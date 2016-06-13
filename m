From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/7] ASoC: Intel: Update ignore suspend for
	bxt-rt298
Date: Mon, 13 Jun 2016 17:59:00 +0530
Message-ID: <1465820944-14774-4-git-send-email-vinod.koul@intel.com>
References: <1465820944-14774-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 783B12654C7
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 14:22:34 +0200 (CEST)
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

Capture from DMIC requires that we ignore the suspend, so mark
these as ignore_suspend in bxt-rt298 machine.

Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
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
1.9.1
