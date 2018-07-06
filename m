From: Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v3 3/5] ASoC: qcom: add sdm845 sound card
	support
Date: Fri,  6 Jul 2018 15:13:13 +0530
Message-ID: <1530870195-13576-4-git-send-email-rohitkr@codeaurora.org>
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id AB03326720C
 for <alsa-devel@alsa-project.org>; Fri,  6 Jul 2018 11:43:54 +0200 (CEST)
In-Reply-To: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Rohit kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

This patch adds sdm845 audio machine driver support.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/Kconfig  |  10 ++
 sound/soc/qcom/Makefile |   2 +
 sound/soc/qcom/sdm845.c | 390 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 402 insertions(+)
 create mode 100644 sound/soc/qcom/sdm845.c

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 0e364b4..cf55f0a 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -93,3 +93,13 @@ config SND_SOC_MSM8996
 
 config SND_SOC_QCOM_COMMON
 	tristate
+
+config SND_SOC_SDM845
+	tristate "SoC Machine driver for SDM845 boards"
+	select SND_SOC_QDSP6
+	select SND_SOC_QCOM_COMMON
+	default n
+	help
+	  To add support for audio on Qualcomm Technologies Inc.
+	  SDM845 SoC-based systems.
+	  Say Y if you want to use audio device on this SoCs.
diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
index 1bcdbee..c9699fb 100644
--- a/sound/soc/qcom/Makefile
+++ b/sound/soc/qcom/Makefile
@@ -14,10 +14,12 @@ obj-$(CONFIG_SND_SOC_LPASS_APQ8016) += snd-soc-lpass-apq8016.o
 snd-soc-storm-objs := storm.o
 snd-soc-apq8016-sbc-objs := apq8016_sbc.o
 snd-soc-apq8096-objs := apq8096.o
+snd-soc-sdm845-objs := sdm845.o
 
 obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
 obj-$(CONFIG_SND_SOC_APQ8016_SBC) += snd-soc-apq8016-sbc.o
 obj-$(CONFIG_SND_SOC_MSM8996) += snd-soc-apq8096.o
+obj-$(CONFIG_SND_SOC_SDM845) += snd-soc-sdm845.o
 
 obj-$(CONFIG_SND_SOC_QCOM_COMMON) += common.o
 #DSP lib
diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
new file mode 100644
index 0000000..9ee3558
--- /dev/null
+++ b/sound/soc/qcom/sdm845.c
@@ -0,0 +1,390 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/atomic.h>
+#include <linux/of_device.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <linux/soc/qcom/apr.h>
+#include "common.h"
+#include "qdsp6/q6afe.h"
+
+#define DEFAULT_SAMPLE_RATE_48K		48000
+#define DEFAULT_MCLK_RATE		24576000
+#define DEFAULT_BCLK_RATE		1536000
+
+struct sdm845_snd_data {
+	struct snd_soc_card *card;
+	struct regulator *vdd_supply;
+	uint32_t pri_mi2s_clk_count;
+	uint32_t quat_tdm_clk_count;
+};
+
+
+static unsigned int tdm_slot_offset[8] = {0, 4, 8, 12, 16, 20, 24, 28};
+
+static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	int ret = 0;
+	int channels, slot_width;
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S32_LE:
+	case SNDRV_PCM_FORMAT_S24_LE:
+	case SNDRV_PCM_FORMAT_S16_LE:
+		slot_width = 32;
+		break;
+	default:
+		dev_err(rtd->dev, "%s: invalid param format 0x%x\n",
+				__func__, params_format(params));
+		return -EINVAL;
+	}
+
+	channels = params_channels(params);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0, 0x3,
+				channels, slot_width);
+		if (ret < 0) {
+			dev_err(rtd->dev, "%s: failed to set tdm slot, err:%d\n",
+					__func__, ret);
+			goto end;
+		}
+
+		ret = snd_soc_dai_set_channel_map(cpu_dai, 0, NULL,
+				channels, tdm_slot_offset);
+		if (ret < 0) {
+			dev_err(rtd->dev, "%s: failed to set channel map, err:%d\n",
+					__func__, ret);
+			goto end;
+		}
+	} else {
+		ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0xf, 0,
+				channels, slot_width);
+		if (ret < 0) {
+			dev_err(rtd->dev, "%s: failed to set tdm slot, err:%d\n",
+					__func__, ret);
+			goto end;
+		}
+
+		ret = snd_soc_dai_set_channel_map(cpu_dai, channels,
+				tdm_slot_offset, 0, NULL);
+		if (ret < 0) {
+			dev_err(rtd->dev, "%s: failed to set channel map, err:%d\n",
+					__func__, ret);
+			goto end;
+		}
+	}
+end:
+	return ret;
+}
+
+static int sdm845_snd_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	int ret = 0;
+
+	switch (cpu_dai->id) {
+	case QUATERNARY_TDM_RX_0:
+	case QUATERNARY_TDM_TX_0:
+		ret = sdm845_tdm_snd_hw_params(substream, params);
+		break;
+	default:
+		pr_err("%s: invalid dai id 0x%x\n", __func__, cpu_dai->id);
+		break;
+	}
+	return ret;
+}
+
+static int sdm845_snd_startup(struct snd_pcm_substream *substream)
+{
+	unsigned int fmt = SND_SOC_DAIFMT_CBS_CFS;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+
+	switch (cpu_dai->id) {
+	case PRIMARY_MI2S_RX:
+	case PRIMARY_MI2S_TX:
+		if (++(data->pri_mi2s_clk_count) == 1) {
+			snd_soc_dai_set_sysclk(cpu_dai,
+				Q6AFE_LPASS_CLK_ID_MCLK_1,
+				DEFAULT_MCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
+			snd_soc_dai_set_sysclk(cpu_dai,
+				Q6AFE_LPASS_CLK_ID_PRI_MI2S_IBIT,
+				DEFAULT_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
+		}
+		snd_soc_dai_set_fmt(cpu_dai, fmt);
+		break;
+
+	case QUATERNARY_TDM_RX_0:
+	case QUATERNARY_TDM_TX_0:
+		if (++(data->quat_tdm_clk_count) == 1) {
+			snd_soc_dai_set_sysclk(cpu_dai,
+				Q6AFE_LPASS_CLK_ID_QUAD_TDM_IBIT,
+				DEFAULT_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
+		}
+		break;
+
+	default:
+		pr_err("%s: invalid dai id 0x%x\n", __func__, cpu_dai->id);
+		break;
+	}
+	return 0;
+}
+
+static void  sdm845_snd_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+
+	switch (cpu_dai->id) {
+	case PRIMARY_MI2S_RX:
+	case PRIMARY_MI2S_TX:
+		if (--(data->pri_mi2s_clk_count) == 0) {
+			snd_soc_dai_set_sysclk(cpu_dai,
+				Q6AFE_LPASS_CLK_ID_MCLK_1,
+				0, SNDRV_PCM_STREAM_PLAYBACK);
+			snd_soc_dai_set_sysclk(cpu_dai,
+				Q6AFE_LPASS_CLK_ID_PRI_MI2S_IBIT,
+				0, SNDRV_PCM_STREAM_PLAYBACK);
+		};
+		break;
+
+	case QUATERNARY_TDM_RX_0:
+	case QUATERNARY_TDM_TX_0:
+		if (--(data->quat_tdm_clk_count) == 0) {
+			snd_soc_dai_set_sysclk(cpu_dai,
+				Q6AFE_LPASS_CLK_ID_QUAD_TDM_IBIT,
+				0, SNDRV_PCM_STREAM_PLAYBACK);
+		}
+		break;
+
+	default:
+		pr_err("%s: invalid dai id 0x%x\n", __func__, cpu_dai->id);
+		break;
+	}
+}
+
+static struct snd_soc_ops sdm845_be_ops = {
+	.hw_params = sdm845_snd_hw_params,
+	.startup = sdm845_snd_startup,
+	.shutdown = sdm845_snd_shutdown,
+};
+
+static int sdm845_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *rate = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_CHANNELS);
+
+	rate->min = rate->max = DEFAULT_SAMPLE_RATE_48K;
+	channels->min = channels->max = 2;
+
+	return 0;
+}
+
+static void sdm845_init_supplies(struct device *dev)
+{
+	struct snd_soc_card *card = dev_get_drvdata(dev);
+	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
+
+	data->vdd_supply = regulator_get(dev, "cdc-vdd");
+	if (IS_ERR(data->vdd_supply)) {
+		dev_err(dev, "Unable to get regulator supplies\n");
+		data->vdd_supply = NULL;
+		return;
+	}
+
+	if (regulator_enable(data->vdd_supply))
+		dev_err(dev, "Unable to enable vdd supply\n");
+}
+
+static void sdm845_deinit_supplies(struct device *dev)
+{
+	struct snd_soc_card *card = dev_get_drvdata(dev);
+	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
+
+	if (!data->vdd_supply)
+		return;
+
+	regulator_disable(data->vdd_supply);
+	regulator_put(data->vdd_supply);
+}
+
+static void sdm845_add_be_ops(struct snd_soc_card *card)
+{
+	struct snd_soc_dai_link *link = card->dai_link;
+	int i, num_links = card->num_links;
+
+	for (i = 0; i < num_links; i++) {
+		if (link->no_pcm == 1) {
+			link->ops = &sdm845_be_ops;
+			link->be_hw_params_fixup = sdm845_be_hw_params_fixup;
+		}
+		link++;
+	}
+}
+
+static int sdm845_bind(struct device *dev)
+{
+	struct snd_soc_card *card;
+	struct sdm845_snd_data *data;
+	int ret;
+
+	card = kzalloc(sizeof(*card), GFP_KERNEL);
+	if (!card)
+		return -ENOMEM;
+
+	/* Allocate the private data */
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	ret = component_bind_all(dev, card);
+	if (ret) {
+		dev_err(dev, "Audio components bind failed: %d\n", ret);
+		goto bind_fail;
+	}
+
+	dev_set_drvdata(dev, card);
+	card->dev = dev;
+	ret = qcom_snd_parse_of(card);
+	if (ret) {
+		dev_err(dev, "Error parsing OF data\n");
+		goto parse_dt_fail;
+	}
+
+	data->card = card;
+	snd_soc_card_set_drvdata(card, data);
+
+	sdm845_add_be_ops(card);
+
+	sdm845_init_supplies(dev);
+
+	ret = snd_soc_register_card(card);
+	if (ret) {
+		dev_err(dev, "Sound card registration failed\n");
+		goto register_card_fail;
+	}
+	return ret;
+
+register_card_fail:
+	sdm845_deinit_supplies(dev);
+	kfree(card->dai_link);
+parse_dt_fail:
+	component_unbind_all(dev, card);
+bind_fail:
+	kfree(data);
+	kfree(card);
+	return ret;
+}
+
+static void sdm845_unbind(struct device *dev)
+{
+	struct snd_soc_card *card = dev_get_drvdata(dev);
+	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
+
+	if (data->vdd_supply)
+		regulator_put(data->vdd_supply);
+	component_unbind_all(dev, card);
+	snd_soc_unregister_card(card);
+	kfree(card->dai_link);
+	kfree(data);
+	kfree(card);
+}
+
+static const struct component_master_ops sdm845_ops = {
+	.bind = sdm845_bind,
+	.unbind = sdm845_unbind,
+};
+
+static int sdm845_runtime_resume(struct device *dev)
+{
+	struct snd_soc_card *card = dev_get_drvdata(dev);
+	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
+
+	if (!data->vdd_supply) {
+		dev_dbg(dev, "no supplies defined\n");
+		return 0;
+	}
+
+	if (regulator_enable(data->vdd_supply))
+		dev_err(dev, "Enable regulator supply failed\n");
+
+	return 0;
+}
+
+static int sdm845_runtime_suspend(struct device *dev)
+{
+	struct snd_soc_card *card = dev_get_drvdata(dev);
+	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
+
+	if (!data->vdd_supply) {
+		dev_dbg(dev, "no supplies defined\n");
+		return 0;
+	}
+
+	if (regulator_disable(data->vdd_supply))
+		dev_err(dev, "Disable regulator supply failed\n");
+
+	return 0;
+}
+
+static const struct dev_pm_ops sdm845_pm_ops = {
+	SET_RUNTIME_PM_OPS(sdm845_runtime_suspend,
+			sdm845_runtime_resume, NULL)
+};
+
+static int sdm845_snd_platform_probe(struct platform_device *pdev)
+{
+	struct component_match *match = NULL;
+	int ret;
+
+	ret = qcom_snd_add_components(&pdev->dev, &match);
+	if (ret)
+		return ret;
+
+	return component_master_add_with_match(&pdev->dev, &sdm845_ops, match);
+}
+
+static int sdm845_snd_platform_remove(struct platform_device *pdev)
+{
+	component_master_del(&pdev->dev, &sdm845_ops);
+	return 0;
+}
+
+static const struct of_device_id sdm845_snd_device_id[]  = {
+	{ .compatible = "qcom,sdm845-sndcard" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sdm845_snd_device_id);
+
+static struct platform_driver sdm845_snd_driver = {
+	.probe = sdm845_snd_platform_probe,
+	.remove = sdm845_snd_platform_remove,
+	.driver = {
+		.name = "msm-snd-sdm845",
+		.pm = &sdm845_pm_ops,
+		.owner = THIS_MODULE,
+		.of_match_table = sdm845_snd_device_id,
+	},
+};
+module_platform_driver(sdm845_snd_driver);
+
+MODULE_DESCRIPTION("sdm845 ASoC Machine Driver");
+MODULE_LICENSE("GPL v2");
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
