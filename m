From: " Koul, Vinod" <vinod.koul@intel.com>
Subject: [RFC 3/4] ASoC SST: add mid machine driver
Date: Tue, 28 Dec 2010 17:41:27 +0530
Message-ID: <1293538287-31918-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 198CF1038BC
	for <alsa-devel@alsa-project.org>; Tue, 28 Dec 2010 13:09:51 +0100 (CET)
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>, broonie@opensource.wolfsonmicro.com, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

This patch adds the mic machine driver
The mid machine driver glues the msic and mid_platfrom driver to form the asoc sound driver

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
---
 sound/soc/mid-x86/mid_machine.c       |  168 +++++++++++++++++++++++++++++++++
 sound/soc/mid-x86/mid_machine.h       |   63 ++++++++++++
 sound/soc/mid-x86/mid_machine_pvt.c   |   81 ++++++++++++++++
 sound/soc/mid-x86/mid_machine_table.h |  154 ++++++++++++++++++++++++++++++
 4 files changed, 466 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/mid-x86/mid_machine.c
 create mode 100644 sound/soc/mid-x86/mid_machine.h
 create mode 100644 sound/soc/mid-x86/mid_machine_pvt.c
 create mode 100644 sound/soc/mid-x86/mid_machine_table.h

diff --git a/sound/soc/mid-x86/mid_machine.c b/sound/soc/mid-x86/mid_machine.c
new file mode 100644
index 0000000..4f4bc0c
--- /dev/null
+++ b/sound/soc/mid-x86/mid_machine.c
@@ -0,0 +1,168 @@
+/*
+ *  mid_machine.c - Intel MID Machine driver
+ *
+ *  Copyright (C) 2010 Intel Corp
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
+#include <linux/module.h>
+#include <linux/device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+#include <sound/intel_sst.h>
+#include "../codecs/msic.h"
+#include "mid_platform.h"
+#include "mid_machine.h"
+#include "mid_machine_table.h"
+
+
+static struct platform_device *mid_platform_device,
+			*mid_codec_device,
+			*mid_soc_device;
+
+struct mid_dev_data	platform_drv_data;
+struct snd_soc_card	soc_dev_data;
+
+
+int __devinit snd_intelmid_mc_probe(struct platform_device *pdev)
+{
+	int ret_val = 0, i;
+	struct codec_id_info *codec;
+	const struct platform_device_id *id = platform_get_device_id(pdev);
+	unsigned int cpu_id, codec_id;
+
+	pr_debug("snd_intelmid_mc_probe called\n");
+
+	codec = (void *)id->driver_data;
+	if (codec == NULL) {
+		pr_err("driver data received as null\n");
+		return 0;
+	}
+
+	codec_id = get_codec_id(codec);
+	cpu_id = codec->cpu_id;
+	pr_debug("**codec id = %d \t ***cpu id = %d\n", codec_id, cpu_id);
+
+	for (i = 0; i < ARRAY_SIZE(machine_table); i++) {
+		struct platform_codec_map mc = machine_table[i];
+		if (mc.cpu_id == cpu_id && mc.codec_id == codec_id) {
+			platform_drv_data.dai = mc.cpu_dai;
+			platform_drv_data.num_dais = mc.cpu_num_dais;
+			ret_val = create_device(&mid_platform_device,
+				mc.platform_name, &platform_drv_data);
+			if (ret_val)
+				return ret_val;
+
+			ret_val = create_device(&mid_codec_device,
+				mc.codec_name, NULL);
+			if (ret_val)
+				goto unreg_platform;
+
+			soc_dev_data.name = mc.soc_name;
+			soc_dev_data.dai_link = mc.dai_link;
+			soc_dev_data.num_links = mc.num_dai_links;
+			/*soc_dev_data.codec_dev = mc.codec_dev;*/
+			ret_val = create_device(&mid_soc_device,
+				"soc-audio", &soc_dev_data);
+			if (ret_val)
+				goto unreg_codec;
+		}
+
+	}
+	if (i > ARRAY_SIZE(machine_table)) {
+		pr_err("no platform and codec found to be registered\n");
+		return -1;
+	}
+	pr_debug("successfully exited probe\n");
+	return ret_val;
+unreg_codec:
+	platform_device_unregister(mid_codec_device);
+unreg_platform:
+	platform_device_unregister(mid_platform_device);
+	return ret_val;
+}
+
+static int snd_intelmid_remove(struct platform_device *pdev)
+{
+	const struct platform_device_id *id = platform_get_device_id(pdev);
+	struct codec_id_info *codec;
+	int i;
+	unsigned int cpu_id, codec_id;
+
+	pr_debug("snd_intelmid_remove called\n");
+
+	codec = (void *)id->driver_data;
+	if (codec == NULL) {
+		pr_err("driver data received as null\n");
+		return 0;
+	}
+	codec_id = get_codec_id(codec);
+	cpu_id = codec->cpu_id;
+	pr_debug("**codec id = %d \t ***cpu id = %d\n", codec_id, cpu_id);
+
+	for (i = 0; i < ARRAY_SIZE(machine_table); i++) {
+		struct platform_codec_map mc = machine_table[i];
+		if (mc.cpu_id == cpu_id && mc.codec_id == codec_id) {
+			platform_device_unregister(mid_soc_device);
+			platform_device_unregister(mid_platform_device);
+			platform_device_unregister(mid_codec_device);
+			platform_set_drvdata(pdev, NULL);
+		}
+	}
+	return 0;
+}
+
+
+static struct platform_driver snd_intelmid_mc_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "mid_sound_card",
+	},
+	.id_table = snd_intelmid_ids,
+	.probe = snd_intelmid_mc_probe,
+	.remove = __devexit_p(snd_intelmid_remove),
+};
+
+static int __init intelmidmc_soc_init(void)
+{
+	pr_debug("intelmidmc_soc_init called\n");
+
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
+MODULE_DESCRIPTION("ASoC Intel(R) MACHINE driver");
+MODULE_AUTHOR("Harsha Priya");
+MODULE_LICENSE("GPL v2");
+
+
diff --git a/sound/soc/mid-x86/mid_machine.h b/sound/soc/mid-x86/mid_machine.h
new file mode 100644
index 0000000..efe693e
--- /dev/null
+++ b/sound/soc/mid-x86/mid_machine.h
@@ -0,0 +1,63 @@
+/*
+ *  mid_machine.h - Intel MID Machine driver header file
+ *
+ *  Copyright (C) 2010 Intel Corp
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
+#define MONO 1
+#define STEREO 2
+#define MAX_CAP 5
+#define DRIVER_NAME_MFLD "msic_audio"
+#define DRIVER_NAME_MRST "pmic_audio"
+#define CPU_CHIP_LINCROFT       1 /* System running lincroft */
+#define CPU_CHIP_PENWELL        2 /* System running penwell */
+#define MSIC_CODEC		3
+
+struct codec_id_info {
+	unsigned int	cpu_id;
+	unsigned int	reg_addr;
+	unsigned int	shift;
+	unsigned int	mask;
+};
+
+struct platform_codec_map {
+	int			cpu_id;
+	int			codec_id;
+	char			*platform_name;
+	char			*codec_name;
+	char			*soc_name;
+	struct snd_soc_dai_driver *cpu_dai;
+	int			cpu_num_dais;
+	struct snd_soc_dai_link *dai_link;
+	int			num_dai_links;
+};
+
+int create_device(struct platform_device **device, char *name,
+				void *drv_data);
+
+int get_codec_id(struct codec_id_info *codec);
+
+#endif
+
diff --git a/sound/soc/mid-x86/mid_machine_pvt.c b/sound/soc/mid-x86/mid_machine_pvt.c
new file mode 100644
index 0000000..71ab0e8
--- /dev/null
+++ b/sound/soc/mid-x86/mid_machine_pvt.c
@@ -0,0 +1,81 @@
+/*
+ *  mid_machine_pvt.c - Intel Machine driver private functions
+ *
+ *  Copyright (C) 2010 Intel Corp
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
+#include <linux/module.h>
+#include <linux/device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+#include "mid_machine.h"
+#include <asm/intel_scu_ipc.h>
+
+int get_codec_id(struct codec_id_info *codec)
+{
+	u8 value;
+	int ret;
+
+	pr_debug("reg id = %d, reg shift = %d, reg mask = %x\n",
+			codec->reg_addr, codec->shift, codec->mask);
+	ret = intel_scu_ipc_ioread8(codec->reg_addr, &value);
+	if (ret)
+		pr_err("scu ipc read failed to read codec vendor reg\n");
+
+	return (value >> codec->shift) & codec->mask;
+}
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
+		pr_err("ERR:%s device allocation failed\n", name);
+		return -ENOMEM;
+	}
+
+	if (drv_data)
+		platform_set_drvdata(*device, drv_data);
+
+	ret_val = platform_device_add(*device);
+	if (ret_val) {
+		pr_err("ERR:Unable to add platform device\n");
+		platform_device_put(*device);
+	}
+	pr_debug("%s...created\n", name);
+	return ret_val;
+}
+
+MODULE_DESCRIPTION("ASoC Intel(R) MACHINE pvt module");
+MODULE_AUTHOR("Harsha Priya");
+MODULE_LICENSE("GPL v2");
+
+
diff --git a/sound/soc/mid-x86/mid_machine_table.h b/sound/soc/mid-x86/mid_machine_table.h
new file mode 100644
index 0000000..7038c1d
--- /dev/null
+++ b/sound/soc/mid-x86/mid_machine_table.h
@@ -0,0 +1,154 @@
+/*
+ *  mid_machine_table.h - Intel Machine driver tables for different platform
+ *  codec combination
+ *
+ *  Copyright (C) 2010 Intel Corp
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
+#ifndef __MID_MACHINE_TABLE_H__
+#define __MID_MACHINE_TABLE_H__
+#include "mid_machine.h"
+
+#define INFO(_cpu_id, _reg_addr, _shift, _mask) \
+	((kernel_ulong_t)&(struct codec_id_info) {	\
+		.cpu_id = (_cpu_id),			\
+		.reg_addr = (_reg_addr),		\
+		.shift = (_shift),			\
+		.mask = (_mask),			\
+	})
+/*MFLD - MSIC*/
+struct snd_soc_dai_driver mfld_dai[] = {
+{
+	.name = "Headset-cpu-dai",
+	.id = 0,
+	.playback = {
+		.channels_min = STEREO,
+		.channels_max = STEREO,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S24_LE,
+	},
+},
+{
+	.name = "Speaker-cpu-dai",
+	.id = 1,
+	.playback = {
+		.channels_min = MONO,
+		.channels_max = STEREO,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S24_LE,
+	},
+},
+{
+	.name = "Vibra 1-cpu-dai",
+	.id = 2,
+	.playback = {
+		.channels_min = MONO,
+		.channels_max = MONO,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S24_LE,
+	},
+},
+{
+	.name = "Vibra 2-cpu-dai",
+	.id = 3,
+	.playback = {
+		.channels_min = MONO,
+		.channels_max = STEREO,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S24_LE,
+	},
+},
+};
+
+struct snd_soc_dai_link mfld_msic_dailink[] = {
+	{
+		.name = "Intel MSIC Headset",
+		.stream_name = "Codec",
+		.cpu_dai_name = "Headset-cpu-dai",
+		.codec_dai_name = "Intel MSIC Headset",
+		.codec_name = "mid-msic-codec",
+		.platform_name = "mid-audio-platform",
+		.init = NULL,
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
+/* MFLD - MSIC END*/
+
+/*add table entry for every platform-codec combination*/
+struct platform_codec_map machine_table[] = {
+	{
+		.cpu_id		= CPU_CHIP_PENWELL,
+		.codec_id	= MSIC_CODEC,
+		.platform_name	= "mid-audio-platform",
+		.codec_name	= "mid-msic-codec",
+		.soc_name	= "mid",
+		.cpu_dai	= mfld_dai,
+		.cpu_num_dais	= ARRAY_SIZE(mfld_dai),
+		.dai_link	= mfld_msic_dailink,
+		.num_dai_links  = ARRAY_SIZE(mfld_msic_dailink),
+		/*the following is exported from your codec file*/
+		/*.codec_dev	= &intel_msic_codec,*/
+		/*.i2c_drv_name	= "mid_virt_i2c_scu", */
+	},
+};
+
+/*driver data
+ ____________
+ * cpu_id,
+ * register addres of codec vendor id,
+ * shift bits to extract vendor id,
+ * mask bits to extract vendor id
+ * */
+static const struct platform_device_id snd_intelmid_ids[] = {
+	{DRIVER_NAME_MRST, INFO(CPU_CHIP_LINCROFT, 0, 0, 0x07)},
+	{DRIVER_NAME_MFLD, INFO(CPU_CHIP_PENWELL, 0, 6, 0x03)},
+	{"", 0},
+};
+
+#endif
+
-- 
1.7.2.3
