From: srinivas.kandagatla@linaro.org
Subject: [PATCH v9 04/13] slimbus: core: Add slim controllers
	support
Date: Thu,  7 Dec 2017 10:27:11 +0000
Message-ID: <20171207102720.21071-5-srinivas.kandagatla@linaro.org>
References: <20171207102720.21071-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 51D93267A89
 for <alsa-devel@alsa-project.org>; Thu,  7 Dec 2017 11:30:40 +0100 (CET)
Received: by mail-wm0-f66.google.com with SMTP id i11so11909546wmf.4
 for <alsa-devel@alsa-project.org>; Thu, 07 Dec 2017 02:30:40 -0800 (PST)
In-Reply-To: <20171207102720.21071-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org, j.neuschaefer@gmx.net, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, pombredanne@nexb.com, sdharia@codeaurora.org
List-Id: alsa-devel@alsa-project.org

From: Sagar Dharia <sdharia@codeaurora.org>

This patch adds support to slim controllers in the slim core,
including some utility functions invoked by the controller and
slim device drivers.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/core.c    | 306 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/slimbus/slimbus.h | 106 ++++++++++++++++
 include/linux/slimbus.h   |   8 ++
 3 files changed, 420 insertions(+)
 create mode 100644 drivers/slimbus/slimbus.h

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index f4e6bfdeef92..a59a88a7a52d 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -5,7 +5,11 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/init.h>
+#include <linux/idr.h>
 #include <linux/slimbus.h>
+#include "slimbus.h"
+
+static DEFINE_IDA(ctrl_ida);
 
 static const struct slim_device_id *slim_match(const struct slim_device_id *id,
 					       const struct slim_device *sbdev)
@@ -90,6 +94,308 @@ void slim_driver_unregister(struct slim_driver *drv)
 }
 EXPORT_SYMBOL_GPL(slim_driver_unregister);
 
