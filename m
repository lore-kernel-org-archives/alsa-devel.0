From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 2/2] ASoC: codecs: Add initial PCM1862/63/64/65
 universal ADC driver
Date: Thu, 30 Nov 2017 09:56:08 -0600
Message-ID: <d4f015ab-3b17-dab8-33ba-4144b7571554@ti.com>
References: <20171129185015.5304-1-afd@ti.com>
 <20171129185015.5304-2-afd@ti.com>
 <20171130122035.wgj2jpvzx6md5gnl@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171130122035.wgj2jpvzx6md5gnl-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 11/30/2017 06:20 AM, Mark Brown wrote:
> On Wed, Nov 29, 2017 at 12:50:15PM -0600, Andrew F. Davis wrote:
> 
>> +	case SND_SOC_BIAS_STANDBY:
>> +		pcm186x_power_on(codec);
>> +		break;
>> +	case SND_SOC_BIAS_OFF:
>> +		pcm186x_power_off(codec);
>> +		break;
>> +	}
> 
>> +/*
>> + * The PCM186x's page register is located on every page, allowing to program it
>> + * without having to switch pages. Take advantage of this by defining the range
>> + * such to have this register located inside the data window.
>> + */
> 
> That sounds like a normal page register?
> 

It is, I believe Andreas commented this for his own reference, I'll drop it.

>> +int pcm186x_probe(struct device *dev, enum pcm186x_type type, int irq,
>> +		  struct regmap *regmap)
>> +{
> 
>> +	ret = regulator_bulk_disable(ARRAY_SIZE(priv->supplies),
>> +				     priv->supplies);
>> +	if (ret) {
>> +		dev_err(dev, "failed disable supplies: %d\n", ret);
>> +		return ret;
>> +	}
> 
>> +static int __maybe_unused pcm186x_resume(struct device *dev)
>> +{
>> +	struct pcm186x_priv *priv = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	ret = regulator_bulk_enable(ARRAY_SIZE(priv->supplies),
>> +				    priv->supplies);
>> +	if (ret != 0) {
>> +		dev_err(dev, "failed to enable supplies: %d\n", ret);
>> +		return ret;
>> +	}
> 
>> +const struct dev_pm_ops pcm186x_pm_ops = {
>> +	SET_RUNTIME_PM_OPS(pcm186x_suspend, pcm186x_resume, NULL)
>> +};
>> +EXPORT_SYMBOL_GPL(pcm186x_pm_ops);
> 
> There's no code in the driver that enables runtime PM so this isn't
> going to do anything.  I'm also not clear that the power management
> handling is in general joined up - we leave the regulators disabled
> at the end of probe, relying on the bias level configuration to reenable
> them but then the runtime PM configuration also tries to enable and
> disable them.  Based on what I think the intention is I'd suggest
> removing the bias level handling and then having probe enable runtime
> PM with the device flagged as active, letting runtime PM do any
> disabling if the device is idle.
> 

I beleive this was meant to be be SIMPLE_DEV_PM_OPS and not
SET_RUNTIME_PM_OPS. I'll fix this all up for v3.

Just thinking, the sound core sets SND_SOC_BIAS_OFF before suspend
anyway, right? So the results would be similar just having all the PM
stuff in the bias level handling for consistency, but I'm open to
whatever is the preferred way.

> I'd also expect to see some system suspend handling.
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
