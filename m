From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH RFC 1/3] ASoC: uda1380: use callbacks
	instead of gpiolib
Date: Sat, 26 Jun 2010 23:53:50 +0300
Message-ID: <201006262353.58897.anarsoul@gmail.com>
References: <1277565285-11563-1-git-send-email-anarsoul@gmail.com>
	<201006261953.43884.anarsoul@gmail.com>
	<877258B5-0752-473E-920C-CFD529858C4B@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2253492986615351979=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 5BFBD24450
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Jun 2010 22:54:03 +0200 (CEST)
Received: by bwz11 with SMTP id 11so1129476bwz.38
	for <alsa-devel@alsa-project.org>; Sat, 26 Jun 2010 13:54:03 -0700 (PDT)
In-Reply-To: <877258B5-0752-473E-920C-CFD529858C4B@opensource.wolfsonmicro.com>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

--===============2253492986615351979==
Content-Type: multipart/signed;
  boundary="nextPart2935205.HerYBHnBgt";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2935205.HerYBHnBgt
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
26 =D0=B8=D1=8E=D0=BD=D1=8F 2010 23:09:39 =D0=B0=D0=B2=D1=82=D0=BE=D1=80 Ma=
rk Brown =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:

> The regulator API isn't massively complex either and it does provide a
> standard abstraction for controlling power which seems like it might be
> useful here, though given the (frankly rather odd) fiddling with clocks
> your callback does perhaps it won't help.

Ok, but I still don't like idea about keeping both regulator and gpio stuff=
=2E=20
Btw, this weird clock stuff can be merged to i2c driver, i.e. keep i2c modu=
le=20
clock enabled only on i2c transfer (it's not scl line, it's module clock)=20
(I've sent patch for i2c-s3c2410 ~month ago, can resend it), and we can avo=
id=20
modyfing power/reset controlling part of uda1380 driver. What do you think=
=20
about that?

Regards
Vasily

--nextPart2935205.HerYBHnBgt
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEABECAAYFAkwmaOYACgkQRM6pQpltKE7suACg44LemnZzRkXhHTi+Dj81zj5x
YwIAoJ/hWlFZQGfPVAzENVuSE+vOL/Cn
=YEfN
-----END PGP SIGNATURE-----

--nextPart2935205.HerYBHnBgt--

--===============2253492986615351979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2253492986615351979==--
