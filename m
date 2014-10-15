From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v9 6/6] ASoC: Intel: mrfld: add the DSP mixers
Date: Wed, 15 Oct 2014 12:35:01 +0530
Message-ID: <1413356701-8535-7-git-send-email-vinod.koul@intel.com>
References: <1413356701-8535-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 280D22605F2
 for <alsa-devel@alsa-project.org>; Wed, 15 Oct 2014 09:40:38 +0200 (CEST)
In-Reply-To: <1413356701-8535-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/sst-atom-controls.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/sound/soc/intel/sst-atom-controls.c b/sound/soc/intel/sst-atom-controls.c
index 056e6b3..f5e54f4 100644
--- a/sound/soc/intel/sst-atom-controls.c
+++ b/sound/soc/intel/sst-atom-controls.c
@@ -956,6 +956,32 @@ static const struct snd_soc_dapm_widget sst_dapm_widgets[] = {
 	SST_PATH_MEDIA_LOOP_OUTPUT("media_loop2_out", SST_TASK_SBA, SST_SWM_OUT_MEDIA_LOOP2, SST_FMT_STEREO, sst_set_media_loop),
 
 	/* Media Mixers */
+	SST_SWM_MIXER("media0_out mix 0", SND_SOC_NOPM, SST_TASK_MMX, SST_SWM_OUT_MEDIA0,
+		      sst_mix_media0_controls, sst_swm_mixer_event),
+	SST_SWM_MIXER("media1_out mix 0", SND_SOC_NOPM, SST_TASK_MMX, SST_SWM_OUT_MEDIA1,
+		      sst_mix_media1_controls, sst_swm_mixer_event),
+
+	/* SBA PCM mixers */
+	SST_SWM_MIXER("pcm0_out mix 0", SND_SOC_NOPM, SST_TASK_SBA, SST_SWM_OUT_PCM0,
+		      sst_mix_pcm0_controls, sst_swm_mixer_event),
+	SST_SWM_MIXER("pcm1_out mix 0", SND_SOC_NOPM, SST_TASK_SBA, SST_SWM_OUT_PCM1,
+		      sst_mix_pcm1_controls, sst_swm_mixer_event),
+	SST_SWM_MIXER("pcm2_out mix 0", SND_SOC_NOPM, SST_TASK_SBA, SST_SWM_OUT_PCM2,
+		      sst_mix_pcm2_controls, sst_swm_mixer_event),
+
+	/* SBA Loop mixers */
+	SST_SWM_MIXER("sprot_loop_out mix 0", SND_SOC_NOPM, SST_TASK_SBA, SST_SWM_OUT_SPROT_LOOP,
+		      sst_mix_sprot_l0_controls, sst_swm_mixer_event),
+	SST_SWM_MIXER("media_loop1_out mix 0", SND_SOC_NOPM, SST_TASK_SBA, SST_SWM_OUT_MEDIA_LOOP1,
+		      sst_mix_media_l1_controls, sst_swm_mixer_event),
+	SST_SWM_MIXER("media_loop2_out mix 0", SND_SOC_NOPM, SST_TASK_SBA, SST_SWM_OUT_MEDIA_LOOP2,
+		      sst_mix_media_l2_controls, sst_swm_mixer_event),
+
+	/* SBA Backend mixers */
+	SST_SWM_MIXER("codec_out0 mix 0", SND_SOC_NOPM, SST_TASK_SBA, SST_SWM_OUT_CODEC0,
+		      sst_mix_codec0_controls, sst_swm_mixer_event),
+	SST_SWM_MIXER("codec_out1 mix 0", SND_SOC_NOPM, SST_TASK_SBA, SST_SWM_OUT_CODEC1,
+		      sst_mix_codec1_controls, sst_swm_mixer_event),
 };
 
 static const struct snd_soc_dapm_route intercon[] = {
-- 
1.7.0.4
