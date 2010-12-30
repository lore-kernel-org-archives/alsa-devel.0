From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/4] ASoC sst: Add mid machine driver
Date: Thu, 30 Dec 2010 16:43:13 +0530
Message-ID: <1293707593-8372-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C8AE243FF
	for <alsa-devel@alsa-project.org>; Thu, 30 Dec 2010 12:11:31 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@opensource.wolfsonmicro.com, Vinod Koul <vinod.koul@intel.com>, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

This patch adds the mic machine driver
The mid machine driver glues the msic and mid_platfrom driver to form the asoc sound driver

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
---
 sound/soc/mid-x86/mid_machine.c     |  317 +++++++++++++++++++++++++++++++++++
 sound/soc/mid-x86/mid_machine.h     |   37 ++++
 sound/soc/mid-x86/mid_machine_lib.c |   54 ++++++
 3 files changed, 408 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/mid-x86/mid_machine.c
 create mode 100644 sound/soc/mid-x86/mid_machine.h
 create mode 100644 sound/soc/mid-x86/mid_machine_lib.c

diff --git a/sound/soc/mid-x86/mid_machine.c b/sound/soc/mid-x86/mid_machine.c
new file mode 100644
index 0000000..36786ce
--- /dev/null
+++ b/sound/soc/mid-x86/mid_machine.c
@@ -0,0 +1,317 @@
+/*
+ *  mid_machine.c - Intel MID Machine driver
+ *
+ *  Copyright (C) 2010 Intel Corp
+ *  Author: Vinod Koul <vinod.koul@intel.com>
+ *  Author: Harsha Priya <priya.harsha@intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include "../codecs/msic.h"
+#include "mid_machine.h"
+
+struct mid_mfld_device {
+	struct platform_device *mid_platform_device;
+	struct platform_device *mid_codec_device;
+	struct platform_device *mid_soc_device;
+};
+
+static unsigned int	hs_switch;
+static unsigned int	lo_dac;
+
+/*sound card controls*/
+static const char *headset_switch_text[] = {"Earpiece", "Headset"};
+
+static const char *lo_text[] = {"Vibra", "Headset", "IHF", "None"};
+
+static const struct soc_enum headset_enum =
+	SOC_ENUM_SINGLE_EXT(2, headset_switch_text);
+
+static const struct soc_enum lo_enum =
+	SOC_ENUM_SINGLE_EXT(4, lo_text);
+
+static int headset_get_switch(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = hs_switch;
+	return 0;
+}
+
+static int headset_set_switch(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+
+	if (ucontrol->value.integer.value[0] == hs_switch)
+		return 0;
+
+	if (ucontrol->value.integer.value[0]) {
+		pr_debug("hs_set HS path\n");
+		snd_soc_dapm_enable_pin(&codec->dapm, "HPOUTL");
+		snd_soc_dapm_enable_pin(&codec->dapm, "HPOUTR");
+		snd_soc_dapm_disable_pin(&codec->dapm, "EPOUT");
+	} else {
+		pr_debug("hs_set EP path\n");
+		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTL");
+		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTR");
+		snd_soc_dapm_enable_pin(&codec->dapm, "EPOUT");
+	}
+	snd_soc_dapm_sync(&codec->dapm);
+	hs_switch = ucontrol->value.integer.value[0];
+
+	return 0;
+}
+
+static void lo_enable_out_pins(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_enable_pin(&codec->dapm, "IHFOUTL");
+	snd_soc_dapm_enable_pin(&codec->dapm, "IHFOUTR");
+	snd_soc_dapm_enable_pin(&codec->dapm, "LINEOUTL");
+	snd_soc_dapm_enable_pin(&codec->dapm, "LINEOUTR");
+	snd_soc_dapm_enable_pin(&codec->dapm, "VIB1OUT");
+	snd_soc_dapm_enable_pin(&codec->dapm, "VIB2OUT");
+	if (hs_switch) {
+		snd_soc_dapm_enable_pin(&codec->dapm, "HPOUTL");
+		snd_soc_dapm_enable_pin(&codec->dapm, "HPOUTR");
+		snd_soc_dapm_disable_pin(&codec->dapm, "EPOUT");
+	} else {
+		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTL");
+		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTR");
+		snd_soc_dapm_enable_pin(&codec->dapm, "EPOUT");
+	}
+}
+
+static int lo_get_switch(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = lo_dac;
+	return 0;
+}
+
+static int lo_set_switch(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+
+	if (ucontrol->value.integer.value[0] == lo_dac)
+		return 0;
+
+	/*
+	 * we dont want to work with last state of lineout so just enable all
+	 * pins and then disable pins not required
+	 */
+	lo_enable_out_pins(codec);
+	switch (ucontrol->value.integer.value[0]) {
+	case 0:
+		pr_debug("set vibra path\n");
+		snd_soc_dapm_disable_pin(&codec->dapm, "VIB1OUT");
+		snd_soc_dapm_disable_pin(&codec->dapm, "VIB2OUT");
+		snd_soc_update_bits(codec, MSIC_LOCTL, 0x66, 0);
+		break;
+
+	case 1:
+		pr_debug("set hs  path\n");
+		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTL");
+		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTR");
+		snd_soc_dapm_disable_pin(&codec->dapm, "EPOUT");
+		snd_soc_update_bits(codec, MSIC_LOCTL, 0x66, 0x22);
+		break;
+
+	case 2:
+		pr_debug("set spkr path\n");
+		snd_soc_dapm_disable_pin(&codec->dapm, "IHFOUTL");
+		snd_soc_dapm_disable_pin(&codec->dapm, "IHFOUTR");
+		snd_soc_update_bits(codec, MSIC_LOCTL, 0x66, 0x44);
+		break;
+
+	case 3:
+		pr_debug("set null path\n");
+		snd_soc_dapm_disable_pin(&codec->dapm, "LINEOUTL");
+		snd_soc_dapm_disable_pin(&codec->dapm, "LINEOUTR");
+		snd_soc_update_bits(codec, MSIC_LOCTL, 0x66, 0x66);
+		break;
+	}
+	snd_soc_dapm_sync(&codec->dapm);
+	lo_dac = ucontrol->value.integer.value[0];
+	return 0;
+}
+
+static const struct snd_kcontrol_new mid_snd_controls[] = {
+	SOC_ENUM_EXT("Playback Switch", headset_enum,
+			headset_get_switch, headset_set_switch),
+	SOC_ENUM_EXT("Lineout Mux", lo_enum,
+			lo_get_switch, lo_set_switch),
+};
+
+static int msic_init(struct snd_soc_pcm_runtime *runtime)
+{
+	struct snd_soc_codec *codec = runtime->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	int ret_val;
+
+	ret_val = snd_soc_add_controls(codec, mid_snd_controls,
+				ARRAY_SIZE(mid_snd_controls));
+	if (ret_val) {
+		pr_err("soc_add_controls failed %d", ret_val);
+		return ret_val;
+	}
+	/*default is earpiece pin, userspace sets it explcitly*/
+	snd_soc_dapm_disable_pin(dapm, "HPOUTL");
+	snd_soc_dapm_disable_pin(dapm, "HPOUTR");
+	/*default is lineout NC, userspace sets it explcitly*/
+	snd_soc_dapm_disable_pin(dapm, "LINEOUTL");
+	snd_soc_dapm_disable_pin(dapm, "LINEOUTR");
+	return snd_soc_dapm_sync(dapm);
+	lo_dac = 3;
+	hs_switch = 0;
+}
+
+struct snd_soc_dai_link mfld_msic_dailink[] = {
+	{
+		.name = "Intel MSIC Headset",
+		.stream_name = "Codec",
+		.cpu_dai_name = "Headset-cpu-dai",
+		.codec_dai_name = "Intel MSIC Headset",
+		.codec_name = "mid-msic-codec",
+		.platform_name = "mid-audio-platform",
+		.init = msic_init,
+	},
+	{
+		.name = "Intel MSIC Speaker",
+		.stream_name = "Speaker",
+		.cpu_dai_name = "Speaker-cpu-dai",
+		.codec_dai_name = "Intel MSIC Speaker",
+		.codec_name = "mid-msic-codec",
+		.platform_name = "mid-audio-platform",
+		.init = NULL,
+	},
+	{
+		.name = "Intel MSIC Vibra1",
+		.stream_name = "Vibra1",
+		.cpu_dai_name = "Vibra 1-cpu-dai",
+		.codec_dai_name = "Intel MSIC Vibra1",
+		.codec_name = "mid-msic-codec",
+		.platform_name = "mid-audio-platform",
+		.init = NULL,
+	},
+	{
+		.name = "Intel MSIC Vibra2",
+		.stream_name = "Vibra2",
+		.cpu_dai_name = "Vibra 2-cpu-dai",
+		.codec_dai_name = "Intel MSIC Vibra2",
+		.codec_name =  "mid-msic-codec",
+		.platform_name = "mid-audio-platform",
+		.init = NULL,
+	},
+};
+
+/* SoC card */
+static struct snd_soc_card snd_soc_card_mfld = {
+	.name = "mid_msic_audio",
+	.dai_link = mfld_msic_dailink,
+	.num_links = ARRAY_SIZE(mfld_msic_dailink),
+};
+
+int __devinit snd_intelmid_mc_probe(struct platform_device *pdev)
+{
+	struct mid_mfld_device *dev_data;
+	int ret_val = 0;
+
+	pr_debug("snd_intelmid_mc_probe called\n");
+
+	dev_data = kzalloc(sizeof(*dev_data), GFP_KERNEL);
+	if (!dev_data) {
+		pr_err("snd_intelmid_mc_probe mem alloc fail\n");
+		return -ENOMEM;
+	}
+
+	ret_val = create_device(&dev_data->mid_platform_device,
+		"mid-audio-platform", NULL);
+	if (ret_val)
+		return ret_val;
+
+	ret_val = create_device(&dev_data->mid_codec_device,
+			"mid-msic-codec", NULL);
+	if (ret_val)
+		goto unreg_platform;
+
+	ret_val = create_device(&dev_data->mid_soc_device,
+			"soc-audio", &snd_soc_card_mfld);
+	if (ret_val)
+		goto unreg_codec;
+
+	platform_set_drvdata(pdev, dev_data);
+
+	pr_debug("successfully exited probe\n");
+	return ret_val;
+unreg_codec:
+	platform_device_unregister(dev_data->mid_codec_device);
+unreg_platform:
+	platform_device_unregister(dev_data->mid_platform_device);
+	return ret_val;
+}
+
+static int snd_intelmid_remove(struct platform_device *pdev)
+{
+	struct mid_mfld_device *dev_data =  platform_get_drvdata(pdev);
+	pr_debug("snd_intelmid_remove called\n");
+
+	platform_device_unregister(dev_data->mid_soc_device);
+	platform_device_unregister(dev_data->mid_platform_device);
+	platform_device_unregister(dev_data->mid_codec_device);
+	platform_set_drvdata(pdev, NULL);
+	return 0;
+}
+
+static struct platform_driver snd_intelmid_mc_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "msic_audio",
+	},
+	.probe = snd_intelmid_mc_probe,
+	.remove = __devexit_p(snd_intelmid_remove),
+};
+
+static int __init intelmidmc_soc_init(void)
+{
+	pr_debug("intelmidmc_soc_init called\n");
+	return platform_driver_register(&snd_intelmid_mc_driver);
+}
+module_init(intelmidmc_soc_init);
+
+static void __exit intelmidmc_soc_exit(void)
+{
+	pr_debug("intelmidmc_soc_exit called\n");
+	platform_driver_unregister(&snd_intelmid_mc_driver);
+}
+module_exit(intelmidmc_soc_exit);
+
+MODULE_DESCRIPTION("ASoC Intel(R) MID Machine driver");
+MODULE_AUTHOR("Vinod Koul <vinod.koul@intel.com>");
+MODULE_AUTHOR("Harsha Priya <priya.harsha@intel.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("mid-machine");
diff --git a/sound/soc/mid-x86/mid_machine.h b/sound/soc/mid-x86/mid_machine.h
new file mode 100644
index 0000000..34dbbdd
--- /dev/null
+++ b/sound/soc/mid-x86/mid_machine.h
@@ -0,0 +1,37 @@
+/*
+ *  mid_machine.h - Intel MID Machine driver header file
+ *
+ *  Copyright (C) 2010 Intel Corp
+ *  Author: Vinod Koul <vinod.koul@intel.com>
+ *  Author: Harsha Priya <priya.harsha@intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *
+ */
+
+#ifndef __MID_MACHINEDRV_H__
+#define __MID_MACHINEDRV_H__
+
+#define MID_MONO 1
+#define MID_STEREO 2
+#define MID_MAX_CAP 5
+
+int create_device(struct platform_device **device, char *name,
+				void *drv_data);
+#endif
+
diff --git a/sound/soc/mid-x86/mid_machine_lib.c b/sound/soc/mid-x86/mid_machine_lib.c
new file mode 100644
index 0000000..fce2861
--- /dev/null
+++ b/sound/soc/mid-x86/mid_machine_lib.c
@@ -0,0 +1,54 @@
+/*
+ *  mid_machine_lib.c - Intel Machine driver library functions
+ *  should be reused in other mid machine drivers
+ *
+ *  Copyright (C) 2010 Intel Corp
+ *  Author: Vinod Koul <vinod.koul@intel.com>
+ *  Author: Harsha Priya <priya.harsha@intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/platform_device.h>
+
+int create_device(struct platform_device **device, char *name,
+				void *drv_data)
+{
+	int ret_val = 0;
+
+	pr_debug("%s device creation...", name);
+
+	*device = platform_device_alloc(name, -1);
+	if (!*device) {
+		pr_err("%s device allocation failed\n", name);
+		return -ENOMEM;
+	}
+
+	if (drv_data)
+		platform_set_drvdata(*device, drv_data);
+
+	ret_val = platform_device_add(*device);
+	if (ret_val) {
+		pr_err("Unable to add platform device\n");
+		platform_device_put(*device);
+	}
+	pr_debug("%s...created\n", name);
+	return ret_val;
+}
-- 
1.7.2.3
