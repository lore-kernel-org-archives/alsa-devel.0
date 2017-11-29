From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v2 10/19] ASoC: tlv320aic31xx: Add MICBIAS off setting
Date: Wed, 29 Nov 2017 15:32:51 -0600
Message-ID: <20171129213300.20021-11-afd@ti.com>
References: <20171129213300.20021-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171129213300.20021-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

Leaving microphone bias off is a valid setting and even used in the DT
binding document example. Add this setting here and document the same.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/tlv320aic31xx.txt | 1 +
 include/dt-bindings/sound/tlv320aic31xx-micbias.h         | 1 +
 sound/soc/codecs/tlv320aic31xx.c                          | 1 +
 3 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt b/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
index 5b3c33bb99e5..411cc46a2c58 100644
--- a/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
+++ b/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
@@ -24,6 +24,7 @@ Optional properties:
 
 - reset-gpios - GPIO specification for the active low RESET input.
 - ai31xx-micbias-vg - MicBias Voltage setting
+        0 or MICBIAS_OFF - MICBIAS output is powered off
         1 or MICBIAS_2_0V - MICBIAS output is powered to 2.0V
         2 or MICBIAS_2_5V - MICBIAS output is powered to 2.5V
         3 or MICBIAS_AVDD - MICBIAS output is connected to AVDD
diff --git a/include/dt-bindings/sound/tlv320aic31xx-micbias.h b/include/dt-bindings/sound/tlv320aic31xx-micbias.h
index c6895a18a455..069484070fcf 100644
--- a/include/dt-bindings/sound/tlv320aic31xx-micbias.h
+++ b/include/dt-bindings/sound/tlv320aic31xx-micbias.h
@@ -2,6 +2,7 @@
 #ifndef __DT_TLV320AIC31XX_MICBIAS_H
 #define __DT_TLV320AIC31XX_MICBIAS_H
 
+#define MICBIAS_OFF		0
 #define MICBIAS_2_0V		1
 #define MICBIAS_2_5V		2
 #define MICBIAS_AVDDV		3
diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 0e00421d363b..252d99af6688 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1298,6 +1298,7 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 	fwnode_property_read_u32(aic31xx->dev->fwnode, "ai31xx-micbias-vg",
 				 &micbias_value);
 	switch (micbias_value) {
+	case MICBIAS_OFF:
 	case MICBIAS_2_0V:
 	case MICBIAS_2_5V:
 	case MICBIAS_AVDDV:
-- 
2.15.0
