From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 02/13] soundwire: Add support for SoundWire
	stream management
Date: Wed, 28 Mar 2018 15:08:27 +0530
Message-ID: <1522229918-4748-3-git-send-email-vinod.koul@intel.com>
References: <1522229918-4748-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id C700F266E07
 for <alsa-devel@alsa-project.org>; Wed, 28 Mar 2018 11:34:33 +0200 (CEST)
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

This patch adds APIs and relevant stream data structures
for initialization and release of stream.

Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/soundwire/Makefile    |   2 +-
 drivers/soundwire/bus.c       |   1 +
 drivers/soundwire/bus.h       |  32 ++++
 drivers/soundwire/stream.c    | 337 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/soundwire/sdw.h | 112 ++++++++++++++
 5 files changed, 483 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soundwire/stream.c

diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index e1a74c5692aa..5817beaca0e1 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -3,7 +3,7 @@
 #
 
 #Bus Objs
-soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o
+soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o
 obj-$(CONFIG_SOUNDWIRE_BUS) += soundwire-bus.o
 
 #Cadence Objs
diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index d6dc8e7a8614..abf046f6b188 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -32,6 +32,7 @@ int sdw_add_bus_master(struct sdw_bus *bus)
 	mutex_init(&bus->msg_lock);
 	mutex_init(&bus->bus_lock);
 	INIT_LIST_HEAD(&bus->slaves);
