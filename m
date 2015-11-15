From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/9] ALSA: oxfw: rename local functions for
	control elements so that they represent as local
Date: Sun, 15 Nov 2015 18:25:59 +0900
Message-ID: <1447579565-4615-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1447579565-4615-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 49812261A53
 for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2015 10:26:10 +0100 (CET)
In-Reply-To: <1447579565-4615-1-git-send-email-o-takashi@sakamocchi.jp>
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

This commit renames local functions with prefix 'spkr_', so that they're
in firewire-speaker layer.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-spkr.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-spkr.c b/sound/firewire/oxfw/oxfw-spkr.c
index ba766be..515468a 100644
--- a/sound/firewire/oxfw/oxfw-spkr.c
+++ b/sound/firewire/oxfw/oxfw-spkr.c
@@ -16,7 +16,7 @@ enum control_attribute {
 	CTL_CURRENT	= 0x10,
 };
 
-static int oxfw_mute_command(struct snd_oxfw *oxfw, bool *value,
+static int spkr_mute_command(struct snd_oxfw *oxfw, bool *value,
 			     enum control_action action)
 {
 	u8 *buf;
@@ -72,7 +72,7 @@ error:
 	return err;
 }
 
-static int oxfw_volume_command(struct snd_oxfw *oxfw, s16 *value,
+static int spkr_volume_command(struct snd_oxfw *oxfw, s16 *value,
 			       unsigned int channel,
 			       enum control_attribute attribute,
 			       enum control_action action)
@@ -133,7 +133,7 @@ error:
 	return err;
 }
 
-static int oxfw_mute_get(struct snd_kcontrol *control,
+static int spkr_mute_get(struct snd_kcontrol *control,
 			 struct snd_ctl_elem_value *value)
 {
 	struct snd_oxfw *oxfw = control->private_data;
@@ -143,7 +143,7 @@ static int oxfw_mute_get(struct snd_kcontrol *control,
 	return 0;
 }
 
-static int oxfw_mute_put(struct snd_kcontrol *control,
+static int spkr_mute_put(struct snd_kcontrol *control,
 			 struct snd_ctl_elem_value *value)
 {
 	struct snd_oxfw *oxfw = control->private_data;
@@ -155,7 +155,7 @@ static int oxfw_mute_put(struct snd_kcontrol *control,
 	if (mute == oxfw->mute)
 		return 0;
 
-	err = oxfw_mute_command(oxfw, &mute, CTL_WRITE);
+	err = spkr_mute_command(oxfw, &mute, CTL_WRITE);
 	if (err < 0)
 		return err;
 	oxfw->mute = mute;
@@ -163,7 +163,7 @@ static int oxfw_mute_put(struct snd_kcontrol *control,
 	return 1;
 }
 
-static int oxfw_volume_info(struct snd_kcontrol *control,
+static int spkr_volume_info(struct snd_kcontrol *control,
 			    struct snd_ctl_elem_info *info)
 {
 	struct snd_oxfw *oxfw = control->private_data;
@@ -178,7 +178,7 @@ static int oxfw_volume_info(struct snd_kcontrol *control,
 
 static const u8 channel_map[6] = { 0, 1, 4, 5, 2, 3 };
 
-static int oxfw_volume_get(struct snd_kcontrol *control,
+static int spkr_volume_get(struct snd_kcontrol *control,
 			   struct snd_ctl_elem_value *value)
 {
 	struct snd_oxfw *oxfw = control->private_data;
@@ -190,7 +190,7 @@ static int oxfw_volume_get(struct snd_kcontrol *control,
 	return 0;
 }
 
-static int oxfw_volume_put(struct snd_kcontrol *control,
+static int spkr_volume_put(struct snd_kcontrol *control,
 			   struct snd_ctl_elem_value *value)
 {
 	struct snd_oxfw *oxfw = control->private_data;
@@ -220,7 +220,7 @@ static int oxfw_volume_put(struct snd_kcontrol *control,
 	for (i = 0; i <= oxfw->device_info->mixer_channels; ++i) {
 		volume = value->value.integer.value[channel_map[i ? i - 1 : 0]];
 		if (changed_channels & (1 << i)) {
-			err = oxfw_volume_command(oxfw, &volume, i,
+			err = spkr_volume_command(oxfw, &volume, i,
 						   CTL_CURRENT, CTL_WRITE);
 			if (err < 0)
 				return err;
@@ -239,36 +239,36 @@ int snd_oxfw_create_mixer(struct snd_oxfw *oxfw)
 			.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 			.name = "PCM Playback Switch",
 			.info = snd_ctl_boolean_mono_info,
-			.get = oxfw_mute_get,
-			.put = oxfw_mute_put,
+			.get = spkr_mute_get,
+			.put = spkr_mute_put,
 		},
 		{
 			.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 			.name = "PCM Playback Volume",
-			.info = oxfw_volume_info,
-			.get = oxfw_volume_get,
-			.put = oxfw_volume_put,
+			.info = spkr_volume_info,
+			.get = spkr_volume_get,
+			.put = spkr_volume_put,
 		},
 	};
 	unsigned int i, first_ch;
 	int err;
 
-	err = oxfw_volume_command(oxfw, &oxfw->volume_min,
+	err = spkr_volume_command(oxfw, &oxfw->volume_min,
 				   0, CTL_MIN, CTL_READ);
 	if (err < 0)
 		return err;
-	err = oxfw_volume_command(oxfw, &oxfw->volume_max,
+	err = spkr_volume_command(oxfw, &oxfw->volume_max,
 				   0, CTL_MAX, CTL_READ);
 	if (err < 0)
 		return err;
 
-	err = oxfw_mute_command(oxfw, &oxfw->mute, CTL_READ);
+	err = spkr_mute_command(oxfw, &oxfw->mute, CTL_READ);
 	if (err < 0)
 		return err;
 
 	first_ch = oxfw->device_info->mixer_channels == 1 ? 0 : 1;
 	for (i = 0; i < oxfw->device_info->mixer_channels; ++i) {
-		err = oxfw_volume_command(oxfw, &oxfw->volume[i],
+		err = spkr_volume_command(oxfw, &oxfw->volume[i],
 					   first_ch + i, CTL_CURRENT, CTL_READ);
 		if (err < 0)
 			return err;
-- 
2.5.0
