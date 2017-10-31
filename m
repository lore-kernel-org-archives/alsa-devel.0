From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Enable tdm slots for max98927"
	to the asoc tree
Date: Tue, 31 Oct 2017 11:21:12 +0000
Message-ID: <E1e9UbY-0002mG-4v@debutante>
References: <1504291278-4482-2-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 47751267275
 for <alsa-devel@alsa-project.org>; Tue, 31 Oct 2017 12:21:17 +0100 (CET)
In-Reply-To: <1504291278-4482-2-git-send-email-harshapriya.n@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Harsha Priya <harshapriya.n@intel.com>, vinod.koul@intel.com, broonie@kernel.org, tiwai@suse.de, Naveen M <naveen.m@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Enable tdm slots for max98927

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

>From 7a679ea75a1bc4ea6216aa6877a8bd47fd83e790 Mon Sep 17 00:00:00 2001
From: Harsha Priya N <harshapriya.n@intel.com>
Date: Thu, 26 Oct 2017 11:44:02 -0700
Subject: [PATCH] ASoC: Intel: Enable tdm slots for max98927

In this patch the SSP0 BE's mode is changed from I2S mode to DSP_B
with 8 slots of 16 bits. It enables 4 slot for IV feedback and 2 slots for
playback on max98927 for kabylake machine driver

The layout of SSP0 Tx and Rx slots is as follows;
1. Playback uses Tx slots 0 and 1
2. Capture uses Rx slots 4,5,6,7.

Slots 0 through 3 of Rx are used by DMIC codec RT5514 in another flavor
of Kabylake platform. We are using the same slots 4 through 7 on all
Kabylake platforms for max98927 in order to reuse same NHLT configuration.

Signed-off-by: Naveen M <naveen.m@intel.com>
Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/kbl_rt5663_max98927.c | 40 +++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index e45b6feca076..5a4ee5b1c6a0 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -399,6 +399,43 @@ static int kabylake_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
+static int kabylake_ssp0_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	int ret = 0, j;
+
+	for (j = 0; j < rtd->num_codecs; j++) {
+		struct snd_soc_dai *codec_dai = rtd->codec_dais[j];
+
+		if (!strcmp(codec_dai->component->name, MAXIM_DEV0_NAME)) {
+			/*
+			 * Use channel 4 and 5 for the first amp
+			 */
+			ret = snd_soc_dai_set_tdm_slot(codec_dai, 0x30, 3, 8, 16);
+			if (ret < 0) {
+				dev_err(rtd->dev, "set TDM slot err:%d\n", ret);
+				return ret;
+			}
+		}
+		if (!strcmp(codec_dai->component->name, MAXIM_DEV1_NAME)) {
+			/*
+			 * Use channel 6 and 7 for the second amp
+			 */
+			ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xC0, 3, 8, 16);
+			if (ret < 0) {
+				dev_err(rtd->dev, "set TDM slot err:%d\n", ret);
+				return ret;
+			}
+		}
+	}
+	return ret;
+}
+
+static struct snd_soc_ops kabylake_ssp0_ops = {
+	.hw_params = kabylake_ssp0_hw_params,
+};
+
 static unsigned int channels_dmic[] = {
 	2, 4,
 };
@@ -602,12 +639,13 @@ static struct snd_soc_dai_link kabylake_dais[] = {
 		.no_pcm = 1,
 		.codecs = max98927_codec_components,
 		.num_codecs = ARRAY_SIZE(max98927_codec_components),
-		.dai_fmt = SND_SOC_DAIFMT_I2S |
+		.dai_fmt = SND_SOC_DAIFMT_DSP_B |
 			SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
 		.ignore_pmdown_time = 1,
 		.be_hw_params_fixup = kabylake_ssp_fixup,
 		.dpcm_playback = 1,
+		.ops = &kabylake_ssp0_ops,
 	},
 	{
 		/* SSP1 - Codec */
-- 
2.15.0.rc2
