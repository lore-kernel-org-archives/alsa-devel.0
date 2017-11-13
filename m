From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8540: improve FLL performance
Date: Mon, 13 Nov 2017 10:16:17 +0800
Message-ID: <1510539377-26916-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CC342672AC
 for <alsa-devel@alsa-project.org>; Mon, 13 Nov 2017 03:16:22 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, YHCHuang@nuvoton.com, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

Add these parameters to improve the FLL performance.
The comments show as follows:

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
---
 sound/soc/codecs/nau8540.c | 21 ++++++++++++++-------
 sound/soc/codecs/nau8540.h |  5 +++++
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/nau8540.c b/sound/soc/codecs/nau8540.c
index 9565f9a..b08fb7e 100644
--- a/sound/soc/codecs/nau8540.c
+++ b/sound/soc/codecs/nau8540.c
@@ -615,7 +615,8 @@ static void nau8540_fll_apply(struct regmap *regmap,
 		NAU8540_CLK_SRC_MASK | NAU8540_CLK_MCLK_SRC_MASK,
 		NAU8540_CLK_SRC_MCLK | fll_param->mclk_src);
 	regmap_update_bits(regmap, NAU8540_REG_FLL1,
-		NAU8540_FLL_RATIO_MASK, fll_param->ratio);
+		NAU8540_FLL_RATIO_MASK | NAU8540_ICTRL_LATCH_MASK,
+		fll_param->ratio | (0x6 << NAU8540_ICTRL_LATCH_SFT));
 	/* FLL 16-bit fractional input */
 	regmap_write(regmap, NAU8540_REG_FLL2, fll_param->fll_frac);
 	/* FLL 10-bit integer input */
@@ -636,13 +637,14 @@ static void nau8540_fll_apply(struct regmap *regmap,
 			NAU8540_FLL_PDB_DAC_EN | NAU8540_FLL_LOOP_FTR_EN |
 			NAU8540_FLL_FTR_SW_FILTER);
 		regmap_update_bits(regmap, NAU8540_REG_FLL6,
-			NAU8540_SDM_EN, NAU8540_SDM_EN);
+			NAU8540_SDM_EN | NAU8540_CUTOFF500,
+			NAU8540_SDM_EN | NAU8540_CUTOFF500);
 	} else {
 		regmap_update_bits(regmap, NAU8540_REG_FLL5,
 			NAU8540_FLL_PDB_DAC_EN | NAU8540_FLL_LOOP_FTR_EN |
 			NAU8540_FLL_FTR_SW_MASK, NAU8540_FLL_FTR_SW_ACCU);
-		regmap_update_bits(regmap,
-			NAU8540_REG_FLL6, NAU8540_SDM_EN, 0);
+		regmap_update_bits(regmap, NAU8540_REG_FLL6,
+			NAU8540_SDM_EN | NAU8540_CUTOFF500, 0);
 	}
 }
 
@@ -657,17 +659,22 @@ static int nau8540_set_pll(struct snd_soc_codec *codec, int pll_id, int source,
 	switch (pll_id) {
 	case NAU8540_CLK_FLL_MCLK:
 		regmap_update_bits(nau8540->regmap, NAU8540_REG_FLL3,
-			NAU8540_FLL_CLK_SRC_MASK, NAU8540_FLL_CLK_SRC_MCLK);
+			NAU8540_FLL_CLK_SRC_MASK | NAU8540_GAIN_ERR_MASK,
+			NAU8540_FLL_CLK_SRC_MCLK | 0);
 		break;
 
 	case NAU8540_CLK_FLL_BLK:
 		regmap_update_bits(nau8540->regmap, NAU8540_REG_FLL3,
-			NAU8540_FLL_CLK_SRC_MASK, NAU8540_FLL_CLK_SRC_BLK);
+			NAU8540_FLL_CLK_SRC_MASK | NAU8540_GAIN_ERR_MASK,
+			NAU8540_FLL_CLK_SRC_BLK |
+			(0xf << NAU8540_GAIN_ERR_SFT));
 		break;
 
 	case NAU8540_CLK_FLL_FS:
 		regmap_update_bits(nau8540->regmap, NAU8540_REG_FLL3,
-			NAU8540_FLL_CLK_SRC_MASK, NAU8540_FLL_CLK_SRC_FS);
+			NAU8540_FLL_CLK_SRC_MASK | NAU8540_GAIN_ERR_MASK,
+			NAU8540_FLL_CLK_SRC_FS |
+			(0xf << NAU8540_GAIN_ERR_SFT));
 		break;
 
 	default:
diff --git a/sound/soc/codecs/nau8540.h b/sound/soc/codecs/nau8540.h
index dceb04b..732b490 100644
--- a/sound/soc/codecs/nau8540.h
+++ b/sound/soc/codecs/nau8540.h
@@ -100,9 +100,13 @@
 #define NAU8540_CLK_MCLK_SRC_MASK	0xf
 
 /* FLL1 (0x04) */
+#define NAU8540_ICTRL_LATCH_SFT	10
+#define NAU8540_ICTRL_LATCH_MASK	(0x7 << NAU8540_ICTRL_LATCH_SFT)
 #define NAU8540_FLL_RATIO_MASK	0x7f
 
 /* FLL3 (0x06) */
+#define NAU8540_GAIN_ERR_SFT		12
+#define NAU8540_GAIN_ERR_MASK		(0xf << NAU8540_GAIN_ERR_SFT)
 #define NAU8540_FLL_CLK_SRC_SFT	10
 #define NAU8540_FLL_CLK_SRC_MASK	(0x3 << NAU8540_FLL_CLK_SRC_SFT)
 #define NAU8540_FLL_CLK_SRC_MCLK	(0 << NAU8540_FLL_CLK_SRC_SFT)
@@ -127,6 +131,7 @@
 /* FLL6 (0x9) */
 #define NAU8540_DCO_EN			(0x1 << 15)
 #define NAU8540_SDM_EN			(0x1 << 14)
+#define NAU8540_CUTOFF500		(0x1 << 13)
 
 /* PCM_CTRL0 (0x10) */
 #define NAU8540_I2S_BP_SFT		7
-- 
2.6.4
