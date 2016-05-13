From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 2/2] ASoC: Add support for HifiBerry DAC
Date: Fri, 13 May 2016 09:14:13 +0000
Message-ID: <1463130853-25096-3-git-send-email-kernel@martin.sperl.org>
References: <1463130853-25096-1-git-send-email-kernel@martin.sperl.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463130853-25096-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Reichl <hias-vtPv7MOkFPkAvxtiuMwx3w@public.gmane.org>, Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>

This adds a machine driver for the HifiBerry DAC.
It is a sound card that can be stacked onto the Raspberry Pi.

Signed-off-by: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>

Changes to original patch by Florian Meier:
* added .owner to struct snd_rpi_hifiberry_dac (ref-count)

Signed-off-by: Matthias Reichl <hias-vtPv7MOkFPkAvxtiuMwx3w@public.gmane.org>

Changes to original patch by Florian Meier:
* change to use BCM2835 in config keys instead of bcm2708
* fixed checkpath errors (spaces, indentation)
* added dt-binding documentation

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 .../bindings/sound/hifiberry,hifiberry-dac.txt     |  12 ++
 sound/soc/bcm/Kconfig                              |   7 ++
 sound/soc/bcm/Makefile                             |   3 +-
 sound/soc/bcm/hifiberry_dac.c                      | 126 +++++++++++++++++++++
 4 files changed, 147 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/hifiberry,hifiberry-dac.txt
 create mode 100644 sound/soc/bcm/hifiberry_dac.c

diff --git a/Documentation/devicetree/bindings/sound/hifiberry,hifiberry-dac.txt b/Documentation/devicetree/bindings/sound/hifiberry,hifiberry-dac.txt
new file mode 100644
index 0000000..88ba248
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/hifiberry,hifiberry-dac.txt
@@ -0,0 +1,12 @@
+* Hifiberry-dac soundcard-hat for raspberry-pi
+
+Required properties:
+- compatible: "hifiberry,hifiberry-dac"
+- i2s-controller: phandle of the bcm2835 i2s controller
+
+Example:
+
+sound {
+      compatible = "hifiberry,hifiberry-dac";
+      i2s-controller = <&i2s>;
+};
diff --git a/sound/soc/bcm/Kconfig b/sound/soc/bcm/Kconfig
index 6a834e1..e912774 100644
--- a/sound/soc/bcm/Kconfig
+++ b/sound/soc/bcm/Kconfig
@@ -7,3 +7,10 @@ config SND_BCM2835_SOC_I2S
 	  Say Y or M if you want to add support for codecs attached to
 	  the BCM2835 I2S interface. You will also need
 	  to select the audio interfaces to support below.
+
+config SND_BCM2835_SOC_HIFIBERRY_DAC
+        tristate "Support for HifiBerry DAC"
+        depends on SND_BCM2835_SOC_I2S
+        select SND_SOC_PCM5102A
+        help
+         Say Y or M if you want to add support for HifiBerry DAC.
diff --git a/sound/soc/bcm/Makefile b/sound/soc/bcm/Makefile
index bc816b7..bc6e249 100644
--- a/sound/soc/bcm/Makefile
+++ b/sound/soc/bcm/Makefile
@@ -1,5 +1,6 @@
 # BCM2835 Platform Support
 snd-soc-bcm2835-i2s-objs := bcm2835-i2s.o
+snd-soc-hifiberry-dac-objs := hifiberry_dac.o

 obj-$(CONFIG_SND_BCM2835_SOC_I2S) += snd-soc-bcm2835-i2s.o
