From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 5/7] ASOC: hda: add DSP platfrom controls widget
	event handlers
Date: Sun, 19 Apr 2015 02:27:31 +0530
Message-ID: <1429390653-8194-6-git-send-email-vinod.koul@intel.com>
References: <1429390653-8194-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 56EF4260881
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 23:02:53 +0200 (CEST)
In-Reply-To: <1429390653-8194-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

This add widget event handlers for PRE/POST PMU event and PRE/POST PMD
event. event handlers functions implement the FW sequence to enable path
from source to sink.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/hda/Makefile           |    3 +-
 sound/soc/hda/hda_dsp_controls.c |  702 ++++++++++++++++++++++++++++++++++++++
 sound/soc/hda/hda_skl.h          |   17 +
 sound/soc/hda/hda_soc_dsp.c      |    4 +-
 4 files changed, 723 insertions(+), 3 deletions(-)
 create mode 100644 sound/soc/hda/hda_dsp_controls.c

diff --git a/sound/soc/hda/Makefile b/sound/soc/hda/Makefile
index 2be667dc0724..668c831b196e 100644
--- a/sound/soc/hda/Makefile
+++ b/sound/soc/hda/Makefile
@@ -1,4 +1,5 @@
-snd-soc-hda-skl-objs := hda_skl.o hda_skl_pcm.o hda_soc_dsp.o
+snd-soc-hda-skl-objs := hda_skl.o hda_skl_pcm.o hda_soc_dsp.o \
+hda_dsp_controls.o
 
 obj-$(CONFIG_SND_SOC_HDA_SKL) += snd-soc-hda-skl.o
 
