From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 2/2] ASoC: cx2072x Add driver for CX2072X
 CODEC
Date: Mon, 19 Dec 2016 12:54:48 -0600
Message-ID: <7f6154f9-27ae-0656-5ce4-e8741c7e29a2@linux.intel.com>
References: <cover.1481903061.git.simon.ho@conexant.com>
 <233120a71738fcef7b56f27fade0942f432e38ea.1481903061.git.simon.ho@conexant.com>
 <20161219162041.pvphqrcfoykmucfs@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id CBEF1266DAA
 for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2016 19:54:50 +0100 (CET)
In-Reply-To: <20161219162041.pvphqrcfoykmucfs@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, simon.ho.cnxt@gmail.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Simon Ho <simon.ho@conexant.com>
List-Id: alsa-devel@alsa-project.org

Thanks Simon, this will help fix 
https://bugzilla.kernel.org/show_bug.cgi?id=115531
It looks like this patch never reached the mailing list? the archives 
show patches 0 and 1 but not patch 2/2.

On 12/19/2016 10:20 AM, Mark Brown wrote:
> On Sat, Dec 17, 2016 at 03:52:33PM +0800, simon.ho.cnxt@gmail.com wrote:
>
>> +/*FIXME: need to move the default settings to device tree*/
> No, we'd expect things to be configured from userspace via a binary
> control.
>
>> +static unsigned char cx2072x_eq_coeff_array[MAX_EQ_BAND][MAC_EQ_COEFF] = {
>> +	{0x77, 0x26, 0x13, 0xb3, 0x76, 0x26, 0x0a, 0x3d, 0xd4, 0xe2, 0x04},
>> +	{0x97, 0x3e, 0xb3, 0x86, 0xc2, 0x3b, 0x4d, 0x79, 0xa7, 0xc5, 0x03},
>> +	{0x0f, 0x39, 0x76, 0xa3, 0x1b, 0x2b, 0x89, 0x5c, 0xd7, 0xdb, 0x03},
>> +	{0x21, 0x46, 0xfe, 0xa6, 0xec, 0x24, 0x01, 0x59, 0xf4, 0xd4, 0x03},
>> +	{0xe9, 0x78, 0x9c, 0xb0, 0x8a, 0x56, 0x64, 0x4f, 0x8d, 0xb0, 0x02},
>> +	{0x60, 0x6e, 0x57, 0xee, 0xec, 0x18, 0xa8, 0x11, 0xb5, 0xf8, 0x02},
>> +	{0x5a, 0x14, 0x68, 0xe9, 0x1d, 0x06, 0xb9, 0x5f, 0x68, 0xdc, 0x03},
>> +};
>> +
>> +static unsigned char cx2072x_drc_array[MAX_DRC_REGS] = {
>> +	0x65, 0x55, 0x3C, 0x01, 0x05, 0x39, 0x76, 0x1A, 0x00
>> +};
> Just use the chip defaults, this avoids any confusion or debate about
> the values in the kernel.
>
>> +#define get_cx2072x_priv(_codec_) \
>> +	((struct cx2072x_priv *) snd_soc_codec_get_drvdata(_codec_))
> There is no need to cast void pointers, this will at most hide actual
> errors, and there's no real need for the macro at all really.
>
>> +	{ 36864000, 7 },/* Don't use div 7*/
> Does something enforce that?  Also coding style, missing space.
>
>> +static const struct reg_default cx2072x_reg_defaults[] = {
>> +	{ 0x0414, 0x00000003 },	/*2072X_AFG_POWER_STATE */
> We have defines for the register names which are helpfully commented
> here, why not just actually use the defines?
>
>> +	if (reg == CX2072X_UM_INTERRUPT_CRTL_E) {
>> +		/* Update the MSB byte only */
>> +		reg += 3;
>> +		size = 1;
>> +		value >>= 24;
>> +	}
> Use a switch here in case you find any more magic registers.
>
>> +	ret = i2c_master_send(client, buf, size + 2);
>> +	if (ret == size + 2) {
>> +		ret =  0;
>> +	} else if (ret < 0) {
>> +		dev_err(dev,
>> +			"I2C write address failed\n");
> Please print the error code, it makes life easier for people looking at
> logs with errors.
>
>> +static unsigned int get_div_from_mclk(unsigned int mclk)
>> +{
>> +	unsigned int div = 8;
>> +	int i = 0;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(MCLK_PRE_DIV); i++) {
>> +		if (mclk <= MCLK_PRE_DIV[i].mclk) {
>> +			div = MCLK_PRE_DIV[i].div;
>> +			break;
>> +		}
>> +	}
>> +	return div;
>> +}
> Why is this function in the middle of all the register I/O functions?
>
>> +static int cx2072x_config_headset_det(struct cx2072x_priv *cx2072x)
>> +{
>> +	const int interrupt_gpio_pin = 1;
>> +
>> +	dev_dbg(cx2072x->dev,
>> +		"Configure interrupt pin: %d\n", interrupt_gpio_pin);
>> +	/*No-sticky input type*/
> Coding style.  There's *lots* of really obvious and bad coding style
> problems throughout the driver, this is really not good - as well as
> making things harder to read poor coding style is normally a good
> indicator that there are other problems.
>
>> +	/* support both nokia and apple headset set. Monitor time = 275 ms*/
>> +	regmap_write(cx2072x->regmap, CX2072X_DIGITAL_TEST15, 0x73);
>> +
>> +	/* Disable TIP detection*/
>> +	regmap_write(cx2072x->regmap, CX2072X_ANALOG_TEST12, 0x300);
>> +
>> +	/* Switch MusicD3Live pin to GPIO */
>> +	regmap_write(cx2072x->regmap, CX2072X_DIGITAL_TEST1, 0);
> These look awfully like they should be configured by the system
> integrator via DT.
>
>> +	regmap_write(cx2072x->regmap, CX2072X_ANALOG_TEST8,
>> +		(unsigned char)int_div & 0xffff);
> This cast is worrying, why is it needed?
>
>> +
>> +	/* clock inversion */
>> +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
>> +	case SND_SOC_DAIFMT_NB_NF:
>> +		is_frame_inv = is_i2s ? 1 : 0;
>> +		is_bclk_inv = is_i2s ? 1 : 0;
> Please don't abuse the ternery operator like this, write normal logic
> statements with straightforward assignments.  Readers will thank you.
>
>> +	regmap_write(cx2072x->regmap, CX2072X_I2SPCM_CONTROL1, reg1.ulVal);
> Please don't use Hungarian notation.
>
>> +	/*Enables bclk and EAPD pin*/
>> +	if (cx2072x->rev_id == CX2072X_REV_A2)
>> +		regmap_update_bits(cx2072x->regmap, CX2072X_DIGITAL_BIOS_TEST2,
>> +			0x84, 0xFF);
>> +	else
>> +		regmap_write(cx2072x->regmap, CX2072X_DIGITAL_BIOS_TEST2,
>> +			regDBT2.ulVal);
> Again, switch statement.
>
>> +static int portg_power_ev(struct snd_soc_dapm_widget *w,
>> +	struct snd_kcontrol *kcontrol, int event)
>> +{
>> +	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
>> +
>> +	switch (event) {
>> +	case SND_SOC_DAPM_POST_PMU:
>> +		cx2072x_update_dsp(codec);
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +	return 0;
>> +}
>> +static int cx2072x_plbk_dsp_info(struct snd_kcontrol *kcontrol,
> Blank lines between functions.
>
>> +	mutex_lock(&cx2072x->eq_coeff_lock);
>> +	memcpy(cache, param, CX2072X_PLBK_EQ_COEF_LEN);
>> +	cx2072x->plbk_dsp_changed = true;
> Shouldn't this involve a memcmp() to check if the new value is different?
>
>> +static const struct snd_kcontrol_new cx2072x_snd_controls[] = {
>> +
>> +	SOC_DOUBLE_R_TLV("PortD Boost", CX2072X_PORTD_GAIN_LEFT,
>> +	CX2072X_PORTD_GAIN_RIGHT, 0, 3, 0, boost_tlv),
> All volume controls should end in Volume so userspace knows how to
> handle them.  Also please use normal kernel indentation for the
> continuation lines.
>
>> +	SOC_DOUBLE_R("DAC1 Mute", CX2072X_DAC1_AMP_GAIN_LEFT,
>> +		CX2072X_DAC1_AMP_GAIN_RIGHT, 7,  1, 0),
> All boolean controls should end in Switch so userspace knows how to
> handle them.
>
>> +	CX2072X_PLBK_EQ_COEF("DACL EQ 0", 0, 0),
>> +	CX2072X_PLBK_EQ_COEF("DACL EQ 1", 0, 1),
>> +	CX2072X_PLBK_EQ_COEF("DACL EQ 2", 0, 2),
>> +	CX2072X_PLBK_EQ_COEF("DACL EQ 3", 0, 3),
>> +	CX2072X_PLBK_EQ_COEF("DACL EQ 4", 0, 4),
>> +	CX2072X_PLBK_EQ_COEF("DACL EQ 5", 0, 5),
>> +	CX2072X_PLBK_EQ_COEF("DACL EQ 6", 0, 6),
>> +	CX2072X_PLBK_EQ_COEF("DACR EQ 0", 1, 0),
>> +	CX2072X_PLBK_EQ_COEF("DACR EQ 1", 1, 1),
>> +	CX2072X_PLBK_EQ_COEF("DACR EQ 2", 1, 2),
>> +	CX2072X_PLBK_EQ_COEF("DACR EQ 3", 1, 3),
>> +	CX2072X_PLBK_EQ_COEF("DACR EQ 4", 1, 4),
>> +	CX2072X_PLBK_EQ_COEF("DACR EQ 5", 1, 5),
>> +	CX2072X_PLBK_EQ_COEF("DACR EQ 6", 1, 6),
> This looks like it should be two binary controls, one per EQ.
>
>> +int cx2072x_hs_jack_report(struct snd_soc_codec *codec)
>> +{
>> +}
>> +EXPORT_SYMBOL_GPL(cx2072x_hs_jack_report);
> We have a standard jack detection interface in the kernel, the driver
> should be using it rather than writing its own.
>
>> +static int cx2072x_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
>> +	unsigned int rx_mask, int slots, int slot_width)
>> +{
>> +	struct snd_soc_codec *codec = dai->codec;
>> +	struct cx2072x_priv *cx2072x = snd_soc_codec_get_drvdata(codec);
>> +
>> +	if (slots == 0)
>> +		goto out;
>> +
>> +
>> +	switch (rx_mask) {
>> +	case 1 ... 0xf:
>> +	default:
>> +		return -EINVAL;
>> +	}
> So all possible values are invalid?  That doesn't seemw right...
>
>> +	switch (clk_id) {
>> +	case CX2072X_MCLK_EXTERNAL_PLL:
>> +		if (cx2072x->mclk && clk_set_rate(cx2072x->mclk, freq))
>> +			return -EINVAL;
> Please write sensible error handling, log what went wrong if you get an
> error and pass back error codes you get from other APIs.  This will make
> it a lot easier for users to figure out what's happened.
>
>> +#define CX2072X_DAPM_SUPPLY_S(wname, wsubseq, wreg, wshift, wmask,  won_val, \
>> +	woff_val, wevent, wflags) \
>> +	{.id = snd_soc_dapm_supply, .name = wname, .kcontrol_news = NULL, \
>> +	.num_kcontrols = 0, .reg = wreg, .shift = wshift, .mask = wmask, \
>> +	.on_val = won_val, .off_val = woff_val, \
>> +	.subseq = wsubseq, .event = wevent, .event_flags = wflags}
> There appears to be nothing device specific in here, why is this not
> being added as a generic supply type?
>
>> +static void cx2072x_sw_reset(struct cx2072x_priv *cx2072x)
>> +{
>> +
>> +	regmap_write(cx2072x->regmap, CX2072X_AFG_FUNCTION_RESET, 0x01);
> Coding style, random blank line hre.
>
>> +	/* reduce the jack monitor time*/
>> +	regmap_update_bits(cx2072x->regmap, CX2072X_DIGITAL_TEST15,
>> +	0x00, 0x06);
> Coding style, please intent contiuation lines...
>
>> +	cx2072x_config_headset_det(cx2072x);
>> +	/* configre PortC as input device */
>> +	regmap_update_bits(cx2072x->regmap, CX2072X_PORTC_PIN_CTRL,
>> +		0x20, 0x20);
> ...this isn't even consistent with the rest of the same function :(
>
>> +	switch (level) {
>> +	case SND_SOC_BIAS_ON:
>> +		/* Enable Headset Mic Bias */
>> +		if (cx2072x->is_biason == 0)
>> +			cx2072x->is_biason = 1;
>> +		break;
> This looks worrying but since nothing else uses that driver data I'm
> guessing it doesn't actually do anything.
>
>> +	case SND_SOC_BIAS_PREPARE:
>> +		if (old_level == SND_SOC_BIAS_STANDBY) {
>> +			if (cx2072x->mclk) {
>> +				dev_dbg(cx2072x->dev, "Turn on MCLK\n");
>> +				ret = clk_prepare_enable(cx2072x->mclk);
>> +				if (ret)
>> +					return ret;
>> +			}
>> +		}
>> +		break;
>> +	case SND_SOC_BIAS_STANDBY:
>> +
>> +		if (old_level == SND_SOC_BIAS_OFF) {
>> +			if (cx2072x->mclk) {
>> +				dev_dbg(cx2072x->dev, "Turn on MCLK\n");
>> +				ret = clk_prepare_enable(cx2072x->mclk);
>> +				if (ret)
>> +					return ret;
>> +			}
> So we enable MCLK both when coming out of _OFF and when coming out of
> _STANDBY?  Why (and note that we're missing some disables here...
>
>> +	regmap_read(cx2072x->regmap, CX2072X_VENDOR_ID, &ven_id);
>> +	regmap_read(cx2072x->regmap, CX2072X_REVISION_ID, &cx2072x->rev_id);
>> +	dev_dbg(codec->dev, "codec version: %08x,%08x\n",
>> +		ven_id, cx2072x->rev_id);
> Log this at info level.
>
>> +#ifdef CONFIG_PM
>> +static int cx2072x_runtime_suspend(struct device *dev)
>> +{
>> +	struct cx2072x_priv *cx2072x = dev_get_drvdata(dev);
>> +
>> +	cx2072x_set_bias_level(cx2072x->codec, SND_SOC_BIAS_OFF);
> Let the framework take care of managing bias level for you.
>
>> +static bool cx2072x_readable_register(struct device *dev, unsigned int reg)
>> +{
>> +	switch (reg) {
> Why is this nowhere near the rest of the regmap code?
>
>> +static int cx2072x_i2c_probe(struct i2c_client *i2c,
>> +	const struct i2c_device_id *id)
>> +{
>> +	int ret = -1;
>> +	struct cx2072x_priv *cx2072x;
>> +
>> +	cx2072x = (struct cx2072x_priv *)devm_kzalloc(
>> +		&i2c->dev, sizeof(struct cx2072x_priv), GFP_KERNEL);
> No need to cast away from void.
>
>> +	if (cx2072x == NULL) {
>> +		dev_err(&i2c->dev, "Out of memory!\n");
> kzalloc() will already be very noisy if this happens.
>
>> +static const struct i2c_device_id cx2072x_i2c_id[] = {
>> +	{ "cx20721", 0 },
>> +	{ "cx20723", 0 },
>> +	{ "14F10720", 0 },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(i2c, cx2072x_i2c_id);
> One of those looks like an ACPI ID not an I2C ID.
>
>> +
>> +static const struct of_device_id cx2072x_of_match[] = {
>> +	{ .compatible = "cnxt,cx20721", },
>> +	{ .compatible = "cnxt,cx20723", },
>> +	{ .compatible = "cnxt,cx7601", },
>> +	{}
> Why is cx7601 not an I2C ID?
>
>> +#ifdef CONFIG_ACPI
>> +		.acpi_match_table = ACPI_PTR(cx2072x_acpi_match),
>> +#endif
> No need for the defines here.
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
