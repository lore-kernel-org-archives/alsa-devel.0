From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] ASoC: ad74111: new codec driver
Date: Sat, 26 Mar 2011 04:33:46 -0400
Message-ID: <1301128426-2817-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DB691037F3
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 09:33:19 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Scott Jiang <scott.jiang@analog.com>, Cliff Cai <cliff.cai@analog.com>, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Scott Jiang <scott.jiang@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/codecs/Kconfig   |    8 +++-
 sound/soc/codecs/Makefile  |    4 ++-
 sound/soc/codecs/ad74111.c |   76 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ad74111.h |   63 ++++++++++++++++++++++++++++++++++++
 4 files changed, 148 insertions(+), 3 deletions(-)
 create mode 100644 sound/soc/codecs/ad74111.c
 create mode 100644 sound/soc/codecs/ad74111.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index dc6d253..ee65b7c 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -16,8 +16,9 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_AD183X if SPI_MASTER
 	select SND_SOC_AD193X if SND_SOC_I2C_AND_SPI
 	select SND_SOC_AD1980 if SND_SOC_AC97_BUS
-	select SND_SOC_ADS117X
 	select SND_SOC_AD73311 if I2C
+	select SND_SOC_AD74111
+	select SND_SOC_ADS117X
 	select SND_SOC_AK4104 if SPI_MASTER
 	select SND_SOC_AK4535 if I2C
 	select SND_SOC_AK4642 if I2C
@@ -126,7 +127,10 @@ config SND_SOC_AD1980
 
 config SND_SOC_AD73311
 	tristate
-	
+
+config SND_SOC_AD74111
+	tristate
+
 config SND_SOC_ADS117X
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 44d3278..b834755 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -4,6 +4,7 @@ snd-soc-ad183x-objs := ad183x.o
 snd-soc-ad193x-objs := ad193x.o
 snd-soc-ad1980-objs := ad1980.o
 snd-soc-ad73311-objs := ad73311.o
+snd-soc-ad74111-objs := ad74111.o
 snd-soc-ads117x-objs := ads117x.o
 snd-soc-ak4104-objs := ak4104.o
 snd-soc-ak4535-objs := ak4535.o
@@ -90,7 +91,8 @@ obj-$(CONFIG_SND_SOC_AC97_CODEC)	+= snd-soc-ac97.o
 obj-$(CONFIG_SND_SOC_AD183X)	+= snd-soc-ad183x.o
 obj-$(CONFIG_SND_SOC_AD193X)	+= snd-soc-ad193x.o
 obj-$(CONFIG_SND_SOC_AD1980)	+= snd-soc-ad1980.o
-obj-$(CONFIG_SND_SOC_AD73311) += snd-soc-ad73311.o
+obj-$(CONFIG_SND_SOC_AD73311)	+= snd-soc-ad73311.o
+obj-$(CONFIG_SND_SOC_AD74111)	+= snd-soc-ad74111.o
 obj-$(CONFIG_SND_SOC_ADS117X)	+= snd-soc-ads117x.o
 obj-$(CONFIG_SND_SOC_AK4104)	+= snd-soc-ak4104.o
 obj-$(CONFIG_SND_SOC_AK4535)	+= snd-soc-ak4535.o
diff --git a/sound/soc/codecs/ad74111.c b/sound/soc/codecs/ad74111.c
new file mode 100644
index 0000000..9d247ae
--- /dev/null
+++ b/sound/soc/codecs/ad74111.c
@@ -0,0 +1,76 @@
+/*
+ * ALSA Soc AD74111 codec support
+ *
+ * Copyright 2009-2011 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/ac97_codec.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+
+#include "ad74111.h"
+
+static struct snd_soc_dai_driver ad74111_dai = {
+	.name = "ad74111-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 1,
+		.rates = SNDRV_PCM_RATE_8000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE, },
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 1,
+		.rates = SNDRV_PCM_RATE_8000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE, },
+};
+
+static struct snd_soc_codec_driver soc_codec_dev_ad74111;
+
+static int ad74111_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_codec(&pdev->dev,
+			&soc_codec_dev_ad74111, &ad74111_dai, 1);
+}
+
+static int __devexit ad74111_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver ad74111_codec_driver = {
+	.driver = {
+		.name = "ad74111-codec",
+		.owner = THIS_MODULE,
+	},
+
+	.probe = ad74111_probe,
+	.remove = __devexit_p(ad74111_remove),
+};
+
+static int __init ad74111_init(void)
+{
+	return platform_driver_register(&ad74111_codec_driver);
+}
+module_init(ad74111_init);
+
+static void __exit ad74111_exit(void)
+{
+	platform_driver_unregister(&ad74111_codec_driver);
+}
+module_exit(ad74111_exit);
+
+MODULE_DESCRIPTION("ASoC AD74111 driver");
+MODULE_AUTHOR("Cliff Cai");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/ad74111.h b/sound/soc/codecs/ad74111.h
new file mode 100644
index 0000000..19a8183
--- /dev/null
+++ b/sound/soc/codecs/ad74111.h
@@ -0,0 +1,63 @@
+/*
+ * definitions for AD74111 registers
+ *
+ * Copyright 2006-2011 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#ifndef __AD74111_H__
+#define __AD74111_H__
+
+#define AD_READ			0x0000
+#define AD_WRITE		0x8000
+
+/* Control register A */
+#define CTRL_REG_A		(0 << 11)
+
+#define REGA_REFAMP		(1 << 2)
+#define REGA_REF		(1 << 3)
+#define REGA_DAC		(1 << 4)
+#define REGA_ADC		(1 << 5)
+#define REGA_ADC_INPAMP		(1 << 6)
+
+/* Control register B */
+#define CTRL_REG_B		(1 << 11)
+
+#define REGB_FCLKDIV(x)		((x) & 0x3)
+#define REGB_SCLKDIV(x)		(((x) & 0x3) << 2)
+#define REGB_TCLKDIV(x)		(((x) & 0x3) << 4)
+
+/* Control register C */
+#define CTRL_REG_C		(2 << 11)
+
+#define REGC_ADC_HP		(1 << 0)
+#define REGC_DAC_DEEMPH(x)	(((x) & 0x3) << 1)
+#define REGC_LG_DELAY		(1 << 3)
+#define REGC_WORD_WIDTH(x)	(((x) & 0x3) << 4)
+
+/* Control register D */
+#define CTRL_REG_D		(3 << 11)
+
+#define REGD_MASTER		(1 << 0)
+#define REGD_FDCLK		(1 << 1)
+#define REGD_DSP_MODE		(1 << 2)
+#define REGD_MIX_MODE		(1 << 3)
+#define REGD_MFS		(1 << 9)
+
+/* Control register E */
+#define CTRL_REG_E		(4 << 11)
+
+#define REGE_DAC_MUTE		(1 << 0)
+#define REGE_ADC_MUTE		(1 << 1)
+#define REGE_ADC_GAIN(x)	(((x) & 0x7) << 2)
+#define REGE_ADC_PEAKEN		(1 << 5)
+
+/* Control register F */
+#define CTRL_REG_F		(5 << 11)
+#define REGF_DAC_VOL(x)		((x) & 0x3F)
+
+/* Control register G */
+#define CTRL_REG_G		(6 << 11)
+
+#endif
-- 
1.7.4.1
