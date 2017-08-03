From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: kbl: Add map for new DAIs for
	Multi-Playback & Echo Ref" to the asoc tree
Date: Thu, 03 Aug 2017 17:30:29 +0100
Message-ID: <E1ddJ13-0002ap-1F@debutante>
References: <1501654415-24590-4-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AF953267456
 for <alsa-devel@alsa-project.org>; Thu,  3 Aug 2017 18:30:40 +0200 (CEST)
In-Reply-To: <1501654415-24590-4-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Sathya Prakash M R <sathya.prakash.m.r@intel.com>, naveen.m@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: kbl: Add map for new DAIs for Multi-Playback & Echo Ref

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

>From 0b06122fc8d0949a0aa7b817d98e031104802611 Mon Sep 17 00:00:00 2001
From: Naveen Manohar <naveen.m@intel.com>
Date: Wed, 2 Aug 2017 11:43:35 +0530
Subject: [PATCH] ASoC: Intel: kbl: Add map for new DAIs for Multi-Playback &
 Echo Ref

Modified DAPM Machine map for machine to suit the toplogy change
required to enable features:
Multi-Endpoint Playback
Echo Reference Capture

Signed-off-by: Naveen M <naveen.m@intel.com>
Signed-off-by: Sathya Prakash M R <sathya.prakash.m.r@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/kbl_rt5663_max98927.c        | 6 +++---
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index 4c70d5a3028c..12b34b9a0104 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -99,12 +99,12 @@ static const struct snd_soc_dapm_route kabylake_map[] = {
 	/* CODEC BE connections */
 	{ "Left HiFi Playback", NULL, "ssp0 Tx" },
 	{ "Right HiFi Playback", NULL, "ssp0 Tx" },
-	{ "ssp0 Tx", NULL, "codec0_out" },
+	{ "ssp0 Tx", NULL, "spk_out" },
 
 	{ "AIF Playback", NULL, "ssp1 Tx" },
-	{ "ssp1 Tx", NULL, "codec1_out" },
+	{ "ssp1 Tx", NULL, "hs_out" },
 
-	{ "codec0_in", NULL, "ssp1 Rx" },
+	{ "hs_in", NULL, "ssp1 Rx" },
 	{ "ssp1 Rx", NULL, "AIF Capture" },
 
 	/* DMIC */
diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 64364de165be..5ec942885b69 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -107,12 +107,12 @@ static const struct snd_soc_dapm_route kabylake_map[] = {
 	/* CODEC BE connections */
 	{ "Left HiFi Playback", NULL, "ssp0 Tx" },
 	{ "Right HiFi Playback", NULL, "ssp0 Tx" },
-	{ "ssp0 Tx", NULL, "codec0_out" },
+	{ "ssp0 Tx", NULL, "spk_out" },
 
 	{ "AIF Playback", NULL, "ssp1 Tx" },
-	{ "ssp1 Tx", NULL, "codec1_out" },
+	{ "ssp1 Tx", NULL, "hs_out" },
 
-	{ "codec0_in", NULL, "ssp1 Rx" },
+	{ "hs_in", NULL, "ssp1 Rx" },
 	{ "ssp1 Rx", NULL, "AIF Capture" },
 
 	{ "codec1_in", NULL, "ssp0 Rx" },
-- 
2.13.2
