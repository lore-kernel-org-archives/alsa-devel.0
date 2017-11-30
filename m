From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 06/15] soundwire: Add IO transfer
Date: Thu, 30 Nov 2017 15:27:01 +0530
Message-ID: <1512035830-29161-7-git-send-email-vinod.koul@intel.com>
References: <1512035830-29161-1-git-send-email-vinod.koul@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512035830-29161-1-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

SoundWire bus supports read or write register(s) for SoundWire Slave
device. sdw_read() and sdw_write() APIs are provided for single
register read/write. sdw_nread() and sdw_nwrite() for operations on
contiguous registers.

Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/soundwire/bus.c       | 275 ++++++++++++++++++++++++++++++++++++++++++
 drivers/soundwire/bus.h       |  37 ++++++
 include/linux/soundwire/sdw.h |  57 +++++++++
 3 files changed, 369 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index c0db6d6243b3..82796463fd18 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -51,6 +51,8 @@
 
 #include <linux/acpi.h>
 #include <linux/mod_devicetable.h>
+#include <linux/pm_runtime.h>
+#include <linux/soundwire/sdw_registers.h>
 #include <linux/soundwire/sdw.h>
 #include "bus.h"
 
@@ -70,6 +72,12 @@ int sdw_add_bus_master(struct sdw_bus *bus)
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
 
@@ -145,6 +153,273 @@ void sdw_delete_bus_master(struct sdw_bus *bus)
 }
 EXPORT_SYMBOL(sdw_delete_bus_master);
 
+/*
+ * SDW IO Calls
+ */
+
+static inline int find_response_code(enum sdw_command_response resp)
+{
+	switch (resp) {
+	case SDW_CMD_OK:
+		return 0;
+
+	case SDW_CMD_IGNORED:
+		return -ENODATA;
+
+	case SDW_CMD_TIMEOUT:
+		return -ETIMEDOUT;
+
+	default:
+		return -EIO;
+	}
+}
+
+static inline int do_transfer(struct sdw_bus *bus, struct sdw_msg *msg)
+{
+	int retry = bus->prop.err_threshold;
+	enum sdw_command_response resp;
+	int ret = 0, i;
+
+	for (i = 0; i <= retry; i++) {
+		resp = bus->ops->xfer_msg(bus, msg);
+		ret = find_response_code(resp);
+
+		/* if cmd is ok or ignored return */
+		if (ret == 0 || ret == -ENODATA)
+			return ret;
+	}
+
+	return ret;
+}
+
+static inline int do_transfer_defer(struct sdw_bus *bus,
+			struct sdw_msg *msg, struct sdw_defer *defer)
+{
+	int retry = bus->prop.err_threshold;
+	enum sdw_command_response resp;
+	int ret = 0, i;
+
+	defer->msg = msg;
+	defer->length = msg->len;
+
+	for (i = 0; i <= retry; i++) {
+		resp = bus->ops->xfer_msg_defer(bus, msg, defer);
+		ret = find_response_code(resp);
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
+	enum sdw_command_response resp;
+	int ret = 0, i;
+
+	for (i = 0; i <= retry; i++) {
+		resp = bus->ops->reset_page_addr(bus, dev_num);
+		ret = find_response_code(resp);
+		/* if cmd is ok or ignored return */
+		if (ret == 0 || ret == -ENODATA)
+			return ret;
+	}
+
+	return ret;
+}
+
+/**
+ * sdw_transfer() - Synchronous transfer message to a SDW Slave device
+ * @bus: SDW bus
+ * @slave: SDW Slave
+ * @msg: SDW message to be xfered
+ */
+int sdw_transfer(struct sdw_bus *bus,
+		struct sdw_slave *slave, struct sdw_msg *msg)
+{
+	int ret;
+
+	mutex_lock(&bus->msg_lock);
+
+	ret = do_transfer(bus, msg);
+	if (ret != 0 && ret != -ENODATA)
+		dev_err(bus->dev, "trf on Slave %d failed:%d\n",
+				msg->dev_num, ret);
+
+	if (msg->page)
+		sdw_reset_page(bus, msg->dev_num);
+
+	mutex_unlock(&bus->msg_lock);
+
+	return ret;
+}
+
+/**
+ * sdw_transfer_defer() - Asynchronously transfer message to a SDW Slave device
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
+	int ret;
+
+	if (!bus->ops->xfer_msg_defer)
+		return -ENOTSUPP;
+
+	ret = do_transfer_defer(bus, msg, defer);
+	if (ret != 0 && ret != -ENODATA)
+		dev_err(bus->dev, "Defer trf on Slave %d failed:%d\n",
+				msg->dev_num, ret);
+
+	if (msg->page)
+		sdw_reset_page(bus, msg->dev_num);
+
+	return ret;
+}
+
+
+int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
+		u32 addr, size_t count, u16 dev_num, u8 flags, u8 *buf)
+{
+	memset(msg, 0, sizeof(*msg));
+	msg->addr = addr;
+	msg->len = count;
+	msg->dev_num = dev_num;
+	msg->flags = flags;
+	msg->buf = buf;
+	msg->ssp_sync = false;
+	msg->page = false;
+
+	if (addr < SDW_REG_NO_PAGE) { /* no paging area */
+		return 0;
+	} else if (addr >= SDW_REG_MAX) { /* illegal addr */
+		pr_err("SDW: Invalid address %x passed\n", addr);
+		return -EINVAL;
+	}
+
+	if (addr < SDW_REG_OPTIONAL_PAGE) { /* 32k but no page */
+		if (slave && !slave->prop.paging_support)
+			return 0;
+		/* no need for else as that will fall thru to paging */
+	}
+
+	/* paging madatory */
+	if (dev_num == SDW_ENUM_DEV_NUM || dev_num == SDW_BROADCAST_DEV_NUM) {
+		pr_err("SDW: Invalid device for paging :%d\n", dev_num);
+		return -EINVAL;
+	}
+
+	if (!slave) {
+		pr_err("SDW: No slave for paging addr\n");
+		return -EINVAL;
+	} else if (!slave->prop.paging_support) {
+		dev_err(&slave->dev,
+			"address %x needs paging but no support", addr);
+		return -EINVAL;
+	}
+
+	msg->addr_page1 = (addr >> SDW_REG_SHIFT(SDW_SCP_ADDRPAGE1_MASK));
+	msg->addr_page2 = (addr >> SDW_REG_SHIFT(SDW_SCP_ADDRPAGE2_MASK));
+	msg->addr |= BIT(15);
+	msg->page = true;
+
+	return 0;
+}
+
+/**
+ * sdw_nread() - Read "n" contiguous SDW Slave registers
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
+	ret = sdw_fill_msg(&msg, slave, addr, count,
+			slave->dev_num, SDW_MSG_FLAG_READ, val);
+	if (ret < 0)
+		return ret;
+
+	ret = pm_runtime_get_sync(slave->bus->dev);
+	if (!ret)
+		return ret;
+
+	ret = sdw_transfer(slave->bus, slave, &msg);
+	pm_runtime_put(slave->bus->dev);
+
+	return ret;
+}
+EXPORT_SYMBOL(sdw_nread);
+
+/**
+ * sdw_nwrite() - Write "n" contiguous SDW Slave registers
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
+	ret = sdw_fill_msg(&msg, slave, addr, count,
+			slave->dev_num, SDW_MSG_FLAG_WRITE, val);
+	if (ret < 0)
+		return ret;
+
+	ret = pm_runtime_get_sync(slave->bus->dev);
+	if (!ret)
+		return ret;
+
+	ret = sdw_transfer(slave->bus, slave, &msg);
+	pm_runtime_put(slave->bus->dev);
+
+	return ret;
+}
+EXPORT_SYMBOL(sdw_nwrite);
+
+/**
+ * sdw_read() - Read a SDW Slave register
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
+ * sdw_write() - Write a SDW Slave register
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
 			u64 addr, struct sdw_slave_id *id)
 {
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index c7e8d89271a1..baf173441ac2 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -65,4 +65,41 @@ int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size);
 void sdw_extract_slave_id(struct sdw_bus *bus,
 			u64 addr, struct sdw_slave_id *id);
 
+enum {
+	SDW_MSG_FLAG_READ = 0,
+	SDW_MSG_FLAG_WRITE,
+};
+
+/**
+ * struct sdw_msg - Message structure
+ * @addr: Register address accessed in the Slave
+ * @len: number of messages
+ * @dev_num: Slave device number
+ * @addr_page1: SCP address page 1 Slave register
+ * @addr_page2: SCP address page 2 Slave register
+ * @flags: transfer flags, indicate if xfer is read or write
+ * @buf: message data buffer
+ * @ssp_sync: Send message at SSP (Stream Synchronization Point)
+ * @page: address requires paging
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
+	bool page;
+};
+
+int sdw_transfer(struct sdw_bus *bus, struct sdw_slave *slave,
+			struct sdw_msg *msg);
+int sdw_transfer_defer(struct sdw_bus *bus, struct sdw_slave *slave,
+			struct sdw_msg *msg, struct sdw_defer *defer);
+
+int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
+		u32 addr, size_t count, u16 dev_num, u8 flags, u8 *buf);
+
 #endif /* __SDW_BUS_H */
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 06524af644e9..9c6ea5dbe5c8 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -79,6 +79,27 @@ enum sdw_slave_status {
 	SDW_SLAVE_RESERVED = 3,
 };
 
