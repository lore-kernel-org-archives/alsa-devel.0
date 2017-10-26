From: Harsha Priya <harshapriya.n@intel.com>
Subject: [PATCH RESEND 1/2] ASoC: Intel: Enable tdm slots for
	max98927
Date: Thu, 26 Oct 2017 11:44:02 -0700
Message-ID: <1509043443-28143-2-git-send-email-harshapriya.n@intel.com>
References: <1509043443-28143-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 24A73267468
 for <alsa-devel@alsa-project.org>; Thu, 26 Oct 2017 20:47:29 +0200 (CEST)
In-Reply-To: <1509043443-28143-1-git-send-email-harshapriya.n@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, vinod.koul@intel.com, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: Harsha Priya <harshapriya.n@intel.com>, Naveen M <naveen.m@intel.com>
List-Id: alsa-devel@alsa-project.org

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
---
 sound/soc/intel/boards/kbl_rt5663_max98927.c | 40 +++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index e45b6fe..5a4ee5b 100644
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
@@ -602,12 +639,13 @@ static int kabylake_refcap_startup(struct snd_pcm_substream *substream)
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
1.9.1
