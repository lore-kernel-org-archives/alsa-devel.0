From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add missing
	PRE/POST_PMU handlers for vmixer" to the asoc tree
Date: Thu, 04 Feb 2016 12:16:10 +0000
Message-ID: <E1aRIpW-0001Bh-Sh@debutante>
References: <1454502594-21700-10-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EC9C52615C0
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2016 13:16:17 +0100 (CET)
In-Reply-To: <1454502594-21700-10-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Add missing PRE/POST_PMU handlers for vmixer

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

>From de1fedf25b075664320010789ede2a0f9f4de07d Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Wed, 3 Feb 2016 17:59:52 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add missing PRE/POST_PMU handlers for
 vmixer

Some modules may be directly connected to a pipeline without a
mixer module. For these modules, we require PRE_PMU and POST_PMU
handler which will do bind between the pipelines, so add these
missing handlers.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 77a688d00fc6..489848637df5 100644
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
2.7.0.rc3
