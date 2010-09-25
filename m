From: linuxaudio@showlabor.de
Subject: [PATCH - Add mixer support for M-Audio FTU series
	1/1]Add basic mixer support for M-Audio FTU (8R)
Date: Sat, 25 Sep 2010 08:36:44 +0200
Message-ID: <1285396604-28129-2-git-send-email-linuxaudio@showlabor.de>
References: <1285396604-28129-1-git-send-email-linuxaudio@showlabor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1285396604-28129-1-git-send-email-linuxaudio@showlabor.de>
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
Cc: alsa-devel@alsa-project.org, Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

From: Felix Homann <linuxaudio@showlabor.de>


Signed-off-by: Felix Homann <linuxaudio@showlabor.de>

diff --git a/usb/card.c b/usb/card.c
index 800f7cb..28efd7b 100644
--- a/usb/card.c
+++ b/usb/card.c
@@ -489,6 +489,11 @@ static void *snd_usb_audio_probe(struct usb_device *dev,
 	if (!chip->ctrl_intf)
 		chip->ctrl_intf = alts;
 
+	/* try to create a mixer for quirked devices, too */
+	if (snd_usb_create_mixer(chip, ifnum, ignore_ctl_error) < 0) {
+		goto __error;
+	}
+
 	if (err > 0) {
 		/* create normal USB audio interfaces */
 		if (snd_usb_create_streams(chip, ifnum) < 0 ||
diff --git a/usb/mixer.c b/usb/mixer.c
index 3ed3901..edb9893 100644
--- a/usb/mixer.c
+++ b/usb/mixer.c
@@ -85,16 +85,6 @@ struct mixer_build {
 	const struct usbmix_selector_map *selector_map;
 };
 
-enum {
-	USB_MIXER_BOOLEAN,
-	USB_MIXER_INV_BOOLEAN,
-	USB_MIXER_S8,
-	USB_MIXER_U8,
-	USB_MIXER_S16,
-	USB_MIXER_U16,
-};
-
-
 /*E-mu 0202(0404) eXtension Unit(XU) control*/
 enum {
 	USB_XU_CLOCK_RATE 		= 0xe301,
@@ -2149,6 +2139,71 @@ static int snd_usb_mixer_status_create(struct usb_mixer_interface *mixer)
 	return 0;
 }
 
+/* This is just the same as 'add_control_to_empty' but using a mixer instead of a mixer_build */
+int add_unique_control_to_empty_mixer(struct usb_mixer_interface *mixer, struct snd_kcontrol *kctl)
+{
+	struct usb_mixer_elem_info *cval = kctl->private_data;
+	int err;
+
+	/* No duplicates! */
+	if (snd_ctl_find_id(mixer->chip->card, &kctl->id))
+		return 0;
+
+	if ((err = snd_ctl_add(mixer->chip->card, kctl)) < 0) {
+		snd_printd(KERN_ERR "cannot add control (err = %d)\n", err);
+		return err;
+	}
+
+	cval->elem_id = &kctl->id;
+	cval->next_id_elem = mixer->id_elems[cval->id];
+	mixer->id_elems[cval->id] = cval;
+
+	return 0;
+}
+
+int build_named_mixer_unit_ctl(struct usb_mixer_interface *mixer,
+	int in_pin, int in_ch, int unitid, int val_type, unsigned int cmask, char *ctrl_name, int channels)
+{
+	struct usb_mixer_elem_info *cval;
+	struct snd_kcontrol *kctl;
+	int err;
+
+	cval = kzalloc(sizeof(*cval), GFP_KERNEL);
+	if (!cval)
+		return -1;
+
+	cval->mixer = mixer;
+	cval->id = unitid;
+	cval->control = in_ch + 1; /* based on 1 */
+	cval->val_type = val_type; /* like USB_MIXER_S16 etc. */
+	if (!((0 < channels) && (channels <= MAX_CHANNELS)))
+		return -1;
+	cval->channels = 1;
+	cval->cmask = cmask;
+	/* get min/max values */
+	get_min_max(cval, 0);
+
+	kctl = snd_ctl_new1(&usb_feature_unit_ctl, cval);
+	if (!kctl) {
+		snd_printk(KERN_ERR "cannot malloc kcontrol\n");
+		kfree(cval);
+		return -1;
+	}
+
+	kctl->tlv.c = mixer_vol_tlv;
+	kctl->vd[0].access |=
+		SNDRV_CTL_ELEM_ACCESS_TLV_READ |
+		SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
+	kctl->private_free = usb_mixer_elem_free;
+
+	sprintf(kctl->id.name, ctrl_name);
+
+	if (err = add_unique_control_to_empty_mixer(mixer, kctl))
+		return err;
+
+	return 0;
+}
+
 int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
 			 int ignore_error)
 {
diff --git a/usb/mixer.h b/usb/mixer.h
index 26c636c..f7378c5 100644
--- a/usb/mixer.h
+++ b/usb/mixer.h
@@ -24,7 +24,16 @@ struct usb_mixer_interface {
 	u8 xonar_u1_status;
 };
 
-#define MAX_CHANNELS	10	/* max logical channels */
+#define MAX_CHANNELS	16	/* max logical channels */
+
+enum {
+	USB_MIXER_BOOLEAN,
+	USB_MIXER_INV_BOOLEAN,
+	USB_MIXER_S8,
+	USB_MIXER_U8,
+	USB_MIXER_S16,
+	USB_MIXER_U16,
+};
 
 struct usb_mixer_elem_info {
 	struct usb_mixer_interface *mixer;
@@ -53,4 +62,7 @@ void snd_usb_mixer_notify_id(struct usb_mixer_interface *mixer, int unitid);
 int snd_usb_mixer_set_ctl_value(struct usb_mixer_elem_info *cval,
 				int request, int validx, int value_set);
 
+int build_named_mixer_unit_ctl(struct usb_mixer_interface *mixer,
+		int in_pin, int in_ch, int unitid, int val_type, unsigned int cmask,
+		char* ctrl_name, int channels);
 #endif /* __USBMIXER_H */
diff --git a/usb/mixer_quirks.c b/usb/mixer_quirks.c
index e7df1e5..7843451 100644
--- a/usb/mixer_quirks.c
+++ b/usb/mixer_quirks.c
@@ -354,6 +354,32 @@ void snd_emuusb_set_samplerate(struct snd_usb_audio *chip,
 	}
 }
 
+int snd_ftu_controls_create(struct usb_mixer_interface *mixer)
+{
+	char name[44];
+	int out, in_ch, unitid, err;
+	unsigned int cmask;
+	int val_type =  USB_MIXER_S16;
+	int channels = 1;
+	unitid = 5; // FTU's unit id
+
+	for (out = 0; out < 8; ++out) {
+		for (in_ch = 0; in_ch < 16; ++in_ch) {
+				cmask = (1 << in_ch);
+			if (in_ch < 8)
+				sprintf(name, "AIn%d - Out%d Capture Volume", in_ch + 1, out + 1);
+			else if (in_ch >= 8)
+				sprintf(name, "DIn%d - Out%d Playback Volume", in_ch - 7, out + 1);     
+			if ((err = build_named_mixer_unit_ctl(mixer, in_ch, out, unitid, 
+				val_type, cmask, name, channels))) {
+				return err;
+			}
+		}
+	}
+
+	return 0;
+}
+
 int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 {
 	int err;
@@ -379,6 +405,14 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 			return err;
 	}
 
+	/* M-Audio Fast Track Ultra (8R) */
+	if (mixer->chip->usb_id == USB_ID(0x0763, 0x2080) ||
+	    mixer->chip->usb_id == USB_ID(0x0763, 0x2081)) {
+		err = snd_ftu_controls_create(mixer);
+		if (err < 0)
+			return err;
+	}
+
 	return 0;
 }
 
diff --git a/usb/usbmixer.h b/usb/usbmixer.h
index 63101ae..0ddbeab 100644
--- a/usb/usbmixer.h
+++ b/usb/usbmixer.h
@@ -22,7 +22,7 @@ struct usb_mixer_interface {
 	u8 xonar_u1_status;
 };
 
-#define MAX_CHANNELS	10	/* max logical channels */
+#define MAX_CHANNELS	16	/* max logical channels */
 
 struct usb_mixer_elem_info {
 	struct usb_mixer_interface *mixer;
-- 
1.7.1
