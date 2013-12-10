From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] ASoC: ep93xx: remove custom DMA alloc
	compat function
Date: Tue, 10 Dec 2013 10:26:52 +0000
Message-ID: <20131210102651.GZ29268@sirena.org.uk>
References: <1386620656-18391-1-git-send-email-swarren@wwwdotorg.org>
 <1386620656-18391-3-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2476389586556251170=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 827C02651BE
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2013 11:26:54 +0100 (CET)
In-Reply-To: <1386620656-18391-3-git-send-email-swarren@wwwdotorg.org>
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


--===============2476389586556251170==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fSLOEWDpqXiBB1zu"
Content-Disposition: inline


--fSLOEWDpqXiBB1zu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2013 at 01:24:13PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> ep93xx_compat_request_channel() is almost identical to
> dmaengine_pcm_compat_request_channel(), with the exception that the
> latter:
>=20
> a) Assumes that the DAI DMA data is a struct snd_dmaengine_dai_dma_data
>    pointer rather than some custom type.
>=20
> b) dma_data->filter_data rather than dma_data should be passed to
>    snd_dmaengine_pcm_request_channel() as the filter data.
>=20
> Make minor changes to the ep93xx DAI drivers so that those two conditions
> are met. This allows removal of the custom .compat_request_channel().

Adding Hartley and Ryan.

