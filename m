From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: Re: [RFC 00/10] ASoC: Introduce dmaengine pcm helper
 functions
Date: Wed, 22 Feb 2012 16:46:41 +0800
Message-ID: <20120222084640.GI11087@shlinux2.ap.freescale.net>
References: <1329842884-9757-1-git-send-email-lars@metafoo.de>
	<20120222081908.GB21820@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 5BB83103A8C
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 09:38:53 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Russell King <linux@arm.linux.org.uk>, Mallon <rmallon@gmail.com>, Liam Girdwood <lrg@ti.com>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Vinod Koul <vinod.koul@linux.intel.com>, Ryan@alsa-project.org, Wolfram Sang <w.sang@pengutronix.de>, Mika Westerberg <mika.westerberg@iki.fi>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 22, 2012 at 04:19:10PM +0800, Shawn Guo wrote:
> Nice consolidation ...
> 
> On Tue, Feb 21, 2012 at 05:47:54PM +0100, Lars-Peter Clausen wrote:
> > This patch series introduces a new set of helper functions for dmaengine based
> > PCM drivers. Currently we have 6 different dmaengine based PCM drivers which are
> > all more or less similar in structure, but all have also individual requirements
Correct.

> > which can't easily be generalized. So that's why this series does not introduce
> > a generic dmaengine PCM driver but rather a set of helper functions which can be
> > used to implement the common bits between such dmaengine based PCM drivers.
> > 
I once had the same thinking about it...

> I did not notice this patch on any list yet, so am not sure about
> Russell's plan about it.  But it seems this series does not reach
> alsa-devel list either. (forgot?)
> 
I'm also interested in this patch series.
However, i can not see it in the alsa-dev list....


Regards
Dong Aisheng
