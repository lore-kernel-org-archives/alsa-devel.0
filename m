From: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v5 07/13] soundwire: Add stream configuration
	APIs
Date: Wed, 25 Apr 2018 15:09:17 +0530
Message-ID: <1524649163-12088-8-git-send-email-vkoul@kernel.org>
References: <1524649163-12088-1-git-send-email-vkoul@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 97211267799
 for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2018 11:35:05 +0200 (CEST)
In-Reply-To: <1524649163-12088-1-git-send-email-vkoul@kernel.org>
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
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Vinod Koul <vkoul@kernel.org>, broonie@kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Sanyog Kale <sanyog.r.kale@intel.com>

Add APIs for prepare, enable, disable and de-prepare stream.

Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soundwire/bus.c       |   9 ++
 drivers/soundwire/stream.c    | 246 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/soundwire/sdw.h |   4 +
 3 files changed, 259 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 084bf71b2b87..dcc0ff9f0c22 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -17,6 +17,7 @@
  */
 int sdw_add_bus_master(struct sdw_bus *bus)
 {
+	struct sdw_master_prop *prop = NULL;
 	int ret;
 
 	if (!bus->dev) {
@@ -79,9 +80,17 @@ int sdw_add_bus_master(struct sdw_bus *bus)
 	}
 
 	/*
+	 * Initialize clock values based on Master properties. The max
+	 * frequency is read from max_freq property. Current assumption
+	 * is that the bus will start at highest clock frequency when
+	 * powered on.
+	 *
 	 * Default active bank will be 0 as out of reset the Slaves have
 	 * to start with bank 0 (Table 40 of Spec)
 	 */
+	prop = &bus->prop;
+	bus->params.max_dr_freq = prop->max_freq * SDW_DOUBLE_RATE_FACTOR;
+	bus->params.curr_dr_freq = bus->params.max_dr_freq;
 	bus->params.curr_bank = SDW_BANK0;
 	bus->params.next_bank = SDW_BANK1;
 
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 98348c38d0e0..68252f252841 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1242,3 +1242,249 @@ struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
 
 	return NULL;
 }
+
+static int _sdw_prepare_stream(struct sdw_stream_runtime *stream)
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
+	/* TODO: Update this during Device-Device support */
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
+	stream->state = SDW_STREAM_PREPARED;
+
+	return ret;
+
+restore_params:
+	memcpy(&bus->params, &params, sizeof(params));
+	return ret;
+}
+
+/**
+ * sdw_prepare_stream() - Prepare SoundWire stream
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
+	ret = _sdw_prepare_stream(stream);
+	if (ret < 0)
+		pr_err("Prepare for stream:%s failed: %d", stream->name, ret);
+
+	mutex_unlock(&stream->m_rt->bus->bus_lock);
+	return ret;
+}
+EXPORT_SYMBOL(sdw_prepare_stream);
+
+static int _sdw_enable_stream(struct sdw_stream_runtime *stream)
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
+	stream->state = SDW_STREAM_ENABLED;
+	return 0;
+}
+
+/**
+ * sdw_enable_stream() - Enable SoundWire stream
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
+	ret = _sdw_enable_stream(stream);
+	if (ret < 0)
+		pr_err("Enable for stream:%s failed: %d", stream->name, ret);
+
+	mutex_unlock(&stream->m_rt->bus->bus_lock);
+	return ret;
+}
+EXPORT_SYMBOL(sdw_enable_stream);
+
+static int _sdw_disable_stream(struct sdw_stream_runtime *stream)
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
+	stream->state = SDW_STREAM_DISABLED;
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
+ * sdw_disable_stream() - Disable SoundWire stream
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
+	ret = _sdw_disable_stream(stream);
+	if (ret < 0)
+		pr_err("Disable for stream:%s failed: %d", stream->name, ret);
+
+	mutex_unlock(&stream->m_rt->bus->bus_lock);
+	return ret;
+}
+EXPORT_SYMBOL(sdw_disable_stream);
+
+static int _sdw_deprepare_stream(struct sdw_stream_runtime *stream)
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
+	/* TODO: Update this during Device-Device support */
+	bus->params.bandwidth -= m_rt->stream->params.rate *
+		m_rt->ch_count * m_rt->stream->params.bps;
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
+	stream->state = SDW_STREAM_DEPREPARED;
+
+	return ret;
+}
+
+/**
+ * sdw_deprepare_stream() - Deprepare SoundWire stream
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
+	ret = _sdw_deprepare_stream(stream);
+	if (ret < 0)
+		pr_err("De-prepare for stream:%d failed: %d", ret, ret);
+
+	mutex_unlock(&stream->m_rt->bus->bus_lock);
+	return ret;
+}
+EXPORT_SYMBOL(sdw_deprepare_stream);
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index ff4b0134897e..7cebb7da1a8c 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -791,6 +791,10 @@ int sdw_stream_remove_master(struct sdw_bus *bus,
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
