From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 03/13] soundwire: Add support for port
	management
Date: Wed, 28 Mar 2018 15:08:28 +0530
Message-ID: <1522229918-4748-4-git-send-email-vinod.koul@intel.com>
References: <1522229918-4748-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id C6165266F93
 for <alsa-devel@alsa-project.org>; Wed, 28 Mar 2018 11:34:36 +0200 (CEST)
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
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Add Soundwire port data structures and APIS for initialization
and release of ports.

Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/soundwire/bus.h       |  32 +++++++++
 drivers/soundwire/stream.c    | 163 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/soundwire/sdw.h |  67 +++++++++++++++++
 3 files changed, 259 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 0f55a18fa652..b28a0c224323 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -46,18 +46,45 @@ struct sdw_msg {
 };
 
 /**
+ * sdw_port_runtime: Runtime port parameters for Master or Slave
+ *
+ * @num: Port number. For audio streams, valid port number ranges from
+ * [1,14]
+ * @ch_mask: Channel mask
+ * @transport_params: Transport parameters
+ * @port_params: Port parameters
+ * @port_node: List node for Master or Slave port_list
+ *
+ * SoundWire spec has no mention of ports for Master interface but the
+ * concept is logically extended.
+ */
+struct sdw_port_runtime {
+	int num;
+	int ch_mask;
+	struct sdw_transport_params transport_params;
+	struct sdw_port_params port_params;
+	struct list_head port_node;
+};
+
+/**
  * sdw_slave_runtime: Runtime Stream parameters for Slave
  *
  * @slave: Slave handle
  * @direction: Data direction w.r.t Slave
  * @ch_count: Channel count of the Slave w.r.t stream
  * @m_rt_node: sdw_master_runtime list node
+ * @port_list: List of Slave Ports for this Stream. This list is
+ * used for computing and programming transport parameters, port
+ * parameters, prepare, enable, disable and de-prepare of Slave port
+ * maintains list of Slave runtime associated with Master runtime for
+ * this stream
  */
 struct sdw_slave_runtime {
 	struct sdw_slave *slave;
 	enum sdw_data_direction direction;
 	unsigned int ch_count;
 	struct list_head m_rt_node;
+	struct list_head port_list;
 };
 
 /**
@@ -67,6 +94,10 @@ struct sdw_slave_runtime {
  * @stream: Stream runtime handle
  * @ch_count: Master channel count
  * @slave_rt_list: Slave runtime list
+ * @port_list: List of Master Ports for this Stream. This list is
+ * used for computing and programming transport parameters, port
+ * parameters of Master port
+ * @slave_list: Slave runtime list
  * @bus_node: sdw_bus m_rt_list node
  */
 struct sdw_master_runtime {
@@ -74,6 +105,7 @@ struct sdw_master_runtime {
 	struct sdw_stream_runtime *stream;
 	unsigned int ch_count;
 	struct list_head slave_rt_list;
+	struct list_head port_list;
 	struct list_head bus_node;
 };
 
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 00b9fcea4369..95ad714b9c76 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -75,6 +75,7 @@ static struct sdw_master_runtime
 		return NULL;
 
 	/* Initialization of Master runtime handle */
+	INIT_LIST_HEAD(&m_rt->port_list);
 	INIT_LIST_HEAD(&m_rt->slave_rt_list);
 	stream->m_rt = m_rt;
 
@@ -108,6 +109,7 @@ static struct sdw_slave_runtime
 	if (!s_rt)
 		return NULL;
 
+	INIT_LIST_HEAD(&s_rt->port_list);
 
 	s_rt->ch_count = stream_config->ch_count;
 	s_rt->direction = stream_config->direction;
@@ -116,6 +118,41 @@ static struct sdw_slave_runtime
 	return s_rt;
 }
 
