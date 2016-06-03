From: jeeja.kp@intel.com
Subject: [PATCH 03/10] ASoC: Intel: Skylake: Don't pause
	stopped pipeline while deleting
Date: Fri,  3 Jun 2016 18:29:36 +0530
Message-ID: <1464958783-19344-4-git-send-email-jeeja.kp@intel.com>
References: <1464958783-19344-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 676132612DF
 for <alsa-devel@alsa-project.org>; Fri,  3 Jun 2016 14:56:33 +0200 (CEST)
In-Reply-To: <1464958783-19344-1-git-send-email-jeeja.kp@intel.com>
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
Cc: Dharageswari R <dharageswari.r@intel.com>, patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Dharageswari R <dharageswari.r@intel.com>

If pipeline is not STARTED, we do not need to pause pipeline while
deleting.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 07d2a73..804091a 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -1046,7 +1046,7 @@ int skl_delete_pipe(struct skl_sst *ctx, struct skl_pipe *pipe)
 
 	dev_dbg(ctx->dev, "%s: pipe = %d\n", __func__, pipe->ppl_id);
 
-	/* If pipe is not started, do not try to stop the pipe in FW. */
+	/* If pipe is started, do stop the pipe in FW. */
 	if (pipe->state > SKL_PIPE_STARTED) {
 		ret = skl_set_pipe_state(ctx, pipe, PPL_PAUSED);
 		if (ret < 0) {
@@ -1055,18 +1055,20 @@ int skl_delete_pipe(struct skl_sst *ctx, struct skl_pipe *pipe)
 		}
 
 		pipe->state = SKL_PIPE_PAUSED;
-	} else {
-		/* If pipe was not created in FW, do not try to delete it */
-		if (pipe->state < SKL_PIPE_CREATED)
-			return 0;
+	}
 
-		ret = skl_ipc_delete_pipeline(&ctx->ipc, pipe->ppl_id);
-		if (ret < 0)
-			dev_err(ctx->dev, "Failed to delete pipeline\n");
+	/* If pipe was not created in FW, do not try to delete it */
+	if (pipe->state < SKL_PIPE_CREATED)
+		return 0;
 
-		pipe->state = SKL_PIPE_INVALID;
+	ret = skl_ipc_delete_pipeline(&ctx->ipc, pipe->ppl_id);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Failed to delete pipeline\n");
+		return ret;
 	}
 
+	pipe->state = SKL_PIPE_INVALID;
+
 	return ret;
 }
 
-- 
2.5.0
