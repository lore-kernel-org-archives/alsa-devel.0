From: srinivas.kandagatla@linaro.org
Subject: [Patch v6 1/7] slimbus: Device management on SLIMbus
Date: Fri,  6 Oct 2017 17:51:30 +0200
Message-ID: <20171006155136.4682-2-srinivas.kandagatla@linaro.org>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 64510266991
 for <alsa-devel@alsa-project.org>; Fri,  6 Oct 2017 17:51:55 +0200 (CEST)
Received: by mail-wm0-f42.google.com with SMTP id i124so8734912wmf.3
 for <alsa-devel@alsa-project.org>; Fri, 06 Oct 2017 08:51:55 -0700 (PDT)
In-Reply-To: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
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
Cc: mark.rutland@arm.com, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, andreas.noever@gmail.com, gong.chen@linux.intel.com, arnd@arndb.de, kheitke@audience.com, bp@suse.de, devicetree@vger.kernel.org, james.hogan@imgtec.com, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, robh+dt@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, treding@nvidia.com, mathieu.poirier@linaro.org, jkosina@suse.cz, linux-kernel@vger.kernel.org, daniel@ffwll.ch, joe@perches.com, davem@davemloft.net
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

This patch does device enumeration, logical address assignment,
informing device when the device reports present/absent etc.
Reporting present may need the driver to do the needful (e.g. turning
on voltage regulators powering the device). Additionally device is
probed when it reports present if that device doesn't need any such
steps mentioned above.

Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/slimbus/bus.txt |  57 ++
 Documentation/slimbus/summary                     | 109 ++++
 drivers/Kconfig                                   |   2 +
 drivers/Makefile                                  |   1 +
 drivers/slimbus/Kconfig                           |  11 +
 drivers/slimbus/Makefile                          |   5 +
 drivers/slimbus/slim-core.c                       | 695 ++++++++++++++++++++++
 include/linux/mod_devicetable.h                   |  13 +
 include/linux/slimbus.h                           | 299 ++++++++++
 9 files changed, 1192 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/slimbus/bus.txt
 create mode 100644 Documentation/slimbus/summary
 create mode 100644 drivers/slimbus/Kconfig
 create mode 100644 drivers/slimbus/Makefile
 create mode 100644 drivers/slimbus/slim-core.c
 create mode 100644 include/linux/slimbus.h

