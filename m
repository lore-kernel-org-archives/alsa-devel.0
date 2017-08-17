From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: usb-audio: Add mute TLV for playback
	volumes on C-Media devices
Date: Thu, 17 Aug 2017 16:14:11 +0200
Message-ID: <20170817141411.28239-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 98DD8266998
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 16:14:13 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 08D72AD8E
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 14:14:13 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

C-Media devices (at least some models) mute the playback stream when
volumes are set to the minimum value.  But this isn't informed via TLV
and the user-space, typically PulseAudio, gets confused as if it's
still played in a low volume.

This patch adds the new flag, min_mute, to struct usb_mixer_elem_info
for indicating that the mixer element is with the minimum-mute volume.
This flag is set for known C-Media devices in
snd_usb_mixer_fu_apply_quirk() in turn.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=196669
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.c        | 2 ++
 sound/usb/mixer.h        | 1 +
 sound/usb/mixer_quirks.c | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 082736c539bc..e630813c5008 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -542,6 +542,8 @@ int snd_usb_mixer_vol_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 
 	if (size < sizeof(scale))
 		return -ENOMEM;
+	if (cval->min_mute)
+		scale[0] = SNDRV_CTL_TLVT_DB_MINMAX_MUTE;
 	scale[2] = cval->dBmin;
 	scale[3] = cval->dBmax;
 	if (copy_to_user(_tlv, scale, sizeof(scale)))
diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index 3417ef347e40..2b4b067646ab 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -64,6 +64,7 @@ struct usb_mixer_elem_info {
 	int cached;
 	int cache_val[MAX_CHANNELS];
 	u8 initialized;
+	u8 min_mute;
 	void *private_data;
 };
 
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index e3d1dec48ee4..e1e7ce9ab217 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -1878,6 +1878,12 @@ void snd_usb_mixer_fu_apply_quirk(struct usb_mixer_interface *mixer,
 		if (unitid == 7 && cval->control == UAC_FU_VOLUME)
 			snd_dragonfly_quirk_db_scale(mixer, cval, kctl);
 		break;
+	/* lowest playback value is muted on C-Media devices */
+	case USB_ID(0x0d8c, 0x000c):
+	case USB_ID(0x0d8c, 0x0014):
+		if (strstr(kctl->id.name, "Playback"))
+			cval->min_mute = 1;
+		break;
 	}
 }
 
-- 
2.14.1
