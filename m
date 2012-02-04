From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH 19/19] ASoC: fsi: Add DMAEngine support
Date: Sat, 04 Feb 2012 22:01:32 +0530
Message-ID: <1328373092.26182.27.camel@vkoul-udesk3>
References: <871uqcjo9i.wl%kuninori.morimoto.gx@renesas.com>
	<87aa50i971.wl%kuninori.morimoto.gx@renesas.com>
	<20120203134850.GM3151@opensource.wolfsonmicro.com>
	<4F2BE998.4020903@metafoo.de>
	<20120203141440.GR3151@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 387E624345
	for <alsa-devel@alsa-project.org>; Sat,  4 Feb 2012 17:30:12 +0100 (CET)
In-Reply-To: <20120203141440.GR3151@opensource.wolfsonmicro.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Sascha Hauer <s.hauer@pengutronix.de>, Wolfram Sang <w.sang@pengutronix.de>, Ralf Baechle <ralf@linux-mips.org>, H Hartley Sweeten <hsweeten@visionengravers.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, 2012-02-03 at 14:14 +0000, Mark Brown wrote:
> On Fri, Feb 03, 2012 at 03:05:12PM +0100, Lars-Peter Clausen wrote:
> 
> > Yes, I was faced with the task of writing yet another dmaengine based ASoC
> > PCM driver last week. At first I thought it might be a good idea to come up
> > with a common ASoC PCM driver which could be used by all platforms using DMA
> > engine. Unfortunately this turned out to be not feasible due to how
> > dmaengine works. Each dmaengine driver has it's custom API for configuring
> > the DMA controller. :/
Not really, if the driver is written properly its doable..
> 
> That doesn't sound insurmountible - you need a callback to allow the
> individual drivers to set the parameters but hopefully the data flow is
> more generic?  There will probably be some other setup type stuff that
> needs doing.
I had though about this sometime back, and if we add dmaengine support
into asoc, we wouldn't need to add this kind of support in every driver.

Typically, finding the right channel involves some handshaking between
client and dma driver, so this is something the PCM driver should do as
part of setup.
The dma_chan can be part of the DAI, including the dma_add_t of the
peripheral. Any required dmac parametrs should be set using
dma_slave_config at setup.
Once the stream is opened, asoc core on finding dma_chan in DAI should
call the dmaengine APIs to get cyclic descriptor (in prepare) and then
submit. The trigger START should invoke issue_pending callback of DMA.
Similarly the trigger PAUSE, RESUME maps to dmanegine PAUSE and RESUME
respectively (if implemented by dmac).

This way PCM driver would just need to setup the dma and not worry about
data transfer as long as dma driver is properly done. 
> 
> > The other ASoC platforms using dmaengine for their PCM driver (including the
> > one in this patch series) don't have this function implemented and so the
> > PCM drivers manually have to setup the cyclic SG lists. So while we could
> > add a common set up functions for this to ASoC or ALSA I think the better
> > place for this is in the dmaengine framework and implement
> > device_prep_dma_cyclic for those drivers which don't do yet.
> 
> That seems like a good plan, that way other users of cyclic DMA will
> also benefit.


-- 
~Vinod
