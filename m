From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8825: extend FLL function
Date: Mon, 29 Feb 2016 02:23:47 +0800
Message-ID: <1456683827-6597-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server-codec (unknown [202.39.226.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 73778260524
 for <alsa-devel@alsa-project.org>; Sun, 28 Feb 2016 19:25:16 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

Extend FLL clock source from MCLK/BCLK/FS.
Modify FLL calculation and parameter setting.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8825.c | 128 ++++++++++++++++++++++++++++++++-------------
 sound/soc/codecs/nau8825.h |  21 ++++++--
 2 files changed, 108 insertions(+), 41 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index c1b87c5..504c969 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -31,7 +31,7 @@
 #include "nau8825.h"
 
 #define NAU_FREF_MAX 13500000
-#define NAU_FVCO_MAX 100000000
+#define NAU_FVCO_MAX 124000000
 #define NAU_FVCO_MIN 90000000
 
 struct nau8825_fll {
@@ -874,8 +874,8 @@ static int nau8825_codec_probe(struct snd_soc_codec *codec)
 static int nau8825_calc_fll_param(unsigned int fll_in, unsigned int fs,
 		struct nau8825_fll *fll_param)
 {
-	u64 fvco;
-	unsigned int fref, i;
+	u64 fvco, fvco_max;
+	unsigned int fref, i, fvco_sel;
 
 	/* Ensure the reference clock frequency (FREF) is <= 13.5MHz by dividing
 	 * freq_in by 1, 2, 4, or 8 using FLL pre-scalar.
@@ -900,18 +900,23 @@ static int nau8825_calc_fll_param(unsigned int fll_in, unsigned int fs,
 	fll_param->ratio = fll_ratio[i].val;
 
 	/* Calculate the frequency of DCO (FDCO) given freq_out = 256 * Fs.
-	 * FDCO must be within the 90MHz - 100MHz or the FFL cannot be
+	 * FDCO must be within the 90MHz - 124MHz or the FFL cannot be
 	 * guaranteed across the full range of operation.
 	 * FDCO = freq_out * 2 * mclk_src_scaling
 	 */
+	fvco_max = 0;
+	fvco_sel = ARRAY_SIZE(mclk_src_scaling);
 	for (i = 0; i < ARRAY_SIZE(mclk_src_scaling); i++) {
 		fvco = 256 * fs * 2 * mclk_src_scaling[i].param;
-		if (NAU_FVCO_MIN < fvco && fvco < NAU_FVCO_MAX)
-			break;
+		if (fvco > NAU_FVCO_MIN && fvco < NAU_FVCO_MAX &&
+			fvco_max < fvco) {
+			fvco_max = fvco;
+			fvco_sel = i;
+		}
 	}
-	if (i == ARRAY_SIZE(mclk_src_scaling))
+	if (ARRAY_SIZE(mclk_src_scaling) == fvco_sel)
 		return -EINVAL;
-	fll_param->mclk_src = mclk_src_scaling[i].val;
+	fll_param->mclk_src = mclk_src_scaling[fvco_sel].val;
 
 	/* Calculate the FLL 10-bit integer input and the FLL 16-bit fractional
 	 * input based on FDCO, FREF and FLL ratio.
@@ -926,7 +931,8 @@ static void nau8825_fll_apply(struct nau8825 *nau8825,
 		struct nau8825_fll *fll_param)
 {
 	regmap_update_bits(nau8825->regmap, NAU8825_REG_CLK_DIVIDER,
-		NAU8825_CLK_MCLK_SRC_MASK, fll_param->mclk_src);
+		NAU8825_CLK_SRC_MASK | NAU8825_CLK_MCLK_SRC_MASK,
+		NAU8825_CLK_SRC_MCLK | fll_param->mclk_src);
 	regmap_update_bits(nau8825->regmap, NAU8825_REG_FLL1,
 			NAU8825_FLL_RATIO_MASK, fll_param->ratio);
 	/* FLL 16-bit fractional input */
@@ -939,10 +945,25 @@ static void nau8825_fll_apply(struct nau8825 *nau8825,
 			NAU8825_FLL_REF_DIV_MASK, fll_param->clk_ref_div);
 	/* select divided VCO input */
 	regmap_update_bits(nau8825->regmap, NAU8825_REG_FLL5,
-			NAU8825_FLL_FILTER_SW_MASK, 0x0000);
-	/* FLL sigma delta modulator enable */
-	regmap_update_bits(nau8825->regmap, NAU8825_REG_FLL6,
-			NAU8825_SDM_EN_MASK, NAU8825_SDM_EN);
+		NAU8825_FLL_CLK_SW_MASK, NAU8825_FLL_CLK_SW_REF);
+	/* Disable free-running mode */
+	regmap_update_bits(nau8825->regmap,
+		NAU8825_REG_FLL6, NAU8825_DCO_EN, 0);
+	if (fll_param->fll_frac) {
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_FLL5,
+			NAU8825_FLL_PDB_DAC_EN | NAU8825_FLL_LOOP_FTR_EN |
+			NAU8825_FLL_FTR_SW_MASK,
+			NAU8825_FLL_PDB_DAC_EN | NAU8825_FLL_LOOP_FTR_EN |
+			NAU8825_FLL_FTR_SW_FILTER);
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_FLL6,
+			NAU8825_SDM_EN, NAU8825_SDM_EN);
+	} else {
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_FLL5,
+			NAU8825_FLL_PDB_DAC_EN | NAU8825_FLL_LOOP_FTR_EN |
+			NAU8825_FLL_FTR_SW_MASK, NAU8825_FLL_FTR_SW_ACCU);
+		regmap_update_bits(nau8825->regmap,
+			NAU8825_REG_FLL6, NAU8825_SDM_EN, 0);
+	}
 }
 
 /* freq_out must be 256*Fs in order to achieve the best performance */
