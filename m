From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: [PATCH V2 6/6] ASoC: tlv320aic3x: Add device tree
	bindings
Date: Mon, 27 Aug 2012 18:56:44 +0530
Message-ID: <1346074004-22172-7-git-send-email-gururaja.hebbar@ti.com>
References: <1346074004-22172-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 52CAD265E49
 for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2012 15:43:43 +0200 (CEST)
In-Reply-To: <1346074004-22172-1-git-send-email-gururaja.hebbar@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tony@atomide.com, lrg@ti.com, broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, sudhakar.raj@ti.com, nsekhar@ti.com, davinci-linux-open-source@linux.davincidsp.com, gururaja.hebbar@ti.com, alsa-user@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Device tree support for tlv320aic3x CODEC driver.

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
---
Changes from V1:
	- use standard DT GPIO reference by phandle to populate gpio based DT
	  parameters

:000000 100644 0000000... e7b98f4... A	Documentation/devicetree/bindings/sound/tlv320aic3x.txt
:100644 100644 01485bd... 5708a97... M	sound/soc/codecs/tlv320aic3x.c
 .../devicetree/bindings/sound/tlv320aic3x.txt      |   20 +++++++++++++
 sound/soc/codecs/tlv320aic3x.c                     |   31 ++++++++++++++++++++
 2 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic3x.txt b/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
new file mode 100644
index 0000000..e7b98f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
@@ -0,0 +1,20 @@
+Texas Instruments - tlv320aic3x Codec module
+
+The tlv320aic3x serial control bus communicates through I2C protocols
+
+Required properties:
+- compatible - "string" -  "ti,tlv320aic3x"
+- reg - <int> -  I2C slave address
+
+
+Optional properties:
+
+- gpio-reset - gpio pin number used for codec reset
+- ai3x-gpio-func - <array of 2 int> - AIC3X_GPIO1 & AIC3X_GPIO2 Functionality
+
+Example:
+
+tlv320aic3x: tlv320aic3x@1b {
+	compatible = "ti,tlv320aic3x";
+	reg = <0x1b>;
+};
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 01485bd..5708a97 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -40,6 +40,7 @@
 #include <linux/i2c.h>
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
+#include <linux/of_gpio.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -1457,6 +1458,8 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 {
 	struct aic3x_pdata *pdata = i2c->dev.platform_data;
 	struct aic3x_priv *aic3x;
+	struct aic3x_setup_data *ai3x_setup;
+	struct device_node *np = i2c->dev.of_node;
 	int ret;
 
 	aic3x = devm_kzalloc(&i2c->dev, sizeof(struct aic3x_priv), GFP_KERNEL);
@@ -1471,6 +1474,25 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 	if (pdata) {
 		aic3x->gpio_reset = pdata->gpio_reset;
 		aic3x->setup = pdata->setup;
+	} else if (np) {
+		ai3x_setup = devm_kzalloc(&i2c->dev, sizeof(*ai3x_setup),
+								GFP_KERNEL);
+		if (ai3x_setup == NULL) {
+			dev_err(&i2c->dev, "failed to create private data\n");
+			return -ENOMEM;
+		}
+
+		ret = of_get_named_gpio(np, "gpio-reset", 0);
+		if (ret >= 0)
+			aic3x->gpio_reset = ret;
+		else
+			aic3x->gpio_reset = -1;
+
+		if (of_property_read_u32_array(np, "ai3x-gpio-func",
+					ai3x_setup->gpio_func, 2) >= 0) {
+			aic3x->setup = ai3x_setup;
+		}
+
 	} else {
 		aic3x->gpio_reset = -1;
 	}
@@ -1488,11 +1510,20 @@ static int aic3x_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
+#if defined(CONFIG_OF)
+static const struct of_device_id tlv320aic3x_of_match[] = {
+	{ .compatible = "ti,tlv320aic3x", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, tlv320aic3x_of_match);
+#endif
+
 /* machine i2c codec control layer */
 static struct i2c_driver aic3x_i2c_driver = {
 	.driver = {
 		.name = "tlv320aic3x-codec",
 		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(tlv320aic3x_of_match),
 	},
 	.probe	= aic3x_i2c_probe,
 	.remove = aic3x_i2c_remove,
-- 
1.7.1
