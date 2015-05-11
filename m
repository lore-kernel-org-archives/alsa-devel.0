From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v4 1/7] ASoC: hda - add ASoC HDA codec match
	function
Date: Mon, 11 May 2015 16:23:59 +0530
Message-ID: <1431341645-2457-2-git-send-email-vinod.koul@intel.com>
References: <1431341645-2457-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 7071B261AA0
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 12:53:31 +0200 (CEST)
In-Reply-To: <1431341645-2457-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

ASoC hda codec driver will use id_table for registration.
id_table has info of codec vendor_id, revision_id and name.
For ASoC device/driver matching, device vendor_id, rev_id
will be matched to id_table to identify the device/driver.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/soc-hda-codec.h | 49 ++++++++++++++++++++++++
 sound/soc/Kconfig             |  1 +
 sound/soc/Makefile            |  1 +
 sound/soc/hda/Kconfig         |  3 ++
 sound/soc/hda/Makefile        |  3 ++
 sound/soc/hda/soc-hda-codec.c | 89 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 146 insertions(+)
 create mode 100644 include/sound/soc-hda-codec.h
 create mode 100644 sound/soc/hda/Kconfig
 create mode 100644 sound/soc/hda/Makefile
 create mode 100644 sound/soc/hda/soc-hda-codec.c

diff --git a/include/sound/soc-hda-codec.h b/include/sound/soc-hda-codec.h
new file mode 100644
index 000000000000..850430a3855b
--- /dev/null
+++ b/include/sound/soc-hda-codec.h
@@ -0,0 +1,49 @@
+/*
+ * ASoC High Definition Audio Codec interface Definitions
+ *
+ * Copyright (c) 2014-2015 Intel Corporation
+ *
+ * Author(s): Jeeja KP <jeeja.kp@intel.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the Free
+ *  Software Foundation; either version 2 of the License, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ *  more details.
+ *
+ */
+
+#ifndef __SOUND_SOC_HDA_CODEC_H
+#define __SOUND_SOC_HDA_CODEC_H
+
+#include <sound/hdaudio.h>
+
+/* HDA device table */
+#define HDA_NAME_SIZE      20
+struct soc_hda_device_id {
+	__u32 id;
+	__u32 rev_id;
+	char name[HDA_NAME_SIZE];
+	unsigned long driver_data;
+};
+
+struct soc_hda_codec_driver {
+	struct hdac_driver core;
+	const struct soc_hda_device_id *id_table;
+};
+
+#define to_hdac_driver(drv) (container_of((drv), \
+				 struct hdac_driver, driver))
+#define to_soc_hda_codec_driver(hdrv) (container_of((hdrv), \
+				 struct soc_hda_codec_driver, core))
+
+int snd_soc_hda_codec_driver_register(struct soc_hda_codec_driver *drv);
+void snd_soc_hda_codec_driver_unregister(struct soc_hda_codec_driver *drv);
+const struct soc_hda_device_id *snd_soc_hda_get_device_id(
+	struct hdac_device *hdev, struct soc_hda_codec_driver *drv);
+
+#endif
diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 3ba52da18bc6..d3903580cb10 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -40,6 +40,7 @@ source "sound/soc/cirrus/Kconfig"
 source "sound/soc/davinci/Kconfig"
 source "sound/soc/dwc/Kconfig"
 source "sound/soc/fsl/Kconfig"
+source "sound/soc/hda/Kconfig"
 source "sound/soc/jz4740/Kconfig"
 source "sound/soc/nuc900/Kconfig"
 source "sound/soc/omap/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 974ba708b482..8741d6a38bf6 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_SND_SOC)	+= cirrus/
 obj-$(CONFIG_SND_SOC)	+= davinci/
 obj-$(CONFIG_SND_SOC)	+= dwc/
 obj-$(CONFIG_SND_SOC)	+= fsl/
+obj-$(CONFIG_SND_SOC)	+= hda/
 obj-$(CONFIG_SND_SOC)	+= jz4740/
 obj-$(CONFIG_SND_SOC)	+= intel/
 obj-$(CONFIG_SND_SOC)	+= mxs/
