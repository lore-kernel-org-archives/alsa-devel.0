From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: txx9: Don't opencode DMAengine API
	calls
Date: Tue, 19 Aug 2014 17:48:07 +0200
Message-ID: <1408463287-5546-2-git-send-email-lars@metafoo.de>
References: <1408463287-5546-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-176.synserver.de (smtp-out-176.synserver.de
 [212.40.185.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 30FAA265847
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 17:48:12 +0200 (CEST)
In-Reply-To: <1408463287-5546-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Atsushi Nemoto <anemo@mba.ocn.ne.jp>, Lars-Peter Clausen <lars@metafoo.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use the proper wrapper functions instead of directly calling the DMAengine
callback functions.

Also add the missing include to linux/dmaengine.h.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/txx9/txx9aclc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/txx9/txx9aclc.c b/sound/soc/txx9/txx9aclc.c
index f0829de..cd71fd8 100644
--- a/sound/soc/txx9/txx9aclc.c
+++ b/sound/soc/txx9/txx9aclc.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
+#include <linux/dmaengine.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -137,7 +138,7 @@ txx9aclc_dma_submit(struct txx9aclc_dmadata *dmadata, dma_addr_t buf_dma_addr)
 	}
 	desc->callback = txx9aclc_dma_complete;
 	desc->callback_param = dmadata;
-	desc->tx_submit(desc);
+	dmaengine_submit(desc);
 	return desc;
 }
 
@@ -160,7 +161,7 @@ static void txx9aclc_dma_tasklet(unsigned long data)
 		void __iomem *base = drvdata->base;
 
 		spin_unlock_irqrestore(&dmadata->dma_lock, flags);
-		chan->device->device_control(chan, DMA_TERMINATE_ALL, 0);
+		dmaengine_terminate_all(chan);
 		/* first time */
 		for (i = 0; i < NR_DMA_CHAIN; i++) {
 			desc = txx9aclc_dma_submit(dmadata,
@@ -169,7 +170,7 @@ static void txx9aclc_dma_tasklet(unsigned long data)
 				return;
 		}
 		dmadata->dmacount = NR_DMA_CHAIN;
-		chan->device->device_issue_pending(chan);
+		dma_async_issue_pending(chan);
 		spin_lock_irqsave(&dmadata->dma_lock, flags);
 		__raw_writel(ctlbit, base + ACCTLEN);
 		dmadata->frag_count = NR_DMA_CHAIN % dmadata->frags;
@@ -188,7 +189,7 @@ static void txx9aclc_dma_tasklet(unsigned long data)
 			dmadata->frag_count * dmadata->frag_bytes);
 		if (!desc)
 			return;
-		chan->device->device_issue_pending(chan);
+		dma_async_issue_pending(chan);
 
 		spin_lock_irqsave(&dmadata->dma_lock, flags);
 		dmadata->frag_count++;
@@ -266,7 +267,7 @@ static int txx9aclc_pcm_close(struct snd_pcm_substream *substream)
 	struct dma_chan *chan = dmadata->dma_chan;
 
 	dmadata->frag_count = -1;
-	chan->device->device_control(chan, DMA_TERMINATE_ALL, 0);
+	dmaengine_terminate_all(chan);
 	return 0;
 }
 
@@ -398,8 +399,7 @@ static int txx9aclc_pcm_remove(struct snd_soc_platform *platform)
 		struct dma_chan *chan = dmadata->dma_chan;
 		if (chan) {
 			dmadata->frag_count = -1;
-			chan->device->device_control(chan,
-						     DMA_TERMINATE_ALL, 0);
+			dmaengine_terminate_all(chan);
 			dma_release_channel(chan);
 		}
 		dev->dmadata[i].dma_chan = NULL;
-- 
1.8.0
