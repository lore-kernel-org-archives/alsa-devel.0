From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mt6797: add Hostless DAI" to the asoc
	tree
Date: Thu, 31 May 2018 12:06:24 +0100
Message-ID: <E1fOLPU-0001xi-9e@debutante>
References: <1527729981-4802-2-git-send-email-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D51026790F
 for <alsa-devel@alsa-project.org>; Thu, 31 May 2018 13:06:36 +0200 (CEST)
In-Reply-To: <1527729981-4802-2-git-send-email-kaichieh.chuang@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mt6797: add Hostless DAI

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

>From 2c1a5c04417ec10189e4ae9e07543b67c2b48b90 Mon Sep 17 00:00:00 2001
From: Kai Chieh Chuang <kaichieh.chuang@mediatek.com>
Date: Thu, 31 May 2018 09:26:20 +0800
Subject: [PATCH] ASoC: mt6797: add Hostless DAI

add path for hosltess lpbk from ADDA Capture to ADDA Playback
add path for hostless phone call between ADDA DAI and PCM DAI

Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt6797/Makefile            |   1 +
 sound/soc/mediatek/mt6797/mt6797-afe-common.h |   3 +
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c    |   1 +
 sound/soc/mediatek/mt6797/mt6797-dai-adda.c   |  12 ++
 .../soc/mediatek/mt6797/mt6797-dai-hostless.c | 112 ++++++++++++++++++
 5 files changed, 129 insertions(+)
 create mode 100644 sound/soc/mediatek/mt6797/mt6797-dai-hostless.c

diff --git a/sound/soc/mediatek/mt6797/Makefile b/sound/soc/mediatek/mt6797/Makefile
index 484a6a6fb0f5..bf6e179ea93f 100644
--- a/sound/soc/mediatek/mt6797/Makefile
+++ b/sound/soc/mediatek/mt6797/Makefile
@@ -5,6 +5,7 @@ snd-soc-mt6797-afe-objs := \
 	mt6797-afe-pcm.o \
 	mt6797-afe-clk.o \
 	mt6797-dai-pcm.o \
+	mt6797-dai-hostless.o \
 	mt6797-dai-adda.o
 
 obj-$(CONFIG_SND_SOC_MT6797) += snd-soc-mt6797-afe.o
diff --git a/sound/soc/mediatek/mt6797/mt6797-afe-common.h b/sound/soc/mediatek/mt6797/mt6797-afe-common.h
index 85d2a3cb1d10..22eb7b455cf1 100644
--- a/sound/soc/mediatek/mt6797/mt6797-afe-common.h
+++ b/sound/soc/mediatek/mt6797/mt6797-afe-common.h
@@ -26,6 +26,8 @@ enum {
 	MT6797_DAI_ADDA = MT6797_MEMIF_NUM,
 	MT6797_DAI_PCM_1,
 	MT6797_DAI_PCM_2,
+	MT6797_DAI_HOSTLESS_LPBK,
+	MT6797_DAI_HOSTLESS_SPEECH,
 	MT6797_DAI_NUM,
 };
 
