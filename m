From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 3/3] ALSA: hda - add soc hda bus wrapper
Date: Thu,  2 Apr 2015 15:27:31 +0530
Message-ID: <1427968651-7821-4-git-send-email-vinod.koul@intel.com>
References: <1427968651-7821-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id ABB1C2604CE
 for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2015 12:02:06 +0200 (CEST)
In-Reply-To: <1427968651-7821-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, Ramesh Babu <ramesh.babu@intel.com>, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, pathes.audio@intel.com
List-Id: alsa-devel@alsa-project.org

From: Ramesh Babu <ramesh.babu@intel.com>

The SKL controller will be ASoC device but needs access to HDA code, so
create asoc wrppers on top of hdac.

Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/soc-hdac-bus.h |  103 +++++++++++++++++++
 sound/soc/Kconfig            |    1 +
 sound/soc/Makefile           |    1 +
 sound/soc/hda/Kconfig        |    4 +
 sound/soc/hda/Makefile       |    3 +
 sound/soc/hda/soc-hdac-bus.c |  233 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 345 insertions(+)
 create mode 100644 include/sound/soc-hdac-bus.h
 create mode 100644 sound/soc/hda/Kconfig
 create mode 100644 sound/soc/hda/Makefile
 create mode 100644 sound/soc/hda/soc-hdac-bus.c

