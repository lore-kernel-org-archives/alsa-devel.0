From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v2 1/3] dmaengine: Add wrapper for
 device_tx_status callback
Date: Wed, 20 Jun 2012 19:05:46 +0530
Message-ID: <1340199346.1927.1655.camel@vkoul-udesk3>
References: <1339438302-12417-1-git-send-email-lars@metafoo.de>
	<1340189662.1927.1648.camel@vkoul-udesk3> <4FE1BE79.5080903@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id E03EC245BD
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2012 15:43:34 +0200 (CEST)
In-Reply-To: <4FE1BE79.5080903@metafoo.de>
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
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, Mika Westerberg <mika.westerberg@iki.fi>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-06-20 at 14:13 +0200, Lars-Peter Clausen wrote:
> On 06/20/2012 12:54 PM, Vinod Koul wrote:
> > On Mon, 2012-06-11 at 20:11 +0200, Lars-Peter Clausen wrote:
> >> This patch adds a small inline wrapper for the devivce_tx_status callback of a
> >> dma device. This makes the source code of users of this function a bit more
> >> compact and a bit more legible.
> > Applied, thanks
> > 
> > rest of the series should go thru ASoC tree.
> > 
> 
> Thanks.
> 
> There is a compile time dependency between the patches, so this patch should
> go through the ASoC tree as well, or we'll have to wait another release
> before the ASoC patches can be applied.
> 
Yes and rest of the two patches depend on components in asoc-next so
they don't apply for me as well.
Mark, it would make sense to take all three to your tree. I will retain
this in my next for others to use.
So, 
Acked-by Vinod Koul <vinod.koul@linux.intel.com>

-- 
~Vinod
