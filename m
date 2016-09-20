From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: cs35l34: Initial commit of the
 cs35l34 CODEC driver.
Date: Tue, 20 Sep 2016 15:22:41 +0100
Message-ID: <20160920142241.GU21682@localhost.localdomain>
References: <73bdbc44-4e95-41bf-a941-47c969686f57@EX3.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <73bdbc44-4e95-41bf-a941-47c969686f57-XU/xxMRwCJnfk+Ne4bZl5AC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 16, 2016 at 04:48:40PM -0500, Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org wrote:
> From: Paul Handrigan <Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
> 
> Initial commit of the Cirrus Logic cs35l34 8V boosted class D
> amplifier.
> 
> Signed-off-by: Paul Handrigan <Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
> ---

Some very minor comments:

<snip>

> +struct cs35l34_platform_data {
> +	/* Set AIF to half drive strength */
> +	bool aif_half_drv;
> +	/* Digital Soft Ramp Disable */
> +	bool digsft_disable;
> +	/* Amplifier Invert */
> +	bool amp_inv;
> +	/* Peak current (mA) */
> +	unsigned int boost_peak;

This is a little misleading the DT is in mA's but the pdata looks
like it is in 80mA blocks starting at 1200mA.

> +	/* Boost inductor value (nH) */
> +	unsigned int boost_ind;
> +	/* Boost Controller Voltage Setting (mV) */
> +	unsigned int boost_vtge;
> +	/* Gain Change Zero Cross */
> +	bool gain_zc_disable;
> +	/* SDIN Left/Right Selection */
> +	unsigned int i2s_sdinloc;
> +	/* TDM Rising Edge */
> +	bool tdm_rising_edge;
> +};
> +

<snip>

> +
> +struct  cs35l34_private {
> +	struct snd_soc_codec *codec;
> +	struct cs35l34_platform_data pdata;
> +	struct regmap *regmap;
> +	void *control_data;

This control_data field appears to be unused.

> +	struct regulator_bulk_data core_supplies[2];
> +	int num_core_supplies;
> +	int mclk_int;
> +	bool tdm_mode;
> +	struct gpio_desc *reset_gpio;	/* Active-low reset GPIO */
> +};
> +

<snip>

> +
> +static int cs35l34_sdin_event(struct snd_soc_dapm_widget *w,
> +		struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
> +	struct cs35l34_private *priv = snd_soc_codec_get_drvdata(codec);
> +	int ret;
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		if (priv->tdm_mode) {
> +			regmap_update_bits(priv->regmap, CS35L34_PWRCTL3,
> +							CS35L34_PDN_TDM, 0x00);
> +		}

Should really drop the brackets around single statements.

> +		ret = regmap_update_bits(priv->regmap, CS35L34_PWRCTL1,
> +							CS35L34_PDN_ALL, 0);
> +		if (ret < 0) {
> +			dev_err(codec->dev, "Cannot set Power bits %d\n", ret);
> +			return ret;
> +		}
> +		usleep_range(5000, 5100);
> +	break;
> +	case SND_SOC_DAPM_POST_PMD:
> +		if (priv->tdm_mode) {
> +			regmap_update_bits(priv->regmap, CS35L34_PWRCTL3,
> +					CS35L34_PDN_TDM, CS35L34_PDN_TDM);
> +		}
> +		ret = regmap_update_bits(priv->regmap, CS35L34_PWRCTL1,
> +					CS35L34_PDN_ALL, CS35L34_PDN_ALL);
> +	break;
> +	default:
> +		pr_err("Invalid event = 0x%x\n", event);
> +	}
> +	return 0;
> +}
> +
> +static int cs35l34_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
> +				unsigned int rx_mask, int slots, int slot_width)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	struct cs35l34_private *priv = snd_soc_codec_get_drvdata(codec);
> +	unsigned int reg, bit_pos;
> +	int slot, slot_num;
> +
> +	if (slot_width != 8)
> +		return -EINVAL;
> +
> +	priv->tdm_mode = true;
> +	/* scan rx_mask for aud slot */
> +	slot = ffs(rx_mask) - 1;
> +	if (slot >= 0)
> +		snd_soc_update_bits(codec, CS35L34_TDM_RX_CTL_1_AUDIN,
> +							CS35L34_X_LOC, slot);

