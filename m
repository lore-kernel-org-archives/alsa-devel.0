From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: Re: [PATCH 1/2] ASoC: sgtl5000: Convert mic bias to a
 supply widget
Date: Thu, 29 Mar 2012 11:40:46 +0800
Message-ID: <20120329034045.GB29787@shlinux2.ap.freescale.net>
References: <1332964426-8480-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
	(am1ehsobe005.messaging.microsoft.com [213.199.154.208])
	by alsa0.perex.cz (Postfix) with ESMTP id AC18D24352
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 05:29:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1332964426-8480-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Liam@alsa-project.org, Zeng Zhaoming <zengzm.kernel@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 28, 2012 at 08:53:45PM +0100, Mark Brown wrote:
> No current users and it's the last user of MICBIAS_E().
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/sgtl5000.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
> index d192626..77beb6d 100644
> --- a/sound/soc/codecs/sgtl5000.c
> +++ b/sound/soc/codecs/sgtl5000.c
> @@ -197,9 +197,9 @@ static const struct snd_soc_dapm_widget sgtl5000_dapm_widgets[] = {
>  	SND_SOC_DAPM_OUTPUT("HP_OUT"),
>  	SND_SOC_DAPM_OUTPUT("LINE_OUT"),
>  
> -	SND_SOC_DAPM_MICBIAS_E("Mic Bias", SGTL5000_CHIP_MIC_CTRL, 8, 0,
> -				mic_bias_event,
> -				SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
> +	SND_SOC_DAPM_SUPPLY("Mic Bias", SGTL5000_CHIP_MIC_CTRL, 8, 0,
> +			    mic_bias_event,
> +			    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
>  
>  	SND_SOC_DAPM_PGA_E("HP", SGTL5000_CHIP_ANA_POWER, 4, 0, NULL, 0,
>  			small_pop_event,
> -- 
> 1.7.9.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Regards
Dong Aisheng
