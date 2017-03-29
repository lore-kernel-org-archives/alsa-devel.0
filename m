From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix module state after
	unbind and delete" to the asoc tree
Date: Wed, 29 Mar 2017 12:54:00 +0100
Message-ID: <E1ctCAq-0001TC-Lz@debutante>
References: <1490275926-2270-11-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D172266F2E
 for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2017 13:54:12 +0200 (CEST)
In-Reply-To: <1490275926-2270-11-git-send-email-jeeja.kp@intel.com>
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

   ASoC: Intel: Skylake: Fix module state after unbind and delete

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

>From 473a4d516cfe6d0668cf7223aa3002ae8367349b Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 24 Mar 2017 23:10:33 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix module state after unbind and
 delete

When DSP module is unbound, the module state needs to be in INIT_DONE
state instead of UNINT. Also the state needs to be set to UNINIT after
module is deleted from DSP pipeline.

So, set the module state to INIT_DONE after unbind and then UNINIT after
module is deleted.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 2 +-
 sound/soc/intel/skylake/skl-topology.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index ba1ec973ded7..09730dd8e6a3 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -862,7 +862,7 @@ static void skl_clear_module_state(struct skl_module_pin *mpin, int max,
 	}
 
 	if (!found)
-		mcfg->m_state = SKL_MODULE_UNINIT;
+		mcfg->m_state = SKL_MODULE_INIT_DONE;
 	return;
 }
 
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 8bd5ded98cec..e960d9f761b9 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1037,6 +1037,11 @@ static int skl_tplg_mixer_dapm_post_pmd_event(struct snd_soc_dapm_widget *w,
 
 	skl_delete_pipe(ctx, mconfig->pipe);
 
+	list_for_each_entry(w_module, &s_pipe->w_list, node) {
+		src_module = w_module->w->priv;
+		src_module->m_state = SKL_MODULE_UNINIT;
+	}
+
 	return skl_tplg_unload_pipe_modules(ctx, s_pipe);
 }
 
-- 
2.11.0
