From: Adrian Pardini <pardo.bsso@gmail.com>
Subject: [RFC][PATCH] snd-usb: improving support for CM6206
Date: Sun, 4 Jul 2010 20:49:58 -0300
Message-ID: <201007042049.59030.pardo.bsso@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homiemail-a63.g.dreamhost.com (jankymail-mx1.g.dreamhost.com
	[208.97.132.126])
	by alsa0.perex.cz (Postfix) with ESMTP id B4C1924456
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Jul 2010 01:50:22 +0200 (CEST)
Received: from homiemail-a63.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a63.g.dreamhost.com (Postfix) with ESMTP id EE1E22F406D
	for <alsa-devel@alsa-project.org>; Sun,  4 Jul 2010 16:50:20 -0700 (PDT)
Received: from onyx.local (unknown [201.255.102.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: adrian@tangopardo.com.ar)
	by homiemail-a63.g.dreamhost.com (Postfix) with ESMTPSA id 522D72F406A
	for <alsa-devel@alsa-project.org>; Sun,  4 Jul 2010 16:50:20 -0700 (PDT)
Content-Disposition: inline
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

Hi all,

I'm working in my spare time to get better support for this chip. Right now it
works but some features present in the datasheet are missing.
This patch gives the option to select the source for the "headphone" jack.

I have some concerns with the way I accomplished this and I'd like if someone
could kick me in the right direction. In particular with the caching of some
register values. Added another field to usb_mixer_interface, maybe it's not
the best place.

Also, according to the datasheet, in order to read back the register I must
issue a request as done in snd_usb_cm106_write_int_reg() and the result will
come in the HID input report. For this it doesn't matter but I'm planning on
making some controls for spdif and I'll need it. Where should I tap to get
that information?.

To be done (I need help):

  * Mapping of streams: Front is ok. Rear_L jack is assigned to 
    "Center", Rear_R jack gets "Speaker Woofer". "Center/Bass" jack is managed
    with the mixer "Speaker". Traced the circuit and the connections are fine,
    how do I switch them from ALSA? (nb: not with a ttable, from the driver)


To be done (I think I'll somehow get this done on my own):

  * Input levels are reported with more resolution than the real. Add another
    case to build_feature_ctl(). Not very important now.

  * Engaging of the "mute" controls: now I can't mute left or right channel
    without muting everything. Have to play more with mixer_maps.


Kind regards and thanks a lot for your time.



Signed off by: Adrian Pardini <adrian.pardini@solar.org.ar>

---

diff --git a/alsa-kernel/usb/mixer.h b/alsa-kernel/usb/mixer.h
index 26c636c..291ba4b 100644
--- a/alsa-kernel/usb/mixer.h
+++ b/alsa-kernel/usb/mixer.h
@@ -22,6 +22,7 @@ struct usb_mixer_interface {
 
 	u8 audigy2nx_leds[3];
 	u8 xonar_u1_status;
+	u16 cm6206reg2;
 };
 
 #define MAX_CHANNELS	10	/* max logical channels */

diff --git a/usb/mixer_quirks.c b/usb/mixer_quirks.c
index 794cdbd..8adeef0 100644
--- a/usb/mixer_quirks.c
+++ b/usb/mixer_quirks.c
@@ -360,6 +360,129 @@ void snd_emuusb_set_samplerate(struct snd_usb_audio 
*chip,
 	}
 }
 
+/*
+ * C-Media CM106/CM106+ have four 16-bit internal registers that are nicely
+ * documented in the device's data sheet.
+ */
+int snd_usb_cm106_write_int_reg(struct usb_device *dev, int reg, u16 value)
+{
+	u8 buf[4];
+	buf[0] = 0x20;
+	buf[1] = value & 0xff;
+	buf[2] = (value >> 8) & 0xff;
+	buf[3] = reg;
+	return snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), 
USB_REQ_SET_CONFIGURATION,
+			       USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_ENDPOINT,
+	  0, 0, &buf, 4, 1000);
+}
+
+static int snd_cm6206_headphone_source_get(struct snd_kcontrol *kcontrol, 
struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = kcontrol->private_value;
+	return 0;
+}
+
+static int snd_cm6206_headphone_source_put(struct snd_kcontrol *kcontrol, 
struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_interface *mixer = snd_kcontrol_chip(kcontrol);
+	struct usb_device *dev = mixer->chip->dev;
+
+	u16 reg2 = mixer->cm6206reg2;
+	u16 idx = kcontrol->private_value = ucontrol->value.integer.value[0];
+
+	reg2 = (u16)( (((1<<7) | (idx<<5))<<8) | (reg2 & 0x1800) );
+
+	snd_usb_cm106_write_int_reg(dev, 2, reg2);
+	mixer->cm6206reg2 = reg2;
+	return 1;
+}
+
+static int snd_cm6206_headphone_mute_get(struct snd_kcontrol *kcontrol, 
struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = kcontrol->private_value & (1<<11);
+	ucontrol->value.integer.value[1] = kcontrol->private_value & (1<<12);
+	return 0;
+}
+
+static int snd_cm6206_headphone_mute_put(struct snd_kcontrol *kcontrol, 
struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_interface *mixer = snd_kcontrol_chip(kcontrol);
+	struct usb_device *dev = mixer->chip->dev;
+
+	u16 reg2 = mixer->cm6206reg2;
+	u16 mute;
+
+	mute = ucontrol->value.integer.value[1] ? (1<<12) : 0;
+	mute |= ucontrol->value.integer.value[0] ? (1<<11) : 0;
+	kcontrol->private_value = mute;
+
+	reg2 = (u16)(mute | (reg2 & ~0x1800));
+
+	snd_usb_cm106_write_int_reg(dev, 2, reg2);
+	mixer->cm6206reg2 = reg2;
+	return 1;
+}
+
+static int snd_cm6206_headphone_source_info(struct snd_kcontrol *kcontrol,
+					    struct snd_ctl_elem_info *uinfo)
+{
+	static const char *const names[] = {
+		"Side",
+		"Surround",
+		"Center",
+		"Front"
+	};
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 4;
+	if (uinfo->value.enumerated.item > 3)
+		uinfo->value.enumerated.item = 3;
+	strcpy(uinfo->value.enumerated.name, names[uinfo->value.enumerated.item]);
+	return 0;
+}
+
+#define snd_cm6206_headphone_mute_info  snd_ctl_boolean_stereo_info
+
+static struct snd_kcontrol_new cm6206_controls[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.name = "Headphone Source",
+		.info = snd_cm6206_headphone_source_info,
+		.get = snd_cm6206_headphone_source_get,
+		.put = snd_cm6206_headphone_source_put,
+		.private_value = 3
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.name = "Headphone",
+		.info = snd_cm6206_headphone_mute_info,
+		.get = snd_cm6206_headphone_mute_get,
+		.put = snd_cm6206_headphone_mute_put,
+		.private_value = 24
+	}
+};
+
+static int snd_cm6206_controls_create(struct usb_mixer_interface *mixer)
+{
+	int i, err;
+
+	for (i=0; i < ARRAY_SIZE(cm6206_controls); ++i) {
+		err = snd_ctl_add(mixer->chip->card,
+				  snd_ctl_new1(&cm6206_controls[i], mixer));
+		if (err < 0)
+			return err;
+	}
+	mixer->cm6206reg2 = 0xf800; /* Headphone source=front, no mute. */
+	return 0;
+}
+
 int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 {
 	int err;
@@ -385,6 +508,11 @@ int snd_usb_mixer_apply_create_quirk(struct 
usb_mixer_interface *mixer)
 			return err;
 	}
 
