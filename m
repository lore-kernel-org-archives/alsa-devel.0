From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 05/13] soundwire: Add helpers for ports
	operations
Date: Wed, 28 Mar 2018 15:08:30 +0530
Message-ID: <1522229918-4748-6-git-send-email-vinod.koul@intel.com>
References: <1522229918-4748-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id BBD1F2671DB
 for <alsa-devel@alsa-project.org>; Wed, 28 Mar 2018 11:34:43 +0200 (CEST)
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
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Sanyog Kale <sanyog.r.kale@intel.com>

Add helpers to configure, prepare, enable, disable and
de-prepare ports.

Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/soundwire/bus.c       |  26 +++++
 drivers/soundwire/bus.h       |   2 +
 drivers/soundwire/runtime.c   | 259 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/soundwire/sdw.h |  54 +++++++++
 4 files changed, 341 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index abf046f6b188..b8c93f0ac0a0 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -577,6 +577,32 @@ static void sdw_modify_slave_status(struct sdw_slave *slave,
 	mutex_unlock(&slave->bus->bus_lock);
 }
 
+int sdw_configure_dpn_intr(struct sdw_slave *slave,
+			int port, bool enable, int mask)
+{
+	u32 addr;
+	int ret;
+	u8 val = 0;
+
+	addr = SDW_DPN_INTMASK(port);
+
+	/* Set/Clear port ready interrupt mask */
+	if (enable) {
+		val |= mask;
+		val |= SDW_DPN_INT_PORT_READY;
+	} else {
+		val &= ~(mask);
+		val &= ~SDW_DPN_INT_PORT_READY;
+	}
+
+	ret = sdw_update(slave, addr, (mask | SDW_DPN_INT_PORT_READY), val);
+	if (ret < 0)
+		dev_err(slave->bus->dev,
+				"SDW_DPN_INTMASK write failed:%d", val);
+
+	return ret;
+}
+
 static int sdw_initialize_slave(struct sdw_slave *slave)
 {
 	struct sdw_slave_prop *prop = &slave->prop;
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 8bb150294936..95764f1b9339 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -112,6 +112,8 @@ struct sdw_master_runtime {
 struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
 				enum sdw_data_direction direction,
 				unsigned int port_num);
+int sdw_configure_dpn_intr(struct sdw_slave *slave, int port,
+					bool enable, int mask);
 
 int sdw_transfer(struct sdw_bus *bus, struct sdw_msg *msg);
 int sdw_transfer_defer(struct sdw_bus *bus, struct sdw_msg *msg,
diff --git a/drivers/soundwire/runtime.c b/drivers/soundwire/runtime.c
index 6e8826a6ea8e..5ceea1052b92 100644
--- a/drivers/soundwire/runtime.c
+++ b/drivers/soundwire/runtime.c
@@ -241,3 +241,262 @@ static int sdw_program_port_params(struct sdw_master_runtime *m_rt)
 
 	return 0;
 }
+
+static int sdw_enable_disable_slave_ports(struct sdw_bus *bus,
+				struct sdw_slave_runtime *s_rt,
+				struct sdw_port_runtime *p_rt, bool en)
+{
+	struct sdw_transport_params *t_params = &p_rt->transport_params;
+	u32 addr;
+	int ret;
+
+	if (bus->params.next_bank)
+		addr = SDW_DPN_CHANNELEN_B1(p_rt->num);
+	else
+		addr = SDW_DPN_CHANNELEN_B0(p_rt->num);
+
+	/*
+	 * Since we do not support sharing a port across two streams,
+	 * it is safe to reset this register
+	 */
+	if (en)
+		ret = sdw_update(s_rt->slave, addr, 0xFF, p_rt->ch_mask);
+	else
+		ret = sdw_update(s_rt->slave, addr, 0xFF, 0x0);
+
+	if (ret < 0)
+		dev_err(&s_rt->slave->dev,
+			"Slave chn_en reg write failed:%d port:%d",
+			ret, t_params->port_num);
+
+	return ret;
+}
+
+static int sdw_enable_disable_mstr_ports(struct sdw_master_runtime *m_rt,
+			struct sdw_port_runtime *p_rt, bool en)
+{
+	struct sdw_transport_params *t_params = &p_rt->transport_params;
+	struct sdw_bus *bus = m_rt->bus;
+	struct sdw_enable_ch enable_ch;
+	int ret = 0;
+
+	enable_ch.num = p_rt->num;
+	enable_ch.ch_mask = p_rt->ch_mask;
+	enable_ch.enable = en;
+
+	/* Perform Master port channel(s) enable/disable */
+	if (bus->port_ops->dpn_port_enable_ch) {
+		ret = bus->port_ops->dpn_port_enable_ch(bus,
+				&enable_ch, bus->params.next_bank);
+		if (ret < 0) {
+			dev_err(bus->dev,
+				"Master chn_en write failed:%d port:%d",
+				ret, t_params->port_num);
+			return ret;
+		}
+	} else {
+		dev_err(bus->dev,
+			"enable/disable Master port channel unsuuported");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * sdw_enable_disable_ports: Enable/disable port(s) for Master and
+ * Slave(s)
+ *
+ * @m_rt: Master stream runtime
+ * @en: mode (enable/disable)
+ */
+static int sdw_enable_disable_ports(struct sdw_master_runtime *m_rt, bool en)
+{
+	struct sdw_port_runtime *s_port, *m_port;
+	struct sdw_slave_runtime *s_rt = NULL;
+	int ret = 0;
+
+	/* Enable/Disable Slave port(s) */
+	list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
+		list_for_each_entry(s_port, &s_rt->port_list, port_node) {
+			ret = sdw_enable_disable_slave_ports(m_rt->bus, s_rt,
+							s_port, en);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	/* Enable/Disable Master port(s) */
+	list_for_each_entry(m_port, &m_rt->port_list, port_node) {
+		ret = sdw_enable_disable_mstr_ports(m_rt, m_port, en);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int sdw_do_port_prep(struct sdw_slave_runtime *s_rt,
+		struct sdw_prepare_ch prep_ch, enum sdw_port_prep_ops cmd)
+{
+	const struct sdw_slave_ops *ops = s_rt->slave->ops;
+	int ret;
+
+	if (ops->port_prep) {
+		ret = ops->port_prep(s_rt->slave, &prep_ch, cmd);
+		if (ret < 0) {
+			dev_err(&s_rt->slave->dev,
+				"Slave Port Pre-Prepare failed: %d", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int sdw_prep_deprep_slave_ports(struct sdw_bus *bus,
+			struct sdw_slave_runtime *s_rt,
+			struct sdw_port_runtime *p_rt, bool prep)
+{
+	struct completion *port_ready = NULL;
+	struct sdw_dpn_prop *dpn_prop;
+	struct sdw_prepare_ch prep_ch;
+	unsigned int time_left;
+	bool intr = false;
+	int ret = 0, val;
+	u32 addr;
+
+	prep_ch.num = p_rt->num;
+	prep_ch.ch_mask = p_rt->ch_mask;
+
+	dpn_prop = sdw_get_slave_dpn_prop(s_rt->slave,
+					s_rt->direction,
+					prep_ch.num);
+	if (!dpn_prop) {
+		dev_err(bus->dev,
+			"Slave Port:%d properties not found", prep_ch.num);
+		return -EINVAL;
+	}
+
+	prep_ch.prepare = prep;
+
+	prep_ch.bank = bus->params.next_bank;
+
+	if ((dpn_prop->device_interrupts) || (!dpn_prop->simple_ch_prep_sm))
+		intr = true;
+
+	/*
+	 * Enable interrupt before Port prepare.
+	 * For Port de-prepare, it is assumed that port
+	 * was prepared earlier.
+	 **/
+	if (prep && intr) {
+		ret = sdw_configure_dpn_intr(s_rt->slave, p_rt->num, prep,
+						dpn_prop->device_interrupts);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Inform slave about the impending port prepare */
+	sdw_do_port_prep(s_rt, prep_ch, SDW_OPS_PORT_PRE_PREP);
+
+	/* Prepare Slave port implementing CP_SM */
+	if (!dpn_prop->simple_ch_prep_sm) {
+		addr = SDW_DPN_PREPARECTRL(p_rt->num);
+
+		if (prep)
+			ret = sdw_update(s_rt->slave, addr,
+					0xFF, p_rt->ch_mask);
+		else
+			ret = sdw_update(s_rt->slave, addr, 0xFF, 0x0);
+
+		if (ret < 0) {
+			dev_err(&s_rt->slave->dev,
+				"Slave prep_ctrl reg write failed");
+			return ret;
+		}
+
+		/* Wait for completion on port ready */
+		port_ready = &s_rt->slave->port_ready[prep_ch.num];
+		time_left = wait_for_completion_timeout(port_ready,
+				msecs_to_jiffies(dpn_prop->ch_prep_timeout));
+
+		val = sdw_read(s_rt->slave, SDW_DPN_PREPARESTATUS(p_rt->num));
+		val &= p_rt->ch_mask;
+		if (!time_left && !val) {
+			dev_err(&s_rt->slave->dev,
+				"Chn prep failed for port:%d", prep_ch.num);
+			return -ETIMEDOUT;
+		}
+	}
+
+	/* Inform slaves about ports being prepared */
+	sdw_do_port_prep(s_rt, prep_ch, SDW_OPS_PORT_POST_PREP);
+
+	/* Disable interrupt after Port de-prepare */
+	if ((!prep) && (intr))
+		ret = sdw_configure_dpn_intr(s_rt->slave, p_rt->num, prep,
+						dpn_prop->device_interrupts);
+
+	return ret;
+}
+
+static int sdw_prep_deprep_mstr_ports(struct sdw_master_runtime *m_rt,
+				struct sdw_port_runtime *p_rt, bool prep)
+{
+	struct sdw_transport_params *t_params = &p_rt->transport_params;
+	struct sdw_bus *bus = m_rt->bus;
+	const struct sdw_master_port_ops *ops = bus->port_ops;
+	struct sdw_prepare_ch prep_ch;
+	int ret = 0;
+
+	prep_ch.num = p_rt->num;
+	prep_ch.ch_mask = p_rt->ch_mask;
+	prep_ch.prepare = prep; /* Prepare/De-prepare */
+	prep_ch.bank = bus->params.next_bank;
+
+	/* Pre-prepare/Pre-deprepare port(s) */
+	if (ops->dpn_port_prep) {
+		ret = ops->dpn_port_prep(bus, &prep_ch);
+		if (ret < 0) {
+			dev_err(bus->dev, "Port prepare failed for port:%d",
+					t_params->port_num);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+/**
+ * sdw_prep_deprep_ports: Prepare/De-prepare port(s) for Master(s) and
+ * Slave(s)
+ *
+ * @m_rt: Master runtime handle
+ * @prep: Prepare or De-prepare
+ */
+static int sdw_prep_deprep_ports(struct sdw_master_runtime *m_rt, bool prep)
+{
+	struct sdw_slave_runtime *s_rt = NULL;
+	struct sdw_port_runtime *p_rt;
+	int ret = 0;
+
+	/* Prepare/De-prepare Slave port(s) */
+	list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
+		list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
+			ret = sdw_prep_deprep_slave_ports(m_rt->bus, s_rt,
+							p_rt, prep);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	/* Prepare/De-prepare Master port(s) */
+	list_for_each_entry(p_rt, &m_rt->port_list, port_node) {
+		ret = sdw_prep_deprep_mstr_ports(m_rt, p_rt, prep);
+		if (ret < 0)
+			return ret;
+	}
+
+	return ret;
+}
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 57aba663a4e3..39fa86a83a1e 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -380,6 +380,37 @@ enum sdw_reg_bank {
 };
 
 /**
+ * struct sdw_prepare_ch: Prepare/De-prepare Data Port channel
+ *
+ * @num: Port number
+ * @ch_mask: Active channel mask
+ * @prepare: Prepare (true) /de-prepare (false) channel
+ * @bank: Register bank, which bank Slave/Master driver should program for
+ * implementation defined registers. This is always updated to next_bank
+ * value read from bus params.
+ *
+ */
+struct sdw_prepare_ch {
+	unsigned int num;
+	unsigned int ch_mask;
+	bool prepare;
+	unsigned int bank;
+};
+
+/**
+ * enum sdw_port_prep_ops: Prepare operations for Data Port
+ *
+ * @SDW_OPS_PORT_PRE_PREP: Pre prepare operation for the Port
+ * @SDW_OPS_PORT_PREP: Prepare operation for the Port
+ * @SDW_OPS_PORT_POST_PREP: Post prepare operation for the Port
+ */
+enum sdw_port_prep_ops {
+	SDW_OPS_PORT_PRE_PREP = 0,
+	SDW_OPS_PORT_PREP = 1,
+	SDW_OPS_PORT_POST_PREP = 2,
+};
+
+/**
  * struct sdw_bus_params: Structure holding bus configuration
  *
  * @curr_bank: Current bank in use (BANK0/BANK1)
@@ -398,6 +429,7 @@ struct sdw_bus_params {
  * @interrupt_callback: Device interrupt notification (invoked in thread
  * context)
  * @update_status: Update Slave status
+ * @port_prep: Prepare the port with parameters
  */
 struct sdw_slave_ops {
 	int (*read_prop)(struct sdw_slave *sdw);
@@ -405,6 +437,9 @@ struct sdw_slave_ops {
 			struct sdw_slave_intr_status *status);
 	int (*update_status)(struct sdw_slave *slave,
 			enum sdw_slave_status status);
+	int (*port_prep)(struct sdw_slave *slave,
+			struct sdw_prepare_ch *prepare_ch,
+			enum sdw_port_prep_ops pre_ops);
 };
 
 /**
@@ -509,6 +544,19 @@ struct sdw_transport_params {
 };
 
 /**
+ * struct sdw_enable_ch: Enable/disable Data Port channel
+ *
+ * @num: Port number
+ * @ch_mask: Active channel mask
+ * @enable: Enable (true) /disable (false) channel
+ */
+struct sdw_enable_ch {
+	unsigned int num;
+	unsigned int ch_mask;
+	bool enable;
+};
+
+/**
  * struct sdw_master_port_ops: Callback functions from bus to Master
  * driver to set Master Data ports.
  *
@@ -516,6 +564,8 @@ struct sdw_transport_params {
  * Mandatory callback
  * @dpn_set_port_transport_params: Set transport parameters for the Master
  * Port. Mandatory callback
+ * @dpn_port_prep: Port prepare operations for the Master Data Port.
+ * @dpn_port_enable_ch: Enable the channels of Master Port.
  */
 struct sdw_master_port_ops {
 	int (*dpn_set_port_params)(struct sdw_bus *bus,
@@ -524,6 +574,10 @@ struct sdw_master_port_ops {
 	int (*dpn_set_port_transport_params)(struct sdw_bus *bus,
 			struct sdw_transport_params *transport_params,
 			enum sdw_reg_bank bank);
+	int (*dpn_port_prep)(struct sdw_bus *bus,
+			struct sdw_prepare_ch *prepare_ch);
+	int (*dpn_port_enable_ch)(struct sdw_bus *bus,
+			struct sdw_enable_ch *enable_ch, unsigned int bank);
 };
 
 struct sdw_msg;
-- 
2.7.4
