From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 08/14] soundwire: Add Slave status handling helpers
Date: Fri, 10 Nov 2017 17:19:10 +0530
Message-ID: <1510314556-13002-9-git-send-email-vinod.koul@intel.com>
References: <1510314556-13002-1-git-send-email-vinod.koul@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510314556-13002-1-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Sanyog Kale <sanyog.r.kale@intel.com>

SoundWire Slaves report status to bus. Add helpers to handle
the status changes.

Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/soundwire/bus.c       | 213 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/soundwire/sdw.h |   1 +
 2 files changed, 214 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 70b60ba84592..16bc295634de 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -419,6 +419,93 @@ int sdw_write(struct sdw_slave *slave, u32 addr, u8 value)
 }
 EXPORT_SYMBOL(sdw_write);
 
+/*
+ * SDW alert handling
+ */
+
+/* called with bus_lock held */
+static struct sdw_slave *sdw_get_slave(struct sdw_bus *bus, int i)
+{
+	struct sdw_slave *slave = NULL;
+
+	list_for_each_entry(slave, &bus->slaves, node) {
+		if (slave->dev_num == i)
+			break;
+	}
+
+	return slave;
+}
+
+static int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id)
+{
+
+	if ((slave->id.unique_id != id.unique_id) ||
+	    (slave->id.mfg_id != id.mfg_id) ||
+	    (slave->id.part_id != id.part_id) ||
+	    (slave->id.class_id != id.class_id))
+		return -ENODEV;
+
+	return 0;
+}
+
+/* called with bus_lock held */
+static int sdw_get_device_num(struct sdw_slave *slave)
+{
+	int bit;
+
+	bit = find_first_zero_bit(slave->bus->assigned, SDW_MAX_DEVICES);
+	if (bit == SDW_MAX_DEVICES) {
+		bit = -ENODEV;
+		goto err;
+	}
+
+	/*
+	 * Do not update dev_num in Slave data structure here,
+	 * Update once program dev_num is successful
+	 */
+	set_bit(bit, slave->bus->assigned);
+
+err:
+	return bit;
+}
+
+static int sdw_assign_device_num(struct sdw_slave *slave)
+{
+	int ret, dev_num;
+
+	/* check first if device number is assigned, if so reuse that */
+	if (!slave->dev_num) {
+		mutex_lock(&slave->bus->bus_lock);
+		dev_num = sdw_get_device_num(slave);
+		mutex_unlock(&slave->bus->bus_lock);
+		if (dev_num < 0) {
+			dev_err(slave->bus->dev, "Get dev_num failed: %d",
+								dev_num);
+			return dev_num;
+		}
+	} else {
+		dev_info(slave->bus->dev,
+				"Slave already registered dev_num:%d",
+				slave->dev_num);
+
+		/* Clear the slave->dev_num to transfer message on device 0 */
+		dev_num = slave->dev_num;
+		slave->dev_num = 0;
+
+	}
+
+	ret = sdw_write(slave, SDW_SCP_DEVNUMBER, dev_num);
+	if (ret < 0) {
+		dev_err(&slave->dev, "Program device_num failed: %d", ret);
+		return ret;
+	}
+
+	/* After xfer of msg, restore dev_num */
+	slave->dev_num = dev_num;
+
+	return 0;
+}
+
 void sdw_extract_slave_id(struct sdw_bus *bus,
 			u64 addr, struct sdw_slave_id *id)
 {
@@ -447,3 +534,129 @@ void sdw_extract_slave_id(struct sdw_bus *bus,
 				id->unique_id, id->sdw_version);
 
 }
