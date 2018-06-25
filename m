From: Shreyas NC <shreyas.nc@intel.com>
Subject: [PATCH v4 4/7] soundwire: Handle multiple master
	instances in a stream
Date: Mon, 25 Jun 2018 16:28:57 +0530
Message-ID: <1529924340-30065-5-git-send-email-shreyas.nc@intel.com>
References: <1529924340-30065-1-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 353502675FB
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 13:00:53 +0200 (CEST)
In-Reply-To: <1529924340-30065-1-git-send-email-shreyas.nc@intel.com>
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

From: Vinod Koul <vkoul@kernel.org>

For each SoundWire stream operation, we need to parse master
list and operate upon all master runtime.

This is a preparatory patch to do the boilerplate conversion
of stream handling from single master runtime to handle a
list of master runtime. The code to support bank switch for
multiple master instances is added in the next patch.

Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
---
 drivers/soundwire/stream.c    | 309 +++++++++++++++++++++++++-----------------
 include/linux/soundwire/sdw.h |   2 -
 2 files changed, 186 insertions(+), 125 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index eb942c6..0e8a2eb5 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -681,35 +681,45 @@ static int sdw_bank_switch(struct sdw_bus *bus)
 
 static int do_bank_switch(struct sdw_stream_runtime *stream)
 {
-	struct sdw_master_runtime *m_rt = stream->m_rt;
+	struct sdw_master_runtime *m_rt = NULL;
 	const struct sdw_master_ops *ops;
-	struct sdw_bus *bus = m_rt->bus;
+	struct sdw_bus *bus = NULL;
 	int ret = 0;
 
-	ops = bus->ops;
 
-	/* Pre-bank switch */
-	if (ops->pre_bank_switch) {
-		ret = ops->pre_bank_switch(bus);
+	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
+		bus = m_rt->bus;
+		ops = bus->ops;
+
+		/* Pre-bank switch */
+		if (ops->pre_bank_switch) {
+			ret = ops->pre_bank_switch(bus);
+			if (ret < 0) {
+				dev_err(bus->dev,
+					"Pre bank switch op failed: %d", ret);
+				return ret;
+			}
+		}
+
+		/* Bank switch */
+		ret = sdw_bank_switch(bus);
 		if (ret < 0) {
-			dev_err(bus->dev, "Pre bank switch op failed: %d", ret);
+			dev_err(bus->dev, "Bank switch failed: %d", ret);
 			return ret;
 		}
 	}
 
-	/* Bank switch */
-	ret = sdw_bank_switch(bus);
-	if (ret < 0) {
-		dev_err(bus->dev, "Bank switch failed: %d", ret);
-		return ret;
-	}
+	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
+		bus = m_rt->bus;
+		ops = bus->ops;
 
-	/* Post-bank switch */
-	if (ops->post_bank_switch) {
-		ret = ops->post_bank_switch(bus);
-		if (ret < 0) {
-			dev_err(bus->dev,
+		/* Post-bank switch */
+		if (ops->post_bank_switch) {
+			ret = ops->post_bank_switch(bus);
+			if (ret < 0) {
+				dev_err(bus->dev,
 					"Post bank switch op failed: %d", ret);
+			}
 		}
 	}
 
@@ -754,6 +764,21 @@ struct sdw_stream_runtime *sdw_alloc_stream(char *stream_name)
 }
 EXPORT_SYMBOL(sdw_alloc_stream);
 
+static struct sdw_master_runtime
+*sdw_find_master_rt(struct sdw_bus *bus,
+			struct sdw_stream_runtime *stream)
+{
+	struct sdw_master_runtime *m_rt = NULL;
+
+	/* Retrieve Bus handle if already available */
+	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
+		if (m_rt->bus == bus)
+			return m_rt;
+	}
+
+	return NULL;
+}
+
 /**
  * sdw_alloc_master_rt() - Allocates and initialize Master runtime handle
  *
@@ -770,12 +795,11 @@ static struct sdw_master_runtime
 {
 	struct sdw_master_runtime *m_rt;
 
-	m_rt = stream->m_rt;
-
 	/*
 	 * check if Master is already allocated (as a result of Slave adding
 	 * it first), if so skip allocation and go to configure
 	 */
+	m_rt = sdw_find_master_rt(bus, stream);
 	if (m_rt)
 		goto stream_config;
 
@@ -786,7 +810,7 @@ static struct sdw_master_runtime
 	/* Initialization of Master runtime handle */
 	INIT_LIST_HEAD(&m_rt->port_list);
 	INIT_LIST_HEAD(&m_rt->slave_rt_list);
-	stream->m_rt = m_rt;
+	list_add_tail(&m_rt->stream_node, &stream->master_list);
 
 	list_add_tail(&m_rt->bus_node, &bus->m_rt_list);
 
@@ -844,17 +868,21 @@ static void sdw_slave_port_release(struct sdw_bus *bus,
 			struct sdw_stream_runtime *stream)
 {
 	struct sdw_port_runtime *p_rt, *_p_rt;
-	struct sdw_master_runtime *m_rt = stream->m_rt;
+	struct sdw_master_runtime *m_rt;
 	struct sdw_slave_runtime *s_rt;
 
-	list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
-		if (s_rt->slave != slave)
-			continue;
+	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
+		list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
 
-		list_for_each_entry_safe(p_rt, _p_rt,
-				&s_rt->port_list, port_node) {
-			list_del(&p_rt->port_node);
-			kfree(p_rt);
+			if (s_rt->slave != slave)
+				continue;
+
+			list_for_each_entry_safe(p_rt, _p_rt,
+					&s_rt->port_list, port_node) {
+
+				list_del(&p_rt->port_node);
+				kfree(p_rt);
+			}
 		}
 	}
 }
