From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 09/12] ASoC: dmaengine_pcm: support use of
	generic DMA helper
Date: Wed, 27 Feb 2013 23:25:45 +0800
Message-ID: <1361978748-25281-10-git-send-email-shawn.guo@linaro.org>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 19A4E26538C
 for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2013 16:26:29 +0100 (CET)
In-Reply-To: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Huang Shijie <b32955@freescale.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Marek Vasut <marek.vasut@gmail.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

With generic DMA device tree binding and helper function
dma_request_slave_channel() in place, dmaengine_pcm should support
that in requesting DMA channel for users that support generic DMA
device tree binding.

Instead of inventing a new API, it defines the parameters needed by
dma_request_slave_channel() into struct snd_dma_channel_params,
interprets filter_data into snd_dma_channel_params, and calls the
helper in case that dmaengine_pcm users pass in a NULL filter_fn.

Then, dmaengine_pcm users can call snd_dmaengine_pcm_open() with NULL
filter_fn and snd_dma_channel_params being filter_data to direct the
API to request DMA channel using generic DMA helper.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
---
 include/sound/dmaengine_pcm.h |    5 +++++
 sound/soc/soc-dmaengine-pcm.c |   19 +++++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index b877334..6c0f795 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -18,6 +18,11 @@
 #include <sound/pcm.h>
 #include <linux/dmaengine.h>
 
+struct snd_dma_channel_params {
+	struct device *dev;
+	char *name;
+};
+
 /**
  * snd_pcm_substream_to_dma_direction - Get dma_transfer_direction for a PCM
  *   substream
diff --git a/sound/soc/soc-dmaengine-pcm.c b/sound/soc/soc-dmaengine-pcm.c
index 111b7d92..7ef8034 100644
--- a/sound/soc/soc-dmaengine-pcm.c
+++ b/sound/soc/soc-dmaengine-pcm.c
@@ -247,12 +247,19 @@ EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_pointer);
 static int dmaengine_pcm_request_channel(struct dmaengine_pcm_runtime_data *prtd,
 	dma_filter_fn filter_fn, void *filter_data)
 {
-	dma_cap_mask_t mask;
-
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-	dma_cap_set(DMA_CYCLIC, mask);
-	prtd->dma_chan = dma_request_channel(mask, filter_fn, filter_data);
+	if (filter_fn) {
+		dma_cap_mask_t mask;
+
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_SLAVE, mask);
+		dma_cap_set(DMA_CYCLIC, mask);
+		prtd->dma_chan = dma_request_channel(mask, filter_fn,
+						     filter_data);
+	} else {
+		struct snd_dma_channel_params *params = filter_data;
+		prtd->dma_chan = dma_request_slave_channel(params->dev,
+							   params->name);
+	}
 
 	if (!prtd->dma_chan)
 		return -ENXIO;
-- 
1.7.9.5
