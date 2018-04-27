From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add mt6797-mt6351 driver and config
	option" to the asoc tree
Date: Fri, 27 Apr 2018 11:53:26 +0100
Message-ID: <E1fC10I-0003MO-6v@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D3502678A2
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 12:53:29 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, KaiChieh Chuang <kaichieh.chuang@mediatek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: add mt6797-mt6351 driver and config option

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

>From f0ab0bf250da5a115d5675a686117f21984f0760 Mon Sep 17 00:00:00 2001
From: Kai Chieh Chuang <kaichieh.chuang@mediatek.com>
Date: Wed, 25 Apr 2018 15:25:21 +0800
Subject: [PATCH] ASoC: add mt6797-mt6351 driver and config option

Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/Kconfig                |  20 +++
 sound/soc/mediatek/Makefile               |   1 +
 sound/soc/mediatek/mt6797/Makefile        |  19 +++
 sound/soc/mediatek/mt6797/mt6797-mt6351.c | 186 ++++++++++++++++++++++
 4 files changed, 226 insertions(+)
 create mode 100644 sound/soc/mediatek/mt6797/Makefile
 create mode 100644 sound/soc/mediatek/mt6797/mt6797-mt6351.c

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 5c68797f36c4..e731d40afcce 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -32,6 +32,26 @@ config SND_SOC_MT2701_WM8960
 	  Select Y if you have such device.
 	  If unsure select "N".
 
+config SND_SOC_MT6797
+	tristate "ASoC support for Mediatek MT6797 chip"
+	depends on ARCH_MEDIATEK
+	select SND_SOC_MEDIATEK
+	help
+	  This adds ASoC driver for Mediatek MT6797 boards
+	  that can be used with other codecs.
+	  Select Y if you have such device.
+	  If unsure select "N".
+
+config SND_SOC_MT6797_MT6351
+	tristate "ASoc Audio driver for MT6797 with MT6351 codec"
+	depends on SND_SOC_MT6797 && MTK_PMIC_WRAP
+	select SND_SOC_MT6351
+	help
+	  This adds ASoC driver for Mediatek MT6797 boards
+	  with the MT6351 codecs.
+	  Select Y if you have such device.
+	  If unsure select "N".
+
 config SND_SOC_MT8173
 	tristate "ASoC support for Mediatek MT8173 chip"
 	depends on ARCH_MEDIATEK
diff --git a/sound/soc/mediatek/Makefile b/sound/soc/mediatek/Makefile
index 28679589ad2a..3bb2c47532f4 100644
--- a/sound/soc/mediatek/Makefile
+++ b/sound/soc/mediatek/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_SND_SOC_MEDIATEK) += common/
 obj-$(CONFIG_SND_SOC_MT2701) += mt2701/
+obj-$(CONFIG_SND_SOC_MT6797) += mt6797/
 obj-$(CONFIG_SND_SOC_MT8173) += mt8173/