@@ -970,6 +991,36 @@ static int nau8825_set_pll(struct snd_soc_codec *codec, int pll_id, int source,
 	return 0;
 }
 
+static int nau8825_mclk_prepare(struct nau8825 *nau8825, unsigned int freq)
+{
+	int ret = 0;
+
+	/* We selected MCLK source but the clock itself managed externally */
+	if (!nau8825->mclk)
+		return 0;
+
+	if (!nau8825->mclk_freq) {
+		ret = clk_prepare_enable(nau8825->mclk);
+		if (ret) {
+			dev_err(nau8825->dev, "Unable to prepare codec mclk\n");
+			return ret;
+		}
+	}
+
+	if (nau8825->mclk_freq != freq) {
+		nau8825->mclk_freq = freq;
+
+		freq = clk_round_rate(nau8825->mclk, freq);
+		ret = clk_set_rate(nau8825->mclk, freq);
+		if (ret) {
+			dev_err(nau8825->dev, "Unable to set mclk rate\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 	unsigned int freq)
 {
@@ -981,29 +1032,9 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 		regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
 			NAU8825_CLK_SRC_MASK, NAU8825_CLK_SRC_MCLK);
 		regmap_update_bits(regmap, NAU8825_REG_FLL6, NAU8825_DCO_EN, 0);
-
-		/* We selected MCLK source but the clock itself managed externally */
-		if (!nau8825->mclk)
-			break;
-
-		if (!nau8825->mclk_freq) {
-			ret = clk_prepare_enable(nau8825->mclk);
-			if (ret) {
-				dev_err(nau8825->dev, "Unable to prepare codec mclk\n");
-				return ret;
-			}
-		}
-
-		if (nau8825->mclk_freq != freq) {
-			nau8825->mclk_freq = freq;
-
-			freq = clk_round_rate(nau8825->mclk, freq);
-			ret = clk_set_rate(nau8825->mclk, freq);
-			if (ret) {
-				dev_err(nau8825->dev, "Unable to set mclk rate\n");
-				return ret;
-			}
-		}
+		ret = nau8825_mclk_prepare(nau8825, freq);
+		if (ret)
+			return ret;
 
 		break;
 	case NAU8825_CLK_INTERNAL:
@@ -1011,7 +1042,32 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 			NAU8825_DCO_EN);
 		regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
 			NAU8825_CLK_SRC_MASK, NAU8825_CLK_SRC_VCO);
+		if (nau8825->mclk_freq) {
+			clk_disable_unprepare(nau8825->mclk);
+			nau8825->mclk_freq = 0;
+		}
+
+		break;
+	case NAU8825_CLK_FLL_MCLK:
+		regmap_update_bits(regmap, NAU8825_REG_FLL3,
+			NAU8825_FLL_CLK_SRC_MASK, NAU8825_FLL_CLK_SRC_MCLK);
+		ret = nau8825_mclk_prepare(nau8825, freq);
+		if (ret)
+			return ret;
+
+		break;
+	case NAU8825_CLK_FLL_BLK:
+		regmap_update_bits(regmap, NAU8825_REG_FLL3,
+			NAU8825_FLL_CLK_SRC_MASK, NAU8825_FLL_CLK_SRC_BLK);
+		if (nau8825->mclk_freq) {
+			clk_disable_unprepare(nau8825->mclk);
+			nau8825->mclk_freq = 0;
+		}
 
+		break;
+	case NAU8825_CLK_FLL_FS:
+		regmap_update_bits(regmap, NAU8825_REG_FLL3,
+			NAU8825_FLL_CLK_SRC_MASK, NAU8825_FLL_CLK_SRC_FS);
 		if (nau8825->mclk_freq) {
 			clk_disable_unprepare(nau8825->mclk);
 			nau8825->mclk_freq = 0;
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index dff8edb..8237693 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -112,20 +112,28 @@
 
 /* FLL3 (0x06) */
 #define NAU8825_FLL_INTEGER_MASK		(0x3ff << 0)
+#define NAU8825_FLL_CLK_SRC_SFT		10
+#define NAU8825_FLL_CLK_SRC_MASK		(0x3 << NAU8825_FLL_CLK_SRC_SFT)
+#define NAU8825_FLL_CLK_SRC_MCLK		(0 << NAU8825_FLL_CLK_SRC_SFT)
+#define NAU8825_FLL_CLK_SRC_BLK		(0x2 << NAU8825_FLL_CLK_SRC_SFT)
+#define NAU8825_FLL_CLK_SRC_FS			(0x3 << NAU8825_FLL_CLK_SRC_SFT)
 
 /* FLL4 (0x07) */
 #define NAU8825_FLL_REF_DIV_MASK		(0x3 << 10)
 
 /* FLL5 (0x08) */
-#define NAU8825_FLL_FILTER_SW_MASK		(0x1 << 14)
+#define NAU8825_FLL_PDB_DAC_EN		(0x1 << 15)
+#define NAU8825_FLL_LOOP_FTR_EN		(0x1 << 14)
+#define NAU8825_FLL_CLK_SW_MASK		(0x1 << 13)
+#define NAU8825_FLL_CLK_SW_N2			(0x1 << 13)
+#define NAU8825_FLL_CLK_SW_REF		(0x0 << 13)
+#define NAU8825_FLL_FTR_SW_MASK		(0x1 << 12)
+#define NAU8825_FLL_FTR_SW_ACCU		(0x1 << 12)
+#define NAU8825_FLL_FTR_SW_FILTER		(0x0 << 12)
 
 /* FLL6 (0x9) */
-#define NAU8825_DCO_EN_MASK			(0x1 << 15)
 #define NAU8825_DCO_EN				(0x1 << 15)
-#define NAU8825_DCO_DIS				(0x0 << 15)
-#define NAU8825_SDM_EN_MASK			(0x1 << 14)
 #define NAU8825_SDM_EN				(0x1 << 14)
-#define NAU8825_SDM_DIS				(0x0 << 14)
 
 /* HSD_CTRL (0xc) */
 #define NAU8825_HSD_AUTO_MODE	(1 << 6)
@@ -306,6 +314,9 @@
 enum {
 	NAU8825_CLK_MCLK = 0,
 	NAU8825_CLK_INTERNAL,
+	NAU8825_CLK_FLL_MCLK,
+	NAU8825_CLK_FLL_BLK,
+	NAU8825_CLK_FLL_FS,
 };
 
 struct nau8825 {
-- 
2.6.4
