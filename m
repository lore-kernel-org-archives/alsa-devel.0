From: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH 2/5] ASoC: madera: Add common support for
 Cirrus Logic Madera codecs
Date: Fri, 24 May 2019 16:21:37 +0100
Message-ID: <2f4ab4ff-5b1e-8ef5-3ef7-8dfe413b4b95@opensource.cirrus.com>
References: <20190524104158.30731-1-ckeepax@opensource.cirrus.com>
 <20190524104158.30731-2-ckeepax@opensource.cirrus.com>
 <20190524145603.GE2456@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CB2CFF806F7
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 17:21:44 +0200 (CEST)
In-Reply-To: <20190524145603.GE2456@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, lgirdwood@gmail.com, robh+dt@kernel.org, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

On 24/05/19 15:56, Mark Brown wrote:
> On Fri, May 24, 2019 at 11:41:55AM +0100, Charles Keepax wrote:
> 
>> +	/*
>> +	 * Just read a register a few times to ensure the internal
>> +	 * oscillator sends out a few clocks.
>> +	 */
>> +	for (i = 0; i < 4; i++) {
>> +		ret = regmap_read(madera->regmap, MADERA_SOFTWARE_RESET, &val);
>> +		if (ret)
>> +			dev_err(madera->dev,
>> +				"%s Failed to read register: %d (%d)\n",
>> +				__func__, ret, i);
> 
> Why use %s to format the __func__ rather than just concatenate?

GCC docs say that it's a magic variable so cannot be concatenated with string literals. Though I
never tried concatenation to see if it works.

> 
>> +	}
>> +
>> +	udelay(300);
> 
> So we read the register a few times then add a few hundred us of delay
> after?  Surely that delay is going to be negligable compared to the time
> spent on I/O?

The register reads are to create clock cycles in the silicon, not to generate delay.

> 
>> +int madera_sysclk_ev(struct snd_soc_dapm_widget *w,
>> +		     struct snd_kcontrol *kcontrol, int event)
>> +{
>> +	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
>> +	struct madera_priv *priv = snd_soc_component_get_drvdata(component);
>> +
>> +	madera_spin_sysclk(priv);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(madera_sysclk_ev);
> 
> This will delay both before and after every power up and power down.
> Are you sure that makes sense?
>

I think that's correct but we can re-check with hardware people. It's not just a delay,
it needs to ensure there are always a certain number of SYSCLK cycles in the hardware to
avoid leaving certain state machines in limbo.

>> +
>> +	ret = madera_check_speaker_overheat(madera, &warn, &shutdown);
>> +	if (ret)
>> +		shutdown = true; /* for safety attempt to shutdown on error */
>> +
>> +	if (shutdown) {
>> +		dev_crit(madera->dev, "Thermal shutdown\n");
>> +		ret = regmap_update_bits(madera->regmap,
>> +					 MADERA_OUTPUT_ENABLES_1,
>> +					 MADERA_OUT4L_ENA |
>> +					 MADERA_OUT4R_ENA, 0);
>> +		if (ret != 0)
>> +			dev_crit(madera->dev,
>> +				 "Failed to disable speaker outputs: %d\n",
>> +				 ret);
>> +	} else if (warn) {
>> +		dev_crit(madera->dev, "Thermal warning\n");
>> +	}
>> +
>> +	return IRQ_HANDLED;
> 
> We will flag the interrupt as handled if there was neither a warning nor
> a critical overheat?  I'd expect some warning about a spurious interrupt
> at least.
> 
>> +static int madera_get_variable_u32_array(struct madera_priv *priv,
>> +					 const char *propname,
>> +					 u32 *dest,
>> +					 int n_max,
>> +					 int multiple)
>> +{
>> +	struct madera *madera = priv->madera;
>> +	int n, ret;
>> +
>> +	n = device_property_read_u32_array(madera->dev, propname, NULL, 0);
>> +	if (n == -EINVAL) {
>> +		return 0;	/* missing, ignore */
>> +	} else if (n < 0) {
>> +		dev_warn(madera->dev, "%s malformed (%d)\n",
>> +			 propname, n);
>> +		return n;
>> +	} else if ((n % multiple) != 0) {
>> +		dev_warn(madera->dev, "%s not a multiple of %d entries\n",
>> +			 propname, multiple);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (n > n_max)
>> +		n = n_max;
>> +
>> +	ret = device_property_read_u32_array(madera->dev, propname, dest, n);
>> +
>> +	if (ret < 0)
>> +		return ret;
>> +	else
>> +		return n;
>> +}
> 
> This feels like it should perhaps be a generic OF helper function -
> there's nothing driver specific I'm seeing here and arrays that need to
> be a multiple of N entries aren't that uncommon I think.
> 
>> +	mutex_lock(&priv->rate_lock);
>> +	cached_rate = priv->adsp_rate_cache[adsp_num];
>> +	mutex_unlock(&priv->rate_lock);
> 
> What's this lock protecting?  The value can we read can change as soon
> as the lock is released and we're just reading a single word here rather
> than traversing a data structure that might change under us or
> something.
> 
>> +void madera_destroy_bus_error_irq(struct madera_priv *priv, int dsp_num)
>> +{
>> +	struct madera *madera = priv->madera;
>> +
>> +	madera_free_irq(madera,
>> +			madera_dsp_bus_error_irqs[dsp_num],
>> +			&priv->adsp[dsp_num]);
>> +}
>> +EXPORT_SYMBOL_GPL(madera_destroy_bus_error_irq);
> 
> We use free rather than destroy normally?
> 
>> +static const char * const madera_dfc_width_text[MADERA_DFC_WIDTH_ENUM_SIZE] = {
>> +	"8bit", "16bit", "20bit", "24bit", "32bit",
>> +};
> 
> Spaces might make these more readable.
> 
>> +static void madera_sleep(unsigned int delay)
>> +{
>> +	if (delay < 20) {
>> +		delay *= 1000;
>> +		usleep_range(delay, delay + 500);
>> +	} else {
>> +		msleep(delay);
>> +	}
>> +}
> 
> This feels like it might make sense as a helper function as well - I
> could've sworn there was one already but I can't immediately find it.
> 
