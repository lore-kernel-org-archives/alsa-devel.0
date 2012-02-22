From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [RFC 4/7] ASoC: Add dmaengine PCM helper functions
Date: Wed, 22 Feb 2012 19:00:09 +0530
Message-ID: <1329917409.24656.115.camel@vkoul-udesk3>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
	<1329904151-5927-5-git-send-email-lars@metafoo.de>
	<20120222132107.GD7340@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 62A58103F70
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 14:28:44 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Sascha Hauer <s.hauer@pengutronix.de>, Wolfram Sang <w.sang@pengutronix.de>, Mika Westerberg <mika.westerberg@iki.fi>, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-02-22 at 13:21 +0000, Mark Brown wrote:
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
Sure,
Acked-by :Vinod Koul <vinod.koul@linux.intel.com>
> 
> For the non-cyclic DMAs the idea of emulating at the dmaengine layer
> does seem very sensible but if that's hard then having the code at the
> ASoC level and pushing it down later seems fine.  We do have several
> platforms with non-cyclic DMA so it's a general need.
I think this should be pushed to dmaengine rather than in ASoC. That way
ASoC can always request circular and we emulate the behavior in
dmaengine for dmacs who don't support this


-- 
~Vinod
