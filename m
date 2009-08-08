From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: alsamixer -a basic
Date: Sat, 8 Aug 2009 16:55:48 +0200
Message-ID: <20090808145547.GD3204@aragorn.home.lxtec.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8913707292472497471=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout.hostsharing.net (smtpout.hostsharing.net
	[83.223.95.103]) by alsa0.perex.cz (Postfix) with ESMTP id 0C18A245CE
	for <alsa-devel@alsa-project.org>;
	Sat,  8 Aug 2009 16:55:50 +0200 (CEST)
Received: from h01.hostsharing.net (h01.hostsharing.net [83.223.95.29])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtpout.hostsharing.net (Postfix) with ESMTPS id 3975450664
	for <alsa-devel@alsa-project.org>; Sat,  8 Aug 2009 14:55:50 +0000 (UTC)
Received: from mail.home.lxtec.de (p5B144CCC.dip.t-dialin.net [91.20.76.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by h01.hostsharing.net (Postfix) with ESMTP id 13EB11035FA7C
	for <alsa-devel@alsa-project.org>;
	Sat,  8 Aug 2009 16:55:50 +0200 (CEST)
Received: from localhost ([127.0.0.1])
	by mail.home.lxtec.de with esmtp (Exim 4.69 1 (LXTEC))
	id 1MZnKn-0005Wc-1K
	for <alsa-devel@alsa-project.org>; Sat, 08 Aug 2009 16:55:49 +0200
Received: from mail.home.lxtec.de ([127.0.0.1])
	by localhost (baumbart.home.lxtec.de [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id b-M1OHd7EyaW for <alsa-devel@alsa-project.org>;
	Sat,  8 Aug 2009 16:55:48 +0200 (CEST)
Received: from aragorn.home.lxtec.de ([192.168.200.203] ident=Debian-exim)
	by mail.home.lxtec.de with esmtps (Exim 4.69 1 (LXTEC))
	id 1MZnKm-0005WV-Gx
	for <alsa-devel@alsa-project.org>; Sat, 08 Aug 2009 16:55:48 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============8913707292472497471==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


alsa-lib 1.0.20

running alsamixer -a basic gives:
ALSA lib python.c:991:(alsa_mixer_simple_finit) Unable to find python modul=
e '/usr/lib/alsa-lib/smixer/python/main.py'

How do I build smixer/python/main.py ?

Elimar



--=20
  On the keyboard of life you have always
  to keep a finger at the escape key;-)

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkp9kfMACgkQ3Ig8bsVPf7AksQCgv8baDfoEejvUsTuhCiWkMLMH
R1YAoJFSbIHHm0+rXmnqbcyB6Cn5o+Bn
=9VJO
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--

--===============8913707292472497471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8913707292472497471==--
