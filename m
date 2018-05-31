From: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 1/3] ASoC: mt6797: add PCM interface
Date: Thu, 31 May 2018 09:26:19 +0800
Message-ID: <1527729981-4802-1-git-send-email-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, wsd_upstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 sound/soc/mediatek/mt6797/Makefile            |   1 +
 sound/soc/mediatek/mt6797/mt6797-afe-common.h |   3 +
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c    |   1 +
 sound/soc/mediatek/mt6797/mt6797-dai-pcm.c    | 312 ++++++++++++++++++++++++++
 sound/soc/mediatek/mt6797/mt6797-reg.h        | 177 +++++++++++++++
 5 files changed, 494 insertions(+)
 create mode 100644 sound/soc/mediatek/mt6797/mt6797-dai-pcm.c

diff --git a/sound/soc/mediatek/mt6797/Makefile b/sound/soc/mediatek/mt6797/Makefile
index 4cbdc4d..484a6a6 100644
--- a/sound/soc/mediatek/mt6797/Makefile
+++ b/sound/soc/mediatek/mt6797/Makefile
@@ -4,6 +4,7 @@
 snd-soc-mt6797-afe-objs := \
 	mt6797-afe-pcm.o \
 	mt6797-afe-clk.o \
+	mt6797-dai-pcm.o \
 	mt6797-dai-adda.o
 
 obj-$(CONFIG_SND_SOC_MT6797) += snd-soc-mt6797-afe.o
diff --git a/sound/soc/mediatek/mt6797/mt6797-afe-common.h b/sound/soc/mediatek/mt6797/mt6797-afe-common.h
index d53654f..85d2a3c 100644
--- a/sound/soc/mediatek/mt6797/mt6797-afe-common.h
+++ b/sound/soc/mediatek/mt6797/mt6797-afe-common.h
@@ -24,6 +24,8 @@ enum {
 	MT6797_MEMIF_MOD_DAI,
 	MT6797_MEMIF_NUM,
 	MT6797_DAI_ADDA = MT6797_MEMIF_NUM,
+	MT6797_DAI_PCM_1,
+	MT6797_DAI_PCM_2,
 	MT6797_DAI_NUM,
 };
 