A lot of the indenting is a bit exciting might be worth going
through and tidying it up.

<snip>

> +
> +static int cs35l34_mclk_event(struct snd_soc_dapm_widget *w,
> +		struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
> +	struct cs35l34_private *priv = snd_soc_codec_get_drvdata(codec);
> +	int ret, i;
> +	unsigned int reg;
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMD:
> +		ret = regmap_read(priv->regmap, CS35L34_AMP_DIG_VOL_CTL,
> +			&reg);
> +		if (ret != 0) {
> +			pr_err("%s regmap read failure %d\n", __func__, ret);
> +			return ret;
> +		}
> +		if (reg & CS35L34_AMP_DIGSFT)
> +			msleep(40);
> +		else
> +			usleep_range(2000, 2010);
> +
> +		for (i = 0; i < PDN_DONE_ATTEMPTS; i++) {
> +			ret = regmap_read(priv->regmap, CS35L34_INT_STATUS_2,
> +				&reg);
> +			if (ret != 0) {
> +				pr_err("%s regmap read failure %d\n",
> +					__func__, ret);
> +				return ret;
> +			}
> +			if (reg & CS35L34_PDN_DONE)
> +				break;
> +
> +			usleep_range(5000, 5010);

These are really tight usleep ranges do they need to be so tight?

> +		}
> +		if (i == PDN_DONE_ATTEMPTS)
> +			pr_err("%s Device did not power down properly\n",
> +				__func__);
> +		break;
> +	default:
> +		pr_err("Invalid event = 0x%x\n", event);
> +		break;
> +	}
> +	return 0;
> +}
> +

<snip>

