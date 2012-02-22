From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [RFC 4/7] ASoC: Add dmaengine PCM helper functions
Date: Wed, 22 Feb 2012 10:49:08 +0100
Message-ID: <1329904151-5927-5-git-send-email-lars@metafoo.de>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-087.synserver.de (smtp-out-093.synserver.de
	[212.40.185.93]) by alsa0.perex.cz (Postfix) with ESMTP id D3CAB24575
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 10:47:46 +0100 (CET)
In-Reply-To: <1329904151-5927-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Vinod Koul <vinod.koul@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Mika Westerberg <mika.westerberg@iki.fi>, Wolfram Sang <w.sang@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

This patch adds a set of functions which are intended to be used when
implementing a dmaengine based sound PCM driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Tested-by: Shawn Guo <shawn.guo@linaro.org>
---
 include/sound/dmaengine_pcm.h |   49 +++++++
 sound/soc/Kconfig             |    3 +
 sound/soc/Makefile            |    3 +
 sound/soc/soc-dmaengine-pcm.c |  287 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 342 insertions(+), 0 deletions(-)
 create mode 100644 include/sound/dmaengine_pcm.h
 create mode 100644 sound/soc/soc-dmaengine-pcm.c

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
new file mode 100644
index 0000000..a8fcaa6
--- /dev/null
+++ b/include/sound/dmaengine_pcm.h
@@ -0,0 +1,49 @@
+/*
+ *  Copyright (C) 2012, Analog Devices Inc.
+ *	Author: Lars-Peter Clausen <lars@metafoo.de>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under  the terms of the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+#ifndef __SOUND_DMAENGINE_PCM_H__
+#define __SOUND_DMAENGINE_PCM_H__
+
+#include <sound/pcm.h>
+#include <linux/dmaengine.h>
+
+/**
+ * snd_pcm_substream_to_dma_direction - Get dma_transfer_direction for a PCM
+ *   substream
+ * @substream: PCM substream
+ */
+static inline enum dma_transfer_direction
+snd_pcm_substream_to_dma_direction(const struct snd_pcm_substream *substream)
+{
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		return DMA_MEM_TO_DEV;
+	else
+		return DMA_DEV_TO_MEM;
+}
+
+void snd_dmaengine_pcm_set_data(struct snd_pcm_substream *substream, void *data);
+void *snd_dmaengine_pcm_get_data(struct snd_pcm_substream *substream);
+
+int snd_hwparams_to_dma_slave_config(const struct snd_pcm_substream *substream,
+	const struct snd_pcm_hw_params *params, struct dma_slave_config *slave_config);
+int snd_dmaengine_pcm_trigger(struct snd_pcm_substream *substream, int cmd);
+snd_pcm_uframes_t snd_dmaengine_pcm_pointer(struct snd_pcm_substream *substream);
+
+int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
+	dma_filter_fn filter_fn, void *filter_data);
+int snd_dmaengine_pcm_close(struct snd_pcm_substream *substream);
+
+struct dma_chan *snd_dmaengine_pcm_get_chan(struct snd_pcm_substream *substream);
+
+#endif
diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 35e662d..91c9855 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -25,6 +25,9 @@ if SND_SOC
 config SND_SOC_AC97_BUS
 	bool
 
+config SND_SOC_DMAENGINE_PCM
+	bool
+
 # All the supported SoCs
 source "sound/soc/atmel/Kconfig"
 source "sound/soc/au1x/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 9ea8ac8..2feaf37 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -1,6 +1,9 @@
 snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o soc-cache.o soc-utils.o
 snd-soc-core-objs += soc-pcm.o soc-io.o
 
+snd-soc-dmaengine-pcm-objs := soc-dmaengine-pcm.o
+obj-$(CONFIG_SND_SOC_DMAENGINE_PCM) += snd-soc-dmaengine-pcm.o
+
 obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
 obj-$(CONFIG_SND_SOC)	+= codecs/
 obj-$(CONFIG_SND_SOC)	+= atmel/
