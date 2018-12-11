From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 12/14] ASoC: SOF: Add Nocodec machine driver
	support
Date: Tue, 11 Dec 2018 15:23:16 -0600
Message-ID: <20181211212318.28644-13-pierre-louis.bossart@linux.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Daniel Baluta <daniel.baluta@gmail.com>, andriy.shevchenko@intel.com, tiwai@suse.de, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

Add a simple "fallback" machine driver that can be used to enable SOF
on boards with no codec device. This machine driver can also be forced
for debug/development.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/sof.h     | 10 +++++
 sound/soc/sof/nocodec.c | 81 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 sound/soc/sof/nocodec.c

diff --git a/include/sound/sof.h b/include/sound/sof.h
index 371a14cb4a56..4ed6e2379141 100644
--- a/include/sound/sof.h
+++ b/include/sound/sof.h
@@ -12,6 +12,7 @@
 #define __INCLUDE_SOUND_SOF_H
 
 #include <linux/pci.h>
+#include <sound/soc.h>
 #include <sound/soc-acpi.h>
 
 struct snd_sof_dsp_ops;
@@ -78,4 +79,13 @@ struct sof_dev_desc {
 	const char *nocodec_tplg_filename;
 };
 
+int sof_nocodec_setup(struct device *dev,
+		      struct snd_sof_pdata *sof_pdata,
+		      struct snd_soc_acpi_mach *mach,
+		      const struct sof_dev_desc *desc,
+		      struct snd_sof_dsp_ops *ops);
+
+int sof_bes_setup(struct device *dev, struct snd_sof_dsp_ops *ops,
+		  struct snd_soc_dai_link *links, int link_num,
+		  struct snd_soc_card *card);
 #endif
diff --git a/sound/soc/sof/nocodec.c b/sound/soc/sof/nocodec.c
new file mode 100644
index 000000000000..686324b30a57
--- /dev/null
+++ b/sound/soc/sof/nocodec.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license.  When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2018 Intel Corporation. All rights reserved.
+//
+// Author: Liam Girdwood <liam.r.girdwood@linux.intel.com>
+//
+
+#include <linux/module.h>
+#include <sound/sof.h>
+#include "sof-priv.h"
+
+static struct snd_soc_card sof_nocodec_card = {
+	.name = "nocodec", /* the sof- prefix is added by the core */
+};
+
+int sof_nocodec_setup(struct device *dev,
+		      struct snd_sof_pdata *sof_pdata,
+		      struct snd_soc_acpi_mach *mach,
+		      const struct sof_dev_desc *desc,
+		      struct snd_sof_dsp_ops *ops)
+{
+	struct snd_soc_dai_link *links;
+	int ret;
+
+	if (!mach)
+		return -EINVAL;
+
+	sof_pdata->drv_name = "sof-nocodec";
+
+	mach->drv_name = "sof-nocodec";
+	mach->sof_fw_filename = desc->nocodec_fw_filename;
+	mach->sof_tplg_filename = desc->nocodec_tplg_filename;
+
+	/* create dummy BE dai_links */
+	links = devm_kzalloc(dev, sizeof(struct snd_soc_dai_link) *
+			     ops->num_drv, GFP_KERNEL);
+	if (!links)
+		return -ENOMEM;
+
+	ret = sof_bes_setup(dev, ops, links, ops->num_drv,
+			    &sof_nocodec_card);
+	if (ret) {
+		kfree(links);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(sof_nocodec_setup);
+
+static int sof_nocodec_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &sof_nocodec_card;
+
+	card->dev = &pdev->dev;
+
+	return devm_snd_soc_register_card(&pdev->dev, card);
+}
+
+static int sof_nocodec_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver sof_nocodec_audio = {
+	.probe = sof_nocodec_probe,
+	.remove = sof_nocodec_remove,
+	.driver = {
+		.name = "sof-nocodec",
+		.pm = &snd_soc_pm_ops,
+	},
+};
+module_platform_driver(sof_nocodec_audio)
+
+MODULE_DESCRIPTION("ASoC sof nocodec");
+MODULE_AUTHOR("Liam Girdwood");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_ALIAS("platform:sof-nocodec");
-- 
2.17.1
