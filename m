From: Hardik Shah <hardik.t.shah@intel.com>
Subject: [RFC 09/14] SoundWire: Add support to handle Slave status change
Date: Fri, 21 Oct 2016 18:11:07 +0530
Message-ID: <1477053673-16021-10-git-send-email-hardik.t.shah@intel.com>
References: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: tiwai@suse.de, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, lgirdwood@gmail.com, plai@codeaurora.org, patches.audio@intel.com, Hardik Shah <hardik.t.shah@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch adds the support for updating the Slave status to bus driver.
Master driver updates Slave status change to the bus driver. Bus driver
takes appropriate action on Slave status change like.

	1. Registering new device if new Slave got enumerated on bus.
	2. Assigning the device number to the Slave device
	3. Marking Slave as un-attached if Slave got detached from bus.
	4. Handling Slave alerts.

Signed-off-by: Hardik Shah <hardik.t.shah@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/sdw/sdw.c      | 1074 ++++++++++++++++++++++++++++++++++++++++++++++++++
 sound/sdw/sdw_priv.h |   66 ++++
 2 files changed, 1140 insertions(+)

diff --git a/sound/sdw/sdw.c b/sound/sdw/sdw.c
index c98e4d7..801200f 100644
--- a/sound/sdw/sdw.c
+++ b/sound/sdw/sdw.c
@@ -60,11 +60,13 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_domain.h>
 #include <sound/sdw_bus.h>
 #include <sound/sdw_master.h>
 #include <sound/sdw_slave.h>
+#include <sound/sdw/sdw_registers.h>
 
 #include "sdw_priv.h"
 
@@ -334,6 +336,251 @@ static int sdw_match(struct device *dev, struct device_driver *driver)
 	.pm		= &soundwire_pm,
 };
 
