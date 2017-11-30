From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 04/15] soundwire: Add MIPI DisCo property helpers
Date: Thu, 30 Nov 2017 15:26:59 +0530
Message-ID: <1512035830-29161-5-git-send-email-vinod.koul@intel.com>
References: <1512035830-29161-1-git-send-email-vinod.koul@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512035830-29161-1-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

MIPI Discovery And Configuration (DisCo) Specification for SoundWire
specifies properties to be implemented for SoundWire Masters and
Slaves. The DisCo spec doesn't mandate these properties. However,
SDW bus cannot work without knowing these values.

The helper functions read the Master and Slave properties.
Implementers of Master or Slave drivers can use any of the below
three mechanisms:
   a) Use these APIs here as .read_prop() callback for Master
      and Slave
   b) Implement own methods and set those as .read_prop(), but invoke
      APIs in this file for generic read and override the values with
      platform specific data
   c) Implement ones own methods which do not use anything provided
      here

Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/soundwire/Makefile     |   2 +-
 drivers/soundwire/bus.c        |   8 +
 drivers/soundwire/bus_type.c   |  23 ++-
 drivers/soundwire/mipi_disco.c | 422 +++++++++++++++++++++++++++++++++++++++++
 include/linux/soundwire/sdw.h  | 274 ++++++++++++++++++++++++++
 5 files changed, 727 insertions(+), 2 deletions(-)
 create mode 100644 drivers/soundwire/mipi_disco.c

diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index c875e434f8b3..bcde0d26524c 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -3,5 +3,5 @@
 #
 
 #Bus Objs
-soundwire-bus-objs := bus_type.o bus.o slave.o
+soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o
 obj-$(CONFIG_SOUNDWIRE_BUS) += soundwire-bus.o
diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 964f0400507c..c0db6d6243b3 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -73,6 +73,14 @@ int sdw_add_bus_master(struct sdw_bus *bus)
 	mutex_init(&bus->bus_lock);
 	INIT_LIST_HEAD(&bus->slaves);
 
+	if (bus->ops->read_prop) {
+		ret = bus->ops->read_prop(bus);
+		if (ret < 0) {
+			dev_err(bus->dev, "Bus read properties failed:%d", ret);
+			return ret;
+		}
+	}
+
 	/*
 	 * Device numbers in SoundWire are 0 thru 15 with 0 being
 	 * Enumeration device number and 15 broadcast device number. So
diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index ed8275d047f5..e897fd64864b 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -125,6 +125,8 @@ static int sdw_drv_probe(struct device *dev)
 	if (!id)
 		return -ENODEV;
 
+	slave->ops = drv->ops;
+
 	/*
 	 * attach to power domain but don't turn on (last arg)
 	 */
@@ -137,7 +139,26 @@ static int sdw_drv_probe(struct device *dev)
 		}
 	}
 
-	return ret;
+	if (ret)
+		return ret;
+
+	/* device is probed so let's read the properties now */
+	if (slave->ops && slave->ops->read_prop)
+		slave->ops->read_prop(slave);
+
+	/*
+	 * Check for valid clk_stop_timeout, use DisCo worst case value of
+	 * 300ms
+	 *
+	 * TODO: check the timeouts and driver removal case
+	 */
+	if (slave->prop.clk_stop_timeout == 0)
+		slave->prop.clk_stop_timeout = 300;
+
+	slave->bus->clk_stop_timeout = max_t(u32, slave->bus->clk_stop_timeout,
+					slave->prop.clk_stop_timeout);
+
+	return 0;
 }
 
 static int sdw_drv_remove(struct device *dev)
diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
new file mode 100644
index 000000000000..a2d3b6a435e4
--- /dev/null
+++ b/drivers/soundwire/mipi_disco.c
@@ -0,0 +1,422 @@
+/*
+ *  This file is provided under a dual BSD/GPLv2 license.  When using or
+ *  redistributing this file, you may do so under either license.
+ *
+ *  SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
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
+/*
+ * MIPI Discovery And Configuration (DisCo) Specification for SoundWire
+ * specifies properties to be implemented for SoundWire Masters and Slaves.
+ * The DisCo spec doesn't mandate these properties. However, SDW bus cannot
+ * work without knowing these values.
+ *
+ * The helper functions read the Master and Slave properties. Implementers
+ * of Master or Slave drivers can use any of the below three mechanisms:
+ *    a) Use these APIs here as .read_prop() callback for Master and Slave
+ *    b) Implement own methods and set those as .read_prop(), but invoke
+ *    APIs in this file for generic read and override the values with
+ *    platform specific data
+ *    c) Implement ones own methods which do not use anything provided
+ *    here
+ */
+
+#include <linux/device.h>
+#include <linux/property.h>
+#include <linux/mod_devicetable.h>
+#include <linux/soundwire/sdw.h>
+#include "bus.h"
+
+/**
+ * sdw_master_read_prop() - Read Master properties
+ * @bus: SDW bus instance
+ */
+int sdw_master_read_prop(struct sdw_bus *bus)
+{
+	struct sdw_master_prop *prop = &bus->prop;
+	struct fwnode_handle *link;
+	unsigned int count = 0;
+	char name[32];
+	int nval, i;
+
+	device_property_read_u32(bus->dev,
+			"mipi-sdw-sw-interface-revision", &prop->revision);
+	device_property_read_u32(bus->dev, "mipi-sdw-master-count", &count);
+
+	/* Find link handle */
+	snprintf(name, sizeof(name),
+			"mipi-sdw-link-%d-subproperties", bus->link_id);
+
+	link = device_get_named_child_node(bus->dev, name);
+	if (!link) {
+		dev_err(bus->dev, "Link node %s not found\n", name);
+		return -EIO;
+	}
+
+	if (fwnode_property_read_bool(link,
+			"mipi-sdw-clock-stop-mode0-supported") == true)
+		prop->clk_stop_mode = SDW_CLK_STOP_MODE0;
+
+	if (fwnode_property_read_bool(link,
+			"mipi-sdw-clock-stop-mode1-supported") == true)
+		prop->clk_stop_mode |= SDW_CLK_STOP_MODE1;
+
+	fwnode_property_read_u32(link,
+			"mipi-sdw-max-clock-frequency", &prop->max_freq);
+
+	nval = fwnode_property_read_u32_array(link,
+			"mipi-sdw-clock-frequencies-supported", NULL, 0);
+	if (nval > 0)
+		prop->num_freq = nval;
+
+	if (prop->num_freq) {
+		prop->freq = devm_kcalloc(bus->dev, nval,
+					sizeof(*prop->freq), GFP_KERNEL);
+		if (!prop->freq)
+			return -ENOMEM;
+
+		fwnode_property_read_u32_array(link,
+				"mipi-sdw-clock-frequencies-supported",
+				prop->freq, nval);
+
+		/*
+		 * Check the frequencies supported. If FW doesn't provide max
+		 * freq, then populate here by checking values.
+		 */
+		if (!prop->max_freq) {
+			prop->max_freq = prop->freq[0];
+			for (i = 1; i < prop->num_freq; i++) {
+				if (prop->freq[i] > prop->max_freq)
+					prop->max_freq = prop->freq[i];
+			}
+		}
+	}
+
+	nval = fwnode_property_read_u32_array(link,
+			"mipi-sdw-supported-clock-gears", NULL, 0);
+	if (nval > 0)
+		prop->num_clk_gears = nval;
+
+	if (prop->num_clk_gears) {
+		prop->clk_gears = devm_kcalloc(bus->dev, nval,
+				sizeof(*prop->clk_gears), GFP_KERNEL);
+		if (!prop->clk_gears)
+			return -ENOMEM;
+
+		fwnode_property_read_u32_array(link,
+				"mipi-sdw-supported-clock-gears",
+				prop->clk_gears, nval);
+	}
+
+	fwnode_property_read_u32(link, "mipi-sdw-default-frame-rate",
+				&prop->default_frame_rate);
+	fwnode_property_read_u32(link, "mipi-sdw-default-frame-row-size",
+				&prop->default_row);
+	fwnode_property_read_u32(link, "mipi-sdw-default-frame-col-size",
+				&prop->default_col);
+	prop->dynamic_frame =  fwnode_property_read_bool(link,
+				"mipi-sdw-dynamic-frame-shape");
+	fwnode_property_read_u32(link, "mipi-sdw-command-error-threshold",
+				&prop->err_threshold);
+
+	return 0;
+}
+EXPORT_SYMBOL(sdw_master_read_prop);
+
+static int sdw_slave_read_dpn(struct sdw_slave *slave,
+		struct sdw_dpn_prop *dpn, int count, int ports, char *type)
+{
+	struct fwnode_handle *node;
+	u32 bit, i = 0, nval;
+	unsigned long addr;
+	char name[40];
+
+	addr = ports;
+	/* valid ports are 1 to 14 so apply mask */
+	addr &= GENMASK(14, 1);
+
+	for_each_set_bit(bit, &addr, 32) {
+		snprintf(name, sizeof(name),
+			"mipi-sdw-dp-%d-%s-subproperties", bit, type);
+
+		dpn[i].num = bit;
+
+		node = device_get_named_child_node(&slave->dev, name);
+		if (!node) {
+			dev_err(&slave->dev, "%s dpN not found\n", name);
+			return -EIO;
+		}
+
+		fwnode_property_read_u32(node, "mipi-sdw-port-max-wordlength",
+						&dpn[i].max_word);
+		fwnode_property_read_u32(node, "mipi-sdw-port-min-wordlength",
+						&dpn[i].min_word);
+
+		nval = fwnode_property_read_u32_array(node,
+				"mipi-sdw-port-wordlength-configs", NULL, 0);
+		if (nval > 0)
+			dpn[i].num_words = nval;
+
+		if (dpn[i].num_words) {
+			dpn[i].words = devm_kcalloc(&slave->dev, nval,
+				sizeof(*dpn[i].words), GFP_KERNEL);
+			if (!dpn[i].words)
+				return -ENOMEM;
+
+			fwnode_property_read_u32_array(node,
+					"mipi-sdw-port-wordlength-configs",
+					&dpn[i].num_words, nval);
+		}
+
+		fwnode_property_read_u32(node, "mipi-sdw-data-port-type",
+				&dpn[i].type);
+		fwnode_property_read_u32(node,
+				"mipi-sdw-max-grouping-supported",
+				&dpn[i].max_grouping);
+		dpn[i].simple_ch_prep_sm = fwnode_property_read_bool(node,
+				"mipi-sdw-simplified-channelprepare-sm");
+		fwnode_property_read_u32(node,
+				"mipi-sdw-port-channelprepare-timeout",
+				&dpn[i].ch_prep_timeout);
+		fwnode_property_read_u32(node,
+				"mipi-sdw-imp-def-dpn-interrupts-supported",
+				&dpn[i].device_interrupts);
+		fwnode_property_read_u32(node, "mipi-sdw-min-channel-number",
+				&dpn[i].min_ch);
+		fwnode_property_read_u32(node, "mipi-sdw-max-channel-number",
+				&dpn[i].max_ch);
+
+		nval = fwnode_property_read_u32_array(node,
+				"mipi-sdw-channel-number-list", NULL, 0);
+		if (nval > 0)
+			dpn[i].num_ch = nval;
+
+		if (dpn[i].num_ch) {
+			dpn[i].ch = devm_kcalloc(&slave->dev, nval,
+					sizeof(*dpn[i].ch), GFP_KERNEL);
+			if (!dpn[i].ch)
+				return -ENOMEM;
+
+			fwnode_property_read_u32_array(node,
+					"mipi-sdw-channel-number-list",
+					dpn[i].ch, nval);
+		}
+
+		nval = fwnode_property_read_u32_array(node,
+				"mipi-sdw-channel-combination-list", NULL, 0);
+		if (nval > 0)
+			dpn[i].num_ch_combinations = nval;
+
+		if (dpn[i].num_ch_combinations) {
+			dpn[i].ch_combinations = devm_kcalloc(&slave->dev,
+					nval, sizeof(*dpn[i].ch_combinations),
+					GFP_KERNEL);
+			if (!dpn[i].ch_combinations)
+				return -ENOMEM;
+
+			fwnode_property_read_u32_array(node,
+					"mipi-sdw-channel-combination-list",
+					dpn[i].ch_combinations, nval);
+		}
+
+		fwnode_property_read_u32(node,
+				"mipi-sdw-modes-supported", &dpn[i].modes);
+		fwnode_property_read_u32(node, "mipi-sdw-max-async-buffer",
+				&dpn[i].max_async_buffer);
+		dpn[i].block_pack_mode = fwnode_property_read_bool(node,
+				"mipi-sdw-block-packing-mode");
+
+		fwnode_property_read_u32(node, "mipi-sdw-port-encoding-type",
+				&dpn[i].port_encoding);
+
+		/* TODO: Read audio mode */
+
+		i++;
+	}
+
+	return 0;
+}
+
+/**
+ * sdw_slave_read_prop() - Read Slave properties
+ * @slave: SDW Slave
+ */
+int sdw_slave_read_prop(struct sdw_slave *slave)
+{
+	struct sdw_slave_prop *prop = &slave->prop;
+	struct device *dev = &slave->dev;
+	struct fwnode_handle *port;
+	int num_of_ports, nval, i;
+
+	device_property_read_u32(dev, "mipi-sdw-sw-interface-revision",
+				&prop->mipi_revision);
+
+	prop->wake_capable = device_property_read_bool(dev,
+				"mipi-sdw-wake-up-unavailable");
+	prop->wake_capable = !prop->wake_capable;
+
+	prop->test_mode_capable = device_property_read_bool(dev,
+				"mipi-sdw-test-mode-supported");
+
+	prop->clk_stop_mode1 = false;
+	if (device_property_read_bool(dev,
+				"mipi-sdw-clock-stop-mode1-supported"))
+		prop->clk_stop_mode1 = true;
+
+	prop->simple_clk_stop_capable = device_property_read_bool(dev,
+			"mipi-sdw-simplified-clockstopprepare-sm-supported");
+
+	device_property_read_u32(dev, "mipi-sdw-clockstopprepare-timeout",
+			&prop->clk_stop_timeout);
+	device_property_read_u32(dev, "mipi-sdw-slave-channelprepare-timeout",
+			&prop->ch_prep_timeout);
+	device_property_read_u32(dev,
+			"mipi-sdw-clockstopprepare-hard-reset-behavior",
+			&prop->reset_behave);
+
+	prop->high_PHY_capable = device_property_read_bool(dev,
+			"mipi-sdw-highPHY-capable");
+	prop->paging_support = device_property_read_bool(dev,
+			"mipi-sdw-paging-support");
+	prop->bank_delay_support = device_property_read_bool(dev,
+			"mipi-sdw-bank-delay-support");
+	device_property_read_u32(dev,
+			"mipi-sdw-port15-read-behavior", &prop->p15_behave);
+	device_property_read_u32(dev, "mipi-sdw-master-count",
+				&prop->master_count);
+
+	device_property_read_u32(dev, "mipi-sdw-source-port-list",
+				&prop->source_ports);
+	device_property_read_u32(dev, "mipi-sdw-sink-port-list",
+				&prop->sink_ports);
+
+	/* Read dp0 properties */
+	port = device_get_named_child_node(dev, "mipi-sdw-dp-0-subproperties");
+	if (!port) {
+		dev_err(dev, "DP0 node not found!!\n");
+		return -EIO;
+	}
+
+	prop->dp0_prop = devm_kzalloc(&slave->dev,
+			sizeof(*prop->dp0_prop), GFP_KERNEL);
+	if (!prop->dp0_prop)
+		return -ENOMEM;
+
+	fwnode_property_read_u32(port, "mipi-sdw-port-max-wordlength",
+			&prop->dp0_prop->max_word);
+	fwnode_property_read_u32(port, "mipi-sdw-port-min-wordlength",
+			&prop->dp0_prop->min_word);
+	nval = fwnode_property_read_u32_array(port,
+			"mipi-sdw-port-wordlength-configs", NULL, 0);
+	if (nval > 0)
+		prop->dp0_prop->num_words = nval;
+
+	if (prop->dp0_prop->num_words) {
+		prop->dp0_prop->words = devm_kcalloc(&slave->dev, nval,
+				sizeof(*prop->dp0_prop->words), GFP_KERNEL);
+		if (!prop->dp0_prop->words)
+			return -ENOMEM;
+
+		fwnode_property_read_u32_array(port,
+				"mipi-sdw-port-wordlength-configs",
+				prop->dp0_prop->words, nval);
+	}
+
+	prop->dp0_prop->flow_controlled = fwnode_property_read_bool(port,
+			"mipi-sdw-bra-flow-controlled");
+
+	prop->dp0_prop->simple_ch_prep_sm = fwnode_property_read_bool(port,
+			"mipi-sdw-simplified-channel-prepare-sm");
+
+	prop->dp0_prop->device_interrupts = fwnode_property_read_bool(port,
+			"mipi-sdw-imp-def-dp0-interrupts-supported");
+
+	/*
+	 * Based on each DPn port, get source and sink dpn properties.
+	 * Also, some ports can operate as both source or sink.
+	 */
+
+	/* Allocate memory for set bits in port lists */
+	nval = hweight32(prop->source_ports);
+	num_of_ports += nval;
+	prop->src_dpn_prop = devm_kcalloc(&slave->dev, nval,
+				sizeof(*prop->src_dpn_prop), GFP_KERNEL);
+	if (!prop->src_dpn_prop)
+		return -ENOMEM;
+
+	/* Read dpn properties for source port(s) */
+	sdw_slave_read_dpn(slave, prop->src_dpn_prop, nval,
+			prop->source_ports, "source");
+
+	nval = hweight32(prop->sink_ports);
+	num_of_ports += nval;
+	prop->sink_dpn_prop = devm_kcalloc(&slave->dev, nval,
+				sizeof(*prop->sink_dpn_prop), GFP_KERNEL);
+	if (!prop->sink_dpn_prop)
+		return -ENOMEM;
+
+	/* Read dpn properties for sink port(s) */
+	sdw_slave_read_dpn(slave, prop->sink_dpn_prop, nval,
+			prop->sink_ports, "sink");
+
+	/* some ports are bidirectional so check total ports by ORing */
+	nval = prop->source_ports | prop->sink_ports;
+	num_of_ports = hweight32(nval) + 1; /* add 1 for DP0 */
+
+	/* Allocate port_ready based on num_of_ports */
+	slave->port_ready = devm_kcalloc(&slave->dev, num_of_ports,
+				sizeof(*slave->port_ready), GFP_KERNEL);
+	if (!slave->port_ready)
+		return -ENOMEM;
+
+	/* Initialize completion */
+	for (i = 0; i < num_of_ports; i++)
+		init_completion(&slave->port_ready[i]);
+
+	return 0;
+}
+EXPORT_SYMBOL(sdw_slave_read_prop);
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index d87b0d4b399a..06524af644e9 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -80,6 +80,252 @@ enum sdw_slave_status {
 };
 
 /*
+ * SDW properties, defined in MIPI DisCo spec v1.0
+ */
+enum sdw_clk_stop_reset_behave {
+	SDW_CLK_STOP_KEEP_STATUS = 1,
+};
+
+/**
+ * enum sdw_p15_behave - Slave Port 15 behaviour when the Master attempts a
+ * read
+ * @SDW_P15_READ_IGNORED: Read is ignored
+ * @SDW_P15_CMD_OK: Command is ok
+ */
+enum sdw_p15_behave {
+	SDW_P15_READ_IGNORED = 0,
+	SDW_P15_CMD_OK = 1,
+};
+
+/**
+ * enum sdw_dpn_type - Data port types
+ * @SDW_DPN_FULL: Full Data Port is supported
+ * @SDW_DPN_SIMPLE: Simplified Data Port as defined in spec.
+ * DPN_SampleCtrl2, DPN_OffsetCtrl2, DPN_HCtrl and DPN_BlockCtrl3
+ * are not implemented.
+ * @SDW_DPN_REDUCED: Reduced Data Port as defined in spec.
+ * DPN_SampleCtrl2, DPN_HCtrl are not implemented.
+ */
+enum sdw_dpn_type {
+	SDW_DPN_FULL = 0,
+	SDW_DPN_SIMPLE = 1,
+	SDW_DPN_REDUCED = 2,
+};
+
+/**
+ * enum sdw_clk_stop_mode - Clock Stop modes
+ * @SDW_CLK_STOP_MODE0: Slave can continue operation seamlessly on clock
+ * restart
+ * @SDW_CLK_STOP_MODE1: Slave may have entered a deeper power-saving mode,
+ * not capable of continuing operation seamlessly when the clock restarts
+ */
+enum sdw_clk_stop_mode {
+	SDW_CLK_STOP_MODE0 = 1,
+	SDW_CLK_STOP_MODE1 = 2,
+};
+
+/**
+ * struct sdw_dp0_prop - DP0 properties
+ * @max_word: Maximum number of bits in a Payload Channel Sample, 1 to 64
+ * (inclusive)
+ * @min_word: Minimum number of bits in a Payload Channel Sample, 1 to 64
+ * (inclusive)
+ * @num_words: number of wordlengths supported
+ * @words: wordlengths supported
+ * @flow_controlled: Slave implementation results in an OK_NotReady
+ * response
+ * @simple_ch_prep_sm: If channel prepare sequence is required
+ * @device_interrupts: If implementation-defined interrupts are supported
+ *
+ * The wordlengths are specified by Spec as max, min AND number of
+ * discrete values, implementation can define based on the wordlengths they
+ * support
+ */
+struct sdw_dp0_prop {
+	u32 max_word;
+	u32 min_word;
+	u32 num_words;
+	u32 *words;
+	bool flow_controlled;
+	bool simple_ch_prep_sm;
+	bool device_interrupts;
+};
+
+/**
+ * struct sdw_dpn_audio_mode - Audio mode properties for DPn
+ * @bus_min_freq: Minimum bus frequency, in Hz
+ * @bus_max_freq: Maximum bus frequency, in Hz
+ * @bus_num_freq: Number of discrete frequencies supported
+ * @bus_freq: Discrete bus frequencies, in Hz
+ * @min_freq: Minimum sampling frequency, in Hz
+ * @max_freq: Maximum sampling bus frequency, in Hz
+ * @num_freq: Number of discrete sampling frequency supported
+ * @freq: Discrete sampling frequencies, in Hz
+ * @prep_ch_behave: Specifies the dependencies between Channel Prepare
+ * sequence and bus clock configuration
+ * If 0, Channel Prepare can happen at any Bus clock rate
+ * If 1, Channel Prepare sequence shall happen only after Bus clock is
+ * changed to a frequency supported by this mode or compatible modes
+ * described by the next field
+ * @glitchless: Bitmap describing possible glitchless transitions from this
+ * Audio Mode to other Audio Modes
+ */
+struct sdw_dpn_audio_mode {
+	u32 bus_min_freq;
+	u32 bus_max_freq;
+	u32 bus_num_freq;
+	u32 *bus_freq;
+	u32 max_freq;
+	u32 min_freq;
+	u32 num_freq;
+	u32 *freq;
+	u32 prep_ch_behave;
+	u32 glitchless;
+};
+
+/**
+ * struct sdw_dpn_prop - Data Port DPn properties
+ * @num: port number
+ * @max_word: Maximum number of bits in a Payload Channel Sample, 1 to 64
+ * (inclusive)
+ * @min_word: Minimum number of bits in a Payload Channel Sample, 1 to 64
+ * (inclusive)
+ * @num_words: Number of discrete supported wordlengths
+ * @words: Discrete supported wordlength
+ * @type: Data port type. Full, Simplified or Reduced
+ * @max_grouping: Maximum number of samples that can be grouped together for
+ * a full data port
+ * @simple_ch_prep_sm: If the port supports simplified channel prepare state
+ * machine
+ * @ch_prep_timeout: Port-specific timeout value, in milliseconds
+ * @device_interrupts: If set, each bit corresponds to support for
+ * implementation-defined interrupts
+ * @max_ch: Maximum channels supported
+ * @min_ch: Minimum channels supported
+ * @num_ch: Number of discrete channels supported
+ * @ch: Discrete channels supported
+ * @num_ch_combinations: Number of channel combinations supported
+ * @ch_combinations: Channel combinations supported
+ * @modes: SDW mode supported
+ * @max_async_buffer: Number of samples that this port can buffer in
+ * asynchronous modes
+ * @block_pack_mode: Type of block port mode supported
+ * @port_encoding: Payload Channel Sample encoding schemes supported
+ * @audio_modes: Audio modes supported
+ */
+struct sdw_dpn_prop {
+	u32 num;
+	u32 max_word;
+	u32 min_word;
+	u32 num_words;
+	u32 *words;
+	enum sdw_dpn_type type;
+	u32 max_grouping;
+	bool simple_ch_prep_sm;
+	u32 ch_prep_timeout;
+	u32 device_interrupts;
+	u32 max_ch;
+	u32 min_ch;
+	u32 num_ch;
+	u32 *ch;
+	u32 num_ch_combinations;
+	u32 *ch_combinations;
+	u32 modes;
+	u32 max_async_buffer;
+	bool block_pack_mode;
+	u32 port_encoding;
+	struct sdw_dpn_audio_mode *audio_modes;
+};
+
+/**
+ * struct sdw_slave_prop - SoundWire Slave properties
+ * @mipi_revision: Spec version of the implementation
+ * @wake_capable: Wake-up events are supported
+ * @test_mode_capable: If test mode is supported
+ * @clk_stop_mode1: Clock-Stop Mode 1 is supported
+ * @simple_clk_stop_capable: Simple clock mode is supported
+ * @clk_stop_timeout: Worst-case latency of the Clock Stop Prepare State
+ * Machine transitions, in milliseconds
+ * @ch_prep_timeout: Worst-case latency of the Channel Prepare State Machine
+ * transitions, in milliseconds
+ * @reset_behave: Slave keeps the status of the SlaveStopClockPrepare
+ * state machine (P=1 SCSP_SM) after exit from clock-stop mode1
+ * @high_PHY_capable: Slave is HighPHY capable
+ * @paging_support: Slave implements paging registers SCP_AddrPage1 and
+ * SCP_AddrPage2
+ * @bank_delay_support: Slave implements bank delay/bridge support registers
+ * SCP_BankDelay and SCP_NextFrame
+ * @p15_behave: Slave behavior when the Master attempts a read to the Port15
+ * alias
+ * @lane_control_support: Slave supports lane control
+ * @master_count: Number of Masters present on this Slave
+ * @source_ports: Bitmap identifying source ports
+ * @sink_ports: Bitmap identifying sink ports
+ * @dp0_prop: Data Port 0 properties
+ * @src_dpn_prop: Source Data Port N properties
+ * @sink_dpn_prop: Sink Data Port N properties
+ */
+struct sdw_slave_prop {
+	u32 mipi_revision;
+	bool wake_capable;
+	bool test_mode_capable;
+	bool clk_stop_mode1;
+	bool simple_clk_stop_capable;
+	u32 clk_stop_timeout;
+	u32 ch_prep_timeout;
+	enum sdw_clk_stop_reset_behave reset_behave;
+	bool high_PHY_capable;
+	bool paging_support;
+	bool bank_delay_support;
+	enum sdw_p15_behave p15_behave;
+	bool lane_control_support;
+	u32 master_count;
+	u32 source_ports;
+	u32 sink_ports;
+	struct sdw_dp0_prop *dp0_prop;
+	struct sdw_dpn_prop *src_dpn_prop;
+	struct sdw_dpn_prop *sink_dpn_prop;
+};
+
+/**
+ * struct sdw_master_prop - Master properties
+ * @revision: MIPI spec version of the implementation
+ * @master_count: Number of masters
+ * @clk_stop_mode: Bitmap for Clock Stop modes supported
+ * @max_freq: Maximum Bus clock frequency, in Hz
+ * @num_clk_gears: Number of clock gears supported
+ * @clk_gears: Clock gears supported
+ * @num_freq: Number of clock frequencies supported, in Hz
+ * @freq: Clock frequencies supported, in Hz
+ * @default_frame_rate: Controller default Frame rate, in Hz
+ * @default_row: Number of rows
+ * @default_col: Number of columns
+ * @dynamic_frame: Dynamic frame supported
+ * @err_threshold: Number of times that software may retry sending a single
+ * command
+ * @dpn_prop: Data Port N properties
+ */
+struct sdw_master_prop {
+	u32 revision;
+	u32 master_count;
+	enum sdw_clk_stop_mode clk_stop_mode;
+	u32 max_freq;
+	u32 num_clk_gears;
+	u32 *clk_gears;
+	u32 num_freq;
+	u32 *freq;
+	u32 default_frame_rate;
+	u32 default_row;
+	u32 default_col;
+	bool dynamic_frame;
+	u32 err_threshold;
+	struct sdw_dpn_prop *dpn_prop;
+};
+
+int sdw_master_read_prop(struct sdw_bus *bus);
+int sdw_slave_read_prop(struct sdw_slave *slave);
+
+/*
  * SDW Slave Structures and APIs
  */
 
