From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: [PATCH 4/4] Separate common pxa2xx-pcm code
Date: Wed, 10 Sep 2008 05:01:20 +0400
Message-ID: <1221008480-13377-4-git-send-email-dbaryshkov@gmail.com>
References: <1221008480-13377-1-git-send-email-dbaryshkov@gmail.com>
	<1221008480-13377-2-git-send-email-dbaryshkov@gmail.com>
	<1221008480-13377-3-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.231])
	by alsa0.perex.cz (Postfix) with ESMTP id 16D01103884
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Sep 2008 03:01:36 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id c38so1718994wra.24
	for <alsa-devel@alsa-project.org>; Tue, 09 Sep 2008 18:01:35 -0700 (PDT)
In-Reply-To: <1221008480-13377-3-git-send-email-dbaryshkov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>
List-Id: alsa-devel@alsa-project.org

ASoC and non-ASoC drivers for PCM DMA on PXA share lot's of common code.
Move it to pxa2xx-lib.

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
---
 include/sound/pxa2xx-lib.h                         |   25 ++
 sound/arm/Kconfig                                  |    7 +-
 sound/arm/Makefile                                 |    3 +-
 .../{soc/pxa/pxa2xx-pcm.c => arm/pxa2xx-pcm-lib.c} |  247 ++++++-------------
 sound/arm/pxa2xx-pcm.c                             |  252 +------------------
 sound/arm/pxa2xx-pcm.h                             |   13 +-
 sound/soc/pxa/Kconfig                              |    3 +-
 sound/soc/pxa/pxa2xx-i2s.c                         |   10 +
 sound/soc/pxa/pxa2xx-pcm.c                         |  261 +-------------------
 sound/soc/pxa/pxa2xx-pcm.h                         |   15 --
 10 files changed, 143 insertions(+), 693 deletions(-)
 copy sound/{soc/pxa/pxa2xx-pcm.c => arm/pxa2xx-pcm-lib.c} (52%)

diff --git a/include/sound/pxa2xx-lib.h b/include/sound/pxa2xx-lib.h
index d18dd2d..2fd3d25 100644
--- a/include/sound/pxa2xx-lib.h
+++ b/include/sound/pxa2xx-lib.h
@@ -4,6 +4,31 @@
 #include <linux/platform_device.h>
 #include <sound/ac97_codec.h>
 
+/* PCM */
+
+struct pxa2xx_pcm_dma_params {
+	char *name;			/* stream identifier */
+	u32 dcmd;			/* DMA descriptor dcmd field */
+	volatile u32 *drcmr;		/* the DMA request channel to use */
+	u32 dev_addr;			/* device physical address for DMA */
+};
+
+extern int __pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params);
+extern int __pxa2xx_pcm_hw_free(struct snd_pcm_substream *substream);
+extern int pxa2xx_pcm_trigger(struct snd_pcm_substream *substream, int cmd);
+extern snd_pcm_uframes_t pxa2xx_pcm_pointer(struct snd_pcm_substream *substream);
+extern int __pxa2xx_pcm_prepare(struct snd_pcm_substream *substream);
+extern void pxa2xx_pcm_dma_irq(int dma_ch, void *dev_id);
+extern int __pxa2xx_pcm_open(struct snd_pcm_substream *substream);
+extern int __pxa2xx_pcm_close(struct snd_pcm_substream *substream);
+extern int pxa2xx_pcm_mmap(struct snd_pcm_substream *substream,
+	struct vm_area_struct *vma);
+extern int pxa2xx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream);
+extern void pxa2xx_pcm_free_dma_buffers(struct snd_pcm *pcm);
+
+/* AC97 */
+
 extern unsigned short pxa2xx_ac97_read(struct snd_ac97 *ac97, unsigned short reg);
 extern void pxa2xx_ac97_write(struct snd_ac97 *ac97, unsigned short reg, unsigned short val);
 
diff --git a/sound/arm/Kconfig b/sound/arm/Kconfig
index 3fd2642..234708e 100644
--- a/sound/arm/Kconfig
+++ b/sound/arm/Kconfig
@@ -34,13 +34,16 @@ config SND_PXA2XX_PCM
 
 config SND_PXA2XX_LIB
 	tristate
-	select SND_AC97_CODEC
+	select SND_AC97_CODEC if SND_PXA2XX_LIB_AC97
+
+config SND_PXA2XX_LIB_AC97
+	bool
 
 config SND_PXA2XX_AC97
 	tristate "AC97 driver for the Intel PXA2xx chip"
 	depends on ARCH_PXA
 	select SND_PXA2XX_PCM
-	select SND_PXA2XX_LIB
+	select SND_PXA2XX_LIB_AC97
 	help
 	  Say Y or M if you want to support any AC97 codec attached to
 	  the PXA2xx AC97 interface.
diff --git a/sound/arm/Makefile b/sound/arm/Makefile
index bb2ed88..2054de1 100644
--- a/sound/arm/Makefile
+++ b/sound/arm/Makefile
@@ -12,7 +12,8 @@ obj-$(CONFIG_SND_PXA2XX_PCM)	+= snd-pxa2xx-pcm.o
 snd-pxa2xx-pcm-objs		:= pxa2xx-pcm.o
 
 obj-$(CONFIG_SND_PXA2XX_LIB)	+= snd-pxa2xx-lib.o
