From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 1/2] ASoC: tlv320aic32x4: always enable dividers
Date: Wed, 18 Jan 2012 11:48:58 +0100
Message-ID: <1326883739-8148-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 8374610388D
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 11:49:11 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Javier Martin <javier.martin@vista-silicon.com>, Wolfram Sang <w.sang@pengutronix.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Dividers (such as MDAC) are always needed, independent of the codec
being I2S master or slave. Needed on a custom board where the codec has
to be slave.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 sound/soc/codecs/tlv320aic32x4.c |  102 +++++++++++++++++---------------------
 1 files changed, 46 insertions(+), 56 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index eb401ef..3806cb6 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -60,7 +60,6 @@ struct aic32x4_rate_divs {
 
 struct aic32x4_priv {
 	u32 sysclk;
-	s32 master;
 	u8 page_no;
 	void *control_data;
 	u32 power_cfg;
@@ -369,7 +368,6 @@ static int aic32x4_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 static int aic32x4_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
 	u8 iface_reg_1;
 	u8 iface_reg_2;
 	u8 iface_reg_3;
@@ -384,11 +382,9 @@ static int aic32x4_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	/* set master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
-		aic32x4->master = 1;
 		iface_reg_1 |= AIC32X4_BCLKMASTER | AIC32X4_WCLKMASTER;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
-		aic32x4->master = 0;
 		break;
 	default:
 		printk(KERN_ERR "aic32x4: invalid DAI master/slave interface\n");
@@ -526,64 +522,58 @@ static int aic32x4_mute(struct snd_soc_dai *dai, int mute)
 static int aic32x4_set_bias_level(struct snd_soc_codec *codec,
 				  enum snd_soc_bias_level level)
 {
-	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
-
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-		if (aic32x4->master) {
-			/* Switch on PLL */
-			snd_soc_update_bits(codec, AIC32X4_PLLPR,
-					    AIC32X4_PLLEN, AIC32X4_PLLEN);
-
-			/* Switch on NDAC Divider */
-			snd_soc_update_bits(codec, AIC32X4_NDAC,
-					    AIC32X4_NDACEN, AIC32X4_NDACEN);
-
-			/* Switch on MDAC Divider */
-			snd_soc_update_bits(codec, AIC32X4_MDAC,
-					    AIC32X4_MDACEN, AIC32X4_MDACEN);
-
-			/* Switch on NADC Divider */
-			snd_soc_update_bits(codec, AIC32X4_NADC,
-					    AIC32X4_NADCEN, AIC32X4_NADCEN);
-
-			/* Switch on MADC Divider */
-			snd_soc_update_bits(codec, AIC32X4_MADC,
-					    AIC32X4_MADCEN, AIC32X4_MADCEN);
-
-			/* Switch on BCLK_N Divider */
-			snd_soc_update_bits(codec, AIC32X4_BCLKN,
-					    AIC32X4_BCLKEN, AIC32X4_BCLKEN);
-		}
+		/* Switch on PLL */
+		snd_soc_update_bits(codec, AIC32X4_PLLPR,
+				    AIC32X4_PLLEN, AIC32X4_PLLEN);
+
+		/* Switch on NDAC Divider */
+		snd_soc_update_bits(codec, AIC32X4_NDAC,
+				    AIC32X4_NDACEN, AIC32X4_NDACEN);
+
+		/* Switch on MDAC Divider */
+		snd_soc_update_bits(codec, AIC32X4_MDAC,
+				    AIC32X4_MDACEN, AIC32X4_MDACEN);
+
+		/* Switch on NADC Divider */
+		snd_soc_update_bits(codec, AIC32X4_NADC,
+				    AIC32X4_NADCEN, AIC32X4_NADCEN);
+
+		/* Switch on MADC Divider */
+		snd_soc_update_bits(codec, AIC32X4_MADC,
+				    AIC32X4_MADCEN, AIC32X4_MADCEN);
+
+		/* Switch on BCLK_N Divider */
+		snd_soc_update_bits(codec, AIC32X4_BCLKN,
+				    AIC32X4_BCLKEN, AIC32X4_BCLKEN);
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (aic32x4->master) {
-			/* Switch off PLL */
-			snd_soc_update_bits(codec, AIC32X4_PLLPR,
-					    AIC32X4_PLLEN, 0);
-
-			/* Switch off NDAC Divider */
-			snd_soc_update_bits(codec, AIC32X4_NDAC,
-					    AIC32X4_NDACEN, 0);
-
-			/* Switch off MDAC Divider */
-			snd_soc_update_bits(codec, AIC32X4_MDAC,
-					    AIC32X4_MDACEN, 0);
-
-			/* Switch off NADC Divider */
-			snd_soc_update_bits(codec, AIC32X4_NADC,
-					    AIC32X4_NADCEN, 0);
-
-			/* Switch off MADC Divider */
-			snd_soc_update_bits(codec, AIC32X4_MADC,
-					    AIC32X4_MADCEN, 0);
-
-			/* Switch off BCLK_N Divider */
-			snd_soc_update_bits(codec, AIC32X4_BCLKN,
-					    AIC32X4_BCLKEN, 0);
-		}
+		/* Switch off PLL */
+		snd_soc_update_bits(codec, AIC32X4_PLLPR,
+				    AIC32X4_PLLEN, 0);
+
+		/* Switch off NDAC Divider */
+		snd_soc_update_bits(codec, AIC32X4_NDAC,
+				    AIC32X4_NDACEN, 0);
+
+		/* Switch off MDAC Divider */
+		snd_soc_update_bits(codec, AIC32X4_MDAC,
+				    AIC32X4_MDACEN, 0);
+
+		/* Switch off NADC Divider */
+		snd_soc_update_bits(codec, AIC32X4_NADC,
+				    AIC32X4_NADCEN, 0);
+
+		/* Switch off MADC Divider */
+		snd_soc_update_bits(codec, AIC32X4_MADC,
+				    AIC32X4_MADCEN, 0);
+
+		/* Switch off BCLK_N Divider */
+		snd_soc_update_bits(codec, AIC32X4_BCLKN,
+				    AIC32X4_BCLKEN, 0);
 		break;
 	case SND_SOC_BIAS_OFF:
 		break;
-- 
1.7.8.3
