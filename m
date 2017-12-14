From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v6 09/14] soundwire: Add slave status handling
Date: Thu, 14 Dec 2017 11:19:40 +0530
Message-ID: <1513230585-13882-10-git-send-email-vinod.koul@intel.com>
References: <1513230585-13882-1-git-send-email-vinod.koul@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513230585-13882-1-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi <tiwai@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

Add status handling API sdw_handle_slave_status() to handle
Slave status changes.

Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Reviewed-by: Philippe Ombredanne <pombredanne@nexb.com>
Acked-By: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/soundwire/bus.c       | 379 ++++++++++++++++++++++++++++++++++++++++++
 drivers/soundwire/bus.h       |   2 +
 include/linux/soundwire/sdw.h |  20 +++
 3 files changed, 401 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index e306bd4438bd..4c345197eb55 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -616,3 +616,382 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
 
 	return 0;
 }
+
+static int sdw_handle_dp0_interrupt(struct sdw_slave *slave, u8 *slave_status)
+{
+	u8 clear = 0, impl_int_mask;
+	int status, status2, ret, count = 0;
+
+	status = sdw_read(slave, SDW_DP0_INT);
+	if (status < 0) {
+		dev_err(slave->bus->dev,
+				"SDW_DP0_INT read failed:%d", status);
+		return status;
+	}
+
+	do {
+
+		if (status & SDW_DP0_INT_TEST_FAIL) {
+			dev_err(&slave->dev, "Test fail for port 0");
+			clear |= SDW_DP0_INT_TEST_FAIL;
+		}
+
+		/*
+		 * Assumption: PORT_READY interrupt will be received only for
+		 * ports implementing Channel Prepare state machine (CP_SM)
+		 */
+
+		if (status & SDW_DP0_INT_PORT_READY) {
+			complete(&slave->port_ready[0]);
+			clear |= SDW_DP0_INT_PORT_READY;
+		}
+
+		if (status & SDW_DP0_INT_BRA_FAILURE) {
+			dev_err(&slave->dev, "BRA failed");
+			clear |= SDW_DP0_INT_BRA_FAILURE;
+		}
+
+		impl_int_mask = SDW_DP0_INT_IMPDEF1 |
+			SDW_DP0_INT_IMPDEF2 | SDW_DP0_INT_IMPDEF3;
+
+		if (status & impl_int_mask) {
+			clear |= impl_int_mask;
+			*slave_status = clear;
+		}
+
+		/* clear the interrupt */
+		ret = sdw_write(slave, SDW_DP0_INT, clear);
+		if (ret < 0) {
+			dev_err(slave->bus->dev,
+				"SDW_DP0_INT write failed:%d", ret);
+			return ret;
+		}
+
+		/* Read DP0 interrupt again */
+		status2 = sdw_read(slave, SDW_DP0_INT);
+		if (status2 < 0) {
+			dev_err(slave->bus->dev,
+				"SDW_DP0_INT read failed:%d", status);
+			return status;
+		}
+		status &= status2;
+
+		count++;
+
+		/* we can get alerts while processing so keep retrying */
+	} while (status != 0 && count < SDW_READ_INTR_CLEAR_RETRY);
+
+	if (count == SDW_READ_INTR_CLEAR_RETRY)
+		dev_warn(slave->bus->dev, "Reached MAX_RETRY on DP0 read");
+
+	return ret;
+}
+
+static int sdw_handle_port_interrupt(struct sdw_slave *slave,
+		int port, u8 *slave_status)
+{
+	u8 clear = 0, impl_int_mask;
+	int status, status2, ret, count = 0;
+	u32 addr;
+
+	if (port == 0)
+		return sdw_handle_dp0_interrupt(slave, slave_status);
+
+	addr = SDW_DPN_INT(port);
+	status = sdw_read(slave, addr);
+	if (status < 0) {
+		dev_err(slave->bus->dev,
+				"SDW_DPN_INT read failed:%d", status);
+
+		return status;
+	}
+
+	do {
+
+		if (status & SDW_DPN_INT_TEST_FAIL) {
+			dev_err(&slave->dev, "Test fail for port:%d", port);
+			clear |= SDW_DPN_INT_TEST_FAIL;
+		}
+
+		/*
+		 * Assumption: PORT_READY interrupt will be received only
+		 * for ports implementing CP_SM.
+		 */
+		if (status & SDW_DPN_INT_PORT_READY) {
+			complete(&slave->port_ready[port]);
+			clear |= SDW_DPN_INT_PORT_READY;
+		}
+
+		impl_int_mask = SDW_DPN_INT_IMPDEF1 |
+			SDW_DPN_INT_IMPDEF2 | SDW_DPN_INT_IMPDEF3;
+
+
+		if (status & impl_int_mask) {
+			clear |= impl_int_mask;
+			*slave_status = clear;
+		}
+
+		/* clear the interrupt */
+		ret = sdw_write(slave, addr, clear);
+		if (ret < 0) {
+			dev_err(slave->bus->dev,
+					"SDW_DPN_INT write failed:%d", ret);
+			return ret;
+		}
+
+		/* Read DPN interrupt again */
+		status2 = sdw_read(slave, addr);
+		if (status < 0) {
+			dev_err(slave->bus->dev,
+					"SDW_DPN_INT read failed:%d", status);
+			return status;
+		}
+		status &= status2;
+
+		count++;
+
+		/* we can get alerts while processing so keep retrying */
+	} while (status != 0 && count < SDW_READ_INTR_CLEAR_RETRY);
+
+	if (count == SDW_READ_INTR_CLEAR_RETRY)
+		dev_warn(slave->bus->dev, "Reached MAX_RETRY on port read");
+
+	return ret;
+}
+
+static int sdw_handle_slave_alerts(struct sdw_slave *slave)
+{
+	struct sdw_slave_intr_status slave_intr;
+	u8 clear = 0, bit, port_status[15];
+	int port_num, stat, ret, count = 0;
+	unsigned long port;
+	bool slave_notify = false;
+	u8 buf, buf2[2], _buf, _buf2[2];
+
+	sdw_modify_slave_status(slave, SDW_SLAVE_ALERT);
+
+	/* Read Instat 1, Instat 2 and Instat 3 registers */
+	ret = buf = sdw_read(slave, SDW_SCP_INT1);
+	if (ret < 0) {
+		dev_err(slave->bus->dev,
+					"SDW_SCP_INT1 read failed:%d", ret);
+		return ret;
+	}
+
+	ret = sdw_nread(slave, SDW_SCP_INTSTAT2, 2, buf2);
+	if (ret < 0) {
+		dev_err(slave->bus->dev,
+					"SDW_SCP_INT2/3 read failed:%d", ret);
+		return ret;
+	}
+
+	do {
+		/*
+		 * Check parity, bus clash and Slave (impl defined)
+		 * interrupt
+		 */
+		if (buf & SDW_SCP_INT1_PARITY) {
+			dev_err(&slave->dev, "Parity error detected");
+			clear |= SDW_SCP_INT1_PARITY;
+		}
+
+		if (buf & SDW_SCP_INT1_BUS_CLASH) {
+			dev_err(&slave->dev, "Bus clash error detected");
+			clear |= SDW_SCP_INT1_BUS_CLASH;
+		}
+
+		/*
+		 * When bus clash or parity errors are detected, such errors
+		 * are unlikely to be recoverable errors.
+		 * TODO: In such scenario, reset bus. Make this configurable
+		 * via sysfs property with bus reset being the default.
+		 */
+
+		if (buf & SDW_SCP_INT1_IMPL_DEF) {
+			dev_dbg(&slave->dev, "Slave impl defined interrupt\n");
+			clear |= SDW_SCP_INT1_IMPL_DEF;
+			slave_notify = true;
+		}
+
+		/* Check port 0 - 3 interrupts */
+		port = buf & SDW_SCP_INT1_PORT0_3;
+
+		/* To get port number corresponding to bits, shift it */
+		port = port >> SDW_REG_SHIFT(SDW_SCP_INT1_PORT0_3);
+		for_each_set_bit(bit, &port, 8) {
+			sdw_handle_port_interrupt(slave, bit,
+						&port_status[bit]);
+
+		}
+
+		/* Check if cascade 2 interrupt is present */
+		if (buf & SDW_SCP_INT1_SCP2_CASCADE) {
+			port = buf2[0] & SDW_SCP_INTSTAT2_PORT4_10;
+			for_each_set_bit(bit, &port, 8) {
+				/* scp2 ports start from 4 */
+				port_num = bit + 3;
+				sdw_handle_port_interrupt(slave,
+						port_num,
+						&port_status[port_num]);
+			}
+		}
+
+		/* now check last cascade */
+		if (buf2[0] & SDW_SCP_INTSTAT2_SCP3_CASCADE) {
+			port = buf2[1] & SDW_SCP_INTSTAT3_PORT11_14;
+			for_each_set_bit(bit, &port, 8) {
+				/* scp3 ports start from 11 */
+				port_num = bit + 10;
+				sdw_handle_port_interrupt(slave,
+						port_num,
+						&port_status[port_num]);
+			}
+		}
+
+		/* Update the Slave driver */
+		if (slave_notify && (slave->ops) &&
+					(slave->ops->interrupt_callback)) {
+			slave_intr.control_port = clear;
+			memcpy(slave_intr.port, &port_status,
+						sizeof(slave_intr.port));
+
+			slave->ops->interrupt_callback(slave, &slave_intr);
+		}
+
+		/* Ack interrupt */
+		ret = sdw_write(slave, SDW_SCP_INT1, clear);
+		if (ret < 0) {
+			dev_err(slave->bus->dev,
+					"SDW_SCP_INT1 write failed:%d", ret);
+			return ret;
+		}
+
+		/*
+		 * Read status again to ensure no new interrupts arrived
+		 * while servicing interrupts.
+		 */
+		ret = _buf = sdw_read(slave, SDW_SCP_INT1);
+		if (ret < 0) {
+			dev_err(slave->bus->dev,
+					"SDW_SCP_INT1 read failed:%d", ret);
+			return ret;
+		}
+
+		ret = sdw_nread(slave, SDW_SCP_INTSTAT2, 2, _buf2);
+		if (ret < 0) {
+			dev_err(slave->bus->dev,
+					"SDW_SCP_INT2/3 read failed:%d", ret);
+			return ret;
+		}
+
+		/* Make sure no interrupts are pending */
+		buf &= _buf;
+		buf2[0] &= _buf2[0];
+		buf2[1] &= _buf2[1];
+		stat = buf || buf2[0] || buf2[1];
+
+		/*
+		 * Exit loop if Slave is continuously in ALERT state even
+		 * after servicing the interrupt multiple times.
+		 */
+		count++;
+
+		/* we can get alerts while processing so keep retrying */
+	} while (stat != 0 && count < SDW_READ_INTR_CLEAR_RETRY);
+
+	if (count == SDW_READ_INTR_CLEAR_RETRY)
+		dev_warn(slave->bus->dev, "Reached MAX_RETRY on alert read");
+
+	return ret;
+}
+
+static int sdw_update_slave_status(struct sdw_slave *slave,
+				enum sdw_slave_status status)
+{
+	if ((slave->ops) && (slave->ops->update_status))
+		return slave->ops->update_status(slave, status);
+
+	return 0;
+}
+
+/**
+ * sdw_handle_slave_status() - Handle Slave status
+ * @bus: SDW bus instance
+ * @status: Status for all Slave(s)
+ */
+int sdw_handle_slave_status(struct sdw_bus *bus,
+			enum sdw_slave_status status[])
+{
+	enum sdw_slave_status prev_status;
+	struct sdw_slave *slave;
+	int i, ret = 0;
+
+	if (status[0] == SDW_SLAVE_ATTACHED) {
+		ret = sdw_program_device_num(bus);
+		if (ret)
+			dev_err(bus->dev, "Slave attach failed: %d", ret);
+	}
+
+	/* Continue to check other slave statuses */
+	for (i = 1; i <= SDW_MAX_DEVICES; i++) {
+		mutex_lock(&bus->bus_lock);
+		if (test_bit(i, bus->assigned) == false) {
+			mutex_unlock(&bus->bus_lock);
+			continue;
+		}
+		mutex_unlock(&bus->bus_lock);
+
+		slave = sdw_get_slave(bus, i);
+		if (!slave)
+			continue;
+
+		switch (status[i]) {
+		case SDW_SLAVE_UNATTACHED:
+			if (slave->status == SDW_SLAVE_UNATTACHED)
+				break;
+
+			sdw_modify_slave_status(slave, SDW_SLAVE_UNATTACHED);
+			break;
+
+		case SDW_SLAVE_ALERT:
+			ret = sdw_handle_slave_alerts(slave);
+			if (ret)
+				dev_err(bus->dev,
+					"Slave %d alert handling failed: %d",
+					i, ret);
+			break;
+
+		case SDW_SLAVE_ATTACHED:
+			if (slave->status == SDW_SLAVE_ATTACHED)
+				break;
+
+			prev_status = slave->status;
+			sdw_modify_slave_status(slave, SDW_SLAVE_ATTACHED);
+
+			if (prev_status == SDW_SLAVE_ALERT)
+				break;
+
+			ret = sdw_initialize_slave(slave);
+			if (ret)
+				dev_err(bus->dev,
+					"Slave %d initialization failed: %d",
+					i, ret);
+
+			break;
+
+		default:
+			dev_err(bus->dev, "Invalid slave %d status:%d",
+							i, status[i]);
+			break;
+		}
+
+		ret = sdw_update_slave_status(slave, status[i]);
+		if (ret)
+			dev_err(slave->bus->dev,
+				"Update Slave status failed:%d", ret);
+
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(sdw_handle_slave_status);
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index e8df55d761c7..345c34d697e9 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -49,6 +49,8 @@ int sdw_transfer(struct sdw_bus *bus, struct sdw_msg *msg);
 int sdw_transfer_defer(struct sdw_bus *bus, struct sdw_msg *msg,
 				struct sdw_defer *defer);
 
+#define SDW_READ_INTR_CLEAR_RETRY	10
+
 int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
 		u32 addr, size_t count, u16 dev_num, u8 flags, u8 *buf);
 
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index cbadddce470d..e91fdcf41049 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -331,11 +331,28 @@ struct sdw_slave_id {
 };
 
 /**
+ * struct sdw_slave_intr_status - Slave interrupt status
+ * @control_port: control port status
+ * @port: data port status
+ */
+struct sdw_slave_intr_status {
+	u8 control_port;
+	u8 port[15];
+};
+
+/**
  * struct sdw_slave_ops - Slave driver callback ops
  * @read_prop: Read Slave properties
+ * @interrupt_callback: Device interrupt notification (invoked in thread
+ * context)
+ * @update_status: Update Slave status
  */
 struct sdw_slave_ops {
 	int (*read_prop)(struct sdw_slave *sdw);
+	int (*interrupt_callback)(struct sdw_slave *slave,
+			struct sdw_slave_intr_status *status);
+	int (*update_status)(struct sdw_slave *slave,
+			enum sdw_slave_status status);
 };
 
 /**
@@ -382,6 +399,9 @@ struct sdw_driver {
 	{ .mfg_id = (_mfg_id), .part_id = (_part_id), \
 	  .driver_data = (unsigned long)(_drv_data) }
 
+int sdw_handle_slave_status(struct sdw_bus *bus,
+			enum sdw_slave_status status[]);
+
 /*
  * SDW master structures and APIs
  */
-- 
2.7.4
