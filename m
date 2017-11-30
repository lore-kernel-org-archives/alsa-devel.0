From: srinivas.kandagatla@linaro.org
Subject: [PATCH v8 03/13] slimbus: Add SLIMbus bus type
Date: Thu, 30 Nov 2017 17:41:50 +0000
Message-ID: <20171130174200.6684-4-srinivas.kandagatla@linaro.org>
References: <20171130174200.6684-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f196.google.com (mail-wr0-f196.google.com
 [209.85.128.196])
 by alsa0.perex.cz (Postfix) with ESMTP id D1322267B21
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 18:45:52 +0100 (CET)
Received: by mail-wr0-f196.google.com with SMTP id z18so7468795wrb.8
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 09:45:52 -0800 (PST)
In-Reply-To: <20171130174200.6684-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: mark.rutland@arm.com, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, srinivas.kandagatla@linaro.org, andreas.noever@gmail.com, arnd@arndb.de, vinod.koul@intel.com, bp@suse.de, devicetree@vger.kernel.org, james.hogan@imgtec.com, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, robh+dt@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, treding@nvidia.com, mathieu.poirier@linaro.org, jkosina@suse.cz, linux-kernel@vger.kernel.org, daniel@ffwll.ch, joe@perches.com, davem@davemloft.net
List-Id: alsa-devel@alsa-project.org

From: Sagar Dharia <sdharia@codeaurora.org>

SLIMbus (Serial Low Power Interchip Media Bus) is a specification
developed by MIPI (Mobile Industry Processor Interface) alliance.
SLIMbus is a 2-wire implementation, which is used to communicate with
peripheral components like audio-codec.
SLIMbus uses Time-Division-Multiplexing to accommodate multiple data
channels, and control channel. Control channel has messages to do
device-enumeration, messages to send/receive control-data to/from
SLIMbus devices, messages for port/channel management, and messages to
do bandwidth allocation.
The framework supports multiple instances of the bus (1 controller per
bus), and multiple slave devices per controller.

This patch adds support to basic silmbus core which includes support to
SLIMbus type, slimbus device registeration and some basic data structures.

Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/Kconfig                 |   2 +
 drivers/Makefile                |   1 +
 drivers/slimbus/Kconfig         |  16 ++++++
 drivers/slimbus/Makefile        |   5 ++
 drivers/slimbus/core.c          | 115 +++++++++++++++++++++++++++++++++++++
 include/linux/mod_devicetable.h |  13 +++++
 include/linux/slimbus.h         | 123 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 275 insertions(+)
 create mode 100644 drivers/slimbus/Kconfig
 create mode 100644 drivers/slimbus/Makefile
 create mode 100644 drivers/slimbus/core.c
 create mode 100644 include/linux/slimbus.h

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 152744c5ef0f..c8e1d1c3f426 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -211,4 +211,6 @@ source "drivers/mux/Kconfig"
 
 source "drivers/opp/Kconfig"
 
+source "drivers/slimbus/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index 1d034b680431..d233a95b3b24 100644
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
index 000000000000..ecf94ef66f10
--- /dev/null
+++ b/drivers/slimbus/Kconfig
@@ -0,0 +1,16 @@
+#
+# SLIMbus driver configuration
+#
+menuconfig SLIMBUS
+	tristate "SLIMbus support"
+	help
+	  SLIMbus is standard interface between System-on-Chip and audio codec,
+	  and other peripheral components in typical embedded systems.
+
+	  If unsure, choose N.
+
+if SLIMBUS
+
+# SLIMbus controllers
+
+endif
diff --git a/drivers/slimbus/Makefile b/drivers/slimbus/Makefile
new file mode 100644
index 000000000000..49ac5dce3fef
--- /dev/null
+++ b/drivers/slimbus/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for kernel SLIMbus framework.
+#
+obj-$(CONFIG_SLIMBUS)			+= slimbus.o
+slimbus-y				:= core.o
diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
new file mode 100644
index 000000000000..005714464fd8
--- /dev/null
+++ b/drivers/slimbus/core.c
@@ -0,0 +1,115 @@
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
+	return !!slim_match(sbdrv->id_table, sbdev);
+}
+
+static int slim_device_probe(struct device *dev)
+{
+	struct slim_device	*sbdev = to_slim_device(dev);
+	struct slim_driver	*sbdrv = to_slim_driver(dev->driver);
+
+	return sbdrv->probe(sbdev);
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
+ * __slim_driver_register() - Client driver registration with SLIMbus
+ *
+ * @drv:Client driver to be associated with client-device.
+ * @owner: owning module/driver
+ *
+ * This API will register the client driver with the SLIMbus
+ * It is called from the driver's module-init function.
+ */
+int __slim_driver_register(struct slim_driver *drv, struct module *owner)
+{
+	/* ID table and probe are mandatory */
+	if (!drv->id_table || !drv->probe)
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
index abb6dc2ebbf8..48e188327c02 100644
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
+	__u16 dev_index, instance;
+
+	/* Data private to the driver */
+	kernel_ulong_t driver_data;
+};
+
 #define SPMI_NAME_SIZE	32
 #define SPMI_MODULE_PREFIX "spmi:"
 
diff --git a/include/linux/slimbus.h b/include/linux/slimbus.h
new file mode 100644
index 000000000000..852cdb9f1abd
--- /dev/null
+++ b/include/linux/slimbus.h
@@ -0,0 +1,123 @@
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
+extern struct bus_type slimbus_bus;
+
+/**
+ * struct slim_eaddr - Enumeration address for a SLIMbus device
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
+} __packed;
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
+ * @e_addr: Enumeration address of this device.
+ * @status: slim device status
+ * @laddr: 1-byte Logical address of this device.
+ * @is_laddr_valid: indicates if the laddr is valid or not
+ *
+ * This is the client/device handle returned when a SLIMbus
+ * device is registered with a controller.
+ * Pointer to this structure is used by client-driver as a handle.
+ */
+struct slim_device {
+	struct device		dev;
+	struct slim_eaddr	e_addr;
+	enum slim_device_status	status;
+	u8			laddr;
+	bool			is_laddr_valid;
+};
+
+#define to_slim_device(d) container_of(d, struct slim_device, dev)
+
+/**
+ * struct slim_driver - SLIMbus 'generic device' (slave) device driver
+ *				(similar to 'spi_device' on SPI)
+ * @probe: Binds this driver to a SLIMbus device.
+ * @remove: Unbinds this driver from the SLIMbus device.
+ * @shutdown: Standard shutdown callback used during powerdown/halt.
+ * @device_status: This callback is called when
+ *	- The device reports present and gets a laddr assigned
+ *	- The device reports absent, or the bus goes down.
+ * @driver: SLIMbus device drivers should initialize name and owner field of
+ *	    this structure
+ * @id_table: List of SLIMbus devices supported by this driver
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
+ * module_slim_driver() - Helper macro for registering a SLIMbus driver
+ * @__slim_driver: slimbus_driver struct
+ *
+ * Helper macro for SLIMbus drivers which do not do anything special in module
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
