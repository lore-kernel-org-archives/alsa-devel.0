From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH 2/2] snd-usb-audio: Replace mixer for Electrix
	Ebox-44
Date: Sat, 14 Apr 2012 17:19:24 +0100
Message-ID: <1334420364-30700-2-git-send-email-mark@pogo.org.uk>
References: <1334420364-30700-1-git-send-email-mark@pogo.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wes.ijneb.com (mx.ij.cx [212.13.201.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D9DA246CB
	for <alsa-devel@alsa-project.org>;
	Sat, 14 Apr 2012 18:19:25 +0200 (CEST)
In-Reply-To: <1334420364-30700-1-git-send-email-mark@pogo.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The mixer units from the firmware are corrupt, and even where they
are valid they presents mono controls as L and R channels of
stereo.

Signed-off-by: Mark Hills <mark@pogo.org.uk>
---
 sound/usb/mixer_maps.c   |   13 +++++++++
 sound/usb/mixer_quirks.c |   67 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 0 deletions(-)

diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index f1324c4..41daaa2 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -288,6 +288,15 @@ static struct usbmix_name_map scratch_live_map[] = {
 	{ 0 } /* terminator */
 };
 
+static struct usbmix_name_map ebox44_map[] = {
+	{ 4, NULL }, /* FU */
+	{ 6, NULL }, /* MU */
+	{ 7, NULL }, /* FU */
+	{ 10, NULL }, /* FU */
+	{ 11, NULL }, /* MU */
+	{ 0 }
+};
+
 /* "Gamesurround Muse Pocket LT" looks same like "Sound Blaster MP3+"
  *  most importand difference is SU[8], it should be set to "Capture Source"
  *  to make alsamixer and PA working properly.
@@ -371,6 +380,10 @@ static struct usbmix_ctl_map usbmix_ctl_maps[] = {
 		.map = scratch_live_map,
 		.ignore_ctl_error = 1,
 	},
+	{
+		.id = USB_ID(0x200c, 0x1018),
+		.map = ebox44_map,
+	},
 	{ 0 } /* terminator */
 };
 
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index ab125ee..e2072ed 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -557,6 +557,69 @@ static int snd_maudio_ftu_create_mixer(struct usb_mixer_interface *mixer)
 	return 0;
 }
 
+static int snd_ebox44_create_ctl(struct usb_mixer_interface *mixer,
+				int unitid, int control, int cmask,
+				int val_type, const char *name)
+{
+	struct usb_mixer_elem_info *cval;
+	struct snd_kcontrol *kctl;
+
+	cval = kzalloc(sizeof(*cval), GFP_KERNEL);
+	if (!cval)
+		return -ENOMEM;
+
+	cval->id = unitid;
+	cval->mixer = mixer;
+
+	cval->val_type = val_type;
+	cval->channels = 1;
+	cval->control = control;
+	cval->cmask = cmask;
+
+	/* Volume controls will override these values */
+	cval->min = 0;
+	cval->max = 1;
+	cval->res = 0;
+
+	cval->dBmin = 0;
+	cval->dBmax = 0;
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
+/*
+ * Create mixer for Electrix Ebox-44
+ *
+ * The mixer units from this device are corrupt, and even where they
+ * are valid they presents mono controls as L and R channels of
+ * stereo. So we create a good mixer in code.
+ */
+
+static int snd_ebox44_create_mixer(struct usb_mixer_interface *mixer)
+{
+	snd_ebox44_create_ctl(mixer, 4, 1, 0x0, USB_MIXER_INV_BOOLEAN, "Headphone Playback Switch");
+	snd_ebox44_create_ctl(mixer, 4, 2, 0x1, USB_MIXER_S16, "Headphone A Mix Playback Volume");
+	snd_ebox44_create_ctl(mixer, 4, 2, 0x2, USB_MIXER_S16, "Headphone B Mix Playback Volume");
+
+	snd_ebox44_create_ctl(mixer, 7, 1, 0x0, USB_MIXER_INV_BOOLEAN, "Output Playback Switch");
+	snd_ebox44_create_ctl(mixer, 7, 2, 0x1, USB_MIXER_S16, "Output A Playback Volume");
+	snd_ebox44_create_ctl(mixer, 7, 2, 0x2, USB_MIXER_S16, "Output B Playback Volume");
+
+	snd_ebox44_create_ctl(mixer, 10, 1, 0x0, USB_MIXER_INV_BOOLEAN, "Input Capture Switch");
+	snd_ebox44_create_ctl(mixer, 10, 2, 0x1, USB_MIXER_S16, "Input A Capture Volume");
+	snd_ebox44_create_ctl(mixer, 10, 2, 0x2, USB_MIXER_S16, "Input B Capture Volume");
+
+	return 0;
+}
+
 void snd_emuusb_set_samplerate(struct snd_usb_audio *chip,
 			       unsigned char samplerate_id)
 {
@@ -619,6 +682,10 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 				snd_nativeinstruments_ta10_mixers,
 				ARRAY_SIZE(snd_nativeinstruments_ta10_mixers));
 		break;
+
+	case USB_ID(0x200c, 0x1018): /* Electrix Ebox-44 */
+		err = snd_ebox44_create_mixer(mixer);
+		break;
 	}
 
 	return err;
-- 
1.7.4.4
