From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 02/13] ASoC: Intel: Skylake: Fix to set pipe
	state to invalid when deleting
Date: Mon, 14 Dec 2015 09:57:18 +0530
Message-ID: <1450067249-7151-3-git-send-email-vinod.koul@intel.com>
References: <1450067249-7151-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id B49C126053B
 for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2015 05:24:26 +0100 (CET)
In-Reply-To: <1450067249-7151-1-git-send-email-vinod.koul@intel.com>
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

When pipeline is deleted, set the pipeline state to invalid state.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 46310d9ac008..de6dac496a0d 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -849,6 +849,8 @@ int skl_delete_pipe(struct skl_sst *ctx, struct skl_pipe *pipe)
 		ret = skl_ipc_delete_pipeline(&ctx->ipc, pipe->ppl_id);
 		if (ret < 0)
 			dev_err(ctx->dev, "Failed to delete pipeline\n");
+
+		pipe->state = SKL_PIPE_INVALID;
 	}
 
 	return ret;
-- 
1.9.1