+/**
+ * enum sdw_command_response - Command response as defined by SDW spec
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
@@ -414,12 +435,37 @@ void sdw_unregister_driver(struct sdw_driver *drv);
  * SDW master structures and APIs
  */
 
+struct sdw_msg;
+
+/**
+ * struct sdw_defer - SDW deffered message
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
  * struct sdw_master_ops - Master driver ops
  * @read_prop: Read Master properties
+ * @xfer_msg: Transfer message callback
+ * @xfer_msg_defer: Defer version of transfer message callback
+ * @reset_page_addr: Reset the SCP page address registers
  */
 struct sdw_master_ops {
 	int (*read_prop)(struct sdw_bus *bus);
+
+	enum sdw_command_response (*xfer_msg)
+			(struct sdw_bus *bus, struct sdw_msg *msg);
+	enum sdw_command_response (*xfer_msg_defer)
+			(struct sdw_bus *bus, struct sdw_msg *msg,
+			struct sdw_defer *defer);
+	enum sdw_command_response (*reset_page_addr)
+			(struct sdw_bus *bus, unsigned int dev_num);
 };
 
 /**
@@ -430,8 +476,10 @@ struct sdw_master_ops {
  * @assigned: Bitmap for Slave device numbers.
  * Bit set implies used number, bit clear implies unused number.
  * @bus_lock: bus lock
+ * @msg_lock: message lock
  * @ops: Master callback ops
  * @prop: Master properties
+ * @defer_msg: Defer message
  * @clk_stop_timeout: Clock stop timeout computed
  */
 struct sdw_bus {
@@ -440,12 +488,21 @@ struct sdw_bus {
 	struct list_head slaves;
 	DECLARE_BITMAP(assigned, SDW_MAX_DEVICES);
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