-snd-pxa2xx-lib-objs		:= pxa2xx-ac97-lib.o
+snd-pxa2xx-lib-y		:= pxa2xx-pcm-lib.o
+snd-pxa2xx-lib-$(CONFIG_SND_PXA2XX_LIB_AC97)	+= pxa2xx-ac97-lib.o
 
 obj-$(CONFIG_SND_PXA2XX_AC97)	+= snd-pxa2xx-ac97.o
 snd-pxa2xx-ac97-objs		:= pxa2xx-ac97.o
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/arm/pxa2xx-pcm-lib.c
similarity index 52%
copy from sound/soc/pxa/pxa2xx-pcm.c
copy to sound/arm/pxa2xx-pcm-lib.c
index 771c592..fe20453 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/arm/pxa2xx-pcm-lib.c
@@ -1,30 +1,19 @@
 /*
- * linux/sound/arm/pxa2xx-pcm.c -- ALSA PCM interface for the Intel PXA2xx chip
- *
- * Author:	Nicolas Pitre
- * Created:	Nov 30, 2004
- * Copyright:	(C) 2004 MontaVista Software, Inc.
- *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
 
 #include <linux/module.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
 #include <linux/dma-mapping.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
-#include <sound/soc.h>
+#include <sound/pxa2xx-lib.h>
 
 #include <asm/dma.h>
-#include <mach/hardware.h>
 #include <mach/pxa-regs.h>
-#include <mach/audio.h>
 
 #include "pxa2xx-pcm.h"
 
@@ -45,123 +34,57 @@ static const struct snd_pcm_hardware pxa2xx_pcm_hardware = {
 	.fifo_size		= 32,
 };
 
-struct pxa2xx_runtime_data {
-	int dma_ch;
-	struct pxa2xx_pcm_dma_params *params;
-	pxa_dma_desc *dma_desc_array;
-	dma_addr_t dma_desc_array_phys;
-};
-
-static void pxa2xx_pcm_dma_irq(int dma_ch, void *dev_id)
-{
-	struct snd_pcm_substream *substream = dev_id;
-	struct pxa2xx_runtime_data *prtd = substream->runtime->private_data;
-	int dcsr;
-
-	dcsr = DCSR(dma_ch);
-	DCSR(dma_ch) = dcsr & ~DCSR_STOPIRQEN;
-
-	if (dcsr & DCSR_ENDINTR) {
-		snd_pcm_period_elapsed(substream);
-	} else {
-		printk(KERN_ERR "%s: DMA error on channel %d (DCSR=%#x)\n",
-			prtd->params->name, dma_ch, dcsr);
-	}
-}
-
-static int pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+int __pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct pxa2xx_runtime_data *prtd = runtime->private_data;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct pxa2xx_pcm_dma_params *dma = rtd->dai->cpu_dai->dma_data;
+	struct pxa2xx_runtime_data *rtd = runtime->private_data;
 	size_t totsize = params_buffer_bytes(params);
 	size_t period = params_period_bytes(params);
 	pxa_dma_desc *dma_desc;
 	dma_addr_t dma_buff_phys, next_desc_phys;
-	int ret;
-
-	/* return if this is a bufferless transfer e.g.
-	 * codec <--> BT codec or GSM modem -- lg FIXME */
-	if (!dma)
-		return 0;
-
-	/* this may get called several times by oss emulation
-	 * with different params */
-	if (prtd->params == NULL) {
-		prtd->params = dma;
-		ret = pxa_request_dma(prtd->params->name, DMA_PRIO_LOW,
-			      pxa2xx_pcm_dma_irq, substream);
-		if (ret < 0)
-			return ret;
-		prtd->dma_ch = ret;
-	} else if (prtd->params != dma) {
-		pxa_free_dma(prtd->dma_ch);
-		prtd->params = dma;
-		ret = pxa_request_dma(prtd->params->name, DMA_PRIO_LOW,
-			      pxa2xx_pcm_dma_irq, substream);
-		if (ret < 0)
-			return ret;
-		prtd->dma_ch = ret;
-	}
 
 	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
 	runtime->dma_bytes = totsize;
 
-	dma_desc = prtd->dma_desc_array;
-	next_desc_phys = prtd->dma_desc_array_phys;
+	dma_desc = rtd->dma_desc_array;
+	next_desc_phys = rtd->dma_desc_array_phys;
 	dma_buff_phys = runtime->dma_addr;
 	do {
 		next_desc_phys += sizeof(pxa_dma_desc);
 		dma_desc->ddadr = next_desc_phys;
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			dma_desc->dsadr = dma_buff_phys;
-			dma_desc->dtadr = prtd->params->dev_addr;
+			dma_desc->dtadr = rtd->params->dev_addr;
 		} else {
-			dma_desc->dsadr = prtd->params->dev_addr;
+			dma_desc->dsadr = rtd->params->dev_addr;
 			dma_desc->dtadr = dma_buff_phys;
 		}
 		if (period > totsize)
 			period = totsize;
-		dma_desc->dcmd = prtd->params->dcmd | period | DCMD_ENDIRQEN;
+		dma_desc->dcmd = rtd->params->dcmd | period | DCMD_ENDIRQEN;
 		dma_desc++;
 		dma_buff_phys += period;
 	} while (totsize -= period);
-	dma_desc[-1].ddadr = prtd->dma_desc_array_phys;
+	dma_desc[-1].ddadr = rtd->dma_desc_array_phys;
 
 	return 0;
 }
+EXPORT_SYMBOL(__pxa2xx_pcm_hw_params);
 
