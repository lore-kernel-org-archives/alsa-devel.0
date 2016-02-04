From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix mcps freeup after
	module unbind failure" to the asoc tree
Date: Thu, 04 Feb 2016 12:16:16 +0000
Message-ID: <E1aRIpc-0001Ed-9X@debutante>
References: <1454502594-21700-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 993BD262607
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2016 13:16:21 +0100 (CET)
In-Reply-To: <1454502594-21700-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guneshwor Singh <guneshwor.o.singh@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix mcps freeup after module unbind failure

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

>From 7ca42f5ac5e0d8011086bcfa00e85aede42f0b78 Mon Sep 17 00:00:00 2001
From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Date: Wed, 3 Feb 2016 17:59:46 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix mcps freeup after module unbind
 failure

While cleaning resources on module pmd event, we check for return
of skl_unbind_modules(). On failure this causes leak as all modules
attached do not have resources freed.

So ignore return value of module unbind and continue freeing
resources. This makes dapm state and resources correct.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index c67e3acb8102..86d5323e9184 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -98,7 +98,7 @@ static bool skl_tplg_alloc_pipe_mcps(struct skl *skl,
 			"%s: module_id %d instance %d\n", __func__,
 			mconfig->id.module_id, mconfig->id.instance_id);
 		dev_err(ctx->dev,
-			"exceeds ppl memory available %d > mem %d\n",
+			"exceeds ppl mcps available %d > mem %d\n",
 			skl->resource.max_mcps, skl->resource.mcps);
 		return false;
 	}
@@ -773,10 +773,7 @@ static int skl_tplg_mixer_dapm_post_pmd_event(struct snd_soc_dapm_widget *w,
 			continue;
 		}
 
-		ret = skl_unbind_modules(ctx, src_module, dst_module);
-		if (ret < 0)
-			return ret;
-
+		skl_unbind_modules(ctx, src_module, dst_module);
 		src_module = dst_module;
 	}
 
-- 
2.7.0.rc3
