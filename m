From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH 1/4] ASoC: wm8804: Add support for hardware reset line
Date: Tue,  7 Apr 2015 11:34:50 +0100
Message-ID: <1428402893-11787-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, info-Ht5PubfIbSajfpyLsbbDOw@public.gmane.org, sapthagiri.baratam-sjhevXS25z0S+FvcfC7Uqw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

It is best to use the physical reset if it is available. This patch adds
support for a GPIO controlled physical reset for the chip.

Signed-off-by: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
 sound/soc/codecs/wm8804.c |   26 +++++++++++++++++++++-----
 1 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index f44da83..cc168c4 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/of_device.h>
@@ -61,6 +62,8 @@ struct wm8804_priv {
 	struct regulator_bulk_data supplies[WM8804_NUM_SUPPLIES];
 	struct notifier_block disable_nb[WM8804_NUM_SUPPLIES];
 	int mclk_div;
+
+	struct gpio_desc *reset;
 };
 
 static int txsrc_get(struct snd_kcontrol *kcontrol,
@@ -182,7 +185,7 @@ static bool wm8804_volatile(struct device *dev, unsigned int reg)
 	}
 }
 
-static int wm8804_reset(struct wm8804_priv *wm8804)
+static int wm8804_soft_reset(struct wm8804_priv *wm8804)
 {
 	return regmap_write(wm8804->regmap, WM8804_RST_DEVID1, 0x0);
 }
@@ -586,6 +589,14 @@ int wm8804_probe(struct device *dev, struct regmap *regmap)
 
 	wm8804->regmap = regmap;
 
+	wm8804->reset = devm_gpiod_get_optional(dev, "wlf,reset",
+						GPIOD_OUT_LOW);
+	if (IS_ERR(wm8804->reset)) {
+		ret = PTR_ERR(wm8804->reset);
+		dev_err(dev, "Failed to get reset line: %d\n", ret);
+		return ret;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(wm8804->supplies); i++)
 		wm8804->supplies[i].supply = wm8804_supply_names[i];
 
@@ -620,6 +631,9 @@ int wm8804_probe(struct device *dev, struct regmap *regmap)
 		return ret;
 	}
 
+	if (wm8804->reset)
+		gpiod_set_value_cansleep(wm8804->reset, 1);
+
 	ret = regmap_read(regmap, WM8804_RST_DEVID1, &id1);
 	if (ret < 0) {
 		dev_err(dev, "Failed to read device ID: %d\n", ret);
@@ -648,10 +662,12 @@ int wm8804_probe(struct device *dev, struct regmap *regmap)
 	}
 	dev_info(dev, "revision %c\n", id1 + 'A');
 
-	ret = wm8804_reset(wm8804);
-	if (ret < 0) {
-		dev_err(dev, "Failed to issue reset: %d\n", ret);
-		goto err_reg_enable;
+	if (!wm8804->reset) {
+		ret = wm8804_soft_reset(wm8804);
+		if (ret < 0) {
+			dev_err(dev, "Failed to issue reset: %d\n", ret);
+			goto err_reg_enable;
+		}
 	}
 
 	ret = snd_soc_register_codec(dev, &soc_codec_dev_wm8804,
-- 
1.7.2.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
