From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 2/2] ASoC: rt5677: add i2s asrc clk src
	selection
Date: Tue, 28 Apr 2015 11:27:40 +0800
Message-ID: <1430191660-2959-2-git-send-email-bardliao@realtek.com>
References: <1430191660-2959-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id E2A73265363
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2015 05:27:53 +0200 (CEST)
In-Reply-To: <1430191660-2959-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, koro.chen@mediatek.com, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The ASRC source of i2s are also configurable. We add the selection
in the existing rt5677_sel_asrc_clk_src API.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5677.c | 30 ++++++++++++++++++++++++++++++
 sound/soc/codecs/rt5677.h | 14 ++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index dca64ae..685e268 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -1060,6 +1060,7 @@ int rt5677_sel_asrc_clk_src(struct snd_soc_codec *codec,
 	unsigned int asrc5_mask = 0, asrc5_value = 0;
 	unsigned int asrc6_mask = 0, asrc6_value = 0;
 	unsigned int asrc7_mask = 0, asrc7_value = 0;
+	unsigned int asrc8_mask = 0, asrc8_value = 0;
 
 	switch (clk_src) {
 	case RT5677_CLK_SEL_SYS:
@@ -1196,6 +1197,35 @@ int rt5677_sel_asrc_clk_src(struct snd_soc_codec *codec,
 		regmap_update_bits(rt5677->regmap, RT5677_ASRC_7, asrc7_mask,
 			asrc7_value);
 
+	/* ASRC 8 */
+	if (filter_mask & RT5677_I2S1_SOURCE) {
+		asrc8_mask |= RT5677_I2S1_CLK_SEL_MASK;
+		asrc8_value = (asrc8_value & ~RT5677_I2S1_CLK_SEL_MASK)
+			| ((clk_src - 1) << RT5677_I2S1_CLK_SEL_SFT);
+	}
+
+	if (filter_mask & RT5677_I2S2_SOURCE) {
+		asrc8_mask |= RT5677_I2S2_CLK_SEL_MASK;
+		asrc8_value = (asrc8_value & ~RT5677_I2S2_CLK_SEL_MASK)
+			| ((clk_src - 1) << RT5677_I2S2_CLK_SEL_SFT);
+	}
+
+	if (filter_mask & RT5677_I2S3_SOURCE) {
+		asrc8_mask |= RT5677_I2S3_CLK_SEL_MASK;
+		asrc8_value = (asrc8_value & ~RT5677_I2S3_CLK_SEL_MASK)
+			| ((clk_src - 1) << RT5677_I2S3_CLK_SEL_SFT);
+	}
+
+	if (filter_mask & RT5677_I2S4_SOURCE) {
+		asrc8_mask |= RT5677_I2S4_CLK_SEL_MASK;
+		asrc8_value = (asrc8_value & ~RT5677_I2S4_CLK_SEL_MASK)
+			| ((clk_src - 1) << RT5677_I2S4_CLK_SEL_SFT);
+	}
+
+	if (asrc8_mask)
+		regmap_update_bits(rt5677->regmap, RT5677_ASRC_8, asrc8_mask,
+			asrc8_value);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(rt5677_sel_asrc_clk_src);
diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index 9dceb41..62571d0 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -1446,6 +1446,16 @@
 #define RT5677_DSP_OB_4_7_CLK_SEL_MASK		(0xf << 8)
 #define RT5677_DSP_OB_4_7_CLK_SEL_SFT		8
 
+/* ASRC Control 8 (0x8a) */
+#define RT5677_I2S1_CLK_SEL_MASK		(0xf << 12)
+#define RT5677_I2S1_CLK_SEL_SFT			12
+#define RT5677_I2S2_CLK_SEL_MASK		(0xf << 8)
+#define RT5677_I2S2_CLK_SEL_SFT			8
+#define RT5677_I2S3_CLK_SEL_MASK		(0xf << 4)
+#define RT5677_I2S3_CLK_SEL_SFT			4
+#define RT5677_I2S4_CLK_SEL_MASK		(0xf)
+#define RT5677_I2S4_CLK_SEL_SFT			0
+
 /* VAD Function Control 4 (0x9f) */
 #define RT5677_VAD_SRC_MASK			(0x7 << 8)
 #define RT5677_VAD_SRC_SFT			8
@@ -1744,6 +1754,10 @@ enum {
 	RT5677_AD_MONO_R_FILTER = (0x1 << 12),
 	RT5677_DSP_OB_0_3_FILTER = (0x1 << 13),
 	RT5677_DSP_OB_4_7_FILTER = (0x1 << 14),
+	RT5677_I2S1_SOURCE = (0x1 << 15),
+	RT5677_I2S2_SOURCE = (0x1 << 16),
+	RT5677_I2S3_SOURCE = (0x1 << 17),
+	RT5677_I2S4_SOURCE = (0x1 << 18),
 };
 
 struct rt5677_priv {
-- 
1.8.1.1.439.g50a6b54
