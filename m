From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/2] ALSA: ASoC: ak4104: convert to direct
	regmap API usage
Date: Wed,  6 Mar 2013 22:22:15 +0100
Message-ID: <1362604936-13624-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 71E0C260304
 for <alsa-devel@alsa-project.org>; Wed,  6 Mar 2013 22:22:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/codecs/ak4104.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index 6f6c335..58f390d 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -55,6 +55,7 @@ static int ak4104_set_dai_fmt(struct snd_soc_dai *codec_dai,
 			      unsigned int format)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
+	struct ak4104_private *ak4104 = snd_soc_codec_get_drvdata(codec);
 	int val = 0;
 	int ret;
 
@@ -77,9 +78,9 @@ static int ak4104_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	if ((format & SND_SOC_DAIFMT_MASTER_MASK) != SND_SOC_DAIFMT_CBS_CFS)
 		return -EINVAL;
 
-	ret = snd_soc_update_bits(codec, AK4104_REG_CONTROL1,
-				  AK4104_CONTROL1_DIF0 | AK4104_CONTROL1_DIF1,
-				  val);
+	ret = regmap_update_bits(ak4104->regmap, AK4104_REG_CONTROL1,
+				 AK4104_CONTROL1_DIF0 | AK4104_CONTROL1_DIF1,
+				 val);
 	if (ret < 0)
 		return ret;
 
@@ -91,11 +92,12 @@ static int ak4104_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
+	struct ak4104_private *ak4104 = snd_soc_codec_get_drvdata(codec);
 	int val = 0;
 
 	/* set the IEC958 bits: consumer mode, no copyright bit */
 	val |= IEC958_AES0_CON_NOT_COPYRIGHT;
-	snd_soc_write(codec, AK4104_REG_CHN_STATUS(0), val);
+	regmap_write(ak4104->regmap, AK4104_REG_CHN_STATUS(0), val);
 
 	val = 0;
 
@@ -132,7 +134,7 @@ static int ak4104_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	return snd_soc_write(codec, AK4104_REG_CHN_STATUS(3), val);
+	return regmap_write(ak4104->regmap, AK4104_REG_CHN_STATUS(3), val);
 }
 
 static const struct snd_soc_dai_ops ak4101_dai_ops = {
@@ -160,20 +162,17 @@ static int ak4104_probe(struct snd_soc_codec *codec)
 	int ret;
 
 	codec->control_data = ak4104->regmap;
-	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_REGMAP);
-	if (ret != 0)
-		return ret;
 
 	/* set power-up and non-reset bits */
-	ret = snd_soc_update_bits(codec, AK4104_REG_CONTROL1,
-				  AK4104_CONTROL1_PW | AK4104_CONTROL1_RSTN,
-				  AK4104_CONTROL1_PW | AK4104_CONTROL1_RSTN);
+	ret = regmap_update_bits(ak4104->regmap, AK4104_REG_CONTROL1,
+				 AK4104_CONTROL1_PW | AK4104_CONTROL1_RSTN,
+				 AK4104_CONTROL1_PW | AK4104_CONTROL1_RSTN);
 	if (ret < 0)
 		return ret;
 
 	/* enable transmitter */
-	ret = snd_soc_update_bits(codec, AK4104_REG_TX,
-				  AK4104_TX_TXE, AK4104_TX_TXE);
+	ret = regmap_update_bits(ak4104->regmap, AK4104_REG_TX,
+				 AK4104_TX_TXE, AK4104_TX_TXE);
 	if (ret < 0)
 		return ret;
 
@@ -182,8 +181,10 @@ static int ak4104_probe(struct snd_soc_codec *codec)
 
 static int ak4104_remove(struct snd_soc_codec *codec)
 {
-	snd_soc_update_bits(codec, AK4104_REG_CONTROL1,
-			    AK4104_CONTROL1_PW | AK4104_CONTROL1_RSTN, 0);
+	struct ak4104_private *ak4104 = snd_soc_codec_get_drvdata(codec);
+
+	regmap_update_bits(ak4104->regmap, AK4104_REG_CONTROL1,
+			   AK4104_CONTROL1_PW | AK4104_CONTROL1_RSTN, 0);
 
 	return 0;
 }
-- 
1.8.1.4
