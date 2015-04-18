From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 4/7] ASoC: hda: add FW pipe
	create/delete/set_pipe_state IPC
Date: Sun, 19 Apr 2015 02:27:30 +0530
Message-ID: <1429390653-8194-5-git-send-email-vinod.koul@intel.com>
References: <1429390653-8194-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id DC53726517F
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 23:02:50 +0200 (CEST)
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

This helper function is called when FW pipeline has to created/deleted/ to
set the pipe to run/pause and uses IPC lib to send the msg to dsp.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/hda/hda_soc_dsp.c |  112 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/sound/soc/hda/hda_soc_dsp.c b/sound/soc/hda/hda_soc_dsp.c
index 5a9927b82852..5f36ebdc0fba 100644
--- a/sound/soc/hda/hda_soc_dsp.c
+++ b/sound/soc/hda/hda_soc_dsp.c
@@ -588,3 +588,115 @@ int ssth_bind_unbind_modules(struct ssth_lib *ctx, struct ssth_module_config
 	}
 	return ret;
 }
+
+static int ssth_set_pipe_state(struct ssth_lib *ctx, struct ssth_pipe *pipe,
+	enum ssth_pipe_state state)
+{
+	int ret = 0;
+
+	dev_dbg(ctx->dev, "%s: pipe_satate = %d\n", __func__, state);
+	ret = ssth_ipc_set_pipeline_state(ctx->ipc, pipe->ppl_id, state);
+	return ret;
+}
+
+/*
+ * Creates pipeline, by sending IPC messages to FW
+ */
+int ssth_create_pipeline(struct ssth_lib *ctx, struct ssth_pipe *pipe)
+{
+	int ret = 0;
+
+	dev_dbg(ctx->dev, "%s: pipe_id = %d\n", __func__, pipe->ppl_id);
+
+	ret = ssth_ipc_create_pipeline(ctx->ipc, pipe->memory_pages,
+				pipe->pipe_priority, pipe->ppl_id);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Failed to create pipeline\n");
+		return ret;
+	}
+	pipe->state = SSTH_PIPE_STATE_CREATED;
+	return ret;
+}
+
+/*
+ * Sets pipe state to RUNNING
+ */
+int ssth_run_pipe(struct ssth_lib *ctx, struct ssth_pipe *pipe)
+{
+	int ret = 0;
+
+	dev_dbg(ctx->dev, "%s: pipe = %d\n", __func__, pipe->ppl_id);
+
+	/* If pipe was not created in FW, do not try to pause or delete */
+	if (pipe->state < SSTH_PIPE_STATE_CREATED)
+		return ret;
+
+	/* Pipe has to be paused before it is started */
+	ret = ssth_set_pipe_state(ctx, pipe, PPL_PAUSED);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Failed to pause pipe\n");
+		return ret;
+	}
+	pipe->state = SSTH_PIPE_STATE_PAUSED;
+	ret = ssth_set_pipe_state(ctx, pipe, PPL_RUNNING);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Failed to start pipe\n");
+		return ret;
+	}
+
+	pipe->state = SSTH_PIPE_STATE_STARTED;
+
+	return ret;
+}
+
+/*
+ * Sets pipe state to PAUSED in FW, stops DMA engines and releases resources
+ */
+int hda_sst_delete_pipe(struct ssth_lib *ctx, struct ssth_pipe *pipe)
+{
+	int ret = 0;
+
+	dev_dbg(ctx->dev, "%s: pipe = %d\n", __func__, pipe->ppl_id);
+
+	/* If pipe is not started, do not try to stop the pipe in FW. */
+	if (pipe->state < SSTH_PIPE_STATE_STARTED)
+		goto delete_pipe;
+
+	ret = ssth_set_pipe_state(ctx, pipe, PPL_PAUSED);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Failed to stop pipeline\n");
+		return ret;
+	}
+	pipe->state = SSTH_PIPE_STATE_PAUSED;
+
+delete_pipe:
+	/* If pipe was not created in FW, do not try to delete it */
+	if (pipe->state < SSTH_PIPE_STATE_CREATED)
+		return ret;
+
+	ret = ssth_ipc_delete_pipeline(ctx->ipc, pipe->ppl_id);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Failed to delete pipeline\n");
+		return ret;
+	}
+	return ret;
+}
+
+int hda_sst_stop_pipe(struct ssth_lib *ctx, struct ssth_pipe *pipe)
+{
+	int ret = 0;
+
+	dev_dbg(ctx->dev, "In %s pipe=%d\n", __func__, pipe->ppl_id);
+
+	/* If pipe was not created in FW, do not try to pause or delete */
+	if (pipe->state < SSTH_PIPE_STATE_PAUSED)
+		return ret;
+	ret = ssth_set_pipe_state(ctx, pipe, PPL_PAUSED);
+	if (ret < 0) {
+		dev_dbg(ctx->dev, "Failed to stop pipe\n");
+		return ret;
+	}
+	pipe->state = SSTH_PIPE_STATE_CREATED;
+
+	return ret;
+}
-- 
1.7.9.5
