From: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 04/14] soundwire: remove empty line
	before/after braces
Date: Thu,  2 May 2019 16:29:20 +0530
Message-ID: <20190502105930.9889-5-vkoul@kernel.org>
References: <20190502105930.9889-1-vkoul@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CA77BF89721
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2019 13:00:23 +0200 (CEST)
In-Reply-To: <20190502105930.9889-1-vkoul@kernel.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Greg KH <gregkh@linuxfoundation.org>, Sanyog Kale <sanyog.r.kale@intel.com>, Vinod Koul <vkoul@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

Linux code style doesn't expect empty lines before or after braces and
gives warning:

CHECK: Blank lines aren't necessary after an open brace '{'
CHECK: Blank lines aren't necessary before a close brace '}'

Fix these instances in soundwire core

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soundwire/bus.c        | 8 --------
 drivers/soundwire/mipi_disco.c | 6 ------
 drivers/soundwire/stream.c     | 8 --------
 3 files changed, 22 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index fa86957cb615..e2ee305905a6 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -391,7 +391,6 @@ EXPORT_SYMBOL(sdw_read);
 int sdw_write(struct sdw_slave *slave, u32 addr, u8 value)
 {
 	return sdw_nwrite(slave, addr, 1, &value);
-
 }
 EXPORT_SYMBOL(sdw_write);
 
@@ -414,7 +413,6 @@ static struct sdw_slave *sdw_get_slave(struct sdw_bus *bus, int i)
 
 static int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id)
 {
-
 	if (slave->id.unique_id != id.unique_id ||
 	    slave->id.mfg_id != id.mfg_id ||
 	    slave->id.part_id != id.part_id ||
@@ -467,7 +465,6 @@ static int sdw_assign_device_num(struct sdw_slave *slave)
 		/* Clear the slave->dev_num to transfer message on device 0 */
 		dev_num = slave->dev_num;
 		slave->dev_num = 0;
-
 	}
 
 	ret = sdw_write(slave, SDW_SCP_DEVNUMBER, dev_num);
@@ -508,7 +505,6 @@ void sdw_extract_slave_id(struct sdw_bus *bus,
 		"SDW Slave class_id %x, part_id %x, mfg_id %x, unique_id %x, version %x\n",
 				id->class_id, id->part_id, id->mfg_id,
 				id->unique_id, id->sdw_version);
-
 }
 
 static int sdw_program_device_num(struct sdw_bus *bus)
