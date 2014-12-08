From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch v2 04/11] ASoC: codec: Add Maxim codec driver
Date: Mon,  8 Dec 2014 14:01:06 -0800
Message-ID: <1418076073-12623-5-git-send-email-kwestfie@codeaurora.org>
References: <1418076073-12623-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1418076073-12623-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Add codec driver for the MAX98357A DAC.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 sound/soc/codecs/max98357a.c | 267 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 267 insertions(+)
 create mode 100644 sound/soc/codecs/max98357a.c

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
new file mode 100644
index 0000000000000000000000000000000000000000..16def09e98c2318a73e136d92f0c53c81313f10f
--- /dev/null
+++ b/sound/soc/codecs/max98357a.c
@@ -0,0 +1,267 @@
+/* Copyright (c) 2010-2011,2013-2014 The Linux Foundation. All rights reserved.
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
+#include <linux/module.h>
+#include <linux/gpio.h>
+#include <sound/soc.h>
+
+#define DRV_NAME "max98357a-codec"
+
+enum pinctrl_pin_state {
+	STATE_DISABLED = 0,
+	STATE_ENABLED = 1
+};
+static const char * const pin_states[] = {"Disabled", "Enabled"};
+
+struct max98357a_codec_pinctrl {
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *disabled;
+	struct pinctrl_state *enabled;
+	enum pinctrl_pin_state curr_state;
+};
+
+struct max98357a_codec_data {
+	struct gpio_desc *dac;
+	struct max98357a_codec_pinctrl mi2s;
+};
+
+static int max98357a_codec_set_pinctrl(struct max98357a_codec_pinctrl *mi2s)
+{
+	int ret;
+
+	pr_debug("%s: curr_state = %s\n", __func__,
+			pin_states[mi2s->curr_state]);
+
+	switch (mi2s->curr_state) {
+	case STATE_DISABLED:
+		ret = pinctrl_select_state(mi2s->pinctrl, mi2s->enabled);
+		if (ret) {
+			pr_err("%s: pinctrl_select_state failed with %d\n",
+					__func__, ret);
+			return -EIO;
+		}
+		mi2s->curr_state = STATE_ENABLED;
+		break;
+	case STATE_ENABLED:
+		pr_err("%s: MI2S pins already enabled\n", __func__);
+		break;
+	default:
+		pr_err("%s: MI2S pin state is invalid: %d\n", __func__,
+				mi2s->curr_state);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int max98357a_codec_reset_pinctrl(struct max98357a_codec_pinctrl *mi2s)
+{
+	int ret;
+
+	pr_debug("%s: curr_state = %s\n", __func__,
+			pin_states[mi2s->curr_state]);
+
+	switch (mi2s->curr_state) {
+	case STATE_ENABLED:
+		ret = pinctrl_select_state(mi2s->pinctrl, mi2s->disabled);
+		if (ret) {
+			pr_err("%s: pinctrl_select_state failed with %d\n",
+					__func__, ret);
+			return -EIO;
+		}
+		mi2s->curr_state = STATE_DISABLED;
+		break;
+	case STATE_DISABLED:
+		pr_err("%s: MI2S pins already disabled\n", __func__);
+		break;
+	default:
+		pr_err("%s: MI2S pin state is invalid: %d\n", __func__,
+				mi2s->curr_state);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int max98357a_codec_get_pinctrl(struct snd_soc_dai *dai)
+{
+	int ret;
+	struct max98357a_codec_data *prtd = snd_soc_dai_get_drvdata(dai);
+	struct max98357a_codec_pinctrl *mi2s = &prtd->mi2s;
+	struct pinctrl *pinctrl;
+
+	pinctrl = devm_pinctrl_get(dai->dev);
+	if (IS_ERR_OR_NULL(pinctrl)) {
+		dev_err(dai->dev, "%s: Unable to get pinctrl handle: %d\n",
+				__func__, PTR_ERR_OR_ZERO(pinctrl));
+		return -EINVAL;
+	}
+	mi2s->pinctrl = pinctrl;
+
+	/* get all the states handles from Device Tree */
+	mi2s->disabled = pinctrl_lookup_state(pinctrl, "mi2s-disabled");
+	if (IS_ERR(mi2s->disabled)) {
+		dev_err(dai->dev, "%s: could not get disabled pinstate: %d\n",
+				__func__, PTR_ERR_OR_ZERO(mi2s->disabled));
+		return -EINVAL;
+	}
+
+	mi2s->enabled = pinctrl_lookup_state(pinctrl, "mi2s-enabled");
+	if (IS_ERR(mi2s->enabled)) {
+		dev_err(dai->dev, "%s: could not get enabled pinstate: %d\n",
+				__func__, PTR_ERR_OR_ZERO(mi2s->enabled));
+		return -EINVAL;
+	}
+
+	/* Reset the MI2S pins to the disabled state */
+	ret = pinctrl_select_state(mi2s->pinctrl, mi2s->disabled);
+	if (ret) {
+		dev_err(dai->dev, "%s: Disable MI2S pins failed with %d\n",
+				__func__, ret);
+		return -EIO;
+	}
+	mi2s->curr_state = STATE_DISABLED;
+
+	return 0;
+}
+
+static int max98357a_codec_daiops_startup(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	int ret;
+	struct max98357a_codec_data *prtd = snd_soc_dai_get_drvdata(dai);
+
+	ret = max98357a_codec_set_pinctrl(&prtd->mi2s);
+	if (ret) {
+		dev_err(dai->dev, "%s: MI2S pinctrl set failed with %d\n",
+				__func__, ret);
+		return ret;
+	}
+
+	gpiod_set_value(prtd->dac, 1);
+
+	return 0;
+}
+
+static void max98357a_codec_daiops_shutdown(
+		struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
+{
+	int ret;
+	struct max98357a_codec_data *prtd = snd_soc_dai_get_drvdata(dai);
+
+	gpiod_set_value(prtd->dac, 0);
+
+	ret = max98357a_codec_reset_pinctrl(&prtd->mi2s);
+	if (ret)
+		dev_err(dai->dev, "%s: MI2S pinctrl set failed with %d\n",
+				__func__, ret);
+}
+
+static struct snd_soc_dai_ops max98357a_codec_dai_ops = {
+	.startup	= max98357a_codec_daiops_startup,
+	.shutdown	= max98357a_codec_daiops_shutdown,
+};
+
+static int max98357a_codec_dai_probe(struct snd_soc_dai *dai)
+{
+	int ret;
+	struct max98357a_codec_data *prtd = snd_soc_dai_get_drvdata(dai);
+
+	prtd->dac = devm_gpiod_get(dai->dev, "dac");
+	if (IS_ERR(prtd->dac)) {
+		dev_err(dai->dev, "unable to get DAC GPIO\n");
+		return PTR_ERR(prtd->dac);
+	}
+	gpiod_direction_output(prtd->dac, 0);
+
+	ret = max98357a_codec_get_pinctrl(dai);
+	if (ret) {
+		dev_err(dai->dev, "%s: Parsing MI2S pinctrl failed: %d\n",
+				__func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_dai_driver max98357a_codec_dai_driver = {
+	.name = "max98357a-codec-dai",
+	.playback = {
+		.stream_name	= "max98357a-codec-playback",
+		.formats	= SNDRV_PCM_FMTBIT_S16 |
+					SNDRV_PCM_FMTBIT_S24 |
+					SNDRV_PCM_FMTBIT_S32,
+		.rates		= SNDRV_PCM_RATE_8000 |
+					SNDRV_PCM_RATE_16000 |
+					SNDRV_PCM_RATE_48000 |
+					SNDRV_PCM_RATE_96000,
+		.rate_min	= 8000,
+		.rate_max	= 96000,
+		.channels_min	= 1,
+		.channels_max	= 2,
+	},
+	.probe = &max98357a_codec_dai_probe,
+	.ops = &max98357a_codec_dai_ops,
+};
+
+static int max98357a_codec_platform_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct max98357a_codec_data *prtd;
+	struct snd_soc_codec_driver *codec_driver;
+
+	prtd = devm_kzalloc(&pdev->dev, sizeof(struct max98357a_codec_data),
+			GFP_KERNEL);
+	if (!prtd)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, prtd);
+
+	codec_driver = devm_kzalloc(&pdev->dev,
+			sizeof(struct snd_soc_codec_driver), GFP_KERNEL);
+	if (!codec_driver)
+		return -ENOMEM;
+
+	ret = snd_soc_register_codec(&pdev->dev, codec_driver,
+			&max98357a_codec_dai_driver, 1);
+	if (ret)
+		dev_err(&pdev->dev, "%s: error registering codec dais\n",
+				__func__);
+
+	return ret;
+}
+
+static int max98357a_codec_platform_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
+
+	return 0;
+}
+
+static const struct of_device_id max98357a_codec_dt_match[] = {
+	{ .compatible = "qcom,max98357a-codec", },
+	{}
+};
+
+static struct platform_driver max98357a_codec_platform_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.of_match_table = max98357a_codec_dt_match,
+	},
+	.probe	= max98357a_codec_platform_probe,
+	.remove = max98357a_codec_platform_remove,
+};
+module_platform_driver(max98357a_codec_platform_driver);
+
+MODULE_DESCRIPTION("QCOM MAX98357A CODEC DRIVER");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_DEVICE_TABLE(of, max98357a_codec_dt_match);
-- 
1.8.2.1
