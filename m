From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH RFC 1/3] ASoC: uda1380: use callbacks
	instead of gpiolib
Date: Sun, 27 Jun 2010 00:12:05 +0300
Message-ID: <201006270012.12854.anarsoul@gmail.com>
References: <1277565285-11563-1-git-send-email-anarsoul@gmail.com>
	<201006262353.58897.anarsoul@gmail.com>
	<8308AEB2-F7DB-4C48-AAED-719311AF7A42@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2191931359956798656=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 1CD94244F7
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Jun 2010 23:12:17 +0200 (CEST)
Received: by bwz11 with SMTP id 11so1133300bwz.38
	for <alsa-devel@alsa-project.org>; Sat, 26 Jun 2010 14:12:16 -0700 (PDT)
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

--===============2191931359956798656==
Content-Type: multipart/signed;
  boundary="nextPart4937730.llRjuaEQXX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4937730.llRjuaEQXX
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
26 =D0=B8=D1=8E=D0=BD=D1=8F 2010 23:57:42 =D0=B0=D0=B2=D1=82=D0=BE=D1=80 Ma=
rk Brown =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:

> You definitely should be doing this in the I2C driver not the CODEC drive=
r,
> you're peering inside the internals of the I2C driver as things stand and
> are likely to cause problems if someone comes along and implements this in
> the driver. There's also the fact that all users of the I2C controller
> will benefit if the code is implemented there, not just this one audio
> driver.

I'm afraid that it can cause problems with other i2c-controlled devices, an=
d I=20
can test i2c modification only on h1940 and rx1950 with same codec (uda1380=
).

--nextPart4937730.llRjuaEQXX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEABECAAYFAkwmbSwACgkQRM6pQpltKE6fWgCfTCKrNdSf33b1gINOCipcGRgO
FyQAn2Ob+PY91jnaN11bXwD5Th08CDSQ
=Tk/f
-----END PGP SIGNATURE-----

--nextPart4937730.llRjuaEQXX--

--===============2191931359956798656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2191931359956798656==--
