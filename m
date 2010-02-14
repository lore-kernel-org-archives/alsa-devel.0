From: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Subject: Re: Since kernel-2.6.32,
 alsactl fails to restore defaults
Date: Sun, 14 Feb 2010 20:14:36 +0100
Message-ID: <1266174876.23964.10.camel@localhost.localdomain>
References: <alpine.LNX.2.00.1002142008190.28127@eeebox2.perex-int.cz>
Reply-To: pacho@condmat1.ciencias.uniovi.es
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5402580337261138546=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp01.jazztel.es (smtp01.jazztel.es [62.14.3.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C3112444A
	for <alsa-devel@alsa-project.org>; Sun, 14 Feb 2010 20:14:44 +0100 (CET)
In-Reply-To: <alpine.LNX.2.00.1002142008190.28127@eeebox2.perex-int.cz>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============5402580337261138546==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-NmgeQKAvQkwo611GkDxt"


--=-NmgeQKAvQkwo611GkDxt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El dom, 14-02-2010 a las 20:10 +0100, Jaroslav Kysela escribi=C3=B3:
>=20
> The files look good. The question is why the initialization is called=20
> when a default state already exists (it shouldn't).
>=20
> Does 'alsactl -f test.state restore' show some messages? Use test.state=20
> file you sent me.
>=20
>  					Jaroslav
>=20
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.

Yes, it shows:
# alsactl -f test.state restore
Unknown hardware: "VIA8237" "Realtek ALC658D" "AC97a:414c4781" "0x147b"
"0x1415"
Hardware is initialized using a guess method


--=-NmgeQKAvQkwo611GkDxt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
 digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkt4S5wACgkQCaWpQKGI+9T8LgCbB2mmXTxd7Uud6xsCJ62Cr8b4
5ZgAn0Lh64jeWiZ+h1QnVgOWuMMOaX0k
=gAdX
-----END PGP SIGNATURE-----

--=-NmgeQKAvQkwo611GkDxt--


--===============5402580337261138546==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5402580337261138546==--
