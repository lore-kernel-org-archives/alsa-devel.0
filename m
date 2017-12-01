From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v4 02/15] soundwire: Add SoundWire bus type
Date: Fri,  1 Dec 2017 15:26:04 +0530
Message-ID: <1512122177-2889-3-git-send-email-vinod.koul@intel.com>
References: <1512122177-2889-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 819C9267BE5
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 10:52:52 +0100 (CET)
In-Reply-To: <1512122177-2889-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

This adds the base SoundWire bus type, bus and driver registration.
along with changes to module device table for new SoundWire
device type.

Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/Kconfig                    |   2 +
 drivers/Makefile                   |   1 +
 drivers/soundwire/Kconfig          |  22 +++++
 drivers/soundwire/Makefile         |   7 ++
 drivers/soundwire/bus_type.c       | 172 +++++++++++++++++++++++++++++++++++++
 include/linux/mod_devicetable.h    |   6 ++
 include/linux/soundwire/sdw.h      | 111 ++++++++++++++++++++++++
 include/linux/soundwire/sdw_type.h |  19 ++++
 scripts/mod/devicetable-offsets.c  |   4 +
 scripts/mod/file2alias.c           |  15 ++++
 10 files changed, 359 insertions(+)
 create mode 100644 drivers/soundwire/Kconfig
 create mode 100644 drivers/soundwire/Makefile
 create mode 100644 drivers/soundwire/bus_type.c
 create mode 100644 include/linux/soundwire/sdw.h
 create mode 100644 include/linux/soundwire/sdw_type.h

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 152744c5ef0f..3a0bbbd42292 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -153,6 +153,8 @@ source "drivers/remoteproc/Kconfig"
 
 source "drivers/rpmsg/Kconfig"
 
+source "drivers/soundwire/Kconfig"
+
 source "drivers/soc/Kconfig"
 
 source "drivers/devfreq/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 1d034b680431..cd13b2ed7ed6 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -156,6 +156,7 @@ obj-$(CONFIG_MAILBOX)		+= mailbox/
 obj-$(CONFIG_HWSPINLOCK)	+= hwspinlock/
 obj-$(CONFIG_REMOTEPROC)	+= remoteproc/
 obj-$(CONFIG_RPMSG)		+= rpmsg/
+obj-$(CONFIG_SOUNDWIRE)		+= soundwire/
 
 # Virtualization drivers
 obj-$(CONFIG_VIRT_DRIVERS)	+= virt/
diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
new file mode 100644
index 000000000000..d7d3908f4913
--- /dev/null
+++ b/drivers/soundwire/Kconfig
@@ -0,0 +1,22 @@
+#
+# SoundWire subsystem configuration
+#
+
+menuconfig SOUNDWIRE
+	bool "SoundWire support"
+	---help---
+	  SoundWire is a 2-Pin interface with data and clock line ratified
+	  by the MIPI Alliance. SoundWire is used for transporting data
+	  typically related to audio functions. SoundWire interface is
+	  optimized to integrate audio devices in mobile or mobile inspired
+	  systems. Say Y to enable this subsystem, N if you do not have such
+	  a device
+
+if SOUNDWIRE
+
+comment "SoundWire Devices"
+
+config SOUNDWIRE_BUS
+	tristate
+
+endif
diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
new file mode 100644
index 000000000000..d1281def7662
--- /dev/null
+++ b/drivers/soundwire/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for soundwire core
+#
+
+#Bus Objs
+soundwire-bus-objs := bus_type.o
+obj-$(CONFIG_SOUNDWIRE_BUS) += soundwire-bus.o
diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
new file mode 100644
index 000000000000..8d8dcc68e9a8
--- /dev/null
+++ b/drivers/soundwire/bus_type.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright(c) 2015-17 Intel Corporation.
+
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/pm_domain.h>
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_type.h>
+
+/**
+ * sdw_get_device_id - find the matching SoundWire device id
+ * @slave: SoundWire Slave Device
+ * @drv: SoundWire Slave Driver
+ *
+ * The match is done by comparing the mfg_id and part_id from the
+ * struct sdw_device_id.
+ */
+static const struct sdw_device_id *
+sdw_get_device_id(struct sdw_slave *slave, struct sdw_driver *drv)
+{
+	const struct sdw_device_id *id = drv->id_table;
+
+	while (id && id->mfg_id) {
+		if (slave->id.mfg_id == id->mfg_id &&
+		    slave->id.part_id == id->part_id)
+			return id;
+		id++;
+	}
+
+	return NULL;
+}
+
+static int sdw_bus_match(struct device *dev, struct device_driver *ddrv)
+{
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	struct sdw_driver *drv = drv_to_sdw_driver(ddrv);
+
+	return !!sdw_get_device_id(slave, drv);
+}
+
+int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size)
+{
+	/* modalias is sdw:m<mfg_id>p<part_id> */
+
+	return snprintf(buf, size, "sdw:m%04Xp%04X\n",
+			slave->id.mfg_id, slave->id.part_id);
+}
+
+static int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	char modalias[32];
+
+	sdw_slave_modalias(slave, modalias, sizeof(modalias));
+
+	if (add_uevent_var(env, "MODALIAS=%s", modalias))
+		return -ENOMEM;
+
+	return 0;
+}
+
+struct bus_type sdw_bus_type = {
+	.name = "soundwire",
+	.match = sdw_bus_match,
+	.uevent = sdw_uevent,
+};
+EXPORT_SYMBOL_GPL(sdw_bus_type);
+
+static int sdw_drv_probe(struct device *dev)
+{
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
+	const struct sdw_device_id *id;
+	int ret;
+
+	id = sdw_get_device_id(slave, drv);
+	if (!id)
+		return -ENODEV;
+
+	/*
+	 * attach to power domain but don't turn on (last arg)
+	 */
+	ret = dev_pm_domain_attach(dev, false);
+	if (ret != -EPROBE_DEFER) {
+		ret = drv->probe(slave, id);
+		if (ret) {
+			dev_err(dev, "Probe of %s failed: %d\n", drv->name, ret);
+			dev_pm_domain_detach(dev, false);
+		}
+	}
+
+	return ret;
+}
+
+static int sdw_drv_remove(struct device *dev)
+{
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
+	int ret = 0;
+
+	if (drv->remove)
+		ret = drv->remove(slave);
+
+	dev_pm_domain_detach(dev, false);
+
+	return ret;
+}
+
+static void sdw_drv_shutdown(struct device *dev)
+{
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
+
+	if (drv->shutdown)
+		drv->shutdown(slave);
+}
+
+/**
+ * __sdw_register_driver() - register a SoundWire Slave driver
+ * @drv: driver to register
+ * @owner: owning module/driver
+ *
+ * Return: zero on success, else a negative error code.
+ */
+int __sdw_register_driver(struct sdw_driver *drv, struct module *owner)
+{
+	drv->driver.bus = &sdw_bus_type;
+
+	if (!drv->probe) {
+		pr_err("driver %s didn't provide SDW probe routine\n",
+							drv->name);
+		return -EINVAL;
+	}
+
+	drv->driver.owner = owner;
+	drv->driver.probe = sdw_drv_probe;
+
+	if (drv->remove)
+		drv->driver.remove = sdw_drv_remove;
+
+	if (drv->shutdown)
+		drv->driver.shutdown = sdw_drv_shutdown;
+
+	return driver_register(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(__sdw_register_driver);
+
+/**
+ * sdw_unregister_driver() - unregisters the SoundWire Slave driver
+ * @drv: driver to unregister
+ */
+void sdw_unregister_driver(struct sdw_driver *drv)
+{
+	driver_unregister(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(sdw_unregister_driver);
+
+static int __init sdw_bus_init(void)
+{
+	return bus_register(&sdw_bus_type);
+}
+
+static void __exit sdw_bus_exit(void)
+{
+	bus_unregister(&sdw_bus_type);
+}
+
+postcore_initcall(sdw_bus_init);
+module_exit(sdw_bus_exit);
+
+MODULE_DESCRIPTION("SoundWire bus");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index abb6dc2ebbf8..d6f727a68eb1 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -229,6 +229,12 @@ struct hda_device_id {
 	unsigned long driver_data;
 };
 
+struct sdw_device_id {
+	__u16 mfg_id;
+	__u16 part_id;
+	kernel_ulong_t driver_data;
+};
+
 /*
  * Struct used for matching a device
  */
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
new file mode 100644
index 000000000000..4a7503781602
--- /dev/null
+++ b/include/linux/soundwire/sdw.h
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2015-17 Intel Corporation.
+
+#ifndef __SOUNDWIRE_H
+#define __SOUNDWIRE_H
+
+struct sdw_bus;
+struct sdw_slave;
+
+#define SDW_MAX_DEVICES			11
+
+/**
+ * enum sdw_slave_status - Slave status
+ * @SDW_SLAVE_UNATTACHED: Slave is not attached with the bus.
+ * @SDW_SLAVE_ATTACHED: Slave is attached with bus.
+ * @SDW_SLAVE_ALERT: Some alert condition on the Slave
+ * @SDW_SLAVE_RESERVED: Reserved for future use
+ */
+enum sdw_slave_status {
+	SDW_SLAVE_UNATTACHED = 0,
+	SDW_SLAVE_ATTACHED = 1,
+	SDW_SLAVE_ALERT = 2,
+	SDW_SLAVE_RESERVED = 3,
+};
+
+/*
+ * SDW Slave Structures and APIs
+ */
+
+/**
+ * struct sdw_slave_id - Slave ID
+ * @mfg_id: MIPI Manufacturer ID
+ * @part_id: Device Part ID
+ * @class_id: MIPI Class ID, unused now.
+ * Currently a placeholder in MIPI SoundWire Spec
+ * @unique_id: Device unique ID
+ * @sdw_version: SDW version implemented
+ *
+ * The order of the IDs here does not follow the DisCo spec definitions
+ */
+struct sdw_slave_id {
+	__u16 mfg_id;
+	__u16 part_id;
+	__u8 class_id;
+	__u8 unique_id:4;
+	__u8 sdw_version:4;
+};
+
+/**
+ * struct sdw_slave - SoundWire Slave
+ * @id: MIPI device ID
+ * @dev: Linux device
+ * @status: Status reported by the Slave
+ * @bus: Bus handle
+ * @node: node for bus list
+ * @dev_num: Device Number assigned by Bus
+ */
+struct sdw_slave {
+	struct sdw_slave_id id;
+	struct device dev;
+	enum sdw_slave_status status;
+	struct sdw_bus *bus;
+	struct list_head node;
+	u16 dev_num;
+};
+
+#define dev_to_sdw_dev(_dev) container_of(_dev, struct sdw_slave, dev)
+
+struct sdw_driver {
+	const char *name;
+
+	int (*probe)(struct sdw_slave *sdw,
+			const struct sdw_device_id *id);
+	int (*remove)(struct sdw_slave *sdw);
+	void (*shutdown)(struct sdw_slave *sdw);
+
+	const struct sdw_device_id *id_table;
+	const struct sdw_slave_ops *ops;
+
+	struct device_driver driver;
+};
+
+#define SDW_SLAVE_ENTRY(_mfg_id, _part_id, _drv_data) \
+	{ .mfg_id = (_mfg_id), .part_id = (_part_id), \
+	  .driver_data = (unsigned long)(_drv_data) }
+
+int sdw_handle_slave_status(struct sdw_bus *bus,
+			enum sdw_slave_status status[]);
+
+/*
+ * SDW master structures and APIs
+ */
+
+/**
+ * struct sdw_bus - SoundWire bus
+ * @dev: Master linux device
+ * @link_id: Link id number, can be 0 to N, unique for each Master
+ * @slaves: list of Slaves on this bus
+ * @assigned: Bitmap for Slave device numbers.
+ * Bit set implies used number, bit clear implies unused number.
+ * @bus_lock: bus lock
+ */
+struct sdw_bus {
+	struct device *dev;
+	unsigned int link_id;
+	struct list_head slaves;
+	DECLARE_BITMAP(assigned, SDW_MAX_DEVICES);
+	struct mutex bus_lock;
+};
+
+#endif /* __SOUNDWIRE_H */
diff --git a/include/linux/soundwire/sdw_type.h b/include/linux/soundwire/sdw_type.h
new file mode 100644
index 000000000000..9fd553e553e9
--- /dev/null
+++ b/include/linux/soundwire/sdw_type.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright(c) 2015-17 Intel Corporation.
+
+#ifndef __SOUNDWIRE_TYPES_H
+#define __SOUNDWIRE_TYPES_H
+
+extern struct bus_type sdw_bus_type;
+
+#define drv_to_sdw_driver(_drv) container_of(_drv, struct sdw_driver, driver)
+
+#define sdw_register_driver(drv) \
+	__sdw_register_driver(drv, THIS_MODULE)
+
+int __sdw_register_driver(struct sdw_driver *drv, struct module *);
+void sdw_unregister_driver(struct sdw_driver *drv);
+
+int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size);
+
+#endif /* __SOUNDWIRE_TYPES_H */
diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index 9826b9a6543c..9fad6afe4c41 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -203,6 +203,10 @@ int main(void)
 	DEVID_FIELD(hda_device_id, rev_id);
 	DEVID_FIELD(hda_device_id, api_version);
 
+	DEVID(sdw_device_id);
+	DEVID_FIELD(sdw_device_id, mfg_id);
+	DEVID_FIELD(sdw_device_id, part_id);
+
 	DEVID(fsl_mc_device_id);
 	DEVID_FIELD(fsl_mc_device_id, vendor);
 	DEVID_FIELD(fsl_mc_device_id, obj_type);
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 6ef6e63f96fd..b9beeaa4695b 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1289,6 +1289,21 @@ static int do_hda_entry(const char *filename, void *symval, char *alias)
 }
 ADD_TO_DEVTABLE("hdaudio", hda_device_id, do_hda_entry);
 
+/* Looks like: sdw:mNpN */
+static int do_sdw_entry(const char *filename, void *symval, char *alias)
+{
+	DEF_FIELD(symval, sdw_device_id, mfg_id);
+	DEF_FIELD(symval, sdw_device_id, part_id);
+
+	strcpy(alias, "sdw:");
+	ADD(alias, "m", mfg_id != 0, mfg_id);
+	ADD(alias, "p", part_id != 0, part_id);
+
+	add_wildcard(alias);
+	return 1;
+}
+ADD_TO_DEVTABLE("sdw", sdw_device_id, do_sdw_entry);
+
 /* Looks like: fsl-mc:vNdN */
 static int do_fsl_mc_entry(const char *filename, void *symval,
 			   char *alias)
-- 
2.7.4
