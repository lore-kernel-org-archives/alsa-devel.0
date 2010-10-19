From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 05/25] ASoC: Samsung: Rename ASoC DMA driver
Date: Tue, 19 Oct 2010 16:05:47 +0900
Message-ID: <1287471947-27632-1-git-send-email-jassisinghbrar@gmail.com>
References: <1P85Z9-0007a6-27>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 00856103929
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 09:12:35 +0200 (CEST)
In-Reply-To: <1P85Z9-0007a6-27>
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
Cc: kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, broonie@opensource.wolfsonmicro.com, ben-linux@fluff.org, june.bae@samsung.com, lrg@slimlogic.co.uk, sw.youn@samsung.com
List-Id: alsa-devel@alsa-project.org

From: Jassi Brar <jassi.brar@samsung.com>

Rename Samsung ASoC DMA driver
	s3c-dma.[c/h] -> dma.[c/h]

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/Makefile                     |    2 +-
 sound/soc/s3c24xx/dma.c                        |  503 ++++++++++++++++++++++++
 sound/soc/s3c24xx/dma.h                        |   30 ++
 sound/soc/s3c24xx/goni_wm8994.c                |    2 +-
 sound/soc/s3c24xx/jive_wm8750.c                |    2 +-
 sound/soc/s3c24xx/ln2440sbc_alc650.c           |    2 +-
 sound/soc/s3c24xx/neo1973_gta02_wm8753.c       |    2 +-
 sound/soc/s3c24xx/neo1973_wm8753.c             |    2 +-
 sound/soc/s3c24xx/rx1950_uda1380.c             |    2 +-
 sound/soc/s3c24xx/s3c-ac97.c                   |    2 +-
 sound/soc/s3c24xx/s3c-dma.c                    |  503 ------------------------
 sound/soc/s3c24xx/s3c-dma.h                    |   30 --
 sound/soc/s3c24xx/s3c-i2s-v2.c                 |    2 +-
 sound/soc/s3c24xx/s3c-pcm.c                    |    2 +-
 sound/soc/s3c24xx/s3c2412-i2s.c                |    2 +-
 sound/soc/s3c24xx/s3c24xx-i2s.c                |    2 +-
 sound/soc/s3c24xx/s3c24xx_simtec.c             |    2 +-
 sound/soc/s3c24xx/s3c24xx_simtec_hermes.c      |    2 +-
 sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c |    2 +-
 sound/soc/s3c24xx/s3c24xx_uda134x.c            |    2 +-
 sound/soc/s3c24xx/s3c64xx-i2s-v4.c             |    2 +-
 sound/soc/s3c24xx/s3c64xx-i2s.c                |    2 +-
 sound/soc/s3c24xx/smartq_wm8987.c              |    2 +-
 sound/soc/s3c24xx/smdk2443_wm9710.c            |    2 +-
 sound/soc/s3c24xx/smdk64xx_wm8580.c            |    2 +-
 sound/soc/s3c24xx/smdk_spdif.c                 |    2 +-
 sound/soc/s3c24xx/smdk_wm9713.c                |    2 +-
 sound/soc/s3c24xx/spdif.c                      |    2 +-
 28 files changed, 557 insertions(+), 557 deletions(-)
 create mode 100644 sound/soc/s3c24xx/dma.c
 create mode 100644 sound/soc/s3c24xx/dma.h
 delete mode 100644 sound/soc/s3c24xx/s3c-dma.c
 delete mode 100644 sound/soc/s3c24xx/s3c-dma.h

diff --git a/sound/soc/s3c24xx/Makefile b/sound/soc/s3c24xx/Makefile
index 4e232f1..20aac45 100644
--- a/sound/soc/s3c24xx/Makefile
+++ b/sound/soc/s3c24xx/Makefile
@@ -1,5 +1,5 @@
 # S3c24XX Platform Support
-snd-soc-s3c24xx-objs := s3c-dma.o
+snd-soc-s3c24xx-objs := dma.o
 snd-soc-s3c24xx-i2s-objs := s3c24xx-i2s.o
 snd-soc-s3c2412-i2s-objs := s3c2412-i2s.o
 snd-soc-s3c64xx-i2s-objs := s3c64xx-i2s.o
