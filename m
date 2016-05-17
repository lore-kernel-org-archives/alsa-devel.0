From: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 2/2] ASoC: wm8985: add device-tree support
Date: Tue, 17 May 2016 14:49:49 +0200
Message-ID: <1463489389-17719-2-git-send-email-petr@barix.com>
References: <1463489389-17719-1-git-send-email-petr@barix.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463489389-17719-1-git-send-email-petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, plamen-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Add device-tree support to the WM8985 driver.

Signed-off-by: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
---
v1: initial
v2: add missing of_match_ptr()
    use chip type enum instead of chip structure

 sound/soc/codecs/wm8985.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
index 436c7e2c5a0b..0b2dd2bc6fff 100644
--- a/sound/soc/codecs/wm8985.c
+++ b/sound/soc/codecs/wm8985.c
@@ -32,6 +32,7 @@
 #include <sound/soc.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
+#include <linux/of_device.h>
 
 #include "wm8985.h"
 
@@ -1174,10 +1175,21 @@ static const struct regmap_config wm8985_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(wm8985_reg_defaults),
 };
 
+static enum wm8985_type wm8985_data = WM8985;
+static enum wm8985_type wm8758_data = WM8758;
+
+static const struct of_device_id wm8985_of_match[] = {
+	{ .compatible = "wlf,wm8985", .data = &wm8985_data},
+	{ .compatible = "wlf,wm8758", .data = &wm8758_data},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, wm8985_of_match);
+
 #if defined(CONFIG_SPI_MASTER)
 static int wm8985_spi_probe(struct spi_device *spi)
 {
 	struct wm8985_priv *wm8985;
+	const struct of_device_id *of_id;
 	int ret;
 
 	wm8985 = devm_kzalloc(&spi->dev, sizeof *wm8985, GFP_KERNEL);
@@ -1186,7 +1198,11 @@ static int wm8985_spi_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, wm8985);
 
-	wm8985->dev_type = WM8985;
+	of_id = of_match_device(wm8985_of_match, &spi->dev);
+	if (of_id)
+		wm8985->dev_type = *((enum wm8985_type *)of_id->data);
+	else
+		wm8985->dev_type = WM8985;
 
 	wm8985->regmap = devm_regmap_init_spi(spi, &wm8985_regmap);
 	if (IS_ERR(wm8985->regmap)) {
@@ -1210,6 +1226,7 @@ static int wm8985_spi_remove(struct spi_device *spi)
 static struct spi_driver wm8985_spi_driver = {
 	.driver = {
 		.name = "wm8985",
+		.of_match_table = of_match_ptr(wm8985_of_match),
 	},
 	.probe = wm8985_spi_probe,
 	.remove = wm8985_spi_remove
@@ -1221,6 +1238,7 @@ static int wm8985_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
 	struct wm8985_priv *wm8985;
+	const struct of_device_id *of_id;
 	int ret;
 
 	wm8985 = devm_kzalloc(&i2c->dev, sizeof *wm8985, GFP_KERNEL);
@@ -1229,7 +1247,11 @@ static int wm8985_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm8985);
 
-	wm8985->dev_type = id->driver_data;
+	of_id = of_match_device(wm8985_of_match, &i2c->dev);
+	if (of_id)
+		wm8985->dev_type = *((enum wm8985_type *)of_id->data);
+	else
+		wm8985->dev_type = id->driver_data;
 
 	wm8985->regmap = devm_regmap_init_i2c(i2c, &wm8985_regmap);
 	if (IS_ERR(wm8985->regmap)) {
@@ -1260,6 +1282,7 @@ MODULE_DEVICE_TABLE(i2c, wm8985_i2c_id);
 static struct i2c_driver wm8985_i2c_driver = {
 	.driver = {
 		.name = "wm8985",
+		.of_match_table = of_match_ptr(wm8985_of_match),
 	},
 	.probe = wm8985_i2c_probe,
 	.remove = wm8985_i2c_remove,
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
