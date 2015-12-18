From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoc: Intel: boards: update ignore suspend
	for nau88l25_ssm4567 machine" to the asoc tree
Date: Fri, 18 Dec 2015 12:15:33 +0000
Message-ID: <E1a9twb-00068q-PU@debutante>
References: <1449862153-68738-5-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BD93266640
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 13:15:39 +0100 (CET)
In-Reply-To: <1449862153-68738-5-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Yong Zhi <yong.zhi@intel.com>, Fang Yang A <yang.a.fang@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoc: Intel: boards: update ignore suspend for nau88l25_ssm4567 machine

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

>From 941eee74563652f6cc363d8d62b3a9f4bfffdbe2 Mon Sep 17 00:00:00 2001
From: Yong Zhi <yong.zhi@intel.com>
Date: Fri, 11 Dec 2015 11:29:10 -0800
Subject: [PATCH] ASoc: Intel: boards: update ignore suspend for
 nau88l25_ssm4567 machine

We don't support ignore suspend on few devices so remove that.
Also since we support ignore susend on PDM DMIC, add that

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Yong Zhi <yong.zhi@intel.com>
Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 9c9ebb8d0734..8aa821c6b106 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -187,6 +187,8 @@ static int skylake_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
 
 	nau8825_enable_jack_detect(codec, &skylake_headset);
 
+	snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "SoC DMIC");
+
 	return ret;
 }
 
@@ -285,7 +287,6 @@ static struct snd_soc_dai_link skylake_dais[] = {
 			SND_SOC_DAIFMT_IB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
 		.init = skylake_ssm4567_codec_init,
-		.ignore_suspend = 1,
 		.ignore_pmdown_time = 1,
 		.be_hw_params_fixup = skylake_ssp_fixup,
 		.dpcm_playback = 1,
@@ -302,7 +303,6 @@ static struct snd_soc_dai_link skylake_dais[] = {
 		.init = skylake_nau8825_codec_init,
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
-		.ignore_suspend = 1,
 		.ignore_pmdown_time = 1,
 		.be_hw_params_fixup = skylake_ssp_fixup,
 		.ops = &skylake_nau8825_ops,
-- 
2.6.2
