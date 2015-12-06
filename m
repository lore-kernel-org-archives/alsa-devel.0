From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 08/17] ALSA: oxfw: move model-specific
	parameters from common structure
Date: Sun,  6 Dec 2015 13:18:16 +0900
Message-ID: <1449375505-2704-9-git-send-email-o-takashi@sakamocchi.jp>
References: <1449375505-2704-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F4A7265162
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

In previous commit, some members are moved from 'struct snd_oxfw' because
they're model-specific. There are also the other model-specific parameters
in 'struct device_info'.

This commit moves these members to model-specific structure.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-spkr.c | 60 +++++++++++++++++++++++------------------
 sound/firewire/oxfw/oxfw.c      | 16 +++--------
 sound/firewire/oxfw/oxfw.h      |  5 +---
 3 files changed, 39 insertions(+), 42 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-spkr.c b/sound/firewire/oxfw/oxfw-spkr.c
index fbdd432..cb905af 100644
--- a/sound/firewire/oxfw/oxfw-spkr.c
+++ b/sound/firewire/oxfw/oxfw-spkr.c
@@ -12,6 +12,10 @@ struct fw_spkr {
 	s16 volume[6];
 	s16 volume_min;
 	s16 volume_max;
+
+	unsigned int mixer_channels;
+	u8 mute_fb_id;
+	u8 volume_fb_id;
 };
 
 enum control_action { CTL_READ, CTL_WRITE };
