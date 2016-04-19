From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7219: Update PLL ranges and dividers to improve locking" to the asoc tree
Date: Tue, 19 Apr 2016 17:41:37 +0100
Message-ID: <E1asYiX-0001g8-Fg@debutante>
References: <c4a7a64be81c12da79bc47a9ca5fa798611a12fc.1461071847.git.Adam.Thomson.Opensource@diasemi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c4a7a64be81c12da79bc47a9ca5fa798611a12fc.1461071847.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7219: Update PLL ranges and dividers to improve locking

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

>From 63a450aa4d08ccf4f53e9fa59144e746e2288319 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 19 Apr 2016 15:19:02 +0100
Subject: [PATCH] ASoC: da7219: Update PLL ranges and dividers to improve
 locking

The expected MCLK frequency ranges and the associated dividers
are updated to improve PLL locking in a corner scenario, with low
MCLK frequency near an input divider change boundary.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7219.c | 28 ++++++++++++++--------------
 sound/soc/codecs/da7219.h | 20 ++++++++++----------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 81c0708b85c1..3b1d65badbda 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1079,21 +1079,21 @@ static int da7219_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 		dev_err(codec->dev, "PLL input clock %d below valid range\n",
 			da7219->mclk_rate);
 		return -EINVAL;
-	} else if (da7219->mclk_rate <= 5000000) {
-		indiv_bits = DA7219_PLL_INDIV_2_5_MHZ;
-		indiv = DA7219_PLL_INDIV_2_5_MHZ_VAL;
-	} else if (da7219->mclk_rate <= 10000000) {
-		indiv_bits = DA7219_PLL_INDIV_5_10_MHZ;
-		indiv = DA7219_PLL_INDIV_5_10_MHZ_VAL;
-	} else if (da7219->mclk_rate <= 20000000) {
-		indiv_bits = DA7219_PLL_INDIV_10_20_MHZ;
-		indiv = DA7219_PLL_INDIV_10_20_MHZ_VAL;
-	} else if (da7219->mclk_rate <= 40000000) {
-		indiv_bits = DA7219_PLL_INDIV_20_40_MHZ;
-		indiv = DA7219_PLL_INDIV_20_40_MHZ_VAL;
+	} else if (da7219->mclk_rate <= 4500000) {
+		indiv_bits = DA7219_PLL_INDIV_2_TO_4_5_MHZ;
+		indiv = DA7219_PLL_INDIV_2_TO_4_5_MHZ_VAL;
+	} else if (da7219->mclk_rate <= 9000000) {
+		indiv_bits = DA7219_PLL_INDIV_4_5_TO_9_MHZ;
+		indiv = DA7219_PLL_INDIV_4_5_TO_9_MHZ_VAL;
+	} else if (da7219->mclk_rate <= 18000000) {
+		indiv_bits = DA7219_PLL_INDIV_9_TO_18_MHZ;
+		indiv = DA7219_PLL_INDIV_9_TO_18_MHZ_VAL;
+	} else if (da7219->mclk_rate <= 36000000) {
+		indiv_bits = DA7219_PLL_INDIV_18_TO_36_MHZ;
+		indiv = DA7219_PLL_INDIV_18_TO_36_MHZ_VAL;
 	} else if (da7219->mclk_rate <= 54000000) {
-		indiv_bits = DA7219_PLL_INDIV_40_54_MHZ;
-		indiv = DA7219_PLL_INDIV_40_54_MHZ_VAL;
+		indiv_bits = DA7219_PLL_INDIV_36_TO_54_MHZ;
+		indiv = DA7219_PLL_INDIV_36_TO_54_MHZ_VAL;
 	} else {
 		dev_err(codec->dev, "PLL input clock %d above valid range\n",
 			da7219->mclk_rate);
diff --git a/sound/soc/codecs/da7219.h b/sound/soc/codecs/da7219.h
index 5a787e738084..ff2a2f02ce40 100644
--- a/sound/soc/codecs/da7219.h
+++ b/sound/soc/codecs/da7219.h
@@ -194,11 +194,11 @@
 /* DA7219_PLL_CTRL = 0x20 */
 #define DA7219_PLL_INDIV_SHIFT		2
 #define DA7219_PLL_INDIV_MASK		(0x7 << 2)
-#define DA7219_PLL_INDIV_2_5_MHZ	(0x0 << 2)
-#define DA7219_PLL_INDIV_5_10_MHZ	(0x1 << 2)
-#define DA7219_PLL_INDIV_10_20_MHZ	(0x2 << 2)
-#define DA7219_PLL_INDIV_20_40_MHZ	(0x3 << 2)
-#define DA7219_PLL_INDIV_40_54_MHZ	(0x4 << 2)
+#define DA7219_PLL_INDIV_2_TO_4_5_MHZ	(0x0 << 2)
+#define DA7219_PLL_INDIV_4_5_TO_9_MHZ	(0x1 << 2)
+#define DA7219_PLL_INDIV_9_TO_18_MHZ	(0x2 << 2)
+#define DA7219_PLL_INDIV_18_TO_36_MHZ	(0x3 << 2)
+#define DA7219_PLL_INDIV_36_TO_54_MHZ	(0x4 << 2)
 #define DA7219_PLL_MCLK_SQR_EN_SHIFT	5
 #define DA7219_PLL_MCLK_SQR_EN_MASK	(0x1 << 5)
 #define DA7219_PLL_MODE_SHIFT		6
@@ -761,11 +761,11 @@
 #define DA7219_PLL_FREQ_OUT_98304	98304000
 
 /* PLL Frequency Dividers */
-#define DA7219_PLL_INDIV_2_5_MHZ_VAL	1
-#define DA7219_PLL_INDIV_5_10_MHZ_VAL	2
-#define DA7219_PLL_INDIV_10_20_MHZ_VAL	4
-#define DA7219_PLL_INDIV_20_40_MHZ_VAL	8
-#define DA7219_PLL_INDIV_40_54_MHZ_VAL	16
+#define DA7219_PLL_INDIV_2_TO_4_5_MHZ_VAL	1
+#define DA7219_PLL_INDIV_4_5_TO_9_MHZ_VAL	2
+#define DA7219_PLL_INDIV_9_TO_18_MHZ_VAL	4
+#define DA7219_PLL_INDIV_18_TO_36_MHZ_VAL	8
+#define DA7219_PLL_INDIV_36_TO_54_MHZ_VAL	16
 
 /* SRM */
 #define DA7219_SRM_CHECK_RETRIES	8
-- 
2.8.0.rc3
