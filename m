From: Felix Homann <linuxaudio@showlabor.de>
Subject: [PATCH 5/5] M-Audio Fast Track Ultra: Add effect
	controls
Date: Mon, 23 Apr 2012 20:24:27 +0200
Message-ID: <1335205467-12650-6-git-send-email-linuxaudio@showlabor.de>
References: <1335205467-12650-1-git-send-email-linuxaudio@showlabor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1335205467-12650-1-git-send-email-linuxaudio@showlabor.de>
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

This adds controls for the effects section on the FTU devices.
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
index 534e81e..21f2519 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -574,6 +574,186 @@ static int snd_nativeinstruments_create_mixer(struct usb_mixer_interface *mixer,
 }
 
 /* M-Audio FastTrack Ultra quirks */
+/* FTU Effect switch */
+struct snd_ftu_eff_switch_priv_val {
+	struct usb_mixer_interface *mixer;
+	int cached_value;
+	int is_cached;
+};
+
+static int snd_ftu_eff_switch_info(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_info *uinfo)
+{
+	static const char *texts[8] = {"Room 1",
+				       "Room 2",
+				       "Room 3",
+				       "Hall 1",
+				       "Hall 2",
+				       "Plate",
+				       "Delay",
+				       "Echo"
+	};
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 8;
+	if (uinfo->value.enumerated.item > 7)
+		uinfo->value.enumerated.item = 7;
+	strcpy(uinfo->value.enumerated.name,
+		texts[uinfo->value.enumerated.item]);
+
+	return 0;
+}
+
+static int snd_ftu_eff_switch_get(struct snd_kcontrol *kctl,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_audio *chip;
+	struct usb_mixer_interface *mixer;
+	struct snd_ftu_eff_switch_priv_val *pval;
+	int err;
+	unsigned char value[2];
+
+	const int id = 6;
+	const int validx = 1;
+	const int val_len = 2;
+
+	value[0] = 0x00;
+	value[1] = 0x00;
+
+	pval = (struct snd_ftu_eff_switch_priv_val *)
+		kctl->private_value;
+
+	if (pval->is_cached) {
+		ucontrol->value.enumerated.item[0] = pval->cached_value;
+		return 0;
+	}
+
+	mixer = (struct usb_mixer_interface *) pval->mixer;
+	if (snd_BUG_ON(!mixer))
+		return -EINVAL;
+
+	chip = (struct snd_usb_audio *) mixer->chip;
+	if (snd_BUG_ON(!chip))
+		return -EINVAL;
+
+
+	err = snd_usb_ctl_msg(chip->dev,
+			usb_rcvctrlpipe(chip->dev, 0), UAC_GET_CUR,
+			USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
+			validx << 8, snd_usb_ctrl_intf(chip) | (id << 8),
+			value, val_len);
+	if (err < 0)
+		return err;
+
+	ucontrol->value.enumerated.item[0] = value[0];
+	pval->cached_value = value[0];
+	pval->is_cached = 1;
+
+	return 0;
+}
+
+static int snd_ftu_eff_switch_put(struct snd_kcontrol *kctl,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_audio *chip;
+	struct snd_ftu_eff_switch_priv_val *pval;
+
+	struct usb_mixer_interface *mixer;
+	int changed, cur_val, err, new_val;
+	unsigned char value[2];
+
+
+	const int id = 6;
+	const int validx = 1;
+	const int val_len = 2;
+
+	changed = 0;
+
+	pval = (struct snd_ftu_eff_switch_priv_val *)
+		kctl->private_value;
+	cur_val = pval->cached_value;
+	new_val = ucontrol->value.enumerated.item[0];
+
+	mixer = (struct usb_mixer_interface *) pval->mixer;
+	if (snd_BUG_ON(!mixer))
+		return -EINVAL;
+
+	chip = (struct snd_usb_audio *) mixer->chip;
+	if (snd_BUG_ON(!chip))
+		return -EINVAL;
+
+	if (!pval->is_cached) {
+		/* Read current value */
+		err = snd_usb_ctl_msg(chip->dev,
+				usb_rcvctrlpipe(chip->dev, 0), UAC_GET_CUR,
+				USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
+				validx << 8, snd_usb_ctrl_intf(chip) | (id << 8),
+				value, val_len);
+		if (err < 0)
+			return err;
+
+		cur_val = value[0];
+		pval->cached_value = cur_val;
+		pval->is_cached = 1;
+	}
+	/* update value if needed */
+	if (cur_val != new_val) {
+		value[0] = new_val;
+		value[1] = 0;
+		err = snd_usb_ctl_msg(chip->dev,
+				usb_sndctrlpipe(chip->dev, 0), UAC_SET_CUR,
+				USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
+				validx << 8, snd_usb_ctrl_intf(chip) | (id << 8),
+				value, val_len);
+		if (err < 0)
+			return err;
+
+		pval->cached_value = new_val;
+		pval->is_cached = 1;
+		changed = 1;
+	}
+
+	return changed;
+}
+
+static int snd_ftu_create_effect_switch(struct usb_mixer_interface *mixer)
+{
+	static struct snd_kcontrol_new template = {
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Effect Program Switch",
+		.index = 0,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_ftu_eff_switch_info,
+		.get = snd_ftu_eff_switch_get,
+		.put = snd_ftu_eff_switch_put
+	};
+
+	int err;
+	struct snd_kcontrol *kctl;
+	struct snd_ftu_eff_switch_priv_val *pval;
+
+	pval = kzalloc(sizeof(*pval), GFP_KERNEL);
+	if (!pval)
+		return -ENOMEM;
+
+	pval->cached_value = 0;
+	pval->is_cached = 0;
+	pval->mixer = mixer;
+
+	template.private_value = (unsigned long) pval;
+	kctl = snd_ctl_new1(&template, mixer->chip);
+	if (!kctl) {
+		kfree(pval);
+		return -ENOMEM;
+	}
+
+	err = snd_ctl_add(mixer->chip->card, kctl);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
 
 /* Create volume controls for FTU devices*/
 static int snd_ftu_create_volume_ctls(struct usb_mixer_interface *mixer)
@@ -614,6 +794,102 @@ static int snd_ftu_create_volume_ctls(struct usb_mixer_interface *mixer)
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
@@ -622,6 +898,29 @@ static int snd_ftu_create_mixer(struct usb_mixer_interface *mixer)
 	if (err < 0)
 		return err;
 
+	err = snd_ftu_create_effect_switch(mixer);
+	if (err < 0)
+		return err;
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
+
 	return 0;
 }
 
-- 
1.7.5.4