>=20
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  sound/soc/cirrus/ep93xx-ac97.c | 16 ++++++++++++----
>  sound/soc/cirrus/ep93xx-i2s.c  | 14 ++++++++++++--
>  sound/soc/cirrus/ep93xx-pcm.c  | 13 -------------
>  3 files changed, 24 insertions(+), 19 deletions(-)
>=20
> diff --git a/sound/soc/cirrus/ep93xx-ac97.c b/sound/soc/cirrus/ep93xx-ac9=
7.c
> index e45f0fd2f6b8..f434b6ebb1d6 100644
> --- a/sound/soc/cirrus/ep93xx-ac97.c
> +++ b/sound/soc/cirrus/ep93xx-ac97.c
> @@ -19,6 +19,7 @@
>  #include <linux/slab.h>
> =20
>  #include <sound/core.h>
> +#include <sound/dmaengine_pcm.h>
>  #include <sound/ac97_codec.h>
>  #include <sound/soc.h>
> =20
> @@ -97,6 +98,8 @@ struct ep93xx_ac97_info {
>  	struct device		*dev;
>  	void __iomem		*regs;
>  	struct completion	done;
> +	struct snd_dmaengine_dai_dma_data dma_params_rx;
> +	struct snd_dmaengine_dai_dma_data dma_params_tx;
>  };
> =20
>  /* currently ALSA only supports a single AC97 device */
> @@ -317,8 +320,13 @@ static int ep93xx_ac97_trigger(struct snd_pcm_substr=
eam *substream,
> =20
>  static int ep93xx_ac97_dai_probe(struct snd_soc_dai *dai)
>  {
> -	dai->playback_dma_data =3D &ep93xx_ac97_pcm_out;
> -	dai->capture_dma_data =3D &ep93xx_ac97_pcm_in;
> +	struct ep93xx_ac97_info *info =3D snd_soc_dai_get_drvdata(dai);
> +
> +	info->dma_params_tx.filter_data =3D &ep93xx_ac97_pcm_out;
> +	info->dma_params_rx.filter_data =3D &ep93xx_ac97_pcm_in;
> +
> +	dai->playback_dma_data =3D &info->dma_params_tx;
> +	dai->capture_dma_data =3D &info->dma_params_rx;
> =20
>  	return 0;
>  }
> @@ -396,8 +404,8 @@ static int ep93xx_ac97_probe(struct platform_device *=
pdev)
>  	if (ret)
>  		goto fail;
> =20
> -	err =3D ep93xx_pcm_platform_register(&pdev->dev);
> -	if (err)
> +	ret =3D ep93xx_pcm_platform_register(&pdev->dev);
> +	if (ret)
>  		goto fail_unregister;
> =20
>  	return 0;
> diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
> index cc43ed2dbca5..d21a359f4011 100644
> --- a/sound/soc/cirrus/ep93xx-i2s.c
> +++ b/sound/soc/cirrus/ep93xx-i2s.c
> @@ -21,6 +21,7 @@
>  #include <linux/io.h>
> =20
>  #include <sound/core.h>
> +#include <sound/dmaengine_pcm.h>
>  #include <sound/pcm.h>
>  #include <sound/pcm_params.h>
>  #include <sound/initval.h>
> @@ -63,6 +64,8 @@ struct ep93xx_i2s_info {
>  	struct clk			*sclk;
>  	struct clk			*lrclk;
>  	void __iomem			*regs;
> +	struct snd_dmaengine_dai_dma_data dma_params_rx;
> +	struct snd_dmaengine_dai_dma_data dma_params_tx;
>  };
> =20
>  static struct ep93xx_dma_data ep93xx_i2s_dma_data[] =3D {
> @@ -142,8 +145,15 @@ static void ep93xx_i2s_disable(struct ep93xx_i2s_inf=
o *info, int stream)
> =20
>  static int ep93xx_i2s_dai_probe(struct snd_soc_dai *dai)
>  {
> -	dai->playback_dma_data =3D &ep93xx_i2s_dma_data[SNDRV_PCM_STREAM_PLAYBA=
CK];
> -	dai->capture_dma_data =3D &ep93xx_i2s_dma_data[SNDRV_PCM_STREAM_CAPTURE=
];
> +	struct ep93xx_i2s_info *info =3D snd_soc_dai_get_drvdata(dai);
> +
> +	info->dma_params_tx.filter_data =3D
> +		&ep93xx_i2s_dma_data[SNDRV_PCM_STREAM_PLAYBACK];
> +	info->dma_params_rx.filter_data =3D
> +		&ep93xx_i2s_dma_data[SNDRV_PCM_STREAM_CAPTURE];
> +
> +	dai->playback_dma_data =3D &info->dma_params_tx;
> +	dai->capture_dma_data =3D &info->dma_params_rx;
> =20
>  	return 0;
>  }
> diff --git a/sound/soc/cirrus/ep93xx-pcm.c b/sound/soc/cirrus/ep93xx-pcm.c
> index 144278aa65f9..856862932fdf 100644
> --- a/sound/soc/cirrus/ep93xx-pcm.c
> +++ b/sound/soc/cirrus/ep93xx-pcm.c
> @@ -59,22 +59,9 @@ static bool ep93xx_pcm_dma_filter(struct dma_chan *cha=
n, void *filter_param)
>  	return false;
>  }
> =20
> -static struct dma_chan *ep93xx_compat_request_channel(
> -	struct snd_soc_pcm_runtime *rtd,
> -	struct snd_pcm_substream *substream)
> -{
> -	struct snd_dmaengine_dai_dma_data *dma_data;
> -
> -	dma_data =3D snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
> -
> -	return snd_dmaengine_pcm_request_channel(ep93xx_pcm_dma_filter,
> -						 dma_data);
> -}
> -
>  static const struct snd_dmaengine_pcm_config ep93xx_dmaengine_pcm_config=
 =3D {
>  	.pcm_hardware =3D &ep93xx_pcm_hardware,
>  	.compat_filter_fn =3D ep93xx_pcm_dma_filter,
> -	.compat_request_channel =3D ep93xx_compat_request_channel,
>  	.prealloc_buffer_size =3D 131072,
>  };
> =20
> --=20
> 1.8.1.5
>=20
>=20

--fSLOEWDpqXiBB1zu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSpuxoAAoJELSic+t+oim9rRYP/03c5JjCp2bcO5IDeQ+3uX7A
A+dytdM/ZR0tAFxdDd4c0OWigdR02oPRZ3IbQo0vNL3VqnyV0JtLj1WvsApsjogd
XzI1amiOU5QIFDokjV88R+TQ0NdKyLnU0JCSwIxt3KCRtibWj66qXmTlfIzincZz
ZfczKNk64FC6oTqQ1fBM69Fo4g2daD6rkyCnvrN+s9ov8d+aRV4zEoweJkDu7RkC
/jQ7NgWcYRUrsZ213A1qkYyv9BH9MTOIGbna6YvJ062ofuFfQqT3oU4U0Sdu63Kc
57y82r3HESaoD3qnrQTmXcqk9vooHzGgfbkic3LpIKI4UmxfQi+FHyazJcECYaWi
cy6MZy/bx2ACrr1SmFu3EqDfPu62Zo70t4OGe68PbrSTlFREnOefACTWjOksvM14
EDYw+dxn/Em/uxtz3Y+3y6qSvqldl4vdufqY0qUYHJdrjf+kIwKoE/HiaK5t9FJw
XabR2l1LSDbVZAiW0Iw4IljCtc5EN0DZ+sJRFkvgEdBxwd19GVzw9VybOWaWF4d2
yKuGmYfb+lf3GVy161eYgAR7KjO8t0bcbW1EGHLBwKLCda/oXL3ZsMX/IJDSTli/
9wZMsm41Dh/MK3hf6LKSKcJECclsJoRI79nZI3OjU4vT/jVBxDxqxCf6QCcii0ss
8j1EfcelhSNirhywU5oR
=xYm3
-----END PGP SIGNATURE-----

--fSLOEWDpqXiBB1zu--

--===============2476389586556251170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2476389586556251170==--
