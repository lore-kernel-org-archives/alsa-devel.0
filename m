From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 19/19] ASoC: fsi: Add DMAEngine support
Date: Fri, 03 Feb 2012 15:05:12 +0100
Message-ID: <4F2BE998.4020903@metafoo.de>
References: <871uqcjo9i.wl%kuninori.morimoto.gx@renesas.com>	<87aa50i971.wl%kuninori.morimoto.gx@renesas.com>
	<20120203134850.GM3151@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-085.synserver.de (smtp-out-085.synserver.de
	[212.40.185.85])
	by alsa0.perex.cz (Postfix) with ESMTP id A587611CDFF
	for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2012 15:04:09 +0100 (CET)
In-Reply-To: <20120203134850.GM3151@opensource.wolfsonmicro.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Vinod Koul <vinod.koul@linux.intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Sascha Hauer <s.hauer@pengutronix.de>, Wolfram Sang <w.sang@pengutronix.de>, Ralf Baechle <ralf@linux-mips.org>, H Hartley Sweeten <hsweeten@visionengravers.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 02/03/2012 02:48 PM, Mark Brown wrote:
> So, we're getting more and more drivers converted over to dmaengine
> (I've CCed a random selection of people working on relevant drivers and
> Vinod).  This means we're getting a bunch of drivers that talk to the
> ALSA API on the top and the dmaengine API on the bottom and seem to need
> to implement very similar code patterns (like this tasklet to push the
> DMA through).  This feels like we need some sort of abstraction to
> factor out some code here, either library code or perhaps a framework
> driver with callbacks that fill in the platform specifics - if the APIs
> are providing useful abstractions then presumably a large part of this
> is just translating between them.
> 
> If that's not doable then what are the problems?


Yes, I was faced with the task of writing yet another dmaengine based ASoC
PCM driver last week. At first I thought it might be a good idea to come up
with a common ASoC PCM driver which could be used by all platforms using DMA
engine. Unfortunately this turned out to be not feasible due to how
dmaengine works. Each dmaengine driver has it's custom API for configuring
the DMA controller. :/

So what I have come up with so far is a set of helper functions which can be
used to implement a dmaengine based ASoC PCM driver. Right now I'm in the
process of converting imx, mxs and ep93xx to this set of functions.

These platforms have in common that their dmaengine driver implements
device_prep_dma_cyclic function, which prepares a continuous transfer for
cyclic buffer.
The other ASoC platforms using dmaengine for their PCM driver (including the
one in this patch series) don't have this function implemented and so the
PCM drivers manually have to setup the cyclic SG lists. So while we could
add a common set up functions for this to ASoC or ALSA I think the better
place for this is in the dmaengine framework and implement
device_prep_dma_cyclic for those drivers which don't do yet.

I'll try to send patches and some further explanations next week.

- Lars