diff --git a/Documentation/devicetree/bindings/slimbus/bus.txt b/Documentation/devicetree/bindings/slimbus/bus.txt
new file mode 100644
index 0000000..cb658bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/slimbus/bus.txt
@@ -0,0 +1,57 @@
+SLIM(Serial Low Power Interchip Media Bus) bus
+
+SLIMbus is a 2-wire bus, and is used to communicate with peripheral
+components like audio-codec.
+
+Controller is a normal device using binding for whatever bus it is
+on (e.g. platform bus).
+Required property for SLIMbus controller node:
+- compatible	- name of SLIMbus controller following generic names
+		recommended practice.
+- #address-cells - should be 2
+- #size-cells	- should be 0
+
+No other properties are required in the SLIMbus controller bus node.
+
+Child nodes:
+Every SLIMbus controller node can contain zero or more child nodes
+representing slave devices on the bus. Every SLIMbus slave device is
+uniquely determined by the enumeration address containing 4 fields:
+Manufacturer ID, Product code, Device index, and Instance value for
+the device.
+If child node is not present and it is instantiated after device
+discovery (slave device reporting itself present).
+
+In some cases it may be necessary to describe non-probeable device
+details such as non-standard ways of powering up a device. In
+such cases, child nodes for those devices will be present as
+slaves of the slimbus-controller, as detailed below.
+
+Required property for SLIMbus child node if it is present:
+- reg		- Is Duplex (Device index, Instance ID) from Enumeration
+		  Address.
+		  Device Index Uniquely identifies multiple Devices within
+		  a single Component.
+		  Instance ID Is for the cases where multiple Devices of the
+		  same type or Class are attached to the bus.
+
+- compatible	-"slimMID,PID". The textual representation of Manufacturer ID,
+	 	  Product Code, shall be in lower case hexadecimal with leading
+		  zeroes suppressed
+
+SLIMbus example for Qualcomm's slimbus manager component:
+
+	slim@28080000 {
+		compatible = "qcom,slim-msm";
+		reg = <0x28080000 0x2000>,
+		interrupts = <0 33 0>;
+		clocks = <&lcc SLIMBUS_SRC>, <&lcc AUDIO_SLIMBUS_CLK>;
+		clock-names = "iface_clk", "core_clk";
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		codec: wcd9310@1{
+			compatible = "slim217,60"";
+			reg = <1 0>;
+		};
+	};
diff --git a/Documentation/slimbus/summary b/Documentation/slimbus/summary
new file mode 100644
index 0000000..e7f90bb
--- /dev/null
+++ b/Documentation/slimbus/summary
@@ -0,0 +1,109 @@
+Overview of Linux kernel SLIMbus support
+========================================
+
+What is SLIMbus?
+----------------
+SLIMbus (Serial Low Power Interchip Media Bus) is a specification developed by
+MIPI (Mobile Industry Processor Interface) alliance. The bus uses master/slave
+configuration, and is a 2-wire multi-drop implementation (clock, and data).
+
+Currently, SLIMbus is used to interface between application processors of SoCs
+(System-on-Chip) and peripheral components (typically codec).SLIMbus uses
+Time-Division-Multiplexing to accommodate multiple data channels, and
+a control channel.
+
+The control channel is used for various control functions such as bus
+management, configuration and status updates.These messages can be unicast (e.g.
+reading/writing device specific values), or multicast (e.g. data channel
+reconfiguration sequence is a broadcast message announced to all devices)
+
+A data channel is used for data-transfer between 2 Slimbus devices. Data
+channel uses dedicated ports on the device.
+
+Hardware description:
+---------------------
+Slimbus specification has different types of device classifications based on
+their capabilities.
+A manager device is responsible for enumeration, configuration, and dynamic
+channel allocation. Every bus has 1 active manager.
+
+A generic device is a device providing application functionality (e.g. codec).
+
+Framer device is responsible for clocking the bus, and transmitting frame-sync
+and framing information on the bus.
+
+Each SLIMbus component has an interface device for monitoring physical layer.
+
+Typically each SoC contains SLIMbus component having 1 manager, 1 framer device,
+1 generic device (for data channel support), and 1 interface device.
+External peripheral SLIMbus component usually has 1 generic device (for
+functionality/data channel support), and an associated interface device.
+The generic device's registers are mapped as 'value elements' so that they can
+be written/read using Slimbus control channel exchanging control/status type of
+information.
+In case there are multiple framer devices on the same bus, manager device is
+responsible to select the active-framer for clocking the bus.
+
+Per specification, Slimbus uses "clock gears" to do power management based on
+current frequency and bandwidth requirements. There are 10 clock gears and each
+gear changes the Slimbus frequency to be twice its previous gear.
+
+Each device has a 6-byte enumeration-address and the manager assigns every
+device with a 1-byte logical address after the devices report presence on the
+bus.
+
+Software description:
+---------------------
+There are 2 types of SLIMbus drivers:
+
+slim_controller represents a 'controller' for SLIMbus. This driver should
+implement duties needed by the SoC (manager device, associated
+interface device for monitoring the layers and reporting errors, default
+framer device).
+
+slim_device represents the 'generic device/component' for SLIMbus, and a
+slim_driver should implement driver for that slim_device.
+
+Device notifications to the driver:
+-----------------------------------
+Since SLIMbus devices have mechanisms for reporting their presence, the
+framework allows drivers to bind when corresponding devices report their
+presence on the bus.
+However, it is possible that the driver needs to be probed
+first so that it can enable corresponding SLIMbus devie (e.g. power it up and/or
+take it out of reset). To support that behavior, the framework allows drivers
+to probe first as well  (e.g. using standard DeviceTree compatbility field).
+This creates the necessity for the driver to know when the device is functional
+(i.e. reported present). device_up callback is used for that reason when the
+device reports present and is assigned a logical address by the controller.
+
+Similarly, SLIMbus devices 'report absent' when they go down. A 'device_down'
+callback notifies the driver when the device reports absent and its logical
+address assignment is invalidated by the controller.
+
+Another notification "boot_device" is used to notify the slim_driver when
+controller resets the bus. This notification allows the driver to take necessary
+steps to boot the device so that it's functional after the bus has been reset.
+
+Clock-pause:
+------------
+SLIMbus mandates that a reconfiguration sequence (known as clock-pause) be
+broadcast to all active devices on the bus before the bus can enter low-power
+mode. Controller uses this sequence when it decides to enter low-power mode so
+that corresponding clocks and/or power-rails can be turned off to save power.
+Clock-pause is exited by waking up framer device (if controller driver initiates
+exiting low power mode), or by toggling the data line (if a slave device wants
+to initiate it).
+
+Messaging APIs:
+---------------
+The framework supports APIs to exchange control-information with a SLIMbus
+device. APIs can be synchronous or asynchronous.
+From controller's perspective, multiple buffers can be queued to/from
+hardware for sending/receiving data using slim_ctrl_buf circular buffer.
+The header file <linux/slimbus.h> has more documentation about messaging APIs.
+
+-----------------------------------------------------------------
+<Sections will be added to this document when port/channel bandwidth management
+support, multi-xfer APIs are added to the framework>
+------------------------------------------------------------------
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 505c676..8010c67 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -208,4 +208,6 @@ source "drivers/tee/Kconfig"
 
 source "drivers/mux/Kconfig"
 
+source "drivers/slimbus/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index d90fdc4..0449c7c 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -86,6 +86,7 @@ obj-$(CONFIG_MTD)		+= mtd/
 obj-$(CONFIG_SPI)		+= spi/
 obj-$(CONFIG_SPMI)		+= spmi/
 obj-$(CONFIG_HSI)		+= hsi/
+obj-$(CONFIG_SLIMBUS)		+= slimbus/
 obj-y				+= net/
 obj-$(CONFIG_ATM)		+= atm/
 obj-$(CONFIG_FUSION)		+= message/
