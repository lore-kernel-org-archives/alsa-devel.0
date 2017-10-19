From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 10/14] soundwire: Add sysfs for SoundWire DisCo properties
Date: Thu, 19 Oct 2017 08:33:26 +0530
Message-ID: <1508382211-3154-11-git-send-email-vinod.koul@intel.com>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

It helps to read the properties for understanding and debug
SoundWire systems, so add sysfs files for SoundWire DisCo
properties.

TODO: Add ABI files for sysfs

Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/soundwire/Makefile    |   2 +-
 drivers/soundwire/bus.c       |   5 +
 drivers/soundwire/bus.h       |   2 +
 drivers/soundwire/slave.c     |   1 +
 drivers/soundwire/sysfs.c     | 396 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/soundwire/sdw.h |  15 ++
 6 files changed, 420 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soundwire/sysfs.c

diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index bcde0d26524c..67dc7b546258 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -3,5 +3,5 @@
 #
 
 #Bus Objs
-soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o
+soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o sysfs.o
 obj-$(CONFIG_SOUNDWIRE_BUS) += soundwire-bus.o
diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 6c4f41b64744..e3d7aea18892 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -90,6 +90,8 @@ int sdw_add_bus_master(struct sdw_bus *bus)
 		}
 	}
 
+	sdw_sysfs_bus_init(bus);
+
 	/*
 	 * SDW is an enumerable bus, but devices can be powered off. So,
 	 * they won't be able to report as present.
@@ -119,6 +121,8 @@ static int sdw_delete_slave(struct device *dev, void *data)
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
 	struct sdw_bus *bus = slave->bus;
 
+	sdw_sysfs_slave_exit(slave);
+
 	mutex_lock(&bus->bus_lock);
 	if (!list_empty(&bus->slaves))
 		list_del(&slave->node);
@@ -130,6 +134,7 @@ static int sdw_delete_slave(struct device *dev, void *data)
 
 void sdw_delete_bus_master(struct sdw_bus *bus)
 {
+	sdw_sysfs_bus_init(bus);
 	device_for_each_child(bus->dev, NULL, sdw_delete_slave);
 }
 EXPORT_SYMBOL(sdw_delete_bus_master);
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 2e9f84209879..2c1f64415a5b 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -79,6 +79,8 @@ int sdw_slave_modalias(struct sdw_slave *slave, char *buf, size_t size);
 void sdw_extract_slave_id(struct sdw_bus *bus,
 			unsigned long long addr, struct sdw_slave_id *id);
 
+extern const struct attribute_group *sdw_slave_dev_attr_groups[];
+
 enum {
 	SDW_MSG_FLAG_READ = 0,
 	SDW_MSG_FLAG_WRITE,
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index ee8e0e848f64..1b4e7f1b66e1 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -85,6 +85,7 @@ static int sdw_slave_add(struct sdw_bus *bus,
 	slave->dev.fwnode = fwnode;
 	dev_set_name(&slave->dev, "%s", name);
 	slave->dev.release = sdw_slave_release;
+	slave->dev.groups = sdw_slave_dev_attr_groups;
 	slave->dev.bus = &sdw_bus_type;
 	slave->bus = bus;
 	slave->status = SDW_SLAVE_UNATTACHED;
diff --git a/drivers/soundwire/sysfs.c b/drivers/soundwire/sysfs.c
new file mode 100644
index 000000000000..29e2f1db08ec
--- /dev/null
+++ b/drivers/soundwire/sysfs.c
@@ -0,0 +1,396 @@
+/*
+ *  This file is provided under a dual BSD/GPLv2 license.  When using or
+ *  redistributing this file, you may do so under either license.
+ *
+ *  GPL LICENSE SUMMARY
+ *
+ *  Copyright(c) 2015-17 Intel Corporation.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of version 2 of the GNU General Public License as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  BSD LICENSE
+ *
+ *  Copyright(c) 2015-17 Intel Corporation.
+ *
+ *  Redistribution and use in source and binary forms, with or without
+ *  modification, are permitted provided that the following conditions
+ *  are met:
+ *
+ *    * Redistributions of source code must retain the above copyright
+ *      notice, this list of conditions and the following disclaimer.
+ *    * Redistributions in binary form must reproduce the above copyright
+ *      notice, this list of conditions and the following disclaimer in
+ *      the documentation and/or other materials provided with the
+ *      distribution.
+ *    * Neither the name of Intel Corporation nor the names of its
+ *      contributors may be used to endorse or promote products derived
+ *      from this software without specific prior written permission.
+ *
+ *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
+
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/soundwire/sdw.h>
+#include "bus.h"
+
+/*
+ * The sysfs for properties reflects the MIPI description as given
+ * in the MIPI DisCo spec
+ *
+ * Base file is:
+ *		properties
+ *		|---- interface-revision
+ *		|---- master-count
+ *		|---- link-N
+ *		      |---- clock-stop-modes
+ *		      |---- max-clock-frequency
+ *		      |---- clock-frequencies
+ *		      |---- default-frame-rows
+ *		      |---- default-frame-cols
+ *		      |---- dynamic-frame-shape
+ *		      |---- command-error-threshold
+ */
+
+struct sdw_master_sysfs {
+	struct kobject kobj;
+	struct sdw_bus *bus;
+};
+
+struct sdw_prop_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct sdw_bus *bus,
+			struct sdw_prop_attribute *attr, char *buf);
+};
+
+static ssize_t sdw_prop_attr_show(struct kobject *kobj,
+		struct attribute *attr, char *buf)
+{
+	struct sdw_prop_attribute *prop_attr =
+		container_of(attr, struct sdw_prop_attribute, attr);
+	struct sdw_master_sysfs *master =
+		container_of(kobj, struct sdw_master_sysfs, kobj);
+
+	if (!prop_attr->show)
+		return -EIO;
+
+	return prop_attr->show(master->bus, prop_attr, buf);
+}
+
+static const struct sysfs_ops sdw_prop_sysfs_ops = {
+	.show	= sdw_prop_attr_show,
+};
+
+static void prop_release(struct kobject *kobj)
+{
+	struct sdw_master_sysfs *master =
+		container_of(kobj, struct sdw_master_sysfs, kobj);
+
+	kfree(master);
+}
+
+static struct kobj_type sdw_master_prop_ktype = {
+	.release	= prop_release,
+	.sysfs_ops	= &sdw_prop_sysfs_ops,
+};
+
+
+#define MASTER_ATTR(_name) \
+	struct sdw_prop_attribute master_attr_##_name = __ATTR_RO(_name)
+
+static ssize_t revision_show(struct sdw_bus *bus,
+			struct sdw_prop_attribute *attr, char *buf)
+{
+	return sprintf(buf, "0x%08x\n", bus->prop.revision);
+}
+
+static ssize_t count_show(struct sdw_bus *bus,
+			struct sdw_prop_attribute *attr, char *buf)
+{
+	return sprintf(buf, "0x%08x\n", bus->prop.master_count);
+}
+
+static ssize_t clock_stop_modes_show(struct sdw_bus *bus,
+			struct sdw_prop_attribute *attr, char *buf)
+{
+	return sprintf(buf, "0x%08x\n", bus->prop.clk_stop_mode);
+}
+
+static ssize_t max_clock_frequency_show(struct sdw_bus *bus,
+			struct sdw_prop_attribute *attr, char *buf)
+{
+	return sprintf(buf, "0x%08x\n", bus->prop.max_freq);
+}
+
+static ssize_t clock_frequencies_show(struct sdw_bus *bus,
+			struct sdw_prop_attribute *attr, char *buf)
+{
+	ssize_t size = 0;
+	int i;
+
+	for (i = 0; i < bus->prop.num_freq; i++)
+		size += sprintf(buf + size, "%8d\n", bus->prop.freq[i]);
+
+	return size;
+}
+
+static ssize_t clock_gears_show(struct sdw_bus *bus,
+			struct sdw_prop_attribute *attr, char *buf)
+{
+	ssize_t size = 0;
+	int i;
+
+	for (i = 0; i < bus->prop.num_clk_gears; i++)
+		size += sprintf(buf + size, "%8d\n", bus->prop.clk_gears[i]);
+
+	return size;
+}
+
+static ssize_t default_frame_rows_show(struct sdw_bus *bus,
+			struct sdw_prop_attribute *attr, char *buf)
+{
+	return sprintf(buf, "0x%08x\n", bus->prop.default_row);
+}
+
+static ssize_t default_frame_cols_show(struct sdw_bus *bus,
+			struct sdw_prop_attribute *attr, char *buf)
+{
+	return sprintf(buf, "0x%08x\n", bus->prop.default_col);
+}
+
+static ssize_t dynamic_frame_shape_show(struct sdw_bus *bus,
+			struct sdw_prop_attribute *attr, char *buf)
+{
+	return sprintf(buf, "0x%08x\n", bus->prop.dynamic_frame);
+}
+
+static ssize_t command_error_threshold_show(struct sdw_bus *bus,
+			struct sdw_prop_attribute *attr, char *buf)
+{
+	return sprintf(buf, "0x%08x\n", bus->prop.err_threshold);
+}
+
+static MASTER_ATTR(revision);
+static MASTER_ATTR(count);
+static MASTER_ATTR(clock_stop_modes);
+static MASTER_ATTR(max_clock_frequency);
+static MASTER_ATTR(clock_frequencies);
+static MASTER_ATTR(clock_gears);
+static MASTER_ATTR(default_frame_rows);
+static MASTER_ATTR(default_frame_cols);
+static MASTER_ATTR(dynamic_frame_shape);
+static MASTER_ATTR(command_error_threshold);
+
+static struct attribute *master_node_attrs[] = {
+	&master_attr_revision.attr,
+	&master_attr_count.attr,
+	&master_attr_clock_stop_modes.attr,
+	&master_attr_max_clock_frequency.attr,
+	&master_attr_clock_frequencies.attr,
+	&master_attr_clock_gears.attr,
+	&master_attr_default_frame_rows.attr,
+	&master_attr_default_frame_cols.attr,
+	&master_attr_dynamic_frame_shape.attr,
+	&master_attr_command_error_threshold.attr,
+	NULL,
+};
+
+static const struct attribute_group sdw_master_node_group = {
+	.attrs = master_node_attrs,
+};
+
+int sdw_sysfs_bus_init(struct sdw_bus *bus)
+{
+	struct kset *sdw_bus_kset;
+	struct sdw_master_sysfs *master;
+	int err;
+
+	if (bus->sysfs) {
+		dev_err(bus->dev, "SDW sysfs is already initialized\n");
+		return -EIO;
+	}
+
+	sdw_bus_kset = bus_get_kset(&sdw_bus_type);
+
+	master = bus->sysfs = kzalloc(sizeof(*master), GFP_KERNEL);
+	if (!master)
+		return -ENOMEM;
+
+	err = kobject_init_and_add(&master->kobj,
+			&sdw_master_prop_ktype, &sdw_bus_kset->kobj,
+			"mipi-properties-link%d", bus->link_id);
+	if (err < 0)
+		return err;
+
+	master->bus = bus;
+
+	err = sysfs_create_group(&master->kobj, &sdw_master_node_group);
+	if (err < 0) {
+		kobject_put(&master->kobj);
+		return err;
+	}
+
+	kobject_uevent(&master->kobj, KOBJ_CHANGE);
+	return 0;
+}
+
+void sdw_sysfs_bus_exit(struct sdw_bus *bus)
+{
+	struct sdw_master_sysfs *master = bus->sysfs;
+
+	if (!master)
+		return;
+
+	kobject_put(&master->kobj);
+	bus->sysfs = NULL;
+}
+
+/*
+ * Slave sysfs
+ */
+
+/*
+ * The sysfs for Slave reflects the MIPI description as given
+ * in the MIPI DisCo spec
+ *
+ * Base file is device
+ *	|---- mipi_revision
+ *	|---- wake_capable
+ *	|---- test_mode_capable
+ *	|---- simple_clk_stop_capable
+ *	|---- clk_stop_timeout
+ *	|---- ch_prep_timeout
+ *	|---- reset_behave
+ *	|---- high_PHY_capable
+ *	|---- paging_support
+ *	|---- bank_delay_support
+ *	|---- p15_behave
+ *	|---- master_count
+ *	|---- source_ports
+ *	|---- sink_ports
+ *	|---- dp0
+ *		|---- max_word
+ *		|---- min_word
+ *		|---- words
+ *		|---- flow_controlled
+ *		|---- simple_ch_prep_sm
+ *		|---- device_interrupts
+ *	|---- dpN
+ *		|---- max_word
+ *		|---- min_word
+ *		|---- words
+ *		|---- type
+ *		|---- max_grouping
+ *		|---- simple_ch_prep_sm
+ *		|---- ch_prep_timeout
+ *		|---- device_interrupts
+ *		|---- max_ch
+ *		|---- min_ch
+ *		|---- ch
+ *		|---- ch_combinations
+ *		|---- modes
+ *		|---- max_async_buffer
+ *		|---- block_pack_mode
+ *		|---- port_encoding
+ *		|---- bus_min_freq
+ *		|---- bus_max_freq
+ *		|---- bus_freq
+ *		|---- max_freq
+ *		|---- min_freq
+ *		|---- freq
+ *		|---- prep_ch_behave
+ *		|---- glitchless
+ *
+ */
+struct sdw_slave_sysfs {
+	struct sdw_slave *slave;
+};
+
+#define SLAVE_ATTR(type)					\
+static ssize_t type##_show(struct device *dev,			\
+		struct device_attribute *attr, char *buf)	\
+{								\
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);		\
+	return sprintf(buf, "0x%x\n", slave->prop.type);	\
+}								\
+static DEVICE_ATTR_RO(type)
+
+SLAVE_ATTR(mipi_revision);
+SLAVE_ATTR(wake_capable);
+SLAVE_ATTR(test_mode_capable);
+SLAVE_ATTR(clk_stop_mode1);
+SLAVE_ATTR(simple_clk_stop_capable);
+SLAVE_ATTR(clk_stop_timeout);
+SLAVE_ATTR(ch_prep_timeout);
+SLAVE_ATTR(reset_behave);
+SLAVE_ATTR(high_PHY_capable);
+SLAVE_ATTR(paging_support);
+SLAVE_ATTR(bank_delay_support);
+SLAVE_ATTR(p15_behave);
+SLAVE_ATTR(master_count);
+SLAVE_ATTR(source_ports);
+
+static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+
+	return sdw_slave_modalias(slave, buf, 256);
+}
+static DEVICE_ATTR_RO(modalias);
+
+static struct attribute *slave_dev_attrs[] = {
+	&dev_attr_mipi_revision.attr,
+	&dev_attr_wake_capable.attr,
+	&dev_attr_test_mode_capable.attr,
+	&dev_attr_clk_stop_mode1.attr,
+	&dev_attr_simple_clk_stop_capable.attr,
+	&dev_attr_clk_stop_timeout.attr,
+	&dev_attr_ch_prep_timeout.attr,
+	&dev_attr_reset_behave.attr,
+	&dev_attr_high_PHY_capable.attr,
+	&dev_attr_paging_support.attr,
+	&dev_attr_bank_delay_support.attr,
+	&dev_attr_p15_behave.attr,
+	&dev_attr_master_count.attr,
+	&dev_attr_source_ports.attr,
+	&dev_attr_modalias.attr,
+	NULL,
+};
+
+static struct attribute_group sdw_slave_dev_attr_group = {
+	.attrs	= slave_dev_attrs,
+};
+
+const struct attribute_group *sdw_slave_dev_attr_groups[] = {
+	&sdw_slave_dev_attr_group,
+	NULL
+};
+
+int sdw_sysfs_slave_init(struct sdw_slave *slave)
+{
+	/* TODO: Initialize dp0 and dpn kobject and attribute */
+	return 0;
+}
+
+void sdw_sysfs_slave_exit(struct sdw_slave *slave)
+{
+}
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 38c806cae2bf..299e15894860 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -362,6 +362,17 @@ int sdw_slave_read_dpn(struct sdw_slave *slave,
 		struct sdw_dpn_prop *dpn, int count, int ports, char *type);
 
 /*
+ * SDW sysfs APIs
+ */
+struct sdw_slave_sysfs;
+struct sdw_master_sysfs;
+
+int sdw_sysfs_bus_init(struct sdw_bus *bus);
+void sdw_sysfs_bus_exit(struct sdw_bus *bus);
+int sdw_sysfs_slave_init(struct sdw_slave *slave);
+void sdw_sysfs_slave_exit(struct sdw_slave *slave);
+
+/*
  * SDW Slave Structures and APIs
  */
 
