From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ics43432: Add codec driver for
	InvenSense ICS-43432" to the asoc tree
Date: Thu, 27 Aug 2015 20:18:17 +0100
Message-ID: <E1ZV2gj-0003KT-HT@debutante>
References: <alpine.DEB.2.02.1508271124140.16666@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 355CD260616
 for <alsa-devel@alsa-project.org>; Thu, 27 Aug 2015 21:18:27 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1508271124140.16666@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricardw@axis.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ics43432: Add codec driver for InvenSense ICS-43432

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 3b7ce99748f0d006f9d1aa85709872e7b46787f7 Mon Sep 17 00:00:00 2001
From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Date: Thu, 27 Aug 2015 11:35:20 +0200
Subject: [PATCH] ASoC: ics43432: Add codec driver for InvenSense ICS-43432

Add support for the InvenSense ICS-43432 I2S MEMS microphone.

This is a non-software-configurable MEMS microphone with I2S output.

Tested on a setup with a single ICS-43432 (the device itself supports
stereo operation using a hardware pin controlling left vs. right channel
output).

Signed-off-by: Ricard Wanderlof <ricardw@axis.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/ics43432.txt         | 17 +++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 sound/soc/codecs/Kconfig                           |  4 ++
 sound/soc/codecs/Makefile                          |  2 +
 sound/soc/codecs/ics43432.c                        | 77 ++++++++++++++++++++++
 5 files changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ics43432.txt
 create mode 100644 sound/soc/codecs/ics43432.c

diff --git a/Documentation/devicetree/bindings/sound/ics43432.txt b/Documentation/devicetree/bindings/sound/ics43432.txt
new file mode 100644
index 000000000000..b02e3a6c0fef
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ics43432.txt
@@ -0,0 +1,17 @@
+Invensense ICS-43432 MEMS microphone with I2S output.
+
+There are no software configuration options for this device, indeed, the only
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
+		compatible = "invensense,ics43432";
+	};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index d444757c4d9e..80bf96d4795f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -110,6 +110,7 @@ ingenic	Ingenic Semiconductor
 innolux	Innolux Corporation
 intel	Intel Corporation
 intercontrol	Inter Control Group
+invensense	InvenSense Inc.
 isee	ISEE 2007 S.L.
 isil	Intersil
 karo	Ka-Ro electronics GmbH
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index efaafce8ba38..1bb6446dce53 100644
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
@@ -446,6 +447,9 @@ config SND_SOC_ES8328_SPI
 	tristate
 	select SND_SOC_ES8328
 
+config SND_SOC_ICS43432
+	tristate
+
 config SND_SOC_ISABELLE
         tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index cf160d972cb3..5a19a670a82b 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -55,6 +55,7 @@ snd-soc-dmic-objs := dmic.o
 snd-soc-es8328-objs := es8328.o
 snd-soc-es8328-i2c-objs := es8328-i2c.o
 snd-soc-es8328-spi-objs := es8328-spi.o
+snd-soc-ics43432-objs := ics43432.o
 snd-soc-isabelle-objs := isabelle.o
 snd-soc-jz4740-codec-objs := jz4740.o
 snd-soc-l3-objs := l3.o
@@ -242,6 +243,7 @@ obj-$(CONFIG_SND_SOC_DMIC)	+= snd-soc-dmic.o
 obj-$(CONFIG_SND_SOC_ES8328)	+= snd-soc-es8328.o
 obj-$(CONFIG_SND_SOC_ES8328_I2C)+= snd-soc-es8328-i2c.o
 obj-$(CONFIG_SND_SOC_ES8328_SPI)+= snd-soc-es8328-spi.o
+obj-$(CONFIG_SND_SOC_ICS43432)	+= snd-soc-ics43432.o
 obj-$(CONFIG_SND_SOC_ISABELLE)	+= snd-soc-isabelle.o
 obj-$(CONFIG_SND_SOC_JZ4740_CODEC)	+= snd-soc-jz4740-codec.o
 obj-$(CONFIG_SND_SOC_L3)	+= snd-soc-l3.o
diff --git a/sound/soc/codecs/ics43432.c b/sound/soc/codecs/ics43432.c
new file mode 100644
index 000000000000..4f202c15df39
--- /dev/null
+++ b/sound/soc/codecs/ics43432.c
@@ -0,0 +1,77 @@
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
+#define ICS43432_FORMATS (SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32)
+
+static struct snd_soc_dai_driver ics43432_dai = {
+	.name = "ics43432-hifi",
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rate_min = ICS43432_RATE_MIN,
+		.rate_max = ICS43432_RATE_MAX,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
+		.formats = ICS43432_FORMATS,
+	},
+};
+
+static struct snd_soc_codec_driver ics43432_codec_driver = {
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
+static const struct of_device_id ics43432_ids[] = {
+	{ .compatible = "invensense,ics43432", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ics43432_dt_ids);
+#endif
+
+static struct platform_driver ics43432_driver = {
+	.driver = {
+		.name = "ics43432",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(ics43432_ids),
+	},
+	.probe = ics43432_probe,
+	.remove = ics43432_remove,
+};
+
+module_platform_driver(ics43432_driver);
+
+MODULE_DESCRIPTION("ASoC ICS43432 driver");
+MODULE_AUTHOR("Ricard Wanderlof <ricardw@axis.com>");
+MODULE_LICENSE("GPLv2");
-- 
2.5.0
