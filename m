From: Felix Homann <linuxaudio@showlabor.de>
Subject: A plea for help on mixer support for Fast Track Ultra
	(8R)
Date: Wed, 18 May 2011 17:19:57 +0200
Message-ID: <4DD3E39D.30100@showlabor.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000101040900080309070209"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203])
	by alsa0.perex.cz (Postfix) with ESMTP id C8A6D10383E
	for <alsa-devel@alsa-project.org>;
	Wed, 18 May 2011 17:20:01 +0200 (CEST)
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
Cc: Grant Diffey <gdiffey@gmail.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000101040900080309070209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I need some help again by someone who's more familiar with Alsa's inner 
working than I am. This might be you, Daniel ;-)

I've attached a patch series that would add support for the mixer in 
M-Audio's Fast Track Ultra (8R) devices.

BUT, it will break others!

It will break others in that mixer controls will show up multiple times. 
The reason for this seems to be my ambitiuos calling of 
snd_usb_create_mixer() for quirked devices in card.c. To circumvent the 
problem of a control showing up multiple times, I check for duplicates 
in add_unique_control_to_empty_mixer() and skip controls already present.

This doesn't work for devices which are not using 
add_unique_control_to_empty_mixer(), in other words *all* devices not 
using my messy patch...

So, probably the best thing would be to have some kind of entry in 
quirks-table.h to tell which device would need to be "mixerquirked" to 
prevent other devices to be disturbed. How can this be done?

I would highly appreciate anybody coming up with a proper solution.

Kind regards,

Felix


--------------000101040900080309070209
Content-Type: text/x-patch;
 name="0001-Raise-MAX_CHANNELS-to-16-as-needed-by-Fast-TRack-Ult.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Raise-MAX_CHANNELS-to-16-as-needed-by-Fast-TRack-Ult.pa";
 filename*1="tch"

>From d698eefa94673ab9869de2614338cd2e0998ab3a Mon Sep 17 00:00:00 2001
From: Felix Homann <fex@yerbouti>
Date: Wed, 18 May 2011 09:09:24 +0200
Subject: [PATCH - Basic mixer support for Fast Track Ultra 1/6]Raise MAX_CHANNELS to 16 as needed by Fast TRack Ultra (8R)


Signed-off-by: Felix Homann <linuxaudio@showlabor.de>

diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index b4a2c81..06d035f 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -24,7 +24,7 @@ struct usb_mixer_interface {
 	u8 xonar_u1_status;
 };
 
