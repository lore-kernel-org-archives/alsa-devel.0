From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Don't pause stopped
	pipeline while deleting" to the asoc tree
Date: Tue, 07 Jun 2016 14:27:51 +0100
Message-ID: <E1bAH2t-0001jb-ED@debutante>
References: <1464958783-19344-4-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 922292665D3
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2016 15:27:56 +0200 (CEST)
In-Reply-To: <1464958783-19344-4-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dharageswari R <dharageswari.r@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Don't pause stopped pipeline while deleting

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 1ae7ca041a460502b0f9877d84d0f0d9bed9cb72 Mon Sep 17 00:00:00 2001
From: Dharageswari R <dharageswari.r@intel.com>
Date: Fri, 3 Jun 2016 18:29:36 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Don't pause stopped pipeline while
 deleting

If pipeline is not STARTED, we do not need to pause pipeline while
deleting.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 07d2a73ff207..804091aa6e64 100644
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
2.8.1
