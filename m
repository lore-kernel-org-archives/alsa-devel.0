From: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] ASoC: wm8985: add device-tree support
Date: Thu, 12 May 2016 17:58:50 +0200
Message-ID: <1463068730-18817-2-git-send-email-petr@barix.com>
References: <1463068730-18817-1-git-send-email-petr@barix.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463068730-18817-1-git-send-email-petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, plamen-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Add device-tree support to the WM8985 driver.

Signed-off-by: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
---
 sound/soc/codecs/wm8985.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
index bbf25a1ad51d..fa5b391c24bd 100644
--- a/sound/soc/codecs/wm8985.c
+++ b/sound/soc/codecs/wm8985.c
@@ -32,6 +32,7 @@
 #include <sound/soc.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
+#include <linux/of_device.h>
 
 #include "wm8985.h"
 
@@ -1323,11 +1324,19 @@ static const struct wm8xxx_chip wm8758_chip = {
 	.codec_dev	= &soc_codec_dev_wm8758,
 };
 
+static const struct of_device_id wm8985_of_match[] = {
+	{ .compatible = "wlf,wm8985", .data = &wm8985_chip},
+	{ .compatible = "wlf,wm8758", .data = &wm8758_chip},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, wm8985_of_match);
 
 #if defined(CONFIG_SPI_MASTER)
 static int wm8985_spi_probe(struct spi_device *spi)
 {
 	struct wm8985_priv *wm8985;
+	const struct wm8xxx_chip *chip;
+	const struct of_device_id *of_id;
 	int ret;
 
 	wm8985 = devm_kzalloc(&spi->dev, sizeof *wm8985, GFP_KERNEL);
@@ -1336,6 +1345,12 @@ static int wm8985_spi_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, wm8985);
 
+	of_id = of_match_device(wm8985_of_match, &spi->dev);
+	if (of_id)
+		chip = of_id->data;
+	else
+		chip = &wm8985_chip;
+
 	wm8985->regmap = devm_regmap_init_spi(spi, &wm8985_regmap);
 	if (IS_ERR(wm8985->regmap)) {
 		ret = PTR_ERR(wm8985->regmap);
@@ -1345,7 +1360,7 @@ static int wm8985_spi_probe(struct spi_device *spi)
 	}
 
 	ret = snd_soc_register_codec(&spi->dev,
-				     &soc_codec_dev_wm8985, &wm8985_dai, 1);
+				     chip->codec_dev, chip->dai, 1);
 	return ret;
 }
 
@@ -1358,6 +1373,7 @@ static int wm8985_spi_remove(struct spi_device *spi)
 static struct spi_driver wm8985_spi_driver = {
 	.driver = {
 		.name = "wm8985",
+		.of_match_table = wm8985_of_match,
 	},
 	.probe = wm8985_spi_probe,
 	.remove = wm8985_spi_remove
@@ -1369,7 +1385,8 @@ static int wm8985_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
 	struct wm8985_priv *wm8985;
-	struct wm8xxx_chip *chip = (void *) id->driver_data;
+	const struct wm8xxx_chip *chip;
+	const struct of_device_id *of_id;
 	int ret;
 
 	wm8985 = devm_kzalloc(&i2c->dev, sizeof *wm8985, GFP_KERNEL);
@@ -1378,6 +1395,12 @@ static int wm8985_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm8985);
 
+	of_id = of_match_device(wm8985_of_match, &i2c->dev);
+	if (of_id)
+		chip = of_id->data;
+	else
+		chip = (void *) id->driver_data;
+
 	wm8985->regmap = devm_regmap_init_i2c(i2c, &wm8985_regmap);
 	if (IS_ERR(wm8985->regmap)) {
 		ret = PTR_ERR(wm8985->regmap);
@@ -1407,6 +1430,7 @@ MODULE_DEVICE_TABLE(i2c, wm8985_i2c_id);
 static struct i2c_driver wm8985_i2c_driver = {
 	.driver = {
 		.name = "wm8985",
+		.of_match_table = wm8985_of_match,
 	},
 	.probe = wm8985_i2c_probe,
 	.remove = wm8985_i2c_remove,
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
