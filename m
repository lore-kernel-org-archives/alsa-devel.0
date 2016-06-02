From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: [PATCH 2/2] ASoC: Add ADAU7002 Stereo PDM-to-I2S/TDM Converter driver
Date: Thu,  2 Jun 2016 14:19:42 +0200
Message-ID: <1464869982-6722-2-git-send-email-lars@metafoo.de>
References: <1464869982-6722-1-git-send-email-lars@metafoo.de>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1464869982-6722-1-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patch adds support for the ADAU7002 PDM-to-I2S/TDM converter. The
ADAU7002 takes a stereo PDM signal (e.g. from two digital microphones) and
converts it into a I2S/TDM PCM stream. The chip does not have a
programmable control interface and the driver simply describes the static
capabilities of the chip.

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
---
 sound/soc/codecs/Kconfig    |  4 +++
 sound/soc/codecs/Makefile   |  2 ++
 sound/soc/codecs/adau7002.c | 80 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)
 create mode 100644 sound/soc/codecs/adau7002.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index a0a4164..2b4dde1 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -32,6 +32,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_ADAU1977_SPI if SPI_MASTER
 	select SND_SOC_ADAU1977_I2C if I2C
 	select SND_SOC_ADAU1701 if I2C
+	select SND_SOC_ADAU7002
 	select SND_SOC_ADS117X
 	select SND_SOC_AK4104 if SPI_MASTER
 	select SND_SOC_AK4535 if I2C
@@ -324,6 +325,9 @@ config SND_SOC_ADAU1977_I2C
 	select SND_SOC_ADAU1977
 	select REGMAP_I2C
 
+config SND_SOC_ADAU7002
+	tristate "Analog Devices ADAU7002 Stereo PDM-to-I2S/TDM Converter"
+
 config SND_SOC_ADAV80X
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 80b4f51..550a174 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -19,6 +19,7 @@ snd-soc-adau1781-spi-objs := adau1781-spi.o
 snd-soc-adau1977-objs := adau1977.o
 snd-soc-adau1977-spi-objs := adau1977-spi.o
 snd-soc-adau1977-i2c-objs := adau1977-i2c.o
+snd-soc-adau7002-objs := adau7002.o
 snd-soc-adav80x-objs := adav80x.o
 snd-soc-adav801-objs := adav801.o
 snd-soc-adav803-objs := adav803.o
@@ -234,6 +235,7 @@ obj-$(CONFIG_SND_SOC_ADAU1781_SPI)	+= snd-soc-adau1781-spi.o
 obj-$(CONFIG_SND_SOC_ADAU1977)		+= snd-soc-adau1977.o
 obj-$(CONFIG_SND_SOC_ADAU1977_SPI)	+= snd-soc-adau1977-spi.o
 obj-$(CONFIG_SND_SOC_ADAU1977_I2C)	+= snd-soc-adau1977-i2c.o
+obj-$(CONFIG_SND_SOC_ADAU7002)	+= snd-soc-adau7002.o
 obj-$(CONFIG_SND_SOC_ADAV80X)  += snd-soc-adav80x.o
 obj-$(CONFIG_SND_SOC_ADAV801)  += snd-soc-adav801.o
 obj-$(CONFIG_SND_SOC_ADAV803)  += snd-soc-adav803.o
diff --git a/sound/soc/codecs/adau7002.c b/sound/soc/codecs/adau7002.c
new file mode 100644
index 0000000..9df72c6
--- /dev/null
+++ b/sound/soc/codecs/adau7002.c
@@ -0,0 +1,80 @@
+/*
+ * ADAU7002 Stereo PDM-to-I2S/TDM converter driver
+ *
+ * Copyright 2014-2016 Analog Devices
+ *  Author: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include <sound/soc.h>
+
+static const struct snd_soc_dapm_widget adau7002_widgets[] = {
+	SND_SOC_DAPM_INPUT("PDM_DAT"),
+	SND_SOC_DAPM_REGULATOR_SUPPLY("IOVDD", 0, 0),
+};
+
+static const struct snd_soc_dapm_route adau7002_routes[] = {
+	{ "Capture", NULL, "PDM_DAT" },
+	{ "Capture", NULL, "IOVDD" },
+};
+
+static struct snd_soc_dai_driver adau7002_dai = {
+	.name = "adau7002-hifi",
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S18_3LE |
+			SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S24_LE |
+			SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE,
+		.sig_bits = 20,
+	},
+};
+
+static const struct snd_soc_codec_driver adau7002_codec_driver = {
+	.dapm_widgets = adau7002_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(adau7002_widgets),
+	.dapm_routes = adau7002_routes,
+	.num_dapm_routes = ARRAY_SIZE(adau7002_routes),
+};
+
+static int adau7002_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_codec(&pdev->dev, &adau7002_codec_driver,
+			&adau7002_dai, 1);
+}
+
+static int adau7002_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id adau7002_dt_ids[] = {
+	{ .compatible = "adi,adau7002", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adau7002_dt_ids);
+#endif
+
+static struct platform_driver adau7002_driver = {
+	.driver = {
+		.name = "adau7002",
+		.of_match_table	= of_match_ptr(adau7002_dt_ids),
+	},
+	.probe = adau7002_probe,
+	.remove = adau7002_remove,
+};
+module_platform_driver(adau7002_driver);
+
+MODULE_AUTHOR("Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>");
+MODULE_DESCRIPTION("ADAU7002 Stereo PDM-to-I2S/TDM Converter driver");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
