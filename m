From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: ep93xx: get rid of
 ep93xx-pcm-audio struct device
Date: Tue, 10 Dec 2013 10:26:05 +0000
Message-ID: <20131210102605.GY29268@sirena.org.uk>
References: <1386620656-18391-1-git-send-email-swarren@wwwdotorg.org>
 <1386620656-18391-2-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7077750592632789049=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C3B2E261A4B
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2013 11:26:10 +0100 (CET)
In-Reply-To: <1386620656-18391-2-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@nvidia.com>, Ryan Mallon <rmallon@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, H Hartley Sweeten <hsweeten@visionengravers.com>
List-Id: alsa-devel@alsa-project.org


--===============7077750592632789049==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HS0RKbQYUdbWMyzK"
Content-Disposition: inline


--HS0RKbQYUdbWMyzK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2013 at 01:24:12PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> Modify the ep93xx PCM driver so that it's a utility library that can be
> registered on each DAI, rather than a separate struct device. This is
> more in line with how many recent DT-converted platforms operate, and
> avoids the need for yet another struct device.

Please CC driver maintainers, adding Hartley and Ryan.

>=20
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  sound/soc/cirrus/edb93xx.c     |  2 +-
>  sound/soc/cirrus/ep93xx-ac97.c |  9 +++++++++
>  sound/soc/cirrus/ep93xx-i2s.c  |  9 +++++++++
>  sound/soc/cirrus/ep93xx-pcm.c  | 26 ++++++++------------------
>  sound/soc/cirrus/ep93xx-pcm.h  | 24 ++++++++++++++++++++++++
>  sound/soc/cirrus/simone.c      |  2 +-
>  sound/soc/cirrus/snappercl15.c |  2 +-
>  7 files changed, 53 insertions(+), 21 deletions(-)
>  create mode 100644 sound/soc/cirrus/ep93xx-pcm.h
>=20
> diff --git a/sound/soc/cirrus/edb93xx.c b/sound/soc/cirrus/edb93xx.c
> index c43fb214558a..4f900efc437c 100644
> --- a/sound/soc/cirrus/edb93xx.c
> +++ b/sound/soc/cirrus/edb93xx.c
> @@ -63,7 +63,7 @@ static struct snd_soc_ops edb93xx_ops =3D {
>  static struct snd_soc_dai_link edb93xx_dai =3D {
>  	.name		=3D "CS4271",
>  	.stream_name	=3D "CS4271 HiFi",
> -	.platform_name	=3D "ep93xx-pcm-audio",
> +	.platform_name	=3D "ep93xx-i2s",
>  	.cpu_dai_name	=3D "ep93xx-i2s",
>  	.codec_name	=3D "spi0.0",
>  	.codec_dai_name	=3D "cs4271-hifi",
> diff --git a/sound/soc/cirrus/ep93xx-ac97.c b/sound/soc/cirrus/ep93xx-ac9=
7.c
> index efa75b5086a4..e45f0fd2f6b8 100644
> --- a/sound/soc/cirrus/ep93xx-ac97.c
> +++ b/sound/soc/cirrus/ep93xx-ac97.c
> @@ -24,6 +24,8 @@
> =20
>  #include <linux/platform_data/dma-ep93xx.h>
> =20
> +#include "ep93xx-pcm.h"
> +
>  /*
>   * Per channel (1-4) registers.
>   */
> @@ -394,8 +396,14 @@ static int ep93xx_ac97_probe(struct platform_device =
*pdev)
>  	if (ret)
>  		goto fail;
> =20
> +	err =3D ep93xx_pcm_platform_register(&pdev->dev);
> +	if (err)
> +		goto fail_unregister;
> +
>  	return 0;
> =20
> +fail_unregister:
> +	snd_soc_unregister_component(&pdev->dev);
>  fail:
>  	ep93xx_ac97_info =3D NULL;
>  	snd_soc_set_ac97_ops(NULL);
> @@ -406,6 +414,7 @@ static int ep93xx_ac97_remove(struct platform_device =
*pdev)
>  {
>  	struct ep93xx_ac97_info	*info =3D platform_get_drvdata(pdev);
> =20
> +	ep93xx_pcm_platform_unregister(&pdev->dev);
>  	snd_soc_unregister_component(&pdev->dev);
> =20
>  	/* disable the AC97 controller */
> diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
> index a57643d6402f..cc43ed2dbca5 100644
> --- a/sound/soc/cirrus/ep93xx-i2s.c
> +++ b/sound/soc/cirrus/ep93xx-i2s.c
> @@ -30,6 +30,8 @@
>  #include <mach/ep93xx-regs.h>
>  #include <linux/platform_data/dma-ep93xx.h>
> =20
> +#include "ep93xx-pcm.h"
> +
>  #define EP93XX_I2S_TXCLKCFG		0x00
>  #define EP93XX_I2S_RXCLKCFG		0x04
>  #define EP93XX_I2S_GLCTRL		0x0C
> @@ -405,8 +407,14 @@ static int ep93xx_i2s_probe(struct platform_device *=
pdev)
>  	if (err)
>  		goto fail_put_lrclk;
> =20
> +	err =3D ep93xx_pcm_platform_register(&pdev->dev);
> +	if (err)
> +		goto fail_unregister;
> +
>  	return 0;
> =20
> +fail_unregister:
> +	snd_soc_unregister_component(&pdev->dev);
>  fail_put_lrclk:
>  	clk_put(info->lrclk);
>  fail_put_sclk:
> @@ -421,6 +429,7 @@ static int ep93xx_i2s_remove(struct platform_device *=
pdev)
>  {
>  	struct ep93xx_i2s_info *info =3D dev_get_drvdata(&pdev->dev);
> =20
> +	ep93xx_pcm_platform_unregister(&pdev->dev);
>  	snd_soc_unregister_component(&pdev->dev);
>  	clk_put(info->lrclk);
>  	clk_put(info->sclk);
> diff --git a/sound/soc/cirrus/ep93xx-pcm.c b/sound/soc/cirrus/ep93xx-pcm.c
> index cfe517e68009..144278aa65f9 100644
> --- a/sound/soc/cirrus/ep93xx-pcm.c
> +++ b/sound/soc/cirrus/ep93xx-pcm.c
> @@ -23,6 +23,8 @@
> =20
>  #include <linux/platform_data/dma-ep93xx.h>
> =20
> +#include "ep93xx-pcm.h"
> +
>  static const struct snd_pcm_hardware ep93xx_pcm_hardware =3D {
>  	.info			=3D (SNDRV_PCM_INFO_MMAP		|
>  				   SNDRV_PCM_INFO_MMAP_VALID	|
> @@ -76,34 +78,22 @@ static const struct snd_dmaengine_pcm_config ep93xx_d=
maengine_pcm_config =3D {
>  	.prealloc_buffer_size =3D 131072,
>  };
> =20
> -static int ep93xx_soc_platform_probe(struct platform_device *pdev)
> +int ep93xx_pcm_platform_register(struct device *dev)
>  {
> -	return snd_dmaengine_pcm_register(&pdev->dev,
> +	return snd_dmaengine_pcm_register(dev,
>  		&ep93xx_dmaengine_pcm_config,
>  		SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
>  		SND_DMAENGINE_PCM_FLAG_NO_DT |
>  		SND_DMAENGINE_PCM_FLAG_COMPAT);
>  }
> +EXPORT_SYMBOL_GPL(ep93xx_pcm_platform_register);
> =20
> -static int ep93xx_soc_platform_remove(struct platform_device *pdev)
> +void ep93xx_pcm_platform_unregister(struct device *dev)
>  {
> -	snd_dmaengine_pcm_unregister(&pdev->dev);
> -	return 0;
> +	snd_dmaengine_pcm_unregister(dev);
>  }
> -
> -static struct platform_driver ep93xx_pcm_driver =3D {
> -	.driver =3D {
> -			.name =3D "ep93xx-pcm-audio",
> -			.owner =3D THIS_MODULE,
> -	},
> -
> -	.probe =3D ep93xx_soc_platform_probe,
> -	.remove =3D ep93xx_soc_platform_remove,
> -};
> -
> -module_platform_driver(ep93xx_pcm_driver);
> +EXPORT_SYMBOL_GPL(ep93xx_pcm_platform_unregister);
> =20
>  MODULE_AUTHOR("Ryan Mallon");
>  MODULE_DESCRIPTION("EP93xx ALSA PCM interface");
>  MODULE_LICENSE("GPL");
> -MODULE_ALIAS("platform:ep93xx-pcm-audio");
> diff --git a/sound/soc/cirrus/ep93xx-pcm.h b/sound/soc/cirrus/ep93xx-pcm.h
> new file mode 100644
> index 000000000000..5ee1afce931f
> --- /dev/null
> +++ b/sound/soc/cirrus/ep93xx-pcm.h
> @@ -0,0 +1,24 @@
> +/*
> + * Copyright (c) 2013, NVIDIA CORPORATION.  All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef __EP93XX_PCM_H__
> +#define __EP93XX_PCM_H__
> +
> +int ep93xx_pcm_platform_register(struct device *dev);
> +void ep93xx_pcm_platform_unregister(struct device *dev);
> +
> +#endif
> +
> diff --git a/sound/soc/cirrus/simone.c b/sound/soc/cirrus/simone.c
> index 4d094d00c34a..822a19a89e74 100644
> --- a/sound/soc/cirrus/simone.c
> +++ b/sound/soc/cirrus/simone.c
> @@ -27,7 +27,7 @@ static struct snd_soc_dai_link simone_dai =3D {
>  	.cpu_dai_name	=3D "ep93xx-ac97",
>  	.codec_dai_name	=3D "ac97-hifi",
>  	.codec_name	=3D "ac97-codec",
> -	.platform_name	=3D "ep93xx-pcm-audio",
> +	.platform_name	=3D "ep93xx-ac97",
>  };
> =20
>  static struct snd_soc_card snd_soc_simone =3D {
> diff --git a/sound/soc/cirrus/snappercl15.c b/sound/soc/cirrus/snappercl1=
5.c
> index 69041074f2c1..29238a7476dd 100644
> --- a/sound/soc/cirrus/snappercl15.c
> +++ b/sound/soc/cirrus/snappercl15.c
> @@ -83,7 +83,7 @@ static struct snd_soc_dai_link snappercl15_dai =3D {
>  	.cpu_dai_name	=3D "ep93xx-i2s",
>  	.codec_dai_name	=3D "tlv320aic23-hifi",
>  	.codec_name	=3D "tlv320aic23-codec.0-001a",
> -	.platform_name	=3D  "ep93xx-pcm-audio",
> +	.platform_name	=3D "ep93xx-i2s",
>  	.init		=3D snappercl15_tlv320aic23_init,
>  	.dai_fmt	=3D SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_IF |
>  			  SND_SOC_DAIFMT_CBS_CFS,
> --=20
> 1.8.1.5
>=20
>=20

--HS0RKbQYUdbWMyzK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSpuw6AAoJELSic+t+oim9UsEP/0QXBWxMD+6UgAQ80H5qW8l1
v5Wkt9bPpRk89pATKWQOAmOOAbSkjxtbxnVwaR+6TsnHZL0WAKolv9+aZTwNhFp4
wTDAVSwdQ3tT5i/RfYBZF9eg8Z0v6tzDnXub+dd3U75kZhoT+Ywxvq/C7ELY9x1Z
7Cj6EXwKIiO93/+xevcjGoe2P/ohgsnQ/8ppKxQ26KFincPTsa0ZpJa6itXOQ041
4+JZwwWesoe1r8v3VYWd1yhndG/psvcYuFjhQNM/a0u/Q5oyGWyR+VY3rzkxzD2u
jwFKKVNqEuJBwBItnTF5qPrQVlJBB+HGYMNfFR2xxRWBVuThESHSCUQP6kglrlZ9
xWnjHueUrPA0q6GeRx+OCewLJEwl7hHZGH6Xi5emRD7RGz11dnJ9jgrkp9ZGeul/
cft7n2L08cXVKJXYX3ck8tRt3ofExXFXvlmF/betuaCsKRvVm6pjcuZBnMFkPMIO
UV46hYRt3ry8Sipu2oCSqlkCpXr0/izFdGrne89/BIqiKCOnyxggFG+mGr2o30yo
ALX8lXoe1k9eIRxjZHc2shNf41LpYoEzGoev9ThKwVyrgGZ6jmLR6SGO0qPW4IJH
DV+AobgfL5mFm+l87WhQd9lpWffebeTi0cBjDyap2fBgHualvyEKXqqjxWpuqN2e
SBLy6kc8JSZkOZTR/iXD
=T8Ls
-----END PGP SIGNATURE-----

--HS0RKbQYUdbWMyzK--

--===============7077750592632789049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7077750592632789049==--
