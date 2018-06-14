From: Shreyas NC <shreyas.nc@intel.com>
Subject: [PATCH v3 5/6] soundwire: Add support for multi link
	bank switch
Date: Thu, 14 Jun 2018 17:02:02 +0530
Message-ID: <1528975923-15141-6-git-send-email-shreyas.nc@intel.com>
References: <1528975923-15141-1-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 4309C26760F
 for <alsa-devel@alsa-project.org>; Thu, 14 Jun 2018 13:34:32 +0200 (CEST)
In-Reply-To: <1528975923-15141-1-git-send-email-shreyas.nc@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: patches.audio@intel.com, gregkh@linuxfoundation.org, pierre-louis.bossart@linux.intel.com, vkoul@kernel.org, Shreyas NC <shreyas.nc@intel.com>, sanyog.r.kale@intel.com
List-Id: alsa-devel@alsa-project.org

In cases of multiple Masters in a stream, synchronization
between multiple Master(s) is achieved by performing bank switch
together and using Master methods.

Add sdw_ml_bank_switch() to wait for completion of bank switch.

Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
---
 drivers/soundwire/bus.h       |   2 +
 drivers/soundwire/stream.c    | 116 ++++++++++++++++++++++++++++++++++++++----
 include/linux/soundwire/sdw.h |   2 +
 3 files changed, 110 insertions(+), 10 deletions(-)

diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index b6cfbdf..c77de05 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -4,6 +4,8 @@
 #ifndef __SDW_BUS_H
 #define __SDW_BUS_H
 
+#define DEFAULT_BANK_SWITCH_TIMEOUT 3000
+
 #if IS_ENABLED(CONFIG_ACPI)
 int sdw_acpi_find_slaves(struct sdw_bus *bus);
 #else
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 0e8a2eb5..771c963 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -638,6 +638,8 @@ static int sdw_bank_switch(struct sdw_bus *bus)
 	if (!wr_msg)
 		return -ENOMEM;
 
+	bus->defer_msg.msg = wr_msg;
+
 	wbuf = kzalloc(sizeof(*wbuf), GFP_KERNEL);
 	if (!wbuf) {
 		ret = -ENOMEM;
@@ -658,17 +660,23 @@ static int sdw_bank_switch(struct sdw_bus *bus)
 					SDW_MSG_FLAG_WRITE, wbuf);
 	wr_msg->ssp_sync = true;
 
-	ret = sdw_transfer(bus, wr_msg);
+	if (bus->multi_link)
+		ret = sdw_transfer_defer(bus, wr_msg, &bus->defer_msg);
+	else
+		ret = sdw_transfer(bus, wr_msg);
+
 	if (ret < 0) {
 		dev_err(bus->dev, "Slave frame_ctrl reg write failed");
 		goto error;
 	}
 
-	kfree(wr_msg);
-	kfree(wbuf);
-	bus->defer_msg.msg = NULL;
-	bus->params.curr_bank = !bus->params.curr_bank;
-	bus->params.next_bank = !bus->params.next_bank;
+	if (!bus->multi_link) {
+		kfree(wr_msg);
+		kfree(wbuf);
+		bus->defer_msg.msg = NULL;
+		bus->params.curr_bank = !bus->params.curr_bank;
+		bus->params.next_bank = !bus->params.next_bank;
+	}
 
 	return 0;
 
@@ -679,36 +687,88 @@ static int sdw_bank_switch(struct sdw_bus *bus)
 	return ret;
 }
 
