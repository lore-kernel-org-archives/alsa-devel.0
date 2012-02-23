From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [RFC 4/7] ASoC: Add dmaengine PCM helper functions
Date: Thu, 23 Feb 2012 12:27:18 +0530
Message-ID: <1329980238.24656.132.camel@vkoul-udesk3>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
	<1329904151-5927-5-git-send-email-lars@metafoo.de>
	<20120222132107.GD7340@opensource.wolfsonmicro.com>
	<20120222133207.GD22562@n2100.arm.linux.org.uk>
	<20120222133939.GK7340@opensource.wolfsonmicro.com>
	<20120222142236.GF22562@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C558104044
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 07:55:42 +0100 (CET)
In-Reply-To: <20120222142236.GF22562@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Ryan Mallon <rmallon@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wolfram Sang <w.sang@pengutronix.de>, Mika Westerberg <mika.westerberg@iki.fi>, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-02-22 at 14:22 +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 22, 2012 at 01:39:39PM +0000, Mark Brown wrote:
> > Well, Vinod seemed to also think that dmaengine ought to be able to cope
> > with emulating this and I really don't see why it shouldn't be.  It does
> > know the capabilities of the underlying driver and it gets to look at
> > all the calls going into the driver before the driver does.  If ASoC can
> > interpose itself I don't see why dmaengine can't.
> 
> Have you ever looked at the DMA engine drivers?  It's a total mess.
> Even something as basic as the DMA engine driver assigning a cookie to
> the descriptor is implemented in each driver in their own unique way.
> 
> Completion of DMA descriptors is a similar thing - every driver implements
> this in their own unique way.
> 
> The only really common thing in the DMA engine drivers is that they all
> share the same API.  Nothing much more than that is shared.
> 
> It's something I have been chipping away at for a while, trying to extract
> out common parts into a library, but it's really not that easy.
> 
> So, there's no way in hell that I want to see any more stuff pushed down
> into the DMA engine drivers until we have a proper DMA engine library in
> place to stop all this idiotic code duplication throughout every driver.
> Especially if it means everyone will be implementing their own cyclic
> emulation in their individual drivers.
> 
> And lets not forget that it's not just a question of "oh we can just queue
> up buffer after buffer".  Doing it properly for audio does need to ensure
> that the DMA engine driver is capable of getting the next buffer chained
> into the hardware before the previous buffer has completed, so the transfer
> continues across a buffer boundary without needing the intervention of an
> interrupt handler.  Otherwise you get glitches in the audio.
> 
> So, there's a lot more here that DMA engine stuff needs to get fixed than
> just a simple "layer on top".
I would agree with Russell that some of dma drivers are messy, but then
were also a victim of ambiguous API. Now at least we have a clear
direction of what is expected out of dma driver and what is not. Except
for channel mapping stuff, rest has a clarity.

So the new drivers and fixes now are going in the right direction
(hopefully you will agree with me on this) and we are frankly in much
better state then we were one year back.

Said that, we still have lot of work to do to improve :)
And I see this as another opportunity. Having a common library for these
kind of common subsystem operations forces people to write proper driver
and forces them to fix existing issue. Now, new support for DMAengine in
asoc wont come without using this library and if it does work on a
particular driver that is precondition for fixes as well.

Similarly I would really love to see such libraries in other subsystems
which would help us in making the usage of dmaengine and dmac standard
and straight forward for users.

-- 
~Vinod
