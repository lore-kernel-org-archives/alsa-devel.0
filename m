From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 07/13] soundwire: Add stream configuration APIs
Date: Wed, 28 Mar 2018 15:08:32 +0530
Message-ID: <1522229918-4748-8-git-send-email-vinod.koul@intel.com>
References: <1522229918-4748-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 6435C26732A
 for <alsa-devel@alsa-project.org>; Wed, 28 Mar 2018 11:34:50 +0200 (CEST)
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
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Add APIs for prepare, enable, disable and de-prepare stream.

Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/soundwire/bus.c       |  14 ++++
 drivers/soundwire/bus.h       |   6 ++
 drivers/soundwire/runtime.c   | 164 ++++++++++++++++++++++++++++++++++++++++++
 drivers/soundwire/stream.c    | 151 ++++++++++++++++++++++++++++++++++++++
 include/linux/soundwire/sdw.h |   4 ++
 5 files changed, 339 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 6cdb08b8781b..6f319bfde569 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -17,6 +17,7 @@
  */
 int sdw_add_bus_master(struct sdw_bus *bus)
 {
+	struct sdw_master_prop *prop = NULL;
 	int ret;
 
 	if (!bus->dev) {
@@ -78,6 +79,19 @@ int sdw_add_bus_master(struct sdw_bus *bus)
 		return ret;
 	}
 
+	/*
+	 * Initialize clock values based on Master properties. The max
+	 * frequency is read from max_freq property. Current assumption
+	 * is that the bus will start at highest clock frequency when
+	 * powered on.
+	 *
+	 * Default active bank will be 0 as out of reset the Slaves have to
+	 * start with bank 0 (Table 40 of Spec)
+	 */
+
+	prop = &bus->prop;
+	bus->params.max_dr_freq = prop->max_freq * SDW_DOUBLE_RATE_FACTOR;
+	bus->params.curr_dr_freq = bus->params.max_dr_freq;
 	bus->params.curr_bank = SDW_BANK0;
 	bus->params.next_bank = SDW_BANK1;
 
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 03a56a7feba1..60419e56bdb7 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -46,6 +46,7 @@ struct sdw_msg {
 };
 
 #define SDW_DOUBLE_RATE_FACTOR		2
+#define SDW_FREQ_MOD_FACTOR		3000
 
 extern int rows[SDW_FRAME_ROWS];
 extern int cols[SDW_FRAME_COLS];
@@ -114,6 +115,11 @@ struct sdw_master_runtime {
 	struct list_head bus_node;
 };
 
+int _sdw_prepare_stream(struct sdw_stream_runtime *stream);
+int _sdw_enable_stream(struct sdw_stream_runtime *stream);
+int _sdw_deprepare_stream(struct sdw_stream_runtime *stream);
+int _sdw_disable_stream(struct sdw_stream_runtime *stream);
+
 struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
 				enum sdw_data_direction direction,
 				unsigned int port_num);
diff --git a/drivers/soundwire/runtime.c b/drivers/soundwire/runtime.c
index 9bc876d23a4c..d19c36329033 100644
--- a/drivers/soundwire/runtime.c
+++ b/drivers/soundwire/runtime.c
@@ -741,3 +741,167 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
 err:
 	return ret;
 }
