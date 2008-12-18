From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] ASoC: switch davinci DPRINTK to pr_debug()
Date: Thu, 18 Dec 2008 17:30:55 +0000
Message-ID: <1229621458-2144-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081218173021.GA25332@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3EB3024481
	for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2008 18:30:59 +0100 (CET)
In-Reply-To: <20081218173021.GA25332@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Alexander Beregalov <a.beregalov@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Alexander Beregalov <a.beregalov@gmail.com>

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/davinci/davinci-pcm.c |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index bc83e1c..74abc9b 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
+#include <linux/kernel.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -24,13 +25,6 @@
 
 #include "davinci-pcm.h"
 
-#define DAVINCI_PCM_DEBUG 0
-#if DAVINCI_PCM_DEBUG
-#define DPRINTK(x...) printk(KERN_DEBUG x)
-#else
-#define DPRINTK(x...)
-#endif
-
 static struct snd_pcm_hardware davinci_pcm_hardware = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
@@ -78,8 +72,8 @@ static void davinci_pcm_enqueue_dma(struct snd_pcm_substream *substream)
 	dma_offset = prtd->period * period_size;
 	dma_pos = runtime->dma_addr + dma_offset;
 
-	DPRINTK("audio_set_dma_params_play channel = %d dma_ptr = %x "
-		"period_size=%x\n", lch, dma_pos, period_size);
+	pr_debug("davinci_pcm: audio_set_dma_params_play channel = %d "
+		"dma_ptr = %x period_size=%x\n", lch, dma_pos, period_size);
 
 	data_type = prtd->params->data_type;
 	count = period_size / data_type;
@@ -112,7 +106,7 @@ static void davinci_pcm_dma_irq(int lch, u16 ch_status, void *data)
 	struct snd_pcm_substream *substream = data;
 	struct davinci_runtime_data *prtd = substream->runtime->private_data;
 
-	DPRINTK("lch=%d, status=0x%x\n", lch, ch_status);
+	pr_debug("davinci_pcm: lch=%d, status=0x%x\n", lch, ch_status);
 
 	if (unlikely(ch_status != DMA_COMPLETE))
 		return;
@@ -316,8 +310,8 @@ static int davinci_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
 	buf->area = dma_alloc_writecombine(pcm->card->dev, size,
 					   &buf->addr, GFP_KERNEL);
 
-	DPRINTK("preallocate_dma_buffer: area=%p, addr=%p, size=%d\n",
-		(void *) buf->area, (void *) buf->addr, size);
+	pr_debug("davinci_pcm: preallocate_dma_buffer: area=%p, addr=%p, "
+		"size=%d\n", (void *) buf->area, (void *) buf->addr, size);
 
 	if (!buf->area)
 		return -ENOMEM;
-- 
1.5.6.5
