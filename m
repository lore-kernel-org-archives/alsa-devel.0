From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 4/4] ALSA: add Studio Evolution SE6X support
Date: Fri, 16 Jan 2015 22:16:35 +0100
Message-ID: <54B97FB3.7080609@ladisch.de>
References: <54B97EEB.8060108@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id AF4232656F3
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 22:17:22 +0100 (CET)
In-Reply-To: <54B97EEB.8060108@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add a driver for an embedded sound card.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/pci/Kconfig         |    9 +++
 sound/pci/oxygen/Makefile |    2 +
 sound/pci/oxygen/se6x.c   |  160 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+)
 create mode 100644 sound/pci/oxygen/se6x.c

diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index 50dd008..edfc1b8 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -793,6 +793,15 @@ config SND_RME9652
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-rme9652.

+config SND_SE6X
+	tristate "Studio Evolution SE6X"
+	depends on SND_OXYGEN=n && SND_VIRTUOSO=n  # PCI ID conflict
+	select SND_OXYGEN_LIB
+	select SND_PCM
+	select SND_MPU401_UART
+	help
+	  Say Y or M here only if you actually have this sound card.
+
 config SND_SIS7019
 	tristate "SiS 7019 Audio Accelerator"
 	depends on X86_32
diff --git a/sound/pci/oxygen/Makefile b/sound/pci/oxygen/Makefile
index 8f4c409..ab085d7 100644
--- a/sound/pci/oxygen/Makefile
+++ b/sound/pci/oxygen/Makefile
@@ -1,8 +1,10 @@
 snd-oxygen-lib-objs := oxygen_io.o oxygen_lib.o oxygen_mixer.o oxygen_pcm.o
 snd-oxygen-objs := oxygen.o xonar_dg_mixer.o xonar_dg.o
+snd-se6x-objs := se6x.o
 snd-virtuoso-objs := virtuoso.o xonar_lib.o \
 	xonar_pcm179x.o xonar_cs43xx.o xonar_wm87x6.o xonar_hdmi.o

 obj-$(CONFIG_SND_OXYGEN_LIB) += snd-oxygen-lib.o
 obj-$(CONFIG_SND_OXYGEN) += snd-oxygen.o
+obj-$(CONFIG_SND_SE6X) += snd-se6x.o
 obj-$(CONFIG_SND_VIRTUOSO) += snd-virtuoso.o
