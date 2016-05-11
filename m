From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH] ASoC: MAX9860: new driver
Date: Wed, 11 May 2016 22:28:12 +0200
Message-ID: <be1f0f5c-5dbe-65f8-d55c-df07a92a558e@axentia.se>
References: <1462892797-1147-1-git-send-email-peda@axentia.se>
 <20160511152950.GL6261@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160511152950.GL6261-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 2016-05-11 17:29, Mark Brown wrote:
> On Tue, May 10, 2016 at 05:06:37PM +0200, Peter Rosin wrote:
> 
>> +		if (master) {
>> +			switch (max9860->pclk_rate) {
>> +			case 12000000:
>> +				sysclk = MAX9860_FREQ_12MHZ;
>> +				break;
>> +			case 13000000:
>> +				sysclk = MAX9860_FREQ_13MHZ;
>> +				break;
>> +			case 19200000:
>> +				sysclk = MAX9860_FREQ_19_2MHZ;
>> +				break;
>> +			}
> 
> What if we have another PCLK rate?

In that case the sysclk variable will remain cleared (0) and the
code that follows will trigger the PLL section with the N divider
for clock master mode (that mode is always used in clock slave mode).

>> +#ifdef CONFIG_PM
>> +static int max9860_suspend(struct device *dev)
>> +{
>> +	struct max9860_priv *max9860 = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	ret = regmap_update_bits(max9860->regmap, MAX9860_SYSCLK,
>> +				 MAX9860_PSCLK, MAX9860_PSCLK_OFF);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to disable clock: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int max9860_resume(struct device *dev)
>> +{
>> +	struct max9860_priv *max9860 = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	regcache_cache_only(max9860->regmap, false);
>> +	ret = regcache_sync(max9860->regmap);
> 
> We didn't go into cache only mode on suspend?  I'd also expect to see
> the regulators disabled over suspend and some system PM ops.

Ooops, that is a leftover, and I think it can be removed. However, your
comment suggests that I have misunderstood the workings of
SND_SOC_DAPM_REGULATOR_SUPPLY. I thought dapm would take care of the
regulators (and the clocks for SND_SOC_DAPM_CLOCK_SUPPLY) so that
disabling regulators over suspend was handled by the asoc core?

>> +static int max9860_mclk_rate(struct device *dev, unsigned long *mclk_rate)
>> +{
>> +	struct clk *mclk = clk_get(dev, "mclk");
> 
> Request resources on probe, not at some random point in driver
> execution.  That will mean probe deferral works properly and that we
> don't get broken devices instantiated in userspace.

This function is only called during probe, but yes, it needs to
do probe deferral. I'll fix that for the next version.

>> +	ret = clk_prepare_enable(mclk);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to enable MCLK: %d\n", ret);
>> +		clk_put(mclk);
>> +		return ret;
>> +	}
>> +
>> +	*mclk_rate = clk_get_rate(mclk);
>> +
>> +	clk_disable_unprepare(mclk);
> 
> This is definitely confused too.  Enabling the clock to read the
> programmed frequency is at best odd, and obviously if we do get the rate
> this will ensure that MCLK is disabled which probably isn't ideal.

This is the same situation as for the regulators, I thought dapm
handled it and would prep/enable clocks when they were needed?

>> +err_pm:
>> +	pm_runtime_disable(dev);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(max9860_probe);
> 
> I've no idea why this is exported...

Me neither. I'll kill that export for the next round.

I'll wait for further input on the regulator/clock interaction with dapm
before I send a v2.

Thanks,
Peter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
