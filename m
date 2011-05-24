From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: A plea for help on mixer support for Fast Track
 Ultra (8R)
Date: Tue, 24 May 2011 12:11:16 +0200
Message-ID: <4DDB8444.4010500@showlabor.de>
References: <4DD3E39D.30100@showlabor.de>	<BANLkTinCn2Q+asKhGAoq+3S+AtqyHrg2wg@mail.gmail.com>	<4DD413FC.2090808@showlabor.de>	<BANLkTi=2NeMGL6n7B0n-2p9La=45pM7ZHg@mail.gmail.com>	<s5hhb8r1c20.wl%tiwai@suse.de>
	<4DD4BC97.5090702@showlabor.de>	<s5h39kb17bv.wl%tiwai@suse.de>
	<4DD4D162.20608@showlabor.de>	<BANLkTi=6CHJyFxvk9eVA430uhiwJ7f86vA@mail.gmail.com>	<BANLkTi=OsrZKq3ZmC5cdFfuWb7qSOkPitw@mail.gmail.com>	<4DD51E38.7090406@showlabor.de>	<BANLkTiksJbpMr61QOfJ26iVhETDhSBDRFA@mail.gmail.com>	<4DD63E8F.2030306@showlabor.de>
	<4DD64D13.9070200@showlabor.de>	<BANLkTik-_m-Anr2s5=+G7ksyCHdOEGfN2w@mail.gmail.com>
	<BANLkTik9LLnvZRXE=8LW2UOrOOVCjp+kDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000604010901030608060202"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203])
	by alsa0.perex.cz (Postfix) with ESMTP id ADDB1103850
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 12:11:19 +0200 (CEST)
In-Reply-To: <BANLkTik9LLnvZRXE=8LW2UOrOOVCjp+kDg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Diffey <gdiffey@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000604010901030608060202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi again,

Am 20.05.2011 17:08, schrieb Grant Diffey:
> I think there's something whacky with the control map. (I can't seem to send
> Ain5 to out 1 and 2 successfully. but I'll test this with felix's original
> code.

Grant, could you please try the attached patch. I haven't tested all 128 
controls but it seems to work fine here. And while you're at it, could 
you please try some other "outs" as well. My FTU is in a rack and I 
can't easily access out 5-8.


> The Ain's are not capture volumes for this device
> There's 8 "analog ins" and 8 "software returns" (pcm channels) that are
> mixed to 8 outputs. all the input gain controls are physical or line +4db
> level balanced

That's true. I abused the term "Capture Volume" for my purely personal 
interest, since it made navigating through the controls easier in 
alsamixer and alsamixer-qt4. So, Daniel and Takashi, please feel free to 
change the names  to whatever you think is more appropriate.

Kind regards,

Felix





--------------000604010901030608060202
Content-Type: text/x-patch;
 name="ftu-mixer-v4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ftu-mixer-v4.diff"

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 40722f8..4edf3bc 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -47,6 +47,7 @@
 #include <linux/usb/audio.h>
 #include <linux/usb/audio-v2.h>
 
+#include <sound/control.h>
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/pcm.h>
@@ -478,14 +479,6 @@ static void *snd_usb_audio_probe(struct usb_device *dev,
 		}
 	}
 
