From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 4/7] ASoC: Add dmaengine PCM helper functions
Date: Wed, 22 Feb 2012 14:22:36 +0000
Message-ID: <20120222142236.GF22562@n2100.arm.linux.org.uk>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
	<1329904151-5927-5-git-send-email-lars@metafoo.de>
	<20120222132107.GD7340@opensource.wolfsonmicro.com>
	<20120222133207.GD22562@n2100.arm.linux.org.uk>
	<20120222133939.GK7340@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id CDD3710407A
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 15:23:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120222133939.GK7340@opensource.wolfsonmicro.com>
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

On Wed, Feb 22, 2012 at 01:39:39PM +0000, Mark Brown wrote:
> Well, Vinod seemed to also think that dmaengine ought to be able to cope
> with emulating this and I really don't see why it shouldn't be.  It does
> know the capabilities of the underlying driver and it gets to look at
> all the calls going into the driver before the driver does.  If ASoC can
> interpose itself I don't see why dmaengine can't.

Have you ever looked at the DMA engine drivers?  It's a total mess.
Even something as basic as the DMA engine driver assigning a cookie to
the descriptor is implemented in each driver in their own unique way.

Completion of DMA descriptors is a similar thing - every driver implements
this in their own unique way.

The only really common thing in the DMA engine drivers is that they all
share the same API.  Nothing much more than that is shared.

It's something I have been chipping away at for a while, trying to extract
out common parts into a library, but it's really not that easy.

So, there's no way in hell that I want to see any more stuff pushed down
into the DMA engine drivers until we have a proper DMA engine library in
place to stop all this idiotic code duplication throughout every driver.
Especially if it means everyone will be implementing their own cyclic
emulation in their individual drivers.

And lets not forget that it's not just a question of "oh we can just queue
up buffer after buffer".  Doing it properly for audio does need to ensure
that the DMA engine driver is capable of getting the next buffer chained
into the hardware before the previous buffer has completed, so the transfer
continues across a buffer boundary without needing the intervention of an
interrupt handler.  Otherwise you get glitches in the audio.

So, there's a lot more here that DMA engine stuff needs to get fixed than
just a simple "layer on top".
