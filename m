From: Sergej Sawazki <ce3a@gmx.de>
Subject: [PATCH v2] ASoC: wm8741: Add differential mono mode
	support
Date: Tue,  5 May 2015 22:46:31 +0200
Message-ID: <1430858791-11825-1-git-send-email-ce3a@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by alsa0.perex.cz (Postfix) with ESMTP id 63EF4260451
 for <alsa-devel@alsa-project.org>; Tue,  5 May 2015 22:47:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de
Cc: Sergej Sawazki <ce3a@gmx.de>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The WM8741 DAC supports several differential output modes (stereo,
stereo reversed, mono left, mono right). Add platform data and DT
bindings to configure it.

Signed-off-by: Sergej Sawazki <ce3a@gmx.de>
---
 Documentation/devicetree/bindings/sound/wm8741.txt |  11 +++
 sound/soc/codecs/wm8741.c                          | 108 ++++++++++++++++++---
 sound/soc/codecs/wm8741.h                          |  10 ++
 3 files changed, 117 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/wm8741.txt b/Documentation/devicetree/bindings/sound/wm8741.txt
index 74bda58..a133154 100644
--- a/Documentation/devicetree/bindings/sound/wm8741.txt
+++ b/Documentation/devicetree/bindings/sound/wm8741.txt
@@ -10,9 +10,20 @@ Required properties:
   - reg : the I2C address of the device for I2C, the chip select
           number for SPI.
 
+Optional properties:
+
+  - diff-mode: Differential output mode configuration. Default value for field
+    DIFF in register R8 (MODE_CONTROL_2). If absent, the default is 0, shall be:
+    0 = stereo
+    1 = mono left
+    2 = stereo reversed
+    3 = mono right
+
 Example:
 
 codec: wm8741@1a {
 	compatible = "wlf,wm8741";
 	reg = <0x1a>;
+
+	diff-mode = <3>;
 };
diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 9e71c76..cbf90ab 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -41,6 +41,7 @@ static const char *wm8741_supply_names[WM8741_NUM_SUPPLIES] = {
 
 /* codec private data */
 struct wm8741_priv {
+	struct wm8741_platform_data pdata;
 	struct regmap *regmap;
 	struct regulator_bulk_data supplies[WM8741_NUM_SUPPLIES];
 	unsigned int sysclk;
@@ -398,7 +399,7 @@ static struct snd_soc_dai_driver wm8741_dai = {
 	.name = "wm8741",
 	.playback = {
 		.stream_name = "Playback",
-		.channels_min = 2,  /* Mono modes not yet supported */
+		.channels_min = 2,
 		.channels_max = 2,
 		.rates = WM8741_RATES,
 		.formats = WM8741_FORMATS,
@@ -416,6 +417,60 @@ static int wm8741_resume(struct snd_soc_codec *codec)
 #define wm8741_resume NULL
 #endif
 
+static int wm8741_configure(struct snd_soc_codec *codec)
+{
+	struct wm8741_priv *wm8741 = snd_soc_codec_get_drvdata(codec);
+
+	/* Configure differential mode */
+	switch (wm8741->pdata.diff_mode) {
+	case WM8741_DIFF_MODE_STEREO:
+	case WM8741_DIFF_MODE_STEREO_REVERSED:
+	case WM8741_DIFF_MODE_MONO_LEFT:
+	case WM8741_DIFF_MODE_MONO_RIGHT:
+		snd_soc_update_bits(codec, WM8741_MODE_CONTROL_2,
+				WM8741_DIFF_MASK,
+				wm8741->pdata.diff_mode << WM8741_DIFF_SHIFT);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Change some default settings - latch VU */
+	snd_soc_update_bits(codec, WM8741_DACLLSB_ATTENUATION,
+			WM8741_UPDATELL, WM8741_UPDATELL);
+	snd_soc_update_bits(codec, WM8741_DACLMSB_ATTENUATION,
+			WM8741_UPDATELM, WM8741_UPDATELM);
+	snd_soc_update_bits(codec, WM8741_DACRLSB_ATTENUATION,
+			WM8741_UPDATERL, WM8741_UPDATERL);
+	snd_soc_update_bits(codec, WM8741_DACRMSB_ATTENUATION,
+			WM8741_UPDATERM, WM8741_UPDATERM);
+
+	return 0;
+}
+
+static int wm8741_add_controls(struct snd_soc_codec *codec)
+{
+	struct wm8741_priv *wm8741 = snd_soc_codec_get_drvdata(codec);
+
+	switch (wm8741->pdata.diff_mode) {
+	case WM8741_DIFF_MODE_STEREO:
+	case WM8741_DIFF_MODE_STEREO_REVERSED:
+		snd_soc_add_codec_controls(codec, wm8741_snd_controls,
+				ARRAY_SIZE(wm8741_snd_controls));
+		break;
+	case WM8741_DIFF_MODE_MONO_LEFT:
+	case WM8741_DIFF_MODE_MONO_RIGHT:
+		/* The machine driver is responsible for mixer controls
+		 * if the codec is configured in differential mono mode.
+		 */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int wm8741_probe(struct snd_soc_codec *codec)
 {
 	struct wm8741_priv *wm8741 = snd_soc_codec_get_drvdata(codec);
@@ -434,15 +489,17 @@ static int wm8741_probe(struct snd_soc_codec *codec)
 		goto err_enable;
 	}
 
-	/* Change some default settings - latch VU */
-	snd_soc_update_bits(codec, WM8741_DACLLSB_ATTENUATION,
-			    WM8741_UPDATELL, WM8741_UPDATELL);
-	snd_soc_update_bits(codec, WM8741_DACLMSB_ATTENUATION,
-			    WM8741_UPDATELM, WM8741_UPDATELM);
-	snd_soc_update_bits(codec, WM8741_DACRLSB_ATTENUATION,
-			    WM8741_UPDATERL, WM8741_UPDATERL);
-	snd_soc_update_bits(codec, WM8741_DACRMSB_ATTENUATION,
-			    WM8741_UPDATERM, WM8741_UPDATERM);
+	ret = wm8741_configure(codec);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to change default settings\n");
+		goto err_enable;
+	}
+
+	ret = wm8741_add_controls(codec);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to add controls\n");
+		goto err_enable;
+	}
 
 	dev_dbg(codec->dev, "Successful registration\n");
 	return ret;
@@ -467,8 +524,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8741 = {
 	.remove =	wm8741_remove,
 	.resume =	wm8741_resume,
 
-	.controls = wm8741_snd_controls,
-	.num_controls = ARRAY_SIZE(wm8741_snd_controls),
 	.dapm_widgets = wm8741_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(wm8741_dapm_widgets),
 	.dapm_routes = wm8741_dapm_routes,
@@ -493,6 +548,23 @@ static const struct regmap_config wm8741_regmap = {
 	.readable_reg = wm8741_readable,
 };
 
+static int wm8741_set_pdata(struct device *dev, struct wm8741_priv *wm8741)
+{
+	const struct wm8741_platform_data *pdata = dev_get_platdata(dev);
+	u32 diff_mode;
+
+	if (dev->of_node) {
+		if (of_property_read_u32(dev->of_node, "diff-mode", &diff_mode)
+				>= 0)
+			wm8741->pdata.diff_mode = diff_mode;
+	} else {
+		if (pdata != NULL)
+			memcpy(&wm8741->pdata, pdata, sizeof(wm8741->pdata));
+	}
+
+	return 0;
+}
+
 #if IS_ENABLED(CONFIG_I2C)
 static int wm8741_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
@@ -522,6 +594,12 @@ static int wm8741_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	wm8741_set_pdata(&i2c->dev, wm8741);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to set pdata: %d\n", ret);
+		return ret;
+	}
+
 	i2c_set_clientdata(i2c, wm8741);
 
 	ret = snd_soc_register_codec(&i2c->dev,
@@ -582,6 +660,12 @@ static int wm8741_spi_probe(struct spi_device *spi)
 		return ret;
 	}
 
+	wm8741_set_pdata(&spi->dev, wm8741);
+	if (ret != 0) {
+		dev_err(&spi->dev, "Failed to set pdata: %d\n", ret);
+		return ret;
+	}
+
 	spi_set_drvdata(spi, wm8741);
 
 	ret = snd_soc_register_codec(&spi->dev,
diff --git a/sound/soc/codecs/wm8741.h b/sound/soc/codecs/wm8741.h
index 56c1b1d..c8835f6 100644
--- a/sound/soc/codecs/wm8741.h
+++ b/sound/soc/codecs/wm8741.h
@@ -194,6 +194,12 @@
 #define WM8741_DITHER_SHIFT                          0  /* DITHER - [1:0] */
 #define WM8741_DITHER_WIDTH                          2  /* DITHER - [1:0] */
 
+/* DIFF field values */
+#define WM8741_DIFF_MODE_STEREO                      0  /* stereo normal */
+#define WM8741_DIFF_MODE_STEREO_REVERSED             2  /* stereo reversed */
+#define WM8741_DIFF_MODE_MONO_LEFT                   1  /* mono left */
+#define WM8741_DIFF_MODE_MONO_RIGHT                  3  /* mono right */
+
 /*
  * R32 (0x20) - ADDITONAL_CONTROL_1
  */
@@ -208,4 +214,8 @@
 
 #define  WM8741_SYSCLK 0
 
+struct wm8741_platform_data {
+	u32 diff_mode;   /* Differential Output Mode */
+};
+
 #endif
-- 
1.9.1
