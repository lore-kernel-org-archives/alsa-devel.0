From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 04/13] soundwire: Add Master and Slave port
	programming
Date: Wed, 28 Mar 2018 15:08:29 +0530
Message-ID: <1522229918-4748-5-git-send-email-vinod.koul@intel.com>
References: <1522229918-4748-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A77D2671AB
 for <alsa-devel@alsa-project.org>; Wed, 28 Mar 2018 11:34:40 +0200 (CEST)
In-Reply-To: <1522229918-4748-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Sanyog Kale <sanyog.r.kale@intel.com>

Master and Slave port registers need to be programmed for each port
used in a stream. Add the helpers for port register programming.

Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/soundwire/Makefile    |   3 +-
 drivers/soundwire/bus.h       |   4 +
 drivers/soundwire/runtime.c   | 243 ++++++++++++++++++++++++++++++++++++++++++
 drivers/soundwire/stream.c    |  33 ++++++
 include/linux/soundwire/sdw.h |  47 +++++++-
 5 files changed, 328 insertions(+), 2 deletions(-)
 create mode 100644 drivers/soundwire/runtime.c

diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index 5817beaca0e1..64fe4712ed87 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -3,7 +3,8 @@
 #
 
 #Bus Objs
-soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o
+soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o \
+			runtime.o
 obj-$(CONFIG_SOUNDWIRE_BUS) += soundwire-bus.o
 
 #Cadence Objs
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index b28a0c224323..8bb150294936 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -109,6 +109,10 @@ struct sdw_master_runtime {
 	struct list_head bus_node;
 };
 
+struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
+				enum sdw_data_direction direction,
+				unsigned int port_num);
+
 int sdw_transfer(struct sdw_bus *bus, struct sdw_msg *msg);
 int sdw_transfer_defer(struct sdw_bus *bus, struct sdw_msg *msg,
 				struct sdw_defer *defer);
