From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ASoC: SOF: fix HDA direct MMIO access
Date: Mon, 12 Aug 2019 14:05:02 -0500
Message-ID: <20190812190502.30729-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3A834F8015A
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2019 21:05:18 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, kbuild test robot <lkp@intel.com>
List-Id: alsa-devel@alsa-project.org

The recent change to remove the bus->io_ops callbacks used an older
version of the SOF code base, and when merged into Mark's for-next it
invalidated changes, resulting in broken compilation identified by
kbuild and reproduced during the weekly SOF rebase.

Restore SOF code overridden by git merge and apply Takashi's intended
change in the 'right' location.

Fixes: c2f16a94a8049 ("Merge branch 'topic/hda-bus-ops-cleanup'")
Reported-by: kbuild test robot <lkp@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-ctrl.c |  2 +-
 sound/soc/sof/intel/hda-dsp.c  | 39 ----------------------------------
 2 files changed, 1 insertion(+), 40 deletions(-)

diff --git a/sound/soc/sof/intel/hda-ctrl.c b/sound/soc/sof/intel/hda-ctrl.c
index a7fee403cb90..bc41028a7a01 100644
--- a/sound/soc/sof/intel/hda-ctrl.c
+++ b/sound/soc/sof/intel/hda-ctrl.c
@@ -254,7 +254,7 @@ int hda_dsp_ctrl_init_chip(struct snd_sof_dev *sdev, bool full_reset)
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
 	/* Reset stream-to-link mapping */
 	list_for_each_entry(hlink, &bus->hlink_list, list)
-		bus->io_ops->reg_writel(0, hlink->ml_addr + AZX_REG_ML_LOSIDV);
+		writel(0, hlink->ml_addr + AZX_REG_ML_LOSIDV);
 #endif
 
 	bus->chip_init = true;
diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index 097727cda5cb..fb55a3c5afd0 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -354,45 +354,6 @@ static int hda_resume(struct snd_sof_dev *sdev, bool runtime_resume)
 		return ret;
 	}
 
-	hda_dsp_ctrl_misc_clock_gating(sdev, false);
-
-	/* Reset stream-to-link mapping */
-	list_for_each_entry(hlink, &bus->hlink_list, list)
-		writel(0, hlink->ml_addr + AZX_REG_ML_LOSIDV);
-
-	hda_dsp_ctrl_misc_clock_gating(sdev, true);
-#else
-
-	hda_dsp_ctrl_misc_clock_gating(sdev, false);
-
-	/* reset controller */
-	ret = hda_dsp_ctrl_link_reset(sdev, true);
-	if (ret < 0) {
-		dev_err(sdev->dev,
-			"error: failed to reset controller during resume\n");
-		return ret;
-	}
-
-	/* take controller out of reset */
-	ret = hda_dsp_ctrl_link_reset(sdev, false);
-	if (ret < 0) {
-		dev_err(sdev->dev,
-			"error: failed to ready controller during resume\n");
-		return ret;
-	}
-
-	/* enable hda bus irq */
-	snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR, SOF_HDA_INTCTL,
-				SOF_HDA_INT_CTRL_EN | SOF_HDA_INT_GLOBAL_EN,
-				SOF_HDA_INT_CTRL_EN | SOF_HDA_INT_GLOBAL_EN);
-
-	hda_dsp_ctrl_misc_clock_gating(sdev, true);
-#endif
-
-	/* enable ppcap interrupt */
-	hda_dsp_ctrl_ppcap_enable(sdev, true);
-	hda_dsp_ctrl_ppcap_int_enable(sdev, true);
-
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
 	/* check jack status */
 	if (runtime_resume)
-- 
2.20.1