diff --git a/sound/soc/s3c24xx/dma.c b/sound/soc/s3c24xx/dma.c
new file mode 100644
index 0000000..b4c7c85
--- /dev/null
+++ b/sound/soc/s3c24xx/dma.c
@@ -0,0 +1,503 @@
+/*
+ * dma.c  --  ALSA Soc Audio Layer
+ *
+ * (c) 2006 Wolfson Microelectronics PLC.
+ * Graeme Gregory graeme.gregory@wolfsonmicro.com or linux@wolfsonmicro.com
+ *
+ * Copyright 2004-2005 Simtec Electronics
+ *	http://armlinux.simtec.co.uk/
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include <asm/dma.h>
+#include <mach/hardware.h>
+#include <mach/dma.h>
+
+#include "dma.h"
+
+static const struct snd_pcm_hardware s3c_dma_hardware = {
+	.info			= SNDRV_PCM_INFO_INTERLEAVED |
+				    SNDRV_PCM_INFO_BLOCK_TRANSFER |
+				    SNDRV_PCM_INFO_MMAP |
+				    SNDRV_PCM_INFO_MMAP_VALID |
+				    SNDRV_PCM_INFO_PAUSE |
+				    SNDRV_PCM_INFO_RESUME,
+	.formats		= SNDRV_PCM_FMTBIT_S16_LE |
+				    SNDRV_PCM_FMTBIT_U16_LE |
+				    SNDRV_PCM_FMTBIT_U8 |
+				    SNDRV_PCM_FMTBIT_S8,
+	.channels_min		= 2,
+	.channels_max		= 2,
+	.buffer_bytes_max	= 128*1024,
+	.period_bytes_min	= PAGE_SIZE,
+	.period_bytes_max	= PAGE_SIZE*2,
+	.periods_min		= 2,
+	.periods_max		= 128,
+	.fifo_size		= 32,
+};
+
+struct s3c24xx_runtime_data {
+	spinlock_t lock;
+	int state;
+	unsigned int dma_loaded;
+	unsigned int dma_limit;
+	unsigned int dma_period;
+	dma_addr_t dma_start;
+	dma_addr_t dma_pos;
+	dma_addr_t dma_end;
+	struct s3c_dma_params *params;
+};
+
+/* s3c_dma_enqueue
+ *
+ * place a dma buffer onto the queue for the dma system
+ * to handle.
+*/
+static void s3c_dma_enqueue(struct snd_pcm_substream *substream)
+{
+	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
+	dma_addr_t pos = prtd->dma_pos;
+	unsigned int limit;
+	int ret;
+
+	pr_debug("Entered %s\n", __func__);
+
+	if (s3c_dma_has_circular())
+		limit = (prtd->dma_end - prtd->dma_start) / prtd->dma_period;
+	else
+		limit = prtd->dma_limit;
+
+	pr_debug("%s: loaded %d, limit %d\n",
+				__func__, prtd->dma_loaded, limit);
+
+	while (prtd->dma_loaded < limit) {
+		unsigned long len = prtd->dma_period;
+
+		pr_debug("dma_loaded: %d\n", prtd->dma_loaded);
+
+		if ((pos + len) > prtd->dma_end) {
+			len  = prtd->dma_end - pos;
+			pr_debug(KERN_DEBUG "%s: corrected dma len %ld\n",
+			       __func__, len);
+		}
+
+		ret = s3c2410_dma_enqueue(prtd->params->channel,
+			substream, pos, len);
+
+		if (ret == 0) {
+			prtd->dma_loaded++;
+			pos += prtd->dma_period;
+			if (pos >= prtd->dma_end)
+				pos = prtd->dma_start;
+		} else
+			break;
+	}
+
+	prtd->dma_pos = pos;
+}
+
+static void s3c24xx_audio_buffdone(struct s3c2410_dma_chan *channel,
+				void *dev_id, int size,
+				enum s3c2410_dma_buffresult result)
+{
+	struct snd_pcm_substream *substream = dev_id;
+	struct s3c24xx_runtime_data *prtd;
+
+	pr_debug("Entered %s\n", __func__);
+
+	if (result == S3C2410_RES_ABORT || result == S3C2410_RES_ERR)
+		return;
+
+	prtd = substream->runtime->private_data;
+
+	if (substream)
+		snd_pcm_period_elapsed(substream);
+
+	spin_lock(&prtd->lock);
+	if (prtd->state & ST_RUNNING && !s3c_dma_has_circular()) {
+		prtd->dma_loaded--;
+		s3c_dma_enqueue(substream);
+	}
+
+	spin_unlock(&prtd->lock);
+}
+
+static int s3c_dma_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct s3c24xx_runtime_data *prtd = runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	unsigned long totbytes = params_buffer_bytes(params);
+	struct s3c_dma_params *dma =
+		snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
+	int ret = 0;
+
+
+	pr_debug("Entered %s\n", __func__);
+
+	/* return if this is a bufferless transfer e.g.
+	 * codec <--> BT codec or GSM modem -- lg FIXME */
+	if (!dma)
+		return 0;
+
+	/* this may get called several times by oss emulation
+	 * with different params -HW */
+	if (prtd->params == NULL) {
+		/* prepare DMA */
+		prtd->params = dma;
+
+		pr_debug("params %p, client %p, channel %d\n", prtd->params,
+			prtd->params->client, prtd->params->channel);
+
+		ret = s3c2410_dma_request(prtd->params->channel,
+					  prtd->params->client, NULL);
+
+		if (ret < 0) {
+			printk(KERN_ERR "failed to get dma channel\n");
+			return ret;
+		}
+
+		/* use the circular buffering if we have it available. */
+		if (s3c_dma_has_circular())
+			s3c2410_dma_setflags(prtd->params->channel,
+					     S3C2410_DMAF_CIRCULAR);
+	}
+
+	s3c2410_dma_set_buffdone_fn(prtd->params->channel,
+				    s3c24xx_audio_buffdone);
+
+	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+
+	runtime->dma_bytes = totbytes;
+
+	spin_lock_irq(&prtd->lock);
+	prtd->dma_loaded = 0;
+	prtd->dma_limit = runtime->hw.periods_min;
+	prtd->dma_period = params_period_bytes(params);
+	prtd->dma_start = runtime->dma_addr;
+	prtd->dma_pos = prtd->dma_start;
+	prtd->dma_end = prtd->dma_start + totbytes;
+	spin_unlock_irq(&prtd->lock);
+
+	return 0;
+}
+
+static int s3c_dma_hw_free(struct snd_pcm_substream *substream)
+{
+	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
+
+	pr_debug("Entered %s\n", __func__);
+
+	/* TODO - do we need to ensure DMA flushed */
+	snd_pcm_set_runtime_buffer(substream, NULL);
+
+	if (prtd->params) {
+		s3c2410_dma_free(prtd->params->channel, prtd->params->client);
+		prtd->params = NULL;
+	}
+
+	return 0;
+}
+
+static int s3c_dma_prepare(struct snd_pcm_substream *substream)
+{
+	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
+	int ret = 0;
+
+	pr_debug("Entered %s\n", __func__);
+
+	/* return if this is a bufferless transfer e.g.
+	 * codec <--> BT codec or GSM modem -- lg FIXME */
+	if (!prtd->params)
+		return 0;
+
+	/* channel needs configuring for mem=>device, increment memory addr,
+	 * sync to pclk, half-word transfers to the IIS-FIFO. */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		s3c2410_dma_devconfig(prtd->params->channel,
+				      S3C2410_DMASRC_MEM,
+				      prtd->params->dma_addr);
+	} else {
+		s3c2410_dma_devconfig(prtd->params->channel,
+				      S3C2410_DMASRC_HW,
+				      prtd->params->dma_addr);
+	}
+
+	s3c2410_dma_config(prtd->params->channel,
+			   prtd->params->dma_size);
+
+	/* flush the DMA channel */
+	s3c2410_dma_ctrl(prtd->params->channel, S3C2410_DMAOP_FLUSH);
+	prtd->dma_loaded = 0;
+	prtd->dma_pos = prtd->dma_start;
+
+	/* enqueue dma buffers */
+	s3c_dma_enqueue(substream);
+
+	return ret;
+}
+
+static int s3c_dma_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
+	int ret = 0;
+
+	pr_debug("Entered %s\n", __func__);
+
+	spin_lock(&prtd->lock);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		prtd->state |= ST_RUNNING;
+		s3c2410_dma_ctrl(prtd->params->channel, S3C2410_DMAOP_START);
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		prtd->state &= ~ST_RUNNING;
+		s3c2410_dma_ctrl(prtd->params->channel, S3C2410_DMAOP_STOP);
+		break;
+
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	spin_unlock(&prtd->lock);
+
+	return ret;
+}
+
+static snd_pcm_uframes_t
+s3c_dma_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct s3c24xx_runtime_data *prtd = runtime->private_data;
+	unsigned long res;
+	dma_addr_t src, dst;
+
+	pr_debug("Entered %s\n", __func__);
+
+	spin_lock(&prtd->lock);
+	s3c2410_dma_getposition(prtd->params->channel, &src, &dst);
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		res = dst - prtd->dma_start;
+	else
+		res = src - prtd->dma_start;
+
+	spin_unlock(&prtd->lock);
+
+	pr_debug("Pointer %x %x\n", src, dst);
+
+	/* we seem to be getting the odd error from the pcm library due
+	 * to out-of-bounds pointers. this is maybe due to the dma engine
+	 * not having loaded the new values for the channel before being
+	 * callled... (todo - fix )
+	 */
+
+	if (res >= snd_pcm_lib_buffer_bytes(substream)) {
+		if (res == snd_pcm_lib_buffer_bytes(substream))
+			res = 0;
+	}
+
+	return bytes_to_frames(substream->runtime, res);
+}
+
+static int s3c_dma_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct s3c24xx_runtime_data *prtd;
+
+	pr_debug("Entered %s\n", __func__);
+
+	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
+	snd_soc_set_runtime_hwparams(substream, &s3c_dma_hardware);
+
+	prtd = kzalloc(sizeof(struct s3c24xx_runtime_data), GFP_KERNEL);
+	if (prtd == NULL)
+		return -ENOMEM;
+
+	spin_lock_init(&prtd->lock);
+
+	runtime->private_data = prtd;
+	return 0;
+}
+
+static int s3c_dma_close(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct s3c24xx_runtime_data *prtd = runtime->private_data;
+
+	pr_debug("Entered %s\n", __func__);
+
+	if (!prtd)
+		pr_debug("s3c_dma_close called with prtd == NULL\n");
+
+	kfree(prtd);
+
+	return 0;
+}
+
+static int s3c_dma_mmap(struct snd_pcm_substream *substream,
+	struct vm_area_struct *vma)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	pr_debug("Entered %s\n", __func__);
+
+	return dma_mmap_writecombine(substream->pcm->card->dev, vma,
+				     runtime->dma_area,
+				     runtime->dma_addr,
+				     runtime->dma_bytes);
+}
+
+static struct snd_pcm_ops s3c_dma_ops = {
+	.open		= s3c_dma_open,
+	.close		= s3c_dma_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= s3c_dma_hw_params,
+	.hw_free	= s3c_dma_hw_free,
+	.prepare	= s3c_dma_prepare,
+	.trigger	= s3c_dma_trigger,
+	.pointer	= s3c_dma_pointer,
+	.mmap		= s3c_dma_mmap,
+};
+
+static int s3c_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
+{
+	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+	size_t size = s3c_dma_hardware.buffer_bytes_max;
+
+	pr_debug("Entered %s\n", __func__);
+
+	buf->dev.type = SNDRV_DMA_TYPE_DEV;
+	buf->dev.dev = pcm->card->dev;
+	buf->private_data = NULL;
+	buf->area = dma_alloc_writecombine(pcm->card->dev, size,
+					   &buf->addr, GFP_KERNEL);
+	if (!buf->area)
+		return -ENOMEM;
+	buf->bytes = size;
+	return 0;
+}
+
+static void s3c_dma_free_dma_buffers(struct snd_pcm *pcm)
+{
+	struct snd_pcm_substream *substream;
+	struct snd_dma_buffer *buf;
+	int stream;
+
+	pr_debug("Entered %s\n", __func__);
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
+static u64 s3c_dma_mask = DMA_BIT_MASK(32);
+
+static int s3c_dma_new(struct snd_card *card,
+	struct snd_soc_dai *dai, struct snd_pcm *pcm)
+{
+	int ret = 0;
+
+	pr_debug("Entered %s\n", __func__);
+
+	if (!card->dev->dma_mask)
+		card->dev->dma_mask = &s3c_dma_mask;
+	if (!card->dev->coherent_dma_mask)
+		card->dev->coherent_dma_mask = 0xffffffff;
+
+	if (dai->driver->playback.channels_min) {
+		ret = s3c_preallocate_dma_buffer(pcm,
+			SNDRV_PCM_STREAM_PLAYBACK);
+		if (ret)
+			goto out;
+	}
+
+	if (dai->driver->capture.channels_min) {
+		ret = s3c_preallocate_dma_buffer(pcm,
+			SNDRV_PCM_STREAM_CAPTURE);
+		if (ret)
+			goto out;
+	}
+out:
+	return ret;
+}
+
+static struct snd_soc_platform_driver s3c24xx_soc_platform = {
+	.ops		= &s3c_dma_ops,
+	.pcm_new	= s3c_dma_new,
+	.pcm_free	= s3c_dma_free_dma_buffers,
+};
+
+static int __devinit s3c24xx_soc_platform_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_platform(&pdev->dev, &s3c24xx_soc_platform);
+}
+
+static int __devexit s3c24xx_soc_platform_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_platform(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver s3c24xx_pcm_driver = {
+	.driver = {
+		.name = "samsung-audio",
+		.owner = THIS_MODULE,
+	},
+
+	.probe = s3c24xx_soc_platform_probe,
+	.remove = __devexit_p(s3c24xx_soc_platform_remove),
+};
+
+static int __init snd_s3c24xx_pcm_init(void)
+{
+	return platform_driver_register(&s3c24xx_pcm_driver);
+}
+module_init(snd_s3c24xx_pcm_init);
+
+static void __exit snd_s3c24xx_pcm_exit(void)
+{
+	platform_driver_unregister(&s3c24xx_pcm_driver);
+}
+module_exit(snd_s3c24xx_pcm_exit);
+
+MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
+MODULE_DESCRIPTION("Samsung S3C Audio DMA module");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:samsung-audio");
diff --git a/sound/soc/s3c24xx/dma.h b/sound/soc/s3c24xx/dma.h
new file mode 100644
index 0000000..f8cd2b4
--- /dev/null
+++ b/sound/soc/s3c24xx/dma.h
@@ -0,0 +1,30 @@
+/*
+ *  dma.h --
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  ALSA PCM interface for the Samsung S3C24xx CPU
+ */
+
+#ifndef _S3C_AUDIO_H
+#define _S3C_AUDIO_H
+
+#define ST_RUNNING		(1<<0)
+#define ST_OPENED		(1<<1)
+
+struct s3c_dma_params {
+	struct s3c2410_dma_client *client;	/* stream identifier */
+	int channel;				/* Channel ID */
+	dma_addr_t dma_addr;
+	int dma_size;			/* Size of the DMA transfer */
+};
+
+#define S3C24XX_DAI_I2S			0
+
+/* platform data */
+extern struct snd_ac97_bus_ops s3c24xx_ac97_ops;
+
+#endif
diff --git a/sound/soc/s3c24xx/goni_wm8994.c b/sound/soc/s3c24xx/goni_wm8994.c
index c568f69..201056c 100644
--- a/sound/soc/s3c24xx/goni_wm8994.c
+++ b/sound/soc/s3c24xx/goni_wm8994.c
@@ -25,7 +25,7 @@
 #include <linux/mfd/wm8994/core.h>
 #include <linux/mfd/wm8994/registers.h>
 #include "../codecs/wm8994.h"
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c64xx-i2s.h"
 
 #define MACHINE_NAME	0
diff --git a/sound/soc/s3c24xx/jive_wm8750.c b/sound/soc/s3c24xx/jive_wm8750.c
index 7a6b0fa..4e1b8ac 100644
--- a/sound/soc/s3c24xx/jive_wm8750.c
+++ b/sound/soc/s3c24xx/jive_wm8750.c
@@ -25,7 +25,7 @@
 
 #include <asm/mach-types.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c2412-i2s.h"
 
 #include "../codecs/wm8750.h"
diff --git a/sound/soc/s3c24xx/ln2440sbc_alc650.c b/sound/soc/s3c24xx/ln2440sbc_alc650.c
index 6b7bb38..36e7e85 100644
--- a/sound/soc/s3c24xx/ln2440sbc_alc650.c
+++ b/sound/soc/s3c24xx/ln2440sbc_alc650.c
@@ -23,7 +23,7 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c-ac97.h"
 
 static struct snd_soc_card ln2440sbc;
diff --git a/sound/soc/s3c24xx/neo1973_gta02_wm8753.c b/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
index a9a4bbb..c4b2013 100644
--- a/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
@@ -32,7 +32,7 @@
 #include <asm/io.h>
 #include <mach/gta02.h>
 #include "../codecs/wm8753.h"
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c24xx-i2s.h"
 
 static struct snd_soc_card neo1973_gta02;
diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index d5e4148..96dda57 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -36,7 +36,7 @@
 
 #include "../codecs/wm8753.h"
 #include "lm4857.h"
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c24xx-i2s.h"
 
 /* define the scenarios */
diff --git a/sound/soc/s3c24xx/rx1950_uda1380.c b/sound/soc/s3c24xx/rx1950_uda1380.c
index 99bb86e..07197ee 100644
--- a/sound/soc/s3c24xx/rx1950_uda1380.c
+++ b/sound/soc/s3c24xx/rx1950_uda1380.c
@@ -35,7 +35,7 @@
 
 #include <asm/mach-types.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c24xx-i2s.h"
 #include "../codecs/uda1380.h"
 
diff --git a/sound/soc/s3c24xx/s3c-ac97.c b/sound/soc/s3c24xx/s3c-ac97.c
index f891eb7..408f9c9 100644
--- a/sound/soc/s3c24xx/s3c-ac97.c
+++ b/sound/soc/s3c24xx/s3c-ac97.c
@@ -24,7 +24,7 @@
 #include <mach/dma.h>
 #include <plat/audio.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c-ac97.h"
 
 #define AC_CMD_ADDR(x) (x << 16)
diff --git a/sound/soc/s3c24xx/s3c-dma.c b/sound/soc/s3c24xx/s3c-dma.c
deleted file mode 100644
index 0c1cd6c..0000000
--- a/sound/soc/s3c24xx/s3c-dma.c
+++ /dev/null
@@ -1,503 +0,0 @@
-/*
- * s3c-dma.c  --  ALSA Soc Audio Layer
- *
- * (c) 2006 Wolfson Microelectronics PLC.
- * Graeme Gregory graeme.gregory@wolfsonmicro.com or linux@wolfsonmicro.com
- *
- * Copyright 2004-2005 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/dma-mapping.h>
-
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/soc.h>
-
-#include <asm/dma.h>
-#include <mach/hardware.h>
-#include <mach/dma.h>
-
-#include "s3c-dma.h"
-
-static const struct snd_pcm_hardware s3c_dma_hardware = {
-	.info			= SNDRV_PCM_INFO_INTERLEAVED |
-				    SNDRV_PCM_INFO_BLOCK_TRANSFER |
-				    SNDRV_PCM_INFO_MMAP |
-				    SNDRV_PCM_INFO_MMAP_VALID |
-				    SNDRV_PCM_INFO_PAUSE |
-				    SNDRV_PCM_INFO_RESUME,
-	.formats		= SNDRV_PCM_FMTBIT_S16_LE |
-				    SNDRV_PCM_FMTBIT_U16_LE |
-				    SNDRV_PCM_FMTBIT_U8 |
-				    SNDRV_PCM_FMTBIT_S8,
-	.channels_min		= 2,
-	.channels_max		= 2,
-	.buffer_bytes_max	= 128*1024,
-	.period_bytes_min	= PAGE_SIZE,
-	.period_bytes_max	= PAGE_SIZE*2,
-	.periods_min		= 2,
-	.periods_max		= 128,
-	.fifo_size		= 32,
-};
-
-struct s3c24xx_runtime_data {
-	spinlock_t lock;
-	int state;
-	unsigned int dma_loaded;
-	unsigned int dma_limit;
-	unsigned int dma_period;
-	dma_addr_t dma_start;
-	dma_addr_t dma_pos;
-	dma_addr_t dma_end;
-	struct s3c_dma_params *params;
-};
-
-/* s3c_dma_enqueue
- *
- * place a dma buffer onto the queue for the dma system
- * to handle.
-*/
-static void s3c_dma_enqueue(struct snd_pcm_substream *substream)
-{
-	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
-	dma_addr_t pos = prtd->dma_pos;
-	unsigned int limit;
-	int ret;
-
-	pr_debug("Entered %s\n", __func__);
-
-	if (s3c_dma_has_circular())
-		limit = (prtd->dma_end - prtd->dma_start) / prtd->dma_period;
-	else
-		limit = prtd->dma_limit;
-
-	pr_debug("%s: loaded %d, limit %d\n",
-				__func__, prtd->dma_loaded, limit);
-
-	while (prtd->dma_loaded < limit) {
-		unsigned long len = prtd->dma_period;
-
-		pr_debug("dma_loaded: %d\n", prtd->dma_loaded);
-
-		if ((pos + len) > prtd->dma_end) {
-			len  = prtd->dma_end - pos;
-			pr_debug(KERN_DEBUG "%s: corrected dma len %ld\n",
-			       __func__, len);
-		}
-
-		ret = s3c2410_dma_enqueue(prtd->params->channel,
-			substream, pos, len);
-
-		if (ret == 0) {
-			prtd->dma_loaded++;
-			pos += prtd->dma_period;
-			if (pos >= prtd->dma_end)
-				pos = prtd->dma_start;
-		} else
-			break;
-	}
-
-	prtd->dma_pos = pos;
-}
-
-static void s3c24xx_audio_buffdone(struct s3c2410_dma_chan *channel,
-				void *dev_id, int size,
-				enum s3c2410_dma_buffresult result)
-{
-	struct snd_pcm_substream *substream = dev_id;
-	struct s3c24xx_runtime_data *prtd;
-
-	pr_debug("Entered %s\n", __func__);
-
-	if (result == S3C2410_RES_ABORT || result == S3C2410_RES_ERR)
-		return;
-
-	prtd = substream->runtime->private_data;
-
-	if (substream)
-		snd_pcm_period_elapsed(substream);
-
-	spin_lock(&prtd->lock);
-	if (prtd->state & ST_RUNNING && !s3c_dma_has_circular()) {
-		prtd->dma_loaded--;
-		s3c_dma_enqueue(substream);
-	}
-
-	spin_unlock(&prtd->lock);
-}
-
-static int s3c_dma_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct s3c24xx_runtime_data *prtd = runtime->private_data;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	unsigned long totbytes = params_buffer_bytes(params);
-	struct s3c_dma_params *dma =
-		snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-	int ret = 0;
-
-
-	pr_debug("Entered %s\n", __func__);
-
-	/* return if this is a bufferless transfer e.g.
-	 * codec <--> BT codec or GSM modem -- lg FIXME */
-	if (!dma)
-		return 0;
-
-	/* this may get called several times by oss emulation
-	 * with different params -HW */
-	if (prtd->params == NULL) {
-		/* prepare DMA */
-		prtd->params = dma;
-
-		pr_debug("params %p, client %p, channel %d\n", prtd->params,
-			prtd->params->client, prtd->params->channel);
-
-		ret = s3c2410_dma_request(prtd->params->channel,
-					  prtd->params->client, NULL);
-
-		if (ret < 0) {
-			printk(KERN_ERR "failed to get dma channel\n");
-			return ret;
-		}
-
-		/* use the circular buffering if we have it available. */
-		if (s3c_dma_has_circular())
-			s3c2410_dma_setflags(prtd->params->channel,
-					     S3C2410_DMAF_CIRCULAR);
-	}
-
-	s3c2410_dma_set_buffdone_fn(prtd->params->channel,
-				    s3c24xx_audio_buffdone);
-
-	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
-
-	runtime->dma_bytes = totbytes;
-
-	spin_lock_irq(&prtd->lock);
-	prtd->dma_loaded = 0;
-	prtd->dma_limit = runtime->hw.periods_min;
-	prtd->dma_period = params_period_bytes(params);
-	prtd->dma_start = runtime->dma_addr;
-	prtd->dma_pos = prtd->dma_start;
-	prtd->dma_end = prtd->dma_start + totbytes;
-	spin_unlock_irq(&prtd->lock);
-
-	return 0;
-}
-
-static int s3c_dma_hw_free(struct snd_pcm_substream *substream)
-{
-	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
-
-	pr_debug("Entered %s\n", __func__);
-
-	/* TODO - do we need to ensure DMA flushed */
-	snd_pcm_set_runtime_buffer(substream, NULL);
-
-	if (prtd->params) {
-		s3c2410_dma_free(prtd->params->channel, prtd->params->client);
-		prtd->params = NULL;
-	}
-
-	return 0;
-}
-
-static int s3c_dma_prepare(struct snd_pcm_substream *substream)
-{
-	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
-	int ret = 0;
-
-	pr_debug("Entered %s\n", __func__);
-
-	/* return if this is a bufferless transfer e.g.
-	 * codec <--> BT codec or GSM modem -- lg FIXME */
-	if (!prtd->params)
-		return 0;
-
-	/* channel needs configuring for mem=>device, increment memory addr,
-	 * sync to pclk, half-word transfers to the IIS-FIFO. */
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		s3c2410_dma_devconfig(prtd->params->channel,
-				      S3C2410_DMASRC_MEM,
-				      prtd->params->dma_addr);
-	} else {
-		s3c2410_dma_devconfig(prtd->params->channel,
-				      S3C2410_DMASRC_HW,
-				      prtd->params->dma_addr);
-	}
-
-	s3c2410_dma_config(prtd->params->channel,
-			   prtd->params->dma_size);
-
-	/* flush the DMA channel */
-	s3c2410_dma_ctrl(prtd->params->channel, S3C2410_DMAOP_FLUSH);
-	prtd->dma_loaded = 0;
-	prtd->dma_pos = prtd->dma_start;
-
-	/* enqueue dma buffers */
-	s3c_dma_enqueue(substream);
-
-	return ret;
-}
-
-static int s3c_dma_trigger(struct snd_pcm_substream *substream, int cmd)
-{
-	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
-	int ret = 0;
-
-	pr_debug("Entered %s\n", __func__);
-
-	spin_lock(&prtd->lock);
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_RESUME:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		prtd->state |= ST_RUNNING;
-		s3c2410_dma_ctrl(prtd->params->channel, S3C2410_DMAOP_START);
-		break;
-
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		prtd->state &= ~ST_RUNNING;
-		s3c2410_dma_ctrl(prtd->params->channel, S3C2410_DMAOP_STOP);
-		break;
-
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-	spin_unlock(&prtd->lock);
-
-	return ret;
-}
-
-static snd_pcm_uframes_t
-s3c_dma_pointer(struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct s3c24xx_runtime_data *prtd = runtime->private_data;
-	unsigned long res;
-	dma_addr_t src, dst;
-
-	pr_debug("Entered %s\n", __func__);
-
-	spin_lock(&prtd->lock);
-	s3c2410_dma_getposition(prtd->params->channel, &src, &dst);
-
-	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-		res = dst - prtd->dma_start;
-	else
-		res = src - prtd->dma_start;
-
-	spin_unlock(&prtd->lock);
-
-	pr_debug("Pointer %x %x\n", src, dst);
-
-	/* we seem to be getting the odd error from the pcm library due
-	 * to out-of-bounds pointers. this is maybe due to the dma engine
-	 * not having loaded the new values for the channel before being
-	 * callled... (todo - fix )
-	 */
-
-	if (res >= snd_pcm_lib_buffer_bytes(substream)) {
-		if (res == snd_pcm_lib_buffer_bytes(substream))
-			res = 0;
-	}
-
-	return bytes_to_frames(substream->runtime, res);
-}
-
-static int s3c_dma_open(struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct s3c24xx_runtime_data *prtd;
-
-	pr_debug("Entered %s\n", __func__);
-
-	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
-	snd_soc_set_runtime_hwparams(substream, &s3c_dma_hardware);
-
-	prtd = kzalloc(sizeof(struct s3c24xx_runtime_data), GFP_KERNEL);
-	if (prtd == NULL)
-		return -ENOMEM;
-
-	spin_lock_init(&prtd->lock);
-
-	runtime->private_data = prtd;
-	return 0;
-}
-
-static int s3c_dma_close(struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct s3c24xx_runtime_data *prtd = runtime->private_data;
-
-	pr_debug("Entered %s\n", __func__);
-
-	if (!prtd)
-		pr_debug("s3c_dma_close called with prtd == NULL\n");
-
-	kfree(prtd);
-
-	return 0;
-}
-
-static int s3c_dma_mmap(struct snd_pcm_substream *substream,
-	struct vm_area_struct *vma)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-
-	pr_debug("Entered %s\n", __func__);
-
-	return dma_mmap_writecombine(substream->pcm->card->dev, vma,
-				     runtime->dma_area,
-				     runtime->dma_addr,
-				     runtime->dma_bytes);
-}
-
-static struct snd_pcm_ops s3c_dma_ops = {
-	.open		= s3c_dma_open,
-	.close		= s3c_dma_close,
-	.ioctl		= snd_pcm_lib_ioctl,
-	.hw_params	= s3c_dma_hw_params,
-	.hw_free	= s3c_dma_hw_free,
-	.prepare	= s3c_dma_prepare,
-	.trigger	= s3c_dma_trigger,
-	.pointer	= s3c_dma_pointer,
-	.mmap		= s3c_dma_mmap,
-};
-
-static int s3c_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
-{
-	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
-	struct snd_dma_buffer *buf = &substream->dma_buffer;
-	size_t size = s3c_dma_hardware.buffer_bytes_max;
-
-	pr_debug("Entered %s\n", __func__);
-
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
-static void s3c_dma_free_dma_buffers(struct snd_pcm *pcm)
-{
-	struct snd_pcm_substream *substream;
-	struct snd_dma_buffer *buf;
-	int stream;
-
-	pr_debug("Entered %s\n", __func__);
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
-static u64 s3c_dma_mask = DMA_BIT_MASK(32);
-
-static int s3c_dma_new(struct snd_card *card,
-	struct snd_soc_dai *dai, struct snd_pcm *pcm)
-{
-	int ret = 0;
-
-	pr_debug("Entered %s\n", __func__);
-
-	if (!card->dev->dma_mask)
-		card->dev->dma_mask = &s3c_dma_mask;
-	if (!card->dev->coherent_dma_mask)
-		card->dev->coherent_dma_mask = 0xffffffff;
-
-	if (dai->driver->playback.channels_min) {
-		ret = s3c_preallocate_dma_buffer(pcm,
-			SNDRV_PCM_STREAM_PLAYBACK);
-		if (ret)
-			goto out;
-	}
-
-	if (dai->driver->capture.channels_min) {
-		ret = s3c_preallocate_dma_buffer(pcm,
-			SNDRV_PCM_STREAM_CAPTURE);
-		if (ret)
-			goto out;
-	}
- out:
-	return ret;
-}
-
-static struct snd_soc_platform_driver s3c24xx_soc_platform = {
-	.ops		= &s3c_dma_ops,
-	.pcm_new	= s3c_dma_new,
-	.pcm_free	= s3c_dma_free_dma_buffers,
-};
-
-static int __devinit s3c24xx_soc_platform_probe(struct platform_device *pdev)
-{
-	return snd_soc_register_platform(&pdev->dev, &s3c24xx_soc_platform);
-}
-
-static int __devexit s3c24xx_soc_platform_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_platform(&pdev->dev);
-	return 0;
-}
-
-static struct platform_driver s3c24xx_pcm_driver = {
-	.driver = {
-		.name = "samsung-audio",
-		.owner = THIS_MODULE,
-	},
-
-	.probe = s3c24xx_soc_platform_probe,
-	.remove = __devexit_p(s3c24xx_soc_platform_remove),
-};
-
-static int __init snd_s3c24xx_pcm_init(void)
-{
-	return platform_driver_register(&s3c24xx_pcm_driver);
-}
-module_init(snd_s3c24xx_pcm_init);
-
-static void __exit snd_s3c24xx_pcm_exit(void)
-{
-	platform_driver_unregister(&s3c24xx_pcm_driver);
-}
-module_exit(snd_s3c24xx_pcm_exit);
-
-MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
-MODULE_DESCRIPTION("Samsung S3C Audio DMA module");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:samsung-audio");
diff --git a/sound/soc/s3c24xx/s3c-dma.h b/sound/soc/s3c24xx/s3c-dma.h
deleted file mode 100644
index 748c07d..0000000
--- a/sound/soc/s3c24xx/s3c-dma.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- *  s3c-dma.h --
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  ALSA PCM interface for the Samsung S3C24xx CPU
- */
-
-#ifndef _S3C_AUDIO_H
-#define _S3C_AUDIO_H
-
-#define ST_RUNNING		(1<<0)
-#define ST_OPENED		(1<<1)
-
-struct s3c_dma_params {
-	struct s3c2410_dma_client *client;	/* stream identifier */
-	int channel;				/* Channel ID */
-	dma_addr_t dma_addr;
-	int dma_size;			/* Size of the DMA transfer */
-};
-
-#define S3C24XX_DAI_I2S			0
-
-/* platform data */
-extern struct snd_ac97_bus_ops s3c24xx_ac97_ops;
-
-#endif
diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index b3866d5..c471431 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -28,7 +28,7 @@
 
 #include "regs-i2s-v2.h"
 #include "s3c-i2s-v2.h"
-#include "s3c-dma.h"
+#include "dma.h"
 
 #undef S3C_IIS_V2_SUPPORTED
 
diff --git a/sound/soc/s3c24xx/s3c-pcm.c b/sound/soc/s3c24xx/s3c-pcm.c
index 2e020e1..e111d23 100644
--- a/sound/soc/s3c24xx/s3c-pcm.c
+++ b/sound/soc/s3c24xx/s3c-pcm.c
@@ -29,7 +29,7 @@
 #include <plat/audio.h>
 #include <plat/dma.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c-pcm.h"
 
 static struct s3c2410_dma_client s3c_pcm_dma_client_out = {
diff --git a/sound/soc/s3c24xx/s3c2412-i2s.c b/sound/soc/s3c24xx/s3c2412-i2s.c
index 4a861cf..d953ff4 100644
--- a/sound/soc/s3c24xx/s3c2412-i2s.c
+++ b/sound/soc/s3c24xx/s3c2412-i2s.c
@@ -35,7 +35,7 @@
 #include <mach/regs-gpio.h>
 #include <mach/dma.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "regs-i2s-v2.h"
 #include "s3c2412-i2s.h"
 
diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
index e060daa..13e41ed 100644
--- a/sound/soc/s3c24xx/s3c24xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.c
@@ -38,7 +38,7 @@
 
 #include <plat/regs-iis.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c24xx-i2s.h"
 
 static struct s3c2410_dma_client s3c24xx_dma_client_out = {
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec.c b/sound/soc/s3c24xx/s3c24xx_simtec.c
index c4c1114..3f052a5 100644
--- a/sound/soc/s3c24xx/s3c24xx_simtec.c
+++ b/sound/soc/s3c24xx/s3c24xx_simtec.c
@@ -21,7 +21,7 @@
 
 #include <plat/audio-simtec.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c24xx-i2s.h"
 #include "s3c24xx_simtec.h"
 
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c b/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
index 5180c2a..8b246ab 100644
--- a/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
+++ b/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
@@ -18,7 +18,7 @@
 
 #include <plat/audio-simtec.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c24xx-i2s.h"
 #include "s3c24xx_simtec.h"
 
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c b/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
index 7a7bb53..a922e1e 100644
--- a/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
+++ b/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
@@ -18,7 +18,7 @@
 
 #include <plat/audio-simtec.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c24xx-i2s.h"
 #include "s3c24xx_simtec.h"
 
diff --git a/sound/soc/s3c24xx/s3c24xx_uda134x.c b/sound/soc/s3c24xx/s3c24xx_uda134x.c
index 50d44fa..87eeb46 100644
--- a/sound/soc/s3c24xx/s3c24xx_uda134x.c
+++ b/sound/soc/s3c24xx/s3c24xx_uda134x.c
@@ -24,7 +24,7 @@
 
 #include <plat/regs-iis.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c24xx-i2s.h"
 #include "../codecs/uda134x.h"
 
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s-v4.c b/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
index a962847..46b65d7 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
@@ -21,7 +21,7 @@
 #include <mach/map.h>
 #include <mach/dma.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "regs-i2s-v2.h"
 #include "s3c64xx-i2s.h"
 
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index ae7acb6..0288d4e 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -25,7 +25,7 @@
 #include <mach/map.h>
 #include <mach/dma.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "regs-i2s-v2.h"
 #include "s3c64xx-i2s.h"
 
diff --git a/sound/soc/s3c24xx/smartq_wm8987.c b/sound/soc/s3c24xx/smartq_wm8987.c
index 863631a..1d55312 100644
--- a/sound/soc/s3c24xx/smartq_wm8987.c
+++ b/sound/soc/s3c24xx/smartq_wm8987.c
@@ -24,7 +24,7 @@
 
 #include <asm/mach-types.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c64xx-i2s.h"
 
 #include "../codecs/wm8750.h"
diff --git a/sound/soc/s3c24xx/smdk2443_wm9710.c b/sound/soc/s3c24xx/smdk2443_wm9710.c
index 911bb60..c50d19c 100644
--- a/sound/soc/s3c24xx/smdk2443_wm9710.c
+++ b/sound/soc/s3c24xx/smdk2443_wm9710.c
@@ -19,7 +19,7 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c-ac97.h"
 
 static struct snd_soc_card smdk2443;
diff --git a/sound/soc/s3c24xx/smdk64xx_wm8580.c b/sound/soc/s3c24xx/smdk64xx_wm8580.c
index 7e75c8d..9ddc964 100644
--- a/sound/soc/s3c24xx/smdk64xx_wm8580.c
+++ b/sound/soc/s3c24xx/smdk64xx_wm8580.c
@@ -19,7 +19,7 @@
 #include <sound/soc-dapm.h>
 
 #include "../codecs/wm8580.h"
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c64xx-i2s.h"
 
 /*
diff --git a/sound/soc/s3c24xx/smdk_spdif.c b/sound/soc/s3c24xx/smdk_spdif.c
index 082b88d..4fc6a9f 100644
--- a/sound/soc/s3c24xx/smdk_spdif.c
+++ b/sound/soc/s3c24xx/smdk_spdif.c
@@ -18,7 +18,7 @@
 
 #include <sound/soc.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "spdif.h"
 
 /* Audio clock settings are belonged to board specific part. Every
diff --git a/sound/soc/s3c24xx/smdk_wm9713.c b/sound/soc/s3c24xx/smdk_wm9713.c
index ea96a51..80f2aef 100644
--- a/sound/soc/s3c24xx/smdk_wm9713.c
+++ b/sound/soc/s3c24xx/smdk_wm9713.c
@@ -15,7 +15,7 @@
 #include <linux/device.h>
 #include <sound/soc.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "s3c-ac97.h"
 
 static struct snd_soc_card smdk;
diff --git a/sound/soc/s3c24xx/spdif.c b/sound/soc/s3c24xx/spdif.c
index ce554e9..dc85df3 100644
--- a/sound/soc/s3c24xx/spdif.c
+++ b/sound/soc/s3c24xx/spdif.c
@@ -20,7 +20,7 @@
 #include <plat/audio.h>
 #include <mach/dma.h>
 
-#include "s3c-dma.h"
+#include "dma.h"
 #include "spdif.h"
 
 /* Registers */
-- 
1.6.2.5
