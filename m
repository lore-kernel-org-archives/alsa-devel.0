From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix to delete DSP pipe
	after stopping pipe" to the asoc tree
Date: Wed, 15 Mar 2017 18:13:48 +0000
Message-ID: <E1coDQj-0002PF-08@debutante>
References: <1484589477-7630-31-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E9CE6267066
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 19:13:57 +0100 (CET)
In-Reply-To: <1484589477-7630-31-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix to delete DSP pipe after stopping pipe

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

>From 6914968b8203aef72edf936319c4d46c6d46401b Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Mon, 13 Mar 2017 22:11:23 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix to delete DSP pipe after stopping
 pipe

DSP pipe needs to stopped before deleting the pipe. Currently check is
for pipe state > STARTED, which is incorrect. So changed to include
pipe state STARTED to stop the pipe if it started.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index e66870474f10..ed576965cacc 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -1098,7 +1098,7 @@ int skl_delete_pipe(struct skl_sst *ctx, struct skl_pipe *pipe)
 	dev_dbg(ctx->dev, "%s: pipe = %d\n", __func__, pipe->ppl_id);
 
 	/* If pipe is started, do stop the pipe in FW. */
-	if (pipe->state > SKL_PIPE_STARTED) {
+	if (pipe->state >= SKL_PIPE_STARTED) {
 		ret = skl_set_pipe_state(ctx, pipe, PPL_PAUSED);
 		if (ret < 0) {
 			dev_err(ctx->dev, "Failed to stop pipeline\n");
-- 
2.11.0
