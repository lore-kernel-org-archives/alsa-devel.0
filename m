From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 07/14] ASoC: Add OpenFirmware helper for
	matching bus and codec drivers
Date: Tue, 29 Jul 2008 11:42:28 +0100
Message-ID: <1217328155-30158-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1217328155-30158-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-6-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 63CDD2483E
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jul 2008 12:42:41 +0200 (CEST)
In-Reply-To: <1217328155-30158-6-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Grant Likely <grant.likely@secretlab.ca>

Simple utility layer for creating ASoC machine instances based on data
in the OpenFirmware device tree.  OF aware platform drivers and codec
drivers register themselves with this framework and the framework
automatically instantiates a machine driver.  At the moment, the driver
is not very capable and it is expected to be extended as more features
are needed for specifying the configuration in the device tree.

This is most likely temporary glue code to work around limitations in
the ASoC v1 framework.  When v2 is merged, most of this driver will
need to be reworked.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-of-simple.h |   21 +++++
 sound/soc/fsl/Kconfig         |    3 +
 sound/soc/fsl/Makefile        |    3 +
 sound/soc/fsl/soc-of-simple.c |  171 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 198 insertions(+), 0 deletions(-)
 create mode 100644 include/sound/soc-of-simple.h
 create mode 100644 sound/soc/fsl/soc-of-simple.c

diff --git a/include/sound/soc-of-simple.h b/include/sound/soc-of-simple.h
new file mode 100644
index 0000000..696fc51
--- /dev/null
+++ b/include/sound/soc-of-simple.h
@@ -0,0 +1,21 @@
+/*
+ * OF helpers for ALSA SoC
+ *
+ * Copyright (C) 2008, Secret Lab Technologies Ltd.
+ */
+
+#ifndef _INCLUDE_SOC_OF_H_
+#define _INCLUDE_SOC_OF_H_
+
+#include <linux/of.h>
+#include <sound/soc.h>
+
+int of_snd_soc_register_codec(struct snd_soc_codec_device *codec_dev,
+			      void *codec_data, struct snd_soc_dai *dai,
+			      struct device_node *node);
+
+int of_snd_soc_register_platform(struct snd_soc_platform *platform,
+				 struct device_node *node,
+				 struct snd_soc_dai *cpu_dai);
+
+#endif /* _INCLUDE_SOC_OF_H_ */
diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 3368ace..398f002 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -1,3 +1,6 @@
+config SND_SOC_OF_SIMPLE
+	tristate
+
 config SND_SOC_MPC8610
 	bool "ALSA SoC support for the MPC8610 SOC"
 	depends on MPC8610_HPCD
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index 62f680a..aa2100b 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -1,3 +1,6 @@
+# Simple machine driver that extracts configuration from the OF device tree
+obj-$(CONFIG_SND_SOC_OF_SIMPLE) += soc-of-simple.o
+
 # MPC8610 HPCD Machine Support
 obj-$(CONFIG_SND_SOC_MPC8610_HPCD) += mpc8610_hpcd.o
 
