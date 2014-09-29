From: Stefan Kristiansson <stefan.kristiansson-MbMCFXIvDHJFcC0YU169RA@public.gmane.org>
Subject: [PATCH v2 2/3] ASoC: ssm2602: add device tree bindings
Date: Mon, 29 Sep 2014 22:41:10 +0300
Message-ID: <1412019670-19429-1-git-send-email-stefan.kristiansson@saunalahti.fi>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, Stefan Kristiansson <stefan.kristiansson-MbMCFXIvDHJFcC0YU169RA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Allow the ssm2602/ssm2603/ssm2604 codec driver to be
instantiated from the device tree.

Also, add Kconfig prompts to allow manual selection of both the
I2C and SPI configuration versions of the driver.

Signed-off-by: Stefan Kristiansson <stefan.kristiansson-MbMCFXIvDHJFcC0YU169RA@public.gmane.org>
---
Changes in v2:
 - Remove "ssm2603" and "ssm2604" from the spi compatible list
---
 .../devicetree/bindings/sound/adi,ssm2602.txt         | 19 +++++++++++++++++++
 sound/soc/codecs/Kconfig                              |  8 ++++++--
 sound/soc/codecs/ssm2602-i2c.c                        |  9 +++++++++
 sound/soc/codecs/ssm2602-spi.c                        |  7 +++++++
 4 files changed, 41 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/adi,ssm2602.txt

diff --git a/Documentation/devicetree/bindings/sound/adi,ssm2602.txt b/Documentation/devicetree/bindings/sound/adi,ssm2602.txt
new file mode 100644
index 0000000..3b3302f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/adi,ssm2602.txt
@@ -0,0 +1,19 @@
+Analog Devices SSM2602, SSM2603 and SSM2604 I2S audio CODEC devices
+
+SSM2602 support both I2C and SPI as the configuration interface,
+the selection is made by the MODE strap-in pin.
+SSM2603 and SSM2604 only support I2C as the configuration interface.
+
+Required properties:
+
+  - compatible : One of "adi,ssm2602", "adi,ssm2603" or "adi,ssm2604"
+
+  - reg : the I2C address of the device for I2C, the chip select
+          number for SPI.
+
+ Example:
+
+	ssm2602: ssm2602@1a {
+		compatible = "adi,ssm2602";
+		reg = <0x1a>;
+	};
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 8838838e..3649e73 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -520,12 +520,16 @@ config SND_SOC_SSM2602
 	tristate
 
 config SND_SOC_SSM2602_SPI
+	tristate "Analog Devices SSM2602 CODEC - SPI"
+	depends on SPI_MASTER
 	select SND_SOC_SSM2602
-	tristate
+	select REGMAP_SPI
 
 config SND_SOC_SSM2602_I2C
+	tristate "Analog Devices SSM2602 CODEC - I2C"
+	depends on I2C
 	select SND_SOC_SSM2602
-	tristate
+	select REGMAP_I2C
 
 config SND_SOC_STA32X
 	tristate
diff --git a/sound/soc/codecs/ssm2602-i2c.c b/sound/soc/codecs/ssm2602-i2c.c
index abd63d5..0d9779d 100644
--- a/sound/soc/codecs/ssm2602-i2c.c
+++ b/sound/soc/codecs/ssm2602-i2c.c
@@ -41,10 +41,19 @@ static const struct i2c_device_id ssm2602_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ssm2602_i2c_id);
 
+static const struct of_device_id ssm2602_of_match[] = {
+	{ .compatible = "adi,ssm2602", },
+	{ .compatible = "adi,ssm2603", },
+	{ .compatible = "adi,ssm2604", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ssm2602_of_match);
+
 static struct i2c_driver ssm2602_i2c_driver = {
 	.driver = {
 		.name = "ssm2602",
 		.owner = THIS_MODULE,
+		.of_match_table = ssm2602_of_match,
 	},
 	.probe = ssm2602_i2c_probe,
 	.remove = ssm2602_i2c_remove,
diff --git a/sound/soc/codecs/ssm2602-spi.c b/sound/soc/codecs/ssm2602-spi.c
index 2bf55e2..b5df14f 100644
--- a/sound/soc/codecs/ssm2602-spi.c
+++ b/sound/soc/codecs/ssm2602-spi.c
@@ -26,10 +26,17 @@ static int ssm2602_spi_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct of_device_id ssm2602_of_match[] = {
+	{ .compatible = "adi,ssm2602", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ssm2602_of_match);
+
 static struct spi_driver ssm2602_spi_driver = {
 	.driver = {
 		.name	= "ssm2602",
 		.owner	= THIS_MODULE,
+		.of_match_table = ssm2602_of_match,
 	},
 	.probe		= ssm2602_spi_probe,
 	.remove		= ssm2602_spi_remove,
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
