From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8822: new codec driver
Date: Wed, 17 Oct 2018 19:54:23 +0100
Message-ID: <20181017185423.GG24097@sirena.org.uk>
References: <20180928031002.16112-1-CTLIN0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0680587312325568530=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 41BAF2675A4
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2018 20:54:26 +0200 (CEST)
In-Reply-To: <20180928031002.16112-1-CTLIN0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Lin <CTLIN0@nuvoton.com>
Cc: wtli@nuvoton.com, yhchuang@nuvoton.com, alsa-devel@alsa-project.org, kchsu0@nuvoton.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0680587312325568530==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KR/qxknboQ7+Tpez"
Content-Disposition: inline


--KR/qxknboQ7+Tpez
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 28, 2018 at 11:10:04AM +0800, David Lin wrote:

This looks mostly good so I'm going to apply it, I do have a couple of
comments below but they are quite small and I think they can be
addressed with followup patches.

> +++ b/sound/soc/codecs/nau8822.c
> @@ -0,0 +1,1136 @@
> +/*
> + * nau8822.c  --  NAU8822 ALSA Soc Audio Codec driver
> + *
> + * Copyright 2017 Nuvoton Technology Corp.
> + *
> + * Author: David Lin <ctlin0@nuvoton.com>
> + * Co-author: John Hsu <kchsu0@nuvoton.com>
> + * Co-author: Seven Li <wtli@nuvoton.com>
> + *
> + * Based on WM8974.c
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */

This should be converted to use a SPDX license header

	// SPDX-License-Identifier: GPL-2.0.

> +static int nau8822_config_clkdiv(struct snd_soc_dai *dai, int div, int r=
ate)
> +{
> +	struct snd_soc_component *component =3D dai->component;
> +	struct nau8822 *nau8822 =3D snd_soc_component_get_drvdata(component);
> +	struct nau8822_pll *pll =3D &nau8822->pll;
> +	int i, sclk, imclk;

We're trying to get away from using set_clkdiv() as it makes it much
harder to use generic card drivers without specific knowledge of the=20
card.  However in this case it seems like it's mainly choosing if we
should use the MCLK directly or the PLL and you should be able to do
everything in the set_sysclk() operation - is there a reason not to do
that?  If not then moving to set_sysclk() would avoid problems.

--KR/qxknboQ7+Tpez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvHhV4ACgkQJNaLcl1U
h9DTbgf+N7bc8rVFMOEkLQ4CCYQnFrguK7rEJ4mukkvmpRSLzttCjz8jm6bkkMFx
6gzUlQ7ZpodjJ1ScngetYR+AfwGxrtVYNi9I3Gju2atlWL5KNXwMdoKkQKAWOrDf
cG06gDRSm15Now/WjvzBtjNREgv7YXkItldOoPExr/kTvgnKsNy8lcRe3CUz8BRi
NSwTAkcYj13nGK5kYrG3dtI32L0RmQZx6PttrJrR+cSPW5C+OVqf15EEuZvsBtmR
eLSwA+OgAXl/uprM3m+FSW/svnCm2NTrQdnWQBEQ69JT4ob/Lzh2rTPR6cDIVAyX
eVVegD5psGSKC5EEBIBZXOAMvnTEFw==
=6Bix
-----END PGP SIGNATURE-----

--KR/qxknboQ7+Tpez--

--===============0680587312325568530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0680587312325568530==--
