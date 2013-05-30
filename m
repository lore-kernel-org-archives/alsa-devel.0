From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 3/6] dma: Add a jz4740 dmaengine driver
Date: Thu, 30 May 2013 22:42:26 +0530
Message-ID: <20130530171225.GA3767@intel.com>
References: <1369931105-28065-1-git-send-email-lars@metafoo.de>
 <1369931105-28065-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 952502617B8
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2013 19:50:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1369931105-28065-4-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Maarten ter Huurne <maarten@treewalker.org>
List-Id: alsa-devel@alsa-project.org

On Thu, May 30, 2013 at 06:25:02PM +0200, Lars-Peter Clausen wrote:
> This patch adds dmaengine support for the JZ4740 DMA controller. For now the
> driver will be a wrapper around the custom JZ4740 DMA API. Once all users of the
> custom JZ4740 DMA API have been converted to the dmaengine API the custom API
> will be removed and direct hardware access will be added to the dmaengine
> driver.
> 
> +
> +#include <asm/mach-jz4740/dma.h>
Am bit worried about having header in arch. Why cant we have this drivers header
in linux/. That way same IP block cna be reused across archs.
I was hoping that you would have move it in 6th patch, but that isnt the case


> +static int jz4740_dma_alloc_chan_resources(struct dma_chan *c)
> +{
> +	struct jz4740_dmaengine_chan *chan = to_jz4740_dma_chan(c);
> +
> +	chan->jz_chan = jz4740_dma_request(chan, NULL);
> +	if (!chan->jz_chan)
> +		return -EBUSY;
> +
> +	jz4740_dma_set_complete_cb(chan->jz_chan, jz4740_dma_complete_cb);
> +
> +	return 0;
Sorry, I didnt reply on this one. The API expects you to allocate a pool of
descriptors. These descriptors are to be used in .device_prep_xxx calls later.

--
~Vinod
