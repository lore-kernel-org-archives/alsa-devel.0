From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 13/17] ASoC: tlv320aic31xx: Add overflow
	detection support
Date: Wed, 8 Nov 2017 18:27:37 -0600
Message-ID: <20171109002741.10897-14-afd@ti.com>
References: <20171109002741.10897-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 by alsa0.perex.cz (Postfix) with ESMTP id B0B45267673
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
index 34867274c102..f208362017c6 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1339,6 +1339,23 @@ static irqreturn_t aic31xx_irq(int irq, void *data)
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
 
@@ -1413,7 +1430,8 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 				   AIC31XX_GPIO1_FUNC_SHIFT);
 
 		regmap_write(aic31xx->regmap, AIC31XX_INT1CTRL,
-			     AIC31XX_SC);
+			     AIC31XX_SC |
+			     AIC31XX_ENGINE);
 
 		ret = devm_request_threaded_irq(aic31xx->dev, aic31xx->irq,
 						NULL, aic31xx_irq,
diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index 3415a96aa6c3..944a19539324 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -174,6 +174,13 @@ enum aic31xx_type {
 #define AIC31XX_HPRDRVPWRSTATUS		BIT(1)
 #define AIC31XX_SPRDRVPWRSTATUS		BIT(0)
 
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