+
+/**
+ * _sdw_deprepare_stream: De-prepare stream
+ *
+ * @stream: Stream runtime handle
+ */
+int _sdw_deprepare_stream(struct sdw_stream_runtime *stream)
+{
+	struct sdw_master_runtime *m_rt = stream->m_rt;
+	struct sdw_bus *bus = m_rt->bus;
+	int ret = 0;
+
+	/* De-prepare port(s) */
+	ret = sdw_prep_deprep_ports(m_rt, false);
+	if (ret < 0) {
+		dev_err(bus->dev, "De-prepare port(s) failed: %d", ret);
+		return ret;
+	}
+
+	bus->params.bandwidth -= m_rt->stream->params.rate *
+		m_rt->ch_count * m_rt->stream->params.bps;
+
+	if (!bus->params.bandwidth) {
+		bus->params.row = 0;
+		bus->params.col = 0;
+		goto exit;
+
+	}
+
+	/* Program params */
+	ret = sdw_program_params(bus);
+	if (ret < 0) {
+		dev_err(bus->dev, "Program params failed: %d", ret);
+		return ret;
+	}
+
+	return do_bank_switch(stream);
+
+exit:
+	stream->state = SDW_STREAM_DEPREPARE;
+
+	return ret;
+}
+
+/**
+ * _sdw_disable_stream: Disable stream
+ *
+ * @stream: Stream runtime handle
+ */
+int _sdw_disable_stream(struct sdw_stream_runtime *stream)
+{
+	struct sdw_master_runtime *m_rt = stream->m_rt;
+	struct sdw_bus *bus = m_rt->bus;
+	int ret;
+
+	/* Disable port(s) */
+	ret = sdw_enable_disable_ports(m_rt, false);
+	if (ret < 0) {
+		dev_err(bus->dev, "Disable port(s) failed: %d", ret);
+		return ret;
+	}
+
+	stream->state = SDW_STREAM_DISABLE;
+
+	/* Program params */
+	ret = sdw_program_params(bus);
+	if (ret < 0) {
+		dev_err(bus->dev, "Program params failed: %d", ret);
+		return ret;
+	}
+
+	return do_bank_switch(stream);
+}
+
+/**
+ * _sdw_enable_stream: Enable stream
+ *
+ * @stream: Stream runtime handle
+ */
+int _sdw_enable_stream(struct sdw_stream_runtime *stream)
+{
+	struct sdw_master_runtime *m_rt = stream->m_rt;
+	struct sdw_bus *bus = m_rt->bus;
+	int ret;
+
+	/* Program params */
+	ret = sdw_program_params(bus);
+	if (ret < 0) {
+		dev_err(bus->dev, "Program params failed: %d", ret);
+		return ret;
+	}
+
+	/* Enable port(s) */
+	ret = sdw_enable_disable_ports(m_rt, true);
+	if (ret < 0) {
+		dev_err(bus->dev, "Enable port(s) failed ret: %d", ret);
+		return ret;
+	}
+
+	ret = do_bank_switch(stream);
+	if (ret < 0) {
+		dev_err(bus->dev, "Bank switch failed: %d", ret);
+		return ret;
+	}
+
+	stream->state = SDW_STREAM_ENABLE;
+	return 0;
+}
+
+/**
+ * sdw_prepare_stream: Prepare stream
+ *
+ * @stream: Stream runtime handle
+ */
+int _sdw_prepare_stream(struct sdw_stream_runtime *stream)
+{
+	struct sdw_master_runtime *m_rt = stream->m_rt;
+	struct sdw_bus *bus = m_rt->bus;
+	struct sdw_master_prop *prop = NULL;
+	struct sdw_bus_params params;
+	int ret;
+
+	prop = &bus->prop;
+	memcpy(&params, &bus->params, sizeof(params));
+
+	/* TODO: Support Asynchronous mode */
+	if ((prop->max_freq % stream->params.rate) != 0) {
+		dev_err(bus->dev, "Async mode not supported");
+		return -EINVAL;
+	}
+
+	/* Increment cumulative bus bandwidth */
+	bus->params.bandwidth += m_rt->stream->params.rate *
+		m_rt->ch_count * m_rt->stream->params.bps;
+
+	/* Program params */
+	ret = sdw_program_params(bus);
+	if (ret < 0) {
+		dev_err(bus->dev, "Program params failed: %d", ret);
+		goto restore_params;
+	}
+
+	ret = do_bank_switch(stream);
+	if (ret < 0) {
+		dev_err(bus->dev, "Bank switch failed: %d", ret);
+		goto restore_params;
+	}
+
+	/* Prepare port(s) on the new clock configuration */
+	ret = sdw_prep_deprep_ports(m_rt, true);
+	if (ret < 0) {
+		dev_err(bus->dev, "Prepare port(s) failed ret = %d",
+				ret);
+		return ret;
+	}
+
+	stream->state = SDW_STREAM_PREPARE;
+
+	return ret;
+
+restore_params:
+	memcpy(&bus->params, &params, sizeof(params));
+	return ret;
+}
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index a29447e9a2f0..f7efb7296877 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -525,3 +525,154 @@ struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
 
 	return NULL;
 }
