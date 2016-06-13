From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/7] ASoC: Intel: Add DMIC 4 channel support
	for bxt machine
Date: Mon, 13 Jun 2016 17:58:58 +0530
Message-ID: <1465820944-14774-2-git-send-email-vinod.koul@intel.com>
References: <1465820944-14774-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E602265347
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 14:22:29 +0200 (CEST)
In-Reply-To: <1465820944-14774-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>

Like Skylake, we can support  4 channel for DMIC, so add
hw_params and constraints in the bxt-rt298 machine

While at it, also add codec1 pipe for speaker playback.

Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/bxt_rt298.c | 66 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index f4787515c0ed..9b649b6cc757 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -33,6 +33,7 @@ enum {
 	BXT_DPCM_AUDIO_PB = 0,
 	BXT_DPCM_AUDIO_CP,
 	BXT_DPCM_AUDIO_REF_CP,
+	BXT_DPCM_AUDIO_DMIC_CP,
 	BXT_DPCM_AUDIO_HDMI1_PB,
 	BXT_DPCM_AUDIO_HDMI2_PB,
 	BXT_DPCM_AUDIO_HDMI3_PB,
@@ -88,6 +89,7 @@ static const struct snd_soc_dapm_route broxton_rt298_map[] = {
 	/* CODEC BE connections */
 	{ "AIF1 Playback", NULL, "ssp5 Tx"},
 	{ "ssp5 Tx", NULL, "codec0_out"},
+	{ "ssp5 Tx", NULL, "codec1_out"},
 
 	{ "codec0_in", NULL, "ssp5 Rx" },
 	{ "ssp5 Rx", NULL, "AIF1 Capture" },
@@ -169,6 +171,55 @@ static struct snd_soc_ops broxton_rt298_ops = {
 	.hw_params = broxton_rt298_hw_params,
 };
 
+static unsigned int rates[] = {
+	48000,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_rates = {
+	.count = ARRAY_SIZE(rates),
+	.list  = rates,
+	.mask = 0,
+};
+
+static int broxton_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *channels = hw_param_interval(params,
+						SNDRV_PCM_HW_PARAM_CHANNELS);
+	if (params_channels(params) == 2)
+		channels->min = channels->max = 2;
+	else
+		channels->min = channels->max = 4;
+
+	return 0;
+}
+
+static unsigned int channels_dmic[] = {
+	2, 4,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_dmic_channels = {
+	.count = ARRAY_SIZE(channels_dmic),
+	.list = channels_dmic,
+	.mask = 0,
+};
+
+static int broxton_dmic_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	runtime->hw.channels_max = 4;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+					&constraints_dmic_channels);
+
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+				SNDRV_PCM_HW_PARAM_RATE, &constraints_rates);
+}
+
+static struct snd_soc_ops broxton_dmic_ops = {
+	.startup = broxton_dmic_startup,
+};
+
 /* broxton digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link broxton_rt298_dais[] = {
 	/* Front End DAI links */
@@ -211,6 +262,20 @@ static struct snd_soc_dai_link broxton_rt298_dais[] = {
 		.nonatomic = 1,
 		.dynamic = 1,
 	},
+	[BXT_DPCM_AUDIO_DMIC_CP]
+	{
+		.name = "Bxt Audio DMIC cap",
+		.stream_name = "dmiccap",
+		.cpu_dai_name = "DMIC Pin",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "0000:00:0e.0",
+		.init = NULL,
+		.dpcm_capture = 1,
+		.nonatomic = 1,
+		.dynamic = 1,
+		.ops = &broxton_dmic_ops,
+	},
 	[BXT_DPCM_AUDIO_HDMI1_PB]
 	{
 		.name = "Bxt HDMI Port1",
@@ -276,6 +341,7 @@ static struct snd_soc_dai_link broxton_rt298_dais[] = {
 		.codec_name = "dmic-codec",
 		.codec_dai_name = "dmic-hifi",
 		.platform_name = "0000:00:0e.0",
+		.be_hw_params_fixup = broxton_dmic_fixup,
 		.ignore_suspend = 1,
 		.dpcm_capture = 1,
 		.no_pcm = 1,
-- 
1.9.1
