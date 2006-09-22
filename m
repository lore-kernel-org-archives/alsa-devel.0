From: Mike Frysinger <vapier@gentoo.org>
Subject: [patch] allow building out of tree (sort of)
Date: Fri, 22 Sep 2006 17:24:35 -0400
Message-ID: <200609221724.35846.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TSFFFY5ErvwG6/2"
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

--Boundary-00=_TSFFFY5ErvwG6/2
Content-Type: multipart/signed; boundary="nextPart3406657.XLaeMEHXSi";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3406657.XLaeMEHXSi
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

the current configure script assumes that it will be run in the srcdir ... =
i=20
often build things out of tree so you can quickly punt all the generated=20
files:
mkdir build
cd build
=2E./configure
cd ..
rm -r build
clean!

this tweaks the configure script in a few places to use the correct variabl=
e=20
instead of assuming that configure is always in $PWD ...

i say "sort of" in the subject because there is still the issues of the pcm=
=20
symbols list being generated in $builddir instead of $srcdir and the alsa=20
include symlink, but these doesnt really concern me for what i need ;)
=2Dmike

--nextPart3406657.XLaeMEHXSi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQIVAwUARRRUk0FjO5/oN/WBAQIrEg/9FpyKb+8Sn65ELJDqtV1GUmCwxWkp09o2
5Acans0Sy2BKe7K7QjAOiE0cw1a/wEl/YlOyMZVIj+SXyk3cG/IgS1w6/YQkOtta
+QUhKxopMVhkfwRAdPQKHQHKKuyKVy5za1FCOke+3qS7dBykTBOinMzmh2itLHaU
hMgDj//8n0aIVInTaeMaRxXsMiyzER2xkHUBrQRyx834Fr6IF+5YQTU+j7as50Wa
OS/xDUp5JXofRLYpL2+W4aF/dlxE8QwYjtWhhF72Q49RkOY1J7xT7i3citBpxC7M
dj8EmKm2NKaAl26HEKPp2BIWYXWwx9rIFee7XJmRmveu4XvZIkmYn0yxad8OyFvK
KNXpS+QAktrkv+wstUn6O9aLG4ON4j8g6fByj/2dEoOfIIfhSfpytv9hLdFK4TcG
sk2NJaJfGWwbv1i67a66/oRSmC5DdBoNBFFVi/HkHnhE8ZXrKesP/1pyTvn5s9C0
DIekf6uOvM3ib4lvaytg2jRRfqtbgz752DdCyVNCAgIbITdA48syyxBT11cUmSN9
O+rY7cg8PTZJZF1LUIhqfOUB5fN//hUqOOqiiBoPh/o/djSuhigyTPQmywxI3SpT
pQUOpIzk+9xulYzC5y5eOJeghWusgydVhO+E7jQY8+yfWM2muehE8nM4XJbKM3RK
MpfiyX64dz4=
=dyLB
-----END PGP SIGNATURE-----

--nextPart3406657.XLaeMEHXSi--

--Boundary-00=_TSFFFY5ErvwG6/2
Content-Type: text/x-diff; charset="us-ascii";
	name="alsa-lib-build-out-of-tree.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="alsa-lib-build-out-of-tree.patch"

Signed-off-by: Mike Frysinger <vapier@gentoo.org>

 configure.in |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff -r 8bdd68608788 configure.in
--- a/configure.in	Mon Sep 18 17:57:58 2006 +0200
+++ b/configure.in	Fri Sep 22 17:07:13 2006 -0400
@@ -83,7 +84,7 @@ AC_ARG_WITH(versioned,
   versioned="$withval", versioned="yes")
 if test "$versioned" = "yes"; then
   # it seems that GNU ld versions since 2.10 are not broken
-  xres=`grep '^VERSION=' $ac_aux_dir/libtool | cut -d = -f 2`
+  xres=`grep '^VERSION=' libtool | cut -d = -f 2`
   major=`echo $xres | cut -d . -f 1`
   minor=`echo $xres | cut -d . -f 2`
   pass=0
@@ -357,18 +368,18 @@ fi
 
 
 dnl Create PCM plugin symbol list for static library
-rm -f src/pcm/pcm_symbols_list.c
+rm -f "$srcdir"/src/pcm/pcm_symbols_list.c
 for t in $PCM_PLUGIN_LIST; do
   if eval test \$build_pcm_$t = yes; then
-    echo \&_snd_module_pcm_$t, >> src/pcm/pcm_symbols_list.c
+    echo \&_snd_module_pcm_$t, >> "$srcdir"/src/pcm/pcm_symbols_list.c
   fi
 done
 
 dnl Make a symlink for inclusion of alsa/xxx.h
-if test ! -L include/alsa ; then
+if test ! -L "$srcdir"/include/alsa ; then
   echo "Making a symlink include/alsa"
-  rm -f include/alsa
-  ln -sf . include/alsa
+  rm -f "$srcdir"/include/alsa
+  ln -sf . "$srcdir"/include/alsa
 fi
 
 AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile include/Makefile

--Boundary-00=_TSFFFY5ErvwG6/2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_TSFFFY5ErvwG6/2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--Boundary-00=_TSFFFY5ErvwG6/2--
