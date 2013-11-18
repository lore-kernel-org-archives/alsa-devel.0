From: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
Subject: Re: [PATCHv3] ASoC: Add support for BCM2835
Date: Mon, 18 Nov 2013 16:56:33 +0100
Message-ID: <528A38B1.5010107@koalo.de>
References: <5289F9DF.8060406@koalo.de> <1384776479.14845.208.camel@smile>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384776479.14845.208.camel@smile>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Shevchenko, Andriy" <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dmaengine <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

>> +static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
>> +				 struct snd_pcm_hw_params *params,
>> +				 struct snd_soc_dai *dai)
>> +{
>> +	struct bcm2835_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
>> +
>> +	unsigned int sampling_rate = params_rate(params);
>> +	unsigned int data_length, data_delay, bclk_ratio;
>> +	unsigned int ch1pos, ch2pos, mode, format;
>> +	unsigned int mash = BCM2835_CLK_MASH_1;
>> +	unsigned int divi, divf, target_frequency;
>> +	int clk_src = -1;
>> +	unsigned int master = dev->fmt & SND_SOC_DAIFMT_MASTER_MASK;
>> +	uint32_t bit_master =	(master == SND_SOC_DAIFMT_CBS_CFS
>> +					|| master == SND_SOC_DAIFMT_CBS_CFM);
>> +
>> +	uint32_t frame_master =	(master == SND_SOC_DAIFMT_CBS_CFS
> 
> So, if master == SND_SOC_DAIFMT_CBS_CFS both bit_master and frame_master
> will be true. Is it correct?

Yes. That is exactly what CBS_CFS expresses:
Codec Bit Slave and Codec Frame Slave
So the interface is bit master as well as frame master.
Did I miss anything?
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
