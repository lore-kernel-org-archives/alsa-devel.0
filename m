From: Eldad Zack <eldad@fogrefinery.com>
Subject: [FT C400, PATCH RFC,
	v3 8/9] usb-audio: Fast Track C400 mixer controls
Date: Tue, 27 Nov 2012 17:00:57 +0100
Message-ID: <1354032058-668-9-git-send-email-eldad@fogrefinery.com>
References: <1354032058-668-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id C97BC265326
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2012 17:01:28 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so4944982bkc.38
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2012 08:01:28 -0800 (PST)
In-Reply-To: <1354032058-668-1-git-send-email-eldad@fogrefinery.com>
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

Add a mixer quirks for the M-Audio Fast Track C400
and create the following:

* Volume controls
* Effect Type (reusing FTU controls)
* Effect Volume
* Effect Send/Return
* Effect Program
* Effect Feedback

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/mixer_quirks.c |  176 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 176 insertions(+), 0 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index a614dab..05404e5 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -1027,6 +1027,178 @@ void snd_emuusb_set_samplerate(struct snd_usb_audio *chip,
 	}
 }
 
+/* M-Audio Fast Track C400 */
+/* C400 volume controls, this control needs a volume quirk, see mixer.c */
+static int snd_c400_create_vol_ctls(struct usb_mixer_interface *mixer)
+{
+	char name[64];
+	unsigned int cmask, offset;
+	int out, chan, err;
+
+	const unsigned int id = 0x40;
+	const int val_type = USB_MIXER_S16;
+	const int control = 1;
+
+	for (chan = 0; chan < 10; chan++) {
+		for (out = 0; out < 6; out++) {
+			if (chan < 6) {
+				snprintf(name, sizeof(name),
+					"PCM%d-Out%d Playback Volume",
+					chan + 1, out + 1);
+			} else {
+				snprintf(name, sizeof(name),
+					"In%d-Out%d Playback Volume",
+					chan - 5, out + 1);
+			}
+
+			cmask = (out == 0) ? 0 : 1 << (out - 1);
+			offset = chan * 6;
+			err = snd_create_std_mono_ctl_offset(mixer, id, control,
+						cmask, val_type, offset, name,
+						&snd_usb_mixer_vol_tlv);
+			if (err < 0)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
+/* This control needs a volume quirk, see mixer.c */
+static int snd_c400_create_effect_volume_ctl(struct usb_mixer_interface *mixer)
+{
+	static const char name[] = "Effect Volume";
+	const unsigned int id = 0x43;
+	const int val_type = USB_MIXER_U8;
+	const unsigned int control = 3;
+	const unsigned int cmask = 0;
+
+	return snd_create_std_mono_ctl(mixer, id, control, cmask, val_type,
+					name, snd_usb_mixer_vol_tlv);
+}
+
+/* This control needs a volume quirk, see mixer.c */
+static int snd_c400_create_effect_duration_ctl(struct usb_mixer_interface *mixer)
+{
+	static const char name[] = "Effect Duration";
+	const unsigned int id = 0x43;
+	const int val_type = USB_MIXER_S16;
+	const unsigned int control = 4;
+	const unsigned int cmask = 0;
+
+	return snd_create_std_mono_ctl(mixer, id, control, cmask, val_type,
+					name, snd_usb_mixer_vol_tlv);
+}
+
+/* This control needs a volume quirk, see mixer.c */
+static int snd_c400_create_effect_feedback_ctl(struct usb_mixer_interface *mixer)
+{
+	static const char name[] = "Effect Feedback Volume";
+	const unsigned int id = 0x43;
+	const int val_type = USB_MIXER_U8;
+	const unsigned int control = 5;
+	const unsigned int cmask = 0;
+
+	return snd_create_std_mono_ctl(mixer, id, control, cmask, val_type,
+					name, NULL);
+}
+
+static int snd_c400_create_effect_vol_ctls(struct usb_mixer_interface *mixer)
+{
+	char name[64];
+	unsigned int cmask;
+	int chan, err;
+
+	const unsigned int id = 0x42;
+	const int val_type = USB_MIXER_S16;
+	const int control = 1;
+
+	for (chan = 0; chan < 10; chan++) {
+		if (chan < 6) {
+			snprintf(name, sizeof(name),
+				"Effect Send DOut%d",
+				chan + 1);
+		} else {
+			snprintf(name, sizeof(name),
+				"Effect Send AIn%d",
+				chan - 5);
+		}
+
+		cmask = (chan == 0) ? 0 : 1 << (chan - 1);
+		err = snd_create_std_mono_ctl(mixer, id, control,
+						cmask, val_type, name,
+						&snd_usb_mixer_vol_tlv);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+static int snd_c400_create_effect_ret_vol_ctls(struct usb_mixer_interface *mixer)
+{
+	char name[64];
+	unsigned int cmask;
+	int chan, err;
+
+	const unsigned int id = 0x40;
+	const int val_type = USB_MIXER_S16;
+	const int control = 1;
+	const int chan_id[6] = { 0, 7, 2, 9, 4, 0xb };
+	const unsigned int offset = 0x3c;
+				/* { 0x3c, 0x43, 0x3e, 0x45, 0x40, 0x47 } */
+
+	for (chan = 0; chan < 6; chan++) {
+		snprintf(name, sizeof(name),
+			"Effect Return %d",
+			chan + 1);
+
+		cmask = (chan_id[chan] == 0) ? 0 : 1 << (chan_id[chan] - 1);
+		err = snd_create_std_mono_ctl_offset(mixer, id, control,
+						cmask, val_type, offset, name,
+						&snd_usb_mixer_vol_tlv);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+static int snd_c400_create_mixer(struct usb_mixer_interface *mixer)
+{
+	int err;
+
+	err = snd_c400_create_vol_ctls(mixer);
+	if (err < 0)
+		return err;
+
+	err = snd_c400_create_effect_vol_ctls(mixer);
+	if (err < 0)
+		return err;
+
+	err = snd_c400_create_effect_ret_vol_ctls(mixer);
+	if (err < 0)
+		return err;
+
+	err = snd_ftu_create_effect_switch(mixer, 2, 0x43);
+	if (err < 0)
+		return err;
+
+	err = snd_c400_create_effect_volume_ctl(mixer);
+	if (err < 0)
+		return err;
+
+	err = snd_c400_create_effect_duration_ctl(mixer);
+	if (err < 0)
+		return err;
+
+	err = snd_c400_create_effect_feedback_ctl(mixer);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
 /*
  * The mixer units for Ebox-44 are corrupt, and even where they
  * are valid they presents mono controls as L and R channels of
@@ -1129,6 +1301,10 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 		err = snd_ftu_create_mixer(mixer);
 		break;
 
+	case USB_ID(0x0763, 0x2030): /* M-Audio C400 */
+		err = snd_c400_create_mixer(mixer);
+		break;
+
 	case USB_ID(0x0b05, 0x1739):
 	case USB_ID(0x0b05, 0x1743):
 		err = snd_xonar_u1_controls_create(mixer);
-- 
1.7.8.6