diff --git a/sound/soc/hda/hda_dsp_controls.c b/sound/soc/hda/hda_dsp_controls.c
new file mode 100644
index 000000000000..ee53227fa751
--- /dev/null
+++ b/sound/soc/hda/hda_dsp_controls.c
@@ -0,0 +1,702 @@
+/*
+ *  hda_dsp_control.c -HD Audio Platform component ALSA controls
+ *
+ *  Copyright (C) 2015 Intel Corp
+ *  Author: Jeeja KP <jeeja.kp@intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc-hda-sst-dsp.h>
+#include "hda_dsp_controls.h"
+#include "hda_skl.h"
+
+static int is_hda_widget_type(struct snd_soc_dapm_widget *w)
+{
+	return ((w->id == snd_soc_dapm_dai_link) ||
+		(w->id == snd_soc_dapm_dai_in) ||
+		(w->id == snd_soc_dapm_aif_in) ||
+		(w->id == snd_soc_dapm_aif_out) ||
+		(w->id == snd_soc_dapm_dai_out)) ? 1 : 0;
+
+}
+
+static int hda_bind_unbind_intra_pipes(struct ssth_module_config *src_module,
+	struct ssth_module_config *sink_module, struct ssth_lib *ctx,  bool bind)
+{
+	int ret = 0;
+
+	if (!bind) {
+		ret = ssth_stop_pipe(ctx, src_module->pipe);
+		if (ret < 0)
+			return ret;
+	}
+	return ssth_bind_unbind_modules(ctx, src_module, sink_module, bind);
+}
+
+static int  hda_bind_unbind_pipe_src(struct snd_soc_dapm_widget *w,
+	struct ssth_lib *ctx,  bool bind)
+{
+	struct ssth_module_config *sink_module = w->priv;
+	struct ssth_module_config *src_module = NULL;
+	struct snd_soc_dapm_path *p = NULL;
+	struct ssth_pipe *sink_pipe  = sink_module->pipe;
+	struct ssth_pipe *src_pipe  = NULL;
+	int ret = 0;
+
+	list_for_each_entry(p, &w->sources, list_sink) {
+		if (p->connected && !p->connected(w, p->source)
+			&& (p->source->priv == NULL)
+			&& (is_hda_widget_type(w)))
+			continue;
+		dev_dbg(ctx->dev, "%s: sink widget=%s\n", __func__, w->name);
+		if (p->connect &&
+			(p->source->priv != NULL) &&
+			 (!is_hda_widget_type(p->source))) {
+			src_module = p->source->priv;
+			src_pipe = src_module->pipe;
+			dev_dbg(ctx->dev, "src widget=%s\n", p->source->name);
+			if (sink_pipe->ppl_id != src_pipe->ppl_id)
+				return hda_bind_unbind_intra_pipes(src_module,
+					 sink_module, ctx, bind);
+		}
+	}
+	return ret;
+}
+
+static int  hda_bind_unbind_pipe_sink(struct snd_soc_dapm_widget *w,
+	struct ssth_lib *ctx,  bool bind)
+{
+	struct ssth_module_config *src_module = w->priv;
+	struct ssth_module_config *sink_module = NULL;
+	struct snd_soc_dapm_path *p = NULL;
+	struct ssth_pipe *src_pipe  = src_module->pipe;
+	struct ssth_pipe *sink_pipe  = NULL;
+	int ret = 0;
+
+	list_for_each_entry(p, &w->sinks, list_source) {
+		if (p->connected && !p->connected(w, p->sink)
+			&& (p->sink->priv == NULL)
+			&& (is_hda_widget_type(w)))
+			continue;
+
+		dev_dbg(ctx->dev, "%s: src widget=%s\n", __func__, w->name);
+		if (p->connect  &&
+			(p->sink->priv != NULL) &&
+			(!is_hda_widget_type(p->sink))) {
+			sink_module = p->sink->priv;
+			sink_pipe = sink_module->pipe;
+			dev_dbg(ctx->dev, "sink widget=%s\n", p->sink->name);
+			if (sink_pipe->ppl_id != src_pipe->ppl_id)
+				return hda_bind_unbind_intra_pipes(src_module,
+					 sink_module, ctx, bind);
+		}
+	}
+	return ret;
+}
+
+static int hda_sst_bind_unbind_pipes(struct snd_soc_dapm_widget *w,
+	struct ssth_lib *ctx,  bool bind)
+{
+	struct ssth_module_config *sink_module = w->priv;
+	int ret = 0;
+
+	dev_dbg(ctx->dev, "%s: widget = %s conn_type=%d\n", __func__, w->name,
+				sink_module->hw_conn_type);
+	ret = hda_bind_unbind_pipe_src(w, ctx, bind);
+	if (ret < 0)
+		return ret;
+	return hda_bind_unbind_pipe_sink(w, ctx, bind);
+}
+
+static bool hda_sst_is_pipe_mem_available(struct hda_platform_info *pinfo,
+	struct ssth_lib *ctx, struct ssth_module_config *mconfig)
+{
+	dev_dbg(ctx->dev, "%s: module_id =%d instance=%d\n", __func__,
+		 mconfig->id.module_id, mconfig->id.instance_id);
+	pinfo->resource.mem += mconfig->pipe->memory_pages;
+
+	if (pinfo->resource.mem > pinfo->resource.max_mem) {
+		dev_err(ctx->dev, "exceeds ppl memory available=%d > mem=%d\n",
+				pinfo->resource.max_mem, pinfo->resource.mem);
+		/* TODO - handle failure case
+		 pinfo->resource.mem -= mconfig->pipe->memory_pages;
+		return false;
+		*/
+	}
+	return true;
+}
+
+static bool hda_sst_is_pipe_mcps_available(struct hda_platform_info *pinfo,
+	struct ssth_lib *ctx, struct ssth_module_config *mconfig)
+{
+	dev_dbg(ctx->dev, "%s: module_id = %d instance=%d\n", __func__,
+			mconfig->id.module_id, mconfig->id.instance_id);
+	pinfo->resource.mcps += mconfig->mcps;
+
+	if (pinfo->resource.mcps > pinfo->resource.max_mcps) {
+		dev_err(ctx->dev, "exceeds ppl memory available=%d > mem=%d\n",
+				pinfo->resource.max_mcps, pinfo->resource.mcps);
+		/*TODO - handle failure case
+		pinfo->resource.mcps -= mconfig->mcps;
+		return false
+		*/
+	}
+	return true;
+}
+
+static void hda_update_slot_map(struct ssth_lib *ctx,
+					struct ssth_module_config *m_cfg)
+{
+	int slot_map = 0xFFFFFFFF;
+	int num_slots = 0, i;
+	int start_slot;
+
+	start_slot = m_cfg->formats_config.caps[(1 << (m_cfg->time_slot)) - 1];
+	start_slot &= 0xF;
+
+	if (m_cfg->hw_conn_type == SSTH_CONN_SOURCE)
+		num_slots = m_cfg->in_fmt.channels;
+	else
+		num_slots = m_cfg->out_fmt.channels;
+
+	for (i = 0; i < num_slots; i++) {
+		/*
+		 * For 2 channels with starting slot as 0, slot map will
+		 * look like 0xFFFFFF10, for 4 channels with starting slot
+		 * as 2, slot map will look like 0xFFFF5432
+		 *
+		 */
+		slot_map &= (~(0xF << (4 * i)) | (start_slot << (4 * i)));
+		start_slot++;
+	}
+	dev_dbg(ctx->dev, "slot_map = %x\n", slot_map);
+	m_cfg->formats_config.caps[(1 << (m_cfg->time_slot)) - 1] = slot_map;
+}
+
+static void hda_update_ch_config(struct ssth_module_config *m_cfg)
+{
+	struct ssth_module_format *in_fmt, *out_fmt;
+
+	in_fmt = &m_cfg->in_fmt;
+	out_fmt = &m_cfg->out_fmt;
+
+	if (in_fmt->channels == 2) {
+		in_fmt->channel_config =  SSTH_CHANNEL_CONFIG_STEREO;
+		if (out_fmt->channels == 1)
+			out_fmt->channel_config = SSTH_CHANNEL_CONFIG_MONO;
+		if (out_fmt->channels == 2)
+			out_fmt->channel_config = SSTH_CHANNEL_CONFIG_STEREO;
+	} else if (in_fmt->channels == 1) {
+		in_fmt->channel_config =  SSTH_CHANNEL_CONFIG_MONO;
+			if (out_fmt->channels == 1)
+				out_fmt->channel_config = SSTH_CHANNEL_CONFIG_MONO;
+			if (out_fmt->channels == 2)
+				out_fmt->channel_config = SSTH_CHANNEL_CONFIG_STEREO;
+	}
+
+}
+
+static int hda_sst_get_pipe_widget(struct device *dev,
+	struct snd_soc_dapm_widget *w, struct ssth_pipe *pipe)
+{
+	struct ssth_module_config *src_module = NULL;
+	struct snd_soc_dapm_path *p = NULL;
+	struct ssth_pipe_module *p_module = NULL;
+
+	dev_dbg(dev, "In%s widget=%s\n", __func__, w->name);
+
+	p_module = devm_kzalloc(dev, sizeof(*p_module), GFP_KERNEL);
+	if (!p_module)
+		return -ENOMEM;
+
+	p_module->w = w;
+	list_add_tail(&p_module->node, &pipe->w_list);
+
+	list_for_each_entry(p, &w->sinks, list_source) {
+		if ((p->sink->priv == NULL)
+			&& (is_hda_widget_type(w)))
+			continue;
+
+		if ((p->sink->priv != NULL) && (p->connect)
+			&& (!is_hda_widget_type(p->sink))) {
+			src_module = p->sink->priv;
+			if (pipe->ppl_id == src_module->pipe->ppl_id) {
+				dev_dbg(dev, "%s: found widget = %s\n", __func__, p->sink->name);
+				hda_sst_get_pipe_widget(dev, p->sink, pipe);
+			}
+		}
+	}
+	return 0;
+}
+
+static int hda_init_pipe_modules(struct ssth_lib *ctx,
+	 struct ssth_pipe *pipe, struct hda_platform_info *pinfo)
+{
+	struct ssth_pipe_module *w_module = NULL;
+	struct snd_soc_dapm_widget *w = NULL;
+	struct ssth_module_config *mconfig = NULL;
+	int ret = 0;
+
+	dev_dbg(ctx->dev, "%s: pipe=%d\n", __func__, pipe->ppl_id);
+	list_for_each_entry(w_module, &pipe->w_list, node) {
+		w = w_module->w;
+		dev_dbg(ctx->dev, "Pipe Module =%s\n", w->name);
+		mconfig = w->priv;
+		/*TODO if loadable module, mconfig->is_loadable, load module */
+
+		ret = ssth_init_module(ctx, mconfig, NULL);
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
+static int hda_bind_unbind_pipe_modules(struct ssth_lib *ctx,
+	 struct ssth_pipe *pipe, bool bind)
+{
+	struct ssth_pipe_module *w_module = NULL;
+	struct ssth_module_config *src_module = NULL;
+	struct ssth_module_config *dst_module = NULL;
+	int ret = 0;
+
+	dev_dbg(ctx->dev, "%s: pipe=%d\n", __func__, pipe->ppl_id);
+	list_for_each_entry(w_module, &pipe->w_list, node) {
+		dst_module  = w_module->w->priv;
+
+		if (src_module == NULL) {
+			src_module = dst_module;
+			continue;
+		}
+
+		ret = ssth_bind_unbind_modules(ctx, src_module, dst_module, bind);
+		if (ret < 0)
+			return ret;
+		src_module = dst_module;
+	}
+	return 0;
+}
+
+static int hda_unload_pipe_modules(struct ssth_lib *ctx,
+	 struct ssth_pipe *pipe)
+{
+	struct ssth_pipe_module *w_module = NULL;
+	struct ssth_module_config *mconfig = NULL;
+
+	dev_dbg(ctx->dev, "%s: pipe=%d\n", __func__, pipe->ppl_id);
+	list_for_each_entry(w_module, &pipe->w_list, node) {
+		mconfig  = w_module->w->priv;
+		/*TODO mconfig->is_loadable = 1 , unload module */
+	}
+	return 0;
+}
+
+static int hda_sst_dapm_pre_pmu_event(struct snd_soc_dapm_widget *w,
+	int w_type, struct ssth_lib *ctx, struct hda_platform_info *pinfo)
+{
+	int ret = 0;
+	struct ssth_module_config *mconfig = w->priv;
+	struct ssth_pipe *s_pipe = mconfig->pipe;
+
+	dev_dbg(ctx->dev, "%s: widget =%s type=%d\n", __func__, w->name, w_type);
+
+	/*check resource available */
+	if (!hda_sst_is_pipe_mcps_available(pinfo, ctx, mconfig))
+		return -1;
+
+	if (w_type == SSTH_WIDGET_VMIXER ||
+		w_type == SSTH_WIDGET_MIXER) {
+
+		if (!hda_sst_is_pipe_mem_available(pinfo, ctx, mconfig))
+			return -ENOMEM;
+
+		ret = ssth_create_pipeline(ctx, mconfig->pipe);
+		if (ret < 0)
+			return ret;
+		if (list_empty(&s_pipe->w_list)) {
+			ret = hda_sst_get_pipe_widget(ctx->dev, w, s_pipe);
+			if (ret < 0)
+				return ret;
+		}
+		ret = hda_init_pipe_modules(ctx, s_pipe, pinfo);
+		if (ret < 0)
+			return ret;
+		return hda_bind_unbind_pipe_modules(ctx, s_pipe, true);
+	}
+	return 0;
+}
+
+static int hda_sst_dapm_post_pmu_event(struct snd_soc_dapm_widget *w,
+	int w_type, struct ssth_lib *ctx, struct hda_platform_info *pinfo)
+{
+	struct ssth_module_config *mconfig = w->priv;
+	struct ssth_pipeline *ppl, *__ppl;
+	int ret = 0;
+
+	dev_dbg(ctx->dev, "%s: widget = %s\n", __func__, w->name);
+
+	ret =  hda_sst_bind_unbind_pipes(w, ctx, true);
+	if (ret < 0)
+		return ret;
+	if (w_type == SSTH_WIDGET_VMIXER ||
+		w_type == SSTH_WIDGET_MIXER) {
+		if (mconfig->pipe->conn_type != SSTH_PIPE_CONN_TYPE_FE) {
+			/*if module is not a FE then add to ppl_start list,
+			to send the run pipe when be is reached */
+			ppl = kzalloc(sizeof(*ppl), GFP_KERNEL);
+			if (!ppl)
+				return -ENOMEM;
+			ppl->pipe = mconfig->pipe;
+			list_add(&ppl->node, &pinfo->ppl_start_list);
+		}
+	}
+
+	if (w_type == SSTH_WIDGET_PGA) {
+		list_for_each_entry_safe(ppl, __ppl, &pinfo->ppl_start_list, node) {
+			list_del(&ppl->node);
+
+			dev_dbg(ctx->dev, "%s: set to run pipe_id =%d\n", __func__, ppl->pipe->ppl_id);
+			ret = ssth_run_pipe(ctx, ppl->pipe);
+			kfree(ppl);
+			if (ret < 0)
+				return ret;
+		}
+	}
+	return ret;
+}
+
+static int hda_sst_dapm_pre_pmd_event(struct snd_soc_dapm_widget *w,
+	int w_type, struct ssth_lib *ctx, struct hda_platform_info *pinfo)
+{
+	struct ssth_module_config *mconfig = w->priv;
+	int ret = 0;
+
+	dev_dbg(ctx->dev, "%s: widget = %s\n", __func__, w->name);
+
+	if (w_type == SSTH_WIDGET_PGA) {
+		if (mconfig->pipe->conn_type != SSTH_PIPE_CONN_TYPE_FE) {
+			ret = ssth_stop_pipe(ctx, mconfig->pipe);
+			if (ret < 0)
+				return ret;
+		}
+	}
+	return ret;
+}
+
+static int hda_sst_dapm_post_pmd_event(struct snd_soc_dapm_widget *w,
+	int w_type, struct ssth_lib *ctx, struct hda_platform_info *pinfo)
+{
+	struct ssth_module_config *mconfig = w->priv;
+	int ret = 0;
+	struct ssth_pipe *s_pipe = mconfig->pipe;
+
+	dev_dbg(ctx->dev, "%s: widget = %s\n", __func__, w->name);
+
+	pinfo->resource.mcps -= mconfig->mcps;
+
+	if (w_type == SSTH_WIDGET_VMIXER ||
+		w_type == SSTH_WIDGET_MIXER) {
+
+		ret = hda_bind_unbind_pipe_modules(ctx, s_pipe, false);
+		if (ret < 0)
+			return ret;
+		ret = hda_unload_pipe_modules(ctx, s_pipe);
+		if (ret < 0)
+			return ret;
+		ret = ssth_delete_pipe(ctx, mconfig->pipe);
+		pinfo->resource.mem -= mconfig->pipe->memory_pages;
+	}
+
+	return ret;
+}
+
+static int hda_sst_event_handler(struct snd_soc_dapm_widget *w,
+				int event, int w_type)
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct hda_soc_bus *hda = dev_get_drvdata(dapm->dev);
+	struct hda_platform_info *pinfo = hda->pinfo;
+	struct ssth_lib *ctx = hda->dsp;
+
+	dev_dbg(dapm->dev, "%s: widget = %s\n", __func__, w->name);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		return hda_sst_dapm_pre_pmu_event(w, w_type, ctx, pinfo);
+	break;
+	case SND_SOC_DAPM_POST_PMU:
+		return hda_sst_dapm_post_pmu_event(w, w_type, ctx, pinfo);
+	break;
+	case SND_SOC_DAPM_PRE_PMD:
+		return hda_sst_dapm_pre_pmd_event(w, w_type, ctx, pinfo);
+	break;
+	case SND_SOC_DAPM_POST_PMD:
+		return hda_sst_dapm_post_pmd_event(w, w_type, ctx, pinfo);
+	break;
+	}
+
+	return 0;
+}
+
+static int hda_sst_vmixer_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *k, int event)
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+
+	dev_dbg(dapm->dev, "%s: widget = %s\n", __func__, w->name);
+	return hda_sst_event_handler(w, event, SSTH_WIDGET_VMIXER);
+}
+
+static int hda_sst_mixer_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *k, int event)
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+
+	dev_dbg(dapm->dev, "%s: widget = %s\n", __func__, w->name);
+
+	return hda_sst_event_handler(w, event, SSTH_WIDGET_MIXER);
+}
+
+static int hda_sst_mux_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *k, int event)
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+
+	dev_dbg(dapm->dev, "%s: widget = %s\n", __func__, w->name);
+
+	return hda_sst_event_handler(w, event, SSTH_WIDGET_MUX);
+}
+
+static int hda_sst_pga_event(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *k, int event)
+
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+
+	dev_dbg(dapm->dev, "%s: widget = %s\n", __func__, w->name);
+	return hda_sst_event_handler(w, event, SSTH_WIDGET_PGA);
+}
+
+static struct ssth_module_config *hda_sst_get_module_by_dir(
+	struct snd_soc_dapm_widget *w, int dir, char *m_type)
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct snd_soc_dapm_widget *w1 = NULL;
+	struct snd_soc_dapm_path *p = NULL;
+	struct ssth_module_config *mconfig = NULL;
+
+	/* get the source modules  dir = 0 source module, dir = 1 sink modules*/
+	if (dir == 0) {
+		dev_dbg(dapm->dev, "Stream name=%s\n", w->name);
+		if (list_empty(&w->sources))
+			return mconfig;
+
+		list_for_each_entry(p, &w->sources, list_sink) {
+			if (p->connected && !p->connected(w, p->source) &&
+				!is_hda_widget_type(p->source) &&
+				(strstr(p->source->name, m_type) == NULL))
+				continue;
+
+			if (p->connect && p->source->priv) {
+				dev_dbg(dapm->dev, "module widget=%s\n", p->source->name);
+				return p->source->priv;
+			}
+			w1 = p->source;
+		}
+	} else {
+		dev_dbg(dapm->dev, "Stream name=%s\n", w->name);
+		if (list_empty(&w->sinks))
+			return mconfig;
+
+		list_for_each_entry(p, &w->sinks, list_source) {
+			if (p->connected && !p->connected(w, p->sink) &&
+				!is_hda_widget_type(p->sink) &&
+				(strstr(p->sink->name, m_type) == NULL))
+				continue;
+
+			if (p->connect && p->sink->priv) {
+				dev_dbg(dapm->dev, "module widget=%s\n", p->sink->name);
+				return p->sink->priv;
+			}
+			w1 = p->sink;
+		}
+	}
+	if (w1 != NULL)
+		mconfig = hda_sst_get_module_by_dir(w1, dir, m_type);
+	return mconfig;
+}
+
+static struct ssth_module_config *hda_sst_get_module(struct snd_soc_dai *dai,
+	int stream, bool is_fe, char *m_type)
+{
+	struct snd_soc_dapm_widget *w;
+	int dir = 0;
+
+	dev_dbg(dai->dev, "%s: enter, dai-name=%s dir=%d\n", __func__, dai->name, stream);
+
+	/* if FE - Playback, then parse sink list , Capture then source list
+	if BE - Playback, then parse source list , Capture then sink list
+	*/
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		w = dai->playback_widget;
+		(is_fe) ? (dir = 1) : (dir = 0);
+	} else {
+		w = dai->capture_widget;
+		(is_fe) ? (dir = 0) : (dir = 1);
+	}
+	return hda_sst_get_module_by_dir(w, dir, m_type);
+}
+
+static void hda_set_module_params(struct ssth_module_config *mconfig,
+	struct snd_pcm_hw_params *params, bool is_in_fmt)
+{
+	struct ssth_module_format *format = NULL;
+
+	if (is_in_fmt)
+		format = &mconfig->in_fmt;
+	else
+		format = &mconfig->out_fmt;
+	/*set the hw_params */
+	format->sampling_freq = params_rate(params);
+	format->channels = params_channels(params);
+	format->valid_bit_depth = ssth_get_bit_depth(params);
+	if (format->valid_bit_depth == SSTH_DEPTH_16BIT)
+		format->bit_depth = format->valid_bit_depth;
+	else if (format->valid_bit_depth == SSTH_DEPTH_24BIT)
+		format->bit_depth = SSTH_DEPTH_32BIT;
+	if (is_in_fmt) {
+		mconfig->ibs = (format->sampling_freq / 1000) *
+				(format->channels) *
+				(format->bit_depth >> 3);
+	} else {
+		mconfig->obs = (format->sampling_freq / 1000) *
+				(format->channels) *
+				(format->bit_depth >> 3);
+	}
+}
+
+void hda_sst_set_copier_hw_params(struct snd_soc_dai *dai,
+	struct snd_pcm_hw_params *params, int stream, bool is_fe)
+{
+	struct ssth_module_config *mconfig = NULL;
+	bool in_fmt;
+
+	dev_dbg(dai->dev,
+		"%s: enter, dai-name=%s dir=%d\n", __func__, dai->name, stream);
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+		in_fmt = true;
+	else
+		in_fmt = false;
+	mconfig = hda_sst_get_module(dai, stream, is_fe, "cpr");
+	if (mconfig != NULL)
+		hda_set_module_params(mconfig, params, in_fmt);
+}
+
+void hda_sst_set_copier_dma_id(struct snd_soc_dai *dai, int dma_id, int stream,
+		bool is_fe)
+{
+	struct ssth_module_config *mconfig = NULL;
+
+	dev_dbg(dai->dev,
+		 "%s: enter, dai-name=%s dir=%d\n", __func__,
+		dai->name, stream);
+	mconfig = hda_sst_get_module(dai, stream, is_fe, "cpr");
+	if (mconfig != NULL)
+		mconfig->dma_id = dma_id;
+	return;
+}
+
+/*set BE copier I2s,DMIC, SLIMBUS config*/
+void hda_sst_set_be_copier_caps(struct snd_soc_dai *dai,
+	struct ssth_specific_config *configs, int stream)
+{
+	struct ssth_module_config *mconfig = NULL;
+
+	dev_dbg(dai->dev, "%s: enter, dai-name=%s\n", __func__, dai->name);
+	mconfig = hda_sst_get_module(dai, stream, false, "cpr");
+	if (mconfig != NULL && configs->caps_size != 0) {
+		memcpy(mconfig->formats_config.caps,
+		configs->caps,
+		configs->caps_size);
+
+		mconfig->formats_config.caps_size = configs->caps_size;
+	}
+}
+
+void hda_sst_set_be_dmic_config(struct snd_soc_dai *dai,
+	struct snd_pcm_hw_params *params, int stream)
+{
+	struct ssth_module_config *mconfig = NULL;
+	u32 outctrl;
+
+	dev_dbg(dai->dev, "%s: enter, dai-name=%s\n", __func__, dai->name);
+	mconfig = hda_sst_get_module(dai, stream, false, "cpr");
+	if (mconfig != NULL && mconfig->formats_config.caps_size != 0) {
+		/*FIXME need to fix based on the FW dmic interface struct.
+		the parameter to set here should to set the DMIC mode.
+		currenltly using timeslot
+		*/
+		if (strncmp(dai->name, "DMIC23 Pin", strlen(dai->name)) == 0) {
+			mconfig->time_slot = 1;
+			outctrl = mconfig->formats_config.caps[3];
+		} else
+			outctrl = mconfig->formats_config.caps[2];
+
+		if (ssth_get_bit_depth(params)  == SSTH_DEPTH_16BIT)
+			outctrl &= ~BIT(19);
+		else if (ssth_get_bit_depth(params) == SSTH_DEPTH_24BIT)
+			outctrl |= BIT(19);
+		if (strncmp(dai->name, "DMIC23 Pin", strlen(dai->name)) == 0)
+			mconfig->formats_config.caps[3] = outctrl;
+		else
+			mconfig->formats_config.caps[2] = outctrl;
+		dev_dbg(dai->dev, "%s: outctrl =%x\n", __func__, outctrl);
+		hda_set_module_params(mconfig, params, true);
+
+		/*FIXME need to fix based on the FW dmic interface struct.
+		the parameter to set here should to set the DMIC mode.
+		currenltly using timeslot
+		*/
+		if (strncmp(dai->name, "DMIC23 Pin", strlen(dai->name)) == 0)
+			mconfig->time_slot = 1;
+
+	}
+}
+
+int hda_sst_set_fe_pipeline_state(struct snd_soc_dai *dai, bool start,
+		 int stream)
+{
+	struct hda_soc_bus *hda = dev_get_drvdata(dai->dev);
+	struct ssth_lib *ctx = hda->dsp;
+
+	struct ssth_module_config *mconfig = NULL;
+	int ret = 0;
+
+	dev_dbg(dai->dev, "%s: enter, dai-name=%s dir=%d\n", __func__,
+		 dai->name, stream);
+	mconfig = hda_sst_get_module(dai, stream, true, "cpr");
+	if (mconfig != NULL) {
+		if (start)
+			ret = ssth_run_pipe(ctx, mconfig->pipe);
+		else
+			ret = ssth_stop_pipe(ctx, mconfig->pipe);
+	}
+
+	return ret;
+}
diff --git a/sound/soc/hda/hda_skl.h b/sound/soc/hda/hda_skl.h
index 914ea05da6aa..f6d9c629a8e3 100644
--- a/sound/soc/hda/hda_skl.h
+++ b/sound/soc/hda/hda_skl.h
@@ -15,7 +15,9 @@ struct hda_soc_bus {
 
 	unsigned int init_failed:1; /* delayed init failed */
 	unsigned int msi:1;
+
 	struct ssth_lib *dsp; /* ssth lib ctx */
+	struct hda_platform_info *pinfo; /* platform component info*/
 };
 
 /*to pass dai dma data */
