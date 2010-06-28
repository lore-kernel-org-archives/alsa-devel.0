From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH RFC 1/3] ASoC: uda1380: use callbacks
	instead of gpiolib
Date: Mon, 28 Jun 2010 15:00:13 +0300
Message-ID: <201006281500.21327.anarsoul@gmail.com>
References: <1277565285-11563-1-git-send-email-anarsoul@gmail.com>
	<201006262353.58897.anarsoul@gmail.com>
	<8308AEB2-F7DB-4C48-AAED-719311AF7A42@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7184199056088839496=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 247E5243FF
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Jun 2010 14:00:35 +0200 (CEST)
Received: by fxm15 with SMTP id 15so1022956fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 28 Jun 2010 05:00:34 -0700 (PDT)
In-Reply-To: <8308AEB2-F7DB-4C48-AAED-719311AF7A42@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

--===============7184199056088839496==
Content-Type: multipart/signed;
  boundary="nextPart9007734.vUf7ZuzOes";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart9007734.vUf7ZuzOes
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
26 =D0=B8=D1=8E=D0=BD=D1=8F 2010 23:57:42 =D0=B0=D0=B2=D1=82=D0=BE=D1=80 Ma=
rk Brown =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:
> On 26 Jun 2010, at 21:53, Vasily Khoruzhick wrote:
> > =D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 26 =D0=B8=D1=8E=D0=BD=D1=8F 2010 23:09:39 =D0=B0=D0=B2=D1=82=D0=BE=D1=
=80 Mark Brown =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:
> >> The regulator API isn't massively complex either and it does provide a
> >> standard abstraction for controlling power which seems like it might be
> >> useful here, though given the (frankly rather odd) fiddling with clocks
> >> your callback does perhaps it won't help.
> >=20
> > Ok, but I still don't like idea about keeping both regulator and gpio
> > stuff.
>=20
> If you're going to the regulator API it's probably OK to remove the GPIO
> stuff since the regulator API supports GPIO controlled regulators already.
> Does mean transitioning the existing drivers but it means everyone shares
> the same code.

Actually, power on sequence on rx1950 (and on magician) looks like followin=
g:

1. set power pin to 1
2. set reset pin to 1
3. wait a bit (1ms or so)
4. set reset pin to 0

Reset right after power on is necessary at least on rx1950 (otherwise codec=
=20
doesn't respond on i2c).

=46ixed regulator doesn't support that logic now, and I don't want to mix=20
gpio/regulator stuff in uda1380 driver. Does it makes sense to implement
another fixed-like regulator just for uda1380?

Regards
Vasily

--nextPart9007734.vUf7ZuzOes
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEABECAAYFAkwojtUACgkQRM6pQpltKE6dNQCgy0lQj1x6ddjPB5LootlEaetG
yvkAoL2cCRd4yQ0fXk3AmrSDE9gn1YVG
=7JNb
-----END PGP SIGNATURE-----

--nextPart9007734.vUf7ZuzOes--

--===============7184199056088839496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7184199056088839496==--