+/**
+ * sdw_ml_sync_bank_switch: Multilink register bank switch
+ *
+ * @bus: SDW bus instance
+ *
+ * Caller function should free the buffers on error
+ */
+static int sdw_ml_sync_bank_switch(struct sdw_bus *bus)
+{
+	unsigned long time_left;
+	int ret = 0;
+
+	if (!bus->multi_link)
+		return ret;
+
+	/* Wait for completion of transfer */
+	time_left = wait_for_completion_timeout(&bus->defer_msg.complete,
+						bus->bank_switch_timeout);
+
+	if (!time_left) {
+		dev_err(bus->dev, "Controller Timed out on bank switch");
+		return -ETIMEDOUT;
+	}
+
+	bus->params.curr_bank = !bus->params.curr_bank;
+	bus->params.next_bank = !bus->params.next_bank;
+
+	if (bus->defer_msg.msg) {
+		kfree(bus->defer_msg.msg->buf);
+		kfree(bus->defer_msg.msg);
+	}
+
+	return ret;
+}
+
 static int do_bank_switch(struct sdw_stream_runtime *stream)
 {
 	struct sdw_master_runtime *m_rt = NULL;
 	const struct sdw_master_ops *ops;
 	struct sdw_bus *bus = NULL;
+	bool multi_link = false;
 	int ret = 0;
 
-
 	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
 		bus = m_rt->bus;
 		ops = bus->ops;
 
+		if (bus->multi_link) {
+			multi_link = true;
+			mutex_lock(&bus->msg_lock);
+		}
+
 		/* Pre-bank switch */
 		if (ops->pre_bank_switch) {
 			ret = ops->pre_bank_switch(bus);
 			if (ret < 0) {
 				dev_err(bus->dev,
 					"Pre bank switch op failed: %d", ret);
-				return ret;
+				goto msg_unlock;
 			}
 		}
 
-		/* Bank switch */
+		/*
+		 * Perform Bank switch operation.
+		 * For multi link cases, the actual bank switch is
+		 * synchronized across all Masters and happens later as a
+		 * part of post_bank_switch ops.
+		 */
 		ret = sdw_bank_switch(bus);
 		if (ret < 0) {
 			dev_err(bus->dev, "Bank switch failed: %d", ret);
-			return ret;
+			goto error;
+
 		}
 	}
 
+	/*
+	 * For multi link cases, it is expected that the bank switch is
+	 * triggered by the post_bank_switch for the first Master in the list
+	 * and for the other Masters the post_bank_switch() should return doing
+	 * nothing.
+	 */
 	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
 		bus = m_rt->bus;
 		ops = bus->ops;
@@ -719,8 +779,44 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
 			if (ret < 0) {
 				dev_err(bus->dev,
 					"Post bank switch op failed: %d", ret);
+				goto error;
 			}
 		}
+
+		/* Set the bank switch timeout to default, if not set */
+		if (!bus->bank_switch_timeout)
+			bus->bank_switch_timeout = DEFAULT_BANK_SWITCH_TIMEOUT;
+
+		/* Check if bank switch was successful */
+		ret = sdw_ml_sync_bank_switch(bus);
+		if (ret < 0) {
+			dev_err(bus->dev,
+				"multi link bank switch failed: %d", ret);
+			goto error;
+		}
+
+		mutex_unlock(&bus->msg_lock);
+	}
+
+	return ret;
+
+error:
+	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
+
+		bus = m_rt->bus;
+
+		kfree(bus->defer_msg.msg->buf);
+		kfree(bus->defer_msg.msg);
+	}
+
+msg_unlock:
+
+	if (multi_link) {
+		list_for_each_entry(m_rt, &stream->master_list, stream_node) {
+			bus = m_rt->bus;
+			if (mutex_is_locked(&bus->msg_lock))
+				mutex_unlock(&bus->msg_lock);
+		}
 	}
 
 	return ret;
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 03df709..f006029 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -673,6 +673,7 @@ struct sdw_master_ops {
  * @params: Current bus parameters
  * @prop: Master properties
  * @m_rt_list: List of Master instance of all stream(s) running on Bus. This
+ * @multi_link: if multi links are supported
  * is used to compute and program bus bandwidth, clock, frame shape,
  * transport and port parameters
  * @defer_msg: Defer message
@@ -691,6 +692,7 @@ struct sdw_bus {
 	struct sdw_bus_params params;
 	struct sdw_master_prop prop;
 	struct list_head m_rt_list;
+	bool multi_link;
 	struct sdw_defer defer_msg;
 	unsigned int clk_stop_timeout;
 	u32 bank_switch_timeout;
-- 
2.7.4
