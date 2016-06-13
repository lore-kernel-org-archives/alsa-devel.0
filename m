From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/7] ASoC: Intel: Add FE rate & channel
	constraints for bxt-rt298
Date: Mon, 13 Jun 2016 17:58:59 +0530
Message-ID: <1465820944-14774-3-git-send-email-vinod.koul@intel.com>
References: <1465820944-14774-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id ECAE5265471
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 14:22:31 +0200 (CEST)
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

We support stereo 48Khz audio, so add these as constraints
for this card

Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/bxt_rt298.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index 9b649b6cc757..10eb5cbf57e4 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -220,6 +220,40 @@ static struct snd_soc_ops broxton_dmic_ops = {
 	.startup = broxton_dmic_startup,
 };
 
+static unsigned int channels[] = {
+	2,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_channels = {
+	.count = ARRAY_SIZE(channels),
+	.list = channels,
+	.mask = 0,
+};
+
+static int bxt_fe_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	/*
+	 * on this platform for PCM device we support:
+	 *      48Khz
+	 *      stereo
+	 */
+
+	runtime->hw.channels_max = 2;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				&constraints_channels);
+
+	snd_pcm_hw_constraint_list(runtime, 0,
+				SNDRV_PCM_HW_PARAM_RATE, &constraints_rates);
+
+	return 0;
+}
+
+static const struct snd_soc_ops broxton_rt286_fe_ops = {
+	.startup = bxt_fe_startup,
+};
+
 /* broxton digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link broxton_rt298_dais[] = {
 	/* Front End DAI links */
@@ -235,6 +269,7 @@ static struct snd_soc_dai_link broxton_rt298_dais[] = {
 		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
 		.dpcm_playback = 1,
+		.ops = &broxton_rt286_fe_ops,
 	},
 	[BXT_DPCM_AUDIO_CP]
 	{
@@ -248,6 +283,7 @@ static struct snd_soc_dai_link broxton_rt298_dais[] = {
 		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
 		.dpcm_capture = 1,
+		.ops = &broxton_rt286_fe_ops,
 	},
 	[BXT_DPCM_AUDIO_REF_CP]
 	{
-- 
1.9.1
