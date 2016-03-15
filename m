From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: improve FLL function for
	better performance" to the asoc tree
Date: Tue, 15 Mar 2016 09:28:59 +0000
Message-ID: <E1aflHf-0005Re-Md@debutante>
References: <1458014976-28100-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (unknown [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D40852614C2
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 10:29:26 +0100 (CET)
In-Reply-To: <1458014976-28100-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: improve FLL function for better performance

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

>From 5d4e244cd2c7a4ab9f8947da4ef40eccdfd15e74 Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Tue, 15 Mar 2016 12:09:36 +0800
Subject: [PATCH] ASoC: nau8825: improve FLL function for better performance

In FLL calculation, increase VCO/DCO frequency for better performance.
Besides, have different register configuration according to fraction or not
when apply FLL parameters.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8825.c | 47 +++++++++++++++++++++++++++++++++-------------
 sound/soc/codecs/nau8825.h | 13 ++++++++-----
 2 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index ac264ec3d15e..3e7bee29eed4 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -31,7 +31,7 @@
 #include "nau8825.h"
 
 #define NAU_FREF_MAX 13500000
-#define NAU_FVCO_MAX 100000000
+#define NAU_FVCO_MAX 124000000
 #define NAU_FVCO_MIN 90000000
 
 struct nau8825_fll {
@@ -957,8 +957,8 @@ static int nau8825_codec_probe(struct snd_soc_codec *codec)
 static int nau8825_calc_fll_param(unsigned int fll_in, unsigned int fs,
 		struct nau8825_fll *fll_param)
 {
-	u64 fvco;
-	unsigned int fref, i;
+	u64 fvco, fvco_max;
+	unsigned int fref, i, fvco_sel;
 
 	/* Ensure the reference clock frequency (FREF) is <= 13.5MHz by dividing
 	 * freq_in by 1, 2, 4, or 8 using FLL pre-scalar.
@@ -983,18 +983,23 @@ static int nau8825_calc_fll_param(unsigned int fll_in, unsigned int fs,
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
@@ -1009,7 +1014,8 @@ static void nau8825_fll_apply(struct nau8825 *nau8825,
 		struct nau8825_fll *fll_param)
 {
 	regmap_update_bits(nau8825->regmap, NAU8825_REG_CLK_DIVIDER,
-		NAU8825_CLK_MCLK_SRC_MASK, fll_param->mclk_src);
+		NAU8825_CLK_SRC_MASK | NAU8825_CLK_MCLK_SRC_MASK,
+		NAU8825_CLK_SRC_MCLK | fll_param->mclk_src);
 	regmap_update_bits(nau8825->regmap, NAU8825_REG_FLL1,
 			NAU8825_FLL_RATIO_MASK, fll_param->ratio);
 	/* FLL 16-bit fractional input */
@@ -1022,10 +1028,25 @@ static void nau8825_fll_apply(struct nau8825 *nau8825,
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
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index ed0d8f3df65f..5fe009dcfb3d 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -123,15 +123,18 @@
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
-- 
2.7.0
