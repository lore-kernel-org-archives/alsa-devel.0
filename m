From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH 2/2] ASoC: DA7219: Implement error check on
 reg read and write
Date: Tue, 4 Dec 2018 21:16:05 +0000
Message-ID: <AM5PR1001MB099412DDC3B33069BCFDC38B80AF0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <1543948103-20752-1-git-send-email-akshu.agrawal@amd.com>
 <1543948103-20752-2-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta25.messagelabs.com (mail1.bemta25.messagelabs.com
 [195.245.230.68])
 by alsa0.perex.cz (Postfix) with ESMTP id D9D6A267B4E
 for <alsa-devel@alsa-project.org>; Tue,  4 Dec 2018 22:16:12 +0100 (CET)
In-Reply-To: <1543948103-20752-2-git-send-email-akshu.agrawal@amd.com>
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
To: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER
 MANAGEM..." <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, "djkurtz@chromium.org" <djkurtz@chromium.org>, Mark Brown <broonie@kernel.org>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
List-Id: alsa-devel@alsa-project.org

On 04 December 2018 18:36, Akshu Agrawal wrote:

> Failed i2c transaction can lead to failure in reg read or write.
> Need to have error check for each read write operation.
>

I'm not really clear what this gains you. If I2C is broken this won't solve
anything, and you have far deeper problems. Seems to me like a lot of code which
adds almost nothing.
 
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> ---
>  sound/soc/codecs/da7219.c | 323 +++++++++++++++++++++++++++++++++++-
> ----------
>  sound/soc/codecs/da7219.h |   2 +-
>  2 files changed, 247 insertions(+), 78 deletions(-)
> 
> diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c index
> e46e9f4..6757129 100644
> --- a/sound/soc/codecs/da7219.c
> +++ b/sound/soc/codecs/da7219.c
> @@ -312,69 +312,103 @@ static int da7219_enum_locked_put(struct
> snd_kcontrol *kcontrol,  }
> 
>  /* ALC */
> -static void da7219_alc_calib(struct snd_soc_component *component)
> +static int da7219_alc_calib(struct snd_soc_component *component)
>  {
> -	u8 mic_ctrl, mixin_ctrl, adc_ctrl, calib_ctrl;
> +	int mic_ctrl, mixin_ctrl, adc_ctrl, calib_ctrl;
> +	int ret;
> 
>  	/* Save current state of mic control register */
>  	mic_ctrl = snd_soc_component_read32(component,
> DA7219_MIC_1_CTRL);
> +	if (mic_ctrl < 0)
> +		return mic_ctrl;
> 
>  	/* Save current state of input mixer control register */
>  	mixin_ctrl = snd_soc_component_read32(component,
> DA7219_MIXIN_L_CTRL);
> +	if (mixin_ctrl < 0)
> +		return mixin_ctrl;
> 
>  	/* Save current state of input ADC control register */
>  	adc_ctrl = snd_soc_component_read32(component,
> DA7219_ADC_L_CTRL);
> +	if (adc_ctrl < 0)
> +		return adc_ctrl;
> 
>  	/* Enable then Mute MIC PGAs */
> -	snd_soc_component_update_bits(component, DA7219_MIC_1_CTRL,
> DA7219_MIC_1_AMP_EN_MASK,
> +	ret = snd_soc_component_update_bits(component,
> DA7219_MIC_1_CTRL,
> +			    DA7219_MIC_1_AMP_EN_MASK,
>  			    DA7219_MIC_1_AMP_EN_MASK);
> -	snd_soc_component_update_bits(component, DA7219_MIC_1_CTRL,
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = snd_soc_component_update_bits(component,
> DA7219_MIC_1_CTRL,
>  			    DA7219_MIC_1_AMP_MUTE_EN_MASK,
>  			    DA7219_MIC_1_AMP_MUTE_EN_MASK);
> +	if (ret < 0)
> +		return ret;
> 
>  	/* Enable input mixers unmuted */
> -	snd_soc_component_update_bits(component, DA7219_MIXIN_L_CTRL,
> +	ret = snd_soc_component_update_bits(component,
> DA7219_MIXIN_L_CTRL,
>  			    DA7219_MIXIN_L_AMP_EN_MASK |
>  			    DA7219_MIXIN_L_AMP_MUTE_EN_MASK,
>  			    DA7219_MIXIN_L_AMP_EN_MASK);
> +	if (ret < 0)
> +		return ret;
> 
>  	/* Enable input filters unmuted */
> -	snd_soc_component_update_bits(component, DA7219_ADC_L_CTRL,
> +	ret = snd_soc_component_update_bits(component,
> DA7219_ADC_L_CTRL,
>  			    DA7219_ADC_L_MUTE_EN_MASK |
> DA7219_ADC_L_EN_MASK,
>  			    DA7219_ADC_L_EN_MASK);
> +	if (ret < 0)
> +		return ret;
> 
>  	/* Perform auto calibration */
> -	snd_soc_component_update_bits(component, DA7219_ALC_CTRL1,
> +	ret = snd_soc_component_update_bits(component,
> DA7219_ALC_CTRL1,
>  			    DA7219_ALC_AUTO_CALIB_EN_MASK,
>  			    DA7219_ALC_AUTO_CALIB_EN_MASK);
> +	if (ret < 0)
> +		return ret;
>  	do {
>  		calib_ctrl = snd_soc_component_read32(component,
> DA7219_ALC_CTRL1);
> +		if (calib_ctrl < 0)
> +			return calib_ctrl;
>  	} while (calib_ctrl & DA7219_ALC_AUTO_CALIB_EN_MASK);
> 
>  	/* If auto calibration fails, disable DC offset, hybrid ALC */
>  	if (calib_ctrl & DA7219_ALC_CALIB_OVERFLOW_MASK) {
>  		dev_warn(component->dev,
>  			 "ALC auto calibration failed with overflow\n");
> -		snd_soc_component_update_bits(component,
> DA7219_ALC_CTRL1,
> +		ret = snd_soc_component_update_bits(component,
> DA7219_ALC_CTRL1,
>  				    DA7219_ALC_OFFSET_EN_MASK |
>  				    DA7219_ALC_SYNC_MODE_MASK, 0);
> +		if (ret < 0)
> +			return ret;
>  	} else {
>  		/* Enable DC offset cancellation, hybrid mode */
> -		snd_soc_component_update_bits(component,
> DA7219_ALC_CTRL1,
> +		ret = snd_soc_component_update_bits(component,
> DA7219_ALC_CTRL1,
>  				    DA7219_ALC_OFFSET_EN_MASK |
>  				    DA7219_ALC_SYNC_MODE_MASK,
>  				    DA7219_ALC_OFFSET_EN_MASK |
>  				    DA7219_ALC_SYNC_MODE_MASK);
> +		if (ret < 0)
> +			return ret;
>  	}
> 
>  	/* Restore input filter control register to original state */
> -	snd_soc_component_write(component, DA7219_ADC_L_CTRL, adc_ctrl);
> +	ret = snd_soc_component_write(component, DA7219_ADC_L_CTRL,
> adc_ctrl);
> +	if (ret < 0)
> +		return ret;
> 
>  	/* Restore input mixer control registers to original state */
> -	snd_soc_component_write(component, DA7219_MIXIN_L_CTRL,
> mixin_ctrl);
> +	ret = snd_soc_component_write(component, DA7219_MIXIN_L_CTRL,
> +				mixin_ctrl);
> +	if (ret < 0)
> +		return ret;
> 
>  	/* Restore MIC control registers to original states */
> -	snd_soc_component_write(component, DA7219_MIC_1_CTRL, mic_ctrl);
> +	ret = snd_soc_component_write(component, DA7219_MIC_1_CTRL,
> mic_ctrl);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
>  }
> 
>  static int da7219_mixin_gain_put(struct snd_kcontrol *kcontrol, @@ -391,7
> +425,7 @@ static int da7219_mixin_gain_put(struct snd_kcontrol *kcontrol,
>  	 * make sure calibrated offsets are updated.
>  	 */
>  	if ((ret == 1) && (da7219->alc_en))
> -		da7219_alc_calib(component);
> +		ret = da7219_alc_calib(component);
> 
>  	return ret;
>  }
> @@ -401,11 +435,14 @@ static int da7219_alc_sw_put(struct snd_kcontrol
> *kcontrol,  {
>  	struct snd_soc_component *component =
> snd_soc_kcontrol_component(kcontrol);
>  	struct da7219_priv *da7219 =
> snd_soc_component_get_drvdata(component);
> +	int ret;
> 
> 
>  	/* Force ALC offset calibration if enabling ALC */
>  	if ((ucontrol->value.integer.value[0]) && (!da7219->alc_en)) {
> -		da7219_alc_calib(component);
> +		ret = da7219_alc_calib(component);
> +		if (ret < 0)
> +			return ret;
>  		da7219->alc_en = true;
>  	} else {
>  		da7219->alc_en = false;
> @@ -813,16 +850,20 @@ static int da7219_dai_event(struct
> snd_soc_dapm_widget *w,
>  					return ret;
>  				}
>  			} else {
> -				snd_soc_component_update_bits(component,
> +				ret =
> snd_soc_component_update_bits(component,
> 
> DA7219_DAI_CLK_MODE,
> 
> DA7219_DAI_CLK_EN_MASK,
> 
> DA7219_DAI_CLK_EN_MASK);
> +				if (ret < 0)
> +					return ret;
>  			}
>  		}
> 
>  		/* PC synchronised to DAI */
> -		snd_soc_component_update_bits(component,
> DA7219_PC_COUNT,
> +		ret = snd_soc_component_update_bits(component,
> DA7219_PC_COUNT,
>  				    DA7219_PC_FREERUN_MASK, 0);
> +		if (ret < 0)
> +			return ret;
> 
>  		/* Slave mode, if SRM not enabled no need for status checks */
>  		pll_ctrl = snd_soc_component_read32(component,
> DA7219_PLL_CTRL); @@ -846,19 +887,23 @@ static int da7219_dai_event(struct
> snd_soc_dapm_widget *w,
>  		return 0;
>  	case SND_SOC_DAPM_POST_PMD:
>  		/* PC free-running */
> -		snd_soc_component_update_bits(component,
> DA7219_PC_COUNT,
> +		ret = snd_soc_component_update_bits(component,
> DA7219_PC_COUNT,
>  				    DA7219_PC_FREERUN_MASK,
>  				    DA7219_PC_FREERUN_MASK);
> +		if (ret < 0)
> +			return ret;
> 
>  		/* Disable DAI clks if in master mode */
>  		if (da7219->master) {
>  			if (da7219->dai_clks)
>  				clk_disable_unprepare(da7219->dai_clks);
>  			else
> -				snd_soc_component_update_bits(component,
> +				ret =
> snd_soc_component_update_bits(component,
> 
> DA7219_DAI_CLK_MODE,
> 
> DA7219_DAI_CLK_EN_MASK,
>  							      0);
> +				if (ret < 0)
> +					return ret;
>  		}
> 
>  		return 0;
> @@ -887,6 +932,7 @@ static int da7219_mixout_event(struct
> snd_soc_dapm_widget *w,  {
>  	struct snd_soc_component *component =
> snd_soc_dapm_to_component(w->dapm);
>  	u8 hp_ctrl, min_gain_mask;
> +	int ret;
> 
>  	switch (w->reg) {
>  	case DA7219_MIXOUT_L_CTRL:
> @@ -904,15 +950,20 @@ static int da7219_mixout_event(struct
> snd_soc_dapm_widget *w,
>  	switch (event) {
>  	case SND_SOC_DAPM_PRE_PMD:
>  		/* Enable minimum gain on HP to avoid pops */
> -		snd_soc_component_update_bits(component, hp_ctrl,
> min_gain_mask,
> -				    min_gain_mask);
> +		ret = snd_soc_component_update_bits(component, hp_ctrl,
> +				    min_gain_mask, min_gain_mask);
> +		if (ret < 0)
> +			return ret;
> 
>  		msleep(DA7219_MIN_GAIN_DELAY);
> 
>  		break;
>  	case SND_SOC_DAPM_POST_PMU:
>  		/* Remove minimum gain on HP */
> -		snd_soc_component_update_bits(component, hp_ctrl,
> min_gain_mask, 0);
> +		ret = snd_soc_component_update_bits(component, hp_ctrl,
> +				    min_gain_mask, 0);
> +		if (ret < 0)
> +			return ret;
> 
>  		break;
>  	}
> @@ -925,21 +976,29 @@ static int da7219_gain_ramp_event(struct
> snd_soc_dapm_widget *w,  {
>  	struct snd_soc_component *component =
> snd_soc_dapm_to_component(w->dapm);
>  	struct da7219_priv *da7219 =
> snd_soc_component_get_drvdata(component);
> +	int ret;
> 
>  	switch (event) {
>  	case SND_SOC_DAPM_PRE_PMU:
>  	case SND_SOC_DAPM_PRE_PMD:
>  		/* Ensure nominal gain ramping for DAPM sequence */
> -		da7219->gain_ramp_ctrl =
> -			snd_soc_component_read32(component,
> DA7219_GAIN_RAMP_CTRL);
> -		snd_soc_component_write(component,
> DA7219_GAIN_RAMP_CTRL,
> -			      DA7219_GAIN_RAMP_RATE_NOMINAL);
> +		da7219->gain_ramp_ctrl =
> snd_soc_component_read32(component,
> +						DA7219_GAIN_RAMP_CTRL);
> +		if (da7219->gain_ramp_ctrl < 0)
> +			return da7219->gain_ramp_ctrl;
> +		 ret = snd_soc_component_write(component,
> +				DA7219_GAIN_RAMP_CTRL,
> +				DA7219_GAIN_RAMP_RATE_NOMINAL);
> +		if (ret < 0)
> +			return ret;
>  		break;
>  	case SND_SOC_DAPM_POST_PMU:
>  	case SND_SOC_DAPM_POST_PMD:
>  		/* Restore previous gain ramp settings */
> -		snd_soc_component_write(component,
> DA7219_GAIN_RAMP_CTRL,
> +		ret = snd_soc_component_write(component,
> DA7219_GAIN_RAMP_CTRL,
>  			      da7219->gain_ramp_ctrl);
> +		if (ret < 0)
> +			return ret;
>  		break;
>  	}
> 
> @@ -1177,13 +1236,17 @@ static int da7219_set_dai_sysclk(struct snd_soc_dai
> *codec_dai,
> 
>  	switch (clk_id) {
>  	case DA7219_CLKSRC_MCLK_SQR:
> -		snd_soc_component_update_bits(component,
> DA7219_PLL_CTRL,
> +		ret = snd_soc_component_update_bits(component,
> DA7219_PLL_CTRL,
>  				    DA7219_PLL_MCLK_SQR_EN_MASK,
>  				    DA7219_PLL_MCLK_SQR_EN_MASK);
> +		if (ret < 0)
> +			return ret;
>  		break;
>  	case DA7219_CLKSRC_MCLK:
> -		snd_soc_component_update_bits(component,
> DA7219_PLL_CTRL,
> +		ret = snd_soc_component_update_bits(component,
> DA7219_PLL_CTRL,
>  				    DA7219_PLL_MCLK_SQR_EN_MASK, 0);
> +		if (ret < 0)
> +			return ret;
>  		break;
>  	default:
>  		dev_err(codec_dai->dev, "Unknown clock source %d\n", clk_id);
> @@ -1219,6 +1282,7 @@ int da7219_set_pll(struct snd_soc_component
> *component, int source, unsigned int
>  	u8 pll_frac_top, pll_frac_bot, pll_integer;
>  	u32 freq_ref;
>  	u64 frac_div;
> +	int ret;
> 
>  	/* Verify 2MHz - 54MHz MCLK provided, and set input divider */
>  	if (da7219->mclk_rate < 2000000) {
> @@ -1252,9 +1316,11 @@ int da7219_set_pll(struct snd_soc_component
> *component, int source, unsigned int
>  	switch (source) {
>  	case DA7219_SYSCLK_MCLK:
>  		pll_ctrl |= DA7219_PLL_MODE_BYPASS;
> -		snd_soc_component_update_bits(component,
> DA7219_PLL_CTRL,
> +		ret = snd_soc_component_update_bits(component,
> DA7219_PLL_CTRL,
>  				    DA7219_PLL_INDIV_MASK |
>  				    DA7219_PLL_MODE_MASK, pll_ctrl);
> +		if (ret < 0)
> +			return ret;
>  		return 0;
>  	case DA7219_SYSCLK_PLL:
>  		pll_ctrl |= DA7219_PLL_MODE_NORMAL;
> @@ -1275,12 +1341,23 @@ int da7219_set_pll(struct snd_soc_component
> *component, int source, unsigned int
>  	pll_frac_bot = (frac_div) & DA7219_BYTE_MASK;
> 
>  	/* Write PLL config & dividers */
> -	snd_soc_component_write(component, DA7219_PLL_FRAC_TOP,
> pll_frac_top);
> -	snd_soc_component_write(component, DA7219_PLL_FRAC_BOT,
> pll_frac_bot);
> -	snd_soc_component_write(component, DA7219_PLL_INTEGER,
> pll_integer);
> -	snd_soc_component_update_bits(component, DA7219_PLL_CTRL,
> +	ret = snd_soc_component_write(component, DA7219_PLL_FRAC_TOP,
> +				pll_frac_top);
> +	if (ret < 0)
> +		return ret;
> +	ret = snd_soc_component_write(component, DA7219_PLL_FRAC_BOT,
> +				pll_frac_bot);
> +	if (ret < 0)
> +		return ret;
> +	ret = snd_soc_component_write(component, DA7219_PLL_INTEGER,
> +				pll_integer);
> +	if (ret < 0)
> +		return ret;
> +	ret = snd_soc_component_update_bits(component, DA7219_PLL_CTRL,
>  			    DA7219_PLL_INDIV_MASK |
> DA7219_PLL_MODE_MASK,
>  			    pll_ctrl);
> +	if (ret < 0)
> +		return ret;
> 
>  	return 0;
>  }
> @@ -1304,6 +1381,7 @@ static int da7219_set_dai_fmt(struct snd_soc_dai
> *codec_dai, unsigned int fmt)
>  	struct snd_soc_component *component = codec_dai->component;
>  	struct da7219_priv *da7219 =
> snd_soc_component_get_drvdata(component);
>  	u8 dai_clk_mode = 0, dai_ctrl = 0;
> +	int ret;
> 
>  	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
>  	case SND_SOC_DAIFMT_CBM_CFM:
> @@ -1379,12 +1457,16 @@ static int da7219_set_dai_fmt(struct snd_soc_dai
> *codec_dai, unsigned int fmt)
>  	/* By default 64 BCLKs per WCLK is supported */
>  	dai_clk_mode |= DA7219_DAI_BCLKS_PER_WCLK_64;
> 
> -	snd_soc_component_update_bits(component,
> DA7219_DAI_CLK_MODE,
> +	ret = snd_soc_component_update_bits(component,
> DA7219_DAI_CLK_MODE,
>  			    DA7219_DAI_BCLKS_PER_WCLK_MASK |
>  			    DA7219_DAI_CLK_POL_MASK |
> DA7219_DAI_WCLK_POL_MASK,
>  			    dai_clk_mode);
> -	snd_soc_component_update_bits(component, DA7219_DAI_CTRL,
> DA7219_DAI_FORMAT_MASK,
> -			    dai_ctrl);
> +	if (ret < 0)
> +		return ret;
> +	ret = snd_soc_component_update_bits(component, DA7219_DAI_CTRL,
> +			    DA7219_DAI_FORMAT_MASK, dai_ctrl);
> +	if (ret < 0)
> +		return ret;
> 
>  	return 0;
>  }
> @@ -1398,15 +1480,22 @@ static int da7219_set_dai_tdm_slot(struct
> snd_soc_dai *dai,
>  	u8 dai_bclks_per_wclk;
>  	u16 offset;
>  	u32 frame_size;
> +	int ret;
> 
>  	/* No channels enabled so disable TDM, revert to 64-bit frames */
>  	if (!tx_mask) {
> -		snd_soc_component_update_bits(component,
> DA7219_DAI_TDM_CTRL,
> +		ret = snd_soc_component_update_bits(component,
> +				    DA7219_DAI_TDM_CTRL,
>  				    DA7219_DAI_TDM_CH_EN_MASK |
>  				    DA7219_DAI_TDM_MODE_EN_MASK, 0);
> -		snd_soc_component_update_bits(component,
> DA7219_DAI_CLK_MODE,
> +		if (ret < 0)
> +			return ret;
> +		ret = snd_soc_component_update_bits(component,
> +				    DA7219_DAI_CLK_MODE,
>  				    DA7219_DAI_BCLKS_PER_WCLK_MASK,
>  				    DA7219_DAI_BCLKS_PER_WCLK_64);
> +		if (ret < 0)
> +			return ret;
>  		return 0;
>  	}
> 
> @@ -1444,19 +1533,25 @@ static int da7219_set_dai_tdm_slot(struct
> snd_soc_dai *dai,
>  		return -EINVAL;
>  	}
> 
> -	snd_soc_component_update_bits(component,
> DA7219_DAI_CLK_MODE,
> +	ret = snd_soc_component_update_bits(component,
> DA7219_DAI_CLK_MODE,
>  			    DA7219_DAI_BCLKS_PER_WCLK_MASK,
>  			    dai_bclks_per_wclk);
> +	if (ret < 0)
> +		return ret;
> 
>  	offset = cpu_to_le16(rx_mask);
> -	regmap_bulk_write(da7219->regmap, DA7219_DAI_OFFSET_LOWER,
> +	ret = regmap_bulk_write(da7219->regmap,
> DA7219_DAI_OFFSET_LOWER,
>  			  &offset, sizeof(offset));
> +	if (ret < 0)
> +		return ret;
> 
> -	snd_soc_component_update_bits(component, DA7219_DAI_TDM_CTRL,
> +	ret = snd_soc_component_update_bits(component,
> DA7219_DAI_TDM_CTRL,
>  			    DA7219_DAI_TDM_CH_EN_MASK |
>  			    DA7219_DAI_TDM_MODE_EN_MASK,
>  			    (tx_mask << DA7219_DAI_TDM_CH_EN_SHIFT) |
>  			    DA7219_DAI_TDM_MODE_EN_MASK);
> +	if (ret < 0)
> +		return ret;
> 
>  	return 0;
>  }
> @@ -1468,6 +1563,7 @@ static int da7219_hw_params(struct
> snd_pcm_substream *substream,
>  	struct snd_soc_component *component = dai->component;
>  	u8 dai_ctrl = 0, fs;
>  	unsigned int channels;
> +	int ret;
> 
>  	switch (params_width(params)) {
>  	case 16:
> @@ -1533,11 +1629,15 @@ static int da7219_hw_params(struct
> snd_pcm_substream *substream,
>  		return -EINVAL;
>  	}
> 
> -	snd_soc_component_update_bits(component, DA7219_DAI_CTRL,
> +	ret = snd_soc_component_update_bits(component, DA7219_DAI_CTRL,
>  			    DA7219_DAI_WORD_LENGTH_MASK |
>  			    DA7219_DAI_CH_NUM_MASK,
>  			    dai_ctrl);
> -	snd_soc_component_write(component, DA7219_SR, fs);
> +	if (ret < 0)
> +		return ret;
> +	ret = snd_soc_component_write(component, DA7219_SR, fs);
> +	if (ret < 0)
> +		return ret;
> 
>  	return 0;
>  }
> @@ -1692,9 +1792,12 @@ static int da7219_set_bias_level(struct
> snd_soc_component *component,
>  	case SND_SOC_BIAS_STANDBY:
>  		if (snd_soc_component_get_bias_level(component) ==
> SND_SOC_BIAS_OFF)
>  			/* Master bias */
> -			snd_soc_component_update_bits(component,
> DA7219_REFERENCES,
> +			ret = snd_soc_component_update_bits(component,
> +					    DA7219_REFERENCES,
>  					    DA7219_BIAS_EN_MASK,
>  					    DA7219_BIAS_EN_MASK);
> +			if (ret < 0)
> +				return ret;
> 
>  		if (snd_soc_component_get_bias_level(component) ==
> SND_SOC_BIAS_PREPARE) {
>  			/* Remove MCLK */
> @@ -1705,8 +1808,11 @@ static int da7219_set_bias_level(struct
> snd_soc_component *component,
>  	case SND_SOC_BIAS_OFF:
>  		/* Only disable master bias if we're not a wake-up source */
>  		if (!da7219->wakeup_source)
> -			snd_soc_component_update_bits(component,
> DA7219_REFERENCES,
> +			ret = snd_soc_component_update_bits(component,
> +					    DA7219_REFERENCES,
>  					    DA7219_BIAS_EN_MASK, 0);
> +			if (ret < 0)
> +				return ret;
> 
>  		break;
>  	}
> @@ -1754,10 +1860,16 @@ static int da7219_handle_supplies(struct
> snd_soc_component *component)
>  	}
> 
>  	/* Ensure device in active mode */
> -	snd_soc_component_write(component, DA7219_SYSTEM_ACTIVE,
> DA7219_SYSTEM_ACTIVE_MASK);
> +	ret = snd_soc_component_write(component, DA7219_SYSTEM_ACTIVE,
> +				DA7219_SYSTEM_ACTIVE_MASK);
> +	if (ret < 0)
> +		return ret;
> 
>  	/* Update IO voltage level range */
> -	snd_soc_component_write(component, DA7219_IO_CTRL,
> io_voltage_lvl);
> +	ret = snd_soc_component_write(component, DA7219_IO_CTRL,
> +				io_voltage_lvl);
> +	if (ret < 0)
> +		return ret;
> 
>  	return 0;
>  }
> @@ -1768,10 +1880,13 @@ static int da7219_dai_clks_prepare(struct clk_hw
> *hw)
>  	struct da7219_priv *da7219 =
>  		container_of(hw, struct da7219_priv, dai_clks_hw);
>  	struct snd_soc_component *component = da7219->aad->component;
> +	int ret;
> 
> -	snd_soc_component_update_bits(component,
> DA7219_DAI_CLK_MODE,
> +	ret = snd_soc_component_update_bits(component,
> DA7219_DAI_CLK_MODE,
>  				      DA7219_DAI_CLK_EN_MASK,
>  				      DA7219_DAI_CLK_EN_MASK);
> +	if (ret < 0)
> +		return ret;
> 
>  	return 0;
>  }
> @@ -1781,9 +1896,12 @@ static void da7219_dai_clks_unprepare(struct clk_hw
> *hw)
>  	struct da7219_priv *da7219 =
>  		container_of(hw, struct da7219_priv, dai_clks_hw);
>  	struct snd_soc_component *component = da7219->aad->component;
> +	int ret;
> 
> -	snd_soc_component_update_bits(component,
> DA7219_DAI_CLK_MODE,
> +	ret = snd_soc_component_update_bits(component,
> DA7219_DAI_CLK_MODE,
>  				      DA7219_DAI_CLK_EN_MASK, 0);
> +	if (ret < 0)
> +		dev_err(component->dev, "Failed to disable clk: %d\n", ret);
>  }
> 
>  static int da7219_dai_clks_is_prepared(struct clk_hw *hw) @@ -1791,9 +1909,11
> @@ static int da7219_dai_clks_is_prepared(struct clk_hw *hw)
>  	struct da7219_priv *da7219 =
>  		container_of(hw, struct da7219_priv, dai_clks_hw);
>  	struct snd_soc_component *component = da7219->aad->component;
> -	u8 clk_reg;
> +	int clk_reg;
> 
>  	clk_reg = snd_soc_component_read32(component,
> DA7219_DAI_CLK_MODE);
> +	if (clk_reg < 0)
> +		return clk_reg;
> 
>  	return !!(clk_reg & DA7219_DAI_CLK_EN_MASK);  } @@ -1844,10
> +1964,11 @@ static void da7219_register_dai_clks(struct snd_soc_component
> *component)  static inline void da7219_register_dai_clks(struct
> snd_soc_component *component) {}  #endif /* CONFIG_COMMON_CLK */
> 
> -static void da7219_handle_pdata(struct snd_soc_component *component)
> +static int da7219_handle_pdata(struct snd_soc_component *component)
>  {
>  	struct da7219_priv *da7219 =
> snd_soc_component_get_drvdata(component);
>  	struct da7219_pdata *pdata = da7219->pdata;
> +	int ret;
> 
>  	if (pdata) {
>  		u8 micbias_lvl = 0;
> @@ -1869,7 +1990,10 @@ static void da7219_handle_pdata(struct
> snd_soc_component *component)
>  			break;
>  		}
> 
> -		snd_soc_component_write(component, DA7219_MICBIAS_CTRL,
> micbias_lvl);
> +		ret = snd_soc_component_write(component,
> DA7219_MICBIAS_CTRL,
> +					micbias_lvl);
> +		if (ret < 0)
> +			return ret;
> 
>  		/*
>  		 * Calculate delay required to compensate for DC offset in @@ -
> 1884,11 +2008,15 @@ static void da7219_handle_pdata(struct
> snd_soc_component *component)
>  		case DA7219_MIC_AMP_IN_SEL_DIFF:
>  		case DA7219_MIC_AMP_IN_SEL_SE_P:
>  		case DA7219_MIC_AMP_IN_SEL_SE_N:
> -			snd_soc_component_write(component,
> DA7219_MIC_1_SELECT,
> -				      pdata->mic_amp_in_sel);
> +			ret = snd_soc_component_write(component,
> +					DA7219_MIC_1_SELECT,
> +					pdata->mic_amp_in_sel);
> +			if (ret < 0)
> +				return ret;
>  			break;
>  		}
>  	}
> +	return 0;
>  }
> 
>  static struct reg_sequence da7219_rev_aa_patch[] = { @@ -1934,7 +2062,9 @@
> static int da7219_probe(struct snd_soc_component *component)
>  	if (!da7219->pdata)
>  		da7219->pdata = da7219_fw_to_pdata(component);
> 
> -	da7219_handle_pdata(component);
> +	ret = da7219_handle_pdata(component);
> +	if (ret < 0)
> +		return ret;
> 
>  	/* Check if MCLK provided */
>  	da7219->mclk = devm_clk_get(component->dev, "mclk"); @@ -1948,36
> +2078,57 @@ static int da7219_probe(struct snd_soc_component *component)
>  	}
> 
>  	/* Default PC counter to free-running */
> -	snd_soc_component_update_bits(component, DA7219_PC_COUNT,
> DA7219_PC_FREERUN_MASK,
> -			    DA7219_PC_FREERUN_MASK);
> +	ret = snd_soc_component_update_bits(component,
> DA7219_PC_COUNT,
> +			DA7219_PC_FREERUN_MASK,
> DA7219_PC_FREERUN_MASK);
> +	if (ret < 0)
> +		return ret;
> 
>  	/* Default gain ramping */
> -	snd_soc_component_update_bits(component, DA7219_MIXIN_L_CTRL,
> +	ret = snd_soc_component_update_bits(component,
> DA7219_MIXIN_L_CTRL,
>  			    DA7219_MIXIN_L_AMP_RAMP_EN_MASK,
>  			    DA7219_MIXIN_L_AMP_RAMP_EN_MASK);
> -	snd_soc_component_update_bits(component, DA7219_ADC_L_CTRL,
> DA7219_ADC_L_RAMP_EN_MASK,
> -			    DA7219_ADC_L_RAMP_EN_MASK);
> -	snd_soc_component_update_bits(component, DA7219_DAC_L_CTRL,
> DA7219_DAC_L_RAMP_EN_MASK,
> -			    DA7219_DAC_L_RAMP_EN_MASK);
> -	snd_soc_component_update_bits(component, DA7219_DAC_R_CTRL,
> DA7219_DAC_R_RAMP_EN_MASK,
> -			    DA7219_DAC_R_RAMP_EN_MASK);
> -	snd_soc_component_update_bits(component, DA7219_HP_L_CTRL,
> +	if (ret < 0)
> +		return ret;
> +	ret = snd_soc_component_update_bits(component,
> DA7219_ADC_L_CTRL,
> +			DA7219_ADC_L_RAMP_EN_MASK,
> DA7219_ADC_L_RAMP_EN_MASK);
> +	if (ret < 0)
> +		return ret;
> +	ret = snd_soc_component_update_bits(component,
> DA7219_DAC_L_CTRL,
> +			DA7219_DAC_L_RAMP_EN_MASK,
> DA7219_DAC_L_RAMP_EN_MASK);
> +	if (ret < 0)
> +		return ret;
> +	ret = snd_soc_component_update_bits(component,
> DA7219_DAC_R_CTRL,
> +			DA7219_DAC_R_RAMP_EN_MASK,
> DA7219_DAC_R_RAMP_EN_MASK);
> +	if (ret < 0)
> +		return ret;
> +	ret = snd_soc_component_update_bits(component,
> DA7219_HP_L_CTRL,
>  			    DA7219_HP_L_AMP_RAMP_EN_MASK,
>  			    DA7219_HP_L_AMP_RAMP_EN_MASK);
> -	snd_soc_component_update_bits(component, DA7219_HP_R_CTRL,
> +	if (ret < 0)
> +		return ret;
> +	ret = snd_soc_component_update_bits(component,
> DA7219_HP_R_CTRL,
>  			    DA7219_HP_R_AMP_RAMP_EN_MASK,
>  			    DA7219_HP_R_AMP_RAMP_EN_MASK);
> +	if (ret < 0)
> +		return ret;
> 
>  	/* Default minimum gain on HP to avoid pops during DAPM sequencing
> */
> -	snd_soc_component_update_bits(component, DA7219_HP_L_CTRL,
> +	ret = snd_soc_component_update_bits(component,
> DA7219_HP_L_CTRL,
>  			    DA7219_HP_L_AMP_MIN_GAIN_EN_MASK,
>  			    DA7219_HP_L_AMP_MIN_GAIN_EN_MASK);
> -	snd_soc_component_update_bits(component, DA7219_HP_R_CTRL,
> +	if (ret < 0)
> +		return ret;
> +	ret = snd_soc_component_update_bits(component,
> DA7219_HP_R_CTRL,
>  			    DA7219_HP_R_AMP_MIN_GAIN_EN_MASK,
>  			    DA7219_HP_R_AMP_MIN_GAIN_EN_MASK);
> +	if (ret < 0)
> +		return ret;
> 
>  	/* Default infinite tone gen, start/stop by Kcontrol */
> -	snd_soc_component_write(component, DA7219_TONE_GEN_CYCLES,
> DA7219_BEEP_CYCLES_MASK);
> +	ret = snd_soc_component_write(component,
> DA7219_TONE_GEN_CYCLES,
> +			DA7219_BEEP_CYCLES_MASK);
> +	if (ret < 0)
> +		return ret;
> 
>  	/* Initialise AAD block */
>  	ret = da7219_aad_init(component);
> @@ -2221,16 +2372,28 @@ static int da7219_i2c_probe(struct i2c_client *i2c,
>  	regcache_cache_bypass(da7219->regmap, true);
> 
>  	/* Disable audio paths if still active from previous start */
> -	regmap_read(da7219->regmap, DA7219_SYSTEM_ACTIVE,
> &system_active);
> +	ret = regmap_read(da7219->regmap, DA7219_SYSTEM_ACTIVE,
> &system_active);
> +	if (ret < 0)
> +		return ret;
>  	if (system_active) {
> -		regmap_write(da7219->regmap, DA7219_GAIN_RAMP_CTRL,
> +		ret = regmap_write(da7219->regmap,
> DA7219_GAIN_RAMP_CTRL,
>  			     DA7219_GAIN_RAMP_RATE_NOMINAL);
> -		regmap_write(da7219->regmap,
> DA7219_SYSTEM_MODES_INPUT, 0x00);
> -		regmap_write(da7219->regmap,
> DA7219_SYSTEM_MODES_OUTPUT, 0x01);
> +		if (ret < 0)
> +			return ret;
> +		ret = regmap_write(da7219->regmap,
> DA7219_SYSTEM_MODES_INPUT,
> +				0x00);
> +		if (ret < 0)
> +			return ret;
> +		ret = regmap_write(da7219->regmap,
> DA7219_SYSTEM_MODES_OUTPUT,
> +				0x01);
> +		if (ret < 0)
> +			return ret;
> 
>  		for (i = 0; i < DA7219_SYS_STAT_CHECK_RETRIES; ++i) {
> -			regmap_read(da7219->regmap,
> DA7219_SYSTEM_STATUS,
> +			ret = regmap_read(da7219->regmap,
> DA7219_SYSTEM_STATUS,
>  				    &system_status);
> +			if (ret < 0)
> +				return ret;
>  			if (!system_status)
>  				break;
> 
> @@ -2239,13 +2402,19 @@ static int da7219_i2c_probe(struct i2c_client *i2c,
>  	}
> 
>  	/* Soft reset component */
> -	regmap_write_bits(da7219->regmap, DA7219_ACCDET_CONFIG_1,
> +	ret = regmap_write_bits(da7219->regmap, DA7219_ACCDET_CONFIG_1,
>  			  DA7219_ACCDET_EN_MASK, 0);
> -	regmap_write_bits(da7219->regmap, DA7219_CIF_CTRL,
> +	if (ret < 0)
> +		return ret;
> +	ret = regmap_write_bits(da7219->regmap, DA7219_CIF_CTRL,
>  			  DA7219_CIF_REG_SOFT_RESET_MASK,
>  			  DA7219_CIF_REG_SOFT_RESET_MASK);
> -	regmap_write_bits(da7219->regmap, DA7219_SYSTEM_ACTIVE,
> +	if (ret < 0)
> +		return ret;
> +	ret = regmap_write_bits(da7219->regmap, DA7219_SYSTEM_ACTIVE,
>  			  DA7219_SYSTEM_ACTIVE_MASK, 0);
> +	if (ret < 0)
> +		return ret;
> 
>  	regcache_cache_bypass(da7219->regmap, false);
> 
> diff --git a/sound/soc/codecs/da7219.h b/sound/soc/codecs/da7219.h index
> 3a00686..0cf78a7 100644
> --- a/sound/soc/codecs/da7219.h
> +++ b/sound/soc/codecs/da7219.h
> @@ -832,7 +832,7 @@ struct da7219_priv {
>  	bool alc_en;
>  	bool micbias_on_event;
>  	unsigned int mic_pga_delay;
> -	u8 gain_ramp_ctrl;
> +	int gain_ramp_ctrl;
>  };
> 
>  int da7219_set_pll(struct snd_soc_component *component, int source,
> unsigned int fout);
> --
> 1.9.1