@@ -49,4 +51,5 @@ unsigned int mt6797_rate_transform(struct device *dev,
 
 /* dai register */
 int mt6797_dai_adda_register(struct mtk_base_afe *afe);
+int mt6797_dai_pcm_register(struct mtk_base_afe *afe);
 #endif
diff --git a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
index 1286c6e..d937988 100644
--- a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
+++ b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
@@ -819,6 +819,7 @@ static int mt6797_afe_pcm_dev_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mt6797_dai_adda_register(afe);
+	mt6797_dai_pcm_register(afe);
 
 	afe->sub_dais[MT6797_MEMIF_DL1].dai_drivers = mt6797_memif_dai_driver;
 	afe->sub_dais[MT6797_MEMIF_DL1].num_dai_drivers =
diff --git a/sound/soc/mediatek/mt6797/mt6797-dai-pcm.c b/sound/soc/mediatek/mt6797/mt6797-dai-pcm.c
new file mode 100644
index 0000000..16d5b50
--- /dev/null
+++ b/sound/soc/mediatek/mt6797/mt6797-dai-pcm.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// MediaTek ALSA SoC Audio DAI I2S Control
+//
+// Copyright (c) 2018 MediaTek Inc.
+// Author: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
+
+#include <linux/regmap.h>
+#include <sound/pcm_params.h>
+#include "mt6797-afe-common.h"
+#include "mt6797-interconnection.h"
+#include "mt6797-reg.h"
+
+enum AUD_TX_LCH_RPT {
+	AUD_TX_LCH_RPT_NO_REPEAT = 0,
+	AUD_TX_LCH_RPT_REPEAT = 1
+};
+
+enum AUD_VBT_16K_MODE {
+	AUD_VBT_16K_MODE_DISABLE = 0,
+	AUD_VBT_16K_MODE_ENABLE = 1
+};
+
+enum AUD_EXT_MODEM {
+	AUD_EXT_MODEM_SELECT_INTERNAL = 0,
+	AUD_EXT_MODEM_SELECT_EXTERNAL = 1
+};
+
+enum AUD_PCM_SYNC_TYPE {
+	/* bck sync length = 1 */
+	AUD_PCM_ONE_BCK_CYCLE_SYNC = 0,
+	/* bck sync length = PCM_INTF_CON1[9:13] */
+	AUD_PCM_EXTENDED_BCK_CYCLE_SYNC = 1
+};
+
+enum AUD_BT_MODE {
+	AUD_BT_MODE_DUAL_MIC_ON_TX = 0,
+	AUD_BT_MODE_SINGLE_MIC_ON_TX = 1
+};
+
+enum AUD_PCM_AFIFO_SRC {
+	/* slave mode & external modem uses different crystal */
+	AUD_PCM_AFIFO_ASRC = 0,
+	/* slave mode & external modem uses the same crystal */
+	AUD_PCM_AFIFO_AFIFO = 1
+};
+
+enum AUD_PCM_CLOCK_SOURCE {
+	AUD_PCM_CLOCK_MASTER_MODE = 0,
+	AUD_PCM_CLOCK_SLAVE_MODE = 1
+};
+
+enum AUD_PCM_WLEN {
+	AUD_PCM_WLEN_PCM_32_BCK_CYCLES = 0,
+	AUD_PCM_WLEN_PCM_64_BCK_CYCLES = 1
+};
+
+enum AUD_PCM_MODE {
+	AUD_PCM_MODE_PCM_MODE_8K = 0,
+	AUD_PCM_MODE_PCM_MODE_16K = 1,
+	AUD_PCM_MODE_PCM_MODE_32K = 2,
+	AUD_PCM_MODE_PCM_MODE_48K = 3,
+};
+
+enum AUD_PCM_FMT {
+	AUD_PCM_FMT_I2S = 0,
+	AUD_PCM_FMT_EIAJ = 1,
+	AUD_PCM_FMT_PCM_MODE_A = 2,
+	AUD_PCM_FMT_PCM_MODE_B = 3
+};
+
+enum AUD_BCLK_OUT_INV {
+	AUD_BCLK_OUT_INV_NO_INVERSE = 0,
+	AUD_BCLK_OUT_INV_INVERSE = 1
+};
+
+enum AUD_PCM_EN {
+	AUD_PCM_EN_DISABLE = 0,
+	AUD_PCM_EN_ENABLE = 1
+};
+
+/* dai component */
+static const struct snd_kcontrol_new mtk_pcm_1_playback_ch1_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1", AFE_CONN7,
+				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH1", AFE_CONN7,
+				    I_DL2_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new mtk_pcm_1_playback_ch2_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2", AFE_CONN8,
+				    I_ADDA_UL_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH2", AFE_CONN8,
+				    I_DL2_CH2, 1, 0),
+};
+
+static const struct snd_kcontrol_new mtk_pcm_1_playback_ch4_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH1", AFE_CONN27,
+				    I_DL1_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new mtk_pcm_2_playback_ch1_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1", AFE_CONN17,
+				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH1", AFE_CONN17,
+				    I_DL2_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new mtk_pcm_2_playback_ch2_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2", AFE_CONN18,
+				    I_ADDA_UL_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH2", AFE_CONN18,
+				    I_DL2_CH2, 1, 0),
+};
+
+static const struct snd_kcontrol_new mtk_pcm_2_playback_ch4_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH1", AFE_CONN24,
+				    I_DL1_CH1, 1, 0),
+};
+
+static const struct snd_soc_dapm_widget mtk_dai_pcm_widgets[] = {
+	/* inter-connections */
+	SND_SOC_DAPM_MIXER("PCM_1_PB_CH1", SND_SOC_NOPM, 0, 0,
+			   mtk_pcm_1_playback_ch1_mix,
+			   ARRAY_SIZE(mtk_pcm_1_playback_ch1_mix)),
+	SND_SOC_DAPM_MIXER("PCM_1_PB_CH2", SND_SOC_NOPM, 0, 0,
+			   mtk_pcm_1_playback_ch2_mix,
+			   ARRAY_SIZE(mtk_pcm_1_playback_ch2_mix)),
+	SND_SOC_DAPM_MIXER("PCM_1_PB_CH4", SND_SOC_NOPM, 0, 0,
+			   mtk_pcm_1_playback_ch4_mix,
+			   ARRAY_SIZE(mtk_pcm_1_playback_ch4_mix)),
+	SND_SOC_DAPM_MIXER("PCM_2_PB_CH1", SND_SOC_NOPM, 0, 0,
+			   mtk_pcm_2_playback_ch1_mix,
+			   ARRAY_SIZE(mtk_pcm_2_playback_ch1_mix)),
+	SND_SOC_DAPM_MIXER("PCM_2_PB_CH2", SND_SOC_NOPM, 0, 0,
+			   mtk_pcm_2_playback_ch2_mix,
+			   ARRAY_SIZE(mtk_pcm_2_playback_ch2_mix)),
+	SND_SOC_DAPM_MIXER("PCM_2_PB_CH4", SND_SOC_NOPM, 0, 0,
+			   mtk_pcm_2_playback_ch4_mix,
+			   ARRAY_SIZE(mtk_pcm_2_playback_ch4_mix)),
+
+	SND_SOC_DAPM_SUPPLY("PCM_1_EN", PCM_INTF_CON1, PCM_EN_SFT, 0,
+			    NULL, 0),
+
+	SND_SOC_DAPM_SUPPLY("PCM_2_EN", PCM2_INTF_CON, PCM2_EN_SFT, 0,
+			    NULL, 0),
+
+	SND_SOC_DAPM_INPUT("MD1_TO_AFE"),
+	SND_SOC_DAPM_INPUT("MD2_TO_AFE"),
+	SND_SOC_DAPM_OUTPUT("AFE_TO_MD1"),
+	SND_SOC_DAPM_OUTPUT("AFE_TO_MD2"),
+};
+
+static const struct snd_soc_dapm_route mtk_dai_pcm_routes[] = {
+	{"PCM 1 Playback", NULL, "PCM_1_PB_CH1"},
+	{"PCM 1 Playback", NULL, "PCM_1_PB_CH2"},
+	{"PCM 1 Playback", NULL, "PCM_1_PB_CH4"},
+	{"PCM 2 Playback", NULL, "PCM_2_PB_CH1"},
+	{"PCM 2 Playback", NULL, "PCM_2_PB_CH2"},
+	{"PCM 2 Playback", NULL, "PCM_2_PB_CH4"},
+
+	{"PCM 1 Playback", NULL, "PCM_1_EN"},
+	{"PCM 2 Playback", NULL, "PCM_2_EN"},
+	{"PCM 1 Capture", NULL, "PCM_1_EN"},
+	{"PCM 2 Capture", NULL, "PCM_2_EN"},
+
+	{"AFE_TO_MD1", NULL, "PCM 2 Playback"},
+	{"AFE_TO_MD2", NULL, "PCM 1 Playback"},
+	{"PCM 2 Capture", NULL, "MD1_TO_AFE"},
+	{"PCM 1 Capture", NULL, "MD2_TO_AFE"},
+
+	{"PCM_1_PB_CH1", "DL2_CH1", "DL2"},
+	{"PCM_1_PB_CH2", "DL2_CH2", "DL2"},
+	{"PCM_1_PB_CH4", "DL1_CH1", "DL1"},
+	{"PCM_2_PB_CH1", "DL2_CH1", "DL2"},
+	{"PCM_2_PB_CH2", "DL2_CH2", "DL2"},
+	{"PCM_2_PB_CH4", "DL1_CH1", "DL1"},
+};
+
+/* dai ops */
+static int mtk_dai_pcm_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *dai)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+	unsigned int rate = params_rate(params);
+	unsigned int rate_reg = mt6797_rate_transform(afe->dev, rate, dai->id);
+	unsigned int pcm_con = 0;
+
+	dev_dbg(afe->dev, "%s(), id %d, stream %d, rate %d, rate_reg %d, widget active p %d, c %d\n",
+		__func__,
+		dai->id,
+		substream->stream,
+		rate,
+		rate_reg,
+		dai->playback_widget->active,
+		dai->capture_widget->active);
+
+	if (dai->playback_widget->active || dai->capture_widget->active)
+		return 0;
+
+	switch (dai->id) {
+	case MT6797_DAI_PCM_1:
+		pcm_con |= AUD_BCLK_OUT_INV_NO_INVERSE << PCM_BCLK_OUT_INV_SFT;
+		pcm_con |= AUD_TX_LCH_RPT_NO_REPEAT << PCM_TX_LCH_RPT_SFT;
+		pcm_con |= AUD_VBT_16K_MODE_DISABLE << PCM_VBT_16K_MODE_SFT;
+		pcm_con |= AUD_EXT_MODEM_SELECT_INTERNAL << PCM_EXT_MODEM_SFT;
+		pcm_con |= 0 << PCM_SYNC_LENGTH_SFT;
+		pcm_con |= AUD_PCM_ONE_BCK_CYCLE_SYNC << PCM_SYNC_TYPE_SFT;
+		pcm_con |= AUD_BT_MODE_DUAL_MIC_ON_TX << PCM_BT_MODE_SFT;
+		pcm_con |= AUD_PCM_AFIFO_AFIFO << PCM_BYP_ASRC_SFT;
+		pcm_con |= AUD_PCM_CLOCK_SLAVE_MODE << PCM_SLAVE_SFT;
+		pcm_con |= rate_reg << PCM_MODE_SFT;
+		pcm_con |= AUD_PCM_FMT_PCM_MODE_B << PCM_FMT_SFT;
+
+		regmap_update_bits(afe->regmap, PCM_INTF_CON1,
+				   0xfffffffe, pcm_con);
+		break;
+	case MT6797_DAI_PCM_2:
+		pcm_con |= AUD_TX_LCH_RPT_NO_REPEAT << PCM2_TX_LCH_RPT_SFT;
+		pcm_con |= AUD_VBT_16K_MODE_DISABLE << PCM2_VBT_16K_MODE_SFT;
+		pcm_con |= AUD_BT_MODE_DUAL_MIC_ON_TX << PCM2_BT_MODE_SFT;
+		pcm_con |= AUD_PCM_AFIFO_AFIFO << PCM2_AFIFO_SFT;
+		pcm_con |= AUD_PCM_WLEN_PCM_32_BCK_CYCLES << PCM2_WLEN_SFT;
+		pcm_con |= rate_reg << PCM2_MODE_SFT;
+		pcm_con |= AUD_PCM_FMT_PCM_MODE_B << PCM2_FMT_SFT;
+
+		regmap_update_bits(afe->regmap, PCM2_INTF_CON,
+				   0xfffffffe, pcm_con);
+		break;
+	default:
+		dev_warn(afe->dev, "%s(), id %d not support\n",
+			 __func__, dai->id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops mtk_dai_pcm_ops = {
+	.hw_params = mtk_dai_pcm_hw_params,
+};
+
+/* dai driver */
+#define MTK_PCM_RATES (SNDRV_PCM_RATE_8000 |\
+		       SNDRV_PCM_RATE_16000 |\
+		       SNDRV_PCM_RATE_32000 |\
+		       SNDRV_PCM_RATE_48000)
+
+#define MTK_PCM_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			 SNDRV_PCM_FMTBIT_S24_LE |\
+			 SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver mtk_dai_pcm_driver[] = {
+	{
+		.name = "PCM 1",
+		.id = MT6797_DAI_PCM_1,
+		.playback = {
+			.stream_name = "PCM 1 Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.capture = {
+			.stream_name = "PCM 1 Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mtk_dai_pcm_ops,
+		.symmetric_rates = 1,
+		.symmetric_samplebits = 1,
+	},
+	{
+		.name = "PCM 2",
+		.id = MT6797_DAI_PCM_2,
+		.playback = {
+			.stream_name = "PCM 2 Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.capture = {
+			.stream_name = "PCM 2 Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mtk_dai_pcm_ops,
+		.symmetric_rates = 1,
+		.symmetric_samplebits = 1,
+	},
+};
+
+int mt6797_dai_pcm_register(struct mtk_base_afe *afe)
+{
+	int id = MT6797_DAI_PCM_1;
+
+	afe->sub_dais[id].dai_drivers = mtk_dai_pcm_driver;
+	afe->sub_dais[id].num_dai_drivers = ARRAY_SIZE(mtk_dai_pcm_driver);
+
+	afe->sub_dais[id].dapm_widgets = mtk_dai_pcm_widgets;
+	afe->sub_dais[id].num_dapm_widgets = ARRAY_SIZE(mtk_dai_pcm_widgets);
+	afe->sub_dais[id].dapm_routes = mtk_dai_pcm_routes;
+	afe->sub_dais[id].num_dapm_routes = ARRAY_SIZE(mtk_dai_pcm_routes);
+
+	return 0;
+}
diff --git a/sound/soc/mediatek/mt6797/mt6797-reg.h b/sound/soc/mediatek/mt6797/mt6797-reg.h
index ffb5536..978f146 100644
--- a/sound/soc/mediatek/mt6797/mt6797-reg.h
+++ b/sound/soc/mediatek/mt6797/mt6797-reg.h
@@ -835,4 +835,181 @@
 #define DL1_HD_ALIGN_SFT                                    0
 #define DL1_HD_ALIGN_MASK                                   0x1
 #define DL1_HD_ALIGN_MASK_SFT                               (0x1 << 0)
+
+/* PCM_INTF_CON1 */
+#define PCM_FIX_VALUE_SEL_SFT                               31
+#define PCM_FIX_VALUE_SEL_MASK                              0x1
+#define PCM_FIX_VALUE_SEL_MASK_SFT                          (0x1 << 31)
+#define PCM_BUFFER_LOOPBACK_SFT                             30
+#define PCM_BUFFER_LOOPBACK_MASK                            0x1
+#define PCM_BUFFER_LOOPBACK_MASK_SFT                        (0x1 << 30)
+#define PCM_PARALLEL_LOOPBACK_SFT                           29
+#define PCM_PARALLEL_LOOPBACK_MASK                          0x1
+#define PCM_PARALLEL_LOOPBACK_MASK_SFT                      (0x1 << 29)
+#define PCM_SERIAL_LOOPBACK_SFT                             28
+#define PCM_SERIAL_LOOPBACK_MASK                            0x1
+#define PCM_SERIAL_LOOPBACK_MASK_SFT                        (0x1 << 28)
+#define PCM_DAI_PCM_LOOPBACK_SFT                            27
+#define PCM_DAI_PCM_LOOPBACK_MASK                           0x1
+#define PCM_DAI_PCM_LOOPBACK_MASK_SFT                       (0x1 << 27)
+#define PCM_I2S_PCM_LOOPBACK_SFT                            26
+#define PCM_I2S_PCM_LOOPBACK_MASK                           0x1
+#define PCM_I2S_PCM_LOOPBACK_MASK_SFT                       (0x1 << 26)
+#define PCM_SYNC_DELSEL_SFT                                 25
+#define PCM_SYNC_DELSEL_MASK                                0x1
+#define PCM_SYNC_DELSEL_MASK_SFT                            (0x1 << 25)
+#define PCM_TX_LR_SWAP_SFT                                  24
+#define PCM_TX_LR_SWAP_MASK                                 0x1
+#define PCM_TX_LR_SWAP_MASK_SFT                             (0x1 << 24)
+#define PCM_SYNC_OUT_INV_SFT                                23
+#define PCM_SYNC_OUT_INV_MASK                               0x1
+#define PCM_SYNC_OUT_INV_MASK_SFT                           (0x1 << 23)
+#define PCM_BCLK_OUT_INV_SFT                                22
+#define PCM_BCLK_OUT_INV_MASK                               0x1
+#define PCM_BCLK_OUT_INV_MASK_SFT                           (0x1 << 22)
+#define PCM_SYNC_IN_INV_SFT                                 21
+#define PCM_SYNC_IN_INV_MASK                                0x1
+#define PCM_SYNC_IN_INV_MASK_SFT                            (0x1 << 21)
+#define PCM_BCLK_IN_INV_SFT                                 20
+#define PCM_BCLK_IN_INV_MASK                                0x1
+#define PCM_BCLK_IN_INV_MASK_SFT                            (0x1 << 20)
+#define PCM_TX_LCH_RPT_SFT                                  19
+#define PCM_TX_LCH_RPT_MASK                                 0x1
+#define PCM_TX_LCH_RPT_MASK_SFT                             (0x1 << 19)
+#define PCM_VBT_16K_MODE_SFT                                18
+#define PCM_VBT_16K_MODE_MASK                               0x1
+#define PCM_VBT_16K_MODE_MASK_SFT                           (0x1 << 18)
+#define PCM_EXT_MODEM_SFT                                   17
+#define PCM_EXT_MODEM_MASK                                  0x1
+#define PCM_EXT_MODEM_MASK_SFT                              (0x1 << 17)
+#define PCM_24BIT_SFT                                       16
+#define PCM_24BIT_MASK                                      0x1
+#define PCM_24BIT_MASK_SFT                                  (0x1 << 16)
+#define PCM_WLEN_SFT                                        14
+#define PCM_WLEN_MASK                                       0x3
+#define PCM_WLEN_MASK_SFT                                   (0x3 << 14)
+#define PCM_SYNC_LENGTH_SFT                                 9
+#define PCM_SYNC_LENGTH_MASK                                0x1f
+#define PCM_SYNC_LENGTH_MASK_SFT                            (0x1f << 9)
+#define PCM_SYNC_TYPE_SFT                                   8
+#define PCM_SYNC_TYPE_MASK                                  0x1
+#define PCM_SYNC_TYPE_MASK_SFT                              (0x1 << 8)
+#define PCM_BT_MODE_SFT                                     7
+#define PCM_BT_MODE_MASK                                    0x1
+#define PCM_BT_MODE_MASK_SFT                                (0x1 << 7)
+#define PCM_BYP_ASRC_SFT                                    6
+#define PCM_BYP_ASRC_MASK                                   0x1
+#define PCM_BYP_ASRC_MASK_SFT                               (0x1 << 6)
+#define PCM_SLAVE_SFT                                       5
+#define PCM_SLAVE_MASK                                      0x1
+#define PCM_SLAVE_MASK_SFT                                  (0x1 << 5)
+#define PCM_MODE_SFT                                        3
+#define PCM_MODE_MASK                                       0x3
+#define PCM_MODE_MASK_SFT                                   (0x3 << 3)
+#define PCM_FMT_SFT                                         1
+#define PCM_FMT_MASK                                        0x3
+#define PCM_FMT_MASK_SFT                                    (0x3 << 1)
+#define PCM_EN_SFT                                          0
+#define PCM_EN_MASK                                         0x1
+#define PCM_EN_MASK_SFT                                     (0x1 << 0)
+
+/* PCM_INTF_CON2 */
+#define PCM1_TX_FIFO_OV_SFT                                 31
+#define PCM1_TX_FIFO_OV_MASK                                0x1
+#define PCM1_TX_FIFO_OV_MASK_SFT                            (0x1 << 31)
+#define PCM1_RX_FIFO_OV_SFT                                 30
+#define PCM1_RX_FIFO_OV_MASK                                0x1
+#define PCM1_RX_FIFO_OV_MASK_SFT                            (0x1 << 30)
+#define PCM2_TX_FIFO_OV_SFT                                 29
+#define PCM2_TX_FIFO_OV_MASK                                0x1
+#define PCM2_TX_FIFO_OV_MASK_SFT                            (0x1 << 29)
+#define PCM2_RX_FIFO_OV_SFT                                 28
+#define PCM2_RX_FIFO_OV_MASK                                0x1
+#define PCM2_RX_FIFO_OV_MASK_SFT                            (0x1 << 28)
+#define PCM1_SYNC_GLITCH_SFT                                27
+#define PCM1_SYNC_GLITCH_MASK                               0x1
+#define PCM1_SYNC_GLITCH_MASK_SFT                           (0x1 << 27)
+#define PCM2_SYNC_GLITCH_SFT                                26
+#define PCM2_SYNC_GLITCH_MASK                               0x1
+#define PCM2_SYNC_GLITCH_MASK_SFT                           (0x1 << 26)
+#define PCM1_PCM2_LOOPBACK_SFT                              15
+#define PCM1_PCM2_LOOPBACK_MASK                             0x1
+#define PCM1_PCM2_LOOPBACK_MASK_SFT                         (0x1 << 15)
+#define DAI_PCM_LOOPBACK_CH_SFT                             13
+#define DAI_PCM_LOOPBACK_CH_MASK                            0x1
+#define DAI_PCM_LOOPBACK_CH_MASK_SFT                        (0x1 << 13)
+#define I2S_PCM_LOOPBACK_CH_SFT                             12
+#define I2S_PCM_LOOPBACK_CH_MASK                            0x1
+#define I2S_PCM_LOOPBACK_CH_MASK_SFT                        (0x1 << 12)
+#define PCM_USE_MD3_SFT                                     8
+#define PCM_USE_MD3_MASK                                    0x1
+#define PCM_USE_MD3_MASK_SFT                                (0x1 << 8)
+#define TX_FIX_VALUE_SFT                                    0
+#define TX_FIX_VALUE_MASK                                   0xff
+#define TX_FIX_VALUE_MASK_SFT                               (0xff << 0)
+
+/* PCM2_INTF_CON */
+#define PCM2_TX_FIX_VALUE_SFT                                24
+#define PCM2_TX_FIX_VALUE_MASK                               0xff
+#define PCM2_TX_FIX_VALUE_MASK_SFT                           (0xff << 24)
+#define PCM2_FIX_VALUE_SEL_SFT                               23
+#define PCM2_FIX_VALUE_SEL_MASK                              0x1
+#define PCM2_FIX_VALUE_SEL_MASK_SFT                          (0x1 << 23)
+#define PCM2_BUFFER_LOOPBACK_SFT                             22
+#define PCM2_BUFFER_LOOPBACK_MASK                            0x1
+#define PCM2_BUFFER_LOOPBACK_MASK_SFT                        (0x1 << 22)
+#define PCM2_PARALLEL_LOOPBACK_SFT                           21
+#define PCM2_PARALLEL_LOOPBACK_MASK                          0x1
+#define PCM2_PARALLEL_LOOPBACK_MASK_SFT                      (0x1 << 21)
+#define PCM2_SERIAL_LOOPBACK_SFT                             20
+#define PCM2_SERIAL_LOOPBACK_MASK                            0x1
+#define PCM2_SERIAL_LOOPBACK_MASK_SFT                        (0x1 << 20)
+#define PCM2_DAI_PCM_LOOPBACK_SFT                            19
+#define PCM2_DAI_PCM_LOOPBACK_MASK                           0x1
+#define PCM2_DAI_PCM_LOOPBACK_MASK_SFT                       (0x1 << 19)
+#define PCM2_I2S_PCM_LOOPBACK_SFT                            18
+#define PCM2_I2S_PCM_LOOPBACK_MASK                           0x1
+#define PCM2_I2S_PCM_LOOPBACK_MASK_SFT                       (0x1 << 18)
+#define PCM2_SYNC_DELSEL_SFT                                 17
+#define PCM2_SYNC_DELSEL_MASK                                0x1
+#define PCM2_SYNC_DELSEL_MASK_SFT                            (0x1 << 17)
+#define PCM2_TX_LR_SWAP_SFT                                  16
+#define PCM2_TX_LR_SWAP_MASK                                 0x1
+#define PCM2_TX_LR_SWAP_MASK_SFT                             (0x1 << 16)
+#define PCM2_SYNC_IN_INV_SFT                                 15
+#define PCM2_SYNC_IN_INV_MASK                                0x1
+#define PCM2_SYNC_IN_INV_MASK_SFT                            (0x1 << 15)
+#define PCM2_BCLK_IN_INV_SFT                                 14
+#define PCM2_BCLK_IN_INV_MASK                                0x1
+#define PCM2_BCLK_IN_INV_MASK_SFT                            (0x1 << 14)
+#define PCM2_TX_LCH_RPT_SFT                                  13
+#define PCM2_TX_LCH_RPT_MASK                                 0x1
+#define PCM2_TX_LCH_RPT_MASK_SFT                             (0x1 << 13)
+#define PCM2_VBT_16K_MODE_SFT                                12
+#define PCM2_VBT_16K_MODE_MASK                               0x1
+#define PCM2_VBT_16K_MODE_MASK_SFT                           (0x1 << 12)
+#define PCM2_LOOPBACK_CH_SEL_SFT                             10
+#define PCM2_LOOPBACK_CH_SEL_MASK                            0x3
+#define PCM2_LOOPBACK_CH_SEL_MASK_SFT                        (0x3 << 10)
+#define PCM2_TX2_BT_MODE_SFT                                 8
+#define PCM2_TX2_BT_MODE_MASK                                0x1
+#define PCM2_TX2_BT_MODE_MASK_SFT                            (0x1 << 8)
+#define PCM2_BT_MODE_SFT                                     7
+#define PCM2_BT_MODE_MASK                                    0x1
+#define PCM2_BT_MODE_MASK_SFT                                (0x1 << 7)
+#define PCM2_AFIFO_SFT                                       6
+#define PCM2_AFIFO_MASK                                      0x1
+#define PCM2_AFIFO_MASK_SFT                                  (0x1 << 6)
+#define PCM2_WLEN_SFT                                        5
+#define PCM2_WLEN_MASK                                       0x1
+#define PCM2_WLEN_MASK_SFT                                   (0x1 << 5)
+#define PCM2_MODE_SFT                                        3
+#define PCM2_MODE_MASK                                       0x3
+#define PCM2_MODE_MASK_SFT                                   (0x3 << 3)
+#define PCM2_FMT_SFT                                         1
+#define PCM2_FMT_MASK                                        0x3
+#define PCM2_FMT_MASK_SFT                                    (0x3 << 1)
+#define PCM2_EN_SFT                                          0
+#define PCM2_EN_MASK                                         0x1
+#define PCM2_EN_MASK_SFT                                     (0x1 << 0)
 #endif
-- 
1.9.1
