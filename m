From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix the dapm machine
	map" to the asoc tree
Date: Tue, 08 Dec 2015 19:11:21 +0000
Message-ID: <E1a6NfV-00041C-8n@debutante>
References: <1448703121-5831-17-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A8111260698
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 20:11:27 +0100 (CET)
In-Reply-To: <1448703121-5831-17-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Fix the dapm machine map

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

>From 820f339fe9fcabee17d3d2ba2b48a51368a51bf4 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 3 Dec 2015 23:29:59 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix the dapm machine map

DAPM Machine map for machine was not specifying the paths
correctly.

The correct order should be:
"DMIC01 Rx" (SoC DMIC BE), connected to "DMIC AIF" (DMic Codec
AIF) and then "DMic" (DMic codec Input) connected to "SoC DMIC"
(Machine DMIC MIC Widget)

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/skl_rt286.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index 0a924901b9b6..51c4eb87e6ec 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -68,7 +68,7 @@ static const struct snd_soc_dapm_route skylake_rt286_map[] = {
 
 	/* digital mics */
 	{"DMIC1 Pin", NULL, "DMIC2"},
-	{"DMIC AIF", NULL, "SoC DMIC"},
+	{"DMic", NULL, "SoC DMIC"},
 
 	{"WoV Sink", NULL, "hwd_in sink"},
 
@@ -82,7 +82,7 @@ static const struct snd_soc_dapm_route skylake_rt286_map[] = {
 	{ "ssp0 Rx", NULL, "AIF1 Capture" },
 
 	{ "dmic01_hifi", NULL, "DMIC01 Rx" },
-	{ "DMIC01 Rx", NULL, "Capture" },
+	{ "DMIC01 Rx", NULL, "DMIC AIF" },
 
 	{ "hif1", NULL, "iDisp Tx"},
 	{ "iDisp Tx", NULL, "iDisp_out"},
-- 
2.6.2
