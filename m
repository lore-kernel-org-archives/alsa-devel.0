From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v8 1/3] ALSA: hdac_ext: add extended HDA bus
Date: Wed, 10 Jun 2015 18:36:00 +0530
Message-ID: <1433941562-5778-2-git-send-email-vinod.koul@intel.com>
References: <1433941562-5778-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E405261501
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2015 15:05:00 +0200 (CEST)
In-Reply-To: <1433941562-5778-1-git-send-email-vinod.koul@intel.com>
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

The new HDA controllers from Intel support new capabilities like
multilink, pipe processing, SPIB, GTS etc In order to use them we
create an extended HDA bus which embed the hdac bus and contains the
fields for extended configurations

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio_ext.h  |  45 +++++++++++++++++
 sound/hda/Kconfig            |   4 ++
 sound/hda/Makefile           |   3 ++
 sound/hda/ext/Makefile       |   3 ++
 sound/hda/ext/hdac_ext_bus.c | 116 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 171 insertions(+)
 create mode 100644 include/sound/hdaudio_ext.h
 create mode 100644 sound/hda/ext/Makefile
 create mode 100644 sound/hda/ext/hdac_ext_bus.c

diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
new file mode 100644
index 000000000000..5b67b367367d
--- /dev/null
+++ b/include/sound/hdaudio_ext.h
@@ -0,0 +1,45 @@
+#ifndef __SOUND_HDAUDIO_EXT_H
+#define __SOUND_HDAUDIO_EXT_H
+
+#include <sound/hdaudio.h>
+
+/**
+ * hdac_ext_bus: HDAC extended bus for extended HDA caps
+ *
+ * @bus: hdac bus
+ * @num_streams: streams supported
+ * @ppcap: pp capabilities pointer
+ * @spbcap: SPIB capabilities pointer
+ * @mlcap: MultiLink capabilities pointer
+ * @gtscap: gts capabilities pointer
+ * @hlink_list: link list of HDA links
+ */
+struct hdac_ext_bus {
+	struct hdac_bus bus;
+	int num_streams;
+
+	void __iomem *ppcap;
+	void __iomem *spbcap;
+	void __iomem *mlcap;
+	void __iomem *gtscap;
+
+	struct list_head hlink_list;
+};
+
+int snd_hdac_ext_bus_init(struct hdac_ext_bus *sbus, struct device *dev,
+		      const struct hdac_bus_ops *ops,
+		      const struct hdac_io_ops *io_ops);
+
+void snd_hdac_ext_bus_exit(struct hdac_ext_bus *sbus);
+int snd_hdac_ext_bus_device_init(struct hdac_ext_bus *sbus, int addr);
+void snd_hdac_ext_bus_device_exit(struct hdac_device *hdev);
+
+#define ebus_to_hbus(ebus)	(&(ebus)->bus)
+#define hbus_to_ebus(_bus) \
+	container_of(_bus, struct hdac_ext_bus, bus)
+
+int snd_hdac_ext_bus_parse_capabilities(struct hdac_ext_bus *sbus);
+void snd_hdac_ext_bus_ppcap_enable(struct hdac_ext_bus *chip, bool enable);
+void snd_hdac_ext_bus_ppcap_int_enable(struct hdac_ext_bus *chip, bool enable);
+
+#endif /* __SOUND_HDAUDIO_EXT_H */
diff --git a/sound/hda/Kconfig b/sound/hda/Kconfig
index ac5ffac2a272..6dc3914fd28b 100644
--- a/sound/hda/Kconfig
+++ b/sound/hda/Kconfig
@@ -10,3 +10,7 @@ config SND_HDA_I915
 	default y
 	depends on DRM_I915
 	depends on SND_HDA_CORE
+
+config SND_HDA_EXT_CORE
+       tristate
+       select SND_HDA_CORE
diff --git a/sound/hda/Makefile b/sound/hda/Makefile
index 55dd465c7042..7e999c995cdc 100644
--- a/sound/hda/Makefile
+++ b/sound/hda/Makefile
@@ -8,3 +8,6 @@ CFLAGS_trace.o := -I$(src)
 snd-hda-core-$(CONFIG_SND_HDA_I915) += hdac_i915.o
 
 obj-$(CONFIG_SND_HDA_CORE) += snd-hda-core.o
