From: flameeyes@gmail.com (Diego E. 'Flameeyes' =?utf-8?Q?Petten=C3=B2?=)
Subject: Fixes and misc improvements for alsa-lib, alsa-plugins,
	alsa-utils
Date: Fri, 21 Nov 2008 03:50:32 +0100
Message-ID: <m2ej15okqv.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9182549441387627456=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 270E424402
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 03:50:50 +0100 (CET)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L3M6Y-0005SL-Gt
	for alsa-devel@alsa-project.org; Fri, 21 Nov 2008 02:50:46 +0000
Received: from ppp-13-236.21-151.libero.it ([151.21.236.13])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 02:50:46 +0000
Received: from flameeyes by ppp-13-236.21-151.libero.it with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 02:50:46 +0000
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
List-Id: alsa-devel@alsa-project.org

--===============9182549441387627456==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


I've taken some time to fix some autotools nitpicks and some generic
optimisations, I hope they can be useful:

git://git.flameeyes.eu/others/alsa/alsa-lib.git flameeyes

Diego E. 'Flameeyes' Petten=C3=B2 (5):
      Don't use AC_CANONICAL_SYSTEM, only use AC_CANONICAL_HOST.
      Add the attributes.m4 macro file from xine/lscube.
      Check for --no-undefined linker flag and use it.
      Make sure that python libraries are passed through LIBADD.
      Make some static tables and strings constants.

git://git.flameeyes.eu/others/alsa/alsa-plugins.git flameeyes

Diego E. 'Flameeyes' Petten=C3=B2 (6):
      Add the attributes.m4 macro file from xine/lscube.
      Check for --no-undefined linker flag and use it.
      Cleanup flags in maemo/Makefile.am
      [RFC] Don't use pow() for calculating a power of 2, use shift instead.
      Make some static tables and strings constants.
      Mark as static the functions not used outside their unit.

git://git.flameeyes.eu/others/alsa/alsa-utils.git flameeyes

Diego E. 'Flameeyes' Petten=C3=B2 (4):
      Remove some dead code (comparisons between 0 and unsigned integers).
      Remove some unused variables.
      Mark static the functions not used outside their unit.
      Make some static tables and strings constants.


=2D-=20
Diego "Flameeyes" Petten=C3=B2
http://blog.flameeyes.eu/


--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkkmIfgACgkQe2h1+2mHVWOYzgCgvJSt6nTstMk11ZnQItVeM2Rz
oykAn3HR64/bl9thpMDK/+WAVw20ANAp
=8xfX
-----END PGP SIGNATURE-----
--=-=-=--


--===============9182549441387627456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============9182549441387627456==--
