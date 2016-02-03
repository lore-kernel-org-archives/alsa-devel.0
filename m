From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 09/11] ASoC: Intel: Skylake: Add missing
	PRE/POST_PMU handlers for vmixer
Date: Wed,  3 Feb 2016 17:59:52 +0530
Message-ID: <1454502594-21700-10-git-send-email-vinod.koul@intel.com>
References: <1454502594-21700-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C90AF2606AB
 for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2016 13:26:46 +0100 (CET)
In-Reply-To: <1454502594-21700-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Some modules may be directly connected to a pipeline without a
mixer module. For these modules, we require PRE_PMU and POST_PMU
handler which will do bind between the pipelines, so add these
missing handlers.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 722a05a7f098..50e193e9eb56 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -857,6 +857,12 @@ static int skl_tplg_vmixer_event(struct snd_soc_dapm_widget *w,
 	case SND_SOC_DAPM_PRE_PMU:
 		return skl_tplg_mixer_dapm_pre_pmu_event(w, skl);
 
+	case SND_SOC_DAPM_POST_PMU:
+		return skl_tplg_mixer_dapm_post_pmu_event(w, skl);
+
+	case SND_SOC_DAPM_PRE_PMD:
+		return skl_tplg_mixer_dapm_pre_pmd_event(w, skl);
+
 	case SND_SOC_DAPM_POST_PMD:
 		return skl_tplg_mixer_dapm_post_pmd_event(w, skl);
 	}
-- 
1.9.1
