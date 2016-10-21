From: Hardik Shah <hardik.t.shah@intel.com>
Subject: [RFC 13/14] SoundWire: Add stream and port configuration
Date: Fri, 21 Oct 2016 18:11:11 +0530
Message-ID: <1477053673-16021-14-git-send-email-hardik.t.shah@intel.com>
References: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: tiwai@suse.de, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, lgirdwood@gmail.com, plai@codeaurora.org, patches.audio@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>, Hardik Shah <hardik.t.shah@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Sanyog Kale <sanyog.r.kale@intel.com>

This patch adds APIs for stream and port configurations for SoundWire
bus driver.

Signed-off-by: Hardik Shah <hardik.t.shah@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/sdw/sdw.c      |  774 ++++++++++++++++++++++++++++++++++++++++++++++++++
 sound/sdw/sdw_priv.h |  449 +++++++++++++++++++++++++++++
 2 files changed, 1223 insertions(+)

diff --git a/sound/sdw/sdw.c b/sound/sdw/sdw.c
index 71d2550..ffbec9e 100644
--- a/sound/sdw/sdw.c
+++ b/sound/sdw/sdw.c
@@ -2358,6 +2358,780 @@ static enum sdw_clk_stop_mode sdw_slv_get_clk_stp_mode(struct sdw_slave *slave)
 }
 
 /**
+ * snd_sdw_release_stream_tag: Free the already assigned stream tag.
+ *	Reverses effect of "sdw_alloc_stream_tag"
+ *
+ * @stream_tag: Stream tag to be freed.
+ */
+void snd_sdw_release_stream_tag(unsigned int stream_tag)
+{
+	int i;
+	struct sdw_stream_tag *stream_tags = snd_sdw_core.stream_tags;
+
+	/* Acquire core lock */
+	mutex_lock(&snd_sdw_core.core_mutex);
+
+	/* Get stream tag data structure */
+	for (i = 0; i < SDW_NUM_STREAM_TAGS; i++) {
+		if (stream_tag == stream_tags[i].stream_tag) {
+
+			/* Reference count update */
+			sdw_dec_ref_count(&stream_tags[i].ref_count);
+
+			if (stream_tags[i].ref_count == 0)
+				/* Free up resources */
+				kfree(stream_tags[i].sdw_rt);
+		}
+	}
+
+	/* Release core lock */
+	mutex_unlock(&snd_sdw_core.core_mutex);
+}
+EXPORT_SYMBOL_GPL(snd_sdw_release_stream_tag);
+
+/**
+ * snd_sdw_alloc_stream_tag: Allocates unique stream_tag. Stream tag is
+ *	a unique identifier for each SoundWire stream across all SoundWire
+ *	bus instances. Stream tag is a software concept defined by bus
+ *	driver for stream management and not by MIPI SoundWire Spec. Each
+ *	SoundWire Stream is individually configured and controlled using the
+ *	stream tag. Multiple Master(s) and Slave(s) associated with the
+ *	stream, uses stream tag as an identifier. All the operations on the
+ *	stream e.g. stream configuration, port configuration, prepare and
+ *	enable of the ports are done based on stream tag. This API shall be
+ *	called once per SoundWire stream either by the Master or Slave
+ *	associated with the stream.
+ *
+ * @stream_tag: Stream tag returned by bus driver.
+ */
+int snd_sdw_alloc_stream_tag(unsigned int *stream_tag)
+{
+	int i;
+	int ret = -EINVAL;
+	struct sdw_runtime *sdw_rt;
+	struct sdw_stream_tag *stream_tags = snd_sdw_core.stream_tags;
+
+	/* Acquire core lock */
+	mutex_lock(&snd_sdw_core.core_mutex);
+
+	/* Allocate new stream tag and initialize resources */
+	for (i = 0; i < SDW_NUM_STREAM_TAGS; i++) {
+		if (!stream_tags[i].ref_count) {
+
+			*stream_tag = stream_tags[i].stream_tag;
+
+			/* Initialize stream lock */
+			mutex_init(&stream_tags[i].stream_lock);
+
+			/* Allocate resources for stream runtime handle */
+			sdw_rt = kzalloc(sizeof(*sdw_rt), GFP_KERNEL);
+			if (!sdw_rt) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			/* Reference count update */
+			sdw_inc_ref_count(&stream_tags[i].ref_count);
+
+			/* Initialize Master and Slave list */
+			INIT_LIST_HEAD(&sdw_rt->slv_rt_list);
+			INIT_LIST_HEAD(&sdw_rt->mstr_rt_list);
+
+			/* Change stream state to ALLOC */
+			sdw_rt->stream_state = SDW_STATE_STRM_ALLOC;
+
+			stream_tags[i].sdw_rt = sdw_rt;
+
+			ret = 0;
+			break;
+		}
+	}
+out:
+	/* Release core lock */
+	mutex_unlock(&snd_sdw_core.core_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_sdw_alloc_stream_tag);
+
+/**
+ * sdw_config_mstr_stream: Checks if master runtime handle already
+ *	available, if not allocates and initialize Master runtime handle.
+ *
+ * @mstr: Master handle
+ * @stream_config: Stream configuration for the SoundWire audio stream.
+ * @sdw_rt: Stream runtime handle.
+ *
+ * Returns Master runtime handle.
+ */
+static struct sdw_mstr_runtime *sdw_config_mstr_stream(struct sdw_master *mstr,
+				struct sdw_stream_config *stream_config,
+				struct sdw_runtime *sdw_rt)
+{
+	struct sdw_mstr_runtime *mstr_rt = NULL;
+	struct sdw_stream_params *str_p;
+
+	/* Retrieve Master handle if already available */
+	list_for_each_entry(mstr_rt, &sdw_rt->mstr_rt_list, mstr_strm_node) {
+		if (mstr_rt->mstr == mstr)
+			return mstr_rt;
+	}
+
+	/* Allocate resources for Master runtime handle */
+	mstr_rt = kzalloc(sizeof(*mstr_rt), GFP_KERNEL);
+	if (!mstr_rt)
+		goto out;
+
+	/* Initialization of Master runtime handle */
+	INIT_LIST_HEAD(&mstr_rt->port_rt_list);
+	INIT_LIST_HEAD(&mstr_rt->slv_rt_list);
+	list_add_tail(&mstr_rt->mstr_strm_node, &sdw_rt->mstr_rt_list);
+	list_add_tail(&mstr_rt->mstr_node, &mstr->mstr_rt_list);
+
+	/* Update PCM parameters for Master */
+	mstr_rt->direction = stream_config->direction;
+	str_p = &mstr_rt->stream_params;
+	str_p->rate = stream_config->frame_rate;
+	str_p->channel_count = stream_config->channel_count;
+	str_p->bps = stream_config->bps;
+
+	/* Add reference for Master device handle */
+	mstr_rt->mstr = mstr;
+
+	/* Add reference for stream runtime handle */
+	mstr_rt->sdw_rt = sdw_rt;
+
+out:
+	return mstr_rt;
+}
+
+/**
+ * sdw_config_slave_stream: Allocate and initialize slave runtime handle.
+ *
+ * @slave: Slave handle
+ * @stream_config: Stream configuration for the SoundWire audio stream.
+ * @sdw_rt: Stream runtime handle.
+ *
+ * Returns Slave runtime handle.
+ */
+static struct sdw_slv_runtime *sdw_config_slv_stream(
+				struct sdw_slave *slave,
+				struct sdw_stream_config *stream_config,
+				struct sdw_runtime *sdw_rt)
+{
+	struct sdw_slv_runtime *slv_rt = NULL;
+	struct sdw_stream_params *str_p;
+
+	/* Allocate resources for Slave runtime handle */
+	slv_rt = kzalloc(sizeof(*slv_rt), GFP_KERNEL);
+	if (!slv_rt)
+		goto out;
+
+	/* Initialization of Slave runtime handle */
+	INIT_LIST_HEAD(&slv_rt->port_rt_list);
+
+	/* Update PCM parameters for Slave */
+	slv_rt->direction = stream_config->direction;
+	str_p = &slv_rt->stream_params;
+	str_p->rate = stream_config->frame_rate;
+	str_p->channel_count = stream_config->channel_count;
+	str_p->bps = stream_config->bps;
+
+	/* Add reference for Slave device handle */
+	slv_rt->slv = slave;
+
+	/* Add reference for stream runtime handle */
+	slv_rt->sdw_rt = sdw_rt;
+
+out:
+	return slv_rt;
+}
+
+/**
+ * sdw_release_mstr_stream: Removes entry from master runtime list and free
+ *	up resources.
+ *
+ * @mstr: Master handle.
+ * @sdw_rt: Master runtime handle.
+ */
+static void sdw_release_mstr_stream(struct sdw_master *mstr,
+			struct sdw_runtime *sdw_rt)
+{
+	struct sdw_mstr_runtime *mstr_rt, *__mstr_rt;
+
+	/* Retrieve Master runtime handle */
+	list_for_each_entry_safe(mstr_rt, __mstr_rt, &sdw_rt->mstr_rt_list,
+			mstr_strm_node) {
+
+		if (mstr_rt->mstr == mstr) {
+
+			if (mstr_rt->direction == SDW_DATA_DIR_OUT)
+				/* Reference count update */
+				sdw_dec_ref_count(&sdw_rt->tx_ref_count);
+			else
+				/* Reference count update */
+				sdw_dec_ref_count(&sdw_rt->rx_ref_count);
+
+			/* Remove node from the list */
+			list_del(&mstr_rt->mstr_strm_node);
+			list_del(&mstr_rt->mstr_node);
+
+			pm_runtime_mark_last_busy(&mstr->dev);
+			pm_runtime_put_sync_autosuspend(&mstr->dev);
+
+			/* Free up Master runtime handle resources */
+			kfree(mstr_rt);
+		}
+	}
+}
+
+/**
+ * sdw_release_slv_stream: Removes entry from slave runtime list and free up
+ *	resources.
+ *
+ * @slave: Slave handle.
+ * @sdw_rt: Stream runtime handle.
+ */
+static void sdw_release_slv_stream(struct sdw_slave *slave,
+			struct sdw_runtime *sdw_rt)
+{
+	struct sdw_slv_runtime *slv_rt, *__slv_rt;
+
+	/* Retrieve Slave runtime handle */
+	list_for_each_entry_safe(slv_rt, __slv_rt, &sdw_rt->slv_rt_list,
+			slave_strm_node) {
+
+		if (slv_rt->slv == slave) {
+
+			if (slv_rt->direction == SDW_DATA_DIR_OUT)
+				/* Reference count update */
+				sdw_dec_ref_count(&sdw_rt->tx_ref_count);
+			else
+				/* Reference count update */
+				sdw_dec_ref_count(&sdw_rt->rx_ref_count);
+
+			/* Remove node from the list */
+			list_del(&slv_rt->slave_strm_node);
+
+			pm_runtime_mark_last_busy(&slave->dev);
+			pm_runtime_put_sync_autosuspend(&slave->dev);
+
+			/* Free up Slave runtime handle resources */
+			kfree(slv_rt);
+		}
+	}
+}
+
+/**
+ * snd_sdw_release_stream: De-associates Master(s) and Slave(s) from stream.
+ *	Reverse effect of the sdw_config_stream. Master calls this with
+ *	Slave handle as NULL, Slave calls this with Master handle as NULL.
+ *
+ * @mstr: Master handle,
+ * @slave: SoundWire Slave handle, Null if stream configuration is called by
+ *	Master driver.
+ *
+ * @stream_tag: Stream_tag representing the audio stream. All Masters and
+ *	Slaves part of the same stream has same stream tag. So Bus driver
+ *	holds information of all Masters and Slaves associated with stream
+ *	tag.
+ */
+int snd_sdw_release_stream(struct sdw_master *mstr,
+		struct sdw_slave *slave,
+		unsigned int stream_tag)
+{
+	int i;
+	struct sdw_runtime *sdw_rt = NULL;
+	struct sdw_stream_tag *stream_tags = snd_sdw_core.stream_tags;
+
+	/* Retrieve master handle if called by Slave */
+	if (!mstr)
+		mstr = slave->mstr;
+
+	/* Retrieve stream runtime handle */
+	for (i = 0; i < SDW_NUM_STREAM_TAGS; i++) {
+		if (stream_tags[i].stream_tag == stream_tag) {
+			sdw_rt = stream_tags[i].sdw_rt;
+			break;
+		}
+	}
+
+	if (!sdw_rt) {
+		dev_err(&mstr->dev, "Invalid stream tag\n");
+		return -EINVAL;
+	}
+
+	/* Call release API of Master/Slave */
+	if (!slave)
+		sdw_release_mstr_stream(mstr, sdw_rt);
+	else
+		sdw_release_slv_stream(slave, sdw_rt);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_sdw_release_stream);
+
+/**
+ * snd_sdw_config_stream: Configures the SoundWire stream. All the Master(s)
+ *	and Slave(s) associated with the stream calls this API with
+ *	"sdw_stream_config". This API configures SoundWire stream based on
+ *	"sdw_stream_config" provided by each Master(s) and Slave(s)
+ *	associated with the stream. Master calls this function with Slave
+ *	handle as NULL, Slave calls this with Master handle as NULL.
+ *
+ * @mstr: Master handle.
+ * @slave: SoundWire Slave handle, Null if stream configuration is called by
+ *	Master driver.
+ *
+ * @stream_config: Stream configuration for the SoundWire audio stream.
+ * @stream_tag: Stream_tag representing the audio stream. All Masters and
+ *	Slaves part of the same stream has same stream tag. So Bus driver
+ *	holds information of all Masters and Slaves associated with stream
+ *	tag.
+ */
+int snd_sdw_config_stream(struct sdw_master *mstr,
+		struct sdw_slave *slave,
+		struct sdw_stream_config *stream_config,
+		unsigned int stream_tag)
+{
+	int i;
+	int ret = 0;
+	struct sdw_runtime *sdw_rt = NULL;
+	struct sdw_mstr_runtime *mstr_rt = NULL;
+	struct sdw_slv_runtime *slv_rt = NULL;
+	struct sdw_stream_tag *stream_tags = snd_sdw_core.stream_tags;
+	struct sdw_stream_tag *stream = NULL;
+
+	/* Retrieve master handle if called by Slave */
+	if (!mstr)
+		mstr = slave->mstr;
+
+	/* Retrieve stream runtime handle */
+	for (i = 0; i < SDW_NUM_STREAM_TAGS; i++) {
+		if (stream_tags[i].stream_tag == stream_tag) {
+			sdw_rt = stream_tags[i].sdw_rt;
+			stream = &stream_tags[i];
+			break;
+		}
+	}
+
+	if (!sdw_rt) {
+		dev_err(&mstr->dev, "Valid stream tag not found\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Acquire stream lock */
+	mutex_lock(&stream->stream_lock);
+
+	/* Get and Initialize Master runtime handle */
+	mstr_rt = sdw_config_mstr_stream(mstr, stream_config, sdw_rt);
+	if (!mstr_rt) {
+		dev_err(&mstr->dev, "Master runtime configuration failed\n");
+		ret = -EINVAL;
+		goto error;
+	}
+
+	/* Initialize Slave runtime handle */
+	if (slave) {
+		slv_rt = sdw_config_slv_stream(slave, stream_config, sdw_rt);
+		if (!slv_rt) {
+			dev_err(&mstr->dev, "Slave runtime configuration failed\n");
+			ret = -EINVAL;
+			goto error;
+		}
+	}
+
+	/*
+	 * Stream params will be stored based on Tx only, since there can be
+	 * only one Tx and multiple Rx, There can be multiple Tx if there is
+	 * aggregation on Tx. That is handled by adding the channels to
+	 * stream_params for each aggregated Tx slaves
+	 */
+	if (!sdw_rt->tx_ref_count && stream_config->direction ==
+					SDW_DATA_DIR_OUT) {
+		sdw_rt->stream_params.rate = stream_config->frame_rate;
+		sdw_rt->stream_params.channel_count =
+						stream_config->channel_count;
+		sdw_rt->stream_params.bps = stream_config->bps;
+		/* Reference count update */
+		sdw_inc_ref_count(&sdw_rt->tx_ref_count);
+	}
+
+	/*
+	 * Normally there will be only one Tx in system, multiple Tx can
+	 * only be there if we support aggregation. In that case there may
+	 * be multiple slave or masters handing different channels of same
+	 * Tx stream.
+	 */
+	else if (sdw_rt->tx_ref_count && stream_config->direction ==
+						SDW_DATA_DIR_OUT) {
+		if (sdw_rt->stream_params.rate !=
+			stream_config->frame_rate) {
+			dev_err(&mstr->dev, "Frame rate for aggregated devices not matching\n");
+			ret = -EINVAL;
+			goto error;
+		}
+
+		if (sdw_rt->stream_params.bps != stream_config->bps) {
+			dev_err(&mstr->dev, "bps for aggregated devices not matching\n");
+			ret = -EINVAL;
+			goto error;
+		}
+
+		/*
+		 * Number of channels gets added, since both devices will be
+		 * supporting different channels. Like one Codec supporting
+		 * L and other supporting R channel.
+		 */
+		sdw_rt->stream_params.channel_count +=
+			stream_config->channel_count;
+
+		/* Reference count update */
+		sdw_inc_ref_count(&sdw_rt->tx_ref_count);
+	} else
+		/* Reference count update */
+		sdw_inc_ref_count(&sdw_rt->rx_ref_count);
+
+	sdw_rt->type = stream_config->type;
+
+	/* Change stream state to CONFIG */
+	sdw_rt->stream_state = SDW_STATE_STRM_CONFIG;
+
+	/*
+	 * Slaves are added to two list, This is because bandwidth is
+	 * calculated for two masters individually, while Ports are enabled
+	 * of all the aggregated masters and slaves part of the same stream
+	 * tag simultaneously.
+	 */
+	if (slave) {
+		list_add_tail(&slv_rt->slave_strm_node, &sdw_rt->slv_rt_list);
+		list_add_tail(&slv_rt->slave_mstr_node, &mstr_rt->slv_rt_list);
+	}
+
+	/* Release stream lock */
+	mutex_unlock(&stream->stream_lock);
+
+	if (slave)
+		pm_runtime_get_sync(&slave->dev);
+	else
+		pm_runtime_get_sync(&mstr->dev);
+
+	return ret;
+
+error:
+	mutex_unlock(&stream->stream_lock);
+	kfree(mstr_rt);
+	kfree(slv_rt);
+out:
+	return ret;
+
+}
+EXPORT_SYMBOL_GPL(snd_sdw_config_stream);
+
+/**
+ * sdw_check_dpn_caps: Check Master and Slave port capabilities. This performs
+ *			PCM parameter check based on PCM
+ *			parameters received in stream.
+ * @dpn_cap: Capabilities of Master or Slave port.
+ * @strm_params: Stream PCM parameters.
+ */
+static int sdw_check_dpn_caps(struct sdw_dpn_caps *dpn_cap,
+		struct sdw_stream_params *strm_prms)
+{
+	struct sdw_port_aud_mode_prop *mode_prop =
+		dpn_cap->mode_properties;
+	int i, value;
+
+	/* Check for sampling frequency */
+	if (mode_prop->num_sample_rate_cfgs) {
+		for (i = 0; i < mode_prop->num_sample_rate_cfgs; i++) {
+			value = mode_prop->sample_rate_buf[i];
+			if (strm_prms->rate == value)
+				break;
+		}
+
+		if (i == mode_prop->num_sample_rate_cfgs)
+			return -EINVAL;
+	} else {
+
+		if ((strm_prms->rate < mode_prop->min_sample_rate)
+				|| (strm_prms->rate >
+				mode_prop->max_sample_rate)) {
+			return -EINVAL;
+		}
+	}
+
+	/* Check for bit rate */
+	if (dpn_cap->num_bps) {
+		for (i = 0; i < dpn_cap->num_bps; i++) {
+			value = dpn_cap->bps_buf[i];
+			if (strm_prms->bps == value)
+				break;
+		}
+
+		if (i == dpn_cap->num_bps)
+			return -EINVAL;
+
+	} else {
+
+		if ((strm_prms->bps < dpn_cap->min_bps)
+				|| (strm_prms->bps > dpn_cap->max_bps))
+			return -EINVAL;
+	}
+
+	/* Check for number of channels */
+	if (dpn_cap->num_ch_cnt) {
+		for (i = 0; i < dpn_cap->num_ch_cnt; i++) {
+			value = dpn_cap->ch_cnt_buf[i];
+			if (strm_prms->bps == value)
+				break;
+		}
+
+		if (i == dpn_cap->num_ch_cnt)
+			return -EINVAL;
+
+	} else {
+
+		if ((strm_prms->channel_count < dpn_cap->min_ch_cnt) ||
+			(strm_prms->channel_count > dpn_cap->max_ch_cnt))
+			return -EINVAL;
+
+	}
+
+	return 0;
+}
+
+/**
+ * sdw_mstr_port_configuration: Master Port configuration. This performs
+ *	all the port related configuration including allocation port
+ *	structure memory, assign PCM parameters and add port node in master
+ *	runtime list.
+ *
+ * @mstr: Master handle.
+ * @sdw_rt: Stream runtime information.
+ * @ports_config: Port configuration for Slave.
+ */
+static int sdw_mstr_port_configuration(struct sdw_master *mstr,
+			struct sdw_runtime *sdw_rt,
+			struct sdw_ports_config *ports_config)
+{
+	struct sdw_mstr_runtime *mstr_rt = NULL;
+	struct sdw_port_runtime *port_rt;
+	int found = 0;
+	int i;
+	int ret = 0, pn = 0;
+	struct sdw_dpn_caps *dpn_cap = mstr->caps.sdw_dpn_caps;
+
+	/* Get Master device handle */
+	list_for_each_entry(mstr_rt, &sdw_rt->mstr_rt_list, mstr_strm_node) {
+		if (mstr_rt->mstr == mstr) {
+			found = 1;
+			break;
+		}
+	}
+
+	if (!found) {
+		dev_err(&mstr->dev, "Master not found for this port\n");
+		return -EINVAL;
+	}
+
+	/* Allocate resources for port runtime handle */
+	port_rt = kzalloc((sizeof(*port_rt) * ports_config->num_ports),
+				GFP_KERNEL);
+	if (!port_rt)
+		return -ENOMEM;
+
+	/* Check master capabilities */
+	if (!dpn_cap)
+		return -EINVAL;
+
+	/* Iterate for number of ports to perform initialization */
+	for (i = 0; i < ports_config->num_ports; i++) {
+		port_rt[i].channel_mask = ports_config->port_config[i].ch_mask;
+		port_rt[i].port_num = pn = ports_config->port_config[i].num;
+
+		/* Perform capability check for master port */
+		ret = sdw_check_dpn_caps(&dpn_cap[pn], &mstr_rt->stream_params);
+		if (ret < 0) {
+			dev_err(&mstr->dev, "Master capabilities check failed ret = %d\n", ret);
+			goto error;
+		}
+
+		/* Add node to port runtime list */
+		list_add_tail(&port_rt[i].port_node, &mstr_rt->port_rt_list);
+	}
+
+	return ret;
+
+error:
+	kfree(port_rt);
+	return ret;
+}
+
+struct sdw_dpn_caps *sdw_get_slv_dpn_cap(struct sdw_slave_caps *slv_cap,
+				enum sdw_data_direction direction,
+				unsigned int port_num)
+{
+	int i;
+	struct sdw_dpn_caps *dpn_cap;
+	u8 num_ports;
+	bool port_found = 0;
+
+	if (direction == SDW_DATA_DIR_OUT)
+		num_ports = slv_cap->num_src_ports;
+	else
+		num_ports = slv_cap->num_sink_ports;
+
+	for (i = 0; i < num_ports; i++) {
+		dpn_cap = &slv_cap->dpn_caps[direction][i];
+
+		if (dpn_cap->port_number == port_num) {
+			port_found = 1;
+			break;
+		}
+	}
+
+	if (!port_found)
+		return NULL;
+
+	return dpn_cap;
+
+}
+
+/**
+ * sdw_config_slv_port: Slave Port configuration. This performs
+ *	all the port related configuration including allocation port
+ *	structure memory, assign PCM parameters and add port node in slave
+ *	runtime list.
+ * @slave: Slave handle.
+ * @sdw_rt: Stream runtime information.
+ * @ports_config: Port configuration for Slave.
+ */
+static int sdw_config_slv_port(struct sdw_slave *slave,
+			struct sdw_runtime *sdw_rt,
+			struct sdw_ports_config *ports_config)
+{
+	struct sdw_slv_runtime *slv_rt;
+	struct sdw_port_runtime *port_rt;
+	struct sdw_dpn_caps *dpn_cap;
+	int found = 0, ret = 0;
+	int i, pn;
+
+	/* Get Slave device handle */
+	list_for_each_entry(slv_rt, &sdw_rt->slv_rt_list, slave_strm_node) {
+		if (slv_rt->slv == slave) {
+			found = 1;
+			break;
+		}
+	}
+
+	if (!found) {
+		dev_err(&slave->mstr->dev, "Slave not found for this port\n");
+		return -EINVAL;
+	}
+
+	/* Check whether slave capabilities are valid or invalid */
+	if (!slave->priv.slave_cap_updated) {
+		dev_err(&slave->mstr->dev, "Slave capabilities not updated\n");
+		return -EINVAL;
+	}
+
+	/* Allocate resources for port runtime handle */
+	port_rt = kzalloc((sizeof(*port_rt) * ports_config->num_ports),
+					GFP_KERNEL);
+	if (!port_rt)
+		return -ENOMEM;
+
+	/* Assign PCM parameters */
+	for (i = 0; i < ports_config->num_ports; i++) {
+		port_rt[i].channel_mask = ports_config->port_config[i].ch_mask;
+		port_rt[i].port_num = pn =
+				ports_config->port_config[i].num;
+
+		dpn_cap = sdw_get_slv_dpn_cap(&slave->priv.caps,
+				slv_rt->direction,
+				ports_config->port_config[i].num);
+		if (!dpn_cap) {
+			ret = -EINVAL;
+			dev_err(&slave->mstr->dev, "Slave port capabilities not found ret = %d\n", ret);
+			goto error;
+		}
+
+		/* Perform capability check for slave port */
+		ret = sdw_check_dpn_caps(dpn_cap, &slv_rt->stream_params);
+		if (ret < 0) {
+			dev_err(&slave->mstr->dev, "Slave capabilities check failed ret = %d\n", ret);
+			goto error;
+		}
+
+		/* Add node to port runtime list */
+		list_add_tail(&port_rt[i].port_node, &slv_rt->port_rt_list);
+	}
+
+	return ret;
+
+error:
+	kfree(port_rt);
+	return ret;
+}
+
+/**
+ * snd_sdw_config_ports: Configures Master or Slave Port(s) associated with
+ *	the stream. All the Master(s) and Slave(s) associated with the
+ *	stream calls this API with "sdw_ports_config". Master calls this
+ *	function with Slave handle as NULL, Slave calls this with Master
+ *	handle as NULL.
+ *
+ * @mstr: Master handle where the Slave is connected.
+ * @slave: Slave handle.
+ * @ports_config: Port configuration for each Port of SoundWire Slave.
+ * @stream_tag: Stream tag, where this Port is connected.
+ */
+int snd_sdw_config_ports(struct sdw_master *mstr, struct sdw_slave *slave,
+				struct sdw_ports_config *ports_config,
+				unsigned int stream_tag)
+{
+	int ret;
+	int i;
+	struct sdw_stream_tag *stream_tags = snd_sdw_core.stream_tags;
+	struct sdw_runtime *sdw_rt = NULL;
+	struct sdw_stream_tag *stream = NULL;
+
+	/* Retrieve master handle if called by Slave */
+	if (!mstr)
+		mstr = slave->mstr;
+
+	/* Retrieve stream runtime handle */
+	for (i = 0; i < SDW_NUM_STREAM_TAGS; i++) {
+		if (stream_tags[i].stream_tag == stream_tag) {
+			sdw_rt = stream_tags[i].sdw_rt;
+			stream = &stream_tags[i];
+			break;
+		}
+	}
+
+	if (!sdw_rt) {
+		dev_err(&mstr->dev, "Invalid stream tag\n");
+		return -EINVAL;
+	}
+
+	/* Acquire stream lock */
+	mutex_lock(&stream->stream_lock);
+
+	/* Perform Master/Slave port configuration */
+	if (!slave)
+		ret = sdw_mstr_port_configuration(mstr, sdw_rt, ports_config);
+	else
+		ret = sdw_config_slv_port(slave, sdw_rt, ports_config);
+
+	/* Release stream lock */
+	mutex_unlock(&stream->stream_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_sdw_config_ports);
+
+/**
  * snd_sdw_master_stop_clock: Stop the clock. This function broadcasts the
  *	SCP_CTRL register with clock_stop_now bit set.
  *
diff --git a/sound/sdw/sdw_priv.h b/sound/sdw/sdw_priv.h
index bbba27a..fc738b8 100644
--- a/sound/sdw/sdw_priv.h
+++ b/sound/sdw/sdw_priv.h
@@ -68,6 +68,31 @@
 #define SDW_NUM_OF_MSG3_XFRD	3
 #define SDW_NUM_OF_MSG4_XFRD	4
 
+/**
+ * Below values are not defined in MIPI standard. Completely arbitrary
+ * values that can be changed at will.
+ */
+#define SDW_MAX_STREAM_TAG_KEY_SIZE	80
+#define SDW_NUM_STREAM_TAGS		100 /* Max number of stream tags */
+#define SDW_DOUBLE_RATE_FACTOR		2 /* Double rate */
+
+/* TODO: Description to be provided for SDW_FREQ_MOD_FACTOR */
+#define SDW_FREQ_MOD_FACTOR		3000
+
+/**
+ * SDW_STRM_RATE_GROUPING is place holder number used to hold the frame rate
+ * used in grouping stream for efficiently calculating bandwidth. All the
+ * streams with same frame rates belong to same group. This number is
+ * dynamically increased if the group count number increases above 12.
+ */
+#define SDW_STRM_RATE_GROUPING		12
+
+/* Size of buffer in bytes. */
+#define SDW_BUF_SIZE1			1
+#define SDW_BUF_SIZE2			2
+#define SDW_BUF_SIZE3			3
+#define SDW_BUF_SIZE4			4
+
 /* Maximum number of Data Ports. */
 #define SDW_MAX_DATA_PORTS		15
 
@@ -80,6 +105,8 @@
  */
 #define SDW_INTR_STAT_READ_MAX_TRIES	10
 
+extern struct snd_sdw_core snd_sdw_core;
+
 /**
  * sdw_driver: Structure to typecast both Master and Slave driver to generic
  *	SoundWire driver, to find out the driver type.
@@ -95,6 +122,278 @@ struct sdw_driver {
 		container_of(d, struct sdw_driver, driver)
 
 /**
+ * sdw_stream_state: Stream state maintained by bus driver for performing
+ *	stream operations.
+ *
+ * @SDW_STATE_STRM_ALLOC: New stream is allocated.
+ * @SDW_STATE_STRM_CONFIG: Stream is configured. PCM/PDM parameters of the
+ *	Stream is updated to bus driver.
+ *
+ * @SDW_STATE_STRM_PREPARE: Stream is Prepared. All the ports of Master and
+ *	Slave associated with this stream is prepared for enabling.
+ *
+ * @SDW_STATE_STRM_ENABLE: Stream is enabled. All the ports of Master and
+ *	Slave associated with this stream are enable and now stream is
+ *	active.
+ *
+ * @SDW_STATE_STRM_DISABLE: Stream in disabled state, All the ports of
+ *	Master and Slave associated with the stream are disabled, and stream
+ *	is not active on bus.
+ *
+ * @SDW_STATE_STRM_DEPREPARE: Stream in de-prepare state. All the ports of
+ *	Master and Slave associated with the stream are de-prepared.
+ *
+ * @SDW_STATE_STRM_RELEASE: Stream in release state. Stream is not having
+ *	any PCM/PDM configuration. There is not Free state for stream, since
+ *	memory for the stream gets freed, and there is no way to update
+ *	stream as free.
+ */
+enum sdw_stream_state {
+	SDW_STATE_STRM_ALLOC = 0,
+	SDW_STATE_STRM_CONFIG = 1,
+	SDW_STATE_STRM_PREPARE = 2,
+	SDW_STATE_STRM_ENABLE = 3,
+	SDW_STATE_STRM_DISABLE = 4,
+	SDW_STATE_STRM_DEPREPARE = 5,
+	SDW_STATE_STRM_RELEASE = 6,
+};
+
+/**
+ * sdw_update_bus_ops: Operations performed by bus driver for stream state
+ *	transitions. Some of the operations are performed on individual
+ *	streams, while some are global operations affecting all the streams
+ *	on the bus.
+ *
+ * @SDW_BUS_PORT_PRE: Perform all the operations which is to be done before
+ *	initiating the bank switch for stream getting enabled. Master and
+ *	Slave driver may need to perform some operations before bank switch.
+ *	Call Master and Slave handlers to accomplish device specific
+ *	operations before initiating bank switch.
+ *
+ * @SDW_BUS_BANK_SWITCH: Initiate the bank switch operation by broadcasting
+ *	SCP_FrameCtrl register. Depending upon the Master implementation
+ *	broadcast will be finished as a part of this state, or Master may
+ *	set some register as a part of PORT_POST below operation after which
+ *	broadcast will be finished. Initiation of the broadcast message is
+ *	done as part of this operation. Broadcast message gets transmitted
+ *	on the bus during this or next operation is Master dependent.
+ *
+ * @SDW_BUS_PORT_POST: Perform all the operations which are do be done after
+ *	initiating the Bank switch. Call Master and Slave handlers to
+ *	perform Post bank switch operation.
+ *
+ * @SDW_BUS_BANK_SWITCH_WAIT: Bus driver waits here for the Bank switch to
+ *	be completed. This is used for Master(s) running in aggregation mode
+ *	where pre and post operations are performed before and after Bank
+ *	switch operation. The Bank switch message broadcast will happen only
+ *	when clock is enabled which is done as part of post Bank switch
+ *	operation. After post Bank switch operation, bus driver waits for
+ *	response of Bank switch. The bus driver provides SDW_BUS_PORT_PRE
+ *	and SDW_BUS_PORT_POST for Bank switch operation which are as per
+ *	Master implementation.
+ *
+ * @SDW_BUS_PORT_DIS_CHN: Disable all the ports of the alternate bank
+ *	(unused bank) after the bank switch. Once Bank switch operation is
+ *	successful, the running stream(s) enabled port channels on previous
+ *	bank needs to be disabled for both Master(s) and Slave(s).
+ */
+enum sdw_update_bus_ops {
+	SDW_BUS_PORT_PRE,
+	SDW_BUS_BANK_SWITCH,
+	SDW_BUS_PORT_POST,
+	SDW_BUS_BANK_SWITCH_WAIT,
+	SDW_BUS_PORT_DIS_CHN,
+};
+
+/**
+ * sdw_stream_tag: Stream tag represents the unique SoundWire Audio stream.
+ *	All the ports of the Master(s) and Slave(s) part of the same stream
+ *	tags gets enabled/disabled as a part of single bank Switch.If
+ *	samples of the stream are split between the Master(s), its Master
+ *	responsibility of synchronizing the bank switch of two individual
+ *	Masters.
+ *
+ * @stream_tag: Unique stream tag number.
+ * @stream_lock: Lock for stream.
+ * @ref_count: Number of times stream tag is allocated. Stream tag is is
+ *	available for allocation if reference count is 0.
+ *
+ * @sdw_rt: Holds the stream runtime information.
+ */
+struct sdw_stream_tag {
+	int stream_tag;
+	struct mutex stream_lock;
+	int ref_count;
+	struct sdw_runtime *sdw_rt;
+};
+
+/**
+ * sdw_stream_params: Stream parameters.
+ *
+ * @rate: Sampling frequency
+ * @channel_count: Number of channels.
+ * @bps: bits per sample.
+ */
+struct sdw_stream_params {
+	unsigned int rate;
+	unsigned int channel_count;
+	unsigned int bps;
+};
+
+/**
+ * sdw_port_runtime: Holds the port parameters for each of the Master(s)
+ *	Slave(s) port associated with the stream.
+ *
+ * @port_num: Port number.
+ * @channel_mask: Channels of the Stream handled by this port.
+ * @transport_params: Transport parameters of port.
+ * @port_params: Port parameters
+ * @port_node: Port runtime is added to the Port List of Master(s) or
+ *	Slave(s) associated with stream. Node to add the Port runtime to
+ *	Master(s) or Slave(s) list.
+ */
+struct sdw_port_runtime {
+	int port_num;
+	int channel_mask;
+	struct sdw_transport_params transport_params;
+	struct sdw_port_params port_params;
+	struct list_head port_node;
+};
+
+/**
+ * sdw_slave_runtime: Holds the Stream parameters for the Slave associated
+ *	with the stream.
+ *
+ * @slv: Slave handle associated with this Stream.
+ * @sdw_rt: Stream handle to which this Slave stream is associated.
+ * @direction: Port Direction of the Slave for this Stream. Slave is
+ *	transmitting the Data or receiving the Data.
+ *
+ * @stream_params: Stream parameters for Slave.
+ * @port_rt_list: List of Slave Ports associated with this Stream.
+ * @slave_strm_node: Stream runtime data structure maintains list of all the
+ *	Slave runtime instances associated with stream. This is the node to
+ *	add Slave runtime instance to that list. This list is used for the
+ *	stream configuration.
+ *
+ * @slave_mstr_node: Master runtime data structure maintains list of all the
+ *	Slave runtime instances. This is the node to add Slave runtime
+ *	instance to that list. This list is used for Bandwidth calculation
+ *	per bus. Slave runtime instance gets added to two list one for
+ *	stream configuration and other for bandwidth calculation. Stream
+ *	configuration is per stream where there may be multiple Masters and
+ *	Slave associated with Stream. Bandwidth calculation is per Bus,
+ *	where there is Single Master and Multiple Slaves associated with
+ *	bus.
+ */
+struct sdw_slv_runtime {
+	struct sdw_slave *slv;
+	struct sdw_runtime *sdw_rt;
+	int direction;
+	struct sdw_stream_params stream_params;
+	struct list_head port_rt_list;
+	struct list_head slave_strm_node;
+	struct list_head slave_mstr_node;
+};
+
+/**
+ * sdw_bus_runtime: This structure holds the transport params and BW
+ *	required by the stream on the bus. There may be multiple bus
+ *	associated with the stream. This holds bus specific parameters of
+ *	stream. TODO: Currently sdw_bus_runtime is part of sdw_mstr_runtime
+ *	Master handle. Once stream between Slave to Slave is supported by
+ *	bus driver, this needs to be made part of sdw_runtime handle.
+ *
+ * @stream_bw: Bus Bandwidth required by this stream (bps).
+ * @hstart: Horizontal Start column for this stream.
+ * @hstop: Horizontal stop column for this stream.
+ * @block_offset: Block offset for this stream.
+ * @sub_block_offset: Sub Block offset for this stream.
+ */
+struct sdw_bus_runtime {
+	unsigned int stream_bw;
+	int hstart;
+	int hstop;
+	int block_offset;
+	int sub_block_offset;
+
+};
+
+/**
+ * sdw_mstr_runtime: Holds the Stream parameters for the Master associated
+ *		with the stream.
+ *
+ * @mstr: Master handle associated with this stream.
+ * @sdw_rt: Stream handle to which this Master stream is associated.
+ * @stream_params: Stream parameters.
+ * @port_rt_list: List of this Master Ports associated with this Stream.
+ * @mstr_strm_node: Stream runtime data structure maintains list of all the
+ *	Master runtime instances associated with stream. This is the node to
+ *	add Master runtime instance to that list. This list is used for the
+ *	stream configuration.
+ *
+ * @mstr_node: Master data structure maintains list of all the Master
+ *	runtime instances. This is the node to add Master runtime instance
+ *	to to that list. This list is used for Bandwidth calculation per
+ *	bus.  Master runtime instance gets added to two list one for stream
+ *	configuration and other for bandwidth calculation. Stream
+ *	configuration is per stream where there may be multiple Masters and
+ *	Slave associated with Stream. Bandwidth calculation is per Bus,
+ *	where there is Single Master and Multiple Slaves associated with
+ *	bus.
+ *
+ * @slv_rt_list: List of the Slave_runtime instances associated with this
+ *	Master_runtime. Its list of all the Slave(s) stream associated with
+ *	this Master. There may be stereo stream from Master to two Slaves,
+ *	where L and R samples from Master is received by two different
+ *	Slave(s), so this list contains the runtime structure associated
+ *	with both Slaves.
+ *
+ * @bus_rt: Bus parameters for the stream. There may be multiple bus
+ *	associated with stream. This bus_rt is for current Master.
+ */
+struct sdw_mstr_runtime {
+	struct sdw_master *mstr;
+	struct sdw_runtime *sdw_rt;
+	int direction;
+	struct sdw_stream_params stream_params;
+	struct list_head port_rt_list;
+	struct list_head mstr_strm_node;
+	struct list_head mstr_node;
+	struct list_head slv_rt_list;
+	struct sdw_bus_runtime bus_rt;
+};
+
+/**
+ * sdw_runtime: This structure holds runtime information for each unique
+ *	SoundWire stream.
+ *
+ * @tx_ref_count: Number of Transmit devices of stream. This may include
+ *	multiple Master(s) and Slave(s) based on how stream samples are
+ *	split between Mater and Slaves.
+ * @rx_ref_count: Number of Receive devices of stream. This may include
+ *	multiple Master(s) and Slave(s) based on how stream samples are
+ *	split between Mater and Slaves.
+ *
+ * @stream_params: Steam parameters.
+ * @slv_rt_list: List of the slaves part of this stream.
+ * @mstr_rt_list: List of Masters part of this stream.
+ * @type: Stream type PCM or PDM.This is not SoundWire concept, its used
+ *	inside bus driver for efficient BW management.
+ *
+ * @stream_state: Current State of the stream.
+ */
+struct sdw_runtime {
+	int tx_ref_count;
+	int rx_ref_count;
+	struct sdw_stream_params stream_params;
+	struct list_head slv_rt_list;
+	struct list_head mstr_rt_list;
+	enum sdw_stream_type type;
+	enum sdw_stream_state stream_state;
+};
+
+/**
  * sdw_slv_status: List of Slave status.
  *
  * @node: Node for adding status to list of Slave status.
@@ -110,6 +409,20 @@ struct sdw_slv_status {
  *
  * @bus_node: Node to add the bus in the sdw_core list.
  * @mstr: Master reference for the bus.
+ * @clk_state: State of the clock.
+ * @active_bank: Current bank in use.
+ * @max_clk_dr_freq: Maximum double rate clock frequency. This is maximum
+ * double clock rate supported per bus.
+ * @curr_clk_dr_freq: Current double rate clock frequency in use. This is
+ *	current clock rate at which bus is running.
+ *
+ * @clk_div: Current clock divider in use.
+ * @bandwidth: Total bandwidth.
+ * @system_interval: Bus System interval (Stream Synchronization Point).
+ * @stream_interval: Stream interval.
+ * @frame_freq: SoundWire Frame frequency on bus.
+ * @col: Active columns.
+ * @row: Active rows.
  * @status_thread: Thread to process the Slave status.
  * @kworker: Worker for updating the Slave status.
  * @kwork: Work for worker
@@ -121,16 +434,48 @@ struct sdw_slv_status {
  *	context, spinlock is used to put the status reported by Master into
  *	the status list which is processed by bus driver in thread context
  *	later.
+ *
+ * @data: Data to be provided by bus driver for calling xfer_msg_deferred
+ *	callback of Master driver.
+
  */
 
 struct sdw_bus {
 	struct list_head bus_node;
 	struct sdw_master *mstr;
+	unsigned int clk_state;
+	unsigned int active_bank;
+	unsigned int max_dr_clk_freq;
+	unsigned int curr_dr_clk_freq;
+	unsigned int clk_div;
+	unsigned int bandwidth;
+	unsigned int system_interval;
+	unsigned int stream_interval;
+	unsigned int frame_freq;
+	unsigned int col;
+	unsigned int row;
 	struct task_struct *status_thread;
 	struct kthread_worker kworker;
 	struct kthread_work kwork;
 	struct list_head status_list;
 	spinlock_t spinlock;
+	struct sdw_deferred_xfer_data data;
+};
+
+/**
+ * sdw_row_col_pair: Information for each row column pair. This is used by
+ *	bus driver for quick BW calculation.
+ *
+ * @row: Number of rows.
+ * @col: Number of columns
+ * @control_bits: Number of controls bits for this row-column pair.
+ * @data_bits: Number of controls bits for this row-column pair.
+ */
+struct sdw_row_col_pair {
+	int row;
+	int col;
+	int control_bits;
+	int data_bits;
 };
 
 /**
@@ -138,11 +483,17 @@ struct sdw_bus {
  *	spawned across masters and has list of bus structure per every
  *	Master registered.
  *
+ * @row_col_pair: Array holding all row-column pair possible as per MIPI
+ *	1.1 Spec. This is used for quick reference for BW calculation
+ *	algorithm.
+ *
  * @bus_list: List of all the bus instance.
  * @core_mutex: Global lock for all bus instances.
  * @idr: For identifying the registered buses.
  */
 struct snd_sdw_core {
+	struct sdw_stream_tag stream_tags[SDW_NUM_STREAM_TAGS];
+	struct sdw_row_col_pair row_col_pair[MAX_NUM_ROW_COLS];
 	struct list_head bus_list;
 	struct mutex core_mutex;
 	struct idr idr;
@@ -168,6 +519,58 @@ void sdw_bank_switch_deferred(struct sdw_master *mstr, struct sdw_msg *msg,
 				struct sdw_deferred_xfer_data *data);
 
 /**
+ * sdw_index_to_col: Structure holding mapping of numbers to columns.
+ *
+ * @index: Holds index to number of columns.
+ * @col: Holds actual columns.
+ */
+struct sdw_index_to_col {
+	int index;
+	int col;
+};
+
+/**
+ * sdw_index_to_row: Structure holding mapping of numbers to rows.
+ *
+ * @index: Holds index to number of rows.
+ * @row: Holds actual rows.
+ */
+struct sdw_index_to_row {
+	int index;
+	int row;
+};
+
+/**
+ * sdw_group_params: Structure holding temporary variable while computing
+ *	transport parameters of Master(s) and Slave(s).
+ *
+ * @rate: Holds stream rate.
+ * @full_bw: Holds full bandwidth per group.
+ * @payload_bw: Holds payload bandwidth per group.
+ * @hwidth: Holds hwidth per group.
+ */
+struct sdw_group_params {
+	int rate;
+	int full_bw;
+	int payload_bw;
+	int hwidth;
+};
+
+/**
+ * sdw_group_count: Structure holding group count and stream rate array
+ *	while computing transport parameters of Master(s) and Slave(s).
+ *
+ * @group_count: Holds actual group count.
+ * @max_size: Holds maximum capacity of array.
+ * @stream_rates: Pointer to stream rates.
+ */
+struct sdw_group_count {
+	unsigned int group_count;
+	unsigned int max_size;
+	unsigned int *stream_rates;
+};
+
+/**
  * sdw_enable_disable_dpn_intr: Enable or Disable Slave Data Port interrupt.
  *	This is called by bus driver before prepare and after deprepare of
  *	the ports.
@@ -182,6 +585,52 @@ void sdw_bank_switch_deferred(struct sdw_master *mstr, struct sdw_msg *msg,
 int sdw_enable_disable_dpn_intr(struct sdw_slave *sdw_slv, int port_num,
 					int port_direction, bool enable);
 
+/**
+ * sdw_create_row_col_pair: Initialization of bandwidth related operations.
+ *	This is required to have fast path for the BW calculation when a new
+ *	stream is prepared or deprepared. This is called only once as part
+ *	of SoundWire Bus driver getting initialized.
+ */
+void sdw_create_row_col_pair(void);
+
+/**
+ * sdw_init_bus_params: Sets up bus data structure for BW calculation. This
+ *	is called once per each Master interface registration to the
+ *	SoundWire bus.
+ *
+ * @sdw_bus: Bus handle.
+ */
+void sdw_init_bus_params(struct sdw_bus *sdw_bus);
+
+/**
+ * sdw_get_slv_dpn_caps: Get the data port capabilities based on the port
+ *	number and port direction.
+ *
+ * @slv_cap: Slave capabilities.
+ * @direction: Port data direction.
+ * @port_num: Port number.
+ */
+struct sdw_dpn_caps *sdw_get_slv_dpn_cap(struct sdw_slave_caps *slv_cap,
+			enum sdw_data_direction direction,
+			unsigned int port_num);
+
+/* Return bus structure */
+static inline struct sdw_bus *sdw_master_to_bus(struct sdw_master *mstr)
+{
+	return mstr->bus;
+}
+
+/* Reference count increment */
+static inline void sdw_inc_ref_count(int *ref_count)
+{
+	(*ref_count)++;
+}
+
+/* Reference count decrement */
+static inline void sdw_dec_ref_count(int *ref_count)
+{
+	(*ref_count)--;
+}
 
 /*
  * Helper function for bus driver to write messages. Since bus driver
-- 
1.7.9.5
