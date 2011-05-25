From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 5/5] ALSA: usb-audio: more control quirks for
	M-Audio FastTrack devices
Date: Wed, 25 May 2011 09:09:03 +0200
Message-ID: <1306307343-3247-6-git-send-email-zonque@gmail.com>
References: <1306307343-3247-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 948DF103867
	for <alsa-devel@alsa-project.org>;
	Wed, 25 May 2011 09:09:34 +0200 (CEST)
In-Reply-To: <1306307343-3247-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, gdiffey@gmail.com, clemens@ladisch.de, linuxaudio@showlabor.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make use of the freshly introduced methods to re-use standard mixer
handling and add some controls that are hidden but implemented in a
standard conform way on M-Audio's FastTrack devices.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Original-code-by: Felix Homann <linuxaudio@showlabor.de>
---
 sound/usb/mixer_quirks.c |   70 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/usb/quirks-table.h |    4 +-
 2 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 9146cff..3d0f487 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -40,6 +40,8 @@
 #include "mixer_quirks.h"
 #include "helper.h"
 
+extern struct snd_kcontrol_new *snd_usb_feature_unit_ctl;
+
 /*
  * Sound Blaster remote control configuration
  *
@@ -492,6 +494,69 @@ static int snd_nativeinstruments_create_mixer(struct usb_mixer_interface *mixer,
 	return err;
 }
 
+/* M-Audio FastTrack Ultra quirks */
+
+/* private_free callback */
+static void usb_mixer_elem_free(struct snd_kcontrol *kctl)
+{
+	kfree(kctl->private_data);
+	kctl->private_data = NULL;
+}
+
+static int snd_maudio_ftu_create_ctl(struct usb_mixer_interface *mixer,
+				     int in, int out, const char *name)
+{
+	struct usb_mixer_elem_info *cval;
+	struct snd_kcontrol *kctl;
+
+	cval = kzalloc(sizeof(*cval), GFP_KERNEL);
+	if (!cval)
+		return -ENOMEM;
+
+	cval->id = 5;
+	cval->mixer = mixer;
+	cval->val_type = USB_MIXER_S16;
+	cval->channels = 1;
+	cval->control = out + 1;
+	cval->cmask = 1 << in;
+
+	kctl = snd_ctl_new1(snd_usb_feature_unit_ctl, cval);
+	if (!kctl) {
+		kfree(cval);
+		return -ENOMEM;
+	}
+
+	snprintf(kctl->id.name, sizeof(kctl->id.name), name);
+	kctl->private_free = usb_mixer_elem_free;
+	return snd_usb_mixer_add_control(mixer, kctl);
+}
+
+static int snd_maudio_ftu_create_mixer(struct usb_mixer_interface *mixer)
+{
+	char name[64];
+	int in, out, err;
+
+	for (out = 0; out < 8; out++) {
+		for (in = 0; in < 8; in++) {
+			snprintf(name, sizeof(name),
+				 "AIn%d - Out%d Capture Volume", in  + 1, out + 1);
+			err = snd_maudio_ftu_create_ctl(mixer, in, out, name);
+			if (err < 0)
+				return err;
+		}
+
+		for (in = 8; in < 16; in++) {
+			snprintf(name, sizeof(name),
+				 "DIn%d - Out%d Playback Volume", in - 7, out + 1);
+			err = snd_maudio_ftu_create_ctl(mixer, in, out, name);
+			if (err < 0)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
 void snd_emuusb_set_samplerate(struct snd_usb_audio *chip,
 			       unsigned char samplerate_id)
 {
@@ -533,6 +598,11 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 					      snd_audigy2nx_proc_read);
 		break;
 
+	case USB_ID(0x0763, 0x2080): /* M-Audio Fast Track Ultra */
+	case USB_ID(0x0763, 0x2081): /* M-Audio Fast Track Ultra 8R */
+		err = snd_maudio_ftu_create_mixer(mixer);
+		break;
+
 	case USB_ID(0x0b05, 0x1739):
 	case USB_ID(0x0b05, 0x1743):
 		err = snd_xonar_u1_controls_create(mixer);
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 78792a8..0b2ae8e 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -1988,7 +1988,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		.data = & (const struct snd_usb_audio_quirk[]) {
 			{
 				.ifnum = 0,
-				.type = QUIRK_IGNORE_INTERFACE
+				.type = QUIRK_AUDIO_STANDARD_MIXER,
 			},
 			{
 				.ifnum = 1,
@@ -2055,7 +2055,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		.data = & (const struct snd_usb_audio_quirk[]) {
 			{
 				.ifnum = 0,
-				.type = QUIRK_IGNORE_INTERFACE
+				.type = QUIRK_AUDIO_STANDARD_MIXER,
 			},
 			{
 				.ifnum = 1,
-- 
1.7.5.1
