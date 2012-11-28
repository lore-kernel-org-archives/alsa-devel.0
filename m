From: Eldad Zack <eldad@fogrefinery.com>
Subject: [FT C400, PATCH RFC,
	v4 04/10] usb-audio: add control index offset
Date: Wed, 28 Nov 2012 23:55:35 +0100
Message-ID: <1354143341-1623-5-git-send-email-eldad@fogrefinery.com>
References: <1354143341-1623-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id C4A67264F03
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 23:55:57 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so5643893bkc.38
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 14:55:57 -0800 (PST)
In-Reply-To: <1354143341-1623-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Daniel Mack <zonque@gmail.com>, Felix Homann <linuxaudio@showlabor.de>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
Cc: Grant Diffey <gdiffey@gmail.com>, George Willian Condomitti <georgecondomitti@gmail.com>, Chris Cavey <chris-alsa@rauros.net>, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Currently, channel IDs exceeding 31 (0x1f) cannot be used.
The channel ID is derived from the cmask. Extending cmask
to a 64-bit type would only allow it to go up to 63 (0x3f).
Some devices have channel IDs exceeding that as well.
To address that, add an offset to the mixer element which
is then accounted for in the UAC set/get functions.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/mixer.c        |    4 ++++
 sound/usb/mixer.h        |    1 +
 sound/usb/mixer_quirks.c |   16 +++++++++++++++-
 3 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 298070e..b0fc6ae 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -382,6 +382,8 @@ error:
 
 static int get_ctl_value(struct usb_mixer_elem_info *cval, int request, int validx, int *value_ret)
 {
+	validx += cval->idx_off;
+
 	return (cval->mixer->protocol == UAC_VERSION_1) ?
 		get_ctl_value_v1(cval, request, validx, value_ret) :
 		get_ctl_value_v2(cval, request, validx, value_ret);
@@ -432,6 +434,8 @@ int snd_usb_mixer_set_ctl_value(struct usb_mixer_elem_info *cval,
 	unsigned char buf[2];
 	int idx = 0, val_len, err, timeout = 10;
 
+	validx += cval->idx_off;
+
 	if (cval->mixer->protocol == UAC_VERSION_1) {
 		val_len = cval->val_type >= USB_MIXER_S16 ? 2 : 1;
 	} else { /* UAC_VERSION_2 */
diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index a7f3d45..aab80df 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -43,6 +43,7 @@ struct usb_mixer_elem_info {
 	unsigned int id;
 	unsigned int control;	/* CS or ICN (high byte) */
 	unsigned int cmask; /* channel mask bitmap: 0 = master */
+	unsigned int idx_off; /* Control index offset */
 	unsigned int ch_readonly;
 	unsigned int master_readonly;
 	int channels;
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index ae2b714..4199b97 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -63,11 +63,12 @@ static void usb_mixer_elem_free(struct snd_kcontrol *kctl)
  * Since there doesn't seem to be a devices that needs a multichannel
  * version, we keep it mono for simplicity.
  */
-static int snd_create_std_mono_ctl(struct usb_mixer_interface *mixer,
+static int snd_create_std_mono_ctl_offset(struct usb_mixer_interface *mixer,
 				unsigned int unitid,
 				unsigned int control,
 				unsigned int cmask,
 				int val_type,
+				unsigned int idx_off,
 				const char *name,
 				snd_kcontrol_tlv_rw_t *tlv_callback)
 {
@@ -85,6 +86,7 @@ static int snd_create_std_mono_ctl(struct usb_mixer_interface *mixer,
 	cval->channels = 1;
 	cval->control = control;
 	cval->cmask = cmask;
+	cval->idx_off = idx_off;
 
 	/* get_min_max() is called only for integer volumes later,
 	 * so provide a short-cut for booleans */
@@ -120,6 +122,18 @@ static int snd_create_std_mono_ctl(struct usb_mixer_interface *mixer,
 	return 0;
 }
 
+static int snd_create_std_mono_ctl(struct usb_mixer_interface *mixer,
+				unsigned int unitid,
+				unsigned int control,
+				unsigned int cmask,
+				int val_type,
+				const char *name,
+				snd_kcontrol_tlv_rw_t *tlv_callback)
+{
+	return snd_create_std_mono_ctl_offset(mixer, unitid, control, cmask,
+		val_type, 0 /* Offset */, name, tlv_callback);
+}
+
 /*
  * Create a set of standard UAC controls from a table
  */
-- 
1.7.8.6