@@ -421,6 +432,7 @@ struct sdw_slave_ops {
  * @bus: Bus handle
  * @ops: Slave callback ops
  * @prop: Slave properties
+ * @sysfs: Sysfs interface
  * @node: node for bus list
  * @port_ready: Port ready completion flag for each Slave port
  * @dev_num: Device Number assigned by Bus
@@ -432,6 +444,7 @@ struct sdw_slave {
 	struct sdw_bus *bus;
 	const struct sdw_slave_ops *ops;
 	struct sdw_slave_prop prop;
+	struct sdw_slave_sysfs *sysfs;
 	struct list_head node;
 	struct completion *port_ready;
 	u16 dev_num;
@@ -520,6 +533,7 @@ struct sdw_master_ops {
  * @msg_lock: message lock
  * @ops: Master callback ops
  * @prop: Master properties
+ * @sysfs: Bus sysfs
  * @defer_msg: Defer message
  * @clk_stop_timeout: Clock stop timeout computed
  */
@@ -532,6 +546,7 @@ struct sdw_bus {
 	struct mutex msg_lock;
 	const struct sdw_master_ops *ops;
 	struct sdw_master_prop prop;
+	struct sdw_master_sysfs *sysfs;
 	struct sdw_defer defer_msg;
 	unsigned int clk_stop_timeout;
 };
-- 
2.7.4
