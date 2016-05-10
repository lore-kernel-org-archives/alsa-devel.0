From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7213: Update PLL ranges to improve locking at frequency boundary" to the asoc tree
Date: Tue, 10 May 2016 19:48:56 +0100
Message-ID: <E1b0CiG-0006ji-1x@debutante>
References: <99d22ab107c104cba002706c0aa88ce5c5e08ad5.1462892732.git.Adam.Thomson.Opensource@diasemi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <99d22ab107c104cba002706c0aa88ce5c5e08ad5.1462892732.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7213: Update PLL ranges to improve locking at frequency boundary

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

>From 1e62c52ddc2d23a02ac2308cc1bb6ff18f0cf3cd Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 10 May 2016 16:11:07 +0100
Subject: [PATCH] ASoC: da7213: Update PLL ranges to improve locking at
 frequency boundary

This update changes the dividers used for ranges of input MCLK
frequencies, to improve PLL locking for a corner case when at edge
of MCLK frequency input divider range.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7213.c | 26 +++++++++++++-------------
 sound/soc/codecs/da7213.h | 28 ++++++++++++++--------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 657b7eba9954..a233fe7f12eb 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1344,26 +1344,26 @@ static int da7213_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 	/* Workout input divider based on MCLK rate */
 	if ((da7213->mclk_rate == 32768) && (source == DA7213_SYSCLK_PLL)) {
 		/* 32KHz PLL Mode */
-		indiv_bits = DA7213_PLL_INDIV_10_20_MHZ;
-		indiv = DA7213_PLL_INDIV_10_20_MHZ_VAL;
+		indiv_bits = DA7213_PLL_INDIV_9_TO_18_MHZ;
+		indiv = DA7213_PLL_INDIV_9_TO_18_MHZ_VAL;
 		freq_ref = 3750000;
 		pll_ctrl |= DA7213_PLL_32K_MODE;
 	} else {
 		/* 5 - 54MHz MCLK */
 		if (da7213->mclk_rate < 5000000) {
 			goto pll_err;
-		} else if (da7213->mclk_rate <= 10000000) {
-			indiv_bits = DA7213_PLL_INDIV_5_10_MHZ;
-			indiv = DA7213_PLL_INDIV_5_10_MHZ_VAL;
-		} else if (da7213->mclk_rate <= 20000000) {
-			indiv_bits = DA7213_PLL_INDIV_10_20_MHZ;
-			indiv = DA7213_PLL_INDIV_10_20_MHZ_VAL;
-		} else if (da7213->mclk_rate <= 40000000) {
-			indiv_bits = DA7213_PLL_INDIV_20_40_MHZ;
-			indiv = DA7213_PLL_INDIV_20_40_MHZ_VAL;
+		} else if (da7213->mclk_rate <= 9000000) {
+			indiv_bits = DA7213_PLL_INDIV_5_TO_9_MHZ;
+			indiv = DA7213_PLL_INDIV_5_TO_9_MHZ_VAL;
+		} else if (da7213->mclk_rate <= 18000000) {
+			indiv_bits = DA7213_PLL_INDIV_9_TO_18_MHZ;
+			indiv = DA7213_PLL_INDIV_9_TO_18_MHZ_VAL;
+		} else if (da7213->mclk_rate <= 36000000) {
+			indiv_bits = DA7213_PLL_INDIV_18_TO_36_MHZ;
+			indiv = DA7213_PLL_INDIV_18_TO_36_MHZ_VAL;
 		} else if (da7213->mclk_rate <= 54000000) {
-			indiv_bits = DA7213_PLL_INDIV_40_54_MHZ;
-			indiv = DA7213_PLL_INDIV_40_54_MHZ_VAL;
+			indiv_bits = DA7213_PLL_INDIV_36_TO_54_MHZ;
+			indiv = DA7213_PLL_INDIV_36_TO_54_MHZ_VAL;
 		} else {
 			goto pll_err;
 		}
diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
index 26b87e3c3088..fbb7a356a501 100644
--- a/sound/soc/codecs/da7213.h
+++ b/sound/soc/codecs/da7213.h
@@ -163,10 +163,10 @@
 #define DA7213_VMID_EN						(0x1 << 7)
 
 /* DA7213_PLL_CTRL = 0x27 */
-#define DA7213_PLL_INDIV_5_10_MHZ				(0x0 << 2)
-#define DA7213_PLL_INDIV_10_20_MHZ				(0x1 << 2)
-#define DA7213_PLL_INDIV_20_40_MHZ				(0x2 << 2)
-#define DA7213_PLL_INDIV_40_54_MHZ				(0x3 << 2)
+#define DA7213_PLL_INDIV_5_TO_9_MHZ				(0x0 << 2)
+#define DA7213_PLL_INDIV_9_TO_18_MHZ				(0x1 << 2)
+#define DA7213_PLL_INDIV_18_TO_36_MHZ				(0x2 << 2)
+#define DA7213_PLL_INDIV_36_TO_54_MHZ				(0x3 << 2)
 #define DA7213_PLL_INDIV_MASK					(0x3 << 2)
 #define DA7213_PLL_MCLK_SQR_EN					(0x1 << 4)
 #define DA7213_PLL_32K_MODE					(0x1 << 5)
@@ -499,16 +499,16 @@
 #define DA7213_ALC_AVG_ITERATIONS	5
 
 /* PLL related */
-#define DA7213_SYSCLK_MCLK		0
-#define DA7213_SYSCLK_PLL		1
-#define DA7213_PLL_FREQ_OUT_90316800	90316800
-#define DA7213_PLL_FREQ_OUT_98304000	98304000
-#define DA7213_PLL_FREQ_OUT_94310400	94310400
-#define DA7213_PLL_INDIV_5_10_MHZ_VAL	2
-#define DA7213_PLL_INDIV_10_20_MHZ_VAL	4
-#define DA7213_PLL_INDIV_20_40_MHZ_VAL	8
-#define DA7213_PLL_INDIV_40_54_MHZ_VAL	16
-#define DA7213_SRM_CHECK_RETRIES	8
+#define DA7213_SYSCLK_MCLK			0
+#define DA7213_SYSCLK_PLL			1
+#define DA7213_PLL_FREQ_OUT_90316800		90316800
+#define DA7213_PLL_FREQ_OUT_98304000		98304000
+#define DA7213_PLL_FREQ_OUT_94310400		94310400
+#define DA7213_PLL_INDIV_5_TO_9_MHZ_VAL		2
+#define DA7213_PLL_INDIV_9_TO_18_MHZ_VAL	4
+#define DA7213_PLL_INDIV_18_TO_36_MHZ_VAL	8
+#define DA7213_PLL_INDIV_36_TO_54_MHZ_VAL	16
+#define DA7213_SRM_CHECK_RETRIES		8
 
 enum da7213_clk_src {
 	DA7213_CLKSRC_MCLK = 0,
-- 
2.8.1
