From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH 06/11] ASoC: tlv320aix31xx: Cleanup manual
 bias level transitions
Date: Thu, 27 Nov 2014 10:30:23 +0200
Message-ID: <5476E11F.5050601@ti.com>
References: <1417031880-11364-1-git-send-email-lars@metafoo.de>
 <1417031880-11364-6-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 69D19265966
 for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2014 09:30:27 +0100 (CET)
In-Reply-To: <1417031880-11364-6-git-send-email-lars@metafoo.de>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/26/2014 09:57 PM, Lars-Peter Clausen wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner.
>
> Since the ASoC core now takes care of setting the bias level to
> SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
> anymore either.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Jyri Sarha <jsarha@ti.com>

> ---
>   sound/soc/codecs/tlv320aic31xx.c | 18 ++----------------
>   1 file changed, 2 insertions(+), 16 deletions(-)
>
> diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
> index 93de5dd..dc3223d 100644
> --- a/sound/soc/codecs/tlv320aic31xx.c
> +++ b/sound/soc/codecs/tlv320aic31xx.c
> @@ -1057,18 +1057,6 @@ static int aic31xx_set_bias_level(struct snd_soc_codec *codec,
>   	return 0;
>   }
>
> -static int aic31xx_suspend(struct snd_soc_codec *codec)
> -{
> -	aic31xx_set_bias_level(codec, SND_SOC_BIAS_OFF);
> -	return 0;
> -}
> -
> -static int aic31xx_resume(struct snd_soc_codec *codec)
> -{
> -	aic31xx_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> -	return 0;
> -}
> -
>   static int aic31xx_codec_probe(struct snd_soc_codec *codec)
>   {
>   	int ret = 0;
> @@ -1111,8 +1099,6 @@ static int aic31xx_codec_remove(struct snd_soc_codec *codec)
>   {
>   	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
>   	int i;
> -	/* power down chip */
> -	aic31xx_set_bias_level(codec, SND_SOC_BIAS_OFF);
>
>   	for (i = 0; i < ARRAY_SIZE(aic31xx->supplies); i++)
>   		regulator_unregister_notifier(aic31xx->supplies[i].consumer,
> @@ -1124,9 +1110,9 @@ static int aic31xx_codec_remove(struct snd_soc_codec *codec)
>   static struct snd_soc_codec_driver soc_codec_driver_aic31xx = {
>   	.probe			= aic31xx_codec_probe,
>   	.remove			= aic31xx_codec_remove,
> -	.suspend		= aic31xx_suspend,
> -	.resume			= aic31xx_resume,
>   	.set_bias_level		= aic31xx_set_bias_level,
> +	.suspend_bias_off	= true,
> +
>   	.controls		= aic31xx_snd_controls,
>   	.num_controls		= ARRAY_SIZE(aic31xx_snd_controls),
>   	.dapm_widgets		= aic31xx_dapm_widgets,
>