diff --git a/sound/soc/soc-dmaengine-pcm.c b/sound/soc/soc-dmaengine-pcm.c
new file mode 100644
index 0000000..0526cf8
--- /dev/null
+++ b/sound/soc/soc-dmaengine-pcm.c
@@ -0,0 +1,287 @@
+/*
+ *  Copyright (C) 2012, Analog Devices Inc.
+ *	Author: Lars-Peter Clausen <lars@metafoo.de>
+ *
+ *  Based on:
+ *	imx-pcm-dma-mx2.c, Copyright 2009 Sascha Hauer <s.hauer@pengutronix.de>
+ *	mxs-pcm.c, Copyright (C) 2011 Freescale Semiconductor, Inc.
+ *	ep93xx-pcm.c, Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
+ *		      Copyright (C) 2006 Applied Data Systems
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under  the terms of the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/dmaengine.h>
+#include <linux/slab.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include <sound/dmaengine_pcm.h>
+
+struct dmaengine_pcm_runtime_data {
+	struct dma_chan *dma_chan;
+
+	unsigned int pos;
+
+	void *data;
+};
+
+static inline struct dmaengine_pcm_runtime_data *substream_to_prtd(
+	const struct snd_pcm_substream *substream)
+{
+	return substream->runtime->private_data;
+}
+
+/**
+ * snd_dmaengine_pcm_set_data - Set dmaengine substream private data
+ * @substream: PCM substream
+ * @data: Data to set
+ */
+void snd_dmaengine_pcm_set_data(struct snd_pcm_substream *substream, void *data)
+{
+	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
+
+	prtd->data = data;
+}
+EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_set_data);
+
+/**
+ * snd_dmaengine_pcm_get_data - Get dmaeinge substream private data
+ * @substream: PCM substream
+ *
+ * Returns the data previously set with snd_dmaengine_pcm_set_data
+ */
+void *snd_dmaengine_pcm_get_data(struct snd_pcm_substream *substream)
+{
+	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
+
+	return prtd->data;
+}
+EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_get_data);
+
+struct dma_chan *snd_dmaengine_pcm_get_chan(struct snd_pcm_substream *substream)
+{
+	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
+
+	return prtd->dma_chan;
+}
+EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_get_chan);
+
+/**
+ * snd_hwparams_to_dma_slave_config - Convert hw_params to dma_slave_config
+ * @substream: PCM substream
+ * @params: hw_params
+ * @slave_config: DMA slave config
+ *
+ * This function can be used to initialize a dma_slave_config from a substream
+ * and hw_params in a dmaengine based PCM driver implementation.
+ */
+int snd_hwparams_to_dma_slave_config(const struct snd_pcm_substream *substream,
+	const struct snd_pcm_hw_params *params,
+	struct dma_slave_config *slave_config)
+{
+	enum dma_slave_buswidth buswidth;
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S8:
+		buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		buswidth = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		break;
+	case SNDRV_PCM_FORMAT_S18_3LE:
+	case SNDRV_PCM_FORMAT_S20_3LE:
+	case SNDRV_PCM_FORMAT_S24_LE:
+	case SNDRV_PCM_FORMAT_S32_LE:
+		buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		slave_config->direction = DMA_MEM_TO_DEV;
+		slave_config->dst_addr_width = buswidth;
+	} else {
+		slave_config->direction = DMA_DEV_TO_MEM;
+		slave_config->src_addr_width = buswidth;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_hwparams_to_dma_slave_config);
+
+static void dmaengine_pcm_dma_complete(void *arg)
+{
+	struct snd_pcm_substream *substream = arg;
+	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
+
+	prtd->pos += snd_pcm_lib_period_bytes(substream);
+	if (prtd->pos >= snd_pcm_lib_buffer_bytes(substream))
+		prtd->pos = 0;
+
+	snd_pcm_period_elapsed(substream);
+}
+
+static int dmaengine_pcm_prepare_and_submit(struct snd_pcm_substream *substream)
+{
+	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
+	struct dma_chan *chan = prtd->dma_chan;
+	struct dma_async_tx_descriptor *desc;
+	enum dma_transfer_direction direction;
+
+	direction = snd_pcm_substream_to_dma_direction(substream);
+
+	desc = chan->device->device_prep_dma_cyclic(chan,
+		substream->runtime->dma_addr,
+		snd_pcm_lib_buffer_bytes(substream),
+		snd_pcm_lib_period_bytes(substream), direction);
+
+	if (!desc)
+		return -ENOMEM;
+
+	desc->callback = dmaengine_pcm_dma_complete;
+	desc->callback_param = substream;
+	dmaengine_submit(desc);
+
+	return 0;
+}
+
+/**
+ * snd_dmaengine_pcm_trigger - dmaengine based PCM trigger implementation
+ * @substream: PCM substream
+ * @cmd: Trigger command
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ *
+ * This function can be used as the PCM trigger callback for dmaengine based PCM
+ * driver implementations.
+ */
+int snd_dmaengine_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
+	int ret;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		ret = dmaengine_pcm_prepare_and_submit(substream);
+		if (ret)
+			return ret;
+		dma_async_issue_pending(prtd->dma_chan);
+		break;
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		dmaengine_resume(prtd->dma_chan);
+		break;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		dmaengine_pause(prtd->dma_chan);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		dmaengine_terminate_all(prtd->dma_chan);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_trigger);
+
+/**
+ * snd_dmaengine_pcm_pointer - dmaengine based PCM pointer implementation
+ * @substream: PCM substream
+ *
+ * This function can be used as the PCM pointer callback for dmaengine based PCM
+ * driver implementations.
+ */
+snd_pcm_uframes_t snd_dmaengine_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
+	return bytes_to_frames(substream->runtime, prtd->pos);
+}
+EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_pointer);
+
+static int dmaengine_pcm_request_channel(struct dmaengine_pcm_runtime_data *prtd,
+	dma_filter_fn filter_fn, void *filter_data)
+{
+	dma_cap_mask_t mask;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+	dma_cap_set(DMA_CYCLIC, mask);
+	prtd->dma_chan = dma_request_channel(mask, filter_fn, filter_data);
+
+	if (!prtd->dma_chan)
+		return -ENXIO;
+
+	return 0;
+}
+
+/**
+ * snd_dmaengine_pcm_open - Open a dmaengine based PCM substream
+ * @substream: PCM substream
+ * @filter_fn: Filter function used to request the DMA channel
+ * @filter_data: Data passed to the DMA filter function
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ *
+ * This function will request a DMA channel using the passed filter function and
+ * data. The function should usually be called from the pcm open callback.
+ *
+ * Note that this function will use private_data field of the substream's
+ * runtime. So it is not availabe to your pcm driver implementation. If you need
+ * to keep additional data attached to a substream use
+ * snd_dmaeinge_pcm_{set,get}_data.
+ */
+int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
+	dma_filter_fn filter_fn, void *filter_data)
+{
+	struct dmaengine_pcm_runtime_data *prtd;
+	int ret;
+
+	ret = snd_pcm_hw_constraint_integer(substream->runtime,
+					    SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0)
+		return ret;
+
+	prtd = kzalloc(sizeof(*prtd), GFP_KERNEL);
+	if (!prtd)
+		return -ENOMEM;
+
+	ret = dmaengine_pcm_request_channel(prtd, filter_fn, filter_data);
+	if (ret < 0) {
+		kfree(prtd);
+		return ret;
+	}
+
+	substream->runtime->private_data = prtd;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_open);
+
+/**
+ * snd_dmaengine_pcm_close - Close a dmaengine based PCM substream
+ * @substream: PCM substream
+ */
+int snd_dmaengine_pcm_close(struct snd_pcm_substream *substream)
+{
+	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
+
+	dma_release_channel(prtd->dma_chan);
+	kfree(prtd);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_close);
-- 
1.7.9
