From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH RFC 1/3] ASoC: uda1380: use callbacks
	instead of gpiolib
Date: Mon, 28 Jun 2010 16:49:33 +0300
Message-ID: <201006281649.39572.anarsoul@gmail.com>
References: <1277565285-11563-1-git-send-email-anarsoul@gmail.com>
	<201006281500.21327.anarsoul@gmail.com>
	<20100628134145.GA7403@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4567412479662807991=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id D2679244A1
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Jun 2010 15:49:47 +0200 (CEST)
Received: by fxm15 with SMTP id 15so1106119fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 28 Jun 2010 06:49:47 -0700 (PDT)
In-Reply-To: <20100628134145.GA7403@rakim.wolfsonmicro.main>
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

--===============4567412479662807991==
Content-Type: multipart/signed;
  boundary="nextPart7306409.7rkO6J3Tlm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart7306409.7rkO6J3Tlm
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
28 =D0=B8=D1=8E=D0=BD=D1=8F 2010 16:41:45 =D0=B0=D0=B2=D1=82=D0=BE=D1=80 Ma=
rk Brown =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:
> On Mon, Jun 28, 2010 at 03:00:13PM +0300, Vasily Khoruzhick wrote:
> > Actually, power on sequence on rx1950 (and on magician) looks like
> > following:
> >=20
> > 1. set power pin to 1
>=20
> Is this a feature of the chip or an external power control?

External power control, power and reset pins are routed to s3c24xx gpio pin=
s=20
on rx1950

--nextPart7306409.7rkO6J3Tlm
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEABECAAYFAkwoqHMACgkQRM6pQpltKE6j0ACfRV4C5hfbLDzGftguB3JuBKz3
fzAAoIvwskYjFaD740FanvCubUK4/Ezy
=BODp
-----END PGP SIGNATURE-----

--nextPart7306409.7rkO6J3Tlm--

--===============4567412479662807991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4567412479662807991==--
