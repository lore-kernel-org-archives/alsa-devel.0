From: Mike Frysinger <vapier@gentoo.org>
Subject: [patch/rfc] add support for hosts that have custom
	symbol prefixes
Date: Thu, 7 Sep 2006 20:47:00 -0400
Message-ID: <200609072047.01314.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_F2LAFDQVgbKBgXy"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_F2LAFDQVgbKBgXy
Content-Type: multipart/signed; boundary="nextPart7444303.L0K4lYYAvp";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart7444303.L0K4lYYAvp
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

some architectures, like Blackfin, have a prefix added to all symbols (in o=
ur=20
case it's historical baggage)

while normally packages shouldnt care, when code starts mixing assembler wi=
th=20
C (like symbol versioning), you need to dip down into the inner details. =20
find attached a patch which queries gcc for the prefix (all gcc toolchains=
=20
have a builtin define of __USER_LABEL_PREFIX__) and then automatically has=
=20
asm() constructs utilize this

since most targets define __USER_LABEL_PREFIX__ to nothing, hopefully this=
=20
shouldnt cause any problems :)
=2Dmike

--nextPart7444303.L0K4lYYAvp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQIVAwUARQC9hUFjO5/oN/WBAQK/HQ//bFvvu9jHkeLKdTJGo51jMlGmN9p3xU5M
JtANDkZ/WdOc4fcxRvAmQQ8x4qaC7t2BOa5FvA2WgLtZmGl1QiK7It22/4JSJ1Ug
lfmgxODK5ziXdfduNcH6AIk2lJLn+pl2m8K/cvToCD6QZbx/MFCN2zmjxCRxzai+
MjO22ztSlEkSdtfAIhAEqPR4q88fli9Dm8Oc89GxojFSDK+F9I6mYD+KCxsIAJuP
iuHnnlxEuSh37wCHUjQV+wTJGi8/afipNSS4Iro9KKLvWd3ShvGE//otF0A7poEd
EHgFCIWNU09Y96ZJpWyPWMzs8CYay2Oi+GCUiDsL4/xUyGuN+pHPonXSnW+Iigzn
SWdkGdPEJyeFuXbNou39mlgetCfl0eRZSw11BY7OULCtpffDfiSVrTc647NADjwG
rUxnxKd12MTNOGcNnJ0E5T6q9JAZg9Fr262aKHAprIFiJIbJ8IfpA87SVO4HUg46
OAe4eQaDqBewFN0RvJGiF3kikb4c8O8MdSGXJD31gTV39pKm/Spttb8SXkiA1px5
NQX8xZFJF2DS+xhGhp3oYp1cz4C+ebfIa6ioYU5zfBvgfcngu11C0mE/9tY2jVsh
zOgfcR9mZ9Z3EZsQ/lFhw4CXSByBmJE2jEBYW+K4YSCrfVwlskd9PYCvzOEXxpmW
9h/uki4FhKk=
=fwQU
-----END PGP SIGNATURE-----

--nextPart7444303.L0K4lYYAvp--

--Boundary-00=_F2LAFDQVgbKBgXy
Content-Type: text/x-diff;
  charset="us-ascii";
  name="bfin-alsa-lib.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="bfin-alsa-lib.patch"

diff -r 46221e609f45 configure.in
--- a/configure.in	Wed Sep 06 14:39:01 2006 +0200
+++ b/configure.in	Thu Sep 07 20:45:24 2006 -0400
@@ -34,6 +34,7 @@ fi
 	    
 
 AC_PROG_CC
+AC_PROG_CPP
 AC_PROG_INSTALL
 AC_PROG_LN_S 
 AC_DISABLE_STATIC
@@ -104,6 +105,16 @@ else
   AC_MSG_RESULT(no)
 fi
 AM_CONDITIONAL(VERSIONED_SYMBOLS, test x$versioned = xyes)
+
+dnl See if toolchain has a custom prefix for symbols ...
+AC_MSG_CHECKING(for custom symbol prefixes)
+SYMBOL_PREFIX=` \
+	echo "PREFIX=__USER_LABEL_PREFIX__" \
+		| ${CPP-${CC-gcc} -E} - 2>&1 \
+		| ${EGREP-grep} "^PREFIX=" \
+		| ${SED-sed} "s:^PREFIX=::"`
+AC_DEFINE_UNQUOTED([__SYMBOL_PREFIX], "$SYMBOL_PREFIX", [Toolchain Symbol Prefix])
+AC_MSG_RESULT($SYMBOL_PREFIX)
 
 dnl Check for debug...
 AC_MSG_CHECKING(for debug)
diff -r 46221e609f45 include/alsa-symbols.h
--- a/include/alsa-symbols.h	Wed Sep 06 14:39:01 2006 +0200
+++ b/include/alsa-symbols.h	Thu Sep 07 20:45:45 2006 -0400
@@ -22,6 +22,14 @@
 #ifndef __ALSA_SYMBOLS_H
 #define __ALSA_SYMBOLS_H
 
+#ifdef __USER_LABEL_PREFIX__
+# define __SYMBOL_PREFIX __USER_LABEL_PREFIX__
+#else
+# define __SYMBOL_PREFIX
+#endif
+
+#include "local.h"
+
 #if defined(PIC) && defined(VERSIONED_SYMBOLS) /* might be also configurable */
 #define USE_VERSIONED_SYMBOLS
 #endif