@@ -871,16 +899,18 @@ static void sdw_release_slave_stream(struct sdw_slave *slave,
 			struct sdw_stream_runtime *stream)
 {
 	struct sdw_slave_runtime *s_rt, *_s_rt;
-	struct sdw_master_runtime *m_rt = stream->m_rt;
-
-	/* Retrieve Slave runtime handle */
-	list_for_each_entry_safe(s_rt, _s_rt,
-			&m_rt->slave_rt_list, m_rt_node) {
+	struct sdw_master_runtime *m_rt;
 
-		if (s_rt->slave == slave) {
-			list_del(&s_rt->m_rt_node);
-			kfree(s_rt);
-			return;
+	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
+		/* Retrieve Slave runtime handle */
+		list_for_each_entry_safe(s_rt, _s_rt,
+					&m_rt->slave_rt_list, m_rt_node) {
+
+			if (s_rt->slave == slave) {
+				list_del(&s_rt->m_rt_node);
+				kfree(s_rt);
+				return;
+			}
 		}
 	}
 }
@@ -888,6 +918,7 @@ static void sdw_release_slave_stream(struct sdw_slave *slave,
 /**
  * sdw_release_master_stream() - Free Master runtime handle
  *
+ * @m_rt: Master runtime node
  * @stream: Stream runtime handle.
  *
  * This function is to be called with bus_lock held
@@ -895,16 +926,18 @@ static void sdw_release_slave_stream(struct sdw_slave *slave,
  * handle. If this is called first then sdw_release_slave_stream() will have
  * no effect as Slave(s) runtime handle would already be freed up.
  */
-static void sdw_release_master_stream(struct sdw_stream_runtime *stream)
+static void sdw_release_master_stream(struct sdw_master_runtime *m_rt,
+			struct sdw_stream_runtime *stream)
 {
-	struct sdw_master_runtime *m_rt = stream->m_rt;
 	struct sdw_slave_runtime *s_rt, *_s_rt;
 
 	list_for_each_entry_safe(s_rt, _s_rt,
 			&m_rt->slave_rt_list, m_rt_node)
 		sdw_stream_remove_slave(s_rt->slave, stream);
 
+	list_del(&m_rt->stream_node);
 	list_del(&m_rt->bus_node);
+	kfree(m_rt);
 }
 
 /**
@@ -918,13 +951,22 @@ static void sdw_release_master_stream(struct sdw_stream_runtime *stream)
 int sdw_stream_remove_master(struct sdw_bus *bus,
 		struct sdw_stream_runtime *stream)
 {
+	struct sdw_master_runtime *m_rt, *_m_rt;
+
 	mutex_lock(&bus->bus_lock);
 
-	sdw_release_master_stream(stream);
-	sdw_master_port_release(bus, stream->m_rt);
-	stream->state = SDW_STREAM_RELEASED;
-	kfree(stream->m_rt);
-	stream->m_rt = NULL;
+	list_for_each_entry_safe(m_rt, _m_rt,
+			&stream->master_list, stream_node) {
+
+		if (m_rt->bus != bus)
+			continue;
+
+		sdw_master_port_release(bus, m_rt);
+		sdw_release_master_stream(m_rt, stream);
+	}
+
+	if (list_empty(&stream->master_list))
+		stream->state = SDW_STREAM_RELEASED;
 
 	mutex_unlock(&bus->bus_lock);
 
@@ -1127,7 +1169,7 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 	stream->state = SDW_STREAM_CONFIGURED;
 
 stream_error:
-	sdw_release_master_stream(stream);
+	sdw_release_master_stream(m_rt, stream);
 error:
 	mutex_unlock(&bus->bus_lock);
 	return ret;
@@ -1195,7 +1237,7 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 	 * we hit error so cleanup the stream, release all Slave(s) and
 	 * Master runtime
 	 */
-	sdw_release_master_stream(stream);
+	sdw_release_master_stream(m_rt, stream);
 error:
 	mutex_unlock(&slave->bus->bus_lock);
 	return ret;
@@ -1277,31 +1319,36 @@ static void sdw_release_bus_lock(struct sdw_stream_runtime *stream)
 
 static int _sdw_prepare_stream(struct sdw_stream_runtime *stream)
 {
-	struct sdw_master_runtime *m_rt = stream->m_rt;
-	struct sdw_bus *bus = m_rt->bus;
+	struct sdw_master_runtime *m_rt = NULL;
+	struct sdw_bus *bus = NULL;
 	struct sdw_master_prop *prop = NULL;
 	struct sdw_bus_params params;
 	int ret;
 
-	prop = &bus->prop;
-	memcpy(&params, &bus->params, sizeof(params));
+	/* Prepare  Master(s) and Slave(s) port(s) associated with stream */
+	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
+		bus = m_rt->bus;
+		prop = &bus->prop;
+		memcpy(&params, &bus->params, sizeof(params));
 
-	/* TODO: Support Asynchronous mode */
-	if ((prop->max_freq % stream->params.rate) != 0) {
-		dev_err(bus->dev, "Async mode not supported");
-		return -EINVAL;
-	}
+		/* TODO: Support Asynchronous mode */
+		if ((prop->max_freq % stream->params.rate) != 0) {
+			dev_err(bus->dev, "Async mode not supported");
+			return -EINVAL;
+		}
 
-	/* Increment cumulative bus bandwidth */
-	/* TODO: Update this during Device-Device support */
-	bus->params.bandwidth += m_rt->stream->params.rate *
-		m_rt->ch_count * m_rt->stream->params.bps;
+		/* Increment cumulative bus bandwidth */
+		/* TODO: Update this during Device-Device support */
+		bus->params.bandwidth += m_rt->stream->params.rate *
+			m_rt->ch_count * m_rt->stream->params.bps;
+
+		/* Program params */
+		ret = sdw_program_params(bus);
+		if (ret < 0) {
+			dev_err(bus->dev, "Program params failed: %d", ret);
+			goto restore_params;
+		}
 
-	/* Program params */
-	ret = sdw_program_params(bus);
-	if (ret < 0) {
-		dev_err(bus->dev, "Program params failed: %d", ret);
-		goto restore_params;
 	}
 
 	ret = do_bank_switch(stream);
@@ -1310,12 +1357,16 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream)
 		goto restore_params;
 	}
 
-	/* Prepare port(s) on the new clock configuration */
-	ret = sdw_prep_deprep_ports(m_rt, true);
-	if (ret < 0) {
-		dev_err(bus->dev, "Prepare port(s) failed ret = %d",
-				ret);
-		return ret;
+	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
+		bus = m_rt->bus;
+
+		/* Prepare port(s) on the new clock configuration */
+		ret = sdw_prep_deprep_ports(m_rt, true);
+		if (ret < 0) {
+			dev_err(bus->dev, "Prepare port(s) failed ret = %d",
+					ret);
+			return ret;
+		}
 	}
 
 	stream->state = SDW_STREAM_PREPARED;
@@ -1343,35 +1394,40 @@ int sdw_prepare_stream(struct sdw_stream_runtime *stream)
 		return -EINVAL;
 	}
 
