From: David Jander <david.jander@protonic.nl>
Subject: Re: ASoC driver parts probing order (MPC5200/MPC5121)
Date: Thu, 20 Oct 2011 14:27:02 +0200
Message-ID: <20111020142702.5e2e1929@archvile>
References: <20111020122317.6c705289@archvile>
	<20111020105940.GB2379@pengutronix.de>
	<20111020133758.27011ac7@archvile>
	<20111020121303.GE2379@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from protonic.xs4all.nl (protonic.xs4all.nl [213.84.116.84])
	by alsa0.perex.cz (Postfix) with ESMTP id CF74924765
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Oct 2011 14:26:49 +0200 (CEST)
In-Reply-To: <20111020121303.GE2379@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


Hi Wolfram!

On Thu, 20 Oct 2011 14:13:03 +0200
Wolfram Sang <w.sang@pengutronix.de> wrote:

> > I think I was not clear enough. I meant sound/soc/fsl/mpc5200_dma.c, not
> > the actual Bestcom DMA driver.
> 
> Ah, okay, sorry misunderstood that.

Never mind, I was too hasty to explain correctly what I meant ;-)

> > Btw, I am writing a DMA-less driver for the MPC5121e for now. It uses the
> > PSC FIFO and FIFO alarm interrupts. DMA support could be added later, when
> > de MPC5121 DMA driver becomes capable of doing device IO.
> 
> OK, seems sensible for a start. MPC5121 does not get much love, so small
> steps are definately a good idea.

Yes :-(
This platform could get a big boost just by having open-sourced GPU drivers
for example, but that is never going to happen, and the binary drivers are
completely broken and useless.... so no GPU here.

> > > > 1.- I can't test it on a MPC5200B, so therefor I need help.
> > > 
> > > I can do tests.
> > 
> > If you could try out latest mainline, to see if the driver still works,
> > that would be great for a start. I am almost certain it either doesn't work
> > anymore, or you have a 50% chance it crashes while booting.
> 
> OK, I will leave for Prague in the next hours, so until I return, I can
> do only remote testing. But I should see OOPSes this way nonetheless.
> Might take a few days, though...

Ah, you have it hooked up the the Pengutronix remote workbench? Cool!
Have a nice trip :-)

Best regards,

-- 
David Jander
Protonic Holland.