-static int pxa2xx_pcm_hw_free(struct snd_pcm_substream *substream)
+int __pxa2xx_pcm_hw_free(struct snd_pcm_substream *substream)
 {
-	struct pxa2xx_runtime_data *prtd = substream->runtime->private_data;
-
-	if (prtd && prtd->params)
-		*prtd->params->drcmr = 0;
-
-	if (prtd->dma_ch) {
-		snd_pcm_set_runtime_buffer(substream, NULL);
-		pxa_free_dma(prtd->dma_ch);
-		prtd->dma_ch = 0;
-	}
-
-	return 0;
-}
-
-static int pxa2xx_pcm_prepare(struct snd_pcm_substream *substream)
-{
-	struct pxa2xx_runtime_data *prtd = substream->runtime->private_data;
+	struct pxa2xx_runtime_data *rtd = substream->runtime->private_data;
 
-	DCSR(prtd->dma_ch) &= ~DCSR_RUN;
-	DCSR(prtd->dma_ch) = 0;
-	DCMD(prtd->dma_ch) = 0;
-	*prtd->params->drcmr = prtd->dma_ch | DRCMR_MAPVLD;
+	if (rtd && rtd->params)
+		*rtd->params->drcmr = 0;
 
+	snd_pcm_set_runtime_buffer(substream, NULL);
 	return 0;
 }
+EXPORT_SYMBOL(__pxa2xx_pcm_hw_free);
 
-static int pxa2xx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+int pxa2xx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct pxa2xx_runtime_data *prtd = substream->runtime->private_data;
 	int ret = 0;
@@ -192,8 +115,9 @@ static int pxa2xx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 
 	return ret;
 }
+EXPORT_SYMBOL(pxa2xx_pcm_trigger);
 
-static snd_pcm_uframes_t
+snd_pcm_uframes_t
 pxa2xx_pcm_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -207,14 +131,47 @@ pxa2xx_pcm_pointer(struct snd_pcm_substream *substream)
 		x = 0;
 	return x;
 }
+EXPORT_SYMBOL(pxa2xx_pcm_pointer);
+
+int __pxa2xx_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct pxa2xx_runtime_data *prtd = substream->runtime->private_data;
+
+	DCSR(prtd->dma_ch) &= ~DCSR_RUN;
+	DCSR(prtd->dma_ch) = 0;
+	DCMD(prtd->dma_ch) = 0;
+	*prtd->params->drcmr = prtd->dma_ch | DRCMR_MAPVLD;
+
+	return 0;
+}
+EXPORT_SYMBOL(__pxa2xx_pcm_prepare);
+
+void pxa2xx_pcm_dma_irq(int dma_ch, void *dev_id)
+{
+	struct snd_pcm_substream *substream = dev_id;
+	struct pxa2xx_runtime_data *rtd = substream->runtime->private_data;
+	int dcsr;
+
+	dcsr = DCSR(dma_ch);
+	DCSR(dma_ch) = dcsr & ~DCSR_STOPIRQEN;
+
+	if (dcsr & DCSR_ENDINTR) {
+		snd_pcm_period_elapsed(substream);
+	} else {
+		printk( KERN_ERR "%s: DMA error on channel %d (DCSR=%#x)\n",
+			rtd->params->name, dma_ch, dcsr );
+		snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
+	}
+}
+EXPORT_SYMBOL(pxa2xx_pcm_dma_irq);
 
-static int pxa2xx_pcm_open(struct snd_pcm_substream *substream)
+int __pxa2xx_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct pxa2xx_runtime_data *prtd;
+	struct pxa2xx_runtime_data *rtd;
 	int ret;
 
