From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH RFC 1/3] ASoC: uda1380: use callbacks
	instead of gpiolib
Date: Mon, 28 Jun 2010 17:25:25 +0300
Message-ID: <201006281725.30673.anarsoul@gmail.com>
References: <1277565285-11563-1-git-send-email-anarsoul@gmail.com>
	<201006281705.57779.anarsoul@gmail.com>
	<20100628141539.GC7403@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7167106647037957417=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id A3A3A2447A
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Jun 2010 16:25:41 +0200 (CEST)
Received: by fxm15 with SMTP id 15so1145908fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 28 Jun 2010 07:25:41 -0700 (PDT)
In-Reply-To: <20100628141539.GC7403@rakim.wolfsonmicro.main>
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

--===============7167106647037957417==
Content-Type: multipart/signed;
  boundary="nextPart1290525.dIUGeX5SId";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1290525.dIUGeX5SId
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
28 =D0=B8=D1=8E=D0=BD=D1=8F 2010 17:15:40 =D0=B0=D0=B2=D1=82=D0=BE=D1=80 Ma=
rk Brown =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:

> What I'm trying to figure out is if the GPIO is wired directly to the
> UDA1380 or if this is controlling something external to the UDA1380
> which these designs just happen to have copied.  If it's a direct
> connection to the UDA1380 then using GPIOs directly is perfectly
> sensible.

I'm not sure if s3c24xx GPIOs can drive UDA1380 directly. I suspect it's wi=
red=20
to the gate of some transistor (FET - is it right term to use here? :)) to=
=20
handle higher current (sorry, English is not my native language, and it's h=
ard=20
to explain schematic-specific things, that's not my field :)). Btw, I'm sur=
e=20
that there's no any external power-control chip, maybe just single transist=
or.

Regards
Vasily

--nextPart1290525.dIUGeX5SId
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEABECAAYFAkwosNoACgkQRM6pQpltKE7OcgCgzZqbQsRrn544eRF3vb0K/X1r
f2UAoKCgqvchvOLNfvvPyN+kECbfGWqd
=//Te
-----END PGP SIGNATURE-----

--nextPart1290525.dIUGeX5SId--

--===============7167106647037957417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7167106647037957417==--