diff --git a/sound/soc/fsl/soc-of-simple.c b/sound/soc/fsl/soc-of-simple.c
new file mode 100644
index 0000000..0382fda
--- /dev/null
+++ b/sound/soc/fsl/soc-of-simple.c
@@ -0,0 +1,171 @@
+/*
+ * OF helpers for ALSA SoC Layer
+ *
+ * Copyright (C) 2008, Secret Lab Technologies Ltd.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/bitops.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-of-simple.h>
+#include <sound/initval.h>
+
+MODULE_AUTHOR("Grant Likely <grant.likely@secretlab.ca>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ALSA SoC OpenFirmware bindings");
+
+static DEFINE_MUTEX(of_snd_soc_mutex);
+static LIST_HEAD(of_snd_soc_device_list);
+static int of_snd_soc_next_index;
+
+struct of_snd_soc_device {
+	int id;
+	struct list_head list;
+	struct snd_soc_device device;
+	struct snd_soc_machine machine;
+	struct snd_soc_dai_link dai_link;
+	struct platform_device *pdev;
+	struct device_node *platform_node;
+	struct device_node *codec_node;
+};
+
+static struct snd_soc_ops of_snd_soc_ops = {
+};
+
+static struct of_snd_soc_device *
+of_snd_soc_get_device(struct device_node *codec_node)
+{
+	struct of_snd_soc_device *of_soc;
+
+	list_for_each_entry(of_soc, &of_snd_soc_device_list, list) {
+		if (of_soc->codec_node == codec_node)
+			return of_soc;
+	}
+
+	of_soc = kzalloc(sizeof(struct of_snd_soc_device), GFP_KERNEL);
+	if (!of_soc)
+		return NULL;
+
+	/* Initialize the structure and add it to the global list */
+	of_soc->codec_node = codec_node;
+	of_soc->id = of_snd_soc_next_index++;
+	of_soc->machine.dai_link = &of_soc->dai_link;
+	of_soc->machine.num_links = 1;
+	of_soc->device.machine = &of_soc->machine;
+	of_soc->dai_link.ops = &of_snd_soc_ops;
+	list_add(&of_soc->list, &of_snd_soc_device_list);
+
+	return of_soc;
+}
+
+static void of_snd_soc_register_device(struct of_snd_soc_device *of_soc)
+{
+	struct platform_device *pdev;
+	int rc;
+
+	/* Only register the device if both the codec and platform have
+	 * been registered */
+	if ((!of_soc->device.codec_data) || (!of_soc->platform_node))
+		return;
+
+	pr_info("platform<-->codec match achieved; registering machine\n");
+
+	pdev = platform_device_alloc("soc-audio", of_soc->id);
+	if (!pdev) {
+		pr_err("of_soc: platform_device_alloc() failed\n");
+		return;
+	}
+
+	pdev->dev.platform_data = of_soc;
+	platform_set_drvdata(pdev, &of_soc->device);
+	of_soc->device.dev = &pdev->dev;
+
+	/* The ASoC device is complete; register it */
+	rc = platform_device_add(pdev);
+	if (rc) {
+		pr_err("of_soc: platform_device_add() failed\n");
+		return;
+	}
+
+}
+
+int of_snd_soc_register_codec(struct snd_soc_codec_device *codec_dev,
+			      void *codec_data, struct snd_soc_dai *dai,
+			      struct device_node *node)
+{
+	struct of_snd_soc_device *of_soc;
+	int rc = 0;
+
+	pr_info("registering ASoC codec driver: %s\n", node->full_name);
+
+	mutex_lock(&of_snd_soc_mutex);
+	of_soc = of_snd_soc_get_device(node);
+	if (!of_soc) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	/* Store the codec data */
+	of_soc->device.codec_data = codec_data;
+	of_soc->device.codec_dev = codec_dev;
+	of_soc->dai_link.name = (char *)node->name;
+	of_soc->dai_link.stream_name = (char *)node->name;
+	of_soc->dai_link.codec_dai = dai;
+
+	/* Now try to register the SoC device */
+	of_snd_soc_register_device(of_soc);
+
+ out:
+	mutex_unlock(&of_snd_soc_mutex);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(of_snd_soc_register_codec);
+
+int of_snd_soc_register_platform(struct snd_soc_platform *platform,
+				 struct device_node *node,
+				 struct snd_soc_dai *cpu_dai)
+{
+	struct of_snd_soc_device *of_soc;
+	struct device_node *codec_node;
+	const phandle *handle;
+	int len, rc = 0;
+
+	pr_info("registering ASoC platform driver: %s\n", node->full_name);
+
+	handle = of_get_property(node, "codec-handle", &len);
+	if (!handle || len < sizeof(handle))
+		return -ENODEV;
+	codec_node = of_find_node_by_phandle(*handle);
+	if (!codec_node)
+		return -ENODEV;
+	pr_info("looking for codec: %s\n", codec_node->full_name);
+
+	mutex_lock(&of_snd_soc_mutex);
+	of_soc = of_snd_soc_get_device(codec_node);
+	if (!of_soc) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	of_soc->platform_node = node;
+	of_soc->dai_link.cpu_dai = cpu_dai;
+	of_soc->device.platform = platform;
+	of_soc->machine.name = of_soc->dai_link.cpu_dai->name;
+
+	/* Now try to register the SoC device */
+	of_snd_soc_register_device(of_soc);
+
+ out:
+	mutex_unlock(&of_snd_soc_mutex);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(of_snd_soc_register_platform);
-- 
1.5.6.3
