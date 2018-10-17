From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH] ASoC: sta32x: Add support for XTI clock
Date: Wed, 17 Oct 2018 13:37:03 +0200
Message-ID: <20181017113703.23737-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id A55052675AB
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2018 13:37:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

The STA32x chips feature an XTI clock input that needs to be stable before
the reset signal is released. Therefore, the chip driver needs to get a
handle to the clock. Instead of relying on other parts of the system to
enable the clock, let the codec driver grab a handle itself.

In order to keep existing boards working, clock support is made optional.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 .../devicetree/bindings/sound/st,sta32x.txt   |  6 +++++
 sound/soc/codecs/sta32x.c                     | 25 +++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/st,sta32x.txt b/Documentation/devicetree/bindings/sound/st,sta32x.txt
index ff4a685a4303..52265fb757c5 100644
--- a/Documentation/devicetree/bindings/sound/st,sta32x.txt
+++ b/Documentation/devicetree/bindings/sound/st,sta32x.txt
@@ -19,6 +19,10 @@ Required properties:
 
 Optional properties:
 
+  - clocks, clock-names: Clock specifier for XTI input clock.
+	If specified, the clock will be enabled when the codec is probed,
+	and disabled when it is removed. The 'clock-names' must be set to 'xti'.
+
   -  st,output-conf: number, Selects the output configuration:
 	0: 2-channel (full-bridge) power, 2-channel data-out
 	1: 2 (half-bridge). 1 (full-bridge) on-board power
@@ -79,6 +83,8 @@ Example:
 codec: sta32x@38 {
 	compatible = "st,sta32x";
 	reg = <0x1c>;
+	clocks = <&clock>;
+	clock-names = "xti";
 	reset-gpios = <&gpio1 19 0>;
 	power-down-gpios = <&gpio1 16 0>;
 	st,output-conf = /bits/ 8  <0x3>;	// set output to 2-channel
diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index a878c8d92e68..f753d2db0a5a 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
@@ -142,6 +143,7 @@ static const char *sta32x_supply_names[] = {
 /* codec private data */
 struct sta32x_priv {
 	struct regmap *regmap;
+	struct clk *xti_clk;
 	struct regulator_bulk_data supplies[ARRAY_SIZE(sta32x_supply_names)];
 	struct snd_soc_component *component;
 	struct sta32x_platform_data *pdata;
@@ -882,6 +884,15 @@ static int sta32x_probe(struct snd_soc_component *component)
 
 	sta32x->component = component;
 
+	if (sta32x->xti_clk) {
+		ret = clk_prepare_enable(sta32x->xti_clk);
+		if (ret != 0) {
+			dev_err(component->dev,
+				"Failed to enable clock: %d\n", ret);
+			return ret;
+		}
+	}
+
 	ret = regulator_bulk_enable(ARRAY_SIZE(sta32x->supplies),
 				    sta32x->supplies);
 	if (ret != 0) {
@@ -984,6 +995,9 @@ static void sta32x_remove(struct snd_soc_component *component)
 
 	sta32x_watchdog_stop(sta32x);
 	regulator_bulk_disable(ARRAY_SIZE(sta32x->supplies), sta32x->supplies);
+
+	if (sta32x->xti_clk)
+		clk_disable_unprepare(sta32x->xti_clk);
 }
 
 static const struct snd_soc_component_driver sta32x_component = {
@@ -1100,6 +1114,17 @@ static int sta32x_i2c_probe(struct i2c_client *i2c,
 	}
 #endif
 
+	/* Clock */
+	sta32x->xti_clk = devm_clk_get(dev, "xti");
+	if (IS_ERR(sta32x->xti_clk)) {
+		ret = PTR_ERR(sta32x->xti_clk);
+
+		if (ret == -EPROBE_DEFER)
+			return ret;
+
+		sta32x->xti_clk = NULL;
+	}
+
 	/* GPIOs */
 	sta32x->gpiod_nreset = devm_gpiod_get_optional(dev, "reset",
 						       GPIOD_OUT_LOW);
-- 
2.17.2
