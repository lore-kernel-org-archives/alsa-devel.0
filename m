From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 00/10] ASoC: Introduce dmaengine pcm helper
	functions
Date: Wed, 22 Feb 2012 11:20:10 +0000
Message-ID: <20120222112010.GY22562@n2100.arm.linux.org.uk>
References: <1329842884-9757-1-git-send-email-lars@metafoo.de>
	<20120222081908.GB21820@S2101-09.ap.freescale.net>
	<20120222090307.GQ22562@n2100.arm.linux.org.uk>
	<20120222105003.GB7205@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 1E201103BCC
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 12:20:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120222105003.GB7205@opensource.wolfsonmicro.com>
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Ryan Mallon <rmallon@gmail.com>, alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Wolfram Sang <w.sang@pengutronix.de>, Mika Westerberg <mika.westerberg@iki.fi>, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 22, 2012 at 10:50:04AM +0000, Mark Brown wrote:
> On Wed, Feb 22, 2012 at 09:03:07AM +0000, Russell King - ARM Linux wrote:
> 
> > I have developed a standard DMA engine ASoC driver tested on SA11x0 for
> > playback only (that's because SA11x0 requires playback DMA to be active
> > for capture to work, and ASoC doesn't support that.)
> 
> Eew, that does sound like a rather spectacular hardware fail.  What's
> the root of the restriction?  Since I've never heard of any other
> hardware with a similar requirement and would be surprised to see any
> I'd be comfortable with a driver specific bodge to keep playback
> running whenever there's a capture.

It comes from the fact that the SSP interface only clocks when there's
DMA _to_ the transmit side.  It's a SSP (Microwire/SPI etc) interface
which has been adapted through a FPGA to drive audio codecs.  As such,
every SA11x0 based platform does this.

> > I've not yet posted it, mainly because it's there by accident, along with
> > the rest of the SA11x0 Assabet stuff (it's part of my testing for the
> > SA11x0 DMA engine code.)
> 
> Can you guys take a look at each other's code and see what the overlap
> is please?  Looking through it seems like the final result probably
> wants to be a merge of both.
> 
> It'd also be nice to get as much as we can of the sa11x0 support merged,
> glancing at the code there's quite a few updates I'd like to see like
> more use of devm_ and moving over to using snd_soc_register_card() (you
> shouldn't be registering any devices at all in your machine driver,
> though I've no idea what's going on with L3, perhaps you need to
> register something for that).

L3 is a total abortion - read the comments in the assabet code about it.
The L3 clock and data pins share the I2C bus pins on the assabet.  This
is something that my original L3 driver supported but that's long since
bitten the dust.  Moreover, the ALSA L3 stuff doesn't allow it to be used
with the SA1111 companion device, because that bus isn't bitbanged.  Again,
that's something my original L3 code supported.

Getting that sorted properly is going to be not nice on assabet because it
requires a lock to be shared between the L3 and I2C code.  I don't think
it's worth doing for just one platform.