+static void sdw_master_port_deconfig(struct sdw_bus *bus,
+			struct sdw_master_runtime *m_rt)
+{
+	struct sdw_port_runtime *p_rt, *_p_rt;
+
+	list_for_each_entry_safe(p_rt, _p_rt,
+			&m_rt->port_list, port_node) {
+
+		list_del(&p_rt->port_node);
+		kfree(p_rt);
+	}
+}
+
+static void sdw_slave_port_deconfig(struct sdw_bus *bus,
+		struct sdw_slave *slave,
+		struct sdw_stream_runtime *stream)
+{
+	struct sdw_port_runtime *p_rt, *_p_rt;
+	struct sdw_master_runtime *m_rt = stream->m_rt;
+	struct sdw_slave_runtime *s_rt;
+
+	list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
+
+		if (s_rt->slave != slave)
+			continue;
+
+		list_for_each_entry_safe(p_rt, _p_rt,
+				&s_rt->port_list, port_node) {
+
+			list_del(&p_rt->port_node);
+			kfree(p_rt);
+		}
+	}
+}
+
 /**
  * sdw_release_slave_stream: Free Slave(s) runtime handle
  *
@@ -160,7 +197,7 @@ static void sdw_release_master_stream(struct sdw_stream_runtime *stream)
  * @bus: SDW Bus instance
  * @stream: Soundwire stream
  *
- * This removes and frees master_rt from a stream
+ * This removes and frees port_rt and master_rt from a stream
  */
 
 int sdw_stream_remove_master(struct sdw_bus *bus,
@@ -169,6 +206,7 @@ int sdw_stream_remove_master(struct sdw_bus *bus,
 	mutex_lock(&bus->bus_lock);
 
 	sdw_release_master_stream(stream);
+	sdw_master_port_deconfig(bus, stream->m_rt);
 	stream->state = SDW_STREAM_RELEASE;
 	kfree(stream->m_rt);
 	stream->m_rt = NULL;
@@ -185,7 +223,7 @@ EXPORT_SYMBOL(sdw_stream_remove_master);
  * @slave: SDW Slave instance
  * @stream: Soundwire stream
  *
- * This removes and frees slave_rt from a stream
+ * This removes and frees port_rt and slave_rt from a stream
  */
 
 int sdw_stream_remove_slave(struct sdw_slave *slave,
@@ -193,6 +231,7 @@ int sdw_stream_remove_slave(struct sdw_slave *slave,
 {
 	mutex_lock(&slave->bus->bus_lock);
 
+	sdw_slave_port_deconfig(slave->bus, slave, stream);
 	sdw_release_slave_stream(slave, stream);
 
 	mutex_unlock(&slave->bus->bus_lock);
@@ -233,15 +272,113 @@ static int sdw_config_stream(struct device *dev,
 	return 0;
 }
 
+static int sdw_is_valid_port_range(struct device *dev,
+				struct sdw_port_runtime *p_rt)
+{
+	if (!SDW_VALID_PORT_RANGE(p_rt->num)) {
+		dev_err(dev,
+			"SoundWire: Invalid port number :%d", p_rt->num);
+		return -EINVAL;
+	}
+
+	return 0;
+
+}
+
+static struct sdw_port_runtime *sdw_port_alloc(struct device *dev,
+				struct sdw_port_config *port_config,
+				int port_index)
+{
+	struct sdw_port_runtime *p_rt;
+
+	p_rt = kzalloc(sizeof(*p_rt), GFP_KERNEL);
+	if (!p_rt)
+		return NULL;
+
+	p_rt->ch_mask = port_config[port_index].ch_mask;
+	p_rt->num = port_config[port_index].num;
+
+	return p_rt;
+
+}
+
+static int sdw_master_port_config(struct sdw_bus *bus,
+			struct sdw_master_runtime *m_rt,
+			struct sdw_port_config *port_config,
+			unsigned int num_ports)
+{
+	struct sdw_port_runtime *p_rt;
+	int i, ret;
+
+	/* Iterate for number of ports to perform initialization */
+	for (i = 0; i < num_ports; i++) {
+
+		p_rt = sdw_port_alloc(bus->dev, port_config, i);
+		if (!p_rt)
+			return -ENOMEM;
+
+		ret = sdw_is_valid_port_range(bus->dev, p_rt);
+		if (ret < 0) {
+			kfree(p_rt);
+			return ret;
+		}
+
+		/*
+		 * TODO: Check port capabilities for requested
+		 * configuration (audio mode support)
+		 */
+
+		list_add_tail(&p_rt->port_node, &m_rt->port_list);
+	}
+
+	return 0;
+}
+
+static int sdw_slave_port_config(struct sdw_slave *slave,
+			struct sdw_slave_runtime *s_rt,
+			struct sdw_port_config *port_config,
+			unsigned int num_config)
+{
+	struct sdw_port_runtime *p_rt;
+	int i, ret;
+
+	/* Iterate for number of ports to perform initialization */
+	for (i = 0; i < num_config; i++) {
+
+		p_rt = sdw_port_alloc(&slave->dev, port_config, i);
+		if (!p_rt)
+			return -ENOMEM;
+
+		ret = sdw_is_valid_port_range(&slave->dev, p_rt);
+		if (ret < 0) {
+			kfree(p_rt);
+			return ret;
+		}
+
+		/*
+		 * TODO: Check port capabilities for requested
+		 * configuration (audio mode support)
+		 */
+
+		list_add_tail(&p_rt->port_node, &s_rt->port_list);
+	}
+
+	return 0;
+}
+
 /**
  * sdw_stream_add_master: Allocate and add master runtime to a stream
  *
  * @bus: SDW Bus instance
  * @stream_config: Stream configuration for audio stream
+ * @port_config: Port configuration for audio stream
+ * @num_ports: Number of ports
  * @stream: Soundwire stream
  */
 int sdw_stream_add_master(struct sdw_bus *bus,
 		struct sdw_stream_config *stream_config,
+		struct sdw_port_config *port_config,
+		unsigned int num_ports,
 		struct sdw_stream_runtime *stream)
 {
 	struct sdw_master_runtime *m_rt = NULL;
@@ -265,10 +402,19 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 		goto error;
 	}
 
+	ret = sdw_master_port_config(bus, m_rt, port_config, num_ports);
+	if (ret)
+		goto port_error;
+
 	if (!list_empty(&m_rt->slave_rt_list) &&
 			stream->state == SDW_STREAM_ALLOC)
 		stream->state = SDW_STREAM_CONFIG;
 
+	goto error;
+
+port_error:
+	sdw_release_master_stream(stream);
+
 error:
 	mutex_unlock(&bus->bus_lock);
 	return ret;
@@ -281,10 +427,14 @@ EXPORT_SYMBOL(sdw_stream_add_master);
  *
  * @slave: SDW Slave instance
  * @stream_config: Stream configuration for audio stream
+ * @port_config: Port configuration for audio stream
+ * @num_ports: Number of ports
  * @stream: Soundwire stream
  */
 int sdw_stream_add_slave(struct sdw_slave *slave,
 		struct sdw_stream_config *stream_config,
+		struct sdw_port_config *port_config,
+		unsigned int num_ports,
 		struct sdw_stream_runtime *stream)
 {
 	struct sdw_slave_runtime *s_rt;
@@ -324,12 +474,19 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 
 	ret = sdw_config_stream(&slave->dev, stream, stream_config);
 	if (ret)
-		goto error;
+		goto port_error;
 
 	list_add_tail(&s_rt->m_rt_node, &m_rt->slave_rt_list);
 
+	ret = sdw_slave_port_config(slave, s_rt, port_config, num_ports);
+	if (ret)
+		goto port_error;
+
 	stream->state = SDW_STREAM_CONFIG;
+	goto error;
 
+port_error:
+	sdw_release_master_stream(stream);
 error:
 	mutex_unlock(&slave->bus->bus_lock);
 	return ret;
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index cb006cfd1e31..a6db8e6dccc9 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -26,6 +26,8 @@ struct sdw_slave;
 
 #define SDW_MAX_DEVICES			11
 
+#define SDW_VALID_PORT_RANGE(n)		(n <= 14 && n >= 1)
+
 /**
  * enum sdw_slave_status - Slave status
  * @SDW_SLAVE_UNATTACHED: Slave is not attached with the bus.
@@ -433,6 +435,56 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
  * SDW master structures and APIs
  */
 
+/**
+ * struct sdw_port_params: Data Port parameters
+ *
+ * @num: Port number
+ * @bps: Word length of the Port
+ * @flow_mode: Port Data flow mode
+ * @data_mode: Test modes or normal mode
+ *
+ * This is used to program the Data Port based on Data Port stream
+ * parameters.
+ */
+struct sdw_port_params {
+	unsigned int num;
+	unsigned int bps;
+	unsigned int flow_mode;
+	unsigned int data_mode;
+};
+
+/**
+ * struct sdw_transport_params: Data Port Transport Parameters
+ *
+ * @blk_grp_ctrl_valid: Port implements block group control
+ * @num: Port number
+ * @blk_grp_ctrl: Block group control value
+ * @sample_interval: Sample interval
+ * @offset1: Blockoffset of the payload data
+ * @offset2: Blockoffset of the payload data
+ * @hstart: Horizontal start of the payload data
+ * @hstop: Horizontal stop of the payload data
+ * @blk_pkg_mode: Block per channel or block per port
+ * @lane_ctrl: Data lane Port uses for Data transfer. Currently only single
+ * data lane is supported in bus
+ *
+ * This is used to program the Data Port based on Data Port transport
+ * parameters. All these parameters are banked and can be modified
+ * during a bank switch without any artifacts in audio stream.
+ */
+struct sdw_transport_params {
+	bool blk_grp_ctrl_valid;
+	unsigned int port_num;
+	unsigned int blk_grp_ctrl;
+	unsigned int sample_interval;
+	unsigned int offset1;
+	unsigned int offset2;
+	unsigned int hstart;
+	unsigned int hstop;
+	unsigned int blk_pkg_mode;
+	unsigned int lane_ctrl;
+};
+
 struct sdw_msg;
 
 /**
@@ -501,6 +553,17 @@ int sdw_add_bus_master(struct sdw_bus *bus);
 void sdw_delete_bus_master(struct sdw_bus *bus);
 
 /**
+ * sdw_port_config: Master or Slave Port configuration
+ *
+ * @num: Port number
+ * @ch_mask: channels mask for port
+ */
+struct sdw_port_config {
+	unsigned int num;
+	unsigned int ch_mask;
+};
+
+/**
  * sdw_stream_config: Master or Slave stream configuration
  *
  * @frame_rate: Audio frame rate of the stream, in Hz
@@ -572,9 +635,13 @@ struct sdw_stream_runtime *sdw_alloc_stream(char *stream_name);
 void sdw_release_stream(struct sdw_stream_runtime *stream);
 int sdw_stream_add_master(struct sdw_bus *bus,
 		struct sdw_stream_config *stream_config,
+		struct sdw_port_config *port_config,
+		unsigned int num_ports,
 		struct sdw_stream_runtime *stream);
 int sdw_stream_add_slave(struct sdw_slave *slave,
 		struct sdw_stream_config *stream_config,
+		struct sdw_port_config *port_config,
+		unsigned int num_ports,
 		struct sdw_stream_runtime *stream);
 int sdw_stream_remove_master(struct sdw_bus *bus,
 		struct sdw_stream_runtime *stream);
-- 
2.7.4
