From: abhijeet.kumar@intel.com
Subject: [PATCH] ASoC: Intel: Skylake: Fix typo
Date: Sun,  4 Mar 2018 01:16:39 +0530
Message-ID: <1520106400-22664-1-git-send-email-abhijeet.kumar@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Dharageswari R <dharageswari.r@intel.com>, G Kranthi <gudishax.kranthikumar@intel.com>, Pradeep Tewani <pradeep.d.tewani@intel.com>, Ramesh Babu <ramesh.babu@intel.com>, Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: abhijeet.kumar@intel.com
List-Id: alsa-devel@alsa-project.org

From: Abhijeet Kumar <abhijeet.kumar@intel.com>

Spelling mistake in state. So fixing it.

Signed-off-by: Abhijeet Kumar <abhijeet.kumar@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 60d76adade43..f161907859f3 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -1210,7 +1210,7 @@ int skl_bind_modules(struct skl_sst *ctx,
 static int skl_set_pipe_state(struct skl_sst *ctx, struct skl_pipe *pipe,
 	enum skl_ipc_pipeline_state state)
 {
-	dev_dbg(ctx->dev, "%s: pipe_satate = %d\n", __func__, state);
+	dev_dbg(ctx->dev, "%s: pipe_state = %d\n", __func__, state);
 
 	return skl_ipc_set_pipeline_state(&ctx->ipc, pipe->ppl_id, state);
 }
-- 
1.9.1
