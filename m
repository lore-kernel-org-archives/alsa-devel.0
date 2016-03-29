From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix DSP resource
	de-allocation" to the asoc tree
Date: Tue, 29 Mar 2016 00:38:52 -0700
Message-ID: <E1akoEm-0007DU-8b@finisterre>
References: <1459183291-16395-2-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 090AA261522
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2016 09:39:07 +0200 (CEST)
In-Reply-To: <1459183291-16395-2-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix DSP resource de-allocation

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

>From 4f329d9fbab630af44db2f787eb79ca52e6ba22e Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Mon, 28 Mar 2016 22:11:31 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix DSP resource de-allocation

In PRE PMD of widget handler DSP resources are allocated after
the creation of DSP pipe and modules and in POST PMD DSP
resources are destroyed.

If there is any failure in pipe or module creation in PRE PMD,
pcm trigger fails and finally POST PMD gets called and DSP
resources are freed, without getting allocated.

Fixes the DSP resource de-allocation by allocating the resource
before creation of pipe and module in PRE PMD and in POST PMD,
free the resources.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 3f393cbe1bfe..5a85f3a4699b 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -485,6 +485,8 @@ skl_tplg_init_pipe_modules(struct skl *skl, struct skl_pipe *pipe)
 		if (!skl_is_pipe_mcps_avail(skl, mconfig))
 			return -ENOMEM;
 
+		skl_tplg_alloc_pipe_mcps(skl, mconfig);
+
 		if (mconfig->is_loadable && ctx->dsp->fw_ops.load_mod) {
 			ret = ctx->dsp->fw_ops.load_mod(ctx->dsp,
 				mconfig->id.module_id, mconfig->guid);
@@ -511,7 +513,6 @@ skl_tplg_init_pipe_modules(struct skl *skl, struct skl_pipe *pipe)
 		ret = skl_tplg_set_module_params(w, ctx);
 		if (ret < 0)
 			return ret;
-		skl_tplg_alloc_pipe_mcps(skl, mconfig);
 	}
 
 	return 0;
@@ -561,6 +562,9 @@ static int skl_tplg_mixer_dapm_pre_pmu_event(struct snd_soc_dapm_widget *w,
 	if (!skl_is_pipe_mem_avail(skl, mconfig))
 		return -ENOMEM;
 
+	skl_tplg_alloc_pipe_mem(skl, mconfig);
+	skl_tplg_alloc_pipe_mcps(skl, mconfig);
+
 	/*
 	 * Create a list of modules for pipe.
 	 * This list contains modules from source to sink
@@ -604,9 +608,6 @@ static int skl_tplg_mixer_dapm_pre_pmu_event(struct snd_soc_dapm_widget *w,
 		src_module = dst_module;
 	}
 
-	skl_tplg_alloc_pipe_mem(skl, mconfig);
-	skl_tplg_alloc_pipe_mcps(skl, mconfig);
-
 	return 0;
 }
 
-- 
2.8.0.rc3
