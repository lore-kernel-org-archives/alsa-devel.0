From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: [PATCH]ASoC: Create a common directory for AVR32 and
	ARM9 atmel boards.
Date: Thu, 02 Oct 2008 09:50:26 +0200
Message-ID: <48E47D42.8080306@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030900070503000803070901"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C4A42446C
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Oct 2008 09:50:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030900070503000803070901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Create a common directory for AVR32 and ARM9 atmel boards to unify atmel audio DAI.

Signed-off-by: Sedji Gaouaou <sedji.gaouaou@atmel.com>
---
 sound/soc/Kconfig                |    3 +-
 sound/soc/Makefile               |    2 +-
 sound/soc/atmel/Kconfig          |   43 ++
 sound/soc/atmel/Makefile         |   15 +
 sound/soc/atmel/atmel-pcm.c      |  484 +++++++++++++++++++++++
 sound/soc/atmel/atmel-pcm.h      |   86 ++++
 sound/soc/atmel/atmel_ssc_dai.c  |  803 ++++++++++++++++++++++++++++++++++++++
 sound/soc/atmel/atmel_ssc_dai.h  |  121 ++++++
 sound/soc/atmel/playpaq_wm8510.c |  523 +++++++++++++++++++++++++
 sound/soc/atmel/sam9g20_wm8731.c |  329 ++++++++++++++++
 10 files changed, 2406 insertions(+), 3 deletions(-)
 create mode 100644 sound/soc/atmel/Kconfig
 create mode 100644 sound/soc/atmel/Makefile
 create mode 100644 sound/soc/atmel/atmel-pcm.c
 create mode 100644 sound/soc/atmel/atmel-pcm.h
 create mode 100644 sound/soc/atmel/atmel_ssc_dai.c
 create mode 100644 sound/soc/atmel/atmel_ssc_dai.h
 create mode 100644 sound/soc/atmel/playpaq_wm8510.c
 create mode 100644 sound/soc/atmel/sam9g20_wm8731.c

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 4dfda66..615ebf0 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -23,8 +23,7 @@ config SND_SOC_AC97_BUS
 	bool
 
 # All the supported Soc's
-source "sound/soc/at32/Kconfig"
-source "sound/soc/at91/Kconfig"
+source "sound/soc/atmel/Kconfig"
 source "sound/soc/au1x/Kconfig"
 source "sound/soc/pxa/Kconfig"
 source "sound/soc/s3c24xx/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index d849349..4d475c3 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -1,5 +1,5 @@
 snd-soc-core-objs := soc-core.o soc-dapm.o
 
 obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
-obj-$(CONFIG_SND_SOC)	+= codecs/ at32/ at91/ pxa/ s3c24xx/ sh/ fsl/ davinci/
+obj-$(CONFIG_SND_SOC)	+= codecs/ atmel/ pxa/ s3c24xx/ sh/ fsl/ davinci/
 obj-$(CONFIG_SND_SOC)	+= omap/ au1x/ blackfin/
diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
new file mode 100644
index 0000000..170d9da
--- /dev/null
+++ b/sound/soc/atmel/Kconfig
@@ -0,0 +1,43 @@
+config SND_ATMEL_SOC
+	tristate "SoC Audio for the Atmel System-on-Chip"
+	depends on ARCH_AT91 || AVR32
+	help
+	  Say Y or M if you want to add support for codecs attached to
+	  the AT91 SSC interface. You will also need
+	  to select the audio interfaces to support below.
+
+config SND_ATMEL_SOC_SSC
+	tristate
+	depends on SND_ATMEL_SOC
+	help
+	  Say Y or M if you want to add support for codecs the
+	  ATMEL SSC interface. You will also needs to select the individual
+	  machine drivers to support below.
+
+config SND_AT91_SOC_SAM9G20_WM8731
+	tristate "SoC Audio support for WM8731-based At91sam9g20 evaluation board"
+	depends on ATMEL_SSC && ARCH_AT91SAM9G20 && SND_ATMEL_SOC
+	select SND_ATMEL_SOC_SSC
+	select SND_SOC_WM8731
+	help
+	  Say Y if you want to add support for SoC audio on WM8731-based
+	  AT91sam9g20 evaluation board.
+
+config SND_AT32_SOC_PLAYPAQ
+        tristate "SoC Audio support for PlayPaq with WM8510"
+        depends on SND_ATMEL_SOC && BOARD_PLAYPAQ
+        select SND_ATMEL_SOC_SSC
+        select SND_SOC_WM8510
+        help
+          Say Y or M here if you want to add support for SoC audio
+          on the LRS PlayPaq.
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
diff --git a/sound/soc/atmel/Makefile b/sound/soc/atmel/Makefile
new file mode 100644
index 0000000..f54a7cc
--- /dev/null
+++ b/sound/soc/atmel/Makefile
@@ -0,0 +1,15 @@
+# AT91 Platform Support
+snd-soc-atmel-pcm-objs := atmel-pcm.o
+snd-soc-atmel_ssc_dai-objs := atmel_ssc_dai.o
+
+obj-$(CONFIG_SND_ATMEL_SOC) += snd-soc-atmel-pcm.o
+obj-$(CONFIG_SND_ATMEL_SOC_SSC) += snd-soc-atmel_ssc_dai.o
+
+# AT91 Machine Support
+snd-soc-sam9g20-wm8731-objs := sam9g20_wm8731.o
+
+# AT32 Machine Support
+snd-soc-playpaq-objs := playpaq_wm8510.o
+
+obj-$(CONFIG_SND_AT91_SOC_SAM9G20_WM8731) += snd-soc-sam9g20-wm8731.o
+obj-$(CONFIG_SND_AT32_SOC_PLAYPAQ) += snd-soc-playpaq.o
diff --git a/sound/soc/atmel/atmel-pcm.c b/sound/soc/atmel/atmel-pcm.c
new file mode 100644
index 0000000..6d317d2
--- /dev/null
+++ b/sound/soc/atmel/atmel-pcm.c
@@ -0,0 +1,484 @@
+/*
+ * atmel-pcm.c  --  ALSA PCM interface for the Atmel atmel SoC.
+ *
+ *  Copyright (C) 2005 SAN People
+ *  Copyright (C) 2008 Atmel
+ *
+ * Authors: Sedji Gaouaou <sedji.gaouaou@atmel.com>
+ *
+ * Based on at91-pcm. by:
+ * Frank Mandarino <fmandarino@endrelia.com>
+ * Copyright 2006 Endrelia Technologies Inc.
+ *
+ * Based on pxa2xx-pcm.c by:
+ *
+ * Author:	Nicolas Pitre
+ * Created:	Nov 30, 2004
+ * Copyright:	(C) 2004 MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+#include <linux/atmel_pdc.h>
+#include <linux/atmel-ssc.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include <mach/hardware.h>
+
+#include "atmel-pcm.h"
+
+
+/*--------------------------------------------------------------------------*\
+ * Hardware definition
+\*--------------------------------------------------------------------------*/
+/* TODO: These values were taken from the AT91 platform driver, check
+ *	 them against real values for AT32
+ */
+static const struct snd_pcm_hardware atmel_pcm_hardware = {
+	.info			= SNDRV_PCM_INFO_MMAP |
+				  SNDRV_PCM_INFO_MMAP_VALID |
+				  SNDRV_PCM_INFO_INTERLEAVED |
+				  SNDRV_PCM_INFO_PAUSE,
+	.formats		= SNDRV_PCM_FMTBIT_S16_LE,
+	.period_bytes_min	= 32,
+	.period_bytes_max	= 8192,
+	.periods_min		= 2,
+	.periods_max		= 1024,
+	.buffer_bytes_max	= 32 * 1024,
+};
+
+
+/*--------------------------------------------------------------------------*\
+ * Data types
+\*--------------------------------------------------------------------------*/
+struct atmel_runtime_data {
+	struct atmel_pcm_dma_params *params;
+	dma_addr_t dma_buffer;		/* physical address of dma buffer */
+	dma_addr_t dma_buffer_end;	/* first address beyond DMA buffer */
+	size_t period_size;
+
+	dma_addr_t period_ptr;		/* physical address of next period */
+	int periods;			/* period index of period_ptr */
+
+	/* PDC register save */
+	u32 pdc_xpr_save;
+	u32 pdc_xcr_save;
+	u32 pdc_xnpr_save;
+	u32 pdc_xncr_save;
+};
+
+
+/*--------------------------------------------------------------------------*\
+ * Helper functions
+\*--------------------------------------------------------------------------*/
+static int atmel_pcm_preallocate_dma_buffer(struct snd_pcm *pcm,
+	int stream)
+{
+	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+	size_t size = atmel_pcm_hardware.buffer_bytes_max;
+
+	buf->dev.type = SNDRV_DMA_TYPE_DEV;
+	buf->dev.dev = pcm->card->dev;
+	buf->private_data = NULL;
+	buf->area = dma_alloc_coherent(pcm->card->dev, size,
+					  &buf->addr, GFP_KERNEL);
+	pr_debug("atmel-pcm:"
+		"preallocate_dma_buffer: area=%p, addr=%p, size=%d\n",
+		(void *) buf->area,
+		(void *) buf->addr,
+		size);
+
+	if (!buf->area)
+		return -ENOMEM;
+
+	buf->bytes = size;
+	return 0;
+}
+/*--------------------------------------------------------------------------*\
+ * ISR
+\*--------------------------------------------------------------------------*/
+static void atmel_pcm_dma_irq(u32 ssc_sr,
+	struct snd_pcm_substream *substream)
+{
+	struct atmel_runtime_data *prtd = substream->runtime->private_data;
+	struct atmel_pcm_dma_params *params = prtd->params;
+	static int count = 0;
+
+	count++;
+
+	if (ssc_sr & params->mask->ssc_endbuf) {
+		pr_warning("atmel-pcm: buffer %s on %s"
+				" (SSC_SR=%#x, count=%d)\n",
+				substream->stream == SNDRV_PCM_STREAM_PLAYBACK
+				? "underrun" : "overrun",
+				params->name, ssc_sr, count);
+
+		/* re-start the PDC */
+		ssc_writex(params->ssc->regs, ATMEL_PDC_PTCR,
+			   params->mask->pdc_disable);
+		prtd->period_ptr += prtd->period_size;
+		if (prtd->period_ptr >= prtd->dma_buffer_end)
+			prtd->period_ptr = prtd->dma_buffer;
+
+		ssc_writex(params->ssc->regs, params->pdc->xpr,
+			   prtd->period_ptr);
+		ssc_writex(params->ssc->regs, params->pdc->xcr,
+			   prtd->period_size / params->pdc_xfer_size);
+		ssc_writex(params->ssc->regs, ATMEL_PDC_PTCR,
+			   params->mask->pdc_enable);
+	}
+
+	if (ssc_sr & params->mask->ssc_endx) {
+		/* Load the PDC next pointer and counter registers */
+		prtd->period_ptr += prtd->period_size;
+		if (prtd->period_ptr >= prtd->dma_buffer_end)
+			prtd->period_ptr = prtd->dma_buffer;
+
+		ssc_writex(params->ssc->regs, params->pdc->xnpr,
+			   prtd->period_ptr);
+		ssc_writex(params->ssc->regs, params->pdc->xncr,
+			   prtd->period_size / params->pdc_xfer_size);
+	}
+
+	snd_pcm_period_elapsed(substream);
+}
+
+
+/*--------------------------------------------------------------------------*\
+ * PCM operations
+\*--------------------------------------------------------------------------*/
+static int atmel_pcm_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct atmel_runtime_data *prtd = runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+
+	/* this may get called several times by oss emulation
+	 * with different params */
+
+	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+	runtime->dma_bytes = params_buffer_bytes(params);
+
+	prtd->params = rtd->dai->cpu_dai->dma_data;
+	prtd->params->dma_intr_handler = atmel_pcm_dma_irq;
+
+	prtd->dma_buffer = runtime->dma_addr;
+	prtd->dma_buffer_end = runtime->dma_addr + runtime->dma_bytes;
+	prtd->period_size = params_period_bytes(params);
+
+	pr_debug("atmel-pcm: "
+		"hw_params: DMA for %s initialized "
+		"(dma_bytes=%u, period_size=%u)\n",
+		prtd->params->name,
+		runtime->dma_bytes,
+		prtd->period_size);
+	return 0;
+}
+
+static int atmel_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	struct atmel_runtime_data *prtd = substream->runtime->private_data;
+	struct atmel_pcm_dma_params *params = prtd->params;
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
+static int atmel_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct atmel_runtime_data *prtd = substream->runtime->private_data;
+	struct atmel_pcm_dma_params *params = prtd->params;
+
+	ssc_writex(params->ssc->regs, SSC_IDR,
+		   params->mask->ssc_endx | params->mask->ssc_endbuf);
+	ssc_writex(params->ssc->regs, ATMEL_PDC_PTCR,
+		   params->mask->pdc_disable);
+	return 0;
+}
+
+static int atmel_pcm_trigger(struct snd_pcm_substream *substream,
+	int cmd)
+{
+	struct snd_pcm_runtime *rtd = substream->runtime;
+	struct atmel_runtime_data *prtd = rtd->private_data;
+	struct atmel_pcm_dma_params *params = prtd->params;
+	int ret = 0;
+
+	pr_debug("atmel-pcm:buffer_size = %ld,"
+		"dma_area = %p, dma_bytes = %u\n",
+		rtd->buffer_size, rtd->dma_area, rtd->dma_bytes);
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
+		pr_debug("atmel-pcm: trigger: "
+			"period_ptr=%lx, xpr=%u, "
+			"xcr=%u, xnpr=%u, xncr=%u\n",
+			(unsigned long)prtd->period_ptr,
+			ssc_readx(params->ssc->regs, params->pdc->xpr),
+			ssc_readx(params->ssc->regs, params->pdc->xcr),
+			ssc_readx(params->ssc->regs, params->pdc->xnpr),
+			ssc_readx(params->ssc->regs, params->pdc->xncr));
+
+		ssc_writex(params->ssc->regs, SSC_IER,
+			   params->mask->ssc_endx | params->mask->ssc_endbuf);
+		ssc_writex(params->ssc->regs, SSC_PDC_PTCR,
+			   params->mask->pdc_enable);
+
+		pr_debug("sr=%u imr=%u\n",
+			ssc_readx(params->ssc->regs, SSC_SR),
+			ssc_readx(params->ssc->regs, SSC_IER));
+		break;		/* SNDRV_PCM_TRIGGER_START */
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		ssc_writex(params->ssc->regs, ATMEL_PDC_PTCR,
+			   params->mask->pdc_disable);
+		break;
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
+static snd_pcm_uframes_t atmel_pcm_pointer(
+	struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct atmel_runtime_data *prtd = runtime->private_data;
+	struct atmel_pcm_dma_params *params = prtd->params;
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
+static int atmel_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct atmel_runtime_data *prtd;
+	int ret = 0;
+
+	snd_soc_set_runtime_hwparams(substream, &atmel_pcm_hardware);
+
+	/* ensure that buffer size is a multiple of period size */
+	ret = snd_pcm_hw_constraint_integer(runtime,
+						SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0)
+		goto out;
+
+	prtd = kzalloc(sizeof(struct atmel_runtime_data), GFP_KERNEL);
+	if (prtd == NULL) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	runtime->private_data = prtd;
+
+ out:
+	return ret;
+}
+
+static int atmel_pcm_close(struct snd_pcm_substream *substream)
+{
+	struct atmel_runtime_data *prtd = substream->runtime->private_data;
+
+	kfree(prtd);
+	return 0;
+}
+
+static int atmel_pcm_mmap(struct snd_pcm_substream *substream,
+	struct vm_area_struct *vma)
+{
+	return remap_pfn_range(vma, vma->vm_start,
+		       substream->dma_buffer.addr >> PAGE_SHIFT,
+		       vma->vm_end - vma->vm_start, vma->vm_page_prot);
+}
+
+struct snd_pcm_ops atmel_pcm_ops = {
+	.open		= atmel_pcm_open,
+	.close		= atmel_pcm_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= atmel_pcm_hw_params,
+	.hw_free	= atmel_pcm_hw_free,
+	.prepare	= atmel_pcm_prepare,
+	.trigger	= atmel_pcm_trigger,
+	.pointer	= atmel_pcm_pointer,
+	.mmap		= atmel_pcm_mmap,
+};
+
+
+/*--------------------------------------------------------------------------*\
+ * ASoC platform driver
+\*--------------------------------------------------------------------------*/
+static u64 atmel_pcm_dmamask = 0xffffffff;
+
+static int atmel_pcm_new(struct snd_card *card,
+	struct snd_soc_dai *dai, struct snd_pcm *pcm)
+{
+	int ret = 0;
+
+	if (!card->dev->dma_mask)
+		card->dev->dma_mask = &atmel_pcm_dmamask;
+	if (!card->dev->coherent_dma_mask)
+		card->dev->coherent_dma_mask = 0xffffffff;
+
+	if (dai->playback.channels_min) {
+		ret = atmel_pcm_preallocate_dma_buffer(pcm,
+			SNDRV_PCM_STREAM_PLAYBACK);
+		if (ret)
+			goto out;
+	}
+
+	if (dai->capture.channels_min) {
+		pr_debug("at32-pcm:"
+				"Allocating PCM capture DMA buffer\n");
+		ret = atmel_pcm_preallocate_dma_buffer(pcm,
+			SNDRV_PCM_STREAM_CAPTURE);
+		if (ret)
+			goto out;
+	}
+ out:
+	return ret;
+}
+
+static void atmel_pcm_free_dma_buffers(struct snd_pcm *pcm)
+{
+	struct snd_pcm_substream *substream;
+	struct snd_dma_buffer *buf;
+	int stream;
+
+	for (stream = 0; stream < 2; stream++) {
+		substream = pcm->streams[stream].substream;
+		if (!substream)
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
+#ifdef CONFIG_PM
+static int atmel_pcm_suspend(struct platform_device *pdev,
+	struct snd_soc_dai *dai)
+{
+	struct snd_pcm_runtime *runtime = dai->runtime;
+	struct atmel_runtime_data *prtd;
+	struct atmel_pcm_dma_params *params;
+
+	if (!runtime)
+		return 0;
+
+	prtd = runtime->private_data;
+	params = prtd->params;
+
+	/* disable the PDC and save the PDC registers */
+
+	ssc_writel(params->ssc->regs, PDC_PTCR, params->mask->pdc_disable);
+
+	prtd->pdc_xpr_save = ssc_readx(params->ssc->regs, params->pdc->xpr);
+	prtd->pdc_xcr_save = ssc_readx(params->ssc->regs, params->pdc->xcr);
+	prtd->pdc_xnpr_save = ssc_readx(params->ssc->regs, params->pdc->xnpr);
+	prtd->pdc_xncr_save = ssc_readx(params->ssc->regs, params->pdc->xncr);
+
+	return 0;
+}
+
+static int atmel_pcm_resume(struct platform_device *pdev,
+	struct snd_soc_dai *dai)
+{
+	struct snd_pcm_runtime *runtime = dai->runtime;
+	struct atmel_runtime_data *prtd;
+	struct atmel_pcm_dma_params *params;
+
+	if (!runtime)
+		return 0;
+
+	prtd = runtime->private_data;
+	params = prtd->params;
+
+	/* restore the PDC registers and enable the PDC */
+	ssc_writex(params->ssc->regs, params->pdc->xpr, prtd->pdc_xpr_save);
+	ssc_writex(params->ssc->regs, params->pdc->xcr, prtd->pdc_xcr_save);
+	ssc_writex(params->ssc->regs, params->pdc->xnpr, prtd->pdc_xnpr_save);
+	ssc_writex(params->ssc->regs, params->pdc->xncr, prtd->pdc_xncr_save);
+
+	ssc_writel(params->ssc->regs, PDC_PTCR, params->mask->pdc_enable);
+	return 0;
+}
+#else
+#define atmel_pcm_suspend	NULL
+#define atmel_pcm_resume	NULL
+#endif
+
+struct snd_soc_platform atmel_soc_platform = {
+	.name		= "atmel-audio",
+	.pcm_ops 	= &atmel_pcm_ops,
+	.pcm_new	= atmel_pcm_new,
+	.pcm_free	= atmel_pcm_free_dma_buffers,
+	.suspend	= atmel_pcm_suspend,
+	.resume		= atmel_pcm_resume,
+};
+EXPORT_SYMBOL_GPL(atmel_soc_platform);
+
+MODULE_AUTHOR("Sedji Gaouaou <sedji.gaouaou@atmel.com>");
+MODULE_DESCRIPTION("Atmel PCM module");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/atmel/atmel-pcm.h b/sound/soc/atmel/atmel-pcm.h
new file mode 100644
index 0000000..ec9b282
--- /dev/null
+++ b/sound/soc/atmel/atmel-pcm.h
@@ -0,0 +1,86 @@
+/*
+ * at91-pcm.h - ALSA PCM interface for the Atmel AT91 SoC.
+ *
+ *  Copyright (C) 2005 SAN People
+ *  Copyright (C) 2008 Atmel
+ *
+ * Authors: Sedji Gaouaou <sedji.gaouaou@atmel.com>
+ *
+ * Based on at91-pcm. by:
+ * Frank Mandarino <fmandarino@endrelia.com>
+ * Copyright 2006 Endrelia Technologies Inc.
+ *
+ * Based on pxa2xx-pcm.c by:
+ *
+ * Author:	Nicolas Pitre
+ * Created:	Nov 30, 2004
+ * Copyright:	(C) 2004 MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef _ATMEL_PCM_H
+#define _ATMEL_PCM_H
+
+#include <linux/atmel-ssc.h>
+
+/*
+ * Registers and status bits that are required by the PCM driver.
+ */
+struct atmel_pdc_regs {
+	unsigned int	xpr;		/* PDC recv/trans pointer */
+	unsigned int	xcr;		/* PDC recv/trans counter */
+	unsigned int	xnpr;		/* PDC next recv/trans pointer */
+	unsigned int	xncr;		/* PDC next recv/trans counter */
+	unsigned int	ptcr;		/* PDC transfer control */
+};
+
+struct atmel_ssc_mask {
+	u32	ssc_enable;		/* SSC recv/trans enable */
+	u32	ssc_disable;		/* SSC recv/trans disable */
+	u32	ssc_endx;		/* SSC ENDTX or ENDRX */
+	u32	ssc_endbuf;		/* SSC TXBUFE or RXBUFF */
+	u32	pdc_enable;		/* PDC recv/trans enable */
+	u32	pdc_disable;		/* PDC recv/trans disable */
+};
+
+/*
+ * This structure, shared between the PCM driver and the interface,
+ * contains all information required by the PCM driver to perform the
+ * PDC DMA operation.  All fields except dma_intr_handler() are initialized
+ * by the interface.  The dms_intr_handler() pointer is set by the PCM
+ * driver and called by the interface SSC interrupt handler if it is
+ * non-NULL.
+ */
+struct atmel_pcm_dma_params {
+	char *name;			/* stream identifier */
+	int pdc_xfer_size;		/* PDC counter increment in bytes */
+	struct ssc_device *ssc;		/* SSC device for stream */
+	struct atmel_pdc_regs *pdc;	/* PDC receive or transmit registers */
+	struct atmel_ssc_mask *mask;	/* SSC & PDC status bits */
+	struct snd_pcm_substream *substream;
+	void (*dma_intr_handler)(u32, struct snd_pcm_substream *);
+};
+
+extern struct snd_soc_platform atmel_soc_platform;
+
+
+/*
+ * SSC register access (since ssc_writel() / ssc_readl() require literal name)
+ */
+#define ssc_readx(base, reg)            (__raw_readl((base) + (reg)))
+#define ssc_writex(base, reg, value)    __raw_writel((value), (base) + (reg))
+
+#endif /* _ATMEL_PCM_H */
diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
new file mode 100644
index 0000000..2ed1575
--- /dev/null
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -0,0 +1,803 @@
+/*
+ * atmel_ssc_dai.c  --  ALSA SoC ATMEL SSC Audio Layer Platform driver
+ *
+ * Copyright (C) 2005 SAN People
+ * Copyright (C) 2008 Atmel
+ *
+ * Author: Sedji Gaouaou <sedji.gaouaou@atmel.com>
+ *         ATMEL CORP.
+ *
+ * Based on at91-ssc.c by
+ * Frank Mandarino <fmandarino@endrelia.com>
+ * Based on pxa2xx Platform drivers by
+ * Liam Girdwood <liam.girdwood@wolfsonmicro.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/atmel_pdc.h>
+
+#include <linux/atmel-ssc.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+
+#include <mach/hardware.h>
+
+#include "atmel-pcm.h"
+#include "atmel_ssc_dai.h"
+
+
+#if defined(CONFIG_ARCH_AT91SAM9260) || defined(CONFIG_ARCH_AT91SAM9G20)
+#define NUM_SSC_DEVICES		1
+#else
+#define NUM_SSC_DEVICES		3
+#endif
+
+/*
+ * SSC PDC registers required by the PCM DMA engine.
+ */
+static struct atmel_pdc_regs pdc_tx_reg = {
+	.xpr		= ATMEL_PDC_TPR,
+	.xcr		= ATMEL_PDC_TCR,
+	.xnpr		= ATMEL_PDC_TNPR,
+	.xncr		= ATMEL_PDC_TNCR,
+};
+
+static struct atmel_pdc_regs pdc_rx_reg = {
+	.xpr		= ATMEL_PDC_RPR,
+	.xcr		= ATMEL_PDC_RCR,
+	.xnpr		= ATMEL_PDC_RNPR,
+	.xncr		= ATMEL_PDC_RNCR,
+};
+
+/*
+ * SSC & PDC status bits for transmit and receive.
+ */
+static struct atmel_ssc_mask ssc_tx_mask = {
+	.ssc_enable	= SSC_BIT(CR_TXEN),
+	.ssc_disable	= SSC_BIT(CR_TXDIS),
+	.ssc_endx	= SSC_BIT(SR_ENDTX),
+	.ssc_endbuf	= SSC_BIT(SR_TXBUFE),
+	.pdc_enable	= ATMEL_PDC_TXTEN,
+	.pdc_disable	= ATMEL_PDC_TXTDIS,
+};
+
+static struct atmel_ssc_mask ssc_rx_mask = {
+	.ssc_enable	= SSC_BIT(CR_RXEN),
+	.ssc_disable	= SSC_BIT(CR_RXDIS),
+	.ssc_endx	= SSC_BIT(SR_ENDRX),
+	.ssc_endbuf	= SSC_BIT(SR_RXBUFF),
+	.pdc_enable	= ATMEL_PDC_RXTEN,
+	.pdc_disable	= ATMEL_PDC_RXTDIS,
+};
+
+
+/*
+ * DMA parameters.
+ */
+static struct atmel_pcm_dma_params ssc_dma_params[NUM_SSC_DEVICES][2] = {
+	{{
+	.name		= "SSC0 PCM out",
+	.pdc		= &pdc_tx_reg,
+	.mask		= &ssc_tx_mask,
+	},
+	{
+	.name		= "SSC0 PCM in",
+	.pdc		= &pdc_rx_reg,
+	.mask		= &ssc_rx_mask,
+	} },
+#if NUM_SSC_DEVICES == 3
+	{{
+	.name		= "SSC1 PCM out",
+	.pdc		= &pdc_tx_reg,
+	.mask		= &ssc_tx_mask,
+	},
+	{
+	.name		= "SSC1 PCM in",
+	.pdc		= &pdc_rx_reg,
+	.mask		= &ssc_rx_mask,
+	} },
+	{{
+	.name		= "SSC2 PCM out",
+	.pdc		= &pdc_tx_reg,
+	.mask		= &ssc_tx_mask,
+	},
+	{
+	.name		= "SSC2 PCM in",
+	.pdc		= &pdc_rx_reg,
+	.mask		= &ssc_rx_mask,
+	} },
+#endif
+};
+
+
+static struct atmel_ssc_info ssc_info[NUM_SSC_DEVICES] = {
+	{
+	.name		= "ssc0",
+	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info[0].lock),
+	.dir_mask	= SSC_DIR_MASK_UNUSED,
+	.initialized	= 0,
+	},
+#if NUM_SSC_DEVICES == 3
+	{
+	.name		= "ssc1",
+	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info[1].lock),
+	.dir_mask	= SSC_DIR_MASK_UNUSED,
+	.initialized	= 0,
+	},
+	{
+	.name		= "ssc2",
+	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info[2].lock),
+	.dir_mask	= SSC_DIR_MASK_UNUSED,
+	.initialized	= 0,
+	},
+#endif
+};
+
+
+/*
+ * SSC interrupt handler.  Passes PDC interrupts to the DMA
+ * interrupt handler in the PCM driver.
+ */
+static irqreturn_t atmel_ssc_interrupt(int irq, void *dev_id)
+{
+	struct atmel_ssc_info *ssc_p = dev_id;
+	struct atmel_pcm_dma_params *dma_params;
+	u32 ssc_sr;
+	u32 ssc_substream_mask;
+	int i;
+
+	ssc_sr = (unsigned long)ssc_readl(ssc_p->ssc->regs, SR)
+			& (unsigned long)ssc_readl(ssc_p->ssc->regs, IMR);
+
+	/*
+	 * Loop through the substreams attached to this SSC.  If
+	 * a DMA-related interrupt occurred on that substream, call
+	 * the DMA interrupt handler function, if one has been
+	 * registered in the dma_params structure by the PCM driver.
+	 */
+	for (i = 0; i < ARRAY_SIZE(ssc_p->dma_params); i++) {
+		dma_params = ssc_p->dma_params[i];
+
+		if ((dma_params != NULL) &&
+			(dma_params->dma_intr_handler != NULL)) {
+			ssc_substream_mask = (dma_params->mask->ssc_endx |
+					dma_params->mask->ssc_endbuf);
+			if (ssc_sr & ssc_substream_mask) {
+				dma_params->dma_intr_handler(ssc_sr,
+						dma_params->
+						substream);
+			}
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+
+/*-------------------------------------------------------------------------*\
+ * DAI functions
+\*-------------------------------------------------------------------------*/
+/*
+ * Startup.  Only that one substream allowed in each direction.
+ */
+static int atmel_ssc_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct atmel_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
+	int dir_mask;
+
+	pr_debug("atmel_ssc_startup: SSC_SR=0x%u\n",
+		ssc_readl(ssc_p->ssc->regs, SR));
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dir_mask = SSC_DIR_MASK_PLAYBACK;
+	else
+		dir_mask = SSC_DIR_MASK_CAPTURE;
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
+/*
+ * Shutdown.  Clear DMA parameters and shutdown the SSC if there
+ * are no other substreams open.
+ */
+static void atmel_ssc_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct atmel_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
+	struct atmel_pcm_dma_params *dma_params;
+	int dir, dir_mask;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dir = 0;
+	else
+		dir = 1;
+
+	dma_params = ssc_p->dma_params[dir];
+
+	if (dma_params != NULL) {
+		ssc_writel(ssc_p->ssc->regs, CR, dma_params->mask->ssc_disable);
+		pr_debug("atmel_ssc_shutdown: %s disabled SSC_SR=0x%08x\n",
+			(dir ? "receive" : "transmit"),
+			ssc_readl(ssc_p->ssc->regs, SR));
+
+		dma_params->ssc = NULL;
+		dma_params->substream = NULL;
+		ssc_p->dma_params[dir] = NULL;
+	}
+
+	dir_mask = 1 << dir;
+
+	spin_lock_irq(&ssc_p->lock);
+	ssc_p->dir_mask &= ~dir_mask;
+	if (!ssc_p->dir_mask) {
+		/* Shutdown the SSC clock. */
+		pr_debug("atmel_ssc_dau: Stopping clock\n");
+		clk_disable(ssc_p->ssc->clk);
+
+		if (ssc_p->initialized) {
+			free_irq(ssc_p->ssc->irq, ssc_p);
+			ssc_p->initialized = 0;
+		}
+
+		/* Reset the SSC */
+		ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_SWRST));
+		/* Clear the SSC dividers */
+		ssc_p->cmr_div = ssc_p->tcmr_period = ssc_p->rcmr_period = 0;
+	}
+	spin_unlock_irq(&ssc_p->lock);
+}
+#if 0
+/*
+ * Record the SSC system clock rate.
+ */
+static int atmel_ssc_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	/*
+	 * The only clock supplied to the SSC is the AT91 master clock,
+	 * which is only used if the SSC is generating BCLK and/or
+	 * LRC clocks.
+	 */
+	switch (clk_id) {
+	case ATMEL_SYSCLK_MCK:
+		atmel_ssc_sysclk = freq;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+#endif
+/*
+ * Record the DAI format for use in hw_params().
+ */
+static int atmel_ssc_set_dai_fmt(struct snd_soc_dai *cpu_dai,
+		unsigned int fmt)
+{
+	struct atmel_ssc_info *ssc_p = &ssc_info[cpu_dai->id];
+
+	ssc_p->daifmt = fmt;
+	return 0;
+}
+
+/*
+ * Record SSC clock dividers for use in hw_params().
+ */
+static int atmel_ssc_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
+	int div_id, int div)
+{
+	struct atmel_ssc_info *ssc_p = &ssc_info[cpu_dai->id];
+
+	switch (div_id) {
+	case ATMEL_SSC_CMR_DIV:
+		/*
+		 * The same master clock divider is used for both
+		 * transmit and receive, so if a value has already
+		 * been set, it must match this value.
+		 */
+		if (ssc_p->cmr_div == 0)
+			ssc_p->cmr_div = div;
+		else
+			if (div != ssc_p->cmr_div)
+				return -EBUSY;
+		break;
+
+	case ATMEL_SSC_TCMR_PERIOD:
+		ssc_p->tcmr_period = div;
+		break;
+
+	case ATMEL_SSC_RCMR_PERIOD:
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
+/*
+ * Configure the SSC.
+ */
+static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	int id = rtd->dai->cpu_dai->id;
+	struct atmel_ssc_info *ssc_p = &ssc_info[id];
+	struct atmel_pcm_dma_params *dma_params;
+	int dir, channels, bits;
+	u32 tfmr, rfmr, tcmr, rcmr;
+	int start_event;
+	int ret;
+
+	/*
+	 * Currently, there is only one set of dma params for
+	 * each direction.  If more are added, this code will
+	 * have to be changed to select the proper set.
+	 */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dir = 0;
+	else
+		dir = 1;
+
+	dma_params = &ssc_dma_params[id][dir];
+	dma_params->ssc = ssc_p->ssc;
+	dma_params->substream = substream;
+
+	ssc_p->dma_params[dir] = dma_params;
+
+	/*
+	 * The cpu_dai->dma_data field is only used to communicate the
+	 * appropriate DMA parameters to the pcm driver hw_params()
+	 * function.  It should not be used for other purposes
+	 * as it is common to all substreams.
+	 */
+	rtd->dai->cpu_dai->dma_data = dma_params;
+
+	channels = params_channels(params);
+
+	/*
+	 * Determine sample size in bits and the PDC increment.
+	 */
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S8:
+		bits = 8;
+		dma_params->pdc_xfer_size = 1;
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		bits = 16;
+		dma_params->pdc_xfer_size = 2;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		bits = 24;
+		dma_params->pdc_xfer_size = 4;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		bits = 32;
+		dma_params->pdc_xfer_size = 4;
+		break;
+	default:
+		printk(KERN_WARNING "atmel_ssc_dai: unsupported PCM format");
+		return -EINVAL;
+	}
+
+	/*
+	 * The SSC only supports up to 16-bit samples in I2S format, due
+	 * to the size of the Frame Mode Register FSLEN field.
+	 */
+	if ((ssc_p->daifmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_I2S
+		&& bits > 16) {
+		printk(KERN_WARNING
+				"atmel_ssc_dai: sample size %d"
+				"is too large for I2S\n", bits);
+		return -EINVAL;
+	}
+
+	/*
+	 * Compute SSC register settings.
+	 */
+	switch (ssc_p->daifmt
+		& (SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_MASTER_MASK)) {
+
+	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS:
+		/*
+		 * I2S format, SSC provides BCLK and LRC clocks.
+		 *
+		 * The SSC transmit and receive clocks are generated
+		 * from the MCK divider, and the BCLK signal
+		 * is output on the SSC TK line.
+		 */
+		rcmr =	  SSC_BF(RCMR_PERIOD, ssc_p->rcmr_period)
+			| SSC_BF(RCMR_STTDLY, START_DELAY)
+			| SSC_BF(RCMR_START, SSC_START_FALLING_RF)
+			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
+			| SSC_BF(RCMR_CKO, SSC_CKO_NONE)
+			| SSC_BF(RCMR_CKS, SSC_CKS_DIV);
+
+		rfmr =	  SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
+			| SSC_BF(RFMR_FSOS, SSC_FSOS_NEGATIVE)
+			| SSC_BF(RFMR_FSLEN, (bits - 1))
+			| SSC_BF(RFMR_DATNB, (channels - 1))
+			| SSC_BIT(RFMR_MSBF)
+			| SSC_BF(RFMR_LOOP, 0)
+			| SSC_BF(RFMR_DATLEN, (bits - 1));
+
+		tcmr =	  SSC_BF(TCMR_PERIOD, ssc_p->tcmr_period)
+			| SSC_BF(TCMR_STTDLY, START_DELAY)
+			| SSC_BF(TCMR_START, SSC_START_FALLING_RF)
+			| SSC_BF(TCMR_CKI, SSC_CKI_FALLING)
+			| SSC_BF(TCMR_CKO, SSC_CKO_CONTINUOUS)
+			| SSC_BF(TCMR_CKS, SSC_CKS_DIV);
+
+		tfmr =	  SSC_BF(TFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
+			| SSC_BF(TFMR_FSDEN, 0)
+			| SSC_BF(TFMR_FSOS, SSC_FSOS_NEGATIVE)
+			| SSC_BF(TFMR_FSLEN, (bits - 1))
+			| SSC_BF(TFMR_DATNB, (channels - 1))
+			| SSC_BIT(TFMR_MSBF)
+			| SSC_BF(TFMR_DATDEF, 0)
+			| SSC_BF(TFMR_DATLEN, (bits - 1));
+		break;
+
+	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM:
+		/*
+		 * I2S format, CODEC supplies BCLK and LRC clocks.
+		 *
+		 * The SSC transmit clock is obtained from the BCLK signal on
+		 * on the TK line, and the SSC receive clock is
+		 * generated from the transmit clock.
+		 *
+		 *  For single channel data, one sample is transferred
+		 * on the falling edge of the LRC clock.
+		 * For two channel data, one sample is
+		 * transferred on both edges of the LRC clock.
+		 */
+		start_event = ((channels == 1)
+				? SSC_START_FALLING_RF
+				: SSC_START_EDGE_RF);
+
+		rcmr =	  SSC_BF(RCMR_PERIOD, 0)
+			| SSC_BF(RCMR_STTDLY, START_DELAY)
+			| SSC_BF(RCMR_START, start_event)
+			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
+			| SSC_BF(RCMR_CKO, SSC_CKO_NONE)
+			| SSC_BF(RCMR_CKS, SSC_CKS_CLOCK);
+
+		rfmr =	  SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
+			| SSC_BF(RFMR_FSOS, SSC_FSOS_NONE)
+			| SSC_BF(RFMR_FSLEN, 0)
+			| SSC_BF(RFMR_DATNB, 0)
+			| SSC_BIT(RFMR_MSBF)
+			| SSC_BF(RFMR_LOOP, 0)
+			| SSC_BF(RFMR_DATLEN, (bits - 1));
+
+		tcmr =	  SSC_BF(TCMR_PERIOD, 0)
+			| SSC_BF(TCMR_STTDLY, START_DELAY)
+			| SSC_BF(TCMR_START, start_event)
+			| SSC_BF(TCMR_CKI, SSC_CKI_FALLING)
+			| SSC_BF(TCMR_CKO, SSC_CKO_NONE)
+			| SSC_BF(TCMR_CKS, SSC_CKS_PIN);
+
+		tfmr =	  SSC_BF(TFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
+			| SSC_BF(TFMR_FSDEN, 0)
+			| SSC_BF(TFMR_FSOS, SSC_FSOS_NONE)
+			| SSC_BF(TFMR_FSLEN, 0)
+			| SSC_BF(TFMR_DATNB, 0)
+			| SSC_BIT(TFMR_MSBF)
+			| SSC_BF(TFMR_DATDEF, 0)
+			| SSC_BF(TFMR_DATLEN, (bits - 1));
+		break;
+
+	case SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_CBS_CFS:
+		/*
+		 * DSP/PCM Mode A format, SSC provides BCLK and LRC clocks.
+		 *
+		 * The SSC transmit and receive clocks are generated from the
+		 * MCK divider, and the BCLK signal is output
+		 * on the SSC TK line.
+		 */
+		rcmr =	  SSC_BF(RCMR_PERIOD, ssc_p->rcmr_period)
+			| SSC_BF(RCMR_STTDLY, 1)
+			| SSC_BF(RCMR_START, SSC_START_RISING_RF)
+			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
+			| SSC_BF(RCMR_CKO, SSC_CKO_NONE)
+			| SSC_BF(RCMR_CKS, SSC_CKS_DIV);
+
+		rfmr =	  SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
+			| SSC_BF(RFMR_FSOS, SSC_FSOS_POSITIVE)
+			| SSC_BF(RFMR_FSLEN, 0)
+			| SSC_BF(RFMR_DATNB, (channels - 1))
+			| SSC_BIT(RFMR_MSBF)
+			| SSC_BF(RFMR_LOOP, 0)
+			| SSC_BF(RFMR_DATLEN, (bits - 1));
+
+		tcmr =	  SSC_BF(TCMR_PERIOD, ssc_p->tcmr_period)
+			| SSC_BF(TCMR_STTDLY, 1)
+			| SSC_BF(TCMR_START, SSC_START_RISING_RF)
+			| SSC_BF(TCMR_CKI, SSC_CKI_RISING)
+			| SSC_BF(TCMR_CKO, SSC_CKO_CONTINUOUS)
+			| SSC_BF(TCMR_CKS, SSC_CKS_DIV);
+
+		tfmr =	  SSC_BF(TFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
+			| SSC_BF(TFMR_FSDEN, 0)
+			| SSC_BF(TFMR_FSOS, SSC_FSOS_POSITIVE)
+			| SSC_BF(TFMR_FSLEN, 0)
+			| SSC_BF(TFMR_DATNB, (channels - 1))
+			| SSC_BIT(TFMR_MSBF)
+			| SSC_BF(TFMR_DATDEF, 0)
+			| SSC_BF(TFMR_DATLEN, (bits - 1));
+		break;
+
+	case SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_CBM_CFM:
+	default:
+		printk(KERN_WARNING "atmel_ssc_dai: unsupported DAI format 0x%x\n",
+			ssc_p->daifmt);
+		return -EINVAL;
+		break;
+	}
+	pr_debug("atmel_ssc_hw_params: "
+			"RCMR=%08x RFMR=%08x TCMR=%08x TFMR=%08x\n",
+			rcmr, rfmr, tcmr, tfmr);
+
+	if (!ssc_p->initialized) {
+
+		/* Enable PMC peripheral clock for this SSC */
+		pr_debug("atmel_ssc_dai: Starting clock\n");
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
+		ret = request_irq(ssc_p->ssc->irq, atmel_ssc_interrupt, 0,
+				ssc_p->name, ssc_p);
+		if (ret < 0) {
+			printk(KERN_WARNING
+					"atmel_ssc_dai: request_irq failure\n");
+			pr_debug("Atmel_ssc_dai: Stoping clock\n");
+			clk_disable(ssc_p->ssc->clk);
+			return ret;
+		}
+
+		ssc_p->initialized = 1;
+	}
+
+	/* set SSC clock mode register */
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
+	pr_debug("atmel_ssc_dai,hw_params: SSC initialized\n");
+	return 0;
+}
+
+
+static int atmel_ssc_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct atmel_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
+	struct atmel_pcm_dma_params *dma_params;
+	int dir;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dir = 0;
+	else
+		dir = 1;
+
+	dma_params = ssc_p->dma_params[dir];
+
+	ssc_writel(ssc_p->ssc->regs, CR, dma_params->mask->ssc_enable);
+
+	pr_debug("%s enabled SSC_SR=0x%08x\n",
+			dir ? "receive" : "transmit",
+			ssc_readl(ssc_p->ssc->regs, SR));
+	return 0;
+}
+
+
+#ifdef CONFIG_PM
+static int atmel_ssc_suspend(struct platform_device *pdev,
+			    struct snd_soc_dai *cpu_dai)
+{
+	struct atmel_ssc_info *ssc_p;
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
+static int atmel_ssc_resume(struct platform_device *pdev,
+			   struct snd_soc_dai *cpu_dai)
+{
+	struct atmel_ssc_info *ssc_p;
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
+#  define atmel_ssc_suspend	NULL
+#  define atmel_ssc_resume	NULL
+#endif /* CONFIG_PM */
+
+
+#define ATMEL_SSC_RATES (SNDRV_PCM_RATE_8000_96000)
+
+#define ATMEL_SSC_FORMATS (SNDRV_PCM_FMTBIT_S8     | SNDRV_PCM_FMTBIT_S16_LE |\
+			  SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
+
+struct snd_soc_dai atmel_ssc_dai[NUM_SSC_DEVICES] = {
+	{	.name = "atmel-ssc0",
+		.id = 0,
+		.type = SND_SOC_DAI_PCM,
+		.suspend = atmel_ssc_suspend,
+		.resume = atmel_ssc_resume,
+		.playback = {
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = ATMEL_SSC_RATES,
+			.formats = ATMEL_SSC_FORMATS,},
+		.capture = {
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = ATMEL_SSC_RATES,
+			.formats = ATMEL_SSC_FORMATS,},
+		.ops = {
+			.startup = atmel_ssc_startup,
+			.shutdown = atmel_ssc_shutdown,
+			.prepare = atmel_ssc_prepare,
+			.hw_params = atmel_ssc_hw_params,},
+		.dai_ops = {
+			.set_fmt = atmel_ssc_set_dai_fmt,
+			.set_clkdiv = atmel_ssc_set_dai_clkdiv,},
+		.private_data = &ssc_info[0],
+	},
+#if NUM_SSC_DEVICES == 3
+	{	.name = "atmel-ssc1",
+		.id = 1,
+		.type = SND_SOC_DAI_PCM,
+		.suspend = atmel_ssc_suspend,
+		.resume = atmel_ssc_resume,
+		.playback = {
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = ATMEL_SSC_RATES,
+			.formats = ATMEL_SSC_FORMATS,},
+		.capture = {
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = ATMEL_SSC_RATES,
+			.formats = ATMEL_SSC_FORMATS,},
+		.ops = {
+			.startup = atmel_ssc_startup,
+			.shutdown = atmel_ssc_shutdown,
+			.prepare = atmel_ssc_prepare,
+			.hw_params = atmel_ssc_hw_params,},
+		.dai_ops = {
+			.set_fmt = atmel_ssc_set_dai_fmt,
+			.set_clkdiv = atmel_ssc_set_dai_clkdiv,},
+		.private_data = &ssc_info[1],
+	},
+	{	.name = "atmel-ssc2",
+		.id = 2,
+		.type = SND_SOC_DAI_PCM,
+		.suspend = atmel_ssc_suspend,
+		.resume = atmel_ssc_resume,
+		.playback = {
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = ATMEL_SSC_RATES,
+			.formats = ATMEL_SSC_FORMATS,},
+		.capture = {
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = ATMEL_SSC_RATES,
+			.formats = ATMEL_SSC_FORMATS,},
+		.ops = {
+			.startup = atmel_ssc_startup,
+			.shutdown = atmel_ssc_shutdown,
+			.prepare = atmel_ssc_prepare,
+			.hw_params = atmel_ssc_hw_params,},
+		.dai_ops = {
+			.set_fmt = atmel_ssc_set_dai_fmt,
+			.set_clkdiv = atmel_ssc_set_dai_clkdiv,},
+		.private_data = &ssc_info[2],
+	},
+#endif
+};
+EXPORT_SYMBOL_GPL(atmel_ssc_dai);
+
+/* Module information */
+MODULE_AUTHOR("Sedji Gaouaou, sedji.gaouaou@atmel.com, www.atmel.com");
+MODULE_DESCRIPTION("ATMEL SSC ASoC Interface");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/atmel/atmel_ssc_dai.h b/sound/soc/atmel/atmel_ssc_dai.h
new file mode 100644
index 0000000..a828746
--- /dev/null
+++ b/sound/soc/atmel/atmel_ssc_dai.h
@@ -0,0 +1,121 @@
+/*
+ * atmel_ssc_dai.h - ALSA SSC interface for the Atmel  SoC
+ *
+ * Copyright (C) 2005 SAN People
+ * Copyright (C) 2008 Atmel
+ *
+ * Author: Sedji Gaouaou <sedji.gaouaou@atmel.com>
+ *         ATMEL CORP.
+ *
+ * Based on at91-ssc.c by
+ * Frank Mandarino <fmandarino@endrelia.com>
+ * Based on pxa2xx Platform drivers by
+ * Liam Girdwood <liam.girdwood@wolfsonmicro.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef _ATMEL_SSC_DAI_H
+#define _ATMEL_SSC_DAI_H
+
+#include <linux/types.h>
+#include <linux/atmel-ssc.h>
+
+#include "atmel-pcm.h"
+
+/* SSC system clock ids */
+#define ATMEL_SYSCLK_MCK	0 /* SSC uses AT91 MCK as system clock */
+
+/* SSC divider ids */
+#define ATMEL_SSC_CMR_DIV	0 /* MCK divider for BCLK */
+#define ATMEL_SSC_TCMR_PERIOD	1 /* BCLK divider for transmit FS */
+#define ATMEL_SSC_RCMR_PERIOD	2 /* BCLK divider for receive FS */
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
+struct atmel_ssc_state {
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
+struct atmel_ssc_info {
+	char *name;
+	struct ssc_device *ssc;
+	spinlock_t lock;	/* lock for dir_mask */
+	unsigned short dir_mask;	/* 0=unused, 1=playback, 2=capture */
+	unsigned short initialized;	/* true if SSC has been initialized */
+	unsigned short daifmt;
+	unsigned short cmr_div;
+	unsigned short tcmr_period;
+	unsigned short rcmr_period;
+	struct atmel_pcm_dma_params *dma_params[2];
+	struct atmel_ssc_state ssc_state;
+};
+extern struct snd_soc_dai atmel_ssc_dai[];
+
+#endif /* _AT91_SSC_DAI_H */
diff --git a/sound/soc/atmel/playpaq_wm8510.c b/sound/soc/atmel/playpaq_wm8510.c
new file mode 100644
index 0000000..7e6560b
--- /dev/null
+++ b/sound/soc/atmel/playpaq_wm8510.c
@@ -0,0 +1,523 @@
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
+#include <mach/at32ap700x.h>
+#include <mach/portmux.h>
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
+	struct snd_soc_dai *cpu_dai)
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
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
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
+	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
+	if (ret < 0) {
+		pr_warning("playpaq_wm8510: "
+			   "Failed to set CODEC DAI format (%d)\n",
+			   ret);
+		return ret;
+	}
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
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
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, AT32_SSC_CMR_DIV, cd.cmr_div);
+	if (ret < 0) {
+		pr_warning("playpaq_wm8510: Failed to set CPU CMR_DIV (%d)\n",
+			   ret);
+		return ret;
+	}
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, AT32_SSC_TCMR_PERIOD,
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
+	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8510_BCLKDIV, bclk);
+	if (ret < 0) {
+		pr_warning
+		    ("playpaq_wm8510: Failed to set CODEC DAI BCLKDIV (%d)\n",
+		     ret);
+		return ret;
+	}
+#endif /* CONFIG_SND_AT32_SOC_PLAYPAQ_SLAVE */
+
+
+	ret = snd_soc_dai_set_pll(codec_dai, 0,
+					 clk_get_rate(CODEC_CLK), pll_out);
+	if (ret < 0) {
+		pr_warning("playpaq_wm8510: Failed to set CODEC DAI PLL (%d)\n",
+			   ret);
+		return ret;
+	}
+
+
+	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8510_MCLKDIV, mclk_div);
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
+	/* always connected pins */
+	snd_soc_dapm_enable_pin(codec, "Int Mic");
+	snd_soc_dapm_enable_pin(codec, "Ext Spk");
+	snd_soc_dapm_sync(codec);
+
+
+
+	/* Make CSB show PLL rate */
+	snd_soc_dai_set_clkdiv(codec->dai, WM8510_OPCLKDIV,
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
+	.i2c_bus = 0,
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
diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
new file mode 100644
index 0000000..4e191df
--- /dev/null
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -0,0 +1,329 @@
+/*
+ * sam9g20_wm8731  --  SoC audio for AT91SAM9G20-based
+ * 			ATMEL AT91SAM9G20ek board.
+ *
+ *  Copyright (C) 2005 SAN People
+ *  Copyright (C) 2008 Atmel
+ *
+ * Authors: Sedji Gaouaou <sedji.gaouaou@atmel.com>
+ *
+ * Based on ati_b1_wm8731.c by:
+ * Frank Mandarino <fmandarino@endrelia.com>
+ * Copyright 2006 Endrelia Technologies Inc.
+ * Based on corgi.c by:
+ * Copyright 2005 Wolfson Microelectronics PLC.
+ * Copyright 2005 Openedhand Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/timer.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+
+#include <linux/atmel-ssc.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <mach/hardware.h>
+#include <mach/gpio.h>
+
+#include "../codecs/wm8731.h"
+#include "atmel-pcm.h"
+#include "atmel_ssc_dai.h"
+
+
+static int at91sam9g20ek_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	int ret;
+
+	/* codec system clock is supplied by PCK0, set to 12MHz */
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK,
+		12000000, SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static void at91sam9g20ek_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+
+	dev_dbg(rtd->socdev->dev, "shutdown");
+}
+
+static int at91sam9g20ek_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct atmel_ssc_info *ssc_p = cpu_dai->private_data;
+	struct ssc_device *ssc = ssc_p->ssc;
+	int ret;
+
+	unsigned int rate;
+	int cmr_div, period;
+
+	if (ssc == NULL) {
+		printk(KERN_INFO "at91sam9g20ek_hw_params: ssc is NULL!\n");
+		return -EINVAL;
+	}
+
+	/* set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	/* set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * The SSC clock dividers depend on the sample rate.  The CMR.DIV
+	 * field divides the system master clock MCK to drive the SSC TK
+	 * signal which provides the codec BCLK.  The TCMR.PERIOD and
+	 * RCMR.PERIOD fields further divide the BCLK signal to drive
+	 * the SSC TF and RF signals which provide the codec DACLRC and
+	 * ADCLRC clocks.
+	 *
+	 * The dividers were determined through trial and error, where a
+	 * CMR.DIV value is chosen such that the resulting BCLK value is
+	 * divisible, or almost divisible, by (2 * sample rate), and then
+	 * the TCMR.PERIOD or RCMR.PERIOD is BCLK / (2 * sample rate) - 1.
+	 */
+	rate = params_rate(params);
+
+	switch (rate) {
+	case 8000:
+		cmr_div = 55;	/* BCLK = 133MHz/(2*55) = 1.209MHz */
+		period = 74;	/* LRC = BCLK/(2*(74+1)) ~= 8060,6Hz */
+		break;
+	case 11025:
+		cmr_div = 67;	/* BCLK = 133MHz/(2*60) = 1.108MHz */
+		period = 45;	/* LRC = BCLK/(2*(49+1)) = 11083,3Hz */
+		break;
+	case 16000:
+		cmr_div = 63;	/* BCLK = 133MHz/(2*63) = 1.055MHz */
+		period = 32;	/* LRC = BCLK/(2*(32+1)) = 15993,2Hz */
+		break;
+	case 22050:
+		cmr_div = 52;	/* BCLK = 133MHz/(2*52) = 1.278MHz */
+		period = 28;	/* LRC = BCLK/(2*(28+1)) = 22049Hz */
+		break;
+	case 32000:
+		cmr_div = 66;	/* BCLK = 133MHz/(2*66) = 1.007MHz */
+		period = 15;	/* LRC = BCLK/(2*(15+1)) = 31486,742Hz */
+		break;
+	case 44100:
+		cmr_div = 29;	/* BCLK = 133MHz/(2*29) = 2.293MHz */
+		period = 25;	/* LRC = BCLK/(2*(25+1)) = 44098Hz */
+		break;
+	case 48000:
+		cmr_div = 33;	/* BCLK = 133MHz/(2*33) = 2.015MHz */
+		period = 20;	/* LRC = BCLK/(2*(20+1)) = 47979,79Hz */
+		break;
+	case 88200:
+		cmr_div = 29;	/* BCLK = 133MHz/(2*29) = 2.293MHz */
+		period = 12;	/* LRC = BCLK/(2*(12+1)) = 88196Hz */
+		break;
+	case 96000:
+		cmr_div = 23;	/* BCLK = 133MHz/(2*23) = 2.891MHz */
+		period = 14;	/* LRC = BCLK/(2*(14+1)) = 96376Hz */
+		break;
+	default:
+		printk(KERN_WARNING "unsupported rate %d"
+				" on at91sam9g20ek board\n", rate);
+		return -EINVAL;
+	}
+
+	/* set the MCK divider for BCLK */
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, ATMEL_SSC_CMR_DIV, cmr_div);
+	if (ret < 0)
+		return ret;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		/* set the BCLK divider for DACLRC */
+		ret = snd_soc_dai_set_clkdiv(cpu_dai,
+						ATMEL_SSC_TCMR_PERIOD, period);
+	} else {
+		/* set the BCLK divider for ADCLRC */
+		ret = snd_soc_dai_set_clkdiv(cpu_dai,
+						ATMEL_SSC_RCMR_PERIOD, period);
+	}
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct snd_soc_ops at91sam9g20ek_ops = {
+	.startup = at91sam9g20ek_startup,
+	.hw_params = at91sam9g20ek_hw_params,
+	.shutdown = at91sam9g20ek_shutdown,
+};
+
+
+static const struct snd_soc_dapm_widget at91sam9g20ek_dapm_widgets[] = {
+	SND_SOC_DAPM_MIC("Int Mic", NULL),
+	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+};
+
+static const struct snd_soc_dapm_route intercon[] = {
+
+	/* speaker connected to LHPOUT */
+	{"Ext Spk", NULL, "LHPOUT"},
+
+	/* mic is connected to Mic Jack, with WM8731 Mic Bias */
+	{"MICIN", NULL, "Mic Bias"},
+	{"Mic Bias", NULL, "Int Mic"},
+};
+
+/*
+ * Logic for a wm8731 as connected on a at91sam9g20ek board.
+ */
+static int at91sam9g20ek_wm8731_init(struct snd_soc_codec *codec)
+{
+	printk(KERN_DEBUG
+			"at91sam9g20ek_wm8731 "
+			": at91sam9g20ek_wm8731_init() called\n");
+
+	/* Add specific widgets */
+	snd_soc_dapm_new_controls(codec, at91sam9g20ek_dapm_widgets,
+				  ARRAY_SIZE(at91sam9g20ek_dapm_widgets));
+	/* Set up specific audio path interconnects */
+	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
+
+	/* not connected */
+	snd_soc_dapm_disable_pin(codec, "RLINEIN");
+	snd_soc_dapm_disable_pin(codec, "LLINEIN");
+
+	/* always connected */
+	snd_soc_dapm_enable_pin(codec, "Int Mic");
+	snd_soc_dapm_enable_pin(codec, "Ext Spk");
+
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+static struct snd_soc_dai_link at91sam9g20ek_dai = {
+	.name = "WM8731",
+	.stream_name = "WM8731 PCM",
+	.cpu_dai = &atmel_ssc_dai[0],
+	.codec_dai = &wm8731_dai,
+	.init = at91sam9g20ek_wm8731_init,
+	.ops = &at91sam9g20ek_ops,
+};
+
+static struct snd_soc_machine snd_soc_machine_at91sam9g20ek = {
+	.name = "WM8731",
+	.dai_link = &at91sam9g20ek_dai,
+	.num_links = 1,
+};
+
+static struct wm8731_setup_data at91sam9g20ek_wm8731_setup = {
+	.i2c_bus = 0,
+	.i2c_address = 0x1b,
+};
+
+static struct snd_soc_device at91sam9g20ek_snd_devdata = {
+	.machine = &snd_soc_machine_at91sam9g20ek,
+	.platform = &atmel_soc_platform,
+	.codec_dev = &soc_codec_dev_wm8731,
+	.codec_data = &at91sam9g20ek_wm8731_setup,
+};
+
+static struct platform_device *at91sam9g20ek_snd_device;
+
+static int __init at91sam9g20ek_init(void)
+{
+	struct atmel_ssc_info *ssc_p = at91sam9g20ek_dai.cpu_dai->private_data;
+	struct ssc_device *ssc = NULL;
+	int ret;
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
+	at91sam9g20ek_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!at91sam9g20ek_snd_device) {
+		printk(KERN_DEBUG
+				"platform device allocation failed\n");
+		ret = -ENOMEM;
+	}
+
+	platform_set_drvdata(at91sam9g20ek_snd_device,
+			&at91sam9g20ek_snd_devdata);
+	at91sam9g20ek_snd_devdata.dev = &at91sam9g20ek_snd_device->dev;
+
+	ret = platform_device_add(at91sam9g20ek_snd_device);
+	if (ret) {
+		printk(KERN_DEBUG
+				"platform device allocation failed\n");
+		platform_device_put(at91sam9g20ek_snd_device);
+	}
+
+	return ret;
+
+err_ssc:
+	return ret;
+}
+
+static void __exit at91sam9g20ek_exit(void)
+{
+	struct atmel_ssc_info *ssc_p = at91sam9g20ek_dai.cpu_dai->private_data;
+	struct ssc_device *ssc;
+
+	if (ssc_p != NULL) {
+		ssc = ssc_p->ssc;
+		if (ssc != NULL)
+			ssc_free(ssc);
+		ssc_p->ssc = NULL;
+	}
+
+	platform_device_unregister(at91sam9g20ek_snd_device);
+	at91sam9g20ek_snd_device = NULL;
+}
+
+module_init(at91sam9g20ek_init);
+module_exit(at91sam9g20ek_exit);
+
+/* Module information */
+MODULE_AUTHOR("Sedji Gaouaou <sedji.gaouaou@atmel.com>");
+MODULE_DESCRIPTION("ALSA SoC AT91SAM9G20EK_WM8731");
+MODULE_LICENSE("GPL");
-- 
1.5.3.7






