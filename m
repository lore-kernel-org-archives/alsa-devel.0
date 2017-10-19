From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 06/14] soundwire: Add IO transfer
Date: Thu, 19 Oct 2017 08:33:22 +0530
Message-ID: <1508382211-3154-7-git-send-email-vinod.koul@intel.com>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E75C267571
 for <alsa-devel@alsa-project.org>; Thu, 19 Oct 2017 04:59:43 +0200 (CEST)
In-Reply-To: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

SoundWire bus supports read and write register(s) for SoundWire
Slave device. sdw_read() and sdw_write() APIs are provided for single
register read/write. sdw_nread() and sdw_nwrite() for operations on
contiguous register read/write.

Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/soundwire/bus.c       | 265 ++++++++++++++++++++++++++++++++++++++++++
 drivers/soundwire/bus.h       |  33 ++++++
 include/linux/soundwire/sdw.h |  67 +++++++++++
 3 files changed, 365 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 5b13d96b67b8..9ac22eab11bb 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -73,6 +73,12 @@ int sdw_add_bus_master(struct sdw_bus *bus)
 		return -ENODEV;
 	}
 
+	if (!bus->ops) {
+		dev_err(bus->dev, "SoundWire Bus ops are not set");
+		return -EINVAL;
+	}
+
+	mutex_init(&bus->msg_lock);
 	mutex_init(&bus->bus_lock);
 	INIT_LIST_HEAD(&bus->slaves);
 
@@ -128,6 +134,265 @@ void sdw_delete_bus_master(struct sdw_bus *bus)
 }
 EXPORT_SYMBOL(sdw_delete_bus_master);
 
