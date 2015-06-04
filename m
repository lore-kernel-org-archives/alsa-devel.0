From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 05/22] ASoC: tas2552: Correct CFG1 register bit
	definitions
Date: Thu, 4 Jun 2015 15:22:29 +0300
Message-ID: <1433420571-5421-6-git-send-email-peter.ujfalusi@ti.com>
References: <1433420571-5421-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 55F0B266480
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 14:23:09 +0200 (CEST)
In-Reply-To: <1433420571-5421-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, dmurphy@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Remove the _MASK postfix of the bit definitions, collect the CFG1 bit
definition in one place and correct the bit shifts at the same time.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tas2552.c | 14 +++++++-------
 sound/soc/codecs/tas2552.h | 17 ++++++++---------
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index 07a0ec03905d..681b868a9e8c 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -126,10 +126,10 @@ static void tas2552_sw_shutdown(struct tas2552_data *tas_data, int sw_shutdown)
 	if (sw_shutdown)
 		cfg1_reg = 0;
 	else
-		cfg1_reg = TAS2552_SWS_MASK;
+		cfg1_reg = TAS2552_SWS;
 
-	snd_soc_update_bits(tas_data->codec, TAS2552_CFG_1,
-						 TAS2552_SWS_MASK, cfg1_reg);
+	snd_soc_update_bits(tas_data->codec, TAS2552_CFG_1, TAS2552_SWS,
+			    cfg1_reg);
 }
 #endif
 
@@ -258,11 +258,11 @@ static int tas2552_mute(struct snd_soc_dai *dai, int mute)
 	struct snd_soc_codec *codec = dai->codec;
 
 	if (mute)
-		cfg1_reg = TAS2552_MUTE_MASK;
+		cfg1_reg = TAS2552_MUTE;
 	else
-		cfg1_reg = ~TAS2552_MUTE_MASK;
+		cfg1_reg = ~TAS2552_MUTE;
 
-	snd_soc_update_bits(codec, TAS2552_CFG_1, TAS2552_MUTE_MASK, cfg1_reg);
+	snd_soc_update_bits(codec, TAS2552_CFG_1, TAS2552_MUTE, cfg1_reg);
 
 	return 0;
 }
@@ -370,7 +370,7 @@ static int tas2552_codec_probe(struct snd_soc_codec *codec)
 		goto probe_fail;
 	}
 
-	snd_soc_write(codec, TAS2552_CFG_1, TAS2552_MUTE_MASK |
+	snd_soc_write(codec, TAS2552_CFG_1, TAS2552_MUTE |
 				TAS2552_PLL_SRC_BCLK);
 	snd_soc_write(codec, TAS2552_CFG_3, TAS2552_I2S_OUT_SEL |
 				TAS2552_DIN_SRC_SEL_AVG_L_R | TAS2552_88_96KHZ);
diff --git a/sound/soc/codecs/tas2552.h b/sound/soc/codecs/tas2552.h
index 938d90f1cab9..0725befb4c41 100644
--- a/sound/soc/codecs/tas2552.h
+++ b/sound/soc/codecs/tas2552.h
@@ -45,10 +45,14 @@
 #define TAS2552_MAX_REG			0x20
 
 /* CFG1 Register Masks */
-#define TAS2552_MUTE_MASK		(1 << 2)
-#define TAS2552_SWS_MASK		(1 << 1)
-#define TAS2552_WCLK_MASK		0x07
-#define TAS2552_CLASSD_EN_MASK	(1 << 7)
+#define TAS2552_DEV_RESET		(1 << 0)
+#define TAS2552_SWS			(1 << 1)
+#define TAS2552_MUTE			(1 << 2)
+#define TAS2552_PLL_SRC_MCLK		(0x0 << 4)
+#define TAS2552_PLL_SRC_BCLK		(0x1 << 4)
+#define TAS2552_PLL_SRC_IVCLKIN		(0x2 << 4)
+#define TAS2552_PLL_SRC_1_8_FIXED 	(0x3 << 4)
+#define TAS2552_PLL_SRC_MASK	 	TAS2552_PLL_SRC_1_8_FIXED
 
 /* CFG2 Register Masks */
 #define TAS2552_CLASSD_EN		(1 << 7)
@@ -68,11 +72,6 @@
 #define TAS2552_DAIFMT_RIGHT_J		(1 << 4)
 #define TAS2552_DAIFMT_LEFT_J		(0x11 << 3)
 
-#define TAS2552_PLL_SRC_MCLK	0x00
-#define TAS2552_PLL_SRC_BCLK	(1 << 3)
-#define TAS2552_PLL_SRC_IVCLKIN	(1 << 4)
-#define TAS2552_PLL_SRC_1_8_FIXED (0x11 << 3)
-
 #define TAS2552_DIN_SRC_SEL_MUTED	0x00
 #define TAS2552_DIN_SRC_SEL_LEFT	(1 << 4)
 #define TAS2552_DIN_SRC_SEL_RIGHT	(1 << 5)
-- 
2.4.2
