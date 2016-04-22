From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH] ASoC: da7218: Update PLL ranges and dividers
 to improve locking
Date: Fri, 22 Apr 2016 14:16:26 +0100
Message-ID: <20160422131626.CB01C3FA9D@swsrvapps-01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com
 [193.109.254.110])
 by alsa0.perex.cz (Postfix) with ESMTP id 80511264F3A
 for <alsa-devel@alsa-project.org>; Fri, 22 Apr 2016 15:16:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

The expected MCLK frequency ranges and the associated dividers
are updated to improve PLL locking in a corner scenario, with low
MCLK frequency near an input divider change boundary.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---

This patch is based on v4.6-rc1 kernel version

 sound/soc/codecs/da7218.c | 32 ++++++++++++++++----------------
 sound/soc/codecs/da7218.h | 21 ++++++++++++---------
 2 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
index 93575f2..99ce23e 100644
--- a/sound/soc/codecs/da7218.c
+++ b/sound/soc/codecs/da7218.c
@@ -1868,27 +1868,27 @@ static int da7218_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 
 	/* Verify 32KHz, 2MHz - 54MHz MCLK provided, and set input divider */
 	if (da7218->mclk_rate == 32768) {
-		indiv_bits = DA7218_PLL_INDIV_2_5_MHZ;
-		indiv = DA7218_PLL_INDIV_2_10_MHZ_VAL;
+		indiv_bits = DA7218_PLL_INDIV_9_TO_18_MHZ;
+		indiv = DA7218_PLL_INDIV_9_TO_18_MHZ_VAL;
 	} else if (da7218->mclk_rate < 2000000) {
 		dev_err(codec->dev, "PLL input clock %d below valid range\n",
 			da7218->mclk_rate);
 		return -EINVAL;
-	} else if (da7218->mclk_rate <= 5000000) {
-		indiv_bits = DA7218_PLL_INDIV_2_5_MHZ;
-		indiv = DA7218_PLL_INDIV_2_10_MHZ_VAL;
-	} else if (da7218->mclk_rate <= 10000000) {
-		indiv_bits = DA7218_PLL_INDIV_5_10_MHZ;
-		indiv = DA7218_PLL_INDIV_2_10_MHZ_VAL;
-	} else if (da7218->mclk_rate <= 20000000) {
-		indiv_bits = DA7218_PLL_INDIV_10_20_MHZ;
-		indiv = DA7218_PLL_INDIV_10_20_MHZ_VAL;
-	} else if (da7218->mclk_rate <= 40000000) {
-		indiv_bits = DA7218_PLL_INDIV_20_40_MHZ;
-		indiv = DA7218_PLL_INDIV_20_40_MHZ_VAL;
+	} else if (da7218->mclk_rate <= 4500000) {
+		indiv_bits = DA7218_PLL_INDIV_2_TO_4_5_MHZ;
+		indiv = DA7218_PLL_INDIV_2_TO_4_5_MHZ_VAL;
+	} else if (da7218->mclk_rate <= 9000000) {
+		indiv_bits = DA7218_PLL_INDIV_4_5_TO_9_MHZ;
+		indiv = DA7218_PLL_INDIV_4_5_TO_9_MHZ_VAL;
+	} else if (da7218->mclk_rate <= 18000000) {
+		indiv_bits = DA7218_PLL_INDIV_9_TO_18_MHZ;
+		indiv = DA7218_PLL_INDIV_9_TO_18_MHZ_VAL;
+	} else if (da7218->mclk_rate <= 36000000) {
+		indiv_bits = DA7218_PLL_INDIV_18_TO_36_MHZ;
+		indiv = DA7218_PLL_INDIV_18_TO_36_MHZ_VAL;
 	} else if (da7218->mclk_rate <= 54000000) {
-		indiv_bits = DA7218_PLL_INDIV_40_54_MHZ;
-		indiv = DA7218_PLL_INDIV_40_54_MHZ_VAL;
+		indiv_bits = DA7218_PLL_INDIV_36_TO_54_MHZ;
+		indiv = DA7218_PLL_INDIV_36_TO_54_MHZ_VAL;
 	} else {
 		dev_err(codec->dev, "PLL input clock %d above valid range\n",
 			da7218->mclk_rate);
diff --git a/sound/soc/codecs/da7218.h b/sound/soc/codecs/da7218.h
index c2c5904..477cd37 100644
--- a/sound/soc/codecs/da7218.h
+++ b/sound/soc/codecs/da7218.h
@@ -876,15 +876,11 @@
 /* DA7218_PLL_CTRL = 0x91 */
 #define DA7218_PLL_INDIV_SHIFT		0
 #define DA7218_PLL_INDIV_MASK		(0x7 << 0)
-#define DA7218_PLL_INDIV_2_5_MHZ	(0x0 << 0)
-#define DA7218_PLL_INDIV_5_10_MHZ	(0x1 << 0)
-#define DA7218_PLL_INDIV_10_20_MHZ	(0x2 << 0)
-#define DA7218_PLL_INDIV_20_40_MHZ	(0x3 << 0)
-#define DA7218_PLL_INDIV_40_54_MHZ	(0x4 << 0)
-#define DA7218_PLL_INDIV_2_10_MHZ_VAL	2
-#define DA7218_PLL_INDIV_10_20_MHZ_VAL	4
-#define DA7218_PLL_INDIV_20_40_MHZ_VAL	8
-#define DA7218_PLL_INDIV_40_54_MHZ_VAL	16
+#define DA7218_PLL_INDIV_2_TO_4_5_MHZ	(0x0 << 0)
+#define DA7218_PLL_INDIV_4_5_TO_9_MHZ	(0x1 << 0)
+#define DA7218_PLL_INDIV_9_TO_18_MHZ	(0x2 << 0)
+#define DA7218_PLL_INDIV_18_TO_36_MHZ	(0x3 << 0)
+#define DA7218_PLL_INDIV_36_TO_54_MHZ	(0x4 << 0)
 #define DA7218_PLL_MCLK_SQR_EN_SHIFT	4
 #define DA7218_PLL_MCLK_SQR_EN_MASK	(0x1 << 4)
 #define DA7218_PLL_MODE_SHIFT		6
@@ -1336,6 +1332,13 @@
 #define DA7218_PLL_FREQ_OUT_90316	90316800
 #define DA7218_PLL_FREQ_OUT_98304	98304000
 
+/* PLL Frequency Dividers */
+#define DA7218_PLL_INDIV_2_TO_4_5_MHZ_VAL	1
+#define DA7218_PLL_INDIV_4_5_TO_9_MHZ_VAL	2
+#define DA7218_PLL_INDIV_9_TO_18_MHZ_VAL	4
+#define DA7218_PLL_INDIV_18_TO_36_MHZ_VAL	8
+#define DA7218_PLL_INDIV_36_TO_54_MHZ_VAL	16
+
 /* ALC Calibration */
 #define DA7218_ALC_CALIB_DELAY_MIN	2500
 #define DA7218_ALC_CALIB_DELAY_MAX	5000
-- 
1.9.3