-	mutex_lock(&stream->m_rt->bus->bus_lock);
+	sdw_acquire_bus_lock(stream);
 
 	ret = _sdw_prepare_stream(stream);
 	if (ret < 0)
 		pr_err("Prepare for stream:%s failed: %d", stream->name, ret);
 
-	mutex_unlock(&stream->m_rt->bus->bus_lock);
+	sdw_release_bus_lock(stream);
 	return ret;
 }
 EXPORT_SYMBOL(sdw_prepare_stream);
 
 static int _sdw_enable_stream(struct sdw_stream_runtime *stream)
 {
-	struct sdw_master_runtime *m_rt = stream->m_rt;
-	struct sdw_bus *bus = m_rt->bus;
+	struct sdw_master_runtime *m_rt = NULL;
+	struct sdw_bus *bus = NULL;
 	int ret;
 
-	/* Program params */
-	ret = sdw_program_params(bus);
-	if (ret < 0) {
-		dev_err(bus->dev, "Program params failed: %d", ret);
-		return ret;
-	}
+	/* Enable Master(s) and Slave(s) port(s) associated with stream */
+	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
+		bus = m_rt->bus;
 
-	/* Enable port(s) */
-	ret = sdw_enable_disable_ports(m_rt, true);
-	if (ret < 0) {
-		dev_err(bus->dev, "Enable port(s) failed ret: %d", ret);
-		return ret;
+		/* Program params */
+		ret = sdw_program_params(bus);
+		if (ret < 0) {
+			dev_err(bus->dev, "Program params failed: %d", ret);
+			return ret;
+		}
+
+		/* Enable port(s) */
+		ret = sdw_enable_disable_ports(m_rt, true);
+		if (ret < 0) {
+			dev_err(bus->dev, "Enable port(s) failed ret: %d", ret);
+			return ret;
+		}
 	}
 
 	ret = do_bank_switch(stream);
@@ -1400,37 +1456,42 @@ int sdw_enable_stream(struct sdw_stream_runtime *stream)
 		return -EINVAL;
 	}
 