@@ -24,6 +26,21 @@ struct soc_hda_dma_params {
 	u8 stream_tag;
 };
 
+struct ssth_dsp_resource {
+	u32 max_mcps;
+	u32 max_mem;
+	u32 mcps;
+	u32 mem;
+};
+
+struct hda_platform_info {
+	struct hda_soc_bus schip;
+	struct device *dev;
+	struct ssth_dsp_resource resource;
+	struct list_head ppl_list;
+	struct list_head ppl_start_list;
+};
+
 int azx_get_delay_from_lpib(struct hdac_bus *chip,
 				struct hdac_stream *azx_dev,
 				unsigned int pos);
diff --git a/sound/soc/hda/hda_soc_dsp.c b/sound/soc/hda/hda_soc_dsp.c
index 5f36ebdc0fba..ce1527602e00 100644
--- a/sound/soc/hda/hda_soc_dsp.c
+++ b/sound/soc/hda/hda_soc_dsp.c
@@ -652,7 +652,7 @@ int ssth_run_pipe(struct ssth_lib *ctx, struct ssth_pipe *pipe)
 /*
  * Sets pipe state to PAUSED in FW, stops DMA engines and releases resources
  */
-int hda_sst_delete_pipe(struct ssth_lib *ctx, struct ssth_pipe *pipe)
+int ssth_delete_pipe(struct ssth_lib *ctx, struct ssth_pipe *pipe)
 {
 	int ret = 0;
 
@@ -682,7 +682,7 @@ delete_pipe:
 	return ret;
 }
 
-int hda_sst_stop_pipe(struct ssth_lib *ctx, struct ssth_pipe *pipe)
+int ssth_stop_pipe(struct ssth_lib *ctx, struct ssth_pipe *pipe)
 {
 	int ret = 0;
 
-- 
1.7.9.5