+	if (mixer->chip->usb_id == USB_ID(0x0d8c, 0x0102)) {
+		err = snd_cm6206_controls_create(mixer);
+		if (err < 0)
+			return err;
+	}
 	return 0;
 }
 
@@ -415,4 +543,3 @@ void snd_usb_mixer_rc_memory_change(struct 
usb_mixer_interface *mixer,
 		break;
 	}
 }
-

diff --git a/alsa-kernel/usb/mixer_quirks.h b/alsa-kernel/usb/mixer_quirks.h
index bdbfab0..bc5d577 100644
--- a/alsa-kernel/usb/mixer_quirks.h
+++ b/alsa-kernel/usb/mixer_quirks.h
@@ -9,5 +9,7 @@ void snd_emuusb_set_samplerate(struct snd_usb_audio *chip,
 void snd_usb_mixer_rc_memory_change(struct usb_mixer_interface *mixer,
 				    int unitid);
 
+int snd_usb_cm106_write_int_reg(struct usb_device *dev, int reg, u16 value);
+		
 #endif /* SND_USB_MIXER_QUIRKS_H */
 
diff --git a/usb/quirks.c b/usb/quirks.c
index bf97ccd..ab57d58 100644
--- a/usb/quirks.c
+++ b/usb/quirks.c
@@ -376,22 +376,6 @@ static int snd_usb_audigy2nx_boot_quirk(struct usb_device 
*dev)
 	return 0;
 }
 
-/*
- * C-Media CM106/CM106+ have four 16-bit internal registers that are nicely
- * documented in the device's data sheet.
- */
-static int snd_usb_cm106_write_int_reg(struct usb_device *dev, int reg, u16 
value)
-{
-	u8 buf[4];
-	buf[0] = 0x20;
-	buf[1] = value & 0xff;
-	buf[2] = (value >> 8) & 0xff;
-	buf[3] = reg;
-	return snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), 
USB_REQ_SET_CONFIGURATION,
-			       USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_ENDPOINT,
-			       0, 0, &buf, 4, 1000);
-}
-
 static int snd_usb_cm106_boot_quirk(struct usb_device *dev)
 {
 	/*





-- 
Adrian.
http://elesquinazotango.com.ar
http://www.noalcodigodescioli.blogspot.com/