@@ -31,16 +39,16 @@
 
 #ifdef __powerpc64__
 # define symbol_version(real, name, version) 			\
-	__asm__ (".symver " #real "," #name "@" #version);	\
-	__asm__ (".symver ." #real ",." #name "@" #version)
+	__asm__ (".symver " ASM_NAME(#real) "," ASM_NAME(#name) "@" #version);	\
+	__asm__ (".symver ." ASM_NAME(#real) ",." ASM_NAME(#name) "@" #version)
 # define default_symbol_version(real, name, version) 		\
-	__asm__ (".symver " #real "," #name "@@" #version);	\
-	__asm__ (".symver ." #real ",." #name "@@" #version)
+	__asm__ (".symver " ASM_NAME(#real) "," ASM_NAME(#name) "@@" #version);	\
+	__asm__ (".symver ." ASM_NAME(#real) ",." ASM_NAME(#name) "@@" #version)
 #else
 # define symbol_version(real, name, version) \
-	__asm__ (".symver " #real "," #name "@" #version)
+	__asm__ (".symver " ASM_NAME(#real) "," ASM_NAME(#name) "@" #version)
 # define default_symbol_version(real, name, version) \
-	__asm__ (".symver " #real "," #name "@@" #version)
+	__asm__ (".symver " ASM_NAME(#real) "," ASM_NAME(#name) "@@" #version)
 #endif
 
 #ifdef USE_VERSIONED_SYMBOLS
@@ -52,19 +60,19 @@
 #define use_symbol_version(real, name, version) /* nothing */
 #ifdef __powerpc64__
 #define use_default_symbol_version(real, name, version) \
-	__asm__ (".weak " #name); 			\
-	__asm__ (".weak ." #name); 			\
-	__asm__ (".set " #name "," #real);		\
-	__asm__ (".set ." #name ",." #real)
+	__asm__ (".weak " ASM_NAME(#name)); 			\
+	__asm__ (".weak ." ASM_NAME(#name)); 			\
+	__asm__ (".set " ASM_NAME(#name) "," ASM_NAME(#real));		\
+	__asm__ (".set ." ASM_NAME(#name) ",." ASM_NAME(#real))
 #else
 #if defined(__alpha__) || defined(__mips__)
 #define use_default_symbol_version(real, name, version) \
-        __asm__ (".weak " #name); \
-        __asm__ (#name " = " #real)
+        __asm__ (".weak " ASM_NAME(#name)); \
+        __asm__ (ASM_NAME(#name) " = " ASM_NAME(#real))
 #else
 #define use_default_symbol_version(real, name, version) \
-	__asm__ (".weak " #name); \
-	__asm__ (".set " #name "," #real)
+	__asm__ (".weak " ASM_NAME(#name)); \
+	__asm__ (".set " ASM_NAME(#name) "," ASM_NAME(#real))
 #endif
 #endif
 #endif
diff -r 46221e609f45 include/local.h
--- a/include/local.h	Wed Sep 06 14:39:01 2006 +0200
+++ b/include/local.h	Thu Sep 07 20:45:45 2006 -0400
@@ -192,6 +192,9 @@ extern snd_lib_error_handler_t snd_err_m
 
 /* When a reference to SYMBOL is encountered, the linker will emit a
    warning message MSG.  */
+
+#define ASM_NAME(name) __SYMBOL_PREFIX name
+
 #ifdef HAVE_GNU_LD
 # ifdef HAVE_ELF
 
@@ -210,19 +213,19 @@ extern snd_lib_error_handler_t snd_err_m
    section attributes on what looks like a comment to the assembler.  */
 #  ifdef HAVE_SECTION_QUOTES
 #   define link_warning(symbol, msg) \
-  __make_section_unallocated (".gnu.warning." #symbol) \
+  __make_section_unallocated (".gnu.warning." ASM_NAME(#symbol)) \
   static const char __evoke_link_warning_##symbol[]	\
-    __attribute__ ((section (".gnu.warning." #symbol "\"\n\t#\""))) = msg;
+    __attribute__ ((section (".gnu.warning." ASM_NAME(#symbol) "\"\n\t#\""))) = msg;
 #  else
 #   define link_warning(symbol, msg) \
-  __make_section_unallocated (".gnu.warning." #symbol) \
+  __make_section_unallocated (".gnu.warning." ASM_NAME(#symbol)) \
   static const char __evoke_link_warning_##symbol[]	\
-    __attribute__ ((section (".gnu.warning." #symbol "\n\t#"))) = msg;
+    __attribute__ ((section (".gnu.warning." ASM_NAME(#symbol) "\n\t#"))) = msg;
 #  endif
 # else
 #  define link_warning(symbol, msg)		\
   asm (".stabs \"" msg "\",30,0,0,0\n\t"	\
-       ".stabs \"" __SYMBOL_PREFIX #symbol "\",1,0,0,0\n");
+       ".stabs \"" ASM_NAME(#symbol) "\",1,0,0,0\n");
 # endif
 #else
 /* We will never be heard; they will all die horribly.  */

--Boundary-00=_F2LAFDQVgbKBgXy
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--Boundary-00=_F2LAFDQVgbKBgXy
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--Boundary-00=_F2LAFDQVgbKBgXy--
