From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH resend 1/2] ASoC: davinci: replace private sram
	api with genalloc
Date: Wed, 17 Oct 2012 16:08:03 +0200
Message-ID: <1350482884-13119-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B51B265221
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2012 16:08:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: mporter@ti.com, broonie@opensource.wolfsonmicro.com, nsekhar@ti.com, gururaja.hebbar@ti.com
List-Id: alsa-devel@alsa-project.org

From: Matt Porter <mporter@ti.com>

Removes the DaVinci private SRAM API and replaces it with
the genalloc API. The SRAM gen_pool is passed in pdata since
DaVinci is in the early stages of DT conversion.

[zonque@gmail.com: stub out gen_pool functions for
		   !CONFIG_GENERIC_ALLOCATOR]

Signed-off-by: Matt Porter <mporter@ti.com>
---
 include/linux/platform_data/davinci_asp.h |  3 +++
 sound/soc/davinci/davinci-mcasp.c         |  2 ++
 sound/soc/davinci/davinci-pcm.c           | 37 ++++++++++++++++++++++++++-----
 sound/soc/davinci/davinci-pcm.h           |  2 ++
 4 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/include/linux/platform_data/davinci_asp.h b/include/linux/platform_data/davinci_asp.h
index d0c5825..f3d6e4f 100644
--- a/include/linux/platform_data/davinci_asp.h
+++ b/include/linux/platform_data/davinci_asp.h
@@ -16,6 +16,8 @@
 #ifndef __DAVINCI_ASP_H
 #define __DAVINCI_ASP_H
 
