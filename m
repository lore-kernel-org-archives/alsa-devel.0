From: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
Subject: Re: [PATCH] alsa-tools
Date: Mon, 16 May 2005 21:03:27 +0200
Message-ID: <20050516190326.GA21914@skinner.hem.za.org>
References: <20050516143936.GA12324@skinner.hem.za.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20050516143936.GA12324@skinner.hem.za.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, May 16, 2005 at 04:39:36PM +0200, Mikael Magnusson wrote:
> ld10k1_configure.patch
> ld10k1_makefile.patch
> Removes ALSA_CFLAGS and ALSA_LIBS in configure.in, they are added to
> CFLAGS and LDADD in src/Makefile.am already. Adds "-Wall" to CFLAGS only
> if CFLAGS is undefined.
> 
> qlo10k1_configure.patch
> qlo10k1_makefile.patch
> Adds LD10K1_CFLAGS and LD10K1_LDFLAGS in src/Makefile.am, and moves
> QT_CXXFLAGS to the makefile.
> 
> qlo10k1_acinclude.patch
> Fixes pattern in gw_CHECK_QT not to match files that the linker won't
> use, for example libqt.so.3 . Needed if both libqt and libqt-mt shared
> libraries are installed, but only the libqt-mt development library.
> 
> Signed-Off-By: Mikael Magnusson <mikma@users.sourceforge.net>
> 

With the patches this time.

/Mikael Magnusson


ld10k1_configure.patch:
diff -ur orig/alsa-tools-1.0.9rc3/ld10k1/configure.in alsa-tools-1.0.9rc3/ld10k1/configure.in
--- orig/alsa-tools-1.0.9rc3/ld10k1/configure.in        2005-04-11 15:15:52.000000000 +0200
+++ alsa-tools-1.0.9rc3/ld10k1/configure.in     2005-05-14 23:18:10.000000000 +0200
@@ -9,8 +9,7 @@
 AC_DISABLE_STATIC
 AC_PROG_LIBTOOL
 AM_PATH_ALSA(1.0.8, [], [])
-CFLAGS="$CFLAGS $ALSA_CFLAGS -Wall"
-LIBS="$LIBS $ALSA_LIBS"
+CFLAGS="${CFLAGS--Wall}"
 
 effectsdir='$(pkgdatadir)/effects'
 AC_SUBST(effectsdir)

ld10k1_makefile.patch:
diff -ur orig/alsa-tools-1.0.9rc3/ld10k1/src/Makefile.am alsa-tools-1.0.9rc3/ld10k1/src/Makefile.am
--- orig/alsa-tools-1.0.9rc3/ld10k1/src/Makefile.am     2005-03-18 14:41:02.000000000 +0100
+++ alsa-tools-1.0.9rc3/ld10k1/src/Makefile.am  2005-05-15 00:37:00.000000000 +0200
@@ -13,6 +13,8 @@
 lib_LTLIBRARIES = liblo10k1.la
 liblo10k1_la_SOURCES = comm.c liblo10k1.c liblo10k1ef.c liblo10k1lf.c
 #liblo10k1_la_HEADERS = comm.h liblo10k1.h liblo10k1ef.h ld10k1_error.h ld10k1_fnc.h liblo10k1lf.h
+liblo10k1_la_CFLAGS = $(ALSA_CFLAGS)
+liblo10k1_la_LIBADD = $(ALSA_LIBS)
 
 lo10k1_SOURCES = lo10k1.c
 lo10k1_CFLAGS = $(ALSA_CFLAGS) -DEFFECTSDIR='"$(effectsdir)"'

qlo10k1_acinclude.patch:
diff -ur orig/alsa-tools-1.0.9rc3/qlo10k1/acinclude.m4 alsa-tools-1.0.9rc3/qlo10k1/acinclude.m4
--- orig/alsa-tools-1.0.9rc3/qlo10k1/acinclude.m4	2005-03-18 17:42:49.000000000 +0100
+++ alsa-tools-1.0.9rc3/qlo10k1/acinclude.m4	2005-05-14 17:12:04.000000000 +0200
@@ -99,17 +99,17 @@
             fi
         fi
 
-        if test "x`ls $QTDIR/lib/libqt.* 2> /dev/null`" != x ; then
+        if test "x`ls $QTDIR/lib/libqt.{a,so} 2> /dev/null`" != x ; then
             QT_LIB="-lqt"
             QT_IS_MT="no"
-        elif test "x`ls $QTDIR/lib/libqt-mt.* 2> /dev/null`" != x ; then
+        elif test "x`ls $QTDIR/lib/libqt-mt.{a,so} 2> /dev/null`" != x ; then
             QT_LIB="-lqt-mt"
             QT_IS_MT="yes"
-        elif test "x`ls $QTDIR/lib/libqte.* 2> /dev/null`" != x ; then
+        elif test "x`ls $QTDIR/lib/libqte.{a,so} 2> /dev/null`" != x ; then
             QT_LIB="-lqte"
             QT_IS_MT="no"
             QT_IS_EMBEDDED="yes"
-        elif test "x`ls $QTDIR/lib/libqte-mt.* 2> /dev/null`" != x ; then
+        elif test "x`ls $QTDIR/lib/libqte-mt.{a,so} 2> /dev/null`" != x ; then
             QT_LIB="-lqte-mt"
             QT_IS_MT="yes"
             QT_IS_EMBEDDED="yes"

qlo10k1_configure.patch:
diff -ur orig/alsa-tools-1.0.9rc3/qlo10k1/configure.in alsa-tools-1.0.9rc3/qlo10k1/configure.in
--- orig/alsa-tools-1.0.9rc3/qlo10k1/configure.in       2005-03-18 17:42:49.000000000 +0100
+++ alsa-tools-1.0.9rc3/qlo10k1/configure.in    2005-05-14 17:13:38.000000000 +0200
@@ -8,7 +8,7 @@
 
 AC_C_BIGENDIAN
 gw_CHECK_QT
-CXXFLAGS="$CXXFLAGS $QT_CXXFLAGS -Wall"
+CXXFLAGS="${CXXFLAGS--Wall}"
 AM_PATH_LD10K1(0.1.8)
 
 AC_OUTPUT(Makefile

qlo10k1_makefile.patch:
diff -ur orig/alsa-tools-1.0.9rc3/qlo10k1/src/Makefile.am alsa-tools-1.0.9rc3/qlo10k1/src/Makefile.am
--- orig/alsa-tools-1.0.9rc3/qlo10k1/src/Makefile.am    2005-03-18 17:42:49.000000000 +0100
+++ alsa-tools-1.0.9rc3/qlo10k1/src/Makefile.am 2005-05-14 22:04:16.000000000 +0200
@@ -4,6 +4,10 @@
 # of the other Makefile.am variables
 bin_PROGRAMS = qlo10k1
 
+AM_CPPFLAGS = $(LD10K1_CFLAGS)
+AM_CXXFLAGS= $(QT_CXXFLAGS)
+AM_LDFLAGS = $(LD10K1_LDFLAGS)
+
 # the libraries to link against.
 qlo10k1_LDADD = $(LDADD) $(QT_LDADD)
 



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
