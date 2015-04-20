From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH v2] ASoC: Add support for NAU8825 codec to
 ASoC
Date: Mon, 20 Apr 2015 16:57:55 +0200
Message-ID: <553513F3.4060202@metafoo.de>
References: <552F874A.7090409@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <552F874A.7090409@nuvoton.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chih-Chiang Chang <ccchang12@nuvoton.com>, Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 04/16/2015 11:56 AM, Chih-Chiang Chang wrote:
> The NAU88L25 is an ultra-low power high performance audio codec designed
> for smartphone, tablet PC, and other portable devices by Nuvoton, now
> add linux driver support for it.
>
> Signed-off-by: Chih-Chiang Chang <ccchang12@nuvoton.com>

Looks pretty good now.

> ---
> v2->v1:
>     - fixes according to Lars-Peter Clausen's review comments
>     - removes unused platform data file
>     - corrects the naming of DAPM input widget
>     - fixes some wrong coding of SOC widgets and other codes
>     - adds definition and remark for config FLL clock
>     - moves the code of reset hardware registers from codec_probe() to i2c_probe()
>     - removes unused codes
>
[...]
> +static const struct snd_kcontrol_new nau8825_snd_controls[] = {
> +

Here and a few other places you leave the first line in the struct 
declaration empty. No need for that.

> +	SOC_SINGLE_TLV("MIC Volume", NAU8825_ADC_DGAIN_CTRL,
> +				NAU8825_ADC_DGAIN_SFT,
> +				NAU8825_ADC_VOL_RSCL_RANGE, 0, adc_vol_tlv),
> +	SOC_DOUBLE_TLV("HP Volume", NAU8825_HSVOL_CTRL,
> +				NAU8825_L_HSVOL_SFT, NAU8825_R_HSVOL_SFT,
> +				NAU8825_VOL_RSCL_RANGE, 1, out_hp_vol_tlv),
> +};
[...]
> +
> +static void config_fll_clk_12m(struct snd_soc_codec *codec)
> +{
> +	struct nau8825_priv *nau8825 = snd_soc_codec_get_drvdata(codec);
> +
> +	regmap_update_bits(nau8825->regmap, NAU8825_CLK_DIVIDER,
> +				NAU8825_CLK_MCLK_SRC_MASK, 0x0003);
> +	regmap_update_bits(nau8825->regmap, NAU8825_FLL_1,
> +				NAU8825_FLL_RATIO_MASK, 0x0001);
> +	/* FLL 16-bit fractional input */
> +	regmap_write(nau8825->regmap, NAU8825_FLL_2, 0xC49B);
> +	/* FLL 10-bit integer input */
> +	regmap_update_bits(nau8825->regmap, NAU8825_FLL_3,
> +				NAU8825_FLL_INTEGER_MASK, 0x0020);
> +	/* FLL pre-scaler */
> +	regmap_update_bits(nau8825->regmap, NAU8825_FLL_4,
> +				NAU8825_FLL_REF_DIV_MASK, 0x0800);

This seems to use some constant dividers and multipliers for the FLL. Does 
this expect a specific reference clock from somewhere?

> +	/* select divied VCO input */
> +	regmap_update_bits(nau8825->regmap, NAU8825_FLL_5,
> +				NAU8825_FLL_FILTER_SW_MASK, 0x0000);
> +	/* FLL sigma delta modulator enable */
> +	regmap_update_bits(nau8825->regmap, NAU8825_FLL_6,
> +				NAU8825_SDM_EN_MASK, 0x4000);
> +}
> +
> +static void set_sys_clk(struct snd_soc_codec *codec, int sys_clk)
> +{
> +	struct nau8825_priv *nau8825 = snd_soc_codec_get_drvdata(codec);
> +
> +	pr_debug("%s :: sys_clk=%x\n", __func__, sys_clk);
> +	switch (sys_clk) {
> +	case NAU8825_INTERNALCLOCK:
> +		regmap_update_bits(nau8825->regmap, NAU8825_CLK_DIVIDER,
> +				NAU8825_SYSCLK_EN_MASK, NAU8825_SYSCLK_DIS);
> +		regmap_update_bits(nau8825->regmap, NAU8825_FLL_6,
> +				NAU8825_DCO_EN_MASK, NAU8825_DCO_EN);
> +		regmap_update_bits(nau8825->regmap, NAU8825_CLK_DIVIDER,
> +				NAU8825_SYSCLK_EN_MASK, NAU8825_SYSCLK_EN);
> +		break;
> +	case NAU8825_MCLK:
> +	default:
> +		regmap_update_bits(nau8825->regmap, NAU8825_CLK_DIVIDER,
> +				NAU8825_SYSCLK_EN_MASK, NAU8825_SYSCLK_DIS);
> +		regmap_update_bits(nau8825->regmap, NAU8825_FLL_6,
> +				NAU8825_DCO_EN_MASK, NAU8825_DCO_DIS);
> +		regmap_update_bits(nau8825->regmap, NAU8825_CLK_DIVIDER,
> +				NAU8825_SYSCLK_EN_MASK, NAU8825_SYSCLK_EN);
> +		break;
> +	}
> +}
> +
> +static int nau8825_dai_set_sysclk(struct snd_soc_dai *dai,
> +		int clk_id, unsigned int freq, int dir)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +
> +	switch (clk_id) {
> +	case NAU8825_MCLK:
> +		config_fll_clk_12m(codec);
> +		set_sys_clk(codec, clk_id);

Maybe just inline the contents of set_sys_clk here ...

> +		break;
> +	case NAU8825_INTERNALCLOCK:
> +		set_sys_clk(codec, clk_id);

... and here

> +		break;
> +	default:
> +		dev_err(codec->dev, "Wrong clock src\n");
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
[...]
 > +static const struct reg_default nau8825_reg[] = {
 > +	/* enable clock source */
 > +	{0x0001, 0x07FF},
 > +	/* enable VMID and Bias */
 > +	{0x0076, 0x3140},
 > +	/* setup clock divider */
 > +	{0x0003, 0x0050},
 > +	/* jack detection configuration */
 > +	{0x000C, 0x0004},
 > +	{0x000D, 0x00E0},
 > +	{0x000F, 0x0801},
 > +	{0x0012, 0x0010},
 > +	/* keypad detection configuration */
 > +	{0x0013, 0x0280},
 > +	{0x0014, 0x7310},
 > +	{0x0015, 0x050E},
 > +	{0x0016, 0x1B2A},
 > +	/* audio format configuration */
 > +	{0x001A, 0x0800},
 > +	{0x001C, 0x000E},
 > +	{0x001D, 0x0010},
 > +	/* sampling rate control */
 > +	{0x002B, 0x0012},
 > +	/* DAC sampling rate control */
 > +	{0x002C, 0x0082},
 > +	/* ADC and DAC mixer control */
 > +	{0x0030, 0x00D2},
 > +	{0x0033, 0x00CF},
 > +	{0x0034, 0x02CF},
 > +	/* DAC class-G control */
 > +	{0x006A, 0x1003},
 > +	{0x0050, 0x2007},
 > +	/* ADC PGA control */
 > +	{0x0072, 0x0260},
 > +	/* DAC power down enabled */
 > +	{0x0080, 0x03A0},
 > +	/* enable DAC clock */
 > +	{0x0073, 0x336C},
 > +	/* enable MIC Bias */
 > +	{0x0074, 0x5502},
 > +	/* powerup output driver */
 > +	{0x007F, 0x473C},
 > +	{0x007F, 0x473F},
 > +	/* DAC power down disabled */
 > +	{0x0080, 0x00A0},
 > +	/* adjust MIC Bias */
 > +	{0x0066, 0x2060},
 > +	{0x0066, 0x2060},
 > +	{0x0066, 0x0060},
 > +};

The register defaults should hold the content of the registers in the 
power-on reset state of the chip. This is not meant to be used as a 
initialization sequence.

 > +
[...]
> +static struct snd_soc_dai_driver nau8825_dai_driver[] = {
> +	{
> +		.name = "nau8825-aif1",
> +			.playback = {
> +				.stream_name	 = "AIF1 Playback",
> +				.channels_min	 = 1,
> +				.channels_max	 = 2,
> +				.rates		 = NAU8825_RATES,
> +				.formats	 = NAU8825_FORMATS,
> +			},
> +			.capture = {
> +				.stream_name	 = "AIF1 Capture",
> +				.channels_min	 = 1,
> +				.channels_max	 = 2,
> +				.rates		 = NAU8825_RATES,
> +				.formats	 = NAU8825_FORMATS,
> +			},

The indent is a bit strange above.

> +		.ops = &nau8825_dai_ops,
> +	}
> +};
> +
> +
> +static int nau8825_i2c_probe(struct i2c_client *i2c,
> +				 const struct i2c_device_id *i2c_id)
> +{
> +	struct nau8825_priv *nau8825;
> +	int i, ret;
> +
> +	nau8825 = devm_kzalloc(&i2c->dev, sizeof(*nau8825),
> +		GFP_KERNEL);
> +	if (nau8825 == NULL)
> +		return -ENOMEM;
> +	nau8825->i2c = i2c;
> +	i2c_set_clientdata(i2c, nau8825);
> +	nau8825->regmap = devm_regmap_init_i2c(i2c, &nau8825_regmap);
> +	if (IS_ERR(nau8825->regmap)) {
> +		ret = PTR_ERR(nau8825->regmap);
> +		dev_err(&i2c->dev, "Failed to allocate regmap: %d\n", ret);
> +		goto err_enable;

Since there is nothing to do at err_enable, just return ret directly and get 
rid of the label.

> +	}
> +	/* software reset */
> +	regmap_write(nau8825->regmap, NAU8825_RESET, 0x01);
> +	regmap_write(nau8825->regmap, NAU8825_RESET, 0x02);
> +	/*writing initial register values to the codec*/
> +	for (i = 0; i < ARRAY_SIZE(nau8825_reg); i++)
> +		regmap_write(nau8825->regmap, nau8825_reg[i].reg,
> +		nau8825_reg[i].def);
> +
> +	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_driver_nau8825,
> +				nau8825_dai_driver,
> +				ARRAY_SIZE(nau8825_dai_driver));
> +err_enable:
> +	return ret;
> +}
> +
[...]
> +#define NAU8825_RATES	SNDRV_PCM_RATE_8000_192000
> +#define NAU8825_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE \
> +			 | SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)

These defines should probably be moved to the C file close to their users.

> +
> +struct nau8825_priv {
> +	struct snd_soc_codec *codec;
> +	struct regmap *regmap;
> +	struct i2c_client *i2c;
> +	struct snd_soc_jack *jack;
> +	struct delayed_work jack_detect_work;

All fields in here except for the regmap field are still unused.

> +};
> +#endif	/* _NAU8825_H */
>
