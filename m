From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoc: Intel: boards: Add WOV as sink for
	nau88l25_ssm4567 machine" to the asoc tree
Date: Fri, 18 Dec 2015 12:15:31 +0000
Message-ID: <E1a9twZ-00067t-VF@debutante>
References: <1449862153-68738-7-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 509A5266618
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 13:15:38 +0100 (CET)
In-Reply-To: <1449862153-68738-7-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Fang Yang A <yang.a.fang@intel.com>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoc: Intel: boards: Add WOV as sink for nau88l25_ssm4567 machine

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

>From 2154be362c9050b9ed5d3beac491f0103505bf16 Mon Sep 17 00:00:00 2001
From: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Date: Fri, 11 Dec 2015 11:29:12 -0800
Subject: [PATCH] ASoc: Intel: boards: Add WOV as sink for nau88l25_ssm4567
 machine

We have WOV module which should act as DAPM sink, so add that and
its links.

Also rename the refcap to "Wake On Voice" as some user expect to
find this name

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
Signed-off-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 1b54613132c1..f6c252cccdb4 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -92,6 +92,7 @@ static const struct snd_soc_dapm_widget skylake_widgets[] = {
 	SND_SOC_DAPM_SPK("Left Speaker", NULL),
 	SND_SOC_DAPM_SPK("Right Speaker", NULL),
 	SND_SOC_DAPM_MIC("SoC DMIC", NULL),
+	SND_SOC_DAPM_SINK("WoV Sink"),
 	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
 			platform_clock_control, SND_SOC_DAPM_PRE_PMU |
 			SND_SOC_DAPM_POST_PMD),
@@ -110,6 +111,7 @@ static const struct snd_soc_dapm_route skylake_map[] = {
 	{"MIC", NULL, "Headset Mic"},
 	{"DMic", NULL, "SoC DMIC"},
 
+	{"WoV Sink", NULL, "hwd_in sink"},
 	/* CODEC BE connections */
 	{ "Left Playback", NULL, "ssp0 Tx"},
 	{ "Right Playback", NULL, "ssp0 Tx"},
@@ -188,6 +190,7 @@ static int skylake_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
 	nau8825_enable_jack_detect(codec, &skylake_headset);
 
 	snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "SoC DMIC");
+	snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "WoV Sink");
 
 	return ret;
 }
@@ -383,7 +386,7 @@ static struct snd_soc_dai_link skylake_dais[] = {
 	},
 	{
 		.name = "Skl Audio Reference cap",
-		.stream_name = "refcap",
+		.stream_name = "Wake on Voice",
 		.cpu_dai_name = "Reference Pin",
 		.codec_name = "snd-soc-dummy",
 		.codec_dai_name = "snd-soc-dummy-dai",
-- 
2.6.2
