From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: kbl: Modify map for Headset
	Playback to fix pop-noise" to the asoc tree
Date: Thu, 16 Nov 2017 19:28:40 +0000 (GMT)
Message-ID: <20171116192840.2CE0D44005B@finisterre.ee.mobilebroadband>
References: <1509679697-22154-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EB6A267784
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 20:28:49 +0100 (CET)
In-Reply-To: <1509679697-22154-1-git-send-email-naveen.m@intel.com>
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

   ASoC: Intel: kbl: Modify map for Headset Playback to fix pop-noise

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 4c761ebfcb2d04ee36783c4c8c45ae00caf59d36 Mon Sep 17 00:00:00 2001
From: Naveen Manohar <naveen.m@intel.com>
Date: Fri, 3 Nov 2017 19:15:02 +0530
Subject: [PATCH] ASoC: Intel: kbl: Modify map for Headset Playback to fix
 pop-noise

Patch fixes wrong path in commit 0b06122fc8d0 ("ASoC: Intel: kbl: Add
map for new DAIs for Multi-Playback & Echo Ref") which resulted in pop
noise.
Current topology for Headset results in unwanted pop noise, while
switching from spk->hs at the start of Headset Playback.
Hence re-introduced mixin-mixout dsp module in topology for headset
playback pipe to fix the regression.
And the corresponding modification for headset route is updated here.

Fixes: 0b06122fc8d0 ("ASoC: Intel: kbl: Add map for new DAIs for
Multi-Playback & Echo Ref")
Signed-off-by: Naveen Manohar <naveen.m@intel.com>
Signed-off-by: Sathya Prakash M R <sathya.prakash.m.r@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/kbl_rt5663_max98927.c        | 2 +-
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index 6f9a8bcf20f3..6dcad0a8a0d0 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -101,7 +101,7 @@ static const struct snd_soc_dapm_route kabylake_map[] = {
 	{ "ssp0 Tx", NULL, "spk_out" },
 
 	{ "AIF Playback", NULL, "ssp1 Tx" },
-	{ "ssp1 Tx", NULL, "hs_out" },
+	{ "ssp1 Tx", NULL, "codec1_out" },
 
 	{ "hs_in", NULL, "ssp1 Rx" },
 	{ "ssp1 Rx", NULL, "AIF Capture" },
diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 6072164f2d43..271ae3c2c535 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -109,7 +109,7 @@ static const struct snd_soc_dapm_route kabylake_map[] = {
 	{ "ssp0 Tx", NULL, "spk_out" },
 
 	{ "AIF Playback", NULL, "ssp1 Tx" },
-	{ "ssp1 Tx", NULL, "hs_out" },
+	{ "ssp1 Tx", NULL, "codec1_out" },
 
 	{ "hs_in", NULL, "ssp1 Rx" },
 	{ "ssp1 Rx", NULL, "AIF Capture" },
-- 
2.14.1
