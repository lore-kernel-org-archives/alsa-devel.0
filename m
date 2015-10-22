From: Damien Horsley <Damien.Horsley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH V2 06/10] ASoC: img: Add driver for parallel
 output controller
Date: Thu, 22 Oct 2015 20:21:03 +0100
Message-ID: <5629371F.5080700@imgtec.com>
References: <1444653637-14711-1-git-send-email-Damien.Horsley@imgtec.com>
 <1444653637-14711-7-git-send-email-Damien.Horsley@imgtec.com>
 <20151019180757.GJ32054@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151019180757.GJ32054-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, James Hartley <James.Hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 19/10/15 19:07, Mark Brown wrote:
> On Mon, Oct 12, 2015 at 01:40:33PM +0100, Damien Horsley wrote:
> 
>> +	spin_lock_irqsave(&prl->lock, flags);
>> +	reg = img_prl_out_readl(prl, IMG_PRL_OUT_CTL);
>> +	ucontrol->value.integer.value[0] = !!(reg & IMG_PRL_OUT_CTL_EDGE_MASK);
>> +	spin_unlock_irqrestore(&prl->lock, flags);
> 
> Do you need to lock a single register read?
>

Between the calls to reset_control_assert and reset_control_deassert,
the block is held in reset. During this time, no register access will
succeed. All register access that may occur concurrently with the reset
needs to be locked

>> +static struct snd_kcontrol_new img_prl_out_controls[] = {
>> +	{
>> +		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
>> +		.name = "Parallel Out Edge Falling",
>> +		.info = img_prl_out_edge_info,
>> +		.get = img_prl_out_get_edge,
>> +		.put = img_prl_out_set_edge
>> +	}
>> +};
> 
> If this is a boolean control (it looked like one) it should be called
> Switch but it's not clear to me what exactly is being controlled here or
> why it's something that should be exposed to userspace.
> 

This controls the edge (rising/falling) of the frame clock that the
samples are generated on. Should I create a set_fmt function and use
SND_SOC_DAIFMT_NB_NF / SND_SOC_DAIFMT_NB_IF to set this instead? I
wasn't sure if those formats were just for I2S or not

>> +	switch (cmd) {
>> +	case SNDRV_PCM_TRIGGER_START:
>> +	case SNDRV_PCM_TRIGGER_RESUME:
>> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>> +		reg = img_prl_out_readl(prl, IMG_PRL_OUT_CTL);
>> +		reg |= IMG_PRL_OUT_CTL_ME_MASK;
>> +		img_prl_out_writel(prl, reg, IMG_PRL_OUT_CTL);
>> +		prl->active = true;
>> +		break;
>> +	case SNDRV_PCM_TRIGGER_STOP:
>> +	case SNDRV_PCM_TRIGGER_SUSPEND:
>> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>> +		img_prl_out_reset(prl);
>> +		prl->active = false;
>> +		break;
> 
> No need for locking on the reset (and doesn't this mean that the control
> state is going to be changed underneath userspace)?
> 

The reset function restores the setting after the reset
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
