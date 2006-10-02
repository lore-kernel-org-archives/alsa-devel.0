From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: [PATCH 1/4] ASoC AT91RM92000 audio DMA
Date: Mon, 02 Oct 2006 17:17:02 +0100
Message-ID: <1159805822.2382.117.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-V2G+EVDhQCPc34scZzVn"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-V2G+EVDhQCPc34scZzVn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds ASoC audio DMA support to the Atmel AT91RM9200 CPU.

Features:-

 o Playback/Capture supported.
 o 16 Bit data size.

Signed-off-by: Frank Mandarino <fmandarino@endrelia.com>
Signed-off-by: Liam Girdwood <liam.girdwood@wolfsonmicro.com>

--=-V2G+EVDhQCPc34scZzVn
Content-Disposition: attachment; filename=asoc-at91-dma.patch
Content-Type: text/x-patch; name=asoc-at91-dma.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: alsa-kernel/soc/at91/at91rm9200-pcm.c
===================================================================
--- /dev/null
+++ alsa-kernel/soc/at91/at91rm9200-pcm.c
@@ -0,0 +1,428 @@
+/*
+ * at91rm9200-pcm.c -- ALSA PCM interface for the Atmel AT91RM9200 chip.
+ *
+ * Author:	Frank Mandarino <fmandarino@endrelia.com>
+ *		Endrelia Technologies Inc.
+ * Created:	Mar 3, 2006
+ *
+ * Based on pxa2xx-pcm.c by:
+ *
+ * Author:	Nicolas Pitre
+ * Created:	Nov 30, 2004
+ * Copyright:	(C) 2004 MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include <asm/arch/at91rm9200.h>
+#include <asm/arch/at91rm9200_ssc.h>
+#include <asm/arch/at91rm9200_pdc.h>
+#include <asm/arch/hardware.h>
+
+#include "at91rm9200-pcm.h"
+
+#if 0
+#define	DBG(x...)	printk(KERN_INFO "at91rm9200-pcm: " x)
+#else
+#define	DBG(x...)
+#endif
+
+static const snd_pcm_hardware_t at91rm9200_pcm_hardware = {
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
+struct at91rm9200_runtime_data {
+	at91rm9200_pcm_dma_params_t *params;
+	dma_addr_t dma_buffer;			/* physical address of dma buffer */
+	dma_addr_t dma_buffer_end;		/* first address beyond DMA buffer */
+	size_t period_size;
+	dma_addr_t period_ptr;			/* physical address of next period */
+	u32 pdc_xpr_save;			/* PDC register save */
+	u32 pdc_xcr_save;
+	u32 pdc_xnpr_save;
+	u32 pdc_xncr_save;
+};
+
+static void at91rm9200_pcm_dma_irq(u32 ssc_sr,
+	struct snd_pcm_substream *substream)
+{
+	struct at91rm9200_runtime_data *prtd = substream->runtime->private_data;
+	at91rm9200_pcm_dma_params_t *params = prtd->params;
+	static int count = 0;
+
+	count++;
+
+	if (ssc_sr & params->mask->ssc_endbuf) {
+
+		printk(KERN_WARNING
+			"at91rm9200-pcm: buffer %s on %s (SSC_SR=%#x, count=%d)\n",
+			substream->stream == SNDRV_PCM_STREAM_PLAYBACK
+				? "underrun" : "overrun",
+			params->name, ssc_sr, count);
+
+		/* re-start the PDC */
+		at91_ssc_write(params->pdc->ptcr, params->mask->pdc_disable);
+
+		prtd->period_ptr += prtd->period_size;
+		if (prtd->period_ptr >= prtd->dma_buffer_end) {
+			prtd->period_ptr = prtd->dma_buffer;
+		}
+
+		at91_ssc_write(params->pdc->xpr, prtd->period_ptr);
+		at91_ssc_write(params->pdc->xcr,
+				prtd->period_size / params->pdc_xfer_size);
+
+		at91_ssc_write(params->pdc->ptcr, params->mask->pdc_enable);
+	}
+
+	if (ssc_sr & params->mask->ssc_endx) {
+
+		/* Load the PDC next pointer and counter registers */
+		prtd->period_ptr += prtd->period_size;
+		if (prtd->period_ptr >= prtd->dma_buffer_end) {
+			prtd->period_ptr = prtd->dma_buffer;
+		}
+		at91_ssc_write(params->pdc->xnpr, prtd->period_ptr);
+		at91_ssc_write(params->pdc->xncr,
+				prtd->period_size / params->pdc_xfer_size);
+	}
+
+	snd_pcm_period_elapsed(substream);
+}
+
+static int at91rm9200_pcm_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	struct at91rm9200_runtime_data *prtd = runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+
+	/* this may get called several times by oss emulation
+	 * with different params */
+
+	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+	runtime->dma_bytes = params_buffer_bytes(params);
+
+	prtd->params = rtd->cpu_dai->dma_data;
+	prtd->params->dma_intr_handler = at91rm9200_pcm_dma_irq;
+
+	prtd->dma_buffer = runtime->dma_addr;
+	prtd->dma_buffer_end = runtime->dma_addr + runtime->dma_bytes;
+	prtd->period_size = params_period_bytes(params);
+
+	DBG("hw_params: DMA for %s initialized (dma_bytes=%d, period_size=%d)\n",
+		prtd->params->name, runtime->dma_bytes, prtd->period_size);
+	return 0;
+}
+
+static int at91rm9200_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	struct at91rm9200_runtime_data *prtd = substream->runtime->private_data;
+	at91rm9200_pcm_dma_params_t *params = prtd->params;
+
+	if (params != NULL) {
+		at91_ssc_write(params->pdc->ptcr, params->mask->pdc_disable);
+		prtd->params->dma_intr_handler = NULL;
+	}
+
+	return 0;
+}
+
+static int at91rm9200_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct at91rm9200_runtime_data *prtd = substream->runtime->private_data;
+	at91rm9200_pcm_dma_params_t *params = prtd->params;
+
+	at91_ssc_write(params->ssc->idr,
+			params->mask->ssc_endx | params->mask->ssc_endbuf);
+
+	at91_ssc_write(params->pdc->ptcr, params->mask->pdc_disable);
+	return 0;
+}
+
+static int at91rm9200_pcm_trigger(struct snd_pcm_substream *substream,
+	int cmd)
+{
+	struct at91rm9200_runtime_data *prtd = substream->runtime->private_data;
+	at91rm9200_pcm_dma_params_t *params = prtd->params;
+	int ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		prtd->period_ptr = prtd->dma_buffer;
+
+		at91_ssc_write(params->pdc->xpr, prtd->period_ptr);
+		at91_ssc_write(params->pdc->xcr,
+				prtd->period_size / params->pdc_xfer_size);
+
+		prtd->period_ptr += prtd->period_size;
+		at91_ssc_write(params->pdc->xnpr, prtd->period_ptr);
+		at91_ssc_write(params->pdc->xncr,
+				prtd->period_size / params->pdc_xfer_size);
+
+		DBG("trigger: period_ptr=%lx, xpr=%lx, xcr=%ld, xnpr=%lx, xncr=%ld\n",
+			(unsigned long) prtd->period_ptr,
+			at91_ssc_read(params->pdc->xpr),
+			at91_ssc_read(params->pdc->xcr),
+			at91_ssc_read(params->pdc->xnpr),
+			at91_ssc_read(params->pdc->xncr));
+
+		at91_ssc_write(params->ssc->ier,
+			params->mask->ssc_endx | params->mask->ssc_endbuf);
+
+		at91_ssc_write(params->pdc->ptcr, params->mask->pdc_enable);
+
+		DBG("sr=%lx imr=%lx\n", at91_ssc_read(params->ssc->ier - 4),
+					at91_ssc_read(params->ssc->ier + 8));
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		at91_ssc_write(params->pdc->ptcr, params->mask->pdc_disable);
+		break;
+
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		at91_ssc_write(params->pdc->ptcr, params->mask->pdc_enable);
+		break;
+
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static snd_pcm_uframes_t at91rm9200_pcm_pointer(
+	struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct at91rm9200_runtime_data *prtd = runtime->private_data;
+	at91rm9200_pcm_dma_params_t *params = prtd->params;
+	dma_addr_t ptr;
+	snd_pcm_uframes_t x;
+
+	ptr = (dma_addr_t) at91_ssc_read(params->pdc->xpr);
+	x = bytes_to_frames(runtime, ptr - prtd->dma_buffer);
+
+	if (x == runtime->buffer_size)
+		x = 0;
+	return x;
+}
+
+static int at91rm9200_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct at91rm9200_runtime_data *prtd;
+	int ret = 0;
+
+	snd_soc_set_runtime_hwparams(substream, &at91rm9200_pcm_hardware);
+
+	/* ensure that buffer size is a multiple of period size */
+	ret = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0)
+		goto out;
+
+	prtd = kzalloc(sizeof(struct at91rm9200_runtime_data), GFP_KERNEL);
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
+static int at91rm9200_pcm_close(struct snd_pcm_substream *substream)
+{
+	struct at91rm9200_runtime_data *prtd = substream->runtime->private_data;
+
+	kfree(prtd);
+	return 0;
+}
+
+static int at91rm9200_pcm_mmap(struct snd_pcm_substream *substream,
+	struct vm_area_struct *vma)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	return dma_mmap_writecombine(substream->pcm->card->dev, vma,
+				     runtime->dma_area,
+				     runtime->dma_addr,
+				     runtime->dma_bytes);
+}
+
+struct snd_pcm_ops at91rm9200_pcm_ops = {
+	.open		= at91rm9200_pcm_open,
+	.close		= at91rm9200_pcm_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= at91rm9200_pcm_hw_params,
+	.hw_free	= at91rm9200_pcm_hw_free,
+	.prepare	= at91rm9200_pcm_prepare,
+	.trigger	= at91rm9200_pcm_trigger,
+	.pointer	= at91rm9200_pcm_pointer,
+	.mmap		= at91rm9200_pcm_mmap,
+};
+
+static int at91rm9200_pcm_preallocate_dma_buffer(struct snd_pcm *pcm,
+	int stream)
+{
+	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+	size_t size = at91rm9200_pcm_hardware.buffer_bytes_max;
+
+	buf->dev.type = SNDRV_DMA_TYPE_DEV;
+	buf->dev.dev = pcm->card->dev;
+	buf->private_data = NULL;
+	buf->area = dma_alloc_writecombine(pcm->card->dev, size,
+					   &buf->addr, GFP_KERNEL);
+
+	DBG("preallocate_dma_buffer: area=%p, addr=%p, size=%d\n",
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
+
+static u64 at91rm9200_pcm_dmamask = 0xffffffff;
+
+static int at91rm9200_pcm_new(struct snd_card *card,
+	struct snd_soc_codec_dai *dai, struct snd_pcm *pcm)
+{
+	int ret = 0;
+
+	if (!card->dev->dma_mask)
+		card->dev->dma_mask = &at91rm9200_pcm_dmamask;
+	if (!card->dev->coherent_dma_mask)
+		card->dev->coherent_dma_mask = 0xffffffff;
+
+	if (dai->playback.channels_min) {
+		ret = at91rm9200_pcm_preallocate_dma_buffer(pcm,
+			SNDRV_PCM_STREAM_PLAYBACK);
+		if (ret)
+			goto out;
+	}
+
+	if (dai->capture.channels_min) {
+		ret = at91rm9200_pcm_preallocate_dma_buffer(pcm,
+			SNDRV_PCM_STREAM_CAPTURE);
+		if (ret)
+			goto out;
+	}
+ out:
+	return ret;
+}
+
+static void at91rm9200_pcm_free_dma_buffers(struct snd_pcm *pcm)
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
+
+		dma_free_writecombine(pcm->card->dev, buf->bytes,
+				      buf->area, buf->addr);
+		buf->area = NULL;
+	}
+}
+
+static int at91rm9200_pcm_suspend(struct platform_device *pdev,
+	struct snd_soc_cpu_dai *dai)
+{
+	struct snd_pcm_runtime *runtime = dai->runtime;
+	struct at91rm9200_runtime_data *prtd;
+	at91rm9200_pcm_dma_params_t *params;
+
+	if (!runtime)
+		return 0;
+
+	prtd = runtime->private_data;
+	params = prtd->params;
+
+	/* disable the PDC and save the PDC registers */
+
+	at91_ssc_write(params->pdc->ptcr, params->mask->pdc_disable);
+
+	prtd->pdc_xpr_save  = at91_ssc_read(params->pdc->xpr);
+	prtd->pdc_xcr_save  = at91_ssc_read(params->pdc->xcr);
+	prtd->pdc_xnpr_save = at91_ssc_read(params->pdc->xnpr);
+	prtd->pdc_xncr_save = at91_ssc_read(params->pdc->xncr);
+
+	return 0;
+}
+
+static int at91rm9200_pcm_resume(struct platform_device *pdev,
+	struct snd_soc_cpu_dai *dai)
+{
+	struct snd_pcm_runtime *runtime = dai->runtime;
+	struct at91rm9200_runtime_data *prtd;
+	at91rm9200_pcm_dma_params_t *params;
+
+	if (!runtime)
+		return 0;
+
+	prtd = runtime->private_data;
+	params = prtd->params;
+
+	/* restore the PDC registers and enable the PDC */
+	at91_ssc_write(params->pdc->xpr,  prtd->pdc_xpr_save);
+	at91_ssc_write(params->pdc->xcr,  prtd->pdc_xcr_save);
+	at91_ssc_write(params->pdc->xnpr, prtd->pdc_xnpr_save);
+	at91_ssc_write(params->pdc->xncr, prtd->pdc_xncr_save);
+
+	at91_ssc_write(params->pdc->ptcr, params->mask->pdc_enable);
+	return 0;
+}
+
+struct snd_soc_platform at91rm9200_soc_platform = {
+	.name		= "at91rm9200-audio",
+	.pcm_ops 	= &at91rm9200_pcm_ops,
+	.pcm_new	= at91rm9200_pcm_new,
+	.pcm_free	= at91rm9200_pcm_free_dma_buffers,
+	.suspend	= at91rm9200_pcm_suspend,
+	.resume		= at91rm9200_pcm_resume,
+};
+
+EXPORT_SYMBOL_GPL(at91rm9200_soc_platform);
+
+MODULE_AUTHOR("Frank Mandarino <fmandarino@endrelia.com>");
+MODULE_DESCRIPTION("Atmel AT91RM9200 PCM module");
+MODULE_LICENSE("GPL");
Index: alsa-kernel/soc/at91/at91rm9200-pcm.h
===================================================================
--- /dev/null
+++ alsa-kernel/soc/at91/at91rm9200-pcm.h
@@ -0,0 +1,75 @@
+/*
+ * at91rm9200-pcm.h - ALSA PCM interface for the Atmel AT91RM9200 chip
+ *
+ * Author:	Frank Mandarino <fmandarino@endrelia.com>
+ *		Endrelia Technologies Inc.
+ * Created:	Mar 3, 2006
+ *
+ * Based on pxa2xx-pcm.h by:
+ *
+ * Author:	Nicolas Pitre
+ * Created:	Nov 30, 2004
+ * Copyright:	MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Registers and status bits that are required by the PCM driver.
+ */
+struct at91rm9200_ssc_regs {
+	void __iomem 	*cr;		/* SSC control */
+	void __iomem	*ier;		/* SSC interrupt enable */
+	void __iomem	*idr;		/* SSC interrupt disable */
+};
+
+struct at91rm9200_pdc_regs {
+	void __iomem	*xpr;		/* PDC recv/trans pointer */
+	void __iomem	*xcr;		/* PDC recv/trans counter */
+	void __iomem	*xnpr;		/* PDC next recv/trans pointer */
+	void __iomem	*xncr;		/* PDC next recv/trans counter */
+	void __iomem	*ptcr;		/* PDC transfer control */
+};
+
+struct at91rm9200_ssc_mask {
+	u32	ssc_enable;		/* SSC recv/trans enable */
+	u32	ssc_disable;		/* SSC recv/trans disable */
+	u32	ssc_endx;		/* SSC ENDTX or ENDRX */
+	u32	ssc_endbuf;		/* SSC TXBUFE or RXBUFF */
+	u32	pdc_enable;		/* PDC recv/trans enable */
+	u32	pdc_disable;		/* PDC recv/trans disable */
+};
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
+typedef struct {
+	char *name;			/* stream identifier */
+	int pdc_xfer_size;		/* PDC counter increment in bytes */
+	struct at91rm9200_ssc_regs *ssc; /* SSC register addresses */
+	struct at91rm9200_pdc_regs *pdc; /* PDC receive/transmit registers */
+	struct at91rm9200_ssc_mask *mask;/* SSC & PDC status bits */
+	snd_pcm_substream_t *substream;
+	void (*dma_intr_handler)(u32, snd_pcm_substream_t *);
+} at91rm9200_pcm_dma_params_t;
+
+extern struct snd_soc_cpu_dai at91rm9200_i2s_dai[3];
+extern struct snd_soc_platform at91rm9200_soc_platform;
+
+
+/*
+ * SSC I/O helpers.
+ * E.g., at91_ssc_write(AT91_SSC(1) + AT91_SSC_CR, AT91_SSC_RXEN);
+ */
+#define AT91_SSC(x) (((x)==0) ? AT91_VA_BASE_SSC0 :\
+	 ((x)==1) ? AT91_VA_BASE_SSC1 : ((x)==2) ? AT91_VA_BASE_SSC2 : NULL)
+#define at91_ssc_read(a)	((unsigned long) __raw_readl(a))
+#define at91_ssc_write(a,v)	__raw_writel((v),(a))

--=-V2G+EVDhQCPc34scZzVn
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-V2G+EVDhQCPc34scZzVn
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-V2G+EVDhQCPc34scZzVn--