diff --git a/include/sound/soc-hdac-bus.h b/include/sound/soc-hdac-bus.h
new file mode 100644
index 000000000000..aaa91ef934c5
--- /dev/null
+++ b/include/sound/soc-hdac-bus.h
@@ -0,0 +1,103 @@
+/*
+ *  soc-hdac-bus.h - ASoC HDA bus wrapper
+ *
+ *  Copyright (c) 2015 Intel Corporation
+ *  Author: Jeeja KP <jeeja.kp@intel.com>
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
+#ifndef _SOC_HDAC_BUS_H_
+#define _SOC_HDAC_BUS_H_
+
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
+#include <sound/hdaudio.h>
+
+struct snd_soc_hdac_device {
+	struct hdac_device hdac;
+	struct snd_soc_hdac_bus *hbus;
+	const char	*name;
+	unsigned int	id;
+	const struct snd_soc_hda_device_id *id_entry;
+};
+
+#define soc_hda_get_device_id(pdev)    ((pdev)->id_entry)
+
+#define to_soc_hdac_device(x) container_of((x), struct snd_soc_hdac_device, hdac.dev)
+
+int snd_soc_hdac_device_register(struct snd_soc_hdac_device *);
+void snd_soc_hdac_device_unregister(struct snd_soc_hdac_device *);
+
+int snd_soc_hdac_add_devices(struct snd_soc_hdac_device **, int);
+struct snd_soc_hdac_device *snd_soc_hdac_device_alloc(const char *name,
+					int addr, unsigned int id);
+
+int snd_soc_hdac_device_add_data(struct snd_soc_hdac_device *pdev,
+				const void *data, size_t size);
+int snd_soc_hdac_device_add(struct hdac_stream *hstream, struct snd_soc_hdac_device *pdev);
+void snd_soc_hdac_device_del(struct snd_soc_hdac_device *pdev);
+void snd_soc_hdac_device_put(struct snd_soc_hdac_device *pdev);
+
+struct snd_soc_hdac_driver {
+	struct hdac_driver hdrv;
+	const struct snd_soc_hda_device_id *id_table;
+	int	(*probe)(struct snd_soc_hdac_device *hda);
+	int	(*remove)(struct snd_soc_hdac_device *hda);
+	void	(*shutdown)(struct snd_soc_hdac_device *hda);
+	int	(*suspend)(struct snd_soc_hdac_device *hda, pm_message_t mesg);
+	int	(*resume)(struct snd_soc_hdac_device *hda);
+	void	(*unsol_event)(struct snd_soc_hdac_device *hda,
+					unsigned int res);
+};
+
+#define to_soc_hdac_driver(drv) (container_of((drv), struct snd_soc_hdac_driver, \
+				hdrv.driver))
+
+int snd_soc_hdac_driver_register(struct snd_soc_hdac_driver *);
+void snd_soc_hdac_driver_unregister(struct snd_soc_hdac_driver *);
+static inline void *snd_soc_hdac_get_drvdata(
+			const struct snd_soc_hdac_device *pdev)
+{
+	return dev_get_drvdata(&pdev->hdac.dev);
+}
+
+static inline void snd_soc_hdac_set_drvdata(struct snd_soc_hdac_device *pdev,
+						void *data)
+{
+	dev_set_drvdata(&pdev->hdac.dev, data);
+}
+
+struct snd_soc_hdac_bus {
+	struct hdac_bus bus;
+	/* unsolicited event queue */
+	struct snd_soc_hdac_bus_unsolicited *unsol;
+	struct pci_dev *pci;
+	struct mutex prepare_mutex;
+};
+
+int snd_soc_hdac_bus_init(struct pci_dev *pci, void *data,
+			struct hdac_bus_ops ops,
+			struct snd_soc_hdac_bus **busp);
+void snd_soc_hdac_bus_release(struct snd_soc_hdac_bus *hbus);
+
+/*Soc HDA Device*/
+#define HDA_NAME_SIZE      20
+#define HDA_MODULE_PREFIX  "hda:"
+struct snd_soc_hda_device_id {
+	__u32 id;
+	__u8 addr;
+	char name[HDA_NAME_SIZE];
+	kernel_ulong_t driver_data;
+};
+
+#endif /* _SOC_HDAC_BUS_H_ */
diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index dcc79aa0236b..c19b882a0854 100644
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
index 5b3c8f67c8db..3269d19b20b9 100644
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
index 000000000000..09ef831b8513
--- /dev/null
+++ b/sound/soc/hda/Kconfig
@@ -0,0 +1,4 @@
+config SND_SOC_HDA_BUS
+	tristate "SoC HDA bus wrapper"
+	help
+	 This adds support the SOC HDA Bus wrapper
diff --git a/sound/soc/hda/Makefile b/sound/soc/hda/Makefile
new file mode 100644
index 000000000000..0cb26a68f2dc
--- /dev/null
+++ b/sound/soc/hda/Makefile
@@ -0,0 +1,3 @@
+#ccflags-y += -Werror
+snd-soc-hda-bus-objs := soc-hdac-bus.o
+obj-$(CONFIG_SND_SOC_HDA_BUS) += snd-soc-hda-bus.o
diff --git a/sound/soc/hda/soc-hdac-bus.c b/sound/soc/hda/soc-hdac-bus.c
new file mode 100644
index 000000000000..d505a6ffb30f
--- /dev/null
+++ b/sound/soc/hda/soc-hdac-bus.c
@@ -0,0 +1,233 @@
+/*
+ *  soc-hdac-bus.c - SoC HDA bus Interface for SoC HDA devices
+ *
+ *  Copyright (C) 2015 Intel Corp
+ *  Author: Jeeja KP<jeeja.kp@intel.com>
+ *	Ramesh Babu <Ramesh.Babu@intel.com>
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
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#include <linux/string.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/pm_runtime.h>
+#include <linux/pci.h>
+#include <sound/core.h>
+#include <sound/hdaudio.h>
+#include <sound/soc-hdac-bus.h>
+
+
+/**
+ * hda_device_put - destroy a hda device
+ * @pdev: hda device to free
+ *
+ * Free all memory associated with a hda device.  This function must
+ * _only_ be externally called in error cases.  All other usage is a bug.
+ */
+void snd_soc_hdac_device_put(struct snd_soc_hdac_device *pdev)
+{
+	if (pdev)
+		put_device(&pdev->hdac.dev);
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_device_put);
+
+/**
+ * snd_soc_hdac_device_add_data - add platform-specific data to a hda device
+ * @pdev: hda device allocated by platform_device_alloc to add resources to
+ * @data: hda specific data for this hda device
+ * @size: size of platform specific data
+ *
+ */
+int snd_soc_hdac_device_add_data(struct snd_soc_hdac_device *pdev,
+	const void *data, size_t size)
+{
+	void *d = NULL;
+
+	if (data) {
+		d = kmemdup(data, size, GFP_KERNEL);
+		if (!d)
+			return -ENOMEM;
+	}
+
+	kfree(pdev->hdac.dev.platform_data);
+	pdev->hdac.dev.platform_data = d;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_device_add_data);
+
+/**
+ * hda_device_unregister - unregister a hda device
+ * @pdev: hda device we're unregistering
+ *
+ * Unregistration is done in 2 steps. First we release all resources
+ * and remove it from the subsystem, then we drop reference count by
+ * calling hda_device_put().
+ */
+void snd_soc_hdac_device_unregister(struct snd_soc_hdac_device *pdev)
+{
+	snd_hdac_device_exit(&pdev->hdac);
+	snd_hdac_device_unregister(&pdev->hdac);
+	snd_soc_hdac_device_put(pdev);
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_device_unregister);
+
+static int soc_hdac_drv_probe(struct device *dev)
+{
+	struct snd_soc_hdac_driver *drv = to_soc_hdac_driver(dev->driver);
+
+	return drv->probe(to_soc_hdac_device(dev));
+}
+
+
+static int soc_hdac_drv_remove(struct device *dev)
+{
+	struct snd_soc_hdac_driver *drv = to_soc_hdac_driver(dev->driver);
+
+	return drv->remove(to_soc_hdac_device(dev));
+}
+
+static void soc_hdac_drv_shutdown(struct device *dev)
+{
+	struct snd_soc_hdac_driver *drv = to_soc_hdac_driver(dev->driver);
+
+	drv->shutdown(to_soc_hdac_device(dev));
+}
+
+/**
+ * hda_driver_register - register a driver for hda devices
+ * @drv: hda driver structure
+ */
+int snd_soc_hdac_driver_register(struct snd_soc_hdac_driver *drv)
+{
+	if (drv->probe)
+		drv->hdrv.driver.probe = soc_hdac_drv_probe;
+	if (drv->remove)
+		drv->hdrv.driver.remove = soc_hdac_drv_remove;
+	if (drv->shutdown)
+		drv->hdrv.driver.shutdown = soc_hdac_drv_shutdown;
+
+	return driver_register(&drv->hdrv.driver);
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_driver_register);
+
+/**
+ * hda_driver_unregister - unregister a driver for hda devices
+ * @drv: hda driver structure
+ */
+void snd_soc_hdac_driver_unregister(struct snd_soc_hdac_driver *drv)
+{
+	driver_unregister(&drv->hdrv.driver);
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_driver_unregister);
+
+static const struct snd_soc_hda_device_id *soc_hda_match_id(
+			const struct snd_soc_hda_device_id *id,
+			struct snd_soc_hdac_device *pdev)
+{
+	while (id->name[0]) {
+		if (pdev->id == id->id) {
+			pdev->id_entry = id;
+			return id;
+		} else if (strcmp(pdev->name, id->name) == 0) {
+				pdev->id_entry = id;
+				return id;
+		}
+		id++;
+	}
+	return NULL;
+}
+
+/**
+ * hda_match - bind hda device to hda driver.
+ * @dev: device.
+ * @drv: driver.
+ *
+ */
+static int soc_hdac_match(struct device *dev, struct device_driver *drv)
+{
+	struct snd_soc_hdac_device *pdev = to_soc_hdac_device(dev);
+	struct snd_soc_hdac_driver *pdrv = to_soc_hdac_driver(drv);
+
+	/* Then try to match against the id table */
+	if (pdrv->id_table)
+		return soc_hda_match_id(pdrv->id_table, pdev) != NULL;
+
+	/* fall-back to driver name match */
+	return (strcmp(pdev->name, drv->name) == 0);
+}
+EXPORT_SYMBOL_GPL(soc_hdac_match);
+
+
+int snd_soc_hda_bus_init(struct pci_dev *pci, void *data,
+	struct snd_soc_hdac_bus **busp)
+{
+	struct snd_soc_hdac_bus *sbus;
+	int err;
+
+	sbus = kzalloc(sizeof(*sbus), GFP_KERNEL);
+	if (sbus == NULL)
+		return -ENOMEM;
+
+	err = snd_hdac_bus_init(&sbus->bus, &pci->dev, NULL);
+	if (err < 0) {
+		kfree(sbus);
+		return err;
+	}
+	if (busp)
+		*busp = sbus;
+	sbus->pci = pci;
+	mutex_init(&sbus->prepare_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_hda_bus_init);
+
+static int soc_hda_bus_free(struct snd_soc_hdac_bus *sbus)
+{
+	struct hdac_bus *bus;
+
+	if (!sbus)
+		return 0;
+
+	bus = &sbus->bus;
+	snd_hdac_bus_exit(bus);
+	kfree(sbus);
+	return 0;
+}
+
+static int soc_hda_release_device(struct device *dev, void *data)
+{
+	struct snd_soc_hdac_device *pdev = to_soc_hdac_device(dev);
+
+	snd_soc_hdac_device_unregister(pdev);
+	return 0;
+}
+
+void snd_soc_hdac_bus_release(struct snd_soc_hdac_bus *hbus)
+{
+	/*unregister all devices on bus */
+	bus_for_each_dev(&snd_hda_bus_type, NULL, NULL,
+			soc_hda_release_device);
+
+	soc_hda_bus_free(hbus);
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_bus_release);
+
+MODULE_AUTHOR("KP Jeeja, jeeja.kp@intel.com");
+MODULE_AUTHOR("Ramesh Babu, Ramesh.Babu@intel.com");
+MODULE_DESCRIPTION("ASOC HDA bus core");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5
