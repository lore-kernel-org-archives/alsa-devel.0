From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: Add support to parse common audio
	device nodes" to the asoc tree
Date: Wed,  1 Aug 2018 12:18:10 +0100 (BST)
Message-ID: <20180801111810.C50761124241@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 382A52676E2
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2018 13:18:11 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rohit kumar <rohitkr@codeaurora.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: Add support to parse common audio device nodes

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From c25e295cd77b37903ddc9ee27384e17aad08f27c Mon Sep 17 00:00:00 2001
From: Rohit kumar <rohitkr@codeaurora.org>
Date: Wed, 1 Aug 2018 14:31:08 +0530
Subject: [PATCH] ASoC: qcom: Add support to parse common audio device nodes

This adds support to parse cpu, platform and codec
device nodes and add them in dai-links. Also, update
apq8096 machine driver to use the common API.

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/Makefile  |   2 +-
 sound/soc/qcom/apq8096.c | 111 ++++----------------------------------
 sound/soc/qcom/common.c  | 112 +++++++++++++++++++++++++++++++++++++++
 sound/soc/qcom/common.h  |  12 +++++
 4 files changed, 136 insertions(+), 101 deletions(-)
 create mode 100644 sound/soc/qcom/common.c
 create mode 100644 sound/soc/qcom/common.h

diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
index 206945bb9ba1..fefecc072265 100644
--- a/sound/soc/qcom/Makefile
+++ b/sound/soc/qcom/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_SND_SOC_LPASS_APQ8016) += snd-soc-lpass-apq8016.o
 # Machine
 snd-soc-storm-objs := storm.o
 snd-soc-apq8016-sbc-objs := apq8016_sbc.o
-snd-soc-apq8096-objs := apq8096.o
+snd-soc-apq8096-objs := apq8096.o common.o
 
 obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
 obj-$(CONFIG_SND_SOC_APQ8016_SBC) += snd-soc-apq8016-sbc.o
diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index a56156281c8d..1e4a90d59228 100644
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
-
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
+	struct snd_soc_dai_link *link = card->dai_link;
+	int i, num_links = card->num_links;
 
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
 
 static int apq8096_platform_probe(struct platform_device *pdev)
@@ -142,18 +50,21 @@ static int apq8096_platform_probe(struct platform_device *pdev)
 	card->dev = dev;
 	card->auto_bind = true;
 	dev_set_drvdata(dev, card);
-	ret = apq8096_sbc_parse_of(card);
+	ret = qcom_snd_parse_of(card);
 	if (ret) {
 		dev_err(dev, "Error parsing OF data\n");
 		goto err;
 	}
 
+	apq8096_add_be_ops(card);
 	ret = snd_soc_register_card(card);
 	if (ret)
-		goto err;
+		goto err_card_register;
 
 	return 0;
 
+err_card_register:
+	kfree(card->dai_link);
 err:
 	kfree(card);
 	return ret;
diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
new file mode 100644
index 000000000000..eb1b9da05dd4
--- /dev/null
+++ b/sound/soc/qcom/common.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, Linaro Limited.
+// Copyright (c) 2018, The Linux Foundation. All rights reserved.
+
+#include <linux/module.h>
+#include "common.h"
+
+int qcom_snd_parse_of(struct snd_soc_card *card)
+{
+	struct device_node *np;
+	struct device_node *codec = NULL;
+	struct device_node *platform = NULL;
+	struct device_node *cpu = NULL;
+	struct device *dev = card->dev;
+	struct snd_soc_dai_link *link;
+	int ret, num_links;
+
+	ret = snd_soc_of_parse_card_name(card, "model");
+	if (ret) {
+		dev_err(dev, "Error parsing card name: %d\n", ret);
+		return ret;
+	}
+
+	/* DAPM routes */
+	if (of_property_read_bool(dev->of_node, "audio-routing")) {
+		ret = snd_soc_of_parse_audio_routing(card,
+				"audio-routing");
+		if (ret)
+			return ret;
+	}
+
+	/* Populate links */
+	num_links = of_get_child_count(dev->of_node);
+
+	/* Allocate the DAI link array */
+	card->dai_link = kcalloc(num_links, sizeof(*link), GFP_KERNEL);
+	if (!card->dai_link)
+		return -ENOMEM;
+
+	card->num_links = num_links;
+	link = card->dai_link;
+	for_each_child_of_node(dev->of_node, np) {
+		cpu = of_get_child_by_name(np, "cpu");
+		if (!cpu) {
+			dev_err(dev, "Can't find cpu DT node\n");
+			ret = -EINVAL;
+			goto err;
+		}
+
+		link->cpu_of_node = of_parse_phandle(cpu, "sound-dai", 0);
+		if (!link->cpu_of_node) {
+			dev_err(card->dev, "error getting cpu phandle\n");
+			ret = -EINVAL;
+			goto err;
+		}
+
+		ret = snd_soc_of_get_dai_name(cpu, &link->cpu_dai_name);
+		if (ret) {
+			dev_err(card->dev, "error getting cpu dai name\n");
+			goto err;
+		}
+
+		platform = of_get_child_by_name(np, "platform");
+		codec = of_get_child_by_name(np, "codec");
+		if (codec && platform) {
+			link->platform_of_node = of_parse_phandle(platform,
+					"sound-dai",
+					0);
+			if (!link->platform_of_node) {
+				dev_err(card->dev, "platform dai not found\n");
+				ret = -EINVAL;
+				goto err;
+			}
+
+			ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
+			if (ret < 0) {
+				dev_err(card->dev, "codec dai not found\n");
+				goto err;
+			}
+			link->no_pcm = 1;
+			link->ignore_pmdown_time = 1;
+		} else {
+			link->platform_of_node = link->cpu_of_node;
+			link->codec_dai_name = "snd-soc-dummy-dai";
+			link->codec_name = "snd-soc-dummy";
+			link->dynamic = 1;
+		}
+
+		link->ignore_suspend = 1;
+		ret = of_property_read_string(np, "link-name", &link->name);
+		if (ret) {
+			dev_err(card->dev, "error getting codec dai_link name\n");
+			goto err;
+		}
+
+		link->dpcm_playback = 1;
+		link->dpcm_capture = 1;
+		link->stream_name = link->name;
+		link++;
+	}
+
+	return 0;
+err:
+	of_node_put(cpu);
+	of_node_put(codec);
+	of_node_put(platform);
+	kfree(card->dai_link);
+	return ret;
+}
+EXPORT_SYMBOL(qcom_snd_parse_of);
+
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/qcom/common.h b/sound/soc/qcom/common.h
new file mode 100644
index 000000000000..ad5d2cf27459
--- /dev/null
+++ b/sound/soc/qcom/common.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (c) 2018, The Linux Foundation. All rights reserved.
+
+#ifndef __QCOM_SND_COMMON_H__
+#define __QCOM_SND_COMMON_H__
+
+#include <linux/component.h>
+#include <sound/soc.h>
+
+int qcom_snd_parse_of(struct snd_soc_card *card);
+
+#endif
-- 
2.18.0
