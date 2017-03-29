From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Remove redundant vmixer
	handler" to the asoc tree
Date: Wed, 29 Mar 2017 12:54:24 +0100
Message-ID: <E1ctCBE-0001XQ-64@debutante>
References: <1490275926-2270-7-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DE030266F89
 for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2017 13:54:32 +0200 (CEST)
In-Reply-To: <1490275926-2270-7-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Remove redundant vmixer handler

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

>From 9a1e350709492cf512a3c4781915d567b34f8d26 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Fri, 24 Mar 2017 23:10:29 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Remove redundant vmixer handler

Initially vmixer and mixer widget handlers were bit different, but over
time they became same so remove the duplicate code.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 32 +-------------------------------
 1 file changed, 1 insertion(+), 31 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 43f9cb380a76..35d9d7b43dd2 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1073,36 +1073,6 @@ static int skl_tplg_pga_dapm_post_pmd_event(struct snd_soc_dapm_widget *w,
 }
 
 /*
- * In modelling, we assume there will be ONLY one mixer in a pipeline.  If
- * mixer is not required then it is treated as static mixer aka vmixer with
- * a hard path to source module
- * So we don't need to check if source is started or not as hard path puts
- * dependency on each other
- */
-static int skl_tplg_vmixer_event(struct snd_soc_dapm_widget *w,
-				struct snd_kcontrol *k, int event)
-{
-	struct snd_soc_dapm_context *dapm = w->dapm;
-	struct skl *skl = get_skl_ctx(dapm->dev);
-
-	switch (event) {
-	case SND_SOC_DAPM_PRE_PMU:
-		return skl_tplg_mixer_dapm_pre_pmu_event(w, skl);
-
-	case SND_SOC_DAPM_POST_PMU:
-		return skl_tplg_mixer_dapm_post_pmu_event(w, skl);
-
-	case SND_SOC_DAPM_PRE_PMD:
-		return skl_tplg_mixer_dapm_pre_pmd_event(w, skl);
-
-	case SND_SOC_DAPM_POST_PMD:
-		return skl_tplg_mixer_dapm_post_pmd_event(w, skl);
-	}
-
-	return 0;
-}
-
-/*
  * In modelling, we assume there will be ONLY one mixer in a pipeline. If a
  * second one is required that is created as another pipe entity.
  * The mixer is responsible for pipe management and represent a pipeline
@@ -1570,7 +1540,7 @@ int skl_tplg_be_update_params(struct snd_soc_dai *dai,
 
 static const struct snd_soc_tplg_widget_events skl_tplg_widget_ops[] = {
 	{SKL_MIXER_EVENT, skl_tplg_mixer_event},
-	{SKL_VMIXER_EVENT, skl_tplg_vmixer_event},
+	{SKL_VMIXER_EVENT, skl_tplg_mixer_event},
 	{SKL_PGA_EVENT, skl_tplg_pga_event},
 };
 
-- 
2.11.0
