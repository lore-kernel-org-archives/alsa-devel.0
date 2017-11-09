From: Naveen Manohar <naveen.m@intel.com>
Subject: [PATCH 2/2] ASoC: Intel: kbl: update dmic fixup params
Date: Thu,  9 Nov 2017 19:34:36 +0530
Message-ID: <1510236276-3416-3-git-send-email-naveen.m@intel.com>
References: <1510236276-3416-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D68A2677C4
 for <alsa-devel@alsa-project.org>; Thu,  9 Nov 2017 15:05:12 +0100 (CET)
In-Reply-To: <1510236276-3416-1-git-send-email-naveen.m@intel.com>
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
Cc: vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, naveen.m@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

Update dmic fixup params to always expose QUAD channel capture
device, enabling User-space to control channel count.
Assign min and max channel only based on input hw_params.

Signed-off-by: Naveen Manohar <naveen.m@intel.com>
---
 sound/soc/intel/boards/kbl_rt5663_max98927.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index 661f164..27c8cf3 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -33,9 +33,9 @@
 #define DMIC_CH(p) p->list[p->count-1]
 #define MAXIM_DEV0_NAME "i2c-MX98927:00"
 #define MAXIM_DEV1_NAME "i2c-MX98927:01"
+#define QUAD_CHANNEL 4
 
 static struct snd_soc_card *kabylake_audio_card;
-static const struct snd_pcm_hw_constraint_list *dmic_constraints;
 static struct snd_soc_jack skylake_hdmi[3];
 
 struct kbl_hdmi_pcm {
@@ -305,6 +305,16 @@ static int kabylake_5663_hdmi2_init(struct snd_soc_pcm_runtime *rtd)
 	.mask = 0,
 };
 
+static const unsigned int channels_quad[] = {
+	QUAD_CHANNEL,
+};
+
+static const struct snd_pcm_hw_constraint_list constraints_channels_quad = {
+	.count = ARRAY_SIZE(channels_quad),
+	.list = channels_quad,
+	.mask = 0,
+};
+
 static int kbl_fe_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -382,7 +392,7 @@ static int kabylake_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
 	struct snd_interval *channels = hw_param_interval(params,
 				SNDRV_PCM_HW_PARAM_CHANNELS);
 
-	if (params_channels(params) == 2 || DMIC_CH(dmic_constraints) == 2)
+	if (params_channels(params) == 2)
 		channels->min = channels->max = 2;
 	else
 		channels->min = channels->max = 4;
@@ -394,9 +404,9 @@ static int kabylake_dmic_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
-	runtime->hw.channels_max = DMIC_CH(dmic_constraints);
+	runtime->hw.channels_min = runtime->hw.channels_max = QUAD_CHANNEL;
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
-			dmic_constraints);
+			&constraints_channels_quad);
 
 	return snd_pcm_hw_constraint_list(substream->runtime, 0,
 			SNDRV_PCM_HW_PARAM_RATE, &constraints_rates);
-- 
1.9.1
