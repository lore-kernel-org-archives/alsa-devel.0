From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: pxassp dma pointer not moving
Date: Sun, 22 Feb 2009 22:22:59 +0000
Message-ID: <1235341379.27887.550.camel@vega.slimlogic.co.uk>
References: <20090222214721.GB5893@buzzloop.caiaq.de>
	<1235340477.27887.541.camel@vega.slimlogic.co.uk>
	<20090222221657.GC5893@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from slimlogic.co.uk (slimlogic.co.uk [89.16.172.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 80143244D8
	for <alsa-devel@alsa-project.org>; Sun, 22 Feb 2009 23:23:00 +0100 (CET)
In-Reply-To: <20090222221657.GC5893@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2009-02-22 at 23:16 +0100, Daniel Mack wrote:
> Hi Liam,
> 
> On Sun, Feb 22, 2009 at 10:07:57PM +0000, Liam Girdwood wrote:
> > > I'm currently implementing support for a board based on a PXA300 with an
> > > I2S codec (CS4270) next to it. Things do work in general, including the
> > > setup of the SSP engine and clocks, and when using the OSS compat layer,
> > > I can see data on the bus. With the native ALSA API, however, the DMA
> > > pointer does not move forward but is stuck at position 8. ALSA's core
> > > calls pxa2xx_pcm_pointer() a couple of times and eventually gives up on
> > > it. Unfortunately, I don't have a Zylonite board for cross-check; could
> > > anyone verify that things are not currently broken in a general way?
> > > 
> > > My code base is up-to-date to sound-2.6.git/for-2.6.30.
> > 
> > Can't test on my zylonite atm, but static DMA pointers usually mean data
> > is not being clocked out of the SSP FIFO. Can you check you are
> > supplying a BCLK and LRC to the SSP port (if codec is BCLK/LRC master)
> > or have enabled the PXA SSP master mode (if codec slave).
> 
> All the clocks are there, they're only driven by the Codec, and they look
> fine. And thus, the CPU DAI is set to SND_SOC_DAIFMT_CBM_CFM.
> 
> What puzzles me is that the whole system works when I cat /dev/urandom
> to /dev/dsp (the DMA pointer is moving forward just as expected), only
> when using aplay it doesn't do anything.

Ah, Please see later email re buildroot. Interestingly someone had
exactly the same issue (on OMAP iirc) with buildroot alsa-lib on
#alsa-soc last week.

Liam  
