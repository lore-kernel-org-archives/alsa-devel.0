From: jeeja.kp@intel.com
Subject: [PATCH v2 06/11] ASoC: Intel: Skylake: Remove
	redundant vmixer handler
Date: Fri, 24 Mar 2017 23:10:29 +0530
Message-ID: <1490377234-30257-7-git-send-email-jeeja.kp@intel.com>
References: <1490377234-30257-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D35B72674CC
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 18:28:34 +0100 (CET)
In-Reply-To: <1490377234-30257-1-git-send-email-jeeja.kp@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

Initially vmixer and mixer widget handlers were bit different, but over
time they became same so remove the duplicate code.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 32 +-------------------------------
 1 file changed, 1 insertion(+), 31 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 43f9cb3..35d9d7b 100644
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
2.5.0
