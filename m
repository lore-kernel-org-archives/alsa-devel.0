From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: [PATCH] ASoC: ics43432: Add codec driver for
	InvenSense ICS-43432
Date: Thu, 13 Aug 2015 15:55:17 +0200
Message-ID: <alpine.DEB.2.02.1508131428310.27635@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D185261A3B
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 15:55:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


Add support for the InvenSense ICS-43432 I2S MEMS microphone.

This is a non-software-configurable MEMS microphone with I2S output.

Signed-off-by: Ricard Wanderlof <ricardw@axis.com>

---
 .../devicetree/bindings/sound/ics43432.txt         |   17 +++
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 sound/soc/codecs/Kconfig                           |    4 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/ics43432.c                        |  111 ++++++++++++++++=
++++
 5 files changed, 135 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ics43432.txt
 create mode 100644 sound/soc/codecs/ics43432.c

diff --git a/Documentation/devicetree/bindings/sound/ics43432.txt b/Documen=
tation/devicetree/bindings/sound/ics43432.txt
new file mode 100644
index 0000000..b02e3a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ics43432.txt
@@ -0,0 +1,17 @@
+Invensense ICS-43432 MEMS microphone with I2S output.
+
+There are no software configuration options for this device, indeed, the o=
nly
+host connection is the I2S interface. Apart from requirements on clock
+frequency (460 kHz to 3.379 MHz according to the data sheet) there must be
+64 clock cycles in each stereo output frame; 24 of the 32 available bits
+contain audio data. A hardware pin determines if the device outputs data
+on the left or right channel of the I2S frame.
+
+Required properties:
+  - compatible : Must be "invensense,ics43432"
+
+Example:
+
+	ics43432: ics43432 {
+		compatible =3D "invensense,ics43432";
+	};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Docume=
ntation/devicetree/bindings/vendor-prefixes.txt
index 8033919..7966637 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -103,6 +103,7 @@ img	Imagination Technologies Ltd.
 innolux	Innolux Corporation
 intel	Intel Corporation
 intercontrol	Inter Control Group
+invensense	InvenSense Inc.
 isee	ISEE 2007 S.L.
 isil	Intersil
 karo	Ka-Ro electronics GmbH
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 061c465..d696c85 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -62,6 +62,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_BT_SCO
 	select SND_SOC_ES8328_SPI if SPI_MASTER
 	select SND_SOC_ES8328_I2C if I2C
+	select SND_SOC_ICS43432
 	select SND_SOC_ISABELLE if I2C
 	select SND_SOC_JZ4740_CODEC
 	select SND_SOC_LM4857 if I2C
@@ -444,6 +445,9 @@ config SND_SOC_ES8328_SPI
 	tristate
 	select SND_SOC_ES8328
 =

+config SND_SOC_ICS43432
+	tristate
+
 config SND_SOC_ISABELLE
         tristate
 =

diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index abe2d7e..23a2caf 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -55,6 +55,7 @@ snd-soc-dmic-objs :=3D dmic.o
 snd-soc-es8328-objs :=3D es8328.o
 snd-soc-es8328-i2c-objs :=3D es8328-i2c.o
 snd-soc-es8328-spi-objs :=3D es8328-spi.o
+snd-soc-ics43432-objs :=3D ics43432.o
 snd-soc-isabelle-objs :=3D isabelle.o
 snd-soc-jz4740-codec-objs :=3D jz4740.o
 snd-soc-l3-objs :=3D l3.o
@@ -240,6 +241,7 @@ obj-$(CONFIG_SND_SOC_DMIC)	+=3D snd-soc-dmic.o
 obj-$(CONFIG_SND_SOC_ES8328)	+=3D snd-soc-es8328.o
 obj-$(CONFIG_SND_SOC_ES8328_I2C)+=3D snd-soc-es8328-i2c.o
 obj-$(CONFIG_SND_SOC_ES8328_SPI)+=3D snd-soc-es8328-spi.o
+obj-$(CONFIG_SND_SOC_ICS43432)	+=3D snd-soc-ics43432.o
 obj-$(CONFIG_SND_SOC_ISABELLE)	+=3D snd-soc-isabelle.o
 obj-$(CONFIG_SND_SOC_JZ4740_CODEC)	+=3D snd-soc-jz4740-codec.o
 obj-$(CONFIG_SND_SOC_L3)	+=3D snd-soc-l3.o
diff --git a/sound/soc/codecs/ics43432.c b/sound/soc/codecs/ics43432.c
new file mode 100644
index 0000000..902daae
--- /dev/null
+++ b/sound/soc/codecs/ics43432.c
@@ -0,0 +1,111 @@
+/*
+ * I2S MEMS microphone driver for InvenSense ICS-43432
+ *
+ * - Non configurable.
+ * - I2S interface, 64 BCLs per frame, 32 bits per channel, 24 bit data
+ *
+ * Copyright (c) 2015 Axis Communications AB
+ *
+ * Licensed under GPL2.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+
+#define ICS43432_RATE_MIN 7190 /* Hz, from data sheet */
+#define ICS43432_RATE_MAX 52800  /* Hz, from data sheet */
+
+static int ics43432_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+{
+	unsigned int rate =3D params_rate(params);
+
+	if (rate < ICS43432_RATE_MIN || rate > ICS43432_RATE_MAX)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ics43432_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+#define ICS43432_FORMATS (SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32)
+
+static const struct snd_soc_dai_ops ics43432_dai_ops =3D {
+	.hw_params	=3D ics43432_hw_params,
+	.set_fmt	=3D ics43432_set_dai_fmt,
+};
+
+static struct snd_soc_dai_driver ics43432_dai =3D {
+	.name =3D "ics43432-hifi",
+	.capture =3D {
+		.stream_name =3D "Capture",
+		.channels_min =3D 1,
+		.channels_max =3D 2,
+		.rates =3D SNDRV_PCM_RATE_8000_48000,
+		.formats =3D ICS43432_FORMATS,
+	},
+	.ops =3D &ics43432_dai_ops,
+};
+
+static struct snd_soc_codec_driver ics43432_codec_driver =3D {
+};
+
+static int ics43432_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_codec(&pdev->dev, &ics43432_codec_driver,
+			&ics43432_dai, 1);
+}
+
+static int ics43432_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id ics43432_ids[] =3D {
+	{ .compatible =3D "invensense,ics43432", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ics43432_dt_ids);
+#endif
+
+static struct platform_driver ics43432_driver =3D {
+	.driver =3D {
+		.name =3D "ics43432",
+		.owner =3D THIS_MODULE,
+		.of_match_table =3D of_match_ptr(ics43432_ids),
+	},
+	.probe =3D ics43432_probe,
+	.remove =3D ics43432_remove,
+};
+
+module_platform_driver(ics43432_driver);
+
+MODULE_DESCRIPTION("ASoC ICS43432 driver");
+MODULE_AUTHOR("Ricard Wanderlof <ricardw@axis.com>");
+MODULE_LICENSE("GPL2");
-- =

1.7.10.4


-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
