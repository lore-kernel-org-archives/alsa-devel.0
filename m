From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] Revised AT32 ASoC Patch
Date: Thu,  5 Jun 2008 13:49:34 +0100
Message-ID: <1212670174-19810-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1212670174-19810-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1212670174-19810-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 189751037F7
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jun 2008 14:49:37 +0200 (CEST)
In-Reply-To: <1212670174-19810-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Geoffrey Wossum <gwossum@acm.org>, Geoffrey Wossum <geoffrey@pager.net>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Geoffrey Wossum <geoffrey@pager.net>

Attached is a revised version of my patch to add AT32 to ASoC.  This cleans
most of the style issues associated with the previous patch.  Also fixes an
issue with the playpaq_wm8510.c code depending on a non-released patch to th
AT32 portmux support.

Patch is against 2.6.24.3.atmel.3 kernel, the latest AVR32 kernel Atmel has
released, with the linux-2.6-asoc patches from when v2.6.24 was tagged also
applied.

[Fixed up minor checkpatch issues and updated for current kernels -- broonie]

Signed-off-by: Geoffrey Wossum <gwossum@acm.org>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/Kconfig               |    1 +
 sound/soc/Makefile              |    3 +-
 sound/soc/at32/Kconfig          |   34 ++
 sound/soc/at32/Makefile         |   11 +
 sound/soc/at32/at32-pcm.c       |  491 ++++++++++++++++++++++
 sound/soc/at32/at32-pcm.h       |   79 ++++
 sound/soc/at32/at32-ssc.c       |  849 +++++++++++++++++++++++++++++++++++++++
 sound/soc/at32/at32-ssc.h       |   59 +++
 sound/soc/at32/playpaq_wm8510.c |  524 ++++++++++++++++++++++++
 9 files changed, 2050 insertions(+), 1 deletions(-)
 create mode 100644 sound/soc/at32/Kconfig
 create mode 100644 sound/soc/at32/Makefile
 create mode 100644 sound/soc/at32/at32-pcm.c
 create mode 100644 sound/soc/at32/at32-pcm.h
 create mode 100644 sound/soc/at32/at32-ssc.c
 create mode 100644 sound/soc/at32/at32-ssc.h
 create mode 100644 sound/soc/at32/playpaq_wm8510.c

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index fd7bc4f..b939e22 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -22,6 +22,7 @@ config SND_SOC_AC97_BUS
 	bool
 
 # All the supported Soc's
+source "sound/soc/at32/Kconfig"
 source "sound/soc/at91/Kconfig"
 source "sound/soc/pxa/Kconfig"
 source "sound/soc/s3c24xx/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 782db21..3645f95 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -1,4 +1,5 @@
 snd-soc-core-objs := soc-core.o soc-dapm.o
 
 obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
