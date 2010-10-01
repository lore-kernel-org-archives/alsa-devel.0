From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: namehint: Evaluate more possibilities for hw
	devices
Date: Fri, 01 Oct 2010 18:05:06 +0400
Message-ID: <4CA5EA92.1050102@aknet.ru>
References: <4CA4B6BF.3080503@aknet.ru>
	<alpine.LNX.2.00.1010011332210.20467@eeebox2.perex-int.cz>
	<4CA5CB0D.9030003@aknet.ru>
	<alpine.LNX.2.00.1010011408410.20467@eeebox2.perex-int.cz>
	<4CA5D359.9040400@aknet.ru>
	<alpine.LNX.2.00.1010011512520.20467@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020201090305030100060504"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.28])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D40E103A1A
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 16:05:07 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1010011512520.20467@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020201090305030100060504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

  01.10.2010 17:14, Jaroslav Kysela wrote:
> Try upgrade alsa-utils (aplay). Appearenly, the bug is there (at least 
> on my system the latest aplay lists devices correctly, but aplay 
> 1.0.18 is buggy).
Many thanks, now it works!
One thing to note is that previously
also VirMIDI device was listed, and not
any more. But I guess this is intentional,
as it is not a PCM device.
I needed the attached patch to compile
alsa-utils. I am cross-compiling, and without
this change, the configure would pick up
the host's ncurses-config.

Thanks for your help.

--------------020201090305030100060504
Content-Type: text/plain;
 name="a.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="a.diff"

diff --git a/configure.in b/configure.in
index 8bae007..2f47ef6 100644
--- a/configure.in
+++ b/configure.in
@@ -108,7 +108,8 @@ if test x$alsamixer = xtrue; then
   CURSESLIBDIR=""
   NCURSESLIBSUFFIX=""
   CURSES_NLS="no"
-  if test "$curseslib" = "ncursesw" -o \( "$curseslib" = "auto" -a "$USE_NLS" = "yes" \); then
+  if test "$cross_compiling" != "yes"; then
+   if test "$curseslib" = "ncursesw" -o \( "$curseslib" = "auto" -a "$USE_NLS" = "yes" \); then
     AC_CHECK_PROG([ncursesw5_config], [ncursesw5-config], [yes])
     if test "$ncursesw5_config" = "yes"; then
       CURSESINC="<ncurses.h>"
@@ -124,8 +125,8 @@ if test x$alsamixer = xtrue; then
       NCURSESLIBSUFFIX="w"
       CURSES_NLS="yes"
     fi
-  fi
-  if test "$curseslib" = "ncurses" -o "$curseslib" = "auto"; then
+   fi
+   if test "$curseslib" = "ncurses" -o "$curseslib" = "auto"; then
     AC_CHECK_PROG([ncurses5_config], [ncurses5-config], [yes])
     if test "$ncurses5_config" = "yes"; then
       CURSESINC="<ncurses.h>"
@@ -137,6 +138,7 @@ if test x$alsamixer = xtrue; then
       AC_CHECK_LIB(ncurses, initscr, 
                  [ CURSESINC='<ncurses.h>'; CURSESLIB='-lncurses'; curseslib="ncurses"])
     fi
+   fi
   fi
   if test "$curseslib" = "curses" -o "$curseslib" = "auto"; then
     AC_CHECK_LIB(curses, initscr, 

--------------020201090305030100060504
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------020201090305030100060504--