diff --git a/sound/soc/mediatek/mt6797/Makefile b/sound/soc/mediatek/mt6797/Makefile
new file mode 100644
index 000000000000..58618a0d339a
--- /dev/null
+++ b/sound/soc/mediatek/mt6797/Makefile
@@ -0,0 +1,19 @@
+#
+# Copyright (C) 2018 MediaTek Inc.
+#
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+# GNU General Public License for more details.
+#
+
+# platform driver
+snd-soc-mt6797-afe-objs := mt6797-afe-pcm.o mt6797-afe-clk.o
+obj-$(CONFIG_SND_SOC_MT6797) += snd-soc-mt6797-afe.o
+
+# machine driver
+obj-$(CONFIG_SND_SOC_MT6797_MT6351) += mt6797-mt6351.o
diff --git a/sound/soc/mediatek/mt6797/mt6797-mt6351.c b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
new file mode 100644
index 000000000000..d42a9d9fbf3e
--- /dev/null
+++ b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
@@ -0,0 +1,186 @@
+/*
+ * mt6797-mt6351.c  --  MT6797 MT6351 ALSA SoC machine driver
+ *
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: Ryder Lee <ryder.lee@mediatek.com>
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
+#include <sound/soc.h>
+
+#include "mt6797-afe-common.h"
+
+static struct snd_soc_dai_link mt6797_mt6351_dai_links[] = {
+	/* FE */
+	{
+		.name = "Playback_1",
+		.stream_name = "Playback_1",
+		.cpu_dai_name = "DL1",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+	},
+	{
+		.name = "Playback_2",
+		.stream_name = "Playback_2",
+		.cpu_dai_name = "DL2",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+	},
+	{
+		.name = "Playback_3",
+		.stream_name = "Playback_3",
+		.cpu_dai_name = "DL3",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+	},
+	{
+		.name = "Capture_1",
+		.stream_name = "Capture_1",
+		.cpu_dai_name = "UL1",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+	},
+	{
+		.name = "Capture_2",
+		.stream_name = "Capture_2",
+		.cpu_dai_name = "UL2",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+	},
+	{
+		.name = "Capture_3",
+		.stream_name = "Capture_3",
+		.cpu_dai_name = "UL3",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+	},
+	{
+		.name = "Capture_Mono_1",
+		.stream_name = "Capture_Mono_1",
+		.cpu_dai_name = "UL_MONO_1",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+	},
+	/* BE */
+	{
+		.name = "Primary Codec",
+		.cpu_dai_name = "ADDA",
+		.codec_dai_name = "mt6351-snd-codec-aif1",
+		.no_pcm = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+	},
+};
+
+static struct snd_soc_card mt6797_mt6351_card = {
+	.name = "mt6797-mt6351",
+	.owner = THIS_MODULE,
+	.dai_link = mt6797_mt6351_dai_links,
+	.num_links = ARRAY_SIZE(mt6797_mt6351_dai_links),
+};
+
+static int mt6797_mt6351_dev_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &mt6797_mt6351_card;
+	struct device_node *platform_node, *codec_node;
+	int ret, i;
+
+	card->dev = &pdev->dev;
+
+	platform_node = of_parse_phandle(pdev->dev.of_node,
+					 "mediatek,platform", 0);
+	if (!platform_node) {
+		dev_err(&pdev->dev, "Property 'platform' missing or invalid\n");
+		return -EINVAL;
+	}
+	for (i = 0; i < card->num_links; i++) {
+		if (mt6797_mt6351_dai_links[i].platform_name)
+			continue;
+		mt6797_mt6351_dai_links[i].platform_of_node = platform_node;
+	}
+
+	codec_node = of_parse_phandle(pdev->dev.of_node,
+				      "mediatek,audio-codec", 0);
+	if (!codec_node) {
+		dev_err(&pdev->dev,
+			"Property 'audio-codec' missing or invalid\n");
+		return -EINVAL;
+	}
+	for (i = 0; i < card->num_links; i++) {
+		if (mt6797_mt6351_dai_links[i].codec_name)
+			continue;
+		mt6797_mt6351_dai_links[i].codec_of_node = codec_node;
+	}
+
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
+	if (ret)
+		dev_err(&pdev->dev, "%s snd_soc_register_card fail %d\n",
+			__func__, ret);
+
+	return ret;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id mt6797_mt6351_dt_match[] = {
+	{.compatible = "mediatek,mt6797-mt6351-sound",},
+	{}
+};
+#endif
+
+static struct platform_driver mt6797_mt6351_driver = {
+	.driver = {
+		.name = "mt6797-mt6351",
+		.owner = THIS_MODULE,
+#ifdef CONFIG_OF
+		.of_match_table = mt6797_mt6351_dt_match,
+#endif
+	},
+	.probe = mt6797_mt6351_dev_probe,
+};
+
+module_platform_driver(mt6797_mt6351_driver);
+
+/* Module information */
+MODULE_DESCRIPTION("MT6797 MT6351 ALSA SoC machine driver");
+MODULE_AUTHOR("KaiChieh Chuang <kaichieh.chuang@mediatek.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("mt6797 mt6351 soc card");
+
-- 
2.17.0
