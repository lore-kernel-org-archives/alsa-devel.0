From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v4 03/15] soundwire: Add Master registration
Date: Fri,  1 Dec 2017 15:26:05 +0530
Message-ID: <1512122177-2889-4-git-send-email-vinod.koul@intel.com>
References: <1512122177-2889-1-git-send-email-vinod.koul@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512122177-2889-1-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

A Master registers with SoundWire bus and scans the firmware provided
for device description. In this patch we scan the ACPI namespaces and
create the SoundWire Slave devices based on the ACPI description

Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/soundwire/Makefile    |   2 +-
 drivers/soundwire/bus.c       | 119 ++++++++++++++++++++++++++++++++++++++++++
 drivers/soundwire/bus.h       |  19 +++++++
 drivers/soundwire/slave.c     | 114 ++++++++++++++++++++++++++++++++++++++++
 include/linux/soundwire/sdw.h |  11 ++++
 5 files changed, 264 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soundwire/bus.c
 create mode 100644 drivers/soundwire/bus.h
 create mode 100644 drivers/soundwire/slave.c

diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index d1281def7662..c875e434f8b3 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -3,5 +3,5 @@
 #
 
 #Bus Objs
-soundwire-bus-objs := bus_type.o
+soundwire-bus-objs := bus_type.o bus.o slave.o
 obj-$(CONFIG_SOUNDWIRE_BUS) += soundwire-bus.o
diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
new file mode 100644
index 000000000000..0f89b2f36938
--- /dev/null
+++ b/drivers/soundwire/bus.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2015-17 Intel Corporation.
+
+#include <linux/acpi.h>
+#include <linux/mod_devicetable.h>
+#include <linux/soundwire/sdw.h>
+#include "bus.h"
+
+/**
+ * sdw_add_bus_master() - add a bus Master instance
+ * @bus: bus instance
+ *
+ * Initializes the bus instance, read properties and create child
+ * devices.
+ */
+int sdw_add_bus_master(struct sdw_bus *bus)
+{
+	int ret;
+
+	if (!bus->dev) {
+		pr_err("SoundWire bus has no device");
+		return -ENODEV;
+	}
+
+	mutex_init(&bus->bus_lock);
+	INIT_LIST_HEAD(&bus->slaves);
+
+	/*
+	 * Device numbers in SoundWire are 0 thru 15 with 0 being
+	 * Enumeration device number and 15 broadcast device number. So
+	 * they are not used for assignment so mask these and other
+	 * higher bits
+	 */
+
+	/* Set higher order bits */
+	*bus->assigned = ~GENMASK(SDW_BROADCAST_DEV_NUM, SDW_ENUM_DEV_NUM);
+
+	/* Set device number and broadcast device number */
+	set_bit(SDW_ENUM_DEV_NUM, bus->assigned);
+	set_bit(SDW_BROADCAST_DEV_NUM, bus->assigned);
+
+	/*
+	 * SDW is an enumerable bus, but devices can be powered off. So,
+	 * they won't be able to report as present.
+	 *
+	 * Create Slave devices based on Slaves described in
+	 * the respective firmware (ACPI/DT)
+	 */
+	if (IS_ENABLED(CONFIG_ACPI) && ACPI_HANDLE(bus->dev))
+		ret = sdw_acpi_find_slaves(bus);
+	else
+		ret = -ENOTSUPP; /* No ACPI/DT so error out */
+
+	if (ret) {
+		dev_err(bus->dev, "Finding slaves failed:%d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(sdw_add_bus_master);
+
+static int sdw_delete_slave(struct device *dev, void *data)
+{
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	struct sdw_bus *bus = slave->bus;
+
+	mutex_lock(&bus->bus_lock);
+
+	if (slave->dev_num) /* clear dev_num if assigned */
+		clear_bit(slave->dev_num, bus->assigned);
+
+	list_del_init(&slave->node);
+	mutex_unlock(&bus->bus_lock);
+
+	device_unregister(dev);
+	return 0;
+}
+
+/**
+ * sdw_delete_bus_master() - delete the bus master instance
+ * @bus: bus to be deleted
+ *
+ * Remove the instance, delete the child devices.
+ */
+void sdw_delete_bus_master(struct sdw_bus *bus)
+{
+	device_for_each_child(bus->dev, NULL, sdw_delete_slave);
+}
+EXPORT_SYMBOL(sdw_delete_bus_master);
+
+void sdw_extract_slave_id(struct sdw_bus *bus,
+			u64 addr, struct sdw_slave_id *id)
+{
+	dev_dbg(bus->dev, "SDW Slave Addr: %llx", addr);
+
+	/*
+	 * Spec definition
+	 *   Register		Bit	Contents
+	 *   DevId_0 [7:4]	47:44	sdw_version
+	 *   DevId_0 [3:0]	43:40	unique_id
+	 *   DevId_1		39:32	mfg_id [15:8]
+	 *   DevId_2		31:24	mfg_id [7:0]
+	 *   DevId_3		23:16	part_id [15:8]
+	 *   DevId_4		15:08	part_id [7:0]
+	 *   DevId_5		07:00	class_id
+	 */
+	id->sdw_version = (addr >> 44) & GENMASK(3, 0);
+	id->unique_id = (addr >> 40) & GENMASK(3, 0);
+	id->mfg_id = (addr >> 24) & GENMASK(15, 0);
+	id->part_id = (addr >> 8) & GENMASK(15, 0);
+	id->class_id = addr & GENMASK(7, 0);
+
+	dev_dbg(bus->dev,
+		"SDW Slave class_id %x, part_id %x, mfg_id %x, unique_id %x, version %x",
+				id->class_id, id->part_id, id->mfg_id,
+				id->unique_id, id->sdw_version);
+
+}
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
new file mode 100644
index 000000000000..a54921825ce0
--- /dev/null
+++ b/drivers/soundwire/bus.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2015-17 Intel Corporation.
+
+#ifndef __SDW_BUS_H
+#define __SDW_BUS_H
+
+#if IS_ENABLED(CONFIG_ACPI)
+int sdw_acpi_find_slaves(struct sdw_bus *bus);
+#else
+static inline int sdw_acpi_find_slaves(struct sdw_bus *bus)
+{
+	return -ENOTSUPP;
+}
+#endif
+
+void sdw_extract_slave_id(struct sdw_bus *bus,
+			u64 addr, struct sdw_slave_id *id);
+
+#endif /* __SDW_BUS_H */
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
new file mode 100644
index 000000000000..397e100d66e3
--- /dev/null
+++ b/drivers/soundwire/slave.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2015-17 Intel Corporation.
+
+#include <linux/acpi.h>
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_type.h>
+#include "bus.h"
+
+static void sdw_slave_release(struct device *dev)
+{
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+
+	kfree(slave);
+}
+
+static int sdw_slave_add(struct sdw_bus *bus,
+		struct sdw_slave_id *id, struct fwnode_handle *fwnode)
+{
+	struct sdw_slave *slave;
+	int ret;
+
+	slave = kzalloc(sizeof(*slave), GFP_KERNEL);
+	if (!slave)
+		return -ENOMEM;
+
+	/* Initialize data structure */
+	memcpy(&slave->id, id, sizeof(*id));
+	slave->dev.parent = bus->dev;
+	slave->dev.fwnode = fwnode;
+
+	/* name shall be sdw:link:mfg:part:class:unique */
+	dev_set_name(&slave->dev, "sdw:%x:%x:%x:%x:%x",
+			bus->link_id, id->mfg_id, id->part_id,
+			id->class_id, id->unique_id);
+
+	slave->dev.release = sdw_slave_release;
+	slave->dev.bus = &sdw_bus_type;
+	slave->bus = bus;
+	slave->status = SDW_SLAVE_UNATTACHED;
+	slave->dev_num = 0;
+
+	mutex_lock(&bus->bus_lock);
+	list_add_tail(&slave->node, &bus->slaves);
+	mutex_unlock(&bus->bus_lock);
+
+	ret = device_register(&slave->dev);
+	if (ret) {
+		dev_err(bus->dev, "Failed to add slave: ret %d\n", ret);
+
+		/*
+		 * On err, don't free but drop ref as this will be freed
+		 * when release method is invoked.
+		 */
+		mutex_lock(&bus->bus_lock);
+		list_del(&slave->node);
+		mutex_unlock(&bus->bus_lock);
+		put_device(&slave->dev);
+	}
+
+	return ret;
+}
+
+#if IS_ENABLED(CONFIG_ACPI)
+/*
+ * sdw_acpi_find_slaves() - Find Slave devices in Master ACPI node
+ * @bus: SDW bus instance
+ *
+ * Scans Master ACPI node for SDW child Slave devices and registers it.
+ */
+int sdw_acpi_find_slaves(struct sdw_bus *bus)
+{
+	struct acpi_device *adev, *parent;
+
+	parent = ACPI_COMPANION(bus->dev);
+	if (!parent) {
+		dev_err(bus->dev, "Can't find parent for acpi bind\n");
+		return -ENODEV;
+	}
+
+	list_for_each_entry(adev, &parent->children, node) {
+		unsigned long long addr;
+		struct sdw_slave_id id;
+		unsigned int link_id;
+		acpi_status status;
+
+		status = acpi_evaluate_integer(adev->handle,
+					METHOD_NAME__ADR, NULL, &addr);
+
+		if (ACPI_FAILURE(status)) {
+			dev_err(bus->dev, "_ADR resolution failed: %x\n",
+							status);
+			return status;
+		}
+
+		/* Extract link id from ADR, it is from 48 to 51 bits */
+		link_id = (addr >> 48) & GENMASK(3, 0);
+
+		/* Check for link_id match */
+		if (link_id != bus->link_id)
+			continue;
+
+		sdw_extract_slave_id(bus, addr, &id);
+
+		/*
+		 * don't error check for sdw_slave_add as we want to continue
+		 * adding Slaves
+		 */
+		sdw_slave_add(bus, &id, acpi_fwnode_handle(adev));
+	}
+
+	return 0;
+}
+
+#endif
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 4a7503781602..7e9579941c66 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -7,6 +7,14 @@
 struct sdw_bus;
 struct sdw_slave;
 
+/* SDW spec defines and enums, as defined by MIPI 1.1. Spec */
+
+/* SDW Broadcast Device Number */
+#define SDW_BROADCAST_DEV_NUM		15
+
+/* SDW Enumeration Device Number */
+#define SDW_ENUM_DEV_NUM		0
+
 #define SDW_MAX_DEVICES			11
 
 /**
@@ -108,4 +116,7 @@ struct sdw_bus {
 	struct mutex bus_lock;
 };
 
+int sdw_add_bus_master(struct sdw_bus *bus);
+void sdw_delete_bus_master(struct sdw_bus *bus);
+
 #endif /* __SOUNDWIRE_H */
-- 
2.7.4
