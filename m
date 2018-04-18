From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v4 06/13] soundwire: Add bank switch routine
Date: Wed, 18 Apr 2018 16:28:59 +0530
Message-ID: <1524049146-8725-7-git-send-email-vinod.koul@intel.com>
References: <1524049146-8725-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CFB0267688
 for <alsa-devel@alsa-project.org>; Wed, 18 Apr 2018 12:54:53 +0200 (CEST)
In-Reply-To: <1524049146-8725-1-git-send-email-vinod.koul@intel.com>
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

SoundWire supports two registers banks. So, program the alternate bank
with new configuration and then performs bank switch.

Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/soundwire/bus.c       |   7 ++
 drivers/soundwire/bus.h       |   5 ++
 drivers/soundwire/stream.c    | 202 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/soundwire/sdw.h |  48 ++++++++++
 4 files changed, 262 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index b8c93f0ac0a0..084bf71b2b87 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -78,6 +78,13 @@ int sdw_add_bus_master(struct sdw_bus *bus)
 		return ret;
 	}
 
+	/*
+	 * Default active bank will be 0 as out of reset the Slaves have
+	 * to start with bank 0 (Table 40 of Spec)
+	 */
+	bus->params.curr_bank = SDW_BANK0;
+	bus->params.next_bank = SDW_BANK1;
+
 	return 0;
 }
 EXPORT_SYMBOL(sdw_add_bus_master);
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 07da6c4b10c4..3b15c4e25a3a 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -45,6 +45,11 @@ struct sdw_msg {
 	bool page;
 };
 
