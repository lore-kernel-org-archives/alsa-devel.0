From: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v6 03/13] soundwire: Add support for port
	management
Date: Thu, 26 Apr 2018 18:49:59 +0530
Message-ID: <1524748809-21860-4-git-send-email-vkoul@kernel.org>
References: <1524748809-21860-1-git-send-email-vkoul@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 60DF4267860
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 15:15:43 +0200 (CEST)
In-Reply-To: <1524748809-21860-1-git-send-email-vkoul@kernel.org>
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
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Vinod Koul <vkoul@kernel.org>, broonie@kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Sanyog Kale <sanyog.r.kale@intel.com>

Add Soundwire port data structures and APIS for initialization
and release of ports.

Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soundwire/bus.h       |  25 ++++++++
 drivers/soundwire/stream.c    | 144 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/soundwire/sdw.h |  67 ++++++++++++++++++++
 3 files changed, 234 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 2e5043de9a4b..39e6811e435c 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -46,6 +46,27 @@ struct sdw_msg {
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
@@ -53,12 +74,14 @@ struct sdw_msg {
  * @ch_count: Number of channels handled by the Slave for
  * this stream
  * @m_rt_node: sdw_master_runtime list node
+ * @port_list: List of Slave Ports configured for this stream
  */
 struct sdw_slave_runtime {
 	struct sdw_slave *slave;
 	enum sdw_data_direction direction;
 	unsigned int ch_count;
 	struct list_head m_rt_node;
+	struct list_head port_list;
 };
 
 /**
@@ -70,6 +93,7 @@ struct sdw_slave_runtime {
  * @ch_count: Number of channels handled by the Master for
  * this stream, can be zero.
  * @slave_rt_list: Slave runtime list
+ * @port_list: List of Master Ports configured for this stream, can be zero.
  * @bus_node: sdw_bus m_rt_list node
  */
 struct sdw_master_runtime {
@@ -78,6 +102,7 @@ struct sdw_master_runtime {
 	enum sdw_data_direction direction;
 	unsigned int ch_count;
 	struct list_head slave_rt_list;
+	struct list_head port_list;
 	struct list_head bus_node;
 };
 
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 89b2550ea453..289342340262 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -81,6 +81,7 @@ static struct sdw_master_runtime
 		return NULL;
 
 	/* Initialization of Master runtime handle */
+	INIT_LIST_HEAD(&m_rt->port_list);
 	INIT_LIST_HEAD(&m_rt->slave_rt_list);
 	stream->m_rt = m_rt;
 
@@ -115,6 +116,7 @@ static struct sdw_slave_runtime
 	if (!s_rt)
 		return NULL;
 
+	INIT_LIST_HEAD(&s_rt->port_list);
 	s_rt->ch_count = stream_config->ch_count;
 	s_rt->direction = stream_config->direction;
 	s_rt->slave = slave;
@@ -122,6 +124,38 @@ static struct sdw_slave_runtime
 	return s_rt;
 }
 
+static void sdw_master_port_release(struct sdw_bus *bus,
+			struct sdw_master_runtime *m_rt)
+{
+	struct sdw_port_runtime *p_rt, *_p_rt;
+
+	list_for_each_entry_safe(p_rt, _p_rt,
+			&m_rt->port_list, port_node) {
+		list_del(&p_rt->port_node);
+		kfree(p_rt);
+	}
+}
+
+static void sdw_slave_port_release(struct sdw_bus *bus,
+			struct sdw_slave *slave,
+			struct sdw_stream_runtime *stream)
+{
+	struct sdw_port_runtime *p_rt, *_p_rt;
+	struct sdw_master_runtime *m_rt = stream->m_rt;
+	struct sdw_slave_runtime *s_rt;
+
+	list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
+		if (s_rt->slave != slave)
+			continue;
+
+		list_for_each_entry_safe(p_rt, _p_rt,
+				&s_rt->port_list, port_node) {
+			list_del(&p_rt->port_node);
+			kfree(p_rt);
+		}
+	}
+}
+
 /**
  * sdw_release_slave_stream() - Free Slave(s) runtime handle
  *
@@ -176,7 +210,7 @@ static void sdw_release_master_stream(struct sdw_stream_runtime *stream)
  * @bus: SDW Bus instance
  * @stream: SoundWire stream
  *
- * This removes and frees master_rt from a stream
+ * This removes and frees port_rt and master_rt from a stream
  */
 int sdw_stream_remove_master(struct sdw_bus *bus,
 		struct sdw_stream_runtime *stream)
@@ -184,6 +218,7 @@ int sdw_stream_remove_master(struct sdw_bus *bus,
 	mutex_lock(&bus->bus_lock);
 
 	sdw_release_master_stream(stream);
+	sdw_master_port_release(bus, stream->m_rt);
 	stream->state = SDW_STREAM_RELEASED;
 	kfree(stream->m_rt);
 	stream->m_rt = NULL;
@@ -200,13 +235,14 @@ EXPORT_SYMBOL(sdw_stream_remove_master);
  * @slave: SDW Slave instance
  * @stream: SoundWire stream
  *
- * This removes and frees slave_rt from a stream
+ * This removes and frees port_rt and slave_rt from a stream
  */
 int sdw_stream_remove_slave(struct sdw_slave *slave,
 		struct sdw_stream_runtime *stream)
 {
 	mutex_lock(&slave->bus->bus_lock);
 
+	sdw_slave_port_release(slave->bus, slave, stream);
 	sdw_release_slave_stream(slave, stream);
 
 	mutex_unlock(&slave->bus->bus_lock);
@@ -260,15 +296,107 @@ static int sdw_config_stream(struct device *dev,
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
+}
+
+static int sdw_master_port_config(struct sdw_bus *bus,
+			struct sdw_master_runtime *m_rt,
+			struct sdw_port_config *port_config,
+			unsigned int num_ports)
+{
+	struct sdw_port_runtime *p_rt;
+	int i;
+
+	/* Iterate for number of ports to perform initialization */
+	for (i = 0; i < num_ports; i++) {
+		p_rt = sdw_port_alloc(bus->dev, port_config, i);
+		if (!p_rt)
+			return -ENOMEM;
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
+		p_rt = sdw_port_alloc(&slave->dev, port_config, i);
+		if (!p_rt)
+			return -ENOMEM;
+
+		/*
+		 * TODO: Check valid port range as defined by DisCo/
+		 * slave
+		 */
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
  * sdw_stream_add_master() - Allocate and add master runtime to a stream
  *
  * @bus: SDW Bus instance
  * @stream_config: Stream configuration for audio stream
+ * @port_config: Port configuration for audio stream
+ * @num_ports: Number of ports
  * @stream: SoundWire stream
  */
 int sdw_stream_add_master(struct sdw_bus *bus,
 		struct sdw_stream_config *stream_config,
+		struct sdw_port_config *port_config,
+		unsigned int num_ports,
 		struct sdw_stream_runtime *stream)
 {
 	struct sdw_master_runtime *m_rt = NULL;
@@ -289,6 +417,10 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 	if (ret)
 		goto stream_error;
 
+	ret = sdw_master_port_config(bus, m_rt, port_config, num_ports);
+	if (ret)
+		goto stream_error;
+
 	stream->state = SDW_STREAM_CONFIGURED;
 
 stream_error:
@@ -305,9 +437,13 @@ EXPORT_SYMBOL(sdw_stream_add_master);
  * @slave: SDW Slave instance
  * @stream_config: Stream configuration for audio stream
  * @stream: SoundWire stream
+ * @port_config: Port configuration for audio stream
+ * @num_ports: Number of ports
  */
 int sdw_stream_add_slave(struct sdw_slave *slave,
 		struct sdw_stream_config *stream_config,
+		struct sdw_port_config *port_config,
+		unsigned int num_ports,
 		struct sdw_stream_runtime *stream)
 {
 	struct sdw_slave_runtime *s_rt;
@@ -344,6 +480,10 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 
 	list_add_tail(&s_rt->m_rt_node, &m_rt->slave_rt_list);
 
+	ret = sdw_slave_port_config(slave, s_rt, port_config, num_ports);
+	if (ret)
+		goto stream_error;
+
 	stream->state = SDW_STREAM_CONFIGURED;
 	goto error;
 
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 610a98da103e..5e06a0de508c 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -26,6 +26,8 @@ struct sdw_slave;
 
 #define SDW_MAX_DEVICES			11
 
+#define SDW_VALID_PORT_RANGE(n)		(n <= 14 && n >= 1)
+
 /**
  * enum sdw_slave_status - Slave status
  * @SDW_SLAVE_UNATTACHED: Slave is not attached with the bus.
@@ -430,6 +432,56 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
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
@@ -498,6 +550,17 @@ int sdw_add_bus_master(struct sdw_bus *bus);
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
@@ -569,9 +632,13 @@ struct sdw_stream_runtime *sdw_alloc_stream(char *stream_name);
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
