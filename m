From: flameeyes@gmail.com (Diego E. 'Flameeyes' =?utf-8?Q?Petten=C3=B2?=)
Subject: GIT branch for ICE1712-related fixes
Date: Tue, 20 Jan 2009 02:53:55 +0100
Message-ID: <m2skneagjw.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8613959899868487786=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B38924156
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 02:52:59 +0100 (CET)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LP5nU-0004oe-Sp
	for alsa-devel@alsa-project.org; Tue, 20 Jan 2009 01:52:56 +0000
Received: from ppp-196-234.21-151.libero.it ([151.21.234.196])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 01:52:56 +0000
Received: from flameeyes by ppp-196-234.21-151.libero.it with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 01:52:56 +0000
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

--===============8613959899868487786==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


At git://git.flameeyes.eu/others/alsa/alsa-lib.git (branch ice1712) you
can find some fixes for ICE1712-based cards:

Diego E. 'Flameeyes' Petten=C3=B2 (2):
      Remove definition for surround sound devices on ICE1712.
      Make the front:idx device work for ICE1712.

With this aplay -L only shows devices that actually do work, rather than
a series of devices where just iec958 works.

HTH,
=2D-=20
Diego "Flameeyes" Petten=C3=B2
http://blog.flameeyes.eu/


--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkl1LrcACgkQe2h1+2mHVWMWFACdEVALsWERl24AILDq49RJT5cH
NSYAnAt7l070cYLl2otU7fZF9X7Lel05
=tZmX
-----END PGP SIGNATURE-----
--=-=-=--


--===============8613959899868487786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8613959899868487786==--
