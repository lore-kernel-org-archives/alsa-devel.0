From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: Add mt2701-wm8960 machine
	driver" to the asoc tree
Date: Wed, 29 Mar 2017 12:02:32 +0100
Message-ID: <E1ctBN2-0007Lh-4L@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FC1A266F00
 for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2017 13:02:41 +0200 (CEST)
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
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: Add mt2701-wm8960 machine driver

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 8625c1dbd87631572f8e2c05bc67736b73d6f02f Mon Sep 17 00:00:00 2001
From: Ryder Lee <ryder.lee@mediatek.com>
Date: Wed, 29 Mar 2017 16:59:31 +0800
Subject: [PATCH] ASoC: mediatek: Add mt2701-wm8960 machine driver

Add wm8960 machine driver and config option for MT2701.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/Kconfig                 |  10 ++
 sound/soc/mediatek/mt2701/Makefile         |   1 +
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c |  16 +++
 sound/soc/mediatek/mt2701/mt2701-wm8960.c  | 176 +++++++++++++++++++++++++++++
 4 files changed, 203 insertions(+)
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-wm8960.c

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index d7013bde6f45..c6f39040f71f 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -22,6 +22,16 @@ config SND_SOC_MT2701_CS42448
 	  Select Y if you have such device.
 	  If unsure select "N".
 
+config SND_SOC_MT2701_WM8960
+	tristate "ASoc Audio driver for MT2701 with WM8960 codec"
+	depends on SND_SOC_MT2701
+	select SND_SOC_WM8960
+	help
+	  This adds ASoC driver for Mediatek MT2701 boards
+	  with the WM8960 codecs.
+	  Select Y if you have such device.
+	  If unsure select "N".
+
 config SND_SOC_MT8173
 	tristate "ASoC support for Mediatek MT8173 chip"
 	depends on ARCH_MEDIATEK
diff --git a/sound/soc/mediatek/mt2701/Makefile b/sound/soc/mediatek/mt2701/Makefile
index 31c3d04d4942..c91deb6aca21 100644
--- a/sound/soc/mediatek/mt2701/Makefile
+++ b/sound/soc/mediatek/mt2701/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_SND_SOC_MT2701) += snd-soc-mt2701-afe.o
 
 # machine driver
 obj-$(CONFIG_SND_SOC_MT2701_CS42448) += mt2701-cs42448.o
