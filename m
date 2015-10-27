From: Damien Horsley <Damien.Horsley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH V2 02/10] ASoC: img: Add driver for I2S input
 controller
Date: Tue, 27 Oct 2015 13:55:27 +0000
Message-ID: <562F824F.9070407@imgtec.com>
References: <1444653637-14711-1-git-send-email-Damien.Horsley@imgtec.com>
 <1444653637-14711-3-git-send-email-Damien.Horsley@imgtec.com>
 <20151019174732.GG32054@sirena.org.uk> <56293472.7000401@imgtec.com>
 <20151023225723.GO29919@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151023225723.GO29919-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, James Hartley <James.Hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org



On 23/10/15 23:57, Mark Brown wrote:
> On Thu, Oct 22, 2015 at 08:09:38PM +0100, Damien Horsley wrote:
>> On 19/10/15 18:47, Mark Brown wrote:
>>> On Mon, Oct 12, 2015 at 01:40:29PM +0100, Damien Horsley wrote:
> 
>>> The APIs here all seem a bit odd - for example the enable API taking a
>>> register value as an argument (normally reg is a register address BTW)
>>> and returning a value but the disable API doing a read/modify/write
>>> cycle.
> 
>> Sure. It reduces the number of register accesses this way, but the
>> difference in execution time is not significant. Would you prefer these
>> to both do read-modify-writes?
> 
> I would prefer that the functions look consistent with each other and
> ideally resemble common register acceess idioms in the kernel.
> 

Ok.

>>>> +static inline void img_i2s_in_flush(struct img_i2s_in *i2s)
>>>> +{
>>>> +	int i;
>>>> +	u32 reg;
>>>> +
>>>> +	for (i = 0; i < i2s->active_channels; i++) {
>>>> +		reg = img_i2s_in_ch_disable(i2s, i);
>>>> +		reg |= IMG_I2S_IN_CH_CTL_FIFO_FLUSH_MASK;
>>>> +		img_i2s_in_ch_writel(i2s, i, reg, IMG_I2S_IN_CH_CTL);
>>>> +		reg &= ~IMG_I2S_IN_CH_CTL_FIFO_FLUSH_MASK;
>>>> +		img_i2s_in_ch_writel(i2s, i, reg, IMG_I2S_IN_CH_CTL);
>>>> +		img_i2s_in_ch_enable(i2s, i, reg);
>>>> +	}
>>>> +}
> 
>>> This all seems to be connected to this, which is itself slightly funky
>>> especially in the context of the only user...
> 
>> They are also used during hw_params and set_format.
> 
> My point is that the flush function has only one user.
> 
>>>> +	case SNDRV_PCM_TRIGGER_STOP:
>>>> +	case SNDRV_PCM_TRIGGER_SUSPEND:
>>>> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>>>> +		reg = img_i2s_in_readl(i2s, IMG_I2S_IN_CTL);
>>>> +		reg &= ~IMG_I2S_IN_CTL_ME_MASK;
>>>> +		img_i2s_in_writel(i2s, reg, IMG_I2S_IN_CTL);
>>>> +		img_i2s_in_flush(i2s);
>>>> +		break;
> 
>>> ...which looks like it'll enable everything, then disable and reenable.
>>> Plus needing to do a flush on trigger seems weird.
> 
>> If the FIFOs are not flushed, some samples from the previous stream will
>> be transferred to the user application when the block is started again
> 
> Shouldn't we be doing that flush on stream close instead?  If nothing
> else the flush is going to discard a bit of data if the stream is just
> paused.
> 

The FIFOs are only 8 frames in size, so I am not sure there is an
issue with these frames being lost.

I think it also makes sense to keep the blocks consistent with each
other. The spdif (out and in), and parallel out, all flush automatically
when stopped, and the fifo for the i2s out block is cleared when the
reset is asserted.

>>>> +	if ((channels < 2) ||
>>>> +			(channels > (i2s->max_i2s_chan * 2)) ||
>>>> +			(channels % 2))
>>>> +		return -EINVAL;
> 
>>> This indentation is very weird.
> 
>> Ok. What is the correct indentation for this?
> 
> Align the continuation lines of the if condition with the first line.
> 

Ok
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
