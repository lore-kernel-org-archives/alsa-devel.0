From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 4/7] ASoC: Add dmaengine PCM helper functions
Date: Wed, 22 Feb 2012 15:23:55 +0000
Message-ID: <20120222152355.GG22562@n2100.arm.linux.org.uk>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
	<1329904151-5927-5-git-send-email-lars@metafoo.de>
	<20120222132107.GD7340@opensource.wolfsonmicro.com>
	<20120222133207.GD22562@n2100.arm.linux.org.uk>
	<20120222133939.GK7340@opensource.wolfsonmicro.com>
	<20120222142236.GF22562@n2100.arm.linux.org.uk>
	<20120222150455.GO7340@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id BA8241040AF
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 16:24:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120222150455.GO7340@opensource.wolfsonmicro.com>
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

On Wed, Feb 22, 2012 at 03:04:56PM +0000, Mark Brown wrote:
> Well, if we can't do it with a layer in the dmaengine code then I don't
> see how we could do it in ASoC either, presumably the issues that block
> doing it in the dmaengine core code would also cause issues doing it in
> ASoC?
> 
> I'm not saying there's nothing that needs fixing in the dmaengine code,
> and like I say I'm not too worried about carrying things in ASoC if the
> dmaengine code is intractably difficult, but I'm not sure that the
> issues you're rasing aren't orthogonal to the issues with emulating
> cyclic transfers.

Look, I spent a number of weeks working on the SA11x0 DMA engine code
and ALSA side to get something which worked reliably, and a simple
solution doesn't work.  I've been looking at the DMA engine code
probably for longer than Vinod has been involved with it.  I've been
working on cleaning up all the DMA engine drivers extracting some of the
common bits from them.  I'm very familiar with level of crap in the DMA
engine stuff.  I know what I'm talking about.

The point that I'm making is that there's more to this than just adding
a layer.  If you think that's all that there is, then you haven't properly
understood the SA11x0 audio support patch set that I have, and the
interactions between the individual patches.  That's not surprising
because I haven't posted the patches yet, and I haven't explained them
either.

And since I'm spending today working on x86 kernel instability (thanks to
Linux for taking out my laptop last night) I've little time to spend
discussing the fine points of this, let alone any other ARM stuff.
