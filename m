From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: kbl: Add MST route change to kbl
	machine drivers" to the asoc tree
Date: Tue, 29 Aug 2017 20:29:59 +0100 (BST)
Message-ID: <20170829192959.56AF74400E7@finisterre.ee.mobilebroadband>
References: <1503700450-7964-2-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4168426706F
 for <alsa-devel@alsa-project.org>; Tue, 29 Aug 2017 21:30:02 +0200 (CEST)
In-Reply-To: <1503700450-7964-2-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, naveen.m@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: kbl: Add MST route change to kbl machine drivers

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

>From c20252cf9230eb7abd8bce9fdb2ce9bdd6743689 Mon Sep 17 00:00:00 2001
From: Naveen M <naveen.m@intel.com>
Date: Sat, 26 Aug 2017 04:04:09 +0530
Subject: [PATCH] ASoC: Intel: kbl: Add MST route change to kbl machine drivers

To support MST hdmi audio, modify the current routes to be based
on port in rt5663_max98927 & rt5663_rt5514_max98927 machine.

Signed-off-by: Naveen M <naveen.m@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/kbl_rt5663_max98927.c        | 8 +++-----
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 7 ++-----
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index c1442147d138..941480c3e906 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -74,8 +74,9 @@ static const struct snd_soc_dapm_widget kabylake_widgets[] = {
 	SND_SOC_DAPM_SPK("Left Spk", NULL),
 	SND_SOC_DAPM_SPK("Right Spk", NULL),
 	SND_SOC_DAPM_MIC("SoC DMIC", NULL),
-	SND_SOC_DAPM_SPK("DP", NULL),
-	SND_SOC_DAPM_SPK("HDMI", NULL),
+	SND_SOC_DAPM_SPK("HDMI1", NULL),
+	SND_SOC_DAPM_SPK("HDMI2", NULL),
+	SND_SOC_DAPM_SPK("HDMI3", NULL),
 
 };
 
@@ -93,9 +94,6 @@ static const struct snd_soc_dapm_route kabylake_map[] = {
 	{ "IN1N", NULL, "Headset Mic" },
 	{ "DMic", NULL, "SoC DMIC" },
 
-	{ "HDMI", NULL, "hif5 Output" },
-	{ "DP", NULL, "hif6 Output" },
-
 	/* CODEC BE connections */
 	{ "Left HiFi Playback", NULL, "ssp0 Tx" },
 	{ "Right HiFi Playback", NULL, "ssp0 Tx" },
diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 69681b04d7fc..d042255235c1 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -85,8 +85,8 @@ static const struct snd_soc_dapm_widget kabylake_widgets[] = {
 	SND_SOC_DAPM_SPK("Left Spk", NULL),
 	SND_SOC_DAPM_SPK("Right Spk", NULL),
 	SND_SOC_DAPM_MIC("DMIC", NULL),
-	SND_SOC_DAPM_SPK("DP", NULL),
-	SND_SOC_DAPM_SPK("HDMI", NULL),
+	SND_SOC_DAPM_SPK("HDMI1", NULL),
+	SND_SOC_DAPM_SPK("HDMI2", NULL),
 
 };
 
@@ -103,9 +103,6 @@ static const struct snd_soc_dapm_route kabylake_map[] = {
 	{ "IN1P", NULL, "Headset Mic" },
 	{ "IN1N", NULL, "Headset Mic" },
 
-	{ "HDMI", NULL, "hif5 Output" },
-	{ "DP", NULL, "hif6 Output" },
-
 	/* CODEC BE connections */
 	{ "Left HiFi Playback", NULL, "ssp0 Tx" },
 	{ "Right HiFi Playback", NULL, "ssp0 Tx" },
-- 
2.13.2