--------------030900070503000803070901
Content-Type: text/plain;
 name="Create-a-common-directory-for-AVR32-and-ARM9-atmel-b.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="Create-a-common-directory-for-AVR32-and-ARM9-atmel-b.txt"

>From 179f4a719de77810da1a1d74a298dbec14c185cb Mon Sep 17 00:00:00 2001
From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Date: Wed, 1 Oct 2008 17:51:49 +0200
Subject: [PATCH] Create a common directory for AVR32 and ARM9 atmel boards.

Signed-off-by: Sedji Gaouaou <sedji.gaouaou@atmel.com>
---
 sound/soc/Kconfig                |    3 +-
 sound/soc/Makefile               |    2 +-
 sound/soc/atmel/Kconfig          |   43 ++
 sound/soc/atmel/Makefile         |   15 +
 sound/soc/atmel/atmel-pcm.c      |  484 +++++++++++++++++++++++
 sound/soc/atmel/atmel-pcm.h      |   86 ++++
 sound/soc/atmel/atmel_ssc_dai.c  |  803 ++++++++++++++++++++++++++++++++++++++
 sound/soc/atmel/atmel_ssc_dai.h  |  121 ++++++
 sound/soc/atmel/playpaq_wm8510.c |  523 +++++++++++++++++++++++++
 sound/soc/atmel/sam9g20_wm8731.c |  329 ++++++++++++++++
 10 files changed, 2406 insertions(+), 3 deletions(-)
 create mode 100644 sound/soc/atmel/Kconfig
 create mode 100644 sound/soc/atmel/Makefile
 create mode 100644 sound/soc/atmel/atmel-pcm.c
 create mode 100644 sound/soc/atmel/atmel-pcm.h
 create mode 100644 sound/soc/atmel/atmel_ssc_dai.c
 create mode 100644 sound/soc/atmel/atmel_ssc_dai.h
 create mode 100644 sound/soc/atmel/playpaq_wm8510.c
 create mode 100644 sound/soc/atmel/sam9g20_wm8731.c

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 4dfda66..615ebf0 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -23,8 +23,7 @@ config SND_SOC_AC97_BUS
 	bool
 
 # All the supported Soc's
