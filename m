From: srinivas.kandagatla@linaro.org
Subject: [RFC PATCH 7/9] ASoC: qcom: qdsp6v2: Add support to q6 pcm driver
Date: Fri, 11 Aug 2017 15:29:50 +0200
Message-ID: <20170811132952.32572-8-srinivas.kandagatla@linaro.org>
References: <20170811132952.32572-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170811132952.32572-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org, kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org, lkasam@qti.qualcomm.com, sboyd@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to q6 pcm driver which configures Q6ASM streams
to pass pcm data.
Currently the driver only exposes 2 playback streams for hdmi playback
support, it can be easily extended to add all 8 streams.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,q6pcm.txt       |  21 +
 sound/soc/qcom/Kconfig                             |   6 +
 sound/soc/qcom/qdsp6v2/Makefile                    |   1 +
 sound/soc/qcom/qdsp6v2/q6pcm.c                     | 558 +++++++++++++++++++++
 4 files changed, 586 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6pcm.txt
 create mode 100644 sound/soc/qcom/qdsp6v2/q6pcm.c

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6pcm.txt b/Documentation/devicetree/bindings/sound/qcom,q6pcm.txt
new file mode 100644
index 0000000..3560757
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6pcm.txt
@@ -0,0 +1,21 @@
+Qualcomm Q6ADM (Q6 Audio Device Manager) binding
+
+This bindings describe the Qualcomm Q6 ADM module on QDSP,
+which is used by audio drivers.
+
+- compatible:
+
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,q6pcm-v2"
+
+#sound-dai-cells:
+	Usage: required
+	Value type: <integer>
+	Definition: Must be equal to 1
+
+= EXAMPLE
+	pcm: pcm0 {
+		compatible = "qcom,q6pcm-v2";
+		#sound-dai-cells = <1>;
+	};
diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 5035d37..a2aa480 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -64,6 +64,11 @@ config SND_SOC_QDSP6V2_HDMI
 	tristate
 	default n
 
+config SND_SOC_QDSP6V2_PCM
+	tristate
+	default n
+
+
 config SND_SOC_QDSP6V2
 	tristate "SoC ALSA audio driver for QDSP6V2"
 	select SND_SOC_QDSP6V2_AFE
@@ -71,6 +76,7 @@ config SND_SOC_QDSP6V2
 	select SND_SOC_QDSP6V2_ASM
 	select SND_SOC_QDSP6V2_ROUTING
 	select SND_SOC_QDSP6V2_HDMI
+	select SND_SOC_QDSP6V2_PCM
 	help
 	 To add support for MSM QDSP6V2 Soc Audio.
 	 This will enable sound soc platform specific
diff --git a/sound/soc/qcom/qdsp6v2/Makefile b/sound/soc/qcom/qdsp6v2/Makefile
index 4cab915..76e0794 100644
--- a/sound/soc/qcom/qdsp6v2/Makefile
+++ b/sound/soc/qcom/qdsp6v2/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_SND_SOC_QDSP6V2_ADM) += q6adm.o
 obj-$(CONFIG_SND_SOC_QDSP6V2_ASM) += q6asm.o
 obj-$(CONFIG_SND_SOC_QDSP6V2_ROUTING) += q6routing.o
 obj-$(CONFIG_SND_SOC_QDSP6V2_HDMI) += q6hdmi.o
