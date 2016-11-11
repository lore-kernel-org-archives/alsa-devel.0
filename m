From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: FLL parameters finetune" to
	the asoc tree
Date: Fri, 11 Nov 2016 15:52:10 +0000
Message-ID: <E1c5E7e-0002g3-Ff@finisterre>
References: <1478837789-10901-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F17326748B
 for <alsa-devel@alsa-project.org>; Fri, 11 Nov 2016 16:52:29 +0100 (CET)
In-Reply-To: <1478837789-10901-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, benzh@chromium.org, WTLI@nuvoton.com, lgirdwood@gmail.com, YHCHuang@nuvoton.com, broonie@kernel.org, CTLIN0@nuvoton.com, yong.zhi@intel.com, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: FLL parameters finetune

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

>From aee02c75a5fb3b3583780bb7b298cb0d0d6647e2 Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Fri, 11 Nov 2016 12:16:29 +0800
Subject: [PATCH] ASoC: nau8825: FLL parameters finetune

The driver fine-tune some parameters to improve FLL performance.
Those items have description as follow.
(1)ICTRL_LATCH: FLL DSP speed capability control
When FLL running at high frequency with long decimal number, DSP needs
to operate at high speed. FLL DSP can optimize between performance and
power consumption by ICTRL_LATCH.(111 has highest power consumption.)
The default setting can be used to reduce power.
(2)CUTOFF500: loop filter cutoff frequency at 500Khz
It will give the best FLL performance but highest power consumption
to enable the cutoff frequency. FLL Loop Filter enable to reduce FLL
output noise, especially,(DCO frequency)/(FLL input reference frequency)
is not a integer.
(3)GAIN_ERR: FLL gain error correction threshold setting
The threshold is comparison between DCO and target frequency.
The value 1111 has the most sensitive threshold, that is, 1111 can have
the most accurate DCO to target frequency. However, the gain error setting
conditionally and inversely depends on FLL input reference clock rate.
Higher FLL reference input frequency can only set lower gain error, such
as 0000 for input reference from MCLK=12.288Mhz. On the other side, if FLL
reference input is from Frame Sync, 48KHz, higher error gain can apply
such as 1111.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8825.c | 48 ++++++++++++++++++++++++++++++++++++++--------
 sound/soc/codecs/nau8825.h |  5 +++++
 2 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 50cdb30297b4..3f9137f60c0d 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1994,8 +1994,10 @@ static void nau8825_fll_apply(struct nau8825 *nau8825,
 	regmap_update_bits(nau8825->regmap, NAU8825_REG_CLK_DIVIDER,
 		NAU8825_CLK_SRC_MASK | NAU8825_CLK_MCLK_SRC_MASK,
 		NAU8825_CLK_SRC_MCLK | fll_param->mclk_src);
+	/* Make DSP operate at high speed for better performance. */
 	regmap_update_bits(nau8825->regmap, NAU8825_REG_FLL1,
-			NAU8825_FLL_RATIO_MASK, fll_param->ratio);
+		NAU8825_FLL_RATIO_MASK | NAU8825_ICTRL_LATCH_MASK,
+		fll_param->ratio | (0x6 << NAU8825_ICTRL_LATCH_SFT));
 	/* FLL 16-bit fractional input */
 	regmap_write(nau8825->regmap, NAU8825_REG_FLL2, fll_param->fll_frac);
 	/* FLL 10-bit integer input */
@@ -2011,19 +2013,22 @@ static void nau8825_fll_apply(struct nau8825 *nau8825,
 	regmap_update_bits(nau8825->regmap,
 		NAU8825_REG_FLL6, NAU8825_DCO_EN, 0);
 	if (fll_param->fll_frac) {
+		/* set FLL loop filter enable and cutoff frequency at 500Khz */
 		regmap_update_bits(nau8825->regmap, NAU8825_REG_FLL5,
 			NAU8825_FLL_PDB_DAC_EN | NAU8825_FLL_LOOP_FTR_EN |
 			NAU8825_FLL_FTR_SW_MASK,
 			NAU8825_FLL_PDB_DAC_EN | NAU8825_FLL_LOOP_FTR_EN |
 			NAU8825_FLL_FTR_SW_FILTER);
 		regmap_update_bits(nau8825->regmap, NAU8825_REG_FLL6,
-			NAU8825_SDM_EN, NAU8825_SDM_EN);
+			NAU8825_SDM_EN | NAU8825_CUTOFF500,
+			NAU8825_SDM_EN | NAU8825_CUTOFF500);
 	} else {
+		/* disable FLL loop filter and cutoff frequency */
 		regmap_update_bits(nau8825->regmap, NAU8825_REG_FLL5,
 			NAU8825_FLL_PDB_DAC_EN | NAU8825_FLL_LOOP_FTR_EN |
 			NAU8825_FLL_FTR_SW_MASK, NAU8825_FLL_FTR_SW_ACCU);
-		regmap_update_bits(nau8825->regmap,
-			NAU8825_REG_FLL6, NAU8825_SDM_EN, 0);
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_FLL6,
+			NAU8825_SDM_EN | NAU8825_CUTOFF500, 0);
 	}
 }
 
