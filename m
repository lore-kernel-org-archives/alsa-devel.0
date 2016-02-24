From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: boards: Remove WoV sink in
	skl_rt286" to the asoc tree
Date: Wed, 24 Feb 2016 17:42:29 +0900
Message-ID: <E1aYV1h-0002uT-MJ@finisterre>
References: <1456293464-19646-6-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 83D9E26078A
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2016 09:42:40 +0100 (CET)
In-Reply-To: <1456293464-19646-6-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: boards: Remove WoV sink in skl_rt286

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

>From aac5cc88b107c316fdd2846fdac777726b9f725d Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Wed, 24 Feb 2016 11:27:42 +0530
Subject: [PATCH] ASoC: Intel: boards: Remove WoV sink in skl_rt286

WoV module needs to be triggered with PCM open, so remove this as
DAPM Sink and will be connected to FE

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/skl_rt286.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index 00b84c1ff07f..2016397a8e75 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -64,7 +64,6 @@ static const struct snd_soc_dapm_widget skylake_widgets[] = {
 	SND_SOC_DAPM_MIC("Mic Jack", NULL),
 	SND_SOC_DAPM_MIC("DMIC2", NULL),
 	SND_SOC_DAPM_MIC("SoC DMIC", NULL),
-	SND_SOC_DAPM_SINK("WoV Sink"),
 	SND_SOC_DAPM_SPK("HDMI1", NULL),
 	SND_SOC_DAPM_SPK("HDMI2", NULL),
 	SND_SOC_DAPM_SPK("HDMI3", NULL),
@@ -85,8 +84,6 @@ static const struct snd_soc_dapm_route skylake_rt286_map[] = {
 	{"DMIC1 Pin", NULL, "DMIC2"},
 	{"DMic", NULL, "SoC DMIC"},
 
-	{"WoV Sink", NULL, "hwd_in sink"},
-
 	{"HDMI1", NULL, "hif5 Output"},
 	{"HDMI2", NULL, "hif6 Output"},
 	{"HDMI3", NULL, "hif7 Output"},
@@ -139,7 +136,6 @@ static int skylake_rt286_codec_init(struct snd_soc_pcm_runtime *rtd)
 	rt286_mic_detect(codec, &skylake_headset);
 
 	snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "SoC DMIC");
-	snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "WoV Sink");
 
 	return 0;
 }
-- 
2.7.0