-	mutex_lock(&stream->m_rt->bus->bus_lock);
+	sdw_acquire_bus_lock(stream);
 
 	ret = _sdw_enable_stream(stream);
 	if (ret < 0)
 		pr_err("Enable for stream:%s failed: %d", stream->name, ret);
 
-	mutex_unlock(&stream->m_rt->bus->bus_lock);
+	sdw_release_bus_lock(stream);
 	return ret;
 }
 EXPORT_SYMBOL(sdw_enable_stream);
 
 static int _sdw_disable_stream(struct sdw_stream_runtime *stream)
 {
-	struct sdw_master_runtime *m_rt = stream->m_rt;
-	struct sdw_bus *bus = m_rt->bus;
+	struct sdw_master_runtime *m_rt = NULL;
+	struct sdw_bus *bus = NULL;
 	int ret;
 
-	/* Disable port(s) */
-	ret = sdw_enable_disable_ports(m_rt, false);
-	if (ret < 0) {
-		dev_err(bus->dev, "Disable port(s) failed: %d", ret);
-		return ret;
+	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
+		bus = m_rt->bus;
+		/* Disable port(s) */
+		ret = sdw_enable_disable_ports(m_rt, false);
+		if (ret < 0) {
+			dev_err(bus->dev, "Disable port(s) failed: %d", ret);
+			return ret;
+		}
 	}
-
 	stream->state = SDW_STREAM_DISABLED;
 
-	/* Program params */
-	ret = sdw_program_params(bus);
-	if (ret < 0) {
-		dev_err(bus->dev, "Program params failed: %d", ret);
-		return ret;
+	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
+		bus = m_rt->bus;
+		/* Program params */
+		ret = sdw_program_params(bus);
+		if (ret < 0) {
+			dev_err(bus->dev, "Program params failed: %d", ret);
+			return ret;
+		}
 	}
 
 	return do_bank_switch(stream);
@@ -1452,43 +1513,46 @@ int sdw_disable_stream(struct sdw_stream_runtime *stream)
 		return -EINVAL;
 	}
 
