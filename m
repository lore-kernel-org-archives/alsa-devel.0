From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH V2 2/2] ASoC: WM8962: Add device tree binding
Date: Thu, 6 Jun 2013 19:38:46 +0800
Message-ID: <a7acc6e603272a9d48324712f54da9bb1fa46889.1370518627.git.b42378@freescale.com>
References: <cover.1370518627.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C5197261AB4
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 13:32:21 +0200 (CEST)
In-Reply-To: <cover.1370518627.git.b42378@freescale.com>
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
 Documentation/devicetree/bindings/sound/wm8962.txt |   20 +++++++++++
 sound/soc/codecs/wm8962.c                          |   35 +++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/wm8962.txt b/Documentation/devicetree/bindings/sound/wm8962.txt
index dceb3b1..855d723 100644
--- a/Documentation/devicetree/bindings/sound/wm8962.txt
+++ b/Documentation/devicetree/bindings/sound/wm8962.txt
@@ -8,9 +8,29 @@ Required properties:
 
   - reg : the I2C address of the device.
 
+Optional properties:
+  - spk-mono: Default register value for SPK_MONO of R51 (Class D Control 2).
+
+  - mic-cfg : Default register value for R48 (Additional Control 4).
+    If absent, the default is 0.
+
+  - gpio-cfg : A list of GPIO configuration register values. The list must
+    be 6 entries long. If absent, no configuration of these registers is
+    performed. And note that only the value within [0x0, 0xffff] is valid.
+    Any other value will be regarded as setting the GPIO register by its
+    default value 0x0.
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