+#define SDW_DOUBLE_RATE_FACTOR		2
+
+extern int rows[SDW_FRAME_ROWS];
+extern int cols[SDW_FRAME_COLS];
+
 /**
  * sdw_port_runtime: Runtime port parameters for Master or Slave
  *
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 1b00b58f8372..c1bfceee5b73 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -15,6 +15,43 @@
 #include <linux/soundwire/sdw.h>
 #include "bus.h"
 
+/*
+ * Array of supported rows and columns as per MIPI SoundWire Specification 1.1
+ *
+ * The rows are arranged as per the array index value programmed
+ * in register. The index 15 has dummy value 0 in order to fill hole.
+ */
+int rows[SDW_FRAME_ROWS] = {48, 50, 60, 64, 75, 80, 125, 147,
+			96, 100, 120, 128, 150, 160, 250, 0,
+			192, 200, 240, 256, 72, 144, 90, 180};
+
+int cols[SDW_FRAME_COLS] = {2, 4, 6, 8, 10, 12, 14, 16};
+
+static int sdw_find_col_index(int col)
+{
+	int i;
+
+	for (i = 0; i < SDW_FRAME_COLS; i++) {
+		if (cols[i] == col)
+			return i;
+	}
+
+	pr_warn("Requested column not found, selecting lowest column no: 2\n");
+	return 0;
+}
+
+static int sdw_find_row_index(int row)
+{
+	int i;
+
+	for (i = 0; i < SDW_FRAME_ROWS; i++) {
+		if (rows[i] == row)
+			return i;
+	}
+
+	pr_warn("Requested row not found, selecting lowest row no: 48\n");
+	return 0;
+}
 static int _sdw_program_slave_port_params(struct sdw_bus *bus,
 				struct sdw_slave *slave,
 				struct sdw_transport_params *t_params,
@@ -506,6 +543,171 @@ static int sdw_prep_deprep_ports(struct sdw_master_runtime *m_rt, bool prep)
 }
 
 /**
+ * sdw_notify_config() - Notify bus configuration
+ *
+ * @m_rt: Master runtime handle
+ *
+ * This function notifies the Master(s) and Slave(s) of the
+ * new bus configuration.
+ */
+static int sdw_notify_config(struct sdw_master_runtime *m_rt)
+{
+	struct sdw_slave_runtime *s_rt;
+	struct sdw_bus *bus = m_rt->bus;
+	struct sdw_slave *slave;
+	int ret = 0;
+
+	if (bus->ops->set_bus_conf) {
+		ret = bus->ops->set_bus_conf(bus, &bus->params);
+		if (ret < 0)
+			return ret;
+	}
+
+	list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
+		slave = s_rt->slave;
+
+		if (slave->ops->bus_config) {
+			ret = slave->ops->bus_config(slave, &bus->params);
+			if (ret < 0)
+				dev_err(bus->dev, "Notify Slave: %d failed",
+								slave->dev_num);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+/**
+ * sdw_program_params() - Program transport and port parameters for Master(s)
+ * and Slave(s)
+ *
+ * @bus: SDW bus instance
+ */
+static int sdw_program_params(struct sdw_bus *bus)
+{
+	struct sdw_master_runtime *m_rt = NULL;
+	int ret = 0;
+
+	list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
+		ret = sdw_program_port_params(m_rt);
+		if (ret < 0) {
+			dev_err(bus->dev,
+				"Program transport params failed: %d", ret);
+			return ret;
+		}
+
+		ret = sdw_notify_config(m_rt);
+		if (ret < 0) {
+			dev_err(bus->dev, "Notify bus config failed: %d", ret);
+			return ret;
+		}
+
+		/* Enable port(s) on alternate bank for all active streams */
+		if (m_rt->stream->state != SDW_STREAM_ENABLED)
+			continue;
+
+		ret = sdw_enable_disable_ports(m_rt, true);
+		if (ret < 0) {
+			dev_err(bus->dev, "Enable channel failed: %d", ret);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int sdw_bank_switch(struct sdw_bus *bus)
+{
+	int col_index, row_index;
+	struct sdw_msg *wr_msg;
+	u8 *wbuf = NULL;
+	int ret = 0;
+	u16 addr;
+
+	wr_msg = kzalloc(sizeof(*wr_msg), GFP_KERNEL);
+	if (!wr_msg)
+		return -ENOMEM;
+
+	wbuf = kzalloc(sizeof(*wbuf), GFP_KERNEL);
+	if (!wbuf) {
+		ret = -ENOMEM;
+		goto error_1;
+	}
+
+	/* Get row and column index to program register */
+	col_index = sdw_find_col_index(bus->params.col);
+	row_index = sdw_find_row_index(bus->params.row);
+	wbuf[0] = col_index | (row_index << 3);
+
+	if (bus->params.next_bank)
+		addr = SDW_SCP_FRAMECTRL_B1;
+	else
+		addr = SDW_SCP_FRAMECTRL_B0;
+
+	sdw_fill_msg(wr_msg, NULL, addr, 1, SDW_BROADCAST_DEV_NUM,
+					SDW_MSG_FLAG_WRITE, wbuf);
+	wr_msg->ssp_sync = true;
+
+	ret = sdw_transfer(bus, wr_msg);
+	if (ret < 0) {
+		dev_err(bus->dev, "Slave frame_ctrl reg write failed");
+		goto error;
+	}
+
+	kfree(wr_msg);
+	kfree(wbuf);
+	bus->defer_msg.msg = NULL;
+	bus->params.curr_bank = !bus->params.curr_bank;
+	bus->params.next_bank = !bus->params.next_bank;
+
+	return 0;
+
+error:
+	kfree(wbuf);
+error_1:
+	kfree(wr_msg);
+	return ret;
+}
+
+static int do_bank_switch(struct sdw_stream_runtime *stream)
+{
+	struct sdw_master_runtime *m_rt = stream->m_rt;
+	const struct sdw_master_ops *ops;
+	struct sdw_bus *bus = m_rt->bus;
+	int ret = 0;
+
+	ops = bus->ops;
+
+	/* Pre-bank switch */
+	if (ops->pre_bank_switch) {
+		ret = ops->pre_bank_switch(bus);
+		if (ret < 0) {
+			dev_err(bus->dev, "Pre bank switch op failed: %d", ret);
+			return ret;
+		}
+	}
+
+	/* Bank switch */
+	ret = sdw_bank_switch(bus);
+	if (ret < 0) {
+		dev_err(bus->dev, "Bank switch failed: %d", ret);
+		return ret;
+	}
+
+	/* Post-bank switch */
+	if (ops->post_bank_switch) {
+		ret = ops->post_bank_switch(bus);
+		if (ret < 0) {
+			dev_err(bus->dev,
+					"Post bank switch op failed: %d", ret);
+		}
+	}
+
+	return ret;
+}
+
+/**
  * sdw_release_stream() - Free the assigned stream runtime
  *
  * @stream: SoundWire stream runtime
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 6b52e6c53c22..ff4b0134897e 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -23,7 +23,17 @@ struct sdw_slave;
 #define SDW_MASTER_DEV_NUM		14
 
 #define SDW_NUM_DEV_ID_REGISTERS	6
+/* frame shape defines */
 
+/*
+ * Note: The maximum row define in SoundWire spec 1.1 is 23. In order to
+ * fill hole with 0, one more dummy entry is added
+ */
+#define SDW_FRAME_ROWS		24
+#define SDW_FRAME_COLS		8
+#define SDW_FRAME_ROW_COLS		(SDW_FRAME_ROWS * SDW_FRAME_COLS)
+
+#define SDW_FRAME_CTRL_BITS		48
 #define SDW_MAX_DEVICES			11
 
 #define SDW_VALID_PORT_RANGE(n)		(n <= 14 && n >= 1)
@@ -377,6 +387,21 @@ enum sdw_reg_bank {
 };
 
 /**
+ * struct sdw_bus_conf: Bus configuration
+ *
+ * @clk_freq: Clock frequency, in Hz
+ * @num_rows: Number of rows in frame
+ * @num_cols: Number of columns in frame
+ * @bank: Next register bank
+ */
+struct sdw_bus_conf {
+	unsigned int clk_freq;
+	unsigned int num_rows;
+	unsigned int num_cols;
+	unsigned int bank;
+};
+
+/**
  * struct sdw_prepare_ch: Prepare/De-prepare Data Port channel
  *
  * @num: Port number
@@ -413,10 +438,20 @@ enum sdw_port_prep_ops {
  * @curr_bank: Current bank in use (BANK0/BANK1)
  * @next_bank: Next bank to use (BANK0/BANK1). next_bank will always be
  * set to !curr_bank
+ * @max_dr_freq: Maximum double rate clock frequency supported, in Hz
+ * @curr_dr_freq: Current double rate clock frequency, in Hz
+ * @bandwidth: Current bandwidth
+ * @col: Active columns
+ * @row: Active rows
  */
 struct sdw_bus_params {
 	enum sdw_reg_bank curr_bank;
 	enum sdw_reg_bank next_bank;
+	unsigned int max_dr_freq;
+	unsigned int curr_dr_freq;
+	unsigned int bandwidth;
+	unsigned int col;
+	unsigned int row;
 };
 
 /**
@@ -426,6 +461,7 @@ struct sdw_bus_params {
  * @interrupt_callback: Device interrupt notification (invoked in thread
  * context)
  * @update_status: Update Slave status
+ * @bus_config: Update the bus config for Slave
  * @port_prep: Prepare the port with parameters
  */
 struct sdw_slave_ops {
@@ -434,6 +470,8 @@ struct sdw_slave_ops {
 			struct sdw_slave_intr_status *status);
 	int (*update_status)(struct sdw_slave *slave,
 			enum sdw_slave_status status);
+	int (*bus_config)(struct sdw_slave *slave,
+			struct sdw_bus_params *params);
 	int (*port_prep)(struct sdw_slave *slave,
 			struct sdw_prepare_ch *prepare_ch,
 			enum sdw_port_prep_ops pre_ops);
@@ -597,6 +635,9 @@ struct sdw_defer {
  * @xfer_msg: Transfer message callback
  * @xfer_msg_defer: Defer version of transfer message callback
  * @reset_page_addr: Reset the SCP page address registers
+ * @set_bus_conf: Set the bus configuration
+ * @pre_bank_switch: Callback for pre bank switch
+ * @post_bank_switch: Callback for post bank switch
  */
 struct sdw_master_ops {
 	int (*read_prop)(struct sdw_bus *bus);
@@ -608,6 +649,11 @@ struct sdw_master_ops {
 			struct sdw_defer *defer);
 	enum sdw_command_response (*reset_page_addr)
 			(struct sdw_bus *bus, unsigned int dev_num);
+	int (*set_bus_conf)(struct sdw_bus *bus,
+			struct sdw_bus_params *params);
+	int (*pre_bank_switch)(struct sdw_bus *bus);
+	int (*post_bank_switch)(struct sdw_bus *bus);
+
 };
 
 /**
@@ -628,6 +674,7 @@ struct sdw_master_ops {
  * transport and port parameters
  * @defer_msg: Defer message
  * @clk_stop_timeout: Clock stop timeout computed
+ * @bank_switch_timeout: Bank switch timeout computed
  */
 struct sdw_bus {
 	struct device *dev;
@@ -643,6 +690,7 @@ struct sdw_bus {
 	struct list_head m_rt_list;
 	struct sdw_defer defer_msg;
 	unsigned int clk_stop_timeout;
+	u32 bank_switch_timeout;
 };
 
 int sdw_add_bus_master(struct sdw_bus *bus);
-- 
2.7.4
