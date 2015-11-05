From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix resource cleanup on
	teardown" to the asoc tree
Date: Thu, 05 Nov 2015 16:29:46 +0000
Message-ID: <E1ZuNQ2-0001ME-Qe@finisterre>
References: <1446739455-22332-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EC6C2664CB
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 17:30:03 +0100 (CET)
In-Reply-To: <1446739455-22332-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mohan Krishna Velaga <mohan.krishnax.velaga@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix resource cleanup on teardown

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

>From 1b7431cef2f71fb1b15d398d8d8f24571c358dce Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 5 Nov 2015 21:34:10 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix resource cleanup on teardown

MCPS free was being done from PGA context which will free up MCPS
for only last modules in a pipe and not the rest causing MCPS
leak and eventual audio loss due to no "free" MCPS.

This needs to be freed for every module while cleaning up the
modules, so move the check to
skl_tplg_mixer_dapm_post_pmd_event()

Signed-off-by: Mohan Krishna Velaga <mohan.krishnax.velaga@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 3c5f062..2b6ee22 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -640,6 +640,7 @@ static int skl_tplg_mixer_dapm_post_pmd_event(struct snd_soc_dapm_widget *w,
 	list_for_each_entry(w_module, &s_pipe->w_list, node) {
 		dst_module = w_module->w->priv;
 
+		skl_tplg_free_pipe_mcps(skl, dst_module);
 		if (src_module == NULL) {
 			src_module = dst_module;
 			continue;
@@ -673,7 +674,6 @@ static int skl_tplg_pga_dapm_post_pmd_event(struct snd_soc_dapm_widget *w,
 
 	src_mconfig = w->priv;
 
-	skl_tplg_free_pipe_mcps(skl, src_mconfig);
 	/* Stop the pipe since this is a mixin module */
 	ret = skl_stop_pipe(ctx, src_mconfig->pipe);
 	if (ret)
-- 
2.6.1
