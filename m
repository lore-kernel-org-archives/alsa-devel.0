From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 03/19] ASoC: mrst_machine: add moorestown
	machine driver
Date: Wed, 04 May 2011 21:45:09 +0800
Message-ID: <20110504134509.32443.32365.stgit@localhost>
References: <20110504133756.32443.6282.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 19FDD103941
	for <alsa-devel@alsa-project.org>;
	Wed,  4 May 2011 15:43:50 +0200 (CEST)
In-Reply-To: <20110504133756.32443.6282.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Lu Guanqun <guanqun.lu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Koul Vinod <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

This machine driver glues upd9976 codec driver and sst_platform driver.

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
---
 sound/soc/mid-x86/Kconfig        |   12 +++
 sound/soc/mid-x86/Makefile       |    2 
 sound/soc/mid-x86/mrst_machine.c |  163 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/mid-x86/mrst_machine.c

diff --git a/sound/soc/mid-x86/Kconfig b/sound/soc/mid-x86/Kconfig
index 2935042..f76acba 100644
--- a/sound/soc/mid-x86/Kconfig
+++ b/sound/soc/mid-x86/Kconfig
@@ -10,5 +10,17 @@ config SND_MFLD_MACHINE
           Say Y if you have such a device
           If unsure select "N".
 
+config SND_MRST_MACHINE
+	tristate "SoC Machine Audio Driver for Intel Moorestown Platform"
+	depends on INTEL_SCU_IPC
+	depends on SND_INTEL_SST
+	select SND_SOC_UPD9976
+	select SND_SST_PLATFORM
+	help
+	  This adds support for ASoC machine driver for Intel(R) MID Moorestown platform.
+	  It is used as ALSA device in audio substream in Intel(R) MID devices.
+	  Say Y if you have such a device.
+	  If unsure, select 'N'.
+
 config SND_SST_PLATFORM
 	tristate
diff --git a/sound/soc/mid-x86/Makefile b/sound/soc/mid-x86/Makefile
index 6398833..d0f2c29 100644
--- a/sound/soc/mid-x86/Makefile
+++ b/sound/soc/mid-x86/Makefile
@@ -1,5 +1,7 @@
 snd-soc-sst-platform-objs := sst_platform.o
 snd-soc-mfld-machine-objs := mfld_machine.o
+snd-soc-mrst-machine-objs := mrst_machine.o
 
 obj-$(CONFIG_SND_SST_PLATFORM) += snd-soc-sst-platform.o
 obj-$(CONFIG_SND_MFLD_MACHINE) += snd-soc-mfld-machine.o
+obj-$(CONFIG_SND_MRST_MACHINE) += snd-soc-mrst-machine.o
diff --git a/sound/soc/mid-x86/mrst_machine.c b/sound/soc/mid-x86/mrst_machine.c
new file mode 100644
index 0000000..11163e7
--- /dev/null
+++ b/sound/soc/mid-x86/mrst_machine.c
@@ -0,0 +1,163 @@
+/*
+ *  mrst_machine.c - ASoC Machine driver for Intel Moorestown MID platform
+ *
+ *  Copyright (C) 2011 Intel Corporation
+ *
+ *  Maintainer:
+ *              Lu Guanqun <guanqun.lu@intel.com>
+ *              Wang Xingchao <xingchao.wang@intel.com>
+ *
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
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+static const struct snd_soc_dapm_widget mrst_audio_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+};
+
+static const struct snd_soc_dapm_route mrst_audio_map[] = {
+	{"HPINL", NULL, "PREOUTL"},
+	{"HPINR", NULL, "PREOUTR"},
+
+	{"Headphone", NULL, "HPOUTL"},
+	{"Headphone", NULL, "HPOUTR"},
+};
+
+static int mrst_audio_init(struct snd_soc_pcm_runtime *runtime)
+{
+	struct snd_soc_codec *codec = runtime->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	int ret;
+
+	ret = snd_soc_dapm_new_controls(dapm,
+					mrst_audio_widgets,
+					ARRAY_SIZE(mrst_audio_widgets));
+	if (ret)
+		return ret;
+
+	ret = snd_soc_dapm_add_routes(dapm,
+				      mrst_audio_map,
+				      ARRAY_SIZE(mrst_audio_map));
+	if (ret)
+		return ret;
+
+	snd_soc_dapm_nc_pin(dapm, "LINEINL");
+	snd_soc_dapm_nc_pin(dapm, "LINEINR");
+	snd_soc_dapm_nc_pin(dapm, "LINEOUTL");
+	snd_soc_dapm_nc_pin(dapm, "LINEOUTR");
+
+	snd_soc_dapm_enable_pin(dapm, "Headphone");
+
+	snd_soc_dapm_sync(dapm);
+
+	return 0;
+}
+
+static int mrst_hw_params(struct snd_pcm_substream *substream,
+			  struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret;
+
+	ret = snd_soc_dai_set_fmt(codec_dai,
+				  SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM);
+
+	return ret;
+}
+
+static struct snd_soc_ops mrst_audio_ops = {
+	.hw_params = mrst_hw_params,
+};
+
+struct snd_soc_dai_link mrst_dailinks[] = {
+	{
+		.name = "Moorestown Audio",
+		.stream_name = "Audio",
+		.cpu_dai_name = "mrst-cpu-pcm2",
+		.codec_dai_name = "upd9976-audio",
+		.codec_name = "upd9976",
+		.platform_name = "sst-platform",
+		.init = mrst_audio_init,
+		.ops = &mrst_audio_ops,
+	},
+};
+
+static struct snd_soc_card snd_soc_card_mrst = {
+	.name = "moorestown_audio",
+	.dai_link = mrst_dailinks,
+	.num_links = ARRAY_SIZE(mrst_dailinks),
+};
+
+static int __devinit snd_mrst_audio_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	snd_soc_card_mrst.dev = &pdev->dev;
+	ret = snd_soc_register_card(&snd_soc_card_mrst);
+	if (ret)
+		goto fail_register_card;
+
+	return 0;
+
+fail_register_card:
+	return ret;
+}
+
+static int __devexit snd_mrst_audio_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_card(&snd_soc_card_mrst);
+	return 0;
+}
+
+static struct platform_driver snd_mrst_audio_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "pmic_audio",
+	},
+	.probe = snd_mrst_audio_probe,
+	.remove = __devexit_p(snd_mrst_audio_remove),
+};
+
+static int __init snd_mrst_driver_init(void)
+{
+	return platform_driver_register(&snd_mrst_audio_driver);
+}
+module_init(snd_mrst_driver_init);
+
+static void __exit snd_mrst_driver_exit(void)
+{
+	platform_driver_unregister(&snd_mrst_audio_driver);
+}
+module_exit(snd_mrst_driver_exit);
+
+MODULE_DESCRIPTION("ASoC Intel(R) MID Moorestown Machine Driver");
+MODULE_AUTHOR("Lu Guanqun <guanqun.lu@intel.com>");
+MODULE_AUTHOR("Wang Xingchao <xingchao.wang@intel.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:mrst-audio");