+#include <linux/genalloc.h>
+
 struct snd_platform_data {
 	u32 tx_dma_offset;
 	u32 rx_dma_offset;
@@ -30,6 +32,7 @@ struct snd_platform_data {
 	unsigned enable_channel_combine:1;
 	unsigned sram_size_playback;
 	unsigned sram_size_capture;
+	struct gen_pool *sram_pool;
 
 	/*
 	 * If McBSP peripheral gets the clock from an external pin,
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 714e51e..52194bb 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1098,6 +1098,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	dma_data = &dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK];
 	dma_data->asp_chan_q = pdata->asp_chan_q;
 	dma_data->ram_chan_q = pdata->ram_chan_q;
+	dma_data->sram_pool = pdata->sram_pool;
 	dma_data->sram_size = pdata->sram_size_playback;
 	dma_data->dma_addr = (dma_addr_t) (pdata->tx_dma_offset +
 							mem->start);
@@ -1115,6 +1116,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	dma_data = &dev->dma_params[SNDRV_PCM_STREAM_CAPTURE];
 	dma_data->asp_chan_q = pdata->asp_chan_q;
 	dma_data->ram_chan_q = pdata->ram_chan_q;
+	dma_data->sram_pool = pdata->sram_pool;
 	dma_data->sram_size = pdata->sram_size_capture;
 	dma_data->dma_addr = (dma_addr_t)(pdata->rx_dma_offset +
 							mem->start);
diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index 93ea3bf..0ae7b6d 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
 #include <linux/kernel.h>
+#include <linux/genalloc.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -23,7 +24,6 @@
 #include <sound/soc.h>
 
 #include <asm/dma.h>
-#include <mach/sram.h>
 
 #include "davinci-pcm.h"
 
@@ -259,7 +259,9 @@ static void davinci_pcm_dma_irq(unsigned link, u16 ch_status, void *data)
 	}
 }
 
-static int allocate_sram(struct snd_pcm_substream *substream, unsigned size,
+#ifdef CONFIG_GENERIC_ALLOCATOR
+static int allocate_sram(struct snd_pcm_substream *substream,
+		struct gen_pool *sram_pool, unsigned size,
 		struct snd_pcm_hardware *ppcm)
 {
 	struct snd_dma_buffer *buf = &substream->dma_buffer;
@@ -271,9 +273,10 @@ static int allocate_sram(struct snd_pcm_substream *substream, unsigned size,
 		return 0;
 
 	ppcm->period_bytes_max = size;
-	iram_virt = sram_alloc(size, &iram_phys);
+	iram_virt = (void *)gen_pool_alloc(sram_pool, size);
 	if (!iram_virt)
 		goto exit1;
+	iram_phys = gen_pool_virt_to_phys(sram_pool, (unsigned)iram_virt);
 	iram_dma = kzalloc(sizeof(*iram_dma), GFP_KERNEL);
 	if (!iram_dma)
 		goto exit2;
@@ -285,11 +288,33 @@ static int allocate_sram(struct snd_pcm_substream *substream, unsigned size,
 	return 0;
 exit2:
 	if (iram_virt)
-		sram_free(iram_virt, size);
+		gen_pool_free(sram_pool, (unsigned)iram_virt, size);
 exit1:
 	return -ENOMEM;
 }
 
+static void davinci_free_sram(struct snd_pcm_substream *substream,
+			      struct snd_dma_buffer *iram_dma)
+{
+	struct davinci_runtime_data *prtd = substream->runtime->private_data;
+	struct gen_pool *sram_pool = prtd->params->sram_pool;
+
+	gen_pool_free(sram_pool, (unsigned) iram_dma->area, iram_dma->bytes);
+}
+#else
+static int allocate_sram(struct snd_pcm_substream *substream,
+		struct gen_pool *sram_pool, unsigned size,
+		struct snd_pcm_hardware *ppcm)
+{
+	return 0;
+}
+
+static void davinci_free_sram(struct snd_pcm_substream *substream,
+			      struct snd_dma_buffer *iram_dma)
+{
+}
+#endif
+
 /*
  * Only used with ping/pong.
  * This is called after runtime->dma_addr, period_bytes and data_type are valid
@@ -676,7 +701,7 @@ static int davinci_pcm_open(struct snd_pcm_substream *substream)
 
 	ppcm = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
 			&pcm_hardware_playback : &pcm_hardware_capture;
-	allocate_sram(substream, params->sram_size, ppcm);
+	allocate_sram(substream, params->sram_pool, params->sram_size, ppcm);
 	snd_soc_set_runtime_hwparams(substream, ppcm);
 	/* ensure that buffer size is a multiple of period size */
 	ret = snd_pcm_hw_constraint_integer(runtime,
@@ -819,7 +844,7 @@ static void davinci_pcm_free(struct snd_pcm *pcm)
 		buf->area = NULL;
 		iram_dma = buf->private_data;
 		if (iram_dma) {
-			sram_free(iram_dma->area, iram_dma->bytes);
+			davinci_free_sram(substream, iram_dma);
 			kfree(iram_dma);
 		}
 	}
diff --git a/sound/soc/davinci/davinci-pcm.h b/sound/soc/davinci/davinci-pcm.h
index fc4d01c..b6ef703 100644
--- a/sound/soc/davinci/davinci-pcm.h
+++ b/sound/soc/davinci/davinci-pcm.h
@@ -12,6 +12,7 @@
 #ifndef _DAVINCI_PCM_H
 #define _DAVINCI_PCM_H
 
+#include <linux/genalloc.h>
 #include <linux/platform_data/davinci_asp.h>
 #include <mach/edma.h>
 
@@ -20,6 +21,7 @@ struct davinci_pcm_dma_params {
 	unsigned short acnt;
 	dma_addr_t dma_addr;		/* device physical address for DMA */
 	unsigned sram_size;
+	struct gen_pool *sram_pool;	/* SRAM gen_pool for ping pong */
 	enum dma_event_q asp_chan_q;	/* event queue number for ASP channel */
 	enum dma_event_q ram_chan_q;	/* event queue number for RAM channel */
 	unsigned char data_type;	/* xfer data type */
-- 
1.7.11.7
