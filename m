From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 4/7] ASoC: Add dmaengine PCM helper functions
Date: Wed, 22 Feb 2012 13:32:07 +0000
Message-ID: <20120222133207.GD22562@n2100.arm.linux.org.uk>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
	<1329904151-5927-5-git-send-email-lars@metafoo.de>
	<20120222132107.GD7340@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 54F7B103F8E
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 14:32:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120222132107.GD7340@opensource.wolfsonmicro.com>
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Ryan Mallon <rmallon@gmail.com>, alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Wolfram Sang <w.sang@pengutronix.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mika Westerberg <mika.westerberg@iki.fi>, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 22, 2012 at 01:21:08PM +0000, Mark Brown wrote:
> On Wed, Feb 22, 2012 at 10:49:08AM +0100, Lars-Peter Clausen wrote:
> > This patch adds a set of functions which are intended to be used when
> > implementing a dmaengine based sound PCM driver.
> 
> Looks good - if you need to resend then:
> 
> > + * Note that this function will use private_data field of the substream's
> > + * runtime. So it is not availabe to your pcm driver implementation. If you need
> > + * to keep additional data attached to a substream use
> > + * snd_dmaeinge_pcm_{set,get}_data.
> 
> there's a typo here but no need to resend just for that.
> 
> I'd like to see some review from both Morimoto-san as we should convert
> fsi over to this too, Vinod I guess you're also pretty much happy given
> your comments on the previous version?
> 
> For the non-cyclic DMAs the idea of emulating at the dmaengine layer
> does seem very sensible but if that's hard then having the code at the
> ASoC level and pushing it down later seems fine.  We do have several
> platforms with non-cyclic DMA so it's a general need.

I think you're making the assumption that other people need cyclic
transfers.  I've seen little evidence that anyone other than sound
needs such things, so I don't think there's justification to push
this code into every DMA engine driver.

Remember, there's no common code to a DMA engine driver at all,
everyone implements their own way with their own bugs.  I would agree
with you if there was some decent DMA engine infrastructure to abstract
out such things, but there isn't.

So what you're asking is for N different ways of doing this, instead of
having one centralized way.
