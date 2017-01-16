From: jeeja.kp@intel.com
Subject: [PATCH 30/30] ASoC: Intel: Skylake: Fix to delete DSP
	pipe after stopping pipe
Date: Mon, 16 Jan 2017 23:27:57 +0530
Message-ID: <1484589477-7630-31-git-send-email-jeeja.kp@intel.com>
References: <1484589477-7630-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 29A3B2668B3
 for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2017 18:49:11 +0100 (CET)
In-Reply-To: <1484589477-7630-1-git-send-email-jeeja.kp@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

DSP pipe needs to stopped before deleting the pipe. Currently check is
is for pipe state > STARTED, which is incorrect. So changed to include
pipe state STARTED to stop the pipe if it started.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index e79cbcf..7190df5 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -1091,7 +1091,7 @@ int skl_delete_pipe(struct skl_sst *ctx, struct skl_pipe *pipe)
 	dev_dbg(ctx->dev, "%s: pipe = %d\n", __func__, pipe->ppl_id);
 
 	/* If pipe is started, do stop the pipe in FW. */
-	if (pipe->state > SKL_PIPE_STARTED) {
+	if (pipe->state >= SKL_PIPE_STARTED) {
 		ret = skl_set_pipe_state(ctx, pipe, PPL_PAUSED);
 		if (ret < 0) {
 			dev_err(ctx->dev, "Failed to stop pipeline\n");
-- 
2.5.0
