From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 12/12] ASoC: Intel: Skylake: Update ignore
	suspend for rt286 machine
Date: Thu,  3 Dec 2015 23:30:01 +0530
Message-ID: <1449165601-11226-13-git-send-email-vinod.koul@intel.com>
References: <1449165601-11226-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E3202606FE
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2015 18:57:36 +0100 (CET)
In-Reply-To: <1449165601-11226-1-git-send-email-vinod.koul@intel.com>
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
Cc: patches.audio@intel.com, Praveen Diwakar <praveen.diwakar@intel.com>, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Vunny Sodhi <vunnyx.sodhi@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Praveen Diwakar <praveen.diwakar@intel.com>

We should only add ignore suspend flag for some DAIs and not all.
This patches removes it from the DAIs where we do not support
this

It also marks the endpoints for which ignore_suspend should be
enabled

Signed-off-by: Praveen Diwakar <praveen.diwakar@intel.com>
Signed-off-by: Vunny Sodhi <vunnyx.sodhi@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/skl_rt286.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index 51c4eb87e6ec..7396ddb427d8 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -89,6 +89,17 @@ static const struct snd_soc_dapm_route skylake_rt286_map[] = {
 
 };
 
+static int skylake_rt286_fe_init(struct snd_soc_pcm_runtime *rtd)
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
 static int skylake_rt286_codec_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
@@ -104,6 +115,9 @@ static int skylake_rt286_codec_init(struct snd_soc_pcm_runtime *rtd)
 
 	rt286_mic_detect(codec, &skylake_headset);
 
+	snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "SoC DMIC");
+	snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "WoV Sink");
+
 	return 0;
 }
 
@@ -241,6 +255,7 @@ static struct snd_soc_dai_link skylake_rt286_dais[] = {
 		.dynamic = 1,
 		.codec_name = "snd-soc-dummy",
 		.codec_dai_name = "snd-soc-dummy-dai",
+		.init = skylake_rt286_fe_init,
 		.trigger = {
 			SND_SOC_DPCM_TRIGGER_POST,
 			SND_SOC_DPCM_TRIGGER_POST
@@ -286,7 +301,6 @@ static struct snd_soc_dai_link skylake_rt286_dais[] = {
 		.platform_name = "0000:00:1f.3",
 		.init = NULL,
 		.dpcm_capture = 1,
-		.ignore_suspend = 1,
 		.nonatomic = 1,
 		.dynamic = 1,
 		.ops = &skylake_dmic_ops,
@@ -306,7 +320,6 @@ static struct snd_soc_dai_link skylake_rt286_dais[] = {
 		.dai_fmt = SND_SOC_DAIFMT_I2S |
 			SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
-		.ignore_suspend = 1,
 		.ignore_pmdown_time = 1,
 		.be_hw_params_fixup = skylake_ssp0_fixup,
 		.ops = &skylake_rt286_ops,
-- 
1.9.1