-obj-$(CONFIG_SND_SOC)	+= codecs/ at91/ pxa/ s3c24xx/ sh/ fsl/ davinci/ omap/
+obj-$(CONFIG_SND_SOC)	+= codecs/ at32/ at91/ pxa/ s3c24xx/ sh/ fsl/ davinci/
+obj-$(CONFIG_SND_SOC)	+= omap/
diff --git a/sound/soc/at32/Kconfig b/sound/soc/at32/Kconfig
new file mode 100644
index 0000000..b0765e8
--- /dev/null
+++ b/sound/soc/at32/Kconfig
@@ -0,0 +1,34 @@
+config SND_AT32_SOC
+        tristate "SoC Audio for the Atmel AT32 System-on-a-Chip"
+        depends on AVR32 && SND_SOC
+        help
+          Say Y or M if you want to add support for codecs attached to 
+          the AT32 SSC interface.  You will also need to
+          to select the audio interfaces to support below.
+
+
+config SND_AT32_SOC_SSC
+        tristate
+
+
+
+config SND_AT32_SOC_PLAYPAQ
+        tristate "SoC Audio support for PlayPaq with WM8510"
+        depends on SND_AT32_SOC && BOARD_PLAYPAQ
+        select SND_AT32_SOC_SSC
+        select SND_SOC_WM8510
+        help
+          Say Y or M here if you want to add support for SoC audio
+          on the LRS PlayPaq.
+
+
+
+config SND_AT32_SOC_PLAYPAQ_SLAVE
+        bool "Run CODEC on PlayPaq in slave mode"
+        depends on SND_AT32_SOC_PLAYPAQ
+        default n
+        help
+          Say Y if you want to run with the AT32 SSC generating the BCLK
+          and FRAME signals on the PlayPaq.  Unless you want to play
+          with the AT32 as the SSC master, you probably want to say N here,
+          as this will give you better sound quality.
diff --git a/sound/soc/at32/Makefile b/sound/soc/at32/Makefile
new file mode 100644
index 0000000..c03e55e
--- /dev/null
+++ b/sound/soc/at32/Makefile
@@ -0,0 +1,11 @@
+# AT32 Platform Support
+snd-soc-at32-objs := at32-pcm.o
+snd-soc-at32-ssc-objs := at32-ssc.o
+
+obj-$(CONFIG_SND_AT32_SOC) += snd-soc-at32.o
+obj-$(CONFIG_SND_AT32_SOC_SSC) += snd-soc-at32-ssc.o
+
+# AT32 Machine Support
+snd-soc-playpaq-objs := playpaq_wm8510.o
+
+obj-$(CONFIG_SND_AT32_SOC_PLAYPAQ) += snd-soc-playpaq.o
diff --git a/sound/soc/at32/at32-pcm.c b/sound/soc/at32/at32-pcm.c
new file mode 100644
index 0000000..cf76e89
--- /dev/null
+++ b/sound/soc/at32/at32-pcm.c
@@ -0,0 +1,491 @@
+/* sound/soc/at32/at32-pcm.c
+ * ASoC PCM interface for Atmel AT32 SoC
+ *
+ * Copyright (C) 2008 Long Range Systems
+ *    Geoffrey Wossum <gwossum@acm.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Note that this is basically a port of the sound/soc/at91-pcm.c to
+ * the AVR32 kernel.  Thanks to Frank Mandarino for that code.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+#include <linux/atmel_pdc.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include "at32-pcm.h"
+
+
+
+/*--------------------------------------------------------------------------*\
+ * Hardware definition
+\*--------------------------------------------------------------------------*/
+/* TODO: These values were taken from the AT91 platform driver, check
+ *	 them against real values for AT32
+ */
+static const struct snd_pcm_hardware at32_pcm_hardware = {
+	.info = (SNDRV_PCM_INFO_MMAP |
+		 SNDRV_PCM_INFO_MMAP_VALID |
+		 SNDRV_PCM_INFO_INTERLEAVED |
+		 SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		 SNDRV_PCM_INFO_PAUSE),
+
+	.formats = SNDRV_PCM_FMTBIT_S16,
+	.period_bytes_min = 32,
+	.period_bytes_max = 8192,	/* 512 frames * 16 bytes / frame */
+	.periods_min = 2,
+	.periods_max = 1024,
+	.buffer_bytes_max = 32 * 1024,
+};
+
+
+
+/*--------------------------------------------------------------------------*\
+ * Data types
+\*--------------------------------------------------------------------------*/
+struct at32_runtime_data {
+	struct at32_pcm_dma_params *params;
+	dma_addr_t dma_buffer;	/* physical address of DMA buffer */
+	dma_addr_t dma_buffer_end; /* first address beyond DMA buffer */
+	size_t period_size;
+
+	dma_addr_t period_ptr;	/* physical address of next period */
+	int periods;		/* period index of period_ptr */
+
+	/* Save PDC registers (for power management) */
+	u32 pdc_xpr_save;
+	u32 pdc_xcr_save;
+	u32 pdc_xnpr_save;
+	u32 pdc_xncr_save;
+};
+
+
+
+/*--------------------------------------------------------------------------*\
+ * Helper functions
+\*--------------------------------------------------------------------------*/
+static int at32_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
+{
+	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
+	struct snd_dma_buffer *dmabuf = &substream->dma_buffer;
+	size_t size = at32_pcm_hardware.buffer_bytes_max;
+
+	dmabuf->dev.type = SNDRV_DMA_TYPE_DEV;
+	dmabuf->dev.dev = pcm->card->dev;
+	dmabuf->private_data = NULL;
+	dmabuf->area = dma_alloc_coherent(pcm->card->dev, size,
+					  &dmabuf->addr, GFP_KERNEL);
+	pr_debug("at32_pcm: preallocate_dma_buffer: "
+		 "area=%p, addr=%p, size=%ld\n",
+		 (void *)dmabuf->area, (void *)dmabuf->addr, size);
+
+	if (!dmabuf->area)
+		return -ENOMEM;
+
+	dmabuf->bytes = size;
+	return 0;
+}
+
+
+
+/*--------------------------------------------------------------------------*\
+ * ISR
+\*--------------------------------------------------------------------------*/
+static void at32_pcm_dma_irq(u32 ssc_sr, struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *rtd = substream->runtime;
+	struct at32_runtime_data *prtd = rtd->private_data;
+	struct at32_pcm_dma_params *params = prtd->params;
+	static int count;
+
+	count++;
+	if (ssc_sr & params->mask->ssc_endbuf) {
+		pr_warning("at32-pcm: buffer %s on %s (SSC_SR=%#x, count=%d)\n",
+			   substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
+			   "underrun" : "overrun", params->name, ssc_sr, count);
+
+		/* re-start the PDC */
+		ssc_writex(params->ssc->regs, ATMEL_PDC_PTCR,
+			   params->mask->pdc_disable);
+		prtd->period_ptr += prtd->period_size;
+		if (prtd->period_ptr >= prtd->dma_buffer_end)
+			prtd->period_ptr = prtd->dma_buffer;
+
+
+		ssc_writex(params->ssc->regs, params->pdc->xpr,
+			   prtd->period_ptr);
+		ssc_writex(params->ssc->regs, params->pdc->xcr,
+			   prtd->period_size / params->pdc_xfer_size);
+		ssc_writex(params->ssc->regs, ATMEL_PDC_PTCR,
+			   params->mask->pdc_enable);
+	}
+
+
+	if (ssc_sr & params->mask->ssc_endx) {
+		/* Load the PDC next pointer and counter registers */
+		prtd->period_ptr += prtd->period_size;
+		if (prtd->period_ptr >= prtd->dma_buffer_end)
+			prtd->period_ptr = prtd->dma_buffer;
+		ssc_writex(params->ssc->regs, params->pdc->xnpr,
+			   prtd->period_ptr);
+		ssc_writex(params->ssc->regs, params->pdc->xncr,
+			   prtd->period_size / params->pdc_xfer_size);
+	}
+
+
+	snd_pcm_period_elapsed(substream);
+}
+
+
+
+/*--------------------------------------------------------------------------*\
+ * PCM operations
+\*--------------------------------------------------------------------------*/
+static int at32_pcm_hw_params(struct snd_pcm_substream *substream,
+			      struct snd_pcm_hw_params *params)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct at32_runtime_data *prtd = runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+
+	/* this may get called several times by oss emulation
+	 * with different params
+	 */
+	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+	runtime->dma_bytes = params_buffer_bytes(params);
+
+	prtd->params = rtd->dai->cpu_dai->dma_data;
+	prtd->params->dma_intr_handler = at32_pcm_dma_irq;
+
+	prtd->dma_buffer = runtime->dma_addr;
+	prtd->dma_buffer_end = runtime->dma_addr + runtime->dma_bytes;
+	prtd->period_size = params_period_bytes(params);
+
+	pr_debug("hw_params: DMA for %s initialized "
+		 "(dma_bytes=%ld, period_size=%ld)\n",
+		 prtd->params->name, runtime->dma_bytes, prtd->period_size);
+
+	return 0;
+}
+
+
+
+static int at32_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	struct at32_runtime_data *prtd = substream->runtime->private_data;
+	struct at32_pcm_dma_params *params = prtd->params;
+
+	if (params != NULL) {
+		ssc_writex(params->ssc->regs, SSC_PDC_PTCR,
+			   params->mask->pdc_disable);
+		prtd->params->dma_intr_handler = NULL;
+	}
+
+	return 0;
+}
+
+
+
+static int at32_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct at32_runtime_data *prtd = substream->runtime->private_data;
+	struct at32_pcm_dma_params *params = prtd->params;
+
+	ssc_writex(params->ssc->regs, SSC_IDR,
+		   params->mask->ssc_endx | params->mask->ssc_endbuf);
+	ssc_writex(params->ssc->regs, ATMEL_PDC_PTCR,
+		   params->mask->pdc_disable);
+
+	return 0;
+}
+
+
+static int at32_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_pcm_runtime *rtd = substream->runtime;
+	struct at32_runtime_data *prtd = rtd->private_data;
+	struct at32_pcm_dma_params *params = prtd->params;
+	int ret = 0;
+
+	pr_debug("at32_pcm_trigger: buffer_size = %ld, "
+		 "dma_area = %p, dma_bytes = %ld\n",
+		 rtd->buffer_size, rtd->dma_area, rtd->dma_bytes);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		prtd->period_ptr = prtd->dma_buffer;
+
+		ssc_writex(params->ssc->regs, params->pdc->xpr,
+			   prtd->period_ptr);
+		ssc_writex(params->ssc->regs, params->pdc->xcr,
+			   prtd->period_size / params->pdc_xfer_size);
+
+		prtd->period_ptr += prtd->period_size;
+		ssc_writex(params->ssc->regs, params->pdc->xnpr,
+			   prtd->period_ptr);
+		ssc_writex(params->ssc->regs, params->pdc->xncr,
+			   prtd->period_size / params->pdc_xfer_size);
+
+		pr_debug("trigger: period_ptr=%lx, xpr=%x, "
+			 "xcr=%d, xnpr=%x, xncr=%d\n",
+			 (unsigned long)prtd->period_ptr,
+			 ssc_readx(params->ssc->regs, params->pdc->xpr),
+			 ssc_readx(params->ssc->regs, params->pdc->xcr),
+			 ssc_readx(params->ssc->regs, params->pdc->xnpr),
+			 ssc_readx(params->ssc->regs, params->pdc->xncr));
+
+		ssc_writex(params->ssc->regs, SSC_IER,
+			   params->mask->ssc_endx | params->mask->ssc_endbuf);
+		ssc_writex(params->ssc->regs, SSC_PDC_PTCR,
+			   params->mask->pdc_enable);
+
+		pr_debug("sr=%x, imr=%x\n",
+			 ssc_readx(params->ssc->regs, SSC_SR),
+			 ssc_readx(params->ssc->regs, SSC_IER));
+		break;		/* SNDRV_PCM_TRIGGER_START */
+
+
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		ssc_writex(params->ssc->regs, ATMEL_PDC_PTCR,
+			   params->mask->pdc_disable);
+		break;
+
+
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		ssc_writex(params->ssc->regs, ATMEL_PDC_PTCR,
+			   params->mask->pdc_enable);
+		break;
+
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+
+
+static snd_pcm_uframes_t at32_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct at32_runtime_data *prtd = runtime->private_data;
+	struct at32_pcm_dma_params *params = prtd->params;
+	dma_addr_t ptr;
+	snd_pcm_uframes_t x;
+
+	ptr = (dma_addr_t) ssc_readx(params->ssc->regs, params->pdc->xpr);
+	x = bytes_to_frames(runtime, ptr - prtd->dma_buffer);
+
+	if (x == runtime->buffer_size)
+		x = 0;
+
+	return x;
+}
+
+
+
+static int at32_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct at32_runtime_data *prtd;
+	int ret = 0;
+
+	snd_soc_set_runtime_hwparams(substream, &at32_pcm_hardware);
+
+	/* ensure that buffer size is a multiple of period size */
+	ret = snd_pcm_hw_constraint_integer(runtime,
+					    SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0)
+		goto out;
+
+	prtd = kzalloc(sizeof(*prtd), GFP_KERNEL);
+	if (prtd == NULL) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	runtime->private_data = prtd;
+
+
+out:
+	return ret;
+}
+
+
+
+static int at32_pcm_close(struct snd_pcm_substream *substream)
+{
+	struct at32_runtime_data *prtd = substream->runtime->private_data;
+
+	kfree(prtd);
+	return 0;
+}
+
+
+static int at32_pcm_mmap(struct snd_pcm_substream *substream,
+			 struct vm_area_struct *vma)
+{
+	return remap_pfn_range(vma, vma->vm_start,
+			       substream->dma_buffer.addr >> PAGE_SHIFT,
+			       vma->vm_end - vma->vm_start, vma->vm_page_prot);
+}
+
+
+
+static struct snd_pcm_ops at32_pcm_ops = {
+	.open = at32_pcm_open,
+	.close = at32_pcm_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.hw_params = at32_pcm_hw_params,
+	.hw_free = at32_pcm_hw_free,
+	.prepare = at32_pcm_prepare,
+	.trigger = at32_pcm_trigger,
+	.pointer = at32_pcm_pointer,
+	.mmap = at32_pcm_mmap,
+};
+
+
+
+/*--------------------------------------------------------------------------*\
+ * ASoC platform driver
+\*--------------------------------------------------------------------------*/
+static u64 at32_pcm_dmamask = 0xffffffff;
+
+static int at32_pcm_new(struct snd_card *card,
+			struct snd_soc_codec_dai *dai,
+			struct snd_pcm *pcm)
+{
+	int ret = 0;
+
+	if (!card->dev->dma_mask)
+		card->dev->dma_mask = &at32_pcm_dmamask;
+	if (!card->dev->coherent_dma_mask)
+		card->dev->coherent_dma_mask = 0xffffffff;
+
+	if (dai->playback.channels_min) {
+		ret = at32_pcm_preallocate_dma_buffer(
+			  pcm, SNDRV_PCM_STREAM_PLAYBACK);
+		if (ret)
+			goto out;
+	}
+
+	if (dai->capture.channels_min) {
+		pr_debug("at32-pcm: Allocating PCM capture DMA buffer\n");
+		ret = at32_pcm_preallocate_dma_buffer(
+			  pcm, SNDRV_PCM_STREAM_CAPTURE);
+		if (ret)
+			goto out;
+	}
+
+
+out:
+	return ret;
+}
+
+
+
+static void at32_pcm_free_dma_buffers(struct snd_pcm *pcm)
+{
+	struct snd_pcm_substream *substream;
+	struct snd_dma_buffer *buf;
+	int stream;
+
+	for (stream = 0; stream < 2; stream++) {
+		substream = pcm->streams[stream].substream;
+		if (substream == NULL)
+			continue;
+
+		buf = &substream->dma_buffer;
+		if (!buf->area)
+			continue;
+		dma_free_coherent(pcm->card->dev, buf->bytes,
+				  buf->area, buf->addr);
+		buf->area = NULL;
+	}
+}
+
+
+
+#ifdef CONFIG_PM
+static int at32_pcm_suspend(struct platform_device *pdev,
+			    struct snd_soc_cpu_dai *dai)
+{
+	struct snd_pcm_runtime *runtime = dai->runtime;
+	struct at32_runtime_data *prtd;
+	struct at32_pcm_dma_params *params;
+
+	if (runtime == NULL)
+		return 0;
+	prtd = runtime->private_data;
+	params = prtd->params;
+
+	/* Disable the PDC and save the PDC registers */
+	ssc_writex(params->ssc->regs, PDC_PTCR, params->mask->pdc_disable);
+
+	prtd->pdc_xpr_save = ssc_readx(params->ssc->regs, params->pdc->xpr);
+	prtd->pdc_xcr_save = ssc_readx(params->ssc->regs, params->pdc->xcr);
+	prtd->pdc_xnpr_save = ssc_readx(params->ssc->regs, params->pdc->xnpr);
+	prtd->pdc_xncr_save = ssc_readx(params->ssc->regs, params->pdc->xncr);
+
+	return 0;
+}
+
+
+
+static int at32_pcm_resume(struct platform_device *pdev,
+			   struct snd_soc_cpu_dai *dai)
+{
+	struct snd_pcm_runtime *runtime = dai->runtime;
+	struct at32_runtime_data *prtd;
+	struct at32_pcm_dma_params *params;
+
+	if (runtime == NULL)
+		return 0;
+	prtd = runtime->private_data;
+	params = prtd->params;
+
+	/* Restore the PDC registers and enable the PDC */
+	ssc_writex(params->ssc->regs, params->pdc->xpr, prtd->pdc_xpr_save);
+	ssc_writex(params->ssc->regs, params->pdc->xcr, prtd->pdc_xcr_save);
+	ssc_writex(params->ssc->regs, params->pdc->xnpr, prtd->pdc_xnpr_save);
+	ssc_writex(params->ssc->regs, params->pdc->xncr, prtd->pdc_xncr_save);
+
+	ssc_writex(params->ssc->regs, PDC_PTCR, params->mask->pdc_enable);
+	return 0;
+}
+#else /* CONFIG_PM */
+#  define at32_pcm_suspend	NULL
+#  define at32_pcm_resume	NULL
+#endif /* CONFIG_PM */
+
+
+
+struct snd_soc_platform at32_soc_platform = {
+	.name = "at32-audio",
+	.pcm_ops = &at32_pcm_ops,
+	.pcm_new = at32_pcm_new,
+	.pcm_free = at32_pcm_free_dma_buffers,
+	.suspend = at32_pcm_suspend,
+	.resume = at32_pcm_resume,
+};
+EXPORT_SYMBOL_GPL(at32_soc_platform);
+
+
+
+MODULE_AUTHOR("Geoffrey Wossum <gwossum@acm.org>");
+MODULE_DESCRIPTION("Atmel AT32 PCM module");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/at32/at32-pcm.h b/sound/soc/at32/at32-pcm.h
new file mode 100644
index 0000000..2a52430
--- /dev/null
+++ b/sound/soc/at32/at32-pcm.h
@@ -0,0 +1,79 @@
+/* sound/soc/at32/at32-pcm.h
+ * ASoC PCM interface for Atmel AT32 SoC
+ *
+ * Copyright (C) 2008 Long Range Systems
+ *    Geoffrey Wossum <gwossum@acm.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __SOUND_SOC_AT32_AT32_PCM_H
+#define __SOUND_SOC_AT32_AT32_PCM_H __FILE__
+
+#include <linux/atmel-ssc.h>
+
+
+/*
+ * Registers and status bits that are required by the PCM driver
+ * TODO: Is ptcr really used?
+ */
+struct at32_pdc_regs {
+	u32 xpr;		/* PDC RX/TX pointer */
+	u32 xcr;		/* PDC RX/TX counter */
+	u32 xnpr;		/* PDC next RX/TX pointer */
+	u32 xncr;		/* PDC next RX/TX counter */
+	u32 ptcr;		/* PDC transfer control */
+};
+
+
+
+/*
+ * SSC mask info
+ */
+struct at32_ssc_mask {
+	u32 ssc_enable;		/* SSC RX/TX enable */
+	u32 ssc_disable;	/* SSC RX/TX disable */
+	u32 ssc_endx;		/* SSC ENDTX or ENDRX */
+	u32 ssc_endbuf;		/* SSC TXBUFF or RXBUFF */
+	u32 pdc_enable;		/* PDC RX/TX enable */
+	u32 pdc_disable;	/* PDC RX/TX disable */
+};
+
+
+
+/*
+ * This structure, shared between the PCM driver and the interface,
+ * contains all information required by the PCM driver to perform the
+ * PDC DMA operation.  All fields except dma_intr_handler() are initialized
+ * by the interface.  The dms_intr_handler() pointer is set by the PCM
+ * driver and called by the interface SSC interrupt handler if it is
+ * non-NULL.
+ */
+struct at32_pcm_dma_params {
+	char *name;		/* stream identifier */
+	int pdc_xfer_size;	/* PDC counter increment in bytes */
+	struct ssc_device *ssc;	/* SSC device for stream */
+	struct at32_pdc_regs *pdc;	/* PDC register info */
+	struct at32_ssc_mask *mask;	/* SSC mask info */
+	struct snd_pcm_substream *substream;
+	void (*dma_intr_handler) (u32, struct snd_pcm_substream *);
+};
+
+
+
+/*
+ * The AT32 ASoC platform driver
+ */
+extern struct snd_soc_platform at32_soc_platform;
+
+
+
+/*
+ * SSC register access (since ssc_writel() / ssc_readl() require literal name)
+ */
+#define ssc_readx(base, reg)            (__raw_readl((base) + (reg)))
+#define ssc_writex(base, reg, value)    __raw_writel((value), (base) + (reg))
+
+#endif /* __SOUND_SOC_AT32_AT32_PCM_H */
diff --git a/sound/soc/at32/at32-ssc.c b/sound/soc/at32/at32-ssc.c
new file mode 100644
index 0000000..0ca4410
--- /dev/null
+++ b/sound/soc/at32/at32-ssc.c
@@ -0,0 +1,849 @@
+/* sound/soc/at32/at32-ssc.c
+ * ASoC platform driver for AT32 using SSC as DAI
+ *
+ * Copyright (C) 2008 Long Range Systems
+ *    Geoffrey Wossum <gwossum@acm.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Note that this is basically a port of the sound/soc/at91-ssc.c to
+ * the AVR32 kernel.  Thanks to Frank Mandarino for that code.
+ */
+
+/* #define DEBUG */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/atmel_pdc.h>
+#include <linux/atmel-ssc.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+
+#include "at32-pcm.h"
+#include "at32-ssc.h"
+
+
+
+/*-------------------------------------------------------------------------*\
+ * Constants
+\*-------------------------------------------------------------------------*/
+#define NUM_SSC_DEVICES		3
+
+/*
+ * SSC direction masks
+ */
+#define SSC_DIR_MASK_UNUSED	0
+#define SSC_DIR_MASK_PLAYBACK	1
+#define SSC_DIR_MASK_CAPTURE	2
+
+/*
+ * SSC register values that Atmel left out of <linux/atmel-ssc.h>.  These
+ * are expected to be used with SSC_BF
+ */
+/* START bit field values */
+#define SSC_START_CONTINUOUS	0
+#define SSC_START_TX_RX		1
+#define SSC_START_LOW_RF	2
+#define SSC_START_HIGH_RF	3
+#define SSC_START_FALLING_RF	4
+#define SSC_START_RISING_RF	5
+#define SSC_START_LEVEL_RF	6
+#define SSC_START_EDGE_RF	7
+#define SSS_START_COMPARE_0	8
+
+/* CKI bit field values */
+#define SSC_CKI_FALLING		0
+#define SSC_CKI_RISING		1
+
+/* CKO bit field values */
+#define SSC_CKO_NONE		0
+#define SSC_CKO_CONTINUOUS	1
+#define SSC_CKO_TRANSFER	2
+
+/* CKS bit field values */
+#define SSC_CKS_DIV		0
+#define SSC_CKS_CLOCK		1
+#define SSC_CKS_PIN		2
+
+/* FSEDGE bit field values */
+#define SSC_FSEDGE_POSITIVE	0
+#define SSC_FSEDGE_NEGATIVE	1
+
+/* FSOS bit field values */
+#define SSC_FSOS_NONE		0
+#define SSC_FSOS_NEGATIVE	1
+#define SSC_FSOS_POSITIVE	2
+#define SSC_FSOS_LOW		3
+#define SSC_FSOS_HIGH		4
+#define SSC_FSOS_TOGGLE		5
+
+#define START_DELAY		1
+
+
+
+/*-------------------------------------------------------------------------*\
+ * Module data
+\*-------------------------------------------------------------------------*/
+/*
+ * SSC PDC registered required by the PCM DMA engine
+ */
+static struct at32_pdc_regs pdc_tx_reg = {
+	.xpr = SSC_PDC_TPR,
+	.xcr = SSC_PDC_TCR,
+	.xnpr = SSC_PDC_TNPR,
+	.xncr = SSC_PDC_TNCR,
+};
+
+
+
+static struct at32_pdc_regs pdc_rx_reg = {
+	.xpr = SSC_PDC_RPR,
+	.xcr = SSC_PDC_RCR,
+	.xnpr = SSC_PDC_RNPR,
+	.xncr = SSC_PDC_RNCR,
+};
+
+
+
+/*
+ * SSC and PDC status bits for transmit and receive
+ */
+static struct at32_ssc_mask ssc_tx_mask = {
+	.ssc_enable = SSC_BIT(CR_TXEN),
+	.ssc_disable = SSC_BIT(CR_TXDIS),
+	.ssc_endx = SSC_BIT(SR_ENDTX),
+	.ssc_endbuf = SSC_BIT(SR_TXBUFE),
+	.pdc_enable = SSC_BIT(PDC_PTCR_TXTEN),
+	.pdc_disable = SSC_BIT(PDC_PTCR_TXTDIS),
+};
+
+
+
+static struct at32_ssc_mask ssc_rx_mask = {
+	.ssc_enable = SSC_BIT(CR_RXEN),
+	.ssc_disable = SSC_BIT(CR_RXDIS),
+	.ssc_endx = SSC_BIT(SR_ENDRX),
+	.ssc_endbuf = SSC_BIT(SR_RXBUFF),
+	.pdc_enable = SSC_BIT(PDC_PTCR_RXTEN),
+	.pdc_disable = SSC_BIT(PDC_PTCR_RXTDIS),
+};
+
+
+
+/*
+ * DMA parameters for each SSC
+ */
+static struct at32_pcm_dma_params ssc_dma_params[NUM_SSC_DEVICES][2] = {
+	{
+	 {
+	  .name = "SSC0 PCM out",
+	  .pdc = &pdc_tx_reg,
+	  .mask = &ssc_tx_mask,
+	  },
+	 {
+	  .name = "SSC0 PCM in",
+	  .pdc = &pdc_rx_reg,
+	  .mask = &ssc_rx_mask,
+	  },
+	 },
+	{
+	 {
+	  .name = "SSC1 PCM out",
+	  .pdc = &pdc_tx_reg,
+	  .mask = &ssc_tx_mask,
+	  },
+	 {
+	  .name = "SSC1 PCM in",
+	  .pdc = &pdc_rx_reg,
+	  .mask = &ssc_rx_mask,
+	  },
+	 },
+	{
+	 {
+	  .name = "SSC2 PCM out",
+	  .pdc = &pdc_tx_reg,
+	  .mask = &ssc_tx_mask,
+	  },
+	 {
+	  .name = "SSC2 PCM in",
+	  .pdc = &pdc_rx_reg,
+	  .mask = &ssc_rx_mask,
+	  },
+	 },
+};
+
+
+
+static struct at32_ssc_info ssc_info[NUM_SSC_DEVICES] = {
+	{
+	 .name = "ssc0",
+	 .lock = __SPIN_LOCK_UNLOCKED(ssc_info[0].lock),
+	 .dir_mask = SSC_DIR_MASK_UNUSED,
+	 .initialized = 0,
+	 },
+	{
+	 .name = "ssc1",
+	 .lock = __SPIN_LOCK_UNLOCKED(ssc_info[1].lock),
+	 .dir_mask = SSC_DIR_MASK_UNUSED,
+	 .initialized = 0,
+	 },
+	{
+	 .name = "ssc2",
+	 .lock = __SPIN_LOCK_UNLOCKED(ssc_info[2].lock),
+	 .dir_mask = SSC_DIR_MASK_UNUSED,
+	 .initialized = 0,
+	 },
+};
+
+
+
+
+/*-------------------------------------------------------------------------*\
+ * ISR
+\*-------------------------------------------------------------------------*/
+/*
+ * SSC interrupt handler.  Passes PDC interrupts to the DMA interrupt
+ * handler in the PCM driver.
+ */
+static irqreturn_t at32_ssc_interrupt(int irq, void *dev_id)
+{
+	struct at32_ssc_info *ssc_p = dev_id;
+	struct at32_pcm_dma_params *dma_params;
+	u32 ssc_sr;
+	u32 ssc_substream_mask;
+	int i;
+
+	ssc_sr = (ssc_readl(ssc_p->ssc->regs, SR) &
+		  ssc_readl(ssc_p->ssc->regs, IMR));
+
+	/*
+	 * Loop through substreams attached to this SSC.  If a DMA-related
+	 * interrupt occured on that substream, call the DMA interrupt
+	 * handler function, if one has been registered in the dma_param
+	 * structure by the PCM driver.
+	 */
+	for (i = 0; i < ARRAY_SIZE(ssc_p->dma_params); i++) {
+		dma_params = ssc_p->dma_params[i];
+
+		if ((dma_params != NULL) &&
+		    (dma_params->dma_intr_handler != NULL)) {
+			ssc_substream_mask = (dma_params->mask->ssc_endx |
+					      dma_params->mask->ssc_endbuf);
+			if (ssc_sr & ssc_substream_mask) {
+				dma_params->dma_intr_handler(ssc_sr,
+							     dma_params->
+							     substream);
+			}
+		}
+	}
+
+
+	return IRQ_HANDLED;
+}
+
+/*-------------------------------------------------------------------------*\
+ * DAI functions
+\*-------------------------------------------------------------------------*/
+/*
+ * Startup.  Only that one substream allowed in each direction.
+ */
+static int at32_ssc_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct at32_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
+	int dir_mask;
+
+	dir_mask = ((substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
+		    SSC_DIR_MASK_PLAYBACK : SSC_DIR_MASK_CAPTURE);
+
+	spin_lock_irq(&ssc_p->lock);
+	if (ssc_p->dir_mask & dir_mask) {
+		spin_unlock_irq(&ssc_p->lock);
+		return -EBUSY;
+	}
+	ssc_p->dir_mask |= dir_mask;
+	spin_unlock_irq(&ssc_p->lock);
+
+	return 0;
+}
+
+
+
+/*
+ * Shutdown.  Clear DMA parameters and shutdown the SSC if there
+ * are no other substreams open.
+ */
+static void at32_ssc_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct at32_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
+	struct at32_pcm_dma_params *dma_params;
+	int dir_mask;
+
+	dma_params = ssc_p->dma_params[substream->stream];
+
+	if (dma_params != NULL) {
+		ssc_writel(dma_params->ssc->regs, CR,
+			   dma_params->mask->ssc_disable);
+		pr_debug("%s disabled SSC_SR=0x%08x\n",
+			 (substream->stream ? "receiver" : "transmit"),
+			 ssc_readl(ssc_p->ssc->regs, SR));
+
+		dma_params->ssc = NULL;
+		dma_params->substream = NULL;
+		ssc_p->dma_params[substream->stream] = NULL;
+	}
+
+
+	dir_mask = 1 << substream->stream;
+	spin_lock_irq(&ssc_p->lock);
+	ssc_p->dir_mask &= ~dir_mask;
+	if (!ssc_p->dir_mask) {
+		/* Shutdown the SSC clock */
+		pr_debug("at32-ssc: Stopping user %d clock\n",
+			 ssc_p->ssc->user);
+		clk_disable(ssc_p->ssc->clk);
+
+		if (ssc_p->initialized) {
+			free_irq(ssc_p->ssc->irq, ssc_p);
+			ssc_p->initialized = 0;
+		}
+
+		/* Reset the SSC */
+		ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_SWRST));
+
+		/* clear the SSC dividers */
+		ssc_p->cmr_div = 0;
+		ssc_p->tcmr_period = 0;
+		ssc_p->rcmr_period = 0;
+	}
+	spin_unlock_irq(&ssc_p->lock);
+}
+
+
+
+/*
+ * Set the SSC system clock rate
+ */
+static int at32_ssc_set_dai_sysclk(struct snd_soc_cpu_dai *cpu_dai,
+				   int clk_id, unsigned int freq, int dir)
+{
+	/* TODO: What the heck do I do here? */
+	return 0;
+}
+
+
+
+/*
+ * Record DAI format for use by hw_params()
+ */
+static int at32_ssc_set_dai_fmt(struct snd_soc_cpu_dai *cpu_dai,
+				unsigned int fmt)
+{
+	struct at32_ssc_info *ssc_p = &ssc_info[cpu_dai->id];
+
+	ssc_p->daifmt = fmt;
+	return 0;
+}
+
+
+
+/*
+ * Record SSC clock dividers for use in hw_params()
+ */
+static int at32_ssc_set_dai_clkdiv(struct snd_soc_cpu_dai *cpu_dai,
+				   int div_id, int div)
+{
+	struct at32_ssc_info *ssc_p = &ssc_info[cpu_dai->id];
+
+	switch (div_id) {
+	case AT32_SSC_CMR_DIV:
+		/*
+		 * The same master clock divider is used for both
+		 * transmit and receive, so if a value has already
+		 * been set, it must match this value
+		 */
+		if (ssc_p->cmr_div == 0)
+			ssc_p->cmr_div = div;
+		else if (div != ssc_p->cmr_div)
+			return -EBUSY;
+		break;
+
+	case AT32_SSC_TCMR_PERIOD:
+		ssc_p->tcmr_period = div;
+		break;
+
+	case AT32_SSC_RCMR_PERIOD:
+		ssc_p->rcmr_period = div;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+
+
+/*
+ * Configure the SSC
+ */
+static int at32_ssc_hw_params(struct snd_pcm_substream *substream,
+			      struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	int id = rtd->dai->cpu_dai->id;
+	struct at32_ssc_info *ssc_p = &ssc_info[id];
+	struct at32_pcm_dma_params *dma_params;
+	int channels, bits;
+	u32 tfmr, rfmr, tcmr, rcmr;
+	int start_event;
+	int ret;
+
+
+	/*
+	 * Currently, there is only one set of dma_params for each direction.
+	 * If more are added, this code will have to be changed to select
+	 * the proper set
+	 */
+	dma_params = &ssc_dma_params[id][substream->stream];
+	dma_params->ssc = ssc_p->ssc;
+	dma_params->substream = substream;
+
+	ssc_p->dma_params[substream->stream] = dma_params;
+
+
+	/*
+	 * The cpu_dai->dma_data field is only used to communicate the
+	 * appropriate DMA parameters to the PCM driver's hw_params()
+	 * function.  It should not be used for other purposes as it
+	 * is common to all substreams.
+	 */
+	rtd->dai->cpu_dai->dma_data = dma_params;
+
+	channels = params_channels(params);
+
+
+	/*
+	 * Determine sample size in bits and the PDC increment
+	 */
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S8:
+		bits = 8;
+		dma_params->pdc_xfer_size = 1;
+		break;
+
+	case SNDRV_PCM_FORMAT_S16:
+		bits = 16;
+		dma_params->pdc_xfer_size = 2;
+		break;
+
+	case SNDRV_PCM_FORMAT_S24:
+		bits = 24;
+		dma_params->pdc_xfer_size = 4;
+		break;
+
+	case SNDRV_PCM_FORMAT_S32:
+		bits = 32;
+		dma_params->pdc_xfer_size = 4;
+		break;
+
+	default:
+		pr_warning("at32-ssc: Unsupported PCM format %d",
+			   params_format(params));
+		return -EINVAL;
+	}
+	pr_debug("at32-ssc: bits = %d, pdc_xfer_size = %d, channels = %d\n",
+		 bits, dma_params->pdc_xfer_size, channels);
+
+
+	/*
+	 * The SSC only supports up to 16-bit samples in I2S format, due
+	 * to the size of the Frame Mode Register FSLEN field.
+	 */
+	if ((ssc_p->daifmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_I2S)
+		if (bits > 16) {
+			pr_warning("at32-ssc: "
+				   "sample size %d is too large for I2S\n",
+				   bits);
+			return -EINVAL;
+		}
+
+
+	/*
+	 * Compute the SSC register settings
+	 */
+	switch (ssc_p->daifmt & (SND_SOC_DAIFMT_FORMAT_MASK |
+				 SND_SOC_DAIFMT_MASTER_MASK)) {
+	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS:
+		/*
+		 * I2S format, SSC provides BCLK and LRS clocks.
+		 *
+		 * The SSC transmit and receive clocks are generated from the
+		 * MCK divider, and the BCLK signal is output on the SSC TK line
+		 */
+		pr_debug("at32-ssc: SSC mode is I2S BCLK / FRAME master\n");
+		rcmr = (SSC_BF(RCMR_PERIOD, ssc_p->rcmr_period) |
+			SSC_BF(RCMR_STTDLY, START_DELAY) |
+			SSC_BF(RCMR_START, SSC_START_FALLING_RF) |
+			SSC_BF(RCMR_CKI, SSC_CKI_RISING) |
+			SSC_BF(RCMR_CKO, SSC_CKO_NONE) |
+			SSC_BF(RCMR_CKS, SSC_CKS_DIV));
+
+		rfmr = (SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE) |
+			SSC_BF(RFMR_FSOS, SSC_FSOS_NEGATIVE) |
+			SSC_BF(RFMR_FSLEN, bits - 1) |
+			SSC_BF(RFMR_DATNB, channels - 1) |
+			SSC_BIT(RFMR_MSBF) | SSC_BF(RFMR_DATLEN, bits - 1));
+
+		tcmr = (SSC_BF(TCMR_PERIOD, ssc_p->tcmr_period) |
+			SSC_BF(TCMR_STTDLY, START_DELAY) |
+			SSC_BF(TCMR_START, SSC_START_FALLING_RF) |
+			SSC_BF(TCMR_CKI, SSC_CKI_FALLING) |
+			SSC_BF(TCMR_CKO, SSC_CKO_CONTINUOUS) |
+			SSC_BF(TCMR_CKS, SSC_CKS_DIV));
+
+		tfmr = (SSC_BF(TFMR_FSEDGE, SSC_FSEDGE_POSITIVE) |
+			SSC_BF(TFMR_FSOS, SSC_FSOS_NEGATIVE) |
+			SSC_BF(TFMR_FSLEN, bits - 1) |
+			SSC_BF(TFMR_DATNB, channels - 1) | SSC_BIT(TFMR_MSBF) |
+			SSC_BF(TFMR_DATLEN, bits - 1));
+		break;
+
+
+	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM:
+		/*
+		 * I2S format, CODEC supplies BCLK and LRC clock.
+		 *
+		 * The SSC transmit clock is obtained from the BCLK signal
+		 * on the TK line, and the SSC receive clock is generated from
+		 * the transmit clock.
+		 *
+		 * For single channel data, one sample is transferred on the
+		 * falling edge of the LRC clock.  For two channel data, one
+		 * sample is transferred on both edges of the LRC clock.
+		 */
+		pr_debug("at32-ssc: SSC mode is I2S BCLK / FRAME slave\n");
+		start_event = ((channels == 1) ?
+			       SSC_START_FALLING_RF : SSC_START_EDGE_RF);
+
+		rcmr = (SSC_BF(RCMR_STTDLY, START_DELAY) |
+			SSC_BF(RCMR_START, start_event) |
+			SSC_BF(RCMR_CKI, SSC_CKI_RISING) |
+			SSC_BF(RCMR_CKO, SSC_CKO_NONE) |
+			SSC_BF(RCMR_CKS, SSC_CKS_CLOCK));
+
+		rfmr = (SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE) |
+			SSC_BF(RFMR_FSOS, SSC_FSOS_NONE) |
+			SSC_BIT(RFMR_MSBF) | SSC_BF(RFMR_DATLEN, bits - 1));
+
+		tcmr = (SSC_BF(TCMR_STTDLY, START_DELAY) |
+			SSC_BF(TCMR_START, start_event) |
+			SSC_BF(TCMR_CKI, SSC_CKI_FALLING) |
+			SSC_BF(TCMR_CKO, SSC_CKO_NONE) |
+			SSC_BF(TCMR_CKS, SSC_CKS_PIN));
+
+		tfmr = (SSC_BF(TFMR_FSEDGE, SSC_FSEDGE_POSITIVE) |
+			SSC_BF(TFMR_FSOS, SSC_FSOS_NONE) |
+			SSC_BIT(TFMR_MSBF) | SSC_BF(TFMR_DATLEN, bits - 1));
+		break;
+
+
+	case SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_CBS_CFS:
+		/*
+		 * DSP/PCM Mode A format, SSC provides BCLK and LRC clocks.
+		 *
+		 * The SSC transmit and receive clocks are generated from the
+		 * MCK divider, and the BCLK signal is output on the SSC TK line
+		 */
+		pr_debug("at32-ssc: SSC mode is DSP A BCLK / FRAME master\n");
+		rcmr = (SSC_BF(RCMR_PERIOD, ssc_p->rcmr_period) |
+			SSC_BF(RCMR_STTDLY, 1) |
+			SSC_BF(RCMR_START, SSC_START_RISING_RF) |
+			SSC_BF(RCMR_CKI, SSC_CKI_RISING) |
+			SSC_BF(RCMR_CKO, SSC_CKO_NONE) |
+			SSC_BF(RCMR_CKS, SSC_CKS_DIV));
+
+		rfmr = (SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE) |
+			SSC_BF(RFMR_FSOS, SSC_FSOS_POSITIVE) |
+			SSC_BF(RFMR_DATNB, channels - 1) |
+			SSC_BIT(RFMR_MSBF) | SSC_BF(RFMR_DATLEN, bits - 1));
+
+		tcmr = (SSC_BF(TCMR_PERIOD, ssc_p->tcmr_period) |
+			SSC_BF(TCMR_STTDLY, 1) |
+			SSC_BF(TCMR_START, SSC_START_RISING_RF) |
+			SSC_BF(TCMR_CKI, SSC_CKI_RISING) |
+			SSC_BF(TCMR_CKO, SSC_CKO_CONTINUOUS) |
+			SSC_BF(TCMR_CKS, SSC_CKS_DIV));
+
+		tfmr = (SSC_BF(TFMR_FSEDGE, SSC_FSEDGE_POSITIVE) |
+			SSC_BF(TFMR_FSOS, SSC_FSOS_POSITIVE) |
+			SSC_BF(TFMR_DATNB, channels - 1) |
+			SSC_BIT(TFMR_MSBF) | SSC_BF(TFMR_DATLEN, bits - 1));
+		break;
+
+
+	case SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_CBM_CFM:
+	default:
+		pr_warning("at32-ssc: unsupported DAI format 0x%x\n",
+			   ssc_p->daifmt);
+		return -EINVAL;
+		break;
+	}
+	pr_debug("at32-ssc: RCMR=%08x RFMR=%08x TCMR=%08x TFMR=%08x\n",
+		 rcmr, rfmr, tcmr, tfmr);
+
+
+	if (!ssc_p->initialized) {
+		/* enable peripheral clock */
+		pr_debug("at32-ssc: Starting clock\n");
+		clk_enable(ssc_p->ssc->clk);
+
+		/* Reset the SSC and its PDC registers */
+		ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_SWRST));
+
+		ssc_writel(ssc_p->ssc->regs, PDC_RPR, 0);
+		ssc_writel(ssc_p->ssc->regs, PDC_RCR, 0);
+		ssc_writel(ssc_p->ssc->regs, PDC_RNPR, 0);
+		ssc_writel(ssc_p->ssc->regs, PDC_RNCR, 0);
+
+		ssc_writel(ssc_p->ssc->regs, PDC_TPR, 0);
+		ssc_writel(ssc_p->ssc->regs, PDC_TCR, 0);
+		ssc_writel(ssc_p->ssc->regs, PDC_TNPR, 0);
+		ssc_writel(ssc_p->ssc->regs, PDC_TNCR, 0);
+
+		ret = request_irq(ssc_p->ssc->irq, at32_ssc_interrupt, 0,
+				  ssc_p->name, ssc_p);
+		if (ret < 0) {
+			pr_warning("at32-ssc: request irq failed (%d)\n", ret);
+			pr_debug("at32-ssc: Stopping clock\n");
+			clk_disable(ssc_p->ssc->clk);
+			return ret;
+		}
+
+		ssc_p->initialized = 1;
+	}
+
+	/* Set SSC clock mode register */
+	ssc_writel(ssc_p->ssc->regs, CMR, ssc_p->cmr_div);
+
+	/* set receive clock mode and format */
+	ssc_writel(ssc_p->ssc->regs, RCMR, rcmr);
+	ssc_writel(ssc_p->ssc->regs, RFMR, rfmr);
+
+	/* set transmit clock mode and format */
+	ssc_writel(ssc_p->ssc->regs, TCMR, tcmr);
+	ssc_writel(ssc_p->ssc->regs, TFMR, tfmr);
+
+	pr_debug("at32-ssc: SSC initialized\n");
+	return 0;
+}
+
+
+
+static int at32_ssc_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct at32_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
+	struct at32_pcm_dma_params *dma_params;
+
+	dma_params = ssc_p->dma_params[substream->stream];
+
+	ssc_writel(dma_params->ssc->regs, CR, dma_params->mask->ssc_enable);
+
+	return 0;
+}
+
+
+
+#ifdef CONFIG_PM
+static int at32_ssc_suspend(struct platform_device *pdev,
+			    struct snd_soc_cpu_dai *cpu_dai)
+{
+	struct at32_ssc_info *ssc_p;
+
+	if (!cpu_dai->active)
+		return 0;
+
+	ssc_p = &ssc_info[cpu_dai->id];
+
+	/* Save the status register before disabling transmit and receive */
+	ssc_p->ssc_state.ssc_sr = ssc_readl(ssc_p->ssc->regs, SR);
+	ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_TXDIS) | SSC_BIT(CR_RXDIS));
+
+	/* Save the current interrupt mask, then disable unmasked interrupts */
+	ssc_p->ssc_state.ssc_imr = ssc_readl(ssc_p->ssc->regs, IMR);
+	ssc_writel(ssc_p->ssc->regs, IDR, ssc_p->ssc_state.ssc_imr);
+
+	ssc_p->ssc_state.ssc_cmr = ssc_readl(ssc_p->ssc->regs, CMR);
+	ssc_p->ssc_state.ssc_rcmr = ssc_readl(ssc_p->ssc->regs, RCMR);
+	ssc_p->ssc_state.ssc_rfmr = ssc_readl(ssc_p->ssc->regs, RFMR);
+	ssc_p->ssc_state.ssc_tcmr = ssc_readl(ssc_p->ssc->regs, TCMR);
+	ssc_p->ssc_state.ssc_tfmr = ssc_readl(ssc_p->ssc->regs, TFMR);
+
+	return 0;
+}
+
+
+
+static int at32_ssc_resume(struct platform_device *pdev,
+			   struct snd_soc_cpu_dai *cpu_dai)
+{
+	struct at32_ssc_info *ssc_p;
+	u32 cr;
+
+	if (!cpu_dai->active)
+		return 0;
+
+	ssc_p = &ssc_info[cpu_dai->id];
+
+	/* restore SSC register settings */
+	ssc_writel(ssc_p->ssc->regs, TFMR, ssc_p->ssc_state.ssc_tfmr);
+	ssc_writel(ssc_p->ssc->regs, TCMR, ssc_p->ssc_state.ssc_tcmr);
+	ssc_writel(ssc_p->ssc->regs, RFMR, ssc_p->ssc_state.ssc_rfmr);
+	ssc_writel(ssc_p->ssc->regs, RCMR, ssc_p->ssc_state.ssc_rcmr);
+	ssc_writel(ssc_p->ssc->regs, CMR, ssc_p->ssc_state.ssc_cmr);
+
+	/* re-enable interrupts */
+	ssc_writel(ssc_p->ssc->regs, IER, ssc_p->ssc_state.ssc_imr);
+
+	/* Re-enable recieve and transmit as appropriate */
+	cr = 0;
+	cr |=
+	    (ssc_p->ssc_state.ssc_sr & SSC_BIT(SR_RXEN)) ? SSC_BIT(CR_RXEN) : 0;
+	cr |=
+	    (ssc_p->ssc_state.ssc_sr & SSC_BIT(SR_TXEN)) ? SSC_BIT(CR_TXEN) : 0;
+	ssc_writel(ssc_p->ssc->regs, CR, cr);
+
+	return 0;
+}
+#else /* CONFIG_PM */
+#  define at32_ssc_suspend	NULL
+#  define at32_ssc_resume	NULL
+#endif /* CONFIG_PM */
+
+
+#define AT32_SSC_RATES \
+    (SNDRV_PCM_RATE_8000  | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
+     SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
+     SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
+
+
+#define AT32_SSC_FORMATS \
+    (SNDRV_PCM_FMTBIT_S8  | SNDRV_PCM_FMTBIT_S16 | \
+     SNDRV_PCM_FMTBIT_S24 | SNDRV_PCM_FMTBIT_S32)
+
+
+struct snd_soc_cpu_dai at32_ssc_dai[NUM_SSC_DEVICES] = {
+	{
+	 .name = "at32-ssc0",
+	 .id = 0,
+	 .type = SND_SOC_DAI_PCM,
+	 .suspend = at32_ssc_suspend,
+	 .resume = at32_ssc_resume,
+	 .playback = {
+		      .channels_min = 1,
+		      .channels_max = 2,
+		      .rates = AT32_SSC_RATES,
+		      .formats = AT32_SSC_FORMATS,
+		      },
+	 .capture = {
+		     .channels_min = 1,
+		     .channels_max = 2,
+		     .rates = AT32_SSC_RATES,
+		     .formats = AT32_SSC_FORMATS,
+		     },
+	 .ops = {
+		 .startup = at32_ssc_startup,
+		 .shutdown = at32_ssc_shutdown,
+		 .prepare = at32_ssc_prepare,
+		 .hw_params = at32_ssc_hw_params,
+		 },
+	 .dai_ops = {
+		     .set_sysclk = at32_ssc_set_dai_sysclk,
+		     .set_fmt = at32_ssc_set_dai_fmt,
+		     .set_clkdiv = at32_ssc_set_dai_clkdiv,
+		     },
+	 .private_data = &ssc_info[0],
+	 },
+	{
+	 .name = "at32-ssc1",
+	 .id = 1,
+	 .type = SND_SOC_DAI_PCM,
+	 .suspend = at32_ssc_suspend,
+	 .resume = at32_ssc_resume,
+	 .playback = {
+		      .channels_min = 1,
+		      .channels_max = 2,
+		      .rates = AT32_SSC_RATES,
+		      .formats = AT32_SSC_FORMATS,
+		      },
+	 .capture = {
+		     .channels_min = 1,
+		     .channels_max = 2,
+		     .rates = AT32_SSC_RATES,
+		     .formats = AT32_SSC_FORMATS,
+		     },
+	 .ops = {
+		 .startup = at32_ssc_startup,
+		 .shutdown = at32_ssc_shutdown,
+		 .prepare = at32_ssc_prepare,
+		 .hw_params = at32_ssc_hw_params,
+		 },
+	 .dai_ops = {
+		     .set_sysclk = at32_ssc_set_dai_sysclk,
+		     .set_fmt = at32_ssc_set_dai_fmt,
+		     .set_clkdiv = at32_ssc_set_dai_clkdiv,
+		     },
+	 .private_data = &ssc_info[1],
+	 },
+	{
+	 .name = "at32-ssc2",
+	 .id = 2,
+	 .type = SND_SOC_DAI_PCM,
+	 .suspend = at32_ssc_suspend,
+	 .resume = at32_ssc_resume,
+	 .playback = {
+		      .channels_min = 1,
+		      .channels_max = 2,
+		      .rates = AT32_SSC_RATES,
+		      .formats = AT32_SSC_FORMATS,
+		      },
+	 .capture = {
+		     .channels_min = 1,
+		     .channels_max = 2,
+		     .rates = AT32_SSC_RATES,
+		     .formats = AT32_SSC_FORMATS,
+		     },
+	 .ops = {
+		 .startup = at32_ssc_startup,
+		 .shutdown = at32_ssc_shutdown,
+		 .prepare = at32_ssc_prepare,
+		 .hw_params = at32_ssc_hw_params,
+		 },
+	 .dai_ops = {
+		     .set_sysclk = at32_ssc_set_dai_sysclk,
+		     .set_fmt = at32_ssc_set_dai_fmt,
+		     .set_clkdiv = at32_ssc_set_dai_clkdiv,
+		     },
+	 .private_data = &ssc_info[2],
+	 },
+};
+EXPORT_SYMBOL_GPL(at32_ssc_dai);
+
+
+MODULE_AUTHOR("Geoffrey Wossum <gwossum@acm.org>");
+MODULE_DESCRIPTION("AT32 SSC ASoC Interface");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/at32/at32-ssc.h b/sound/soc/at32/at32-ssc.h
new file mode 100644
index 0000000..3c6901a
--- /dev/null
+++ b/sound/soc/at32/at32-ssc.h
@@ -0,0 +1,59 @@
+/* sound/soc/at32/at32-ssc.h
+ * ASoC SSC interface for Atmel AT32 SoC
+ *
+ * Copyright (C) 2008 Long Range Systems
+ *    Geoffrey Wossum <gwossum@acm.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __SOUND_SOC_AT32_AT32_SSC_H
+#define __SOUND_SOC_AT32_AT32_SSC_H __FILE__
+
+#include <linux/types.h>
+#include <linux/atmel-ssc.h>
+
+#include "at32-pcm.h"
+
+
+
+struct at32_ssc_state {
+	u32 ssc_cmr;
+	u32 ssc_rcmr;
+	u32 ssc_rfmr;
+	u32 ssc_tcmr;
+	u32 ssc_tfmr;
+	u32 ssc_sr;
+	u32 ssc_imr;
+};
+
+
+
+struct at32_ssc_info {
+	char *name;
+	struct ssc_device *ssc;
+	spinlock_t lock;	/* lock for dir_mask */
+	unsigned short dir_mask;	/* 0=unused, 1=playback, 2=capture */
+	unsigned short initialized;	/* true if SSC has been initialized */
+	unsigned short daifmt;
+	unsigned short cmr_div;
+	unsigned short tcmr_period;
+	unsigned short rcmr_period;
+	struct at32_pcm_dma_params *dma_params[2];
+	struct at32_ssc_state ssc_state;
+};
+
+
+/* SSC divider ids */
+#define AT32_SSC_CMR_DIV        0	/* MCK divider for BCLK */
+#define AT32_SSC_TCMR_PERIOD    1	/* BCLK divider for transmit FS */
+#define AT32_SSC_RCMR_PERIOD    2	/* BCLK divider for receive FS */
+
+
+extern struct snd_soc_cpu_dai at32_ssc_dai[];
+
+
+
+#endif /* __SOUND_SOC_AT32_AT32_SSC_H */
diff --git a/sound/soc/at32/playpaq_wm8510.c b/sound/soc/at32/playpaq_wm8510.c
new file mode 100644
index 0000000..d6b9fd5
--- /dev/null
+++ b/sound/soc/at32/playpaq_wm8510.c
@@ -0,0 +1,524 @@
+/* sound/soc/at32/playpaq_wm8510.c
+ * ASoC machine driver for PlayPaq using WM8510 codec
+ *
+ * Copyright (C) 2008 Long Range Systems
+ *    Geoffrey Wossum <gwossum@acm.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This code is largely inspired by sound/soc/at91/eti_b1_wm8731.c
+ *
+ * NOTE: If you don't have the AT32 enhanced portmux configured (which
+ * isn't currently in the mainline or Atmel patched kernel), you will
+ * need to set the MCLK pin (PA30) to peripheral A in your board initialization
+ * code.  Something like:
+ *	at32_select_periph(GPIO_PIN_PA(30), GPIO_PERIPH_A, 0);
+ *
+ */
+
+/* #define DEBUG */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/clk.h>
+#include <linux/timer.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <asm/arch/at32ap700x.h>
+#include <asm/arch/portmux.h>
+
+#include "../codecs/wm8510.h"
+#include "at32-pcm.h"
+#include "at32-ssc.h"
+
+
+/*-------------------------------------------------------------------------*\
+ * constants
+\*-------------------------------------------------------------------------*/
+#define MCLK_PIN		GPIO_PIN_PA(30)
+#define MCLK_PERIPH		GPIO_PERIPH_A
+
+
+/*-------------------------------------------------------------------------*\
+ * data types
+\*-------------------------------------------------------------------------*/
+/* SSC clocking data */
+struct ssc_clock_data {
+	/* CMR div */
+	unsigned int cmr_div;
+
+	/* Frame period (as needed by xCMR.PERIOD) */
+	unsigned int period;
+
+	/* The SSC clock rate these settings where calculated for */
+	unsigned long ssc_rate;
+};
+
+
+/*-------------------------------------------------------------------------*\
+ * module data
+\*-------------------------------------------------------------------------*/
+static struct clk *_gclk0;
+static struct clk *_pll0;
+
+#define CODEC_CLK (_gclk0)
+
+
+/*-------------------------------------------------------------------------*\
+ * Sound SOC operations
+\*-------------------------------------------------------------------------*/
+#if defined CONFIG_SND_AT32_SOC_PLAYPAQ_SLAVE
+static struct ssc_clock_data playpaq_wm8510_calc_ssc_clock(
+	struct snd_pcm_hw_params *params,
+	struct snd_soc_cpu_dai *cpu_dai)
+{
+	struct at32_ssc_info *ssc_p = cpu_dai->private_data;
+	struct ssc_device *ssc = ssc_p->ssc;
+	struct ssc_clock_data cd;
+	unsigned int rate, width_bits, channels;
+	unsigned int bitrate, ssc_div;
+	unsigned actual_rate;
+
+
+	/*
+	 * Figure out required bitrate
+	 */
+	rate = params_rate(params);
+	channels = params_channels(params);
+	width_bits = snd_pcm_format_physical_width(params_format(params));
+	bitrate = rate * width_bits * channels;
+
+
+	/*
+	 * Figure out required SSC divider and period for required bitrate
+	 */
+	cd.ssc_rate = clk_get_rate(ssc->clk);
+	ssc_div = cd.ssc_rate / bitrate;
+	cd.cmr_div = ssc_div / 2;
+	if (ssc_div & 1) {
+		/* round cmr_div up */
+		cd.cmr_div++;
+	}
+	cd.period = width_bits - 1;
+
+
+	/*
+	 * Find actual rate, compare to requested rate
+	 */
+	actual_rate = (cd.ssc_rate / (cd.cmr_div * 2)) / (2 * (cd.period + 1));
+	pr_debug("playpaq_wm8510: Request rate = %d, actual rate = %d\n",
+		 rate, actual_rate);
+
+
+	return cd;
+}
+#endif /* CONFIG_SND_AT32_SOC_PLAYPAQ_SLAVE */
+
+
+
+static int playpaq_wm8510_hw_params(struct snd_pcm_substream *substream,
+				    struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct at32_ssc_info *ssc_p = cpu_dai->private_data;
+	struct ssc_device *ssc = ssc_p->ssc;
+	unsigned int pll_out = 0, bclk = 0, mclk_div = 0;
+	int ret;
+
+
+	/* Due to difficulties with getting the correct clocks from the AT32's
+	 * PLL0, we're going to let the CODEC be in charge of all the clocks
+	 */
+#if !defined CONFIG_SND_AT32_SOC_PLAYPAQ_SLAVE
+	const unsigned int fmt = (SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBM_CFM);
+#else
+	struct ssc_clock_data cd;
+	const unsigned int fmt = (SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBS_CFS);
+#endif
+
+	if (ssc == NULL) {
+		pr_warning("playpaq_wm8510_hw_params: ssc is NULL!\n");
+		return -EINVAL;
+	}
+
+
+	/*
+	 * Figure out PLL and BCLK dividers for WM8510
+	 */
+	switch (params_rate(params)) {
+	case 48000:
+		pll_out = 12288000;
+		mclk_div = WM8510_MCLKDIV_1;
+		bclk = WM8510_BCLKDIV_8;
+		break;
+
+	case 44100:
+		pll_out = 11289600;
+		mclk_div = WM8510_MCLKDIV_1;
+		bclk = WM8510_BCLKDIV_8;
+		break;
+
+	case 22050:
+		pll_out = 11289600;
+		mclk_div = WM8510_MCLKDIV_2;
+		bclk = WM8510_BCLKDIV_8;
+		break;
+
+	case 16000:
+		pll_out = 12288000;
+		mclk_div = WM8510_MCLKDIV_3;
+		bclk = WM8510_BCLKDIV_8;
+		break;
+
+	case 11025:
+		pll_out = 11289600;
+		mclk_div = WM8510_MCLKDIV_4;
+		bclk = WM8510_BCLKDIV_8;
+		break;
+
+	case 8000:
+		pll_out = 12288000;
+		mclk_div = WM8510_MCLKDIV_6;
+		bclk = WM8510_BCLKDIV_8;
+		break;
+
+	default:
+		pr_warning("playpaq_wm8510: Unsupported sample rate %d\n",
+			   params_rate(params));
+		return -EINVAL;
+	}
+
+
+	/*
+	 * set CPU and CODEC DAI configuration
+	 */
+	ret = codec_dai->dai_ops.set_fmt(codec_dai, fmt);
+	if (ret < 0) {
+		pr_warning("playpaq_wm8510: "
+			   "Failed to set CODEC DAI format (%d)\n",
+			   ret);
+		return ret;
+	}
+	ret = cpu_dai->dai_ops.set_fmt(cpu_dai, fmt);
+	if (ret < 0) {
+		pr_warning("playpaq_wm8510: "
+			   "Failed to set CPU DAI format (%d)\n",
+			   ret);
+		return ret;
+	}
+
+
+	/*
+	 * Set CPU clock configuration
+	 */
+#if defined CONFIG_SND_AT32_SOC_PLAYPAQ_SLAVE
+	cd = playpaq_wm8510_calc_ssc_clock(params, cpu_dai);
+	pr_debug("playpaq_wm8510: cmr_div = %d, period = %d\n",
+		 cd.cmr_div, cd.period);
+	ret = cpu_dai->dai_ops.set_clkdiv(cpu_dai,
+					  AT32_SSC_CMR_DIV, cd.cmr_div);
+	if (ret < 0) {
+		pr_warning("playpaq_wm8510: Failed to set CPU CMR_DIV (%d)\n",
+			   ret);
+		return ret;
+	}
+	ret = cpu_dai->dai_ops.set_clkdiv(cpu_dai, AT32_SSC_TCMR_PERIOD,
+					  cd.period);
+	if (ret < 0) {
+		pr_warning("playpaq_wm8510: "
+			   "Failed to set CPU transmit period (%d)\n",
+			   ret);
+		return ret;
+	}
+#endif /* CONFIG_SND_AT32_SOC_PLAYPAQ_SLAVE */
+
+
+	/*
+	 * Set CODEC clock configuration
+	 */
+	pr_debug("playpaq_wm8510: "
+		 "pll_in = %ld, pll_out = %u, bclk = %x, mclk = %x\n",
+		 clk_get_rate(CODEC_CLK), pll_out, bclk, mclk_div);
+
+
+#if !defined CONFIG_SND_AT32_SOC_PLAYPAQ_SLAVE
+	ret = codec_dai->dai_ops.set_clkdiv(codec_dai, WM8510_BCLKDIV, bclk);
+	if (ret < 0) {
+		pr_warning
+		    ("playpaq_wm8510: Failed to set CODEC DAI BCLKDIV (%d)\n",
+		     ret);
+		return ret;
+	}
+#endif /* CONFIG_SND_AT32_SOC_PLAYPAQ_SLAVE */
+
+
+	ret = codec_dai->dai_ops.set_pll(codec_dai, 0,
+					 clk_get_rate(CODEC_CLK), pll_out);
+	if (ret < 0) {
+		pr_warning("playpaq_wm8510: Failed to set CODEC DAI PLL (%d)\n",
+			   ret);
+		return ret;
+	}
+
+
+	ret = codec_dai->dai_ops.set_clkdiv(codec_dai,
+					    WM8510_MCLKDIV, mclk_div);
+	if (ret < 0) {
+		pr_warning("playpaq_wm8510: Failed to set CODEC MCLKDIV (%d)\n",
+			   ret);
+		return ret;
+	}
+
+
+	return 0;
+}
+
+
+
+static struct snd_soc_ops playpaq_wm8510_ops = {
+	.hw_params = playpaq_wm8510_hw_params,
+};
+
+
+
+static const struct snd_soc_dapm_widget playpaq_dapm_widgets[] = {
+	SND_SOC_DAPM_MIC("Int Mic", NULL),
+	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+};
+
+
+
+static const char *intercon[][3] = {
+	/* speaker connected to SPKOUT */
+	{"Ext Spk", NULL, "SPKOUTP"},
+	{"Ext Spk", NULL, "SPKOUTN"},
+
+	{"Mic Bias", NULL, "Int Mic"},
+	{"MICN", NULL, "Mic Bias"},
+	{"MICP", NULL, "Mic Bias"},
+
+	/* Terminator */
+	{NULL, NULL, NULL},
+};
+
+
+
+static int playpaq_wm8510_init(struct snd_soc_codec *codec)
+{
+	int i;
+
+	/*
+	 * Add DAPM widgets
+	 */
+	for (i = 0; i < ARRAY_SIZE(playpaq_dapm_widgets); i++)
+		snd_soc_dapm_new_control(codec, &playpaq_dapm_widgets[i]);
+
+
+
+	/*
+	 * Setup audio path interconnects
+	 */
+	for (i = 0; intercon[i][0] != NULL; i++) {
+		snd_soc_dapm_connect_input(codec,
+					   intercon[i][0],
+					   intercon[i][1], intercon[i][2]);
+	}
+
+
+	/* always connected endpoints */
+	snd_soc_dapm_set_endpoint(codec, "Int Mic", 1);
+	snd_soc_dapm_set_endpoint(codec, "Ext Spk", 1);
+	snd_soc_dapm_sync_endpoints(codec);
+
+
+
+	/* Make CSB show PLL rate */
+	codec->dai->dai_ops.set_clkdiv(codec->dai, WM8510_OPCLKDIV,
+				       WM8510_OPCLKDIV_1 | 4);
+
+	return 0;
+}
+
+
+
+static struct snd_soc_dai_link playpaq_wm8510_dai = {
+	.name = "WM8510",
+	.stream_name = "WM8510 PCM",
+	.cpu_dai = &at32_ssc_dai[0],
+	.codec_dai = &wm8510_dai,
+	.init = playpaq_wm8510_init,
+	.ops = &playpaq_wm8510_ops,
+};
+
+
+
+static struct snd_soc_machine snd_soc_machine_playpaq = {
+	.name = "LRS_PlayPaq_WM8510",
+	.dai_link = &playpaq_wm8510_dai,
+	.num_links = 1,
+};
+
+
+
+static struct wm8510_setup_data playpaq_wm8510_setup = {
+	.i2c_address = 0x1a,
+};
+
+
+
+static struct snd_soc_device playpaq_wm8510_snd_devdata = {
+	.machine = &snd_soc_machine_playpaq,
+	.platform = &at32_soc_platform,
+	.codec_dev = &soc_codec_dev_wm8510,
+	.codec_data = &playpaq_wm8510_setup,
+};
+
+static struct platform_device *playpaq_snd_device;
+
+
+static int __init playpaq_asoc_init(void)
+{
+	int ret = 0;
+	struct at32_ssc_info *ssc_p = playpaq_wm8510_dai.cpu_dai->private_data;
+	struct ssc_device *ssc = NULL;
+
+
+	/*
+	 * Request SSC device
+	 */
+	ssc = ssc_request(0);
+	if (IS_ERR(ssc)) {
+		ret = PTR_ERR(ssc);
+		ssc = NULL;
+		goto err_ssc;
+	}
+	ssc_p->ssc = ssc;
+
+
+	/*
+	 * Configure MCLK for WM8510
+	 */
+	_gclk0 = clk_get(NULL, "gclk0");
+	if (IS_ERR(_gclk0)) {
+		_gclk0 = NULL;
+		goto err_gclk0;
+	}
+	_pll0 = clk_get(NULL, "pll0");
+	if (IS_ERR(_pll0)) {
+		_pll0 = NULL;
+		goto err_pll0;
+	}
+	if (clk_set_parent(_gclk0, _pll0)) {
+		pr_warning("snd-soc-playpaq: "
+			   "Failed to set PLL0 as parent for DAC clock\n");
+		goto err_set_clk;
+	}
+	clk_set_rate(CODEC_CLK, 12000000);
+	clk_enable(CODEC_CLK);
+
+#if defined CONFIG_AT32_ENHANCED_PORTMUX
+	at32_select_periph(MCLK_PIN, MCLK_PERIPH, 0);
+#endif
+
+
+	/*
+	 * Create and register platform device
+	 */
+	playpaq_snd_device = platform_device_alloc("soc-audio", 0);
+	if (playpaq_snd_device == NULL) {
+		ret = -ENOMEM;
+		goto err_device_alloc;
+	}
+
+	platform_set_drvdata(playpaq_snd_device, &playpaq_wm8510_snd_devdata);
+	playpaq_wm8510_snd_devdata.dev = &playpaq_snd_device->dev;
+
+	ret = platform_device_add(playpaq_snd_device);
+	if (ret) {
+		pr_warning("playpaq_wm8510: platform_device_add failed (%d)\n",
+			   ret);
+		goto err_device_add;
+	}
+
+	return 0;
+
+
+err_device_add:
+	if (playpaq_snd_device != NULL) {
+		platform_device_put(playpaq_snd_device);
+		playpaq_snd_device = NULL;
+	}
+err_device_alloc:
+err_set_clk:
+	if (_pll0 != NULL) {
+		clk_put(_pll0);
+		_pll0 = NULL;
+	}
+err_pll0:
+	if (_gclk0 != NULL) {
+		clk_put(_gclk0);
+		_gclk0 = NULL;
+	}
+err_gclk0:
+	if (ssc != NULL) {
+		ssc_free(ssc);
+		ssc = NULL;
+	}
+err_ssc:
+	return ret;
+}
+
+
+static void __exit playpaq_asoc_exit(void)
+{
+	struct at32_ssc_info *ssc_p = playpaq_wm8510_dai.cpu_dai->private_data;
+	struct ssc_device *ssc;
+
+	if (ssc_p != NULL) {
+		ssc = ssc_p->ssc;
+		if (ssc != NULL)
+			ssc_free(ssc);
+		ssc_p->ssc = NULL;
+	}
+
+	if (_gclk0 != NULL) {
+		clk_put(_gclk0);
+		_gclk0 = NULL;
+	}
+	if (_pll0 != NULL) {
+		clk_put(_pll0);
+		_pll0 = NULL;
+	}
+
+#if defined CONFIG_AT32_ENHANCED_PORTMUX
+	at32_free_pin(MCLK_PIN);
+#endif
+
+	platform_device_unregister(playpaq_snd_device);
+	playpaq_snd_device = NULL;
+}
+
+module_init(playpaq_asoc_init);
+module_exit(playpaq_asoc_exit);
+
+MODULE_AUTHOR("Geoffrey Wossum <gwossum@acm.org>");
+MODULE_DESCRIPTION("ASoC machine driver for LRS PlayPaq");
+MODULE_LICENSE("GPL");
-- 
1.5.5.3
