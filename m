From: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Subject: Re: Since kernel-2.6.32,
 alsactl fails to restore defaults
Date: Fri, 19 Feb 2010 12:25:15 +0100
Message-ID: <1266578715.5249.2.camel@localhost.localdomain>
References: <1266174876.23964.10.camel@localhost.localdomain>
Reply-To: pacho@condmat1.ciencias.uniovi.es
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1407196429957707314=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp01.jazztel.es (smtp01.jazztel.es [62.14.3.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 80554244F3
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 12:25:24 +0100 (CET)
In-Reply-To: <1266174876.23964.10.camel@localhost.localdomain>
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


--===============1407196429957707314==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-RTBtRuiOWtUKHZvS8n4j"


--=-RTBtRuiOWtUKHZvS8n4j
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El dom, 14-02-2010 a las 20:14 +0100, Pacho Ramos escribi=C3=B3:
> El dom, 14-02-2010 a las 20:10 +0100, Jaroslav Kysela escribi=C3=B3:
> >=20
> > The files look good. The question is why the initialization is called=20
> > when a default state already exists (it shouldn't).
> >=20
> > Does 'alsactl -f test.state restore' show some messages? Use test.state=
=20
> > file you sent me.
> >=20
> >  					Jaroslav
> >=20
> > -----
> > Jaroslav Kysela <perex@perex.cz>
> > Linux Kernel Sound Maintainer
> > ALSA Project, Red Hat, Inc.
>=20
> Yes, it shows:
> # alsactl -f test.state restore
> Unknown hardware: "VIA8237" "Realtek ALC658D" "AC97a:414c4781" "0x147b"
> "0x1415"
> Hardware is initialized using a guess method
>=20

Any news on this? Do you need any more information? Thanks a lot :-)

--=-RTBtRuiOWtUKHZvS8n4j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
 digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkt+dRsACgkQCaWpQKGI+9RuJQCggK0Hrj+hJ9UkZcUxkDD1EO29
+vgAmwamBV042/lE/uZvoILx8oiUdXrg
=1WGn
-----END PGP SIGNATURE-----

--=-RTBtRuiOWtUKHZvS8n4j--


--===============1407196429957707314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1407196429957707314==--
