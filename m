From: Bas Wijnen <wijnen@debian.org>
Subject: Fwd: aseqview patch for building with new autoconf
Date: Tue, 25 Jan 2011 19:06:31 +0100
Message-ID: <4D3F1127.1010207@debian.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7557323325798693831=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-vbr7.xs4all.nl (smtp-vbr7.xs4all.nl [194.109.24.27])
	by alsa0.perex.cz (Postfix) with ESMTP id 6373B103979
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 19:06:49 +0100 (CET)
Received: from a83-163-111-92.adsl.xs4all.nl (a83-163-111-92.adsl.xs4all.nl
	[83.163.111.92])
	by smtp-vbr7.xs4all.nl (8.13.8/8.13.8) with ESMTP id p0PI6c8Y027589
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 19:06:49 +0100 (CET)
	(envelope-from wijnen@debian.org)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--===============7557323325798693831==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_spark-19438-1295978797-0001-2"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_spark-19438-1295978797-0001-2
Content-Type: multipart/mixed;
 boundary="------------070508010408010501090101"

This is a multi-part message in MIME format.
--------------070508010408010501090101
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

When trying to build aseqview from source (autoreconf -fis; ./configure;
make), I found that it produced errors in configure. The web told me
that those were caused by underquoted constructs in configure.in, which
newer autoconf version have stricter requirements for than older
versions. I've attached a patch which makes it build.

Thanks,
Bas Wijnen


--------------070508010408010501090101
Content-Type: text/x-patch;
 name="aseqview-autoconf.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="aseqview-autoconf.patch"

--- aseqview-0.2.8/configure.in	2007-05-09 13:02:00.000000000 +0200
+++ aseqview-0.2.8.new/configure.in	2011-01-02 00:29:21.000000000 +0100
@@ -11,13 +11,13 @@ AC_HEADER_STDC
 AC_C_INLINE
=20
 AH_TEMPLATE([HAVE_LIBCAP], [Hey, we have libcap])
-AC_CHECK_HEADER(sys/capability.h,
-		AC_CHECK_LIB(cap, cap_get_proc,
+AC_CHECK_HEADER([sys/capability.h],
+		[AC_CHECK_LIB([cap], [cap_get_proc],
 			     [AC_DEFINE(HAVE_LIBCAP)
-			      LIBS=3D"$LIBS -lcap"]))
+			      LIBS=3D"$LIBS -lcap"])])
=20
 AM_PATH_ALSA(0.5.0)
-AC_CHECK_HEADERS(alsa/asoundlib.h)
+AC_CHECK_HEADERS([alsa/asoundlib.h])
=20
 AC_ARG_ENABLE(gtk2,
     [  --enable-gtk2     Use gtk+-2.x instead of gtk+-1.x],


--------------070508010408010501090101--

--=_spark-19438-1295978797-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk0/ESoACgkQFShl+2J8z5XDgQCgq/9jcUNuSUSsFUHvlep1JwBd
s/cAoLOLM9sFdE8wFYYYI8akF1Xv2ro/
=fp3e
-----END PGP SIGNATURE-----

--=_spark-19438-1295978797-0001-2--

--===============7557323325798693831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7557323325798693831==--
