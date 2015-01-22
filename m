From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH] ASoC: ts3a227e: Add dts property that allows
	to specify micbias voltage
Date: Thu, 22 Jan 2015 15:47:24 -0800
Message-ID: <1421970444-15939-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f74.google.com (mail-qa0-f74.google.com
 [209.85.216.74])
 by alsa0.perex.cz (Postfix) with ESMTP id 464B026530D
 for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2015 00:47:35 +0100 (CET)
Received: by mail-qa0-f74.google.com with SMTP id x12so321768qac.1
 for <alsa-devel@alsa-project.org>; Thu, 22 Jan 2015 15:47:34 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, dgreid@chromium.org
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

The voltage controls key press threshold.

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 .../devicetree/bindings/sound/ts3a227e.txt         |  5 ++++
 sound/soc/codecs/ts3a227e.c                        | 27 ++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/ts3a227e.txt b/Documentation/devicetree/bindings/sound/ts3a227e.txt
index e8bf23e..a836881 100644
--- a/Documentation/devicetree/bindings/sound/ts3a227e.txt
+++ b/Documentation/devicetree/bindings/sound/ts3a227e.txt
@@ -13,6 +13,11 @@ Required properties:
  - interrupt-parent:	The parent interrupt controller
  - interrupts:		Interrupt number for /INT pin from the 227e
 
+Optional properies:
+ - ti,micbias:   Intended MICBIAS voltage (datasheet section 9.6.7).
+      Select 0/1/2/3/4/5/6/7 to specify MACBIAS voltage
+      2.1V/2.2V/2.3V/2.4V/2.5V/2.6V/2.7V/2.8V
+      Default value is "1" (2.2V).
 
 Examples:
 
diff --git a/sound/soc/codecs/ts3a227e.c b/sound/soc/codecs/ts3a227e.c
index 54d431c..5ecfa31 100644
--- a/sound/soc/codecs/ts3a227e.c
+++ b/sound/soc/codecs/ts3a227e.c
@@ -79,6 +79,10 @@ static const int ts3a227e_buttons[] = {
 /* TS3A227E_REG_SETTING_2 0x05 */
 #define KP_ENABLE 0x04
 
+/* TS3A227E_REG_SETTING_3 0x06 */
+#define MICBIAS_SETTING_SFT (3)
+#define MICBIAS_SETTING_MASK (0x7 << MICBIAS_SETTING_SFT)
+
 /* TS3A227E_REG_ACCESSORY_STATUS  0x0b */
 #define TYPE_3_POLE 0x01
 #define TYPE_4_POLE_OMTP 0x02
@@ -248,6 +252,21 @@ static const struct regmap_config ts3a227e_regmap_config = {
 	.num_reg_defaults = ARRAY_SIZE(ts3a227e_reg_defaults),
 };
 
+static int ts3a227e_parse_dt(struct ts3a227e *ts3a227e, struct device_node *np)
+{
+	u32 micbias;
+	int err;
+
+	err = of_property_read_u32(np, "ti,micbias", &micbias);
+	if (!err) {
+		regmap_update_bits(ts3a227e->regmap, TS3A227E_REG_SETTING_3,
+			MICBIAS_SETTING_MASK,
+			(micbias & 0x07) << MICBIAS_SETTING_SFT);
+	}
+
+	return 0;
+}
+
 static int ts3a227e_i2c_probe(struct i2c_client *i2c,
 			      const struct i2c_device_id *id)
 {
@@ -266,6 +285,14 @@ static int ts3a227e_i2c_probe(struct i2c_client *i2c,
 	if (IS_ERR(ts3a227e->regmap))
 		return PTR_ERR(ts3a227e->regmap);
 
+	if (dev->of_node) {
+		ret = ts3a227e_parse_dt(ts3a227e, dev->of_node);
+		if (ret) {
+			dev_err(dev, "Failed to parse device tree: %d\n", ret);
+			return ret;
+		}
+	}
+
 	ret = devm_request_threaded_irq(dev, i2c->irq, NULL, ts3a227e_interrupt,
 					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 					"TS3A227E", ts3a227e);
-- 
2.2.0.rc0.207.ga3a616c
