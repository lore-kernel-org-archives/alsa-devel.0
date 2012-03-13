From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 14/16] ASoC: Ux500: Add platform-driver
Date: Tue, 13 Mar 2012 16:11:41 +0100
Message-ID: <1331651503-16917-15-git-send-email-ola.o.lilja@stericsson.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog108.obsmtp.com (eu1sys200aog108.obsmtp.com
	[207.126.144.125])
	by alsa0.perex.cz (Postfix) with ESMTP id 80C38104348
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 16:12:31 +0100 (CET)
In-Reply-To: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

Add platform-driver handling all DMA-activities.

Signed-off-by: Ola Lilja <ola.o.lilja@stericsson.com>
---
 sound/soc/ux500/Kconfig     |    7 +
 sound/soc/ux500/Makefile    |    4 +
 sound/soc/ux500/ux500_pcm.c |  537 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/ux500/ux500_pcm.h |   52 ++++
 4 files changed, 600 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/ux500/ux500_pcm.c
 create mode 100644 sound/soc/ux500/ux500_pcm.h

diff --git a/sound/soc/ux500/Kconfig b/sound/soc/ux500/Kconfig
index 532429b..6c0271c 100644
--- a/sound/soc/ux500/Kconfig
+++ b/sound/soc/ux500/Kconfig
@@ -16,6 +16,13 @@ config SND_SOC_UX500_MSP_I2S
 	help
 		Say Y if you want to enable the Ux500 MSP I2S-driver.
 
+config SND_SOC_UX500_PLATFORM
+	bool "Platform - DB8500 (DMA)"
+	depends on SND_SOC_UX500
+	default n
+	help
+		Say Y if you want to enable the Ux500 platform-driver.
+
 config SND_SOC_UX500_DEBUG
 	bool "Activate Ux500 platform debug-mode (pr_debug)"
 	depends on SND_SOC_UX500
diff --git a/sound/soc/ux500/Makefile b/sound/soc/ux500/Makefile
index 9666b3a..72e806e 100644
--- a/sound/soc/ux500/Makefile
+++ b/sound/soc/ux500/Makefile
@@ -10,4 +10,8 @@ snd-soc-ux500-platform-i2s-objs := ux500_msp_dai.o ux500_msp_i2s.o
 obj-$(CONFIG_SND_SOC_UX500_MSP_I2S) += snd-soc-ux500-platform-i2s.o
 endif
 
+ifdef CONFIG_SND_SOC_UX500_PLATFORM
+snd-soc-ux500-platform-dma-objs := ux500_pcm.o
+obj-$(CONFIG_SND_SOC_UX500_PLATFORM) += snd-soc-ux500-platform-dma.o
+endif
 
diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pcm.c
new file mode 100644
index 0000000..dee8957
--- /dev/null
+++ b/sound/soc/ux500/ux500_pcm.c
@@ -0,0 +1,537 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Ola Lilja <ola.o.lilja@stericsson.com>,
+ *         Roger Nilsson <roger.xr.nilsson@stericsson.com>
+ *         for ST-Ericsson.
+ *
+ * License terms:
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <asm/page.h>
+
+#include <linux/module.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+
+#include <plat/ste_dma40.h>
+
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include "ux500_pcm.h"
+
+static struct snd_pcm_hardware ux500_pcm_hw_playback = {
+	.info = SNDRV_PCM_INFO_INTERLEAVED |
+		SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_RESUME |
+		SNDRV_PCM_INFO_PAUSE,
+	.formats = SNDRV_PCM_FMTBIT_S16_LE |
+		SNDRV_PCM_FMTBIT_U16_LE |
+		SNDRV_PCM_FMTBIT_S16_BE |
+		SNDRV_PCM_FMTBIT_U16_BE,
+	.rates = SNDRV_PCM_RATE_KNOT,
+	.rate_min = UX500_PLATFORM_MIN_RATE_PLAYBACK,
+	.rate_max = UX500_PLATFORM_MAX_RATE_PLAYBACK,
+	.channels_min = UX500_PLATFORM_MIN_CHANNELS,
+	.channels_max = UX500_PLATFORM_MAX_CHANNELS,
+	.buffer_bytes_max = UX500_PLATFORM_BUFFER_BYTES_MAX,
+	.period_bytes_min = UX500_PLATFORM_PERIODS_BYTES_MIN,
+	.period_bytes_max = UX500_PLATFORM_PERIODS_BYTES_MAX,
+	.periods_min = UX500_PLATFORM_PERIODS_MIN,
+	.periods_max = UX500_PLATFORM_PERIODS_MAX,
+};
+
+static struct snd_pcm_hardware ux500_pcm_hw_capture = {
+	.info = SNDRV_PCM_INFO_INTERLEAVED |
+		SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_RESUME |
+		SNDRV_PCM_INFO_PAUSE,
+	.formats = SNDRV_PCM_FMTBIT_S16_LE |
+		SNDRV_PCM_FMTBIT_U16_LE |
+		SNDRV_PCM_FMTBIT_S16_BE |
+		SNDRV_PCM_FMTBIT_U16_BE,
+	.rates = SNDRV_PCM_RATE_KNOT,
+	.rate_min = UX500_PLATFORM_MIN_RATE_CAPTURE,
+	.rate_max = UX500_PLATFORM_MAX_RATE_CAPTURE,
+	.channels_min = UX500_PLATFORM_MIN_CHANNELS,
+	.channels_max = UX500_PLATFORM_MAX_CHANNELS,
+	.buffer_bytes_max = UX500_PLATFORM_BUFFER_BYTES_MAX,
+	.period_bytes_min = UX500_PLATFORM_PERIODS_BYTES_MIN,
+	.period_bytes_max = UX500_PLATFORM_PERIODS_BYTES_MAX,
+	.periods_min = UX500_PLATFORM_PERIODS_MIN,
+	.periods_max = UX500_PLATFORM_PERIODS_MAX,
+};
+
+static const char *stream_str(struct snd_pcm_substream *substream)
+{
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		return "Playback";
+	else
+		return "Capture";
+}
+
+static void ux500_pcm_dma_eot_handler(void *data)
+{
+	struct snd_pcm_substream *substream = data;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *dai = rtd->cpu_dai;
+
+	dev_dbg(rtd->platform->dev, "%s: MSP %d (%s): Enter.\n", __func__, dai->id,
+		stream_str(substream));
+
+	if (substream) {
+		struct snd_pcm_runtime *runtime = substream->runtime;
+		struct ux500_pcm *ux500_pcm_data = substream->runtime->private_data;
+
+		/* calc the offset in the circular buffer */
+		ux500_pcm_data->offset +=
+			frames_to_bytes(runtime, runtime->period_size);
+		ux500_pcm_data->offset %=
+			frames_to_bytes(runtime, runtime->period_size) *
+			runtime->periods;
+
+		snd_pcm_period_elapsed(substream);
+	}
+}
+
+static int ux500_pcm_dma_start(struct snd_pcm_substream *substream, dma_addr_t dma_addr,
+			int period_cnt, size_t period_len, int dai_idx, int stream_id)
+{
+	dma_cookie_t status_submit;
+	int direction;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ux500_pcm *ux500_pcm_data = runtime->private_data;
+	struct dma_device *dma_dev = ux500_pcm_data->pipeid->device;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *dai = rtd->cpu_dai;
+	struct dma_async_tx_descriptor *cdesc;
+	struct ux500_pcm_dma_params *dma_params;
+
+	dev_dbg(rtd->platform->dev, "%s: Enter\n", __func__);
+
+	dma_params = snd_soc_dai_get_dma_data(dai, substream);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		direction = DMA_TO_DEVICE;
+	else
+		direction = DMA_FROM_DEVICE;
+
+	cdesc = dma_dev->device_prep_dma_cyclic(ux500_pcm_data->pipeid, dma_addr,
+						period_cnt * period_len, period_len,
+						direction);
+
+	if (IS_ERR(cdesc)) {
+		dev_err(rtd->platform->dev,
+			"%s: ERROR: device_prep_dma_cyclic failed (%ld)!\n", __func__,
+			PTR_ERR(cdesc));
+		return -EINVAL;
+	}
+
+	cdesc->callback = ux500_pcm_dma_eot_handler;
+	cdesc->callback_param = substream;
+
+	status_submit = dmaengine_submit(cdesc);
+
+	if (dma_submit_error(status_submit)) {
+		dev_err(rtd->platform->dev, "%s: ERROR: dmaengine_submit failed!\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	dma_async_issue_pending(ux500_pcm_data->pipeid);
+
+	return 0;
+}
+
+static void ux500_pcm_dma_stop(struct work_struct *work)
+{
+	struct ux500_pcm *ux500_pcm_data = container_of(work, struct ux500_pcm, ws_stop);
+
+	if (ux500_pcm_data->pipeid != NULL) {
+		dmaengine_terminate_all(ux500_pcm_data->pipeid);
+		dma_release_channel(ux500_pcm_data->pipeid);
+		ux500_pcm_data->pipeid = NULL;
+	}
+}
+
+static void ux500_pcm_dma_hw_free(struct device *dev,
+				struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_dma_buffer *buf = runtime->dma_buffer_p;
+
+	if (runtime->dma_area == NULL)
+		return;
+
+	if (buf != &substream->dma_buffer) {
+		dma_free_coherent(buf->dev.dev, buf->bytes, buf->area, buf->addr);
+		kfree(runtime->dma_buffer_p);
+	}
+
+	snd_pcm_set_runtime_buffer(substream, NULL);
+}
+
+static int ux500_pcm_open(struct snd_pcm_substream *substream)
+{
+	int stream_id = substream->pstr->stream;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ux500_pcm *ux500_pcm_data;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *dai = rtd->cpu_dai;
+	int ret;
+
+	dev_dbg(dai->dev, "%s: MSP %d (%s): Enter.\n", __func__, dai->id, stream_str(substream));
+
+	dev_dbg(dai->dev, "%s: Set runtime hwparams.\n", __func__);
+	if (stream_id == SNDRV_PCM_STREAM_PLAYBACK)
+		snd_soc_set_runtime_hwparams(substream, &ux500_pcm_hw_playback);
+	else
+		snd_soc_set_runtime_hwparams(substream, &ux500_pcm_hw_capture);
+
+	/* ensure that buffer size is a multiple of period size */
+	ret = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0) {
+		dev_err(dai->dev, "%s: Error: snd_pcm_hw_constraints failed (%d)\n",
+			__func__, ret);
+		return ret;
+	}
+
+	dev_dbg(dai->dev, "%s: Init runtime private data.\n", __func__);
+	ux500_pcm_data = kzalloc(sizeof(struct ux500_pcm), GFP_KERNEL);
+	if (ux500_pcm_data == NULL)
+		return -ENOMEM;
+	ux500_pcm_data->msp_id = dai->id;
+	ux500_pcm_data->wq = alloc_ordered_workqueue("ux500/pcm", 0);
+	INIT_WORK(&ux500_pcm_data->ws_stop, ux500_pcm_dma_stop);
+
+	runtime->private_data = ux500_pcm_data;
+
+	dev_dbg(dai->dev, "%s: Set hw-struct for %s.\n", __func__, stream_str(substream));
+	runtime->hw = (stream_id == SNDRV_PCM_STREAM_PLAYBACK) ?
+		ux500_pcm_hw_playback : ux500_pcm_hw_capture;
+
+	return 0;
+}
+
+static int ux500_pcm_close(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *dai = rtd->cpu_dai;
+	struct ux500_pcm *ux500_pcm_data = substream->runtime->private_data;
+
+	dev_dbg(dai->dev, "%s: Enter\n", __func__);
+
+	if (ux500_pcm_data->pipeid != NULL) {
+		dma_release_channel(ux500_pcm_data->pipeid);
+		ux500_pcm_data->pipeid = NULL;
+	}
+
+	destroy_workqueue(ux500_pcm_data->wq);
+	kfree(ux500_pcm_data);
+
+	return 0;
+}
+
+static int ux500_pcm_hw_params(struct snd_pcm_substream *substream,
+			struct snd_pcm_hw_params *hw_params)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_dma_buffer *buf = runtime->dma_buffer_p;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	int ret = 0;
+	int size;
+
+	dev_dbg(rtd->platform->dev, "%s: Enter\n", __func__);
+
+	size = params_buffer_bytes(hw_params);
+
+	if (buf) {
+		if (buf->bytes >= size)
+			goto out;
+		ux500_pcm_dma_hw_free(NULL, substream);
+	}
+
+	if (substream->dma_buffer.area != NULL && substream->dma_buffer.bytes >= size) {
+		buf = &substream->dma_buffer;
+	} else {
+		buf = kmalloc(sizeof(struct snd_dma_buffer), GFP_KERNEL);
+		if (!buf)
+			goto nomem;
+
+		buf->dev.type = SNDRV_DMA_TYPE_DEV;
+		buf->dev.dev = NULL;
+		buf->area = dma_alloc_coherent(NULL, size, &buf->addr, GFP_KERNEL);
+		buf->bytes = size;
+		buf->private_data = NULL;
+
+		if (!buf->area)
+			goto free;
+	}
+	snd_pcm_set_runtime_buffer(substream, buf);
+	ret = 1;
+ out:
+	runtime->dma_bytes = size;
+	return ret;
+
+ free:
+	kfree(buf);
+ nomem:
+	return -ENOMEM;
+}
+
+static int ux500_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+
+	dev_dbg(rtd->platform->dev, "%s: Enter\n", __func__);
+
+	ux500_pcm_dma_hw_free(NULL, substream);
+
+	return 0;
+}
+
+static int ux500_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct stedma40_chan_cfg *dma_cfg;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *dai = rtd->cpu_dai;
+	struct ux500_pcm *ux500_pcm_data = runtime->private_data;
+	struct ux500_pcm_dma_params *dma_params;
+	dma_cap_mask_t mask;
+	u16 per_data_width, mem_data_width;
+
+	dev_dbg(rtd->platform->dev, "%s: Enter\n", __func__);
+
+	if (ux500_pcm_data->pipeid != NULL) {
+		dma_release_channel(ux500_pcm_data->pipeid);
+		ux500_pcm_data->pipeid = NULL;
+	}
+
+	dma_params = snd_soc_dai_get_dma_data(dai, substream);
+
+	mem_data_width = STEDMA40_HALFWORD_WIDTH;
+
+	switch (dma_params->data_size) {
+	case 32:
+		per_data_width = STEDMA40_WORD_WIDTH;
+		break;
+	case 16:
+		per_data_width = STEDMA40_HALFWORD_WIDTH;
+		break;
+	case 8:
+		per_data_width = STEDMA40_BYTE_WIDTH;
+		break;
+	default:
+		per_data_width = STEDMA40_WORD_WIDTH;
+		dev_warn(rtd->platform->dev, "%s: Unknown data-size (%d)! Assuming 32 bits.\n",
+			__func__, dma_params->data_size);
+	}
+
+	dma_cfg = dma_params->dma_cfg;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		dma_cfg->src_info.data_width = mem_data_width;
+		dma_cfg->dst_info.data_width = per_data_width;
+	} else {
+		dma_cfg->src_info.data_width = per_data_width;
+		dma_cfg->dst_info.data_width = mem_data_width;
+	}
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	ux500_pcm_data->pipeid = dma_request_channel(mask, stedma40_filter, dma_cfg);
+
+	return 0;
+}
+
+static int ux500_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	int ret = 0;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ux500_pcm *ux500_pcm_data = runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+
+	dev_dbg(rtd->platform->dev, "%s: Enter\n", __func__);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		dev_dbg(rtd->platform->dev, "%s: START/PAUSE-RELEASE\n", __func__);
+		if (runtime->status->state == SNDRV_PCM_STATE_XRUN) {
+			dev_dbg(rtd->platform->dev, "XRUN occurred\n");
+				return 0;
+		}
+
+		ux500_pcm_data->offset = 0;
+		ret = ux500_pcm_dma_start(
+				substream,
+				runtime->dma_addr,
+				runtime->periods,
+				frames_to_bytes(runtime, runtime->period_size),
+				ux500_pcm_data->msp_id,
+				substream->pstr->stream);
+		if (ret) {
+			dev_err(rtd->platform->dev, "%s: Failed to configure I2S!\n",
+				__func__);
+			return -EINVAL;
+		}
+		break;
+
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+		dev_dbg(rtd->platform->dev, "%s: SNDRV_PCM_TRIGGER_STOP\n", __func__);
+		dev_dbg(rtd->platform->dev, "%s: no_of_underruns = %u\n",
+			__func__,
+			ux500_pcm_data->no_of_underruns);
+		break;
+
+	default:
+		dev_err(rtd->platform->dev, "%s: Invalid command in pcm trigger\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static snd_pcm_uframes_t ux500_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ux500_pcm *ux500_pcm_data = runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+
+	dev_dbg(rtd->platform->dev, "%s: dma_offset %d frame %ld\n",
+		__func__, ux500_pcm_data->offset,
+		bytes_to_frames(substream->runtime, ux500_pcm_data->offset));
+
+	return bytes_to_frames(substream->runtime, ux500_pcm_data->offset);
+}
+
+static int ux500_pcm_mmap(struct snd_pcm_substream *substream,
+			struct vm_area_struct *vma)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+
+	dev_dbg(rtd->platform->dev, "%s: Enter.\n", __func__);
+
+	return dma_mmap_coherent(NULL, vma, runtime->dma_area, runtime->dma_addr,
+				runtime->dma_bytes);
+}
+
+static const struct snd_pcm_ops ux500_pcm_ops = {
+	.open		= ux500_pcm_open,
+	.close		= ux500_pcm_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= ux500_pcm_hw_params,
+	.hw_free	= ux500_pcm_hw_free,
+	.prepare	= ux500_pcm_prepare,
+	.trigger	= ux500_pcm_trigger,
+	.pointer	= ux500_pcm_pointer,
+	.mmap		= ux500_pcm_mmap
+};
+
+int ux500_pcm_new(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_pcm *pcm = rtd->pcm;
+
+	dev_dbg(rtd->platform->dev, "%s: Enter.\n", __func__);
+
+	pcm->info_flags = 0;
+	strcpy(pcm->name, "UX500_PCM");
+	dev_dbg(rtd->platform->dev, "%s: PCM-name: %s\n", __func__, pcm->name);
+
+	return 0;
+}
+
+static void ux500_pcm_free(struct snd_pcm *pcm)
+{
+	pr_debug("%s: Enter\n", __func__);
+}
+
+static int ux500_pcm_suspend(struct snd_soc_dai *dai)
+{
+	dev_dbg(dai->platform->dev, "%s: Enter\n", __func__);
+
+	return 0;
+}
+
+static int ux500_pcm_resume(struct snd_soc_dai *dai)
+{
+	dev_dbg(dai->platform->dev, "%s: Enter\n", __func__);
+
+	return 0;
+}
+
+struct snd_soc_platform_driver ux500_pcm_soc_drv = {
+	.ops		= &ux500_pcm_ops,
+	.pcm_new        = ux500_pcm_new,
+	.pcm_free       = ux500_pcm_free,
+	.suspend        = ux500_pcm_suspend,
+	.resume         = ux500_pcm_resume,
+};
+EXPORT_SYMBOL(ux500_pcm_soc_drv);
+
+static int __devexit ux500_pcm_drv_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	dev_info(&pdev->dev, "%s: Register ux500-pcm SoC platform driver.\n", __func__);
+	ret = snd_soc_register_platform(&pdev->dev, &ux500_pcm_soc_drv);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "%s: Error: Failed to register "
+			"ux500-pcm SoC platform driver (%d)!\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __devinit ux500_pcm_drv_remove(struct platform_device *pdev)
+{
+	dev_info(&pdev->dev, "%s: Unregister ux500-pcm SoC platform driver.\n", __func__);
+	snd_soc_unregister_platform(&pdev->dev);
+
+	return 0;
+}
+
+static struct platform_driver ux500_pcm_driver = {
+	.driver = {
+		.name = "ux500-pcm",
+		.owner = THIS_MODULE,
+	},
+
+	.probe = ux500_pcm_drv_probe,
+	.remove = __devexit_p(ux500_pcm_drv_remove),
+};
+
+static int __init ux500_pcm_drv_init(void)
+{
+	pr_debug("%s: Register ux500-pcm platform driver.\n", __func__);
+
+	return platform_driver_register(&ux500_pcm_driver);
+}
+
+static void __exit ux500_pcm_drv_exit(void)
+{
+	pr_debug("%s: Unregister ux500-pcm platform driver.\n", __func__);
+
+	platform_driver_unregister(&ux500_pcm_driver);
+}
+
+module_init(ux500_pcm_drv_init);
+module_exit(ux500_pcm_drv_exit);
+
diff --git a/sound/soc/ux500/ux500_pcm.h b/sound/soc/ux500/ux500_pcm.h
new file mode 100644
index 0000000..6cd78eb
--- /dev/null
+++ b/sound/soc/ux500/ux500_pcm.h
@@ -0,0 +1,52 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2012
+ *
+ * Author: Ola Lilja <ola.o.lilja@stericsson.com>,
+ *         Roger Nilsson <roger.xr.nilsson@stericsson.com>
+ *         for ST-Ericsson.
+ *
+ * License terms:
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+#ifndef UX500_PCM_H
+#define UX500_PCM_H
+
+#include <asm/page.h>
+
+#include <linux/workqueue.h>
+
+#define UX500_PLATFORM_MIN_RATE_PLAYBACK 8000
+#define UX500_PLATFORM_MAX_RATE_PLAYBACK 48000
+#define UX500_PLATFORM_MIN_RATE_CAPTURE	8000
+#define UX500_PLATFORM_MAX_RATE_CAPTURE	48000
+
+#define UX500_PLATFORM_MIN_CHANNELS 1
+#define UX500_PLATFORM_MAX_CHANNELS 8
+
+#define UX500_PLATFORM_PERIODS_BYTES_MIN	128
+#define UX500_PLATFORM_PERIODS_BYTES_MAX	(64 * PAGE_SIZE)
+#define UX500_PLATFORM_PERIODS_MIN		2
+#define UX500_PLATFORM_PERIODS_MAX		48
+#define UX500_PLATFORM_BUFFER_BYTES_MAX		(2048 * PAGE_SIZE)
+
+extern struct snd_soc_platform ux500_soc_platform;
+
+struct ux500_pcm {
+	struct dma_chan *pipeid;
+	struct workqueue_struct *wq;
+	struct work_struct ws_stop;
+	int msp_id;
+	int stream_id;
+	unsigned int offset;
+	unsigned int no_of_underruns;
+};
+
+struct ux500_pcm_dma_params {
+	unsigned int data_size;
+	struct stedma40_chan_cfg *dma_cfg;
+};
+
+#endif
-- 
1.7.8.3
