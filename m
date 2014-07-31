From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 7/7] ASoC: twl4030: Convert to
	params_width()
Date: Thu, 31 Jul 2014 15:40:03 +0300
Message-ID: <53DA3923.7080700@ti.com>
References: <1406808978-16175-1-git-send-email-broonie@kernel.org>
 <1406808978-16175-7-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 870F82654E9
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 14:40:20 +0200 (CEST)
In-Reply-To: <1406808978-16175-7-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 07/31/2014 03:16 PM, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> =

> The CODEC doesn't care how data is laid out in memory.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> =

> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  sound/soc/codecs/twl4030.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> =

> diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
> index cf404505e7d1..b6b0cb399599 100644
> --- a/sound/soc/codecs/twl4030.c
> +++ b/sound/soc/codecs/twl4030.c
> @@ -1763,16 +1763,16 @@ static int twl4030_hw_params(struct snd_pcm_subst=
ream *substream,
>  	old_format =3D twl4030_read(codec, TWL4030_REG_AUDIO_IF);
>  	format =3D old_format;
>  	format &=3D ~TWL4030_DATA_WIDTH;
> -	switch (params_format(params)) {
> -	case SNDRV_PCM_FORMAT_S16_LE:
> +	switch (params_width(params)) {
> +	case 16:
>  		format |=3D TWL4030_DATA_WIDTH_16S_16W;
>  		break;
> -	case SNDRV_PCM_FORMAT_S32_LE:
> +	case 32:
>  		format |=3D TWL4030_DATA_WIDTH_32S_24W;
>  		break;
>  	default:
> -		dev_err(codec->dev, "%s: unknown format %d\n", __func__,
> -			params_format(params));
> +		dev_err(codec->dev, "%s: unsupported bits/sample %d\n",
> +			__func__, params_width(params));
>  		return -EINVAL;
>  	}
>  =

> =



-- =

P=E9ter
