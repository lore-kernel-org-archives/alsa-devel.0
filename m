From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 1/2] ASoC: da7219: Update PLL ranges and
 dividers to improve locking
Date: Tue, 19 Apr 2016 15:19:02 +0100
Message-ID: <c4a7a64be81c12da79bc47a9ca5fa798611a12fc.1461071847.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1461071847.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com
 [193.109.254.107])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C82726522E
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 16:19:04 +0200 (CEST)
In-Reply-To: <cover.1461071847.git.Adam.Thomson.Opensource@diasemi.com>
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
 sound/soc/codecs/da7219.c | 28 ++++++++++++++--------------
 sound/soc/codecs/da7219.h | 20 ++++++++++----------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 81c0708..3b1d65b 100644
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
index 5a787e7..ff2a2f0 100644
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
1.9.3