> +static int cs35l34_dai_set_sysclk(struct snd_soc_dai *dai,
> +				int clk_id, unsigned int freq, int dir)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	struct cs35l34_private *cs35l34 = snd_soc_codec_get_drvdata(codec);
> +
> +	switch (freq) {
> +	case CS35L34_MCLK_5644:
> +		snd_soc_update_bits(codec, CS35L34_MCLK_CTL,
> +				CS35L34_MCLK_DIV | CS35L34_MCLK_RATE_MASK,
> +				~CS35L34_MCLK_DIV & CS35L34_MCLK_RATE_5P6448);
> +		cs35l34->mclk_int = freq;
> +	break;
> +	case CS35L34_MCLK_6:
> +		snd_soc_update_bits(codec, CS35L34_MCLK_CTL,
> +				CS35L34_MCLK_DIV | CS35L34_MCLK_RATE_MASK,
> +				~CS35L34_MCLK_DIV & CS35L34_MCLK_RATE_6P0000);
> +		cs35l34->mclk_int = freq;
> +	break;
> +	case CS35L34_MCLK_6144:
> +		snd_soc_update_bits(codec, CS35L34_MCLK_CTL,
> +				CS35L34_MCLK_DIV | CS35L34_MCLK_RATE_MASK,
> +				~CS35L34_MCLK_DIV & CS35L34_MCLK_RATE_6P1440);
> +		cs35l34->mclk_int = freq;
> +	break;
> +	case CS35L34_MCLK_11289:
> +		snd_soc_update_bits(codec, CS35L34_MCLK_CTL,
> +				CS35L34_MCLK_DIV | CS35L34_MCLK_RATE_MASK,
> +				CS35L34_MCLK_DIV | CS35L34_MCLK_RATE_5P6448);
> +		cs35l34->mclk_int = freq/2;
> +	break;
> +	case CS35L34_MCLK_12:
> +		snd_soc_update_bits(codec, CS35L34_MCLK_CTL,
> +				CS35L34_MCLK_DIV | CS35L34_MCLK_RATE_MASK,
> +				CS35L34_MCLK_DIV | CS35L34_MCLK_RATE_6P0000);
> +		cs35l34->mclk_int = freq/2;
> +	break;
> +	case CS35L34_MCLK_12288:
> +		snd_soc_update_bits(codec, CS35L34_MCLK_CTL,
> +				CS35L34_MCLK_DIV | CS35L34_MCLK_RATE_MASK,
> +				CS35L34_MCLK_DIV | CS35L34_MCLK_RATE_6P1440);

Might be worth dropping the snd_soc_update_bits out of the switch
here and assigning a variable for the value in the switch would
look a little nicer.

> +		cs35l34->mclk_int = freq/2;

Spaces around operators.

> +	break;
> +	default:
> +		dev_err(codec->dev, "ERROR: Invalid Frequency %d\n", freq);
> +		cs35l34->mclk_int = 0;
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static const struct snd_soc_dai_ops cs35l34_ops = {
> +	.startup = cs35l34_pcm_startup,
> +	.set_tristate = cs35l34_set_tristate,
> +	.set_fmt = cs35l34_set_dai_fmt,
> +	.hw_params = cs35l34_pcm_hw_params,
> +	.set_sysclk = cs35l34_dai_set_sysclk,
> +	.set_tdm_slot = cs35l34_set_tdm_slot,
> +};
> +
> +static struct snd_soc_dai_driver cs35l34_dai = {
> +		.name = "cs35l34",
> +		.id = 0,
> +		.playback = {
> +			.stream_name = "AMP Playback",
> +			.channels_min = 1,
> +			.channels_max = 8,
> +			.rates = CS35L34_RATES,
> +			.formats = CS35L34_FORMATS,
> +		},
> +		.capture = {
> +			.stream_name = "AMP Capture",
> +			.channels_min = 1,
> +			.channels_max = 8,
> +			.rates = CS35L34_RATES,
> +			.formats = CS35L34_FORMATS,
> +		},
> +		.ops = &cs35l34_ops,
> +		.symmetric_rates = 1,
> +};
> +
> +static int cs35l34_boost_inductor(struct cs35l34_private *cs35l34,
> +	unsigned int inductor)
> +{
> +	struct snd_soc_codec *codec = cs35l34->codec;
> +
> +	switch (inductor) {
> +	case 1000: /* 1 uH */
> +		regmap_write(cs35l34->regmap, CS35L34_BST_CONV_COEF_1, 0x24);
> +		regmap_write(cs35l34->regmap, CS35L34_BST_CONV_COEF_2, 0x24);
> +		regmap_write(cs35l34->regmap, CS35L34_BST_CONV_SLOPE_COMP,
> +			0x4E);
> +		regmap_write(cs35l34->regmap, CS35L34_BST_CONV_SW_FREQ, 0);
> +		break;
> +	case 1200: /* 1.2 uH */
> +		regmap_write(cs35l34->regmap, CS35L34_BST_CONV_COEF_1, 0x20);
> +		regmap_write(cs35l34->regmap, CS35L34_BST_CONV_COEF_2, 0x20);
> +		regmap_write(cs35l34->regmap, CS35L34_BST_CONV_SLOPE_COMP,
> +			0x47);
> +		regmap_write(cs35l34->regmap, CS35L34_BST_CONV_SW_FREQ, 1);
> +		break;
> +	case 1500: /* 1.5uH */
> +		regmap_write(cs35l34->regmap, CS35L34_BST_CONV_COEF_1, 0x20);
> +		regmap_write(cs35l34->regmap, CS35L34_BST_CONV_COEF_2, 0x20);
> +		regmap_write(cs35l34->regmap, CS35L34_BST_CONV_SLOPE_COMP,
> +			0x3C);
> +		regmap_write(cs35l34->regmap, CS35L34_BST_CONV_SW_FREQ, 2);
> +		break;
> +	case 2200: /* 2.2uH */
> +		regmap_write(cs35l34->regmap, CS35L34_BST_CONV_COEF_1, 0x19);
> +		regmap_write(cs35l34->regmap, CS35L34_BST_CONV_COEF_2, 0x25);
> +		regmap_write(cs35l34->regmap, CS35L34_BST_CONV_SLOPE_COMP,
> +			0x23);
> +		regmap_write(cs35l34->regmap, CS35L34_BST_CONV_SW_FREQ, 3);
> +		break;
> +	default:
> +		dev_err(codec->dev, "%s Invalid Inductor Value %d uH\n",
> +			__func__, inductor);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int cs35l34_probe(struct snd_soc_codec *codec)
> +{
> +	int ret = 0;
> +	struct cs35l34_private *cs35l34 = snd_soc_codec_get_drvdata(codec);
> +
> +	codec->control_data = cs35l34->regmap;

This use of the codec's control_data field also appears to be
unused.

> +
> +	pm_runtime_get_sync(codec->dev);
> +
> +	/* Set over temperature warning attenuation to 6 dB */
> +	regmap_update_bits(cs35l34->regmap, CS35L34_PROTECT_CTL,
> +		 CS35L34_OTW_ATTN_MASK, 0x8);
> +
> +	/* Set Power control registers 2 and 3 to have everything
> +	 * powered down at initialization
> +	 */
> +	regmap_write(cs35l34->regmap, CS35L34_PWRCTL2, 0xFD);
> +	regmap_write(cs35l34->regmap, CS35L34_PWRCTL3, 0x1F);
> +
> +	/* Set mute bit at startup */
> +	regmap_update_bits(cs35l34->regmap, CS35L34_PROTECT_CTL,
> +				CS35L34_MUTE, CS35L34_MUTE);
> +
> +	/* Set Platform Data */
> +	if (cs35l34->pdata.boost_peak)
> +		regmap_update_bits(cs35l34->regmap, CS35L34_BST_PEAK_I,
> +				CS35L34_BST_PEAK_MASK,
> +				cs35l34->pdata.boost_peak);
> +
> +	if (cs35l34->pdata.gain_zc_disable)
> +		regmap_update_bits(cs35l34->regmap, CS35L34_PROTECT_CTL,
> +			CS35L34_GAIN_ZC_MASK, 0);
> +	else
> +		regmap_update_bits(cs35l34->regmap, CS35L34_PROTECT_CTL,
> +			CS35L34_GAIN_ZC_MASK, CS35L34_GAIN_ZC_MASK);
> +
> +	if (cs35l34->pdata.aif_half_drv)
> +		regmap_update_bits(cs35l34->regmap, CS35L34_ADSP_CLK_CTL,
> +			CS35L34_ADSP_DRIVE, 0);
> +
> +	if (cs35l34->pdata.digsft_disable)
> +		regmap_update_bits(cs35l34->regmap, CS35L34_AMP_DIG_VOL_CTL,
> +			CS35L34_AMP_DIGSFT, 0);
> +
> +	if (cs35l34->pdata.amp_inv)
> +		regmap_update_bits(cs35l34->regmap, CS35L34_AMP_DIG_VOL_CTL,
> +			CS35L34_INV, CS35L34_INV);
> +
> +	if (cs35l34->pdata.boost_ind)
> +		ret = cs35l34_boost_inductor(cs35l34, cs35l34->pdata.boost_ind);
> +
> +	if (cs35l34->pdata.i2s_sdinloc)
> +		regmap_update_bits(cs35l34->regmap, CS35L34_ADSP_I2S_CTL,
> +			CS35L34_I2S_LOC_MASK,
> +			cs35l34->pdata.i2s_sdinloc << CS35L34_I2S_LOC_SHIFT);
> +
> +	if (cs35l34->pdata.tdm_rising_edge)
> +		regmap_update_bits(cs35l34->regmap, CS35L34_ADSP_TDM_CTL,
> +			1, 1);
> +
> +	pm_runtime_put_sync(codec->dev);
> +
> +	return ret;
> +}
> +
> +
<snip>
> +static int cs35l34_handle_of_data(struct i2c_client *i2c_client,
> +				struct cs35l34_platform_data *pdata)
> +{
> +	struct device_node *np = i2c_client->dev.of_node;
> +	unsigned int val;
> +
> +	if (of_property_read_u32(np, "cirrus,boost-vtge", &val) >= 0) {
> +		/* Boost Voltage has a maximum of 8V */
> +		if (val > 8000 || (val < 3300 && val > 0)) {
> +			dev_err(&i2c_client->dev,
> +				"Invalid Boost Voltage %d mV\n", val);
> +			return -EINVAL;
> +		}
> +		if (val == 0)
> +			pdata->boost_vtge = 0; /* Use VP */
> +		else
> +			pdata->boost_vtge = ((val - 3300)/100) + 1;
> +	} else {
> +		dev_warn(&i2c_client->dev,
> +			"Boost Voltage not specified. Using VP\n");
> +	}
> +
> +	if (of_property_read_u32(np, "cirrus,boost-ind", &val) >= 0) {
> +		pdata->boost_ind = val;
> +	} else {
> +		dev_err(&i2c_client->dev, "Inductor not specified.\n");
> +		return -EINVAL;
> +	}
> +
> +	if (of_property_read_u32(np, "cirrus,boost-peak", &val) >= 0) {
> +		if (val > 3840 || val < 1200) {
> +			dev_err(&i2c_client->dev,
> +				"Invalid Boost Peak Current %d mA\n", val);
> +			return -EINVAL;
> +		}

Might be nice to do the error checking on the pdata that way it
applies to both the DT and pdata specified values.

> +		pdata->boost_peak = ((val - 1200)/80) + 1;
> +	}
> +
> +	pdata->aif_half_drv = of_property_read_bool(np,
> +		"cirrus,aif-half-drv");
> +	pdata->digsft_disable = of_property_read_bool(np,
> +		"cirrus,digsft-disable");
> +
> +	pdata->gain_zc_disable = of_property_read_bool(np,
> +		"cirrus,gain-zc-disable");
> +	pdata->amp_inv = of_property_read_bool(np, "cirrus,amp-inv");
> +
> +	if (of_property_read_u32(np, "cirrus,i2s-sdinloc", &val) >= 0)
> +		pdata->i2s_sdinloc = val;
> +	if (of_property_read_u32(np, "cirrus,tdm-rising-edge", &val) >= 0)
> +		pdata->tdm_rising_edge = val;
> +
> +	return 0;
> +}
<snip>
> +static int cs35l34_i2c_probe(struct i2c_client *i2c_client,
> +			      const struct i2c_device_id *id)
> +{
> +	struct cs35l34_private *cs35l34;
> +	struct cs35l34_platform_data *pdata =
> +		dev_get_platdata(&i2c_client->dev);
> +	int i;
> +	int ret;
> +	unsigned int devid = 0;
> +	unsigned int reg;
> +
> +	cs35l34 = devm_kzalloc(&i2c_client->dev,
> +			       sizeof(struct cs35l34_private),
> +			       GFP_KERNEL);
> +	if (!cs35l34) {
> +		dev_err(&i2c_client->dev, "could not allocate codec\n");
> +		return -ENOMEM;
> +	}
> +
> +	i2c_set_clientdata(i2c_client, cs35l34);
> +	cs35l34->regmap = devm_regmap_init_i2c(i2c_client, &cs35l34_regmap);
> +	if (IS_ERR(cs35l34->regmap)) {
> +		ret = PTR_ERR(cs35l34->regmap);
> +		dev_err(&i2c_client->dev, "regmap_init() failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	cs35l34->num_core_supplies = ARRAY_SIZE(cs35l34_core_supplies);
> +	for (i = 0; i < ARRAY_SIZE(cs35l34_core_supplies); i++)
> +		cs35l34->core_supplies[i].supply = cs35l34_core_supplies[i];
> +
> +	ret = devm_regulator_bulk_get(&i2c_client->dev,
> +		cs35l34->num_core_supplies,
> +		cs35l34->core_supplies);
> +	if (ret != 0) {
> +		dev_err(&i2c_client->dev,
> +			"Failed to request core supplies %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regulator_bulk_enable(cs35l34->num_core_supplies,
> +							cs35l34->core_supplies);
> +	if (ret != 0) {
> +		dev_err(&i2c_client->dev,
> +				"Failed to enable core supplies: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (pdata) {
> +		cs35l34->pdata = *pdata;
> +	} else {
> +		pdata = devm_kzalloc(&i2c_client->dev,
> +				     sizeof(struct cs35l34_platform_data),
> +								GFP_KERNEL);
> +		if (!pdata) {
> +			dev_err(&i2c_client->dev,
> +				"could not allocate pdata\n");
> +			return -ENOMEM;
> +		}
> +		if (i2c_client->dev.of_node) {
> +			ret = cs35l34_handle_of_data(i2c_client, pdata);
> +			if (ret != 0)
> +				return ret;
> +
> +		}
> +		cs35l34->pdata = *pdata;
> +	}
> +
> +	ret = devm_request_threaded_irq(&i2c_client->dev, i2c_client->irq, NULL,
> +			cs35l34_irq_thread, IRQF_ONESHOT | IRQF_TRIGGER_LOW,
> +			"cs35l34", cs35l34);
> +	if (ret != 0)
> +		dev_err(&i2c_client->dev, "Failed to request IRQ: %d\n", ret);
> +
> +	cs35l34->reset_gpio = devm_gpiod_get_optional(&i2c_client->dev,
> +				"reset-gpios", GPIOD_OUT_LOW);
> +	if (IS_ERR(cs35l34->reset_gpio))
> +		return PTR_ERR(cs35l34->reset_gpio);

Might be nice to print an error here.

> +
> +	gpiod_set_value_cansleep(cs35l34->reset_gpio, 1);
> +
> +	msleep(CS35L34_START_DELAY);
> +
> +	ret = regmap_read(cs35l34->regmap, CS35L34_DEVID_AB, &reg);
> +
> +	devid = (reg & 0xFF) << 12;
> +	ret = regmap_read(cs35l34->regmap, CS35L34_DEVID_CD, &reg);
> +	devid |= (reg & 0xFF) << 4;
> +	ret = regmap_read(cs35l34->regmap, CS35L34_DEVID_E, &reg);
> +	devid |= (reg & 0xF0) >> 4;
> +
> +	if (devid != CS35L34_CHIP_ID) {
> +		dev_err(&i2c_client->dev,
> +			"CS35l34 Device ID (%X). Expected ID %X\n",
> +			devid, CS35L34_CHIP_ID);
> +		ret = -ENODEV;
> +		goto err_regulator;
> +	}
> +
> +	ret = regmap_read(cs35l34->regmap, CS35L34_REV_ID, &reg);
> +	if (ret < 0) {
> +		dev_err(&i2c_client->dev, "Get Revision ID failed\n");
> +		goto err_regulator;
> +	}
> +
> +	dev_info(&i2c_client->dev,
> +		 "Cirrus Logic CS35l34 (%x), Revision: %02X\n", devid,
> +		reg & 0xFF);
> +
> +	/* Unmask critical interrupts */
> +	regmap_update_bits(cs35l34->regmap, CS35L34_INT_MASK_1,
> +				CS35L34_M_CAL_ERR | CS35L34_M_ALIVE_ERR |
> +				CS35L34_M_AMP_SHORT | CS35L34_M_OTW |
> +				CS35L34_M_OTE, 0);
> +	regmap_update_bits(cs35l34->regmap, CS35L34_INT_MASK_3,
> +				CS35L34_M_BST_HIGH | CS35L34_M_LBST_SHORT, 0);
> +
> +	pm_runtime_set_autosuspend_delay(&i2c_client->dev, 100);
> +	pm_runtime_use_autosuspend(&i2c_client->dev);
> +	pm_runtime_set_active(&i2c_client->dev);
> +	pm_runtime_enable(&i2c_client->dev);
> +
> +	ret =  snd_soc_register_codec(&i2c_client->dev,
> +			&soc_codec_dev_cs35l34, &cs35l34_dai, 1);
> +	if (ret < 0) {
> +		dev_err(&i2c_client->dev,
> +			"%s: Register codec failed\n", __func__);
> +		goto err_regulator;
> +	}
> +
> +	return 0;
> +
> +err_regulator:
> +	regulator_bulk_disable(cs35l34->num_core_supplies,
> +		cs35l34->core_supplies);
> +
> +	return ret;
> +}
> +
> +static int cs35l34_i2c_remove(struct i2c_client *client)
> +{
> +	struct cs35l34_private *cs35l34 = i2c_get_clientdata(client);
> +
> +	snd_soc_unregister_codec(&client->dev);
> +
> +	if (cs35l34->reset_gpio)
> +		gpiod_set_value_cansleep(cs35l34->reset_gpio, 0);

gpiod_set_value_cansleep actually does a null check for you so
you can drop that.

> +
> +	pm_runtime_disable(&client->dev);
> +	regulator_bulk_disable(cs35l34->num_core_supplies,
> +		cs35l34->core_supplies);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused cs35l34_runtime_resume(struct device *dev)
> +{
> +	struct cs35l34_private *cs35l34 = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = regulator_bulk_enable(cs35l34->num_core_supplies,
> +		cs35l34->core_supplies);
> +
> +	if (ret != 0) {
> +		dev_err(dev, "Failed to enable core supplies: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	regcache_cache_only(cs35l34->regmap, false);
> +
> +	gpiod_set_value_cansleep(cs35l34->reset_gpio, 1);
> +	msleep(CS35L34_START_DELAY);
> +
> +	ret = regcache_sync(cs35l34->regmap);
> +	if (ret != 0) {
> +		dev_err(dev, "Failed to restore register cache\n");
> +		goto err;
> +	}
> +	return 0;
> +err:
> +	regcache_cache_only(cs35l34->regmap, true);
> +	regulator_bulk_disable(cs35l34->num_core_supplies,
> +		cs35l34->core_supplies);
> +
> +	return ret;
> +}
> +
> +static int __maybe_unused cs35l34_runtime_suspend(struct device *dev)
> +{
> +	struct cs35l34_private *cs35l34 = dev_get_drvdata(dev);
> +
> +	regcache_cache_only(cs35l34->regmap, true);
> +	regcache_mark_dirty(cs35l34->regmap);
> +
> +	gpiod_set_value_cansleep(cs35l34->reset_gpio, 0);
> +
> +	regulator_bulk_disable(cs35l34->num_core_supplies,
> +					cs35l34->core_supplies);
> +
> +	return 0;
> +}
> +
<snip>
> +
> +static int __init cs35l34_modinit(void)
> +{
> +	int ret;
> +
> +	ret = i2c_add_driver(&cs35l34_i2c_driver);
> +	if (ret != 0) {
> +		pr_err("Failed to register CS35l34 I2C driver: %d\n", ret);
> +		return ret;
> +	}
> +	return 0;
> +}
> +module_init(cs35l34_modinit);
> +
> +static void __exit cs35l34_exit(void)
> +{
> +	i2c_del_driver(&cs35l34_i2c_driver);
> +}
> +module_exit(cs35l34_exit);

Can you not use module_i2c_driver here?

Thanks,
Charles
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
