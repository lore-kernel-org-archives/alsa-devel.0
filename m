From: Sergey Kiselev <sergey.kiselev@intel.com>
Subject: Re: [PATCH] ASoC: wm8731: initialize the hardware when
 loading the codec driver; use regmap for I/O
Date: Tue, 2 Jun 2015 11:33:18 -0700
Message-ID: <20150602113318.918151bd4112a407da314099@intel.com>
References: <20150530003455.4c4d67eb444b1ceb45d3148c@intel.com>
 <556C1FCD.1070905@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 41D9E26058D
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 20:33:21 +0200 (CEST)
In-Reply-To: <556C1FCD.1070905@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hi,

I generated a new patch that fixes the issues indicated by Lars.

On Mon, 1 Jun 2015 11:03:09 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:
> It looks like the patch has been made against an older tree. It will 
> not apply on-top of ASoC for-next branch.
> 

Rebased.

> There is no need to replace all the snd_soc_${io}() calls with 
> regmap_${io}(). The snd_soc methods will just call the corresponding 
> regmap method internally. But if you really want to do it this should 
> be done in a separate patch.
> 

I kept the snd_soc_${io} except of reset and wm8731_hw_init, that are called before codec is registered (so snd_soc_${io} can't be used there). I'll generate a separate patch for regmap transistion.

> This is not necessary, the core will put the CODEC into BIAS_STANDBY 
> mode, after the probe callback has been called. So the whole probe 
> function can be dropped.
> 
> 
> Same here, the core already puts the CODEC into BIAS_OFF mode before 
> the remove callback is called.
> 

wm8731_probe and wm8731_remove callbacks removed.

This patch moves the request supplies and hardware reset and initialization from wm8731_probe to wm8731_i2c_probe and wm8731_spi_probe. So that the codec hardware is initialized when loading the codec driver, and not when loading the machine driver.

Signed-off-by: Sergey Kiselev <sergey.kiselev@intel.com>
---
 wm8731.c |   82 +++++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 52 insertions(+), 30 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 915ea11..8b19205 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -84,7 +84,7 @@ static bool wm8731_writeable(struct device *dev, unsigned int reg)
 	return reg <= WM8731_RESET;
 }
 
-#define wm8731_reset(c)	snd_soc_write(c, WM8731_RESET, 0)
+#define wm8731_reset(m)	regmap_write(m, WM8731_RESET, 0)
 
 static const char *wm8731_input_select[] = {"Line In", "Mic"};
 
@@ -571,44 +571,48 @@ static struct snd_soc_dai_driver wm8731_dai = {
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
-
-	/* Latch the update bits */
-	snd_soc_update_bits(codec, WM8731_LOUT1V, 0x100, 0);
-	snd_soc_update_bits(codec, WM8731_ROUT1V, 0x100, 0);
-	snd_soc_update_bits(codec, WM8731_LINVOL, 0x100, 0);
-	snd_soc_update_bits(codec, WM8731_RINVOL, 0x100, 0);
+	/* Clear POWEROFF, keep everything else disabled */
+	regmap_write(wm8731->regmap, WM8731_PWR, 0x7f);
 
 	/* Disable bypass path by default */
-	snd_soc_update_bits(codec, WM8731_APANA, 0x8, 0);
+	regmap_update_bits(wm8731->regmap, WM8731_APANA, 0x8, 0);
+
+	regcache_mark_dirty(wm8731->regmap);
 
 	/* Regulators will have been enabled by bias management */
 	regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
@@ -621,19 +625,7 @@ err_regulator_enable:
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
 
@@ -690,6 +682,13 @@ static int wm8731_spi_probe(struct spi_device *spi)
 
 	mutex_init(&wm8731->lock);
 
+	spi_set_drvdata(spi, wm8731);
+
+	ret = wm8731_request_supplies(&spi->dev, wm8731);
+	if (ret != 0) {
+		return ret;
+	}
+
 	wm8731->regmap = devm_regmap_init_spi(spi, &wm8731_regmap);
 	if (IS_ERR(wm8731->regmap)) {
 		ret = PTR_ERR(wm8731->regmap);
@@ -698,7 +697,10 @@ static int wm8731_spi_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	spi_set_drvdata(spi, wm8731);
+	ret = wm8731_hw_init(&spi->dev, wm8731);
+	if (ret != 0) {
+		return ret;
+	}
 
 	ret = snd_soc_register_codec(&spi->dev,
 			&soc_codec_dev_wm8731, &wm8731_dai, 1);
@@ -712,7 +714,12 @@ static int wm8731_spi_probe(struct spi_device *spi)
 
 static int wm8731_spi_remove(struct spi_device *spi)
 {
+	struct wm8731_priv *wm8731 = spi_get_drvdata(spi);
+
 	snd_soc_unregister_codec(&spi->dev);
+
+	regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
+
 	return 0;
 }
 
@@ -754,6 +761,13 @@ static int wm8731_i2c_probe(struct i2c_client *i2c,
 
 	mutex_init(&wm8731->lock);
 
+	i2c_set_clientdata(i2c, wm8731);
+
+	ret = wm8731_request_supplies(&i2c->dev, wm8731);
+	if (ret != 0) {
+		return ret;
+	}
+
 	wm8731->regmap = devm_regmap_init_i2c(i2c, &wm8731_regmap);
 	if (IS_ERR(wm8731->regmap)) {
 		ret = PTR_ERR(wm8731->regmap);
@@ -762,7 +776,10 @@ static int wm8731_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	i2c_set_clientdata(i2c, wm8731);
+	ret = wm8731_hw_init(&i2c->dev, wm8731);
+	if (ret != 0) {
+		return ret;
+	}
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8731, &wm8731_dai, 1);
@@ -776,7 +793,12 @@ static int wm8731_i2c_probe(struct i2c_client *i2c,
 
 static int wm8731_i2c_remove(struct i2c_client *client)
 {
+	struct wm8731_priv *wm8731 = i2c_get_clientdata(client);
+
 	snd_soc_unregister_codec(&client->dev);
+
+	regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
+
 	return 0;
 }
 
--
Sergey
