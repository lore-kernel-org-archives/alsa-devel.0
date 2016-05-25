From: Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 3/4 v7] ASoC: dwc: Add PIO PCM extension
Date: Wed, 25 May 2016 11:11:47 +0100
Message-ID: <57457A63.5060702@synopsys.com>
References: <cover.1463996627.git.joabreu@synopsys.com>
 <d81055d826825874c9d76922d2275688b2586fa6.1463996627.git.joabreu@synopsys.com>
 <20160524164151.GM8206@sirena.org.uk> <57448A42.9050606@synopsys.com>
 <20160524175144.GO8206@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160524175144.GO8206-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Carlos Palminha <CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexey Brodkin <Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,


On 24-05-2016 18:51, Mark Brown wrote:
> On Tue, May 24, 2016 at 06:07:14PM +0100, Jose Abreu wrote:
>> On 24-05-2016 17:41, Mark Brown wrote:
> Please fix your mail client to word wrap within paragraphs at something
> substantially less than 80 columns.  Doing this makes your messages much
> easier to read and reply to.
>
>>>>  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>>>>  		i2s_write_reg(dev->i2s_base, ITER, 1);
>>> That seems wrong, or at least something that should be separate?
>>> Previously we needed interrupts for DMA operation but now we enable
>>> interrupts only if we don't use DMA.  It feels like we want to make the
>>> change for DMA separately if only to make it clear for bisection, are we
>>> 100% sure that masking the interrupt won't also mask the DMA request
>>> signals?
>> Indeed I thought about this and the interrupts must also be enabled when in DMA
>> mode. Although there is no interrupt handler in the original driver (without
>> this patches) in some setups the interrupt line may be connected to the DMA
>> controller. I will drop this change and always enable interrupts. Please note
>> that I don't have a setup with DMA support so I can only test using the PIO mode.
> Presumably you can talk to your hardware colleagues and get them to make
> you a FPGA with a DMA IP available?

Its already in the todo list.

>
>>> This also seems wrong.  We're forcing PIO if an interrupt is provided
>>> rather than based on DMA being configured which means that if the
>>> interrupt is wired up and happens to be described in DT we'll get worse
>> How should I then determine which mode to use?
>>     - Check if DMA parameters are declared in DT, or
>>     - Check if snd_dmaengine_pcm_register() fails, or
>>     - Assume PIO mode will be used when compiling with PIO PCM, or
>>     - Something else ?
> You could either unconditionally register the PIO driver and only
> actually start using it if the driver is instantiated or you could check
> to see if the registration function works (handling deferred probe - if
> the DMA driver just didn't load yet you should wait for it).

I think I will take the second option. Something like this:
"
    ret = snd_dmaengine_pcm_register(...)
    if (ret == -EPROBE_DEFER)
        return ret;
    else
        pio_register(...);
"?


Best regards,
Jose Miguel Abreu
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