@@ -677,7 +673,6 @@ static int sdw_handle_dp0_interrupt(struct sdw_slave *slave, u8 *slave_status)
 	}
 
 	do {
-
 		if (status & SDW_DP0_INT_TEST_FAIL) {
 			dev_err(&slave->dev, "Test fail for port 0\n");
 			clear |= SDW_DP0_INT_TEST_FAIL;
@@ -754,7 +749,6 @@ static int sdw_handle_port_interrupt(struct sdw_slave *slave,
 	}
 
 	do {
-
 		if (status & SDW_DPN_INT_TEST_FAIL) {
 			dev_err(&slave->dev, "Test fail for port:%d\n", port);
 			clear |= SDW_DPN_INT_TEST_FAIL;
@@ -867,7 +861,6 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		for_each_set_bit(bit, &port, 8) {
 			sdw_handle_port_interrupt(slave, bit,
 						  &port_status[bit]);
-
 		}
 
 		/* Check if cascade 2 interrupt is present */
@@ -1035,7 +1028,6 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 		if (ret)
 			dev_err(slave->bus->dev,
 				"Update Slave status failed:%d\n", ret);
-
 	}
 
 	return ret;
diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index 2bf4046e68b6..c1f51d6a23d2 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -63,7 +63,6 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 	nval = fwnode_property_read_u32_array(link,
 			"mipi-sdw-clock-frequencies-supported", NULL, 0);
 	if (nval > 0) {
-
 		prop->num_freq = nval;
 		prop->freq = devm_kcalloc(bus->dev, prop->num_freq,
 					  sizeof(*prop->freq), GFP_KERNEL);
@@ -90,7 +89,6 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 	nval = fwnode_property_read_u32_array(link,
 			"mipi-sdw-supported-clock-gears", NULL, 0);
 	if (nval > 0) {
-
 		prop->num_clk_gears = nval;
 		prop->clk_gears = devm_kcalloc(bus->dev, prop->num_clk_gears,
 					       sizeof(*prop->clk_gears),
@@ -197,7 +195,6 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 		nval = fwnode_property_read_u32_array(node,
 				"mipi-sdw-port-wordlength-configs", NULL, 0);
 		if (nval > 0) {
-
 			dpn[i].num_words = nval;
 			dpn[i].words = devm_kcalloc(&slave->dev,
 						    dpn[i].num_words,
@@ -238,7 +235,6 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 		nval = fwnode_property_read_u32_array(node,
 				"mipi-sdw-channel-number-list", NULL, 0);
 		if (nval > 0) {
-
 			dpn[i].num_ch = nval;
 			dpn[i].ch = devm_kcalloc(&slave->dev, dpn[i].num_ch,
 						 sizeof(*dpn[i].ch),
@@ -254,7 +250,6 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 		nval = fwnode_property_read_u32_array(node,
 				"mipi-sdw-channel-combination-list", NULL, 0);
 		if (nval > 0) {
-
 			dpn[i].num_ch_combinations = nval;
 			dpn[i].ch_combinations = devm_kcalloc(&slave->dev,
 					dpn[i].num_ch_combinations,
@@ -354,7 +349,6 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 	if (!port) {
 		dev_dbg(dev, "DP0 node not found!!\n");
 	} else {
-
 		prop->dp0_prop = devm_kzalloc(&slave->dev,
 					      sizeof(*prop->dp0_prop),
 					      GFP_KERNEL);
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 166b0c16003f..032a326a96d7 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -771,7 +771,6 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
 		if (ret < 0) {
 			dev_err(bus->dev, "Bank switch failed: %d\n", ret);
 			goto error;
-
 		}
 	}
 
@@ -818,7 +817,6 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
 
 error:
 	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
-
 		bus = m_rt->bus;
 
 		kfree(bus->defer_msg.msg->buf);
@@ -985,13 +983,11 @@ static void sdw_slave_port_release(struct sdw_bus *bus,
 
 	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
 		list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
-
 			if (s_rt->slave != slave)
 				continue;
 
 			list_for_each_entry_safe(p_rt, _p_rt,
 						 &s_rt->port_list, port_node) {
-
 				list_del(&p_rt->port_node);
 				kfree(p_rt);
 			}
@@ -1017,7 +1013,6 @@ static void sdw_release_slave_stream(struct sdw_slave *slave,
 		/* Retrieve Slave runtime handle */
 		list_for_each_entry_safe(s_rt, _s_rt,
 					 &m_rt->slave_rt_list, m_rt_node) {
-
 			if (s_rt->slave == slave) {
 				list_del(&s_rt->m_rt_node);
 				kfree(s_rt);
@@ -1070,7 +1065,6 @@ int sdw_stream_remove_master(struct sdw_bus *bus,
 
 	list_for_each_entry_safe(m_rt, _m_rt,
 				 &stream->master_list, stream_node) {
-
 		if (m_rt->bus != bus)
 			continue;
 
@@ -1492,7 +1486,6 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream)
 			dev_err(bus->dev, "Program params failed: %d\n", ret);
 			goto restore_params;
 		}
-
 	}
 
 	ret = do_bank_switch(stream);
@@ -1693,7 +1686,6 @@ static int _sdw_deprepare_stream(struct sdw_stream_runtime *stream)
 			dev_err(bus->dev, "Program params failed: %d\n", ret);
 			return ret;
 		}
-
 	}
 
 	stream->state = SDW_STREAM_DEPREPARED;
-- 
2.20.1
