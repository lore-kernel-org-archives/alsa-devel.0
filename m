From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5651: add ACPI and OF support
Date: Wed, 23 Dec 2015 18:24:09 +0800
Message-ID: <1450866249-15462-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A77326581E
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 11:24:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, john.lin@realtek.com, pierre-louis.bossart@linux.intel.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Add required tables and the binding document for ACPI and OF matching.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 Documentation/devicetree/bindings/sound/rt5651.txt | 41 ++++++++++++++++++++++
 sound/soc/codecs/rt5651.c                          | 31 ++++++++++++++++
 2 files changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rt5651.txt

diff --git a/Documentation/devicetree/bindings/sound/rt5651.txt b/Documentation/devicetree/bindings/sound/rt5651.txt
new file mode 100644
index 0000000..3875233
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rt5651.txt
@@ -0,0 +1,41 @@
+RT5651 audio CODEC
+
+This device supports I2C only.
+
+Required properties:
+
+- compatible : "realtek,rt5651".
+
+- reg : The I2C address of the device.
+
+Optional properties:
+
+- realtek,in2-differential
+  Boolean. Indicate MIC2 input are differential, rather than single-ended.
+
+- realtek,dmic-en
+  Boolean. true if dmic is used.
+
+Pins on the device (for linking into audio routes) for RT5651:
+
+  * DMIC L1
+  * DMIC R1
+  * IN1P
+  * IN2P
+  * IN2N
+  * IN3P
+  * HPOL
+  * HPOR
+  * LOUTL
+  * LOUTR
+  * PDML
+  * PDMR
+
+Example:
+
+codec: rt5651@1a {
+	compatible = "realtek,rt5651";
+	reg = <0x1a>;
+	realtek,dmic-en = "true";
+	realtek,in2-diff = "false";
+};
diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 1d40318..7a61970 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -18,6 +18,7 @@
 #include <linux/regmap.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
+#include <linux/acpi.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -1735,12 +1736,38 @@ static const struct regmap_config rt5651_regmap = {
 	.num_ranges = ARRAY_SIZE(rt5651_ranges),
 };
 
+#if defined(CONFIG_OF)
+static const struct of_device_id rt5651_of_match[] = {
+	{ .compatible = "realtek,rt5651", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rt5651_of_match);
+#endif
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id rt5651_acpi_match[] = {
+	{ "10EC5651", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, rt5651_acpi_match);
+#endif
+
 static const struct i2c_device_id rt5651_i2c_id[] = {
 	{ "rt5651", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rt5651_i2c_id);
 
+static int rt5651_parse_dt(struct rt5651_priv *rt5651, struct device_node *np)
+{
+	rt5651->pdata.in2_diff = of_property_read_bool(np,
+		"realtek,in2-differential");
+	rt5651->pdata.dmic_en = of_property_read_bool(np,
+		"realtek,dmic-en");
+
+	return 0;
+}
+
 static int rt5651_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
@@ -1757,6 +1784,8 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 
 	if (pdata)
 		rt5651->pdata = *pdata;
+	else if (i2c->dev.of_node)
+		rt5651_parse_dt(rt5651, i2c->dev.of_node);
 
 	rt5651->regmap = devm_regmap_init_i2c(i2c, &rt5651_regmap);
 	if (IS_ERR(rt5651->regmap)) {
@@ -1806,6 +1835,8 @@ static int rt5651_i2c_remove(struct i2c_client *i2c)
 static struct i2c_driver rt5651_i2c_driver = {
 	.driver = {
 		.name = "rt5651",
+		.acpi_match_table = ACPI_PTR(rt5651_acpi_match),
+		.of_match_table = of_match_ptr(rt5651_of_match),
 	},
 	.probe = rt5651_i2c_probe,
 	.remove   = rt5651_i2c_remove,
-- 
1.8.1.1.439.g50a6b54
