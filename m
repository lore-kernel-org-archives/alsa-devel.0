From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 6/6] ASoC: Move initial WM8903 identification
	and reset to I2C probe
Date: Fri,  2 Dec 2011 19:28:15 +0000
Message-ID: <1322854095-14437-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20111202192330.GA4333@opensource.wolfsonmicro.com>
	<1322854095-14437-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E64BF24583
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 20:28:20 +0100 (CET)
In-Reply-To: <1322854095-14437-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Stephen Warren <swarren@nvidia.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Get control of the device earlier and avoid trying to do an ASoC probe
on a card that won't work.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |   41 +++++++++++++++++++++++------------------
 1 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 004db57..9e52cf0 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -248,11 +248,6 @@ static bool wm8903_volatile_register(struct device *dev, unsigned int reg)
 	}
 }
 
-static void wm8903_reset(struct snd_soc_codec *codec)
-{
-	snd_soc_write(codec, WM8903_SW_RESET_AND_ID, 0);
-}
-
 static int wm8903_cp_event(struct snd_soc_dapm_widget *w,
 			   struct snd_kcontrol *kcontrol, int event)
 {
@@ -1896,19 +1891,6 @@ static int wm8903_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	val = snd_soc_read(codec, WM8903_SW_RESET_AND_ID);
-	if (val != 0x8903) {
-		dev_err(codec->dev,
-			"Device with ID register %x is not a WM8903\n", val);
-		return -ENODEV;
-	}
-
-	val = snd_soc_read(codec, WM8903_REVISION_NUMBER);
-	dev_info(codec->dev, "WM8903 revision %c\n",
-		 (val & WM8903_CHIP_REV_MASK) + 'A');
-
-	wm8903_reset(codec);
-
 	/* Set up GPIOs and microphone detection */
 	if (pdata) {
 		bool mic_gpio = false;
@@ -2062,6 +2044,7 @@ static __devinit int wm8903_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8903_priv *wm8903;
+	unsigned int val;
 	int ret;
 
 	wm8903 = devm_kzalloc(&i2c->dev,  sizeof(struct wm8903_priv),
@@ -2080,6 +2063,28 @@ static __devinit int wm8903_i2c_probe(struct i2c_client *i2c,
 	i2c_set_clientdata(i2c, wm8903);
 	wm8903->irq = i2c->irq;
 
+	ret = regmap_read(wm8903->regmap, WM8903_SW_RESET_AND_ID, &val);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to read chip ID: %d\n", ret);
+		goto err;
+	}
+	if (val != 0x8903) {
+		dev_err(&i2c->dev, "Device with ID %x is not a WM8903\n", val);
+		ret = -ENODEV;
+		goto err;
+	}
+
+	ret = regmap_read(wm8903->regmap, WM8903_REVISION_NUMBER, &val);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to read chip revision: %d\n", ret);
+		goto err;
+	}
+	dev_info(&i2c->dev, "WM8903 revision %c\n",
+		 (val & WM8903_CHIP_REV_MASK) + 'A');
+
+	/* Reset the device */
+	regmap_write(wm8903->regmap, WM8903_SW_RESET_AND_ID, 0x8903);
+
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8903, &wm8903_dai, 1);
 	if (ret != 0)
-- 
1.7.7.3