+obj-$(CONFIG_SND_SOC_MT2701_WM8960) += mt2701-wm8960.o
diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index c7fa3e663463..bc5d4db94de6 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -604,6 +604,22 @@ static struct snd_soc_dai_ops mt2701_btmrg_ops = {
 static struct snd_soc_dai_driver mt2701_afe_pcm_dais[] = {
 	/* FE DAIs: memory intefaces to CPU */
 	{
+		.name = "PCMO0",
+		.id = MT2701_MEMIF_DL1,
+		.suspend = mtk_afe_dai_suspend,
+		.resume = mtk_afe_dai_resume,
+		.playback = {
+			.stream_name = "DL1",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_8000_192000,
+			.formats = (SNDRV_PCM_FMTBIT_S16_LE
+				| SNDRV_PCM_FMTBIT_S24_LE
+				| SNDRV_PCM_FMTBIT_S32_LE)
+		},
+		.ops = &mt2701_single_memif_dai_ops,
+	},
+	{
 		.name = "PCM_multi",
 		.id = MT2701_MEMIF_DLM,
 		.suspend = mtk_afe_dai_suspend,
diff --git a/sound/soc/mediatek/mt2701/mt2701-wm8960.c b/sound/soc/mediatek/mt2701/mt2701-wm8960.c
new file mode 100644
index 000000000000..a08ce2323bdc
--- /dev/null
+++ b/sound/soc/mediatek/mt2701/mt2701-wm8960.c
@@ -0,0 +1,176 @@
+/*
+ * mt2701-wm8960.c  --  MT2701 WM8960 ALSA SoC machine driver
+ *
+ * Copyright (c) 2017 MediaTek Inc.
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
+#include "mt2701-afe-common.h"
+
+static const struct snd_soc_dapm_widget mt2701_wm8960_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("AMIC", NULL),
+};
+
+static const struct snd_kcontrol_new mt2701_wm8960_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("AMIC"),
+};
+
+static int mt2701_wm8960_be_ops_hw_params(struct snd_pcm_substream *substream,
+					  struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	unsigned int mclk_rate;
+	unsigned int rate = params_rate(params);
+	unsigned int div_mclk_over_bck = rate > 192000 ? 2 : 4;
+	unsigned int div_bck_over_lrck = 64;
+
+	mclk_rate = rate * div_bck_over_lrck * div_mclk_over_bck;
+
+	snd_soc_dai_set_sysclk(cpu_dai, 0, mclk_rate, SND_SOC_CLOCK_OUT);
+	snd_soc_dai_set_sysclk(codec_dai, 0, mclk_rate, SND_SOC_CLOCK_IN);
+
+	return 0;
+}
+
+static struct snd_soc_ops mt2701_wm8960_be_ops = {
+	.hw_params = mt2701_wm8960_be_ops_hw_params
+};
+
+static struct snd_soc_dai_link mt2701_wm8960_dai_links[] = {
+	/* FE */
+	{
+		.name = "wm8960-playback",
+		.stream_name = "wm8960-playback",
+		.cpu_dai_name = "PCMO0",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.trigger = {SND_SOC_DPCM_TRIGGER_POST,
+			    SND_SOC_DPCM_TRIGGER_POST},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+	},
+	{
+		.name = "wm8960-capture",
+		.stream_name = "wm8960-capture",
+		.cpu_dai_name = "PCM0",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.trigger = {SND_SOC_DPCM_TRIGGER_POST,
+			    SND_SOC_DPCM_TRIGGER_POST},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+	},
+	/* BE */
+	{
+		.name = "wm8960-codec",
+		.cpu_dai_name = "I2S0",
+		.no_pcm = 1,
+		.codec_dai_name = "wm8960-hifi",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS
+			| SND_SOC_DAIFMT_GATED,
+		.ops = &mt2701_wm8960_be_ops,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+	},
+};
+
+static struct snd_soc_card mt2701_wm8960_card = {
+	.name = "mt2701-wm8960",
+	.owner = THIS_MODULE,
+	.dai_link = mt2701_wm8960_dai_links,
+	.num_links = ARRAY_SIZE(mt2701_wm8960_dai_links),
+	.controls = mt2701_wm8960_controls,
+	.num_controls = ARRAY_SIZE(mt2701_wm8960_controls),
+	.dapm_widgets = mt2701_wm8960_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(mt2701_wm8960_widgets),
+};
+
+static int mt2701_wm8960_machine_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &mt2701_wm8960_card;
+	struct device_node *platform_node, *codec_node;
+	int ret, i;
+
+	platform_node = of_parse_phandle(pdev->dev.of_node,
+					 "mediatek,platform", 0);
+	if (!platform_node) {
+		dev_err(&pdev->dev, "Property 'platform' missing or invalid\n");
+		return -EINVAL;
+	}
+	for (i = 0; i < card->num_links; i++) {
+		if (mt2701_wm8960_dai_links[i].platform_name)
+			continue;
+		mt2701_wm8960_dai_links[i].platform_of_node = platform_node;
+	}
+
+	card->dev = &pdev->dev;
+
+	codec_node = of_parse_phandle(pdev->dev.of_node,
+				      "mediatek,audio-codec", 0);
+	if (!codec_node) {
+		dev_err(&pdev->dev,
+			"Property 'audio-codec' missing or invalid\n");
+		return -EINVAL;
+	}
+	for (i = 0; i < card->num_links; i++) {
+		if (mt2701_wm8960_dai_links[i].codec_name)
+			continue;
+		mt2701_wm8960_dai_links[i].codec_of_node = codec_node;
+	}
+
+	ret = snd_soc_of_parse_audio_routing(card, "audio-routing");
+	if (ret) {
+		dev_err(&pdev->dev, "failed to parse audio-routing: %d\n", ret);
+		return ret;
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
+static const struct of_device_id mt2701_wm8960_machine_dt_match[] = {
+	{.compatible = "mediatek,mt2701-wm8960-machine",},
+	{}
+};
+#endif
+
+static struct platform_driver mt2701_wm8960_machine = {
+	.driver = {
+		.name = "mt2701-wm8960",
+		.owner = THIS_MODULE,
+#ifdef CONFIG_OF
+		.of_match_table = mt2701_wm8960_machine_dt_match,
+#endif
+	},
+	.probe = mt2701_wm8960_machine_probe,
+};
+
+module_platform_driver(mt2701_wm8960_machine);
+
+/* Module information */
+MODULE_DESCRIPTION("MT2701 WM8960 ALSA SoC machine driver");
+MODULE_AUTHOR("Ryder Lee <ryder.lee@mediatek.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("mt2701 wm8960 soc card");
+
-- 
2.11.0
