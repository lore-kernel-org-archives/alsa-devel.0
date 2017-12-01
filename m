From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v4 12/15] soundwire: cdns: Add sdw_master_ops and IO transfer support
Date: Fri,  1 Dec 2017 15:26:14 +0530
Message-ID: <1512122177-2889-13-git-send-email-vinod.koul@intel.com>
References: <1512122177-2889-1-git-send-email-vinod.koul@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512122177-2889-1-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Sanyog Kale <sanyog.r.kale@intel.com>

Implement sdw_master_ops with support for xfer_msg, xfer_msg_defer
and reset_page_addr. Since Cadence module doesn't know the systems
it will be used, set the read_prop to the bus helper.

Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/soundwire/cadence_master.c | 320 +++++++++++++++++++++++++++++++++++++
 drivers/soundwire/cadence_master.h |  14 ++
 2 files changed, 334 insertions(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index ec7faf228812..4790e82562fa 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -222,9 +222,261 @@ static int cdns_clear_bit(struct sdw_cdns *cdns, int offset, u32 value)
 }
 
 /*
+ * IO Calls
+ */
+static enum sdw_command_response cdns_fill_msg_resp(
+			struct sdw_cdns *cdns,
+			struct sdw_msg *msg, int count, int offset)
+{
+	int nack = 0, no_ack = 0;
+	int i;
+
+	/* check message response */
+	for (i = 0; i < count; i++) {
+		if (!(cdns->response_buf[i] & CDNS_MCP_RESP_ACK)) {
+			no_ack = 1;
+			dev_dbg(cdns->dev, "Msg Ack not received\n");
+			if (cdns->response_buf[i] & CDNS_MCP_RESP_NACK) {
+				nack = 1;
+				dev_err(cdns->dev, "Msg NACK received\n");
+			}
+		}
+	}
+
+	if (nack) {
+		dev_err(cdns->dev, "Msg NACKed for Slave %d\n", msg->dev_num);
+		return SDW_CMD_FAIL;
+	} else if (no_ack) {
+		dev_dbg(cdns->dev, "Msg ignored for Slave %d\n", msg->dev_num);
+		return SDW_CMD_IGNORED;
+	}
+
+	/* fill response */
+	for (i = 0; i < count; i++)
+		msg->buf[i + offset] = cdns->response_buf[i] >>
+				SDW_REG_SHIFT(CDNS_MCP_RESP_RDATA);
+
+	return SDW_CMD_OK;
+}
+
+static enum sdw_command_response
+_cdns_xfer_msg(struct sdw_cdns *cdns, struct sdw_msg *msg, int cmd,
+				int offset, int count, bool defer)
+{
+	unsigned long time;
+	u32 base, i, data;
+	u16 addr;
+
+	/* Program the watermark level for RX FIFO */
+	if (cdns->msg_count != count) {
+		cdns_writel(cdns, CDNS_MCP_FIFOLEVEL, count);
+		cdns->msg_count = count;
+	}
+
+	base = CDNS_MCP_CMD_BASE;
+	addr = msg->addr;
+
+	for (i = 0; i < count; i++) {
+		data = msg->dev_num << SDW_REG_SHIFT(CDNS_MCP_CMD_DEV_ADDR);
+		data |= cmd << SDW_REG_SHIFT(CDNS_MCP_CMD_COMMAND);
+		data |= addr++  << SDW_REG_SHIFT(CDNS_MCP_CMD_REG_ADDR_L);
+
+		if (msg->flags == SDW_MSG_FLAG_WRITE)
+			data |= msg->buf[i + offset];
+
+		data |= msg->ssp_sync << SDW_REG_SHIFT(CDNS_MCP_CMD_SSP_TAG);
+		cdns_writel(cdns, base, data);
+		base += CDNS_MCP_CMD_WORD_LEN;
+	}
+
+	if (defer)
+		return SDW_CMD_OK;
+
+	/* wait for timeout or response */
+	time = wait_for_completion_timeout(&cdns->tx_complete,
+				msecs_to_jiffies(CDNS_TX_TIMEOUT));
+	if (!time) {
+		dev_err(cdns->dev, "IO transfer timed out\n");
+		msg->len = 0;
+		return SDW_CMD_TIMEOUT;
+	}
+
+	return cdns_fill_msg_resp(cdns, msg, count, offset);
+}
+
+static enum sdw_command_response cdns_program_scp_addr(
+			struct sdw_cdns *cdns, struct sdw_msg *msg)
+{
+	int nack = 0, no_ack = 0;
+	unsigned long time;
+	u32 data[2], base;
+	int i;
+
+	/* Program the watermark level for RX FIFO */
+	if (cdns->msg_count != CDNS_SCP_RX_FIFOLEVEL) {
+		cdns_writel(cdns, CDNS_MCP_FIFOLEVEL, CDNS_SCP_RX_FIFOLEVEL);
+		cdns->msg_count = CDNS_SCP_RX_FIFOLEVEL;
+	}
+
+	data[0] = msg->dev_num << SDW_REG_SHIFT(CDNS_MCP_CMD_DEV_ADDR);
+	data[0] |= 0x3 << SDW_REG_SHIFT(CDNS_MCP_CMD_COMMAND);
+	data[1] = data[0];
+
+	data[0] |= SDW_SCP_ADDRPAGE1 << SDW_REG_SHIFT(CDNS_MCP_CMD_REG_ADDR_L);
+	data[1] |= SDW_SCP_ADDRPAGE2 << SDW_REG_SHIFT(CDNS_MCP_CMD_REG_ADDR_L);
+
+	data[0] |= msg->addr_page1;
+	data[1] |= msg->addr_page2;
+
+	base = CDNS_MCP_CMD_BASE;
+	cdns_writel(cdns, base, data[0]);
+	base += CDNS_MCP_CMD_WORD_LEN;
+	cdns_writel(cdns, base, data[1]);
+
+	time = wait_for_completion_timeout(&cdns->tx_complete,
+				msecs_to_jiffies(CDNS_TX_TIMEOUT));
+	if (!time) {
+		dev_err(cdns->dev, "SCP Msg trf timed out\n");
+		msg->len = 0;
+		return SDW_CMD_TIMEOUT;
+	}
+
+	/* check response the writes */
+	for (i = 0; i < 2; i++) {
+		if (!(cdns->response_buf[i] & CDNS_MCP_RESP_ACK)) {
+			no_ack = 1;
+			dev_err(cdns->dev, "Program SCP Ack not received");
+			if (cdns->response_buf[i] & CDNS_MCP_RESP_NACK) {
+				nack = 1;
+				dev_err(cdns->dev, "Program SCP NACK received");
+			}
+		}
+	}
+
+	/* For NACK, NO ack, don't return err if we are in Broadcast mode */
+	if (nack) {
+		dev_err(cdns->dev,
+			"SCP_addrpage NACKed for Slave %d", msg->dev_num);
+		return SDW_CMD_FAIL;
+	} else if (no_ack) {
+		dev_dbg(cdns->dev,
+			"SCP_addrpage ignored for Slave %d", msg->dev_num);
+		return SDW_CMD_IGNORED;
+	}
+
+	return SDW_CMD_OK;
+}
+
+static int cdns_prep_msg(struct sdw_cdns *cdns, struct sdw_msg *msg, int *cmd)
+{
+	int ret;
+
+	if (msg->page) {
+		ret = cdns_program_scp_addr(cdns, msg);
+		if (ret) {
+			msg->len = 0;
+			return ret;
+		}
+	}
+
+	switch (msg->flags) {
+	case SDW_MSG_FLAG_READ:
+		*cmd = CDNS_MCP_CMD_READ;
+		break;
+
+	case SDW_MSG_FLAG_WRITE:
+		*cmd = CDNS_MCP_CMD_WRITE;
+		break;
+
+	default:
+		dev_err(cdns->dev, "Invalid msg cmd: %d\n", msg->flags);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static enum sdw_command_response
+cdns_xfer_msg(struct sdw_bus *bus, struct sdw_msg *msg)
+{
+	struct sdw_cdns *cdns = bus_to_cdns(bus);
+	int cmd = 0, ret, i;
+
+	ret = cdns_prep_msg(cdns, msg, &cmd);
+	if (ret)
+		return SDW_CMD_FAIL_OTHER;
+
+	for (i = 0; i < msg->len / CDNS_MCP_CMD_LEN; i++) {
+		ret = _cdns_xfer_msg(cdns, msg, cmd, i * CDNS_MCP_CMD_LEN,
+				CDNS_MCP_CMD_LEN, false);
+		if (ret < 0)
+			goto exit;
+	}
+
+	if (!(msg->len % CDNS_MCP_CMD_LEN))
+		goto exit;
+
+	ret = _cdns_xfer_msg(cdns, msg, cmd, i * CDNS_MCP_CMD_LEN,
+			msg->len % CDNS_MCP_CMD_LEN, false);
+
+exit:
+	return ret;
+}
+
+static enum sdw_command_response
+cdns_xfer_msg_defer(struct sdw_bus *bus,
+		struct sdw_msg *msg, struct sdw_defer *defer)
+{
+	struct sdw_cdns *cdns = bus_to_cdns(bus);
+	int cmd = 0, ret;
+
+	/* for defer only 1 message is supported */
+	if (msg->len > 1)
+		return -ENOTSUPP;
+
+	ret = cdns_prep_msg(cdns, msg, &cmd);
+	if (ret)
+		return SDW_CMD_FAIL_OTHER;
+
+	cdns->defer = defer;
+	cdns->defer->length = msg->len;
+
+	return _cdns_xfer_msg(cdns, msg, cmd, 0, msg->len, true);
+}
+
+static enum sdw_command_response
+cdns_reset_page_addr(struct sdw_bus *bus, unsigned int dev_num)
+{
+	struct sdw_cdns *cdns = bus_to_cdns(bus);
+	struct sdw_msg msg;
+
+	/* Create dummy message with valid device number */
+	memset(&msg, 0, sizeof(msg));
+	msg.dev_num = dev_num;
+
+	return cdns_program_scp_addr(cdns, &msg);
+}
+
+/*
  * IRQ handling
  */
 
+static void cdns_read_response(struct sdw_cdns *cdns)
+{
+	u32 num_resp, cmd_base;
+	int i;
+
+	num_resp = cdns_readl(cdns, CDNS_MCP_FIFOSTAT);
+	num_resp &= CDNS_MCP_RX_FIFO_AVAIL;
+
+	cmd_base = CDNS_MCP_CMD_BASE;
+
+	for (i = 0; i < num_resp; i++) {
+		cdns->response_buf[i] = cdns_readl(cdns, cmd_base);
+		cmd_base += CDNS_MCP_CMD_WORD_LEN;
+	}
+}
+
 static int cdns_update_slave_status(struct sdw_cdns *cdns,
 					u32 slave0, u32 slave1)
 {
@@ -304,6 +556,18 @@ irqreturn_t sdw_cdns_irq(int irq, void *dev_id)
 	if (!(int_status & CDNS_MCP_INT_IRQ))
 		return IRQ_NONE;
 
+	if (int_status & CDNS_MCP_INT_RX_WL) {
+		cdns_read_response(cdns);
+
+		if (cdns->defer) {
+			cdns_fill_msg_resp(cdns, cdns->defer->msg,
+					cdns->defer->length, 0);
+			complete(&cdns->defer->complete);
+			cdns->defer = NULL;
+		} else
+			complete(&cdns->tx_complete);
+	}
+
 	if (int_status & CDNS_MCP_INT_CTRL_CLASH) {
 
 		/* Slave is driving bit slot during control word */
@@ -363,6 +627,42 @@ EXPORT_SYMBOL(sdw_cdns_thread);
 /*
  * init routines
  */
+static int _cdns_enable_interrupt(struct sdw_cdns *cdns)
+{
+	u32 mask;
+
+	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK0,
+				CDNS_MCP_SLAVE_INTMASK0_MASK);
+	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1,
+				CDNS_MCP_SLAVE_INTMASK1_MASK);
+
+	mask = CDNS_MCP_INT_SLAVE_RSVD | CDNS_MCP_INT_SLAVE_ALERT |
+		CDNS_MCP_INT_SLAVE_ATTACH | CDNS_MCP_INT_SLAVE_NATTACH |
+		CDNS_MCP_INT_CTRL_CLASH | CDNS_MCP_INT_DATA_CLASH |
+		CDNS_MCP_INT_RX_WL | CDNS_MCP_INT_IRQ | CDNS_MCP_INT_DPINT;
+
+	cdns_writel(cdns, CDNS_MCP_INTMASK, mask);
+
+	return 0;
+}
+
+/**
+ * sdw_cdns_enable_interrupt() - Enable SDW interrupts and update config
+ * @cdns: Cadence instance
+ */
+int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
+{
+	int ret;
+
+	_cdns_enable_interrupt(cdns);
+	ret = cdns_clear_bit(cdns, CDNS_MCP_CONFIG_UPDATE,
+			CDNS_MCP_CONFIG_UPDATE_BIT);
+	if (ret < 0)
+		dev_err(cdns->dev, "Config update timedout");
+
+	return ret;
+}
+EXPORT_SYMBOL(sdw_cdns_enable_interrupt);
 
 /**
  * sdw_cdns_init() - Cadence initialization
@@ -425,5 +725,25 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
 }
 EXPORT_SYMBOL(sdw_cdns_init);
 
+struct sdw_master_ops sdw_cdns_master_ops = {
+	.read_prop = sdw_master_read_prop,
+	.xfer_msg = cdns_xfer_msg,
+	.xfer_msg_defer = cdns_xfer_msg_defer,
+	.reset_page_addr = cdns_reset_page_addr,
+};
+EXPORT_SYMBOL(sdw_cdns_master_ops);
+
+/**
+ * sdw_cdns_probe() - Cadence probe routine
+ * @cdns: Cadence instance
+ */
+int sdw_cdns_probe(struct sdw_cdns *cdns)
+{
+	init_completion(&cdns->tx_complete);
+
+	return 0;
+}
+EXPORT_SYMBOL(sdw_cdns_probe);
+
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION("Cadence Soundwire Library");
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index f723c3395c0f..beaf6c9804eb 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -9,26 +9,40 @@
  * @dev: Linux device
  * @bus: Bus handle
  * @instance: instance number
+ * @response_buf: SoundWire response buffer
+ * @tx_complete: Tx completion
+ * @defer: Defer pointer
  * @registers: Cadence registers
  * @link_up: Link status
+ * @msg_count: Messages sent on bus
  */
 struct sdw_cdns {
 	struct device *dev;
 	struct sdw_bus bus;
 	unsigned int instance;
 
+	u32 response_buf[0x80];
+	struct completion tx_complete;
+	struct sdw_defer *defer;
+
 	void __iomem *registers;
 
 	bool link_up;
+	unsigned int msg_count;
 };
 
 #define bus_to_cdns(_bus) container_of(_bus, struct sdw_cdns, bus)
 
 /* Exported symbols */
 
+int sdw_cdns_probe(struct sdw_cdns *cdns);
+extern struct sdw_master_ops sdw_cdns_master_ops;
+
 irqreturn_t sdw_cdns_irq(int irq, void *dev_id);
 irqreturn_t sdw_cdns_thread(int irq, void *dev_id);
 
 int sdw_cdns_init(struct sdw_cdns *cdns);
+int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns);
+
 
 #endif /* __SDW_CADENCE_H */
-- 
2.7.4
