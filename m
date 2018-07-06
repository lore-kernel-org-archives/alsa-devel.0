From: Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v3 5/5] ASoC: qcom: apq8096: Use common APIs to parse device nodes
Date: Fri,  6 Jul 2018 15:13:15 +0530
Message-ID: <1530870195-13576-6-git-send-email-rohitkr@codeaurora.org>
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Rohit kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

Use generic APIs exposed by common.c for parsing
dai link device tree nodes and adding slave components.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/Kconfig   |   1 +
 sound/soc/qcom/apq8096.c | 151 ++++-------------------------------------------
 2 files changed, 11 insertions(+), 141 deletions(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index cf55f0a..2be9cee 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -86,6 +86,7 @@ config SND_SOC_MSM8996
 	tristate "SoC Machine driver for MSM8996 and APQ8096 boards"
 	depends on QCOM_APR
 	select SND_SOC_QDSP6
+	select SND_SOC_QCOM_COMMON
 	help
           Support for Qualcomm Technologies LPASS audio block in
           APQ8096 SoC-based systems.
diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index cab8c4f..726fb73 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -9,6 +9,7 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 #include <sound/pcm.h>
+#include "common.h"
 
 static int apq8096_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 				      struct snd_pcm_hw_params *params)
@@ -24,109 +25,16 @@ static int apq8096_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-static int apq8096_sbc_parse_of(struct snd_soc_card *card)
+static void apq8096_add_be_ops(struct snd_soc_card *card)
 {
-	struct device_node *np;
-	struct device_node *codec = NULL;
-	struct device_node *platform = NULL;
-	struct device_node *cpu = NULL;
-	struct device *dev = card->dev;
-	struct snd_soc_dai_link *link;
-	int ret, num_links;
-
-	ret = snd_soc_of_parse_card_name(card, "qcom,model");
-	if (ret) {
-		dev_err(dev, "Error parsing card name: %d\n", ret);
-		return ret;
-	}
+	struct snd_soc_dai_link *link = card->dai_link;
+	int i, num_links = card->num_links;
 
-	/* DAPM routes */
-	if (of_property_read_bool(dev->of_node, "qcom,audio-routing")) {
-		ret = snd_soc_of_parse_audio_routing(card,
-					"qcom,audio-routing");
-		if (ret)
-			return ret;
-	}
-
-	/* Populate links */
-	num_links = of_get_child_count(dev->of_node);
-
-	/* Allocate the DAI link array */
-	card->dai_link = kcalloc(num_links, sizeof(*link), GFP_KERNEL);
-	if (!card->dai_link)
-		return -ENOMEM;
-
-	card->num_links	= num_links;
-	link = card->dai_link;
-
-	for_each_child_of_node(dev->of_node, np) {
-		cpu = of_get_child_by_name(np, "cpu");
-		if (!cpu) {
-			dev_err(dev, "Can't find cpu DT node\n");
-			ret = -EINVAL;
-			goto err;
-		}
-
-		link->cpu_of_node = of_parse_phandle(cpu, "sound-dai", 0);
-		if (!link->cpu_of_node) {
-			dev_err(card->dev, "error getting cpu phandle\n");
-			ret = -EINVAL;
-			goto err;
-		}
-
-		ret = snd_soc_of_get_dai_name(cpu, &link->cpu_dai_name);
-		if (ret) {
-			dev_err(card->dev, "error getting cpu dai name\n");
-			goto err;
-		}
-
-		platform = of_get_child_by_name(np, "platform");
-		codec = of_get_child_by_name(np, "codec");
-		if (codec && platform) {
-			link->platform_of_node = of_parse_phandle(platform,
-								  "sound-dai",
-								   0);
-			if (!link->platform_of_node) {
-				dev_err(card->dev, "platform dai not found\n");
-				ret = -EINVAL;
-				goto err;
-			}
-
-			ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
-			if (ret < 0) {
-				dev_err(card->dev, "codec dai not found\n");
-				goto err;
-			}
-			link->no_pcm = 1;
-			link->ignore_pmdown_time = 1;
+	for (i = 0; i < num_links; i++) {
+		if (link->no_pcm == 1)
 			link->be_hw_params_fixup = apq8096_be_hw_params_fixup;
-		} else {
-			link->platform_of_node = link->cpu_of_node;
-			link->codec_dai_name = "snd-soc-dummy-dai";
-			link->codec_name = "snd-soc-dummy";
-			link->dynamic = 1;
-		}
-
-		link->ignore_suspend = 1;
-		ret = of_property_read_string(np, "link-name", &link->name);
-		if (ret) {
-			dev_err(card->dev, "error getting codec dai_link name\n");
-			goto err;
-		}
-
-		link->dpcm_playback = 1;
-		link->dpcm_capture = 1;
-		link->stream_name = link->name;
 		link++;
 	}
-
-	return 0;
-err:
-	of_node_put(cpu);
-	of_node_put(codec);
-	of_node_put(platform);
-	kfree(card->dai_link);
-	return ret;
 }
 
 static int apq8096_bind(struct device *dev)
@@ -141,12 +49,14 @@ static int apq8096_bind(struct device *dev)
 	component_bind_all(dev, card);
 	card->dev = dev;
 	dev_set_drvdata(dev, card);
-	ret = apq8096_sbc_parse_of(card);
+	ret = qcom_snd_parse_of(card);
 	if (ret) {
 		dev_err(dev, "Error parsing OF data\n");
 		goto err;
 	}
 
+	apq8096_add_be_ops(card);
+
 	ret = snd_soc_register_card(card);
 	if (ret)
 		goto err;
@@ -174,53 +84,12 @@ static void apq8096_unbind(struct device *dev)
 	.unbind = apq8096_unbind,
 };
 
-static int apq8016_compare_of(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
-static void apq8016_release_of(struct device *dev, void *data)
-{
-	of_node_put(data);
-}
-
-static int add_audio_components(struct device *dev,
-				struct component_match **matchptr)
-{
-	struct device_node *np, *platform, *cpu, *node, *dai_node;
-
-	node = dev->of_node;
-
-	for_each_child_of_node(node, np) {
-		cpu = of_get_child_by_name(np, "cpu");
-		if (cpu) {
-			dai_node = of_parse_phandle(cpu, "sound-dai", 0);
-			of_node_get(dai_node);
-			component_match_add_release(dev, matchptr,
-						    apq8016_release_of,
-						    apq8016_compare_of,
-						    dai_node);
-		}
-
-		platform = of_get_child_by_name(np, "platform");
-		if (platform) {
-			dai_node = of_parse_phandle(platform, "sound-dai", 0);
-			component_match_add_release(dev, matchptr,
-						    apq8016_release_of,
-						    apq8016_compare_of,
-						    dai_node);
-		}
-	}
-
-	return 0;
-}
-
 static int apq8096_platform_probe(struct platform_device *pdev)
 {
 	struct component_match *match = NULL;
 	int ret;
 
-	ret = add_audio_components(&pdev->dev, &match);
+	ret = qcom_snd_add_components(&pdev->dev, &match);
 	if (ret)
 		return ret;
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
