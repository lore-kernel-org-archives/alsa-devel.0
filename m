From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix not to stop sink
	pipe in pga pmd event" to the asoc tree
Date: Thu, 04 Feb 2016 12:16:12 +0000
Message-ID: <E1aRIpY-0001Ci-Mc@debutante>
References: <1454502594-21700-8-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7306E261A28
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2016 13:16:19 +0100 (CET)
In-Reply-To: <1454502594-21700-8-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix not to stop sink pipe in pga pmd event

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

>From 9946f70906eebf2a305d0b189de52eec8ba39649 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Wed, 3 Feb 2016 17:59:50 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix not to stop sink pipe in pga pmd
 event

We should not stop the sink pipe in it's pmd handler for a mixin
module as this module may still be connected to other pipes.

This will be stopped and freed by current implementation on last
connected pipe unbind.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index efe001162204..a356f3b1dd5b 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -827,9 +827,6 @@ static int skl_tplg_pga_dapm_post_pmd_event(struct snd_soc_dapm_widget *w,
 			 * This is a connecter and if path is found that means
 			 * unbind between source and sink has not happened yet
 			 */
-			ret = skl_stop_pipe(ctx, sink_mconfig->pipe);
-			if (ret < 0)
-				return ret;
 			ret = skl_unbind_modules(ctx, src_mconfig,
 							sink_mconfig);
 		}
-- 
2.7.0.rc3
