From: Shunli Wang <shunli.wang@mediatek.com>
Subject: [RESEND PATCH 5/6] ASoC: mediatek: mt8183: add
	mt8183-mt6358 machine driver
Date: Sat, 26 Jan 2019 15:44:59 +0800
Message-ID: <1548488700-47792-6-git-send-email-shunli.wang@mediatek.com>
References: <1548488700-47792-1-git-send-email-shunli.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 14FD92673E2
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2019 08:47:19 +0100 (CET)
In-Reply-To: <1548488700-47792-1-git-send-email-shunli.wang@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, srv_heupstream@mediatek.com, garlic.tseng@mediatek.com, linux-mediatek@lists.infradead.org, shunli.wang@mediatek.com, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

The board uses mt8183 as SoC and codec as mt6358.
Between SoC and codec, a mtk-properity audio inferface
is used.

Signed-off-by: Shunli Wang <shunli.wang@mediatek.com>
---
 sound/soc/mediatek/Kconfig                |  10 ++
 sound/soc/mediatek/mt8183/mt8183-mt6358.c | 208 ++++++++++++++++++++++++++++++
 2 files changed, 218 insertions(+)
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-mt6358.c

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 8bb360e..a4f8651 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -115,3 +115,13 @@ config SND_SOC_MT8183
 	  that can be used with other codecs.
 	  Select Y if you have such device.
 	  If unsure select "N".
+
+config SND_SOC_MT8183_MT6358
+	tristate "ASoc Audio driver for MT8183 with MT6358 codec"
+	depends on SND_SOC_MT8183 && MTK_PMIC_WRAP
+	select SND_SOC_MT8183
+	help
+	  This adds ASoC driver for Mediatek MT8183 boards
+	  with the MT6358 codecs.
+	  Select Y if you have such device.
+	  If unsure select "N".
diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358.c b/sound/soc/mediatek/mt8183/mt8183-mt6358.c
new file mode 100644
index 0000000..51f1d17
--- /dev/null
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// mt8183-mt6358.c
+//	--  MT8183-MT6358 ALSA SoC machine driver
+//
+// Copyright (c) 2018 MediaTek Inc.
+// Author: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
+
+#include <linux/module.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/jack.h>
+#include <linux/pinctrl/consumer.h>
+
+#include "mt8183-afe-common.h"
+
+static int mt8183_mt6358_i2s_hw_params(struct snd_pcm_substream *substream,
+				       struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	unsigned int rate = params_rate(params);
+	unsigned int mclk_fs_ratio = 128;
+	unsigned int mclk_fs = rate * mclk_fs_ratio;
+
+	return snd_soc_dai_set_sysclk(rtd->cpu_dai,
+				      0, mclk_fs, SND_SOC_CLOCK_OUT);
+}
+
+static const struct snd_soc_ops mt8183_mt6358_i2s_ops = {
+	.hw_params = mt8183_mt6358_i2s_hw_params,
+};
+
+static struct snd_soc_dai_link mt8183_mt6358_dai_links[] = {
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
+		.codec_dai_name = "mt6358-snd-codec-aif1",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.no_pcm = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+	},
+};
+
+static struct snd_soc_card mt8183_mt6358_card = {
+	.name = "mt8183-mt6358",
+	.owner = THIS_MODULE,
+	.dai_link = mt8183_mt6358_dai_links,
+	.num_links = ARRAY_SIZE(mt8183_mt6358_dai_links),
+};
+
+static int mt8183_mt6358_dev_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &mt8183_mt6358_card;
+	struct device_node *platform_node;
+	struct snd_soc_dai_link *dai_link;
+	struct pinctrl *default_pins;
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
+
+	for_each_card_prelinks(card, i, dai_link) {
+		/* In the alsa soc-core, the "platform" will be
+		 * allocated by devm_kzalloc if null.
+		 * There is a special case that registerring
+		 * sound card is failed at the first time, but
+		 * the "platform" will not null when probe is trying
+		 * again. It's not expected normally.
+		 */
+		dai_link->platform = NULL;
+
+		if (dai_link->platform_name)
+			continue;
+		dai_link->platform_of_node = platform_node;
+	}
+
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
+	if (ret) {
+		dev_err(&pdev->dev, "%s snd_soc_register_card fail %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	default_pins =
+		devm_pinctrl_get_select(&pdev->dev, PINCTRL_STATE_DEFAULT);
+	if (IS_ERR(default_pins)) {
+		dev_err(&pdev->dev, "%s set pins failed\n",
+			__func__);
+		return PTR_ERR(default_pins);
+	}
+
+	return ret;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id mt8183_mt6358_dt_match[] = {
+	{.compatible = "mediatek,mt8183-mt6358-sound",},
+	{}
+};
+#endif
+
+static struct platform_driver mt8183_mt6358_driver = {
+	.driver = {
+		.name = "mt8183-mt6358",
+		.owner = THIS_MODULE,
+#ifdef CONFIG_OF
+		.of_match_table = mt8183_mt6358_dt_match,
+#endif
+	},
+	.probe = mt8183_mt6358_dev_probe,
+};
+
+module_platform_driver(mt8183_mt6358_driver);
+
+/* Module information */
+MODULE_DESCRIPTION("MT8183-MT6358 ALSA SoC machine driver");
+MODULE_AUTHOR("KaiChieh Chuang <kaichieh.chuang@mediatek.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("mt8183_mt6358 soc card");
+
-- 
1.9.1
