From: Ben Zhang <benzh@chromium.org>
Subject: [PATCH v2 1/2] ASoC: nau8825: Add FLL configuration
Date: Fri,  9 Oct 2015 15:49:01 -0700
Message-ID: <1444430941-18379-1-git-send-email-benzh@chromium.org>
References: <1444427341-7135-1-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C4562651F0
 for <alsa-devel@alsa-project.org>; Sat, 10 Oct 2015 00:49:12 +0200 (CEST)
Received: by pacex6 with SMTP id ex6so98659628pac.0
 for <alsa-devel@alsa-project.org>; Fri, 09 Oct 2015 15:49:10 -0700 (PDT)
In-Reply-To: <1444427341-7135-1-git-send-email-benzh@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, John Hsu <KCHSU0@nuvoton.com>, Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>, Anatol Pomozov <anatol@google.com>, Chih-Chiang Chang <ccchang12@nuvoton.com>
List-Id: alsa-devel@alsa-project.org

snd_soc_codec_driver.set_pll is implemented to configure the FLL.
The codec internal SYSCLK can be from either the MCLK pin directly,
or the FLL. This is configured by snd_soc_codec_driver.set_pll.

Signed-off-by: Ben Zhang <benzh@chromium.org>
---
 sound/soc/codecs/nau8825.c | 162 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/nau8825.h |  28 ++++++--
 2 files changed, 185 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 5c1badf..010f50b 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -29,6 +29,58 @@
 
 #include "nau8825.h"
 
