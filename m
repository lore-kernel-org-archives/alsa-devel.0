From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5677: fall back to DT prop names on error" to the asoc tree
Date: Mon, 17 Jun 2019 16:24:16 +0100 (BST)
Message-ID: <20190617152417.01C03440049@finisterre.sirena.org.uk>
References: <20190614194854.208436-2-fletcherw@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190614194854.208436-2-fletcherw@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Fletcher Woodruff <fletcherw@chromium.org>
Cc: alsa-devel@alsa-project.org, Curtis Malainey <cujomalainey@chromium.org>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Oder Chiou <oder_chiou@realtek.com>, Ross Zwisler <zwisler@chromium.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5677: fall back to DT prop names on error

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 8893cba2fa6994ac8434cbc616eeddcde211ec45 Mon Sep 17 00:00:00 2001
From: Fletcher Woodruff <fletcherw@chromium.org>
Date: Fri, 14 Jun 2019 13:48:51 -0600
Subject: [PATCH] ASoC: rt5677: fall back to DT prop names on error

The rt5677 driver uses ACPI-style property names to read from the
device API. However, these do not match the property names in _DSD
used on the Chromebook Pixel 2015, which are closer to the Device Tree
style.  Unify the two functions for reading from the device API so that
they try ACPI-style names first and fall back to the DT names on error.

With this patch, plugging and unplugging the headphone jack switches
between headphones and speakers automatically.

Signed-off-by: Fletcher Woodruff <fletcherw@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5677.c | 74 +++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index c49b5c218666..fe000f30b9ad 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5020,48 +5020,50 @@ static const struct acpi_device_id rt5677_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, rt5677_acpi_match);
 
-static void rt5677_read_acpi_properties(struct rt5677_priv *rt5677,
+static void rt5677_read_device_properties(struct rt5677_priv *rt5677,
 		struct device *dev)
 {
 	u32 val;
 
-	if (!device_property_read_u32(dev, "DCLK", &val))
-		rt5677->pdata.dmic2_clk_pin = val;
+	rt5677->pdata.in1_diff =
+		device_property_read_bool(dev, "IN1") ||
+		device_property_read_bool(dev, "realtek,in1-differential");
 
-	rt5677->pdata.in1_diff = device_property_read_bool(dev, "IN1");
-	rt5677->pdata.in2_diff = device_property_read_bool(dev, "IN2");
-	rt5677->pdata.lout1_diff = device_property_read_bool(dev, "OUT1");
-	rt5677->pdata.lout2_diff = device_property_read_bool(dev, "OUT2");
-	rt5677->pdata.lout3_diff = device_property_read_bool(dev, "OUT3");
+	rt5677->pdata.in2_diff =
+		device_property_read_bool(dev, "IN2") ||
+		device_property_read_bool(dev, "realtek,in2-differential");
 
-	device_property_read_u32(dev, "JD1", &rt5677->pdata.jd1_gpio);
-	device_property_read_u32(dev, "JD2", &rt5677->pdata.jd2_gpio);
-	device_property_read_u32(dev, "JD3", &rt5677->pdata.jd3_gpio);
-}
+	rt5677->pdata.lout1_diff =
+		device_property_read_bool(dev, "OUT1") ||
+		device_property_read_bool(dev, "realtek,lout1-differential");
 
-static void rt5677_read_device_properties(struct rt5677_priv *rt5677,
-		struct device *dev)
-{
-	rt5677->pdata.in1_diff = device_property_read_bool(dev,
-			"realtek,in1-differential");
-	rt5677->pdata.in2_diff = device_property_read_bool(dev,
-			"realtek,in2-differential");
-	rt5677->pdata.lout1_diff = device_property_read_bool(dev,
-			"realtek,lout1-differential");
-	rt5677->pdata.lout2_diff = device_property_read_bool(dev,
-			"realtek,lout2-differential");
-	rt5677->pdata.lout3_diff = device_property_read_bool(dev,
-			"realtek,lout3-differential");
+	rt5677->pdata.lout2_diff =
+		device_property_read_bool(dev, "OUT2") ||
+		device_property_read_bool(dev, "realtek,lout2-differential");
+
+	rt5677->pdata.lout3_diff =
+		device_property_read_bool(dev, "OUT3") ||
+		device_property_read_bool(dev, "realtek,lout3-differential");
 
 	device_property_read_u8_array(dev, "realtek,gpio-config",
-			rt5677->pdata.gpio_config, RT5677_GPIO_NUM);
-
-	device_property_read_u32(dev, "realtek,jd1-gpio",
-			&rt5677->pdata.jd1_gpio);
-	device_property_read_u32(dev, "realtek,jd2-gpio",
-			&rt5677->pdata.jd2_gpio);
-	device_property_read_u32(dev, "realtek,jd3-gpio",
-			&rt5677->pdata.jd3_gpio);
+				      rt5677->pdata.gpio_config,
+				      RT5677_GPIO_NUM);
+
+	if (!device_property_read_u32(dev, "DCLK", &val) ||
+	    !device_property_read_u32(dev, "realtek,dmic2_clk_pin", &val))
+		rt5677->pdata.dmic2_clk_pin = val;
+
+	if (!device_property_read_u32(dev, "JD1", &val) ||
+	    !device_property_read_u32(dev, "realtek,jd1-gpio", &val))
+		rt5677->pdata.jd1_gpio = val;
+
+	if (!device_property_read_u32(dev, "JD2", &val) ||
+	    !device_property_read_u32(dev, "realtek,jd2-gpio", &val))
+		rt5677->pdata.jd2_gpio = val;
+
+	if (!device_property_read_u32(dev, "JD3", &val) ||
+	    !device_property_read_u32(dev, "realtek,jd3-gpio", &val))
+		rt5677->pdata.jd3_gpio = val;
 }
 
 static struct regmap_irq rt5677_irqs[] = {
@@ -5144,20 +5146,18 @@ static int rt5677_i2c_probe(struct i2c_client *i2c)
 		match_id = of_match_device(rt5677_of_match, &i2c->dev);
 		if (match_id)
 			rt5677->type = (enum rt5677_type)match_id->data;
-
-		rt5677_read_device_properties(rt5677, &i2c->dev);
 	} else if (ACPI_HANDLE(&i2c->dev)) {
 		const struct acpi_device_id *acpi_id;
 
 		acpi_id = acpi_match_device(rt5677_acpi_match, &i2c->dev);
 		if (acpi_id)
 			rt5677->type = (enum rt5677_type)acpi_id->driver_data;
-
-		rt5677_read_acpi_properties(rt5677, &i2c->dev);
 	} else {
 		return -EINVAL;
 	}
 
+	rt5677_read_device_properties(rt5677, &i2c->dev);
+
 	/* pow-ldo2 and reset are optional. The codec pins may be statically
 	 * connected on the board without gpios. If the gpio device property
 	 * isn't specified, devm_gpiod_get_optional returns NULL.
-- 
2.20.1