+static int sdw_find_free_dev_num(struct sdw_master *mstr,
+				struct sdw_msg *msg)
+{
+	int i, ret = -EINVAL;
+
+	mutex_lock(&mstr->lock);
+
+	for (i = 1; i <= SDW_MAX_DEVICES; i++) {
+		if (mstr->sdw_addr[i].assigned == true)
+			continue;
+
+		mstr->sdw_addr[i].assigned = true;
+
+		memcpy(mstr->sdw_addr[i].dev_id, msg->buf,
+				SDW_NUM_DEV_ID_REGISTERS);
+
+		ret = i;
+		break;
+	}
+
+	mutex_unlock(&mstr->lock);
+	return ret;
+}
+
+static int sdw_program_dev_num(struct sdw_master *mstr, u8 dev_num)
+{
+	struct sdw_msg msg;
+	u8 buf;
+	int ret;
+
+	buf = dev_num;
+	ret = sdw_wr_msg(&msg, 0, SDW_SCP_DEVNUMBER, 1, &buf, 0x0, mstr,
+						SDW_NUM_OF_MSG1_XFRD);
+	if (ret != SDW_NUM_OF_MSG1_XFRD) {
+		ret = -EINVAL;
+		dev_err(&mstr->dev, "Program Slave address failed ret = %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static bool sdw_find_slv(struct sdw_master *mstr, struct sdw_msg *msg,
+						unsigned int *dev_num)
+{
+	struct sdw_slave_addr *sdw_addr;
+	int i, comparison;
+	bool found = false;
+
+	mutex_lock(&mstr->lock);
+
+	/*
+	 * Device number resets to 0, when Slave gets unattached. Find the
+	 * already registered Slave, mark it as present and program the
+	 * Slave address again with same value.
+	 */
+	sdw_addr = mstr->sdw_addr;
+
+	for (i = 1; i <= SDW_MAX_DEVICES; i++) {
+		comparison = memcmp(sdw_addr[i].dev_id, msg->buf,
+				SDW_NUM_DEV_ID_REGISTERS);
+
+		if ((!comparison) && (sdw_addr[i].assigned == true)) {
+			found = true;
+			*dev_num = i;
+			break;
+		}
+	}
+
+	mutex_unlock(&mstr->lock);
+
+	return found;
+}
+
+static void sdw_free_dev_num(struct sdw_master *mstr, int dev_num)
+{
+	int i;
+
+	mutex_lock(&mstr->lock);
+
+	for (i = 0; i <= SDW_MAX_DEVICES; i++) {
+
+		if (dev_num == mstr->sdw_addr[i].dev_num) {
+
+			mstr->sdw_addr[dev_num].assigned = false;
+			memset(&mstr->sdw_addr[dev_num].dev_id[0], 0x0,
+					SDW_NUM_DEV_ID_REGISTERS);
+			break;
+		}
+	}
+
+	mutex_unlock(&mstr->lock);
+}
+
+static int sdw_slv_register(struct sdw_master *mstr)
+{
+	int ret, i;
+	struct sdw_msg msg;
+	u8 buf[SDW_NUM_DEV_ID_REGISTERS];
+	struct sdw_slave *sdw_slave;
+	int dev_num = -1;
+	bool found = false;
+
+	/* Create message to read the 6 dev_id registers */
+	sdw_create_rd_msg(&msg, 0, SDW_SCP_DEVID_0, SDW_NUM_DEV_ID_REGISTERS,
+								buf, 0x0);
+
+	/*
+	 * Multiple Slaves may report an Attached_OK status as Device0.
+	 * Since the enumeration relies on a hardware arbitration and is
+	 * done one Slave at a time, a loop needs to run until all Slaves
+	 * have been assigned a non-zero DeviceNumber. The loop exits when
+	 * the reads from Device0 devID registers are no longer successful,
+	 * i.e. there is no Slave left to enumerate
+	 */
+	while ((ret = (snd_sdw_slave_transfer(mstr, &msg, SDW_NUM_OF_MSG1_XFRD))
+					== SDW_NUM_OF_MSG1_XFRD)) {
+
+		/*
+		 * Find is Slave is re-enumerating, and was already
+		 * registered earlier.
+		 */
+		found = sdw_find_slv(mstr, &msg, &dev_num);
+
+		/*
+		 * Reprogram the Slave device number if its getting
+		 * re-enumerated. If that fails we continue finding new
+		 * slaves, we flag error but don't stop since there may be
+		 * new Slaves trying to get enumerated.
+		 */
+		if (found) {
+			ret = sdw_program_dev_num(mstr, dev_num);
+			if (ret < 0)
+				dev_err(&mstr->dev, "Re-registering slave failed ret = %d", ret);
+
+			continue;
+
+		}
+
+		/*
+		 * Find the free device_number for the new Slave getting
+		 * enumerated 1st time.
+		 */
+		dev_num = sdw_find_free_dev_num(mstr, &msg);
+		if (dev_num < 0) {
+			dev_err(&mstr->dev, "Failed to find free dev_num ret = %d\n", ret);
+			goto dev_num_assign_fail;
+		}
+
+		/*
+		 * Allocate and initialize the Slave device on first
+		 * enumeration
+		 */
+		sdw_slave = kzalloc(sizeof(*sdw_slave), GFP_KERNEL);
+		if (!sdw_slave) {
+			ret = -ENOMEM;
+			goto mem_alloc_failed;
+		}
+
+		/*
+		 * Initialize the allocated Slave device, set bus type and
+		 * device type to SoundWire.
+		 */
+		sdw_slave->mstr = mstr;
+		sdw_slave->dev.parent = &sdw_slave->mstr->dev;
+		sdw_slave->dev.bus = &sdw_bus_type;
+		sdw_slave->dev.type = &sdw_slv_type;
+		sdw_slave->priv.addr = &mstr->sdw_addr[dev_num];
+		sdw_slave->priv.addr->slave = sdw_slave;
+
+		for (i = 0; i < SDW_NUM_DEV_ID_REGISTERS; i++)
+			sdw_slave->priv.dev_id[i] = msg.buf[i];
+
+		dev_dbg(&mstr->dev, "SDW slave slave id found with values\n");
+		dev_dbg(&mstr->dev, "dev_id0 to dev_id5: %x:%x:%x:%x:%x:%x\n",
+			msg.buf[0], msg.buf[1], msg.buf[2],
+			msg.buf[3], msg.buf[4], msg.buf[5]);
+		dev_dbg(&mstr->dev, "Dev number assigned is %x\n", dev_num);
+
+		/*
+		 * Set the Slave device name, its based on the dev_id and
+		 * to bus which it is attached.
+		 */
+		dev_set_name(&sdw_slave->dev, "sdw-slave%d-%02x:%02x:%02x:%02x:%02x:%02x",
+			sdw_master_get_id(mstr),
+			sdw_slave->priv.dev_id[0],
+			sdw_slave->priv.dev_id[1],
+			sdw_slave->priv.dev_id[2],
+			sdw_slave->priv.dev_id[3],
+			sdw_slave->priv.dev_id[4],
+			sdw_slave->priv.dev_id[5]);
+
+		/*
+		 * Set name based on dev_id. This will be used in match
+		 * function to bind the device and driver.
+		 */
+		sprintf(sdw_slave->priv.name, "%02x:%02x:%02x:%02x:%02x:%02x",
+				sdw_slave->priv.dev_id[0],
+				sdw_slave->priv.dev_id[1],
+				sdw_slave->priv.dev_id[2],
+				sdw_slave->priv.dev_id[3],
+				sdw_slave->priv.dev_id[4],
+				sdw_slave->priv.dev_id[5]);
+		ret = device_register(&sdw_slave->dev);
+		if (ret) {
+			dev_err(&mstr->dev, "Register slave failed ret = %d\n", ret);
+			goto reg_slv_failed;
+		}
+
+		ret = sdw_program_dev_num(mstr, dev_num);
+		if (ret < 0) {
+			dev_err(&mstr->dev, "Programming slave address failed ret = %d\n", ret);
+			goto program_slv_failed;
+		}
+
+		dev_dbg(&mstr->dev, "Slave registered with bus id %s\n",
+			dev_name(&sdw_slave->dev));
+
+		sdw_slave->dev_num = dev_num;
+
+		/*
+		 * Max number of Slaves that can be attached is 11. This
+		 * check is performed in sdw_find_free_dev_num function.
+		 */
+		mstr->num_slv++;
+
+		mutex_lock(&mstr->lock);
+		list_add_tail(&sdw_slave->priv.node, &mstr->slv_list);
+		mutex_unlock(&mstr->lock);
+
+	}
+
+	return ret;
+
+program_slv_failed:
+	device_unregister(&sdw_slave->dev);
+reg_slv_failed:
+	kfree(sdw_slave);
+mem_alloc_failed:
+	sdw_free_dev_num(mstr, dev_num);
+dev_num_assign_fail:
+	return ret;
+
+}
+
 /**
  * sdw_transfer: Local function where logic is placed to handle NOPM and PM
  *	variants of the Slave transfer functions.
@@ -516,6 +763,816 @@ int snd_sdw_slave_transfer(struct sdw_master *master, struct sdw_msg *msg,
 }
 EXPORT_SYMBOL_GPL(snd_sdw_slave_transfer);
 
+static int sdw_handle_dp0_interrupts(struct sdw_master *mstr,
+			struct sdw_slave *sdw_slv, unsigned int *status)
+{
+	int ret;
+	struct sdw_msg rd_msg, wr_msg;
+	int impl_def_mask = 0;
+	u8 rbuf, wbuf;
+	struct sdw_slave_dp0_caps *dp0_cap;
+	struct sdw_slave_priv *slv_priv = &sdw_slv->priv;
+
+	dp0_cap = slv_priv->caps.dp0_caps;
+
+	/* Read the DP0 interrupt status register and parse the bits */
+	ret = sdw_rd_msg(&rd_msg, 0x0, SDW_DP0_INTSTAT, 1, &rbuf,
+						sdw_slv->dev_num, mstr,
+						SDW_NUM_OF_MSG1_XFRD);
+	if (ret != SDW_NUM_OF_MSG1_XFRD) {
+		ret = -EINVAL;
+		dev_err(&mstr->dev, "Intr status read failed for slave %x\n",
+				sdw_slv->dev_num);
+		goto out;
+	}
+
+	if (rd_msg.buf[0] & SDW_DP0_INTSTAT_TEST_FAIL_MASK) {
+		dev_err(&mstr->dev, "Test fail for slave %d port 0\n",
+				sdw_slv->dev_num);
+		wr_msg.buf[0] |= SDW_DP0_INTCLEAR_TEST_FAIL_MASK;
+	}
+
+	if ((dp0_cap->prepare_ch == SDW_CP_MODE_NORMAL) &&
+		(rd_msg.buf[0] & SDW_DP0_INTSTAT_PORT_READY_MASK)) {
+		complete(&slv_priv->port_ready[0]);
+		wr_msg.buf[0] |= SDW_DP0_INTCLEAR_PORT_READY_MASK;
+	}
+
+	if (rd_msg.buf[0] & SDW_DP0_INTMASK_BRA_FAILURE_MASK) {
+		/* TODO: Handle BRA failure */
+		dev_err(&mstr->dev, "BRA failed for slave %d\n",
+				sdw_slv->dev_num);
+		wr_msg.buf[0] |= SDW_DP0_INTCLEAR_BRA_FAILURE_MASK;
+	}
+
+	impl_def_mask = SDW_DP0_INTSTAT_IMPDEF1_MASK |
+			SDW_DP0_INTSTAT_IMPDEF2_MASK |
+			SDW_DP0_INTSTAT_IMPDEF3_MASK;
+	if (rd_msg.buf[0] & impl_def_mask) {
+		wr_msg.buf[0] |= impl_def_mask;
+		*status = wr_msg.buf[0];
+	}
+
+	/* Ack DP0 interrupts */
+	ret = sdw_wr_msg(&wr_msg, 0x0, SDW_DP0_INTCLEAR, 1, &wbuf,
+						sdw_slv->dev_num, mstr,
+						SDW_NUM_OF_MSG1_XFRD);
+	if (ret != SDW_NUM_OF_MSG1_XFRD) {
+		ret = -EINVAL;
+		dev_err(&mstr->dev, "Ack DP0 interrupts failed\n");
+		goto out;
+	}
+
+out:
+	return ret;
+
+}
+
+static int sdw_handle_port_interrupts(struct sdw_master *mstr,
+		struct sdw_slave *sdw_slv, int port_num,
+		unsigned int *status)
+{
+	int ret;
+	struct sdw_msg rd_msg, wr_msg;
+	u8 rbuf, wbuf;
+	int impl_def_mask = 0;
+	u16 intr_clr_addr, intr_stat_addr;
+	struct sdw_slave_priv *slv_priv = &sdw_slv->priv;
+
+	/*
+	 * Handle the Data port0 interrupt separately since the interrupt
+	 * mask and stat register is different than other DPn registers
+	 */
+	if (port_num == 0 && slv_priv->caps.dp0_present)
+		return sdw_handle_dp0_interrupts(mstr, sdw_slv, status);
+
+	intr_stat_addr = SDW_DPN_INTSTAT + (SDW_NUM_DATA_PORT_REGISTERS *
+							port_num);
+
+	/* Read the interrupt status register of port and parse bits */
+	ret = sdw_rd_msg(&rd_msg, 0x0, intr_stat_addr, 1, &rbuf,
+						sdw_slv->dev_num, mstr,
+						SDW_NUM_OF_MSG1_XFRD);
+	if (ret != SDW_NUM_OF_MSG1_XFRD) {
+		ret = -EINVAL;
+		dev_err(&mstr->dev, "Port Status read failed for slv %x port %x\n",
+			sdw_slv->dev_num, port_num);
+		goto out;
+	}
+
+	if (rd_msg.buf[0] & SDW_DPN_INTSTAT_TEST_FAIL_MASK) {
+		dev_err(&mstr->dev, "Test fail for slave %x port %x\n",
+					sdw_slv->dev_num, port_num);
+		wr_msg.buf[0] |= SDW_DPN_INTCLEAR_TEST_FAIL_MASK;
+	}
+
+	/*
+	 * Port Ready interrupt is only for Normal Channel prepare state
+	 * machine
+	 */
+	if ((rd_msg.buf[0] & SDW_DPN_INTSTAT_PORT_READY_MASK)) {
+		complete(&slv_priv->port_ready[port_num]);
+		wr_msg.buf[0] |= SDW_DPN_INTCLEAR_PORT_READY_MASK;
+	}
+
+	impl_def_mask = SDW_DPN_INTSTAT_IMPDEF1_MASK |
+			SDW_DPN_INTSTAT_IMPDEF2_MASK |
+			SDW_DPN_INTSTAT_IMPDEF3_MASK;
+	if (rd_msg.buf[0] & impl_def_mask) {
+		wr_msg.buf[0] |= impl_def_mask;
+		*status = wr_msg.buf[0];
+	}
+
+	intr_clr_addr = SDW_DPN_INTCLEAR +
+			(SDW_NUM_DATA_PORT_REGISTERS * port_num);
+
+	/* Clear and Ack the Port interrupt */
+	ret =	sdw_wr_msg(&wr_msg, 0x0, intr_clr_addr, 1, &wbuf,
+						sdw_slv->dev_num, mstr,
+						SDW_NUM_OF_MSG1_XFRD);
+	if (ret != SDW_NUM_OF_MSG1_XFRD) {
+		ret = -EINVAL;
+		dev_err(&mstr->dev, "Clear and ACK port interrupt failed for slv %x port %x\n",
+						sdw_slv->dev_num, port_num);
+		goto out;
+	}
+
+out:
+	return ret;
+
+}
+
+/*
+ * Get the Slave status
+ */
+static int sdw_get_slv_intr_stat(struct sdw_master *mstr, struct sdw_slave *slv,
+							u8 *intr_stat_buf)
+{
+	struct sdw_msg rd_msg[3];
+	int ret;
+	int num_rd_messages = 1;
+	struct sdw_slave_priv *slv_priv = &slv->priv;
+
+	sdw_create_rd_msg(&rd_msg[0], 0x0, SDW_SCP_INTSTAT1, 1,
+				&intr_stat_buf[0], slv->dev_num);
+
+	/*
+	 * Create read message for reading the Instat2 registers if Slave
+	 * supports more than 4 ports
+	 */
+	if (slv_priv->caps.num_ports > SDW_CASC_PORT_START_INTSTAT2) {
+		sdw_create_rd_msg(&rd_msg[1], 0x0, SDW_SCP_INTSTAT2, 1,
+				&intr_stat_buf[1], slv->dev_num);
+		num_rd_messages = 2;
+
+	}
+
+	if (slv_priv->caps.num_ports > SDW_CASC_PORT_START_INTSTAT3) {
+		sdw_create_rd_msg(&rd_msg[2], 0x0, SDW_SCP_INTSTAT3, 1,
+				&intr_stat_buf[2], slv->dev_num);
+		num_rd_messages = 3;
+	}
+
+	/* Read Instat1, 2 and 3 registers */
+	ret = snd_sdw_slave_transfer(mstr, rd_msg, num_rd_messages);
+	if (ret != num_rd_messages) {
+		ret = -EINVAL;
+		dev_err(&mstr->dev, "Intr Status read failed for slv %x\n", slv->dev_num);
+	}
+
+	return ret;
+
+}
+
+static int sdw_ack_slv_intr(struct sdw_master *mstr, u8 dev_num,
+						u8 *intr_clr_buf)
+{
+	struct sdw_msg wr_msg;
+	int ret;
+
+	/* Ack the interrupts */
+	ret = sdw_wr_msg(&wr_msg, 0x0, SDW_SCP_INTCLEAR1, 1,
+					intr_clr_buf, dev_num, mstr,
+					SDW_NUM_OF_MSG1_XFRD);
+	if (ret != SDW_NUM_OF_MSG1_XFRD) {
+		ret = -EINVAL;
+		dev_err(&mstr->dev, "Intr clear write failed for slv\n");
+	}
+
+	return ret;
+
+}
+
+static int sdw_handle_casc_port_intr(struct sdw_master *mstr, struct sdw_slave
+					*sdw_slv, u8 cs_port_start,
+					unsigned int *port_status,
+					u8 *intr_stat_buf)
+{
+	int i, ret;
+	int cs_port_mask, cs_port_reg_offset, num_cs_ports;
+
+	switch (cs_port_start) {
+
+	case SDW_CASC_PORT_START_INTSTAT1:
+		/* Number of port status bits in this register */
+		num_cs_ports = SDW_NUM_CASC_PORT_INTSTAT1;
+		/* Bit mask for the starting port intr status */
+		cs_port_mask = SDW_CASC_PORT_MASK_INTSTAT1;
+		/* Register offset to read Cascaded instat 1 */
+		cs_port_reg_offset = SDW_CASC_PORT_REG_OFFSET_INTSTAT1;
+		break;
+
+	case SDW_CASC_PORT_START_INTSTAT2:
+		num_cs_ports = SDW_NUM_CASC_PORT_INTSTAT2;
+		cs_port_mask = SDW_CASC_PORT_MASK_INTSTAT2;
+		cs_port_reg_offset = SDW_CASC_PORT_REG_OFFSET_INTSTAT2;
+		break;
+
+	case SDW_CASC_PORT_START_INTSTAT3:
+		num_cs_ports = SDW_NUM_CASC_PORT_INTSTAT3;
+		cs_port_mask = SDW_CASC_PORT_MASK_INTSTAT3;
+		cs_port_reg_offset = SDW_CASC_PORT_REG_OFFSET_INTSTAT3;
+		break;
+
+	default:
+		return -EINVAL;
+
+	}
+
+	/*
+	 * Look for cascaded port interrupts, if found handle port
+	 * interrupts. Do this for all the Int_stat registers.
+	 */
+	for (i = cs_port_start; i < cs_port_start + num_cs_ports; i++) {
+		if (intr_stat_buf[cs_port_reg_offset] & cs_port_mask) {
+			ret = sdw_handle_port_interrupts(mstr, sdw_slv,
+						cs_port_start + i,
+						&port_status[i]);
+			if (ret < 0) {
+				dev_err(&mstr->dev, "Handling port intr failed ret = %d\n", ret);
+				return ret;
+			}
+		}
+			cs_port_mask = cs_port_mask << i;
+	}
+	return 0;
+}
+
+static int sdw_handle_impl_def_intr(struct sdw_slave *sdw_slv,
+		struct sdw_impl_def_intr_stat *intr_status,
+		unsigned int *port_status,
+		u8 *control_port_stat)
+{
+	int ret, i;
+	struct sdw_slave_priv *slv_priv = &sdw_slv->priv;
+
+	/* Update the implementation defined status to Slave */
+	for (i = 1; i < slv_priv->caps.num_ports; i++) {
+
+		intr_status->portn_stat[i].status = port_status[i];
+		intr_status->portn_stat[i].num = i;
+	}
+
+	intr_status->port0_stat = port_status[0];
+	intr_status->control_port_stat = control_port_stat[0];
+
+	ret = slv_priv->driver->slave_irq(sdw_slv, intr_status);
+	if (ret < 0) {
+		dev_err(&sdw_slv->mstr->dev, "Impl defined interrupt handling failed ret = %d\n", ret);
+		return ret;
+	}
+	return 0;
+}
+
+/*
+ * sdw_handle_slv_alerts: This function handles the Slave alert. Following
+ *	things are done as part of handling Slave alert. Attempt is done to
+ *	complete the interrupt handling in as less read/writes as possible
+ *	based on number of ports defined by Slave.
+ *
+ *	1. Get the interrupt status of the Slave (sdw_get_slv_intr_stat) 1a.
+ *	Read Instat1, Instat2 and Intstat3 registers based on on number of
+ *	ports defined by the Slave.
+ *
+ *	2. Parse Interrupt Status registers for the SCP interrupts and take
+ *	action.
+ *
+ *	3. Parse the interrupt status registers for the Port interrupts and
+ *	take action.
+ *
+ *	4. Ack port interrupts.
+ *	5. Call the Slave implementation defined interrupt, if Slave has
+ *	registered for it.
+ *
+ *	6. Ack the Slave interrupt.
+ *	7. Get interrupt status of the Slave again, to make sure no new
+ *	interrupt came when we were servicing the interrupts.
+ *
+ *	8. Goto step 2 if any interrupt pending.
+ *
+ *	9. Return if no new interrupt pending.
+ *	TODO: Poorly-designed or faulty Slaves may continuously generate
+ *	interrupts and delay handling of interrupts signaled by other
+ *	Slaves. A better QoS could rely on a priority scheme, where Slaves
+ *	with the lowest DeviceNumber are handled first. Currently the
+ *	priority is based on the enumeration sequence and arbitration;
+ *	additional information would be needed from firmware/BIOS or module
+ *	parameters to rank Slaves by relative interrupt processing priority.
+ */
+static int sdw_handle_slv_alerts(struct sdw_master *mstr,
+				struct sdw_slave *sdw_slv)
+{
+	int slave_stat, count = 0, ret;
+	int max_tries = SDW_INTR_STAT_READ_MAX_TRIES;
+	unsigned int port_status[SDW_MAX_DATA_PORTS] = {0};
+	struct sdw_impl_def_intr_stat intr_status;
+	struct sdw_portn_intr_stat portn_stat;
+	struct sdw_slave_priv *slv_priv = &sdw_slv->priv;
+	u8 intr_clr_buf[SDW_NUM_INT_CLEAR_REGISTERS];
+	u8 intr_stat_buf[SDW_NUM_INT_STAT_REGISTERS] = {0};
+	u8 cs_port_start;
+
+	mstr->sdw_addr[sdw_slv->dev_num].status = SDW_SLAVE_STAT_ALERT;
+	/*
+	 * Keep on servicing interrupts till Slave interrupts are ACKed and
+	 * device returns to attached state instead of ALERT state
+	 */
+	ret = sdw_get_slv_intr_stat(mstr, sdw_slv, intr_stat_buf);
+	if (ret < 0)
+		return ret;
+
+	do {
+
+		if (intr_stat_buf[0] & SDW_SCP_INTSTAT1_PARITY_MASK) {
+			dev_err(&mstr->dev, "Parity error detected\n");
+			intr_clr_buf[0] |= SDW_SCP_INTCLEAR1_PARITY_MASK;
+		}
+
+		if (intr_stat_buf[0] & SDW_SCP_INTSTAT1_BUS_CLASH_MASK) {
+			dev_err(&mstr->dev, "Bus clash error detected\n");
+			intr_clr_buf[0] |= SDW_SCP_INTCLEAR1_BUS_CLASH_MASK;
+		}
+
+		/* Handle implementation defined mask */
+		if (intr_stat_buf[0] & SDW_SCP_INTSTAT1_IMPL_DEF_MASK)
+			intr_clr_buf[0] |= SDW_SCP_INTCLEAR1_IMPL_DEF_MASK;
+
+		cs_port_start = SDW_NUM_CASC_PORT_INTSTAT1;
+
+		/* Handle Cascaded Port interrupts from Instat_1 registers */
+		ret = sdw_handle_casc_port_intr(mstr, sdw_slv, cs_port_start,
+					port_status, intr_stat_buf);
+		if (ret < 0)
+			return ret;
+
+		/*
+		 * If there are more than 4 ports and cascaded interrupt is
+		 * set, handle those interrupts
+		 */
+		if (intr_stat_buf[0] & SDW_SCP_INTSTAT1_SCP2_CASCADE_MASK) {
+			cs_port_start = SDW_NUM_CASC_PORT_INTSTAT2;
+			ret = sdw_handle_casc_port_intr(mstr, sdw_slv,
+					cs_port_start, port_status,
+					intr_stat_buf);
+		}
+
+		/*
+		 * Handle cascaded interrupts from instat_2 register, if no
+		 * cascaded interrupt from SCP2 cascade move to impl_def
+		 * intrs
+		 */
+		if (intr_stat_buf[1] & SDW_SCP_INTSTAT2_SCP3_CASCADE_MASK) {
+			cs_port_start = SDW_NUM_CASC_PORT_INTSTAT3;
+			ret = sdw_handle_casc_port_intr(mstr, sdw_slv,
+					cs_port_start, port_status,
+					intr_stat_buf);
+		}
+
+		/*
+		 * Handle implementation defined interrupts if Slave has
+		 * registered for it.
+		 */
+		intr_status.portn_stat = &portn_stat;
+		if (slv_priv->driver->slave_irq) {
+
+			ret = sdw_handle_impl_def_intr(sdw_slv, &intr_status,
+					port_status, intr_clr_buf);
+			if (ret < 0)
+				return ret;
+		}
+
+		/* Ack the Slave interrupt */
+		ret = sdw_ack_slv_intr(mstr, sdw_slv->dev_num, intr_clr_buf);
+		if (ret < 0) {
+			dev_err(&mstr->dev, "Slave interrupt ack failed ret = %d\n", ret);
+			return ret;
+		}
+
+		/*
+		 * Read status once again before exiting loop to make sure
+		 * no new interrupts came while we were servicing the
+		 * interrupts
+		 */
+		ret = sdw_get_slv_intr_stat(mstr, sdw_slv, intr_stat_buf);
+		if (ret < 0)
+			return ret;
+
+		/* Make sure no interrupts are pending */
+		slave_stat = intr_stat_buf[0] || intr_stat_buf[1] ||
+					intr_stat_buf[2];
+		/*
+		 * Exit loop if Slave is continuously in ALERT state even
+		 * after servicing the interrupt multiple times.
+		 */
+		count++;
+
+	} while (slave_stat != 0 && count < max_tries);
+
+	return 0;
+}
+
+/*
+ * Enable the Slave Control Port (SCP) interrupts and DP0 interrupts if
+ * Slave supports DP0. Enable implementation defined interrupts based on
+ * Slave interrupt mask.
+ * This function enables below interrupts.
+ * 1. Bus clash interrupt for SCP
+ * 2. Parity interrupt for SCP.
+ * 3. Enable implementation defined interrupt if slave requires.
+ * 4. Port ready interrupt for the DP0 if required based on Slave support
+ * for DP0 and normal channel prepare supported by DP0 port. For simplified
+ * channel prepare Port ready interrupt is not required to be enabled.
+ */
+static int sdw_enable_scp_intr(struct sdw_slave *sdw_slv, int mask)
+{
+	struct sdw_msg rd_msg, wr_msg;
+	u8 buf;
+	int ret;
+	struct sdw_master *mstr = sdw_slv->mstr;
+	struct sdw_slave_priv *slv_priv = &sdw_slv->priv;
+	u32 reg_addr = SDW_SCP_INTMASK1;
+
+
+	ret = sdw_rd_msg(&rd_msg, 0, reg_addr, 1, &buf,
+					sdw_slv->dev_num, mstr,
+					SDW_NUM_OF_MSG1_XFRD);
+	if (ret != SDW_NUM_OF_MSG1_XFRD) {
+		dev_err(&mstr->dev, "SCP Intr mask read failed for slave %x\n",
+				sdw_slv->dev_num);
+		return -EINVAL;
+	}
+
+	buf |= mask;
+
+	buf |= SDW_SCP_INTMASK1_BUS_CLASH_MASK;
+	buf |= SDW_SCP_INTMASK1_PARITY_MASK;
+
+	ret =	sdw_wr_msg(&wr_msg, 0, reg_addr, 1, &buf,
+					sdw_slv->dev_num, mstr,
+					SDW_NUM_OF_MSG1_XFRD);
+	if (ret != SDW_NUM_OF_MSG1_XFRD) {
+		dev_err(&mstr->dev, "SCP Intr mask write failed for slave %x\n",
+				sdw_slv->dev_num);
+		return -EINVAL;
+	}
+
+	if (!slv_priv->caps.dp0_present)
+		return 0;
+
+	reg_addr = SDW_DP0_INTMASK;
+	mask = slv_priv->caps.dp0_caps->imp_def_intr_mask;
+	buf = 0;
+
+	ret = sdw_rd_msg(&rd_msg, 0, reg_addr, 1, &buf,
+				sdw_slv->dev_num, mstr,
+				SDW_NUM_OF_MSG1_XFRD);
+	if (ret != SDW_NUM_OF_MSG1_XFRD) {
+		dev_err(&mstr->dev, "DP0 Intr mask read failed for slave %x\n",
+				sdw_slv->dev_num);
+		return -EINVAL;
+	}
+
+	buf |= mask;
+
+	if (slv_priv->caps.dp0_caps->prepare_ch == SDW_CP_MODE_NORMAL)
+		buf |= SDW_DPN_INTMASK_PORT_READY_MASK;
+
+	ret = sdw_wr_msg(&wr_msg, 0, reg_addr, 1, &buf,
+					sdw_slv->dev_num,
+					mstr,
+					SDW_NUM_OF_MSG1_XFRD);
+	if (ret != SDW_NUM_OF_MSG1_XFRD) {
+		dev_err(&mstr->dev, "DP0 Intr mask write failed for slave %x\n",
+				sdw_slv->dev_num);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int sdw_enable_disable_dpn_intr(struct sdw_slave *sdw_slv, int port_num,
+					int port_direction, bool enable)
+{
+
+	struct sdw_msg rd_msg, wr_msg;
+	u8 buf;
+	int ret;
+	struct sdw_master *mstr = sdw_slv->mstr;
+	struct sdw_slave_priv *slv_priv = &sdw_slv->priv;
+	u32 reg_addr;
+	struct sdw_dpn_caps *dpn_caps;
+	u8 mask;
+
+	reg_addr = SDW_DPN_INTMASK +
+		(SDW_NUM_DATA_PORT_REGISTERS * port_num);
+
+	dpn_caps = &slv_priv->caps.dpn_caps[port_direction][port_num];
+	mask = dpn_caps->imp_def_intr_mask;
+
+	/* Read DPn interrupt mask register */
+	ret = sdw_rd_msg(&rd_msg, 0, reg_addr, 1, &buf,
+				sdw_slv->dev_num, mstr,
+				SDW_NUM_OF_MSG1_XFRD);
+	if (ret != SDW_NUM_OF_MSG1_XFRD) {
+		dev_err(&mstr->dev, "DPn Intr mask read failed for slave %x\n",
+				sdw_slv->dev_num);
+		return -EINVAL;
+	}
+
+	/* Enable the Slave defined interrupts. */
+	buf |= mask;
+
+	/*
+	 * Enable port prepare interrupt only if port is not having
+	 * simplified channel prepare state machine
+	 */
+	if (dpn_caps->prepare_ch == SDW_CP_MODE_NORMAL)
+		buf |= SDW_DPN_INTMASK_PORT_READY_MASK;
+
+	/* Enable DPn interrupt */
+	ret = sdw_wr_msg(&wr_msg, 0, reg_addr, 1, &buf,
+				sdw_slv->dev_num, mstr,
+				SDW_NUM_OF_MSG1_XFRD);
+	if (ret != SDW_NUM_OF_MSG1_XFRD) {
+		dev_err(&mstr->dev, "DPn Intr mask write failed for slave %x\n",
+				sdw_slv->dev_num);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/**
+ * snd_sdw_slave_set_intr_mask: Set the implementation defined interrupt
+ *	mask. Slave sets the implementation defined interrupt mask as part
+ *	of registering Slave capabilities. Slave driver can also modify
+ *	implementation defined interrupt dynamically using below function.
+ *
+ * @slave: SoundWire Slave handle for which interrupt needs to be enabled.
+ * @intr_mask: Implementation defined interrupt mask.
+ */
+int snd_sdw_slave_set_intr_mask(struct sdw_slave *slave,
+	struct sdw_impl_def_intr_mask *intr_mask)
+{
+	int ret, i, j;
+	struct sdw_slave_caps *caps = &slave->priv.caps;
+	struct sdw_slave_dp0_caps *dp0_caps = caps->dp0_caps;
+	u8 ports;
+
+	caps->scp_impl_def_intr_mask = intr_mask->control_port_mask;
+
+	if (caps->dp0_present)
+		dp0_caps->imp_def_intr_mask = intr_mask->port0_mask;
+
+	for (i = 0; i < SDW_MAX_PORT_DIRECTIONS; i++) {
+		if (i == 0)
+			ports = caps->num_src_ports;
+		else
+			ports = caps->num_sink_ports;
+		for (j = 0; j < ports; j++) {
+			caps->dpn_caps[i][j].imp_def_intr_mask =
+				intr_mask->portn_mask[i][j].mask;
+		}
+	}
+
+	ret = sdw_enable_scp_intr(slave, caps->scp_impl_def_intr_mask);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+
+}
+EXPORT_SYMBOL(snd_sdw_slave_set_intr_mask);
+
+static int sdw_program_slv(struct sdw_slave *sdw_slv)
+{
+	struct sdw_slave_caps *cap;
+	int ret;
+	struct sdw_master *mstr = sdw_slv->mstr;
+	struct sdw_slave_priv *slv_priv = &sdw_slv->priv;
+
+	cap = &slv_priv->caps;
+
+	/* Enable DP0 and SCP interrupts */
+	ret = sdw_enable_scp_intr(sdw_slv, cap->scp_impl_def_intr_mask);
+	if (ret < 0) {
+		dev_err(&mstr->dev, "SCP program failed ret = %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static void sdw_update_slv_status_event(struct sdw_slave *slave,
+				enum sdw_slave_status status)
+
+{
+	struct sdw_slave_priv *slv_priv = &slave->priv;
+	struct sdw_slave_driver *slv_drv = slv_priv->driver;
+
+	if (slv_drv->status_change_event)
+		slv_drv->status_change_event(slave, status);
+}
+
+
+/*
+ * Following thing are done in below loop for each of the registered Slaves.
+ * This handles only Slaves which were already registered before update
+ * status.
+ * 1. Mark Slave as not present, if status is unattached from from bus and
+ * logical address assigned is true, update status to Slave driver.
+ *
+ * 2. Handle the Slave alerts, if the Status is Alert for any of the Slaves.
+ * 3. Mark the Slave as present, if Status is Present and logical address is
+ * assigned.
+ *	3a. Update the Slave status to driver, driver will use to make sure
+ *	its enumerated before doing read/writes.
+ *
+ *	3b. De-prepare if the Slave is exiting from clock stop mode 1 and
+ *	capability is updated as "de-prepare" required after exiting clock
+ *	stop mode 1.
+ *
+ *	3c. Program Slave registers for the implementation defined
+ *	interrupts and wake enable based on Slave capabilities.
+ */
+static void sdw_process_slv_status(struct sdw_master *mstr,
+			struct sdw_slv_status *status)
+{
+	int i, ret;
+
+	for (i = 1; i <= SDW_MAX_DEVICES; i++) {
+
+		if (mstr->sdw_addr[i].assigned != true)
+			continue;
+		/*
+		 * If current state of device is same as previous
+		 * state, nothing to be done for this device.
+		 */
+		else if (status->status[i] == mstr->sdw_addr[i].status)
+			continue;
+
+		/*
+		 * If Slave got unattached, mark it as not present
+		 * Slave can get unattached from attached state or
+		 * Alert State
+		 */
+		if (status->status[i] == SDW_SLAVE_STAT_NOT_PRESENT) {
+
+			mstr->sdw_addr[i].status =
+				SDW_SLAVE_STAT_NOT_PRESENT;
+
+		/*
+		 * If Slave is in alert state, handle the Slave
+		 * interrupts. Slave can get into alert state from
+		 * attached state only.
+		 */
+		} else if (status->status[i] == SDW_SLAVE_STAT_ALERT) {
+
+			ret = sdw_handle_slv_alerts(mstr,
+					mstr->sdw_addr[i].slave);
+
+		/*
+		 * If Slave is re-attaching on the bus program all
+		 * the interrupt and wake_en registers based on
+		 * capabilities. De-prepare the Slave based on
+		 * capability. Slave can move from Alert to
+		 * Attached_Ok, but nothing needs to be done on that
+		 * transition, it can also move from Not_present to
+		 * Attached_ok, in this case only registers needs to
+		 * be reprogrammed and deprepare needs to be done.
+		 */
+		} else if (status->status[i] ==
+				SDW_SLAVE_STAT_ATTACHED_OK &&
+				mstr->sdw_addr[i].status ==
+				SDW_SLAVE_STAT_NOT_PRESENT) {
+
+			ret = sdw_program_slv(mstr->sdw_addr[i].slave);
+
+			if (ret < 0)
+				continue;
+
+			mstr->sdw_addr[i].status =
+				SDW_SLAVE_STAT_ATTACHED_OK;
+		}
+
+		/*
+		 * Update the status to Slave, This is used by Slave
+		 * during resume to make sure its enumerated before
+		 * Slave register access
+		 */
+		sdw_update_slv_status_event(mstr->sdw_addr[i].slave,
+					mstr->sdw_addr[i].status);
+	}
+}
+
+/*
+ * sdw_handle_slv_status: Worker thread to handle the Slave status.
+ */
+static void sdw_handle_slv_status(struct kthread_work *work)
+{
+	int ret = 0;
+	struct sdw_slv_status *status, *__status__;
+	struct sdw_bus *bus =
+		container_of(work, struct sdw_bus, kwork);
+	struct sdw_master *mstr = bus->mstr;
+	unsigned long flags;
+
+	/*
+	 * Loop through each of the status nodes. Each node contains status
+	 * for all Slaves. Master driver reports Slave status for all Slaves
+	 * in interrupt context. Bus driver adds it to list and schedules
+	 * this thread.
+	 */
+	list_for_each_entry_safe(status, __status__, &bus->status_list, node) {
+
+		/*
+		 * Handle newly attached Slaves, Register the Slaves with
+		 * bus for all newly attached Slaves. Slaves may be
+		 * attaching first time to bus or may have re-enumerated
+		 * after hard or soft reset or clock stop exit 1.
+		 */
+		if (status->status[0] == SDW_SLAVE_STAT_ATTACHED_OK) {
+			ret = sdw_slv_register(mstr);
+			if (ret < 0)
+				/*
+				 * Even if adding new Slave fails, we will
+				 * continue to add Slaves till we find all
+				 * the enumerated Slaves.
+				 */
+				dev_err(&mstr->dev, "Register new slave failed ret = %d\n", ret);
+		}
+
+		sdw_process_slv_status(mstr, status);
+
+		spin_lock_irqsave(&bus->spinlock, flags);
+		list_del(&status->node);
+		spin_unlock_irqrestore(&bus->spinlock, flags);
+		kfree(status);
+	}
+}
+
+/**
+ * snd_sdw_master_update_slave_status: Update the status of the Slave to the
+ *	bus driver. Master calls this function based on the interrupt it
+ *	gets once the Slave changes its state or from interrupts for the
+ *	Master hardware that caches status information reported in PING
+ *	commands.
+ *
+ * @master: Master handle for which status is reported.
+ * @status: Array of status of each Slave.
+ *
+ * This function can be called from interrupt context by Master driver to
+ *	report Slave status without delay.
+ */
+int snd_sdw_master_update_slave_status(struct sdw_master *master,
+					struct sdw_status *status)
+{
+	struct sdw_bus *bus = NULL;
+	struct sdw_slv_status *slv_status;
+	unsigned long flags;
+
+	bus = master->bus;
+
+	slv_status = kzalloc(sizeof(*slv_status), GFP_ATOMIC);
+	if (!slv_status)
+		return -ENOMEM;
+
+	memcpy(slv_status->status, status, sizeof(*slv_status));
+
+	/*
+	 * Bus driver will take appropriate action for Slave status change
+	 * in thread context. Master driver can call this from interrupt
+	 * context as well. Memory for the Slave status will be freed in
+	 * workqueue, once its handled.
+	 */
+	spin_lock_irqsave(&bus->spinlock, flags);
+	list_add_tail(&slv_status->node, &bus->status_list);
+	spin_unlock_irqrestore(&bus->spinlock, flags);
+
+	kthread_queue_work(&bus->kworker, &bus->kwork);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_sdw_master_update_slave_status);
+
 /**
  * snd_sdw_master_register_driver: This API will register the Master driver
  *	with the SoundWire bus. It is typically called from the driver's
@@ -910,6 +1967,21 @@ int snd_sdw_master_add(struct sdw_master *master)
 
 	dev_dbg(&master->dev, "master [%s] registered\n", master->name);
 
+	kthread_init_worker(&sdw_bus->kworker);
+	sdw_bus->status_thread = kthread_run(kthread_worker_fn,
+			&sdw_bus->kworker, "%s",
+			dev_name(&master->dev));
+
+	if (IS_ERR(sdw_bus->status_thread)) {
+		dev_err(&master->dev, "error: failed to create status message task\n");
+		ret = PTR_ERR(sdw_bus->status_thread);
+		goto thread_create_failed;
+	}
+
+	kthread_init_work(&sdw_bus->kwork, sdw_handle_slv_status);
+	INIT_LIST_HEAD(&sdw_bus->status_list);
+	spin_lock_init(&sdw_bus->spinlock);
+
 	/*
 	 * Add bus to the list of buses inside core. This is list of Slave
 	 * devices enumerated on this bus. Adding new devices at end. It can
@@ -920,6 +1992,8 @@ int snd_sdw_master_add(struct sdw_master *master)
 
 	return 0;
 
+thread_create_failed:
+	device_unregister(&master->dev);
 dev_reg_failed:
 	kfree(sdw_bus);
 alloc_failed:
diff --git a/sound/sdw/sdw_priv.h b/sound/sdw/sdw_priv.h
index 0af1c99..bbba27a 100644
--- a/sound/sdw/sdw_priv.h
+++ b/sound/sdw/sdw_priv.h
@@ -59,6 +59,27 @@
 #ifndef _LINUX_SDW_PRIV_H
 #define _LINUX_SDW_PRIV_H
 
+#include <linux/kthread.h>
+#include <linux/spinlock.h>
+
+/* Number of message(s) transferred on bus. */
+#define SDW_NUM_OF_MSG1_XFRD	1
+#define SDW_NUM_OF_MSG2_XFRD	2
+#define SDW_NUM_OF_MSG3_XFRD	3
+#define SDW_NUM_OF_MSG4_XFRD	4
+
+/* Maximum number of Data Ports. */
+#define SDW_MAX_DATA_PORTS		15
+
+/**
+ * Max retries to service Slave interrupts, once Slave is in ALERT state.
+ * Bus driver tries to service interrupt till Slave state is changed to
+ * "ATTACHED_OK". In case Slave remains in ALERT state because of error
+ * condition on Slave like, PLL not getting locked or continuous Jack
+ * sensing, bus driver exits after MAX retries.
+ */
+#define SDW_INTR_STAT_READ_MAX_TRIES	10
+
 /**
  * sdw_driver: Structure to typecast both Master and Slave driver to generic
  *	SoundWire driver, to find out the driver type.
@@ -72,16 +93,44 @@ struct sdw_driver {
 };
 #define to_sdw_driver(d)			\
 		container_of(d, struct sdw_driver, driver)
+
+/**
+ * sdw_slv_status: List of Slave status.
+ *
+ * @node: Node for adding status to list of Slave status.
+ * @status: Slave status.
+ */
+struct sdw_slv_status {
+	struct list_head node;
+	enum sdw_slave_status status[SDW_MAX_DEVICES];
+};
+
 /**
  * sdw_bus: Bus structure holding bus related information.
  *
  * @bus_node: Node to add the bus in the sdw_core list.
  * @mstr: Master reference for the bus.
+ * @status_thread: Thread to process the Slave status.
+ * @kworker: Worker for updating the Slave status.
+ * @kwork: Work for worker
+ * @status_list: List where status update from master is added. List is
+ *	executed one by one.
+ *
+ * @spinlock: Lock to protect the list between work thread and interrupt
+ *	context. Bus driver does Slave status processing in the thread
+ *	context, spinlock is used to put the status reported by Master into
+ *	the status list which is processed by bus driver in thread context
+ *	later.
  */
 
 struct sdw_bus {
 	struct list_head bus_node;
 	struct sdw_master *mstr;
+	struct task_struct *status_thread;
+	struct kthread_worker kworker;
+	struct kthread_work kwork;
+	struct list_head status_list;
+	spinlock_t spinlock;
 };
 
 /**
@@ -117,6 +166,23 @@ struct snd_sdw_core {
  */
 void sdw_bank_switch_deferred(struct sdw_master *mstr, struct sdw_msg *msg,
 				struct sdw_deferred_xfer_data *data);
+
+/**
+ * sdw_enable_disable_dpn_intr: Enable or Disable Slave Data Port interrupt.
+ *	This is called by bus driver before prepare and after deprepare of
+ *	the ports.
+ *
+ * @sdw_slv: Slave handle.
+ * @port_num: Port number.
+ * @port_direction: Direction of the port configuration while doing
+ *	prepare/deprepare.
+ *
+ * @enable: Enable (1) or disable (0) the port interrupts.
+ */
+int sdw_enable_disable_dpn_intr(struct sdw_slave *sdw_slv, int port_num,
+					int port_direction, bool enable);
+
+
 /*
  * Helper function for bus driver to write messages. Since bus driver
  * operates on MIPI defined Slave registers, addr_page1 and addr_page2 is
-- 
1.7.9.5