@@ -162,8 +166,8 @@ static int spkr_mute_put(struct snd_kcontrol *control,
 	if (mute == spkr->mute)
 		return 0;
 
-	err = avc_audio_feature_mute(oxfw->unit, oxfw->device_info->mute_fb_id,
-				     &mute, CTL_WRITE);
+	err = avc_audio_feature_mute(oxfw->unit, spkr->mute_fb_id, &mute,
+				     CTL_WRITE);
 	if (err < 0)
 		return err;
 	spkr->mute = mute;
@@ -178,7 +182,7 @@ static int spkr_volume_info(struct snd_kcontrol *control,
 	struct fw_spkr *spkr = oxfw->spec;
 
 	info->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-	info->count = oxfw->device_info->mixer_channels;
+	info->count = spkr->mixer_channels;
 	info->value.integer.min = spkr->volume_min;
 	info->value.integer.max = spkr->volume_max;
 
@@ -194,7 +198,7 @@ static int spkr_volume_get(struct snd_kcontrol *control,
 	struct fw_spkr *spkr = oxfw->spec;
 	unsigned int i;
 
-	for (i = 0; i < oxfw->device_info->mixer_channels; ++i)
+	for (i = 0; i < spkr->mixer_channels; ++i)
 		value->value.integer.value[channel_map[i]] = spkr->volume[i];
 
 	return 0;
@@ -210,7 +214,7 @@ static int spkr_volume_put(struct snd_kcontrol *control,
 	s16 volume;
 	int err;
 
-	for (i = 0; i < oxfw->device_info->mixer_channels; ++i) {
+	for (i = 0; i < spkr->mixer_channels; ++i) {
 		if (value->value.integer.value[i] < spkr->volume_min ||
 		    value->value.integer.value[i] > spkr->volume_max)
 			return -EINVAL;
@@ -220,7 +224,7 @@ static int spkr_volume_put(struct snd_kcontrol *control,
 	}
 
 	changed_channels = 0;
-	for (i = 0; i < oxfw->device_info->mixer_channels; ++i)
+	for (i = 0; i < spkr->mixer_channels; ++i)
 		if (value->value.integer.value[channel_map[i]] !=
 							spkr->volume[i])
 			changed_channels |= 1 << (i + 1);
@@ -228,12 +232,11 @@ static int spkr_volume_put(struct snd_kcontrol *control,
 	if (equal_values && changed_channels != 0)
 		changed_channels = 1 << 0;
 
-	for (i = 0; i <= oxfw->device_info->mixer_channels; ++i) {
+	for (i = 0; i <= spkr->mixer_channels; ++i) {
 		volume = value->value.integer.value[channel_map[i ? i - 1 : 0]];
 		if (changed_channels & (1 << i)) {
 			err = avc_audio_feature_volume(oxfw->unit,
-						  oxfw->device_info->mute_fb_id,
-						  &volume,
+						  spkr->volume_fb_id, &volume,
 						  i, CTL_CURRENT, CTL_WRITE);
 			if (err < 0)
 				return err;
@@ -245,7 +248,7 @@ static int spkr_volume_put(struct snd_kcontrol *control,
 	return changed_channels != 0;
 }
 
-int snd_oxfw_add_spkr(struct snd_oxfw *oxfw)
+int snd_oxfw_add_spkr(struct snd_oxfw *oxfw, bool is_lacie)
 {
 	static const struct snd_kcontrol_new controls[] = {
 		{
@@ -272,30 +275,35 @@ int snd_oxfw_add_spkr(struct snd_oxfw *oxfw)
 		return -ENOMEM;
 	oxfw->spec = spkr;
 
-	err = avc_audio_feature_volume(oxfw->unit,
-				       oxfw->device_info->volume_fb_id,
-				       &spkr->volume_min,
-				       0, CTL_MIN, CTL_READ);
+	if (is_lacie) {
+		spkr->mixer_channels = 1;
+		spkr->mute_fb_id = 0x01;
+		spkr->volume_fb_id = 0x01;
+	} else {
+		spkr->mixer_channels = 6;
+		spkr->mute_fb_id = 0x01;
+		spkr->volume_fb_id = 0x02;
+	}
+
+	err = avc_audio_feature_volume(oxfw->unit, spkr->volume_fb_id,
+				       &spkr->volume_min, 0, CTL_MIN, CTL_READ);
 	if (err < 0)
 		return err;
-	err = avc_audio_feature_volume(oxfw->unit,
-				       oxfw->device_info->volume_fb_id,
-				       &spkr->volume_max,
-				       0, CTL_MAX, CTL_READ);
+	err = avc_audio_feature_volume(oxfw->unit, spkr->volume_fb_id,
+				       &spkr->volume_max, 0, CTL_MAX, CTL_READ);
 	if (err < 0)
 		return err;
 
-	err = avc_audio_feature_mute(oxfw->unit, oxfw->device_info->mute_fb_id,
-				     &spkr->mute, CTL_READ);
+	err = avc_audio_feature_mute(oxfw->unit, spkr->mute_fb_id, &spkr->mute,
+				     CTL_READ);
 	if (err < 0)
 		return err;
 
-	first_ch = oxfw->device_info->mixer_channels == 1 ? 0 : 1;
-	for (i = 0; i < oxfw->device_info->mixer_channels; ++i) {
-		err = avc_audio_feature_volume(oxfw->unit,
-					  oxfw->device_info->volume_fb_id,
-					  &spkr->volume[i],
-					  first_ch + i, CTL_CURRENT, CTL_READ);
+	first_ch = spkr->mixer_channels == 1 ? 0 : 1;
+	for (i = 0; i < spkr->mixer_channels; ++i) {
+		err = avc_audio_feature_volume(oxfw->unit, spkr->volume_fb_id,
+					       &spkr->volume[i], first_ch + i,
+					       CTL_CURRENT, CTL_READ);
 		if (err < 0)
 			return err;
 	}
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 7e50a4f..16ee6ea 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -147,12 +147,10 @@ static int detect_quirks(struct snd_oxfw *oxfw)
 	 * Add ALSA control elements for two models to keep compatibility to
 	 * old firewire-speaker module.
 	 */
-	if (oxfw->entry->vendor_id == VENDOR_GRIFFIN ||
-	    oxfw->entry->vendor_id == VENDOR_LACIE) {
-		oxfw->device_info =
-			(const struct device_info *)oxfw->entry->driver_data;
-		return snd_oxfw_add_spkr(oxfw);
-	}
+	if (oxfw->entry->vendor_id == VENDOR_GRIFFIN)
+		return snd_oxfw_add_spkr(oxfw, false);
+	if (oxfw->entry->vendor_id == VENDOR_LACIE)
+		return snd_oxfw_add_spkr(oxfw, true);
 
 	/*
 	 * TASCAM FireOne has physical control and requires a pair of additional
@@ -285,18 +283,12 @@ static const struct device_info griffin_firewave = {
 	.driver_name = "FireWave",
 	.vendor_name = "Griffin",
 	.model_name = "FireWave",
-	.mixer_channels = 6,
-	.mute_fb_id   = 0x01,
-	.volume_fb_id = 0x02,
 };
 
 static const struct device_info lacie_speakers = {
 	.driver_name = "FWSpeakers",
 	.vendor_name = "LaCie",
 	.model_name = "FireWire Speakers",
-	.mixer_channels = 1,
-	.mute_fb_id   = 0x01,
-	.volume_fb_id = 0x01,
 };
 
 static const struct ieee1394_device_id oxfw_id_table[] = {
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index 046cd33..6038150 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -35,9 +35,6 @@ struct device_info {
 	const char *driver_name;
 	const char *vendor_name;
 	const char *model_name;
-	unsigned int mixer_channels;
-	u8 mute_fb_id;
-	u8 volume_fb_id;
 };
 
 /* This is an arbitrary number for convinience. */
@@ -142,4 +139,4 @@ int snd_oxfw_create_midi(struct snd_oxfw *oxfw);
 
 int snd_oxfw_create_hwdep(struct snd_oxfw *oxfw);
 
-int snd_oxfw_add_spkr(struct snd_oxfw *oxfw);
+int snd_oxfw_add_spkr(struct snd_oxfw *oxfw, bool is_lacie);
-- 
2.5.0
