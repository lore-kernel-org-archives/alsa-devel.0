From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v2 3/3] ASoC: tlv320aic31xx: Add button press detection
Date: Tue, 4 Sep 2018 10:36:19 -0500
Message-ID: <20180904153619.2199-3-afd@ti.com>
References: <20180904153619.2199-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180904153619.2199-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

This device can optionally detect headset or microphone button presses.
Add support for this by passing this event to the jack layer.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 17 +++++++++++++++--
 sound/soc/codecs/tlv320aic31xx.h |  3 ++-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index ccbd601c746d..102654761f25 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1380,10 +1380,21 @@ static irqreturn_t aic31xx_irq(int irq, void *data)
 		dev_err(dev, "Short circuit on Left output is detected\n");
 	if (value & AIC31XX_HPRSCDETECT)
 		dev_err(dev, "Short circuit on Right output is detected\n");
-	if (value & AIC31XX_HSPLUG) {
+	if (value & (AIC31XX_HSPLUG | AIC31XX_BUTTONPRESS)) {
 		unsigned int val;
 		int status = 0;
 
+		ret = regmap_read(aic31xx->regmap, AIC31XX_INTRDACFLAG2,
+				  &val);
+		if (ret) {
+			dev_err(dev, "Failed to read interrupt mask: %d\n",
+				ret);
+			goto exit;
+		}
+
+		if (val & AIC31XX_BUTTONPRESS)
+			status |= SND_JACK_BTN_0;
+
 		ret = regmap_read(aic31xx->regmap, AIC31XX_HSDETECT, &val);
 		if (ret) {
 			dev_err(dev, "Failed to read headset type: %d\n", ret);
@@ -1408,7 +1419,8 @@ static irqreturn_t aic31xx_irq(int irq, void *data)
 	}
 	if (value & ~(AIC31XX_HPLSCDETECT |
 		      AIC31XX_HPRSCDETECT |
-		      AIC31XX_HSPLUG))
+		      AIC31XX_HSPLUG |
+		      AIC31XX_BUTTONPRESS))
 		dev_err(dev, "Unknown DAC interrupt flags: 0x%08x\n", value);
 
 read_overflow:
@@ -1522,6 +1534,7 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 
 		regmap_write(aic31xx->regmap, AIC31XX_INT1CTRL,
 			     AIC31XX_HSPLUGDET |
+			     AIC31XX_BUTTONPRESSDET |
 			     AIC31XX_SC |
 			     AIC31XX_ENGINE);
 
diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index 9985ceed97ae..cb024955c978 100644
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
2.18.0
