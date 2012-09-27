From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ALSA: ASoC: add DT bindings for CS4271
Date: Fri, 28 Sep 2012 01:36:44 +0200
Message-ID: <1348789004-19944-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 320F026036B
 for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2012 01:36:55 +0200 (CEST)
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
Cc: devicetree-discuss@lists.ozlabs.org, broonie@opensource.wolfsonmicro.com, Alexander Sverdlin <subaparts@yandex.ru>, lrg@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Apart from pure matching, the bindings also support setting the the
reset gpio line.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Alexander Sverdlin <subaparts@yandex.ru>
---
 Documentation/devicetree/bindings/sound/cs4271.txt | 36 ++++++++++++++++++++++
 sound/soc/codecs/cs4271.c                          | 24 +++++++++++++--
 2 files changed, 57 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/cs4271.txt

diff --git a/Documentation/devicetree/bindings/sound/cs4271.txt b/Documentation/devicetree/bindings/sound/cs4271.txt
new file mode 100644
index 0000000..c81b5fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cs4271.txt
@@ -0,0 +1,36 @@
+Cirrus Logic CS4271 DT bindings
+
+This driver supports both the I2C and the SPI bus.
+
+Required properties:
+
+ - compatible: "cirrus,cs4271"
+
+For required properties on SPI, please consult
+Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Required properties on I2C:
+
+ - reg: the i2c address
+
+
+Optional properties:
+
+ - reset-gpio: 	a GPIO spec to define which pin is connected to the chip's
+		!RESET pin
+
+Examples:
+
+	codec_i2c: cs4271@10 {
+		compatible = "cirrus,cs4271";
+		reg = <0x10>;
+		reset-gpio = <&gpio 23 0>;
+	};
+
+	codec_spi: cs4271@0 {
+		compatible = "cirrus,cs4271";
+		reg = <0x0>;
+		reset-gpio = <&gpio 23 0>;
+		spi-max-frequency = <6000000>;
+	};
+
diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 9eb01d7..f994af3 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -22,12 +22,14 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
-#include <sound/pcm.h>
-#include <sound/soc.h>
-#include <sound/tlv.h>
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/spi/spi.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
 #include <sound/cs4271.h>
 
 #define CS4271_PCM_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
@@ -458,6 +460,14 @@ static int cs4271_soc_resume(struct snd_soc_codec *codec)
 #define cs4271_soc_resume	NULL
 #endif /* CONFIG_PM */
 
+#ifdef CONFIG_OF
+static const struct of_device_id cs4271_dt_ids[] = {
+	{ .compatible = "cirrus,cs4271", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cs4271_dt_ids);
+#endif
+
 static int cs4271_probe(struct snd_soc_codec *codec)
 {
 	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
@@ -465,6 +475,12 @@ static int cs4271_probe(struct snd_soc_codec *codec)
 	int ret;
 	int gpio_nreset = -EINVAL;
 
+#ifdef CONFIG_OF
+	if (of_match_device(cs4271_dt_ids, codec->dev))
+		gpio_nreset = of_get_named_gpio(codec->dev->of_node,
+						"reset-gpio", 0);
+#endif
+
 	if (cs4271plat && gpio_is_valid(cs4271plat->gpio_nreset))
 		gpio_nreset = cs4271plat->gpio_nreset;
 
@@ -569,6 +585,7 @@ static struct spi_driver cs4271_spi_driver = {
 	.driver = {
 		.name	= "cs4271",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(cs4271_dt_ids),
 	},
 	.probe		= cs4271_spi_probe,
 	.remove		= __devexit_p(cs4271_spi_remove),
@@ -608,6 +625,7 @@ static struct i2c_driver cs4271_i2c_driver = {
 	.driver = {
 		.name	= "cs4271",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(cs4271_dt_ids),
 	},
 	.id_table	= cs4271_i2c_id,
 	.probe		= cs4271_i2c_probe,
-- 
1.7.11.4