diff --git a/sound/soc/hda/Kconfig b/sound/soc/hda/Kconfig
new file mode 100644
index 000000000000..815943360bc5
--- /dev/null
+++ b/sound/soc/hda/Kconfig
@@ -0,0 +1,3 @@
+config SND_SOC_HDA_CORE
+	tristate
+	select SND_HDA_CORE
diff --git a/sound/soc/hda/Makefile b/sound/soc/hda/Makefile
new file mode 100644
index 000000000000..9585ab180a55
--- /dev/null
+++ b/sound/soc/hda/Makefile
@@ -0,0 +1,3 @@
+snd-soc-hda-core-objs := soc-hda-codec.o
+
+obj-$(CONFIG_SND_SOC_HDA_CORE) += snd-soc-hda-core.o
diff --git a/sound/soc/hda/soc-hda-codec.c b/sound/soc/hda/soc-hda-codec.c
new file mode 100644
index 000000000000..90c8fa53e2cc
--- /dev/null
+++ b/sound/soc/hda/soc-hda-codec.c
@@ -0,0 +1,89 @@
+/*
+ * soc-hda-codec.c ASoC High Definition Audio Codec interface Definitions
+ *
+ * Copyright (c) 2014-2015 Intel Corporation
+ *
+ * Author(s): Jeeja KP <jeeja.kp@intel.com>
+ *
+ *
+ *  This driver is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This driver is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <sound/hdaudio.h>
+#include <sound/soc-hda-codec.h>
+
+/**
+ * snd_soc_hda_get_device_id - gets the hdac device id entry
+ * @hdev: HD-audio core device
+ * @drv: HD-audio soc codec driver
+ *
+ * Compares the hdac device vendor_id and revision_id to the hdac_soc_codec
+ * driver id_table and returns the matching device id entry.
+ */
+const struct soc_hda_device_id *
+snd_soc_hda_get_device_id(struct hdac_device *hdev,
+				struct soc_hda_codec_driver *drv)
+{
+	if (drv->id_table) {
+		const struct soc_hda_device_id *id  = drv->id_table;
+
+		while (id->name[0]) {
+			if (hdev->vendor_id == id->id &&
+				(!id->rev_id || id->rev_id == hdev->revision_id))
+				return id;
+			id++;
+		}
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_hda_get_device_id);
+
+/**
+ * soc_hda_codec_match - ASoC HDA codec match function
+ * @dev: HD-audio core device
+ * @@drv: HD-audio soc codec driver
+ *
+ * This tries to match the hdac device with hdac driver and return 1 on
+ * match, 0 otherwise
+ */
+static int soc_hda_codec_match(struct hdac_device *dev, struct hdac_driver *drv)
+{
+	struct soc_hda_codec_driver *driver = to_soc_hda_codec_driver(drv);
+
+	if (snd_soc_hda_get_device_id(dev, driver))
+		return 1;
+	else
+		return 0;
+}
+
+/**
+ * snd_soc_hda_codec_driver_register - register hda codec driver
+ * @drv: HD Audio soc codec driver
+ */
+int snd_soc_hda_codec_driver_register(struct soc_hda_codec_driver *drv)
+{
+	drv->core.driver.bus = &snd_hda_bus_type;
+	drv->core.type = HDA_DEV_ASOC;
+	drv->core.match = soc_hda_codec_match;
+	return driver_register(&drv->core.driver);
+}
+EXPORT_SYMBOL_GPL(snd_soc_hda_codec_driver_register);
+
+/**
+ * snd_soc_hda_codec_driver_unregister - unregister hda codec driver
+ * @drv: HD Audio soc codec driver
+ */
+void snd_soc_hda_codec_driver_unregister(struct soc_hda_codec_driver *drv)
+{
+	driver_unregister(&drv->core.driver);
+}
+EXPORT_SYMBOL_GPL(snd_soc_hda_codec_driver_unregister);
-- 
1.9.1
