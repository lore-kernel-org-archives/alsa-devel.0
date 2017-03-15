From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix not to stop src
	pipe in pre pmd event handler" to the asoc tree
Date: Wed, 15 Mar 2017 18:13:45 +0000
Message-ID: <E1coDQf-0002MP-Vu@debutante>
References: <1488910446-26415-3-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 732562670F5
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 19:13:54 +0100 (CET)
In-Reply-To: <1488910446-26415-3-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guneshwor Singh <guneshwor.o.singh@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix not to stop src pipe in pre pmd event handler

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

>From 3b563e0a8406bf47cd39ca59f8453b3d968d996a Mon Sep 17 00:00:00 2001
From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Date: Mon, 13 Mar 2017 22:11:24 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix not to stop src pipe in pre pmd
 event handler

If the widget is a mixin module, just unbind between source and sink
and don't stop the source pipe as there can be multiple sinks
connected.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index e7836a2e18f0..d4058d2a8023 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -973,15 +973,6 @@ static int skl_tplg_mixer_dapm_pre_pmd_event(struct snd_soc_dapm_widget *w,
 			src_mconfig = sink_mconfig->m_in_pin[i].tgt_mcfg;
 			if (!src_mconfig)
 				continue;
-			/*
-			 * If path_found == 1, that means pmd for source
-			 * pipe has not occurred, source is connected to
-			 * some other sink. so its responsibility of sink
-			 * to unbind itself from source.
-			 */
-			ret = skl_stop_pipe(ctx, src_mconfig->pipe);
-			if (ret < 0)
-				return ret;
 
 			ret = skl_unbind_modules(ctx,
 						src_mconfig, sink_mconfig);
-- 
2.11.0
