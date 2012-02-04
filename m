From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH 19/19] ASoC: fsi: Add DMAEngine support
Date: Sat, 04 Feb 2012 23:36:59 +0530
Message-ID: <1328378819.26182.33.camel@vkoul-udesk3>
References: <871uqcjo9i.wl%kuninori.morimoto.gx@renesas.com>
	<87aa50i971.wl%kuninori.morimoto.gx@renesas.com>
	<20120203134850.GM3151@opensource.wolfsonmicro.com>
	<4F2BE998.4020903@metafoo.de>
	<20120203141440.GR3151@opensource.wolfsonmicro.com>
	<1328373092.26182.27.camel@vkoul-udesk3> <4F2D6416.2050400@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 0ABF5243EF
	for <alsa-devel@alsa-project.org>; Sat,  4 Feb 2012 19:05:37 +0100 (CET)
In-Reply-To: <4F2D6416.2050400@metafoo.de>
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

On Sat, 2012-02-04 at 18:00 +0100, Lars-Peter Clausen wrote:
> This is sort of what I have implemented right now. Although I also prepare and
> submit the dma descriptor in trigger START instead of prepare. Mainly beacuse I
> mapped trigger STOP to dmaengine_terminate_all. Or is issue_pending supposed to
> just restart the transfer if it is circular, even though terminate_all has been
> called?
trigger START should not be used for preparing descriptors. You want to
start to actually start the descriptor (which is issue_pending and NOT
submit!!). You should do this is prepare callback.
> 
> I also have a helper function which maps a hw_params to a dma_slave_config.
> Individual drivers still have to implement their own hw_params callback since
> not all fields of a dma_slave_config can be deduced from a hw_params (e.g. the
> burst size). 
yes, since dma_slave_config is dependent upon what you want to DMA and
match that with peripheral, it can be done by PCM drivers only. Core
cannot take care of this. That would also help, as channel is set
rightly before core calls dmaengine APIs in prepare :-)

-- 
~Vinod
