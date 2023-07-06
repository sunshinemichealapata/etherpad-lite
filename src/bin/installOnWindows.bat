@echo off

:: Change directory to etherpad-lite root
cd /D "%~dp0\..\.."

:: Is node installed?
cmd /C node -e "" || ( echo "Please install node.js ( https://nodejs.org )" && exit /B 1 )

echo _
echo Ensure that all dependencies are up to date...  If this is the first time you have run Etherpad please be patient.

echo Deleting old node_modules and src/node_modules
del /s /q .\node_modules
del /s /q .\src\node_modules


cd /D src
cmd /C npm link || exit /B 1

cmd /C npm link ep_etherpad-lite --omit=optional --omit=dev --save --package-lock=true || exit /B 1

echo _
echo Clearing cache...
del /S var\minified*

echo _
echo Setting up settings.json...

cd  ..
IF NOT EXIST settings.json (
  echo Can't find settings.json.
  echo Copying settings.json.template...
  cmd /C copy settings.json.template settings.json || exit /B 1
)

echo _
echo Installed Etherpad!  To run Etherpad type start.bat
