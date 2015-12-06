From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 03/17] ALSA: oxfw: change function prototype
	for AV/C Audio Subunit command
Date: Sun,  6 Dec 2015 13:18:11 +0900
Message-ID: <1449375505-2704-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1449375505-2704-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id E2E28260492
 for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2015 05:18:30 +0100 (CET)
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

ALSA OXFW driver uses AV/C Audio Subunit commands to control some models.
The commands get/set the state of Feature function block of the subunit.
The commands are not specific to OXFW, thus there's a possibility to use
them in the other drivers.

Currently, helper functions for the commands require 'struct snd_oxfw',
although, it's necessarily required. It's better to change prototype of
the functions without the structure for future use.

This commit changes the prototype.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-spkr.c | 54 +++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-spkr.c b/sound/firewire/oxfw/oxfw-spkr.c
index fde6b76..d733a15 100644
--- a/sound/firewire/oxfw/oxfw-spkr.c
+++ b/sound/firewire/oxfw/oxfw-spkr.c
@@ -14,8 +14,8 @@ enum control_attribute {
 	CTL_CURRENT	= 0x10,
 };
 
-static int spkr_mute_command(struct snd_oxfw *oxfw, bool *value,
-			     enum control_action action)
+static int avc_audio_feature_mute(struct fw_unit *unit, u8 fb_id, bool *value,
+				  enum control_action action)
 {
 	u8 *buf;
 	u8 response_ok;
@@ -35,7 +35,7 @@ static int spkr_mute_command(struct snd_oxfw *oxfw, bool *value,
 	buf[1] = 0x08;			/* audio unit 0 */
 	buf[2] = 0xb8;			/* FUNCTION BLOCK */
 	buf[3] = 0x81;			/* function block type: feature */
-	buf[4] = oxfw->device_info->mute_fb_id; /* function block ID */
+	buf[4] = fb_id;			/* function block ID */
 	buf[5] = 0x10;			/* control attribute: current */
 	buf[6] = 0x02;			/* selector length */
 	buf[7] = 0x00;			/* audio channel number */
@@ -46,16 +46,16 @@ static int spkr_mute_command(struct snd_oxfw *oxfw, bool *value,
 	else
 		buf[10] = *value ? 0x70 : 0x60;
 
-	err = fcp_avc_transaction(oxfw->unit, buf, 11, buf, 11, 0x3fe);
+	err = fcp_avc_transaction(unit, buf, 11, buf, 11, 0x3fe);
 	if (err < 0)
 		goto error;
 	if (err < 11) {
-		dev_err(&oxfw->unit->device, "short FCP response\n");
+		dev_err(&unit->device, "short FCP response\n");
 		err = -EIO;
 		goto error;
 	}
 	if (buf[0] != response_ok) {
-		dev_err(&oxfw->unit->device, "mute command failed\n");
+		dev_err(&unit->device, "mute command failed\n");
 		err = -EIO;
 		goto error;
 	}
@@ -70,10 +70,10 @@ error:
 	return err;
 }
 
-static int spkr_volume_command(struct snd_oxfw *oxfw, s16 *value,
-			       unsigned int channel,
-			       enum control_attribute attribute,
-			       enum control_action action)
+static int avc_audio_feature_volume(struct fw_unit *unit, u8 fb_id, s16 *value,
+				    unsigned int channel,
+				    enum control_attribute attribute,
+				    enum control_action action)
 {
 	u8 *buf;
 	u8 response_ok;
@@ -93,7 +93,7 @@ static int spkr_volume_command(struct snd_oxfw *oxfw, s16 *value,
 	buf[1] = 0x08;			/* audio unit 0 */
 	buf[2] = 0xb8;			/* FUNCTION BLOCK */
 	buf[3] = 0x81;			/* function block type: feature */
-	buf[4] = oxfw->device_info->volume_fb_id; /* function block ID */
+	buf[4] = fb_id;			/* function block ID */
 	buf[5] = attribute;		/* control attribute */
 	buf[6] = 0x02;			/* selector length */
 	buf[7] = channel;		/* audio channel number */
@@ -107,16 +107,16 @@ static int spkr_volume_command(struct snd_oxfw *oxfw, s16 *value,
 		buf[11] = *value;
 	}
 
-	err = fcp_avc_transaction(oxfw->unit, buf, 12, buf, 12, 0x3fe);
+	err = fcp_avc_transaction(unit, buf, 12, buf, 12, 0x3fe);
 	if (err < 0)
 		goto error;
 	if (err < 12) {
-		dev_err(&oxfw->unit->device, "short FCP response\n");
+		dev_err(&unit->device, "short FCP response\n");
 		err = -EIO;
 		goto error;
 	}
 	if (buf[0] != response_ok) {
-		dev_err(&oxfw->unit->device, "volume command failed\n");
+		dev_err(&unit->device, "volume command failed\n");
 		err = -EIO;
 		goto error;
 	}
@@ -153,7 +153,8 @@ static int spkr_mute_put(struct snd_kcontrol *control,
 	if (mute == oxfw->mute)
 		return 0;
 
-	err = spkr_mute_command(oxfw, &mute, CTL_WRITE);
+	err = avc_audio_feature_mute(oxfw->unit, oxfw->device_info->mute_fb_id,
+				     &mute, CTL_WRITE);
 	if (err < 0)
 		return err;
 	oxfw->mute = mute;
@@ -218,8 +219,10 @@ static int spkr_volume_put(struct snd_kcontrol *control,
 	for (i = 0; i <= oxfw->device_info->mixer_channels; ++i) {
 		volume = value->value.integer.value[channel_map[i ? i - 1 : 0]];
 		if (changed_channels & (1 << i)) {
-			err = spkr_volume_command(oxfw, &volume, i,
-						   CTL_CURRENT, CTL_WRITE);
+			err = avc_audio_feature_volume(oxfw->unit,
+						  oxfw->device_info->mute_fb_id,
+						  &volume,
+						  i, CTL_CURRENT, CTL_WRITE);
 			if (err < 0)
 				return err;
 		}
@@ -251,22 +254,27 @@ int snd_oxfw_add_spkr(struct snd_oxfw *oxfw)
 	unsigned int i, first_ch;
 	int err;
 
-	err = spkr_volume_command(oxfw, &oxfw->volume_min,
-				   0, CTL_MIN, CTL_READ);
+	err = avc_audio_feature_volume(oxfw->unit,
+				       oxfw->device_info->volume_fb_id,
+				       &oxfw->volume_min, 0, CTL_MIN, CTL_READ);
 	if (err < 0)
 		return err;
-	err = spkr_volume_command(oxfw, &oxfw->volume_max,
-				   0, CTL_MAX, CTL_READ);
+	err = avc_audio_feature_volume(oxfw->unit,
+				       oxfw->device_info->volume_fb_id,
+				       &oxfw->volume_max, 0, CTL_MAX, CTL_READ);
 	if (err < 0)
 		return err;
 
-	err = spkr_mute_command(oxfw, &oxfw->mute, CTL_READ);
+	err = avc_audio_feature_mute(oxfw->unit, oxfw->device_info->mute_fb_id,
+				     &oxfw->mute, CTL_READ);
 	if (err < 0)
 		return err;
 
 	first_ch = oxfw->device_info->mixer_channels == 1 ? 0 : 1;
 	for (i = 0; i < oxfw->device_info->mixer_channels; ++i) {
-		err = spkr_volume_command(oxfw, &oxfw->volume[i],
+		err = avc_audio_feature_volume(oxfw->unit,
+					  oxfw->device_info->volume_fb_id,
+					  &oxfw->volume[i],
 					  first_ch + i, CTL_CURRENT, CTL_READ);
 		if (err < 0)
 			return err;
-- 
2.5.0
