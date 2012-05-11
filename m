From: Mark Hills <mark@pogo.org.uk>
Subject: [RFC] usb-audio: Use a table of mixer controls
Date: Fri, 11 May 2012 18:28:48 +0100
Message-ID: <1336757328-22649-1-git-send-email-mark@pogo.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wes.ijneb.com (mx.ij.cx [212.13.201.15])
	by alsa0.perex.cz (Postfix) with ESMTP id DFDBC10476F
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2012 19:28:48 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

Allow mixer controls to be provided clearly in a table, to avoid
quantity of error checking at each use.

This is definitely clearer than the current code. But going forward,
how should this work with the tables defined in mixer_maps.c?

I've made this generic and tried to follow existing conventions for
similar tables (eg. use a terminator, not array size), comments welcome.
---
 sound/usb/mixer_quirks.c |  104 +++++++++++++++++++++-------------------------
 1 files changed, 48 insertions(+), 56 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 41f4b69..b80b7e7 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -42,6 +42,13 @@
 
 extern struct snd_kcontrol_new *snd_usb_feature_unit_ctl;
 
+struct std_mono_table {
+	unsigned int unitid, control, cmask;
+	int val_type;
+	const char *name;
+	snd_kcontrol_tlv_rw_t *tlv_callback;
+};
+
 /* private_free callback */
 static void usb_mixer_elem_free(struct snd_kcontrol *kctl)
 {
@@ -114,6 +121,24 @@ static int snd_create_std_mono_ctl(struct usb_mixer_interface *mixer,
 }
 
 /*
+ * Create a set of standard UAC controls from a table
+ */
+static int snd_create_std_mono_table(struct usb_mixer_interface *mixer,
+				struct std_mono_table *t)
+{
+	int err;
+
+	while (t->name != NULL) {
+		err = snd_create_std_mono_ctl(mixer, t->unitid, t->control,
+				t->cmask, t->val_type, t->name, t->tlv_callback);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+/*
  * Sound Blaster remote control configuration
  *
  * format of remote control data:
@@ -916,61 +941,6 @@ static int snd_ftu_create_mixer(struct usb_mixer_interface *mixer)
 	return 0;
 }
 
-
-/*
- * Create mixer for Electrix Ebox-44
- *
- * The mixer units from this device are corrupt, and even where they
- * are valid they presents mono controls as L and R channels of
- * stereo. So we create a good mixer in code.
- */
-
-static int snd_ebox44_create_mixer(struct usb_mixer_interface *mixer)
-{
-	int err;
-
-	err = snd_create_std_mono_ctl(mixer, 4, 1, 0x0, USB_MIXER_INV_BOOLEAN,
-				"Headphone Playback Switch", NULL);
-	if (err < 0)
-		return err;
-	err = snd_create_std_mono_ctl(mixer, 4, 2, 0x1, USB_MIXER_S16,
-				"Headphone A Mix Playback Volume", NULL);
-	if (err < 0)
-		return err;
-	err = snd_create_std_mono_ctl(mixer, 4, 2, 0x2, USB_MIXER_S16,
-				"Headphone B Mix Playback Volume", NULL);
-	if (err < 0)
-		return err;
-
-	err = snd_create_std_mono_ctl(mixer, 7, 1, 0x0, USB_MIXER_INV_BOOLEAN,
-				"Output Playback Switch", NULL);
-	if (err < 0)
-		return err;
-	err = snd_create_std_mono_ctl(mixer, 7, 2, 0x1, USB_MIXER_S16,
-				"Output A Playback Volume", NULL);
-	if (err < 0)
-		return err;
-	err = snd_create_std_mono_ctl(mixer, 7, 2, 0x2, USB_MIXER_S16,
-				"Output B Playback Volume", NULL);
-	if (err < 0)
-		return err;
-
-	err = snd_create_std_mono_ctl(mixer, 10, 1, 0x0, USB_MIXER_INV_BOOLEAN,
-				"Input Capture Switch", NULL);
-	if (err < 0)
-		return err;
-	err = snd_create_std_mono_ctl(mixer, 10, 2, 0x1, USB_MIXER_S16,
-				"Input A Capture Volume", NULL);
-	if (err < 0)
-		return err;
-	err = snd_create_std_mono_ctl(mixer, 10, 2, 0x2, USB_MIXER_S16,
-				"Input B Capture Volume", NULL);
-	if (err < 0)
-		return err;
-
-	return 0;
-}
-
 void snd_emuusb_set_samplerate(struct snd_usb_audio *chip,
 			       unsigned char samplerate_id)
 {
@@ -990,6 +960,27 @@ void snd_emuusb_set_samplerate(struct snd_usb_audio *chip,
 	}
 }
 
+/*
+ * The mixer units for Ebox-44 are corrupt, and even where they
+ * are valid they presents mono controls as L and R channels of
+ * stereo. So we create provide a good mixer here.
+ */
+struct std_mono_table ebox44_table[] = {
+	{ 4, 1, 0x0, USB_MIXER_INV_BOOLEAN, "Headphone Playback Switch", NULL },
+	{ 4, 2, 0x1, USB_MIXER_S16, "Headphone A Mix Playback Volume", NULL },
+	{ 4, 2, 0x2, USB_MIXER_S16, "Headphone B Mix Playback Volume", NULL },
+
+	{ 7, 1, 0x0, USB_MIXER_INV_BOOLEAN, "Output Playback Switch", NULL },
+	{ 7, 2, 0x1, USB_MIXER_S16, "Output A Playback Volume", NULL },
+	{ 7, 2, 0x2, USB_MIXER_S16, "Output B Playback Volume", NULL },
+
+	{ 10, 1, 0x0, USB_MIXER_INV_BOOLEAN, "Input Capture Switch", NULL },
+	{ 10, 2, 0x1, USB_MIXER_S16, "Input A Capture Volume", NULL },
+	{ 10, 2, 0x2, USB_MIXER_S16, "Input B Capture Volume", NULL },
+
+	{ }
+};
+
 int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 {
 	int err = 0;
@@ -1035,7 +1026,8 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 		break;
 
 	case USB_ID(0x200c, 0x1018): /* Electrix Ebox-44 */
-		err = snd_ebox44_create_mixer(mixer);
+		/* detection is disabled in mixer_maps.c */
+		err = snd_create_std_mono_table(mixer, ebox44_table);
 		break;
 	}
 
-- 
1.7.4.4
