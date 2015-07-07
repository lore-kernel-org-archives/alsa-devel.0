From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8731: initialize the hardware when
	loading the codec driver" to the asoc tree
Date: Tue, 07 Jul 2015 14:58:06 +0100
Message-ID: <E1ZCTNu-0005cE-5l@finisterre>
References: <20150605115527.d7c116e0dfbc751f066d417c@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 48F65265740
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 15:58:17 +0200 (CEST)
In-Reply-To: <20150605115527.d7c116e0dfbc751f066d417c@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergey Kiselev <sergey.kiselev@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8731: initialize the hardware when loading the codec driver

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 6702dfcc571d962df499f7466f54e07d044e6cd1 Mon Sep 17 00:00:00 2001
From: Sergey Kiselev <sergey.kiselev@intel.com>
Date: Fri, 5 Jun 2015 11:55:27 -0700
Subject: [PATCH] ASoC: wm8731: initialize the hardware when loading the codec
 driver

This patch moves the requesting supplies, hardware reset and
initialization from wm8731_probe to wm8731_i2c_probe and wm8731_spi_probe.
So that the codec hardware is initialized when loading the codec driver,
and not when loading the machine driver. This avoids unnecesary hardware
resets and re-initializations when re-loading the machine driver.

Signed-off-by: Sergey Kiselev <sergey.kiselev@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8731.c | 74 +++++++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 32 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 915ea11..f22935a 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -84,7 +84,7 @@ static bool wm8731_writeable(struct device *dev, unsigned int reg)
 	return reg <= WM8731_RESET;
 }
 
-#define wm8731_reset(c)	snd_soc_write(c, WM8731_RESET, 0)
+#define wm8731_reset(m)	regmap_write(m, WM8731_RESET, 0)
 
 static const char *wm8731_input_select[] = {"Line In", "Mic"};
 
@@ -571,69 +571,63 @@ static struct snd_soc_dai_driver wm8731_dai = {
 	.symmetric_rates = 1,
 };
 
-static int wm8731_probe(struct snd_soc_codec *codec)
+static int wm8731_request_supplies(struct device *dev,
+		struct wm8731_priv *wm8731)
 {
-	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0, i;
 
 	for (i = 0; i < ARRAY_SIZE(wm8731->supplies); i++)
 		wm8731->supplies[i].supply = wm8731_supply_names[i];
 
-	ret = devm_regulator_bulk_get(codec->dev, ARRAY_SIZE(wm8731->supplies),
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(wm8731->supplies),
 				 wm8731->supplies);
 	if (ret != 0) {
-		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
+		dev_err(dev, "Failed to request supplies: %d\n", ret);
 		return ret;
 	}
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(wm8731->supplies),
 				    wm8731->supplies);
 	if (ret != 0) {
-		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
+		dev_err(dev, "Failed to enable supplies: %d\n", ret);
 		return ret;
 	}
 
-	ret = wm8731_reset(codec);
+	return 0;
+}
+
+static int wm8731_hw_init(struct device *dev, struct wm8731_priv *wm8731)
+{
+	int ret = 0;
+
+	ret = wm8731_reset(wm8731->regmap);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to issue reset: %d\n", ret);
+		dev_err(dev, "Failed to issue reset: %d\n", ret);
 		goto err_regulator_enable;
 	}
 
-	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	/* Clear POWEROFF, keep everything else disabled */
+	regmap_write(wm8731->regmap, WM8731_PWR, 0x7f);
 
 	/* Latch the update bits */
-	snd_soc_update_bits(codec, WM8731_LOUT1V, 0x100, 0);
-	snd_soc_update_bits(codec, WM8731_ROUT1V, 0x100, 0);
-	snd_soc_update_bits(codec, WM8731_LINVOL, 0x100, 0);
-	snd_soc_update_bits(codec, WM8731_RINVOL, 0x100, 0);
+	regmap_update_bits(wm8731->regmap, WM8731_LOUT1V, 0x100, 0);
+	regmap_update_bits(wm8731->regmap, WM8731_ROUT1V, 0x100, 0);
+	regmap_update_bits(wm8731->regmap, WM8731_LINVOL, 0x100, 0);
+	regmap_update_bits(wm8731->regmap, WM8731_RINVOL, 0x100, 0);
 
 	/* Disable bypass path by default */
-	snd_soc_update_bits(codec, WM8731_APANA, 0x8, 0);
+	regmap_update_bits(wm8731->regmap, WM8731_APANA, 0x8, 0);
 
-	/* Regulators will have been enabled by bias management */
-	regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
-
-	return 0;
+	regcache_mark_dirty(wm8731->regmap);
 
 err_regulator_enable:
+	/* Regulators will be enabled by bias management */
 	regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
 
 	return ret;
 }
 
-/* power down chip */
-static int wm8731_remove(struct snd_soc_codec *codec)
-{
-	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
-
-	regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
-
-	return 0;
-}
-
 static struct snd_soc_codec_driver soc_codec_dev_wm8731 = {
-	.probe =	wm8731_probe,
-	.remove =	wm8731_remove,
 	.set_bias_level = wm8731_set_bias_level,
 	.suspend_bias_off = true,
 
@@ -690,6 +684,12 @@ static int wm8731_spi_probe(struct spi_device *spi)
 
 	mutex_init(&wm8731->lock);
 
+	spi_set_drvdata(spi, wm8731);
+
+	ret = wm8731_request_supplies(&spi->dev, wm8731);
+	if (ret != 0)
+		return ret;
+
 	wm8731->regmap = devm_regmap_init_spi(spi, &wm8731_regmap);
 	if (IS_ERR(wm8731->regmap)) {
 		ret = PTR_ERR(wm8731->regmap);
@@ -698,7 +698,9 @@ static int wm8731_spi_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	spi_set_drvdata(spi, wm8731);
+	ret = wm8731_hw_init(&spi->dev, wm8731);
+	if (ret != 0)
+		return ret;
 
 	ret = snd_soc_register_codec(&spi->dev,
 			&soc_codec_dev_wm8731, &wm8731_dai, 1);
@@ -754,6 +756,12 @@ static int wm8731_i2c_probe(struct i2c_client *i2c,
 
 	mutex_init(&wm8731->lock);
 
+	i2c_set_clientdata(i2c, wm8731);
+
+	ret = wm8731_request_supplies(&i2c->dev, wm8731);
+	if (ret != 0)
+		return ret;
+
 	wm8731->regmap = devm_regmap_init_i2c(i2c, &wm8731_regmap);
 	if (IS_ERR(wm8731->regmap)) {
 		ret = PTR_ERR(wm8731->regmap);
@@ -762,7 +770,9 @@ static int wm8731_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	i2c_set_clientdata(i2c, wm8731);
+	ret = wm8731_hw_init(&i2c->dev, wm8731);
+	if (ret != 0)
+		return ret;
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8731, &wm8731_dai, 1);
-- 
2.1.4
