From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch 5/6] kirkwood: Add i2s support
Date: Wed, 12 May 2010 15:59:44 +0100
Message-ID: <20100512145944.GD8082@rakim.wolfsonmicro.main>
References: <20100511162342.640158675@mandriva.com>
	<20100511162602.475198903@mandriva.com>
	<20100512102419.GF4330@rakim.wolfsonmicro.main>
	<m339xxuqvy.fsf@anduin.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6C0831038AC
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 16:59:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <m339xxuqvy.fsf@anduin.mandriva.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arnaud Patard <apatard@mandriva.com>
Cc: alsa-devel@alsa-project.org, nico@fluxnic.net, saeed@marvell.com, tbm@cyrius.com
List-Id: alsa-devel@alsa-project.org

On Wed, May 12, 2010 at 04:38:25PM +0200, Arnaud Patard wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:
> > On Tue, May 11, 2010 at 06:23:47PM +0200, apatard@mandriva.com wrote:

> >> +		if (status & ~(KIRKWOOD_INT_CAUSE_PLAY_BYTES | \
> >> +				KIRKWOOD_INT_CAUSE_REC_BYTES))
> >> +			return IRQ_NONE;

> > Surely it'd make sense to log the unexpected interrupts for diagnostics?
> > You should never get here if there are no interrupts you've enabled.
> > Unless the interrupt is shared, but that'd be a bit surprising for a
> > SoC.

> it's not shared iirc but there are different possible interrupt
> cause. There used to be a message but I think it has been removed by
> error. Should I had it back or remove the check ? (I prefer adding it
> back but your point of view does matter).

Add it back and also log it, but also fix the IRQ_NONE thing - it's
defintiely going to be wrong if this is the second spin through the loop
for example.

> > It also looks like it'd be more sensible to either drop the do/while
> > loop entirely (the IRQ core should handle the interrupt still being
> > asserted and it doesn't look like any of the handling should take so
> > long that interrupts reassert while it's running anyway) or move the
> > handling of error interrupts and the first read into the loop so you
> > don't have two slightly different paths.

> The loop is there to handle playback and record interrupts at the same

Why is this required?  You check both interrupts in sequence anyway.

> time. As regards the error interrupts, I preferred to put outside the
> loop to differentiate "normal" interrupts from "error" interrupts.

Actually looking again they are in a separate status register too so I
suppose that's not quite so bad.  It is a bit odd that they all come in
on the same status line and can't be muxed out from a single register
but hardware designers are like that sometimes.

> >> +		mask = readl(priv->io + KIRKWOOD_INT_MASK);
> >> +		status = readl(priv->io + KIRKWOOD_INT_CAUSE) & mask;

> > This masking didn't happen prior to the first entry into the loop.

> Can you explain a little bit more ? at the beginning of the function,
> there are the 2 same lines.

I was looking at the read of cause there, I hadn't noticed the separate
status register.

> >> +static int kirkwood_dma_mmap(struct snd_pcm_substream *substream,
> >> +		struct vm_area_struct *vma)
> >> +{
> >> +	struct snd_pcm_runtime *runtime = substream->runtime;
> >> +
> >> +	return dma_mmap_coherent(substream->pcm->card->dev, vma,
> >> +					runtime->dma_area,
> >> +					runtime->dma_addr,
> >> +					runtime->dma_bytes);
> >> +}

> > Hrm, this looks like there should be a utility function to do it, it's
> > not terribly driver specific.

> hmm... I need to double check. I got some troubles with this kind of
> stuff on my ST LS2E/F mips platforms, so I wrote something known to be
> working.

The point is that it looks like either there should already be an
implementation of this function you can use or this should be put
somewhere were other folks are able to use it.

> >> +	mv_audio_init(priv->io);

> > Seems a bit odd ot have the separate init function in the middle of a
> > bunch of other register writes.

> I want to have interrupts disable before calling it. I don't want bad
> suprises.

My point is that you may as well just have the mv_audio_init() function
in line in the code here, jumping out into another function seems a bit
odd when all it is is more register writes.
