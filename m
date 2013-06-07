From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH V3] ASoC: WM8962: Add device tree binding
Date: Fri, 7 Jun 2013 11:23:27 +0800
Message-ID: <1370575407-17712-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 by alsa0.perex.cz (Postfix) with ESMTP id E705F2655B8
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2013 05:16:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org
Cc: grant.likely@linaro.org, broonie@kernel.org, lgirdwood@gmail.com, rob.herring@calxeda.com
List-Id: alsa-devel@alsa-project.org

Document the device tree binding for the WM8962 codec, and modify the
driver to extract platform data from the device tree, if present.

Based on work of WM8903 by Stephen Warren <swarren@nvidia.com>

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
ChangeLog:
v1->v2:
 * Dropped out-of-band value error msg by regarding it as default value.
v2->v3:
 * Revised binding doc to warn users if property absent then use default value.

 Documentation/devicetree/bindings/sound/wm8962.txt |   23 +++++++++++++
 sound/soc/codecs/wm8962.c                          |   35 +++++++++++++++++++-
 2 files changed, 57 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/wm8962.txt b/Documentation/devicetree/bindings/sound/wm8962.txt
index dceb3b1..7f82b59 100644
--- a/Documentation/devicetree/bindings/sound/wm8962.txt
+++ b/Documentation/devicetree/bindings/sound/wm8962.txt
@@ -8,9 +8,32 @@ Required properties:
 
   - reg : the I2C address of the device.
 
+Optional properties:
+  - spk-mono: This is a boolean property. If present, the SPK_MONO bit
+    of R51 (Class D Control 2) gets set, indicating that the speaker is
+    in mono mode.
+
+  - mic-cfg : Default register value for R48 (Additional Control 4).
+    If absent, the default should be the register default.
+
+  - gpio-cfg : A list of GPIO configuration register values. The list must
+    be 6 entries long. If absent, no configuration of these registers is
+    performed. And note that only the value within [0x0, 0xffff] is valid.
+    Any other value is regarded as setting the GPIO register by its reset
+    value 0x0.
+
 Example:
 
 codec: wm8962@1a {
 	compatible = "wlf,wm8962";
 	reg = <0x1a>;
+
+	gpio-cfg = <
+		0x0000 /* 0:Default */
+		0x0000 /* 1:Default */
+		0x0013 /* 2:FN_DMICCLK */
+		0x0000 /* 3:Default */
+		0x8014 /* 4:FN_DMICCDAT */
+		0x0000 /* 5:Default */
+	>;
 };
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index d56dd86..26219ea 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3584,6 +3584,34 @@ static const struct regmap_config wm8962_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
+static int wm8962_set_pdata_from_of(struct i2c_client *i2c,
+				    struct wm8962_pdata *pdata)
+{
+	const struct device_node *np = i2c->dev.of_node;
+	u32 val32;
+	int i;
+
+	if (of_property_read_bool(np, "spk-mono"))
+		pdata->spk_mono = true;
+
+	if (of_property_read_u32(np, "mic-cfg", &val32) >= 0)
+		pdata->mic_cfg = val32;
+
+	if (of_property_read_u32_array(np, "gpio-cfg", pdata->gpio_init,
+				       ARRAY_SIZE(pdata->gpio_init)) >= 0)
+		for (i = 0; i < ARRAY_SIZE(pdata->gpio_init); i++) {
+			/*
+			 * The range of GPIO register value is [0x0, 0xffff]
+			 * While the default value of each register is 0x0
+			 * Any other value will be regarded as default value
+			 */
+			if (pdata->gpio_init[i] > 0xffff)
+				pdata->gpio_init[i] = 0x0;
+		}
+
+	return 0;
+}
+
 static int wm8962_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
@@ -3604,8 +3632,13 @@ static int wm8962_i2c_probe(struct i2c_client *i2c,
 	wm8962->irq = i2c->irq;
 
 	/* If platform data was supplied, update the default data in priv */
-	if (pdata)
+	if (pdata) {
 		memcpy(&wm8962->pdata, pdata, sizeof(struct wm8962_pdata));
+	} else if (i2c->dev.of_node) {
+		ret = wm8962_set_pdata_from_of(i2c, &wm8962->pdata);
+		if (ret != 0)
+			return ret;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(wm8962->supplies); i++)
 		wm8962->supplies[i].supply = wm8962_supply_names[i];
-- 
1.7.1