diff --git a/drivers/soundwire/runtime.c b/drivers/soundwire/runtime.c
new file mode 100644
index 000000000000..6e8826a6ea8e
--- /dev/null
+++ b/drivers/soundwire/runtime.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2015-18 Intel Corporation.
+
+/*
+ *  runtime.c - SoundWire Stream runtime operations.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/soundwire/sdw_registers.h>
+#include <linux/mod_devicetable.h>
+#include <linux/soundwire/sdw.h>
+#include "bus.h"
+
+static int _sdw_program_slave_port_params(struct sdw_bus *bus,
+				struct sdw_slave *slave,
+				struct sdw_transport_params *t_params,
+				enum sdw_dpn_type type)
+{
+	u32 addr1, addr2, addr3, addr4;
+	int ret;
+	u8 wbuf;
+
+	if (bus->params.next_bank) {
+		addr1 = SDW_DPN_OFFSETCTRL2_B1(t_params->port_num);
+		addr2 = SDW_DPN_BLOCKCTRL3_B1(t_params->port_num);
+		addr3 = SDW_DPN_SAMPLECTRL2_B1(t_params->port_num);
+		addr4 = SDW_DPN_HCTRL_B1(t_params->port_num);
+	} else {
+		addr1 = SDW_DPN_OFFSETCTRL2_B0(t_params->port_num);
+		addr2 = SDW_DPN_BLOCKCTRL3_B0(t_params->port_num);
+		addr3 = SDW_DPN_SAMPLECTRL2_B0(t_params->port_num);
+		addr4 = SDW_DPN_HCTRL_B0(t_params->port_num);
+	}
+
+	/* Program DPN_OffsetCtrl2 registers */
+	ret = sdw_write(slave, addr1, t_params->offset2);
+	if (ret < 0) {
+		dev_err(bus->dev, "DPN_OffsetCtrl2 register write failed");
+		return ret;
+	}
+
+	/* Program DPN_BlockCtrl3 register */
+	ret = sdw_write(slave, addr2, t_params->blk_pkg_mode);
+	if (ret < 0) {
+		dev_err(bus->dev, "DPN_BlockCtrl3 register write failed");
+		return ret;
+	}
+
+	/*
+	 * Data ports are FULL and REDUCED type. Above handles both and
+	 * beyond this point only FULL is handled, so bail out if we are
+	 * not FULL data port type
+	 */
+	if (type != SDW_DPN_FULL)
+		return ret;
+
+	/* Program DPN_SampleCtrl2 register */
+	wbuf = ((t_params->sample_interval - 1) &
+			SDW_DPN_SAMPLECTRL_HIGH) >>
+			SDW_REG_SHIFT(SDW_DPN_SAMPLECTRL_HIGH);
+
+	ret = sdw_write(slave, addr3, wbuf);
+	if (ret < 0) {
+		dev_err(bus->dev, "DPN_SampleCtrl2 register write failed");
+		return ret;
+	}
+
+	/* Program DPN_HCtrl register */
+	wbuf = (t_params->hstop | (t_params->hstart <<
+				SDW_REG_SHIFT(SDW_DPN_HCTRL_HSTART)));
+	ret = sdw_write(slave, addr4, wbuf);
+	if (ret < 0)
+		dev_err(bus->dev, "DPN_HCtrl register write failed");
+
+	return ret;
+}
+
+static int sdw_program_slave_port_params(struct sdw_bus *bus,
+			struct sdw_slave_runtime *s_rt,
+			struct sdw_port_runtime *p_rt)
+{
+	struct sdw_transport_params *t_params = &p_rt->transport_params;
+	struct sdw_port_params *p_params = &p_rt->port_params;
+	struct sdw_slave_prop *slave_prop = &s_rt->slave->prop;
+	u32 addr1, addr2, addr3, addr4, addr5, addr6;
+	struct sdw_dpn_prop *dpn_prop;
+	int ret;
+	u8 wbuf;
+
+	dpn_prop = sdw_get_slave_dpn_prop(s_rt->slave,
+					s_rt->direction,
+					t_params->port_num);
+	if (!dpn_prop)
+		return -EINVAL;
+
+	addr1 = SDW_DPN_PORTCTRL(t_params->port_num);
+	addr2 = SDW_DPN_BLOCKCTRL1(t_params->port_num);
+
+	if (bus->params.next_bank) {
+		addr3 = SDW_DPN_SAMPLECTRL1_B1(t_params->port_num);
+		addr4 = SDW_DPN_OFFSETCTRL1_B1(t_params->port_num);
+		addr5 = SDW_DPN_BLOCKCTRL2_B1(t_params->port_num);
+		addr6 = SDW_DPN_LANECTRL_B1(t_params->port_num);
+
+	} else {
+		addr3 = SDW_DPN_SAMPLECTRL1_B0(t_params->port_num);
+		addr4 = SDW_DPN_OFFSETCTRL1_B0(t_params->port_num);
+		addr5 = SDW_DPN_BLOCKCTRL2_B0(t_params->port_num);
+		addr6 = SDW_DPN_LANECTRL_B0(t_params->port_num);
+	}
+
+	/* Program DPN_PortCtrl register */
+	wbuf = p_params->data_mode << SDW_REG_SHIFT(SDW_DPN_PORTCTRL_DATAMODE);
+	wbuf |= p_params->flow_mode;
+
+	ret = sdw_update(s_rt->slave, addr1, 0xF, wbuf);
+	if (ret < 0) {
+		dev_err(&s_rt->slave->dev,
+			"DPN_PortCtrl register write failed for port %d",
+			t_params->port_num);
+		return ret;
+	}
+
+	/* Program DPN_BlockCtrl1 register */
+	ret = sdw_write(s_rt->slave, addr2, (p_params->bps - 1));
+	if (ret < 0) {
+		dev_err(&s_rt->slave->dev,
+			"DPN_BlockCtrl1 register write failed for port %d",
+			t_params->port_num);
+		return ret;
+	}
+
+	/* Program DPN_SampleCtrl1 register */
+	wbuf = (t_params->sample_interval - 1) & SDW_DPN_SAMPLECTRL_LOW;
+	ret = sdw_write(s_rt->slave, addr3, wbuf);
+	if (ret < 0) {
+		dev_err(&s_rt->slave->dev,
+			"DPN_SampleCtrl1 register write failed for port %d",
+			t_params->port_num);
+		return ret;
+	}
+
+	/* Program DPN_OffsetCtrl1 registers */
+	ret = sdw_write(s_rt->slave, addr4, t_params->offset1);
+	if (ret < 0) {
+		dev_err(&s_rt->slave->dev,
+			"DPN_OffsetCtrl1 register write failed for port %d",
+			t_params->port_num);
+		return ret;
+	}
+
+	/* Program DPN_BlockCtrl2 register*/
+	if (t_params->blk_grp_ctrl_valid) {
+		ret = sdw_write(s_rt->slave, addr5, t_params->blk_grp_ctrl);
+		if (ret < 0) {
+			dev_err(&s_rt->slave->dev,
+				"DPN_BlockCtrl2 reg write failed for port %d",
+				t_params->port_num);
+			return ret;
+		}
+	}
+
+	/* program DPN_LaneCtrl register */
+	if (slave_prop->lane_control_support) {
+		ret = sdw_write(s_rt->slave, addr6, t_params->lane_ctrl);
+		if (ret < 0) {
+			dev_err(&s_rt->slave->dev,
+				"DPN_LaneCtrl register write failed for port %d",
+				t_params->port_num);
+			return ret;
+		}
+	}
+
+	if (dpn_prop->type != SDW_DPN_SIMPLE) {
+		ret = _sdw_program_slave_port_params(bus, s_rt->slave,
+						t_params, dpn_prop->type);
+		if (ret < 0)
+			dev_err(&s_rt->slave->dev,
+				"Transport reg write failed for port: %d",
+				t_params->port_num);
+	}
+
+	return ret;
+}
+
+static int sdw_program_master_port_params(struct sdw_bus *bus,
+		struct sdw_port_runtime *p_rt)
+{
+	int ret;
+
+	/*
+	 * we need to set transport and port parameters for the port.
+	 * Transport parameters refers to the smaple interval, offsets and
+	 * hstart/stop etc of the data. Port parameters refers to word
+	 * length, flow mode etc of the port
+	 */
+	ret = bus->port_ops->dpn_set_port_transport_params(bus,
+					&p_rt->transport_params,
+					bus->params.next_bank);
+	if (ret < 0)
+		return ret;
+
+	return bus->port_ops->dpn_set_port_params(bus,
+				&p_rt->port_params,
+				bus->params.next_bank);
+}
+
+/**
+ * sdw_program_port_params: Programs transport parameters of Master(s)
+ * and Slave(s)
+ *
+ * @m_rt: Master stream runtime
+ */
+static int sdw_program_port_params(struct sdw_master_runtime *m_rt)
+{
+	struct sdw_slave_runtime *s_rt = NULL;
+	struct sdw_bus *bus = m_rt->bus;
+	struct sdw_port_runtime *p_rt;
+	int ret = 0;
+
+	/* Program transport & port parameters for Slave(s) */
+	list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
+		list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
+
+			ret = sdw_program_slave_port_params(bus, s_rt, p_rt);
+			if (ret < 0)
+				return ret;
+
+		}
+	}
+
+	/* Program transport & port parameters for Master(s) */
+	list_for_each_entry(p_rt, &m_rt->port_list, port_node) {
+		ret = sdw_program_master_port_params(bus, p_rt);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 95ad714b9c76..a29447e9a2f0 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -492,3 +492,36 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 	return ret;
 }
 EXPORT_SYMBOL(sdw_stream_add_slave);
