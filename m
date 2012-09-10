From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: wm8523: Move device ID verification
	and reset to I2C probe
Date: Mon, 10 Sep 2012 17:08:02 +0800
Message-ID: <1347268082-14993-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1347268082-14993-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AAEC526507A
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 11:28:01 +0200 (CEST)
In-Reply-To: <1347268082-14993-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Ensure that we have confirmed that we've got the device in place before
we register with ASoC.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8523.c |   84 ++++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 46 deletions(-)

diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index d7d5fe6..8d5c276 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -68,11 +68,6 @@ static bool wm8523_volatile_register(struct device *dev, unsigned int reg)
 	}
 }
 
-static int wm8523_reset(struct snd_soc_codec *codec)
-{
-	return snd_soc_write(codec, WM8523_DEVICE_ID, 0);
-}
-
 static const DECLARE_TLV_DB_SCALE(dac_tlv, -10000, 25, 0);
 
 static const char *wm8523_zd_count_text[] = {
@@ -409,38 +404,6 @@ static int wm8523_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(wm8523->supplies),
-				    wm8523->supplies);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
-		goto err_get;
-	}
-
-	ret = snd_soc_read(codec, WM8523_DEVICE_ID);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to read ID register\n");
-		goto err_enable;
-	}
-	if (ret != 0x8523) {
-		dev_err(codec->dev, "Device is not a WM8523, ID is %x\n", ret);
-		ret = -EINVAL;
-		goto err_enable;
-	}
-
-	ret = snd_soc_read(codec, WM8523_REVISION);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to read revision register\n");
-		goto err_enable;
-	}
-	dev_info(codec->dev, "revision %c\n",
-		 (ret & WM8523_CHIP_REV_MASK) + 'A');
-
-	ret = wm8523_reset(codec);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to issue reset\n");
-		goto err_enable;
-	}
-
 	/* Change some default settings - latch VU and enable ZC */
 	snd_soc_update_bits(codec, WM8523_DAC_GAINR,
 			    WM8523_DACR_VU, WM8523_DACR_VU);
@@ -448,16 +411,7 @@ static int wm8523_probe(struct snd_soc_codec *codec)
 
 	wm8523_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-	/* Bias level configuration will have done an extra enable */
-	regulator_bulk_disable(ARRAY_SIZE(wm8523->supplies), wm8523->supplies);
-
 	return 0;
-
-err_enable:
-	regulator_bulk_disable(ARRAY_SIZE(wm8523->supplies), wm8523->supplies);
-err_get:
-
-	return ret;
 }
 
 static int wm8523_remove(struct snd_soc_codec *codec)
@@ -503,6 +457,7 @@ static __devinit int wm8523_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8523_priv *wm8523;
+	unsigned int val;
 	int ret, i;
 
 	wm8523 = devm_kzalloc(&i2c->dev, sizeof(struct wm8523_priv),
@@ -527,6 +482,40 @@ static __devinit int wm8523_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	ret = regulator_bulk_enable(ARRAY_SIZE(wm8523->supplies),
+				    wm8523->supplies);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to enable supplies: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_read(wm8523->regmap, WM8523_DEVICE_ID, &val);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "Failed to read ID register\n");
+		goto err_enable;
+	}
+	if (val != 0x8523) {
+		dev_err(&i2c->dev, "Device is not a WM8523, ID is %x\n", ret);
+		ret = -EINVAL;
+		goto err_enable;
+	}
+
+	ret = regmap_read(wm8523->regmap, WM8523_REVISION, &val);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "Failed to read revision register\n");
+		goto err_enable;
+	}
+	dev_info(&i2c->dev, "revision %c\n",
+		 (val & WM8523_CHIP_REV_MASK) + 'A');
+
+	ret = regmap_write(wm8523->regmap, WM8523_DEVICE_ID, 0x8523);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to reset device: %d\n", ret);
+		goto err_enable;
+	}
+
+	regulator_bulk_disable(ARRAY_SIZE(wm8523->supplies), wm8523->supplies);
+
 	i2c_set_clientdata(i2c, wm8523);
 
 	ret =  snd_soc_register_codec(&i2c->dev,
@@ -534,6 +523,9 @@ static __devinit int wm8523_i2c_probe(struct i2c_client *i2c,
 
 	return ret;
 
+err_enable:
+	regulator_bulk_disable(ARRAY_SIZE(wm8523->supplies), wm8523->supplies);
+	return ret;
 }
 
 static __devexit int wm8523_i2c_remove(struct i2c_client *client)
-- 
1.7.10.4
