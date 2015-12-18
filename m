From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoc: Intel: boards: fix dapm map of
	nau88l25_ssm4567 machine" to the asoc tree
Date: Fri, 18 Dec 2015 12:15:34 +0000
Message-ID: <E1a9twc-00069J-Me@debutante>
References: <1449862153-68738-4-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EAC12657E5
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 13:15:40 +0100 (CET)
In-Reply-To: <1449862153-68738-4-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Fang Yang A <yang.a.fang@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoc: Intel: boards: fix dapm map of nau88l25_ssm4567 machine

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

>From 4c6ebc3ecdba9484de5249de406d6fcf725cda62 Mon Sep 17 00:00:00 2001
From: "Fang, Yang A" <yang.a.fang@intel.com>
Date: Fri, 11 Dec 2015 11:29:09 -0800
Subject: [PATCH] ASoc: Intel: boards: fix dapm map of nau88l25_ssm4567 machine

The DAPM map for DMIC and SSP was not properly done, so fix that up.
Also mark machine as fully routed

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 65c65d4c422c..9c9ebb8d0734 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -108,22 +108,22 @@ static const struct snd_soc_dapm_route skylake_map[] = {
 
 	/* other jacks */
 	{"MIC", NULL, "Headset Mic"},
-	{"DMIC AIF", NULL, "SoC DMIC"},
+	{"DMic", NULL, "SoC DMIC"},
 
 	/* CODEC BE connections */
 	{ "Left Playback", NULL, "ssp0 Tx"},
 	{ "Right Playback", NULL, "ssp0 Tx"},
 	{ "ssp0 Tx", NULL, "codec0_out"},
 
-	{ "AIF1 Playback", NULL, "ssp1 Tx"},
+	{ "Playback", NULL, "ssp1 Tx"},
 	{ "ssp1 Tx", NULL, "codec1_out"},
 
 	{ "codec0_in", NULL, "ssp1 Rx" },
-	{ "ssp1 Rx", NULL, "AIF1 Capture" },
+	{ "ssp1 Rx", NULL, "Capture" },
 
 	/* DMIC */
 	{ "dmic01_hifi", NULL, "DMIC01 Rx" },
-	{ "DMIC01 Rx", NULL, "Capture" },
+	{ "DMIC01 Rx", NULL, "DMIC AIF" },
 	{ "Headphone Jack", NULL, "Platform Clock" },
 	{ "Headset Mic", NULL, "Platform Clock" },
 };
@@ -336,6 +336,7 @@ static struct snd_soc_card skylake_audio_card = {
 	.num_dapm_routes = ARRAY_SIZE(skylake_map),
 	.codec_conf = ssm4567_codec_conf,
 	.num_configs = ARRAY_SIZE(ssm4567_codec_conf),
+	.fully_routed = true,
 };
 
 static int skylake_audio_probe(struct platform_device *pdev)
-- 
2.6.2
