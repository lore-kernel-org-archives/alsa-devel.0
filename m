From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: Re: [PATCH 10/11] ASoC: codecs: Add AB8500 codec-driver
Date: Wed, 9 May 2012 09:48:35 +0200
Message-ID: <4FAA2153.1090905@stericsson.com>
References: <1336485450-27405-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120508182751.GJ15893@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog114.obsmtp.com (eu1sys200aog114.obsmtp.com
	[207.126.144.137])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D5DF24543
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 09:49:34 +0200 (CEST)
In-Reply-To: <20120508182751.GJ15893@opensource.wolfsonmicro.com>
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

On 05/08/2012 08:27 PM, Mark Brown wrote:

> On Tue, May 08, 2012 at 03:57:30PM +0200, Ola Lilja wrote:
> 
>> +static void show_regulator_status(struct snd_soc_dapm_context *dapm)
>> +{
>> +	struct device *dev = dapm->dev;
>> +
>> +	dev_dbg(dev, "%s: Regulator-status:\n", __func__);
>> +	dev_dbg(dev, "%s:     V-AUD: %s\n", __func__,
>> +		(snd_soc_dapm_get_regulator_status(dapm, "V-AUD") > 0) ?
>> +			"On" : "Off");
> 
> So, you were adding this just for debug...  Let's not do that.  There's
> already diagnostic infrastructure in the regulator API and at the DAPM
> level too.  If we need this sort of stuff it's probably not device
> specific so we should probably improve the core if it's not easy enough
> to figure out what's going on already.


Well, I want this in our driver and you told me to use the regulator-widget, so
now the only way for us to have this information, which I find very useful when
we debug, is to let the core have some means to provide the information to our
driver. I don't want to be forced to enable debug prints in a lot of other
places than our driver. That just makes it harder.

> 
>> +static void show_clock_status(struct snd_soc_dapm_context *dapm)
>> +{
>> +	struct device *dev = dapm->dev;
> 
> Similarly here (though the clock API diagnostics are probably a bit
> weaker).


Same answer as above. I want to have this debug-information in our driver!

> 
>> +	SND_SOC_DAPM_ADC("ADC", "ab8500_0c", SND_SOC_NOPM, 0, 0),
>> +
>> +	SND_SOC_DAPM_DAC("DAC", "ab8500_0p", SND_SOC_NOPM, 0, 0),
> 
> Please convert all these to use DAPM to hook up the streams to their
> audio interfaces rather than having a stream attached to the widget.
> 
>> +	{"Mic 1a or 1b Select", "Mic 1a", "MIC1A V-AMICx Enable"},
>> +	{"Mic 1a or 1b Select", "Mic 1b", "MIC1B V-AMICx Enable"},
> 
> This also looks very odd...  is this the micbias stuff again?


I'll rename them to "MIC1A Enable" and "MIC1B Enable". They are connected
connected to the correct regulator-supply from the machine-driver.

> 
>> +static int mclk_input_control_get(struct snd_kcontrol *kcontrol,
>> +				struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
>> +	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(codec->dev);
>> +
>> +	ucontrol->value.enumerated.item[0] = drvdata->mclk_sel;
>> +
>> +	return 0;
>> +}
> 
> Same as last time this should be configured by the machine driver.


I also told you last time that I have a hard time doing this from the
machine-driver. The switch between these clocks comes from a component in
user-space getting its information from a DSP running its own life. If we just
run the ASoC-driver normally without Android this will never change, but our
whole system-design form Android needs to be able to do this clock-switch in the
way we do it. I have no means of getting this information inside the linux-kernel.

> 
>> +	/* Mic 1, Mic 2, LineIn */
>> +	SOC_DOUBLE_R_TLV("Mic Master Gain",
>> +		AB8500_ADDIGGAIN3, AB8500_ADDIGGAIN4,
>> +		0, AB8500_ADDIGGAINX_ADXGAIN_MAX, 1, adx_dig_gain_tlv),
> 
> All volume controls should be "...Volume".


So what you are saying is that "Gain" is not an accepted term for a volume?!

> 
>> +	SOC_ENUM("Digital Interface 0 Bit-clock Switch", soc_enum_fsbitclk0),
>> +	SOC_ENUM("Digital Interface 1 Bit-clock Switch", soc_enum_fsbitclk1),
> 
> Hrm?


In our current Android-design this is also needed to be controlled for the same
reasons as the switching of clocks.

> 
>> +	/* Attach regulators to AMic DAPM-paths */
>> +	dev_dbg(codec->dev, "%s: Mic 1a regulator: %s\n", __func__,
>> +		amic_micbias_str(amics->mic1a_micbias));
>> +	route = &ab8500_dapm_routes_mic1a_vamicx[amics->mic1a_micbias];
>> +	status = snd_soc_dapm_add_routes(&codec->dapm, route, 1);
>> +	dev_dbg(codec->dev, "%s: Mic 1b regulator: %s\n", __func__,
>> +		amic_micbias_str(amics->mic1b_micbias));
>> +	route = &ab8500_dapm_routes_mic1b_vamicx[amics->mic1b_micbias];
>> +	status |= snd_soc_dapm_add_routes(&codec->dapm, route, 1);
>> +	dev_dbg(codec->dev, "%s: Mic 2 regulator: %s\n", __func__,
>> +		amic_micbias_str(amics->mic2_micbias));
>> +	route = &ab8500_dapm_routes_mic2_vamicx[amics->mic2_micbias];
>> +	status |= snd_soc_dapm_add_routes(&codec->dapm, route, 1);
> 
> This is fairly impenetrable and would usually be done in hte machine
> driver.  Machines might not use the chip biases for some or all of the
> mics but it looks like this code assumes they do.


OK, so it will be fine if I just move the code to the machine-driver?

> 
>> +int ab8500_audio_setup_if1(struct snd_soc_codec *codec,
>> +			unsigned int fmt,
>> +			unsigned int wl,
>> +			unsigned int delay)
> 
> Why is this not static?


Because it is called from the machine-driver.
