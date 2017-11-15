From: srinivas.kandagatla@linaro.org
Subject: [PATCH v7 03/13] slimbus: Add SLIMbus bus type
Date: Wed, 15 Nov 2017 14:10:33 +0000
Message-ID: <20171115141043.29202-4-srinivas.kandagatla@linaro.org>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, vinod.koul@intel.com, arnd@arndb.de, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Sagar Dharia <sdharia@codeaurora.org>

SLIMbus (Serial Low Power Interchip Media Bus) is a specification
developed by MIPI (Mobile Industry Processor Interface) alliance.
SLIMbus is a 2-wire implementation, which is used to communicate with
peripheral components like audio-codec.
SLIMbus uses Time-Division-Multiplexing to accommodate multiple data
channels, and control channel. Control channel has messages to do
device-enumeration, messages to send/receive control-data to/from
slimbus devices, messages for port/channel management, and messages to
do bandwidth allocation.
The framework supports multiple instances of the bus (1 controller per
bus), and multiple slave devices per controller.

This patch adds support to basic silmbus core which includes support to
slimbus type, slimbus device registeration and some basic data structures.

Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/Kconfig                 |   2 +
 drivers/Makefile                |   1 +
 drivers/slimbus/Kconfig         |  16 +++++
 drivers/slimbus/Makefile        |   5 ++
 drivers/slimbus/core.c          | 122 +++++++++++++++++++++++++++++++++++++
 include/linux/mod_devicetable.h |  13 ++++
 include/linux/slimbus.h         | 129 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 288 insertions(+)
 create mode 100644 drivers/slimbus/Kconfig
 create mode 100644 drivers/slimbus/Makefile
 create mode 100644 drivers/slimbus/core.c
 create mode 100644 include/linux/slimbus.h

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 1d7af3c2ff27..dd921785e65c 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -209,4 +209,6 @@ source "drivers/tee/Kconfig"
 
 source "drivers/mux/Kconfig"
 
+source "drivers/slimbus/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index d242d3514d30..876c6624103c 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -87,6 +87,7 @@ obj-$(CONFIG_MTD)		+= mtd/
 obj-$(CONFIG_SPI)		+= spi/
 obj-$(CONFIG_SPMI)		+= spmi/
 obj-$(CONFIG_HSI)		+= hsi/
+obj-$(CONFIG_SLIMBUS)		+= slimbus/
 obj-y				+= net/
 obj-$(CONFIG_ATM)		+= atm/
 obj-$(CONFIG_FUSION)		+= message/
