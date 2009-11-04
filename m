From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC - Add support for upto 16 channels on
	OMAP MCBSP
Date: Wed, 04 Nov 2009 19:46:49 +0000
Message-ID: <1257364009.2887.665.camel@odin>
References: <1257357235.2887.499.camel@odin>
	<20091104185534.GA22055@xora.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f221.google.com (mail-ew0-f221.google.com
	[209.85.219.221])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B58F24454
	for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2009 20:46:51 +0100 (CET)
Received: by ewy21 with SMTP id 21so12858182ewy.32
	for <alsa-devel@alsa-project.org>; Wed, 04 Nov 2009 11:46:50 -0800 (PST)
In-Reply-To: <20091104185534.GA22055@xora.vm.bytemark.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Graeme Gregory <gg@slimlogic.co.uk>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2009-11-04 at 18:55 +0000, Graeme Gregory wrote:
> On Wed, Nov 04, 2009 at 05:53:55PM +0000, Liam Girdwood wrote:
> > From: Graeme Gregory <gg@slimlogic.co.uk>
> > 
> > This patch increases the number of supported audio channels from 4
> > to 16 and was sponsored by Shotspotter inc.
> > 
> > Signed-off-by: Graeme Gregory <gg@slimlogic.co.uk>
> > Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
> > +	/* Default div to 1 if it wasn't set by machine driver, otherwise
> > +	 * use set div as the maximum clock value
> > +	 */
> > +	div = mcbsp_data->clk_div ? mcbsp_data->clk_div : 1;
> > +
> > +	/* calc best frame size for rate and clock divider */
> > +	do {
> > +		frame_size = (mcbsp_data->in_freq / div) / params_rate(params);
> > +		pr_debug("freq %d, rate %d, frame size %d, div %d\n",
> > +				mcbsp_data->in_freq, params_rate(params), frame_size, div);
> > +
> > +		if (frame_size > 256)
> > +			div++;
> > +	} while (frame_size > 256);
> > +
> > +	/* Check we can fit the requested number of channels into our
> > +	 * calculated frame size
> > +	 */
> > +	if ((channels * wlen) > frame_size) {
> > +		printk(KERN_ERR
> > +			"OMAP-MCBSP: cannot fit channels in frame size\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Set the actual clkdiv to use for this samplerate */
> > +	regs->srgr1 &= ~CLKGDV(0xFF);
> > +	regs->srgr1 |= CLKGDV(div - 1);
> > +
> 
> This chunk changes the semantics of other devices which I have never tested.
> 
> I also dont know how much damage it does if it does to slave mode. In fact
> I think it might break it in cases which are actually allowable as it uses
> the omap as its clock constraint and not the clock source.
> 

Btw, this has been reworked to avoid all I2S paths since you last worked
on it.

So it looks like we need a conditional around this block for when the
codec is mastering BCLK/FRM and MCBSP is slave (as you stated above).
This will then use the original SRGR2 values for SND_SOC_DAIFMT_DSP_A/B
in codec master mode.

V2 will follow.

Liam
