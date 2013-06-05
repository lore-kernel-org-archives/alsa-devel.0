From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH 2/2] ASoC: WM8962: Add device tree binding
Date: Wed, 5 Jun 2013 20:12:56 +0800
Message-ID: <1c716a6860c9486071c11a7f7752d14b217f4ef1.1370433363.git.b42378@freescale.com>
References: <cover.1370433363.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 9554E265453
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 14:06:36 +0200 (CEST)
In-Reply-To: <cover.1370433363.git.b42378@freescale.com>
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
 Documentation/devicetree/bindings/sound/wm8962.txt |   20 ++++++++++++
 sound/soc/codecs/wm8962.c                          |   33 ++++++++++++++++++++
 2 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/wm8962.txt b/Documentation/devicetree/bindings/sound/wm8962.txt
index dceb3b1..ef89a2c 100644
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
+    performed. And note that the max value for each entry is 0xffff, don't
+    fill a large one.
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
index ea35396..4540b0d 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3586,6 +3586,33 @@ static const struct regmap_config wm8962_regmap = {
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
+				       ARRAY_SIZE(pdata->gpio_init)) >= 0) {
+		for (i = 0; i < ARRAY_SIZE(pdata->gpio_init); i++) {
+			if (pdata->gpio_init[i] > 0xffff) {
+				dev_err(&i2c->dev, "Invalid gpio-cfg[%d] %x\n",
+					i, pdata->gpio_init[i]);
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int wm8962_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
@@ -3616,6 +3643,12 @@ static int wm8962_i2c_probe(struct i2c_client *i2c,
 			dev_err(&i2c->dev, "Failed to allocate pdata\n");
 			return -ENOMEM;
 		}
+
+		if (i2c->dev.of_node) {
+			ret = wm8962_set_pdata_from_of(i2c, wm8962->pdata);
+			if (ret != 0)
+				return ret;
+		}
 	}
 
 	for (i = 0; i < ARRAY_SIZE(wm8962->supplies); i++)
-- 
1.7.1
