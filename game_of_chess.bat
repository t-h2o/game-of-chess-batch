@echo off

:: définit les couleurs et pion en situation initial
:: Ces variable ont été mis en place grace à de petit batch
REM CASE
:startSetting
set empty= 
set case[A,1]=T
set case[A,2]=P
set case[A,3]=%empty%
set case[A,4]=%empty%
set case[A,5]=%empty%
set case[A,6]=%empty%
set case[A,7]=P
set case[A,8]=T

set case[B,1]=C
set case[B,2]=P
set case[B,3]=%empty%
set case[B,4]=%empty%
set case[B,5]=%empty%
set case[B,6]=%empty%
set case[B,7]=P
set case[B,8]=C

set case[C,1]=B
set case[C,2]=P
set case[C,3]=%empty%
set case[C,4]=%empty%
set case[C,5]=%empty%
set case[C,6]=%empty%
set case[C,7]=P
set case[C,8]=B

set case[D,1]=K
set case[D,2]=P
set case[D,3]=%empty%
set case[D,4]=%empty%
set case[D,5]=%empty%
set case[D,6]=%empty%
set case[D,7]=P
set case[D,8]=K

set case[E,1]=Q
set case[E,2]=P
set case[E,3]=%empty%
set case[E,4]=%empty%
set case[E,5]=%empty%
set case[E,6]=%empty%
set case[E,7]=P
set case[E,8]=Q

set case[F,1]=B
set case[F,2]=P
set case[F,3]=%empty%
set case[F,4]=%empty%
set case[F,5]=%empty%
set case[F,6]=%empty%
set case[F,7]=P
set case[F,8]=B

set case[G,1]=C
set case[G,2]=P
set case[G,3]=%empty%
set case[G,4]=%empty%
set case[G,5]=%empty%
set case[G,6]=%empty%
set case[G,7]=P
set case[G,8]=C

set case[H,1]=T
set case[H,2]=P
set case[H,3]=%empty%
set case[H,4]=%empty%
set case[H,5]=%empty%
set case[H,6]=%empty%
set case[H,7]=P
set case[H,8]=T

REM COLOR

set player[A,1]=9
set player[A,2]=9
set player[A,3]=F
set player[A,4]=F
set player[A,5]=F
set player[A,6]=F
set player[A,7]=4
set player[A,8]=4

set player[B,1]=9
set player[B,2]=9
set player[B,3]=F
set player[B,4]=F
set player[B,5]=F
set player[B,6]=F
set player[B,7]=4
set player[B,8]=4

set player[C,1]=9
set player[C,2]=9
set player[C,3]=F
set player[C,4]=F
set player[C,5]=F
set player[C,6]=F
set player[C,7]=4
set player[C,8]=4

set player[D,1]=9
set player[D,2]=9
set player[D,3]=F
set player[D,4]=F
set player[D,5]=F
set player[D,6]=F
set player[D,7]=4
set player[D,8]=4

set player[E,1]=9
set player[E,2]=9
set player[E,3]=F
set player[E,4]=F
set player[E,5]=F
set player[E,6]=F
set player[E,7]=4
set player[E,8]=4

set player[F,1]=9
set player[F,2]=9
set player[F,3]=F
set player[F,4]=F
set player[F,5]=F
set player[F,6]=F
set player[F,7]=4
set player[F,8]=4

set player[G,1]=9
set player[G,2]=9
set player[G,3]=F
set player[G,4]=F
set player[G,5]=F
set player[G,6]=F
set player[G,7]=4
set player[G,8]=4

set player[H,1]=9
set player[H,2]=9
set player[H,3]=F
set player[H,4]=F
set player[H,5]=F
set player[H,6]=F
set player[H,7]=4
set player[H,8]=4

set player[I,1]=9
set player[I,2]=9
set player[I,3]=F
set player[I,4]=F
set player[I,5]=F
set player[I,6]=F
set player[I,7]=4
set player[I,8]=4


