From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Update ignore suspend for
	bxt-rt298" to the asoc tree
Date: Tue, 14 Jun 2016 16:09:09 +0100
Message-ID: <E1bCpxl-0001V2-E3@finisterre>
References: <1465820944-14774-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A64A826145E
 for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2016 17:09:19 +0200 (CEST)
In-Reply-To: <1465820944-14774-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Update ignore suspend for bxt-rt298

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

>From 316f135a4ec6fba2a53930f843a0c1c5d4ae1ea2 Mon Sep 17 00:00:00 2001
From: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Date: Mon, 13 Jun 2016 17:59:00 +0530
Subject: [PATCH] ASoC: Intel: Update ignore suspend for bxt-rt298

Capture from DMIC requires that we ignore the suspend, so mark
these as ignore_suspend in bxt-rt298 machine.

Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bxt_rt298.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index 10eb5cbf57e4..8b956500414b 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -106,6 +106,17 @@ static const struct snd_soc_dapm_route broxton_rt298_map[] = {
 
 };
 
+static int broxton_rt298_fe_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_dapm_context *dapm;
+	struct snd_soc_component *component = rtd->cpu_dai->component;
+
+	dapm = snd_soc_component_get_dapm(component);
+	snd_soc_dapm_ignore_suspend(dapm, "Reference Capture");
+
+	return 0;
+}
+
 static int broxton_rt298_codec_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
@@ -120,6 +131,9 @@ static int broxton_rt298_codec_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 
 	rt298_mic_detect(codec, &broxton_headset);
+
+	snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "SoC DMIC");
+
 	return 0;
 }
 
@@ -267,6 +281,7 @@ static struct snd_soc_dai_link broxton_rt298_dais[] = {
 		.dynamic = 1,
 		.codec_name = "snd-soc-dummy",
 		.codec_dai_name = "snd-soc-dummy-dai",
+		.init = broxton_rt298_fe_init,
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
 		.dpcm_playback = 1,
 		.ops = &broxton_rt286_fe_ops,
-- 
2.8.1