+
+#extended hda
+obj-$(CONFIG_SND_HDA_EXT_CORE) += ext/
diff --git a/sound/hda/ext/Makefile b/sound/hda/ext/Makefile
new file mode 100644
index 000000000000..2e583e664916
--- /dev/null
+++ b/sound/hda/ext/Makefile
@@ -0,0 +1,3 @@
+snd-hda-ext-core-objs := hdac_ext_bus.o
+
+obj-$(CONFIG_SND_HDA_EXT_CORE) += snd-hda-ext-core.o
diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
new file mode 100644
index 000000000000..3498bf458d51
--- /dev/null
+++ b/sound/hda/ext/hdac_ext_bus.c
@@ -0,0 +1,116 @@
+/*
+ *  hdac-ext-bus.c - HD-audio extended core bus functions.
+ *
+ *  Copyright (C) 2014-2015 Intel Corp
+ *  Author: Jeeja KP <jeeja.kp@intel.com>
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
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <sound/hdaudio_ext.h>
+
+MODULE_DESCRIPTION("HDA extended core");
+MODULE_LICENSE("GPL v2");
+
+/**
+ * snd_hdac_ext_bus_init - initialize a HD-audio extended bus
+ * @ebus: the pointer to extended bus object
+ * @dev: device pointer
+ * @ops: bus verb operators
+ * @io_ops: lowlevel I/O operators
+ *
+ * Returns 0 if successful, or a negative error code.
+ */
+int snd_hdac_ext_bus_init(struct hdac_ext_bus *ebus, struct device *dev,
+			const struct hdac_bus_ops *ops,
+			const struct hdac_io_ops *io_ops)
+{
+	int ret;
+
+	ret = snd_hdac_bus_init(&ebus->bus, dev, ops, io_ops);
+	if (ret < 0)
+		return ret;
+
+	INIT_LIST_HEAD(&ebus->hlink_list);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_init);
+
+/**
+ * snd_hdac_ext_bus_exit - clean up a HD-audio extended bus
+ * @ebus: the pointer to extended bus object
+ */
+void snd_hdac_ext_bus_exit(struct hdac_ext_bus *ebus)
+{
+	snd_hdac_bus_exit(&ebus->bus);
+	WARN_ON(!list_empty(&ebus->hlink_list));
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_exit);
+
+static void default_release(struct device *dev)
+{
+	snd_hdac_ext_bus_device_exit(container_of(dev, struct hdac_device, dev));
+}
+
+/**
+ * snd_hdac_ext_device_init - initialize the HDA extended codec base device
+ * @ebus: hdac extended bus to attach to
+ * @addr: codec address
+ *
+ * Returns zero for success or a negative error code.
+ */
+int snd_hdac_ext_bus_device_init(struct hdac_ext_bus *ebus, int addr)
+{
+	struct hdac_device *hdev = NULL;
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	static unsigned int idx;
+	char name[15];
+	int ret;
+
+	hdev = kzalloc(sizeof(*hdev), GFP_KERNEL);
+	if (!hdev)
+		return -ENOMEM;
+
+	snprintf(name, sizeof(name), "ehdaudio%dD%d", idx, addr);
+	idx++;
+
+	ret  = snd_hdac_device_init(hdev, bus, name, addr);
+	if (ret < 0) {
+		dev_err(bus->dev, "device init failed for hdac device\n");
+		return ret;
+	}
+	hdev->type = HDA_DEV_ASOC;
+	hdev->dev.release = default_release;
+
+	ret = snd_hdac_device_register(hdev);
+	if (ret) {
+		dev_err(bus->dev, "failed to register hdac device\n");
+		snd_hdac_ext_bus_device_exit(hdev);
+		return ret;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_device_init);
+
+/**
+ * snd_hdac_ext_bus_device_exit - clean up a HD-audio extended codec base device
+ * @hdev: hdac device to clean up
+ */
+void snd_hdac_ext_bus_device_exit(struct hdac_device *hdev)
+{
+	snd_hdac_device_exit(hdev);
+	kfree(hdev);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_device_exit);
-- 
1.9.1
