From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 15/17] ASoC: tlv320aic31xx: Add button press
	detection
Date: Wed, 8 Nov 2017 18:27:39 -0600
Message-ID: <20171109002741.10897-16-afd@ti.com>
References: <20171109002741.10897-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 by alsa0.perex.cz (Postfix) with ESMTP id 47EAD26767D
 for <alsa-devel@alsa-project.org>; Thu,  9 Nov 2017 01:27:47 +0100 (CET)
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

This device can optionally detect headset or microphone button presses.
Add support for this by passing this event to the jack layer.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 14 +++++++++++++-
 sound/soc/codecs/tlv320aic31xx.h |  3 ++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 7a27361d9d27..46cd132e93ef 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1342,9 +1342,20 @@ static irqreturn_t aic31xx_irq(int irq, void *data)
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
@@ -1460,6 +1471,7 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 
 		regmap_write(aic31xx->regmap, AIC31XX_INT1CTRL,
 			     AIC31XX_HSPLUGDET |
+			     AIC31XX_BUTTONPRESSDET |
 			     AIC31XX_SC |
 			     AIC31XX_ENGINE);
 
diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index eca0a99209d8..0cc8dedf5f35 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -28,7 +28,8 @@
 #define DAC31XX_BIT			BIT(3)
 
 #define AIC31XX_JACK_MASK (SND_JACK_HEADPHONE | \
-			   SND_JACK_HEADSET)
+			   SND_JACK_HEADSET | \
+			   SND_JACK_BTN_0)
 
 enum aic31xx_type {
 	AIC3100	= 0,
-- 
2.15.0