+
+/**
+ * sdw_prepare_stream: Prepare SoundWire stream
+ *
+ * @stream: Soundwire stream
+ *
+ * Documentation/soundwire/stream.txt explains this API in detail
+ */
+int sdw_prepare_stream(struct sdw_stream_runtime *stream)
+{
+	int ret = 0;
+
+	if (!stream) {
+		pr_err("SoundWire: Handle not found for stream");
+		return -EINVAL;
+	}
+
+	mutex_lock(&stream->m_rt->bus->bus_lock);
+
+	if (stream->state == SDW_STREAM_DISABLE)
+		goto error;
+
+	if ((stream->state != SDW_STREAM_CONFIG) &&
+		(stream->state != SDW_STREAM_DEPREPARE)) {
+		ret = -EINVAL;
+		goto error;
+	}
+
+	ret = _sdw_prepare_stream(stream);
+	if (ret < 0) {
+		pr_err("Prepare for stream:%s failed: %d", stream->name, ret);
+		goto error;
+	}
+
+error:
+	mutex_unlock(&stream->m_rt->bus->bus_lock);
+	return ret;
+}
+EXPORT_SYMBOL(sdw_prepare_stream);
+
+/**
+ * sdw_enable_stream: Enable SoundWire stream
+ *
+ * @stream: Soundwire stream
+ *
+ * Documentation/soundwire/stream.txt explains this API in detail
+ */
+int sdw_enable_stream(struct sdw_stream_runtime *stream)
+{
+	int ret = 0;
+
+	if (!stream) {
+		pr_err("SoundWire: Handle not found for stream");
+		return -EINVAL;
+	}
+
+	mutex_lock(&stream->m_rt->bus->bus_lock);
+
+	if (stream->state == SDW_STREAM_ENABLE)
+		goto error;
+
+	if ((stream->state != SDW_STREAM_PREPARE) &&
+		(stream->state != SDW_STREAM_DISABLE)) {
+		ret = -EINVAL;
+		goto error;
+	}
+
+	ret = _sdw_enable_stream(stream);
+	if (ret < 0) {
+		pr_err("Enable for stream:%s failed: %d", stream->name, ret);
+		goto error;
+	}
+
+error:
+	mutex_unlock(&stream->m_rt->bus->bus_lock);
+	return ret;
+}
+EXPORT_SYMBOL(sdw_enable_stream);
+
+/**
+ * sdw_disable_stream: Disable SoundWire stream
+ *
+ * @stream: Soundwire stream
+ *
+ * Documentation/soundwire/stream.txt explains this API in detail
+ */
+int sdw_disable_stream(struct sdw_stream_runtime *stream)
+{
+	int ret = 0;
+
+	if (!stream) {
+		pr_err("SoundWire: Handle not found for stream");
+		return -EINVAL;
+	}
+
+	mutex_lock(&stream->m_rt->bus->bus_lock);
+
+	if (stream->state == SDW_STREAM_DISABLE)
+		goto error;
+
+	if (stream->state != SDW_STREAM_ENABLE) {
+		ret = -EINVAL;
+		goto error;
+	}
+
+	ret = _sdw_disable_stream(stream);
+	if (ret < 0) {
+		pr_err("Disable for stream:%s failed: %d", stream->name, ret);
+		goto error;
+	}
+
+error:
+	mutex_unlock(&stream->m_rt->bus->bus_lock);
+	return ret;
+}
+EXPORT_SYMBOL(sdw_disable_stream);
+
+/**
+ * sdw_deprepare_stream: Deprepare SoundWire stream
+ *
+ * @stream: Soundwire stream
+ *
+ * Documentation/soundwire/stream.txt explains this API in detail
+ */
+int sdw_deprepare_stream(struct sdw_stream_runtime *stream)
+{
+	int ret = 0;
+
+	if (!stream) {
+		pr_err("SoundWire: Handle not found for stream");
+		return -EINVAL;
+	}
+
+	mutex_lock(&stream->m_rt->bus->bus_lock);
+
+	if (stream->state != SDW_STREAM_DISABLE) {
+		ret = -EINVAL;
+		goto error;
+	}
+
+	ret = _sdw_deprepare_stream(stream);
+	if (ret < 0) {
+		pr_err("De-prepare for stream:%d failed: %d", ret, ret);
+		goto error;
+	}
+
+error:
+	mutex_unlock(&stream->m_rt->bus->bus_lock);
+	return ret;
+}
+EXPORT_SYMBOL(sdw_deprepare_stream);
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 7c7d9d6b730f..9b583a8ae3dd 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -796,6 +796,10 @@ int sdw_stream_remove_master(struct sdw_bus *bus,
 		struct sdw_stream_runtime *stream);
 int sdw_stream_remove_slave(struct sdw_slave *slave,
 		struct sdw_stream_runtime *stream);
+int sdw_prepare_stream(struct sdw_stream_runtime *stream);
+int sdw_enable_stream(struct sdw_stream_runtime *stream);
+int sdw_disable_stream(struct sdw_stream_runtime *stream);
+int sdw_deprepare_stream(struct sdw_stream_runtime *stream);
 
 /* messaging and data APIs */
 
-- 
2.7.4