diff --git a/drivers/slimbus/Kconfig b/drivers/slimbus/Kconfig
new file mode 100644
index 0000000..f0b118a
--- /dev/null
+++ b/drivers/slimbus/Kconfig
@@ -0,0 +1,11 @@
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
diff --git a/drivers/slimbus/Makefile b/drivers/slimbus/Makefile
new file mode 100644
index 0000000..f580704
--- /dev/null
+++ b/drivers/slimbus/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for kernel slimbus framework.
+#
+obj-$(CONFIG_SLIMBUS)			+= slimbus.o
+slimbus-y				:= slim-core.o
diff --git a/drivers/slimbus/slim-core.c b/drivers/slimbus/slim-core.c
new file mode 100644
index 0000000..de3ef79
--- /dev/null
+++ b/drivers/slimbus/slim-core.c
@@ -0,0 +1,695 @@
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
+#include <linux/completion.h>
+#include <linux/idr.h>
+#include <linux/pm_runtime.h>
+#include <linux/slimbus.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+static DEFINE_MUTEX(slim_lock);
+static DEFINE_IDR(ctrl_idr);
+
+static bool slim_eaddr_equal(struct slim_eaddr *a, struct slim_eaddr *b)
+{
+
+	return (a->manf_id == b->manf_id &&
+		a->prod_code == b->prod_code &&
+		a->dev_index == b->dev_index &&
+		a->instance == b->instance);
+}
+
+static const struct slim_device_id *slim_match(const struct slim_device_id *id,
+					       const struct slim_device *sbdev)
+{
+	while (id->manf_id != 0 || id->prod_code != 0) {
+		if (id->manf_id == sbdev->e_addr.manf_id &&
+		    id->prod_code == sbdev->e_addr.prod_code &&
+		    id->dev_index == sbdev->e_addr.dev_index)
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
+	/* Attempt an OF style match first */
+	if (of_driver_match_device(dev, drv))
+		return 1;
+
+	/* Then try to match against the id table */
+	if (sbdrv->id_table)
+		return slim_match(sbdrv->id_table, sbdev) != NULL;
+
+	return 0;
+}
+
+struct sb_report_wd {
+	struct work_struct wd;
+	struct slim_device *sbdev;
+	bool report;
+};
+
+static void slim_report(struct work_struct *work)
+{
+	struct slim_driver *sbdrv;
+	struct sb_report_wd *sbw = container_of(work, struct sb_report_wd, wd);
+	struct slim_device *sbdev = sbw->sbdev;
+
+	mutex_lock(&sbdev->report_lock);
+	if (!sbdev->dev.driver)
+		goto report_exit;
+
+	/* check if device-up or down needs to be called */
+	if ((!sbdev->reported && !sbdev->notified) ||
+	    (sbdev->reported && sbdev->notified))
+		goto report_exit;
+
+	sbdrv = to_slim_driver(sbdev->dev.driver);
+
+	/**
+	 * address no longer valid, means device reported absent, whereas
+	 * address valid, means device reported present
+	 */
+	if (sbdev->notified && !sbdev->reported) {
+		sbdev->notified = false;
+		if (sbdrv->device_down)
+			sbdrv->device_down(sbdev);
+	} else if (!sbdev->notified && sbdev->reported) {
+		sbdev->notified = true;
+		if (sbdrv->device_up)
+			sbdrv->device_up(sbdev);
+	}
+report_exit:
+	mutex_unlock(&sbdev->report_lock);
+	kfree(sbw);
+}
+
+/**
+ * Report callbacks(device_up, device_down) are implemented by slimbus-devices.
+ * The calls are scheduled into a workqueue to avoid holding up controller
+ * initialization/tear-down.
+ */
+static void schedule_slim_report(struct slim_controller *ctrl,
+				 struct slim_device *sb, bool report)
+{
+	struct sb_report_wd *sbw;
+
+	dev_dbg(&ctrl->dev, "report:%d for slave:%s\n", report, sb->name);
+
+	sbw = kmalloc(sizeof(*sbw), GFP_KERNEL);
+	if (!sbw)
+		return;
+
+	INIT_WORK(&sbw->wd, slim_report);
+	sbw->sbdev = sb;
+	sbw->report = report;
+	if (!queue_work(ctrl->wq, &sbw->wd)) {
+		dev_err(&ctrl->dev, "failed to queue report:%d slave:%s\n",
+				    report, sb->name);
+		kfree(sbw);
+	}
+}
+
+static int slim_device_probe(struct device *dev)
+{
+	struct slim_device	*sbdev;
+	struct slim_driver	*sbdrv;
+	int status = 0;
+
+	sbdev = to_slim_device(dev);
+	sbdrv = to_slim_driver(dev->driver);
+
+	sbdev->driver = sbdrv;
+
+	if (sbdrv->probe)
+		status = sbdrv->probe(sbdev);
+
+	if (status)
+		sbdev->driver = NULL;
+	else if (sbdrv->device_up)
+		schedule_slim_report(sbdev->ctrl, sbdev, true);
+
+	return status;
+}
+
+static int slim_device_remove(struct device *dev)
+{
+	struct slim_device *sbdev;
+	struct slim_driver *sbdrv;
+	int status = 0;
+
+	sbdev = to_slim_device(dev);
+	if (!dev->driver)
+		return 0;
+
+	sbdrv = to_slim_driver(dev->driver);
+	if (sbdrv->remove)
+		status = sbdrv->remove(sbdev);
+
+	mutex_lock(&sbdev->report_lock);
+	sbdev->notified = false;
+	if (status == 0)
+		sbdev->driver = NULL;
+	mutex_unlock(&sbdev->report_lock);
+	return status;
+}
+
+struct bus_type slimbus_type = {
+	.name		= "slimbus",
+	.match		= slim_device_match,
+	.probe		= slim_device_probe,
+	.remove		= slim_device_remove,
+};
+EXPORT_SYMBOL_GPL(slimbus_type);
+
+/**
+ * slim_driver_register: Client driver registration with slimbus
+ * @drv:Client driver to be associated with client-device.
+ * @owner: owning module/driver
+ * This API will register the client driver with the slimbus
+ * It is called from the driver's module-init function.
+ */
+int __slim_driver_register(struct slim_driver *drv, struct module *owner)
+{
+	drv->driver.bus = &slimbus_type;
+	drv->driver.owner = owner;
+	return driver_register(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(__slim_driver_register);
+
+/**
+ * slim_driver_unregister: Undo effect of slim_driver_register
+ * @drv: Client driver to be unregistered
+ */
+void slim_driver_unregister(struct slim_driver *drv)
+{
+	if (drv)
+		driver_unregister(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(slim_driver_unregister);
+
+static struct slim_controller *slim_ctrl_get(struct slim_controller *ctrl)
+{
+	if (!ctrl || !get_device(&ctrl->dev))
+		return NULL;
+
+	return ctrl;
+}
+
+static void slim_ctrl_put(struct slim_controller *ctrl)
+{
+	if (ctrl)
+		put_device(&ctrl->dev);
+}
+
+static void slim_dev_release(struct device *dev)
+{
+	struct slim_device *sbdev = to_slim_device(dev);
+
+	slim_ctrl_put(sbdev->ctrl);
+	kfree(sbdev->name);
+	kfree(sbdev);
+}
+
+static int slim_add_device(struct slim_controller *ctrl,
+			   struct slim_device *sbdev)
+{
+	sbdev->dev.bus = &slimbus_type;
+	sbdev->dev.parent = &ctrl->dev;
+	sbdev->dev.release = slim_dev_release;
+	sbdev->dev.driver = NULL;
+	sbdev->ctrl = ctrl;
+
+	slim_ctrl_get(ctrl);
+	sbdev->name = kasprintf(GFP_KERNEL, "%x:%x:%x:%x",
+					sbdev->e_addr.manf_id,
+					sbdev->e_addr.prod_code,
+					sbdev->e_addr.dev_index,
+					sbdev->e_addr.instance);
+	if (!sbdev->name)
+		return -ENOMEM;
+
+	dev_set_name(&sbdev->dev, "%s", sbdev->name);
+	mutex_init(&sbdev->report_lock);
+
+	/* probe slave on this controller */
+	return device_register(&sbdev->dev);
+}
+
+/* Helper to get hex Manufacturer ID and Product id from compatible */
+static unsigned long str2hex(unsigned char *str)
+{
+	int value = 0;
+
+	while (*str) {
+		char c = *str++;
+
+		value = value << 4;
+		if (c >= '0' && c <= '9')
+			value |= (c - '0');
+		if (c >= 'a' && c <= 'f')
+			value |= (c - 'a' + 10);
+
+	}
+
+	return value;
+}
+
+/* OF helpers for SLIMbus */
+static void of_register_slim_devices(struct slim_controller *ctrl)
+{
+	struct device *dev = &ctrl->dev;
+	struct device_node *node;
+
+	if (!ctrl->dev.of_node)
+		return;
+
+	for_each_child_of_node(ctrl->dev.of_node, node) {
+		struct slim_device *slim;
+		const char *compat = NULL;
+		char *p, *tok;
+		int reg[2], ret;
+
+		slim = kzalloc(sizeof(*slim), GFP_KERNEL);
+		if (!slim)
+			continue;
+
+		slim->dev.of_node = of_node_get(node);
+
+		compat = of_get_property(node, "compatible", NULL);
+		if (!compat)
+			continue;
+
+		p = kasprintf(GFP_KERNEL, "%s", compat + strlen("slim"));
+
+		tok = strsep(&p, ",");
+		if (!tok) {
+			dev_err(dev, "No valid Manufacturer ID found\n");
+			kfree(p);
+			continue;
+		}
+		slim->e_addr.manf_id = str2hex(tok);
+
+		tok = strsep(&p, ",");
+		if (!tok) {
+			dev_err(dev, "No valid Product ID found\n");
+			kfree(p);
+			continue;
+		}
+		slim->e_addr.prod_code = str2hex(tok);
+		kfree(p);
+
+		ret = of_property_read_u32_array(node, "reg", reg, 2);
+		if (ret) {
+			dev_err(dev, "Device and Instance id not found:%d\n",
+				ret);
+			continue;
+		}
+		slim->e_addr.dev_index = reg[0];
+		slim->e_addr.instance = reg[1];
+
+		ret = slim_add_device(ctrl, slim);
+		if (ret)
+			dev_err(dev, "of_slim device register err:%d\n", ret);
+	}
+}
+
+/**
+ * slim_register_controller: Controller bring-up and registration.
+ * @ctrl: Controller to be registered.
+ * A controller is registered with the framework using this API.
+ * If devices on a controller were registered before controller,
+ * this will make sure that they get probed when controller is up
+ */
+int slim_register_controller(struct slim_controller *ctrl)
+{
+	int id, ret = 0;
+
+	mutex_lock(&slim_lock);
+	id = idr_alloc(&ctrl_idr, ctrl, ctrl->nr, -1, GFP_KERNEL);
+	mutex_unlock(&slim_lock);
+
+	if (id < 0)
+		return id;
+
+	ctrl->nr = id;
+
+	dev_set_name(&ctrl->dev, "sb-%d", ctrl->nr);
+	ctrl->num_dev = 0;
+
+	if (!ctrl->min_cg)
+		ctrl->min_cg = SLIM_MIN_CLK_GEAR;
+	if (!ctrl->max_cg)
+		ctrl->max_cg = SLIM_MAX_CLK_GEAR;
+
+	mutex_init(&ctrl->m_ctrl);
+	ret = device_register(&ctrl->dev);
+	if (ret)
+		goto dev_reg_failed;
+
+	dev_dbg(&ctrl->dev, "Bus [%s] registered:dev:%p\n",
+		ctrl->name, &ctrl->dev);
+
+	ctrl->wq = create_singlethread_workqueue(dev_name(&ctrl->dev));
+	if (!ctrl->wq)
+		goto err_workq_failed;
+
+	of_register_slim_devices(ctrl);
+
+	return 0;
+
+err_workq_failed:
+	device_unregister(&ctrl->dev);
+dev_reg_failed:
+	mutex_lock(&slim_lock);
+	idr_remove(&ctrl_idr, ctrl->nr);
+	mutex_unlock(&slim_lock);
+	return ret;
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
+ * slim_del_controller: Controller tear-down.
+ * @ctrl: Controller to tear-down.
+ */
+int slim_del_controller(struct slim_controller *ctrl)
+{
+	struct slim_controller *found;
+
+	/* First make sure that this bus was added */
+	mutex_lock(&slim_lock);
+	found = idr_find(&ctrl_idr, ctrl->nr);
+	mutex_unlock(&slim_lock);
+	if (found != ctrl)
+		return -EINVAL;
+
+	/* Remove all clients */
+	device_for_each_child(&ctrl->dev, NULL, slim_ctrl_remove_device);
+
+
+	destroy_workqueue(ctrl->wq);
+
+	/* free bus id */
+	mutex_lock(&slim_lock);
+	idr_remove(&ctrl_idr, ctrl->nr);
+	mutex_unlock(&slim_lock);
+
+	device_unregister(&ctrl->dev);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(slim_del_controller);
+
+/**
+ * slim_report_absent: Controller calls this function when a device
+ *	reports absent, OR when the device cannot be communicated with
+ * @sbdev: Device that cannot be reached, or sent report absent
+ */
+void slim_report_absent(struct slim_device *sbdev)
+{
+	struct slim_controller *ctrl;
+	int i;
+
+	if (!sbdev)
+		return;
+	ctrl = sbdev->ctrl;
+	if (!ctrl)
+		return;
+
+	/* invalidate logical addresses */
+	mutex_lock(&ctrl->m_ctrl);
+	for (i = 0; i < ctrl->num_dev; i++) {
+		if (sbdev->laddr == ctrl->addrt[i].laddr)
+			ctrl->addrt[i].valid = false;
+	}
+	mutex_unlock(&ctrl->m_ctrl);
+
+	mutex_lock(&sbdev->report_lock);
+	sbdev->reported = false;
+	schedule_slim_report(ctrl, sbdev, false);
+	mutex_unlock(&sbdev->report_lock);
+}
+EXPORT_SYMBOL_GPL(slim_report_absent);
+
+static int slim_boot_child(struct device *dev, void *unused)
+{
+	struct slim_driver *sbdrv;
+	struct slim_device *sbdev = to_slim_device(dev);
+
+	if (sbdev && sbdev->dev.driver) {
+		sbdrv = to_slim_driver(sbdev->dev.driver);
+		if (sbdrv->boot_device)
+			sbdrv->boot_device(sbdev);
+	}
+	return 0;
+}
+
+static int slim_match_dev(struct device *dev, void *data)
+{
+	struct slim_eaddr *e_addr = data;
+	struct slim_device *slim = to_slim_device(dev);
+
+	return slim_eaddr_equal(&slim->e_addr, e_addr);
+}
+
+/**
+ * slim_framer_booted: This function is called by controller after the active
+ * framer has booted (using Bus Reset sequence, or after it has shutdown and has
+ * come back up).
+ * @ctrl: Controller associated with this framer
+ * Components, devices on the bus may be in undefined state,
+ * and this function triggers their drivers to do the needful
+ * to bring them back in Reset state so that they can acquire sync, report
+ * present and be operational again.
+ */
+void slim_framer_booted(struct slim_controller *ctrl)
+{
+	if (!ctrl)
+		return;
+
+	device_for_each_child(&ctrl->dev, NULL, slim_boot_child);
+}
+EXPORT_SYMBOL_GPL(slim_framer_booted);
+
+/**
+ * slim_query_device: Query and get handle to a device.
+ * @ctrl: Controller on which this device will be added/queried
+ * @e_addr: Enumeration address of the device to be queried
+ * Returns pointer to a device if it has already reported. Creates a new
+ * device and returns pointer to it if the device has not yet enumerated.
+ */
+struct slim_device *slim_query_device(struct slim_controller *ctrl,
+				      struct slim_eaddr *e_addr)
+{
+	struct device *dev;
+	struct slim_device *slim = NULL;
+
+	dev = device_find_child(&ctrl->dev, e_addr, slim_match_dev);
+	if (dev) {
+		slim = to_slim_device(dev);
+		return slim;
+	}
+
+	slim = kzalloc(sizeof(struct slim_device), GFP_KERNEL);
+	if (IS_ERR(slim))
+		return NULL;
+
+	slim->e_addr = *e_addr;
+	if (slim_add_device(ctrl, slim) != 0) {
+		kfree(slim);
+		return NULL;
+	}
+	return slim;
+}
+EXPORT_SYMBOL_GPL(slim_query_device);
+
+static int ctrl_getaddr_entry(struct slim_controller *ctrl,
+			      struct slim_eaddr *eaddr, u8 *entry)
+{
+	int i;
+
+	for (i = 0; i < ctrl->num_dev; i++) {
+		if (ctrl->addrt[i].valid &&
+		    slim_eaddr_equal(&ctrl->addrt[i].eaddr, eaddr)) {
+			*entry = i;
+			return 0;
+		}
+	}
+	return -ENXIO;
+}
+
+/**
+ * slim_assign_laddr: Assign logical address to a device enumerated.
+ * @ctrl: Controller with which device is enumerated.
+ * @e_addr: Enumeration address of the device.
+ * @laddr: Return logical address (if valid flag is false)
+ * @valid: true if laddr holds a valid address that controller wants to
+ *	set for this enumeration address. Otherwise framework sets index into
+ *	address table as logical address.
+ * Called by controller in response to REPORT_PRESENT. Framework will assign
+ * a logical address to this enumeration address.
+ * Function returns -EXFULL to indicate that all logical addresses are already
+ * taken.
+ */
+int slim_assign_laddr(struct slim_controller *ctrl, struct slim_eaddr *e_addr,
+		      u8 *laddr, bool valid)
+{
+	int ret;
+	u8 i = 0;
+	bool exists = false;
+	struct slim_device *slim;
+	struct slim_addrt *temp;
+
+	mutex_lock(&ctrl->m_ctrl);
+	/* already assigned */
+	if (ctrl_getaddr_entry(ctrl, e_addr, &i) == 0) {
+		*laddr = ctrl->addrt[i].laddr;
+		exists = true;
+	} else {
+		if (ctrl->num_dev >= (SLIM_LA_MANAGER - 1)) {
+			ret = -EXFULL;
+			goto ret_assigned_laddr;
+		}
+		for (i = 0; i < ctrl->num_dev; i++) {
+			if (ctrl->addrt[i].valid == false)
+				break;
+		}
+		if (i == ctrl->num_dev) {
+			temp = krealloc(ctrl->addrt,
+					(ctrl->num_dev + 1) *
+					sizeof(struct slim_addrt),
+					GFP_KERNEL);
+			if (!temp) {
+				ret = -ENOMEM;
+				goto ret_assigned_laddr;
+			}
+			ctrl->addrt = temp;
+			ctrl->num_dev++;
+		}
+		ctrl->addrt[i].eaddr = *e_addr;
+		ctrl->addrt[i].valid = true;
+
+		/* Preferred address is index into table */
+		if (!valid)
+			*laddr = i;
+	}
+
+	ret = ctrl->set_laddr(ctrl, &ctrl->addrt[i].eaddr, *laddr);
+	if (ret) {
+		ctrl->addrt[i].valid = false;
+		goto ret_assigned_laddr;
+	}
+	ctrl->addrt[i].laddr = *laddr;
+
+ret_assigned_laddr:
+	mutex_unlock(&ctrl->m_ctrl);
+	if (exists || ret)
+		return ret;
+
+	dev_info(&ctrl->dev, "setting slimbus l-addr:%x, ea:%x,%x,%x,%x\n",
+		*laddr, e_addr->manf_id, e_addr->prod_code,
+		e_addr->dev_index, e_addr->instance);
+
+	/**
+	 * Add this device to list of devices on this controller if it's
+	 * not already present
+	 */
+	slim = slim_query_device(ctrl, e_addr);
+	if (!slim) {
+		ret = -ENODEV;
+	} else {
+		struct slim_driver *sbdrv;
+
+		slim->laddr = *laddr;
+		mutex_lock(&slim->report_lock);
+		slim->reported = true;
+		if (slim->dev.driver) {
+			sbdrv = to_slim_driver(slim->dev.driver);
+			if (sbdrv->device_up)
+				schedule_slim_report(ctrl, slim, true);
+		}
+		mutex_unlock(&slim->report_lock);
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(slim_assign_laddr);
+
+/**
+ * slim_get_logical_addr: Return the logical address of a slimbus device.
+ * @sb: client handle requesting the address.
+ * @e_addr: Enumeration address of the device.
+ * @laddr: output buffer to store the address
+ * context: can sleep
+ * -EINVAL is returned in case of invalid parameters, and -ENXIO is returned if
+ *  the device with this enumeration address is not found.
+ */
+int slim_get_logical_addr(struct slim_device *sb, struct slim_eaddr *e_addr,
+			  u8 *laddr)
+{
+	int ret;
+	u8 entry;
+	struct slim_controller *ctrl = sb->ctrl;
+
+	if (!ctrl || !laddr || !e_addr)
+		return -EINVAL;
+
+	mutex_lock(&ctrl->m_ctrl);
+	ret = ctrl_getaddr_entry(ctrl, e_addr, &entry);
+	if (!ret)
+		*laddr = ctrl->addrt[entry].laddr;
+	mutex_unlock(&ctrl->m_ctrl);
+
+	if (ret == -ENXIO && ctrl->get_laddr) {
+		ret = ctrl->get_laddr(ctrl, e_addr, laddr);
+		if (!ret)
+			ret = slim_assign_laddr(ctrl, e_addr, laddr, true);
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(slim_get_logical_addr);
+
+static void __exit slimbus_exit(void)
+{
+	bus_unregister(&slimbus_type);
+}
+module_exit(slimbus_exit);
+
+static int __init slimbus_init(void)
+{
+	return bus_register(&slimbus_type);
+}
+postcore_initcall(slimbus_init);
+
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION("0.1");
+MODULE_DESCRIPTION("Slimbus module");
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 694cebb..015e5f6 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -448,6 +448,19 @@ struct spi_device_id {
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
index 0000000..b5064b6
--- /dev/null
+++ b/include/linux/slimbus.h
@@ -0,0 +1,299 @@
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
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/mod_devicetable.h>
+
+/**
+ * Interfaces between SLIMbus manager drivers, SLIMbus client drivers, and
+ * SLIMbus infrastructure.
+ */
+
+extern struct bus_type slimbus_type;
+
+/* Standard values per SLIMbus spec needed by controllers and devices */
+#define SLIM_CL_PER_SUPERFRAME		6144
+#define SLIM_CL_PER_SUPERFRAME_DIV8	(SLIM_CL_PER_SUPERFRAME >> 3)
+#define SLIM_MAX_CLK_GEAR		10
+#define SLIM_MIN_CLK_GEAR		1
+#define SLIM_CL_PER_SL			4
+#define SLIM_SL_PER_SUPERFRAME		(SLIM_CL_PER_SUPERFRAME >> 2)
+#define SLIM_FRM_SLOTS_PER_SUPERFRAME	16
+#define SLIM_GDE_SLOTS_PER_SUPERFRAME	2
+
+struct slim_controller;
+struct slim_device;
+
+/**
+ * struct slim_eaddr: Enumeration address for a slimbus device
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
+ * struct slim_framer - Represents Slimbus framer.
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
+ * struct slim_addrt: slimbus address used internally by the slimbus framework.
+ * @valid: If the device is present. Valid is set to false when device reports
+ *	absent.
+ * @eaddr: Enumeration address
+ * @laddr: It is possible that controller will set a predefined logical address
+ *	rather than the one assigned by framework. (i.e. logical address may
+ *	not be same as index into this table). This entry will store the
+ *	logical address value for this enumeration address.
+ */
+struct slim_addrt {
+	bool			valid;
+	struct slim_eaddr	eaddr;
+	u8			laddr;
+};
+
+/* SLIMbus message types. Related to interpretation of message code. */
+#define SLIM_MSG_MT_CORE			0x0
+#define SLIM_MSG_MT_DEST_REFERRED_CLASS		0x1
+#define SLIM_MSG_MT_DEST_REFERRED_USER		0x2
+#define SLIM_MSG_MT_SRC_REFERRED_CLASS		0x5
+#define SLIM_MSG_MT_SRC_REFERRED_USER		0x6
+
+/* SLIMbus core type Message Codes. */
+/* Device management messages used by this framework */
+#define SLIM_MSG_MC_REPORT_PRESENT               0x1
+#define SLIM_MSG_MC_ASSIGN_LOGICAL_ADDRESS       0x2
+#define SLIM_MSG_MC_REPORT_ABSENT                0xF
+
+/* Destination type Values */
+#define SLIM_MSG_DEST_LOGICALADDR	0
+#define SLIM_MSG_DEST_ENUMADDR		1
+#define	SLIM_MSG_DEST_BROADCAST		3
+
+/**
+ * struct slim_controller: Controls every instance of SLIMbus
+ *				(similar to 'master' on SPI)
+ *	'Manager device' is responsible for  device management, bandwidth
+ *	allocation, channel setup, and port associations per channel.
+ *	Device management means Logical address assignment/removal based on
+ *	enumeration (report-present, report-absent) if a device.
+ *	Bandwidth allocation is done dynamically by the manager based on active
+ *	channels on the bus, message-bandwidth requests made by slimbus devices.
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
+ * @dev: Device interface to this driver
+ * @nr: Board-specific number identifier for this controller/bus
+ * @list: Link with other slimbus controllers
+ * @name: Name for this controller
+ * @min_cg: Minimum clock gear supported by this controller (default value: 1)
+ * @max_cg: Maximum clock gear supported by this controller (default value: 10)
+ * @clkgear: Current clock gear in which this bus is running
+ * @a_framer: Active framer which is clocking the bus managed by this controller
+ * @m_ctrl: Mutex protecting controller data structures
+ * @addrt: Logical address table
+ * @num_dev: Number of active slimbus slaves on this bus
+ * @wq: Workqueue per controller used to notify devices when they report present
+ * @xfer_msg: Transfer a message on this controller (this can be a broadcast
+ *	control/status message like data channel setup, or a unicast message
+ *	like value element read/write.
+ * @set_laddr: Setup logical address at laddr for the slave with elemental
+ *	address e_addr. Drivers implementing controller will be expected to
+ *	send unicast message to this device with its logical address.
+ * @get_laddr: It is possible that controller needs to set fixed logical
+ *	address table and get_laddr can be used in that case so that controller
+ *	can do this assignment.
+ */
+struct slim_controller {
+	struct device		dev;
+	unsigned int		nr;
+	char			name[SLIMBUS_NAME_SIZE];
+	int			min_cg;
+	int			max_cg;
+	int			clkgear;
+	struct slim_framer	*a_framer;
+	struct mutex		m_ctrl;
+	struct slim_addrt	*addrt;
+	u8			num_dev;
+	struct workqueue_struct *wq;
+	int			(*set_laddr)(struct slim_controller *ctrl,
+					     struct slim_eaddr *ea, u8 laddr);
+	int			(*get_laddr)(struct slim_controller *ctrl,
+					     struct slim_eaddr *ea, u8 *laddr);
+};
+
+#define to_slim_controller(d) container_of(d, struct slim_controller, dev)
+
+/**
+ * struct slim_driver: Slimbus 'generic device' (slave) device driver
+ *				(similar to 'spi_device' on SPI)
+ * @probe: Binds this driver to a slimbus device.
+ * @remove: Unbinds this driver from the slimbus device.
+ * @shutdown: Standard shutdown callback used during powerdown/halt.
+ * @suspend: Standard suspend callback used during system suspend
+ * @resume: Standard resume callback used during system resume
+ * @device_up: This callback is called when the device reports present and
+ *		gets a logical address assigned to it
+ * @device_down: This callback is called when device reports absent, or the
+ *		bus goes down. Device will report present when bus is up and
+ *		device_up callback will be called again when that happens
+ * @boot_device: This callback is called after framer is booted.
+ *		Driver should do the needful to boot the device,
+ *		so that device acquires sync and be operational.
+ * @driver: Slimbus device drivers should initialize name and owner field of
+ *	this structure
+ * @id_table: List of slimbus devices supported by this driver
+ */
+struct slim_driver {
+	int				(*probe)(struct slim_device *sl);
+	int				(*remove)(struct slim_device *sl);
+	void				(*shutdown)(struct slim_device *sl);
+	int				(*suspend)(struct slim_device *sl,
+						   pm_message_t pmesg);
+	int				(*resume)(struct slim_device *sl);
+	int				(*device_up)(struct slim_device *sl);
+	int				(*device_down)(struct slim_device *sl);
+	int				(*boot_device)(struct slim_device *sl);
+
+	struct device_driver		driver;
+	const struct slim_device_id	*id_table;
+};
+
+#define to_slim_driver(d) container_of(d, struct slim_driver, driver)
+
+/**
+ * Client/device handle (struct slim_device):
+ * ------------------------------------------
+ *  This is the client/device handle returned when a slimbus
+ *  device is registered with a controller.
+ *  Pointer to this structure is used by client-driver as a handle.
+ *  @dev: Driver model representation of the device.
+ *  @name: Name of driver to use with this device.
+ *  @e_addr: Enumeration address of this device.
+ *  @driver: Device's driver. Pointer to access routines.
+ *  @ctrl: Slimbus controller managing the bus hosting this device.
+ *  @laddr: 1-byte Logical address of this device.
+ *  @reported: Flag to indicate whether this device reported present. The flag
+ *	is set when device reports present, and is reset when it reports
+ *	absent. This flag alongwith notified flag below is used to call
+ *	device_up, or device_down callbacks for driver of this device.
+ *  @notified: Flag to indicate whether this device has been notified. The
+ *	device may report present multiple times, but should be notified only
+ *	first time it has reported present.
+ *  @report_lock: Lock to protect reporting and notification for this device
+ */
+struct slim_device {
+	struct device		dev;
+	char		*name;
+	struct slim_eaddr	e_addr;
+	struct slim_driver	*driver;
+	struct slim_controller	*ctrl;
+	u8			laddr;
+	bool			reported;
+	bool			notified;
+	struct mutex		report_lock;
+};
+
+#define to_slim_device(d) container_of(d, struct slim_device, dev)
+
+/* Manager's logical address is set to 0xFF per spec */
+#define SLIM_LA_MANAGER 0xFF
+
+int slim_get_logical_addr(struct slim_device *sb,
+				 struct slim_eaddr *e_addr, u8 *laddr);
+
+/*
+ * use a macro to avoid include chaining to get THIS_MODULE
+ */
+#define slim_driver_register(drv) \
+	__slim_driver_register(drv, THIS_MODULE)
+
+int __slim_driver_register(struct slim_driver *drv, struct module *owner);
+
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
+int slim_del_controller(struct slim_controller *ctrl);
+int slim_assign_laddr(struct slim_controller *ctrl,
+		      struct slim_eaddr *e_addr, u8 *laddr, bool valid);
+void slim_report_absent(struct slim_device *sbdev);
+void slim_framer_booted(struct slim_controller *ctrl);
+int slim_register_controller(struct slim_controller *ctrl);
+
+static inline void *slim_get_ctrldata(const struct slim_controller *dev)
+{
+	return dev_get_drvdata(&dev->dev);
+}
+
+static inline void slim_set_ctrldata(struct slim_controller *dev, void *data)
+{
+	dev_set_drvdata(&dev->dev, data);
+}
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
+
+#endif /* _LINUX_SLIMBUS_H */
-- 
2.9.3
