From: Ben Zhang <benzh@chromium.org>
Subject: [PATCH 1/2] ASoC: rt5677: Add ACPI device probing
Date: Fri, 14 Nov 2014 22:56:47 -0800
Message-ID: <1416034608-24238-1-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f73.google.com (mail-oi0-f73.google.com
 [209.85.218.73])
 by alsa0.perex.cz (Postfix) with ESMTP id E0FDC260589
 for <alsa-devel@alsa-project.org>; Sat, 15 Nov 2014 07:57:09 +0100 (CET)
Received: by mail-oi0-f73.google.com with SMTP id a141so392626oig.2
 for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2014 22:57:08 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Ben Zhang <benzh@chromium.org>, Mark Brown <broonie@kernel.org>, Anatol Pomozov <anatol@google.com>, Bard Liao <bardliao@realtek.com>, Dylan Reid <dgreid@chromium.org>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The rt5677 codec driver looks for ACPI device ID "RT5677CE",
which is specified in coreboot. This patch allows platform
data to be obtained via ACPI

Signed-off-by: Ben Zhang <benzh@chromium.org>
---
 sound/soc/codecs/rt5677.c | 52 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 5d317c68..384281d 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -20,6 +20,7 @@
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
+#include <linux/acpi.h>
 #include <linux/firmware.h>
 #include <linux/gpio.h>
 #include <sound/core.h>
@@ -4525,6 +4526,43 @@ static int rt5677_parse_dt(struct rt5677_priv *rt5677, struct device_node *np)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+
+static unsigned long long rt5677_parse_acpi_entry(struct device *dev,
+		acpi_string name)
+{
+	acpi_handle handle = ACPI_HANDLE(dev);
+	unsigned long long val;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(handle, name, NULL, &val);
+	if (ACPI_FAILURE(status)) {
+		dev_err(dev, "Failed to parse ACPI entry %s, default to 0: %d\n",
+				name, status);
+		return 0;
+	}
+	return val;
+}
+
+static void rt5677_parse_acpi(struct rt5677_priv *rt5677, struct device *dev)
+{
+	rt5677->pdata.dmic2_clk_pin = (enum rt5677_dmic2_clk)
+		rt5677_parse_acpi_entry(dev, "DCLK");
+	rt5677->pdata.in1_diff = (bool)rt5677_parse_acpi_entry(dev, "IN1");
+	rt5677->pdata.in2_diff = (bool)rt5677_parse_acpi_entry(dev, "IN2");
+	rt5677->pdata.lout1_diff = (bool)rt5677_parse_acpi_entry(dev, "OUT1");
+	rt5677->pdata.lout2_diff = (bool)rt5677_parse_acpi_entry(dev, "OUT2");
+	rt5677->pdata.lout3_diff = (bool)rt5677_parse_acpi_entry(dev, "OUT3");
+	rt5677->pdata.jd1_gpio = rt5677_parse_acpi_entry(dev, "JD1");
+	rt5677->pdata.jd2_gpio = rt5677_parse_acpi_entry(dev, "JD2");
+	rt5677->pdata.jd3_gpio = rt5677_parse_acpi_entry(dev, "JD3");
+}
+#else
+static void rt5677_parse_acpi(struct rt5677_priv *rt5677, struct device *dev)
+{
+}
+#endif
+
 static struct regmap_irq rt5677_irqs[] = {
 	[RT5677_IRQ_JD1] = {
 		.reg_offset = 0,
@@ -4604,6 +4642,7 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
 	if (pdata)
 		rt5677->pdata = *pdata;
 
+	rt5677->pow_ldo2 = -EINVAL;
 	if (i2c->dev.of_node) {
 		ret = rt5677_parse_dt(rt5677, i2c->dev.of_node);
 		if (ret) {
@@ -4611,8 +4650,8 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
 				ret);
 			return ret;
 		}
-	} else {
-		rt5677->pow_ldo2 = -EINVAL;
+	} else if (ACPI_HANDLE(&i2c->dev)) {
+		rt5677_parse_acpi(rt5677, &i2c->dev);
 	}
 
 	if (gpio_is_valid(rt5677->pow_ldo2)) {
@@ -4708,10 +4747,19 @@ static int rt5677_i2c_remove(struct i2c_client *i2c)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id rt5677_acpi_id[] = {
+	{ "RT5677CE", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, rt5677_acpi_id);
+#endif
+
 static struct i2c_driver rt5677_i2c_driver = {
 	.driver = {
 		.name = "rt5677",
 		.owner = THIS_MODULE,
+		.acpi_match_table = ACPI_PTR(rt5677_acpi_id),
 	},
 	.probe = rt5677_i2c_probe,
 	.remove   = rt5677_i2c_remove,
-- 
2.1.0.rc2.206.gedb03e5