+/*
+ * SDW IO Calls
+ */
+
+static bool sdw_get_page(struct sdw_slave *slave, struct sdw_msg *msg)
+{
+	bool page = false, paging_support = false;
+
+	if (slave && slave->prop.paging_support)
+		paging_support = true;
+
+	/*
+	 * Programme SCP page addr for:
+	 * 1. addr_page1 and addr_page2 contains non-zero values.
+	 * 2. Paging supported by Slave.
+	 */
+	switch (msg->dev_num) {
+	case SDW_ENUM_DEV_NUM:
+	case SDW_BROADCAST_DEV_NUM:
+		break;
+
+	default:
+		if (paging_support && ((msg->addr_page1) || (msg->addr_page2)))
+			page = true;
+	}
+
+	return page;
+}
+
+static inline int find_error_code(unsigned int sdw_ret)
+{
+	switch (sdw_ret) {
+	case SDW_CMD_OK:
+		return 0;
+
+	case SDW_CMD_IGNORED:
+		return -ENODATA;
+
+	case SDW_CMD_TIMEOUT:
+		return -ETIMEDOUT;
+	}
+
+	return -EIO;
+}
+
+static inline int do_transfer(struct sdw_bus *bus,
+			struct sdw_msg *msg, bool page)
+{
+	int retry = bus->prop.err_threshold;
+	int ret, i;
+
+	for (ret = 0, i = 0; i <= retry; i++) {
+		ret = bus->ops->xfer_msg(bus, msg, page);
+		ret = find_error_code(ret);
+		/* if cmd is ok or ignored return */
+		if (ret == 0 || ret == -ENODATA)
+			return ret;
+	}
+
+	return ret;
+}
+
+static inline int do_transfer_defer(struct sdw_bus *bus,
+			struct sdw_msg *msg, bool page,
+			struct sdw_defer *defer)
+{
+	int retry = bus->prop.err_threshold;
+	int ret, i;
+
+	defer->msg = msg;
+	defer->length = msg->len;
+
+	for (ret = 0, i = 0; i <= retry; i++) {
+
+		ret = bus->ops->xfer_msg_defer(bus, msg, page, defer);
+		ret = find_error_code(ret);
+		/* if cmd is ok or ignored return */
+		if (ret == 0 || ret == -ENODATA)
+			return ret;
+	}
+
+	return ret;
+}
+
+static int sdw_reset_page(struct sdw_bus *bus, u16 dev_num)
+{
+	int retry = bus->prop.err_threshold;
+	int ret, i;
+
+	for (ret = 0, i = 0; i <= retry; i++) {
+		ret = bus->ops->reset_page_addr(bus, dev_num);
+		ret = find_error_code(ret);
+		/* if cmd is ok or ignored return */
+		if (ret == 0 || ret == -ENODATA)
+			return ret;
+	}
+
+	return ret;
+}
+
+/**
+ * sdw_transfer: Synchronous transfer message to a SDW Slave device
+ *
+ * @bus: SDW bus
+ * @slave: SDW Slave
+ * @msg: SDW message to be xfered
+ */
+int sdw_transfer(struct sdw_bus *bus, struct sdw_slave *slave,
+					struct sdw_msg *msg)
+{
+	bool page;
+	int ret;
+
+	mutex_lock(&bus->msg_lock);
+
+	page = sdw_get_page(slave, msg);
+
+	ret = do_transfer(bus, msg, page);
+	if (ret != 0 && ret != -ENODATA) {
+		dev_err(bus->dev, "trf on Slave %d failed:%d\n",
+				msg->dev_num, ret);
+		goto error;
+	}
+
+	if (page)
+		ret = sdw_reset_page(bus, msg->dev_num);
+
+error:
+	mutex_unlock(&bus->msg_lock);
+
+	return ret;
+}
+
+/**
+ * sdw_transfer_defer: Asynchronously transfer message to a SDW Slave device
+ *
+ * @bus: SDW bus
+ * @slave: SDW Slave
+ * @msg: SDW message to be xfered
+ * @defer: Defer block for signal completion
+ *
+ * Caller needs to hold the msg_lock lock while calling this
+ */
+int sdw_transfer_defer(struct sdw_bus *bus, struct sdw_slave *slave,
+			struct sdw_msg *msg, struct sdw_defer *defer)
+{
+	bool page;
+	int ret;
+
+	if (!bus->ops->xfer_msg_defer)
+		return -ENOTSUPP;
+
+	page = sdw_get_page(slave, msg);
+
+	ret = do_transfer_defer(bus, msg, page, defer);
+	if (ret != 0 && ret != -ENODATA)
+		goto error;
+
+	if (page)
+		ret = sdw_reset_page(bus, msg->dev_num);
+
+error:
+	return ret;
+}
+
+static inline int sdw_fill_msg(struct sdw_msg *msg, u16 addr,
+				size_t count, u16 dev_num, u8 flags, u8 *buf)
+{
+	msg->addr = (addr >> SDW_REG_SHIFT(SDW_REGADDR));
+	msg->len = count;
+	msg->dev_num = dev_num;
+	msg->addr_page1 = (addr >> SDW_REG_SHIFT(SDW_SCP_ADDRPAGE1_MASK));
+	msg->addr_page2 = (addr >> SDW_REG_SHIFT(SDW_SCP_ADDRPAGE2_MASK));
+	msg->flags = flags;
+	msg->buf = buf;
+	msg->ssp_sync = false;
+
+	return 0;
+}
+
+/**
+ * sdw_nread: Read "n" contiguous SDW Slave registers
+ *
+ * @slave: SDW Slave
+ * @addr: Register address
+ * @count: length
+ * @val: Buffer for values to be read
+ */
+int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
+{
+	struct sdw_msg msg;
+	int ret;
+
+	pm_runtime_get_sync(slave->bus->dev);
+
+	sdw_fill_msg(&msg, addr, count, slave->dev_num, SDW_MSG_FLAG_READ, val);
+	ret = sdw_transfer(slave->bus, slave, &msg);
+	pm_runtime_put(slave->bus->dev);
+
+	return ret;
+}
+EXPORT_SYMBOL(sdw_nread);
+
+/**
+ * sdw_nwrite: Write "n" contiguous SDW Slave registers
+ *
+ * @slave: SDW Slave
+ * @addr: Register address
+ * @count: length
+ * @val: Buffer for values to be read
+ */
+int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
+{
+	struct sdw_msg msg;
+	int ret;
+
+	pm_runtime_get_sync(slave->bus->dev);
+
+	sdw_fill_msg(&msg, addr, count, slave->dev_num, SDW_MSG_FLAG_WRITE, val);
+	ret = sdw_transfer(slave->bus, slave, &msg);
+	pm_runtime_put(slave->bus->dev);
+
+	return ret;
+}
+EXPORT_SYMBOL(sdw_nwrite);
+
+/**
+ * sdw_read: Read a SDW Slave register
+ *
+ * @slave: SDW Slave
+ * @addr: Register address
+ */
+int sdw_read(struct sdw_slave *slave, u32 addr)
+{
+	u8 buf;
+	int ret;
+
+	ret = sdw_nread(slave, addr, 1, &buf);
+	if (ret < 0)
+		return ret;
+	else
+		return buf;
+}
+EXPORT_SYMBOL(sdw_read);
+
+/**
+ * sdw_write: Write a SDW Slave register
+ *
+ * @slave: SDW Slave
+ * @addr: Register address
+ * @value: Register value
+ */
+int sdw_write(struct sdw_slave *slave, u32 addr, u8 value)
+{
+	return sdw_nwrite(slave, addr, 1, &value);
+
+}
+EXPORT_SYMBOL(sdw_write);
+
 void sdw_extract_slave_id(struct sdw_bus *bus,
 			unsigned long long addr, struct sdw_slave_id *id)
 {
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index f61bc9f59445..bd3b7d230076 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -79,4 +79,37 @@ int sdw_slave_modalias(struct sdw_slave *slave, char *buf, size_t size);
 void sdw_extract_slave_id(struct sdw_bus *bus,
 			unsigned long long addr, struct sdw_slave_id *id);
 
+enum {
+	SDW_MSG_FLAG_READ = 0,
+	SDW_MSG_FLAG_WRITE,
+};
+
+/**
+ * struct sdw_msg: Message structure
+ *
+ * @addr: Register address accessed in the Slave
+ * @len: number of messages
+ * @dev_num: Slave device number
+ * @addr_page1: SCP address page 1 Slave register
+ * @addr_page2: SCP address page 2 Slave register
+ * @flags: transfer flags, indicate if xfer is read or write
+ * @buf: message data buffer
+ * @ssp_sync: Send message at SSP (Stream Synchronization Point)
+ */
+struct sdw_msg {
+	u16 addr;
+	u16 len;
+	u16 dev_num;
+	u8 addr_page1;
+	u8 addr_page2;
+	u8 flags;
+	u8 *buf;
+	bool ssp_sync;
+};
+
+int sdw_transfer(struct sdw_bus *bus, struct sdw_slave *slave,
+			struct sdw_msg *msg);
+int sdw_transfer_defer(struct sdw_bus *bus, struct sdw_slave *slave,
+			struct sdw_msg *msg, struct sdw_defer *defer);
+
 #endif /* __SDW_BUS_H */
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index a5bb5e9bc50a..af94c0a29024 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -57,6 +57,14 @@
 struct sdw_bus;
 struct sdw_slave;
 
+/* SDW spec defines and enums, as defined by MIPI 1.1. Spec */
+
+/* SDW Broadcast addr */
+#define SDW_BROADCAST_DEV_NUM		15
+
+/* SDW Enumeration Device Number */
+#define SDW_ENUM_DEV_NUM		0
+
 #define SDW_MAX_DEVICES			11
 
 /**
@@ -74,6 +82,28 @@ enum sdw_slave_status {
 	SDW_SLAVE_RESERVED = 3,
 };
 
+/**
+ * enum sdw_command_response: Command response as defined by SDW spec
+ *
+ * @SDW_CMD_OK: cmd was successful
+ * @SDW_CMD_IGNORED: cmd was ignored
+ * @SDW_CMD_FAIL: cmd was NACKed
+ * @SDW_CMD_TIMEOUT: cmd timedout
+ * @SDW_CMD_FAIL_OTHER: cmd failed due to other reason than above
+ *
+ * NOTE: The enum is different than actual Spec as response in the Spec is
+ * combination of ACK/NAK bits
+ *
+ * SDW_CMD_TIMEOUT/FAIL_OTHER is defined for SW use, not in spec
+ */
+enum sdw_command_response {
+	SDW_CMD_OK = 0,
+	SDW_CMD_IGNORED = 1,
+	SDW_CMD_FAIL = 2,
+	SDW_CMD_TIMEOUT = 4,
+	SDW_CMD_FAIL_OTHER = 8,
+};
+
 /*
  * SDW properties, defined in MIPI DisCo spec v1.0
  */
@@ -422,13 +452,39 @@ void sdw_unregister_driver(struct sdw_driver *drv);
  * SDW master structures and APIs
  */
 
+struct sdw_msg;
+
+/**
+ * struct sdw_defer: SDW deffered message
+ *
+ * @length: message length
+ * @complete: message completion
+ * @msg: SDW message
+ */
+struct sdw_defer {
+	int length;
+	struct completion complete;
+	struct sdw_msg *msg;
+};
+
 /**
  * struct sdw_master_ops: Master driver ops
  *
  * @read_prop: Read Master properties
+ * @xfer_msg: Transfer message callback
+ * @xfer_msg_defer: Defer version of transfer message callback
+ * @reset_page_addr: Reset the SCP page address registers
  */
 struct sdw_master_ops {
 	int (*read_prop)(struct sdw_bus *bus);
+
+	enum sdw_command_response (*xfer_msg)
+			(struct sdw_bus *bus, struct sdw_msg *msg, int page);
+	enum sdw_command_response (*xfer_msg_defer)
+			(struct sdw_bus *bus, struct sdw_msg *msg,
+			int page, struct sdw_defer *defer);
+	enum sdw_command_response (*reset_page_addr)
+			(struct sdw_bus *bus, unsigned int dev_num);
 };
 
 /**
@@ -439,8 +495,10 @@ struct sdw_master_ops {
  * @slaves: list of Slaves on this bus
  * @assigned: logical addresses assigned, Index 0 (broadcast) would be unused
  * @bus_lock: bus lock
+ * @msg_lock: message lock
  * @ops: Master callback ops
  * @prop: Master properties
+ * @defer_msg: Defer message
  * @clk_stop_timeout: Clock stop timeout computed
  */
 struct sdw_bus {
@@ -449,12 +507,21 @@ struct sdw_bus {
 	struct list_head slaves;
 	bool assigned[SDW_MAX_DEVICES + 1];
 	struct mutex bus_lock;
+	struct mutex msg_lock;
 	const struct sdw_master_ops *ops;
 	struct sdw_master_prop prop;
+	struct sdw_defer defer_msg;
 	unsigned int clk_stop_timeout;
 };
 
 int sdw_add_bus_master(struct sdw_bus *bus);
 void sdw_delete_bus_master(struct sdw_bus *bus);
 
+/* messaging and data APIs */
+
+int sdw_read(struct sdw_slave *slave, u32 addr);
+int sdw_write(struct sdw_slave *slave, u32 addr, u8 value);
+int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val);
+int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, u8 *val);
+
 #endif /* __SOUNDWIRE_H */
-- 
2.7.4
