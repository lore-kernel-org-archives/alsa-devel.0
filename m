From: Felix Homann <linuxaudio@showlabor.de>
Subject: [PATCH 7/7] M-Audio Fast Track Ultra: Add effect
	controls
Date: Mon, 23 Apr 2012 16:37:37 +0200
Message-ID: <1335191857-6725-8-git-send-email-linuxaudio@showlabor.de>
References: <1335191857-6725-1-git-send-email-linuxaudio@showlabor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1335191857-6725-1-git-send-email-linuxaudio@showlabor.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Felix Homann <linuxaudio@showlabor.de>, mark@pogo.org.uk
List-Id: alsa-devel@alsa-project.org

This adds the remaining controls for effects on the FTU devices.
Some of these controls need volume quirks. They are added to
mixer.c.

Signed-off-by: Felix Homann <linuxaudio@showlabor.de>

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index bb56f53..195b6d2 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -770,6 +770,24 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 				  struct snd_kcontrol *kctl)
 {
 	switch (cval->mixer->chip->usb_id) {
+	case USB_ID(0x0763, 0x2081): /* M-Audio Fast Track Ultra 8R */
+	case USB_ID(0x0763, 0x2080): /* M-Audio Fast Track Ultra */
+		if ((strcmp(kctl->id.name, "Effect Duration") == 0)) {
+			snd_printk(KERN_INFO
+				"usb-audio: set quirk for FTU Effect Duration\n");
+			cval->min = 0x0000;
+			cval->max = 0x7f00;
+			cval->res = 0x0100;
+			break;
+		}
+		if (strcmp(kctl->id.name, "Effect Volume") == 0 ||
+			strcmp(kctl->id.name, "Effect Feedback Volume") == 0) {
+			snd_printk(KERN_INFO
+				"usb-audio: set quirks for FTU Effect Feedback/Volume\n");
+			cval->min = 0x00;
+			cval->max = 0x7f;
+			break;
+		}
 	case USB_ID(0x0471, 0x0101):
 	case USB_ID(0x0471, 0x0104):
 	case USB_ID(0x0471, 0x0105):
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index f751137..4d8cc45 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -584,14 +584,14 @@ struct snd_ftu_eff_switch_priv_val {
 static int snd_ftu_eff_switch_info(struct snd_kcontrol *kcontrol,
 					struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[8] = {"Room 1",
-				 "Room 2",
-				 "Room 3",
-				 "Hall 1",
-				 "Hall 2",
-				 "Plate",
-				 "Delay",
-				 "Echo"
+	static const char *texts[8] = {"Room 1",
+				       "Room 2",
+				       "Room 3",
+				       "Hall 1",
+				       "Hall 2",
+				       "Plate",
+				       "Delay",
+				       "Echo"
 	};
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
@@ -614,6 +614,13 @@ static int snd_ftu_eff_switch_get(struct snd_kcontrol *kctl,
 	int err;
 	unsigned char value[2];
 
+	const int id = 6;
+	const int validx = 1;
+	const int val_len = 2;
+
+	value[0] = 0x00;
+	value[1] = 0x00;
+
 	pval = (struct snd_ftu_eff_switch_priv_val *)
 		kctl->private_value;
 
@@ -630,14 +637,6 @@ static int snd_ftu_eff_switch_get(struct snd_kcontrol *kctl,
 	if (snd_BUG_ON(!chip))
 		return -EINVAL;
 
-	const int id = 6;
-	const int validx = 1;
-	const int val_type = USB_MIXER_S16;
-
-	value[0] = 0x00;
-	value[1] = 0x00;
-
-	const int val_len = 2;
 
 	err = snd_usb_ctl_msg(chip->dev,
 			usb_rcvctrlpipe(chip->dev, 0), UAC_GET_CUR,
@@ -664,12 +663,13 @@ static int snd_ftu_eff_switch_put(struct snd_kcontrol *kctl,
 	int changed, cur_val, err, new_val;
 	unsigned char value[2];
 
-	changed = 0;
+
 	const int id = 6;
 	const int validx = 1;
-	const int val_type = USB_MIXER_S16;
 	const int val_len = 2;
 
+	changed = 0;
+
 	pval = (struct snd_ftu_eff_switch_priv_val *)
 		kctl->private_value;
 	cur_val = pval->cached_value;
@@ -795,6 +795,102 @@ static int snd_ftu_create_volume_ctls(struct usb_mixer_interface *mixer)
 	return 0;
 }
 
+/* This control needs a volume quirk, see mixer.c */
+static int snd_ftu_create_effect_volume_ctl(struct usb_mixer_interface *mixer)
+{
+	static const char name[] = "Effect Volume";
+	const unsigned int id = 6;
+	const int val_type = USB_MIXER_U8;
+	const unsigned int control = 2;
+	const unsigned int cmask = 0;
+
+	return snd_create_std_mono_ctl(mixer, id, control, cmask, val_type,
+					name, snd_usb_mixer_vol_tlv);
+}
+
+/* This control needs a volume quirk, see mixer.c */
+static int snd_ftu_create_effect_duration_ctl(struct usb_mixer_interface *mixer)
+{
+	static const char name[] = "Effect Duration";
+	const unsigned int id = 6;
+	const int val_type = USB_MIXER_S16;
+	const unsigned int control = 3;
+	const unsigned int cmask = 0;
+
+	return snd_create_std_mono_ctl(mixer, id, control, cmask, val_type,
+					name, snd_usb_mixer_vol_tlv);
+}
+
+/* This control needs a volume quirk, see mixer.c */
+static int snd_ftu_create_effect_feedback_ctl(struct usb_mixer_interface *mixer)
+{
+	static const char name[] = "Effect Feedback Volume";
+	const unsigned int id = 6;
+	const int val_type = USB_MIXER_U8;
+	const unsigned int control = 4;
+	const unsigned int cmask = 0;
+
+	return snd_create_std_mono_ctl(mixer, id, control, cmask, val_type,
+					name, NULL);
+}
+
+static int snd_ftu_create_effect_return_ctls(struct usb_mixer_interface *mixer)
+{
+	unsigned int cmask;
+	int err, ch;
+	char name[48];
+
+	const unsigned int id = 7;
+	const int val_type = USB_MIXER_S16;
+	const unsigned int control = 7;
+
+	for (ch = 0; ch < 4; ++ch) {
+		cmask = 1 << ch;
+		snprintf(name, sizeof(name),
+			"Effect Return %d Volume", ch + 1);
+		err = snd_create_std_mono_ctl(mixer, id, control,
+						cmask, val_type, name,
+						snd_usb_mixer_vol_tlv);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+static int snd_ftu_create_effect_send_ctls(struct usb_mixer_interface *mixer)
+{
+	unsigned int  cmask;
+	int err, ch;
+	char name[48];
+
+	const unsigned int id = 5;
+	const int val_type = USB_MIXER_S16;
+	const unsigned int control = 9;
+
+	for (ch = 0; ch < 8; ++ch) {
+		cmask = 1 << ch;
+		snprintf(name, sizeof(name),
+			"Effect Send AIn%d Volume", ch + 1);
+		err = snd_create_std_mono_ctl(mixer, id, control, cmask,
+						val_type, name,
+						snd_usb_mixer_vol_tlv);
+		if (err < 0)
+			return err;
+	}
+	for (ch = 8; ch < 16; ++ch) {
+		cmask = 1 << ch;
+		snprintf(name, sizeof(name),
+			"Effect Send DIn%d Volume", ch - 7);
+		err = snd_create_std_mono_ctl(mixer, id, control, cmask,
+						val_type, name,
+						snd_usb_mixer_vol_tlv);
+		if (err < 0)
+			return err;
+	}
+	return 0;
+}
+
 static int snd_ftu_create_mixer(struct usb_mixer_interface *mixer)
 {
 	int err;
@@ -806,6 +902,25 @@ static int snd_ftu_create_mixer(struct usb_mixer_interface *mixer)
 	err = snd_ftu_create_effect_switch(mixer);
 	if (err < 0)
 		return err;
+	err = snd_ftu_create_effect_volume_ctl(mixer);
+	if (err < 0)
+		return err;
+
+	err = snd_ftu_create_effect_duration_ctl(mixer);
+	if (err < 0)
+		return err;
+
+	err = snd_ftu_create_effect_feedback_ctl(mixer);
+	if (err < 0)
+		return err;
+
+	err = snd_ftu_create_effect_return_ctls(mixer);
+	if (err < 0)
+		return err;
+
+	err = snd_ftu_create_effect_send_ctls(mixer);
+	if (err < 0)
+		return err;
 
 	return 0;
 }
-- 
1.7.5.4
