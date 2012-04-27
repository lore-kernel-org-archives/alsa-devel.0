From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: Re: [PATCH 7/8] ASoC: codecs: Add AB8500 codec-driver
Date: Fri, 27 Apr 2012 11:19:26 +0200
Message-ID: <4F9A649E.4000300@stericsson.com>
References: <1334914402-27554-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120423185936.GW8318@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog118.obsmtp.com (eu1sys200aog118.obsmtp.com
	[207.126.144.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A04910BE53
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2012 11:19:33 +0200 (CEST)
In-Reply-To: <20120423185936.GW8318@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 04/23/2012 08:59 PM, Mark Brown wrote:

> On Fri, Apr 20, 2012 at 11:33:22AM +0200, Ola Lilja wrote:
> 
> This is massively better than previous versions!  There's still some
> issues but hopefully not hard to correct.


Thanks :)

> 
>> @@ -12,6 +12,7 @@ config SND_SOC_ALL_CODECS
>>  	tristate "Build all ASoC CODEC drivers"
>>  	select SND_SOC_88PM860X if MFD_88PM860X
>>  	select SND_SOC_L3
>> +	select SND_SOC_AB8500_CODEC if SND_SOC_UX500
> 
> Shouldn't this depend on the MFD core for the device instead?


Hmm, that might be better, yes.

> 
>> +static int regulators_init(struct device *dev)
>> +{
>> +	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(dev);
>> +
>> +	dev_dbg(dev, "%s: Enter\n", __func__);
>> +
>> +	regulators_get_regulator(dev, &drvdata->reg_vaud, "V-AUD");
>> +	regulators_get_regulator(dev, &drvdata->reg_vamic1, "V-AMIC1");
>> +	regulators_get_regulator(dev, &drvdata->reg_vamic2, "V-AMIC2");
>> +	regulators_get_regulator(dev, &drvdata->reg_vdmic, "V-DMIC");
>> +
>> +	if (IS_ERR(drvdata->reg_vaud.consumer) ||
>> +		IS_ERR(drvdata->reg_vamic1.consumer) ||
>> +		IS_ERR(drvdata->reg_vamic2.consumer) ||
>> +		IS_ERR(drvdata->reg_vdmic.consumer)) {
>> +		regulators_cleanup(drvdata);
>> +		return -ENXIO;
>> +	}
> 
> This won't work with probe deferral - if we need to defer then the
> driver will squash down the -EPROBE_DEFER and fail totally.  Not a big
> deal, though.


Hmm, OK, how should I solve this?

> 
>> +static int dapm_audioclk_event(struct snd_soc_dapm_widget *w,
>> +			struct snd_kcontrol *k, int event)
>> +{
> 
> We should add a variant of REGULATOR_SUPPLY for clocks too, have a
> framework thing that will own the clock - this is all generic code which
> gets repeated for each clock, we could easily factor it out into the
> core.


OK, I'll look into this.

> 
>> +static int dapm_audioreg_event(struct snd_soc_dapm_widget *w,
>> +			struct snd_kcontrol *k, int event)
>> +{
>> +	struct device *dev = w->codec->dev;
>> +	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(dev);
>> +	int status = 0;
>> +
>> +	if (SND_SOC_DAPM_EVENT_ON(event))
>> +		status = regulator_enable(drvdata->reg_vaud.consumer);
>> +	else
>> +		regulator_disable(drvdata->reg_vaud.consumer);
> 
> Similarly this is just a REGULATOR_SUPPLY.


Is there already support for this in the core?

> 
>> +/* Mic 1b - Regulator select */
>> +static const struct soc_enum enum_mic1breg_sel = SOC_ENUM_SINGLE(0, 0, 2,
>> +								enum_micreg);
>> +static const struct snd_kcontrol_new dapm_mic1breg_mux[] = {
>> +				SOC_DAPM_ENUM_VIRT("Mic 1b Regulator Select",
>> +						enum_mic1breg_sel),
>> +};
> 
> Can you explain how this hardware works in more detail?  It seems very
> odd to be changing the regulator used to supply something at runtime.


Yes, different customers have different regulators tied to the different mics.
E.g. VMIC1 can be used with MIC2 etc. These settings are stored in a DB in
userspace and therefor we have it as a control reachable from userspace, but I
see the point that this could also be put in the mach-folder and thus fixed
during build-time.

> 
>> +static int mclk_input_control_put(struct snd_kcontrol *kcontrol,
>> +				struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
>> +	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(codec->dev);
>> +	unsigned int val;
>> +
>> +	val = (ucontrol->value.enumerated.item[0] != 0);
>> +	if (drvdata->mclk_sel == val)
>> +		return 0;
>> +
>> +	drvdata->mclk_sel = val;
>> +
>> +	return 1;
>> +}
> 
> This is really weird


This is a way of selecting what clock is to be used during a plaback/capture.
It cannot direclty turn on/off the clock because this is not allowed for
power-saving reasons. Also, it needs to be accessible from user-space as we have
code in user-space which makes this decision during runtime.

> 
>> +static const char * const enum_earselcm[] = {"0.95V", "1.10V", "1.27V",
>> +					"1.58V"};
>> +static SOC_ENUM_SINGLE_DECL(soc_enum_earselcm,
>> +	AB8500_ANACONF1, AB8500_ANACONF1_EARSELCM, enum_earselcm);
> 
> Some of this stuff looks awfully like it ought to be platform data...


This information is also stored as parameters in the database, which customers
can control. I could hard-code the value in the machine-driver...

> 
>> +static const char * const enum_ensemicx[] = {"Differential", "Single Ended"};
>> +static SOC_ENUM_SINGLE_DECL(soc_enum_ensemic1,
>> +	AB8500_ANAGAIN1, AB8500_ANAGAINX_ENSEMICX, enum_ensemicx);
>> +static SOC_ENUM_SINGLE_DECL(soc_enum_lowpowmic1,
>> +	AB8500_ANAGAIN1, AB8500_ANAGAINX_LOWPOWMICX, enum_dis_ena);
> 
> This for example is normally fixed by the physical design and can't
> sensibly be varied at runtime.


The same goes here... customers set this value in the database to match their
board-design. It is not a matter of being able to reconfigure this during
runtime but it is stored in the database, being one common place for most
settings; runtime or one-time-settings.
Also this could be put as a hard-coded parameter in the machine-driver.

> 
>> +	/* Digital interface - AD to slot mapping */
>> +	SOC_ENUM("Digital Interface AD To Slot 0 Map", soc_enum_adslot0map),
>> +	SOC_ENUM("Digital Interface AD To Slot 1 Map", soc_enum_adslot1map),
> 
> Can you usefully leave these fixed with a default configuration?
> There's been some chat about adding a framework feature for this but
> it's not there yet - lots of devices have similar features.  If not then
> this code is fine.


For the moment we need to be able to change what slots in the I2S-IF is mapped
to what AD/DA. In the future we might change it so that it can be fixed in the
kernel-space world, though.

> 
>> +static int ab8500_codec_configure_audio_macrocell(struct snd_soc_codec *codec)
>> +{
>> +	u8 value8;
>> +	unsigned int value;
>> +	int status;
>> +
>> +	status = ab8500_sysctrl_write(AB8500_STW4500CTRL3,
>> +				AB8500_STW4500CTRL3_CLK32KOUT2DIS |
>> +					AB8500_STW4500CTRL3_RESETAUDN,
>> +				AB8500_STW4500CTRL3_RESETAUDN);
>> +	if (status < 0)
>> +		return status;
>> +
>> +	status = abx500_get_register_interruptible(codec->dev, (u8)AB8500_MISC,
>> +						(u8)AB8500_GPIO_DIR4_REG,
>> +						&value8);
>> +	if (status < 0)
>> +		return status;
>> +	value = value8 | GPIO27_DIR_OUTPUT | GPIO29_DIR_OUTPUT |
>> +		GPIO31_DIR_OUTPUT;
>> +	status |= abx500_set_register_interruptible(codec->dev,
>> +						(u8)AB8500_MISC,
>> +						(u8)AB8500_GPIO_DIR4_REG,
>> +						value);
> 
> Still not sure why this isn't platform data.


We never change these values, but I could put them as platform-data.

> 
>> +	/* Add controls */
>> +	status = snd_soc_add_codec_controls(codec, ab8500_ctrls,
>> +				ARRAY_SIZE(ab8500_ctrls));
>> +	if (status < 0) {
>> +		dev_err(dev, "%s: failed to add codec-controls (%d).\n",
>> +			__func__, status);
>> +		return status;
>> +	}
> 
> At least this one could be done from the driver struct.


OK!

> 
>> +	/* Add DAPM-widgets */
>> +	status = snd_soc_dapm_new_controls(&codec->dapm, ab8500_dapm_widgets,
>> +			ARRAY_SIZE(ab8500_dapm_widgets));
>> +	if (status < 0) {
>> +		dev_err(codec->dev,
>> +			"%s: Failed to create DAPM controls (%d).\n",
>> +			__func__, status);
>> +		return status;
>> +	}
> 
> This could also be done from the driver struct.


OK!

> 
>> +	status = snd_soc_dapm_add_routes(&codec->dapm, ab8500_dapm_routes,
>> +					ARRAY_SIZE(ab8500_dapm_routes));
>> +	if (status < 0) {
>> +		dev_err(codec->dev, "%s: Failed to add DAPM routes (%d).\n",
>> +			__func__, status);
>> +		return status;
>> +	}
> 
> This too.


OK!

> 
>> +	if (IS_ERR(drvdata->clk_ptr_sysclk)) {
>> +		dev_err(dev,
>> +			"%s: ERROR: Clocks needed for streaming not available!",
>> +			__func__);
>> +		return -ENXIO;
> 
> return PTR_ERR().


OK.

> 
>> +	dev_info(&pdev->dev, "%s: Register codec.\n", __func__);
> 
> Remove this or downgrade to debug, it's noisy and not adding much
> information.


OK.
