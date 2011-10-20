From: David Jander <david.jander@protonic.nl>
Subject: Re: ASoC driver parts probing order (MPC5200/MPC5121)
Date: Thu, 20 Oct 2011 13:37:58 +0200
Message-ID: <20111020133758.27011ac7@archvile>
References: <20111020122317.6c705289@archvile>
	<20111020105940.GB2379@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from protonic.xs4all.nl (protonic.xs4all.nl [213.84.116.84])
	by alsa0.perex.cz (Postfix) with ESMTP id 59C9724756
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Oct 2011 13:37:46 +0200 (CEST)
In-Reply-To: <20111020105940.GB2379@pengutronix.de>
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


Hi Wolfram,

Thanks for replying.

On Thu, 20 Oct 2011 12:59:40 +0200
Wolfram Sang <w.sang@pengutronix.de> wrote:

> Hi David,
> 
> > I am writing a AC97 ASoC driver for the MPC5121e SoC from Freescale. This
> > SoC has almost the same PSC (Programmable Serial Controllers) as the
> > MPC5200B, for which there already is an AC97 driver:
> > sound/soc/fsl/mpc5200-ac97.c, so I'd like to extend that one to also
> > support the MPC5121e.
> 
> Yes, this seems feasible. It has been done like this for the uart-driver,
> sadly not for the spi-driver :(
> 
> > So obviously, it is supposed that the DMA driver
> > somehow gets probed before the PSC driver, but I can't see where this is
> > enforced. AFAIK, the order is fairly random, so it could be the other way
> 
> Check arch/powerpc/sysdev/bestcomm/bestcomm.c at the end:
> 
> /* If we're not a module, we must make sure everything is setup before  */
> /* anyone tries to use us ... that's why we use subsys_initcall instead */
> /* of module_init. */
> subsys_initcall(mpc52xx_bcom_init);
> 
> while the mpc5121-driver has simply module_init() here. subsys_initcall() is
> also often used for I2C host drivers to ensure client drivers can access them
> early.

I think I was not clear enough. I meant sound/soc/fsl/mpc5200_dma.c, not the
actual Bestcom DMA driver.
Btw, I am writing a DMA-less driver for the MPC5121e for now. It uses the PSC
FIFO and FIFO alarm interrupts. DMA support could be added later, when de
MPC5121 DMA driver becomes capable of doing device IO.
But, if I extend sound/soc/fsl/mpc5200-ac97.c, I will still need to write a
second part doing the actual PCM audio stuff... basically the same thing
sound/soc/fsl/mpc5200_dma.c does, but without DMA. It's the shared drv_data
struct that goes sour.

> > 1.- I can't test it on a MPC5200B, so therefor I need help.
> 
> I can do tests.

If you could try out latest mainline, to see if the driver still works,
that would be great for a start. I am almost certain it either doesn't work
anymore, or you have a 50% chance it crashes while booting.

Best regards,

-- 
David Jander
Protonic Holland.