-source "sound/soc/at32/Kconfig"
-source "sound/soc/at91/Kconfig"
+source "sound/soc/atmel/Kconfig"
 source "sound/soc/au1x/Kconfig"
 source "sound/soc/pxa/Kconfig"
 source "sound/soc/s3c24xx/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index d849349..4d475c3 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -1,5 +1,5 @@
 snd-soc-core-objs := soc-core.o soc-dapm.o
 
 obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
-obj-$(CONFIG_SND_SOC)	+= codecs/ at32/ at91/ pxa/ s3c24xx/ sh/ fsl/ davinci/
+obj-$(CONFIG_SND_SOC)	+= codecs/ atmel/ pxa/ s3c24xx/ sh/ fsl/ davinci/
 obj-$(CONFIG_SND_SOC)	+= omap/ au1x/ blackfin/
diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
new file mode 100644
index 0000000..170d9da
--- /dev/null
+++ b/sound/soc/atmel/Kconfig
@@ -0,0 +1,43 @@
+config SND_ATMEL_SOC
+	tristate "SoC Audio for the Atmel System-on-Chip"
+	depends on ARCH_AT91 || AVR32
+	help
+	  Say Y or M if you want to add support for codecs attached to
+	  the AT91 SSC interface. You will also need
+	  to select the audio interfaces to support below.
+
+config SND_ATMEL_SOC_SSC
+	tristate
+	depends on SND_ATMEL_SOC
+	help
+	  Say Y or M if you want to add support for codecs the
+	  ATMEL SSC interface. You will also needs to select the individual
+	  machine drivers to support below.
+
+config SND_AT91_SOC_SAM9G20_WM8731
+	tristate "SoC Audio support for WM8731-based At91sam9g20 evaluation board"
+	depends on ATMEL_SSC && ARCH_AT91SAM9G20 && SND_ATMEL_SOC
+	select SND_ATMEL_SOC_SSC
+	select SND_SOC_WM8731
+	help
+	  Say Y if you want to add support for SoC audio on WM8731-based
+	  AT91sam9g20 evaluation board.
+
+config SND_AT32_SOC_PLAYPAQ
+        tristate "SoC Audio support for PlayPaq with WM8510"
+        depends on SND_ATMEL_SOC && BOARD_PLAYPAQ
+        select SND_ATMEL_SOC_SSC
+        select SND_SOC_WM8510
+        help
+          Say Y or M here if you want to add support for SoC audio
+          on the LRS PlayPaq.
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
diff --git a/sound/soc/atmel/Makefile b/sound/soc/atmel/Makefile
new file mode 100644
index 0000000..f54a7cc
--- /dev/null
+++ b/sound/soc/atmel/Makefile
@@ -0,0 +1,15 @@
+# AT91 Platform Support
+snd-soc-atmel-pcm-objs := atmel-pcm.o
+snd-soc-atmel_ssc_dai-objs := atmel_ssc_dai.o
+
+obj-$(CONFIG_SND_ATMEL_SOC) += snd-soc-atmel-pcm.o
+obj-$(CONFIG_SND_ATMEL_SOC_SSC) += snd-soc-atmel_ssc_dai.o
+
+# AT91 Machine Support
+snd-soc-sam9g20-wm8731-objs := sam9g20_wm8731.o
+
+# AT32 Machine Support
+snd-soc-playpaq-objs := playpaq_wm8510.o
+
+obj-$(CONFIG_SND_AT91_SOC_SAM9G20_WM8731) += snd-soc-sam9g20-wm8731.o
+obj-$(CONFIG_SND_AT32_SOC_PLAYPAQ) += snd-soc-playpaq.o
diff --git a/sound/soc/atmel/atmel-pcm.c b/sound/soc/atmel/atmel-pcm.c
new file mode 100644
index 0000000..6d317d2
--- /dev/null
+++ b/sound/soc/atmel/atmel-pcm.c
@@ -0,0 +1,484 @@
+/*
+ * atmel-pcm.c  --  ALSA PCM interface for the Atmel atmel SoC.
+ *
+ *  Copyright (C) 2005 SAN People
+ *  Copyright (C) 2008 Atmel
+ *
+ * Authors: Sedji Gaouaou <sedji.gaouaou@atmel.com>
+ *
+ * Based on at91-pcm. by:
+ * Frank Mandarino <fmandarino@endrelia.com>
+ * Copyright 2006 Endrelia Technologies Inc.
+ *
+ * Based on pxa2xx-pcm.c by:
+ *
+ * Author:	Nicolas Pitre
+ * Created:	Nov 30, 2004
+ * Copyright:	(C) 2004 MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+#include <linux/atmel_pdc.h>
+#include <linux/atmel-ssc.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include <mach/hardware.h>
+
+#include "atmel-pcm.h"
+
+
+/*--------------------------------------------------------------------------*\
+ * Hardware definition
+\*--------------------------------------------------------------------------*/
+/* TODO: These values were taken from the AT91 platform driver, check
+ *	 them against real values for AT32
+ */
+static const struct snd_pcm_hardware atmel_pcm_hardware = {
+	.info			= SNDRV_PCM_INFO_MMAP |
+				  SNDRV_PCM_INFO_MMAP_VALID |
+				  SNDRV_PCM_INFO_INTERLEAVED |
+				  SNDRV_PCM_INFO_PAUSE,
+	.formats		= SNDRV_PCM_FMTBIT_S16_LE,
+	.period_bytes_min	= 32,
+	.period_bytes_max	= 8192,
+	.periods_min		= 2,
+	.periods_max		= 1024,
+	.buffer_bytes_max	= 32 * 1024,
+};
+
+
+/*--------------------------------------------------------------------------*\
+ * Data types
+\*--------------------------------------------------------------------------*/
+struct atmel_runtime_data {
+	struct atmel_pcm_dma_params *params;
+	dma_addr_t dma_buffer;		/* physical address of dma buffer */
+	dma_addr_t dma_buffer_end;	/* first address beyond DMA buffer */
+	size_t period_size;
+
+	dma_addr_t period_ptr;		/* physical address of next period */
+	int periods;			/* period index of period_ptr */
+
+	/* PDC register save */
+	u32 pdc_xpr_save;
+	u32 pdc_xcr_save;
+	u32 pdc_xnpr_save;
+	u32 pdc_xncr_save;
+};
+
+
+/*--------------------------------------------------------------------------*\
+ * Helper functions
+\*--------------------------------------------------------------------------*/
+static int atmel_pcm_preallocate_dma_buffer(struct snd_pcm *pcm,
+	int stream)
+{
+	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+	size_t size = atmel_pcm_hardware.buffer_bytes_max;
+
+	buf->dev.type = SNDRV_DMA_TYPE_DEV;
+	buf->dev.dev = pcm->card->dev;
+	buf->private_data = NULL;
+	buf->area = dma_alloc_coherent(pcm->card->dev, size,
+					  &buf->addr, GFP_KERNEL);
+	pr_debug("atmel-pcm:"
+		"preallocate_dma_buffer: area=%p, addr=%p, size=%d\n",
+		(void *) buf->area,
+		(void *) buf->addr,
+		size);
+
+	if (!buf->area)
+		return -ENOMEM;
+
+	buf->bytes = size;
+	return 0;
+}
+/*--------------------------------------------------------------------------*\
+ * ISR
+\*--------------------------------------------------------------------------*/
+static void atmel_pcm_dma_irq(u32 ssc_sr,
+	struct snd_pcm_substream *substream)
+{
+	struct atmel_runtime_data *prtd = substream->runtime->private_data;
+	struct atmel_pcm_dma_params *params = prtd->params;
+	static int count = 0;
+
+	count++;
+
+	if (ssc_sr & params->mask->ssc_endbuf) {
+		pr_warning("atmel-pcm: buffer %s on %s"
+				" (SSC_SR=%#x, count=%d)\n",
+				substream->stream == SNDRV_PCM_STREAM_PLAYBACK
+				? "underrun" : "overrun",
+				params->name, ssc_sr, count);
+
+		/* re-start the PDC */
+		ssc_writex(params->ssc->regs, ATMEL_PDC_PTCR,
+			   params->mask->pdc_disable);
+		prtd->period_ptr += prtd->period_size;
+		if (prtd->period_ptr >= prtd->dma_buffer_end)
+			prtd->period_ptr = prtd->dma_buffer;
+
+		ssc_writex(params->ssc->regs, params->pdc->xpr,
+			   prtd->period_ptr);
+		ssc_writex(params->ssc->regs, params->pdc->xcr,
+			   prtd->period_size / params->pdc_xfer_size);
+		ssc_writex(params->ssc->regs, ATMEL_PDC_PTCR,
+			   params->mask->pdc_enable);
+	}
+
+	if (ssc_sr & params->mask->ssc_endx) {
+		/* Load the PDC next pointer and counter registers */
+		prtd->period_ptr += prtd->period_size;
+		if (prtd->period_ptr >= prtd->dma_buffer_end)
+			prtd->period_ptr = prtd->dma_buffer;
+
+		ssc_writex(params->ssc->regs, params->pdc->xnpr,
+			   prtd->period_ptr);
+		ssc_writex(params->ssc->regs, params->pdc->xncr,
+			   prtd->period_size / params->pdc_xfer_size);
+	}
+
+	snd_pcm_period_elapsed(substream);
+}
+
+
+/*--------------------------------------------------------------------------*\
+ * PCM operations
+\*--------------------------------------------------------------------------*/
+static int atmel_pcm_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct atmel_runtime_data *prtd = runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+
+	/* this may get called several times by oss emulation
+	 * with different params */
+
+	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+	runtime->dma_bytes = params_buffer_bytes(params);
+
+	prtd->params = rtd->dai->cpu_dai->dma_data;
+	prtd->params->dma_intr_handler = atmel_pcm_dma_irq;
+
+	prtd->dma_buffer = runtime->dma_addr;
+	prtd->dma_buffer_end = runtime->dma_addr + runtime->dma_bytes;
+	prtd->period_size = params_period_bytes(params);
+
+	pr_debug("atmel-pcm: "
+		"hw_params: DMA for %s initialized "
+		"(dma_bytes=%u, period_size=%u)\n",
+		prtd->params->name,
+		runtime->dma_bytes,
+		prtd->period_size);
+	return 0;
+}
+
+static int atmel_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	struct atmel_runtime_data *prtd = substream->runtime->private_data;
+	struct atmel_pcm_dma_params *params = prtd->params;
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
+static int atmel_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct atmel_runtime_data *prtd = substream->runtime->private_data;
+	struct atmel_pcm_dma_params *params = prtd->params;
+
+	ssc_writex(params->ssc->regs, SSC_IDR,
+		   params->mask->ssc_endx | params->mask->ssc_endbuf);
+	ssc_writex(params->ssc->regs, ATMEL_PDC_PTCR,
+		   params->mask->pdc_disable);
+	return 0;
+}
+
+static int atmel_pcm_trigger(struct snd_pcm_substream *substream,
+	int cmd)
+{
+	struct snd_pcm_runtime *rtd = substream->runtime;
+	struct atmel_runtime_data *prtd = rtd->private_data;
+	struct atmel_pcm_dma_params *params = prtd->params;
+	int ret = 0;
+
+	pr_debug("atmel-pcm:buffer_size = %ld,"
+		"dma_area = %p, dma_bytes = %u\n",
+		rtd->buffer_size, rtd->dma_area, rtd->dma_bytes);
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
+		pr_debug("atmel-pcm: trigger: "
+			"period_ptr=%lx, xpr=%u, "
+			"xcr=%u, xnpr=%u, xncr=%u\n",
+			(unsigned long)prtd->period_ptr,
+			ssc_readx(params->ssc->regs, params->pdc->xpr),
+			ssc_readx(params->ssc->regs, params->pdc->xcr),
+			ssc_readx(params->ssc->regs, params->pdc->xnpr),
+			ssc_readx(params->ssc->regs, params->pdc->xncr));
+
+		ssc_writex(params->ssc->regs, SSC_IER,
+			   params->mask->ssc_endx | params->mask->ssc_endbuf);
+		ssc_writex(params->ssc->regs, SSC_PDC_PTCR,
+			   params->mask->pdc_enable);
+
+		pr_debug("sr=%u imr=%u\n",
+			ssc_readx(params->ssc->regs, SSC_SR),
+			ssc_readx(params->ssc->regs, SSC_IER));
+		break;		/* SNDRV_PCM_TRIGGER_START */
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		ssc_writex(params->ssc->regs, ATMEL_PDC_PTCR,
+			   params->mask->pdc_disable);
+		break;
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
+static snd_pcm_uframes_t atmel_pcm_pointer(
+	struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct atmel_runtime_data *prtd = runtime->private_data;
+	struct atmel_pcm_dma_params *params = prtd->params;
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
+static int atmel_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct atmel_runtime_data *prtd;
+	int ret = 0;
+
+	snd_soc_set_runtime_hwparams(substream, &atmel_pcm_hardware);
+
+	/* ensure that buffer size is a multiple of period size */
+	ret = snd_pcm_hw_constraint_integer(runtime,
+						SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0)
+		goto out;
+
+	prtd = kzalloc(sizeof(struct atmel_runtime_data), GFP_KERNEL);
+	if (prtd == NULL) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	runtime->private_data = prtd;
+
+ out:
+	return ret;
+}
+
+static int atmel_pcm_close(struct snd_pcm_substream *substream)
+{
+	struct atmel_runtime_data *prtd = substream->runtime->private_data;
+
+	kfree(prtd);
+	return 0;
+}
+
+static int atmel_pcm_mmap(struct snd_pcm_substream *substream,
+	struct vm_area_struct *vma)
+{
+	return remap_pfn_range(vma, vma->vm_start,
+		       substream->dma_buffer.addr >> PAGE_SHIFT,
+		       vma->vm_end - vma->vm_start, vma->vm_page_prot);
+}
+
+struct snd_pcm_ops atmel_pcm_ops = {
+	.open		= atmel_pcm_open,
+	.close		= atmel_pcm_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= atmel_pcm_hw_params,
+	.hw_free	= atmel_pcm_hw_free,
+	.prepare	= atmel_pcm_prepare,
+	.trigger	= atmel_pcm_trigger,
+	.pointer	= atmel_pcm_pointer,
+	.mmap		= atmel_pcm_mmap,
+};
+
+
+/*--------------------------------------------------------------------------*\
+ * ASoC platform driver
+\*--------------------------------------------------------------------------*/
+static u64 atmel_pcm_dmamask = 0xffffffff;
+
+static int atmel_pcm_new(struct snd_card *card,
+	struct snd_soc_dai *dai, struct snd_pcm *pcm)
+{
+	int ret = 0;
+
+	if (!card->dev->dma_mask)
+		card->dev->dma_mask = &atmel_pcm_dmamask;
+	if (!card->dev->coherent_dma_mask)
+		card->dev->coherent_dma_mask = 0xffffffff;
+
+	if (dai->playback.channels_min) {
+		ret = atmel_pcm_preallocate_dma_buffer(pcm,
+			SNDRV_PCM_STREAM_PLAYBACK);
+		if (ret)
+			goto out;
+	}
+
+	if (dai->capture.channels_min) {
+		pr_debug("at32-pcm:"
+				"Allocating PCM capture DMA buffer\n");
+		ret = atmel_pcm_preallocate_dma_buffer(pcm,
+			SNDRV_PCM_STREAM_CAPTURE);
+		if (ret)
+			goto out;
+	}
+ out:
+	return ret;
+}
+
+static void atmel_pcm_free_dma_buffers(struct snd_pcm *pcm)
+{
+	struct snd_pcm_substream *substream;
+	struct snd_dma_buffer *buf;
+	int stream;
+
+	for (stream = 0; stream < 2; stream++) {
+		substream = pcm->streams[stream].substream;
+		if (!substream)
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
+#ifdef CONFIG_PM
+static int atmel_pcm_suspend(struct platform_device *pdev,
+	struct snd_soc_dai *dai)
+{
+	struct snd_pcm_runtime *runtime = dai->runtime;
+	struct atmel_runtime_data *prtd;
+	struct atmel_pcm_dma_params *params;
+
+	if (!runtime)
+		return 0;
+
+	prtd = runtime->private_data;
+	params = prtd->params;
+
+	/* disable the PDC and save the PDC registers */
+
+	ssc_writel(params->ssc->regs, PDC_PTCR, params->mask->pdc_disable);
+
+	prtd->pdc_xpr_save = ssc_readx(params->ssc->regs, params->pdc->xpr);
+	prtd->pdc_xcr_save = ssc_readx(params->ssc->regs, params->pdc->xcr);
+	prtd->pdc_xnpr_save = ssc_readx(params->ssc->regs, params->pdc->xnpr);
+	prtd->pdc_xncr_save = ssc_readx(params->ssc->regs, params->pdc->xncr);
+
+	return 0;
+}
+
+static int atmel_pcm_resume(struct platform_device *pdev,
+	struct snd_soc_dai *dai)
+{
+	struct snd_pcm_runtime *runtime = dai->runtime;
+	struct atmel_runtime_data *prtd;
+	struct atmel_pcm_dma_params *params;
+
+	if (!runtime)
+		return 0;
+
+	prtd = runtime->private_data;
+	params = prtd->params;
+
+	/* restore the PDC registers and enable the PDC */
+	ssc_writex(params->ssc->regs, params->pdc->xpr, prtd->pdc_xpr_save);
+	ssc_writex(params->ssc->regs, params->pdc->xcr, prtd->pdc_xcr_save);
+	ssc_writex(params->ssc->regs, params->pdc->xnpr, prtd->pdc_xnpr_save);
+	ssc_writex(params->ssc->regs, params->pdc->xncr, prtd->pdc_xncr_save);
+
+	ssc_writel(params->ssc->regs, PDC_PTCR, params->mask->pdc_enable);
+	return 0;
+}
+#else
+#define atmel_pcm_suspend	NULL
+#define atmel_pcm_resume	NULL
+#endif
+
+struct snd_soc_platform atmel_soc_platform = {
+	.name		= "atmel-audio",
+	.pcm_ops 	= &atmel_pcm_ops,
+	.pcm_new	= atmel_pcm_new,
+	.pcm_free	= atmel_pcm_free_dma_buffers,
+	.suspend	= atmel_pcm_suspend,
+	.resume		= atmel_pcm_resume,
+};
+EXPORT_SYMBOL_GPL(atmel_soc_platform);
+
+MODULE_AUTHOR("Sedji Gaouaou <sedji.gaouaou@atmel.com>");
+MODULE_DESCRIPTION("Atmel PCM module");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/atmel/atmel-pcm.h b/sound/soc/atmel/atmel-pcm.h
new file mode 100644
index 0000000..ec9b282
--- /dev/null
+++ b/sound/soc/atmel/atmel-pcm.h
@@ -0,0 +1,86 @@
+/*
+ * at91-pcm.h - ALSA PCM interface for the Atmel AT91 SoC.
+ *
+ *  Copyright (C) 2005 SAN People
+ *  Copyright (C) 2008 Atmel
+ *
+ * Authors: Sedji Gaouaou <sedji.gaouaou@atmel.com>
+ *
+ * Based on at91-pcm. by:
+ * Frank Mandarino <fmandarino@endrelia.com>
+ * Copyright 2006 Endrelia Technologies Inc.
+ *
+ * Based on pxa2xx-pcm.c by:
+ *
+ * Author:	Nicolas Pitre
+ * Created:	Nov 30, 2004
+ * Copyright:	(C) 2004 MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef _ATMEL_PCM_H
+#define _ATMEL_PCM_H
+
+#include <linux/atmel-ssc.h>
+
+/*
+ * Registers and status bits that are required by the PCM driver.
+ */
+struct atmel_pdc_regs {
+	unsigned int	xpr;		/* PDC recv/trans pointer */
+	unsigned int	xcr;		/* PDC recv/trans counter */
+	unsigned int	xnpr;		/* PDC next recv/trans pointer */
+	unsigned int	xncr;		/* PDC next recv/trans counter */
+	unsigned int	ptcr;		/* PDC transfer control */
+};
+
+struct atmel_ssc_mask {
+	u32	ssc_enable;		/* SSC recv/trans enable */
+	u32	ssc_disable;		/* SSC recv/trans disable */
+	u32	ssc_endx;		/* SSC ENDTX or ENDRX */
+	u32	ssc_endbuf;		/* SSC TXBUFE or RXBUFF */
+	u32	pdc_enable;		/* PDC recv/trans enable */
+	u32	pdc_disable;		/* PDC recv/trans disable */
+};
+
+/*
+ * This structure, shared between the PCM driver and the interface,
+ * contains all information required by the PCM driver to perform the
+ * PDC DMA operation.  All fields except dma_intr_handler() are initialized
+ * by the interface.  The dms_intr_handler() pointer is set by the PCM
+ * driver and called by the interface SSC interrupt handler if it is
+ * non-NULL.
+ */
+struct atmel_pcm_dma_params {
+	char *name;			/* stream identifier */
+	int pdc_xfer_size;		/* PDC counter increment in bytes */
+	struct ssc_device *ssc;		/* SSC device for stream */
+	struct atmel_pdc_regs *pdc;	/* PDC receive or transmit registers */
+	struct atmel_ssc_mask *mask;	/* SSC & PDC status bits */
+	struct snd_pcm_substream *substream;
+	void (*dma_intr_handler)(u32, struct snd_pcm_substream *);
+};
+
+extern struct snd_soc_platform atmel_soc_platform;
+
+
+/*
+ * SSC register access (since ssc_writel() / ssc_readl() require literal name)
+ */
+#define ssc_readx(base, reg)            (__raw_readl((base) + (reg)))
+#define ssc_writex(base, reg, value)    __raw_writel((value), (base) + (reg))
+
+#endif /* _ATMEL_PCM_H */
diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
new file mode 100644
index 0000000..2ed1575
--- /dev/null
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -0,0 +1,803 @@
+/*
+ * atmel_ssc_dai.c  --  ALSA SoC ATMEL SSC Audio Layer Platform driver
+ *
+ * Copyright (C) 2005 SAN People
+ * Copyright (C) 2008 Atmel
+ *
+ * Author: Sedji Gaouaou <sedji.gaouaou@atmel.com>
+ *         ATMEL CORP.
+ *
+ * Based on at91-ssc.c by
+ * Frank Mandarino <fmandarino@endrelia.com>
+ * Based on pxa2xx Platform drivers by
+ * Liam Girdwood <liam.girdwood@wolfsonmicro.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/atmel_pdc.h>
+
+#include <linux/atmel-ssc.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+
+#include <mach/hardware.h>
+
+#include "atmel-pcm.h"
+#include "atmel_ssc_dai.h"
+
+
+#if defined(CONFIG_ARCH_AT91SAM9260) || defined(CONFIG_ARCH_AT91SAM9G20)
+#define NUM_SSC_DEVICES		1
+#else
+#define NUM_SSC_DEVICES		3
+#endif
+
+/*
+ * SSC PDC registers required by the PCM DMA engine.
+ */
+static struct atmel_pdc_regs pdc_tx_reg = {
+	.xpr		= ATMEL_PDC_TPR,
+	.xcr		= ATMEL_PDC_TCR,
+	.xnpr		= ATMEL_PDC_TNPR,
+	.xncr		= ATMEL_PDC_TNCR,
+};
+
+static struct atmel_pdc_regs pdc_rx_reg = {
+	.xpr		= ATMEL_PDC_RPR,
+	.xcr		= ATMEL_PDC_RCR,
+	.xnpr		= ATMEL_PDC_RNPR,
+	.xncr		= ATMEL_PDC_RNCR,
+};
+
+/*
+ * SSC & PDC status bits for transmit and receive.
+ */
+static struct atmel_ssc_mask ssc_tx_mask = {
+	.ssc_enable	= SSC_BIT(CR_TXEN),
+	.ssc_disable	= SSC_BIT(CR_TXDIS),
+	.ssc_endx	= SSC_BIT(SR_ENDTX),
+	.ssc_endbuf	= SSC_BIT(SR_TXBUFE),
+	.pdc_enable	= ATMEL_PDC_TXTEN,
+	.pdc_disable	= ATMEL_PDC_TXTDIS,
+};
+
+static struct atmel_ssc_mask ssc_rx_mask = {
+	.ssc_enable	= SSC_BIT(CR_RXEN),
+	.ssc_disable	= SSC_BIT(CR_RXDIS),
+	.ssc_endx	= SSC_BIT(SR_ENDRX),
+	.ssc_endbuf	= SSC_BIT(SR_RXBUFF),
+	.pdc_enable	= ATMEL_PDC_RXTEN,
+	.pdc_disable	= ATMEL_PDC_RXTDIS,
+};
+
+
+/*
+ * DMA parameters.
+ */
+static struct atmel_pcm_dma_params ssc_dma_params[NUM_SSC_DEVICES][2] = {
+	{{
+	.name		= "SSC0 PCM out",
+	.pdc		= &pdc_tx_reg,
+	.mask		= &ssc_tx_mask,
+	},
+	{
+	.name		= "SSC0 PCM in",
+	.pdc		= &pdc_rx_reg,
+	.mask		= &ssc_rx_mask,
+	} },
+#if NUM_SSC_DEVICES == 3
+	{{
+	.name		= "SSC1 PCM out",
+	.pdc		= &pdc_tx_reg,
+	.mask		= &ssc_tx_mask,
+	},
+	{
+	.name		= "SSC1 PCM in",
+	.pdc		= &pdc_rx_reg,
+	.mask		= &ssc_rx_mask,
+	} },
+	{{
+	.name		= "SSC2 PCM out",
+	.pdc		= &pdc_tx_reg,
+	.mask		= &ssc_tx_mask,
+	},
+	{
+	.name		= "SSC2 PCM in",
+	.pdc		= &pdc_rx_reg,
+	.mask		= &ssc_rx_mask,
+	} },
+#endif
+};
+
+
+static struct atmel_ssc_info ssc_info[NUM_SSC_DEVICES] = {
+	{
+	.name		= "ssc0",
+	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info[0].lock),
+	.dir_mask	= SSC_DIR_MASK_UNUSED,
+	.initialized	= 0,
+	},
+#if NUM_SSC_DEVICES == 3
+	{
+	.name		= "ssc1",
+	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info[1].lock),
+	.dir_mask	= SSC_DIR_MASK_UNUSED,
+	.initialized	= 0,
+	},
+	{
+	.name		= "ssc2",
+	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info[2].lock),
+	.dir_mask	= SSC_DIR_MASK_UNUSED,
+	.initialized	= 0,
+	},
+#endif
+};
+
+
+/*
+ * SSC interrupt handler.  Passes PDC interrupts to the DMA
+ * interrupt handler in the PCM driver.
+ */
+static irqreturn_t atmel_ssc_interrupt(int irq, void *dev_id)
+{
+	struct atmel_ssc_info *ssc_p = dev_id;
+	struct atmel_pcm_dma_params *dma_params;
+	u32 ssc_sr;
+	u32 ssc_substream_mask;
+	int i;
+
+	ssc_sr = (unsigned long)ssc_readl(ssc_p->ssc->regs, SR)
+			& (unsigned long)ssc_readl(ssc_p->ssc->regs, IMR);
+
+	/*
+	 * Loop through the substreams attached to this SSC.  If
+	 * a DMA-related interrupt occurred on that substream, call
+	 * the DMA interrupt handler function, if one has been
+	 * registered in the dma_params structure by the PCM driver.
+	 */
+	for (i = 0; i < ARRAY_SIZE(ssc_p->dma_params); i++) {
+		dma_params = ssc_p->dma_params[i];
+
+		if ((dma_params != NULL) &&
+			(dma_params->dma_intr_handler != NULL)) {
+			ssc_substream_mask = (dma_params->mask->ssc_endx |
+					dma_params->mask->ssc_endbuf);
+			if (ssc_sr & ssc_substream_mask) {
+				dma_params->dma_intr_handler(ssc_sr,
+						dma_params->
+						substream);
+			}
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+
+/*-------------------------------------------------------------------------*\
+ * DAI functions
+\*-------------------------------------------------------------------------*/
+/*
+ * Startup.  Only that one substream allowed in each direction.
+ */
+static int atmel_ssc_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct atmel_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
+	int dir_mask;
+
+	pr_debug("atmel_ssc_startup: SSC_SR=0x%u\n",
+		ssc_readl(ssc_p->ssc->regs, SR));
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dir_mask = SSC_DIR_MASK_PLAYBACK;
+	else
+		dir_mask = SSC_DIR_MASK_CAPTURE;
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
+/*
+ * Shutdown.  Clear DMA parameters and shutdown the SSC if there
+ * are no other substreams open.
+ */
+static void atmel_ssc_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct atmel_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
+	struct atmel_pcm_dma_params *dma_params;
+	int dir, dir_mask;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dir = 0;
+	else
+		dir = 1;
+
+	dma_params = ssc_p->dma_params[dir];
+
+	if (dma_params != NULL) {
+		ssc_writel(ssc_p->ssc->regs, CR, dma_params->mask->ssc_disable);
+		pr_debug("atmel_ssc_shutdown: %s disabled SSC_SR=0x%08x\n",
+			(dir ? "receive" : "transmit"),
+			ssc_readl(ssc_p->ssc->regs, SR));
+
+		dma_params->ssc = NULL;
+		dma_params->substream = NULL;
+		ssc_p->dma_params[dir] = NULL;
+	}
+
+	dir_mask = 1 << dir;
+
+	spin_lock_irq(&ssc_p->lock);
+	ssc_p->dir_mask &= ~dir_mask;
+	if (!ssc_p->dir_mask) {
+		/* Shutdown the SSC clock. */
+		pr_debug("atmel_ssc_dau: Stopping clock\n");
+		clk_disable(ssc_p->ssc->clk);
+
+		if (ssc_p->initialized) {
+			free_irq(ssc_p->ssc->irq, ssc_p);
+			ssc_p->initialized = 0;
+		}
+
+		/* Reset the SSC */
+		ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_SWRST));
+		/* Clear the SSC dividers */
+		ssc_p->cmr_div = ssc_p->tcmr_period = ssc_p->rcmr_period = 0;
+	}
+	spin_unlock_irq(&ssc_p->lock);
+}
+#if 0
+/*
+ * Record the SSC system clock rate.
+ */
+static int atmel_ssc_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	/*
+	 * The only clock supplied to the SSC is the AT91 master clock,
+	 * which is only used if the SSC is generating BCLK and/or
+	 * LRC clocks.
+	 */
+	switch (clk_id) {
+	case ATMEL_SYSCLK_MCK:
+		atmel_ssc_sysclk = freq;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+#endif
+/*
+ * Record the DAI format for use in hw_params().
+ */
+static int atmel_ssc_set_dai_fmt(struct snd_soc_dai *cpu_dai,
+		unsigned int fmt)
+{
+	struct atmel_ssc_info *ssc_p = &ssc_info[cpu_dai->id];
+
+	ssc_p->daifmt = fmt;
+	return 0;
+}
+
+/*
+ * Record SSC clock dividers for use in hw_params().
+ */
+static int atmel_ssc_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
+	int div_id, int div)
+{
+	struct atmel_ssc_info *ssc_p = &ssc_info[cpu_dai->id];
+
+	switch (div_id) {
+	case ATMEL_SSC_CMR_DIV:
+		/*
+		 * The same master clock divider is used for both
+		 * transmit and receive, so if a value has already
+		 * been set, it must match this value.
+		 */
+		if (ssc_p->cmr_div == 0)
+			ssc_p->cmr_div = div;
+		else
+			if (div != ssc_p->cmr_div)
+				return -EBUSY;
+		break;
+
+	case ATMEL_SSC_TCMR_PERIOD:
+		ssc_p->tcmr_period = div;
+		break;
+
+	case ATMEL_SSC_RCMR_PERIOD:
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
+/*
+ * Configure the SSC.
+ */
+static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	int id = rtd->dai->cpu_dai->id;
+	struct atmel_ssc_info *ssc_p = &ssc_info[id];
+	struct atmel_pcm_dma_params *dma_params;
+	int dir, channels, bits;
+	u32 tfmr, rfmr, tcmr, rcmr;
+	int start_event;
+	int ret;
+
+	/*
+	 * Currently, there is only one set of dma params for
+	 * each direction.  If more are added, this code will
+	 * have to be changed to select the proper set.
+	 */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dir = 0;
+	else
+		dir = 1;
+
+	dma_params = &ssc_dma_params[id][dir];
+	dma_params->ssc = ssc_p->ssc;
+	dma_params->substream = substream;
+
+	ssc_p->dma_params[dir] = dma_params;
+
+	/*
+	 * The cpu_dai->dma_data field is only used to communicate the
+	 * appropriate DMA parameters to the pcm driver hw_params()
+	 * function.  It should not be used for other purposes
+	 * as it is common to all substreams.
+	 */
+	rtd->dai->cpu_dai->dma_data = dma_params;
+
+	channels = params_channels(params);
+
+	/*
+	 * Determine sample size in bits and the PDC increment.
+	 */
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S8:
+		bits = 8;
+		dma_params->pdc_xfer_size = 1;
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		bits = 16;
+		dma_params->pdc_xfer_size = 2;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		bits = 24;
+		dma_params->pdc_xfer_size = 4;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		bits = 32;
+		dma_params->pdc_xfer_size = 4;
+		break;
+	default:
+		printk(KERN_WARNING "atmel_ssc_dai: unsupported PCM format");
+		return -EINVAL;
+	}
+
+	/*
+	 * The SSC only supports up to 16-bit samples in I2S format, due
+	 * to the size of the Frame Mode Register FSLEN field.
+	 */
+	if ((ssc_p->daifmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_I2S
+		&& bits > 16) {
+		printk(KERN_WARNING
+				"atmel_ssc_dai: sample size %d"
+				"is too large for I2S\n", bits);
+		return -EINVAL;
+	}
+
+	/*
+	 * Compute SSC register settings.
+	 */
+	switch (ssc_p->daifmt
+		& (SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_MASTER_MASK)) {
+
+	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS:
+		/*
+		 * I2S format, SSC provides BCLK and LRC clocks.
+		 *
+		 * The SSC transmit and receive clocks are generated
+		 * from the MCK divider, and the BCLK signal
+		 * is output on the SSC TK line.
+		 */
+		rcmr =	  SSC_BF(RCMR_PERIOD, ssc_p->rcmr_period)
+			| SSC_BF(RCMR_STTDLY, START_DELAY)
+			| SSC_BF(RCMR_START, SSC_START_FALLING_RF)
+			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
+			| SSC_BF(RCMR_CKO, SSC_CKO_NONE)
+			| SSC_BF(RCMR_CKS, SSC_CKS_DIV);
+
+		rfmr =	  SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
+			| SSC_BF(RFMR_FSOS, SSC_FSOS_NEGATIVE)
+			| SSC_BF(RFMR_FSLEN, (bits - 1))
+			| SSC_BF(RFMR_DATNB, (channels - 1))
+			| SSC_BIT(RFMR_MSBF)
+			| SSC_BF(RFMR_LOOP, 0)
+			| SSC_BF(RFMR_DATLEN, (bits - 1));
+
+		tcmr =	  SSC_BF(TCMR_PERIOD, ssc_p->tcmr_period)
+			| SSC_BF(TCMR_STTDLY, START_DELAY)
+			| SSC_BF(TCMR_START, SSC_START_FALLING_RF)
+			| SSC_BF(TCMR_CKI, SSC_CKI_FALLING)
+			| SSC_BF(TCMR_CKO, SSC_CKO_CONTINUOUS)
+			| SSC_BF(TCMR_CKS, SSC_CKS_DIV);
+
+		tfmr =	  SSC_BF(TFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
+			| SSC_BF(TFMR_FSDEN, 0)
+			| SSC_BF(TFMR_FSOS, SSC_FSOS_NEGATIVE)
+			| SSC_BF(TFMR_FSLEN, (bits - 1))
+			| SSC_BF(TFMR_DATNB, (channels - 1))
+			| SSC_BIT(TFMR_MSBF)
+			| SSC_BF(TFMR_DATDEF, 0)
+			| SSC_BF(TFMR_DATLEN, (bits - 1));
+		break;
+
+	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM:
+		/*
+		 * I2S format, CODEC supplies BCLK and LRC clocks.
+		 *
+		 * The SSC transmit clock is obtained from the BCLK signal on
+		 * on the TK line, and the SSC receive clock is
+		 * generated from the transmit clock.
+		 *
+		 *  For single channel data, one sample is transferred
+		 * on the falling edge of the LRC clock.
+		 * For two channel data, one sample is
+		 * transferred on both edges of the LRC clock.
+		 */
+		start_event = ((channels == 1)
+				? SSC_START_FALLING_RF
+				: SSC_START_EDGE_RF);
+
+		rcmr =	  SSC_BF(RCMR_PERIOD, 0)
+			| SSC_BF(RCMR_STTDLY, START_DELAY)
+			| SSC_BF(RCMR_START, start_event)
+			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
+			| SSC_BF(RCMR_CKO, SSC_CKO_NONE)
+			| SSC_BF(RCMR_CKS, SSC_CKS_CLOCK);
+
+		rfmr =	  SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
+			| SSC_BF(RFMR_FSOS, SSC_FSOS_NONE)
+			| SSC_BF(RFMR_FSLEN, 0)
+			| SSC_BF(RFMR_DATNB, 0)
+			| SSC_BIT(RFMR_MSBF)
+			| SSC_BF(RFMR_LOOP, 0)
+			| SSC_BF(RFMR_DATLEN, (bits - 1));
+
+		tcmr =	  SSC_BF(TCMR_PERIOD, 0)
+			| SSC_BF(TCMR_STTDLY, START_DELAY)
+			| SSC_BF(TCMR_START, start_event)
+			| SSC_BF(TCMR_CKI, SSC_CKI_FALLING)
+			| SSC_BF(TCMR_CKO, SSC_CKO_NONE)
+			| SSC_BF(TCMR_CKS, SSC_CKS_PIN);
+
+		tfmr =	  SSC_BF(TFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
+			| SSC_BF(TFMR_FSDEN, 0)
+			| SSC_BF(TFMR_FSOS, SSC_FSOS_NONE)
+			| SSC_BF(TFMR_FSLEN, 0)
+			| SSC_BF(TFMR_DATNB, 0)
+			| SSC_BIT(TFMR_MSBF)
+			| SSC_BF(TFMR_DATDEF, 0)
+			| SSC_BF(TFMR_DATLEN, (bits - 1));
+		break;
+
+	case SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_CBS_CFS:
+		/*
+		 * DSP/PCM Mode A format, SSC provides BCLK and LRC clocks.
+		 *
+		 * The SSC transmit and receive clocks are generated from the
+		 * MCK divider, and the BCLK signal is output
+		 * on the SSC TK line.
+		 */
+		rcmr =	  SSC_BF(RCMR_PERIOD, ssc_p->rcmr_period)
+			| SSC_BF(RCMR_STTDLY, 1)
+			| SSC_BF(RCMR_START, SSC_START_RISING_RF)
+			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
+			| SSC_BF(RCMR_CKO, SSC_CKO_NONE)
+			| SSC_BF(RCMR_CKS, SSC_CKS_DIV);
+
+		rfmr =	  SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
+			| SSC_BF(RFMR_FSOS, SSC_FSOS_POSITIVE)
+			| SSC_BF(RFMR_FSLEN, 0)
+			| SSC_BF(RFMR_DATNB, (channels - 1))
+			| SSC_BIT(RFMR_MSBF)
+			| SSC_BF(RFMR_LOOP, 0)
+			| SSC_BF(RFMR_DATLEN, (bits - 1));
+
+		tcmr =	  SSC_BF(TCMR_PERIOD, ssc_p->tcmr_period)
+			| SSC_BF(TCMR_STTDLY, 1)
+			| SSC_BF(TCMR_START, SSC_START_RISING_RF)
+			| SSC_BF(TCMR_CKI, SSC_CKI_RISING)
+			| SSC_BF(TCMR_CKO, SSC_CKO_CONTINUOUS)
+			| SSC_BF(TCMR_CKS, SSC_CKS_DIV);
+
+		tfmr =	  SSC_BF(TFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
+			| SSC_BF(TFMR_FSDEN, 0)
+			| SSC_BF(TFMR_FSOS, SSC_FSOS_POSITIVE)
+			| SSC_BF(TFMR_FSLEN, 0)
+			| SSC_BF(TFMR_DATNB, (channels - 1))
+			| SSC_BIT(TFMR_MSBF)
+			| SSC_BF(TFMR_DATDEF, 0)
+			| SSC_BF(TFMR_DATLEN, (bits - 1));
+		break;
+
+	case SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_CBM_CFM:
+	default:
+		printk(KERN_WARNING "atmel_ssc_dai: unsupported DAI format 0x%x\n",
+			ssc_p->daifmt);
+		return -EINVAL;
+		break;
+	}
+	pr_debug("atmel_ssc_hw_params: "
+			"RCMR=%08x RFMR=%08x TCMR=%08x TFMR=%08x\n",
+			rcmr, rfmr, tcmr, tfmr);
+
+	if (!ssc_p->initialized) {
+
+		/* Enable PMC peripheral clock for this SSC */
+		pr_debug("atmel_ssc_dai: Starting clock\n");
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
+		ret = request_irq(ssc_p->ssc->irq, atmel_ssc_interrupt, 0,
+				ssc_p->name, ssc_p);
+		if (ret < 0) {
+			printk(KERN_WARNING
+					"atmel_ssc_dai: request_irq failure\n");
+			pr_debug("Atmel_ssc_dai: Stoping clock\n");
+			clk_disable(ssc_p->ssc->clk);
+			return ret;
+		}
+
+		ssc_p->initialized = 1;
+	}
+
+	/* set SSC clock mode register */
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
+	pr_debug("atmel_ssc_dai,hw_params: SSC initialized\n");
+	return 0;
+}
+
+
+static int atmel_ssc_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct atmel_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
+	struct atmel_pcm_dma_params *dma_params;
+	int dir;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dir = 0;
+	else
+		dir = 1;
+
+	dma_params = ssc_p->dma_params[dir];
+
+	ssc_writel(ssc_p->ssc->regs, CR, dma_params->mask->ssc_enable);
+
+	pr_debug("%s enabled SSC_SR=0x%08x\n",
+			dir ? "receive" : "transmit",
+			ssc_readl(ssc_p->ssc->regs, SR));
+	return 0;
+}
+
+
+#ifdef CONFIG_PM
+static int atmel_ssc_suspend(struct platform_device *pdev,
+			    struct snd_soc_dai *cpu_dai)
+{
+	struct atmel_ssc_info *ssc_p;
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
+static int atmel_ssc_resume(struct platform_device *pdev,
+			   struct snd_soc_dai *cpu_dai)
+{
+	struct atmel_ssc_info *ssc_p;
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
+#  define atmel_ssc_suspend	NULL
+#  define atmel_ssc_resume	NULL
+#endif /* CONFIG_PM */
+
+
+#define ATMEL_SSC_RATES (SNDRV_PCM_RATE_8000_96000)
+
+#define ATMEL_SSC_FORMATS (SNDRV_PCM_FMTBIT_S8     | SNDRV_PCM_FMTBIT_S16_LE |\
+			  SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
+
+struct snd_soc_dai atmel_ssc_dai[NUM_SSC_DEVICES] = {
+	{	.name = "atmel-ssc0",
+		.id = 0,
+		.type = SND_SOC_DAI_PCM,
+		.suspend = atmel_ssc_suspend,
+		.resume = atmel_ssc_resume,
+		.playback = {
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = ATMEL_SSC_RATES,
+			.formats = ATMEL_SSC_FORMATS,},
+		.capture = {
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = ATMEL_SSC_RATES,
+			.formats = ATMEL_SSC_FORMATS,},
+		.ops = {
+			.startup = atmel_ssc_startup,
+			.shutdown = atmel_ssc_shutdown,
+			.prepare = atmel_ssc_prepare,
+			.hw_params = atmel_ssc_hw_params,},
+		.dai_ops = {
+			.set_fmt = atmel_ssc_set_dai_fmt,
+			.set_clkdiv = atmel_ssc_set_dai_clkdiv,},
+		.private_data = &ssc_info[0],
+	},
+#if NUM_SSC_DEVICES == 3
+	{	.name = "atmel-ssc1",
+		.id = 1,
+		.type = SND_SOC_DAI_PCM,
+		.suspend = atmel_ssc_suspend,
+		.resume = atmel_ssc_resume,
+		.playback = {
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = ATMEL_SSC_RATES,
+			.formats = ATMEL_SSC_FORMATS,},
+		.capture = {
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = ATMEL_SSC_RATES,
+			.formats = ATMEL_SSC_FORMATS,},
+		.ops = {
+			.startup = atmel_ssc_startup,
+			.shutdown = atmel_ssc_shutdown,
+			.prepare = atmel_ssc_prepare,
+			.hw_params = atmel_ssc_hw_params,},
+		.dai_ops = {
+			.set_fmt = atmel_ssc_set_dai_fmt,
+			.set_clkdiv = atmel_ssc_set_dai_clkdiv,},
+		.private_data = &ssc_info[1],
+	},
+	{	.name = "atmel-ssc2",
+		.id = 2,
+		.type = SND_SOC_DAI_PCM,
+		.suspend = atmel_ssc_suspend,
+		.resume = atmel_ssc_resume,
+		.playback = {
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = ATMEL_SSC_RATES,
+			.formats = ATMEL_SSC_FORMATS,},
+		.capture = {
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = ATMEL_SSC_RATES,
+			.formats = ATMEL_SSC_FORMATS,},
+		.ops = {
+			.startup = atmel_ssc_startup,
+			.shutdown = atmel_ssc_shutdown,
+			.prepare = atmel_ssc_prepare,
+			.hw_params = atmel_ssc_hw_params,},
+		.dai_ops = {
+			.set_fmt = atmel_ssc_set_dai_fmt,
+			.set_clkdiv = atmel_ssc_set_dai_clkdiv,},
+		.private_data = &ssc_info[2],
+	},
+#endif
+};
+EXPORT_SYMBOL_GPL(atmel_ssc_dai);
+
+/* Module information */
+MODULE_AUTHOR("Sedji Gaouaou, sedji.gaouaou@atmel.com, www.atmel.com");
+MODULE_DESCRIPTION("ATMEL SSC ASoC Interface");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/atmel/atmel_ssc_dai.h b/sound/soc/atmel/atmel_ssc_dai.h
new file mode 100644
index 0000000..a828746
--- /dev/null
+++ b/sound/soc/atmel/atmel_ssc_dai.h
@@ -0,0 +1,121 @@
+/*
+ * atmel_ssc_dai.h - ALSA SSC interface for the Atmel  SoC
+ *
+ * Copyright (C) 2005 SAN People
+ * Copyright (C) 2008 Atmel
+ *
+ * Author: Sedji Gaouaou <sedji.gaouaou@atmel.com>
+ *         ATMEL CORP.
+ *
+ * Based on at91-ssc.c by
+ * Frank Mandarino <fmandarino@endrelia.com>
+ * Based on pxa2xx Platform drivers by
+ * Liam Girdwood <liam.girdwood@wolfsonmicro.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef _ATMEL_SSC_DAI_H
+#define _ATMEL_SSC_DAI_H
+
+#include <linux/types.h>
+#include <linux/atmel-ssc.h>
+
+#include "atmel-pcm.h"
+
+/* SSC system clock ids */
+#define ATMEL_SYSCLK_MCK	0 /* SSC uses AT91 MCK as system clock */
+
+/* SSC divider ids */
+#define ATMEL_SSC_CMR_DIV	0 /* MCK divider for BCLK */
+#define ATMEL_SSC_TCMR_PERIOD	1 /* BCLK divider for transmit FS */
+#define ATMEL_SSC_RCMR_PERIOD	2 /* BCLK divider for receive FS */
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
+struct atmel_ssc_state {
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
+struct atmel_ssc_info {
+	char *name;
+	struct ssc_device *ssc;
+	spinlock_t lock;	/* lock for dir_mask */
+	unsigned short dir_mask;	/* 0=unused, 1=playback, 2=capture */
+	unsigned short initialized;	/* true if SSC has been initialized */
+	unsigned short daifmt;
+	unsigned short cmr_div;
+	unsigned short tcmr_period;
+	unsigned short rcmr_period;
+	struct atmel_pcm_dma_params *dma_params[2];
+	struct atmel_ssc_state ssc_state;
+};
+extern struct snd_soc_dai atmel_ssc_dai[];
+
+#endif /* _AT91_SSC_DAI_H */
diff --git a/sound/soc/atmel/playpaq_wm8510.c b/sound/soc/atmel/playpaq_wm8510.c
new file mode 100644
index 0000000..7e6560b
--- /dev/null
+++ b/sound/soc/atmel/playpaq_wm8510.c
@@ -0,0 +1,523 @@
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
+#include <mach/at32ap700x.h>
+#include <mach/portmux.h>
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
+	struct snd_soc_dai *cpu_dai)
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
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
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
+	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
+	if (ret < 0) {
+		pr_warning("playpaq_wm8510: "
+			   "Failed to set CODEC DAI format (%d)\n",
+			   ret);
+		return ret;
+	}
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
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
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, AT32_SSC_CMR_DIV, cd.cmr_div);
+	if (ret < 0) {
+		pr_warning("playpaq_wm8510: Failed to set CPU CMR_DIV (%d)\n",
+			   ret);
+		return ret;
+	}
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, AT32_SSC_TCMR_PERIOD,
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
+	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8510_BCLKDIV, bclk);
+	if (ret < 0) {
+		pr_warning
+		    ("playpaq_wm8510: Failed to set CODEC DAI BCLKDIV (%d)\n",
+		     ret);
+		return ret;
+	}
+#endif /* CONFIG_SND_AT32_SOC_PLAYPAQ_SLAVE */
+
+
+	ret = snd_soc_dai_set_pll(codec_dai, 0,
+					 clk_get_rate(CODEC_CLK), pll_out);
+	if (ret < 0) {
+		pr_warning("playpaq_wm8510: Failed to set CODEC DAI PLL (%d)\n",
+			   ret);
+		return ret;
+	}
+
+
+	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8510_MCLKDIV, mclk_div);
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
+	/* always connected pins */
+	snd_soc_dapm_enable_pin(codec, "Int Mic");
+	snd_soc_dapm_enable_pin(codec, "Ext Spk");
+	snd_soc_dapm_sync(codec);
+
+
+
+	/* Make CSB show PLL rate */
+	snd_soc_dai_set_clkdiv(codec->dai, WM8510_OPCLKDIV,
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
+	.i2c_bus = 0,
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
diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
new file mode 100644
index 0000000..4e191df
--- /dev/null
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -0,0 +1,329 @@
+/*
+ * sam9g20_wm8731  --  SoC audio for AT91SAM9G20-based
+ * 			ATMEL AT91SAM9G20ek board.
+ *
+ *  Copyright (C) 2005 SAN People
+ *  Copyright (C) 2008 Atmel
+ *
+ * Authors: Sedji Gaouaou <sedji.gaouaou@atmel.com>
+ *
+ * Based on ati_b1_wm8731.c by:
+ * Frank Mandarino <fmandarino@endrelia.com>
+ * Copyright 2006 Endrelia Technologies Inc.
+ * Based on corgi.c by:
+ * Copyright 2005 Wolfson Microelectronics PLC.
+ * Copyright 2005 Openedhand Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/timer.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+
+#include <linux/atmel-ssc.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <mach/hardware.h>
+#include <mach/gpio.h>
+
+#include "../codecs/wm8731.h"
+#include "atmel-pcm.h"
+#include "atmel_ssc_dai.h"
+
+
+static int at91sam9g20ek_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	int ret;
+
+	/* codec system clock is supplied by PCK0, set to 12MHz */
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK,
+		12000000, SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static void at91sam9g20ek_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+
+	dev_dbg(rtd->socdev->dev, "shutdown");
+}
+
+static int at91sam9g20ek_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct atmel_ssc_info *ssc_p = cpu_dai->private_data;
+	struct ssc_device *ssc = ssc_p->ssc;
+	int ret;
+
+	unsigned int rate;
+	int cmr_div, period;
+
+	if (ssc == NULL) {
+		printk(KERN_INFO "at91sam9g20ek_hw_params: ssc is NULL!\n");
+		return -EINVAL;
+	}
+
+	/* set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	/* set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * The SSC clock dividers depend on the sample rate.  The CMR.DIV
+	 * field divides the system master clock MCK to drive the SSC TK
+	 * signal which provides the codec BCLK.  The TCMR.PERIOD and
+	 * RCMR.PERIOD fields further divide the BCLK signal to drive
+	 * the SSC TF and RF signals which provide the codec DACLRC and
+	 * ADCLRC clocks.
+	 *
+	 * The dividers were determined through trial and error, where a
+	 * CMR.DIV value is chosen such that the resulting BCLK value is
+	 * divisible, or almost divisible, by (2 * sample rate), and then
+	 * the TCMR.PERIOD or RCMR.PERIOD is BCLK / (2 * sample rate) - 1.
+	 */
+	rate = params_rate(params);
+
+	switch (rate) {
+	case 8000:
+		cmr_div = 55;	/* BCLK = 133MHz/(2*55) = 1.209MHz */
+		period = 74;	/* LRC = BCLK/(2*(74+1)) ~= 8060,6Hz */
+		break;
+	case 11025:
+		cmr_div = 67;	/* BCLK = 133MHz/(2*60) = 1.108MHz */
+		period = 45;	/* LRC = BCLK/(2*(49+1)) = 11083,3Hz */
+		break;
+	case 16000:
+		cmr_div = 63;	/* BCLK = 133MHz/(2*63) = 1.055MHz */
+		period = 32;	/* LRC = BCLK/(2*(32+1)) = 15993,2Hz */
+		break;
+	case 22050:
+		cmr_div = 52;	/* BCLK = 133MHz/(2*52) = 1.278MHz */
+		period = 28;	/* LRC = BCLK/(2*(28+1)) = 22049Hz */
+		break;
+	case 32000:
+		cmr_div = 66;	/* BCLK = 133MHz/(2*66) = 1.007MHz */
+		period = 15;	/* LRC = BCLK/(2*(15+1)) = 31486,742Hz */
+		break;
+	case 44100:
+		cmr_div = 29;	/* BCLK = 133MHz/(2*29) = 2.293MHz */
+		period = 25;	/* LRC = BCLK/(2*(25+1)) = 44098Hz */
+		break;
+	case 48000:
+		cmr_div = 33;	/* BCLK = 133MHz/(2*33) = 2.015MHz */
+		period = 20;	/* LRC = BCLK/(2*(20+1)) = 47979,79Hz */
+		break;
+	case 88200:
+		cmr_div = 29;	/* BCLK = 133MHz/(2*29) = 2.293MHz */
+		period = 12;	/* LRC = BCLK/(2*(12+1)) = 88196Hz */
+		break;
+	case 96000:
+		cmr_div = 23;	/* BCLK = 133MHz/(2*23) = 2.891MHz */
+		period = 14;	/* LRC = BCLK/(2*(14+1)) = 96376Hz */
+		break;
+	default:
+		printk(KERN_WARNING "unsupported rate %d"
+				" on at91sam9g20ek board\n", rate);
+		return -EINVAL;
+	}
+
+	/* set the MCK divider for BCLK */
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, ATMEL_SSC_CMR_DIV, cmr_div);
+	if (ret < 0)
+		return ret;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		/* set the BCLK divider for DACLRC */
+		ret = snd_soc_dai_set_clkdiv(cpu_dai,
+						ATMEL_SSC_TCMR_PERIOD, period);
+	} else {
+		/* set the BCLK divider for ADCLRC */
+		ret = snd_soc_dai_set_clkdiv(cpu_dai,
+						ATMEL_SSC_RCMR_PERIOD, period);
+	}
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct snd_soc_ops at91sam9g20ek_ops = {
+	.startup = at91sam9g20ek_startup,
+	.hw_params = at91sam9g20ek_hw_params,
+	.shutdown = at91sam9g20ek_shutdown,
+};
+
+
+static const struct snd_soc_dapm_widget at91sam9g20ek_dapm_widgets[] = {
+	SND_SOC_DAPM_MIC("Int Mic", NULL),
+	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+};
+
+static const struct snd_soc_dapm_route intercon[] = {
+
+	/* speaker connected to LHPOUT */
+	{"Ext Spk", NULL, "LHPOUT"},
+
+	/* mic is connected to Mic Jack, with WM8731 Mic Bias */
+	{"MICIN", NULL, "Mic Bias"},
+	{"Mic Bias", NULL, "Int Mic"},
+};
+
+/*
+ * Logic for a wm8731 as connected on a at91sam9g20ek board.
+ */
+static int at91sam9g20ek_wm8731_init(struct snd_soc_codec *codec)
+{
+	printk(KERN_DEBUG
+			"at91sam9g20ek_wm8731 "
+			": at91sam9g20ek_wm8731_init() called\n");
+
+	/* Add specific widgets */
+	snd_soc_dapm_new_controls(codec, at91sam9g20ek_dapm_widgets,
+				  ARRAY_SIZE(at91sam9g20ek_dapm_widgets));
+	/* Set up specific audio path interconnects */
+	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
+
+	/* not connected */
+	snd_soc_dapm_disable_pin(codec, "RLINEIN");
+	snd_soc_dapm_disable_pin(codec, "LLINEIN");
+
+	/* always connected */
+	snd_soc_dapm_enable_pin(codec, "Int Mic");
+	snd_soc_dapm_enable_pin(codec, "Ext Spk");
+
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+static struct snd_soc_dai_link at91sam9g20ek_dai = {
+	.name = "WM8731",
+	.stream_name = "WM8731 PCM",
+	.cpu_dai = &atmel_ssc_dai[0],
+	.codec_dai = &wm8731_dai,
+	.init = at91sam9g20ek_wm8731_init,
+	.ops = &at91sam9g20ek_ops,
+};
+
+static struct snd_soc_machine snd_soc_machine_at91sam9g20ek = {
+	.name = "WM8731",
+	.dai_link = &at91sam9g20ek_dai,
+	.num_links = 1,
+};
+
+static struct wm8731_setup_data at91sam9g20ek_wm8731_setup = {
+	.i2c_bus = 0,
+	.i2c_address = 0x1b,
+};
+
+static struct snd_soc_device at91sam9g20ek_snd_devdata = {
+	.machine = &snd_soc_machine_at91sam9g20ek,
+	.platform = &atmel_soc_platform,
+	.codec_dev = &soc_codec_dev_wm8731,
+	.codec_data = &at91sam9g20ek_wm8731_setup,
+};
+
+static struct platform_device *at91sam9g20ek_snd_device;
+
+static int __init at91sam9g20ek_init(void)
+{
+	struct atmel_ssc_info *ssc_p = at91sam9g20ek_dai.cpu_dai->private_data;
+	struct ssc_device *ssc = NULL;
+	int ret;
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
+	at91sam9g20ek_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!at91sam9g20ek_snd_device) {
+		printk(KERN_DEBUG
+				"platform device allocation failed\n");
+		ret = -ENOMEM;
+	}
+
+	platform_set_drvdata(at91sam9g20ek_snd_device,
+			&at91sam9g20ek_snd_devdata);
+	at91sam9g20ek_snd_devdata.dev = &at91sam9g20ek_snd_device->dev;
+
+	ret = platform_device_add(at91sam9g20ek_snd_device);
+	if (ret) {
+		printk(KERN_DEBUG
+				"platform device allocation failed\n");
+		platform_device_put(at91sam9g20ek_snd_device);
+	}
+
+	return ret;
+
+err_ssc:
+	return ret;
+}
+
+static void __exit at91sam9g20ek_exit(void)
+{
+	struct atmel_ssc_info *ssc_p = at91sam9g20ek_dai.cpu_dai->private_data;
+	struct ssc_device *ssc;
+
+	if (ssc_p != NULL) {
+		ssc = ssc_p->ssc;
+		if (ssc != NULL)
+			ssc_free(ssc);
+		ssc_p->ssc = NULL;
+	}
+
+	platform_device_unregister(at91sam9g20ek_snd_device);
+	at91sam9g20ek_snd_device = NULL;
+}
+
+module_init(at91sam9g20ek_init);
+module_exit(at91sam9g20ek_exit);
+
+/* Module information */
+MODULE_AUTHOR("Sedji Gaouaou <sedji.gaouaou@atmel.com>");
+MODULE_DESCRIPTION("ALSA SoC AT91SAM9G20EK_WM8731");
+MODULE_LICENSE("GPL");
-- 
1.5.3.7


--------------030900070503000803070901
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------030900070503000803070901--
