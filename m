From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/6] soc - s3c24xx-pcm - Fix checkpatch warnings
Date: Wed, 30 Apr 2008 10:10:16 +0100
Message-ID: <1209546619-14389-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1209546619-14389-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1209546619-14389-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BFA15103848
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Apr 2008 11:10:21 +0200 (CEST)
In-Reply-To: <1209546619-14389-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c24xx-pcm.c |   33 ++++++++++++++++-----------------
 1 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c24xx-pcm.c b/sound/soc/s3c24xx/s3c24xx-pcm.c
index 49580fb..6c70a81 100644
--- a/sound/soc/s3c24xx/s3c24xx-pcm.c
+++ b/sound/soc/s3c24xx/s3c24xx-pcm.c
@@ -20,6 +20,7 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
@@ -30,7 +31,6 @@
 #include <sound/soc.h>
 
 #include <asm/dma.h>
-#include <asm/io.h>
 #include <asm/hardware.h>
 #include <asm/arch/dma.h>
 #include <asm/arch/audio.h>
@@ -93,7 +93,7 @@ static void s3c24xx_pcm_enqueue(struct snd_pcm_substream *substream)
 	while (prtd->dma_loaded < prtd->dma_limit) {
 		unsigned long len = prtd->dma_period;
 
-		DBG("dma_loaded: %d\n",prtd->dma_loaded);
+		DBG("dma_loaded: %d\n", prtd->dma_loaded);
 
 		if ((pos + len) > prtd->dma_end) {
 			len  = prtd->dma_end - pos;
@@ -101,7 +101,7 @@ static void s3c24xx_pcm_enqueue(struct snd_pcm_substream *substream)
 			       __func__, len);
 		}
 
-		ret = s3c2410_dma_enqueue(prtd->params->channel, 
+		ret = s3c2410_dma_enqueue(prtd->params->channel,
 			substream, pos, len);
 
 		if (ret == 0) {
@@ -129,7 +129,7 @@ static void s3c24xx_audio_buffdone(struct s3c2410_dma_chan *channel,
 		return;
 
 	prtd = substream->runtime->private_data;
-	
+
 	if (substream)
 		snd_pcm_period_elapsed(substream);
 
@@ -150,7 +150,7 @@ static int s3c24xx_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct s3c24xx_pcm_dma_params *dma = rtd->dai->cpu_dai->dma_data;
 	unsigned long totbytes = params_buffer_bytes(params);
-	int ret=0;
+	int ret = 0;
 
 	DBG("Entered %s\n", __func__);
 
@@ -223,7 +223,7 @@ static int s3c24xx_pcm_prepare(struct snd_pcm_substream *substream)
 	/* return if this is a bufferless transfer e.g.
 	 * codec <--> BT codec or GSM modem -- lg FIXME */
 	if (!prtd->params)
-	 	return 0;
+		return 0;
 
 	/* channel needs configuring for mem=>device, increment memory addr,
 	 * sync to pclk, half-word transfers to the IIS-FIFO. */
@@ -293,8 +293,8 @@ static int s3c24xx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	return ret;
 }
 
-static snd_pcm_uframes_t 
-	s3c24xx_pcm_pointer(struct snd_pcm_substream *substream)
+static snd_pcm_uframes_t
+s3c24xx_pcm_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct s3c24xx_runtime_data *prtd = runtime->private_data;
@@ -313,7 +313,7 @@ static snd_pcm_uframes_t
 
 	spin_unlock(&prtd->lock);
 
-	DBG("Pointer %x %x\n",src,dst);
+	DBG("Pointer %x %x\n", src, dst);
 
 	/* we seem to be getting the odd error from the pcm library due
 	 * to out-of-bounds pointers. this is maybe due to the dma engine
@@ -355,11 +355,11 @@ static int s3c24xx_pcm_close(struct snd_pcm_substream *substream)
 
 	DBG("Entered %s\n", __func__);
 
-	if (prtd)
-		kfree(prtd);
-	else
+	if (!prtd)
 		DBG("s3c24xx_pcm_close called with prtd == NULL\n");
 
+	kfree(prtd);
+
 	return 0;
 }
 
@@ -371,9 +371,9 @@ static int s3c24xx_pcm_mmap(struct snd_pcm_substream *substream,
 	DBG("Entered %s\n", __func__);
 
 	return dma_mmap_writecombine(substream->pcm->card->dev, vma,
-                                     runtime->dma_area,
-                                     runtime->dma_addr,
-                                     runtime->dma_bytes);
+				     runtime->dma_area,
+				     runtime->dma_addr,
+				     runtime->dma_bytes);
 }
 
 static struct snd_pcm_ops s3c24xx_pcm_ops = {
@@ -432,7 +432,7 @@ static void s3c24xx_pcm_free_dma_buffers(struct snd_pcm *pcm)
 
 static u64 s3c24xx_pcm_dmamask = DMA_32BIT_MASK;
 
-static int s3c24xx_pcm_new(struct snd_card *card, 
+static int s3c24xx_pcm_new(struct snd_card *card,
 	struct snd_soc_codec_dai *dai, struct snd_pcm *pcm)
 {
 	int ret = 0;
@@ -467,7 +467,6 @@ struct snd_soc_platform s3c24xx_soc_platform = {
 	.pcm_new	= s3c24xx_pcm_new,
 	.pcm_free	= s3c24xx_pcm_free_dma_buffers,
 };
-
 EXPORT_SYMBOL_GPL(s3c24xx_soc_platform);
 
 MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
-- 
1.5.5.1
