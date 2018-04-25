From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/5] ASoC: add mt6351 codec driver
Date: Wed, 25 Apr 2018 18:19:34 +0100
Message-ID: <20180425171934.GH24769@sirena.org.uk>
References: <20180425072522.14167-1-kaichieh.chuang@mediatek.com>
 <20180425072522.14167-2-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1065398219761819332=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3258C267035
 for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2018 19:19:39 +0200 (CEST)
In-Reply-To: <20180425072522.14167-2-kaichieh.chuang@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Cc: alsa-devel@alsa-project.org, garlic.tseng@mediatek.com, linux-mediatek@lists.infradead.org, chipeng.chang@mediatek.com, wsd_upstream@mediatek.com
List-Id: alsa-devel@alsa-project.org


--===============1065398219761819332==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GBDnBH7+ZvLx8QD4"
Content-Disposition: inline


--GBDnBH7+ZvLx8QD4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 25, 2018 at 03:25:18PM +0800, KaiChieh Chuang wrote:

This is almost ready, a few more things below that I just noticed as the
bigger issues have all been dealt with now.  Sorry, should've noticed
most of these sooner.

> +++ b/sound/soc/codecs/mt6351.c
> @@ -0,0 +1,1516 @@
> +/*
> + * mt6351.c  --  mt6351 ALSA SoC audio codec driver
> + *
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

This should be a C++ comment with a SPDX header instead of the GPL
statement.

> +static unsigned int get_play_reg_val(struct snd_soc_codec *codec,
> +				     unsigned int rate)

The driver is using snd_soc_codec quite a bit but we are trying to
transition away from that to snd_soc_component - you can see a lot of
example transitions in mainline from Moritmoto-san, everything that
exists at the CODEC level has a pretty direct equivalent in the
component struct so it's mostly (but not quite entirely unfortunately)
search and replace.

> +static struct snd_soc_codec_driver mt6351_soc_codec_driver = {
> +	.probe = mt6351_codec_probe,
> +
> +	.component_driver = {
> +		.dapm_widgets = mt6351_dapm_widgets,
> +		.num_dapm_widgets = ARRAY_SIZE(mt6351_dapm_widgets),
> +		.dapm_routes = mt6351_dapm_routes,
> +		.num_dapm_routes = ARRAY_SIZE(mt6351_dapm_routes),
> +	},
> +};

You should be able to add the controls that you're manually registering
in probe here.

--GBDnBH7+ZvLx8QD4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrguKUACgkQJNaLcl1U
h9A1XQf+IYwq9580VE7RG+lt8Vkzo/3JWQR6jDGB7kqedKhBmclVFtD9RzVrEGLO
N1FwIUvnVKH+YJM785OkBa76s26FivND0fdvl7DrGYynjswenPlmkrjy7GFfR0OU
qvAGcXG9XL2fIPk6PPvrO18mB5IorPkL7XNAjbQ82rc8/cSxMffdfGAoGQ2ETmOS
ZJGUCr9SDMOqzoif+4Mj3E4xyOsTQZjJUdwrtBXvmzSvQZijDbP9HKesjewH5V4A
NznAa6Bz/CUmkLm9OIu9Jdoj52E6dM7Q9mxZpV5DzAOURygX7zle3M8KooD52kln
+9CViHoxcmHds9htqzTvBcN1T8o/8Q==
=YUUy
-----END PGP SIGNATURE-----

--GBDnBH7+ZvLx8QD4--

--===============1065398219761819332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1065398219761819332==--