+
+static int sdw_program_device_num(struct sdw_bus *bus)
+{
+	u8 buf[SDW_NUM_DEV_ID_REGISTERS] = {0};
+	struct sdw_slave *slave, *_s;
+	struct sdw_slave_id id;
+	struct sdw_msg msg;
+	bool found = false;
+	int count = 0, ret;
+	u64 addr;
+
+	/* No Slave, so use raw xfer api */
+	ret = sdw_fill_msg(&msg, NULL, SDW_SCP_DEVID_0, SDW_NUM_DEV_ID_REGISTERS,
+					0, SDW_MSG_FLAG_READ, buf);
+	if (ret < 0)
+		return ret;
+
+	do {
+		ret = sdw_transfer(bus, NULL, &msg);
+		if (ret == -ENODATA)
+			break;
+		if (ret < 0) {
+			dev_err(bus->dev, "DEVID read fail:%d\n", ret);
+			break;
+		}
+
+		/*
+		 * Construct the addr and extract. Cast the higher shift
+		 * bits to avoid truncation due to size limit.
+		 */
+		addr = buf[5] | (buf[4] << 8) | (buf[3] << 16) |
+			(buf[2] << 24) | ((unsigned long long)buf[1] << 32) |
+			((unsigned long long)buf[0] << 40);
+
+		sdw_extract_slave_id(bus, addr, &id);
+
+		/* Now compare with entries */
+		list_for_each_entry_safe(slave, _s, &bus->slaves, node) {
+			if (sdw_compare_devid(slave, id) == 0) {
+				found = true;
+
+				/*
+				 * Assign a new dev_num to this Slave and
+				 * not mark it present. It will be marked
+				 * present after it reports ATTACHED on new
+				 * dev_num
+				 */
+				ret = sdw_assign_device_num(slave);
+				if (ret) {
+					dev_err(slave->bus->dev,
+						"Assign dev_num failed:%d",
+						ret);
+					return ret;
+				}
+
+				break;
+			}
+		}
+
+		if (found == false) {
+			/* TODO: Park this device in Group 13 */
+			dev_err(bus->dev, "Slave Entry not found");
+		}
+
+		count++;
+
+	} while (ret == 0 && count < (SDW_MAX_DEVICES * 2));
+
+	return ret;
+}
+
+static void sdw_modify_slave_status(struct sdw_slave *slave,
+				enum sdw_slave_status status)
+{
+	mutex_lock(&slave->bus->bus_lock);
+	slave->status = status;
+	mutex_unlock(&slave->bus->bus_lock);
+}
+
+static int sdw_initialize_slave(struct sdw_slave *slave)
+{
+	struct sdw_slave_prop *prop = &slave->prop;
+	int val, ret;
+
+	val = sdw_read(slave, SDW_SCP_INTMASK1);
+	if (val < 0) {
+		dev_err(slave->bus->dev,
+				"SDW_SCP_INTMASK1 read failed:%d", val);
+		return val;
+	}
+
+	/* Set bus clash and parity interrupt mask */
+	val |= SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
+
+	/* Enable SCP interrupts */
+	ret = sdw_write(slave, SDW_SCP_INTMASK1, val);
+	if (ret < 0) {
+		dev_err(slave->bus->dev,
+				"SDW_SCP_INTMASK1 write failed:%d", val);
+		return ret;
+	}
+
+	/* No need to continue if DP0 is not present */
+	if (!slave->prop.dp0_prop)
+		return 0;
+
+	/* Enable DP0 interrupts */
+	val = sdw_read(slave, SDW_DP0_INTMASK);
+	if (val < 0) {
+		dev_err(slave->bus->dev,
+				"SDW_DP0_INTMASK read failed:%d", val);
+		return val;
+	}
+
+	val |= prop->dp0_prop->device_interrupts;
+	val |= SDW_DP0_INT_PORT_READY | SDW_DP0_INT_BRA_FAILURE;
+
+	ret = sdw_write(slave, SDW_DP0_INTMASK, val);
+	if (ret < 0) {
+		dev_err(slave->bus->dev,
+				"SDW_DP0_INTMASK write failed:%d", val);
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index f9a3e397afa6..71b69c17cc1b 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -67,6 +67,7 @@ struct sdw_slave;
 /* SDW Enumeration Device Number */
 #define SDW_ENUM_DEV_NUM		0
 
+#define SDW_NUM_DEV_ID_REGISTERS	6
 #define SDW_MAX_DEVICES			11
 
 /**
-- 
2.7.4