-	mutex_lock(&stream->m_rt->bus->bus_lock);
+	sdw_acquire_bus_lock(stream);
 
 	ret = _sdw_disable_stream(stream);
 	if (ret < 0)
 		pr_err("Disable for stream:%s failed: %d", stream->name, ret);
 
-	mutex_unlock(&stream->m_rt->bus->bus_lock);
+	sdw_release_bus_lock(stream);
 	return ret;
 }
 EXPORT_SYMBOL(sdw_disable_stream);
 
 static int _sdw_deprepare_stream(struct sdw_stream_runtime *stream)
 {
-	struct sdw_master_runtime *m_rt = stream->m_rt;
-	struct sdw_bus *bus = m_rt->bus;
+	struct sdw_master_runtime *m_rt = NULL;
+	struct sdw_bus *bus = NULL;
 	int ret = 0;
 
-	/* De-prepare port(s) */
-	ret = sdw_prep_deprep_ports(m_rt, false);
-	if (ret < 0) {
-		dev_err(bus->dev, "De-prepare port(s) failed: %d", ret);
-		return ret;
-	}
+	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
+		bus = m_rt->bus;
+		/* De-prepare port(s) */
+		ret = sdw_prep_deprep_ports(m_rt, false);
+		if (ret < 0) {
+			dev_err(bus->dev, "De-prepare port(s) failed: %d", ret);
+			return ret;
+		}
 
-	stream->state = SDW_STREAM_DEPREPARED;
+		/* TODO: Update this during Device-Device support */
+		bus->params.bandwidth -= m_rt->stream->params.rate *
+			m_rt->ch_count * m_rt->stream->params.bps;
 
-	/* TODO: Update this during Device-Device support */
-	bus->params.bandwidth -= m_rt->stream->params.rate *
-		m_rt->ch_count * m_rt->stream->params.bps;
+		/* Program params */
+		ret = sdw_program_params(bus);
+		if (ret < 0) {
+			dev_err(bus->dev, "Program params failed: %d", ret);
+			return ret;
+		}
 
-	/* Program params */
-	ret = sdw_program_params(bus);
-	if (ret < 0) {
-		dev_err(bus->dev, "Program params failed: %d", ret);
-		return ret;
 	}
 
+	stream->state = SDW_STREAM_DEPREPARED;
 	return do_bank_switch(stream);
 }
 
@@ -1508,13 +1572,12 @@ int sdw_deprepare_stream(struct sdw_stream_runtime *stream)
 		return -EINVAL;
 	}
 
-	mutex_lock(&stream->m_rt->bus->bus_lock);
-
+	sdw_acquire_bus_lock(stream);
 	ret = _sdw_deprepare_stream(stream);
 	if (ret < 0)
 		pr_err("De-prepare for stream:%d failed: %d", ret, ret);
 
-	mutex_unlock(&stream->m_rt->bus->bus_lock);
+	sdw_release_bus_lock(stream);
 	return ret;
 }
 EXPORT_SYMBOL(sdw_deprepare_stream);
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index ccd8dcdf..03df709 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -768,7 +768,6 @@ struct sdw_stream_params {
  * @params: Stream parameters
  * @state: Current state of the stream
  * @type: Stream type PCM or PDM
- * @m_rt: Master runtime
  * @master_list: List of Master runtime(s) in this stream.
  * master_list can contain only one m_rt per Master instance
  * for a stream
@@ -778,7 +777,6 @@ struct sdw_stream_runtime {
 	struct sdw_stream_params params;
 	enum sdw_stream_state state;
 	enum sdw_stream_type type;
-	struct sdw_master_runtime *m_rt;
 	struct list_head master_list;
 };
 
-- 
2.7.4
