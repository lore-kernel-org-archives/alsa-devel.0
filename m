From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: About the platform_name field in snd_soc_dai_link
Date: Wed, 11 Aug 2010 13:39:30 +0200
Message-ID: <20100811113930.GP27749@pengutronix.de>
References: <20100810133818.GL27749@pengutronix.de>
	<20100810134755.GC6416@rakim.wolfsonmicro.main>
	<1281449769.3059.62.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id ACEB510385D
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 13:39:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1281449769.3059.62.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 10, 2010 at 03:16:09PM +0100, Liam Girdwood wrote:
> On Tue, 2010-08-10 at 14:47 +0100, Mark Brown wrote:
> > On Tue, Aug 10, 2010 at 03:38:18PM +0200, Sascha Hauer wrote:
> > 
> > > I'm wondering what exactly a snd_soc_platform is. Apparently the
> > > snd_pcm_ops/pcm_new/pcm_free are specific to a platform. For my
> > > understanding these operations are more specific to a cpu_dai. Looking
> > > at the tree it seems that each cpu_dai has exactly one possible
> > > platform, which seems logical to me because the cpu_dai knows how to
> > > transfer the data.
> > 
> > They're for the DMA bit of the CPU.  While most platforms have a single
> > DMA controller (though some have more than one) it's moderately common
> > to have more than one DAI (eg, dedicated I2S and DSP mode controllers
> > rather than a programmable serial port, or an AC'97 controller) so it's
> > useful to share the DMA code.
> > 
> > > My problem on i.MX is that I currently have two possible cpu dais
> > > (imx-ssi.[01]) and each can be configured to use dma or fiq depending
> > > on the dma capabilities. So the cpu_dai knows which pcm_ops we have
> > > to use, but currently it's the soc glue code which has to decide in
> > > platform_name. Am I understanding something wrong here?
> > 
> > This is mostly a holdover from the existing (current mainline) ASoC
> > structuring at the minute, that also has the DMA configured per machine.
> > This may change depending on future hardware requirements, though.
> > _______________________________________________
> 
> With multi-component it's possible to register both FIQ and DMA platform
> together. i.e. ssi0 could use DMA and ssi1 FIQ.

Whether we have to use FIQ depends on the codec connected (given that
DMA is available, which is not yet the case). On the phyCORE board we
have a wm9712 codec. This codec sends us data gpio status data in slot
12. The i.MX hardware is silly enough to put this data into the rx fifo,
so the fiq handler has to sort out this data.

In the longer term we want to use DMA for everything, but first we have
to extend the pcm-dma to sort aout this data aswell.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
