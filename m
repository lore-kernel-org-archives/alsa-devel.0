From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 12/17] ASoC: tlv320aic31xx: Add short circuit
	detection support
Date: Wed, 8 Nov 2017 18:27:36 -0600
Message-ID: <20171109002741.10897-13-afd@ti.com>
References: <20171109002741.10897-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 by alsa0.perex.cz (Postfix) with ESMTP id B4E9F267679
 for <alsa-devel@alsa-project.org>; Thu,  9 Nov 2017 01:27:46 +0100 (CET)
In-Reply-To: <20171109002741.10897-1-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
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
index 98e9ba3ee708..34867274c102 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -173,6 +173,7 @@ struct aic31xx_priv {
 	unsigned int sysclk;
 	u8 p_div;
 	int rate_div_line;
+	int irq;
 };
 
 struct aic31xx_rate_divs {
@@ -1320,6 +1321,27 @@ static const struct acpi_device_id aic31xx_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, aic31xx_acpi_match);
 #endif
 
+static irqreturn_t aic31xx_irq(int irq, void *data)
+{
+	struct aic31xx_priv *aic31xx = (struct aic31xx_priv *)data;
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
@@ -1342,6 +1364,7 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 	aic31xx->dev = &i2c->dev;
+	aic31xx->irq = i2c->irq;
 
 	aic31xx->codec_type = id->driver_data;
 
@@ -1383,6 +1406,25 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 	/* Reset device registers for a consistent power-on like state */
 	aic31xx_reset(aic31xx);
 
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
index 9bc53af9c3a0..3415a96aa6c3 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -192,6 +192,22 @@ enum aic31xx_type {
 #define AIC31XX_SC			BIT(3)
 #define AIC31XX_ENGINE			BIT(2)
 
+/* AIC31XX_GPIO1 */
+#define AIC31XX_GPIO1_FUNC_MASK		GENMASK(5, 2)
+#define AIC31XX_GPIO1_FUNC_SHIFT	2
+#define AIC31XX_GPIO1_DISABLED		0
+#define AIC31XX_GPIO1_INPUT		1
+#define AIC31XX_GPIO1_GPI		2
+#define AIC31XX_GPIO1_GPO		3
+#define AIC31XX_GPIO1_CLKOUT		4
+#define AIC31XX_GPIO1_INT1		5
+#define AIC31XX_GPIO1_INT2		6
+#define AIC31XX_GPIO1_ADC_WCLK		7
+#define AIC31XX_GPIO1_SBCLK		8
+#define AIC31XX_GPIO1_SWCLK		9
+#define AIC31XX_GPIO1_ADC_MOD_CLK	10
+#define AIC31XX_GPIO1_SDOUT		11
+
 /* AIC31XX_DACSETUP */
 #define AIC31XX_SOFTSTEP_MASK		GENMASK(1, 0)
 
-- 
2.15.0
