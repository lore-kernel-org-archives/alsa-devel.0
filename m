From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH] Add initial support of Mitac mioa701 device
	SoC.
Date: Sat,  7 Feb 2009 14:01:58 +0100
Message-ID: <1234011718-18641-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by alsa0.perex.cz (Postfix) with ESMTP id A96651037ED
	for <alsa-devel@alsa-project.org>; Sat,  7 Feb 2009 14:02:06 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org

This machine driver enables sound functions on Mitac mio
a701 smartphone. Build upon ASoC v1, it handles :
 - rear speaker
 - front speaker
 - microphone
 - GSM

A global "Mio Mode" switch is not yet provided to cope with
audio path setup. As balance on audio chip line is no more
assured, an incorrect setup can produce a lot of heat and
even fry the battery behind the wm9713 and the speaker
amplificator.

It doesn't cope with :
 - headset jack
 - mio master mode
 - master volume control

This driver is backported from ASoc v2, and amputated from
scenario setups and master volume control.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 sound/soc/pxa/Kconfig          |    9 ++
 sound/soc/pxa/Makefile         |    2 +
 sound/soc/pxa/mioa701_wm9713.c |  250 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 261 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/pxa/mioa701_wm9713.c

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index f82e106..b385404 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -97,3 +97,12 @@ config SND_SOC_ZYLONITE
 	help
 	  Say Y if you want to add support for SoC audio on the
 	  Marvell Zylonite reference platform.
+
+config SND_PXA2XX_SOC_MIOA701
+        tristate "SoC Audio support for MIO A701"
+        depends on SND_PXA2XX_SOC && MACH_MIOA701
+        select SND_PXA2XX_SOC_AC97
+        select SND_SOC_WM9713
+        help
+          Say Y if you want to add support for SoC audio on the
+          MIO A701.
diff --git a/sound/soc/pxa/Makefile b/sound/soc/pxa/Makefile
index 08a9f27..9a6d27c 100644
--- a/sound/soc/pxa/Makefile
+++ b/sound/soc/pxa/Makefile
@@ -18,6 +18,7 @@ snd-soc-spitz-objs := spitz.o
 snd-soc-em-x270-objs := em-x270.o
 snd-soc-palm27x-objs := palm27x.o
 snd-soc-zylonite-objs := zylonite.o
+snd-soc-mioa701-objs := mioa701_wm9713.o
 
 obj-$(CONFIG_SND_PXA2XX_SOC_CORGI) += snd-soc-corgi.o
 obj-$(CONFIG_SND_PXA2XX_SOC_POODLE) += snd-soc-poodle.o
@@ -26,4 +27,5 @@ obj-$(CONFIG_SND_PXA2XX_SOC_E800) += snd-soc-e800.o
 obj-$(CONFIG_SND_PXA2XX_SOC_SPITZ) += snd-soc-spitz.o
 obj-$(CONFIG_SND_PXA2XX_SOC_EM_X270) += snd-soc-em-x270.o
 obj-$(CONFIG_SND_PXA2XX_SOC_PALM27X) += snd-soc-palm27x.o
+obj-$(CONFIG_SND_PXA2XX_SOC_MIOA701) += snd-soc-mioa701.o
 obj-$(CONFIG_SND_SOC_ZYLONITE) += snd-soc-zylonite.o
diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
new file mode 100644
index 0000000..839f928
--- /dev/null
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -0,0 +1,250 @@
+/*
+ * Handles the Mitac mioa701 SoC system
+ *
+ * Copyright (C) 2008 Robert Jarzmik
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation in version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * This is a little schema of the sound interconnections :
+ *
+ *    Sagem X200                 Wolfson WM9713
+ *    +--------+             +-------------------+      Rear Speaker
+ *    |        |             |                   |           /-+
+ *    |        +--->----->---+MONOIN         SPKL+--->----+-+  |
+ *    |  GSM   |             |                   |        | |  |
+ *    |        +--->----->---+PCBEEP         SPKR+--->----+-+  |
+ *    |  CHIP  |             |                   |           \-+
+ *    |        +---<-----<---+MONO               |
+ *    |        |             |                   |      Front Speaker
+ *    +--------+             |                   |           /-+
+ *                           |                HPL+--->----+-+  |
+ *                           |                   |        | |  |
+ *                           |               OUT3+--->----+-+  |
+ *                           |                   |           \-+
+ *                           |                   |
+ *                           |                   |     Front Micro
+ *                           |                   |         +
+ *                           |               MIC1+-----<--+o+
+ *                           |                   |         +
+ *                           +-------------------+        ---
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach-types.h>
+#include <mach/audio.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+#include <sound/ac97_codec.h>
+
+#include "pxa2xx-pcm.h"
+#include "pxa2xx-ac97.h"
+#include "../codecs/wm9713.h"
+
+#define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
+
+#define AC97_GPIO_PULL		0x58
+
+/* Use GPIO8 for rear speaker amplificator */
+static int rear_amp_power(struct snd_soc_codec *codec, int power)
+{
+	unsigned short reg;
+
+	if (power) {
+		reg = snd_soc_read(codec, AC97_GPIO_CFG);
+		snd_soc_write(codec, AC97_GPIO_CFG, reg | 0x0100);
+		reg = snd_soc_read(codec, AC97_GPIO_PULL);
+		snd_soc_write(codec, AC97_GPIO_PULL, reg | (1<<15));
+	} else {
+		reg = snd_soc_read(codec, AC97_GPIO_CFG);
+		snd_soc_write(codec, AC97_GPIO_CFG, reg & ~0x0100);
+		reg = snd_soc_read(codec, AC97_GPIO_PULL);
+		snd_soc_write(codec, AC97_GPIO_PULL, reg & ~(1<<15));
+	}
+
+	return 0;
+}
+
+static int rear_amp_event(struct snd_soc_dapm_widget *widget,
+			  struct snd_kcontrol *kctl, int event)
+{
+	struct snd_soc_codec *codec = widget->codec;
+
+	return rear_amp_power(codec, SND_SOC_DAPM_EVENT_ON(event));
+}
+
+/* mioa701 machine dapm widgets */
+static const struct snd_soc_dapm_widget mioa701_dapm_widgets[] = {
+	SND_SOC_DAPM_SPK("Front Speaker", NULL),
+	SND_SOC_DAPM_SPK("Rear Speaker", rear_amp_event),
+	SND_SOC_DAPM_MIC("Headset", NULL),
+	SND_SOC_DAPM_LINE("GSM Line Out", NULL),
+	SND_SOC_DAPM_LINE("GSM Line In", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Front Mic", NULL),
+};
+
+static const struct snd_soc_dapm_route audio_map[] = {
+	/* Call Mic */
+	{"Mic Bias", NULL, "Front Mic"},
+	{"MIC1", NULL, "Mic Bias"},
+
+	/* Headset Mic */
+	{"LINEL", NULL, "Headset Mic"},
+	{"LINER", NULL, "Headset Mic"},
+
+	/* GSM Module */
+	{"MONOIN", NULL, "GSM Line Out"},
+	{"PCBEEP", NULL, "GSM Line Out"},
+	{"GSM Line In", NULL, "MONO"},
+
+	/* headphone connected to HPL, HPR */
+	{"Headset", NULL, "HPL"},
+	{"Headset", NULL, "HPR"},
+
+	/* front speaker connected to HPL, OUT3 */
+	{"Front Speaker", NULL, "HPL"},
+	{"Front Speaker", NULL, "OUT3"},
+
+	/* rear speaker connected to SPKL, SPKR */
+	{"Rear Speaker", NULL, "SPKL"},
+	{"Rear Speaker", NULL, "SPKR"},
+};
+
+static int mioa701_wm9713_init(struct snd_soc_codec *codec)
+{
+	unsigned short reg;
+
+	/* Add mioa701 specific widgets */
+	snd_soc_dapm_new_controls(codec, ARRAY_AND_SIZE(mioa701_dapm_widgets));
+
+	/* Set up mioa701 specific audio path audio_mapnects */
+	snd_soc_dapm_add_routes(codec, ARRAY_AND_SIZE(audio_map));
+
+	/* Prepare GPIO8 for rear speaker amplificator */
+	reg = codec->read(codec, AC97_GPIO_CFG);
+	codec->write(codec, AC97_GPIO_CFG, reg | 0x0100);
+
+	/* Prepare MIC input */
+	reg = codec->read(codec, AC97_3D_CONTROL);
+	codec->write(codec, AC97_3D_CONTROL, reg | 0xc000);
+
+	snd_soc_dapm_enable_pin(codec, "Front Speaker");
+	snd_soc_dapm_enable_pin(codec, "Rear Speaker");
+	snd_soc_dapm_enable_pin(codec, "Front Mic");
+	snd_soc_dapm_enable_pin(codec, "GSM Line In");
+	snd_soc_dapm_enable_pin(codec, "GSM Line Out");
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+static struct snd_soc_ops mioa701_ops;
+
+static struct snd_soc_dai_link mioa701_dai[] = {
+	{
+		.name = "AC97",
+		.stream_name = "AC97 HiFi",
+		.cpu_dai = &pxa_ac97_dai[PXA2XX_DAI_AC97_HIFI],
+		.codec_dai = &wm9713_dai[WM9713_DAI_AC97_HIFI],
+		.init = mioa701_wm9713_init,
+		.ops = &mioa701_ops,
+	},
+	{
+		.name = "AC97 Aux",
+		.stream_name = "AC97 Aux",
+		.cpu_dai = &pxa_ac97_dai[PXA2XX_DAI_AC97_AUX],
+		.codec_dai = &wm9713_dai[WM9713_DAI_AC97_AUX],
+		.ops = &mioa701_ops,
+	},
+};
+
+static struct snd_soc_card mioa701 = {
+	.name = "MioA701",
+	.platform = &pxa2xx_soc_platform,
+	.dai_link = mioa701_dai,
+	.num_links = ARRAY_SIZE(mioa701_dai),
+};
+
+static struct snd_soc_device mioa701_snd_devdata = {
+	.card = &mioa701,
+	.codec_dev = &soc_codec_dev_wm9713,
+};
+
+static struct platform_device *mioa701_snd_device;
+
+static int mioa701_wm9713_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	if (!machine_is_mioa701())
+		return -ENODEV;
+
+	dev_warn(&pdev->dev, "Be warned that incorrect mixes/muxes setup will"
+		 "lead to overheating and possible destruction of your device."
+		 "Do not use without a good knowledge of mio's board design!\n");
+
+	mioa701_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!mioa701_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(mioa701_snd_device, &mioa701_snd_devdata);
+	mioa701_snd_devdata.dev = &mioa701_snd_device->dev;
+
+	ret = platform_device_add(mioa701_snd_device);
+	if (!ret)
+		return 0;
+
+	platform_device_put(mioa701_snd_device);
+	return ret;
+}
+
+static int __devexit mioa701_wm9713_remove(struct platform_device *pdev)
+{
+	platform_device_unregister(mioa701_snd_device);
+	return 0;
+}
+
+static struct platform_driver mioa701_wm9713_driver = {
+	.probe		= mioa701_wm9713_probe,
+	.remove		= __devexit_p(mioa701_wm9713_remove),
+	.driver		= {
+		.name		= "mioa701-wm9713",
+		.owner		= THIS_MODULE,
+	},
+};
+
+static int __init mioa701_asoc_init(void)
+{
+	return platform_driver_register(&mioa701_wm9713_driver);
+}
+
+static void __exit mioa701_asoc_exit(void)
+{
+	platform_driver_unregister(&mioa701_wm9713_driver);
+}
+
+module_init(mioa701_asoc_init);
+module_exit(mioa701_asoc_exit);
+
+/* Module information */
+MODULE_AUTHOR("Robert Jarzmik (rjarzmik@free.fr)");
+MODULE_DESCRIPTION("ALSA SoC WM9713 MIO A701");
+MODULE_LICENSE("GPL");
-- 
1.5.6.5
