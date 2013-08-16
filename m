From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/3] ASoC: tlv320aic26: Remove direct use of
	internal I/O functions
Date: Fri, 16 Aug 2013 12:32:03 +0100
Message-ID: <1376652725-26857-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 34966261692
 for <alsa-devel@alsa-project.org>; Fri, 16 Aug 2013 13:32:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Use the core to do I/O rather than directly calling the driver operations
in order to support further refactoring.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/tlv320aic26.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index b192cd4..a4f9360 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -174,9 +174,9 @@ static int aic26_hw_params(struct snd_pcm_substream *substream,
 	dev_dbg(&aic26->spi->dev, "Setting PLLM to %d.%04d\n", jval, dval);
 	qval = 0;
 	reg = 0x8000 | qval << 11 | pval << 8 | jval << 2;
-	aic26_reg_write(codec, AIC26_REG_PLL_PROG1, reg);
+	snd_soc_write(codec, AIC26_REG_PLL_PROG1, reg);
 	reg = dval << 2;
-	aic26_reg_write(codec, AIC26_REG_PLL_PROG2, reg);
+	snd_soc_write(codec, AIC26_REG_PLL_PROG2, reg);
 
 	/* Audio Control 3 (master mode, fsref rate) */
 	reg = aic26_reg_read_cache(codec, AIC26_REG_AUDIO_CTRL3);
@@ -185,13 +185,13 @@ static int aic26_hw_params(struct snd_pcm_substream *substream,
 		reg |= 0x0800;
 	if (fsref == 48000)
 		reg |= 0x2000;
-	aic26_reg_write(codec, AIC26_REG_AUDIO_CTRL3, reg);
+	snd_soc_write(codec, AIC26_REG_AUDIO_CTRL3, reg);
 
 	/* Audio Control 1 (FSref divisor) */
 	reg = aic26_reg_read_cache(codec, AIC26_REG_AUDIO_CTRL1);
 	reg &= ~0x0fff;
 	reg |= wlen | aic26->datfm | (divisor << 3) | divisor;
-	aic26_reg_write(codec, AIC26_REG_AUDIO_CTRL1, reg);
+	snd_soc_write(codec, AIC26_REG_AUDIO_CTRL1, reg);
 
 	return 0;
 }
@@ -212,7 +212,7 @@ static int aic26_mute(struct snd_soc_dai *dai, int mute)
 		reg |= 0x8080;
 	else
 		reg &= ~0x8080;
-	aic26_reg_write(codec, AIC26_REG_DAC_GAIN, reg);
+	snd_soc_write(codec, AIC26_REG_DAC_GAIN, reg);
 
 	return 0;
 }
@@ -348,7 +348,7 @@ static ssize_t aic26_keyclick_set(struct device *dev,
 
 	val = aic26_reg_read_cache(aic26->codec, AIC26_REG_AUDIO_CTRL2);
 	val |= 0x8000;
-	aic26_reg_write(aic26->codec, AIC26_REG_AUDIO_CTRL2, val);
+	snd_soc_write(aic26->codec, AIC26_REG_AUDIO_CTRL2, val);
 
 	return count;
 }
@@ -368,20 +368,20 @@ static int aic26_probe(struct snd_soc_codec *codec)
 	dev_info(codec->dev, "Probing AIC26 SoC CODEC driver\n");
 
 	/* Reset the codec to power on defaults */
-	aic26_reg_write(codec, AIC26_REG_RESET, 0xBB00);
+	snd_soc_write(codec, AIC26_REG_RESET, 0xBB00);
 
 	/* Power up CODEC */
-	aic26_reg_write(codec, AIC26_REG_POWER_CTRL, 0);
+	snd_soc_write(codec, AIC26_REG_POWER_CTRL, 0);
 
 	/* Audio Control 3 (master mode, fsref rate) */
-	reg = aic26_reg_read(codec, AIC26_REG_AUDIO_CTRL3);
+	reg = snd_soc_read(codec, AIC26_REG_AUDIO_CTRL3);
 	reg &= ~0xf800;
 	reg |= 0x0800; /* set master mode */
-	aic26_reg_write(codec, AIC26_REG_AUDIO_CTRL3, reg);
+	snd_soc_write(codec, AIC26_REG_AUDIO_CTRL3, reg);
 
 	/* Fill register cache */
 	for (i = 0; i < codec->driver->reg_cache_size; i++)
-		aic26_reg_read(codec, i);
+		snd_soc_read(codec, i);
 
 	/* Register the sysfs files for debugging */
 	/* Create SysFS files */
-- 
1.8.4.rc2
