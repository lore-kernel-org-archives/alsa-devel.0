From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: boards: Remove WoV sink in
	nau88125_max98357a machine" to the asoc tree
Date: Wed, 24 Feb 2016 17:42:21 +0900
Message-ID: <E1aYV1Z-0002tS-1x@finisterre>
References: <1456293464-19646-8-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 024D526067A
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2016 09:42:36 +0100 (CET)
In-Reply-To: <1456293464-19646-8-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: boards: Remove WoV sink in nau88125_max98357a machine

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

>From 8be3838af0e992846d4725fae152b818560c1068 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Wed, 24 Feb 2016 11:27:44 +0530
Subject: [PATCH] ASoC: Intel: boards: Remove WoV sink in nau88125_max98357a
 machine

WoV module needs to be triggered with PCM open, so remove this as
DAPM Sink and will be connected to FE

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/skl_nau88l25_max98357a.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index 33bf5286c948..72176b79a18d 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -98,7 +98,6 @@ static const struct snd_soc_dapm_widget skylake_widgets[] = {
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_SPK("Spk", NULL),
 	SND_SOC_DAPM_MIC("SoC DMIC", NULL),
-	SND_SOC_DAPM_SINK("WoV Sink"),
 	SND_SOC_DAPM_SPK("DP", NULL),
 	SND_SOC_DAPM_SPK("HDMI", NULL),
 	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
@@ -118,7 +117,6 @@ static const struct snd_soc_dapm_route skylake_map[] = {
 	{ "MIC", NULL, "Headset Mic" },
 	{ "DMic", NULL, "SoC DMIC" },
 
-	{"WoV Sink", NULL, "hwd_in sink"},
 	{"HDMI", NULL, "hif5 Output"},
 	{"DP", NULL, "hif6 Output"},
 
@@ -188,7 +186,6 @@ static int skylake_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
 	nau8825_enable_jack_detect(codec, &skylake_headset);
 
 	snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "SoC DMIC");
-	snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "WoV Sink");
 
 	return ret;
 }
-- 
2.7.0
