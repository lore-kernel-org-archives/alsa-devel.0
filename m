From: Eldad Zack <eldad@fogrefinery.com>
Subject: [FT C400,
	RFC 6/6] usb-audio: add remaining C400 controls
Date: Sat,  3 Nov 2012 14:40:11 +0100
Message-ID: <1351950011-8915-7-git-send-email-eldad@fogrefinery.com>
References: <1351950011-8915-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 428572625C6
 for <alsa-devel@alsa-project.org>; Sat,  3 Nov 2012 14:40:48 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id e19so1459057bku.38
 for <alsa-devel@alsa-project.org>; Sat, 03 Nov 2012 06:40:48 -0700 (PDT)
In-Reply-To: <1351950011-8915-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Felix Homann <linuxaudio@showlabor.de>, Chris Cavey <chris-alsa@rauros.net>
Cc: Takashi Iwai <tiwai@suse.de>, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Add the remaining controls for the M-Audio Fast Track C400:
* Effect Type (reusing FTU controls)
* Effect Volume
* Effect Send/Return
* Effect Program
* Effect Feedback

(No signed-off-by since it follows the hack from the previous
patch)
---
 sound/usb/mixer_quirks.c |  130 +++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 128 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index f8ff7f6..7d35d78 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -1014,6 +1014,7 @@ void snd_emuusb_set_samplerate(struct snd_usb_audio *chip,
 }
 
 /* M-Audio Fast Track C400 */
+/* C400 volume controls, this control needs a volume quirk, see mixer.c */
 static int snd_c400_create_vol_ctls(struct usb_mixer_interface *mixer)
 {
 	char name[64];
@@ -1047,12 +1048,137 @@ static int snd_c400_create_vol_ctls(struct usb_mixer_interface *mixer)
 	return 0;
 }
 
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
+		cmask = chan; /* FIXME: abuse of cmask. Sorry about that. */
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
+	const int chan_id[6] = { 0x3c, 0x43, 0x3e, 0x45, 0x40, 0x47 };
+
+	for (chan = 0; chan < 6; chan++) {
+		snprintf(name, sizeof(name),
+			"Effect Return %d",
+			chan + 1);
+
+		cmask = chan_id[chan]; /* FIXME: abuse of cmask. Sorry about that. */
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
 static int snd_c400_create_mixer(struct usb_mixer_interface *mixer)
 {
-	int err = 0;
+	int err;
+
 	err = snd_c400_create_vol_ctls(mixer);
+	if (err < 0)
+		return err;
 
-	return err;
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
 }
 
 /*
-- 
1.7.8.6
