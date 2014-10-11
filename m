From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 11/12] ASoC: txx9: use
	dmaengine_terminate_all() API
Date: Sat, 11 Oct 2014 21:10:39 +0530
Message-ID: <1413042040-28222-11-git-send-email-vinod.koul@intel.com>
References: <1413041973-28146-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id BABBF2604A1
 for <alsa-devel@alsa-project.org>; Sat, 11 Oct 2014 18:15:28 +0200 (CEST)
In-Reply-To: <1413041973-28146-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: dmaengine@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The drivers should use dmaengine_terminate_all() API instead of
accessing the device_control which will be deprecated soon

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/txx9/txx9aclc.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/txx9/txx9aclc.c b/sound/soc/txx9/txx9aclc.c
index f0829de..3b122cd 100644
--- a/sound/soc/txx9/txx9aclc.c
+++ b/sound/soc/txx9/txx9aclc.c
@@ -160,7 +160,7 @@ static void txx9aclc_dma_tasklet(unsigned long data)
 		void __iomem *base = drvdata->base;
 
 		spin_unlock_irqrestore(&dmadata->dma_lock, flags);
-		chan->device->device_control(chan, DMA_TERMINATE_ALL, 0);
+		dmaengine_terminate_all(chan);
 		/* first time */
 		for (i = 0; i < NR_DMA_CHAIN; i++) {
 			desc = txx9aclc_dma_submit(dmadata,
@@ -266,7 +266,7 @@ static int txx9aclc_pcm_close(struct snd_pcm_substream *substream)
 	struct dma_chan *chan = dmadata->dma_chan;
 
 	dmadata->frag_count = -1;
-	chan->device->device_control(chan, DMA_TERMINATE_ALL, 0);
+	dmaengine_terminate_all(chan);
 	return 0;
 }
 
@@ -398,8 +398,7 @@ static int txx9aclc_pcm_remove(struct snd_soc_platform *platform)
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
1.7.0.4
