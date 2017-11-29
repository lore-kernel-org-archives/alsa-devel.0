From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v2 17/19] ASoC: tlv320aic31xx: Add overflow detection support
Date: Wed, 29 Nov 2017 15:32:58 -0600
Message-ID: <20171129213300.20021-18-afd@ti.com>
References: <20171129213300.20021-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171129213300.20021-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

Similar to short circuit detection, when the ADC/DAC is saturated and
overflows poor audio quality can result and should be reported to the
user. This device support Automatic Dynamic Range Compression (DRC)
to reduce this but it is not enabled currently in this driver.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 20 +++++++++++++++++++-
 sound/soc/codecs/tlv320aic31xx.h |  7 +++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index fd3109366377..094b1596f9cc 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1277,6 +1277,23 @@ static irqreturn_t aic31xx_irq(int irq, void *data)
 	if (value & AIC31XX_HPRSCDETECT)
 		dev_err(dev, "Short circuit on Right output is detected\n");
 
+	ret = regmap_read(aic31xx->regmap, AIC31XX_OFFLAG, &value);
+	if (ret) {
+		dev_err(dev, "Failed to read overflow flag: %d\n", ret);
+		return IRQ_NONE;
+	}
+
+	if (value & AIC31XX_DAC_OF_LEFT)
+		dev_err(dev, "Left-channel DAC overflow has occurred\n");
+	if (value & AIC31XX_DAC_OF_RIGHT)
+		dev_err(dev, "Right-channel DAC overflow has occurred\n");
+	if (value & AIC31XX_DAC_OF_SHIFTER)
+		dev_err(dev, "DAC barrel shifter overflow has occurred\n");
+	if (value & AIC31XX_ADC_OF)
+		dev_err(dev, "ADC overflow has occurred\n");
+	if (value & AIC31XX_ADC_OF_SHIFTER)
+		dev_err(dev, "ADC barrel shifter overflow has occurred\n");
+
 	return IRQ_HANDLED;
 }
 
@@ -1348,7 +1365,8 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 				   AIC31XX_GPIO1_FUNC_SHIFT);
 
 		regmap_write(aic31xx->regmap, AIC31XX_INT1CTRL,
-			     AIC31XX_SC);
+			     AIC31XX_SC |
+			     AIC31XX_ENGINE);
 
 		ret = devm_request_threaded_irq(aic31xx->dev, aic31xx->irq,
 						NULL, aic31xx_irq,
diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index 9dc85b6f6ad3..d062663f66b5 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -166,6 +166,13 @@ enum aic31xx_type {
 #define AIC31XX_HPRDRVPWRSTATUS_MASK	BIT(1)
 #define AIC31XX_SPRDRVPWRSTATUS_MASK	BIT(0)
 
+/* AIC31XX_OFFLAG */
+#define AIC31XX_DAC_OF_LEFT		BIT(7)
+#define AIC31XX_DAC_OF_RIGHT		BIT(6)
+#define AIC31XX_DAC_OF_SHIFTER		BIT(5)
+#define AIC31XX_ADC_OF			BIT(3)
+#define AIC31XX_ADC_OF_SHIFTER		BIT(1)
+
 /* AIC31XX_INTRDACFLAG */
 #define AIC31XX_HPLSCDETECT		BIT(7)
 #define AIC31XX_HPRSCDETECT		BIT(6)
-- 
2.15.0