-#define MAX_CHANNELS	10	/* max logical channels */
+#define MAX_CHANNELS	16	/* max logical channels */
 
 struct usb_mixer_elem_info {
 	struct usb_mixer_interface *mixer;
-- 
1.7.4.1


--------------000101040900080309070209
Content-Type: text/x-patch;
 name="0002-Move-USB_MIXER_-enum-to-mixer.h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0002-Move-USB_MIXER_-enum-to-mixer.h.patch"

>From 1319e39fc58114f7d277966a845b09b47dbb3730 Mon Sep 17 00:00:00 2001
From: Felix Homann <linuxaudio@showlabor.de>
Date: Wed, 18 May 2011 09:17:44 +0200
Subject: [PATCH - Basic mixer support for Fast Track Ultra 2/6]Move USB_MIXER_ enum to mixer.h
 This facilitates using it in mixer_quirks.c


Signed-off-by: Felix Homann <linuxaudio@showlabor.de>

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 5e47757..ea95ce2 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -86,16 +86,6 @@ struct mixer_build {
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
 /*E-mu 0202/0404/0204 eXtension Unit(XU) control*/
 enum {
 	USB_XU_CLOCK_RATE 		= 0xe301,
diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index 06d035f..86af922 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -1,6 +1,15 @@
 #ifndef __USBMIXER_H
 #define __USBMIXER_H
 
+enum {
+	USB_MIXER_BOOLEAN,
+	USB_MIXER_INV_BOOLEAN,
+	USB_MIXER_S8,
+	USB_MIXER_U8,
+	USB_MIXER_S16,
+	USB_MIXER_U16,
+};
+
 struct usb_mixer_interface {
 	struct snd_usb_audio *chip;
 	struct list_head list;
-- 
1.7.4.1


--------------000101040900080309070209
Content-Type: text/x-patch;
 name="0003-Add-mixer-quirk-for-Fast-Track-Ultra-devices.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0003-Add-mixer-quirk-for-Fast-Track-Ultra-devices.patch"

>From 84a7175d0c05e5f9cf2a6d7c682ba6904686df64 Mon Sep 17 00:00:00 2001
From: Felix Homann <linuxaudio@showlabor.de>
Date: Wed, 18 May 2011 10:05:34 +0200
Subject: [PATCH - Basic mixer support for Fast Track Ultra 3/6]Add mixer quirk for Fast Track Ultra devices


Signed-off-by: Felix Homann <linuxaudio@showlabor.de>

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index ea95ce2..1c37792 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -542,6 +542,31 @@ static int add_control_to_empty(struct mixer_build *state, struct snd_kcontrol *
 	return 0;
 }
 
+/* 
+ * This is almost the same as 'add_control_to_empty' but using a mixer instead of a mixer_build
+ * it simplifies building a mixer for devices without proper descriptors,
+ * e.g. the Fast Track Ultra devices
+ */ 
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
 
 /*
  * get a terminal name string
@@ -1331,6 +1356,57 @@ static void build_mixer_unit_ctl(struct mixer_build *state,
 	add_control_to_empty(state, kctl);
 }
 
+/*
+ * build a mixer unit control and give it a name
+ *
+ * this is essentially identical to build_mixer_unit_ctl but doesn't
+ * rely on proper descriptors to get a name for a control.
+ * At least, useful for Fast Track Ultra devices.
+ */
+
+int build_named_mixer_unit_ctl(struct usb_mixer_interface *mixer,
+	int in_pin, int in_ch, int unitid, int val_type, unsigned int cmask, char* ctrl_name, int channels)
+{
+	struct usb_mixer_elem_info *cval;
+	struct snd_kcontrol *kctl;
+	int err;
+	
+	cval = kzalloc(sizeof(*cval), GFP_KERNEL);
+	if (! cval)
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
+	if (! kctl) {
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
 
 /*
  * parse a mixer unit
diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index 86af922..6fe7bea 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -61,6 +61,9 @@ void snd_usb_mixer_notify_id(struct usb_mixer_interface *mixer, int unitid);
 
 int snd_usb_mixer_set_ctl_value(struct usb_mixer_elem_info *cval,
 				int request, int validx, int value_set);
+int build_named_mixer_unit_ctl(struct usb_mixer_interface *mixer,
+		int in_pin, int in_ch, int unitid, int val_type, 
+		unsigned int cmask, char* ctrl_name, int channels);
 void snd_usb_mixer_inactivate(struct usb_mixer_interface *mixer);
 int snd_usb_mixer_activate(struct usb_mixer_interface *mixer);
 
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 73dcc82..e87f359 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -500,6 +500,36 @@ void snd_emuusb_set_samplerate(struct snd_usb_audio *chip,
 	}
 }
 
+/*
+ * Create mixer controls for Fast Track Ultra (8R)
+ */
+int snd_ftu_controls_create(struct usb_mixer_interface *mixer)
+{
+	char name[44];
+	int out, in_ch, unitid, err;
+	unsigned int cmask;
+	int val_type =  USB_MIXER_S16;
+	int channels = 1; /* mono channels */
+	
+	unitid = 5; // FTU's unit id
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
+
 int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 {
 	int err = 0;
@@ -537,6 +567,10 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 				snd_nativeinstruments_ta10_mixers,
 				ARRAY_SIZE(snd_nativeinstruments_ta10_mixers));
 		break;
+	case USB_ID(0x0763, 0x2080):/* M-Audio Fast Track Ultra */
+	case USB_ID(0x0763, 0x2081): /* M-Audio Fast Track Ultra 8R */
+		err = snd_ftu_controls_create(mixer);
+		break;
 	}
 
 	return err;
-- 
1.7.4.1


--------------000101040900080309070209
Content-Type: text/x-patch;
 name="0004-Try-to-create-a-mixer-for-quirked-devices-too.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0004-Try-to-create-a-mixer-for-quirked-devices-too.patch"

>From 67da1908c4dd0e10a24f65d321875fae3dae7a42 Mon Sep 17 00:00:00 2001
From: Felix Homann <linuxaudio@showlabor.de>
Date: Wed, 18 May 2011 10:40:22 +0200
Subject: [PATCH - Basic mixer support for Fast Track Ultra 5/6]Try to create a mixer for quirked devices, too


Signed-off-by: Felix Homann <linuxaudio@showlabor.de>

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 40722f8..52ad7b0 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -493,6 +493,11 @@ static void *snd_usb_audio_probe(struct usb_device *dev,
 	 */
 	if (!chip->ctrl_intf)
 		chip->ctrl_intf = alts;
+	
+	/* try to create a mixer for quirked devices, too */
+	if (snd_usb_create_mixer(chip, ifnum, ignore_ctl_error) < 0) {
+		goto __error;
+	}
 
 	if (err > 0) {
 		/* create normal USB audio interfaces */
-- 
1.7.4.1


--------------000101040900080309070209
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000101040900080309070209--
