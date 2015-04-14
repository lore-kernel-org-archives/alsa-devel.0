From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 5/7] Asoc: sti: Add platform driver
Date: Tue, 14 Apr 2015 15:35:29 +0200
Message-ID: <1429018531-29025-6-git-send-email-arnaud.pouliquen@st.com>
References: <1429018531-29025-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 85EC726510B
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2015 15:37:25 +0200 (CEST)
In-Reply-To: <1429018531-29025-1-git-send-email-arnaud.pouliquen@st.com>
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
Cc: broonie@kernel.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Asoc Platform driver that manages uniperipheral DAIs and associated
PCM stream.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/sti/sti_platform.c | 643 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 643 insertions(+)
 create mode 100644 sound/soc/sti/sti_platform.c

diff --git a/sound/soc/sti/sti_platform.c b/sound/soc/sti/sti_platform.c
new file mode 100644
index 0000000..5c73dde
--- /dev/null
+++ b/sound/soc/sti/sti_platform.c
@@ -0,0 +1,643 @@
+/*
+ * Copyright (C) STMicroelectronics SA 2015
+ * Authors: Arnaud Pouliquen <arnaud.pouliquen@st.com>
+ *          for STMicroelectronics.
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+
+#include <linux/module.h>
+
+#include <sound/dmaengine_pcm.h>
+
+#include "uniperif.h"
+
+/*
+ * Max buffering use case identified:
+ * 3 periods of 2048 frames @ 192kHz, 32 bits, 10 ch
+ */
+#define STI_PLATFORM_PERIODS_BYTES_MAX	196608
+#define STI_PLATFORM_PERIODS_MAX	3
+#define STI_PLATFORM_BUFFER_BYTES_MAX	(STI_PLATFORM_PERIODS_BYTES_MAX * \
+					 STI_PLATFORM_PERIODS_MAX)
+
+struct sti_platform_dai {
+	int stream;
+	int (*init)(struct platform_device *pdev, struct device_node *node,
+		    struct uniperif **uni, int idx);
+	int (*remove)(struct platform_device *pdev);
+	struct uniperif *uni;
+	struct snd_dmaengine_dai_dma_data dma_data;
+};
+
+struct sti_platform_dai uni_player = {
+	.stream = SNDRV_PCM_STREAM_PLAYBACK,
+	.init = uni_player_init,
+	.remove = uni_player_remove,
+};
+
+struct sti_platform_dai uni_reader = {
+	.stream = SNDRV_PCM_STREAM_CAPTURE,
+	.init = uni_reader_init,
+	.remove = uni_reader_remove,
+};
+
+struct sti_platform_data {
+	struct platform_device *pdev;
+	struct snd_soc_dai_driver *dai;
+	struct sti_platform_dai dai_data[]; /* dynamically allocated */
+};
+
+struct sti_pcm_dma_params {
+	struct dma_chan *dma_channel;
+	dma_cookie_t dma_cookie;
+	struct dma_slave_config slave_config;
+};
+
+#define priv_to_dai_data(priv, i) ((priv)->dai_data + i)
+
+/*
+ * sti_platform_dai_create_ctrl
+ * This function is used to create Ctrl associated to DAI but also pcm device.
+ * Request is done by front end to associate ctrl with pcm device id
+ */
+int sti_platform_dai_create_ctrl(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_dai *dai = rtd->cpu_dai;
+	struct sti_platform_data *priv = snd_soc_dai_get_drvdata(dai);
+	struct sti_platform_dai *dai_data = priv_to_dai_data(priv, dai->id);
+	struct uniperif *uni = dai_data->uni;
+	struct snd_kcontrol_new *ctrl;
+	int i, ret = 0;
+
+	for (i = 0; i < uni->num_ctrls; i++) {
+		ctrl = &uni->snd_ctrls[i];
+		ctrl->index = rtd->pcm->device;
+		ctrl->device = rtd->pcm->device;
+
+		ret = snd_ctl_add(dai->component->card->snd_card,
+				  snd_ctl_new1(ctrl, uni));
+		if (ret < 0) {
+			dev_err(dai->dev, "%s: Failed to add %s: %d\n",
+				__func__, ctrl->name, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * DAI
+ */
+
+static int sti_platform_dai_startup(struct snd_pcm_substream *substream,
+				    struct snd_soc_dai *dai)
+{
+	struct sti_platform_data *priv = snd_soc_dai_get_drvdata(dai);
+	struct sti_platform_dai *dai_data = priv_to_dai_data(priv, dai->id);
+	struct uniperif *uni = dai_data->uni;
+
+	if (uni->ops->open)
+		return uni->ops->open(uni);
+	return 0;
+}
+
+static void sti_platform_dai_shutdown(struct snd_pcm_substream *substream,
+				      struct snd_soc_dai *dai)
+{
+	struct sti_platform_data *priv = snd_soc_dai_get_drvdata(dai);
+	struct sti_platform_dai *dai_data = priv_to_dai_data(priv, dai->id);
+	struct uniperif *uni = dai_data->uni;
+
+	if (uni->ops->close)
+		uni->ops->close(uni);
+}
+
+static int sti_platform_dai_prepare(struct snd_pcm_substream *substream,
+				    struct snd_soc_dai *dai)
+{
+	struct sti_platform_data *priv = snd_soc_dai_get_drvdata(dai);
+	struct sti_platform_dai *dai_data = priv_to_dai_data(priv, dai->id);
+	struct uniperif *uni = dai_data->uni;
+
+	if (uni->ops->prepare)
+		return uni->ops->prepare(uni, substream->runtime);
+
+	return 0;
+}
+
+static int sti_platform_dai_trigger(struct snd_pcm_substream *substream,
+				    int cmd, struct snd_soc_dai *dai)
+{
+	struct sti_platform_data *priv = snd_soc_dai_get_drvdata(dai);
+	struct sti_platform_dai *dai_data = priv_to_dai_data(priv, dai->id);
+	struct uniperif *uni = dai_data->uni;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+	if (uni->ops->trigger)
+		return uni->ops->trigger(uni, SNDRV_PCM_TRIGGER_START);
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	if (uni->ops->trigger)
+		return uni->ops->trigger(uni, SNDRV_PCM_TRIGGER_STOP);
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int sti_platform_dai_hw_params(struct snd_pcm_substream *substream,
+				      struct snd_pcm_hw_params *params,
+				      struct snd_soc_dai *dai)
+{
+	struct sti_platform_data *priv = snd_soc_dai_get_drvdata(dai);
+	struct sti_platform_dai *dai_data = priv_to_dai_data(priv, dai->id);
+	struct snd_dmaengine_dai_dma_data *dma_data = &dai_data->dma_data;
+	int transfer_size;
+
+	transfer_size = params_channels(params) * UNIPERIF_FIFO_FRAMES;
+
+	dma_data = snd_soc_dai_get_dma_data(dai, substream);
+	dma_data->maxburst = transfer_size;
+
+	return 0;
+}
+
+static int sti_platform_dai_set_fmt(struct snd_soc_dai *dai,
+				    unsigned int fmt)
+{
+	struct sti_platform_data *priv = snd_soc_dai_get_drvdata(dai);
+	struct sti_platform_dai *dai_data = priv_to_dai_data(priv, dai->id);
+
+	dai_data->uni->daifmt = fmt;
+	return 0;
+}
+
+static int sti_platform_dai_set_clkdiv(struct snd_soc_dai *dai, int div_id,
+				       int div)
+{
+	struct sti_platform_data *priv = snd_soc_dai_get_drvdata(dai);
+	struct sti_platform_dai *dai_data = priv_to_dai_data(priv, dai->id);
+
+	dai_data->uni->clk_div = div;
+
+	return 0;
+}
+
+static int sti_platform_dai_suspend(struct snd_soc_dai *dai)
+{
+	struct sti_platform_data *priv = snd_soc_dai_get_drvdata(dai);
+	struct sti_platform_dai *dai_data = priv_to_dai_data(priv, dai->id);
+	struct uniperif *uni = dai_data->uni;
+
+	if (uni->ops->trigger)
+		return uni->ops->trigger(uni, SNDRV_PCM_TRIGGER_SUSPEND);
+
+	return 0;
+}
+
+static int sti_platform_dai_resume(struct snd_soc_dai *dai)
+{
+	struct sti_platform_data *priv = snd_soc_dai_get_drvdata(dai);
+	struct sti_platform_dai *dai_data = priv_to_dai_data(priv, dai->id);
+	struct uniperif *uni = dai_data->uni;
+
+	if (uni->ops->trigger)
+		return uni->ops->trigger(uni, SNDRV_PCM_TRIGGER_RESUME);
+
+	return 0;
+}
+
+static int sti_platform_dai_probe(struct snd_soc_dai *dai)
+{
+	struct sti_platform_data *ptf_data = snd_soc_dai_get_drvdata(dai);
+
+	if (ptf_data->dai_data[0].stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dai->playback_dma_data = &ptf_data->dai_data[dai->id].dma_data;
+	else
+		dai->capture_dma_data = &ptf_data->dai_data[dai->id].dma_data;
+
+	return 0;
+}
+
+static struct snd_soc_dai_ops sti_platform_dai_ops[] = {
+	{
+		.startup = sti_platform_dai_startup,
+		.shutdown = sti_platform_dai_shutdown,
+		.prepare = sti_platform_dai_prepare,
+		.trigger = sti_platform_dai_trigger,
+		.hw_params = sti_platform_dai_hw_params,
+		.set_fmt = sti_platform_dai_set_fmt,
+		.set_clkdiv = sti_platform_dai_set_clkdiv,
+	}
+};
+
+static const struct snd_soc_dai_driver sti_platform_dai_template = {
+	.probe = sti_platform_dai_probe,
+	.ops = sti_platform_dai_ops,
+	.suspend = sti_platform_dai_suspend,
+	.resume = sti_platform_dai_resume
+};
+
+static const struct snd_soc_component_driver sti_platform_dai_component = {
+	.name = "sti_cpu_dai",
+};
+
+/* PCM */
+
+static void sti_dma_complete(void *arg)
+{
+	struct snd_pcm_substream *substream = arg;
+
+	snd_pcm_period_elapsed(substream);
+}
+
+static int sti_pcm_open(struct snd_pcm_substream *substream)
+{
+	int ret = 0;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct sti_pcm_dma_params *params;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct sti_platform_data *priv = snd_soc_dai_get_drvdata(rtd->cpu_dai);
+	struct sti_platform_dai *dai_data = priv_to_dai_data(priv,
+							     rtd->cpu_dai->id);
+
+	params = kzalloc(sizeof(*params), GFP_KERNEL);
+	if (!params)
+		return -ENOMEM;
+
+	ret = snd_soc_set_runtime_hwparams(substream, dai_data->uni->hw);
+	if (ret < 0) {
+		dev_err(rtd->dev, "error on FE hw_constraint\n");
+		return ret;
+	}
+
+	/* Ensure that buffer size is a multiple of period size */
+	ret = snd_pcm_hw_constraint_integer(runtime,
+					    SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0) {
+		dev_err(rtd->dev, "Error: pcm hw constraints failed (%d)\n",
+			ret);
+		return ret;
+	}
+
+	/* update private data */
+	runtime->private_data = params;
+
+	return ret;
+}
+
+static int sti_pcm_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct sti_pcm_dma_params *dma_params = runtime->private_data;
+	int size, ret = 0;
+
+	size = params_buffer_bytes(params);
+
+	/* use PCM Lib */
+	ret = snd_pcm_lib_malloc_pages(substream, size);
+	if (ret < 0) {
+		dev_err(rtd->dev, "Can't allocate pages!\n");
+		return -ENOMEM;
+	}
+
+	return snd_dmaengine_pcm_prepare_slave_config(substream, params,
+						     &dma_params->slave_config);
+}
+
+static int sti_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct sti_pcm_dma_params *params = runtime->private_data;
+	struct sti_platform_data *priv = snd_soc_dai_get_drvdata(rtd->cpu_dai);
+	struct sti_platform_dai *dai_data = priv_to_dai_data(priv,
+							     rtd->cpu_dai->id);
+	int ret;
+	char prop[5];
+
+	if (!params->dma_channel) {
+		if (dai_data->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			snprintf(prop, sizeof(prop), "tx-%d", rtd->cpu_dai->id);
+		else
+			snprintf(prop, sizeof(prop), "rx-%d", rtd->cpu_dai->id);
+
+		params->dma_channel =
+			dma_request_slave_channel(rtd->platform->dev, prop);
+		if (!params->dma_channel) {
+			dev_err(rtd->dev, "Failed to request DMA channel");
+			return -ENODEV;
+		}
+	}
+	ret = dmaengine_slave_config(params->dma_channel,
+				     &params->slave_config);
+	if (ret)
+		dev_err(rtd->dev, "Failed to configure DMA channel");
+
+	return ret;
+}
+
+static int sti_pcm_trigger(struct snd_pcm_substream *substream,
+			   int cmd)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct sti_pcm_dma_params *params = runtime->private_data;
+	enum dma_transfer_direction direction;
+	struct dma_async_tx_descriptor *desc;
+	unsigned long flags = DMA_CTRL_ACK;
+	int ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		direction = snd_pcm_substream_to_dma_direction(substream);
+
+		desc = dmaengine_prep_dma_cyclic(
+				params->dma_channel,	runtime->dma_addr,
+				snd_pcm_lib_buffer_bytes(substream),
+				snd_pcm_lib_period_bytes(substream),
+				direction, flags);
+		if (!desc) {
+			dev_err(rtd->dev, "Failed to prepare DMA descriptor");
+			return -ENOMEM;
+		}
+
+		/* Set the dma callback */
+		desc->callback = sti_dma_complete;
+		desc->callback_param = substream;
+
+		/* Submit dma descriptor */
+		params->dma_cookie = dmaengine_submit(desc);
+		dma_async_issue_pending(params->dma_channel);
+		break;
+
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		if (params->dma_channel)
+			ret = dmaengine_terminate_all(params->dma_channel);
+		break;
+	default:
+		dev_err(rtd->dev, "%s: ERROR: Invalid command in pcm trigger!\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static snd_pcm_uframes_t sti_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct sti_pcm_dma_params *prtd = runtime->private_data;
+	struct dma_tx_state state;
+	enum dma_status status;
+	unsigned int buf_size;
+	unsigned int pos = 0;
+
+	status = dmaengine_tx_status(prtd->dma_channel, prtd->dma_cookie,
+				     &state);
+	if (status == DMA_IN_PROGRESS || status == DMA_PAUSED) {
+		buf_size = snd_pcm_lib_buffer_bytes(substream);
+		if (state.residue > 0 && state.residue <= buf_size)
+			pos = buf_size - state.residue;
+	}
+
+	return bytes_to_frames(substream->runtime, pos);
+}
+
+static int sti_pcm_close(struct snd_pcm_substream *substream)
+{
+	struct sti_pcm_dma_params *params;
+
+	params = substream->runtime->private_data;
+	if (params->dma_channel) {
+		dma_release_channel(params->dma_channel);
+		params->dma_channel = NULL;
+	}
+	kfree(params);
+
+	return 0;
+}
+
+int sti_pcm_new(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_pcm *pcm = rtd->pcm;
+	struct snd_card *card = rtd->card->snd_card;
+	int ret = 0;
+
+	ret = sti_platform_dai_create_ctrl(rtd);
+	if (ret < 0)
+		return ret;
+	else
+		return snd_pcm_lib_preallocate_pages_for_all(
+			pcm, SNDRV_DMA_TYPE_DEV, card->dev,
+			STI_PLATFORM_BUFFER_BYTES_MAX,
+			STI_PLATFORM_BUFFER_BYTES_MAX);
+}
+
+static struct snd_pcm_ops sti_pcm_ops = {
+	.open		= sti_pcm_open,
+	.close		= sti_pcm_close,
+	.hw_params	= sti_pcm_hw_params,
+	.prepare	= sti_pcm_prepare,
+	.hw_free	= snd_pcm_lib_free_pages,
+	.trigger	= sti_pcm_trigger,
+	.pointer	= sti_pcm_pointer
+};
+
+static struct snd_soc_platform_driver sti_platform_platform = {
+	.ops		= &sti_pcm_ops,
+	.pcm_new	= sti_pcm_new,
+};
+
+static int sti_platform_cpu_dai_of(struct device_node *node,
+				   struct sti_platform_data *priv, int idx)
+{
+	const char *str;
+	int ret, i;
+	struct device *dev = &priv->pdev->dev;
+	struct sti_platform_dai *dai_data = &priv->dai_data[idx];
+	struct snd_soc_dai_driver *dai = &priv->dai[idx];
+	struct snd_soc_pcm_stream *stream;
+	struct uniperif *uni;
+	struct {
+		char *name;
+		struct sti_platform_dai *val;
+	} of_fmt_table[] = {
+		{ "uni-reader", &uni_reader },
+		{ "uni-player",	&uni_player },
+	};
+
+	*dai = sti_platform_dai_template;
+	ret = of_property_read_string(node, "dai-name", &str);
+	if (ret < 0) {
+		dev_err(dev, "%s: dai name missing.\n", __func__);
+		return -EINVAL;
+	}
+	dai->name = str;
+
+	ret = of_property_read_string(node, "dai-type", &str);
+	if (ret == 0) {
+		ret = -EINVAL;
+		for (i = 0; i < ARRAY_SIZE(of_fmt_table); i++)
+			if (strcmp(str, of_fmt_table[i].name) == 0) {
+				*dai_data = *of_fmt_table[i].val;
+				ret = 0;
+				break;
+			}
+	}
+	if (ret < 0) {
+		dev_err(dev, "%s: invalid dai-type.\n", __func__);
+		return -EINVAL;
+	}
+
+	/* Initialise uniperif */
+	if (!dai_data->init) {
+		dev_err(dev, "%s: context data missing.\n", __func__);
+		return -EINVAL;
+	}
+
+	ret = dai_data->init(priv->pdev, node,
+			     &dai_data->uni, idx);
+	if (ret < 0) {
+		dev_err(dev, "%s: ERROR: Fail to init uniperif ( %d)!\n",
+			__func__, ret);
+		return ret;
+	}
+
+	uni = dai_data->uni;
+
+	if (priv->dai_data->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		stream = &dai->playback;
+	else
+		stream = &dai->capture;
+
+	stream->stream_name = dai->name;
+	stream->channels_min = uni->hw->channels_min;
+	stream->channels_max = uni->hw->channels_max;
+	stream->rates = uni->hw->rates;
+	stream->formats = uni->hw->formats;
+
+	/* DMA settings*/
+	dai_data->dma_data.addr = uni->fifo_phys_address;
+	dai_data->dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+
+	return 0;
+}
+
+static int sti_platform_engine_probe(struct platform_device *pdev)
+{
+	/* Driver can not use snd_dmaengine_pcm_register.
+	 * Reason is that DMA needs to load a firmware.This firmware is not
+	 * loaded during the probe, because filesystem is not mounted.
+	 */
+
+	struct sti_platform_data *priv;
+	struct device_node *node = pdev->dev.of_node;
+	int num_dais, ret;
+
+	/* Get the number of DAI links */
+	if (node && of_get_child_by_name(node, "cpu-dai"))
+		num_dais = of_get_child_count(node);
+	else
+		num_dais = 1;
+
+	/* Allocate the private data and the CPU_DAI array */
+	priv = devm_kzalloc(&pdev->dev,
+			    sizeof(*priv) +
+			    sizeof(struct sti_platform_dai) * num_dais,
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	priv->dai = devm_kzalloc(&pdev->dev, sizeof(*priv->dai) * num_dais,
+				 GFP_KERNEL);
+	if (!priv->dai)
+		return -ENOMEM;
+
+	priv->pdev = pdev;
+
+	if (of_get_child_by_name(node, "cpu-dai")) {
+		struct device_node *np = NULL;
+		int i = 0;
+
+		for_each_child_of_node(node, np) {
+			ret = sti_platform_cpu_dai_of(np, priv, i);
+			if (ret < 0) {
+				of_node_put(np);
+				return ret;
+			}
+			i++;
+		}
+	}
+
+	dev_set_drvdata(&pdev->dev, priv);
+
+	ret = snd_soc_register_component(&pdev->dev,
+					 &sti_platform_dai_component,
+					 priv->dai, num_dais);
+	if (ret < 0)
+		return ret;
+
+	/* Driver can not use snd_dmaengine_pcm_register.
+	 * Reason is that DMA needs to load a firmware.
+	 * This firmware is loaded on request_channel from file system.
+	 * SO can not be done in probe while alsa card enumerated before
+	 * file system is mounted
+	 */
+
+	return snd_soc_register_platform(&pdev->dev, &sti_platform_platform);
+}
+
+static int sti_platform_engine_remove(struct platform_device *pdev)
+{
+	struct sti_platform_data *priv = dev_get_drvdata(&pdev->dev);
+	struct sti_platform_dai *dai_data = priv->dai_data;
+	struct device_node *node = pdev->dev.of_node;
+	int num_dais, idx;
+
+	/* Get the number of DAI links */
+	if (node && of_get_child_by_name(node, "cpu-dai"))
+		num_dais = of_get_child_count(node);
+	else
+		num_dais = 1;
+
+	for (idx = 0; idx < num_dais; idx++) {
+		dai_data->remove(pdev);
+		dai_data++;
+	}
+
+	snd_soc_unregister_platform(&pdev->dev);
+
+	return 0;
+}
+
+static const struct of_device_id snd_soc_sti_match[] = {
+	{ .compatible = "st,sti-audio-platform", },
+	{},
+};
+
+static struct platform_driver sti_platform_driver = {
+	.driver = {
+		.name = "sti-audio-platform",
+		.owner = THIS_MODULE,
+		.of_match_table = snd_soc_sti_match,
+	},
+	.probe = sti_platform_engine_probe,
+	.remove = sti_platform_engine_remove
+};
+module_platform_driver(sti_platform_driver);
+
+MODULE_DESCRIPTION("audio soc platform driver for STI platforms");
+MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
+MODULE_LICENSE("GPL");
-- 
1.9.1
