From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] ASoC: wm8903: add regulator handling
Date: Mon, 20 Mar 2017 10:13:52 +0100
Message-ID: <20170320091352.4115-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f47.google.com (mail-lf0-f47.google.com
 [209.85.215.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A117266CC6
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 10:13:58 +0100 (CET)
Received: by mail-lf0-f47.google.com with SMTP id z15so52730897lfd.1
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 02:13:58 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The WM8903 has four different voltage inputs: AVDD, CPVDD, DBVDD
and DCVDD. On the Qualcomm APQ8060 Dragonboard these are all
supplied from proper regulators and thus need activating and
binding.

This is a quick-and-dirty solution just grabbing and enabling the
regulator supplies on probe() and disabling them on remove() and
the errorpath. More elaborate power management is likely possible.

I assume the nVidia designs using this codec have some hard-wired
always-on power and will be happy with using the dummy regulators
for this. But someone from the nVidia camp should probably check
whether they can bind these to proper regulators instead.

We also amend the DT binding document. A small change like this
does not warrant a separate patch for augmenting these.

Cc: devicetree@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Mark: I was thinking about adding runtime PM for disabling
these regulators when unused, but I'm uncertain about the
interaction with DAPM in that regard. This atleast gives us
control over the supplies.
---
 Documentation/devicetree/bindings/sound/wm8903.txt | 13 +++++++++
 sound/soc/codecs/wm8903.c                          | 31 ++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/wm8903.txt b/Documentation/devicetree/bindings/sound/wm8903.txt
index 94ec32c194bb..afc51caf1137 100644
--- a/Documentation/devicetree/bindings/sound/wm8903.txt
+++ b/Documentation/devicetree/bindings/sound/wm8903.txt
@@ -28,6 +28,14 @@ Optional properties:
     performed. If any entry has the value 0xffffffff, that GPIO's
     configuration will not be modified.
 
+  - AVDD-supply : Analog power supply regulator on the AVDD pin.
+
+  - CPVDD-supply : Charge pump supply regulator on the CPVDD pin.
+
+  - DBVDD-supply : Digital buffer supply regulator for the DBVDD pin.
+
+  - DCVDD-supply : Digital core supply regulator for the DCVDD pin.
+
 Pins on the device (for linking into audio routes):
 
   * IN1L
@@ -54,6 +62,11 @@ codec: wm8903@1a {
 	reg = <0x1a>;
 	interrupts = < 347 >;
 
+	AVDD-supply = <&fooreg_a>;
+	CPVDD-supply = <&fooreg_b>;
+	DBVDD-supply = <&fooreg_c>;
+	DCVDC-supply = <&fooreg_d>;
+
 	gpio-controller;
 	#gpio-cells = <2>;
 
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 6e887c2c42b1..237eeb9a8b97 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -24,6 +24,7 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/irq.h>
 #include <linux/mutex.h>
@@ -115,10 +116,19 @@ static const struct reg_default wm8903_reg_defaults[] = {
 	{ 172, 0x0000 },    /* R172 - Analogue Output Bias 0 */
 };
 
+#define WM8903_NUM_SUPPLIES 4
+static const char *wm8903_supply_names[WM8903_NUM_SUPPLIES] = {
+	"AVDD",
+	"CPVDD",
+	"DBVDD",
+	"DCVDD",
+};
+
 struct wm8903_priv {
 	struct wm8903_platform_data *pdata;
 	struct device *dev;
 	struct regmap *regmap;
+	struct regulator_bulk_data supplies[WM8903_NUM_SUPPLIES];
 
 	int sysclk;
 	int irq;
@@ -2030,6 +2040,23 @@ static int wm8903_i2c_probe(struct i2c_client *i2c,
 
 	pdata = wm8903->pdata;
 
+	for (i = 0; i < ARRAY_SIZE(wm8903->supplies); i++)
+		wm8903->supplies[i].supply = wm8903_supply_names[i];
+
+	ret = devm_regulator_bulk_get(&i2c->dev, ARRAY_SIZE(wm8903->supplies),
+				      wm8903->supplies);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(wm8903->supplies),
+				    wm8903->supplies);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to enable supplies: %d\n", ret);
+		return ret;
+	}
+
 	ret = regmap_read(wm8903->regmap, WM8903_SW_RESET_AND_ID, &val);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to read chip ID: %d\n", ret);
@@ -2160,6 +2187,8 @@ static int wm8903_i2c_probe(struct i2c_client *i2c,
 
 	return 0;
 err:
+	regulator_bulk_disable(ARRAY_SIZE(wm8903->supplies),
+			       wm8903->supplies);
 	return ret;
 }
 
@@ -2167,6 +2196,8 @@ static int wm8903_i2c_remove(struct i2c_client *client)
 {
 	struct wm8903_priv *wm8903 = i2c_get_clientdata(client);
 
+	regulator_bulk_disable(ARRAY_SIZE(wm8903->supplies),
+			       wm8903->supplies);
 	if (client->irq)
 		free_irq(client->irq, wm8903);
 	wm8903_free_gpio(wm8903);
-- 
2.9.3
