From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 2/3] ASoC: tlv320aic3x: Switch to soc-cache
	helpers
Date: Tue, 14 Sep 2010 14:54:48 +0300
Message-ID: <1284465289-4865-2-git-send-email-jhnikula@gmail.com>
References: <1284465289-4865-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id F25B52446F
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Sep 2010 13:55:06 +0200 (CEST)
Received: by mail-ew0-f51.google.com with SMTP id 21so3012819ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 14 Sep 2010 04:55:06 -0700 (PDT)
In-Reply-To: <1284465289-4865-1-git-send-email-jhnikula@gmail.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Continue phasing out aic3x_read_reg_cache, aic3x_write_reg_cache, aic3x_read
and aic3x_write calls.

This patch takes the soc-cache in use and removes aic3x_read_reg_cache and
aic3x_write.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |   46 +++++++--------------------------------
 1 files changed, 9 insertions(+), 37 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 138165c..86e5a58 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -112,18 +112,6 @@ static const u8 aic3x_reg[AIC3X_CACHEREGNUM] = {
 };
 
 /*
- * read aic3x register cache
- */
-static inline unsigned int aic3x_read_reg_cache(struct snd_soc_codec *codec,
-						unsigned int reg)
-{
-	u8 *cache = codec->reg_cache;
-	if (reg >= AIC3X_CACHEREGNUM)
-		return -1;
-	return cache[reg];
-}
-
-/*
  * write aic3x register cache
  */
 static inline void aic3x_write_reg_cache(struct snd_soc_codec *codec,
@@ -136,28 +124,6 @@ static inline void aic3x_write_reg_cache(struct snd_soc_codec *codec,
 }
 
 /*
- * write to the aic3x register space
- */
-static int aic3x_write(struct snd_soc_codec *codec, unsigned int reg,
-		       unsigned int value)
-{
-	u8 data[2];
-
-	/* data is
-	 *   D15..D8 aic3x register offset
-	 *   D7...D0 register data
-	 */
-	data[0] = reg & 0xff;
-	data[1] = value & 0xff;
-
-	aic3x_write_reg_cache(codec, data[0], data[1]);
-	if (codec->hw_write(codec->control_data, data, 2) == 2)
-		return 0;
-	else
-		return -EIO;
-}
-
-/*
  * read from the aic3x register space
  */
 static int aic3x_read(struct snd_soc_codec *codec, unsigned int reg,
@@ -1299,10 +1265,16 @@ static int aic3x_init(struct snd_soc_codec *codec)
 static int aic3x_probe(struct snd_soc_codec *codec)
 {
 	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
+	int ret;
 
-	codec->hw_write = (hw_write_t) i2c_master_send;
 	codec->control_data = aic3x->control_data;
 
+	ret = snd_soc_codec_set_cache_io(codec, 8, 8, aic3x->control_type);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		return ret;
+	}
+
 	aic3x_init(codec);
 
 	if (aic3x->setup) {
@@ -1330,8 +1302,6 @@ static int aic3x_remove(struct snd_soc_codec *codec)
 }
 
 static struct snd_soc_codec_driver soc_codec_dev_aic3x = {
-	.read = aic3x_read_reg_cache,
-	.write = aic3x_write,
 	.set_bias_level = aic3x_set_bias_level,
 	.reg_cache_size = ARRAY_SIZE(aic3x_reg),
 	.reg_word_size = sizeof(u8),
@@ -1375,6 +1345,8 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 	}
 
 	aic3x->control_data = i2c;
+	aic3x->control_type = SND_SOC_I2C;
+
 	i2c_set_clientdata(i2c, aic3x);
 	if (pdata) {
 		aic3x->gpio_reset = pdata->gpio_reset;
-- 
1.7.1
