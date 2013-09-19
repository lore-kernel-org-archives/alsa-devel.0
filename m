From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] ASoC: 88pm60x: Don't use control data for
	i2c
Date: Thu, 19 Sep 2013 19:02:19 +0100
Message-ID: <1379613740-5800-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 18E0E2654AA
 for <alsa-devel@alsa-project.org>; Thu, 19 Sep 2013 20:02:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Haojian Zhuang <haojian.zhuang@marvell.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

In preparation for using the regmap directly in the CODEC driver replace
references to the I2C client using control_data with references to the
driver private data.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/88pm860x-codec.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index 259d1ac..ca5f9f0 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -1169,6 +1169,7 @@ static int pm860x_i2s_set_dai_fmt(struct snd_soc_dai *codec_dai,
 static int pm860x_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
+	struct pm860x_priv *pm860x = snd_soc_codec_get_drvdata(codec);
 	int data;
 
 	switch (level) {
@@ -1182,17 +1183,17 @@ static int pm860x_set_bias_level(struct snd_soc_codec *codec,
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			/* Enable Audio PLL & Audio section */
 			data = AUDIO_PLL | AUDIO_SECTION_ON;
-			pm860x_reg_write(codec->control_data, REG_MISC2, data);
+			pm860x_reg_write(pm860x->i2c, REG_MISC2, data);
 			udelay(300);
 			data = AUDIO_PLL | AUDIO_SECTION_RESET
 				| AUDIO_SECTION_ON;
-			pm860x_reg_write(codec->control_data, REG_MISC2, data);
+			pm860x_reg_write(pm860x->i2c, REG_MISC2, data);
 		}
 		break;
 
 	case SND_SOC_BIAS_OFF:
 		data = AUDIO_PLL | AUDIO_SECTION_RESET | AUDIO_SECTION_ON;
-		pm860x_set_bits(codec->control_data, REG_MISC2, data, 0);
+		pm860x_set_bits(pm860x->i2c, REG_MISC2, data, 0);
 		break;
 	}
 	codec->dapm.bias_level = level;
@@ -1322,17 +1323,17 @@ int pm860x_hs_jack_detect(struct snd_soc_codec *codec,
 	pm860x->det.lo_shrt = lo_shrt;
 
 	if (det & SND_JACK_HEADPHONE)
-		pm860x_set_bits(codec->control_data, REG_HS_DET,
+		pm860x_set_bits(pm860x->i2c, REG_HS_DET,
 				EN_HS_DET, EN_HS_DET);
 	/* headset short detect */
 	if (hs_shrt) {
 		data = CLR_SHORT_HS2 | CLR_SHORT_HS1;
-		pm860x_set_bits(codec->control_data, REG_SHORTS, data, data);
+		pm860x_set_bits(pm860x->i2c, REG_SHORTS, data, data);
 	}
 	/* Lineout short detect */
 	if (lo_shrt) {
 		data = CLR_SHORT_LO2 | CLR_SHORT_LO1;
-		pm860x_set_bits(codec->control_data, REG_SHORTS, data, data);
+		pm860x_set_bits(pm860x->i2c, REG_SHORTS, data, data);
 	}
 
 	/* sync status */
@@ -1350,7 +1351,7 @@ int pm860x_mic_jack_detect(struct snd_soc_codec *codec,
 	pm860x->det.mic_det = det;
 
 	if (det & SND_JACK_MICROPHONE)
-		pm860x_set_bits(codec->control_data, REG_MIC_DET,
+		pm860x_set_bits(pm860x->i2c, REG_MIC_DET,
 				MICDET_MASK, MICDET_MASK);
 
 	/* sync status */
@@ -1380,7 +1381,7 @@ static int pm860x_probe(struct snd_soc_codec *codec)
 
 	pm860x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-	ret = pm860x_bulk_read(codec->control_data, REG_CACHE_BASE,
+	ret = pm860x_bulk_read(pm860x->i2c, REG_CACHE_BASE,
 			       REG_CACHE_SIZE, codec->reg_cache);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to fill register cache: %d\n",
-- 
1.8.4.rc3
