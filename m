From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 4/8] ASoC: Intel: Skylake: Add FE and BE
	hw_params handling
Date: Wed, 23 Sep 2015 20:33:20 +0530
Message-ID: <1443020604-22282-5-git-send-email-vinod.koul@intel.com>
References: <1443020604-22282-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 152C8264F52
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2015 17:01:26 +0200 (CEST)
In-Reply-To: <1443020604-22282-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

For FE and BE, the PCM parameters come from FE and BE hw_params
values passed. For a FE we convert the FE params to DSP expected
module format and pass to DSP. For a BE we need to find the
gateway settings (i2s/PDM) to be applied. These are queried from
NHLT table and applied.

Further for BE based on direction the settings are applied as
either source or destination parameters.

These helpers here allow the format to be calculated and queried
as per firmware format.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 230 +++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-topology.h |  12 ++
 2 files changed, 242 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 12aa84bd7a63..ba287035fca3 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -735,3 +735,233 @@ static int skl_tplg_pga_event(struct snd_soc_dapm_widget *w,
 
 	return 0;
 }
+
+/*
+ * The FE params are passed by hw_params of the DAI.
+ * On hw_params, the params are stored in Gateway module of the FE and we
+ * need to calculate the format in DSP module configuration, that conversion
+ * is done here
+ */
+int skl_tplg_update_pipe_params(struct device *dev,
+		struct skl_module_cfg *mconfig, struct skl_pipe_params *params)
+{
+	struct skl_pipe *pipe = mconfig->pipe;
+	struct skl_module_fmt *format = NULL;
+
+	memcpy(pipe->p_params, params, sizeof(*params));
+
+	if (params->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		format = &mconfig->in_fmt;
+	else
+		format = &mconfig->out_fmt;
+
+	/* set the hw_params */
+	format->s_freq = params->s_freq;
+	format->channels = params->ch;
+	format->valid_bit_depth = skl_get_bit_depth(params->s_fmt);
+
+	/*
+	 * 16 bit is 16 bit container whereas 24 bit is in 32 bit container so
+	 * update bit depth accordingly
+	 */
+	switch (format->valid_bit_depth) {
+	case SKL_DEPTH_16BIT:
+		format->bit_depth = format->valid_bit_depth;
+		break;
+
+	case SKL_DEPTH_24BIT:
+		format->bit_depth = SKL_DEPTH_32BIT;
+		break;
+
+	default:
+		dev_err(dev, "Invalid bit depth %x for pipe\n",
+				format->valid_bit_depth);
+		return -EINVAL;
+	}
+
+	if (params->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		mconfig->ibs = (format->s_freq / 1000) *
+				(format->channels) *
+				(format->bit_depth >> 3);
+	} else {
+		mconfig->obs = (format->s_freq / 1000) *
+				(format->channels) *
+				(format->bit_depth >> 3);
+	}
+
+	return 0;
+}
+
+/*
+ * Query the module config for the FE DAI
+ * This is used to find the hw_params set for that DAI and apply to FE
+ * pipeline
+ */
+struct skl_module_cfg *
+skl_tplg_fe_get_cpr_module(struct snd_soc_dai *dai, int stream)
+{
+	struct snd_soc_dapm_widget *w;
+	struct snd_soc_dapm_path *p = NULL;
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		w = dai->playback_widget;
+		snd_soc_dapm_widget_for_each_source_path(w, p) {
+			if (p->connect && p->sink->power &&
+					is_skl_dsp_widget_type(p->sink))
+				continue;
+
+			if (p->sink->priv) {
+				dev_dbg(dai->dev, "set params for %s\n", p->sink->name);
+				return p->sink->priv;
+			}
+		}
+	} else {
+		w = dai->capture_widget;
+		snd_soc_dapm_widget_for_each_sink_path(w, p) {
+			if (p->connect && p->source->power &&
+					is_skl_dsp_widget_type(p->source))
+				continue;
+
+			if (p->source->priv) {
+				dev_dbg(dai->dev, "set params for %s\n", p->source->name);
+				return p->source->priv;
+			}
+		}
+	}
+
+	return NULL;
+}
+
+static u8 skl_tplg_be_link_type(int dev_type)
+{
+	int ret;
+
+	switch (dev_type) {
+	case SKL_DEVICE_BT:
+		ret = NHLT_LINK_SSP;
+		break;
+
+	case SKL_DEVICE_DMIC:
+		ret = NHLT_LINK_DMIC;
+		break;
+
+	case SKL_DEVICE_I2S:
+		ret = NHLT_LINK_SSP;
+		break;
+
+	case SKL_DEVICE_HDALINK:
+		ret = NHLT_LINK_HDA;
+		break;
+
+	default:
+		ret = NHLT_LINK_INVALID;
+		break;
+	}
+
+	return ret;
+}
+
+/*
+ * Fill the BE gateway parameters
+ * The BE gateway expects a blob of parameters which are kept in the ACPI
+ * NHLT blob, so query the blob for interface type (i2s/pdm) and instance.
+ * The port can have multiple settings so pick based on the PCM
+ * parameters
+ */
+static int skl_tplg_be_fill_pipe_params(struct snd_soc_dai *dai,
+		struct skl_module_cfg *mconfig, struct skl_pipe_params *params)
+{
+	struct skl_pipe *pipe = mconfig->pipe;
+	struct nhlt_specific_cfg *cfg;
+	struct skl *skl = get_skl_ctx(dai->dev);
+	int link_type = skl_tplg_be_link_type(mconfig->dev_type);
+
+	memcpy(pipe->p_params, params, sizeof(*params));
+
+	/* update the blob based on virtual bus_id*/
+	cfg = skl_get_ep_blob(skl, mconfig->vbus_id, link_type, params->s_fmt,
+				params->ch, params->s_freq, params->stream);
+	if (cfg) {
+		mconfig->formats_config.caps_size = cfg->size;
+		memcpy(mconfig->formats_config.caps, &cfg->caps, cfg->size);
+	} else {
+		dev_err(dai->dev, "Blob is NULL for id %x type %d dirn %d\n",
+				mconfig->vbus_id, link_type, params->stream);
+		dev_err(dai->dev, "PCM: ch %d, freq %d, fmt %d\n",
+				 params->ch, params->s_freq, params->s_fmt);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int skl_tplg_be_set_src_pipe_params(struct snd_soc_dai *dai,
+		struct snd_soc_dapm_widget *w, struct skl_pipe_params *params)
+{
+	struct snd_soc_dapm_path *p;
+
+	snd_soc_dapm_widget_for_each_sink_path(w, p) {
+		if (p->connect && is_skl_dsp_widget_type(p->source) &&
+						p->source->priv) {
+
+			if (!p->source->power)
+				return skl_tplg_be_fill_pipe_params(
+						dai, p->source->priv, params);
+			else
+				return -EBUSY;
+		} else {
+			return skl_tplg_be_set_src_pipe_params(dai, p->source,
+									 params);
+		}
+	}
+
+	return -EIO;
+}
+
+static int skl_tplg_be_set_sink_pipe_params(struct snd_soc_dai *dai,
+	struct snd_soc_dapm_widget *w, struct skl_pipe_params *params)
+{
+	struct snd_soc_dapm_path *p = NULL;
+
+	snd_soc_dapm_widget_for_each_source_path(w, p) {
+		if (p->connect && is_skl_dsp_widget_type(p->sink) &&
+						p->sink->priv) {
+
+			if (!p->sink->power)
+				return skl_tplg_be_fill_pipe_params(
+						dai, p->sink->priv, params);
+			else
+				return -EBUSY;
+
+		} else {
+			return skl_tplg_be_set_sink_pipe_params(
+						dai, p->sink, params);
+		}
+	}
+
+	return -EIO;
+}
+
+/*
+ * BE hw_params can be a source parameters (capture) or sink parameters
+ * (playback). Based on sink and source we need to either find the source
+ * list or the sink list and set the pipeline parameters
+ */
+int skl_tplg_be_update_params(struct snd_soc_dai *dai,
+				struct skl_pipe_params *params)
+{
+	struct snd_soc_dapm_widget *w;
+
+	if (params->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		w = dai->playback_widget;
+
+		return skl_tplg_be_set_src_pipe_params(dai, w, params);
+
+	} else {
+		w = dai->capture_widget;
+
+		return skl_tplg_be_set_sink_pipe_params(dai, w, params);
+	}
+
+	return 0;
+}
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index b3a22a6f8d27..12db94d238f2 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -280,6 +280,18 @@ static inline struct skl *get_skl_ctx(struct device *dev)
 	return ebus_to_skl(ebus);
 }
 
+int skl_tplg_be_update_params(struct snd_soc_dai *dai,
+	struct skl_pipe_params *params);
+void skl_tplg_set_be_dmic_config(struct snd_soc_dai *dai,
+	struct skl_pipe_params *params, int stream);
+int skl_tplg_init(struct snd_soc_platform *platform,
+				struct hdac_ext_bus *ebus);
+struct skl_module_cfg *skl_tplg_fe_get_cpr_module(
+		struct snd_soc_dai *dai, int stream);
+int skl_tplg_update_pipe_params(struct device *dev,
+		struct skl_module_cfg *mconfig, struct skl_pipe_params *params);
+
+
 int skl_create_pipeline(struct skl_sst *ctx, struct skl_pipe *pipe);
 
 int skl_run_pipe(struct skl_sst *ctx, struct skl_pipe *pipe);
-- 
1.9.1