+obj-$(CONFIG_SND_SOC_QDSP6V2_PCM) += q6pcm.o
diff --git a/sound/soc/qcom/qdsp6v2/q6pcm.c b/sound/soc/qcom/qdsp6v2/q6pcm.c
new file mode 100644
index 0000000..cfd9a7b
--- /dev/null
+++ b/sound/soc/qcom/qdsp6v2/q6pcm.c
@@ -0,0 +1,558 @@
+/* Copyright (c) 2012-2017, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/pcm.h>
+#include <asm/dma.h>
+#include <linux/dma-mapping.h>
+#include <dt-bindings/sound/qcom,asm.h>
+#include <linux/of_device.h>
+#include <sound/pcm_params.h>
+#include "q6asm-v2.h"
+#include "q6routing-v2.h"
+#include "common.h"
+
+#define PLAYBACK_MIN_NUM_PERIODS    2
+#define PLAYBACK_MAX_NUM_PERIODS   8
+#define PLAYBACK_MAX_PERIOD_SIZE    61440
+#define PLAYBACK_MIN_PERIOD_SIZE    128
+
+enum stream_state {
+	IDLE = 0,
+	STOPPED,
+	RUNNING,
+};
+
+struct q6pcm_rtd {
+	struct snd_pcm_substream *substream;
+	void *data;
+	dma_addr_t phys;
+	unsigned int pcm_size;
+	unsigned int pcm_count;
+	unsigned int pcm_irq_pos;       /* IRQ position */
+	unsigned int periods;
+	uint16_t bits_per_sample;
+	uint16_t source; /* Encoding source bit mask */
+
+	struct audio_client *audio_client;
+	uint16_t session_id;
+
+	enum stream_state state;
+	bool set_channel_map;
+	char channel_map[8];
+};
+
+struct q6pcm_data {
+	struct q6asm *q6asm;
+	u64 sid;
+};
+
+static struct snd_pcm_hardware q6pcm_hardware_playback = {
+	.info =                 (SNDRV_PCM_INFO_MMAP |
+				SNDRV_PCM_INFO_BLOCK_TRANSFER |
+				SNDRV_PCM_INFO_MMAP_VALID |
+				SNDRV_PCM_INFO_INTERLEAVED |
+				SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME),
+	.formats =              (SNDRV_PCM_FMTBIT_S16_LE |
+				SNDRV_PCM_FMTBIT_S24_LE),
+	.rates =                SNDRV_PCM_RATE_8000_192000,
+	.rate_min =             8000,
+	.rate_max =             192000,
+	.channels_min =         1,
+	.channels_max =         8,
+	.buffer_bytes_max =     PLAYBACK_MAX_NUM_PERIODS *
+				PLAYBACK_MAX_PERIOD_SIZE,
+	.period_bytes_min =	PLAYBACK_MIN_PERIOD_SIZE,
+	.period_bytes_max =     PLAYBACK_MAX_PERIOD_SIZE,
+	.periods_min =          PLAYBACK_MIN_NUM_PERIODS,
+	.periods_max =          PLAYBACK_MAX_NUM_PERIODS,
+	.fifo_size =            0,
+};
+
+/* Conventional and unconventional sample rate supported */
+static unsigned int supported_sample_rates[] = {
+	8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000,
+	88200, 96000, 176400, 192000
+};
+
+static struct snd_pcm_hw_constraint_list constraints_sample_rates = {
+	.count = ARRAY_SIZE(supported_sample_rates),
+	.list = supported_sample_rates,
+	.mask = 0,
+};
+
+static void event_handler(uint32_t opcode, uint32_t token,
+			  uint32_t *payload, void *priv)
+{
+	struct q6pcm_rtd *prtd = priv;
+	struct snd_pcm_substream *substream = prtd->substream;
+
+	switch (opcode) {
+	case ASM_CLIENT_EVENT_CMD_RUN_DONE:
+		q6asm_write_nolock(prtd->audio_client,
+				   prtd->pcm_count, 0, 0, NO_TIMESTAMP);
+		break;
+	case ASM_CLIENT_EVENT_CMD_EOS_DONE:
+		prtd->state = STOPPED;
+		break;
+	case ASM_CLIENT_EVENT_DATA_WRITE_DONE: {
+		prtd->pcm_irq_pos += prtd->pcm_count;
+		snd_pcm_period_elapsed(substream);
+		if (prtd->state == RUNNING)
+			q6asm_write_nolock(prtd->audio_client,
+					   prtd->pcm_count, 0, 0, NO_TIMESTAMP);
+
+		break;
+	}
+	default:
+		pr_err("Not Supported Event opcode[0x%x]\n", opcode);
+		break;
+	}
+}
+
+static int q6pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *soc_prtd = substream->private_data;
+	struct q6pcm_rtd *prtd = runtime->private_data;
+	struct q6pcm_data *pdata;
+	int ret;
+
+	pdata = dev_get_drvdata(soc_prtd->platform->dev);
+	if (!pdata) {
+		pr_err("%s: platform data not populated\n", __func__);
+		return -EINVAL;
+	}
+	if (!prtd || !prtd->audio_client) {
+		pr_err("%s: private data null or audio client freed\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	prtd->pcm_count = snd_pcm_lib_period_bytes(substream);
+	prtd->pcm_irq_pos = 0;
+	/* rate and channels are sent to audio driver */
+	if (prtd->state) {
+		/* clear the previous setup if any  */
+		q6asm_cmd(prtd->audio_client, CMD_CLOSE);
+		q6asm_unmap_memory_regions(substream->stream,
+					   prtd->audio_client);
+		routing_dereg_phy_stream(soc_prtd->dai_link->id,
+					 SNDRV_PCM_STREAM_PLAYBACK);
+	}
+
+	ret = q6asm_map_memory_regions(substream->stream, prtd->audio_client,
+				       prtd->data, prtd->phys,
+				       (prtd->pcm_size / prtd->periods),
+				       prtd->periods);
+
+	if (ret < 0) {
+		pr_err("Audio Start: Buffer Allocation failed rc = %d\n",
+							ret);
+		return -ENOMEM;
+	}
+
+	prtd->audio_client->perf_mode = LEGACY_PCM_MODE;
+
+	ret = q6asm_open_write(prtd->audio_client, FORMAT_LINEAR_PCM,
+			       prtd->bits_per_sample);
+	if (ret < 0) {
+		pr_err("%s: q6asm_open_write failed\n", __func__);
+		q6asm_audio_client_free(prtd->audio_client);
+		prtd->audio_client = NULL;
+		return -ENOMEM;
+	}
+
+	prtd->session_id = prtd->audio_client->session;
+	ret = routing_reg_phy_stream(soc_prtd->dai_link->id,
+			prtd->audio_client->perf_mode,
+			prtd->session_id, substream->stream);
+	if (ret) {
+		pr_err("%s: stream reg failed ret:%d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = q6asm_media_format_block_multi_ch_pcm(
+			prtd->audio_client, runtime->rate,
+			runtime->channels, !prtd->set_channel_map,
+			prtd->channel_map, prtd->bits_per_sample);
+	if (ret < 0)
+		pr_info("%s: CMD Format block failed\n", __func__);
+
+	prtd->state = RUNNING;
+
+	return 0;
+}
+
+static int q6pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	int ret = 0;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct q6pcm_rtd *prtd = runtime->private_data;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		ret = q6asm_run_nowait(prtd->audio_client, 0, 0, 0);
+		break;
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		ret = q6asm_run_nowait(prtd->audio_client, 0, 0, 0);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		ret = q6asm_cmd_nowait(prtd->audio_client, CMD_EOS);
+		break;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		ret = q6asm_cmd_nowait(prtd->audio_client, CMD_PAUSE);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int q6pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *soc_prtd = substream->private_data;
+	struct q6pcm_rtd *prtd;
+	struct q6pcm_data *pdata;
+	struct device *dev = soc_prtd->platform->dev;
+	int ret = 0;
+
+	pdata = dev_get_drvdata(dev);
+	if (!pdata) {
+		pr_err("Platform data not found ..\n");
+		return -EINVAL;
+	}
+
+	prtd = kzalloc(sizeof(struct q6pcm_rtd), GFP_KERNEL);
+	if (prtd == NULL)
+		return -ENOMEM;
+
+	prtd->substream = substream;
+	prtd->audio_client = q6asm_audio_client_alloc(pdata->q6asm, dev,
+				(app_cb)event_handler, prtd);
+	if (!prtd->audio_client) {
+		pr_info("%s: Could not allocate memory\n", __func__);
+		kfree(prtd);
+		return -ENOMEM;
+	}
+
+	prtd->audio_client->dev = dev;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		runtime->hw = q6pcm_hardware_playback;
+
+	ret = snd_pcm_hw_constraint_list(runtime, 0,
+				SNDRV_PCM_HW_PARAM_RATE,
+				&constraints_sample_rates);
+	if (ret < 0)
+		pr_info("snd_pcm_hw_constraint_list failed\n");
+	/* Ensure that buffer size is a multiple of period size */
+	ret = snd_pcm_hw_constraint_integer(runtime,
+					    SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0)
+		pr_info("snd_pcm_hw_constraint_integer failed\n");
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		ret = snd_pcm_hw_constraint_minmax(runtime,
+			SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
+			PLAYBACK_MIN_NUM_PERIODS * PLAYBACK_MIN_PERIOD_SIZE,
+			PLAYBACK_MAX_NUM_PERIODS * PLAYBACK_MAX_PERIOD_SIZE);
+		if (ret < 0) {
+			pr_err("constraint for buffer bytes min max ret = %d\n",
+									ret);
+		}
+	}
+
+	ret = snd_pcm_hw_constraint_step(runtime, 0,
+		SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 32);
+	if (ret < 0) {
+		pr_err("constraint for period bytes step ret = %d\n",
+								ret);
+	}
+	ret = snd_pcm_hw_constraint_step(runtime, 0,
+		SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 32);
+	if (ret < 0) {
+		pr_err("constraint for buffer bytes step ret = %d\n",
+								ret);
+	}
+
+	prtd->set_channel_map = false;
+	runtime->private_data = prtd;
+
+	snd_soc_set_runtime_hwparams(substream, &q6pcm_hardware_playback);
+
+	runtime->dma_bytes = q6pcm_hardware_playback.buffer_bytes_max;
+
+
+	prtd->data = substream->dma_buffer.area;
+
+	if (pdata->sid < 0)
+		prtd->phys = substream->dma_buffer.addr;
+	else
+		prtd->phys = substream->dma_buffer.addr | (pdata->sid << 32);
+
+	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+
+	return 0;
+}
+
+static int q6pcm_close(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *soc_prtd = substream->private_data;
+	struct q6pcm_rtd *prtd = runtime->private_data;
+
+	if (prtd->audio_client) {
+		q6asm_cmd(prtd->audio_client, CMD_CLOSE);
+		q6asm_unmap_memory_regions(substream->stream,
+					   prtd->audio_client);
+		q6asm_audio_client_free(prtd->audio_client);
+	}
+	routing_dereg_phy_stream(soc_prtd->dai_link->id,
+						SNDRV_PCM_STREAM_PLAYBACK);
+	kfree(prtd);
+	return 0;
+}
+
+static snd_pcm_uframes_t q6pcm_pointer(struct snd_pcm_substream *substream)
+{
+
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct q6pcm_rtd *prtd = runtime->private_data;
+
+	if (prtd->pcm_irq_pos >= prtd->pcm_size)
+		prtd->pcm_irq_pos = 0;
+
+	return bytes_to_frames(runtime, (prtd->pcm_irq_pos));
+}
+
+static int q6pcm_mmap(struct snd_pcm_substream *substream,
+				struct vm_area_struct *vma)
+{
+
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *soc_prtd = substream->private_data;
+
+	return dma_mmap_coherent(soc_prtd->platform->dev, vma,
+			runtime->dma_area, runtime->dma_addr,
+			runtime->dma_bytes);
+}
+
+static int q6pcm_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct q6pcm_rtd *prtd = runtime->private_data;
+
+	prtd->pcm_size = params_buffer_bytes(params);
+	prtd->periods = params_periods(params);
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		prtd->bits_per_sample = 16;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		prtd->bits_per_sample = 24;
+		break;
+	}
+
+	return 0;
+}
+
+static struct snd_pcm_ops q6pcm_ops = {
+	.open           = q6pcm_open,
+	.hw_params	= q6pcm_hw_params,
+	.close          = q6pcm_close,
+	.ioctl          = snd_pcm_lib_ioctl,
+	.prepare        = q6pcm_prepare,
+	.trigger        = q6pcm_trigger,
+	.pointer        = q6pcm_pointer,
+	.mmap		= q6pcm_mmap,
+};
+static int msm_asoc_pcm_new(struct snd_soc_pcm_runtime *rtd)
+{
+	struct device *dev = rtd->platform->dev;
+	struct snd_pcm *pcm = rtd->pcm;
+	struct snd_pcm_substream *substream;
+	int size, ret = 0;
+
+	substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
+	size = q6pcm_hardware_playback.buffer_bytes_max;
+	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, dev, size,
+				  &substream->dma_buffer);
+	if (ret) {
+		dev_err(dev, "Cannot allocate buffer(s)\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void msm_asoc_pcm_free(struct snd_pcm *pcm)
+{
+	struct snd_pcm_substream *substream;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pcm->streams); i++) {
+		substream = pcm->streams[i].substream;
+		if (substream) {
+			snd_dma_free_pages(&substream->dma_buffer);
+			substream->dma_buffer.area = NULL;
+			substream->dma_buffer.addr = 0;
+		}
+	}
+}
+
+static struct snd_soc_platform_driver msm_soc_platform = {
+	.ops		= &q6pcm_ops,
+	.pcm_new	= msm_asoc_pcm_new,
+	.pcm_free	= msm_asoc_pcm_free,
+
+};
+
+static const struct snd_soc_dapm_route afe_pcm_routes[] = {
+	{"MM_DL1",  NULL, "MultiMedia1 Playback" },
+	{"MM_DL2",  NULL, "MultiMedia2 Playback" },
+
+};
+
+static int fe_dai_probe(struct snd_soc_dai *dai)
+{
+	struct snd_soc_dapm_context *dapm;
+
+	dapm = snd_soc_component_get_dapm(dai->component);
+	snd_soc_dapm_add_routes(dapm, afe_pcm_routes,
+				ARRAY_SIZE(afe_pcm_routes));
+
+	return 0;
+}
+
+static const struct snd_soc_component_driver msm_fe_dai_component = {
+	.name		= "msm-dai-fe",
+};
+
+static struct snd_soc_dai_driver msm_fe_dais[] = {
+	{
+		.playback = {
+			.stream_name = "MultiMedia1 Playback",
+			.rates = (SNDRV_PCM_RATE_8000_192000|
+					SNDRV_PCM_RATE_KNOT),
+			.formats = (SNDRV_PCM_FMTBIT_S16_LE |
+						SNDRV_PCM_FMTBIT_S24_LE),
+			.channels_min = 1,
+			.channels_max = 8,
+			.rate_min =     8000,
+			.rate_max =	192000,
+		},
+		.name = "MM_DL1",
+		.probe = fe_dai_probe,
+		.id = MSM_FRONTEND_DAI_MULTIMEDIA1,
+	},
+	{
+		.playback = {
+			.stream_name = "MultiMedia2 Playback",
+			.rates = (SNDRV_PCM_RATE_8000_192000|
+					SNDRV_PCM_RATE_KNOT),
+			.formats = (SNDRV_PCM_FMTBIT_S16_LE |
+						SNDRV_PCM_FMTBIT_S24_LE),
+			.channels_min = 1,
+			.channels_max = 8,
+			.rate_min =     8000,
+			.rate_max =	192000,
+		},
+		.name = "MM_DL2",
+		.probe = fe_dai_probe,
+		.id = MSM_FRONTEND_DAI_MULTIMEDIA2,
+	},
+};
+
+static int q6pcm_probe(struct platform_device *pdev)
+{
+	struct q6pcm_data *pdata;
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	struct of_phandle_args args;
+	int rc;
+
+	pdata = devm_kzalloc(dev, sizeof(struct q6pcm_data), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	pdata->q6asm = q6asm_get(dev);
+	if (IS_ERR(pdata->q6asm))
+		return -EPROBE_DEFER;
+
+
+	rc = of_parse_phandle_with_fixed_args(node, "iommus", 1, 0, &args);
+	if (rc < 0)
+		pdata->sid = -1;
+	else
+		pdata->sid = args.args[0];
+
+	/* only 32bit addressable */
+	dma_set_mask(dev, DMA_BIT_MASK(32));
+	dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
+	dev_set_drvdata(dev, pdata);
+
+	rc = snd_soc_register_platform(dev,  &msm_soc_platform);
+	if (rc) {
+		dev_err(&pdev->dev, "err_dai_platform\n");
+		return rc;
+	}
+
+	rc = snd_soc_register_component(dev, &msm_fe_dai_component,
+					msm_fe_dais, ARRAY_SIZE(msm_fe_dais));
+	if (rc)
+		dev_err(dev, "err_dai_component\n");
+
+	return rc;
+
+}
+
+static int q6pcm_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_platform(&pdev->dev);
+
+	return 0;
+}
+
+static const struct of_device_id q6pcm_dt_match[] = {
+	{.compatible = "qcom,q6pcm-v2"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, q6pcm_dt_match);
+
+static struct platform_driver q6pcm_driver = {
+	.driver = {
+		.name = "msm-pcm-dsp",
+		.owner = THIS_MODULE,
+		.of_match_table = q6pcm_dt_match,
+	},
+	.probe = q6pcm_probe,
+	.remove = q6pcm_remove,
+};
+
+module_platform_driver(q6pcm_driver);
+
+MODULE_DESCRIPTION("PCM module platform driver");
+MODULE_LICENSE("GPL v2");
-- 
2.9.3