diff --git a/sound/pci/oxygen/se6x.c b/sound/pci/oxygen/se6x.c
new file mode 100644
index 0000000..f70d514
--- /dev/null
+++ b/sound/pci/oxygen/se6x.c
@@ -0,0 +1,160 @@
+/*
+ * C-Media CMI8787 driver for the Studio Evolution SE6X
+ *
+ * Copyright (c) Clemens Ladisch <clemens@ladisch.de>
+ *
+ *  This driver is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License, version 2.
+ *
+ *  This driver is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this driver; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * CMI8787:
+ *
+ *   SPI    -> microcontroller (not actually used)
+ *   GPIO 0 -> do.
+ *   GPIO 2 -> do.
+ *
+ *   DAC0   -> both PCM1792A (L+R, each in mono mode)
+ *   ADC1  <-  1st PCM1804
+ *   ADC2  <-  2nd PCM1804
+ *   ADC3  <-  3rd PCM1804
+ */
+
+#include <linux/pci.h>
+#include <linux/module.h>
+#include <sound/core.h>
+#include <sound/control.h>
+#include <sound/initval.h>
+#include <sound/pcm.h>
+#include "oxygen.h"
+
+MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
+MODULE_DESCRIPTION("Studio Evolution SE6X driver");
+MODULE_LICENSE("GPL v2");
+MODULE_SUPPORTED_DEVICE("{{Studio Evolution,SE6X}}");
+
+static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
+static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
+static bool enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
+
+module_param_array(index, int, NULL, 0444);
+MODULE_PARM_DESC(index, "card index");
+module_param_array(id, charp, NULL, 0444);
+MODULE_PARM_DESC(id, "ID string");
+module_param_array(enable, bool, NULL, 0444);
+MODULE_PARM_DESC(enable, "enable card");
+
+static const struct pci_device_id se6x_ids[] = {
+	{ OXYGEN_PCI_SUBID(0x13f6, 0x8788) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, se6x_ids);
+
+static void se6x_init(struct oxygen *chip)
+{
+	oxygen_set_bits16(chip, OXYGEN_GPIO_CONTROL, 0x005);
+
+	snd_component_add(chip->card, "PCM1792A");
+	snd_component_add(chip->card, "PCM1804");
+}
+
+static int se6x_control_filter(struct snd_kcontrol_new *template)
+{
+	/* no DAC volume/mute */
+	if (!strncmp(template->name, "Master Playback ", 16))
+		return 1;
+	return 0;
+}
+
+static void se6x_cleanup(struct oxygen *chip)
+{
+}
+
+static void set_pcm1792a_params(struct oxygen *chip,
+				struct snd_pcm_hw_params *params)
+{
+	/* nothing to do (the microcontroller monitors DAC_LRCK) */
+}
+
+static void set_pcm1804_params(struct oxygen *chip,
+			       struct snd_pcm_hw_params *params)
+{
+}
+
+static unsigned int se6x_adjust_dac_routing(struct oxygen *chip,
+					    unsigned int play_routing)
+{
+	/* route the same stereo pair to DAC0 and DAC1 */
+	return ( play_routing       & OXYGEN_PLAY_DAC0_SOURCE_MASK) |
+	       ((play_routing << 2) & OXYGEN_PLAY_DAC1_SOURCE_MASK);
+}
+
+static const struct oxygen_model model_se6x = {
+	.shortname = "Studio Evolution SE6X",
+	.longname = "C-Media Oxygen HD Audio",
+	.chip = "CMI8787",
+	.init = se6x_init,
+	.control_filter = se6x_control_filter,
+	.cleanup = se6x_cleanup,
+	.set_dac_params = set_pcm1792a_params,
+	.set_adc_params = set_pcm1804_params,
+	.adjust_dac_routing = se6x_adjust_dac_routing,
+	.device_config = PLAYBACK_0_TO_I2S |
+			 CAPTURE_0_FROM_I2S_1 |
+			 CAPTURE_2_FROM_I2S_2 |
+			 CAPTURE_3_FROM_I2S_3,
+	.dac_channels_pcm = 2,
+	.function_flags = OXYGEN_FUNCTION_SPI,
+	.dac_mclks = OXYGEN_MCLKS(256, 128, 128),
+	.adc_mclks = OXYGEN_MCLKS(256, 256, 128),
+	.dac_i2s_format = OXYGEN_I2S_FORMAT_LJUST,
+	.adc_i2s_format = OXYGEN_I2S_FORMAT_I2S,
+};
+
+static int se6x_get_model(struct oxygen *chip,
+			  const struct pci_device_id *pci_id)
+{
+	chip->model = model_se6x;
+	return 0;
+}
+
+static int se6x_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
+{
+	static int dev;
+	int err;
+
+	if (dev >= SNDRV_CARDS)
+		return -ENODEV;
+	if (!enable[dev]) {
+		++dev;
+		return -ENOENT;
+	}
+	err = oxygen_pci_probe(pci, index[dev], id[dev], THIS_MODULE,
+			       se6x_ids, se6x_get_model);
+	if (err >= 0)
+		++dev;
+	return err;
+}
+
+static struct pci_driver se6x_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = se6x_ids,
+	.probe = se6x_probe,
+	.remove = oxygen_pci_remove,
+#ifdef CONFIG_PM_SLEEP
+	.driver = {
+		.pm = &oxygen_pci_pm,
+	},
+#endif
+	.shutdown = oxygen_pci_shutdown,
+};
+
+module_pci_driver(se6x_driver);