@@ -52,4 +54,5 @@ unsigned int mt6797_rate_transform(struct device *dev,
 /* dai register */
 int mt6797_dai_adda_register(struct mtk_base_afe *afe);
 int mt6797_dai_pcm_register(struct mtk_base_afe *afe);
+int mt6797_dai_hostless_register(struct mtk_base_afe *afe);
 #endif
diff --git a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
index d9379888ae49..6c5dd9fc9976 100644
--- a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
+++ b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
@@ -820,6 +820,7 @@ static int mt6797_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	mt6797_dai_adda_register(afe);
 	mt6797_dai_pcm_register(afe);
+	mt6797_dai_hostless_register(afe);
 
 	afe->sub_dais[MT6797_MEMIF_DL1].dai_drivers = mt6797_memif_dai_driver;
 	afe->sub_dais[MT6797_MEMIF_DL1].num_dai_drivers =
diff --git a/sound/soc/mediatek/mt6797/mt6797-dai-adda.c b/sound/soc/mediatek/mt6797/mt6797-dai-adda.c
index f38e35edfd44..ad083265ce94 100644
--- a/sound/soc/mediatek/mt6797/mt6797-dai-adda.c
+++ b/sound/soc/mediatek/mt6797/mt6797-dai-adda.c
@@ -100,6 +100,10 @@ static const struct snd_kcontrol_new mtk_adda_dl_ch1_mix[] = {
 				    I_ADDA_UL_CH2, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1", AFE_CONN3,
 				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_1_CAP_CH1", AFE_CONN3,
+				    I_PCM_1_CAP_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_2_CAP_CH1", AFE_CONN3,
+				    I_PCM_2_CAP_CH1, 1, 0),
 };
 
 static const struct snd_kcontrol_new mtk_adda_dl_ch2_mix[] = {
@@ -113,6 +117,14 @@ static const struct snd_kcontrol_new mtk_adda_dl_ch2_mix[] = {
 				    I_ADDA_UL_CH2, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1", AFE_CONN4,
 				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_1_CAP_CH1", AFE_CONN4,
+				    I_PCM_1_CAP_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_2_CAP_CH1", AFE_CONN4,
+				    I_PCM_2_CAP_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_1_CAP_CH2", AFE_CONN4,
+				    I_PCM_1_CAP_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_2_CAP_CH2", AFE_CONN4,
+				    I_PCM_2_CAP_CH2, 1, 0),
 };
 
 static int mtk_adda_ul_event(struct snd_soc_dapm_widget *w,
diff --git a/sound/soc/mediatek/mt6797/mt6797-dai-hostless.c b/sound/soc/mediatek/mt6797/mt6797-dai-hostless.c
new file mode 100644
index 000000000000..4cf985b15a11
--- /dev/null
+++ b/sound/soc/mediatek/mt6797/mt6797-dai-hostless.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// MediaTek ALSA SoC Audio DAI Hostless Control
+//
+// Copyright (c) 2018 MediaTek Inc.
+// Author: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
+
+#include "mt6797-afe-common.h"
+
+/* dai component */
+static const struct snd_soc_dapm_route mtk_dai_hostless_routes[] = {
+	/* Hostless ADDA Loopback */
+	{"ADDA_DL_CH1", "ADDA_UL_CH1", "Hostless LPBK DL"},
+	{"ADDA_DL_CH1", "ADDA_UL_CH2", "Hostless LPBK DL"},
+	{"ADDA_DL_CH2", "ADDA_UL_CH1", "Hostless LPBK DL"},
+	{"ADDA_DL_CH2", "ADDA_UL_CH2", "Hostless LPBK DL"},
+	{"Hostless LPBK UL", NULL, "ADDA Capture"},
+
+	/* Hostless Speech */
+	{"ADDA_DL_CH1", "PCM_1_CAP_CH1", "Hostless Speech DL"},
+	{"ADDA_DL_CH2", "PCM_1_CAP_CH1", "Hostless Speech DL"},
+	{"ADDA_DL_CH2", "PCM_1_CAP_CH2", "Hostless Speech DL"},
+	{"ADDA_DL_CH1", "PCM_2_CAP_CH1", "Hostless Speech DL"},
+	{"ADDA_DL_CH2", "PCM_2_CAP_CH1", "Hostless Speech DL"},
+	{"ADDA_DL_CH2", "PCM_2_CAP_CH2", "Hostless Speech DL"},
+	{"PCM_1_PB_CH1", "ADDA_UL_CH1", "Hostless Speech DL"},
+	{"PCM_1_PB_CH2", "ADDA_UL_CH2", "Hostless Speech DL"},
+	{"PCM_2_PB_CH1", "ADDA_UL_CH1", "Hostless Speech DL"},
+	{"PCM_2_PB_CH2", "ADDA_UL_CH2", "Hostless Speech DL"},
+
+	{"Hostless Speech UL", NULL, "PCM 1 Capture"},
+	{"Hostless Speech UL", NULL, "PCM 2 Capture"},
+	{"Hostless Speech UL", NULL, "ADDA Capture"},
+};
+
+/* dai ops */
+static int mtk_dai_hostless_startup(struct snd_pcm_substream *substream,
+				    struct snd_soc_dai *dai)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+
+	return snd_soc_set_runtime_hwparams(substream, afe->mtk_afe_hardware);
+}
+
+static const struct snd_soc_dai_ops mtk_dai_hostless_ops = {
+	.startup = mtk_dai_hostless_startup,
+};
+
+/* dai driver */
+#define MTK_HOSTLESS_RATES (SNDRV_PCM_RATE_8000_48000 |\
+			   SNDRV_PCM_RATE_88200 |\
+			   SNDRV_PCM_RATE_96000 |\
+			   SNDRV_PCM_RATE_176400 |\
+			   SNDRV_PCM_RATE_192000)
+
+#define MTK_HOSTLESS_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			     SNDRV_PCM_FMTBIT_S24_LE |\
+			     SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver mtk_dai_hostless_driver[] = {
+	{
+		.name = "Hostless LPBK DAI",
+		.id = MT6797_DAI_HOSTLESS_LPBK,
+		.playback = {
+			.stream_name = "Hostless LPBK DL",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_HOSTLESS_RATES,
+			.formats = MTK_HOSTLESS_FORMATS,
+		},
+		.capture = {
+			.stream_name = "Hostless LPBK UL",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_HOSTLESS_RATES,
+			.formats = MTK_HOSTLESS_FORMATS,
+		},
+		.ops = &mtk_dai_hostless_ops,
+	},
+	{
+		.name = "Hostless Speech DAI",
+		.id = MT6797_DAI_HOSTLESS_SPEECH,
+		.playback = {
+			.stream_name = "Hostless Speech DL",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_HOSTLESS_RATES,
+			.formats = MTK_HOSTLESS_FORMATS,
+		},
+		.capture = {
+			.stream_name = "Hostless Speech UL",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_HOSTLESS_RATES,
+			.formats = MTK_HOSTLESS_FORMATS,
+		},
+		.ops = &mtk_dai_hostless_ops,
+	},
+};
+
+int mt6797_dai_hostless_register(struct mtk_base_afe *afe)
+{
+	int id = MT6797_DAI_HOSTLESS_LPBK;
+
+	afe->sub_dais[id].dai_drivers = mtk_dai_hostless_driver;
+	afe->sub_dais[id].num_dai_drivers = ARRAY_SIZE(mtk_dai_hostless_driver);
+
+	afe->sub_dais[id].dapm_routes = mtk_dai_hostless_routes;
+	afe->sub_dais[id].num_dapm_routes = ARRAY_SIZE(mtk_dai_hostless_routes);
+
+	return 0;
+}
-- 
2.17.0
