From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7218: Update PLL ranges and dividers
	to improve locking" to the asoc tree
Date: Fri, 22 Apr 2016 16:27:25 +0100
Message-ID: <E1atczN-0007fP-CP@debutante>
References: <20160422131626.CB01C3FA9D@swsrvapps-01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B8CC2617A4
 for <alsa-devel@alsa-project.org>; Fri, 22 Apr 2016 17:27:43 +0200 (CEST)
In-Reply-To: <20160422131626.CB01C3FA9D@swsrvapps-01.diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: alsa-devel@alsa-project.org, Support Opensource <support.opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7218: Update PLL ranges and dividers to improve locking

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

>From ae48a35c408732413880d0ac0d6467baa5b3d68a Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Fri, 22 Apr 2016 14:16:26 +0100
Subject: [PATCH] ASoC: da7218: Update PLL ranges and dividers to improve
 locking

The expected MCLK frequency ranges and the associated dividers
are updated to improve PLL locking in a corner scenario, with low
MCLK frequency near an input divider change boundary.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7218.c | 32 ++++++++++++++++----------------
 sound/soc/codecs/da7218.h | 21 ++++++++++++---------
 2 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
index 93575f251866..99ce23e113bf 100644
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
index c2c59049a2ad..477cd37723cf 100644
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
2.8.0.rc3
