From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH] ASoC: da732x: Merge da732x_dai1_ops and
	da732x_dai2_ops
Date: Wed, 15 Jul 2015 08:39:31 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337AB55E1BC@SW-EX-MBX01.diasemi.com>
References: <1436925093.19790.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EB3E2605B7
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 10:39:34 +0200 (CEST)
In-Reply-To: <1436925093.19790.1.camel@ingics.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>, Support Opensource <Support.Opensource@diasemi.com>, Michal Hajduk <michal.hajduk@diasemi.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 15 July, 2015 02:52, Axel Lin wrote:

> da732x_dai1_ops is identical to da732x_dai2_ops, so merge them to
> da732x_dai_ops. The da732x_dai_ops is not modified after initialization,
> so make it const.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  sound/soc/codecs/da732x.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/soc/codecs/da732x.c b/sound/soc/codecs/da732x.c
> index b1cb465..29251b0 100644
> --- a/sound/soc/codecs/da732x.c
> +++ b/sound/soc/codecs/da732x.c
> @@ -1196,13 +1196,7 @@ static int da732x_set_dai_sysclk(struct snd_soc_dai *dai,
> int clk_id,
>  #define	DA732X_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |
> SNDRV_PCM_FMTBIT_S20_3LE | \
>  			SNDRV_PCM_FMTBIT_S24_LE |
> SNDRV_PCM_FMTBIT_S32_LE)
> 
> -static struct snd_soc_dai_ops da732x_dai1_ops = {
> -	.hw_params	= da732x_hw_params,
> -	.set_fmt	= da732x_set_dai_fmt,
> -	.set_sysclk	= da732x_set_dai_sysclk,
> -};
> -
> -static struct snd_soc_dai_ops da732x_dai2_ops = {
> +static const struct snd_soc_dai_ops da732x_dai_ops = {
>  	.hw_params	= da732x_hw_params,
>  	.set_fmt	= da732x_set_dai_fmt,
>  	.set_sysclk	= da732x_set_dai_sysclk,
> @@ -1227,7 +1221,7 @@ static struct snd_soc_dai_driver da732x_dai[] = {
>  			.rates = DA732X_RATES,
>  			.formats = DA732X_FORMATS,
>  		},
> -		.ops = &da732x_dai1_ops,
> +		.ops = &da732x_dai_ops,
>  	},
>  	{
>  		.name	= "DA732X_AIFB",
> @@ -1247,7 +1241,7 @@ static struct snd_soc_dai_driver da732x_dai[] = {
>  			.rates = DA732X_RATES,
>  			.formats = DA732X_FORMATS,
>  		},
> -		.ops = &da732x_dai2_ops,
> +		.ops = &da732x_dai_ops,
>  	},
>  };
> 
> --
> 2.1.0
> 
> 

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
