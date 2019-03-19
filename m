From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/13] ASoC: tlv320aic32x4: Model PLL in CCF
Date: Tue, 19 Mar 2019 15:26:38 +0000
Message-ID: <20190319152638.GF5514@sirena.org.uk>
References: <20190319033756.20616-1-nh6z@nh6z.net>
 <20190319033756.20616-3-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2772193095650440797=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7C9D8F8070E
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 16:26:51 +0100 (CET)
In-Reply-To: <20190319033756.20616-3-nh6z@nh6z.net>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Annaliese McDermond <nh6z@nh6z.net>
Cc: alsa-devel@alsa-project.org, team@nwdigitalradio.com
List-Id: alsa-devel@alsa-project.org


--===============2772193095650440797==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hK8Uo4Yp55NZU70L"
Content-Disposition: inline


--hK8Uo4Yp55NZU70L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 18, 2019 at 08:37:45PM -0700, Annaliese McDermond wrote:

> ---
>  sound/soc/codecs/Makefile            |   2 +-
>  sound/soc/codecs/tlv320aic32x4-clk.c | 323 +++++++++++++++++++++++++++
>  sound/soc/codecs/tlv320aic32x4.c     |  93 ++++----
>  sound/soc/codecs/tlv320aic32x4.h     |   5 +
>  4 files changed, 379 insertions(+), 44 deletions(-)

I'm not seeing any Kconfig updates which add dependencies on the clock
API or conditionally build the clock implementation only if that's been
enabled.

> +++ b/sound/soc/codecs/tlv320aic32x4-clk.c
> @@ -0,0 +1,323 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * linux/sound/soc/codecs/tlv320aic32x4-clk.c
> + *
> + * Copyright 2019 Annaliese McDermond
> + *
> + * Author: Annaliese McDermond <nh6z@nh6z.net>
> + */

Please make the entire comment a C++ comment so it looks more
intentional.  It's also better to not have the path in the header since
that's prone to bitrot, just write something in words.

> +static const struct clk_ops aic32x4_pll_ops = {
> +	.enable = clk_aic32x4_pll_enable,
> +	.disable = clk_aic32x4_pll_disable,
> +	.is_enabled = clk_aic32x4_pll_is_enabled,

These are enable and disable operations - shouldn't they be prepare and
unprepare?  The device is controlled over buses that require sleeping
but the prepare and enable operations require atomic context.

> +}
> +EXPORT_SYMBOL(aic32x4_register_clocks);

ASoC is all EXPORT_SYMBOL_GPL()...

--hK8Uo4Yp55NZU70L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyRCi4ACgkQJNaLcl1U
h9Ch+wf9HltoUxfRxKtSHXNNcs8t/KuXHmogtuz9FHy7zPkkih4pYNbdoVkBX8FW
AAO8UceKt/+IPMRWTyiJ/r/XG+ptv01oHuW+ZONFwumBuLSrzNroi7gDTp4M4xCm
jd2xU6PyACxue7WSCsIwmZ78SfundDpChZOendtZ9dFLGYGX/Oww5ex9MeH0twhp
HOFeG1feI1yqQ7ndeIBXI7ieob1KNt5Tgbvyd7eZkKJMBW+DX60REehpnQXGbZRE
iIk4Xn78ZVZqTT6UzpgOxwsjM/ZqJUjmTjfaHFWeDx1wCazJRjIlJCeG2v7gV9ML
dfnRz8Yr8Ao8fCcUu39i4R3hs8CLig==
=SUI4
-----END PGP SIGNATURE-----

--hK8Uo4Yp55NZU70L--

--===============2772193095650440797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2772193095650440797==--
