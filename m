From: Arnault Teissier <roswel@assonetworx.com>
Subject: Re: [ALSA - driver 0000541]: Tascam US-122 drivers fails with jackd
Date: Sun, 26 Sep 2004 05:52:47 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1096149167.7939.59.camel@localhost>
References: <20040925142242.704A02014F@server.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1db00xX5Q1zjcwYT6DRj"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 552F8275
	for <alsa-devel@alsa-project.org>; Sat, 25 Sep 2004 23:52:58 +0200 (MEST)
In-Reply-To: <20040925142242.704A02014F@server.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: bugtrack@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-1db00xX5Q1zjcwYT6DRj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Le samedi 25 septembre 2004 =C3=A0 16:22 +0200, bugtrack@alsa-project.org a
=C3=A9crit :
> A BUGNOTE has been added to this bug.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0541
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Reported By:                roswel
> Assigned To:                karsten
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Project:                    ALSA - driver
> Bug ID:                     541
> Category:                   USB - usb-usx2y
> Reproducibility:            always
> Severity:                   crash
> Priority:                   normal
> Status:                     assigned
> Distribution:               Debian
> Kernel Version:             Linux 2.6.9-rc2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Date Submitted:             09-25-2004 16:11 CEST
> Last Modified:              09-25-2004 16:22 CEST
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Summary:                    Tascam US-122 drivers fails with jackd
> Description:=20
> When i start jackd everything seems allright, but if i try to play some
> audio through jack, like for example with alsaplayer or ardour, nothing
> happen.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> ----------------------------------------------------------------------
>  karsten - 09-25-2004 16:22 CEST=20
> ----------------------------------------------------------------------
> Does alsaplayer work in alsa mode?

Yes alsaplayer work just perfectly in alsa mode. I've just this problem
with jackd.=20

Thanx

Arnault

> Bug History
> Date Modified  Username       Field                    Change            =
 =20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 09-25-04 16:11 roswel         New Bug                                    =
 =20
> 09-25-04 16:11 roswel         Distribution              =3D> Debian      =
   =20
> 09-25-04 16:11 roswel         Kernel Version            =3D> Linux 2.6.9-=
rc2=20
> 09-25-04 16:12 roswel         Bug Monitored: roswel                      =
 =20
> 09-25-04 16:22 karsten        Bugnote Added: 0001910                     =
 =20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--=20
Arnault Teissier <roswel@assonetworx.com>
Association Networx

--=-1db00xX5Q1zjcwYT6DRj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBVeivoWna/hhq6i8RAtMqAJ0cc9CMmsCJLrknhsNG07KBfMsc4wCeJB/A
BL+Z25CTPTCJ6LWEi+S+tVI=
=cnYo
-----END PGP SIGNATURE-----

--=-1db00xX5Q1zjcwYT6DRj--


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
