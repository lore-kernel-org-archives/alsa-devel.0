From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC - Add support for upto 16 channels on
 OMAP MCBSP
Date: Thu, 05 Nov 2009 14:55:30 +0000
Message-ID: <1257432930.3603.902.camel@odin>
References: <1257357235.2887.499.camel@odin>
	<20091104185534.GA22055@xora.vm.bytemark.co.uk>
	<1257364009.2887.665.camel@odin>
	<20091105095143.995beeea.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f221.google.com (mail-ew0-f221.google.com
	[209.85.219.221])
	by alsa0.perex.cz (Postfix) with ESMTP id 74EDF24376
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2009 15:55:36 +0100 (CET)
Received: by ewy21 with SMTP id 21so144153ewy.32
	for <alsa-devel@alsa-project.org>; Thu, 05 Nov 2009 06:55:35 -0800 (PST)
In-Reply-To: <20091105095143.995beeea.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Graeme Gregory <gg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, 2009-11-05 at 09:51 +0200, Jarkko Nikula wrote:
> On Wed, 04 Nov 2009 19:46:49 +0000
> Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> 
> > > > +	/* calc best frame size for rate and clock divider */
> > > > +	do {
> > > > +		frame_size = (mcbsp_data->in_freq / div) / params_rate(params);
> > > > +		pr_debug("freq %d, rate %d, frame size %d, div %d\n",
> > > > +				mcbsp_data->in_freq, params_rate(params), frame_size, div);
> > > > +
> > > > +		if (frame_size > 256)
> > > > +			div++;
> > > > +	} while (frame_size > 256);
> > > > +
> 
> This would be better if it tries to calculate minimum frame size. Now
> the algorithm stops when the frame_size is 256 and leads to higher
> bit clock.
> 
> E.g. 4 * 16bits * 48 kHz and using 96 MHz internal clock:
> 
> Algorithm: div = 8, frame_size = 250 and bit clock = 12 MHz.
> 
> Possible dividers and frame_sizes:
> 
> 25*80 (-> best, bit clock = 3.840 MHz)
> 20*100
> 16*125
> 10*200
> 8*250
> 

I've reworked this myself now. It does appear that the current FPER
calculations assume BCLK scales with rate 

i.e. BCLK = rate * channels * word len

This is fine for when McBSP is FRM/BCLK slave (all users except pandora)
as FPER should be ignored internally.

However, when BCLK is constant (e.g. McBSP BCLK derived from constant
source) and we run McBSP as FRM/BCLK master we currently break our
sample rate generation.

Imho, it's better to generate FPER based upon BCLK and rate. e.g. we
calculate the frame size required for the given BCLK and rate.

/* In McBSP master modes, FRAME (i.e. sample rate) is generated
 * by _counting_ BCLKs. Calculate frame size in BCLKs */
div = mcbsp_data->clk_div ? mcbsp_data->clk_div : 1;
framesize = (mcbsp_data->in_freq / div) / params_rate(params);

if (framesize < wlen * channels) {
	printk(KERN_ERR "%s: not enough bandwidth for desired rate and channels\n",
			__func__);
	return -EINVAL;
}

/* Set FS period and length in terms of bit clock periods */
switch (format) {
case SND_SOC_DAIFMT_I2S:
	regs->srgr2	|= FPER(framesize - 1);
	regs->srgr1	|= FWID((framesize >> 1) - 1);
	break;
case SND_SOC_DAIFMT_DSP_A:
case SND_SOC_DAIFMT_DSP_B:
	regs->srgr2	|= FPER(framesize - 1);
	regs->srgr1	|= FWID(0);
	break;
}


I'm now slightly curious about how pandora handles different rates since
it uses the McBSP in master mode too. I guess they can only handle a
single sample rate ?

Liam
