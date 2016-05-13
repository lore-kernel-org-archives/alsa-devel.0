From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 1/2] ASoC: pcm5102a: Add support for PCM5102A codec
Date: Fri, 13 May 2016 09:14:12 +0000
Message-ID: <1463130853-25096-2-git-send-email-kernel@martin.sperl.org>
References: <1463130853-25096-1-git-send-email-kernel@martin.sperl.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463130853-25096-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Reichl <hias-vtPv7MOkFPkAvxtiuMwx3w@public.gmane.org>, Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>

Some definitions to support the PCM5102A codec
by Texas Instruments.

Signed-off-by: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>

Changes to original patch by Florian Meier:
* rebased (Makefile and Kconfig
* fixed checkpath errors (spaces, newlines)
* added dt-binding documentation

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 .../devicetree/bindings/sound/pcm5102a.txt         | 13 ++++
 sound/soc/codecs/Kconfig                           |  4 ++
 sound/soc/codecs/Makefile                          |  2 +
 sound/soc/codecs/pcm5102a.c                        | 69 ++++++++++++++++++++++
 4 files changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/pcm5102a.txt
 create mode 100644 sound/soc/codecs/pcm5102a.c

diff --git a/Documentation/devicetree/bindings/sound/pcm5102a.txt b/Documentation/devicetree/bindings/sound/pcm5102a.txt
new file mode 100644
index 0000000..c63ab0b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/pcm5102a.txt
@@ -0,0 +1,13 @@
+PCM5102a audio CODECs
+
+These devices does not use I2C or SPI.
+
+Required properties:
+
+  - compatible : set as "ti,pcm5102a"
+
+Examples:
+
+	pcm5102a: pcm5102a {
+		compatible = "ti,pcm5102a";
+	};
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 7ef3a0c..26ae0b5 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -94,6 +94,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_PCM3008
 	select SND_SOC_PCM3168A_I2C if I2C
 	select SND_SOC_PCM3168A_SPI if SPI_MASTER
+	select SND_SOC_PCM5102A
 	select SND_SOC_PCM512x_I2C if I2C
 	select SND_SOC_PCM512x_SPI if SPI_MASTER
 	select SND_SOC_RT286 if I2C
@@ -575,6 +576,9 @@ config SND_SOC_PCM3168A_SPI
 	select SND_SOC_PCM3168A
 	select REGMAP_SPI
 
+config SND_SOC_PCM5102A
+	tristate
+
 config SND_SOC_PCM512x
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 185a712..4532a74 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -89,6 +89,7 @@ snd-soc-pcm3008-objs := pcm3008.o
 snd-soc-pcm3168a-objs := pcm3168a.o
 snd-soc-pcm3168a-i2c-objs := pcm3168a-i2c.o
 snd-soc-pcm3168a-spi-objs := pcm3168a-spi.o
+snd-soc-pcm5102a-objs := pcm5102a.o
 snd-soc-pcm512x-objs := pcm512x.o
 snd-soc-pcm512x-i2c-objs := pcm512x-i2c.o
 snd-soc-pcm512x-spi-objs := pcm512x-spi.o
@@ -298,6 +299,7 @@ obj-$(CONFIG_SND_SOC_PCM3008)	+= snd-soc-pcm3008.o
 obj-$(CONFIG_SND_SOC_PCM3168A)	+= snd-soc-pcm3168a.o
 obj-$(CONFIG_SND_SOC_PCM3168A_I2C)	+= snd-soc-pcm3168a-i2c.o
 obj-$(CONFIG_SND_SOC_PCM3168A_SPI)	+= snd-soc-pcm3168a-spi.o
+obj-$(CONFIG_SND_SOC_PCM5102A)	+= snd-soc-pcm5102a.o
 obj-$(CONFIG_SND_SOC_PCM512x)	+= snd-soc-pcm512x.o
 obj-$(CONFIG_SND_SOC_PCM512x_I2C)	+= snd-soc-pcm512x-i2c.o
 obj-$(CONFIG_SND_SOC_PCM512x_SPI)	+= snd-soc-pcm512x-spi.o
diff --git a/sound/soc/codecs/pcm5102a.c b/sound/soc/codecs/pcm5102a.c
new file mode 100644
index 0000000..ed51567
--- /dev/null
+++ b/sound/soc/codecs/pcm5102a.c
@@ -0,0 +1,69 @@
+/*
+ * Driver for the PCM5102A codec
+ *
+ * Author:	Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
+ *		Copyright 2013
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <sound/soc.h>
+
+static struct snd_soc_dai_driver pcm5102a_dai = {
+	.name = "pcm5102a-hifi",
+	.playback = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_192000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE |
+			   SNDRV_PCM_FMTBIT_S24_LE |
+			   SNDRV_PCM_FMTBIT_S32_LE
+	},
+};
+
+static struct snd_soc_codec_driver soc_codec_dev_pcm5102a;
+
+static int pcm5102a_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_pcm5102a,
+			&pcm5102a_dai, 1);
+}
+
+static int pcm5102a_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
+	return 0;
+}
+
+static const struct of_device_id pcm5102a_of_match[] = {
+	{ .compatible = "ti,pcm5102a", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pcm5102a_of_match);
+
+static struct platform_driver pcm5102a_codec_driver = {
+	.probe		= pcm5102a_probe,
+	.remove		= pcm5102a_remove,
+	.driver		= {
+		.name	= "pcm5102a-codec",
+		.owner	= THIS_MODULE,
+		.of_match_table = pcm5102a_of_match,
+	},
+};
+
+module_platform_driver(pcm5102a_codec_driver);
+
+MODULE_DESCRIPTION("ASoC PCM5102A codec driver");
+MODULE_AUTHOR("Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