+	INIT_LIST_HEAD(&bus->m_rt_list);
 
 	if (bus->ops->read_prop) {
 		ret = bus->ops->read_prop(bus);
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 345c34d697e9..0f55a18fa652 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -45,6 +45,38 @@ struct sdw_msg {
 	bool page;
 };
 
+/**
+ * sdw_slave_runtime: Runtime Stream parameters for Slave
+ *
+ * @slave: Slave handle
+ * @direction: Data direction w.r.t Slave
+ * @ch_count: Channel count of the Slave w.r.t stream
+ * @m_rt_node: sdw_master_runtime list node
+ */
+struct sdw_slave_runtime {
+	struct sdw_slave *slave;
+	enum sdw_data_direction direction;
+	unsigned int ch_count;
+	struct list_head m_rt_node;
+};
+
+/**
+ * sdw_master_runtime: Runtime stream parameters for Master
+ *
+ * @bus: Bus handle
+ * @stream: Stream runtime handle
+ * @ch_count: Master channel count
+ * @slave_rt_list: Slave runtime list
+ * @bus_node: sdw_bus m_rt_list node
+ */
+struct sdw_master_runtime {
+	struct sdw_bus *bus;
+	struct sdw_stream_runtime *stream;
+	unsigned int ch_count;
+	struct list_head slave_rt_list;
+	struct list_head bus_node;
+};
+
 int sdw_transfer(struct sdw_bus *bus, struct sdw_msg *msg);
 int sdw_transfer_defer(struct sdw_bus *bus, struct sdw_msg *msg,
 				struct sdw_defer *defer);
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
new file mode 100644
index 000000000000..00b9fcea4369
--- /dev/null
+++ b/drivers/soundwire/stream.c
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2015-18 Intel Corporation.
+
+/*
+ *  stream.c - SoundWire Bus stream operations.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/slab.h>
+#include <linux/soundwire/sdw.h>
+#include "bus.h"
+
+/**
+ * sdw_release_stream: Free the assigned stream runtime
+ *
+ * @stream: SoundWire stream runtime
+ *
+ * sdw_release_stream should be called only once per stream
+ */
+void sdw_release_stream(struct sdw_stream_runtime *stream)
+{
+	kfree(stream);
+}
+EXPORT_SYMBOL(sdw_release_stream);
+
+/**
+ * sdw_alloc_stream: Allocate and return stream runtime
+ *
+ * @stream_name: SoundWire stream name
+ *
+ * Allocates a SoundWire stream runtime instance.
+ * sdw_alloc_stream should be called only once per stream
+ */
+struct sdw_stream_runtime *sdw_alloc_stream(char *stream_name)
+{
+	struct sdw_stream_runtime *stream;
+
+	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
+	if (!stream)
+		return NULL;
+
+	stream->name = stream_name;
+	stream->state = SDW_STREAM_ALLOC;
+
+	return stream;
+}
+EXPORT_SYMBOL(sdw_alloc_stream);
+
+/**
+ * sdw_alloc_master_rt: Allocates and initialize Master runtime handle
+ *
+ * @bus: SDW bus instance
+ * @stream_config: Stream configuration
+ * @stream: Stream runtime handle.
+ *
+ * This function is to be called with bus_lock held.
+ */
+static struct sdw_master_runtime
+*sdw_alloc_master_rt(struct sdw_bus *bus,
+			struct sdw_stream_config *stream_config,
+			struct sdw_stream_runtime *stream)
+{
+	struct sdw_master_runtime *m_rt;
+
+	m_rt = stream->m_rt;
+	if (m_rt)
+		goto stream_config;
+
+	m_rt = kzalloc(sizeof(*m_rt), GFP_KERNEL);
+	if (!m_rt)
+		return NULL;
+
+	/* Initialization of Master runtime handle */
+	INIT_LIST_HEAD(&m_rt->slave_rt_list);
+	stream->m_rt = m_rt;
+
+	list_add_tail(&m_rt->bus_node, &bus->m_rt_list);
+
+stream_config:
+	m_rt->ch_count = stream_config->ch_count;
+	m_rt->bus = bus;
+	m_rt->stream = stream;
+
+	return m_rt;
+}
+
+/**
+ * sdw_alloc_slave_rt: Allocate and initialize Slave runtime handle.
+ *
+ * @slave: Slave handle
+ * @stream_config: Stream configuration
+ * @stream: Stream runtime handle
+ *
+ * This function is to be called with bus_lock held.
+ */
+static struct sdw_slave_runtime
+*sdw_alloc_slave_rt(struct sdw_slave *slave,
+			struct sdw_stream_config *stream_config,
+			struct sdw_stream_runtime *stream)
+{
+	struct sdw_slave_runtime *s_rt = NULL;
+
+	s_rt = kzalloc(sizeof(*s_rt), GFP_KERNEL);
+	if (!s_rt)
+		return NULL;
+
+
+	s_rt->ch_count = stream_config->ch_count;
+	s_rt->direction = stream_config->direction;
+	s_rt->slave = slave;
+
+	return s_rt;
+}
+
+/**
+ * sdw_release_slave_stream: Free Slave(s) runtime handle
+ *
+ * @slave: Slave handle.
+ * @stream: Stream runtime handle.
+ *
+ * This function is to be called with bus_lock held.
+ */
+static void sdw_release_slave_stream(struct sdw_slave *slave,
+			struct sdw_stream_runtime *stream)
+{
+	struct sdw_slave_runtime *s_rt, *_s_rt;
+	struct sdw_master_runtime *m_rt = stream->m_rt;
+
+	/* Retrieve Slave runtime handle */
+	list_for_each_entry_safe(s_rt, _s_rt,
+			&m_rt->slave_rt_list, m_rt_node) {
+
+		if (s_rt->slave == slave) {
+			list_del(&s_rt->m_rt_node);
+			kfree(s_rt);
+			return;
+		}
+	}
+}
+
+static void sdw_release_master_stream(struct sdw_stream_runtime *stream)
+{
+	struct sdw_master_runtime *m_rt = stream->m_rt;
+	struct sdw_slave_runtime *s_rt, *_s_rt;
+
+	list_for_each_entry_safe(s_rt, _s_rt,
+			&m_rt->slave_rt_list, m_rt_node)
+		sdw_release_slave_stream(s_rt->slave, stream);
+
+	list_del(&m_rt->bus_node);
+}
+
+/**
+ * sdw_stream_remove_master: Remove master from sdw_stream
+ *
+ * @bus: SDW Bus instance
+ * @stream: Soundwire stream
+ *
+ * This removes and frees master_rt from a stream
+ */
+
+int sdw_stream_remove_master(struct sdw_bus *bus,
+		struct sdw_stream_runtime *stream)
+{
+	mutex_lock(&bus->bus_lock);
+
+	sdw_release_master_stream(stream);
+	stream->state = SDW_STREAM_RELEASE;
+	kfree(stream->m_rt);
+	stream->m_rt = NULL;
+
+	mutex_unlock(&bus->bus_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(sdw_stream_remove_master);
+
+/**
+ * sdw_stream_remove_slave: Remove slave from sdw_stream
+ *
+ * @slave: SDW Slave instance
+ * @stream: Soundwire stream
+ *
+ * This removes and frees slave_rt from a stream
+ */
+
+int sdw_stream_remove_slave(struct sdw_slave *slave,
+		struct sdw_stream_runtime *stream)
+{
+	mutex_lock(&slave->bus->bus_lock);
+
+	sdw_release_slave_stream(slave, stream);
+
+	mutex_unlock(&slave->bus->bus_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(sdw_stream_remove_slave);
+
+static int sdw_config_stream(struct device *dev,
+		struct sdw_stream_runtime *stream,
+		struct sdw_stream_config *stream_config)
+{
+
+	/*
+	 * Update the stream rate, channel and bps based on data
+	 * transmitter. For more than one transmitter (multilink),
+	 * match the rate, bps and increment number of channels.
+	 */
+	if ((stream->params.rate) &&
+			(stream->params.rate != stream_config->frame_rate)) {
+		dev_err(dev, "rate for multilink not matching, stream:%s",
+				stream->name);
+		return -EINVAL;
+	}
+
+	if ((stream->params.bps) &&
+			(stream->params.bps != stream_config->bps)) {
+		dev_err(dev, "bps for multilink not matching, stream:%s",
+				stream->name);
+		return -EINVAL;
+	}
+
+	stream->params.rate = stream_config->frame_rate;
+	stream->params.bps = stream_config->bps;
+	stream->params.ch_count += stream_config->ch_count;
+	stream->type = stream_config->type;
+
+	return 0;
+}
+
+/**
+ * sdw_stream_add_master: Allocate and add master runtime to a stream
+ *
+ * @bus: SDW Bus instance
+ * @stream_config: Stream configuration for audio stream
+ * @stream: Soundwire stream
+ */
+int sdw_stream_add_master(struct sdw_bus *bus,
+		struct sdw_stream_config *stream_config,
+		struct sdw_stream_runtime *stream)
+{
+	struct sdw_master_runtime *m_rt = NULL;
+	int ret;
+
+	if (stream->state != SDW_STREAM_ALLOC &&
+			stream->state != SDW_STREAM_CONFIG) {
+		dev_err(bus->dev,
+			"Invalid stream state %d", stream->state);
+		return -EINVAL;
+	}
+
+	mutex_lock(&bus->bus_lock);
+
+	m_rt = sdw_alloc_master_rt(bus, stream_config, stream);
+	if (!m_rt) {
+		dev_err(bus->dev,
+				"Master runtime config failed for stream:%s",
+				stream->name);
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	if (!list_empty(&m_rt->slave_rt_list) &&
+			stream->state == SDW_STREAM_ALLOC)
+		stream->state = SDW_STREAM_CONFIG;
+
+error:
+	mutex_unlock(&bus->bus_lock);
+	return ret;
+
+}
+EXPORT_SYMBOL(sdw_stream_add_master);
+
+/**
+ * sdw_stream_add_slave: Allocate and add master/slave runtime to a stream
+ *
+ * @slave: SDW Slave instance
+ * @stream_config: Stream configuration for audio stream
+ * @stream: Soundwire stream
+ */
+int sdw_stream_add_slave(struct sdw_slave *slave,
+		struct sdw_stream_config *stream_config,
+		struct sdw_stream_runtime *stream)
+{
+	struct sdw_slave_runtime *s_rt;
+	struct sdw_master_runtime *m_rt;
+	int ret;
+
+	if (stream->state != SDW_STREAM_ALLOC &&
+			stream->state != SDW_STREAM_CONFIG) {
+		dev_err(&slave->dev,
+			"Invalid stream state %d", stream->state);
+		return -EINVAL;
+	}
+
+	mutex_lock(&slave->bus->bus_lock);
+
+	/*
+	 * If this API is invoked by slave first then m_rt is not valid.
+	 * So, allocate that and add the slave to it.
+	 */
+	m_rt = sdw_alloc_master_rt(slave->bus, stream_config, stream);
+	if (!m_rt) {
+		dev_err(&slave->dev,
+				"alloc master runtime failed for stream:%s",
+				stream->name);
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	s_rt = sdw_alloc_slave_rt(slave, stream_config, stream);
+	if (!s_rt) {
+		dev_err(&slave->dev,
+				"Slave runtime config failed for stream:%s",
+				stream->name);
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	ret = sdw_config_stream(&slave->dev, stream, stream_config);
+	if (ret)
+		goto error;
+
+	list_add_tail(&s_rt->m_rt_node, &m_rt->slave_rt_list);
+
+	stream->state = SDW_STREAM_CONFIG;
+
+error:
+	mutex_unlock(&slave->bus->bus_lock);
+	return ret;
+}
+EXPORT_SYMBOL(sdw_stream_add_slave);
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index e91fdcf41049..cb006cfd1e31 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -61,6 +61,33 @@ enum sdw_command_response {
 	SDW_CMD_FAIL_OTHER = 4,
 };
 
+/**
+ * enum sdw_stream_type: data stream type
+ *
+ * @SDW_STREAM_PCM: PCM data stream
+ * @SDW_STREAM_PDM: PDM data stream
+ *
+ * spec doesn't define this, but is used in implementation
+ */
+enum sdw_stream_type {
+	SDW_STREAM_PCM = 0,
+	SDW_STREAM_PDM = 1,
+};
+
+/**
+ * enum sdw_data_direction: Data direction
+ *
+ * @SDW_DATA_DIR_IN: Data into Port
+ * @SDW_DATA_DIR_OUT: Data out of Port
+ *
+ * For TX it would refer to SDW_DATA_DIR_OUT. For RX it would be
+ * SDW_DATA_DIR_IN
+ */
+enum sdw_data_direction {
+	SDW_DATA_DIR_IN = 0,
+	SDW_DATA_DIR_OUT = 1,
+};
+
 /*
  * SDW properties, defined in MIPI DisCo spec v1.0
  */
@@ -450,6 +477,9 @@ struct sdw_master_ops {
  * @msg_lock: message lock
  * @ops: Master callback ops
  * @prop: Master properties
+ * @m_rt_list: List of Master instance of all stream(s) running on Bus. This
+ * is used to compute and program bus bandwidth, clock, frame shape,
+ * transport and port parameters
  * @defer_msg: Defer message
  * @clk_stop_timeout: Clock stop timeout computed
  */
@@ -462,6 +492,7 @@ struct sdw_bus {
 	struct mutex msg_lock;
 	const struct sdw_master_ops *ops;
 	struct sdw_master_prop prop;
+	struct list_head m_rt_list;
 	struct sdw_defer defer_msg;
 	unsigned int clk_stop_timeout;
 };
@@ -469,6 +500,87 @@ struct sdw_bus {
 int sdw_add_bus_master(struct sdw_bus *bus);
 void sdw_delete_bus_master(struct sdw_bus *bus);
 
+/**
+ * sdw_stream_config: Master or Slave stream configuration
+ *
+ * @frame_rate: Audio frame rate of the stream, in Hz
+ * @ch_count: Channel count of the stream
+ * @bps: Number of bits per audio sample
+ * @direction: Data direction
+ * @type: Stream type PCM or PDM
+ */
+struct sdw_stream_config {
+	unsigned int frame_rate;
+	unsigned int ch_count;
+	unsigned int bps;
+	enum sdw_data_direction direction;
+	enum sdw_stream_type type;
+};
+
+/**
+ * sdw_stream_state: Stream states
+ *
+ * @SDW_STREAM_RELEASE: Stream released
+ * @SDW_STREAM_ALLOC: New stream allocated.
+ * @SDW_STREAM_CONFIG: Stream configured
+ * @SDW_STREAM_PREPARE: Stream prepared
+ * @SDW_STREAM_ENABLE: Stream enabled
+ * @SDW_STREAM_DISABLE: Stream disabled
+ * @SDW_STREAM_DEPREPARE: Stream de-prepared
+ */
+enum sdw_stream_state {
+	SDW_STREAM_RELEASE = 0,
+	SDW_STREAM_ALLOC = 1,
+	SDW_STREAM_CONFIG = 2,
+	SDW_STREAM_PREPARE = 3,
+	SDW_STREAM_ENABLE = 4,
+	SDW_STREAM_DISABLE = 5,
+	SDW_STREAM_DEPREPARE = 6,
+};
+
+/**
+ * sdw_stream_params: Stream parameters
+ *
+ * @rate: Sampling frequency, in Hz
+ * @ch_count: Number of channels
+ * @bps: bits per channel sample
+ */
+struct sdw_stream_params {
+	unsigned int rate;
+	unsigned int ch_count;
+	unsigned int bps;
+};
+
+/**
+ * sdw_stream_runtime: Runtime stream parameters
+ *
+ * @name: SoundWire stream name
+ * @params: Stream parameters
+ * @state: Current state of the stream
+ * @type: Stream type PCM or PDM
+ * @m_rt: Master runtime
+ */
+struct sdw_stream_runtime {
+	char *name;
+	struct sdw_stream_params params;
+	enum sdw_stream_state state;
+	enum sdw_stream_type type;
+	struct sdw_master_runtime *m_rt;
+};
+
+struct sdw_stream_runtime *sdw_alloc_stream(char *stream_name);
+void sdw_release_stream(struct sdw_stream_runtime *stream);
+int sdw_stream_add_master(struct sdw_bus *bus,
+		struct sdw_stream_config *stream_config,
+		struct sdw_stream_runtime *stream);
+int sdw_stream_add_slave(struct sdw_slave *slave,
+		struct sdw_stream_config *stream_config,
+		struct sdw_stream_runtime *stream);
+int sdw_stream_remove_master(struct sdw_bus *bus,
+		struct sdw_stream_runtime *stream);
+int sdw_stream_remove_slave(struct sdw_slave *slave,
+		struct sdw_stream_runtime *stream);
+
 /* messaging and data APIs */
 
 int sdw_read(struct sdw_slave *slave, u32 addr);
-- 
2.7.4