call :TXTCOLOR
set COLOR=TXTCOLOR.exe
title game of chess
color 20
cls
mode con: cols=70 lines=34
set test=0
set t=	

REM color :
	:: fond :20
	::couleur pion player 1 :9 ou 3
	::couleur pion player 2 :4
:mainLoop
::définit les paramètres par défaut de début de partie
cls

call :difinePos
@echo off
call :movePlayer

goto mainLoop

:movePlayer
REM But: reconnaitre le type de movePlayer

::efface le valeur de movePlayer
set mvePlyer=
::demande le mouvement
set /p mvePlyer=Donner votre deplacement :

set test=%mvePlyer%
set longueur=0

:caractereMoins1
IF "%test%"=="" (goto typeDeNotation)
SET test=%test:~0,-1%
SET /A longueur=longueur+1
GOTO caractereMoins1

:typeDeNotation

if %longueur% equ 2 (
	call :movePion %mvePlyer%
	exit /b
) else if %longueur% equ 3 (
	echo type notation 3
	if %mvePlyer:~-3,1% equ B (
	 call :moveFou %mvePlyer%
	)
	
	if %mvePlyer:~-3,1% equ C (
	 call :moveCavalier %mvePlyer%
	)
	
	if %mvePlyer:~-3,1% equ Q (
	 call :moveDame %mvePlyer%
	)
	
	if %mvePlyer:~-3,1% equ K (
	 call :moveRoi %mvePlyer%
	)
	
	if %mvePlyer:~-3,1% equ T (
	 call :moveTour %mvePlyer%
	)
	
	
) else if "%mvePlyer%" equ "exit" (
	call :end

) else if "%mvePlyer%" equ "help" (
	call :help

) else if "%mvePlyer%" equ "reload" (
	call :startSetting

) else if %longueur% equ 4 (
	echo type notation 4
	
) else (
	echo MISTAKE
	pause>nul
	goto movePlayer
)
pause
exit /b

:movePion
@echo on
set mvePion=%~1
set ligneArrive=%mvePion:~-1,1%
set colonneArrive=%mvePion:~-2,1%

::Reset Var
set caseMn1=
set caseMn2=
set colorMn1=
set colorMn2=
set caseArrive=
set colorArrive=
set errorMSG=

::verifie que le case d'arrivé est vide
call set caseArrive=%%case[%colonneArrive%,%ligneArrive%]%%
call set colorArrive=%%player[%colonneArrive%,%ligneArrive%]%%

if %caseArrive%. equ . (
	set caseArrive=EMPTY
)

::vérifie que le pion soie dans la colonne à 1 case avant de la case d'arriver
set /a test=ligneArrive-1
echo test -1 %test%
call set caseMn1=%%case[%colonneArrive%,%test%]%%
if %caseMn1%. equ . (
	set caseMn1=EMPTY
)
call set colorMn1=%%player[%colonneArrive%,%test%]%%

::vérifie que le pion soie dans la colonne à 2 case avant de la case d'arriver
set /a test=ligneArrive-2
call set caseMn2=%%case[%colonneArrive%,%test%]%%

