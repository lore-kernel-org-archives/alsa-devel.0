From: srinivas.kandagatla@linaro.org
Subject: [RFC PATCH 8/9] ASoC: qcom: apq8096: Add db820c machine driver
Date: Fri, 11 Aug 2017 15:29:51 +0200
Message-ID: <20170811132952.32572-9-srinivas.kandagatla@linaro.org>
References: <20170811132952.32572-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170811132952.32572-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org, kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org, lkasam@qti.qualcomm.com, sboyd@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

uThis patch adds support to DB820c machine driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,apq8096.txt     |  85 ++++++++++
 sound/soc/qcom/Kconfig                             |   9 +-
 sound/soc/qcom/Makefile                            |   2 +
 sound/soc/qcom/apq8096.c                           | 174 +++++++++++++++++++++
 4 files changed, 269 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8096.txt
 create mode 100644 sound/soc/qcom/apq8096.c

diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8096.txt b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
new file mode 100644
index 0000000..cf6a15b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
@@ -0,0 +1,85 @@
+* Qualcomm Technologies APQ8096 ASoC sound card driver
+
+This binding describes the APQ8096 sound card, which uses qdsp for audio.
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,apq8096-sndcard"
+
+= FRONTEND and BACKEND dailinks
+Each subnode of sndcard represents either frontend or backend dailink,
+and subnodes of each backend/frontend dailinks would be
+cpu/codec/platform dais.
+
+- fe:
+	Usage: required
+	Value type: <subnode>
+	Definition: FrontEnd CPU dailink sub-node
+
+- be:
+	Usage: required
+	Value type: <subnode>
+	Definition: BackEnd dailink sub-node
+
+- link-name:
+	Usage: required
+	Value type: <string>msm_dai_q6_hdmi
+	Definition: User friendly name for dai link
+
+- is-fe:
+	Usage: optional
+	Value type: <bool>
+	Definition: present if the dailink is frontend
+
+
+= CPU, PLATFORM, CODEC dais subnodes
+- cpu:
+	Usage: required
+	Value type: <subnode>
+	Definition: cpu dai sub-node
+
+- codec:
+	Usage: required
+	Value type: <subnode>
+	Definition: codec dai sub-node
+
+- platform:
+	Usage: opional
+	Value type: <subnode>
+	Definition: platform dai sub-node
+
+- sound-dai:
+	Usage: required
+	Value type: <phandle>
+	Definition: phandle/s and port of CPU/CODEC/PLATFORM dais
+
+Example:
+	sound {
+		compatible	= "qcom,snd-apq8096";
+		qcom,model = "DB820c";
+
+		fe@1 {
+			is-fe;
+			link-name = "MultiMedia1 PCM";
+			cpu {
+				sound-dai = <&pcm  MSM_FRONTEND_DAI_MULTIMEDIA1>;
+			};
+			platform {
+				sound-dai = <&pcm  MSM_FRONTEND_DAI_MULTIMEDIA1>;
+			};
+		};
+
+		be@1 {
+			link-name = "HDMI";
+			cpu {
+				sound-dai = <&hdmi_dai>;
+			};
+			platform {
+				sound-dai = <&routing>;
+			};
+			codec {
+				sound-dai = <&hdmi>;
+			};
+		};
+	};
diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index a2aa480..c190d11 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -68,7 +68,6 @@ config SND_SOC_QDSP6V2_PCM
 	tristate
 	default n
 
-
 config SND_SOC_QDSP6V2
 	tristate "SoC ALSA audio driver for QDSP6V2"
 	select SND_SOC_QDSP6V2_AFE
@@ -82,3 +81,11 @@ config SND_SOC_QDSP6V2
 	 This will enable sound soc platform specific
 	 audio drivers. This includes q6asm, q6adm,
 	 q6afe interfaces to DSP using apr.
+
+config SND_SOC_MSM8996
+	tristate "SoC Machine driver for MSM8996 and APQ8096 boards"
+	select SND_SOC_QDSP6V2
+	default n
+	help
+	 To add support for SoC audio on MSM8996 and APQ8096 boards
+
diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
index a51bf0a..f3889c4 100644
--- a/sound/soc/qcom/Makefile
+++ b/sound/soc/qcom/Makefile
@@ -12,9 +12,11 @@ obj-$(CONFIG_SND_SOC_LPASS_APQ8016) += snd-soc-lpass-apq8016.o
 # Machine
 snd-soc-storm-objs := storm.o
 snd-soc-apq8016-sbc-objs := apq8016_sbc.o
+snd-soc-msm8996-objs := apq8096.o
 
 obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
 obj-$(CONFIG_SND_SOC_APQ8016_SBC) += snd-soc-apq8016-sbc.o
+obj-$(CONFIG_SND_SOC_MSM8996) += snd-soc-msm8996.o
 
 #DSP lib
 obj-$(CONFIG_SND_SOC_QDSP6V2) += qdsp6v2/
diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
new file mode 100644
index 0000000..de62613
--- /dev/null
+++ b/sound/soc/qcom/apq8096.c
@@ -0,0 +1,174 @@
+/*
+ * Copyright (c) 2017 The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/pcm.h>
+#include <dt-bindings/sound/qcom,afe.h>
+#include <dt-bindings/sound/qcom,asm.h>
+
+int msm8996_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
+					      struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *rate = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_CHANNELS);
+
+	rate->min = rate->max = 48000;
+	channels->min = channels->max = 2;
+
+	return 0;
+}
+
+static int apq8096_sbc_parse_of(struct snd_soc_card *card)
+{
+	struct device *dev = card->dev;
+	struct snd_soc_dai_link *link;
+	struct device_node *np, *codec, *platform, *cpu, *node  = dev->of_node;
+	int ret, num_links;
+	bool is_fe;
+
+	ret = snd_soc_of_parse_card_name(card, "qcom,model");
+	if (ret) {
+		dev_err(dev, "Error parsing card name: %d\n", ret);
+		return ret;
+	}
+
+	num_links = of_get_child_count(node);
+
+	/* Allocate the private data and the DAI link array */
+	card->dai_link = devm_kzalloc(dev, sizeof(*link) * num_links,
+				      GFP_KERNEL);
+	if (!card->dai_link)
+		return -ENOMEM;
+
+	card->num_links	= num_links;
+
+	link = &card->dai_link[0];
+
+	for_each_child_of_node(node, np) {
+		is_fe = false;
+		if (of_property_read_bool(np, "is-fe"))
+			is_fe = true;
+
+		if (is_fe) {
+			/* BE is dummy */
+			link->codec_of_node	= NULL;
+			link->codec_dai_name	= "snd-soc-dummy-dai";
+			link->codec_name	= "snd-soc-dummy";
+
+			/* FE settings */
+			link->dynamic		= 1;
+			link->dpcm_playback = 1;
+
+		} else {
+			link->no_pcm = 1;
+			link->dpcm_playback = 1;
+			link->be_hw_params_fixup = msm8996_be_hw_params_fixup;
+		}
+
+		cpu = of_get_child_by_name(np, "cpu");
+		platform = of_get_child_by_name(np, "platform");
+		codec = of_get_child_by_name(np, "codec");
+
+		if (!cpu) {
+			dev_err(dev, "Can't find cpu DT node\n");
+			return -EINVAL;
+		}
+
+		link->cpu_of_node = of_parse_phandle(cpu, "sound-dai", 0);
+		if (!link->cpu_of_node) {
+			dev_err(card->dev, "error getting cpu phandle\n");
+			return -EINVAL;
+		}
+
+		link->platform_of_node = of_parse_phandle(platform,
+							  "sound-dai", 0);
+		if (!link->platform_of_node) {
+			dev_err(card->dev, "error getting platform phandle\n");
+			return -EINVAL;
+		}
+
+		ret = snd_soc_of_get_dai_name(cpu, &link->cpu_dai_name);
+		if (ret) {
+			dev_err(card->dev, "error getting cpu dai name\n");
+			return ret;
+		}
+
+		if (codec) {
+			ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
+
+			if (ret < 0) {
+				dev_err(card->dev, "error getting codec dai name\n");
+				return ret;
+			}
+		}
+
+		ret = of_property_read_string(np, "link-name", &link->name);
+		if (ret) {
+			dev_err(card->dev, "error getting codec dai_link name\n");
+			return ret;
+		}
+
+		link->stream_name = link->name;
+		link++;
+	}
+
+	return 0;
+}
+
+static int msm_snd_apq8096_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct snd_soc_card *card;
+
+	card = devm_kzalloc(&pdev->dev, sizeof(*card), GFP_KERNEL);
+	if (!card)
+		return -ENOMEM;
+
+	card->dev = &pdev->dev;
+	ret = apq8096_sbc_parse_of(card);
+	if (ret) {
+		dev_err(&pdev->dev, "Error parsing OF data\n");
+		return ret;
+	}
+
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
+	if (ret)
+		dev_err(&pdev->dev, "sound card register faile (%d)!\n", ret);
+
+	return ret;
+}
+
+static const struct of_device_id msm_snd_apq8096_dt_match[] = {
+	{.compatible = "qcom,apq8096-sndcard"},
+	{}
+};
+
+static struct platform_driver msm_snd_apq8096_driver = {
+	.probe  = msm_snd_apq8096_probe,
+	.driver = {
+		.name = "msm-snd-apq8096",
+		.owner = THIS_MODULE,
+		.of_match_table = msm_snd_apq8096_dt_match,
+	},
+};
+module_platform_driver(msm_snd_apq8096_driver);
+MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org");
+MODULE_DESCRIPTION("APQ8096 ASoC Machine Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.9.3
