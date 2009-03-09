From: Daniel Mack <daniel@caiaq.de>
Subject: Re: snd-soc-pxa-ssp I2C/FIFO issues
Date: Mon, 9 Mar 2009 17:16:01 +0100
Message-ID: <20090309161601.GC24787@buzzloop.caiaq.de>
References: <74d0deb30903090747p3fbb8dd5l27cd7313d4be7de2@mail.gmail.com>
	<1236610986.6781.93.camel@vega.slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 066481037EA
	for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2009 17:16:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1236610986.6781.93.camel@vega.slimlogic.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@kernel.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 09, 2009 at 03:03:06PM +0000, Liam Girdwood wrote:
> On Mon, 2009-03-09 at 15:47 +0100, pHilipp Zabel wrote:
> > Ok,
> > 
> > I'm not sure how to handle this correctly.
> > 
> > Magician needs stereo S16_LE input data from alsa, DAIFMT_DSP_A on the
> > wire with a frame size of 16 bit (one frame for each channel) and thus
> > 2-byte DMA transfers to the FIFO (currently called 'mono' DMA params).
> > Zylonite's current code uses 32 bit frame size and 4-byte DMA
> > transfers to emulate I2S (S16_LE,stereo). Network mode seems to work,
> > so it could be changed to use two 16 bit slots instead with 2-byte DMA
> > transfers (which would make Magician happy). But...
> > Daniel's board needs very strange settings because network mode
> > doesn't work, so I guess he can't use 2-byte DMA transfers. Is that
> > correct?
> > 
> > If we can't find a way to have all machines use the mono DMA params,
> > there has to be some kind of interface to set the width of the data in
> > the FIFO independently from the Alsa format. How should that interface
> > look like?
> 
> Btw, what pxa processor variants are you and Daniel using ?

PXA300 in my case.

> Iirc, PXA3x SSP is quite different in terms of "usability" compared to
> to PXA2x SSP. It might be worth diverging the SSP code a little here if
> your CPUs are different.

The SSP registers are indeed different (or at least PXA3xx has features
PXA2xx lacks), so it could be we end up with some special cases for the
format I described in my other mail. Maybe PXA2xx's SSPs won't support
that format at all or the need some special treatmeant with other
register magic to be found out by more nasty trial-and-error.

My plan is to only conditionally support that format my board needs for
PXA3s now until someone finds some time to test that on a different
processor. Now the only remaining question is how to pass that
information to the CPU DAI ;)

Daniel
