From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 00/10] ASoC: Introduce dmaengine pcm helper
	functions
Date: Wed, 22 Feb 2012 09:03:07 +0000
Message-ID: <20120222090307.GQ22562@n2100.arm.linux.org.uk>
References: <1329842884-9757-1-git-send-email-lars@metafoo.de>
	<20120222081908.GB21820@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 2232E103AC3
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 10:03:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120222081908.GB21820@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Ryan Mallon <rmallon@gmail.com>, alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wolfram Sang <w.sang@pengutronix.de>, Mika Westerberg <mika.westerberg@iki.fi>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 22, 2012 at 04:19:10PM +0800, Shawn Guo wrote:
> Nice consolidation ...
> 
> On Tue, Feb 21, 2012 at 05:47:54PM +0100, Lars-Peter Clausen wrote:
> > This patch series introduces a new set of helper functions for dmaengine based
> > PCM drivers. Currently we have 6 different dmaengine based PCM drivers which are
> > all more or less similar in structure, but all have also individual requirements
> > which can't easily be generalized.

I have developed a standard DMA engine ASoC driver tested on SA11x0 for
playback only (that's because SA11x0 requires playback DMA to be active
for capture to work, and ASoC doesn't support that.)

It uses the standard scatterlist DMA submission stuff, but could be
expanded to use the cyclic stuff if available.

> I did not notice this patch on any list yet, so am not sure about
> Russell's plan about it.  But it seems this series does not reach
> alsa-devel list either. (forgot?)

I've not yet posted it, mainly because it's there by accident, along with
the rest of the SA11x0 Assabet stuff (it's part of my testing for the
SA11x0 DMA engine code.)
