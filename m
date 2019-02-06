From: Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH v3 2/2] ASoC: ssm2602: Fix ADC powerup
	sequencing
Date: Wed, 6 Feb 2019 18:03:12 +0100
Message-ID: <20190206170312.c23jegj4z2ekcej6@pengutronix.de>
References: <20190206170004.11550-1-m.felsch@pengutronix.de>
 <20190206170004.11550-2-m.felsch@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [85.220.165.71])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F8CF26792A
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2019 18:03:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20190206170004.11550-2-m.felsch@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org


Hi Mark,

sorry didn't got your 'Applied mail' in time. Please drop this patch.

Thanks,
Marco

On 19-02-06 18:00, Marco Felsch wrote:
> From: Philipp Zabel <p.zabel@pengutronix.de>
> 
> According to the ssm2603 data sheet (control register sequencing), the
> digital core should be activated only after all necessary bits in the
> power register are enabled, and a delay determined by the decoupling
> capacitor on the VMID pin has passed. If the digital core is activated
> too early, or even before the ADC is powered up, audible artifacts
> appear at the beginning of the recorded signal.
> 
> The digital core is also needed for playback, so when recording starts
> it may already be enabled. This means we cannot get the power sequence
> correct when we want to be able to start recording after playback.
> 
> As a workaround put the MIC mute switch into the DAPM routes. This
> way we can keep the recording disabled until the MIC Bias has settled
> and thus get rid of audible artifacts.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> [m.felsch@pengutronix.de: adapt commit message]
> [m.felsch@pengutronix.de: drop of configuration as mentioned by Mark:
> 			  https://patchwork.kernel.org/patch/10407449/]
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> Changelog:
> v3:
>  - no changes
> v2:
>  - drop OF timeout configuration
>  - adapt commit message
> 
>  sound/soc/codecs/ssm2602.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
> index 30b6d30e8e7c..464a4d7873bb 100644
> --- a/sound/soc/codecs/ssm2602.c
> +++ b/sound/soc/codecs/ssm2602.c
> @@ -11,6 +11,7 @@
>  //
>  // Bugs:         Enter bugs at http://blackfin.uclinux.org/
>  
> +#include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> @@ -96,7 +97,6 @@ SOC_SINGLE_TLV("Sidetone Playback Volume", SSM2602_APANA, 6, 3, 1,
>  
>  SOC_SINGLE("Mic Boost (+20dB)", SSM2602_APANA, 0, 1, 0),
>  SOC_SINGLE("Mic Boost2 (+20dB)", SSM2602_APANA, 8, 1, 0),
> -SOC_SINGLE("Mic Switch", SSM2602_APANA, 1, 1, 1),
>  };
>  
>  /* Output Mixer */
> @@ -106,10 +106,31 @@ SOC_DAPM_SINGLE("HiFi Playback Switch", SSM2602_APANA, 4, 1, 0),
>  SOC_DAPM_SINGLE("Mic Sidetone Switch", SSM2602_APANA, 5, 1, 0),
>  };
>  
> +static const struct snd_kcontrol_new mic_ctl =
> +	SOC_DAPM_SINGLE("Switch", SSM2602_APANA, 1, 1, 1);
> +
>  /* Input mux */
>  static const struct snd_kcontrol_new ssm2602_input_mux_controls =
>  SOC_DAPM_ENUM("Input Select", ssm2602_enum[0]);
>  
> +static int ssm2602_mic_switch_event(struct snd_soc_dapm_widget *w,
> +				struct snd_kcontrol *kcontrol, int event)
> +{
> +	/*
> +	 * According to the ssm2603 data sheet (control register sequencing),
> +	 * the digital core should be activated only after all necessary bits
> +	 * in the power register are enabled, and a delay determined by the
> +	 * decoupling capacitor on the VMID pin has passed. If the digital core
> +	 * is activated too early, or even before the ADC is powered up, audible
> +	 * artifacts appear at the beginning and end of the recorded signal.
> +	 *
> +	 * In practice, audible artifacts disappear well over 500 ms.
> +	 */
> +	msleep(500);
> +
> +	return 0;
> +}
> +
>  static const struct snd_soc_dapm_widget ssm260x_dapm_widgets[] = {
>  SND_SOC_DAPM_DAC("DAC", "HiFi Playback", SSM2602_PWR, 3, 1),
>  SND_SOC_DAPM_ADC("ADC", "HiFi Capture", SSM2602_PWR, 2, 1),
> @@ -131,6 +152,9 @@ SND_SOC_DAPM_MIXER("Output Mixer", SSM2602_PWR, 4, 1,
>  SND_SOC_DAPM_MUX("Input Mux", SND_SOC_NOPM, 0, 0, &ssm2602_input_mux_controls),
>  SND_SOC_DAPM_MICBIAS("Mic Bias", SSM2602_PWR, 1, 1),
>  
> +SND_SOC_DAPM_SWITCH_E("Mic Switch", SSM2602_APANA, 1, 1, &mic_ctl,
> +		ssm2602_mic_switch_event, SND_SOC_DAPM_PRE_PMU),
> +
>  SND_SOC_DAPM_OUTPUT("LHPOUT"),
>  SND_SOC_DAPM_OUTPUT("RHPOUT"),
>  SND_SOC_DAPM_INPUT("MICIN"),
> @@ -163,9 +187,11 @@ static const struct snd_soc_dapm_route ssm2602_routes[] = {
>  	{"LHPOUT", NULL, "Output Mixer"},
>  
>  	{"Input Mux", "Line", "Line Input"},
> -	{"Input Mux", "Mic", "Mic Bias"},
> +	{"Input Mux", "Mic", "Mic Switch"},
>  	{"ADC", NULL, "Input Mux"},
>  
> +	{"Mic Switch", NULL, "Mic Bias"},
> +
>  	{"Mic Bias", NULL, "MICIN"},
>  };
>  
> -- 
> 2.20.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