@@ -103,12 +349,23 @@ struct sdw_slave_id {
 };
 
 /**
+ * struct sdw_slave_ops - Slave driver callback ops
+ * @read_prop: Read Slave properties
+ */
+struct sdw_slave_ops {
+	int (*read_prop)(struct sdw_slave *sdw);
+};
+
+/**
  * struct sdw_slave - SoundWire Slave
  * @id: MIPI device ID
  * @dev: Linux device
  * @status: Status reported by the Slave
  * @bus: Bus handle
+ * @ops: Slave callback ops
+ * @prop: Slave properties
  * @node: node for bus list
+ * @port_ready: Port ready completion flag for each Slave port
  * @dev_num: Device Number assigned by Bus
  */
 struct sdw_slave {
@@ -116,7 +373,10 @@ struct sdw_slave {
 	struct device dev;
 	enum sdw_slave_status status;
 	struct sdw_bus *bus;
+	const struct sdw_slave_ops *ops;
+	struct sdw_slave_prop prop;
 	struct list_head node;
+	struct completion *port_ready;
 	u16 dev_num;
 };
 
@@ -155,6 +415,14 @@ void sdw_unregister_driver(struct sdw_driver *drv);
  */
 
 /**
+ * struct sdw_master_ops - Master driver ops
+ * @read_prop: Read Master properties
+ */
+struct sdw_master_ops {
+	int (*read_prop)(struct sdw_bus *bus);
+};
+
+/**
  * struct sdw_bus - SoundWire bus
  * @dev: Master linux device
  * @link_id: Link id number, can be 0 to N, unique for each Master
@@ -162,6 +430,9 @@ void sdw_unregister_driver(struct sdw_driver *drv);
  * @assigned: Bitmap for Slave device numbers.
  * Bit set implies used number, bit clear implies unused number.
  * @bus_lock: bus lock
+ * @ops: Master callback ops
+ * @prop: Master properties
+ * @clk_stop_timeout: Clock stop timeout computed
  */
 struct sdw_bus {
 	struct device *dev;
@@ -169,6 +440,9 @@ struct sdw_bus {
 	struct list_head slaves;
 	DECLARE_BITMAP(assigned, SDW_MAX_DEVICES);
 	struct mutex bus_lock;
+	const struct sdw_master_ops *ops;
+	struct sdw_master_prop prop;
+	unsigned int clk_stop_timeout;
 };
 
 int sdw_add_bus_master(struct sdw_bus *bus);
-- 
2.7.4
