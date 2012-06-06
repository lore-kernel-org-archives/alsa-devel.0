From: Adam Thomson <Adam.Thomson@diasemi.com>
Subject: Re: [PATCH v2 2/2] ASoC: codecs: Add DA732x codec
	driver
Date: Wed, 6 Jun 2012 10:36:07 +0000 (UTC)
Message-ID: <201206061034.q56AYZ36021522@sw-eng-lt-apt-vm1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay1.diasemi.com (mailrelay1.diasemi.com [82.210.246.133])
	by alsa0.perex.cz (Postfix) with ESMTP id EC4D710451C
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jun 2012 12:35:53 +0200 (CEST)
Date: $(date -R)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Michal Hajduk <Michal.Hajduk@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Wed, June 4, 2012 at 15:31, Mark Brown wrote:

> A few small things below, very minor and easy to correct though.
> 
> > +	{ DA732X_REG_STATUS_EXT		, 0x00 },
> > +	{ DA732X_REG_STATUS		, 0x00 },
> 
> > +	{ DA732X_REG_MBOX0		, 0x00 },
> > +	{ DA732X_REG_MBOX1		, 0x00 },
> > +	{ DA732X_REG_MBOX2		, 0x00 },
> > +	{ DA732X_REG_MBOX_STATUS	, 0x00 },
> 
> > +	{ DA732X_REG_ID			, 0x00 },
> 
> > +	{ DA732X_REG_DMA_STATUS		, 0x00 },
> > +	{ DA732X_REG_BROWNOUT		, 0x00 },
> 
> I would be very surprised if some or all of the above regsters aren't
> volatile and therefore shouldn't have default specified.

Correct. Will remove those from the cache.

> > +static int da732x_hpf_set(struct snd_kcontrol *kcontrol,
> > +			  struct snd_ctl_elem_value *ucontrol)
> 
> Why doesn't a standard enum work for this?

This is because the two bits that are required for this are not adjacent in the
register, so we use our own get/set methods to control them.
 
> > +	/* High Pass Filters */
> > +	SOC_ENUM_EXT("DAC1 High Pass Filter Mode Switch",
> > +		     da732x_dac1_hpf_mode_enum, da732x_hpf_get, da732x_hpf_set),
> 
> This shouldn't be a Switch, it's an enumeration.  Switches are plain
> boolean controls.

Ok, fair point. Will rename accordingly.
 
> > +	SOC_SINGLE("ADC1 Equalizer Switch", DA732X_REG_ADC1_EQ5,
> > +		   DA732X_EQ_EN_SHIFT, DA732X_EQ_EN_MAX, DA732X_NO_INVERT),
> > +	SOC_SINGLE_TLV("ADC1 EQ Band 1 Volume", DA732X_REG_ADC1_EQ12,
> > +		       DA732X_EQ_BAND1_SHIFT, DA732X_EQ_VOL_VAL_MAX,
> > +		       DA732X_INVERT, eq_band_pga_tlv),
> 
> I'd suggest calling the Switch "ADC1 EQ Switch" for consistency with the
> gains for the bands (or expanding EQ in the gains but that'll make for a
> lot of really long control names).

Again, makes sense. Will update all the ADC & DAC instances to align.

> > +	case SND_SOC_DAPM_POST_PMU:
> > +		if (w->reg == DA732X_REG_ADC1_PD)
> > +			snd_soc_update_bits(codec, DA732X_REG_CLK_EN3,
> > +					    DA732X_ADCA_BB_CLK_EN,
> > +					    DA732X_ADCA_BB_CLK_EN);
> > +		else
> > +			snd_soc_update_bits(codec, DA732X_REG_CLK_EN3,
> > +					    DA732X_ADCC_BB_CLK_EN,
> > +					    DA732X_ADCC_BB_CLK_EN);
> 
> This reads like it should be a switch statement.  The effect will be the
> same but it's a bit clearer.

Ok, don't mind changing it if you think it's clearer.

> > +	da732x->regmap = devm_regmap_init_i2c(i2c, &da732x_regmap);
> > +	if (IS_ERR(da732x->regmap)) {
> > +		ret = PTR_ERR(da732x->regmap);
> > +		dev_err(&i2c->dev, "Failed to initialize regmap\n");
> > +		goto err;
> > +	}
> > +
> > +	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_da732x,
> > +				     da732x_dai, ARRAY_SIZE(da732x_dai));
> 
> The register cache defaults make it look like there's a device ID
> (or possibly chip revision?) register - it'd be good practice to read it
> here and either verify that it has the expected value or log it
> depending on which it is.

Is revision information. Will log this.

> > +static const struct i2c_device_id da732x_i2c_id[] = {
> > +	{ "da732x", 0},
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, da732x_i2c_id);
> 
> Good practice would be to enumerate all the device IDs (so users can
> just register devices) but it doesn't really matter.

For now will stick with this.
