From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 04/13] ASoC: Intel: Skylake: Add pipe
	management helpers
Date: Fri,  7 Aug 2015 23:52:20 +0530
Message-ID: <1438971749-874-5-git-send-email-subhransu.s.prusty@intel.com>
References: <1438971749-874-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id D47E6261B2A
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 20:23:17 +0200 (CEST)
In-Reply-To: <1438971749-874-1-git-send-email-subhransu.s.prusty@intel.com>
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

From: Jeeja KP <jeeja.kp@intel.com>

To manage DSP we need to create processing pipeline and on cleanup destroy
them. So we add create and destroy routines for pipelines.

The pipelines need to to be executed so we add pipeline run and stop
routines All these send required IPCs to DSP using IPC routines added
earlier.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 126 +++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-topology.h |  10 +++
 2 files changed, 136 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index c435a51..826d4fd 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -756,3 +756,129 @@ int skl_bind_modules(struct skl_sst *ctx,
 
 	return ret;
 }
+
+static int skl_set_pipe_state(struct skl_sst *ctx, struct skl_pipe *pipe,
+	enum skl_ipc_pipeline_state state)
+{
+	dev_dbg(ctx->dev, "%s: pipe_satate = %d\n", __func__, state);
+
+	return skl_ipc_set_pipeline_state(&ctx->ipc, pipe->ppl_id, state);
+}
+
+/*
+ * A pipeline is a collection of modules. Before a module in instantiated a
+ * pipeline needs to be created for it.
+ * This function creates pipeline, by sending create pipeline IPC messages
+ * to FW
+ */
+int skl_create_pipeline(struct skl_sst *ctx, struct skl_pipe *pipe)
+{
+	int ret;
+
+	dev_dbg(ctx->dev, "%s: pipe_id = %d\n", __func__, pipe->ppl_id);
+
+	ret = skl_ipc_create_pipeline(&ctx->ipc, pipe->memory_pages,
+				pipe->pipe_priority, pipe->ppl_id);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Failed to create pipeline\n");
+		return ret;
+	}
+
+	pipe->state = SKL_PIPE_CREATED;
+
+	return 0;
+}
+
+/*
+ * A pipeline needs to be deleted on cleanup. If a pipeline is running, then
+ * pause the pipeline first and then delete it
+ * The pipe delete is done by sending delete pipeline IPC. DSP will stop the
+ * DMA engines and releases resources
+ */
+int skl_delete_pipe(struct skl_sst *ctx, struct skl_pipe *pipe)
+{
+	int ret;
+
+	dev_dbg(ctx->dev, "%s: pipe = %d\n", __func__, pipe->ppl_id);
+
+	/* If pipe is not started, do not try to stop the pipe in FW. */
+	if (pipe->state > SKL_PIPE_STARTED) {
+		ret = skl_set_pipe_state(ctx, pipe, PPL_PAUSED);
+		if (ret < 0) {
+			dev_err(ctx->dev, "Failed to stop pipeline\n");
+			return ret;
+		}
+
+		pipe->state = SKL_PIPE_PAUSED;
+	} else {
+		/* If pipe was not created in FW, do not try to delete it */
+		if (pipe->state < SKL_PIPE_CREATED)
+			return 0;
+
+		ret = skl_ipc_delete_pipeline(&ctx->ipc, pipe->ppl_id);
+		if (ret < 0)
+			dev_err(ctx->dev, "Failed to delete pipeline\n");
+	}
+
+	return ret;
+}
+
+/*
+ * A pipeline is also a scheduling entity in DSP which can be run, stopped
+ * For processing data the pipe need to be run by sending IPC set pipe state
+ * to DSP
+ */
+int skl_run_pipe(struct skl_sst *ctx, struct skl_pipe *pipe)
+{
+	int ret;
+
+	dev_dbg(ctx->dev, "%s: pipe = %d\n", __func__, pipe->ppl_id);
+
+	/* If pipe was not created in FW, do not try to pause or delete */
+	if (pipe->state < SKL_PIPE_CREATED)
+		return 0;
+
+	/* Pipe has to be paused before it is started */
+	ret = skl_set_pipe_state(ctx, pipe, PPL_PAUSED);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Failed to pause pipe\n");
+		return ret;
+	}
+
+	pipe->state = SKL_PIPE_PAUSED;
+
+	ret = skl_set_pipe_state(ctx, pipe, PPL_RUNNING);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Failed to start pipe\n");
+		return ret;
+	}
+
+	pipe->state = SKL_PIPE_STARTED;
+
+	return 0;
+}
+
+/*
+ * Stop the pipeline by sending set pipe state IPC
+ * DSP doesnt implement stop so we always send pause message
+ */
+int skl_stop_pipe(struct skl_sst *ctx, struct skl_pipe *pipe)
+{
+	int ret;
+
+	dev_dbg(ctx->dev, "In %s pipe=%d\n", __func__, pipe->ppl_id);
+
+	/* If pipe was not created in FW, do not try to pause or delete */
+	if (pipe->state < SKL_PIPE_PAUSED)
+		return 0;
+
+	ret = skl_set_pipe_state(ctx, pipe, PPL_PAUSED);
+	if (ret < 0) {
+		dev_dbg(ctx->dev, "Failed to stop pipe\n");
+		return ret;
+	}
+
+	pipe->state = SKL_PIPE_CREATED;
+
+	return 0;
+}
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index b7e8aa8..8c7767b 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -263,6 +263,16 @@ struct skl_module_cfg {
 	struct skl_specific_cfg formats_config;
 };
 
+int skl_create_pipeline(struct skl_sst *ctx, struct skl_pipe *pipe);
+
+int skl_run_pipe(struct skl_sst *ctx, struct skl_pipe *pipe);
+
+int skl_pause_pipe(struct skl_sst *ctx, struct skl_pipe *pipe);
+
+int skl_delete_pipe(struct skl_sst *ctx, struct skl_pipe *pipe);
+
+int skl_stop_pipe(struct skl_sst *ctx, struct skl_pipe *pipe);
+
 int skl_init_module(struct skl_sst *ctx, struct skl_module_cfg *module_config,
 	char *param);
 
-- 
2.4.3