-	snd_soc_set_runtime_hwparams(substream, &pxa2xx_pcm_hardware);
+	runtime->hw = pxa2xx_pcm_hardware;
 
 	/*
 	 * For mysterious reasons (and despite what the manual says)
@@ -235,41 +192,39 @@ static int pxa2xx_pcm_open(struct snd_pcm_substream *substream)
 	if (ret < 0)
 		goto out;
 
-	prtd = kzalloc(sizeof(struct pxa2xx_runtime_data), GFP_KERNEL);
-	if (prtd == NULL) {
-		ret = -ENOMEM;
+	ret = -ENOMEM;
+	rtd = kmalloc(sizeof(*rtd), GFP_KERNEL);
+	if (!rtd)
 		goto out;
-	}
-
-	prtd->dma_desc_array =
+	rtd->dma_desc_array =
 		dma_alloc_writecombine(substream->pcm->card->dev, PAGE_SIZE,
-				       &prtd->dma_desc_array_phys, GFP_KERNEL);
-	if (!prtd->dma_desc_array) {
-		ret = -ENOMEM;
+				       &rtd->dma_desc_array_phys, GFP_KERNEL);
+	if (!rtd->dma_desc_array)
 		goto err1;
-	}
 
-	runtime->private_data = prtd;
+	runtime->private_data = rtd;
 	return 0;
 
  err1:
-	kfree(prtd);
+	kfree(rtd);
  out:
 	return ret;
 }
+EXPORT_SYMBOL(__pxa2xx_pcm_open);
 
-static int pxa2xx_pcm_close(struct snd_pcm_substream *substream)
+int __pxa2xx_pcm_close(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct pxa2xx_runtime_data *prtd = runtime->private_data;
+	struct pxa2xx_runtime_data *rtd = runtime->private_data;
 
 	dma_free_writecombine(substream->pcm->card->dev, PAGE_SIZE,
-			      prtd->dma_desc_array, prtd->dma_desc_array_phys);
-	kfree(prtd);
+			      rtd->dma_desc_array, rtd->dma_desc_array_phys);
+	kfree(rtd);
 	return 0;
 }
+EXPORT_SYMBOL(__pxa2xx_pcm_close);
 
-static int pxa2xx_pcm_mmap(struct snd_pcm_substream *substream,
+int pxa2xx_pcm_mmap(struct snd_pcm_substream *substream,
 	struct vm_area_struct *vma)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -278,20 +233,9 @@ static int pxa2xx_pcm_mmap(struct snd_pcm_substream *substream,
 				     runtime->dma_addr,
 				     runtime->dma_bytes);
 }
+EXPORT_SYMBOL(pxa2xx_pcm_mmap);
 
-struct snd_pcm_ops pxa2xx_pcm_ops = {
-	.open		= pxa2xx_pcm_open,
-	.close		= pxa2xx_pcm_close,
-	.ioctl		= snd_pcm_lib_ioctl,
-	.hw_params	= pxa2xx_pcm_hw_params,
-	.hw_free	= pxa2xx_pcm_hw_free,
-	.prepare	= pxa2xx_pcm_prepare,
-	.trigger	= pxa2xx_pcm_trigger,
-	.pointer	= pxa2xx_pcm_pointer,
-	.mmap		= pxa2xx_pcm_mmap,
-};
-
-static int pxa2xx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
+int pxa2xx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
 {
 	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
 	struct snd_dma_buffer *buf = &substream->dma_buffer;
@@ -306,8 +250,9 @@ static int pxa2xx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
 	buf->bytes = size;
 	return 0;
 }
+EXPORT_SYMBOL(pxa2xx_pcm_preallocate_dma_buffer);
 
-static void pxa2xx_pcm_free_dma_buffers(struct snd_pcm *pcm)
+void pxa2xx_pcm_free_dma_buffers(struct snd_pcm *pcm)
 {
 	struct snd_pcm_substream *substream;
 	struct snd_dma_buffer *buf;
@@ -317,54 +262,16 @@ static void pxa2xx_pcm_free_dma_buffers(struct snd_pcm *pcm)
 		substream = pcm->streams[stream].substream;
 		if (!substream)
 			continue;
-
 		buf = &substream->dma_buffer;
 		if (!buf->area)
 			continue;
-
 		dma_free_writecombine(pcm->card->dev, buf->bytes,
 				      buf->area, buf->addr);
 		buf->area = NULL;
 	}
 }
-
-static u64 pxa2xx_pcm_dmamask = DMA_32BIT_MASK;
-
-static int pxa2xx_soc_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
-	struct snd_pcm *pcm)
-{
-	int ret = 0;
-
-	if (!card->dev->dma_mask)
-		card->dev->dma_mask = &pxa2xx_pcm_dmamask;
-	if (!card->dev->coherent_dma_mask)
-		card->dev->coherent_dma_mask = DMA_32BIT_MASK;
-
-	if (dai->playback.channels_min) {
-		ret = pxa2xx_pcm_preallocate_dma_buffer(pcm,
-			SNDRV_PCM_STREAM_PLAYBACK);
-		if (ret)
-			goto out;
-	}
-
-	if (dai->capture.channels_min) {
-		ret = pxa2xx_pcm_preallocate_dma_buffer(pcm,
-			SNDRV_PCM_STREAM_CAPTURE);
-		if (ret)
-			goto out;
-	}
- out:
-	return ret;
-}
-
-struct snd_soc_platform pxa2xx_soc_platform = {
-	.name		= "pxa2xx-audio",
-	.pcm_ops 	= &pxa2xx_pcm_ops,
-	.pcm_new	= pxa2xx_soc_pcm_new,
-	.pcm_free	= pxa2xx_pcm_free_dma_buffers,
-};
-EXPORT_SYMBOL_GPL(pxa2xx_soc_platform);
+EXPORT_SYMBOL(pxa2xx_pcm_free_dma_buffers);
 
 MODULE_AUTHOR("Nicolas Pitre");
-MODULE_DESCRIPTION("Intel PXA2xx PCM DMA module");
+MODULE_DESCRIPTION("Intel PXA2xx sound library");
 MODULE_LICENSE("GPL");
diff --git a/sound/arm/pxa2xx-pcm.c b/sound/arm/pxa2xx-pcm.c
index 381094a..535704f 100644
--- a/sound/arm/pxa2xx-pcm.c
+++ b/sound/arm/pxa2xx-pcm.c
@@ -10,183 +10,20 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/device.h>
-#include <linux/slab.h>
-#include <linux/dma-mapping.h>
-
 #include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-
-#include <asm/dma.h>
-#include <mach/hardware.h>
-#include <mach/pxa-regs.h>
+#include <sound/pxa2xx-lib.h>
 
 #include "pxa2xx-pcm.h"
 
-
-static const struct snd_pcm_hardware pxa2xx_pcm_hardware = {
-	.info			= SNDRV_PCM_INFO_MMAP |
-				  SNDRV_PCM_INFO_MMAP_VALID |
-				  SNDRV_PCM_INFO_INTERLEAVED |
-				  SNDRV_PCM_INFO_PAUSE,
-	.formats		= SNDRV_PCM_FMTBIT_S16_LE,
-	.period_bytes_min	= 32,
-	.period_bytes_max	= 8192 - 32,
-	.periods_min		= 1,
-	.periods_max		= PAGE_SIZE/sizeof(pxa_dma_desc),
-	.buffer_bytes_max	= 128 * 1024,
-	.fifo_size		= 32,
-};
-
-struct pxa2xx_runtime_data {
-	int dma_ch;
-	struct pxa2xx_pcm_dma_params *params;
-	pxa_dma_desc *dma_desc_array;
-	dma_addr_t dma_desc_array_phys;
-};
-
-static int pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *params)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct pxa2xx_runtime_data *rtd = runtime->private_data;
-	size_t totsize = params_buffer_bytes(params);
-	size_t period = params_period_bytes(params);
-	pxa_dma_desc *dma_desc;
-	dma_addr_t dma_buff_phys, next_desc_phys;
-
-	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
-	runtime->dma_bytes = totsize;
-
-	dma_desc = rtd->dma_desc_array;
-	next_desc_phys = rtd->dma_desc_array_phys;
-	dma_buff_phys = runtime->dma_addr;
-	do {
-		next_desc_phys += sizeof(pxa_dma_desc);
-		dma_desc->ddadr = next_desc_phys;
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			dma_desc->dsadr = dma_buff_phys;
-			dma_desc->dtadr = rtd->params->dev_addr;
-		} else {
-			dma_desc->dsadr = rtd->params->dev_addr;
-			dma_desc->dtadr = dma_buff_phys;
-		}
-		if (period > totsize)
-			period = totsize;
-		dma_desc->dcmd = rtd->params->dcmd | period | DCMD_ENDIRQEN;
-		dma_desc++;
-		dma_buff_phys += period;
-	} while (totsize -= period);
-	dma_desc[-1].ddadr = rtd->dma_desc_array_phys;
-
-	return 0;
-}
-
-static int pxa2xx_pcm_hw_free(struct snd_pcm_substream *substream)
-{
-	struct pxa2xx_runtime_data *rtd = substream->runtime->private_data;
-
-	*rtd->params->drcmr = 0;
-	snd_pcm_set_runtime_buffer(substream, NULL);
-	return 0;
-}
-
 static int pxa2xx_pcm_prepare(struct snd_pcm_substream *substream)
 {
 	struct pxa2xx_pcm_client *client = substream->private_data;
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct pxa2xx_runtime_data *rtd = runtime->private_data;
 
-	DCSR(rtd->dma_ch) &= ~DCSR_RUN;
-	DCSR(rtd->dma_ch) = 0;
-	DCMD(rtd->dma_ch) = 0;
-	*rtd->params->drcmr = rtd->dma_ch | DRCMR_MAPVLD;
+	__pxa2xx_pcm_prepare(substream);
 
 	return client->prepare(substream);
 }
 
-static int pxa2xx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
-{
-	struct pxa2xx_runtime_data *rtd = substream->runtime->private_data;
-	int ret = 0;
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-		DDADR(rtd->dma_ch) = rtd->dma_desc_array_phys;
-		DCSR(rtd->dma_ch) = DCSR_RUN;
-		break;
-
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		DCSR(rtd->dma_ch) &= ~DCSR_RUN;
-		break;
-
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		DCSR(rtd->dma_ch) |= DCSR_RUN;
-		break;
-
-	default:
-		ret = -EINVAL;
-	}
-
-	return ret;
-}
-
-static void pxa2xx_pcm_dma_irq(int dma_ch, void *dev_id)
-{
-	struct snd_pcm_substream *substream = dev_id;
-	struct pxa2xx_runtime_data *rtd = substream->runtime->private_data;
-	int dcsr;
-
-	dcsr = DCSR(dma_ch);
-	DCSR(dma_ch) = dcsr & ~DCSR_STOPIRQEN;
-
-	if (dcsr & DCSR_ENDINTR) {
-		snd_pcm_period_elapsed(substream);
-	} else {
-		printk( KERN_ERR "%s: DMA error on channel %d (DCSR=%#x)\n",
-			rtd->params->name, dma_ch, dcsr );
-		snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
-	}
-}
-
-static snd_pcm_uframes_t pxa2xx_pcm_pointer(struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct pxa2xx_runtime_data *rtd = runtime->private_data;
-	dma_addr_t ptr = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
-			 DSADR(rtd->dma_ch) : DTADR(rtd->dma_ch);
-	snd_pcm_uframes_t x = bytes_to_frames(runtime, ptr - runtime->dma_addr);
-	if (x == runtime->buffer_size)
-		x = 0;
-	return x;
-}
-
-static int
-pxa2xx_pcm_hw_rule_mult32(struct snd_pcm_hw_params *params, struct snd_pcm_hw_rule *rule)
-{
-	struct snd_interval *i = hw_param_interval(params, rule->var);
-	int changed = 0;
-
-	if (i->min & 31) {
-		i->min = (i->min & ~31) + 32;
-		i->openmin = 0;
-		changed = 1;
-	}
-
-	if (i->max & 31) {
-		i->max &= ~31;
-		i->openmax = 0;
-		changed = 1;
-	}
-
-	return changed;
-}
-
 static int pxa2xx_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct pxa2xx_pcm_client *client = substream->private_data;
@@ -194,33 +31,11 @@ static int pxa2xx_pcm_open(struct snd_pcm_substream *substream)
 	struct pxa2xx_runtime_data *rtd;
 	int ret;
 
-	runtime->hw = pxa2xx_pcm_hardware;
-
-	/*
-	 * For mysterious reasons (and despite what the manual says)
-	 * playback samples are lost if the DMA count is not a multiple
-	 * of the DMA burst size.  Let's add a rule to enforce that.
-	 */
-	ret = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
-				  pxa2xx_pcm_hw_rule_mult32, NULL,
-				  SNDRV_PCM_HW_PARAM_PERIOD_BYTES, -1);
-	if (ret)
-		goto out;
-	ret = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
-				  pxa2xx_pcm_hw_rule_mult32, NULL,
-				  SNDRV_PCM_HW_PARAM_BUFFER_BYTES, -1);
+	ret = __pxa2xx_pcm_open(substream);
 	if (ret)
 		goto out;
 
