From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/4] ASoC: codecs: tas5720: add TAS5722 register support
Date: Mon, 11 Dec 2017 13:01:55 -0600
Message-ID: <20171211190157.12371-2-afd@ti.com>
References: <20171211190157.12371-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171211190157.12371-1-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>

Introduce a custom super-set register map and associated bit definitions
to allow driver access to all TAS5722 device functionality.

Signed-off-by: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
---
 sound/soc/codecs/tas5720.c | 23 ++++++++++++++++++++++-
 sound/soc/codecs/tas5720.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas5720.c b/sound/soc/codecs/tas5720.c
index 5def54d1336d..f3006f301fe8 100644
--- a/sound/soc/codecs/tas5720.c
+++ b/sound/soc/codecs/tas5720.c
@@ -466,6 +466,15 @@ static const struct regmap_config tas5720_regmap_config = {
 	.volatile_reg = tas5720_is_volatile_reg,
 };
 
+static const struct regmap_config tas5722_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = TAS5722_MAX_REG,
+	.cache_type = REGCACHE_RBTREE,
+	.volatile_reg = tas5720_is_volatile_reg,
+};
+
 /*
  * DAC analog gain. There are four discrete values to select from, ranging
  * from 19.2 dB to 26.3dB.
@@ -564,6 +573,7 @@ static int tas5720_probe(struct i2c_client *client,
 {
 	struct device *dev = &client->dev;
 	struct tas5720_data *data;
+	const struct regmap_config *regmap_config;
 	int ret;
 	int i;
 
@@ -574,7 +584,18 @@ static int tas5720_probe(struct i2c_client *client,
 	data->tas5720_client = client;
 	data->devtype = id->driver_data;
 
-	data->regmap = devm_regmap_init_i2c(client, &tas5720_regmap_config);
+	switch (id->driver_data) {
+	case TAS5720:
+		regmap_config = &tas5720_regmap_config;
+		break;
+	case TAS5722:
+		regmap_config = &tas5722_regmap_config;
+		break;
+	default:
+		dev_err(dev, "unexpected private driver data\n");
+		return -EINVAL;
+	}
+	data->regmap = devm_regmap_init_i2c(client, regmap_config);
 	if (IS_ERR(data->regmap)) {
 		ret = PTR_ERR(data->regmap);
 		dev_err(dev, "failed to allocate register map: %d\n", ret);
diff --git a/sound/soc/codecs/tas5720.h b/sound/soc/codecs/tas5720.h
index bef802afcc69..1dda3095961d 100644
--- a/sound/soc/codecs/tas5720.h
+++ b/sound/soc/codecs/tas5720.h
@@ -30,6 +30,11 @@
 #define TAS5720_DIGITAL_CLIP1_REG	0x11
 #define TAS5720_MAX_REG			TAS5720_DIGITAL_CLIP1_REG
 
+/* Additional TAS5722-specific Registers */
+#define TAS5722_DIGITAL_CTRL2_REG	0x13
+#define TAS5722_ANALOG_CTRL2_REG	0x14
+#define TAS5722_MAX_REG			TAS5722_ANALOG_CTRL2_REG
+
 /* TAS5720_DEVICE_ID_REG */
 #define TAS5720_DEVICE_ID		0x01
 #define TAS5722_DEVICE_ID		0x12
@@ -52,6 +57,7 @@
 #define TAS5720_SAIF_FORMAT_MASK	GENMASK(2, 0)
 
 /* TAS5720_DIGITAL_CTRL2_REG */
+#define TAS5722_VOL_RAMP_RATE		BIT(6)
 #define TAS5720_MUTE			BIT(4)
 #define TAS5720_TDM_SLOT_SEL_MASK	GENMASK(2, 0)
 
@@ -88,4 +94,28 @@
 #define TAS5720_CLIP1_MASK		GENMASK(7, 2)
 #define TAS5720_CLIP1_SHIFT		(0x2)
 
+/* TAS5722_DIGITAL_CTRL2_REG */
+#define TAS5722_HPF_3_7HZ		(0x0 << 5)
+#define TAS5722_HPF_7_4HZ		(0x1 << 5)
+#define TAS5722_HPF_14_9HZ		(0x2 << 5)
+#define TAS5722_HPF_29_7HZ		(0x3 << 5)
+#define TAS5722_HPF_59_4HZ		(0x4 << 5)
+#define TAS5722_HPF_118_4HZ		(0x5 << 5)
+#define TAS5722_HPF_235_0HZ		(0x6 << 5)
+#define TAS5722_HPF_463_2HZ		(0x7 << 5)
+#define TAS5722_HPF_MASK		GENMASK(7, 5)
+#define TAS5722_AUTO_SLEEP_OFF		(0x0 << 3)
+#define TAS5722_AUTO_SLEEP_1024LR	(0x1 << 3)
+#define TAS5722_AUTO_SLEEP_65536LR	(0x2 << 3)
+#define TAS5722_AUTO_SLEEP_262144LR	(0x3 << 3)
+#define TAS5722_AUTO_SLEEP_MASK		GENMASK(4, 3)
+#define TAS5722_TDM_SLOT_16B		BIT(2)
+#define TAS5722_MCLK_PIN_CFG		BIT(1)
+#define TAS5722_VOL_CONTROL_LSB		BIT(0)
+
+/* TAS5722_ANALOG_CTRL2_REG */
+#define TAS5722_FAULTZ_PU		BIT(3)
+#define TAS5722_VREG_LVL		BIT(2)
+#define TAS5722_PWR_TUNE		BIT(0)
+
 #endif /* __TAS5720_H__ */
-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
