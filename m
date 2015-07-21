From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 6/6] ASoC: Intel: Skylake: Add pipe management
	helpers
Date: Tue, 21 Jul 2015 23:54:00 +0530
Message-ID: <1437503040-7392-7-git-send-email-vinod.koul@intel.com>
References: <1437503040-7392-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id A18082650DB
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2015 20:22:26 +0200 (CEST)
In-Reply-To: <1437503040-7392-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

To manage the DSP pipelines we need routines to create, delete and
message creation helpers. These helpers also check status and creates
IPC messages with the required parameter and send using IPC lib
interface.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 114 +++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-topology.h |   5 ++
 2 files changed, 119 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 72af582183ae..002297249c11 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -712,3 +712,117 @@ int skl_bind_unbind_modules(struct skl_sst *ctx, struct skl_module_cfg
 	else
 		return skl_unbind_modules(ctx, src_module, dst_module);
 }
+
+static int skl_set_pipe_state(struct skl_sst *ctx, struct skl_pipe *pipe,
+	enum skl_pipe_state state)
+{
+	dev_dbg(ctx->dev, "%s: pipe_satate = %d\n", __func__, state);
+
+	return skl_ipc_set_pipeline_state(&ctx->ipc, pipe->ppl_id, state);
+}
+
+/*
+ * Creates pipeline, by sending IPC messages to FW
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
+ * Sets pipe state to RUNNING
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
+ * Sets pipe state to PAUSED in FW, stops DMA engines and releases resources
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
index c944ec024e62..f5584d189ef0 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -263,6 +263,11 @@ struct skl_module_cfg {
 	struct skl_specific_cfg formats_config;
 };
 
+int skl_create_pipeline(struct skl_sst *ctx, struct skl_pipe *pipe);
+int skl_run_pipe(struct skl_sst *ctx, struct skl_pipe *pipe);
+int skl_pause_pipe(struct skl_sst *ctx, struct skl_pipe *pipe);
+int skl_delete_pipe(struct skl_sst *ctx, struct skl_pipe *pipe);
+int skl_stop_pipe(struct skl_sst *ctx, struct skl_pipe *pipe);
 int skl_init_module(struct skl_sst *ctx, struct skl_module_cfg *module_config,
 	char *param);
 int skl_bind_unbind_modules(struct skl_sst *ctx, struct skl_module_cfg
-- 
1.9.1
