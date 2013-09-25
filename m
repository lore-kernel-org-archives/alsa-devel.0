From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/3] ASoC: tlv320aic26: Use
	snd_soc_update_bits()
Date: Wed, 25 Sep 2013 13:30:38 +0100
Message-ID: <1380112239-11149-2-git-send-email-broonie@kernel.org>
References: <1380112239-11149-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EB202625DB
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2013 14:30:45 +0200 (CEST)
In-Reply-To: <1380112239-11149-1-git-send-email-broonie@kernel.org>
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

Use snd_soc_update_bits() rather than open coding. Since the register cache
is currently only used where update_bits() is used this means the current
register cache can be removed entirely.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/tlv320aic26.c | 51 +++++++++++-------------------------------
 1 file changed, 13 insertions(+), 38 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index 32c6b07..4d82447 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -74,19 +74,6 @@ static unsigned int aic26_reg_read(struct snd_soc_codec *codec,
 	return value;
 }
 
-static unsigned int aic26_reg_read_cache(struct snd_soc_codec *codec,
-					 unsigned int reg)
-{
-	u16 *cache = codec->reg_cache;
-
-	if (reg >= AIC26_NUM_REGS) {
-		WARN_ON_ONCE(1);
-		return 0;
-	}
-
-	return cache[reg];
-}
-
 static int aic26_reg_write(struct snd_soc_codec *codec, unsigned int reg,
 			   unsigned int value)
 {
@@ -195,19 +182,15 @@ static int aic26_hw_params(struct snd_pcm_substream *substream,
 	snd_soc_write(codec, AIC26_REG_PLL_PROG2, reg);
 
 	/* Audio Control 3 (master mode, fsref rate) */
-	reg = aic26_reg_read_cache(codec, AIC26_REG_AUDIO_CTRL3);
-	reg &= ~0xf800;
 	if (aic26->master)
-		reg |= 0x0800;
+		reg = 0x0800;
 	if (fsref == 48000)
-		reg |= 0x2000;
-	snd_soc_write(codec, AIC26_REG_AUDIO_CTRL3, reg);
+		reg = 0x2000;
+	snd_soc_update_bits(codec, AIC26_REG_AUDIO_CTRL3, 0xf800, reg);
 
 	/* Audio Control 1 (FSref divisor) */
-	reg = aic26_reg_read_cache(codec, AIC26_REG_AUDIO_CTRL1);
-	reg &= ~0x0fff;
-	reg |= wlen | aic26->datfm | (divisor << 3) | divisor;
-	snd_soc_write(codec, AIC26_REG_AUDIO_CTRL1, reg);
+	reg = wlen | aic26->datfm | (divisor << 3) | divisor;
+	snd_soc_update_bits(codec, AIC26_REG_AUDIO_CTRL1, 0xfff, reg);
 
 	return 0;
 }
@@ -219,16 +202,16 @@ static int aic26_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct aic26 *aic26 = snd_soc_codec_get_drvdata(codec);
-	u16 reg = aic26_reg_read_cache(codec, AIC26_REG_DAC_GAIN);
+	u16 reg;
 
 	dev_dbg(&aic26->spi->dev, "aic26_mute(dai=%p, mute=%i)\n",
 		dai, mute);
 
 	if (mute)
-		reg |= 0x8080;
+		reg = 0x8080;
 	else
-		reg &= ~0x8080;
-	snd_soc_write(codec, AIC26_REG_DAC_GAIN, reg);
+		reg = 0;
+	snd_soc_update_bits(codec, AIC26_REG_DAC_GAIN, 0x8000, reg);
 
 	return 0;
 }
@@ -346,7 +329,7 @@ static ssize_t aic26_keyclick_show(struct device *dev,
 	struct aic26 *aic26 = dev_get_drvdata(dev);
 	int val, amp, freq, len;
 
-	val = aic26_reg_read_cache(aic26->codec, AIC26_REG_AUDIO_CTRL2);
+	val = snd_soc_read(aic26->codec, AIC26_REG_AUDIO_CTRL2);
 	amp = (val >> 12) & 0x7;
 	freq = (125 << ((val >> 8) & 0x7)) >> 1;
 	len = 2 * (1 + ((val >> 4) & 0xf));
@@ -360,11 +343,9 @@ static ssize_t aic26_keyclick_set(struct device *dev,
 				  const char *buf, size_t count)
 {
 	struct aic26 *aic26 = dev_get_drvdata(dev);
-	int val;
 
-	val = aic26_reg_read_cache(aic26->codec, AIC26_REG_AUDIO_CTRL2);
-	val |= 0x8000;
-	snd_soc_write(aic26->codec, AIC26_REG_AUDIO_CTRL2, val);
+	snd_soc_update_bits(aic26->codec, AIC26_REG_AUDIO_CTRL2,
+			    0x8000, 0x800);
 
 	return count;
 }
@@ -377,7 +358,7 @@ static DEVICE_ATTR(keyclick, 0644, aic26_keyclick_show, aic26_keyclick_set);
 static int aic26_probe(struct snd_soc_codec *codec)
 {
 	struct aic26 *aic26 = dev_get_drvdata(codec->dev);
-	int ret, i, reg;
+	int ret, reg;
 
 	aic26->codec = codec;
 
@@ -393,10 +374,6 @@ static int aic26_probe(struct snd_soc_codec *codec)
 	reg |= 0x0800; /* set master mode */
 	snd_soc_write(codec, AIC26_REG_AUDIO_CTRL3, reg);
 
-	/* Fill register cache */
-	for (i = 0; i < codec->driver->reg_cache_size; i++)
-		snd_soc_read(codec, i);
-
 	/* Register the sysfs files for debugging */
 	/* Create SysFS files */
 	ret = device_create_file(codec->dev, &dev_attr_keyclick);
@@ -410,8 +387,6 @@ static struct snd_soc_codec_driver aic26_soc_codec_dev = {
 	.probe = aic26_probe,
 	.read = aic26_reg_read,
 	.write = aic26_reg_write,
-	.reg_cache_size = AIC26_NUM_REGS,
-	.reg_word_size = sizeof(u16),
 	.controls = aic26_snd_controls,
 	.num_controls = ARRAY_SIZE(aic26_snd_controls),
 	.dapm_widgets = tlv320aic26_dapm_widgets,
-- 
1.8.4.rc3
