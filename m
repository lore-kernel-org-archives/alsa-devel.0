From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v3 10/10] ASoC: tlv320aic31xx: Add button press detection
Date: Thu, 7 Dec 2017 09:39:00 -0600
Message-ID: <20171207153900.9831-11-afd@ti.com>
References: <20171207153900.9831-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171207153900.9831-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

This device can optionally detect headset or microphone button presses.
Add support for this by passing this event to the jack layer.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 14 +++++++++++++-
 sound/soc/codecs/tlv320aic31xx.h |  3 ++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index fef402e0f9e8..8f5dec414628 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1290,9 +1290,20 @@ static irqreturn_t aic31xx_irq(int irq, void *data)
 	if (value & AIC31XX_HPRSCDETECT)
 		dev_err(dev, "Short circuit on Right output is detected\n");
 
-	if (value & AIC31XX_HSPLUG) {
+	if (value & (AIC31XX_HSPLUG | AIC31XX_BUTTONPRESS)) {
 		int status = 0;
 
+		ret = regmap_read(aic31xx->regmap, AIC31XX_INTRDACFLAG2,
+				  &value);
+		if (ret) {
+			dev_err(dev, "Failed to read interrupt mask: %d\n",
+				ret);
+			return IRQ_NONE;
+		}
+
+		if (value & AIC31XX_BUTTONPRESS)
+			status |= SND_JACK_BTN_0;
+
 		ret = regmap_read(aic31xx->regmap, AIC31XX_HSDETECT, &value);
 		if (ret) {
 			dev_err(dev, "Failed to read headset type: %d\n", ret);
@@ -1405,6 +1416,7 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 
 		regmap_write(aic31xx->regmap, AIC31XX_INT1CTRL,
 			     AIC31XX_HSPLUGDET |
+			     AIC31XX_BUTTONPRESSDET |
 			     AIC31XX_SC |
 			     AIC31XX_ENGINE);
 
diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index 66c85df4d5be..7fce278eadac 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -21,7 +21,8 @@
 #define DAC31XX_BIT			BIT(3)
 
 #define AIC31XX_JACK_MASK (SND_JACK_HEADPHONE | \
-			   SND_JACK_HEADSET)
+			   SND_JACK_HEADSET | \
+			   SND_JACK_BTN_0)
 
 enum aic31xx_type {
 	AIC3100	= 0,
-- 
2.15.0
