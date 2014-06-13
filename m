From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 19/19] ASoC: Intel: mrfld: add the DSP mixers
Date: Fri, 13 Jun 2014 18:04:08 +0530
Message-ID: <1402662848-24534-20-git-send-email-vinod.koul@intel.com>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 06218261A3D
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 14:33:31 +0200 (CEST)
In-Reply-To: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The is RFC patch for adding the platform mixer controls. This requires the
dapm_set-get to be exported. Or changes required after component series is
merged

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-atom-controls.c |   67 +++++++++++++++++++++++++++++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/sound/soc/intel/sst-atom-controls.c b/sound/soc/intel/sst-atom-controls.c
index 2e733f8..81a24eb 100644
--- a/sound/soc/intel/sst-atom-controls.c
+++ b/sound/soc/intel/sst-atom-controls.c
@@ -66,6 +66,47 @@ unsigned int sst_reg_write(struct sst_data *drv, unsigned int reg,
 	return val;
 }
 
+int sst_mix_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_widget_list *wlist;// = dapm_kcontrol_get_wlist(kcontrol);
+	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct sst_data *drv = snd_soc_platform_get_drvdata(widget->platform);
+	unsigned int mask = (1 << fls(mc->max)) - 1;
+	unsigned int val;
+	int connect;
+	struct snd_soc_dapm_update update;
+
+	pr_debug("%s called set %#lx for %s\n", __func__,
+			ucontrol->value.integer.value[0], widget->name);
+	val = sst_reg_write(drv, mc->reg, mc->shift, mc->max, ucontrol->value.integer.value[0]);
+	connect = !!val;
+
+	//dapm_kcontrol_set_value(kcontrol, val);
+	update.kcontrol = kcontrol;
+	update.reg = mc->reg;
+	update.mask = mask;
+	update.val = val;
+
+	snd_soc_dapm_mixer_update_power(widget->dapm, kcontrol, connect, &update);
+	return 0;
+}
+
+int sst_mix_get(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_widget_list *wlist;// = dapm_kcontrol_get_wlist(kcontrol);
+	struct snd_soc_dapm_widget *w = wlist->widgets[0];
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct sst_data *drv = snd_soc_platform_get_drvdata(w->platform);
+
+	ucontrol->value.integer.value[0] = !!sst_reg_read(drv, mc->reg, mc->shift, mc->max);
+	return 0;
+}
+
 static inline void sst_fill_byte_control(char *param,
 					 u8 ipc_msg, u8 block,
 					 u8 task_id, u8 pipe_id,
@@ -937,6 +978,32 @@ static const struct snd_soc_dapm_widget sst_dapm_widgets[] = {
 	SST_PATH_MEDIA_LOOP_OUTPUT("media_loop2_out", SST_TASK_SBA, SST_SWM_OUT_MEDIA_LOOP2, SST_FMT_STEREO, sst_set_media_loop),
 
 	/* Media Mixers */
+	SST_SWM_MIXER("media0_out mix 0", SST_MIX_MEDIA0, SST_TASK_MMX, SST_SWM_OUT_MEDIA0,
+		      sst_mix_media0_controls, sst_swm_mixer_event),
+	SST_SWM_MIXER("media1_out mix 0", SST_MIX_MEDIA1, SST_TASK_MMX, SST_SWM_OUT_MEDIA1,
+		      sst_mix_media1_controls, sst_swm_mixer_event),
+
+	/* SBA PCM mixers */
+	SST_SWM_MIXER("pcm0_out mix 0", SST_MIX_PCM0, SST_TASK_SBA, SST_SWM_OUT_PCM0,
+		      sst_mix_pcm0_controls, sst_swm_mixer_event),
+	SST_SWM_MIXER("pcm1_out mix 0", SST_MIX_PCM1, SST_TASK_SBA, SST_SWM_OUT_PCM1,
+		      sst_mix_pcm1_controls, sst_swm_mixer_event),
+	SST_SWM_MIXER("pcm2_out mix 0", SST_MIX_PCM2, SST_TASK_SBA, SST_SWM_OUT_PCM2,
+		      sst_mix_pcm2_controls, sst_swm_mixer_event),
+
+	/* SBA Loop mixers */
+	SST_SWM_MIXER("sprot_loop_out mix 0", SST_MIX_LOOP0, SST_TASK_SBA, SST_SWM_OUT_SPROT_LOOP,
+		      sst_mix_sprot_l0_controls, sst_swm_mixer_event),
+	SST_SWM_MIXER("media_loop1_out mix 0", SST_MIX_LOOP1, SST_TASK_SBA, SST_SWM_OUT_MEDIA_LOOP1,
+		      sst_mix_media_l1_controls, sst_swm_mixer_event),
+	SST_SWM_MIXER("media_loop2_out mix 0", SST_MIX_LOOP2, SST_TASK_SBA, SST_SWM_OUT_MEDIA_LOOP2,
+		      sst_mix_media_l2_controls, sst_swm_mixer_event),
+
+	/* SBA Backend mixers */
+	SST_SWM_MIXER("codec_out0 mix 0", SST_MIX_CODEC0, SST_TASK_SBA, SST_SWM_OUT_CODEC0,
+		      sst_mix_codec0_controls, sst_swm_mixer_event),
+	SST_SWM_MIXER("codec_out1 mix 0", SST_MIX_CODEC1, SST_TASK_SBA, SST_SWM_OUT_CODEC1,
+		      sst_mix_codec1_controls, sst_swm_mixer_event),
 };
 
 static const struct snd_soc_dapm_route intercon[] = {
-- 
1.7.0.4
