From: Fletcher Woodruff <fletcherw@chromium.org>
Subject: [PATCH 2/2] ASoC: rt5677: make ACPI property names match _DSD
Date: Mon,  1 Apr 2019 14:55:19 -0600
Message-ID: <20190401205519.34023-2-fletcherw@chromium.org>
References: <20190401205519.34023-1-fletcherw@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401205519.34023-1-fletcherw@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Fletcher Woodruff <fletcherw@chromium.org>, Bard Liao <bardliao@realtek.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Curtis Malainey <cujomalainey@chromium.org>, Ross Zwisler <zwisler@google.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The rt5677 driver is using the wrong property names to read from ACPI.
Update the property names to match those from _DSD, so that the correct
GPIO pin numbers are read and that plug-detection works.

With this patch, plugging and unplugging the headphone jack switches
between headphones and speakers automatically.

Signed-off-by: Fletcher Woodruff <fletcherw@chromium.org>
---
 sound/soc/codecs/rt5677.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 33380f82b7008f..1f725086cee39c 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4998,25 +4998,6 @@ static const struct acpi_device_id rt5677_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, rt5677_acpi_match);
 
-static void rt5677_read_acpi_properties(struct rt5677_priv *rt5677,
-		struct device *dev)
-{
-	u32 val;
-
-	if (!device_property_read_u32(dev, "DCLK", &val))
-		rt5677->pdata.dmic2_clk_pin = val;
-
-	rt5677->pdata.in1_diff = device_property_read_bool(dev, "IN1");
-	rt5677->pdata.in2_diff = device_property_read_bool(dev, "IN2");
-	rt5677->pdata.lout1_diff = device_property_read_bool(dev, "OUT1");
-	rt5677->pdata.lout2_diff = device_property_read_bool(dev, "OUT2");
-	rt5677->pdata.lout3_diff = device_property_read_bool(dev, "OUT3");
-
-	device_property_read_u32(dev, "JD1", &rt5677->pdata.jd1_gpio);
-	device_property_read_u32(dev, "JD2", &rt5677->pdata.jd2_gpio);
-	device_property_read_u32(dev, "JD3", &rt5677->pdata.jd3_gpio);
-}
-
 static void rt5677_read_device_properties(struct rt5677_priv *rt5677,
 		struct device *dev)
 {
@@ -5273,19 +5254,23 @@ static int rt5677_i2c_probe(struct i2c_client *i2c)
 		if (match_id)
 			rt5677->type = (enum rt5677_type)match_id->data;
 
-		rt5677_read_device_properties(rt5677, &i2c->dev);
 	} else if (ACPI_HANDLE(&i2c->dev)) {
 		const struct acpi_device_id *acpi_id;
+		u32 val;
 
 		acpi_id = acpi_match_device(rt5677_acpi_match, &i2c->dev);
 		if (acpi_id)
 			rt5677->type = (enum rt5677_type)acpi_id->driver_data;
 
-		rt5677_read_acpi_properties(rt5677, &i2c->dev);
+		if (!device_property_read_u32(&i2c->dev,
+					"realtek,dmic2_clk_pin", &val))
+			rt5677->pdata.dmic2_clk_pin = val;
 	} else {
 		return -EINVAL;
 	}
 
+	rt5677_read_device_properties(rt5677, &i2c->dev);
+
 	/* pow-ldo2 and reset are optional. The codec pins may be statically
 	 * connected on the board without gpios. If the gpio device property
 	 * isn't specified, devm_gpiod_get_optional returns NULL.
-- 
2.21.0.392.gf8f6787159e-goog
