From: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 1/2] ASoC: Add support for CS35L32 Boosted Amplifier
Date: Mon, 4 Aug 2014 09:44:04 -0500
Message-ID: <alpine.DEB.2.02.1408040940310.7394@heelrod>
References: <1406904331-13860-1-git-send-email-brian.austin@cirrus.com>
 <53DD6252.9070109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53DD6252.9070109-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dinh Nguyen <dinh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, =broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Sat, 2 Aug 2014, Dinh Nguyen wrote:

> 
> On 8/1/14, 9:45 AM, Brian Austin wrote:
> > This patch adds support for the Cirrus Logic CS35L32 Boosted Amplifier
> > I2S output provides monitor data to the SOC/CODEC/DSP for speaker protection algorithms
> >
> > Changes for v2:
> > - Interrupt Status registers added to regmap volatile
> > - Use Speaker for volume control name
> > - Zero Cross Switch rename
> > - Remove Gain Manager from DTS and add to kcontrols
> > - Add VP-Supply to regulator list
> > - Remove uneeded DAPM event
> > - Specify MCLK rates as numbers
> > - Move probe/remove code to device level probe/remove
> > - Move regmap_register_patch to after REV_ID check
> >
> > Signed-off-by: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
> > ---

> > +static int cs35l32_handle_of_data(struct i2c_client *i2c_client,
> > +				    struct cs35l32_platform_data *pdata)
> > +{
> > +	struct device_node *np = i2c_client->dev.of_node;
> > +	unsigned int val;
> > +
> > +	if (of_property_read_u32(np, "cirrus,sdout-share", &val) >= 0)
> > +		pdata->sdout_share = val;
> > +
> > +	of_property_read_u32(np, "cirrus,boost-manager", &val);
> > +	switch (val) {
> > +	case CS35L32_BOOST_MGR_AUTO:
> > +	case CS35L32_BOOST_MGR_AUTO_AUDIO:
> > +	case CS35L32_BOOST_MGR_BYPASS:
> > +	case CS35L32_BOOST_MGR_FIXED:
> > +		pdata->boost_mng = val;
> > +		break;
> > +	default:
> > +		dev_err(&i2c_client->dev,
> > +			"Wrong cirrus,boost-manager DT value %d\n", val);
> > +		pdata->boost_mng = CS35L32_BOOST_MGR_BYPASS;
> > +	}
> > +
> > +	of_property_read_u32(np, "cirrus,sdout-datacfg", &val);
> > +	switch (val) {
> > +	case CS35L32_DATA_CFG_LR_VP:
> > +	case CS35L32_DATA_CFG_LR_STAT:
> > +	case CS35L32_DATA_CFG_LR:
> > +	case CS35L32_DATA_CFG_LR_VPSTAT:
> > +		pdata->sdout_datacfg = val;
> > +		break;
> > +	default:
> > +		dev_err(&i2c_client->dev,
> > +			"Wrong cirrus,sdout-datacfg DT value %d\n", val);
> > +		pdata->sdout_datacfg = CS35L32_DATA_CFG_LR;
> > +	}
> > +
> > +	of_property_read_u32(np, "cirrus,battery-threshold", &val);
> > +	switch (val) {
> > +	case CS35L32_BATT_THRESH_3_1V:
> > +	case CS35L32_BATT_THRESH_3_2V:
> > +	case CS35L32_BATT_THRESH_3_3V:
> > +	case CS35L32_BATT_THRESH_3_4V:
> > +		pdata->batt_thresh = val;
> > +		break;
> > +	default:
> > +		dev_err(&i2c_client->dev,
> > +			"Wrong cirrus,battery-threshold DT value %d\n", val);
> > +		pdata->batt_thresh = CS35L32_BATT_THRESH_3_3V;
> > +	}
> > +
> > +	of_property_read_u32(np, "cirrus,battery-recovery", &val);
> > +	switch (val) {
> > +	case CS35L32_BATT_RECOV_3_1V:
> > +	case CS35L32_BATT_RECOV_3_2V:
> > +	case CS35L32_BATT_RECOV_3_3V:
> > +	case CS35L32_BATT_RECOV_3_4V:
> > +	case CS35L32_BATT_RECOV_3_5V:
> > +	case CS35L32_BATT_RECOV_3_6V:
> > +		pdata->batt_recov = val;
> > +		break;
> > +	default:
> > +		dev_err(&i2c_client->dev,
> > +			"Wrong cirrus,battery-recovery DT value %d\n", val);
> > +		pdata->batt_recov = CS35L32_BATT_RECOV_3_4V;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int cs35l32_i2c_probe(struct i2c_client *i2c_client,
> > +				       const struct i2c_device_id *id)
> > +{
> > +	struct cs35l32_private *cs35l32;
> > +	struct cs35l32_platform_data *pdata =
> > +		dev_get_platdata(&i2c_client->dev);
> > +	int ret, i;
> > +	unsigned int devid = 0;
> > +	unsigned int reg;
> > +
> > +
> > +	cs35l32 = devm_kzalloc(&i2c_client->dev, sizeof(struct cs35l32_private),
> > +			       GFP_KERNEL);
> > +	if (!cs35l32) {
> > +		dev_err(&i2c_client->dev, "could not allocate codec\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	i2c_set_clientdata(i2c_client, cs35l32);
> > +
> > +	cs35l32->regmap = devm_regmap_init_i2c(i2c_client, &cs35l32_regmap);
> > +	if (IS_ERR(cs35l32->regmap)) {
> > +		ret = PTR_ERR(cs35l32->regmap);
> > +		dev_err(&i2c_client->dev, "regmap_init() failed: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	if (pdata) {
> > +		cs35l32->pdata = *pdata;
> > +	} else {
> > +		pdata = devm_kzalloc(&i2c_client->dev,
> > +				     sizeof(struct cs35l32_platform_data),
> > +				GFP_KERNEL);
> > +		if (!pdata) {
> > +			dev_err(&i2c_client->dev, "could not allocate pdata\n");
> > +			return -ENOMEM;
> > +		}
> > +		if (i2c_client->dev.of_node) {
> > +			ret = cs35l32_handle_of_data(i2c_client,
> > +						     &cs35l32->pdata);
> > +			if (ret != 0)
> > +				return ret;
> 
> Doesn't cs35l32_handle_of_data() always return 0?
> 
I thought about this and I think I am going to keep this check incase I 
change anything about handle_of_data and would like to check the return 
value. I don't think it causes anything bad to keep it. I always like to  
have this check just in case.

 > > +		}
> > +	}
> > +
> > +	for (i = 0; i < ARRAY_SIZE(cs35l32->supplies); i++)
> > +		cs35l32->supplies[i].supply = cs35l32_supply_names[i];
> > +
> > +	ret = devm_regulator_bulk_get(&i2c_client->dev,
> > +				      ARRAY_SIZE(cs35l32->supplies),
> > +				      cs35l32->supplies);
> > +	if (ret != 0) {
> > +		dev_err(&i2c_client->dev,
> > +			"Failed to request supplies: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = regulator_bulk_enable(ARRAY_SIZE(cs35l32->supplies),
> > +				    cs35l32->supplies);
> > +	if (ret != 0) {
> > +		dev_err(&i2c_client->dev,
> > +			"Failed to enable supplies: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	/* Reset the Device */
> > +	cs35l32->reset_gpio = devm_gpiod_get(&i2c_client->dev,
> > +		"reset-gpios");
> > +	if (IS_ERR(cs35l32->reset_gpio)) {
> > +		ret = PTR_ERR(cs35l32->reset_gpio);
> > +		if (ret != -ENOENT && ret != -ENOSYS)
> > +			return ret;
> > +
> > +		cs35l32->reset_gpio = NULL;
> > +	} else {
> > +		ret = gpiod_direction_output(cs35l32->reset_gpio, 0);
> > +		if (ret)
> > +			return ret;
> > +		gpiod_set_value_cansleep(cs35l32->reset_gpio, 1);
> > +	}
> > +
> > +	/* initialize codec */
> > +	ret = regmap_read(cs35l32->regmap, CS35L32_DEVID_AB, &reg);
> > +	devid = (reg & 0xFF) << 12;
> > +
> > +	ret = regmap_read(cs35l32->regmap, CS35L32_DEVID_CD, &reg);
> > +	devid |= (reg & 0xFF) << 4;
> > +
> > +	ret = regmap_read(cs35l32->regmap, CS35L32_DEVID_E, &reg);
> > +	devid |= (reg & 0xF0) >> 4;
> > +
> > +	if (devid != CS35L32_CHIP_ID) {
> > +		ret = -ENODEV;
> > +		dev_err(&i2c_client->dev,
> > +			"CS35L32 Device ID (%X). Expected %X\n",
> > +			devid, CS35L32_CHIP_ID);
> > +		return ret;
> > +	}
> > +
> > +	ret = regmap_read(cs35l32->regmap, CS35L32_REV_ID, &reg);
> > +	if (ret < 0) {
> > +		dev_err(&i2c_client->dev, "Get Revision ID failed\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = regmap_register_patch(cs35l32->regmap, cs35l32_monitor_patch,
> > +				    ARRAY_SIZE(cs35l32_monitor_patch));
> > +	if (ret < 0) {
> > +		dev_err(&i2c_client->dev, "Failed to apply errata patch\n");
> > +		return ret;
> > +	}
> > +
> > +	dev_info(&i2c_client->dev,
> > +		 "Cirrus Logic CS35L32, Revision: %02X\n", reg & 0xFF);
> > +
> > +	/* Setup VBOOST Management */
> > +	if (cs35l32->pdata.boost_mng)
> > +		regmap_update_bits(cs35l32->regmap, CS35L32_AUDIO_LED_MNGR,
> > +				   CS35L32_BOOST_MASK,
> > +				cs35l32->pdata.boost_mng);
> > +
> > +	/* Setup ADSP Format Config */
> > +	if (cs35l32->pdata.sdout_share)
> > +		regmap_update_bits(cs35l32->regmap, CS35L32_ADSP_CTL,
> > +				    CS35L32_ADSP_SHARE_MASK,
> > +				cs35l32->pdata.sdout_share << 3);
> > +
> > +	/* Setup ADSP Data Configuration */
> > +	if (cs35l32->pdata.sdout_datacfg)
> > +		regmap_update_bits(cs35l32->regmap, CS35L32_ADSP_CTL,
> > +				   CS35L32_ADSP_DATACFG_MASK,
> > +				cs35l32->pdata.sdout_datacfg << 4);
> > +
> > +	/* Setup Low Battery Recovery  */
> > +	if (cs35l32->pdata.batt_recov)
> > +		regmap_update_bits(cs35l32->regmap, CS35L32_BATT_THRESHOLD,
> > +				   CS35L32_BATT_REC_MASK,
> > +				cs35l32->pdata.batt_recov << 1);
> > +
> > +	/* Setup Low Battery Threshold */
> > +	if (cs35l32->pdata.batt_thresh)
> > +		regmap_update_bits(cs35l32->regmap, CS35L32_BATT_THRESHOLD,
> > +				   CS35L32_BATT_THRESH_MASK,
> > +				cs35l32->pdata.batt_thresh << 4);
> > +
> > +	/* Power down the AMP */
> > +	regmap_update_bits(cs35l32->regmap, CS35L32_PWRCTL1, CS35L32_PDN_AMP,
> > +			    CS35L32_PDN_AMP);
> > +
> > +	/* Clear MCLK Error Bit since we don't have the clock yet */
> > +	ret = regmap_read(cs35l32->regmap, CS35L32_INT_STATUS_1, &reg);
> > +
> > +	ret =  snd_soc_register_codec(&i2c_client->dev,
> > +			&soc_codec_dev_cs35l32, cs35l32_dai,
> > +			ARRAY_SIZE(cs35l32_dai));
> > +
> > +	if (ret < 0)
> > +		return ret;
> > +	return 0;
> 
> Should be able to just "return ret" here.

I will change this but related to the regulator in case 
snd_soc_register_codec fails.

Thanks,
Brian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