if %caseMn2%. equ . (
	set caseMn2=EMPTY
)
::si le pion n'est pas en position inititial; peut pas avance de 2
echo if %test% NEQ 2 (
pause
if %caseMn1% equ EMPTY if %test% NEQ 2 (
	set caseMn2=EMPTY
	set errorMSG="peut pas avancer le pion de 2"
	call :errorMessage %errorMSG%
	goto mainLoop
)
call set colorMn2=%%player[%colonneArrive%,%test%]%%

echo ---  DISPLAY INFO
echo colonne : %colonneArrive% 
echo case d'arrive : %caseArrive% et color %colorArrive%
echo case arriere 1 : %caseMn1% et color %colorMn1%
echo case arriere 2 : %caseMn2% et color %colorMn2%
echo ---

echo if %caseArrive% neq EMPTY if %colorArrive%. equ 9. (
pause
if %caseArrive% neq EMPTY if %colorArrive%. equ 9. (
	set errorMSG="Oups, case deja prise par vous"
	call :errorMessage %errorMSG%
)

echo if %colorArrive%. equ 4. (
pause
if %colorArrive%. equ 4. (
	set errorMSG="Oups, case ennemie"
	call :errorMessage %errorMSG%
)
if %caseArrive% equ EMPTY if %caseMn1% equ P if %colorMn1% equ 9 (
	echo good 1
	echo ligne darrive = %ligneArrive%
	set /a test=ligneArrive-1
	echo delete %colonneArrive%%test%
) 
if %caseArrive% equ EMPTY if %caseMn2% equ P if %colorMn2% equ 9 (
	echo good 2	
)	
	
set case[%colonneArrive%,%ligneArrive%]=P
set player[%colonneArrive%,%ligneArrive%]=9

set case[%colonneArrive%,2]=%empty%
set player[%colonneArrive%,2]=F


pause
::vérifie les case de devant

exit /b

:moveFou
	
set mveFou=%~1
::Reset Var
set caseMn1=
set caseMn2=
set colorUP=
set colorMn2=
set caseArrive=
set colorArrive=
set errorMSG=

set ligneArrive=%mveFou:~-1,1%
set colonneArrive=%mveFou:~-2,1%

:: information case d'arrive
call set caseArrive=%%case[%colonneArrive%,%ligneArrive%]%%
call set colorArrive=%%player[%colonneArrive%,%ligneArrive%]%%
if %caseArrive%. equ . (
	set caseArrive=EMPTY
)

::case d'arrive prise par le joueur ?
if %caseArrive% neq EMPTY if %colorArrive%. equ 9. (
	echo if %caseArrive% neq EMPTY if %colorArrive%. equ 9. (
	pause
	set errorMSG="Oups, case deja prise par vous"
	call :errorMessage %errorMSG%
)

::case d'arrive prise par l'adversaire ?
if %caseArrive% neq EMPTY if %colorArrive%. equ 4. (
	set errorMSG="Oups, case deja prise par votre adversaire"
	echo if %caseArrive% neq EMPTY if %colorArrive%. equ 4. (
	pause
	call :errorMessage %errorMSG%
)

:: RECHERCHE en haut à droite
set n=0
:searchPieceFouUPright
set /a n=n+1
call :lettreTOnumber %colonneArrive%
set /a chiffre=chiffre+n
call :numberTOlettre %chiffre%
set /a test=ligneArrive+n

::test zone echequier
call :testHorsEchequier %chiffre% %test%

::Récupère le type de pièce et sa couleure
call :askPieceAndColor %lettre% %test% 

if %caseDehors%. equ true. (
	echo PIECE EN DEHORS ECHEQUIER
) else (
	if %pieceCase% equ B if %couleurCase% equ 9 (
		set case[%lettre%,%test%]=%empty%
	)
	echo pour la case %lettre%%test% 
	echo piece en haut a droite 
	echo de decalage %n% : %pieceCase% de color %couleurCase%
	pause
	cls
	goto searchPieceFouUPright
)

:: essaie de trouver le fous en haut à gauche
call :lettreTOnumber %colonneArrive%
set /a chiffre=chiffre-1
call :numberTOlettre %chiffre%
set /a test=ligneArrive+1
echo pour la case %lettre%%test%
call set pieceCase=%%case[%lettre%,%test%]%%
if %pieceCase%. equ . (
	set pieceCase=EMPTY
)
echo  piece en haut a gauche %pieceCase%

:: essaie de trouver le fous en bas à droite
call :lettreTOnumber %colonneArrive%
set /a chiffre=chiffre+1
call :numberTOlettre %chiffre%
set /a test=ligneArrive-1
echo pour la case %lettre%%test%
call set pieceCase=%%case[%lettre%,%test%]%%
if %pieceCase%. equ . (
	set pieceCase=EMPTY
)
echo  piece en bas a droite %pieceCase%

:: essaie de trouver le fous en bas à gauche
call :lettreTOnumber %colonneArrive%
set /a chiffre=chiffre-1
call :numberTOlettre %chiffre%
set /a test=ligneArrive-1
if %test% equ 0 (
	echo to far (left)
) else if %chiffre% equ 0 (
	echo to far (down)
) else (
	echo pour la case %lettre%%test%
	call set pieceCase=%%case[%lettre%,%test%]%%
	if %pieceCase%. equ . (
		set pieceCase=EMPTY
	)
)
echo  piece en bas a gauche %pieceCase%


:: met un fous à la case de desisination
set case[%colonneArrive%,%ligneArrive%]=B
set player[%colonneArrive%,%ligneArrive%]=9
pause
exit /b
:moveRoi

echo Mouvement du roi
pause 
exit /b

:moveDame

echo Mouvement de la dame
pause 
exit /b

:moveCavalier

echo Mouvement du cavalier
pause 
exit /b

:moveTour

echo Mouvement de la tour
pause 
exit /b


:askPieceAndColor
set val1=%~1
set val2=%~2

call set pieceCase=%%case[%val1%,%val2%]%%
call set couleurCase=%%player[%val1%,%val2%]%%
if %pieceCase%. equ . (
	set pieceCase=EMPTY
)
echo piece fct %pieceCase%

:testHorsEchequier

set caseDehors=
if %~1 lss 1 (
	echo en dehors, trop à gauche
	set caseDehors=true
)
if 8 lss %~1 (
	echo en dehors, trop à droite
	set caseDehors=true
)


if %~2 lss 1 (
	echo en dehors, trop à bas
	set caseDehors=true
)

if 8 lss %~2 (
	echo en dehors, trop à haut
	set caseDehors=true
)


:numberTOlettre

if %~1 equ 1 (set lettre=A)
if %~1 equ 2 (set lettre=B)
if %~1 equ 3 (set lettre=C)
if %~1 equ 4 (set lettre=D)
if %~1 equ 5 (set lettre=E)
if %~1 equ 6 (set lettre=F)
if %~1 equ 7 (set lettre=G)
if %~1 equ 8 (set lettre=H)

exit /b

:lettreTOnumber

if %~1 equ A (set chiffre=1)
if %~1 equ B (set chiffre=2)
if %~1 equ C (set chiffre=3)
if %~1 equ D (set chiffre=4)
if %~1 equ E (set chiffre=5)
if %~1 equ F (set chiffre=6)
if %~1 equ G (set chiffre=7)
if %~1 equ H (set chiffre=8)

exit /b

:end 
pause
::start chess.bat
exit

:errorMessage

cls
echo - - - - - ERROR - - - - - 
echo. 
echo %t%: %~1
echo. 
echo - - - - - ERROR - - - - -
pause
exit /b
goto mainLoop


:difinePos
@echo off
cls
:: Affiche le l'echequier 
:: Tous est relier sous forme de variable
REM
echo.
echo.
%COLOR% 20 0 "  "
%COLOR% 43 0 "                            "
%COLOR% 20 0 " Player 2 "
%COLOR% 43 1 "                            "
echo.
call :line8
call :line7
call :line6
call :line5
call :line4
call :line3
call :line2
call :line1
echo.
echo           A      B      C      D      E      F      G      H
echo.
%COLOR% 20 0 "  "
%COLOR% 43 0 "                            "
%COLOR% 60 0 " Player 1 " 
%COLOR% 43 1 "                            "
echo.
exit /b

:Line8
call :lineNoire
%COLOR% 20 0 "   8   "
%COLOR% 0%player[A,8]% 0 "   %case[A,8]%   "
%COLOR% 8%player[B,8]% 0 "   %case[B,8]%   "
%COLOR% 0%player[C,8]% 0 "   %case[C,8]%   "
%COLOR% 8%player[D,8]% 0 "   %case[D,8]%   "
%COLOR% 0%player[E,8]% 0 "   %case[E,8]%   "
%COLOR% 8%player[F,8]% 0 "   %case[F,8]%   "
%COLOR% 0%player[G,8]% 0 "   %case[G,8]%   "
%COLOR% 8%player[H,8]% 1 "   %case[H,8]%   "
call :lineNoire
exit /b

:line7
call :lineBlanche
%COLOR% 20 0 "   7   "
%COLOR% 8%player[A,7]% 0 "   %case[A,7]%   "
%COLOR% 0%player[B,7]% 0 "   %case[B,7]%   "
%COLOR% 8%player[C,7]% 0 "   %case[C,7]%   "
%COLOR% 0%player[D,7]% 0 "   %case[D,7]%   "
%COLOR% 8%player[E,7]% 0 "   %case[E,7]%   "
%COLOR% 0%player[F,7]% 0 "   %case[F,7]%   "
%COLOR% 8%player[G,7]% 0 "   %case[G,7]%   "
%COLOR% 0%player[H,7]% 1 "   %case[H,7]%   "
call :lineBlanche
exit /b

:line6
call :lineNoire
%COLOR% 20 0 "   6   "
%COLOR% 0%player[A,6]% 0 "   %case[A,6]%   "
%COLOR% 8%player[B,6]% 0 "   %case[B,6]%   "
%COLOR% 0%player[C,6]% 0 "   %case[C,6]%   "
%COLOR% 8%player[D,6]% 0 "   %case[D,6]%   "
%COLOR% 0%player[E,6]% 0 "   %case[E,6]%   "
%COLOR% 8%player[F,6]% 0 "   %case[F,6]%   "
%COLOR% 0%player[G,6]% 0 "   %case[G,6]%   "
%COLOR% 8%player[H,6]% 1 "   %case[H,6]%   "
call :lineNoire
exit /b

:line5
call :lineBlanche
%COLOR% 20 0 "   5   "
%COLOR% 8%player[A,5]% 0 "   %case[A,5]%   "
%COLOR% 0%player[B,5]% 0 "   %case[B,5]%   "
%COLOR% 8%player[C,5]% 0 "   %case[C,5]%   "
%COLOR% 0%player[D,5]% 0 "   %case[D,5]%   "
%COLOR% 8%player[E,5]% 0 "   %case[E,5]%   "
%COLOR% 0%player[F,5]% 0 "   %case[F,5]%   "
%COLOR% 8%player[G,5]% 0 "   %case[G,5]%   "
%COLOR% 0%player[H,5]% 1 "   %case[H,5]%   "
call :lineBlanche
exit /b

:line4
call :lineNoire
set case[G,4]=%empty%
%COLOR% 20 0 "   4   "
%COLOR% 0%player[A,4]% 0 "   %case[A,4]%   "
%COLOR% 8%player[B,4]% 0 "   %case[B,4]%   "
%COLOR% 0%player[C,4]% 0 "   %case[C,4]%   "
%COLOR% 8%player[D,4]% 0 "   %case[D,4]%   "
%COLOR% 0%player[E,4]% 0 "   %case[E,4]%   "
%COLOR% 8%player[F,4]% 0 "   %case[F,4]%   "
%COLOR% 0%player[G,4]% 0 "   %case[G,4]%   "
%COLOR% 8%player[H,4]% 1 "   %case[H,4]%   "
call :lineNoire
exit /b

:line3
call :lineBlanche
%COLOR% 20 0 "   3   "
%COLOR% 8%player[A,3]% 0 "   %case[A,3]%   "
%COLOR% 0%player[B,3]% 0 "   %case[B,3]%   "
%COLOR% 8%player[C,3]% 0 "   %case[C,3]%   "
%COLOR% 0%player[D,3]% 0 "   %case[D,3]%   "
%COLOR% 8%player[E,3]% 0 "   %case[E,3]%   "
%COLOR% 0%player[F,3]% 0 "   %case[F,3]%   "
%COLOR% 8%player[G,3]% 0 "   %case[G,3]%   "
%COLOR% 0%player[H,3]% 1 "   %case[H,3]%   "
call :lineBlanche
exit /b

:line2
call :lineNoire
%COLOR% 20 0 "   2   "
%COLOR% 0%player[A,2]% 0 "   %case[A,2]%   "
%COLOR% 8%player[B,2]% 0 "   %case[B,2]%   "
%COLOR% 0%player[C,2]% 0 "   %case[C,2]%   "
%COLOR% 8%player[D,2]% 0 "   %case[D,2]%   "
%COLOR% 0%player[E,2]% 0 "   %case[E,2]%   "
%COLOR% 8%player[F,2]% 0 "   %case[F,2]%   "
%COLOR% 0%player[G,2]% 0 "   %case[G,2]%   "
%COLOR% 8%player[H,2]% 1 "   %case[H,2]%   "
call :lineNoire
exit /b

:line1
call :lineBlanche
%COLOR% 20 0 "   1   "
%COLOR% 8%player[A,1]% 0 "   %case[A,1]%   "
%COLOR% 0%player[B,1]% 0 "   %case[B,1]%   "
%COLOR% 8%player[C,1]% 0 "   %case[C,1]%   "
%COLOR% 0%player[D,1]% 0 "   %case[D,1]%   "
%COLOR% 8%player[E,1]% 0 "   %case[E,1]%   "
%COLOR% 0%player[F,1]% 0 "   %case[F,1]%   "
%COLOR% 8%player[G,1]% 0 "   %case[G,1]%   "
%COLOR% 0%player[H,1]% 1 "   %case[H,1]%   "
call :lineBlanche
exit /b

::Fait les entres lignes
:lineNoire
%COLOR% 20 0 "       "
%COLOR% 04 0 "       "
%COLOR% 84 0 "       "
%COLOR% 04 0 "       "
%COLOR% 84 0 "       "
%COLOR% 04 0 "       "
%COLOR% 84 0 "       "
%COLOR% 04 0 "       "
%COLOR% 84 1 "       "
exit /b
:lineBlanche
%COLOR% 20 0 "       "
%COLOR% 84 0 "       "
%COLOR% 04 0 "       "
%COLOR% 84 0 "       "
%COLOR% 04 0 "       "
%COLOR% 84 0 "       "
%COLOR% 04 0 "       "
%COLOR% 84 0 "       "
%COLOR% 04 1 "       "
exit /b

:help
cls
echo - - - HELP - - -
echo Pour donne un deplacement de pion sans ambiguite
echo %t%E4
echo Pour donner un dplacement d'une autre piece sans ambiguite
echo %t%CC1
echo Pour donner un mve avec ambigute
echo %t%CAC1 ou C1C1
echo - - - HELP - - -
pause
cls
echo - - - HELP - - -
echo %t%%t%help :
echo %t%affiche cette fenetre d'aide
echo %t%%t%reload :
echo %t%Reset les emplacement par defaut
echo %t%%t%exit
echo %t%Sors du jeu
echo - - - HELP - - -
pause
cls
goto :mainLoop
 
::fin du programme
:: ##############################  TXT_COLOR  By CARLOS  ##############################
:: Merci à CARLOS pour le code source en batch de cette commande externe  ^^
:TXTCOLOR
Echo.Const W=^2>t.vbs&Echo.Set o=WScript.StdOut>>t.vbs
For %%b In (
"4D53434600000000BA030000000000002C000000000000000301010001000000000000"
"004900000001000100D20700000000000000009E3B8A662000747874636F6C6F722E65"
"78650063EB078D6903D207434BDD544B681341189E6D538D35352AE2030F4EC44A458D"
"55113C88D4C75A85AA5B5A2F8AD66D324997A6BB7177A2297868498B9450ECA182871E"
"7AF0E0C183878AA98844DA83828288074FE24549B1A00785452AEB3F8F3C5A7C54BD39"
"F0E77F7FF3CD9FD9397976045523847C209E87500E89D5847EBFFA40566C7AB0024D2C"
"7B1ECA292DCF43ED5D868393B615B7F51E1CD14DD3A2B893603B6562C3C4474FB7E11E"
"2B4AC27575B55B2486A622D4A254CDC37D8B82D5CB9525F3624DABE167250896EC985D"
"25782354D6A851C4A70F237E2E5EB8B25297145F1701EFC022CEFAA76B0C70F7FF221F"
"A6244D8B644036540BDE950B202E86A33AD5C17EA188C04BA6E78F864D23FFB73CCF0C"
"BDEB9F6D006324ABFA33AE2F38180016593590C9FBB2FED6C228789969DF903AC7637E"
"16EB2BC6DCAC3A9771157E6782A3F9C17C7060032A77071F295AE19C289EB9C413505E"
"5559DEB4B07C872867B97D15B9CC6385A7EBCAE9B5909EA945F2CACE0498C586F3A146"
"04D80FA7EDFE8CA25FEE995704C53298E865C7630D5F7983CBCC8F254E93EC8F6B9D64"
"95AD6C28190E12280D6AB2767E3E52CC33D47ED7637CAE8D0BE48C8B8203AB8AB6121C"
"A86124328CCE17CFF3B44258617C3E0FAB6FB4ACFA592B6C55F830FBDFB24F5684362A"
"9259207BD21D525F0F3E9530FC544B71139A616EAE062CE8789D455A0E31BBC04E0BCC"
"82F7D5F702EA45690EEB99E5E75553BCCAC747CCE7F374AA747FD6B0FB9313439BCDB1"
"0F0FB091025D3778979F776985EB0263589DD578B5360CDB0DAB2EC89C56E8E5D9358C"
"02CC010462E7BF791E9FDAA7ACFA492B5C1000B0B5573F86D9E5F1EAC7A5BE25F56DA9"
"A7A57E22F533A9EF487D57EA09A973523FC48B79FBFE9755EFD43B08AE084DD38895B0"
"EC304913DCA947BAE3B69532A30D8D3B8F6D8B5936A970E181374C7A8A5C69314CD2D0"
"B86BF736BC997611CC5EB4CDB50BF05FE1B21D08897771AE22761562D3F8C7DCD6410E"
"836C07D9077210A419A41D8480A442A26E08F44D907BA17FEBEB712E476C1A8E2612E0"
"38D44E10130CC349478DB841B959B4204B2D56C6671103A3236299D4B612B124733A1C"
"423BF464B283F626090FC409EDD10D53B7E30EF8240D30DDC4364962EF1EB96333A16D"
"347A5C37A30922DC2396E95809D216B109310FA76231629F30631624DB4AC97698FA21"
) Do >>t.vbs (
Echo.For b=1To 69Step 2:o.Write Chr(Clng("&H"^&Mid(%%b,b,W^)^)^):Next)
For %%b In ("4A6DA33345591BFA0E"
) Do >>t.vbs (
Echo.For b=1To 17Step 2:o.Write Chr(Clng("&H"^&Mid(%%b,b,W^)^)^):Next)
Cscript /Nologo t.vbs > TXTCOLOR.ex_
Del /f /q /a t.vbs >nul 2>&1
Expand -r TXTCOLOR.ex_ >nul 2>&1
Del /f /q /a TXTCOLOR.ex_ >nul 2>&1
Goto :Eof
:: ################################  End TXT_COLOR  ################################
