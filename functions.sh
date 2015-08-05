if perl -v >/dev/null 2>/dev/null; then
	RESET=`perl -e 'print("\e[0m")'`
	BOLD=`perl -e 'print("\e[1m")'`
	YELLOW=`perl -e 'print("\e[33m")'`
	BLUE_BG=`perl -e 'print("\e[44m")'`
elif python -V >/dev/null 2>/dev/null; then
	RESET=`echo 'import sys; sys.stdout.write("\033[0m")' | python`
	BOLD=`echo 'import sys; sys.stdout.write("\033[1m")' | python`
	YELLOW=`echo 'import sys; sys.stdout.write("\033[33m")' | python`
	BLUE_BG=`echo 'import sys; sys.stdout.write("\033[44m")' | python`
else
	RESET=
	BOLD=
	YELLOW=
	BLUE_BG=
fi

function header()
{
	local title="$1"
	echo
	echo "${BLUE_BG}${YELLOW}${BOLD}${title}${RESET}"
	echo "------------------------------------------"
}

function run()
{
	echo "+ $@"
	"$@"
}

function download_and_extract()
{
	local BASENAME="$1"
	local DIRNAME="$2"
	local URL="$3"
	local regex='\.bz2$'

	run rm -f "$BASENAME"
	run curl --fail -L -o "$BASENAME" "$URL"
	if [[ "$URL" =~ $regex ]]; then
		run tar xjf "$BASENAME"
	else
		run tar xzf "$BASENAME"
	fi
	run rm "$BASENAME"

	echo "Entering $RUNTIME_DIR/$DIRNAME"
	pushd "$DIRNAME" >/dev/null
}
