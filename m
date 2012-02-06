From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH 19/19] ASoC: fsi: Add DMAEngine support
Date: Mon, 06 Feb 2012 20:16:00 +0530
Message-ID: <1328539560.26182.94.camel@vkoul-udesk3>
References: <871uqcjo9i.wl%kuninori.morimoto.gx@renesas.com>
	<87aa50i971.wl%kuninori.morimoto.gx@renesas.com>
	<20120203134850.GM3151@opensource.wolfsonmicro.com>
	<4F2BE998.4020903@metafoo.de>
	<20120203141440.GR3151@opensource.wolfsonmicro.com>
	<1328373092.26182.27.camel@vkoul-udesk3> <4F2D6416.2050400@metafoo.de>
	<1328378819.26182.33.camel@vkoul-udesk3> <4F2D7824.1020702@metafoo.de>
	<1328380815.26182.54.camel@vkoul-udesk3> <4F2F93A3.2040402@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id F1A25103AEF
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 15:44:11 +0100 (CET)
In-Reply-To: <4F2F93A3.2040402@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wolfram Sang <w.sang@pengutronix.de>, Ralf Baechle <ralf@linux-mips.org>, H Hartley Sweeten <hsweeten@visionengravers.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, 2012-02-06 at 09:47 +0100, Lars-Peter Clausen wrote:
> On 02/04/2012 07:40 PM, Vinod Koul wrote:
> >[...]
> > 
> > And while at it, I believe for this use, terminate_all is too strong an
> > API to be used, perhaps we should introduce a STOP call, which just
> > aborts the current descriptor but doesn't free it, or possibly move to
> > submitted state/queue. And yes terminate_all should used in scenarios
> > like free callback.
> > That way it should map properly to ALSA PCM operations.
> > 
> 
> Yes, a call that would allow us to reset/restart a transfer would be nice.
> While we are at it: Another nice addition, which would be good for sound
> drivers is a callback, which reports the transfer's current position in the
> datastream. This allows us to implement a pointer callback with sub-period
> granularity and also allow us to implement the 'no period wakeup' feature. A
> lot of DMA controllers support reporting this, but as far as I can see there
> is currently no way to export this information using dmaengine.
What makes you think it's missing :-)

Pls see device_tx_status callback. You can return the descriptor
position using this and enable "no wake mode"
> 
> - Lars


-- 
~Vinod