-	ret = -ENOMEM;
-	rtd = kmalloc(sizeof(*rtd), GFP_KERNEL);
-	if (!rtd)
-		goto out;
-	rtd->dma_desc_array =
-		dma_alloc_writecombine(substream->pcm->card->dev, PAGE_SIZE,
-				       &rtd->dma_desc_array_phys, GFP_KERNEL);
-	if (!rtd->dma_desc_array)
-		goto err1;
+	rtd = runtime->private_data;
 
 	rtd->params = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
 		      client->playback_params : client->capture_params;
@@ -230,17 +45,13 @@ static int pxa2xx_pcm_open(struct snd_pcm_substream *substream)
 		goto err2;
 	rtd->dma_ch = ret;
 
-	runtime->private_data = rtd;
 	ret = client->startup(substream);
 	if (!ret)
 		goto out;
 
 	pxa_free_dma(rtd->dma_ch);
  err2:
-	dma_free_writecombine(substream->pcm->card->dev, PAGE_SIZE,
-			      rtd->dma_desc_array, rtd->dma_desc_array_phys);
- err1:
-	kfree(rtd);
+	__pxa2xx_pcm_close(substream);
  out:
 	return ret;
 }
@@ -252,69 +63,22 @@ static int pxa2xx_pcm_close(struct snd_pcm_substream *substream)
 
 	pxa_free_dma(rtd->dma_ch);
 	client->shutdown(substream);
