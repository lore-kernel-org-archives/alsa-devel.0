From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5677: add API to select ASRC clock
	source
Date: Mon, 16 Mar 2015 14:39:57 +0800
Message-ID: <1426487997-18976-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id BDF3F2604D1
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2015 07:40:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: Oder Chiou <oder_chiou@realtek.com>, bardliao@realtek.com, alsa-devel@alsa-project.org, john.lin@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

This patch defines an API to select the clock source for specified filters.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 163 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/rt5677.h |  79 ++++++++++++++++++++++
 2 files changed, 242 insertions(+)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index c2a6e40..af18258 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -1034,6 +1034,169 @@ static int can_use_asrc(struct snd_soc_dapm_widget *source,
 	return 0;
 }
 
+/**
+ * rt5677_sel_asrc_clk_src - select ASRC clock source for a set of filters
+ * @codec: SoC audio codec device.
+ * @filter_mask: mask of filters.
+ * @clk_src: clock source
+ *
+ * The ASRC function is for asynchronous MCLK and LRCK. Also, since RT5677 can
+ * only support standard 32fs or 64fs i2s format, ASRC should be enabled to
+ * support special i2s clock format such as Intel's 100fs(100 * sampling rate).
+ * ASRC function will track i2s clock and generate a corresponding system clock
+ * for codec. This function provides an API to select the clock source for a
+ * set of filters specified by the mask. And the codec driver will turn on ASRC
+ * for these filters if ASRC is selected as their clock source.
+ */
+int rt5677_sel_asrc_clk_src(struct snd_soc_codec *codec,
+		unsigned int filter_mask, unsigned int clk_src)
+{
+	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
+	unsigned int asrc3_mask = 0, asrc3_value = 0;
+	unsigned int asrc4_mask = 0, asrc4_value = 0;
+	unsigned int asrc5_mask = 0, asrc5_value = 0;
+	unsigned int asrc6_mask = 0, asrc6_value = 0;
+	unsigned int asrc7_mask = 0, asrc7_value = 0;
+
+	switch (clk_src) {
+	case RT5677_CLK_SEL_SYS:
+	case RT5677_CLK_SEL_I2S1_ASRC:
+	case RT5677_CLK_SEL_I2S2_ASRC:
+	case RT5677_CLK_SEL_I2S3_ASRC:
+	case RT5677_CLK_SEL_I2S4_ASRC:
+	case RT5677_CLK_SEL_I2S5_ASRC:
+	case RT5677_CLK_SEL_I2S6_ASRC:
+	case RT5677_CLK_SEL_SYS2:
+	case RT5677_CLK_SEL_SYS3:
+	case RT5677_CLK_SEL_SYS4:
+	case RT5677_CLK_SEL_SYS5:
+	case RT5677_CLK_SEL_SYS6:
+	case RT5677_CLK_SEL_SYS7:
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	/* ASRC 3 */
+	if (filter_mask & RT5677_DA_STEREO_FILTER) {
+		asrc3_mask |= RT5677_DA_STO_CLK_SEL_MASK;
+		asrc3_value = (asrc3_value & ~RT5677_DA_STO_CLK_SEL_MASK)
+			| (clk_src << RT5677_DA_STO_CLK_SEL_SFT);
+	}
+
+	if (filter_mask & RT5677_DA_MONO2_L_FILTER) {
+		asrc3_mask |= RT5677_DA_MONO2L_CLK_SEL_MASK;
+		asrc3_value = (asrc3_value & ~RT5677_DA_MONO2L_CLK_SEL_MASK)
+			| (clk_src << RT5677_DA_MONO2L_CLK_SEL_SFT);
+	}
+
+	if (filter_mask & RT5677_DA_MONO2_R_FILTER) {
+		asrc3_mask |= RT5677_DA_MONO2R_CLK_SEL_MASK;
+		asrc3_value = (asrc3_value & ~RT5677_DA_MONO2R_CLK_SEL_MASK)
+			| (clk_src << RT5677_DA_MONO2R_CLK_SEL_SFT);
+	}
+
+	if (asrc3_mask)
+		regmap_update_bits(rt5677->regmap, RT5677_ASRC_3, asrc3_mask,
+			asrc3_value);
+
+	/* ASRC 4 */
+	if (filter_mask & RT5677_DA_MONO3_L_FILTER) {
+		asrc4_mask |= RT5677_DA_MONO3L_CLK_SEL_MASK;
+		asrc4_value = (asrc4_value & ~RT5677_DA_MONO3L_CLK_SEL_MASK)
+			| (clk_src << RT5677_DA_MONO3L_CLK_SEL_SFT);
+	}
+
+	if (filter_mask & RT5677_DA_MONO3_R_FILTER) {
+		asrc4_mask |= RT5677_DA_MONO3R_CLK_SEL_MASK;
+		asrc4_value = (asrc4_value & ~RT5677_DA_MONO3R_CLK_SEL_MASK)
+			| (clk_src << RT5677_DA_MONO3R_CLK_SEL_SFT);
+	}
+
+	if (filter_mask & RT5677_DA_MONO4_L_FILTER) {
+		asrc4_mask |= RT5677_DA_MONO4L_CLK_SEL_MASK;
+		asrc4_value = (asrc4_value & ~RT5677_DA_MONO4L_CLK_SEL_MASK)
+			| (clk_src << RT5677_DA_MONO4L_CLK_SEL_SFT);
+	}
+
+	if (filter_mask & RT5677_DA_MONO4_R_FILTER) {
+		asrc4_mask |= RT5677_DA_MONO4R_CLK_SEL_MASK;
+		asrc4_value = (asrc4_value & ~RT5677_DA_MONO4R_CLK_SEL_MASK)
+			| (clk_src << RT5677_DA_MONO4R_CLK_SEL_SFT);
+	}
+
+	if (asrc4_mask)
+		regmap_update_bits(rt5677->regmap, RT5677_ASRC_4, asrc4_mask,
+			asrc4_value);
+
+	/* ASRC 5 */
+	if (filter_mask & RT5677_AD_STEREO1_FILTER) {
+		asrc5_mask |= RT5677_AD_STO1_CLK_SEL_MASK;
+		asrc5_value = (asrc5_value & ~RT5677_AD_STO1_CLK_SEL_MASK)
+			| (clk_src << RT5677_AD_STO1_CLK_SEL_SFT);
+	}
+
+	if (filter_mask & RT5677_AD_STEREO2_FILTER) {
+		asrc5_mask |= RT5677_AD_STO2_CLK_SEL_MASK;
+		asrc5_value = (asrc5_value & ~RT5677_AD_STO2_CLK_SEL_MASK)
+			| (clk_src << RT5677_AD_STO2_CLK_SEL_SFT);
+	}
+
+	if (filter_mask & RT5677_AD_STEREO3_FILTER) {
+		asrc5_mask |= RT5677_AD_STO3_CLK_SEL_MASK;
+		asrc5_value = (asrc5_value & ~RT5677_AD_STO3_CLK_SEL_MASK)
+			| (clk_src << RT5677_AD_STO3_CLK_SEL_SFT);
+	}
+
+	if (filter_mask & RT5677_AD_STEREO4_FILTER) {
+		asrc5_mask |= RT5677_AD_STO4_CLK_SEL_MASK;
+		asrc5_value = (asrc5_value & ~RT5677_AD_STO4_CLK_SEL_MASK)
+			| (clk_src << RT5677_AD_STO4_CLK_SEL_SFT);
+	}
+
+	if (asrc5_mask)
+		regmap_update_bits(rt5677->regmap, RT5677_ASRC_5, asrc5_mask,
+			asrc5_value);
+
+	/* ASRC 6 */
+	if (filter_mask & RT5677_AD_MONO_L_FILTER) {
+		asrc6_mask |= RT5677_AD_MONOL_CLK_SEL_MASK;
+		asrc6_value = (asrc6_value & ~RT5677_AD_MONOL_CLK_SEL_MASK)
+			| (clk_src << RT5677_AD_MONOL_CLK_SEL_SFT);
+	}
+
+	if (filter_mask & RT5677_AD_MONO_R_FILTER) {
+		asrc6_mask |= RT5677_AD_MONOR_CLK_SEL_MASK;
+		asrc6_value = (asrc6_value & ~RT5677_AD_MONOR_CLK_SEL_MASK)
+			| (clk_src << RT5677_AD_MONOR_CLK_SEL_SFT);
+	}
+
+	if (asrc6_mask)
+		regmap_update_bits(rt5677->regmap, RT5677_ASRC_6, asrc6_mask,
+			asrc6_value);
+
+	/* ASRC 7 */
+	if (filter_mask & RT5677_DSP_OB_0_3_FILTER) {
+		asrc7_mask |= RT5677_DSP_OB_0_3_CLK_SEL_MASK;
+		asrc7_value = (asrc7_value & ~RT5677_DSP_OB_0_3_CLK_SEL_MASK)
+			| (clk_src << RT5677_DSP_OB_0_3_CLK_SEL_SFT);
+	}
+
+	if (filter_mask & RT5677_DSP_OB_4_7_FILTER) {
+		asrc7_mask |= RT5677_DSP_OB_4_7_CLK_SEL_MASK;
+		asrc7_value = (asrc7_value & ~RT5677_DSP_OB_4_7_CLK_SEL_MASK)
+			| (clk_src << RT5677_DSP_OB_4_7_CLK_SEL_SFT);
+	}
+
+	if (asrc7_mask)
+		regmap_update_bits(rt5677->regmap, RT5677_ASRC_7, asrc7_mask,
+			asrc7_value);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rt5677_sel_asrc_clk_src);
+
 /* Digital Mixer */
 static const struct snd_kcontrol_new rt5677_sto1_adc_l_mix[] = {
 	SOC_DAPM_SINGLE("ADC1 Switch", RT5677_STO1_ADC_MIXER,
diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index 07df96b..9dceb41 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -1406,6 +1406,46 @@
 #define RT5677_DSP_CLK_SRC_PLL2			(0x0 << 7)
 #define RT5677_DSP_CLK_SRC_BYPASS		(0x1 << 7)
 
+/* ASRC Control 3 (0x85) */
+#define RT5677_DA_STO_CLK_SEL_MASK		(0xf << 12)
+#define RT5677_DA_STO_CLK_SEL_SFT		12
+#define RT5677_DA_MONO2L_CLK_SEL_MASK		(0xf << 4)
+#define RT5677_DA_MONO2L_CLK_SEL_SFT		4
+#define RT5677_DA_MONO2R_CLK_SEL_MASK		(0xf << 0)
+#define RT5677_DA_MONO2R_CLK_SEL_SFT		0
+
+/* ASRC Control 4 (0x86) */
+#define RT5677_DA_MONO3L_CLK_SEL_MASK		(0xf << 12)
+#define RT5677_DA_MONO3L_CLK_SEL_SFT		12
+#define RT5677_DA_MONO3R_CLK_SEL_MASK		(0xf << 8)
+#define RT5677_DA_MONO3R_CLK_SEL_SFT		8
+#define RT5677_DA_MONO4L_CLK_SEL_MASK		(0xf << 4)
+#define RT5677_DA_MONO4L_CLK_SEL_SFT		4
+#define RT5677_DA_MONO4R_CLK_SEL_MASK		(0xf << 0)
+#define RT5677_DA_MONO4R_CLK_SEL_SFT		0
+
+/* ASRC Control 5 (0x87) */
+#define RT5677_AD_STO1_CLK_SEL_MASK		(0xf << 12)
+#define RT5677_AD_STO1_CLK_SEL_SFT		12
+#define RT5677_AD_STO2_CLK_SEL_MASK		(0xf << 8)
+#define RT5677_AD_STO2_CLK_SEL_SFT		8
+#define RT5677_AD_STO3_CLK_SEL_MASK		(0xf << 4)
+#define RT5677_AD_STO3_CLK_SEL_SFT		4
+#define RT5677_AD_STO4_CLK_SEL_MASK		(0xf << 0)
+#define RT5677_AD_STO4_CLK_SEL_SFT		0
+
+/* ASRC Control 6 (0x88) */
+#define RT5677_AD_MONOL_CLK_SEL_MASK		(0xf << 12)
+#define RT5677_AD_MONOL_CLK_SEL_SFT		12
+#define RT5677_AD_MONOR_CLK_SEL_MASK		(0xf << 8)
+#define RT5677_AD_MONOR_CLK_SEL_SFT		8
+
+/* ASRC Control 7 (0x89) */
+#define RT5677_DSP_OB_0_3_CLK_SEL_MASK		(0xf << 12)
+#define RT5677_DSP_OB_0_3_CLK_SEL_SFT		12
+#define RT5677_DSP_OB_4_7_CLK_SEL_MASK		(0xf << 8)
+#define RT5677_DSP_OB_4_7_CLK_SEL_SFT		8
+
 /* VAD Function Control 4 (0x9f) */
 #define RT5677_VAD_SRC_MASK			(0x7 << 8)
 #define RT5677_VAD_SRC_SFT			8
@@ -1670,6 +1710,42 @@ enum rt5677_type {
 	RT5676,
 };
 
+/* ASRC clock source selection */
+enum {
+	RT5677_CLK_SEL_SYS,
+	RT5677_CLK_SEL_I2S1_ASRC,
+	RT5677_CLK_SEL_I2S2_ASRC,
+	RT5677_CLK_SEL_I2S3_ASRC,
+	RT5677_CLK_SEL_I2S4_ASRC,
+	RT5677_CLK_SEL_I2S5_ASRC,
+	RT5677_CLK_SEL_I2S6_ASRC,
+	RT5677_CLK_SEL_SYS2,
+	RT5677_CLK_SEL_SYS3,
+	RT5677_CLK_SEL_SYS4,
+	RT5677_CLK_SEL_SYS5,
+	RT5677_CLK_SEL_SYS6,
+	RT5677_CLK_SEL_SYS7,
+};
+
+/* filter mask */
+enum {
+	RT5677_DA_STEREO_FILTER = 0x1,
+	RT5677_DA_MONO2_L_FILTER = (0x1 << 1),
+	RT5677_DA_MONO2_R_FILTER = (0x1 << 2),
+	RT5677_DA_MONO3_L_FILTER = (0x1 << 3),
+	RT5677_DA_MONO3_R_FILTER = (0x1 << 4),
+	RT5677_DA_MONO4_L_FILTER = (0x1 << 5),
+	RT5677_DA_MONO4_R_FILTER = (0x1 << 6),
+	RT5677_AD_STEREO1_FILTER = (0x1 << 7),
+	RT5677_AD_STEREO2_FILTER = (0x1 << 8),
+	RT5677_AD_STEREO3_FILTER = (0x1 << 9),
+	RT5677_AD_STEREO4_FILTER = (0x1 << 10),
+	RT5677_AD_MONO_L_FILTER = (0x1 << 11),
+	RT5677_AD_MONO_R_FILTER = (0x1 << 12),
+	RT5677_DSP_OB_0_3_FILTER = (0x1 << 13),
+	RT5677_DSP_OB_4_7_FILTER = (0x1 << 14),
+};
+
 struct rt5677_priv {
 	struct snd_soc_codec *codec;
 	struct rt5677_platform_data pdata;
@@ -1696,4 +1772,7 @@ struct rt5677_priv {
 	bool is_vref_slow;
 };
 
+int rt5677_sel_asrc_clk_src(struct snd_soc_codec *codec,
+		unsigned int filter_mask, unsigned int clk_src);
+
 #endif /* __RT5677_H__ */
-- 
1.8.1.1.439.g50a6b54
