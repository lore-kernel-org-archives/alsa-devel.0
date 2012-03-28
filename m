From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: Re: [PATCH] ASoC: sgtl5000: fix power on/off of MIC
 bias
Date: Wed, 28 Mar 2012 17:58:58 +0800
Message-ID: <20120328095857.GA29787@shlinux2.ap.freescale.net>
References: <1332919833-9641-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
	by alsa0.perex.cz (Postfix) with ESMTP id B261D243F6
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Mar 2012 11:47:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1332919833-9641-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Zeng@alsa-project.org, alsa-devel@alsa-project.org, Lionel Xu <Lionel.Xu@freescale.com>, Brown <broonie@opensource.wolfsonmicro.com>, Mark@alsa-project.org, Zhaoming <zengzm.kernel@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 28, 2012 at 03:30:33PM +0800, Shawn Guo wrote:
> From: Lionel Xu <Lionel.Xu@freescale.com>
> 
> There is no sound in the recorded wav, to enable recording, the VAG
> should be powered up, and the mic bias resistor should be set up with
> proper value.
> 
> Signed-off-by: Lionel Xu <lionel.xu@freescale.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Zeng Zhaoming <zengzm.kernel@gmail.com>
> ---
>  sound/soc/codecs/sgtl5000.c |   14 +++++++++++---
>  1 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
> index d192626..a24299c 100644
> --- a/sound/soc/codecs/sgtl5000.c
> +++ b/sound/soc/codecs/sgtl5000.c
> @@ -132,11 +132,18 @@ static int mic_bias_event(struct snd_soc_dapm_widget *w,
>  		snd_soc_update_bits(w->codec, SGTL5000_CHIP_MIC_CTRL,
>  				SGTL5000_BIAS_R_MASK,
>  				SGTL5000_BIAS_R_4k << SGTL5000_BIAS_R_SHIFT);
> +
> +		snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
> +				SGTL5000_VAG_POWERUP, SGTL5000_VAG_POWERUP);
Only enable SGTL5000_VAG_POWERUP for mic bias_event may not be sufficient.
IIRC for line-in record, we also need to enable VAG_POWER.
Will verify it later when i'm free.

Regards
Dong Aisheng
>  		break;
>  
>  	case SND_SOC_DAPM_PRE_PMD:
>  		snd_soc_update_bits(w->codec, SGTL5000_CHIP_MIC_CTRL,
> -				SGTL5000_BIAS_R_MASK, 0);
> +				SGTL5000_BIAS_R_MASK,
> +				SGTL5000_BIAS_R_off << SGTL5000_BIAS_R_SHIFT);
> +
> +		snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
> +				SGTL5000_VAG_POWERUP, 0);
>  		break;
>  	}
>  	return 0;
> @@ -197,7 +204,7 @@ static const struct snd_soc_dapm_widget sgtl5000_dapm_widgets[] = {
>  	SND_SOC_DAPM_OUTPUT("HP_OUT"),
>  	SND_SOC_DAPM_OUTPUT("LINE_OUT"),
>  
> -	SND_SOC_DAPM_MICBIAS_E("Mic Bias", SGTL5000_CHIP_MIC_CTRL, 8, 0,
> +	SND_SOC_DAPM_MICBIAS_E("Mic Bias", SND_SOC_NOPM, 0, 0,
>  				mic_bias_event,
>  				SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
>  
> @@ -229,7 +236,8 @@ static const struct snd_soc_dapm_widget sgtl5000_dapm_widgets[] = {
>  /* routes for sgtl5000 */
>  static const struct snd_soc_dapm_route sgtl5000_dapm_routes[] = {
>  	{"Capture Mux", "LINE_IN", "LINE_IN"},	/* line_in --> adc_mux */
> -	{"Capture Mux", "MIC_IN", "MIC_IN"},	/* mic_in --> adc_mux */
> +	{"Mic Bias", NULL, "MIC_IN"},		/* mic_in --> mic bias */
> +	{"Capture Mux", "MIC_IN", "Mic Bias"},	/* mic bias --> adc_mux */
>  
>  	{"ADC", NULL, "Capture Mux"},		/* adc_mux --> adc */
>  	{"AIFOUT", NULL, "ADC"},		/* adc --> i2s_out */
> -- 
> 1.7.4.1
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
