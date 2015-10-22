From: Damien Horsley <Damien.Horsley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH V2 02/10] ASoC: img: Add driver for I2S input
 controller
Date: Thu, 22 Oct 2015 20:09:38 +0100
Message-ID: <56293472.7000401@imgtec.com>
References: <1444653637-14711-1-git-send-email-Damien.Horsley@imgtec.com>
 <1444653637-14711-3-git-send-email-Damien.Horsley@imgtec.com>
 <20151019174732.GG32054@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151019174732.GG32054-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, James Hartley <James.Hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 19/10/15 18:47, Mark Brown wrote:
> On Mon, Oct 12, 2015 at 01:40:29PM +0100, Damien Horsley wrote:
> 
>> +static inline u32 img_i2s_in_ch_disable(struct img_i2s_in *i2s, u32 chan)
>> +{
>> +	u32 reg;
>> +
>> +	reg = img_i2s_in_ch_readl(i2s, chan, IMG_I2S_IN_CH_CTL);
>> +	reg &= ~IMG_I2S_IN_CH_CTL_ME_MASK;
>> +	img_i2s_in_ch_writel(i2s, chan, reg, IMG_I2S_IN_CH_CTL);
>> +
>> +	return reg;
>> +}
>> +
>> +static inline void img_i2s_in_ch_enable(struct img_i2s_in *i2s, u32 chan,
>> +					u32 reg)
>> +{
>> +	reg |= IMG_I2S_IN_CH_CTL_ME_MASK;
>> +	img_i2s_in_ch_writel(i2s, chan, reg, IMG_I2S_IN_CH_CTL);
>> +}
> 
> The APIs here all seem a bit odd - for example the enable API taking a
> register value as an argument (normally reg is a register address BTW)
> and returning a value but the disable API doing a read/modify/write
> cycle.
>

Sure. It reduces the number of register accesses this way, but the
difference in execution time is not significant. Would you prefer these
to both do read-modify-writes?

>> +static inline void img_i2s_in_flush(struct img_i2s_in *i2s)
>> +{
>> +	int i;
>> +	u32 reg;
>> +
>> +	for (i = 0; i < i2s->active_channels; i++) {
>> +		reg = img_i2s_in_ch_disable(i2s, i);
>> +		reg |= IMG_I2S_IN_CH_CTL_FIFO_FLUSH_MASK;
>> +		img_i2s_in_ch_writel(i2s, i, reg, IMG_I2S_IN_CH_CTL);
>> +		reg &= ~IMG_I2S_IN_CH_CTL_FIFO_FLUSH_MASK;
>> +		img_i2s_in_ch_writel(i2s, i, reg, IMG_I2S_IN_CH_CTL);
>> +		img_i2s_in_ch_enable(i2s, i, reg);
>> +	}
>> +}
> 
> This all seems to be connected to this, which is itself slightly funky
> especially in the context of the only user...
> 

They are also used during hw_params and set_format.

>> +	case SNDRV_PCM_TRIGGER_STOP:
>> +	case SNDRV_PCM_TRIGGER_SUSPEND:
>> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>> +		reg = img_i2s_in_readl(i2s, IMG_I2S_IN_CTL);
>> +		reg &= ~IMG_I2S_IN_CTL_ME_MASK;
>> +		img_i2s_in_writel(i2s, reg, IMG_I2S_IN_CTL);
>> +		img_i2s_in_flush(i2s);
>> +		break;
> 
> ...which looks like it'll enable everything, then disable and reenable.
> Plus needing to do a flush on trigger seems weird.
> 

If the FIFOs are not flushed, some samples from the previous stream will
be transferred to the user application when the block is started again

>> +	if ((channels < 2) ||
>> +			(channels > (i2s->max_i2s_chan * 2)) ||
>> +			(channels % 2))
>> +		return -EINVAL;
> 
> This indentation is very weird.
> 

Ok. What is the correct indentation for this?

>> +	control_mask = (u32)(~IMG_I2S_IN_CTL_16PACK_MASK &
>> +			~IMG_I2S_IN_CTL_ACTIVE_CHAN_MASK);
> 
>> +	chan_control_mask = (u32)(~IMG_I2S_IN_CH_CTL_16PACK_MASK &
>> +			~IMG_I2S_IN_CH_CTL_FEN_MASK &
>> +			~IMG_I2S_IN_CH_CTL_FMODE_MASK &
>> +			~IMG_I2S_IN_CH_CTL_SW_MASK &
>> +			~IMG_I2S_IN_CH_CTL_FW_MASK &
>> +			~IMG_I2S_IN_CH_CTL_PACKH_MASK);
> 
> This also looks very odd.  Normally we'd write masks as being the valid
> bits and or them together.
> 

Ok

>> +	i2s->clk_sys = devm_clk_get(dev, "sys");
>> +	if (IS_ERR(i2s->clk_sys))
>> +		return PTR_ERR(i2s->clk_sys);
> 
> Please print an error message so people can tell why things failed.
>

Ok


>> +	rst = devm_reset_control_get(dev, "rst");
>> +	if (IS_ERR(rst)) {
>> +		dev_dbg(dev, "No top level reset found\n");
> 
> You should check for -EPROBE_DEFER here and just return the error here
> if you get it (on the basis that the reset framework ought to be using a
> different error if there's nothing bound in DT).
> 

Ok
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
