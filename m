From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v3 07/10] ASoC: tlv320aic31xx: Add short circuit detection support
Date: Thu, 7 Dec 2017 09:38:57 -0600
Message-ID: <20171207153900.9831-8-afd@ti.com>
References: <20171207153900.9831-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171207153900.9831-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

These devices support detecting and reporting short circuits across
the output stages. Add support for reporting these issue. Do this
by registering an interrupt if available and enabling this error
to trigger that interrupt in the device.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 42 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/tlv320aic31xx.h | 16 +++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 6cbe5820ce60..500284853a5c 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -159,6 +159,7 @@ struct aic31xx_priv {
 	unsigned int sysclk;
 	u8 p_div;
 	int rate_div_line;
+	int irq;
 };
 
 struct aic31xx_rate_divs {
@@ -1253,6 +1254,27 @@ static const struct acpi_device_id aic31xx_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, aic31xx_acpi_match);
 #endif
 
+static irqreturn_t aic31xx_irq(int irq, void *data)
+{
+	struct aic31xx_priv *aic31xx = data;
+	struct device *dev = aic31xx->dev;
+	unsigned int value;
+	int ret;
+
+	ret = regmap_read(aic31xx->regmap, AIC31XX_INTRDACFLAG, &value);
+	if (ret) {
+		dev_err(dev, "Failed to read interrupt mask: %d\n", ret);
+		return IRQ_NONE;
+	}
+
+	if (value & AIC31XX_HPLSCDETECT)
+		dev_err(dev, "Short circuit on Left output is detected\n");
+	if (value & AIC31XX_HPRSCDETECT)
+		dev_err(dev, "Short circuit on Right output is detected\n");
+
+	return IRQ_HANDLED;
+}
+
 static int aic31xx_i2c_probe(struct i2c_client *i2c,
 			     const struct i2c_device_id *id)
 {
@@ -1275,6 +1297,7 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 	aic31xx->dev = &i2c->dev;
+	aic31xx->irq = i2c->irq;
 
 	aic31xx->codec_type = id->driver_data;
 
@@ -1313,6 +1336,25 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	if (aic31xx->irq > 0) {
+		regmap_update_bits(aic31xx->regmap, AIC31XX_GPIO1,
+				   AIC31XX_GPIO1_FUNC_MASK,
+				   AIC31XX_GPIO1_INT1 <<
+				   AIC31XX_GPIO1_FUNC_SHIFT);
+
+		regmap_write(aic31xx->regmap, AIC31XX_INT1CTRL,
+			     AIC31XX_SC);
+
+		ret = devm_request_threaded_irq(aic31xx->dev, aic31xx->irq,
+						NULL, aic31xx_irq,
+						IRQF_ONESHOT, "aic31xx-irq",
+						aic31xx);
+		if (ret) {
+			dev_err(aic31xx->dev, "Unable to request IRQ\n");
+			return ret;
+		}
+	}
+
 	if (aic31xx->codec_type & DAC31XX_BIT)
 		return snd_soc_register_codec(&i2c->dev,
 				&soc_codec_driver_aic31xx,
diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index ab94e6a0c742..9dc85b6f6ad3 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -184,6 +184,22 @@ enum aic31xx_type {
 #define AIC31XX_SC			BIT(3)
 #define AIC31XX_ENGINE			BIT(2)
 
+/* AIC31XX_GPIO1 */
+#define AIC31XX_GPIO1_FUNC_MASK		GENMASK(5, 2)
+#define AIC31XX_GPIO1_FUNC_SHIFT	2
+#define AIC31XX_GPIO1_DISABLED		0x00
+#define AIC31XX_GPIO1_INPUT		0x01
+#define AIC31XX_GPIO1_GPI		0x02
+#define AIC31XX_GPIO1_GPO		0x03
+#define AIC31XX_GPIO1_CLKOUT		0x04
+#define AIC31XX_GPIO1_INT1		0x05
+#define AIC31XX_GPIO1_INT2		0x06
+#define AIC31XX_GPIO1_ADC_WCLK		0x07
+#define AIC31XX_GPIO1_SBCLK		0x08
+#define AIC31XX_GPIO1_SWCLK		0x09
+#define AIC31XX_GPIO1_ADC_MOD_CLK	0x10
+#define AIC31XX_GPIO1_SDOUT		0x11
+
 /* AIC31XX_DACSETUP */
 #define AIC31XX_SOFTSTEP_MASK		GENMASK(1, 0)
 
-- 
2.15.0
