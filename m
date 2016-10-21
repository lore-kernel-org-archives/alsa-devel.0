From: Hardik Shah <hardik.t.shah@intel.com>
Subject: [RFC 10/14] SoundWire: Add support for clock stop
Date: Fri, 21 Oct 2016 18:11:08 +0530
Message-ID: <1477053673-16021-11-git-send-email-hardik.t.shah@intel.com>
References: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: tiwai@suse.de, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, lgirdwood@gmail.com, plai@codeaurora.org, patches.audio@intel.com, Hardik Shah <hardik.t.shah@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch adds support for clock stop prepare, clock stop and clock
resume.

As a part of SoundWire clock stop sequence, Master driver needs to call
APIs for.

    1. Prepare Slaves for Clock Stop.
    2. Broadcast ClockStopNow to all Slaves.

As part of SoundWire clock stop resume sequence, Master driver needs to
call APIs for.

    1. De-prepare Slaves exiting from ClockStop mode 0
    2. Optionally de-prepare Slaves exiting from ClockStop mode 1
    based on Slave capabilities.

Signed-off-by: Hardik Shah <hardik.t.shah@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/sdw/sdw.c |  547 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 547 insertions(+)

diff --git a/sound/sdw/sdw.c b/sound/sdw/sdw.c
index 801200f..449060e 100644
--- a/sound/sdw/sdw.c
+++ b/sound/sdw/sdw.c
@@ -671,6 +671,37 @@ static int sdw_transfer(struct sdw_master *mstr, struct sdw_msg *msg, int num,
 	return ret;
 }
 
