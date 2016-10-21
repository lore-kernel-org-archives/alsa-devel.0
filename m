From: Hardik Shah <hardik.t.shah@intel.com>
Subject: [RFC 08/14] SoundWire: Add API for Slave registers read/write
Date: Fri, 21 Oct 2016 18:11:06 +0530
Message-ID: <1477053673-16021-9-git-send-email-hardik.t.shah@intel.com>
References: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: tiwai@suse.de, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, lgirdwood@gmail.com, plai@codeaurora.org, patches.audio@intel.com, Hardik Shah <hardik.t.shah@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

This API is used by:
	1. Bus driver to read/write MIPI defined registers.
	2. Slave driver to read/write SoundWire Slave implementation
	defined registers. Slave driver should use regmap driver to
	access implementation defined registers, regmap driver uses
	read/write APIs internally.

Signed-off-by: Hardik Shah <hardik.t.shah@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/sdw/sdw.c      |  188 +++++++++++++++++++++++++++++++++++++++++++++++++-
 sound/sdw/sdw_priv.h |  144 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 329 insertions(+), 3 deletions(-)

diff --git a/sound/sdw/sdw.c b/sound/sdw/sdw.c
index d4e79b8a..c98e4d7 100644
--- a/sound/sdw/sdw.c
+++ b/sound/sdw/sdw.c
@@ -335,9 +335,191 @@ static int sdw_match(struct device *dev, struct device_driver *driver)
 };
 
 /**
- * snd_sdw_master_register_driver: SoundWire Master driver registration with
- *	bus. This API will register the Master driver with the SoundWire
- *	bus. It is typically called from the driver's module-init function.
+ * sdw_transfer: Local function where logic is placed to handle NOPM and PM
+ *	variants of the Slave transfer functions.
+ *
+ * @mstr: Handle to SDW Master
+ * @msg: One or more messages to be transferred
+ * @num: Number of messages to be transferred.
+ *
+ * Returns negative error, else the number of messages transferred.
+ *
+ */
+static int sdw_transfer(struct sdw_master *mstr, struct sdw_msg *msg, int num,
+				struct sdw_deferred_xfer_data *data)
+{
+	unsigned long orig_jiffies;
+	int ret, try, i;
+	int program_scp_addr_page = false;
+	u8 prev_adr_pg1 = 0;
+	u8 prev_adr_pg2 = 0;
+
+	for (i = 0; i < num; i++) {
+
+		/* Reset timeout for every message */
+		orig_jiffies = jiffies;
+
+		/* Inform Master driver to program SCP addr or not */
+		if ((prev_adr_pg1 != msg[i].addr_page1) ||
+			(prev_adr_pg2 != msg[i].addr_page2))
+			program_scp_addr_page = true;
+
+		for (ret = 0, try = 0; try <= mstr->retries; try++) {
+
+			/* Call deferred or sync handler based on call */
+			if (!data)
+				ret = mstr->driver->ops->xfer_msg(mstr,
+					&msg[i], program_scp_addr_page);
+
+			else if (mstr->driver->ops->xfer_msg_deferred)
+				mstr->driver->ops->xfer_msg_deferred(
+						mstr, &msg[i],
+						program_scp_addr_page,
+						data);
+			else
+				return -ENOTSUPP;
+			if (ret != -EAGAIN)
+				break;
+
+			if (time_after(jiffies, orig_jiffies + mstr->timeout))
+				break;
+		}
+
+
+		/*
+		 * Set previous address page as current once message is
+		 * transferred.
+		 */
+		prev_adr_pg1 = msg[i].addr_page1;
+		prev_adr_pg2 = msg[i].addr_page2;
+	}
+
+	orig_jiffies = jiffies;
+
+	ret = 0;
+
+	/* Reset page address if its other than 0 */
+	if (msg[i].addr_page1 && msg[i].addr_page2) {
+		for (try = 0; try <= mstr->retries; try++) {
+			/*
+			 * Reset the page address to 0, so that always there
+			 * is fast path access to MIPI defined Slave
+			 * registers.
+			 */
+
+			ret = mstr->driver->ops->reset_page_addr(
+					mstr, msg[0].dev_num);
+
+			if (ret != -EAGAIN)
+				break;
+
+			if (time_after(jiffies, orig_jiffies + mstr->timeout))
+				break;
+		}
+	}
+
+	if (!ret)
+		return i + 1;
+
+	return ret;
+}
+
+/**
+ * sdw_bank_switch_deferred: Initiate the transfer of the message but
+ *	doesn't wait for the message to be completed. Bus driver waits
+ *	outside context of this API for master driver to signal message
+ *	transfer complete. This is not Public API, this is used by Bus
+ *	driver only for Bank switch.
+ *
+ * @mstr: Master which will transfer the message.
+ * @msg: Message to be transferred. Message length of only 1 is supported.
+ * @data: Deferred information for the message to be transferred. This is
+ *	filled by Master on message transfer complete.
+ *
+ * Returns immediately after initiating the transfer, Bus driver needs to
+ * wait on xfer_complete, part of data, which is set by Master driver on
+ * completion of message transfer.
+ *
+ */
+void sdw_bank_switch_deferred(struct sdw_master *mstr, struct sdw_msg *msg,
+				struct sdw_deferred_xfer_data *data)
+{
+
+	pm_runtime_get_sync(&mstr->dev);
+
+	sdw_transfer(mstr, msg, 1, data);
+
+	pm_runtime_mark_last_busy(&mstr->dev);
+	pm_runtime_put_sync_autosuspend(&mstr->dev);
+
+}
+
+/**
+ * snd_sdw_slave_transfer: Transfer message on bus.
+ *
+ * @master: Master which will transfer the message.
+ * @msg: Array of messages to be transferred.
+ * @num: Number of messages to be transferred, messages include read and
+ *	write messages, but not the ping commands. The read and write
+ *	messages are transmitted as a part of read and write SoundWire
+ *	commands with a parameter containing the payload.
+ *
+ * Returns the number of messages successfully transferred else appropriate
+ * error code.
+ */
+int snd_sdw_slave_transfer(struct sdw_master *master, struct sdw_msg *msg,
+							unsigned int num)
+{
+	int ret;
+
+	/*
+	 * Master reports the successfully transmitted messages onto the
+	 * bus. If there are N message to be transmitted onto bus, and if
+	 * Master gets error at (N-2) message it will report number of
+	 * message transferred as N-2 Error is reported if ACK is not
+	 * received for all messages or NACK is received for any of the
+	 * transmitted messages. Currently both ACK not getting received
+	 * and NACK is treated as error. But for upper level like regmap,
+	 * both (Absence of ACK or NACK) errors are same as failure.
+	 */
+
+	/*
+	 * Make sure Master is woken up before message transfer Ideally
+	 * function calling this should have wokenup Master as this will be
+	 * called by Slave driver, and it will do runtime_get for itself,
+	 * which will make sure Master is woken up as Master is parent Linux
+	 * device of Slave. But if Slave is not implementing RTPM, it may
+	 * not do this, so bus driver has to do it always irrespective of
+	 * what Slave does.
+	 */
+	pm_runtime_get_sync(&master->dev);
+
+	if (in_atomic() || irqs_disabled()) {
+		ret = mutex_trylock(&master->msg_lock);
+		if (!ret) {
+			ret = -EAGAIN;
+			goto out;
+		}
+	} else {
+		mutex_lock(&master->msg_lock);
+	}
+
+	ret = sdw_transfer(master, msg, num, NULL);
+
+	mutex_unlock(&master->msg_lock);
+out:
+	/* Put Master to sleep once message is transferred */
+	pm_runtime_mark_last_busy(&master->dev);
+	pm_runtime_put_sync_autosuspend(&master->dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_sdw_slave_transfer);
+
+/**
+ * snd_sdw_master_register_driver: This API will register the Master driver
+ *	with the SoundWire bus. It is typically called from the driver's
+ *	module-init function.
  *
  * @driver: Master Driver to be associated with Master interface.
  * @owner: Module owner, generally THIS module.
diff --git a/sound/sdw/sdw_priv.h b/sound/sdw/sdw_priv.h
index 5911aa6..0af1c99 100644
--- a/sound/sdw/sdw_priv.h
+++ b/sound/sdw/sdw_priv.h
@@ -99,4 +99,148 @@ struct snd_sdw_core {
 	struct idr idr;
 };
 
+/**
+ * sdw_bank_switch_deferred: Initiate the transfer of the message but
+ *	doesn't wait for the message to be completed. Bus driver waits
+ *	outside context of this API for master driver to signal message
+ *	transfer complete. This is not Public API, this is used by Bus
+ *	driver only for Bank switch.
+ *
+ * @mstr: Master which will transfer the message.
+ * @msg: Message to be transferred. Message length of only 1 is supported.
+ * @data: Deferred information for the message to be transferred. This is
+ *	filled by Master on message transfer complete.
+ *
+ * Returns immediately after initiating the transfer, Bus driver needs to
+ * wait on xfer_complete, part of data, which is set by Master driver on
+ * completion of message transfer.
+ */
+void sdw_bank_switch_deferred(struct sdw_master *mstr, struct sdw_msg *msg,
+				struct sdw_deferred_xfer_data *data);
+/*
+ * Helper function for bus driver to write messages. Since bus driver
+ * operates on MIPI defined Slave registers, addr_page1 and addr_page2 is
+ * set to 0.
+ */
+static inline int sdw_wr_msg(struct sdw_msg *msg, bool xmit_on_ssp, u16 addr,
+					u16 len, u8 *buf, u8 dev_num,
+					struct sdw_master *mstr,
+					int num_msg)
+{
+	msg->xmit_on_ssp = xmit_on_ssp;
+	msg->r_w_flag = SDW_MSG_FLAG_WRITE;
+	msg->addr = addr;
+	msg->len = len;
+	msg->buf = buf;
+	msg->dev_num = dev_num;
+	msg->addr_page1 = 0x0;
+	msg->addr_page2 = 0x0;
+
+	return snd_sdw_slave_transfer(mstr, msg, num_msg);
+}
+
+/*
+ * Helper function for bus driver to read messages. Since bus driver
+ * operates on MIPI defined Slave registers, addr_page1 and addr_page2 is
+ * set to 0.
+ */
+static inline int sdw_rd_msg(struct sdw_msg *msg, bool xmit_on_ssp, u16 addr,
+					u16 len, u8 *buf, u8 dev_num,
+					struct sdw_master *mstr,
+					int num_msg)
+{
+	msg->xmit_on_ssp = xmit_on_ssp;
+	msg->r_w_flag = SDW_MSG_FLAG_READ;
+	msg->addr = addr;
+	msg->len = len;
+	msg->buf = buf;
+	msg->dev_num = dev_num;
+	msg->addr_page1 = 0x0;
+	msg->addr_page2 = 0x0;
+
+	return snd_sdw_slave_transfer(mstr, msg, num_msg);
+}
+
+/*
+ * Helper function for bus driver to write messages (nopm version). Since
+ * bus driver operates on MIPI defined Slave registers, addr_page1 and
+ * addr_page2 is set to 0.
+ */
+static inline int sdw_wr_msg_nopm(struct sdw_msg *msg, bool xmit_on_ssp,
+					u16 addr, u16 len, u8 *buf,
+					u8 dev_num,
+					struct sdw_master *mstr,
+					int num_msg)
+{
+	msg->xmit_on_ssp = xmit_on_ssp;
+	msg->r_w_flag = SDW_MSG_FLAG_WRITE;
+	msg->addr = addr;
+	msg->len = len;
+	msg->buf = buf;
+	msg->dev_num = dev_num;
+	msg->addr_page1 = 0x0;
+	msg->addr_page2 = 0x0;
+
+	return snd_sdw_slave_transfer(mstr, msg, num_msg);
+}
+
+/*
+ * Helper function for bus driver to read messages (nopm version). Since
+ * bus driver operates on MIPI defined Slave registers, addr_page1 and
+ * addr_page2 is set to 0.
+ */
+static inline int sdw_rd_msg_nopm(struct sdw_msg *msg, bool xmit_on_ssp,
+					u16 addr, u16 len, u8 *buf,
+					u8 dev_num,
+					struct sdw_master *mstr,
+					int num_msg)
+{
+	msg->xmit_on_ssp = xmit_on_ssp;
+	msg->r_w_flag = SDW_MSG_FLAG_READ;
+	msg->addr = addr;
+	msg->len = len;
+	msg->buf = buf;
+	msg->dev_num = dev_num;
+	msg->addr_page1 = 0x0;
+	msg->addr_page2 = 0x0;
+
+	return snd_sdw_slave_transfer(mstr, msg, num_msg);
+}
+
+/*
+ * Helper function for bus driver to create read messages. Since bus driver
+ * operates on MIPI defined Slave registers, addr_page1 and addr_page2 is
+ * set to 0.
+ */
+static inline void sdw_create_rd_msg(struct sdw_msg *msg, bool xmit_on_ssp,
+				u16 addr, u16 len, u8 *buf, u8 dev_num)
+{
+	msg->xmit_on_ssp = xmit_on_ssp;
+	msg->r_w_flag = SDW_MSG_FLAG_READ;
+	msg->addr = addr;
+	msg->len = len;
+	msg->buf = buf;
+	msg->dev_num = dev_num;
+	msg->addr_page1 = 0x0;
+	msg->addr_page2 = 0x0;
+}
+
+/*
+ * Helper function for bus driver to create write messages. Since bus driver
+ * operates on MIPI defined Slave registers, addr_page1 and addr_page2 is
+ * set to 0.
+ */
+static inline void sdw_create_wr_msg(struct sdw_msg *msg, bool xmit_on_ssp,
+				u16 addr, u16 len, u8 *buf, u8 dev_num)
+{
+	msg->xmit_on_ssp = xmit_on_ssp;
+	msg->r_w_flag = SDW_MSG_FLAG_WRITE;
+	msg->addr = addr;
+	msg->len = len;
+	msg->buf = buf;
+	msg->dev_num = dev_num;
+	msg->addr_page1 = 0x0;
+	msg->addr_page2 = 0x0;
+}
+
 #endif /* _LINUX_SDW_PRIV_H */
-- 
1.7.9.5
