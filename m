From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 4/5] ASoC: da7213: Update PLL ranges to improve locking at
 frequency boundary
Date: Tue, 10 May 2016 16:11:07 +0100
Message-ID: <99d22ab107c104cba002706c0aa88ce5c5e08ad5.1462892732.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1462892732.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1462892732.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

This update changes the dividers used for ranges of input MCLK
frequencies, to improve PLL locking for a corner case when at edge
of MCLK frequency input divider range.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7213.c | 26 +++++++++++++-------------
 sound/soc/codecs/da7213.h | 28 ++++++++++++++--------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 657b7eb..a233fe7 100644
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
index 26b87e3..fbb7a35 100644
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
1.9.3
