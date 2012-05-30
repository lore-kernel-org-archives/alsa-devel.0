From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: Re: [PATCH 4/5] ASoC: codecs: Add AB8500 codec-driver
Date: Wed, 30 May 2012 15:49:51 +0200
Message-ID: <4FC6257F.4080905@stericsson.com>
References: <1337865998-26150-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120530131421.GK9947@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog114.obsmtp.com (eu1sys200aog114.obsmtp.com
	[207.126.144.137])
	by alsa0.perex.cz (Postfix) with ESMTP id 803FA247BF
	for <alsa-devel@alsa-project.org>;
	Wed, 30 May 2012 15:49:54 +0200 (CEST)
In-Reply-To: <20120530131421.GK9947@opensource.wolfsonmicro.com>
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

On 05/30/2012 03:14 PM, Mark Brown wrote:

> On Thu, May 24, 2012 at 03:26:38PM +0200, Ola Lilja wrote:
> 
>> +static void show_regulator_status(struct device *dev)
>> +{
>> +	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(dev);
>> +	struct ab8500_codec_drvdata_dbg *dbg = &drvdata->dbg;
>> +
>> +	dev_dbg(dev, "%s: Regulator-status:\n", __func__);
>> +	dev_dbg(dev, "%s:     V-AUD: %s\n", __func__,
>> +		(regulator_is_enabled(dbg->vaud) > 0) ?
>> +			"On" : "Off");
>> +	dev_dbg(dev, "%s:     V-AMIC1: %s\n", __func__,
>> +		(regulator_is_enabled(dbg->vamic1) > 0) ?
>> +			"On" : "Off");
>> +	dev_dbg(dev, "%s:     V-AMIC2: %s\n", __func__,
>> +		(regulator_is_enabled(dbg->vamic2) > 0) ?
>> +			"On" : "Off");
>> +	dev_dbg(dev, "%s:     V-DMIC: %s\n", __func__,
>> +		(regulator_is_enabled(dbg->vdmic) > 0) ?
>> +			"On" : "Off");
> 
> What problems are you finding when you try to use the debug
> infrastructure in both the regulator API and DAPM to discover the state
> of the regulators?


My vision here is that in a simple way, in one place, activate all
debug-information we need in our driver, prefixed with our dev_xxx. This is very
valuable for us when debugging, especially when a customer is told to activate
debug-information that we can use to debug.
I removed the menuconfig flag on your request, and then we lost the information
for regulators and clocks when I implemented the clock/regulator-widgets. I'm
just trying to keep some aspects of what we want to have but still conforming
what you want to see on mainline.

> 
>> +	/* Clocks */
>> +	SND_SOC_DAPM_CLOCK_SUPPLY("audioclk"),
>> +	SND_SOC_DAPM_CLOCK_SUPPLY("gpio.1"),
> 
> This looks wrong - audioclk looks reasonable but gpio.1 looks like a
> board-specific name which shouldn't be encoded into the driver.
> 
>> +	if (ucontrol->value.integer.value[0] != SID_APPLY_FIR) {
>> +		dev_err(codec->dev,
>> +			"%s: ERROR: This control supports '%s' only!\n",
>> +			__func__, enum_sid_state[SID_APPLY_FIR]);
>> +		return 0;
>> +	}
> 
> I'd expect this to return an error...


Yes.

> 
>> +	status = snd_soc_dapm_force_enable_pin(&codec->dapm,
>> +					"ANC Configure Input");
>> +	if (status < 0) {
>> +		dev_err(dev,
>> +			"%s: ERROR: Failed to enable power (status = %d)!\n",
>> +			__func__, status);
>> +		goto cleanup;
>> +	}
>> +	snd_soc_dapm_sync(&codec->dapm);
>> +
>> +	mutex_lock(&codec->mutex);
> 
> Your locking looks bad here.  Nothing ensures that something doesn't
> come along and undo the force enable.  Looking at the code this is the
> only function that fiddles with the input but there's still a race where
> one writer might exit the mutex section and disable the pin while a
> second enters the mutex section.


Will fix.

> 
>> +static int filter_control_get(struct snd_kcontrol *kcontrol,
>> +			struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct filter_control *fc =
>> +			(struct filter_control *)kcontrol->private_value;
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < fc->count; i++)
>> +		ucontrol->value.integer.value[i] = fc->value[i];
>> +
>> +	return 0;
>> +}
>> +
>> +static int filter_control_put(struct snd_kcontrol *kcontrol,
>> +		struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct filter_control *fc =
>> +			(struct filter_control *)kcontrol->private_value;
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < fc->count; i++)
>> +		fc->value[i] = ucontrol->value.integer.value[i];
> 
> These don't seem to be locked?


Will look into it.

> 
>> +int ab8500_audio_init_audioblock(struct snd_soc_codec *codec)
> 
> static.  Lots of other functions in the rest of the driver have the same
> issue.


This one should be static, yes. Cannot find any other non-static functions in
the codec-driver that is missing static.

> 
>> +static int ab8500_codec_pcm_hw_params(struct snd_pcm_substream *substream,
>> +		struct snd_pcm_hw_params *hw_params, struct snd_soc_dai *dai)
>> +{
>> +	dev_dbg(dai->codec->dev, "%s Enter.\n", __func__);
>> +
>> +	return 0;
>> +}
> 
> Remove empty functions.


OK.

> 
>> +	default:
>> +		dev_err(dai->codec->dev,
>> +			"%s: ERROR: Unsupported INV mask 0x%x\n",
>> +			__func__, fmt & SND_SOC_DAIFMT_INV_MASK);
>> +		return -EINVAL;
>> +		break;
> 
> The break is redundant.


Yes.

> 
>> +	/* Only 16 bit slot width is supported at the moment in TDM mode */
>> +	if (slot_width != 16) {
>> +		dev_err(dai->codec->dev,
>> +			"%s: ERROR: Unsupported slot_width %d.\n",
>> +			__func__, slot_width);
>> +		return -EINVAL;
>> +	}
> 
> You've got code which supports other widths...


Will look into it.

> 
>> +static struct snd_soc_codec_driver ab8500_codec_driver = {
>> +	.probe =		ab8500_codec_probe,
>> +	.read =			ab8500_codec_read_reg,
>> +	.write =		ab8500_codec_write_reg,
>> +	.reg_cache_size =	0,
> 
> no need to init things to zero or NULL in static structs.


Yes, was just for clarity. Will remove it.

> 
>> +#define PRE_PMU_POST_PMD			(SND_SOC_DAPM_PRE_PMU | \
>> +						SND_SOC_DAPM_POST_PMD)
> 
> You shouldn't define stuff like this in your driver!


This was mainly to avoid impossible situations trying to comply with the
80-char-width.
