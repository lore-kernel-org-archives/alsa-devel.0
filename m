From: Adrian Pardini <pardo.bsso@gmail.com>
Subject: [PATCH - usb: Headphone support for cm6206 2/2] usb:
	adds headphone source and mute controls to cm6206
Date: Tue, 20 Jul 2010 19:44:29 -0300
Message-ID: <201007201944.29990.pardo.bsso@gmail.com>
References: <201007201942.28942.pardo.bsso@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homiemail-a34.g.dreamhost.com (caiajhbdccac.dreamhost.com
	[208.97.132.202])
	by alsa0.perex.cz (Postfix) with ESMTP id 9027C2436F
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jul 2010 00:44:33 +0200 (CEST)
Received: from homiemail-a34.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a34.g.dreamhost.com (Postfix) with ESMTP id E3EDA10072
	for <alsa-devel@alsa-project.org>; Tue, 20 Jul 2010 15:44:31 -0700 (PDT)
Received: from onyx.local (unknown [201.255.107.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: adrian@tangopardo.com.ar)
	by homiemail-a34.g.dreamhost.com (Postfix) with ESMTPSA id 6742C1006D
	for <alsa-devel@alsa-project.org>; Tue, 20 Jul 2010 15:44:31 -0700 (PDT)
In-Reply-To: <201007201942.28942.pardo.bsso@gmail.com>
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



Signed-off-by: Adrian Pardini <adrian.pardini@solar.org.ar>

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index c4cbbc0..c53842c 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -370,6 +370,112 @@ int snd_usb_cm106_write_int_reg(struct usb_device *dev, int reg, u16 value)
 			       0, 0, &buf, 4, 1000);
 }
 
+static int snd_cm6206_headphone_source_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = kcontrol->private_value;
+	return 0;
+}
+
+static int snd_cm6206_headphone_source_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_interface *mixer = snd_kcontrol_chip(kcontrol);
+	struct usb_device *dev = mixer->chip->dev;
+
+	u16 reg2 = mixer->cm6206reg2;
+	u16 idx = kcontrol->private_value = ucontrol->value.integer.value[0];
+
+	reg2 = (u16)((((1<<7) | (idx<<5))<<8) | (reg2 & 0x1800));
+
+	snd_usb_cm106_write_int_reg(dev, 2, reg2);
+	mixer->cm6206reg2 = reg2;
+	return 0;
+}
+
+static int snd_cm6206_headphone_mute_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = kcontrol->private_value & (1<<11);
+	ucontrol->value.integer.value[1] = kcontrol->private_value & (1<<12);
+	return 0;
+}
+
+
+
+static int snd_cm6206_headphone_mute_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
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
+	for (i = 0; i < ARRAY_SIZE(cm6206_controls); ++i) {
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
@@ -395,6 +501,12 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 			return err;
 	}
 
+	if (mixer->chip->usb_id == USB_ID(0x0d8c, 0x0102)) {
+		err = snd_cm6206_controls_create(mixer);
+		if (err < 0)
+			return err;
+	}
+
 	return 0;
 }
 
-- 
1.5.4.3




-- 
Adrian.
http://elesquinazotango.com.ar
http://www.noalcodigodescioli.blogspot.com/
