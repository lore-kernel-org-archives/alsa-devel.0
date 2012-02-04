From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH 19/19] ASoC: fsi: Add DMAEngine support
Date: Sun, 05 Feb 2012 00:10:15 +0530
Message-ID: <1328380815.26182.54.camel@vkoul-udesk3>
References: <871uqcjo9i.wl%kuninori.morimoto.gx@renesas.com>
	<87aa50i971.wl%kuninori.morimoto.gx@renesas.com>
	<20120203134850.GM3151@opensource.wolfsonmicro.com>
	<4F2BE998.4020903@metafoo.de>
	<20120203141440.GR3151@opensource.wolfsonmicro.com>
	<1328373092.26182.27.camel@vkoul-udesk3> <4F2D6416.2050400@metafoo.de>
	<1328378819.26182.33.camel@vkoul-udesk3> <4F2D7824.1020702@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id C3B3710393C
	for <alsa-devel@alsa-project.org>; Sat,  4 Feb 2012 19:38:55 +0100 (CET)
In-Reply-To: <4F2D7824.1020702@metafoo.de>
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

On Sat, 2012-02-04 at 19:25 +0100, Lars-Peter Clausen wrote:
> On 02/04/2012 07:06 PM, Vinod Koul wrote:
> > On Sat, 2012-02-04 at 18:00 +0100, Lars-Peter Clausen wrote:
> >> This is sort of what I have implemented right now. Although I also prepare and
> >> submit the dma descriptor in trigger START instead of prepare. Mainly beacuse I
> >> mapped trigger STOP to dmaengine_terminate_all. Or is issue_pending supposed to
> >> just restart the transfer if it is circular, even though terminate_all has been
> >> called?
> > trigger START should not be used for preparing descriptors. You want to
> > start to actually start the descriptor (which is issue_pending and NOT
> > submit!!). You should do this is prepare callback.
> 
> I'm doing both, prepare+submit and issue_pending, because of what I wrote
> above. Or can we assume that each call to the ALSA/ASoC prepare callback will
> only be followed by at maximum one call to trigger START?
terminate_all is designed to abort all transfers, so that would mean the
dmac will move the descriptors to free_list. So that way your
implementation is the right one.

And while at it, I believe for this use, terminate_all is too strong an
API to be used, perhaps we should introduce a STOP call, which just
aborts the current descriptor but doesn't free it, or possibly move to
submitted state/queue. And yes terminate_all should used in scenarios
like free callback.
That way it should map properly to ALSA PCM operations.


-- 
~Vinod
