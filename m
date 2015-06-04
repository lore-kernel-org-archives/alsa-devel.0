From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 21/23] ASoC: tas2552: Correct Output Data
	register usage
Date: Thu, 4 Jun 2015 15:22:48 +0300
Message-ID: <1433420571-5421-25-git-send-email-peter.ujfalusi@ti.com>
References: <1433420571-5421-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id CD412266530
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 14:23:50 +0200 (CEST)
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

Do not write to DOUT Tristate register at probe time, specially not write
data which is defined to be used in Output Data Register.
Fix the defines for the Output Data Register and correct the register write
at probe time.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tas2552.c |  5 +++--
 sound/soc/codecs/tas2552.h | 19 +++++++++++++++----
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index cf21413a7c1e..c7a08ab74f99 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -601,8 +601,9 @@ static int tas2552_codec_probe(struct snd_soc_codec *codec)
 	snd_soc_update_bits(codec, TAS2552_CFG_1, TAS2552_MUTE, TAS2552_MUTE);
 	snd_soc_write(codec, TAS2552_CFG_3, TAS2552_I2S_OUT_SEL |
 					    TAS2552_DIN_SRC_SEL_AVG_L_R);
-	snd_soc_write(codec, TAS2552_DOUT, TAS2552_PDM_DATA_I);
-	snd_soc_write(codec, TAS2552_OUTPUT_DATA, TAS2552_PDM_DATA_V_I | 0x8);
+	snd_soc_write(codec, TAS2552_OUTPUT_DATA,
+		      TAS2552_PDM_DATA_SEL_V_I |
+		      TAS2552_R_DATA_OUT(TAS2552_DATA_OUT_V_DATA));
 	snd_soc_write(codec, TAS2552_BOOST_PT_CTRL, TAS2552_APT_DELAY_200 |
 				TAS2552_APT_THRESH_2_1_7);
 
diff --git a/sound/soc/codecs/tas2552.h b/sound/soc/codecs/tas2552.h
index f04d9e6db0aa..14d40ef645c4 100644
--- a/sound/soc/codecs/tas2552.h
+++ b/sound/soc/codecs/tas2552.h
@@ -103,10 +103,21 @@
 #define TAS2552_WCLKDIR			(1 << 7)
 
 /* OUTPUT_DATA register */
-#define TAS2552_PDM_DATA_I		0x00
-#define TAS2552_PDM_DATA_V		(1 << 6)
-#define TAS2552_PDM_DATA_I_V	(1 << 7)
-#define TAS2552_PDM_DATA_V_I	(0x11 << 6)
+#define TAS2552_DATA_OUT_I_DATA		(0x0)
+#define TAS2552_DATA_OUT_V_DATA		(0x1)
+#define TAS2552_DATA_OUT_VBAT_DATA	(0x2)
+#define TAS2552_DATA_OUT_VBOOST_DATA	(0x3)
+#define TAS2552_DATA_OUT_PGA_GAIN	(0x4)
+#define TAS2552_DATA_OUT_IV_DATA	(0x5)
+#define TAS2552_DATA_OUT_VBAT_VBOOST_GAIN	(0x6)
+#define TAS2552_DATA_OUT_DISABLED	(0x7)
+#define TAS2552_L_DATA_OUT(x)		((x) << 0)
+#define TAS2552_R_DATA_OUT(x)		((x) << 3)
+#define TAS2552_PDM_DATA_SEL_I		(0x0 << 6)
+#define TAS2552_PDM_DATA_SEL_V		(0x1 << 6)
+#define TAS2552_PDM_DATA_SEL_I_V	(0x2 << 6)
+#define TAS2552_PDM_DATA_SEL_V_I	(0x3 << 6)
+#define TAS2552_PDM_DATA_SEL_MASK	TAS2552_PDM_DATA_SEL_V_I
 
 /* PDM CFG Register */
 #define TAS2552_PDM_CLK_SEL_PLL		(0x0 << 0)
-- 
2.4.2
