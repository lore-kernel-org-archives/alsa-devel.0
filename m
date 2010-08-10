From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: About the platform_name field in snd_soc_dai_link
Date: Tue, 10 Aug 2010 16:09:30 +0200
Message-ID: <20100810140930.GM27749@pengutronix.de>
References: <20100810133818.GL27749@pengutronix.de>
	<20100810134755.GC6416@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 28B932447F
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Aug 2010 16:09:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100810134755.GC6416@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 10, 2010 at 02:47:55PM +0100, Mark Brown wrote:
> On Tue, Aug 10, 2010 at 03:38:18PM +0200, Sascha Hauer wrote:
> 
> > I'm wondering what exactly a snd_soc_platform is. Apparently the
> > snd_pcm_ops/pcm_new/pcm_free are specific to a platform. For my
> > understanding these operations are more specific to a cpu_dai. Looking
> > at the tree it seems that each cpu_dai has exactly one possible
> > platform, which seems logical to me because the cpu_dai knows how to
> > transfer the data.
> 
> They're for the DMA bit of the CPU.  While most platforms have a single
> DMA controller (though some have more than one) it's moderately common
> to have more than one DAI (eg, dedicated I2S and DSP mode controllers
> rather than a programmable serial port, or an AC'97 controller) so it's
> useful to share the DMA code.

I didn't want to question that it's useful to share the code. It's just
that in current i.MX implementation it would be simple to instantiate
snd_pcm_ops (of fiq or dma type) in the platform_driver probe function
passing all needed data like dma request line, fifo address and the like.
Passing this data through the soc-core seems not very convenient.

> 
> > My problem on i.MX is that I currently have two possible cpu dais
> > (imx-ssi.[01]) and each can be configured to use dma or fiq depending
> > on the dma capabilities. So the cpu_dai knows which pcm_ops we have
> > to use, but currently it's the soc glue code which has to decide in
> > platform_name. Am I understanding something wrong here?
> 
> This is mostly a holdover from the existing (current mainline) ASoC
> structuring at the minute, that also has the DMA configured per machine.
> This may change depending on future hardware requirements, though.

I would welcome such change.

/Me is looking further to make the i.MX part working on multi-component.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
