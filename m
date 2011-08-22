From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Automatically manage WM8996 MICBIAS
 regulating mode
Date: Mon, 22 Aug 2011 11:21:55 +0100
Message-ID: <4E522DC3.4070808@ti.com>
References: <1313863513-31075-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 27AD01038A7
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 12:22:01 +0200 (CEST)
In-Reply-To: <1313863513-31075-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 20/08/11 19:05, Mark Brown wrote:
> For non-audio uses like accessory detection we can use a lower quality,
> unregulated microphone bias, saving a little power. As the hardware can
> manually enable and disable the biases we can select regulating mode
> automatically with supply widgets connected to the biases.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8996.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
> index 0936ae5..d3277d1 100644
> --- a/sound/soc/codecs/wm8996.c
> +++ b/sound/soc/codecs/wm8996.c
> @@ -982,6 +982,8 @@ SND_SOC_DAPM_SUPPLY_S("Charge Pump", 2, WM8996_CHARGE_PUMP_1, 15, 0, cp_event,
>  		      SND_SOC_DAPM_POST_PMU),
>  
>  SND_SOC_DAPM_SUPPLY("LDO2", WM8996_POWER_MANAGEMENT_2, 1, 0, NULL, 0),
> +SND_SOC_DAPM_SUPPLY("MICB1 Audio", WM8996_MICBIAS_1, 4, 1, NULL, 0),
> +SND_SOC_DAPM_SUPPLY("MICB2 Audio", WM8996_MICBIAS_2, 4, 1, NULL, 0),
>  SND_SOC_DAPM_MICBIAS("MICB2", WM8996_POWER_MANAGEMENT_1, 9, 0),
>  SND_SOC_DAPM_MICBIAS("MICB1", WM8996_POWER_MANAGEMENT_1, 8, 0),
>  
> @@ -1137,7 +1139,9 @@ static const struct snd_soc_dapm_route wm8996_dapm_routes[] = {
>  	{ "Charge Pump", NULL, "SYSCLK" },
>  
>  	{ "MICB1", NULL, "LDO2" },
> +	{ "MICB1", NULL, "MICB1 Audio" },
>  	{ "MICB2", NULL, "LDO2" },
> +	{ "MICB2", NULL, "MICB2 Audio" },
>  
>  	{ "IN1L PGA", NULL, "IN2LN" },
>  	{ "IN1L PGA", NULL, "IN2LP" },

Acked-by: Liam Girdwood <lrg@ti.com>