+/*
+ * NO PM version of Slave transfer. Called from power management APIs
+ * to avoid dead locks. This is called by bus driver only.
+ */
+static int sdw_slv_transfer_nopm(struct sdw_master *mstr,
+			struct sdw_msg *msg, int num)
+{
+	int ret;
+
+	/*
+	 * If calling from atomic context, return immediately if previous
+	 * message has not completed executing
+	 */
+	if (in_atomic() || irqs_disabled()) {
+		ret = mutex_trylock(&mstr->msg_lock);
+		if (!ret) {
+			/* SDW activity is ongoing. */
+			ret = -EAGAIN;
+			goto out;
+		}
+	} else {
+		mutex_lock(&mstr->msg_lock);
+	}
+
+	ret = sdw_transfer(mstr, msg, num, NULL);
+
+	mutex_unlock(&mstr->lock);
+out:
+	return ret;
+}
+
 /**
  * sdw_bank_switch_deferred: Initiate the transfer of the message but
  *	doesn't wait for the message to be completed. Bus driver waits
@@ -1393,6 +1424,189 @@ static void sdw_update_slv_status_event(struct sdw_slave *slave,
 		slv_drv->status_change_event(slave, status);
 }
 
+static int sdw_wait_for_clk_stp_deprep(struct sdw_slave *slave,
+			unsigned int prep_timeout)
+{
+	int ret;
+	struct sdw_msg msg;
+	u8 buf = 0;
+	int count = 0;
+	struct sdw_master *mstr = slave->mstr;
+
+	sdw_create_rd_msg(&msg, 0x0, SDW_SCP_STAT, 1, &buf, slave->dev_num);
+
+	/*
+	 * Read the ClockStopNotFinished bit from the SCP_Stat register of
+	 * particular Slave to make sure that clock stop prepare is done
+	 */
+	do {
+		ret = sdw_slv_transfer_nopm(mstr, &msg, SDW_NUM_OF_MSG1_XFRD);
+		if (ret != SDW_NUM_OF_MSG1_XFRD) {
+			WARN_ONCE(1, "Clock stop status read failed\n");
+			break;
+		}
+
+		if (!(buf & SDW_SCP_STAT_CLK_STP_NF_MASK)) {
+			ret = 0;
+			break;
+		}
+
+		usleep_range(1000, 1200);
+		count++;
+
+	} while (count != prep_timeout);
+
+	if (!(buf & SDW_SCP_STAT_CLK_STP_NF_MASK))
+
+		dev_info(&mstr->dev, "Clock stop prepare done\n");
+	else
+		WARN_ONCE(1, "Clk stp deprepare failed for slave %d\n",
+			slave->dev_num);
+
+	return ret;
+}
+
+/*
+ * This function does one of two things based on "prep" flag.
+ * 1. Prepare Slave for clock stop, if "prep" flag is true.
+ * 2. De-prepare Slave after clock resume, if "prep" flag is false.
+ */
+static void sdw_prepare_slv_for_clk_stp(struct sdw_master *mstr,
+			struct sdw_slave *slave,
+			enum sdw_clk_stop_mode clock_stop_mode,
+			bool prep)
+{
+	bool wake_en;
+	struct sdw_slave_caps *cap;
+	u8 buf = 0;
+	struct sdw_msg msg;
+	int ret;
+
+	cap = &slave->priv.caps;
+
+	wake_en = !cap->wake_up_unavailable;
+
+	if (prep) {
+		/*
+		 * Even if its simplified clock stop prepare, setting
+		 * prepare bit wont harm Here we are not doing write modify
+		 * write since we are updating all fields of SystemCtrl
+		 * registers. Currently highphy is not supported, so
+		 * setting that bit to always 0
+		 */
+		buf |= (1 << SDW_SCP_SYSTEMCTRL_CLK_STP_PREP_SHIFT);
+		buf |= clock_stop_mode <<
+			SDW_SCP_SYSTEMCTRL_CLK_STP_MODE_SHIFT;
+		buf |= wake_en << SDW_SCP_SYSTEMCTRL_WAKE_UP_EN_SHIFT;
+	} else
+		buf = 0;
+
+	/*
+	 * We are calling NOPM version of the transfer API, because Master
+	 * controllers calls this from the suspend handler, so if we call
+	 * the normal transfer API, it tries to resume controller, which
+	 * results in deadlock
+	 */
+	ret = sdw_wr_msg_nopm(&msg, 0x0, SDW_SCP_SYSTEMCTRL, 1, &buf,
+					slave->dev_num, mstr,
+					SDW_NUM_OF_MSG1_XFRD);
+
+	/* We should continue even if it fails for some Slave */
+	if (ret != SDW_NUM_OF_MSG1_XFRD)
+		WARN_ONCE(1, "Clock Stop prepare failed for slave %d\n",
+						slave->dev_num);
+}
+
+/*
+ * This function checks if the Slave is in "prepared" or "de-prepared" state
+ * This is used to de-prepare Slaves which are in "prepared" state after
+ * resuming from ClockStop Mode 1
+ */
+static int sdw_check_for_prep_bit(struct sdw_slave *slave)
+{
+	u8 buf = 0;
+	struct sdw_msg msg;
+	int ret;
+	struct sdw_master *mstr = slave->mstr;
+
+	ret = sdw_rd_msg_nopm(&msg, 0x0, SDW_SCP_SYSTEMCTRL, 1, &buf,
+						slave->dev_num, mstr,
+						SDW_NUM_OF_MSG1_XFRD);
+	if (ret != SDW_NUM_OF_MSG1_XFRD) {
+		dev_err(&mstr->dev, "SCP_SystemCtrl read failed for Slave %d\n",
+				slave->dev_num);
+		return -EINVAL;
+	}
+
+	return !(buf & SDW_SCP_SYSTEMCTRL_CLK_STP_PREP_MASK);
+}
+
+/*
+ * This function De-prepares particular Slave which is resuming from
+ * ClockStop mode1. It does following things.
+ * 1. Check if Slave requires de-prepare based on Slave capabilities.
+ * 2. Check for the "Prepare" bit in SystemCtrl register.
+ * 3. If prepare bit is set Deprepare the Slave.
+ * 4. Wait till Slave is deprepared
+ */
+static int sdw_deprepare_slv_clk_stp1(struct sdw_slave *slave)
+{
+	struct sdw_slave_caps *cap;
+	int ret;
+	struct sdw_master *mstr = slave->mstr;
+	struct sdw_slave_priv *slv_priv = &slave->priv;
+	int prep_timeout = 0;
+
+	cap = &slv_priv->caps;
+
+	/*
+	 * Slave might have enumerated 1st time or from clock stop mode 1
+	 * return if Slave doesn't require deprepare
+	 */
+	if (!cap->clk_stp_prep_hard_reset_behavior)
+		return 0;
+
+	/*
+	 * If Slave requires de-prepare after exiting from Clock Stop mode
+	 * 1, then check for ClockStopPrepare bit in SystemCtrl register if
+	 * its 1, de-prepare Slave from clock stop prepare, else return
+	 */
+	ret = sdw_check_for_prep_bit(slave);
+
+	if (ret < 0)
+		return ret;
+
+	if (slv_priv->driver->pre_clk_stop_prep) {
+		ret = slv_priv->driver->pre_clk_stop_prep(slave,
+				cap->clk_stp1_mode, false);
+		if (ret < 0) {
+			dev_warn(&mstr->dev, "Pre de-prepare failed for Slave %d\n",
+				slave->dev_num);
+			return ret;
+		}
+	}
+
+	prep_timeout = cap->clk_stp_prep_timeout;
+	sdw_prepare_slv_for_clk_stp(slave->mstr, slave, cap->clk_stp1_mode,
+				false);
+
+	/* Make sure de-prepare is complete */
+	ret = sdw_wait_for_clk_stp_deprep(slave, prep_timeout);
+
+	if (ret < 0)
+		return ret;
+
+	if (slv_priv->driver->post_clk_stop_prep) {
+		ret = slv_priv->driver->post_clk_stop_prep(slave,
+				cap->clk_stp1_mode, false);
+
+		if (ret < 0)
+			dev_err(&mstr->dev, "Post de-prepare failed for Slave %d ret = %d\n",
+						slave->dev_num, ret);
+	}
+
+	return ret;
+}
 
 /*
  * Following thing are done in below loop for each of the registered Slaves.
@@ -1470,6 +1684,13 @@ static void sdw_process_slv_status(struct sdw_master *mstr,
 			if (ret < 0)
 				continue;
 
+			ret = sdw_deprepare_slv_clk_stp1(
+					mstr->sdw_addr[i].slave);
+
+			if (ret < 0)
+				continue;
+
+
 			mstr->sdw_addr[i].status =
 				SDW_SLAVE_STAT_ATTACHED_OK;
 		}
@@ -2076,6 +2297,332 @@ void snd_sdw_master_del(struct sdw_master *master)
 }
 EXPORT_SYMBOL_GPL(snd_sdw_master_del);
 
+static enum sdw_clk_stop_mode sdw_slv_get_clk_stp_mode(struct sdw_slave *slave)
+{
+	enum sdw_clk_stop_mode clock_stop_mode;
+	struct sdw_slave_priv *slv_priv = &slave->priv;
+	struct sdw_slave_caps *cap = &slv_priv->caps;
+
+	/*
+	 * Get the dynamic value of clock stop from Slave driver if
+	 * supported, else use the static value from capabilities register.
+	 * Update the capabilities also if we have new dynamic value.
+	 */
+	if (slv_priv->driver->get_dyn_clk_stp_mod) {
+		clock_stop_mode = slv_priv->driver->get_dyn_clk_stp_mod(slave);
+		if (clock_stop_mode == SDW_CLOCK_STOP_MODE_1)
+			cap->clk_stp1_mode = true;
+		else
+			cap->clk_stp1_mode = false;
+	} else
+		clock_stop_mode = cap->clk_stp1_mode;
+
+	return clock_stop_mode;
+}
+
+/**
+ * snd_sdw_master_stop_clock: Stop the clock. This function broadcasts the
+ *	SCP_CTRL register with clock_stop_now bit set.
+ *
+ * @master: Master handle for which clock has to be stopped.
+ */
+int snd_sdw_master_stop_clock(struct sdw_master *master)
+{
+	int ret, i;
+	struct sdw_msg msg;
+	u8 buf = 0;
+	enum sdw_clk_stop_mode mode;
+
+	/*
+	 * Send Broadcast message to the SCP_ctrl register with clock stop
+	 * now. If none of the Slaves are attached, then there may not be
+	 * ACK, flag the error about ACK not received but clock will be
+	 * still stopped.
+	 */
+
+	buf |= 0x1 << SDW_SCP_CTRL_CLK_STP_NOW_SHIFT;
+	ret = sdw_wr_msg_nopm(&msg, 0x0, SDW_SCP_CTRL, 1, &buf,
+				SDW_SLAVE_BDCAST_ADDR, master,
+				SDW_NUM_OF_MSG1_XFRD);
+	if (ret != SDW_NUM_OF_MSG1_XFRD)
+		dev_err(&master->dev, "ClockStopNow Broadcast message failed\n");
+
+	/*
+	 * Mark all Slaves as un-attached which are entering clock stop
+	 * mode1
+	 */
+	for (i = 1; i <= SDW_MAX_DEVICES; i++) {
+
+		if (!master->sdw_addr[i].assigned)
+			continue;
+
+		/* Get clock stop mode for all Slaves */
+		mode = sdw_slv_get_clk_stp_mode(master->sdw_addr[i].slave);
+		if (mode == SDW_CLOCK_STOP_MODE_0)
+			continue;
+
+		/* If clock stop mode 1, mark Slave as not present */
+		master->sdw_addr[i].status = SDW_SLAVE_STAT_NOT_PRESENT;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_sdw_master_stop_clock);
+
+static struct sdw_slave *sdw_get_slv_status(struct sdw_master *mstr,
+					int *slave_index)
+{
+	int i;
+
+	for (i = *slave_index; i <= SDW_MAX_DEVICES; i++) {
+		if (mstr->sdw_addr[i].assigned != true)
+			continue;
+
+		if (mstr->sdw_addr[i].status == SDW_SLAVE_STAT_NOT_PRESENT)
+			continue;
+
+		*slave_index = i + 1;
+		return mstr->sdw_addr[i].slave;
+	}
+	return NULL;
+}
+
+/*
+ * Wait till ClockStop prepared/De-prepared is finished, Broadcasts the read
+ * message to read the SCP_STAT register. Wait till ClockStop_NotFinished bit
+ * is set. Break loop after timeout.
+ */
+static void sdw_wait_for_clk_stp_prep(struct sdw_master *mstr, unsigned int
+			prep_timeout)
+{
+	int ret;
+	struct sdw_msg msg;
+	u8 buf = 0;
+	int count = 0;
+
+	/* Create message to read clock stop status, its broadcast message. */
+	sdw_create_rd_msg(&msg, 0x0, SDW_SCP_STAT, 1, &buf,
+				SDW_SLAVE_BDCAST_ADDR);
+	/*
+	 * Once all the Slaves are written with prepare bit, broadcast the
+	 * read message for the SCP_STAT register to read the
+	 * ClockStopNotFinished bit. Read till we get this a 0. Currently
+	 * we have timeout of 1sec before giving up. Even if its not read as
+	 * 0 after timeout, controller can stop the clock after warning.
+	 */
+	do {
+		ret = sdw_slv_transfer_nopm(mstr, &msg, SDW_NUM_OF_MSG1_XFRD);
+		if (ret != SDW_NUM_OF_MSG1_XFRD) {
+			WARN_ONCE(1, "Clock stop status read failed\n");
+			break;
+		}
+
+		if (!(buf & SDW_SCP_STAT_CLK_STP_NF_MASK))
+			break;
+
+		/*
+		 * Sleep in range of 1ms for the max number of millisecond
+		 * of timeout
+		 */
+		usleep_range(1000, 1200);
+		count++;
+
+	} while (count != prep_timeout);
+
+	if (!(buf & SDW_SCP_STAT_CLK_STP_NF_MASK))
+		dev_info(&mstr->dev, "Clock stop prepare done\n");
+	else
+		WARN_ONCE(1, "Some Slaves prepare un-successful\n");
+}
+
+/**
+ * snd_sdw_master_prepare_for_clk_stop: Prepare all the Slaves for clock
+ *	stop. Iterate through each of the enumerated Slaves. Prepare each
+ *	Slave according to the clock stop mode supported by Slave. Use
+ *	dynamic value from Slave callback if registered, else use static
+ *	values from Slave capabilities registered.
+ *	1. Get clock stop mode for each Slave.
+ *	2. Call pre_prepare callback of each Slave if registered.
+ *	3. Write ClockStopPrepare bit in SCP_SystemCtrl register for each of
+ *	the enumerated Slaves.
+ *	4. Broadcast the read message to read the SCP_Stat register to make
+ *	sure ClockStop Prepare is finished for all Slaves.
+ *	5. Call post_prepare callback of each Slave if registered after
+ *	Slaves are in ClockStopPrepare state.
+ *
+ * @master: Master handle for which clock state has to be changed.
+ */
+int snd_sdw_master_prepare_for_clk_stop(struct sdw_master *master)
+{
+	struct sdw_slave_caps *cap;
+	enum sdw_clk_stop_mode clock_stop_mode;
+	int ret;
+	struct sdw_slave *slave = NULL;
+	int slv_index = 1;
+	unsigned int prep_timeout = 0;
+
+	/*
+	 * Get all the Slaves registered to the Master driver for preparing
+	 * for clock stop. Start from Slave with logical address as 1.
+	 */
+	while ((slave = sdw_get_slv_status(master, &slv_index)) != NULL) {
+
+		struct sdw_slave_priv *slv_priv = &slave->priv;
+
+		cap = &slv_priv->caps;
+
+		clock_stop_mode = sdw_slv_get_clk_stp_mode(slave);
+
+		/*
+		 * Call the pre clock stop prepare, if Slave requires.
+		 */
+		if (slv_priv->driver->pre_clk_stop_prep) {
+			ret = slv_priv->driver->pre_clk_stop_prep(slave,
+						clock_stop_mode, true);
+
+			/* If it fails we still continue */
+			if (ret < 0)
+				dev_warn(&master->dev, "Pre prepare failed for Slave %d\n",
+						slave->dev_num);
+		}
+
+		sdw_prepare_slv_for_clk_stp(master, slave, clock_stop_mode,
+								true);
+
+		if (prep_timeout > cap->clk_stp_prep_timeout)
+			prep_timeout = cap->clk_stp_prep_timeout;
+	}
+
+	/* Wait till prepare for all Slaves is finished */
+	sdw_wait_for_clk_stp_prep(master, prep_timeout);
+
+	slv_index = 1;
+	while ((slave = sdw_get_slv_status(master, &slv_index)) != NULL) {
+
+		struct sdw_slave_priv *slv_priv = &slave->priv;
+
+		cap = &slv_priv->caps;
+
+		clock_stop_mode = sdw_slv_get_clk_stp_mode(slave);
+
+		if (slv_priv->driver->post_clk_stop_prep) {
+			ret = slv_priv->driver->post_clk_stop_prep(slave,
+							clock_stop_mode,
+							true);
+			/*
+			 * Even if Slave fails we continue with other
+			 * Slaves. This should never happen ideally.
+			 */
+			if (ret < 0)
+				dev_err(&master->dev, "Post prepare failed for Slave %d ret = %d\n",
+							slave->dev_num, ret);
+
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_sdw_master_prepare_for_clk_stop);
+
+/**
+ * snd_sdw_master_deprepare_after_clk_start: De-prepare all the Slaves
+ *	exiting clock stop mode 0 after clock resumes. Clock is already
+ *	resumed before this. De-prepare for the Slaves which were there in
+ *	clock stop mode 1 is done after they enumerated back. This is because
+ *	Slave specific callbacks needs to be invoked as part of de-prepare,
+ *	which can be invoked only after Slave enumerates.
+ *	1. Get clock stop mode for each Slave.
+ *	2. Call pre_prepare callback of each Slave exiting from clock stop
+ *	mode 0.
+ *	3. De-Prepare each Slave exiting from clock stop mode 0
+ *	4. Broadcast the Read message to make sure all Slaves are
+ *	de-prepared for clock stop.
+ *	5. Call post_prepare callback of each Slave exiting from clock stop
+ *	mode0
+ *
+ * @master: Master handle
+ */
+int snd_sdw_master_deprepare_after_clk_start(struct sdw_master *master)
+{
+	struct sdw_slave_caps *cap;
+	enum sdw_clk_stop_mode clock_stop_mode;
+	int ret = 0;
+	struct sdw_slave *slave = NULL;
+	bool stop = false;
+	int slv_index = 1;
+	unsigned int prep_timeout = 0;
+
+	while ((slave = sdw_get_slv_status(master, &slv_index)) != NULL) {
+		struct sdw_slave_priv *slv_priv = &slave->priv;
+
+		cap = &slv_priv->caps;
+
+		/* Get the clock stop mode from which Slave is exiting */
+		clock_stop_mode = sdw_slv_get_clk_stp_mode(slave);
+
+		/*
+		 * Slave is exiting from Clock stop mode 1, De-prepare is
+		 * optional based on capability, and it has to be done after
+		 * Slave is enumerated. So nothing to be done here.
+		 */
+		if (clock_stop_mode == SDW_CLOCK_STOP_MODE_1)
+			continue;
+		/*
+		 * Call the pre clock stop prepare, if Slave requires.
+		 */
+		if (slv_priv->driver->pre_clk_stop_prep)
+			ret = slv_priv->driver->pre_clk_stop_prep(slave,
+						clock_stop_mode, false);
+
+		/* If it fails we still continue */
+		if (ret < 0)
+			dev_warn(&master->dev, "Pre de-prepare failed for Slave %d ret = %d\n",
+						slave->dev_num, ret);
+
+		sdw_prepare_slv_for_clk_stp(master, slave, clock_stop_mode,
+						false);
+		if (prep_timeout > cap->clk_stp_prep_timeout)
+			prep_timeout = cap->clk_stp_prep_timeout;
+	}
+
+	/*
+	 * Wait till de-prepare is finished for all the Slaves.
+	 */
+	sdw_wait_for_clk_stp_prep(master, prep_timeout);
+
+	slv_index = 1;
+	while ((slave = sdw_get_slv_status(master, &slv_index)) != NULL) {
+
+		struct sdw_slave_priv *slv_priv = &slave->priv;
+
+		cap = &slv_priv->caps;
+
+		clock_stop_mode = sdw_slv_get_clk_stp_mode(slave);
+
+		/*
+		 * Slave is exiting from Clock stop mode 1, De-prepare is
+		 * optional based on capability, and it has to be done after
+		 * Slave is enumerated.
+		 */
+		if (clock_stop_mode == SDW_CLOCK_STOP_MODE_1)
+			continue;
+
+		if (slv_priv->driver->post_clk_stop_prep)
+			ret = slv_priv->driver->post_clk_stop_prep(slave,
+							clock_stop_mode,
+							stop);
+			/*
+			 * Even if Slave fails we continue with other
+			 * Slaves. This should never happen ideally.
+			 */
+			if (ret < 0)
+				dev_err(&master->dev, "Post de-prepare failed for Slave %d ret = %d\n",
+							slave->dev_num, ret);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_sdw_master_deprepare_after_clk_start);
+
 /**
  * snd_sdw_master_get: Return the Master handle from Master number.
  *	Increments the reference count of the module. Similar to
-- 
1.7.9.5
