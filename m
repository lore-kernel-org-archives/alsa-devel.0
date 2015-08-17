From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 3/9] ASoC: Intel: Skylake: add DSP platform
	widget event handlers
Date: Mon, 17 Aug 2015 22:56:38 +0530
Message-ID: <1439832404-12424-4-git-send-email-vinod.koul@intel.com>
References: <1439832404-12424-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id E24E0260410
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 19:24:48 +0200 (CEST)
In-Reply-To: <1439832404-12424-1-git-send-email-vinod.koul@intel.com>
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
Cc: patches.audio@intel.com, Hardik T Shah <hardik.t.shah@intel.com>, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

The Skylake driver topology model tries to model the firmware
rule for pipeline and module creation.
The creation rule is:
 - Create Pipe
 - Add modules to Pipe
 - Connect the modules (bind)
 - Start the pipes

Similarly destroy rule is:
 - Stop the pipe
 - Disconnect it (unbind)
 - Delete the pipe

In driver we use Mixer, as there will always be ONE mixer in a
pipeline to model a pipe. The modules in pipe are modelled as PGA
widgets.  The DAPM sequencing rules (mixer and then PGA) are used
to create the sequence DSP expects as depicted above, and then
widget handlers for PMU and PMD events help in that.

This patch adds widget event handlers for PRE/POST PMU and
PRE/POST PMD event for mixer and pga modules.  These event
handlers invoke pipeline creation, destroy, module creation,
module bind, unbind and pipeline bind unbind

Event handler sequencing is implement to target the DSP FW
sequence expectations to enable path from source to sink pipe for
Playback/Capture.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 416 +++++++++++++++++++++++++++++++++
 1 file changed, 416 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 81b0683bbdeb..184697188a96 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -344,3 +344,419 @@ static int skl_tplg_bind_unbind_pipe_modules(struct skl_sst *ctx,
 	}
 	return 0;
 }
