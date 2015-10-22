From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: Add FLL configuration" to the
	asoc tree
Date: Fri, 23 Oct 2015 08:09:05 +0900
Message-ID: <E1ZpOyn-0008L7-0q@finisterre>
References: <1444452616-32903-1-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BEC4C266ABE
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:09:15 +0200 (CEST)
In-Reply-To: <1444452616-32903-1-git-send-email-benzh@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ben Zhang <benzh@chromium.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: Add FLL configuration

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

>From c86ba612bdba4d267ce5aad30ff10b4d994e2b33 Mon Sep 17 00:00:00 2001
From: Ben Zhang <benzh@chromium.org>
Date: Mon, 19 Oct 2015 16:49:05 -0700
Subject: [PATCH] ASoC: nau8825: Add FLL configuration

snd_soc_codec_driver.set_pll is implemented to configure the FLL.
The codec internal SYSCLK can be from either the MCLK pin directly,
or the FLL. This is configured by snd_soc_codec_driver.set_pll.

Signed-off-by: Ben Zhang <benzh@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8825.c | 163 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/nau8825.h |  28 ++++++--
 2 files changed, 186 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 5c1badf..bd58b96 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/acpi.h>
+#include <linux/math64.h>
 
 #include <sound/initval.h>
 #include <sound/tlv.h>
@@ -29,6 +30,58 @@
 
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
@@ -808,6 +861,115 @@ static int nau8825_codec_probe(struct snd_soc_codec *codec)
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
+	u64 fvco;
+	unsigned int fref, i;
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
+	fvco = div_u64(fvco << 16, fref * fll_param->ratio);
+	fll_param->fll_int = (fvco >> 16) & 0x3FF;
+	fll_param->fll_frac = fvco & 0xFFFF;
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
@@ -920,6 +1082,7 @@ static int nau8825_set_bias_level(struct snd_soc_codec *codec,
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
2.6.1
