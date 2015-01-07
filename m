From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/3] ASoC: omap-twl4030: Use
	snd_soc_runtime_set_dai_fmt()
Date: Wed, 7 Jan 2015 14:23:52 +0200
Message-ID: <54AD2558.4030009@ti.com>
References: <1420553842-17335-1-git-send-email-lars@metafoo.de>
 <1420553842-17335-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 647B42604BB
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 13:23:56 +0100 (CET)
In-Reply-To: <1420553842-17335-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 01/06/2015 04:17 PM, Lars-Peter Clausen wrote:
> Use snd_soc_runtime_set_dai_fmt() to configure the format for the DAI link
> rather than configuring each DAI individually.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> =

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  sound/soc/omap/omap-twl4030.c | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)
> =

> diff --git a/sound/soc/omap/omap-twl4030.c b/sound/soc/omap/omap-twl4030.c
> index 5e551c7..fb1f6bb 100644
> --- a/sound/soc/omap/omap-twl4030.c
> +++ b/sound/soc/omap/omap-twl4030.c
> @@ -53,11 +53,7 @@ static int omap_twl4030_hw_params(struct snd_pcm_subst=
ream *substream,
>  	struct snd_pcm_hw_params *params)
>  {
>  	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
> -	struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
> -	struct snd_soc_dai *cpu_dai =3D rtd->cpu_dai;
> -	struct snd_soc_card *card =3D rtd->card;
>  	unsigned int fmt;
> -	int ret;
>  =

>  	switch (params_channels(params)) {
>  	case 2: /* Stereo I2S mode */
> @@ -74,21 +70,7 @@ static int omap_twl4030_hw_params(struct snd_pcm_subst=
ream *substream,
>  		return -EINVAL;
>  	}
>  =

> -	/* Set codec DAI configuration */
> -	ret =3D snd_soc_dai_set_fmt(codec_dai, fmt);
> -	if (ret < 0) {
> -		dev_err(card->dev, "can't set codec DAI configuration\n");
> -		return ret;
> -	}
> -
> -	/* Set cpu DAI configuration */
> -	ret =3D snd_soc_dai_set_fmt(cpu_dai, fmt);
> -	if (ret < 0) {
> -		dev_err(card->dev, "can't set cpu DAI configuration\n");
> -		return ret;
> -	}
> -
> -	return 0;
> +	return snd_soc_runtime_set_dai_fmt(rtd, fmt);
>  }
>  =

>  static struct snd_soc_ops omap_twl4030_ops =3D {
> =



-- =

P=E9ter
