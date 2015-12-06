From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 07/17] ALSA: oxfw: move model-specific members
	from common structure
Date: Sun,  6 Dec 2015 13:18:15 +0900
Message-ID: <1449375505-2704-8-git-send-email-o-takashi@sakamocchi.jp>
References: <1449375505-2704-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 75DD42604BE
 for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2015 05:18:32 +0100 (CET)
In-Reply-To: <1449375505-2704-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Currently, 'struct snd_oxfw' has some members for models supported by old
firewire-speakers driver, while these members are useless to the other
models.

This commit allocates new memory block and moves these members to
model-specific structure.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-spkr.c | 48 +++++++++++++++++++++++++++++------------
 sound/firewire/oxfw/oxfw.h      |  5 -----
 2 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-spkr.c b/sound/firewire/oxfw/oxfw-spkr.c
index d733a15..fbdd432 100644
--- a/sound/firewire/oxfw/oxfw-spkr.c
+++ b/sound/firewire/oxfw/oxfw-spkr.c
@@ -7,6 +7,13 @@
 
 #include "oxfw.h"
 
+struct fw_spkr {
+	bool mute;
+	s16 volume[6];
+	s16 volume_min;
+	s16 volume_max;
+};
+
 enum control_action { CTL_READ, CTL_WRITE };
 enum control_attribute {
 	CTL_MIN		= 0x02,
@@ -135,8 +142,9 @@ static int spkr_mute_get(struct snd_kcontrol *control,
 			 struct snd_ctl_elem_value *value)
 {
 	struct snd_oxfw *oxfw = control->private_data;
+	struct fw_spkr *spkr = oxfw->spec;
 
-	value->value.integer.value[0] = !oxfw->mute;
+	value->value.integer.value[0] = !spkr->mute;
 
 	return 0;
 }
@@ -145,19 +153,20 @@ static int spkr_mute_put(struct snd_kcontrol *control,
 			 struct snd_ctl_elem_value *value)
 {
 	struct snd_oxfw *oxfw = control->private_data;
+	struct fw_spkr *spkr = oxfw->spec;
 	bool mute;
 	int err;
 
 	mute = !value->value.integer.value[0];
 
-	if (mute == oxfw->mute)
+	if (mute == spkr->mute)
 		return 0;
 
 	err = avc_audio_feature_mute(oxfw->unit, oxfw->device_info->mute_fb_id,
 				     &mute, CTL_WRITE);
 	if (err < 0)
 		return err;
-	oxfw->mute = mute;
+	spkr->mute = mute;
 
 	return 1;
 }
@@ -166,11 +175,12 @@ static int spkr_volume_info(struct snd_kcontrol *control,
 			    struct snd_ctl_elem_info *info)
 {
 	struct snd_oxfw *oxfw = control->private_data;
+	struct fw_spkr *spkr = oxfw->spec;
 
 	info->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	info->count = oxfw->device_info->mixer_channels;
-	info->value.integer.min = oxfw->volume_min;
-	info->value.integer.max = oxfw->volume_max;
+	info->value.integer.min = spkr->volume_min;
+	info->value.integer.max = spkr->volume_max;
 
 	return 0;
 }
@@ -181,10 +191,11 @@ static int spkr_volume_get(struct snd_kcontrol *control,
 			   struct snd_ctl_elem_value *value)
 {
 	struct snd_oxfw *oxfw = control->private_data;
+	struct fw_spkr *spkr = oxfw->spec;
 	unsigned int i;
 
 	for (i = 0; i < oxfw->device_info->mixer_channels; ++i)
-		value->value.integer.value[channel_map[i]] = oxfw->volume[i];
+		value->value.integer.value[channel_map[i]] = spkr->volume[i];
 
 	return 0;
 }
@@ -193,14 +204,15 @@ static int spkr_volume_put(struct snd_kcontrol *control,
 			   struct snd_ctl_elem_value *value)
 {
 	struct snd_oxfw *oxfw = control->private_data;
+	struct fw_spkr *spkr = oxfw->spec;
 	unsigned int i, changed_channels;
 	bool equal_values = true;
 	s16 volume;
 	int err;
 
 	for (i = 0; i < oxfw->device_info->mixer_channels; ++i) {
-		if (value->value.integer.value[i] < oxfw->volume_min ||
-		    value->value.integer.value[i] > oxfw->volume_max)
+		if (value->value.integer.value[i] < spkr->volume_min ||
+		    value->value.integer.value[i] > spkr->volume_max)
 			return -EINVAL;
 		if (value->value.integer.value[i] !=
 		    value->value.integer.value[0])
@@ -210,7 +222,7 @@ static int spkr_volume_put(struct snd_kcontrol *control,
 	changed_channels = 0;
 	for (i = 0; i < oxfw->device_info->mixer_channels; ++i)
 		if (value->value.integer.value[channel_map[i]] !=
-							oxfw->volume[i])
+							spkr->volume[i])
 			changed_channels |= 1 << (i + 1);
 
 	if (equal_values && changed_channels != 0)
@@ -227,7 +239,7 @@ static int spkr_volume_put(struct snd_kcontrol *control,
 				return err;
 		}
 		if (i > 0)
-			oxfw->volume[i - 1] = volume;
+			spkr->volume[i - 1] = volume;
 	}
 
 	return changed_channels != 0;
@@ -251,22 +263,30 @@ int snd_oxfw_add_spkr(struct snd_oxfw *oxfw)
 			.put = spkr_volume_put,
 		},
 	};
+	struct fw_spkr *spkr;
 	unsigned int i, first_ch;
 	int err;
 
+	spkr = kzalloc(sizeof(struct fw_spkr), GFP_KERNEL);
+	if (spkr == NULL)
+		return -ENOMEM;
+	oxfw->spec = spkr;
+
 	err = avc_audio_feature_volume(oxfw->unit,
 				       oxfw->device_info->volume_fb_id,
-				       &oxfw->volume_min, 0, CTL_MIN, CTL_READ);
+				       &spkr->volume_min,
+				       0, CTL_MIN, CTL_READ);
 	if (err < 0)
 		return err;
 	err = avc_audio_feature_volume(oxfw->unit,
 				       oxfw->device_info->volume_fb_id,
-				       &oxfw->volume_max, 0, CTL_MAX, CTL_READ);
+				       &spkr->volume_max,
+				       0, CTL_MAX, CTL_READ);
 	if (err < 0)
 		return err;
 
 	err = avc_audio_feature_mute(oxfw->unit, oxfw->device_info->mute_fb_id,
-				     &oxfw->mute, CTL_READ);
+				     &spkr->mute, CTL_READ);
 	if (err < 0)
 		return err;
 
@@ -274,7 +294,7 @@ int snd_oxfw_add_spkr(struct snd_oxfw *oxfw)
 	for (i = 0; i < oxfw->device_info->mixer_channels; ++i) {
 		err = avc_audio_feature_volume(oxfw->unit,
 					  oxfw->device_info->volume_fb_id,
-					  &oxfw->volume[i],
+					  &spkr->volume[i],
 					  first_ch + i, CTL_CURRENT, CTL_READ);
 		if (err < 0)
 			return err;
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index 9625661..046cd33 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -64,11 +64,6 @@ struct snd_oxfw {
 	unsigned int midi_input_ports;
 	unsigned int midi_output_ports;
 
-	bool mute;
-	s16 volume[6];
-	s16 volume_min;
-	s16 volume_max;
-
 	int dev_lock_count;
 	bool dev_lock_changed;
 	wait_queue_head_t hwdep_wait;
-- 
2.5.0
