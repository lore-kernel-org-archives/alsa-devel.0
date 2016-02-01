From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8825: reduce stanby power
	consumption
Date: Mon, 1 Feb 2016 16:40:18 +0800
Message-ID: <56AF19F2.8060809@nuvoton.com>
References: <1452873193-20650-1-git-send-email-KCHSU0@nuvoton.com>
 <444cc90056564b91a8781143bbba0fce@NTHCML01B.nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EBA10260523
 for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2016 09:40:38 +0100 (CET)
In-Reply-To: <444cc90056564b91a8781143bbba0fce@NTHCML01B.nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Anatol Pomozov <anatol.pomozov@gmail.com>, AC30 YHChuang <YHCHuang@nuvoton.com>, Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>, AC30 CTLIN0 <CTLIN0@nuvoton.com>, MS40 MHKuo <MHKuo@nuvoton.com>, Yong Zhi <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,
This power patch modifies some widgets to fix power saving issue when 
standby.
But we want to submit a depop patch to fine tune widgets and  fix the 
pop noise now.
It has overlap with the power patch. Can we make the depop patch based 
on the power patch?
Could you give us advice how to make submit patch in this case? Thank 
you very much.

BR.
John

On 1/15/2016 11:53 PM, AC30 KCHsu0 wrote:
> Fix unnecessary widget power up when standby; And decrease internal clock frequency to save power.
>
> Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
> ---
>  sound/soc/codecs/nau8825.c | 49 +++++++++++++++++++++++++++++++++-------------
>  1 file changed, 35 insertions(+), 14 deletions(-)
>
> diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c index 52882e4..f9752cc 100644
> --- a/sound/soc/codecs/nau8825.c
> +++ b/sound/soc/codecs/nau8825.c
> @@ -262,6 +262,29 @@ static int nau8825_playback_event(struct snd_soc_dapm_widget *w,
>  	return 0;
>  }
>  
> +static int nau8825_dacr_event(struct snd_soc_dapm_widget *w,
> +		struct snd_kcontrol *kcontrol, int event) {
> +	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
> +	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_POST_PMU:
> +		regmap_update_bits(nau8825->regmap, NAU8825_REG_ENA_CTRL,
> +			NAU8825_ENABLE_DACR, NAU8825_ENABLE_DACR);
> +		break;
> +	case SND_SOC_DAPM_POST_PMD:
> +		if (!nau8825->irq)
> +			regmap_update_bits(nau8825->regmap,
> +			NAU8825_REG_ENA_CTRL, NAU8825_ENABLE_DACR, 0);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  
>  static const char * const nau8825_adc_decimation[] = {
>  	"32", "64", "128", "256"
> @@ -337,16 +360,17 @@ static const struct snd_soc_dapm_widget nau8825_dapm_widgets[] = {
>  		0),
>  
>  	/* ADC for button press detection */
> -	SND_SOC_DAPM_ADC("SAR", NULL, NAU8825_REG_SAR_CTRL,
> -		NAU8825_SAR_ADC_EN_SFT, 0),
> +	SND_SOC_DAPM_SUPPLY("SAR", NAU8825_REG_SAR_CTRL,
> +		NAU8825_SAR_ADC_EN_SFT, 0, NULL, 0),
>  
>  	SND_SOC_DAPM_DAC("ADACL", NULL, NAU8825_REG_RDAC, 12, 0),
>  	SND_SOC_DAPM_DAC("ADACR", NULL, NAU8825_REG_RDAC, 13, 0),
>  	SND_SOC_DAPM_SUPPLY("ADACL Clock", NAU8825_REG_RDAC, 8, 0, NULL, 0),
>  	SND_SOC_DAPM_SUPPLY("ADACR Clock", NAU8825_REG_RDAC, 9, 0, NULL, 0),
>  
> -	SND_SOC_DAPM_DAC("DDACR", NULL, NAU8825_REG_ENA_CTRL,
> -		NAU8825_ENABLE_DACR_SFT, 0),
> +	SND_SOC_DAPM_DAC_E("DDACR", NULL, SND_SOC_NOPM, 0, 0,
> +		nau8825_dacr_event, SND_SOC_DAPM_POST_PMU |
> +		SND_SOC_DAPM_POST_PMD),
>  	SND_SOC_DAPM_DAC("DDACL", NULL, NAU8825_REG_ENA_CTRL,
>  		NAU8825_ENABLE_DACL_SFT, 0),
>  	SND_SOC_DAPM_SUPPLY("DDAC Clock", NAU8825_REG_ENA_CTRL, 6, 0, NULL, 0), @@ -878,13 +902,6 @@ static int nau8825_codec_probe(struct snd_soc_codec *codec)
>  
>  	nau8825->dapm = dapm;
>  
> -	/* The interrupt clock is gated by x1[10:8],
> -	 * one of them needs to be enabled all the time for
> -	 * interrupts to happen.
> -	 */
> -	snd_soc_dapm_force_enable_pin(dapm, "DDACR");
> -	snd_soc_dapm_sync(dapm);
> -
>  	/* Unmask interruptions. Handler uses dapm object so we can enable
>  	 * interruptions only after dapm is fully initialized.
>  	 */
> @@ -1075,6 +1092,12 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
>  			NAU8825_DCO_EN);
>  		regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
>  			NAU8825_CLK_SRC_MASK, NAU8825_CLK_SRC_VCO);
> +		regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
> +			NAU8825_CLK_MCLK_SRC_MASK, 0xf);
> +		regmap_update_bits(regmap, NAU8825_REG_FLL1,
> +			NAU8825_FLL_RATIO_MASK, 0x10);
> +		regmap_update_bits(regmap, NAU8825_REG_FLL6,
> +			NAU8825_SDM_EN, NAU8825_SDM_EN);
>  		if (nau8825->mclk_freq) {
>  			clk_disable_unprepare(nau8825->mclk);
>  			nau8825->mclk_freq = 0;
> @@ -1309,9 +1332,7 @@ static int nau8825_setup_irq(struct nau8825 *nau8825)
>  	/* Enable internal VCO needed for interruptions */
>  	nau8825_configure_sysclk(nau8825, NAU8825_CLK_INTERNAL, 0);
>  
> -	/* Enable DDACR needed for interrupts
> -	 * It is the same as force_enable_pin("DDACR") we do later
> -	 */
> +	/* Enable DDACR needed for interrupts */
>  	regmap_update_bits(regmap, NAU8825_REG_ENA_CTRL,
>  		NAU8825_ENABLE_DACR, NAU8825_ENABLE_DACR);
>  
> --
> 2.6.4
>
> .
>
>   
