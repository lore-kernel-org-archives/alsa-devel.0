From: a@opensource.wolfsonmicro.com
Subject: [PATCH 2/2] ASoC: wm8961: Move device identification
	and reset to I2C probe
Date: Thu, 13 Sep 2012 13:32:46 +0800
Message-ID: <25062.4837157831$1347515110@news.gmane.org>
References: <1347514366-17641-1-git-send-email-a>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 426552625CF
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2012 07:45:00 +0200 (CEST)
In-Reply-To: <1347514366-17641-1-git-send-email-a>
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

From: Mark Brown <broonie@opensource.wolfsonmicro.com>

This is more idiomatic as it means we verify that the device is there
prior to trying to do the card probe.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8961.c |   60 +++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index 4ea64d6e..f387670 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -187,11 +187,6 @@ static bool wm8961_readable(struct device *dev, unsigned int reg)
 	}
 }
 
-static int wm8961_reset(struct snd_soc_codec *codec)
-{
-	return snd_soc_write(codec, WM8961_SOFTWARE_RESET, 0);
-}
-
 /*
  * The headphone output supports special anti-pop sequences giving
  * silent power up and power down.
@@ -840,7 +835,6 @@ static struct snd_soc_dai_driver wm8961_dai = {
 
 static int wm8961_probe(struct snd_soc_codec *codec)
 {
-	struct wm8961_priv *wm8961 = snd_soc_codec_get_drvdata(codec);
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret = 0;
 	u16 reg;
@@ -851,27 +845,6 @@ static int wm8961_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	reg = snd_soc_read(codec, WM8961_SOFTWARE_RESET);
-	if (reg != 0x1801) {
-		dev_err(codec->dev, "Device is not a WM8961: ID=0x%x\n", reg);
-		return -EINVAL;
-	}
-
-	/* This isn't volatile - readback doesn't correspond to write */
-	regcache_cache_bypass(wm8961->regmap, true);
-	reg = snd_soc_read(codec, WM8961_RIGHT_INPUT_VOLUME);
-	regcache_cache_bypass(wm8961->regmap, false);
-	dev_info(codec->dev, "WM8961 family %d revision %c\n",
-		 (reg & WM8961_DEVICE_ID_MASK) >> WM8961_DEVICE_ID_SHIFT,
-		 ((reg & WM8961_CHIP_REV_MASK) >> WM8961_CHIP_REV_SHIFT)
-		 + 'A');
-
-	ret = wm8961_reset(codec);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to issue reset\n");
-		return ret;
-	}
-
 	/* Enable class W */
 	reg = snd_soc_read(codec, WM8961_CHARGE_PUMP_B);
 	reg |= WM8961_CP_DYN_PWR_MASK;
@@ -968,6 +941,7 @@ static __devinit int wm8961_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8961_priv *wm8961;
+	unsigned int val;
 	int ret;
 
 	wm8961 = devm_kzalloc(&i2c->dev, sizeof(struct wm8961_priv),
@@ -979,6 +953,38 @@ static __devinit int wm8961_i2c_probe(struct i2c_client *i2c,
 	if (IS_ERR(wm8961->regmap))
 		return PTR_ERR(wm8961->regmap);
 
+	ret = regmap_read(wm8961->regmap, WM8961_SOFTWARE_RESET, &val);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to read chip ID: %d\n", ret);
+		return ret;
+	}
+
+	if (val != 0x1801) {
+		dev_err(&i2c->dev, "Device is not a WM8961: ID=0x%x\n", val);
+		return -EINVAL;
+	}
+
+	/* This isn't volatile - readback doesn't correspond to write */
+	regcache_cache_bypass(wm8961->regmap, true);
+	ret = regmap_read(wm8961->regmap, WM8961_RIGHT_INPUT_VOLUME, &val);
+	regcache_cache_bypass(wm8961->regmap, false);
+
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to read chip revision: %d\n", ret);
+		return ret;
+	}
+
+	dev_info(&i2c->dev, "WM8961 family %d revision %c\n",
+		 (val & WM8961_DEVICE_ID_MASK) >> WM8961_DEVICE_ID_SHIFT,
+		 ((val & WM8961_CHIP_REV_MASK) >> WM8961_CHIP_REV_SHIFT)
+		 + 'A');
+
+	ret = regmap_write(wm8961->regmap, WM8961_SOFTWARE_RESET, 0x1801);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to issue reset: %d\n", ret);
+		return ret;
+	}
+
 	i2c_set_clientdata(i2c, wm8961);
 
 	ret = snd_soc_register_codec(&i2c->dev,
-- 
1.7.10.4
