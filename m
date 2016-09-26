From: Yong Zhi <yong.zhi@intel.com>
Subject: [PATCH] ASoC: Intel: Add DMIC channel constraint for
	bxt machine
Date: Mon, 26 Sep 2016 13:02:29 -0700
Message-ID: <013ecae10cb3d5f05a1674f184dad29808aa1c6b.1474919400.git.yong.zhi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D0DC26691F
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2016 21:58:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, marc.herbert@intel.com, harshapriya.n@intel.com, sathyanarayana.nujella@intel.com, sathya.prakash.m.r@intel.com, jeeja.kp@intel.com, vedang.patel@intel.com, Yong Zhi <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

Add channel and rate constraints for Refcap and dmiccap devices
respectively.

Signed-off-by: Yong Zhi <yong.zhi@intel.com>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 63 +++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 3774b11..bb4533c 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -37,6 +37,7 @@ enum {
 	BXT_DPCM_AUDIO_PB = 0,
 	BXT_DPCM_AUDIO_CP,
 	BXT_DPCM_AUDIO_REF_CP,
+	BXT_DPCM_AUDIO_DMIC_CP,
 	BXT_DPCM_AUDIO_HDMI1_PB,
 	BXT_DPCM_AUDIO_HDMI2_PB,
 	BXT_DPCM_AUDIO_HDMI3_PB,
@@ -252,6 +253,52 @@ static struct snd_soc_ops broxton_da7219_ops = {
 	.hw_free = broxton_da7219_hw_free,
 };
 
+static int broxton_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
+			struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *channels = hw_param_interval(params,
+						SNDRV_PCM_HW_PARAM_CHANNELS);
+	channels->min = channels->max = DUAL_CHANNEL;
+
+	return 0;
+}
+
+static int broxton_dmic_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	runtime->hw.channels_max = DUAL_CHANNEL;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+			&constraints_channels);
+
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE, &constraints_rates);
+}
+
+static const struct snd_soc_ops broxton_dmic_ops = {
+	.startup = broxton_dmic_startup,
+};
+
+static const unsigned int rates_16000[] = {
+	16000,
+};
+
+static const struct snd_pcm_hw_constraint_list constraints_16000 = {
+	.count = ARRAY_SIZE(rates_16000),
+	.list  = rates_16000,
+};
+
+static int broxton_refcap_startup(struct snd_pcm_substream *substream)
+{
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE,
+			&constraints_16000);
+};
+
+static struct snd_soc_ops broxton_refcap_ops = {
+	.startup = broxton_refcap_startup,
+};
+
 /* broxton digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link broxton_dais[] = {
 	/* Front End DAI links */
@@ -299,6 +346,21 @@ static struct snd_soc_dai_link broxton_dais[] = {
 		.ignore_suspend = 1,
 		.nonatomic = 1,
 		.dynamic = 1,
+		.ops = &broxton_refcap_ops,
+	},
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
 	},
 	[BXT_DPCM_AUDIO_HDMI1_PB]
 	{
@@ -382,6 +444,7 @@ static struct snd_soc_dai_link broxton_dais[] = {
 		.codec_dai_name = "dmic-hifi",
 		.platform_name = "0000:00:0e.0",
 		.ignore_suspend = 1,
+		.be_hw_params_fixup = broxton_dmic_fixup,
 		.dpcm_capture = 1,
 		.no_pcm = 1,
 	},
-- 
1.9.1