-	chip->txfr_quirk = 0;
-	err = 1; /* continue */
-	if (quirk && quirk->ifnum != QUIRK_NO_INTERFACE) {
-		/* need some special handlings */
-		if ((err = snd_usb_create_quirk(chip, intf, &usb_audio_driver, quirk)) < 0)
-			goto __error;
-	}
-
 	/*
 	 * For devices with more than one control interface, we assume the
 	 * first contains the audio controls. We might need a more specific
@@ -494,6 +487,14 @@ static void *snd_usb_audio_probe(struct usb_device *dev,
 	if (!chip->ctrl_intf)
 		chip->ctrl_intf = alts;
 
+	chip->txfr_quirk = 0;
+	err = 1; /* continue */
+	if (quirk && quirk->ifnum != QUIRK_NO_INTERFACE) {
+		/* need some special handlings */
+		if ((err = snd_usb_create_quirk(chip, intf, &usb_audio_driver, quirk)) < 0)
+			goto __error;
+	}
+
 	if (err > 0) {
 		/* create normal USB audio interfaces */
 		if (snd_usb_create_streams(chip, ifnum) < 0 ||
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 5e47757..fbcf02f 100644
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
@@ -535,20 +525,21 @@ static int check_matrix_bitmap(unsigned char *bmap, int ich, int och, int num_ou
  * if failed, give up and free the control instance.
  */
 
-static int add_control_to_empty(struct mixer_build *state, struct snd_kcontrol *kctl)
+int snd_usb_mixer_add_control(struct usb_mixer_interface *mixer,
+			      struct snd_kcontrol *kctl)
 {
 	struct usb_mixer_elem_info *cval = kctl->private_data;
 	int err;
 
-	while (snd_ctl_find_id(state->chip->card, &kctl->id))
+	while (snd_ctl_find_id(mixer->chip->card, &kctl->id))
 		kctl->id.index++;
-	if ((err = snd_ctl_add(state->chip->card, kctl)) < 0) {
+	if ((err = snd_ctl_add(mixer->chip->card, kctl)) < 0) {
 		snd_printd(KERN_ERR "cannot add control (err = %d)\n", err);
 		return err;
 	}
 	cval->elem_id = &kctl->id;
-	cval->next_id_elem = state->mixer->id_elems[cval->id];
-	state->mixer->id_elems[cval->id] = cval;
+	cval->next_id_elem = mixer->id_elems[cval->id];
+	mixer->id_elems[cval->id] = cval;
 	return 0;
 }
 
@@ -967,7 +958,7 @@ static int mixer_ctl_feature_put(struct snd_kcontrol *kcontrol, struct snd_ctl_e
 	return changed;
 }
 
-static struct snd_kcontrol_new usb_feature_unit_ctl = {
+struct snd_kcontrol_new usb_feature_unit_ctl = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "", /* will be filled later manually */
 	.info = mixer_ctl_feature_info,
@@ -984,6 +975,9 @@ static struct snd_kcontrol_new usb_feature_unit_ctl_ro = {
 	.put = NULL,
 };
 
+/* This symbol is exported in order to allow the mixer quirks to
+ * hook up to the standard feature unit control mechanism */
+struct snd_kcontrol_new *snd_usb_feature_unit_ctl = &usb_feature_unit_ctl;
 
 /*
  * build a feature control
@@ -1174,7 +1168,7 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
 
 	snd_printdd(KERN_INFO "[%d] FU [%s] ch = %d, val = %d/%d/%d\n",
 		    cval->id, kctl->id.name, cval->channels, cval->min, cval->max, cval->res);
-	add_control_to_empty(state, kctl);
+	snd_usb_mixer_add_control(state->mixer, kctl);
 }
 
 
@@ -1338,7 +1332,7 @@ static void build_mixer_unit_ctl(struct mixer_build *state,
 
 	snd_printdd(KERN_INFO "[%d] MU [%s] ch = %d, val = %d/%d\n",
 		    cval->id, kctl->id.name, cval->channels, cval->min, cval->max);
-	add_control_to_empty(state, kctl);
+	snd_usb_mixer_add_control(state->mixer, kctl);
 }
 
 
@@ -1639,7 +1633,7 @@ static int build_audio_procunit(struct mixer_build *state, int unitid, void *raw
 
 		snd_printdd(KERN_INFO "[%d] PU [%s] ch = %d, val = %d/%d\n",
 			    cval->id, kctl->id.name, cval->channels, cval->min, cval->max);
-		if ((err = add_control_to_empty(state, kctl)) < 0)
+		if ((err = snd_usb_mixer_add_control(state->mixer, kctl)) < 0)
 			return err;
 	}
 	return 0;
@@ -1856,7 +1850,7 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid, void
 
 	snd_printdd(KERN_INFO "[%d] SU [%s] items = %d\n",
 		    cval->id, kctl->id.name, desc->bNrInPins);
-	if ((err = add_control_to_empty(state, kctl)) < 0)
+	if ((err = snd_usb_mixer_add_control(state->mixer, kctl)) < 0)
 		return err;
 
 	return 0;
@@ -1933,7 +1927,7 @@ static int snd_usb_mixer_dev_free(struct snd_device *device)
  *
  * walk through all UAC_OUTPUT_TERMINAL descriptors to search for mixers
  */
-static int snd_usb_mixer_controls(struct usb_mixer_interface *mixer)
+int snd_usb_mixer_controls(struct usb_mixer_interface *mixer)
 {
 	struct mixer_build state;
 	int err;
diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index b4a2c81..ae1a14d 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
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
@@ -55,4 +64,7 @@ int snd_usb_mixer_set_ctl_value(struct usb_mixer_elem_info *cval,
 void snd_usb_mixer_inactivate(struct usb_mixer_interface *mixer);
 int snd_usb_mixer_activate(struct usb_mixer_interface *mixer);
 
+int snd_usb_mixer_add_control(struct usb_mixer_interface *mixer,
+			      struct snd_kcontrol *kctl);
+
 #endif /* __USBMIXER_H */
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 73dcc82..30143e5 100644
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
@@ -481,6 +483,69 @@ static int snd_nativeinstruments_create_mixer(struct usb_mixer_interface *mixer,
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
+	int out, in, err;
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
@@ -521,6 +586,11 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
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
index 196c753..f0ad7f1 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -1935,7 +1935,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		.data = & (const struct snd_usb_audio_quirk[]) {
 			{
 				.ifnum = 0,
-				.type = QUIRK_IGNORE_INTERFACE
+				.type = QUIRK_AUDIO_STANDARD_MIXER,
 			},
 			{
 				.ifnum = 1,
@@ -2002,7 +2002,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		.data = & (const struct snd_usb_audio_quirk[]) {
 			{
 				.ifnum = 0,
-				.type = QUIRK_IGNORE_INTERFACE
+				.type = QUIRK_AUDIO_STANDARD_MIXER,
 			},
 			{
 				.ifnum = 1,
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 355759b..193e499 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -19,6 +19,7 @@
 #include <linux/usb.h>
 #include <linux/usb/audio.h>
 
+#include <sound/control.h>
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/pcm.h>
@@ -58,6 +59,7 @@ static int create_composite_quirk(struct snd_usb_audio *chip,
 		if (quirk->ifnum != probed_ifnum)
 			usb_driver_claim_interface(driver, iface, (void *)-1L);
 	}
+
 	return 0;
 }
 
@@ -263,6 +265,20 @@ static int create_uaxx_quirk(struct snd_usb_audio *chip,
 }
 
 /*
+ * Create a standard mixer for the specified interface.
+ */
+static int create_standard_mixer_quirk(struct snd_usb_audio *chip,
+				       struct usb_interface *iface,
+				       struct usb_driver *driver,
+				       const struct snd_usb_audio_quirk *quirk)
+{
+	if (quirk->ifnum < 0)
+		return 0;
+
+	return snd_usb_create_mixer(chip, quirk->ifnum, 0);
+}
+
+/*
  * audio-interface quirks
  *
  * returns zero if no standard audio/MIDI parsing is needed.
@@ -294,7 +310,8 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 		[QUIRK_AUDIO_STANDARD_INTERFACE] = create_standard_audio_quirk,
 		[QUIRK_AUDIO_FIXED_ENDPOINT] = create_fixed_stream_quirk,
 		[QUIRK_AUDIO_EDIROL_UAXX] = create_uaxx_quirk,
-		[QUIRK_AUDIO_ALIGN_TRANSFER] = create_align_transfer_quirk
+		[QUIRK_AUDIO_ALIGN_TRANSFER] = create_align_transfer_quirk,
+		[QUIRK_AUDIO_STANDARD_MIXER] = create_standard_mixer_quirk,
 	};
 
 	if (quirk->type < QUIRK_TYPE_COUNT) {
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 32f2a97..1e79986 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -84,6 +84,7 @@ enum quirk_type {
 	QUIRK_AUDIO_FIXED_ENDPOINT,
 	QUIRK_AUDIO_EDIROL_UAXX,
 	QUIRK_AUDIO_ALIGN_TRANSFER,
+	QUIRK_AUDIO_STANDARD_MIXER,
 
 	QUIRK_TYPE_COUNT
 };

--------------000604010901030608060202
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000604010901030608060202--