+
+/*
+ * Mixer module represents a pipeline. So in the Pre-PMU event of mixer we
+ * need create the pipeline. So we do following:
+ *   - check the resources
+ *   - Create the pipeline
+ *   - Initialize the modules in pipeline
+ *   - finally bind all modules together
+ */
+
+static int skl_tplg_mixer_dapm_pre_pmu_event(struct snd_soc_dapm_widget *w,
+								struct skl *skl)
+{
+	int ret;
+	struct skl_module_cfg *mconfig = w->priv;
+	struct skl_pipe *s_pipe = mconfig->pipe;
+	struct skl_sst *ctx = skl->skl_sst;
+
+	dev_dbg(ctx->dev, "%s: widget =%s\n", __func__, w->name);
+
+	/* check resource available */
+	if (!skl_tplg_is_pipe_mcps_available(skl, mconfig))
+		return -EBUSY;
+
+	if (!skl_tplg_is_pipe_mem_available(skl, mconfig))
+		return -ENOMEM;
+
+	/*
+	 * Create list of modules for pipe
+	 * list contains modules from source to sink
+	 */
+	ret = skl_create_pipeline(ctx, mconfig->pipe);
+	if (ret < 0)
+		return ret;
+
+	if (list_empty(&s_pipe->w_list)) {
+		ret = skl_tplg_get_pipe_widget(ctx->dev, w, s_pipe);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Init all pipe modules from source to sink */
+	ret = skl_tplg_init_pipe_modules(skl, s_pipe);
+	if (ret < 0)
+		return ret;
+
+	/* Bind modules from source to sink */
+	return skl_tplg_bind_unbind_pipe_modules(ctx, s_pipe, true);
+}
+/*
+ * A PGA represents a module in a pipeline. So in the Pre-PMU event of PGA
+ * we need to do following:
+ *   - Bind to sink pipeline
+ *   	Since the sink pipes can be running and we don't get mixer event on
+ *   	connect for already running mixer, we need to find the sink pipes
+ *   	here and bind to them. This way dynamic connect works.
+ *   - Start sink pipeline, if not running
+ *   - Then run current pipe
+ */
+static int skl_tplg_pga_dapm_pre_pmu_event(struct snd_soc_dapm_widget *w,
+								struct skl *skl)
+{
+	struct snd_soc_dapm_path *p;
+	struct skl_dapm_path_list *path_list;
+	struct snd_soc_dapm_widget *source, *sink;
+	struct skl_module_cfg *src_mconfig, *sink_mconfig;
+	struct skl_sst *ctx = skl->skl_sst;
+	int ret = 0;
+
+	dev_dbg(ctx->dev, "%s: widget =%s\n", __func__, w->name);
+
+	source = w;
+	src_mconfig = source->priv;
+
+	/*
+	 * find which sink it is connected to, bind with the sink,
+	 * if sink is not started, start sink pipe first, then start
+	 * this pipe
+	 */
+	list_for_each_entry(p, &w->sinks, list_source) {
+		if (!p->connect)
+			continue;
+
+		dev_dbg(ctx->dev, "%s: src widget=%s\n", __func__, w->name);
+		dev_dbg(ctx->dev, "%s: sink widget=%s\n", __func__, p->sink->name);
+
+		/*
+		 * here we will check widgets in sink pipelines, so that can
+		 * be any widgets type and we are only interested if they are
+		 * ones used for SKL so check that first
+		 */
+		if ((p->sink->priv != NULL) && is_skl_dsp_widget_type(p->sink)) {
+
+			sink = p->sink;
+			src_mconfig = source->priv;
+			sink_mconfig = sink->priv;
+
+			/* Bind source to sink, mixin is always source */
+			ret = skl_tplg_bind_unbind_pipes(src_mconfig,
+						sink_mconfig, ctx, true);
+			if (ret)
+				return ret;
+
+			/* Start sinks pipe first */
+			if (sink_mconfig->pipe->state != SKL_PIPE_STARTED) {
+				ret = skl_run_pipe(ctx, sink_mconfig->pipe);
+				if (ret)
+					return ret;
+			}
+
+			path_list = kzalloc(sizeof(struct skl_dapm_path_list),
+								GFP_KERNEL);
+			if (NULL == path_list)
+				return -ENOMEM;
+
+			/* Add connected path to one global list */
+			path_list->dapm_path = p;
+			list_add_tail(&path_list->node, &skl->dapm_path_list);
+			break;
+		}
+	}
+
+	/* Start source pipe last after starting all sinks */
+	ret = skl_run_pipe(ctx, src_mconfig->pipe);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/*
+ * in the Post-PMU event of mixer we need to do following:
+ *   - Check if this pipe is running
+ *   - if not, then
+ *	- bind this pipeline to its source pipeline
+ *	  if source pipe is already running, this means it is a dynamic
+ *	  connection and we need to bind only to that pipe
+ *	- start this pipeline
+ */
+static int skl_tplg_mixer_dapm_post_pmu_event(struct snd_soc_dapm_widget *w,
+								struct skl *skl)
+{
+	int ret = 0;
+	struct snd_soc_dapm_path *p;
+	struct snd_soc_dapm_widget *source, *sink;
+	struct skl_module_cfg *src_mconfig, *sink_mconfig;
+	struct skl_sst *ctx = skl->skl_sst;
+	int src_pipe_started = 0;
+
+	dev_dbg(ctx->dev, "%s: widget = %s\n", __func__, w->name);
+
+	sink = w;
+	sink_mconfig = sink->priv;
+
+	/*
+	 * If source pipe is already started, that means source is driving
+	 * one more sink before this sink got connected, Since source is
+	 * started, bind this sink to source and start this pipe.
+	 */
+	list_for_each_entry(p, &w->sources, list_sink) {
+		if (!p->connect)
+			continue;
+		dev_dbg(ctx->dev, "sink widget=%s\n", w->name);
+		dev_dbg(ctx->dev, "src widget=%s\n", p->source->name);
+
+		/*
+		 * here we will check widgets in sink pipelines, so that can
+		 * be any widgets type and we are only interested if they are
+		 * ones used for SKL so check that first
+		 */
+		if ((p->source->priv != NULL) && is_skl_dsp_widget_type(p->source)) {
+			source = p->source;
+			src_mconfig = source->priv;
+			sink_mconfig = sink->priv;
+			src_pipe_started = 1;
+
+			/*
+			 * check pipe state, then no need to bind or start the
+			 * pipe
+			 */
+			if (src_mconfig->pipe->state != SKL_PIPE_STARTED)
+				src_pipe_started = 0;
+		}
+	}
+
+	if (src_pipe_started) {
+		ret = skl_tplg_bind_unbind_pipes(src_mconfig, sink_mconfig,
+							 ctx, true);
+		if (ret)
+			return ret;
+
+		return skl_run_pipe(ctx, sink_mconfig->pipe);
+	}
+
+	return ret;
+}
+
+/*
+ * in the Pre-PMD event of mixer we need to do following:
+ *   - Stop the pipe
+ *   - find the source connections and remove that from dapm_path_list
+ *   - unbind with source pipelines if still connected
+ */
+static int skl_tplg_mixer_dapm_pre_pmd_event(struct snd_soc_dapm_widget *w,
+								struct skl *skl)
+{
+	struct snd_soc_dapm_widget *source, *sink;
+	struct skl_module_cfg *src_mconfig, *sink_mconfig;
+	int ret = 0, path_found = 0;
+	struct skl_dapm_path_list *path_list, *tmp_list;
+	struct skl_sst *ctx = skl->skl_sst;
+
+	dev_dbg(ctx->dev, "%s: widget = %s\n", __func__, w->name);
+
+	sink = w;
+	sink_mconfig = sink->priv;
+
+	/* Stop the pipe */
+	ret = skl_stop_pipe(ctx, sink_mconfig->pipe);
+	if (ret)
+		return ret;
+
+	list_for_each_entry_safe(path_list, tmp_list, &skl->dapm_path_list, node) {
+		if (path_list->dapm_path->sink == sink) {
+			dev_dbg(ctx->dev, "Path found = %s\n", path_list->dapm_path->name);
+			source = path_list->dapm_path->source;
+			src_mconfig = source->priv;
+			path_found = 1;
+
+			list_del(&path_list->node);
+			kfree(path_list);
+			break;
+		}
+	}
+
+	/*
+	 * If path_found == 1, that means pmd for source pipe has
+	 * not occurred, source is connected to some other sink.
+	 * so its responsibility of sink to unbind itself from source.
+	 */
+	if (path_found)
+		ret = skl_tplg_bind_unbind_pipes(src_mconfig, sink_mconfig,
+							 ctx, false);
+
+	return ret;
+}
+
+/*
+ * in the Post-PMD event of mixer we need to do following:
+ *   - Free the mcps used
+ *   - Free the mem used
+ *   - Unbind the modules within the pipeline
+ *   - Delete the pipeline (modules are not required to be explicitly
+ *     deleted, pipeline delete is enough here
+ */
+static int skl_tplg_mixer_dapm_post_pmd_event(struct snd_soc_dapm_widget *w,
+								struct skl *skl)
+{
+	struct skl_module_cfg *mconfig = w->priv;
+	int ret = 0;
+	struct skl_sst *ctx = skl->skl_sst;
+	struct skl_pipe *s_pipe = mconfig->pipe;
+
+	dev_dbg(ctx->dev, "%s: widget = %s\n", __func__, w->name);
+
+	skl->resource.mcps -= mconfig->mcps;
+
+	ret = skl_tplg_bind_unbind_pipe_modules(ctx, s_pipe, false);
+	if (ret < 0)
+		return ret;
+
+	ret = skl_delete_pipe(ctx, mconfig->pipe);
+	skl->resource.mem -= mconfig->pipe->memory_pages;
+
+	return ret;
+}
+
+/*
+ * in the Post-PMD event of PGA we need to do following:
+ *   - Free the mcps used
+ *   - Stop the pipeline
+ *   - In source pipe is connected, unbind with source pipelines
+ */
+static int skl_tplg_pga_dapm_post_pmd_event(struct snd_soc_dapm_widget *w,
+								struct skl *skl)
+{
+	struct snd_soc_dapm_widget *source, *sink;
+	struct skl_module_cfg *src_mconfig, *sink_mconfig;
+	int ret = 0, path_found = 0;
+	struct skl_dapm_path_list *path_list, *tmp_path_list;
+	struct skl_sst *ctx = skl->skl_sst;
+
+	dev_dbg(ctx->dev, "%s: widget = %s\n", __func__, w->name);
+
+	source = w;
+	src_mconfig = source->priv;
+
+	skl->resource.mcps -= src_mconfig->mcps;
+	/* Stop the pipe since this is a mixin module */
+	ret = skl_stop_pipe(ctx, src_mconfig->pipe);
+	if (ret)
+		return ret;
+
+	list_for_each_entry_safe(path_list, tmp_path_list, &skl->dapm_path_list, node) {
+		if (path_list->dapm_path->source == source) {
+			dev_dbg(ctx->dev, "Path found = %s\n", path_list->dapm_path->name);
+			sink = path_list->dapm_path->sink;
+			sink_mconfig = sink->priv;
+			path_found = 1;
+
+			list_del(&path_list->node);
+			kfree(path_list);
+			break;
+		}
+	}
+
+	/*
+	 * This is a connector and if path is found that means
+	 * unbind between source and sink has not happened yet
+	 */
+	if (path_found)
+		ret = skl_tplg_bind_unbind_pipes(src_mconfig, sink_mconfig,
+							 ctx, false);
+
+	return ret;
+}
+
+static struct skl *get_skl_ctx(struct device *dev)
+{
+	struct hdac_ext_bus *ebus = dev_get_drvdata(dev);
+
+	return ebus_to_skl(ebus);
+}
+
+/*
+ * In modelling, we assume there will be ONLY one mixer in a pipeline.  If
+ * mixer is not required then it is treated as static mixer aka vmixer with
+ * a hard path to source module
+ * So we don't need to check if source is started or not as hard path puts
+ * dependency on each other
+ */
+static int skl_tplg_vmixer_event(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *k, int event)
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct skl *skl = get_skl_ctx(dapm->dev);
+
+	dev_dbg(dapm->dev, "%s:widget=%s event=%d\n", __func__, w->name, event);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		return skl_tplg_mixer_dapm_pre_pmu_event(w, skl);
+
+	case SND_SOC_DAPM_POST_PMD:
+		return skl_tplg_mixer_dapm_post_pmd_event(w, skl);
+	}
+
+	return 0;
+}
+
+/*
+ * In modelling, we assume there will be ONLY one mixer in a pipeline. If a
+ * second one is required that is created as another pipe entity.
+ * The mixer is responsible for pipe management and represent a pipeline
+ * instance
+ */
+static int skl_tplg_mixer_event(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *k, int event)
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct skl *skl = get_skl_ctx(dapm->dev);
+
+	dev_dbg(dapm->dev, "%s:widget=%s event=%d\n", __func__, w->name, event);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		return skl_tplg_mixer_dapm_pre_pmu_event(w, skl);
+
+	case SND_SOC_DAPM_POST_PMU:
+		return skl_tplg_mixer_dapm_post_pmu_event(w, skl);
+
+	case SND_SOC_DAPM_PRE_PMD:
+		return skl_tplg_mixer_dapm_pre_pmd_event(w, skl);
+
+	case SND_SOC_DAPM_POST_PMD:
+		return skl_tplg_mixer_dapm_post_pmd_event(w, skl);
+	}
+
+	return 0;
+}
+
+/*
+ * In modelling, we assumed rest of the modules in pipeline are PGA. But we
+ * are interested in last PGA (leaf PGA) in a pipeline to disconnect with
+ * the sink when it is running (two FE to one BE or one FE to two BE)
+ * scenarios
+ */
+static int skl_tplg_pga_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *k, int event)
+
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct skl *skl = get_skl_ctx(dapm->dev);
+
+	dev_dbg(dapm->dev, "%s:widget=%s event=%d\n", __func__, w->name, event);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		return skl_tplg_pga_dapm_pre_pmu_event(w, skl);
+
+	case SND_SOC_DAPM_POST_PMD:
+		return skl_tplg_pga_dapm_post_pmd_event(w, skl);
+	}
+
+	return 0;
+}
-- 
1.9.1