-
+obj-$(CONFIG_SND_BCM2835_SOC_HIFIBERRY_DAC) += snd-soc-hifiberry-dac.o
diff --git a/sound/soc/bcm/hifiberry_dac.c b/sound/soc/bcm/hifiberry_dac.c
new file mode 100644
index 0000000..9e79bbf
--- /dev/null
+++ b/sound/soc/bcm/hifiberry_dac.c
@@ -0,0 +1,126 @@
+/*
+ * ASoC Driver for HifiBerry DAC
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
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/jack.h>
+
+static int snd_rpi_hifiberry_dac_init(struct snd_soc_pcm_runtime *rtd)
+{
+	return 0;
+}
+
+static int snd_rpi_hifiberry_dac_hw_params(
+	struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+
+	unsigned int sample_bits =
+		snd_pcm_format_physical_width(params_format(params));
+
+	return snd_soc_dai_set_bclk_ratio(cpu_dai, sample_bits * 2);
+}
+
+/* machine stream operations */
+static struct snd_soc_ops snd_rpi_hifiberry_dac_ops = {
+	.hw_params = snd_rpi_hifiberry_dac_hw_params,
+};
+
+static struct snd_soc_dai_link snd_rpi_hifiberry_dac_dai[] = {
+{
+	.name		= "HifiBerry DAC",
+	.stream_name	= "HifiBerry DAC HiFi",
+	.cpu_dai_name	= "bcm2708-i2s.0",
+	.codec_dai_name	= "pcm5102a-hifi",
+	.platform_name	= "bcm2708-i2s.0",
+	.codec_name	= "pcm5102a-codec",
+	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+				SND_SOC_DAIFMT_CBS_CFS,
+	.ops		= &snd_rpi_hifiberry_dac_ops,
+	.init		= snd_rpi_hifiberry_dac_init,
+},
+};
+
+/* audio machine driver */
+static struct snd_soc_card snd_rpi_hifiberry_dac = {
+	.name         = "snd_rpi_hifiberry_dac",
+	.owner        = THIS_MODULE,
+	.dai_link     = snd_rpi_hifiberry_dac_dai,
+	.num_links    = ARRAY_SIZE(snd_rpi_hifiberry_dac_dai),
+};
+
+static int snd_rpi_hifiberry_dac_probe(struct platform_device *pdev)
+{
+	struct device_node *i2s_node;
+	struct snd_soc_dai_link *dai;
+	int ret = 0;
+
+	snd_rpi_hifiberry_dac.dev = &pdev->dev;
+
+	if (pdev->dev.of_node) {
+		dai = &snd_rpi_hifiberry_dac_dai[0];
+		i2s_node = of_parse_phandle(pdev->dev.of_node,
+					    "i2s-controller", 0);
+
+		if (i2s_node) {
+			dai->cpu_dai_name = NULL;
+			dai->cpu_of_node = i2s_node;
+			dai->platform_name = NULL;
+			dai->platform_of_node = i2s_node;
+		}
+	}
+
+	ret = snd_soc_register_card(&snd_rpi_hifiberry_dac);
+	if (ret)
+		dev_err(&pdev->dev,
+			"snd_soc_register_card() failed: %d\n", ret);
+
+	return ret;
+}
+
+static int snd_rpi_hifiberry_dac_remove(struct platform_device *pdev)
+{
+	return snd_soc_unregister_card(&snd_rpi_hifiberry_dac);
+}
+
+static const struct of_device_id snd_rpi_hifiberry_dac_of_match[] = {
+	{ .compatible = "hifiberry,hifiberry-dac", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, snd_rpi_hifiberry_dac_of_match);
+
+static struct platform_driver snd_rpi_hifiberry_dac_driver = {
+	.driver = {
+		.name   = "snd-hifiberry-dac",
+		.owner  = THIS_MODULE,
+		.of_match_table = snd_rpi_hifiberry_dac_of_match,
+	},
+	.probe	= snd_rpi_hifiberry_dac_probe,
+	.remove	= snd_rpi_hifiberry_dac_remove,
+};
+
+module_platform_driver(snd_rpi_hifiberry_dac_driver);
+
+MODULE_AUTHOR("Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>");
+MODULE_DESCRIPTION("ASoC Driver for HifiBerry DAC");
+MODULE_LICENSE("GPL v2");
--
2.1.4
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
