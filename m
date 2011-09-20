From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Refcount WM8996 bandgap from FLL too
Date: Tue, 20 Sep 2011 12:19:59 +0100
Message-ID: <1316517599.8314.1.camel@odin>
References: <1316454992-9878-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog101.obsmtp.com (na3sys009aog101.obsmtp.com
	[74.125.149.67])
	by alsa0.perex.cz (Postfix) with ESMTP id B17A41039F0
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 13:20:05 +0200 (CEST)
Received: by wwn22 with SMTP id 22so4308590wwn.5
	for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2011 04:20:03 -0700 (PDT)
In-Reply-To: <1316454992-9878-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-09-19 at 18:56 +0100, Mark Brown wrote:
> For digital only paths we need to make sure the bandgap is enabled prior
> to starting the FLL which isn't tied into DAPM.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8996.c |   46 +++++++++++++++++++++++++++++++++++++++-----
>  1 files changed, 40 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
> index c587b4d..071dda0 100644
> --- a/sound/soc/codecs/wm8996.c
> +++ b/sound/soc/codecs/wm8996.c
> @@ -72,6 +72,7 @@ struct wm8996_priv {
>  	struct regulator_bulk_data supplies[WM8996_NUM_SUPPLIES];
>  	struct notifier_block disable_nb[WM8996_NUM_SUPPLIES];
>  	struct regulator *cpvdd;
> +	int bg_ena;
>  
>  	struct wm8996_pdata pdata;
>  
> @@ -667,14 +668,40 @@ SOC_SINGLE_TLV("DSP2 EQ B5 Volume", WM8996_DSP2_RX_EQ_GAINS_2, 6, 31, 0,
>  	       eq_tlv),
>  };
>  
> +static void wm8996_bg_enable(struct snd_soc_codec *codec)
> +{
> +	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
> +
> +	wm8996->bg_ena++;
> +	if (wm8996->bg_ena == 1) {
> +		snd_soc_update_bits(codec, WM8996_POWER_MANAGEMENT_1,
> +				    WM8996_BG_ENA, WM8996_BG_ENA);
> +		msleep(2);
> +	}
> +}
> +
> +static void wm8996_bg_disable(struct snd_soc_codec *codec)
> +{
> +	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
> +
> +	wm8996->bg_ena--;
> +	if (!wm8996->bg_ena)
> +		snd_soc_update_bits(codec, WM8996_POWER_MANAGEMENT_1,
> +				    WM8996_BG_ENA, 0);
> +}
> +
>  static int bg_event(struct snd_soc_dapm_widget *w,
>  		    struct snd_kcontrol *kcontrol, int event)
>  {
> +	struct snd_soc_codec *codec = w->codec;
>  	int ret = 0;
>  
>  	switch (event) {
> -	case SND_SOC_DAPM_POST_PMU:
> -		msleep(2);
> +	case SND_SOC_DAPM_PRE_PMU:
> +		wm8996_bg_enable(codec);
> +		break;
> +	case SND_SOC_DAPM_POST_PMD:
> +		wm8996_bg_disable(codec);
>  		break;
>  	default:
>  		BUG();
> @@ -1015,10 +1042,10 @@ SND_SOC_DAPM_SUPPLY_S("SYSCLK", 1, WM8996_AIF_CLOCKING_1, 0, 0, NULL, 0),
>  SND_SOC_DAPM_SUPPLY_S("SYSDSPCLK", 2, WM8996_CLOCKING_1, 1, 0, NULL, 0),
>  SND_SOC_DAPM_SUPPLY_S("AIFCLK", 2, WM8996_CLOCKING_1, 2, 0, NULL, 0),
>  SND_SOC_DAPM_SUPPLY_S("Charge Pump", 2, WM8996_CHARGE_PUMP_1, 15, 0, cp_event,
> -		      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
> -		      SND_SOC_DAPM_POST_PMD),
> -SND_SOC_DAPM_SUPPLY("Bandgap", WM8996_POWER_MANAGEMENT_1, WM8996_BG_ENA_SHIFT,
> -		    0, bg_event, SND_SOC_DAPM_POST_PMU),
> +		      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
> +SND_SOC_DAPM_SUPPLY("Bandgap", SND_SOC_NOPM, 0, 0, bg_event,
> +		    SND_SOC_DAPM_POST_PMU |
> +		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
>  SND_SOC_DAPM_SUPPLY("LDO2", WM8996_POWER_MANAGEMENT_2, 1, 0, NULL, 0),
>  SND_SOC_DAPM_SUPPLY("MICB1 Audio", WM8996_MICBIAS_1, 4, 1, NULL, 0),
>  SND_SOC_DAPM_SUPPLY("MICB2 Audio", WM8996_MICBIAS_2, 4, 1, NULL, 0),
> @@ -2095,6 +2122,8 @@ static int wm8996_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
>  		snd_soc_update_bits(codec, WM8996_FLL_CONTROL_1,
>  				    WM8996_FLL_ENA, 0);
>  
> +		wm8996_bg_disable(codec);
> +
>  		return 0;
>  	}
>  
> @@ -2149,6 +2178,11 @@ static int wm8996_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
>  
>  	snd_soc_write(codec, WM8996_FLL_EFS_1, fll_div.lambda);
>  
> +	/* Enable the bandgap if it's not already enabled */
> +	ret = snd_soc_read(codec, WM8996_FLL_CONTROL_1);
> +	if (!(ret & WM8996_FLL_ENA))
> +		wm8996_bg_enable(codec);
> +
>  	/* Clear any pending completions (eg, from failed startups) */
>  	try_wait_for_completion(&wm8996->fll_lock);
>  

Acked-by: Liam Girdwood <lrg@ti.com>