+static void slim_dev_release(struct device *dev)
+{
+	struct slim_device *sbdev = to_slim_device(dev);
+
+	kfree(sbdev);
+}
+
+static int slim_add_device(struct slim_controller *ctrl,
+			   struct slim_device *sbdev,
+			   struct device_node *node)
+{
+	sbdev->dev.bus = &slimbus_bus;
+	sbdev->dev.parent = ctrl->dev;
+	sbdev->dev.release = slim_dev_release;
+	sbdev->dev.driver = NULL;
+	sbdev->ctrl = ctrl;
+
+	dev_set_name(&sbdev->dev, "%x:%x:%x:%x",
+				  sbdev->e_addr.manf_id,
+				  sbdev->e_addr.prod_code,
+				  sbdev->e_addr.dev_index,
+				  sbdev->e_addr.instance);
+
+	return device_register(&sbdev->dev);
+}
+
+static struct slim_device *slim_alloc_device(struct slim_controller *ctrl,
+					     struct slim_eaddr *eaddr,
+					     struct device_node *node)
+{
+	struct slim_device *sbdev;
+	int ret;
+
+	sbdev = kzalloc(sizeof(*sbdev), GFP_KERNEL);
+	if (!sbdev)
+		return NULL;
+
+	sbdev->e_addr = *eaddr;
+	ret = slim_add_device(ctrl, sbdev, node);
+	if (ret) {
+		kfree(sbdev);
+		return NULL;
+	}
+
+	return sbdev;
+}
+
+/*
+ * slim_register_controller() - Controller bring-up and registration.
+ *
+ * @ctrl: Controller to be registered.
+ *
+ * A controller is registered with the framework using this API.
+ * If devices on a controller were registered before controller,
+ * this will make sure that they get probed when controller is up
+ */
+int slim_register_controller(struct slim_controller *ctrl)
+{
+	int id;
+
+	id = ida_simple_get(&ctrl_ida, 0, 0, GFP_KERNEL);
+	if (id < 0)
+		return id;
+
+	ctrl->id = id;
+
+	if (!ctrl->min_cg)
+		ctrl->min_cg = SLIM_MIN_CLK_GEAR;
+	if (!ctrl->max_cg)
+		ctrl->max_cg = SLIM_MAX_CLK_GEAR;
+
+	ida_init(&ctrl->laddr_ida);
+	idr_init(&ctrl->tid_idr);
+	mutex_init(&ctrl->lock);
+
+	dev_dbg(ctrl->dev, "Bus [%s] registered:dev:%p\n",
+		ctrl->name, ctrl->dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(slim_register_controller);
+
+/* slim_remove_device: Remove the effect of slim_add_device() */
+static void slim_remove_device(struct slim_device *sbdev)
+{
+	device_unregister(&sbdev->dev);
+}
+
+static int slim_ctrl_remove_device(struct device *dev, void *null)
+{
+	slim_remove_device(to_slim_device(dev));
+	return 0;
+}
+
+/**
+ * slim_unregister_controller() - Controller tear-down.
+ *
+ * @ctrl: Controller to tear-down.
+ */
+int slim_unregister_controller(struct slim_controller *ctrl)
+{
+	/* Remove all clients */
+	device_for_each_child(ctrl->dev, NULL, slim_ctrl_remove_device);
+	ida_simple_remove(&ctrl_ida, ctrl->id);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(slim_unregister_controller);
+
+static void slim_device_update_status(struct slim_device *sbdev,
+				      enum slim_device_status status)
+{
+	struct slim_driver *sbdrv;
+
+	if (sbdev->status == status)
+		return;
+
+	sbdev->status = status;
+	if (!sbdev->dev.driver)
+		return;
+
+	sbdrv = to_slim_driver(sbdev->dev.driver);
+	if (sbdrv->device_status)
+		sbdrv->device_status(sbdev, sbdev->status);
+}
+
+/**
+ * slim_report_absent() - Controller calls this function when a device
+ *	reports absent, OR when the device cannot be communicated with
+ *
+ * @sbdev: Device that cannot be reached, or sent report absent
+ */
+void slim_report_absent(struct slim_device *sbdev)
+{
+	struct slim_controller *ctrl = sbdev->ctrl;
+
+	if (!ctrl)
+		return;
+
+	/* invalidate logical addresses */
+	mutex_lock(&ctrl->lock);
+	sbdev->is_laddr_valid = false;
+	mutex_unlock(&ctrl->lock);
+
+	ida_simple_remove(&ctrl->laddr_ida, sbdev->laddr);
+	slim_device_update_status(sbdev, SLIM_DEVICE_STATUS_DOWN);
+}
+EXPORT_SYMBOL_GPL(slim_report_absent);
+
+static bool slim_eaddr_equal(struct slim_eaddr *a, struct slim_eaddr *b)
+{
+	return (a->manf_id == b->manf_id &&
+		a->prod_code == b->prod_code &&
+		a->dev_index == b->dev_index &&
+		a->instance == b->instance);
+}
+
+static int slim_match_dev(struct device *dev, void *data)
+{
+	struct slim_eaddr *e_addr = data;
+	struct slim_device *sbdev = to_slim_device(dev);
+
+	return slim_eaddr_equal(&sbdev->e_addr, e_addr);
+}
+
+static struct slim_device *find_slim_device(struct slim_controller *ctrl,
+					    struct slim_eaddr *eaddr)
+{
+	struct slim_device *sbdev;
+	struct device *dev;
+
+	dev = device_find_child(ctrl->dev, eaddr, slim_match_dev);
+	if (dev) {
+		sbdev = to_slim_device(dev);
+		return sbdev;
+	}
+
+	return NULL;
+}
+
+/**
+ * slim_get_device() - get handle to a device.
+ *
+ * @ctrl: Controller on which this device will be added/queried
+ * @e_addr: Enumeration address of the device to be queried
+ *
+ * Return: pointer to a device if it has already reported. Creates a new
+ * device and returns pointer to it if the device has not yet enumerated.
+ */
+struct slim_device *slim_get_device(struct slim_controller *ctrl,
+				    struct slim_eaddr *e_addr)
+{
+	struct slim_device *sbdev;
+
+	sbdev = find_slim_device(ctrl, e_addr);
+	if (!sbdev) {
+		sbdev = slim_alloc_device(ctrl, e_addr, NULL);
+		if (!sbdev)
+			return ERR_PTR(-ENOMEM);
+	}
+
+	return sbdev;
+}
+EXPORT_SYMBOL_GPL(slim_get_device);
+
+static int slim_device_alloc_laddr(struct slim_device *sbdev,
+				   bool report_present)
+{
+	struct slim_controller *ctrl = sbdev->ctrl;
+	u8 laddr;
+	int ret;
+
+	mutex_lock(&ctrl->lock);
+	if (ctrl->get_laddr) {
+		ret = ctrl->get_laddr(ctrl, &sbdev->e_addr, &laddr);
+		if (ret < 0)
+			goto err;
+	} else if (report_present) {
+		ret = ida_simple_get(&ctrl->laddr_ida,
+				     0, SLIM_LA_MANAGER - 1, GFP_KERNEL);
+		if (ret < 0)
+			goto err;
+
+		laddr = ret;
+	} else {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (ctrl->set_laddr) {
+		ret = ctrl->set_laddr(ctrl, &sbdev->e_addr, laddr);
+		if (ret) {
+			ret = -EINVAL;
+			goto err;
+		}
+	}
+
+	sbdev->laddr = laddr;
+	sbdev->is_laddr_valid = true;
+
+	slim_device_update_status(sbdev, SLIM_DEVICE_STATUS_UP);
+
+	dev_dbg(ctrl->dev, "setting slimbus l-addr:%x, ea:%x,%x,%x,%x\n",
+		laddr, sbdev->e_addr.manf_id, sbdev->e_addr.prod_code,
+		sbdev->e_addr.dev_index, sbdev->e_addr.instance);
+
+err:
+	mutex_unlock(&ctrl->lock);
+	return ret;
+
+}
+
+/**
+ * slim_device_report_present() - Report enumerated device.
+ *
+ * @ctrl: Controller with which device is enumerated.
+ * @e_addr: Enumeration address of the device.
+ * @laddr: Return logical address (if valid flag is false)
+ *
+ * Called by controller in response to REPORT_PRESENT. Framework will assign
+ * a logical address to this enumeration address.
+ * Function returns -EXFULL to indicate that all logical addresses are already
+ * taken.
+ */
+int slim_device_report_present(struct slim_controller *ctrl,
+			       struct slim_eaddr *e_addr, u8 *laddr)
+{
+	struct slim_device *sbdev;
+	int ret;
+
+	sbdev = slim_get_device(ctrl, e_addr);
+	if (IS_ERR(sbdev))
+		return -ENODEV;
+
+	if (sbdev->is_laddr_valid) {
+		*laddr = sbdev->laddr;
+		return 0;
+	}
+
+	ret = slim_device_alloc_laddr(sbdev, true);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(slim_device_report_present);
+
+/**
+ * slim_get_logical_addr() - get/allocate logical address of a SLIMbus device.
+ *
+ * @sbdev: client handle requesting the address.
+ *
+ * Return: zero if a logical address is valid or a new logical address
+ * has been assigned. error code in case of error.
+ */
+int slim_get_logical_addr(struct slim_device *sbdev)
+{
+	if (!sbdev->is_laddr_valid)
+		return slim_device_alloc_laddr(sbdev, false);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(slim_get_logical_addr);
+
 static void __exit slimbus_exit(void)
 {
 	bus_unregister(&slimbus_bus);
diff --git a/drivers/slimbus/slimbus.h b/drivers/slimbus/slimbus.h
new file mode 100644
index 000000000000..155d7231627d
--- /dev/null
+++ b/drivers/slimbus/slimbus.h
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2011-2017, The Linux Foundation
+
+#ifndef _DRIVERS_SLIMBUS_H
+#define _DRIVERS_SLIMBUS_H
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/slimbus.h>
+
+/* Standard values per SLIMbus spec needed by controllers and devices */
+#define SLIM_MAX_CLK_GEAR		10
+#define SLIM_MIN_CLK_GEAR		1
+
+/* Manager's logical address is set to 0xFF per spec */
+#define SLIM_LA_MANAGER 0xFF
+
+/**
+ * struct slim_framer - Represents SLIMbus framer.
+ * Every controller may have multiple framers. There is 1 active framer device
+ * responsible for clocking the bus.
+ * Manager is responsible for framer hand-over.
+ * @dev: Driver model representation of the device.
+ * @e_addr: Enumeration address of the framer.
+ * @rootfreq: Root Frequency at which the framer can run. This is maximum
+ *	frequency ('clock gear 10') at which the bus can operate.
+ * @superfreq: Superframes per root frequency. Every frame is 6144 bits.
+ */
+struct slim_framer {
+	struct device		dev;
+	struct slim_eaddr	e_addr;
+	int			rootfreq;
+	int			superfreq;
+};
+
+#define to_slim_framer(d) container_of(d, struct slim_framer, dev)
+
+/**
+ * struct slim_controller  - Controls every instance of SLIMbus
+ *				(similar to 'master' on SPI)
+ * @dev: Device interface to this driver
+ * @id: Board-specific number identifier for this controller/bus
+ * @name: Name for this controller
+ * @min_cg: Minimum clock gear supported by this controller (default value: 1)
+ * @max_cg: Maximum clock gear supported by this controller (default value: 10)
+ * @clkgear: Current clock gear in which this bus is running
+ * @laddr_ida: logical address id allocator
+ * @a_framer: Active framer which is clocking the bus managed by this controller
+ * @lock: Mutex protecting controller data structures
+ * @devices: Slim device list
+ * @tid_idr: tid id allocator
+ * @txn_lock: Lock to protect table of transactions
+ * @set_laddr: Setup logical address at laddr for the slave with elemental
+ *	address e_addr. Drivers implementing controller will be expected to
+ *	send unicast message to this device with its logical address.
+ * @get_laddr: It is possible that controller needs to set fixed logical
+ *	address table and get_laddr can be used in that case so that controller
+ *	can do this assignment. Use case is when the master is on the remote
+ *	processor side, who is resposible for allocating laddr.
+ *
+ *	'Manager device' is responsible for  device management, bandwidth
+ *	allocation, channel setup, and port associations per channel.
+ *	Device management means Logical address assignment/removal based on
+ *	enumeration (report-present, report-absent) of a device.
+ *	Bandwidth allocation is done dynamically by the manager based on active
+ *	channels on the bus, message-bandwidth requests made by SLIMbus devices.
+ *	Based on current bandwidth usage, manager chooses a frequency to run
+ *	the bus at (in steps of 'clock-gear', 1 through 10, each clock gear
+ *	representing twice the frequency than the previous gear).
+ *	Manager is also responsible for entering (and exiting) low-power-mode
+ *	(known as 'clock pause').
+ *	Manager can do handover of framer if there are multiple framers on the
+ *	bus and a certain usecase warrants using certain framer to avoid keeping
+ *	previous framer being powered-on.
+ *
+ *	Controller here performs duties of the manager device, and 'interface
+ *	device'. Interface device is responsible for monitoring the bus and
+ *	reporting information such as loss-of-synchronization, data
+ *	slot-collision.
+ */
+struct slim_controller {
+	struct device		*dev;
+	unsigned int		id;
+	char			name[SLIMBUS_NAME_SIZE];
+	int			min_cg;
+	int			max_cg;
+	int			clkgear;
+	struct ida		laddr_ida;
+	struct slim_framer	*a_framer;
+	struct mutex		lock;
+	struct list_head	devices;
+	struct idr		tid_idr;
+	spinlock_t		txn_lock;
+	int			(*set_laddr)(struct slim_controller *ctrl,
+					     struct slim_eaddr *ea, u8 laddr);
+	int			(*get_laddr)(struct slim_controller *ctrl,
+					     struct slim_eaddr *ea, u8 *laddr);
+};
+
+int slim_device_report_present(struct slim_controller *ctrl,
+			       struct slim_eaddr *e_addr, u8 *laddr);
+void slim_report_absent(struct slim_device *sbdev);
+int slim_register_controller(struct slim_controller *ctrl);
+int slim_unregister_controller(struct slim_controller *ctrl);
+
+#endif /* _LINUX_SLIMBUS_H */
diff --git a/include/linux/slimbus.h b/include/linux/slimbus.h
index a52f8e530f27..b59b272666b6 100644
--- a/include/linux/slimbus.h
+++ b/include/linux/slimbus.h
@@ -35,11 +35,14 @@ enum slim_device_status {
 	SLIM_DEVICE_STATUS_RESERVED,
 };
 
+struct slim_controller;
+
 /**
  * struct slim_device - Slim device handle.
  * @dev: Driver model representation of the device.
  * @e_addr: Enumeration address of this device.
  * @status: slim device status
+ * @ctrl: slim controller instance.
  * @laddr: 1-byte Logical address of this device.
  * @is_laddr_valid: indicates if the laddr is valid or not
  *
@@ -50,6 +53,7 @@ enum slim_device_status {
 struct slim_device {
 	struct device		dev;
 	struct slim_eaddr	e_addr;
+	struct slim_controller	*ctrl;
 	enum slim_device_status	status;
 	u8			laddr;
 	bool			is_laddr_valid;
@@ -111,4 +115,8 @@ static inline void slim_set_devicedata(struct slim_device *dev, void *data)
 {
 	dev_set_drvdata(&dev->dev, data);
 }
+
+struct slim_device *slim_get_device(struct slim_controller *ctrl,
+				    struct slim_eaddr *e_addr);
+int slim_get_logical_addr(struct slim_device *sbdev);
 #endif /* _LINUX_SLIMBUS_H */
-- 
2.15.0