@@ -2089,6 +2094,9 @@ static void nau8825_configure_mclk_as_sysclk(struct regmap *regmap)
 		NAU8825_CLK_SRC_MASK, NAU8825_CLK_SRC_MCLK);
 	regmap_update_bits(regmap, NAU8825_REG_FLL6,
 		NAU8825_DCO_EN, 0);
+	/* Make DSP operate as default setting for power saving. */
+	regmap_update_bits(regmap, NAU8825_REG_FLL1,
+		NAU8825_ICTRL_LATCH_MASK, 0);
 }
 
 static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
@@ -2132,10 +2140,13 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 				NAU8825_DCO_EN, NAU8825_DCO_EN);
 			regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
 				NAU8825_CLK_SRC_MASK, NAU8825_CLK_SRC_VCO);
-			/* Decrease the VCO frequency for power saving */
+			/* Decrease the VCO frequency and make DSP operate
+			 * as default setting for power saving.
+			 */
 			regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
 				NAU8825_CLK_MCLK_SRC_MASK, 0xf);
 			regmap_update_bits(regmap, NAU8825_REG_FLL1,
+				NAU8825_ICTRL_LATCH_MASK |
 				NAU8825_FLL_RATIO_MASK, 0x10);
 			regmap_update_bits(regmap, NAU8825_REG_FLL6,
 				NAU8825_SDM_EN, NAU8825_SDM_EN);
@@ -2159,8 +2170,13 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 		 * preparation halted until cross talk process finish.
 		 */
 		nau8825_sema_acquire(nau8825, 2 * HZ);
+		/* Higher FLL reference input frequency can only set lower
+		 * gain error, such as 0000 for input reference from MCLK
+		 * 12.288Mhz.
+		 */
 		regmap_update_bits(regmap, NAU8825_REG_FLL3,
-			NAU8825_FLL_CLK_SRC_MASK, NAU8825_FLL_CLK_SRC_MCLK);
+			NAU8825_FLL_CLK_SRC_MASK | NAU8825_GAIN_ERR_MASK,
+			NAU8825_FLL_CLK_SRC_MCLK | 0);
 		/* Release the semaphone. */
 		nau8825_sema_release(nau8825);
 
@@ -2176,8 +2192,16 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 		 * preparation halted until cross talk process finish.
 		 */
 		nau8825_sema_acquire(nau8825, 2 * HZ);
+		/* If FLL reference input is from low frequency source,
+		 * higher error gain can apply such as 0xf which has
+		 * the most sensitive gain error correction threshold,
+		 * Therefore, FLL has the most accurate DCO to
+		 * target frequency.
+		 */
 		regmap_update_bits(regmap, NAU8825_REG_FLL3,
-			NAU8825_FLL_CLK_SRC_MASK, NAU8825_FLL_CLK_SRC_BLK);
+			NAU8825_FLL_CLK_SRC_MASK | NAU8825_GAIN_ERR_MASK,
+			NAU8825_FLL_CLK_SRC_BLK |
+			(0xf << NAU8825_GAIN_ERR_SFT));
 		/* Release the semaphone. */
 		nau8825_sema_release(nau8825);
 
@@ -2194,8 +2218,16 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
 		 * preparation halted until cross talk process finish.
 		 */
 		nau8825_sema_acquire(nau8825, 2 * HZ);
+		/* If FLL reference input is from low frequency source,
+		 * higher error gain can apply such as 0xf which has
+		 * the most sensitive gain error correction threshold,
+		 * Therefore, FLL has the most accurate DCO to
+		 * target frequency.
+		 */
 		regmap_update_bits(regmap, NAU8825_REG_FLL3,
-			NAU8825_FLL_CLK_SRC_MASK, NAU8825_FLL_CLK_SRC_FS);
+			NAU8825_FLL_CLK_SRC_MASK | NAU8825_GAIN_ERR_MASK,
+			NAU8825_FLL_CLK_SRC_FS |
+			(0xf << NAU8825_GAIN_ERR_SFT));
 		/* Release the semaphone. */
 		nau8825_sema_release(nau8825);
 
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index 167a2aaad256..0672a25617b9 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -122,9 +122,13 @@
 #define NAU8825_CLK_MCLK_SRC_MASK		(0xf << 0)
 
 /* FLL1 (0x04) */
+#define NAU8825_ICTRL_LATCH_SFT	10
+#define NAU8825_ICTRL_LATCH_MASK	(0x7 << NAU8825_ICTRL_LATCH_SFT)
 #define NAU8825_FLL_RATIO_MASK			(0x7f << 0)
 
 /* FLL3 (0x06) */
+#define NAU8825_GAIN_ERR_SFT			12
+#define NAU8825_GAIN_ERR_MASK			(0xf << NAU8825_GAIN_ERR_SFT)
 #define NAU8825_FLL_INTEGER_MASK		(0x3ff << 0)
 #define NAU8825_FLL_CLK_SRC_SFT		10
 #define NAU8825_FLL_CLK_SRC_MASK		(0x3 << NAU8825_FLL_CLK_SRC_SFT)
@@ -148,6 +152,7 @@
 /* FLL6 (0x9) */
 #define NAU8825_DCO_EN				(0x1 << 15)
 #define NAU8825_SDM_EN				(0x1 << 14)
+#define NAU8825_CUTOFF500			(0x1 << 13)
 
 /* HSD_CTRL (0xc) */
 #define NAU8825_HSD_AUTO_MODE	(1 << 6)
-- 
2.10.2