-	dma_free_writecombine(substream->pcm->card->dev, PAGE_SIZE,
-			      rtd->dma_desc_array, rtd->dma_desc_array_phys);
-	kfree(rtd);
-	return 0;
-}
 
-static int
-pxa2xx_pcm_mmap(struct snd_pcm_substream *substream, struct vm_area_struct *vma)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	return dma_mmap_writecombine(substream->pcm->card->dev, vma,
-				     runtime->dma_area,
-				     runtime->dma_addr,
-				     runtime->dma_bytes);
+	return __pxa2xx_pcm_close(substream);
 }
 
 static struct snd_pcm_ops pxa2xx_pcm_ops = {
 	.open		= pxa2xx_pcm_open,
 	.close		= pxa2xx_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
-	.hw_params	= pxa2xx_pcm_hw_params,
-	.hw_free	= pxa2xx_pcm_hw_free,
+	.hw_params	= __pxa2xx_pcm_hw_params,
+	.hw_free	= __pxa2xx_pcm_hw_free,
 	.prepare	= pxa2xx_pcm_prepare,
 	.trigger	= pxa2xx_pcm_trigger,
 	.pointer	= pxa2xx_pcm_pointer,
 	.mmap		= pxa2xx_pcm_mmap,
 };
 
-static int pxa2xx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
-{
-	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
-	struct snd_dma_buffer *buf = &substream->dma_buffer;
-	size_t size = pxa2xx_pcm_hardware.buffer_bytes_max;
-	buf->dev.type = SNDRV_DMA_TYPE_DEV;
-	buf->dev.dev = pcm->card->dev;
-	buf->private_data = NULL;
-	buf->area = dma_alloc_writecombine(pcm->card->dev, size,
-					   &buf->addr, GFP_KERNEL);
-	if (!buf->area)
-		return -ENOMEM;
-	buf->bytes = size;
-	return 0;
-}
-
-static void pxa2xx_pcm_free_dma_buffers(struct snd_pcm *pcm)
-{
-	struct snd_pcm_substream *substream;
-	struct snd_dma_buffer *buf;
-	int stream;
-
-	for (stream = 0; stream < 2; stream++) {
-		substream = pcm->streams[stream].substream;
-		if (!substream)
-			continue;
-		buf = &substream->dma_buffer;
-		if (!buf->area)
-			continue;
-		dma_free_writecombine(pcm->card->dev, buf->bytes,
-				      buf->area, buf->addr);
-		buf->area = NULL;
-	}
-}
-
 static u64 pxa2xx_pcm_dmamask = 0xffffffff;
 
 int pxa2xx_pcm_new(struct snd_card *card, struct pxa2xx_pcm_client *client,
diff --git a/sound/arm/pxa2xx-pcm.h b/sound/arm/pxa2xx-pcm.h
index b79f1e8..5c4a4d3 100644
--- a/sound/arm/pxa2xx-pcm.h
+++ b/sound/arm/pxa2xx-pcm.h
@@ -9,14 +9,15 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <asm/dma.h>
 
-struct pxa2xx_pcm_dma_params {
-	char *name;			/* stream identifier */
-	u32 dcmd;			/* DMA descriptor dcmd field */
-	volatile u32 *drcmr;		/* the DMA request channel to use */
-	u32 dev_addr;			/* device physical address for DMA */
+struct pxa2xx_runtime_data {
+	int dma_ch;
+	struct pxa2xx_pcm_dma_params *params;
+	pxa_dma_desc *dma_desc_array;
+	dma_addr_t dma_desc_array_phys;
 };
-	
+
 struct pxa2xx_pcm_client {
 	struct pxa2xx_pcm_dma_params *playback_params;
 	struct pxa2xx_pcm_dma_params *capture_params;
diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index d1ccbdc..f8c1cdd 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -1,6 +1,7 @@
 config SND_PXA2XX_SOC
 	tristate "SoC Audio for the Intel PXA2xx chip"
 	depends on ARCH_PXA
+	select SND_PXA2XX_LIB
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the PXA2xx AC97, I2S or SSP interface. You will also need
@@ -14,7 +15,7 @@ config SND_PXA2XX_SOC_AC97
 	tristate
 	select AC97_BUS
 	select SND_ARM
-	select SND_PXA2XX_LIB
+	select SND_PXA2XX_LIB_AC97
 	select SND_SOC_AC97_BUS
 
 config SND_PXA2XX_SOC_I2S
diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 21ca3fe..39d1921 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -21,6 +21,7 @@
 #include <sound/pcm.h>
 #include <sound/initval.h>
 #include <sound/soc.h>
+#include <sound/pxa2xx-lib.h>
 
 #include <mach/hardware.h>
 #include <mach/pxa-regs.h>
@@ -30,6 +31,15 @@
 #include "pxa2xx-pcm.h"
 #include "pxa2xx-i2s.h"
 
+struct pxa2xx_gpio {
+	u32 sys;
+	u32	rx;
+	u32 tx;
+	u32 clk;
+	u32 frm;
+};
+
+
 struct pxa_i2s_port {
 	u32 sadiv;
 	u32 sacr0;
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index 771c592..afcd892 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -10,64 +10,14 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
 #include <linux/dma-mapping.h>
 
 #include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
 #include <sound/soc.h>
-
-#include <asm/dma.h>
-#include <mach/hardware.h>
-#include <mach/pxa-regs.h>
-#include <mach/audio.h>
+#include <sound/pxa2xx-lib.h>
 
 #include "pxa2xx-pcm.h"
-
-static const struct snd_pcm_hardware pxa2xx_pcm_hardware = {
-	.info			= SNDRV_PCM_INFO_MMAP |
-				  SNDRV_PCM_INFO_MMAP_VALID |
-				  SNDRV_PCM_INFO_INTERLEAVED |
-				  SNDRV_PCM_INFO_PAUSE |
-				  SNDRV_PCM_INFO_RESUME,
-	.formats		= SNDRV_PCM_FMTBIT_S16_LE |
-					SNDRV_PCM_FMTBIT_S24_LE |
-					SNDRV_PCM_FMTBIT_S32_LE,
-	.period_bytes_min	= 32,
-	.period_bytes_max	= 8192 - 32,
-	.periods_min		= 1,
-	.periods_max		= PAGE_SIZE/sizeof(pxa_dma_desc),
-	.buffer_bytes_max	= 128 * 1024,
-	.fifo_size		= 32,
-};
-
-struct pxa2xx_runtime_data {
-	int dma_ch;
-	struct pxa2xx_pcm_dma_params *params;
-	pxa_dma_desc *dma_desc_array;
-	dma_addr_t dma_desc_array_phys;
-};
-
-static void pxa2xx_pcm_dma_irq(int dma_ch, void *dev_id)
-{
-	struct snd_pcm_substream *substream = dev_id;
-	struct pxa2xx_runtime_data *prtd = substream->runtime->private_data;
-	int dcsr;
-
-	dcsr = DCSR(dma_ch);
-	DCSR(dma_ch) = dcsr & ~DCSR_STOPIRQEN;
-
-	if (dcsr & DCSR_ENDINTR) {
-		snd_pcm_period_elapsed(substream);
-	} else {
-		printk(KERN_ERR "%s: DMA error on channel %d (DCSR=%#x)\n",
-			prtd->params->name, dma_ch, dcsr);
-	}
-}
+#include "../../arm/pxa2xx-pcm.h"
 
 static int pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
@@ -76,10 +26,6 @@ static int pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct pxa2xx_runtime_data *prtd = runtime->private_data;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct pxa2xx_pcm_dma_params *dma = rtd->dai->cpu_dai->dma_data;
-	size_t totsize = params_buffer_bytes(params);
-	size_t period = params_period_bytes(params);
-	pxa_dma_desc *dma_desc;
-	dma_addr_t dma_buff_phys, next_desc_phys;
 	int ret;
 
 	/* return if this is a bufferless transfer e.g.
@@ -106,42 +52,16 @@ static int pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
 		prtd->dma_ch = ret;
 	}
 
-	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
-	runtime->dma_bytes = totsize;
-
-	dma_desc = prtd->dma_desc_array;
-	next_desc_phys = prtd->dma_desc_array_phys;
-	dma_buff_phys = runtime->dma_addr;
-	do {
-		next_desc_phys += sizeof(pxa_dma_desc);
-		dma_desc->ddadr = next_desc_phys;
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			dma_desc->dsadr = dma_buff_phys;
-			dma_desc->dtadr = prtd->params->dev_addr;
-		} else {
-			dma_desc->dsadr = prtd->params->dev_addr;
-			dma_desc->dtadr = dma_buff_phys;
-		}
-		if (period > totsize)
-			period = totsize;
-		dma_desc->dcmd = prtd->params->dcmd | period | DCMD_ENDIRQEN;
-		dma_desc++;
-		dma_buff_phys += period;
-	} while (totsize -= period);
-	dma_desc[-1].ddadr = prtd->dma_desc_array_phys;
-
-	return 0;
+	return __pxa2xx_pcm_hw_params(substream, params);
 }
 
 static int pxa2xx_pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	struct pxa2xx_runtime_data *prtd = substream->runtime->private_data;
 
-	if (prtd && prtd->params)
-		*prtd->params->drcmr = 0;
+	__pxa2xx_pcm_hw_free(substream);
 
 	if (prtd->dma_ch) {
-		snd_pcm_set_runtime_buffer(substream, NULL);
 		pxa_free_dma(prtd->dma_ch);
 		prtd->dma_ch = 0;
 	}
@@ -149,185 +69,18 @@ static int pxa2xx_pcm_hw_free(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int pxa2xx_pcm_prepare(struct snd_pcm_substream *substream)
-{
-	struct pxa2xx_runtime_data *prtd = substream->runtime->private_data;
-
-	DCSR(prtd->dma_ch) &= ~DCSR_RUN;
-	DCSR(prtd->dma_ch) = 0;
-	DCMD(prtd->dma_ch) = 0;
-	*prtd->params->drcmr = prtd->dma_ch | DRCMR_MAPVLD;
-
-	return 0;
-}
-
-static int pxa2xx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
-{
-	struct pxa2xx_runtime_data *prtd = substream->runtime->private_data;
-	int ret = 0;
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-		DDADR(prtd->dma_ch) = prtd->dma_desc_array_phys;
-		DCSR(prtd->dma_ch) = DCSR_RUN;
-		break;
-
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		DCSR(prtd->dma_ch) &= ~DCSR_RUN;
-		break;
-
-	case SNDRV_PCM_TRIGGER_RESUME:
-		DCSR(prtd->dma_ch) |= DCSR_RUN;
-		break;
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		DDADR(prtd->dma_ch) = prtd->dma_desc_array_phys;
-		DCSR(prtd->dma_ch) |= DCSR_RUN;
-		break;
-
-	default:
-		ret = -EINVAL;
-	}
-
-	return ret;
-}
-
-static snd_pcm_uframes_t
-pxa2xx_pcm_pointer(struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct pxa2xx_runtime_data *prtd = runtime->private_data;
-
-	dma_addr_t ptr = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
-			 DSADR(prtd->dma_ch) : DTADR(prtd->dma_ch);
-	snd_pcm_uframes_t x = bytes_to_frames(runtime, ptr - runtime->dma_addr);
-
-	if (x == runtime->buffer_size)
-		x = 0;
-	return x;
-}
-
-static int pxa2xx_pcm_open(struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct pxa2xx_runtime_data *prtd;
-	int ret;
-
-	snd_soc_set_runtime_hwparams(substream, &pxa2xx_pcm_hardware);
-
-	/*
-	 * For mysterious reasons (and despite what the manual says)
-	 * playback samples are lost if the DMA count is not a multiple
-	 * of the DMA burst size.  Let's add a rule to enforce that.
-	 */
-	ret = snd_pcm_hw_constraint_step(runtime, 0,
-		SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 32);
-	if (ret)
-		goto out;
-
-	ret = snd_pcm_hw_constraint_step(runtime, 0,
-		SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 32);
-	if (ret)
-		goto out;
-
-	ret = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
-	if (ret < 0)
-		goto out;
-
-	prtd = kzalloc(sizeof(struct pxa2xx_runtime_data), GFP_KERNEL);
-	if (prtd == NULL) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	prtd->dma_desc_array =
-		dma_alloc_writecombine(substream->pcm->card->dev, PAGE_SIZE,
-				       &prtd->dma_desc_array_phys, GFP_KERNEL);
-	if (!prtd->dma_desc_array) {
-		ret = -ENOMEM;
-		goto err1;
-	}
-
-	runtime->private_data = prtd;
-	return 0;
-
- err1:
-	kfree(prtd);
- out:
-	return ret;
-}
-
-static int pxa2xx_pcm_close(struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct pxa2xx_runtime_data *prtd = runtime->private_data;
-
-	dma_free_writecombine(substream->pcm->card->dev, PAGE_SIZE,
-			      prtd->dma_desc_array, prtd->dma_desc_array_phys);
-	kfree(prtd);
-	return 0;
-}
-
-static int pxa2xx_pcm_mmap(struct snd_pcm_substream *substream,
-	struct vm_area_struct *vma)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	return dma_mmap_writecombine(substream->pcm->card->dev, vma,
-				     runtime->dma_area,
-				     runtime->dma_addr,
-				     runtime->dma_bytes);
-}
-
 struct snd_pcm_ops pxa2xx_pcm_ops = {
-	.open		= pxa2xx_pcm_open,
-	.close		= pxa2xx_pcm_close,
+	.open		= __pxa2xx_pcm_open,
+	.close		= __pxa2xx_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= pxa2xx_pcm_hw_params,
 	.hw_free	= pxa2xx_pcm_hw_free,
-	.prepare	= pxa2xx_pcm_prepare,
+	.prepare	= __pxa2xx_pcm_prepare,
 	.trigger	= pxa2xx_pcm_trigger,
 	.pointer	= pxa2xx_pcm_pointer,
 	.mmap		= pxa2xx_pcm_mmap,
 };
 
-static int pxa2xx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
-{
-	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
-	struct snd_dma_buffer *buf = &substream->dma_buffer;
-	size_t size = pxa2xx_pcm_hardware.buffer_bytes_max;
-	buf->dev.type = SNDRV_DMA_TYPE_DEV;
-	buf->dev.dev = pcm->card->dev;
-	buf->private_data = NULL;
-	buf->area = dma_alloc_writecombine(pcm->card->dev, size,
-					   &buf->addr, GFP_KERNEL);
-	if (!buf->area)
-		return -ENOMEM;
-	buf->bytes = size;
-	return 0;
-}
-
-static void pxa2xx_pcm_free_dma_buffers(struct snd_pcm *pcm)
-{
-	struct snd_pcm_substream *substream;
-	struct snd_dma_buffer *buf;
-	int stream;
-
-	for (stream = 0; stream < 2; stream++) {
-		substream = pcm->streams[stream].substream;
-		if (!substream)
-			continue;
-
-		buf = &substream->dma_buffer;
-		if (!buf->area)
-			continue;
-
-		dma_free_writecombine(pcm->card->dev, buf->bytes,
-				      buf->area, buf->addr);
-		buf->area = NULL;
-	}
-}
-
 static u64 pxa2xx_pcm_dmamask = DMA_32BIT_MASK;
 
 static int pxa2xx_soc_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
diff --git a/sound/soc/pxa/pxa2xx-pcm.h b/sound/soc/pxa/pxa2xx-pcm.h
index 54c9c75..60c3b20 100644
--- a/sound/soc/pxa/pxa2xx-pcm.h
+++ b/sound/soc/pxa/pxa2xx-pcm.h
@@ -13,21 +13,6 @@
 #ifndef _PXA2XX_PCM_H
 #define _PXA2XX_PCM_H
 
-struct pxa2xx_pcm_dma_params {
-	char *name;			/* stream identifier */
-	u32 dcmd;			/* DMA descriptor dcmd field */
-	volatile u32 *drcmr;		/* the DMA request channel to use */
-	u32 dev_addr;			/* device physical address for DMA */
-};
-
-struct pxa2xx_gpio {
-	u32 sys;
-	u32	rx;
-	u32 tx;
-	u32 clk;
-	u32 frm;
-};
-
 /* platform data */
 extern struct snd_soc_platform pxa2xx_soc_platform;
 
-- 
1.5.6.5
