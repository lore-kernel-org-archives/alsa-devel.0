From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Eliminating alsa-tools/ac3dec/acconfig.h
Date: Fri, 30 Aug 2002 17:55:03 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0208301749140.20579-100000@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello!

alsa-tools/ac3dec/acconfig.h is slightly out of date, because it doesn't 
have a template "__ia64__".

acconfig.h is considered obsolete since Autoconf version 2.13.  Later 
versions even print a warnings if acconfig.h is found.  The modern 
alternative is to include short descriptions into AC_DEFINE calls.

Since alsa-tools/ac3dec/configure.in already requires Autoconf 2.13 (looks 
for AC_PREREQ), it should be save to eliminate acconfig.h.  AC_C_BIGENDIAN 
provides its own description for WORDS_BIGENDIAN.

===============================
--- alsa-tools/ac3dec/acconfig.h
+++ /dev/null
@@ -1,10 +0,0 @@
-@BOTTOM@
-
-/* Architecture defines */
-#undef __i386__
-#undef __alpha__
-#undef __ppc__
-#undef __sparc__ 
-
-/* Big-Endian */
-#undef WORDS_BIGENDIAN
--- alsa-tools/ac3dec/configure.in
+++ alsa-tools/ac3dec/configure.in
@@ -19,11 +19,11 @@
 
 dnl Set the appropriate architecture define
 case "$host" in
-i?86-*) AC_DEFINE(__i386__);;
-alpha*-*) AC_DEFINE(__alpha__);;
-sparc-*) AC_DEFINE(__sparc__);;
-ppc-*|powerpc-*) AC_DEFINE(__ppc__);;
-ia64-*) AC_DEFINE(__ia64__);;
+i?86-*) AC_DEFINE(__i386__, 1, [Using i386 architecture]);;
+alpha*-*) AC_DEFINE(__alpha__, 1, [Using Alpha architecture]);;
+sparc-*) AC_DEFINE(__sparc__, 1, [Using SPARC architecture]);;
+ppc-*|powerpc-*) AC_DEFINE(__ppc__, 1, [Using PowerPC architecture]);;
+ia64-*) AC_DEFINE(__ia64__, 1, [Using IA-64 architecture]);;
 *) echo "$host is not currently supported by ac3dec"; exit 1;;
 esac
 
===============================

-- 
Regards,
Pavel Roskin



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
