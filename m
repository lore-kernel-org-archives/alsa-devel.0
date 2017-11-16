From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8540: improve FLL performance" to
	the asoc tree
Date: Thu, 16 Nov 2017 19:28:36 +0000 (GMT)
Message-ID: <20171116192836.A589744005B@finisterre.ee.mobilebroadband>
References: <1510539377-26916-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B7BC0267774
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 20:28:37 +0100 (CET)
In-Reply-To: <1510539377-26916-1-git-send-email-KCHSU0@nuvoton.com>
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
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, lgirdwood@gmail.com, YHCHuang@nuvoton.com, broonie@kernel.org, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8540: improve FLL performance

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

>From fe83b1b7d7d0ff11210f84f25b8e1ba1afbac76f Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Mon, 13 Nov 2017 10:16:17 +0800
Subject: [PATCH] ASoC: nau8540: improve FLL performance

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8540.c | 21 ++++++++++++++-------
 sound/soc/codecs/nau8540.h |  5 +++++
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/nau8540.c b/sound/soc/codecs/nau8540.c
index 9565f9a181a9..b08fb7e243c3 100644
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
index dceb04b23c19..732b490edf81 100644
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
2.14.1