diff --git a/drivers/slimbus/Kconfig b/drivers/slimbus/Kconfig
new file mode 100644
index 000000000000..9c7d3c61656a
--- /dev/null
+++ b/drivers/slimbus/Kconfig
@@ -0,0 +1,16 @@
+#
+# SLIMBUS driver configuration
+#
+menuconfig SLIMBUS
+	tristate "Slimbus support"
+	help
+	  Slimbus is standard interface between System-on-Chip and audio codec,
+	  and other peripheral components in typical embedded systems.
+
+	  If unsure, choose N.
+
+if SLIMBUS
+
+# SlIMbus controllers
+
+endif
diff --git a/drivers/slimbus/Makefile b/drivers/slimbus/Makefile
new file mode 100644
index 000000000000..50deace4e76d
--- /dev/null
+++ b/drivers/slimbus/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for kernel slimbus framework.
+#
+obj-$(CONFIG_SLIMBUS)			+= slimbus.o
+slimbus-y				:= core.o
diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
new file mode 100644
index 000000000000..22edebf1a233
--- /dev/null
+++ b/drivers/slimbus/core.c
@@ -0,0 +1,122 @@
+/* Copyright (c) 2011-2017, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/slimbus.h>
+
+static const struct slim_device_id *slim_match(const struct slim_device_id *id,
+					       const struct slim_device *sbdev)
+{
+	while (id->manf_id != 0 || id->prod_code != 0) {
+		if (id->manf_id == sbdev->e_addr.manf_id &&
+		    id->prod_code == sbdev->e_addr.prod_code)
+			return id;
+		id++;
+	}
+	return NULL;
+}
+
+static int slim_device_match(struct device *dev, struct device_driver *drv)
+{
+	struct slim_device *sbdev = to_slim_device(dev);
+	struct slim_driver *sbdrv = to_slim_driver(drv);
+
+	return slim_match(sbdrv->id_table, sbdev) != NULL;
+}
+
+static int slim_device_probe(struct device *dev)
+{
+	struct slim_device	*sbdev;
+	struct slim_driver	*sbdrv;
+	int ret = 0;
+
+	sbdev = to_slim_device(dev);
+	sbdrv = to_slim_driver(dev->driver);
+
+	if (sbdrv->probe)
+		ret = sbdrv->probe(sbdev);
+
+	return ret;
+}
+
+static int slim_device_remove(struct device *dev)
+{
+	struct slim_device *sbdev = to_slim_device(dev);
+	struct slim_driver *sbdrv;
+
+	if (dev->driver) {
+		sbdrv = to_slim_driver(dev->driver);
+		if (sbdrv->remove)
+			sbdrv->remove(sbdev);
+	}
+
+	return 0;
+}
+
+struct bus_type slimbus_bus = {
+	.name		= "slimbus",
+	.match		= slim_device_match,
+	.probe		= slim_device_probe,
+	.remove		= slim_device_remove,
+};
+EXPORT_SYMBOL_GPL(slimbus_bus);
+
+/*
+ * __slim_driver_register() - Client driver registration with slimbus
+ *
+ * @drv:Client driver to be associated with client-device.
+ * @owner: owning module/driver
+ *
+ * This API will register the client driver with the slimbus
+ * It is called from the driver's module-init function.
+ */
+int __slim_driver_register(struct slim_driver *drv, struct module *owner)
+{
+	/* ID table is mandatory to match the devices to probe */
+	if (!drv->id_table)
+		return -EINVAL;
+
+	drv->driver.bus = &slimbus_bus;
+	drv->driver.owner = owner;
+
+	return driver_register(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(__slim_driver_register);
+
+/*
+ * slim_driver_unregister() - Undo effect of slim_driver_register
+ *
+ * @drv: Client driver to be unregistered
+ */
+void slim_driver_unregister(struct slim_driver *drv)
+{
+	driver_unregister(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(slim_driver_unregister);
+
+static void __exit slimbus_exit(void)
+{
+	bus_unregister(&slimbus_bus);
+}
+module_exit(slimbus_exit);
+
+static int __init slimbus_init(void)
+{
+	return bus_register(&slimbus_bus);
+}
+postcore_initcall(slimbus_init);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("SLIMbus core");
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 1c2e8d6b7274..7d6238863fc1 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -452,6 +452,19 @@ struct spi_device_id {
 	kernel_ulong_t driver_data;	/* Data private to the driver */
 };
 
+/* SLIMbus */
+
+#define SLIMBUS_NAME_SIZE	32
+#define SLIMBUS_MODULE_PREFIX	"slim:"
+
+struct slim_device_id {
+	__u16 manf_id, prod_code;
+	__u8 dev_index, instance;
+
+	/* Data private to the driver */
+	kernel_ulong_t driver_data;
+};
+
 #define SPMI_NAME_SIZE	32
 #define SPMI_MODULE_PREFIX "spmi:"
 
diff --git a/include/linux/slimbus.h b/include/linux/slimbus.h
new file mode 100644
index 000000000000..057198216a65
--- /dev/null
+++ b/include/linux/slimbus.h
@@ -0,0 +1,129 @@
+/* Copyright (c) 2011-2017, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _LINUX_SLIMBUS_H
+#define _LINUX_SLIMBUS_H
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+
+/**
+ * Interfaces between SLIMbus manager drivers, SLIMbus client drivers, and
+ * SLIMbus infrastructure.
+ */
+
+extern struct bus_type slimbus_bus;
+
+/**
+ * struct slim_eaddr - Enumeration address for a slimbus device
+ * @manf_id: Manufacturer Id for the device
+ * @prod_code: Product code
+ * @dev_index: Device index
+ * @instance: Instance value
+ */
+struct slim_eaddr {
+	u16 manf_id;
+	u16 prod_code;
+	u8 dev_index;
+	u8 instance;
+};
+
+/**
+ * enum slim_device_status - slim device status
+ * @SLIM_DEVICE_STATUS_DOWN: Slim device is absent or not reported yet.
+ * @SLIM_DEVICE_STATUS_UP: Slim device is announced on the bus.
+ * @SLIM_DEVICE_STATUS_RESERVED: Reserved for future use.
+ */
+enum slim_device_status {
+	SLIM_DEVICE_STATUS_DOWN = 0,
+	SLIM_DEVICE_STATUS_UP,
+	SLIM_DEVICE_STATUS_RESERVED,
+};
+
+/**
+ * struct slim_device - Slim device handle.
+ * @dev: Driver model representation of the device.
+ * @name: Name of driver to use with this device.
+ * @e_addr: Enumeration address of this device.
+ * @driver: Device's driver. Pointer to access routines.
+ * @laddr: 1-byte Logical address of this device.
+ *
+ * This is the client/device handle returned when a slimbus
+ * device is registered with a controller.
+ * Pointer to this structure is used by client-driver as a handle.
+ */
+struct slim_device {
+	struct device		dev;
+	struct slim_eaddr	e_addr;
+	struct list_head node;
+	enum slim_device_status	status;
+	u8			laddr;
+	bool			is_laddr_valid;
+};
+
+#define to_slim_device(d) container_of(d, struct slim_device, dev)
+
+/**
+ * struct slim_driver - Slimbus 'generic device' (slave) device driver
+ *				(similar to 'spi_device' on SPI)
+ * @probe: Binds this driver to a slimbus device.
+ * @remove: Unbinds this driver from the slimbus device.
+ * @shutdown: Standard shutdown callback used during powerdown/halt.
+ * @device_status: This callback is called when
+ *	-The device reports present and gets a laddr assigned
+ *	-The device reports absent, or the bus goes down.
+ * @driver: Slimbus device drivers should initialize name and owner field of
+ *	    this structure
+ * @id_table: List of slimbus devices supported by this driver
+ */
+
+struct slim_driver {
+	int	(*probe)(struct slim_device *sl);
+	void	(*remove)(struct slim_device *sl);
+	void	(*shutdown)(struct slim_device *sl);
+	int	(*device_status)(struct slim_device *sl,
+				 enum slim_device_status s);
+	struct device_driver		driver;
+	const struct slim_device_id	*id_table;
+};
+#define to_slim_driver(d) container_of(d, struct slim_driver, driver)
+
+/*
+ * use a macro to avoid include chaining to get THIS_MODULE
+ */
+#define slim_driver_register(drv) \
+	__slim_driver_register(drv, THIS_MODULE)
+int __slim_driver_register(struct slim_driver *drv, struct module *owner);
+void slim_driver_unregister(struct slim_driver *drv);
+
+/**
+ * module_slim_driver() - Helper macro for registering a slimbus driver
+ * @__slimbus_driver: slimbus_driver struct
+ *
+ * Helper macro for slimbus drivers which do not do anything special in module
+ * init/exit. This eliminates a lot of boilerplate. Each module may only
+ * use this macro once, and calling it replaces module_init() and module_exit()
+ */
+#define module_slim_driver(__slim_driver) \
+	module_driver(__slim_driver, slim_driver_register, \
+			slim_driver_unregister)
+
+static inline void *slim_get_devicedata(const struct slim_device *dev)
+{
+	return dev_get_drvdata(&dev->dev);
+}
+
+static inline void slim_set_devicedata(struct slim_device *dev, void *data)
+{
+	dev_set_drvdata(&dev->dev, data);
+}
+#endif /* _LINUX_SLIMBUS_H */
-- 
2.15.0