+#define NAU_FREF_MAX 13500000
+#define NAU_FVCO_MAX 100000000
+#define NAU_FVCO_MIN 90000000
+
+struct nau8825_fll {
+	int mclk_src;
+	int ratio;
+	int fll_frac;
+	int fll_int;
+	int clk_ref_div;
+};
+
+struct nau8825_fll_attr {
+	unsigned int param;
+	unsigned int val;
+};
+
+/* scaling for mclk from sysclk_src output */
+static const struct nau8825_fll_attr mclk_src_scaling[] = {
+	{ 1, 0x0 },
+	{ 2, 0x2 },
+	{ 4, 0x3 },
+	{ 8, 0x4 },
+	{ 16, 0x5 },
+	{ 32, 0x6 },
+	{ 3, 0x7 },
+	{ 6, 0xa },
+	{ 12, 0xb },
+	{ 24, 0xc },
+	{ 48, 0xd },
+	{ 96, 0xe },
+	{ 5, 0xf },
+};
+
+/* ratio for input clk freq */
+static const struct nau8825_fll_attr fll_ratio[] = {
+	{ 512000, 0x01 },
+	{ 256000, 0x02 },
+	{ 128000, 0x04 },
+	{ 64000, 0x08 },
+	{ 32000, 0x10 },
+	{ 8000, 0x20 },
+	{ 4000, 0x40 },
+};
+
+static const struct nau8825_fll_attr fll_pre_scalar[] = {
+	{ 1, 0x0 },
+	{ 2, 0x1 },
+	{ 4, 0x2 },
+	{ 8, 0x3 },
+};
+
 static const struct reg_default nau8825_reg_defaults[] = {
 	{ NAU8825_REG_ENA_CTRL, 0x00ff },
 	{ NAU8825_REG_CLK_DIVIDER, 0x0050 },
@@ -808,6 +860,115 @@ static int nau8825_codec_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
+/**
+ * nau8825_calc_fll_param - Calculate FLL parameters.
+ * @fll_in: external clock provided to codec.
+ * @fs: sampling rate.
+ * @fll_param: Pointer to structure of FLL parameters.
+ *
+ * Calculate FLL parameters to configure codec.
+ *
+ * Returns 0 for success or negative error code.
+ */
+static int nau8825_calc_fll_param(unsigned int fll_in, unsigned int fs,
+		struct nau8825_fll *fll_param)
+{
+	u64 fref, fvco, fll_input;
+	int i;
+
+	/* Ensure the reference clock frequency (FREF) is <= 13.5MHz by dividing
+	 * freq_in by 1, 2, 4, or 8 using FLL pre-scalar.
+	 * FREF = freq_in / NAU8825_FLL_REF_DIV_MASK
+	 */
+	for (i = 0; i < ARRAY_SIZE(fll_pre_scalar); i++) {
+		fref = fll_in / fll_pre_scalar[i].param;
+		if (fref <= NAU_FREF_MAX)
+			break;
+	}
+	if (i == ARRAY_SIZE(fll_pre_scalar))
+		return -EINVAL;
+	fll_param->clk_ref_div = fll_pre_scalar[i].val;
+
+	/* Choose the FLL ratio based on FREF */
+	for (i = 0; i < ARRAY_SIZE(fll_ratio); i++) {
+		if (fref >= fll_ratio[i].param)
+			break;
+	}
+	if (i == ARRAY_SIZE(fll_ratio))
+		return -EINVAL;
+	fll_param->ratio = fll_ratio[i].val;
+
+	/* Calculate the frequency of DCO (FDCO) given freq_out = 256 * Fs.
+	 * FDCO must be within the 90MHz - 100MHz or the FFL cannot be
+	 * guaranteed across the full range of operation.
+	 * FDCO = freq_out * 2 * mclk_src_scaling
+	 */
+	for (i = 0; i < ARRAY_SIZE(mclk_src_scaling); i++) {
+		fvco = 256 * fs * 2 * mclk_src_scaling[i].param;
+		if (NAU_FVCO_MIN < fvco && fvco < NAU_FVCO_MAX)
+			break;
+	}
+	if (i == ARRAY_SIZE(mclk_src_scaling))
+		return -EINVAL;
+	fll_param->mclk_src = mclk_src_scaling[i].val;
+
+	/* Calculate the FLL 10-bit integer input and the FLL 16-bit fractional
+	 * input based on FDCO, FREF and FLL ratio.
+	 */
+	fll_input = (fvco << 16) / (fref * fll_param->ratio);
+	fll_param->fll_int = fll_input >> 16;
+	fll_param->fll_frac = fll_input & 0xFFFF;
+	return 0;
+}
+
+static void nau8825_fll_apply(struct nau8825 *nau8825,
+		struct nau8825_fll *fll_param)
+{
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_CLK_DIVIDER,
+		NAU8825_CLK_MCLK_SRC_MASK, fll_param->mclk_src);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_FLL1,
+			NAU8825_FLL_RATIO_MASK, fll_param->ratio);
+	/* FLL 16-bit fractional input */
+	regmap_write(nau8825->regmap, NAU8825_REG_FLL2, fll_param->fll_frac);
+	/* FLL 10-bit integer input */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_FLL3,
+			NAU8825_FLL_INTEGER_MASK, fll_param->fll_int);
+	/* FLL pre-scaler */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_FLL4,
+			NAU8825_FLL_REF_DIV_MASK, fll_param->clk_ref_div);
+	/* select divided VCO input */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_FLL5,
+			NAU8825_FLL_FILTER_SW_MASK, 0x0000);
+	/* FLL sigma delta modulator enable */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_FLL6,
+			NAU8825_SDM_EN_MASK, NAU8825_SDM_EN);
+}
+
+/* freq_out must be 256*Fs in order to achieve the best performance */
+static int nau8825_set_pll(struct snd_soc_codec *codec, int pll_id, int source,
+		unsigned int freq_in, unsigned int freq_out)
+{
+	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
+	struct nau8825_fll fll_param;
+	int ret, fs;
+
+	fs = freq_out / 256;
+	ret = nau8825_calc_fll_param(freq_in, fs, &fll_param);
+	if (ret < 0) {
+		dev_err(codec->dev, "Unsupported input clock %d\n", freq_in);
+		return ret;
+	}
+	dev_dbg(codec->dev, "mclk_src=%x ratio=%x fll_frac=%x fll_int=%x clk_ref_div=%x\n",
+		fll_param.mclk_src, fll_param.ratio, fll_param.fll_frac,
+		fll_param.fll_int, fll_param.clk_ref_div);
+
+	nau8825_fll_apply(nau8825, &fll_param);
+	mdelay(2);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_CLK_DIVIDER,
+			NAU8825_CLK_SRC_MASK, NAU8825_CLK_SRC_VCO);
+	return 0;
+}
+
 static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 	unsigned int freq)
 {
@@ -920,6 +1081,7 @@ static int nau8825_set_bias_level(struct snd_soc_codec *codec,
 static struct snd_soc_codec_driver nau8825_codec_driver = {
 	.probe = nau8825_codec_probe,
 	.set_sysclk = nau8825_set_sysclk,
+	.set_pll = nau8825_set_pll,
 	.set_bias_level = nau8825_set_bias_level,
 	.suspend_bias_off = true,
 
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index 8774923..dff8edb 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -101,13 +101,31 @@
 #define NAU8825_ENABLE_SAR_SFT	1
 
 /* CLK_DIVIDER (0x3) */
-#define NAU8825_CLK_SRC_SFT	15
-#define NAU8825_CLK_SRC_MASK	(1 << NAU8825_CLK_SRC_SFT)
-#define NAU8825_CLK_SRC_VCO	(1 << NAU8825_CLK_SRC_SFT)
-#define NAU8825_CLK_SRC_MCLK	(0 << NAU8825_CLK_SRC_SFT)
+#define NAU8825_CLK_SRC_SFT			15
+#define NAU8825_CLK_SRC_MASK			(1 << NAU8825_CLK_SRC_SFT)
+#define NAU8825_CLK_SRC_VCO			(1 << NAU8825_CLK_SRC_SFT)
+#define NAU8825_CLK_SRC_MCLK			(0 << NAU8825_CLK_SRC_SFT)
+#define NAU8825_CLK_MCLK_SRC_MASK		(0xf << 0)
+
+/* FLL1 (0x04) */
+#define NAU8825_FLL_RATIO_MASK			(0x7f << 0)
+
+/* FLL3 (0x06) */
+#define NAU8825_FLL_INTEGER_MASK		(0x3ff << 0)
+
+/* FLL4 (0x07) */
+#define NAU8825_FLL_REF_DIV_MASK		(0x3 << 10)
+
+/* FLL5 (0x08) */
+#define NAU8825_FLL_FILTER_SW_MASK		(0x1 << 14)
 
 /* FLL6 (0x9) */
-#define NAU8825_DCO_EN	(1 << 15)
+#define NAU8825_DCO_EN_MASK			(0x1 << 15)
+#define NAU8825_DCO_EN				(0x1 << 15)
+#define NAU8825_DCO_DIS				(0x0 << 15)
+#define NAU8825_SDM_EN_MASK			(0x1 << 14)
+#define NAU8825_SDM_EN				(0x1 << 14)
+#define NAU8825_SDM_DIS				(0x0 << 14)
 
 /* HSD_CTRL (0xc) */
 #define NAU8825_HSD_AUTO_MODE	(1 << 6)
-- 
2.6.0.rc2.230.g3dd15c0