+
+/**
+ * sdw_get_slave_dpn_prop: Get Slave port capabilities
+ *
+ * @slave: Slave handle
+ * @direction: Data direction.
+ * @port_num: Port number
+ */
+struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
+				enum sdw_data_direction direction,
+				unsigned int port_num)
+{
+	struct sdw_dpn_prop *dpn_prop;
+	u8 num_ports;
+	int i;
+
+	if (direction == SDW_DATA_DIR_OUT) {
+		num_ports = hweight32(slave->prop.source_ports);
+		dpn_prop = slave->prop.src_dpn_prop;
+	} else {
+		num_ports = hweight32(slave->prop.sink_ports);
+		dpn_prop = slave->prop.sink_dpn_prop;
+	}
+
+	for (i = 0; i < num_ports; i++) {
+		dpn_prop = &dpn_prop[i];
+
+		if (dpn_prop->num == port_num)
+			return &dpn_prop[i];
+	}
+
+	return NULL;
+}
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index a6db8e6dccc9..57aba663a4e3 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -370,7 +370,30 @@ struct sdw_slave_intr_status {
 };
 
 /**
- * struct sdw_slave_ops - Slave driver callback ops
+ * sdw_reg_bank - SoundWire register banks
+ * @SDW_BANK0: Soundwire register bank 0
+ * @SDW_BANK1: Soundwire register bank 1
+ */
+enum sdw_reg_bank {
+	SDW_BANK0,
+	SDW_BANK1,
+};
+
+/**
+ * struct sdw_bus_params: Structure holding bus configuration
+ *
+ * @curr_bank: Current bank in use (BANK0/BANK1)
+ * @next_bank: Next bank to use (BANK0/BANK1). next_bank will always be
+ * set to !curr_bank
+ */
+struct sdw_bus_params {
+	enum sdw_reg_bank curr_bank;
+	enum sdw_reg_bank next_bank;
+};
+
+/**
+ * struct sdw_slave_ops: Slave driver callback ops
+ *
  * @read_prop: Read Slave properties
  * @interrupt_callback: Device interrupt notification (invoked in thread
  * context)
@@ -485,6 +508,24 @@ struct sdw_transport_params {
 	unsigned int lane_ctrl;
 };
 
+/**
+ * struct sdw_master_port_ops: Callback functions from bus to Master
+ * driver to set Master Data ports.
+ *
+ * @dpn_set_port_params: Set the Port parameters for the Master Port.
+ * Mandatory callback
+ * @dpn_set_port_transport_params: Set transport parameters for the Master
+ * Port. Mandatory callback
+ */
+struct sdw_master_port_ops {
+	int (*dpn_set_port_params)(struct sdw_bus *bus,
+			struct sdw_port_params *port_params,
+			unsigned int bank);
+	int (*dpn_set_port_transport_params)(struct sdw_bus *bus,
+			struct sdw_transport_params *transport_params,
+			enum sdw_reg_bank bank);
+};
+
 struct sdw_msg;
 
 /**
@@ -528,6 +569,8 @@ struct sdw_master_ops {
  * @bus_lock: bus lock
  * @msg_lock: message lock
  * @ops: Master callback ops
+ * @port_ops: Master port callback ops
+ * @params: Current bus parameters
  * @prop: Master properties
  * @m_rt_list: List of Master instance of all stream(s) running on Bus. This
  * is used to compute and program bus bandwidth, clock, frame shape,
@@ -543,6 +586,8 @@ struct sdw_bus {
 	struct mutex bus_lock;
 	struct mutex msg_lock;
 	const struct sdw_master_ops *ops;
+	const struct sdw_master_port_ops *port_ops;
+	struct sdw_bus_params params;
 	struct sdw_master_prop prop;
 	struct list_head m_rt_list;
 	struct sdw_defer defer_msg;
-- 
2.7.4
