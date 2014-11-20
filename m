From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 03/10] ALSA: usb-audio: Add audigy2nx
	resume support
Date: Thu, 20 Nov 2014 18:33:28 +0100
Message-ID: <1416504815-28685-4-git-send-email-tiwai@suse.de>
References: <1416504815-28685-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D4B4E260630
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 18:33:47 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E3CCEAD00
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 17:33:46 +0000 (UTC)
In-Reply-To: <1416504815-28685-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rewrite the code to handle LEDs on audigy2nx and co for supporting the
proper resume.  A new internal helper function
add_single_ctl_with_resume() is introduced to manage the
usb_mixer_elem_list more easily.

Also while we're at it, move audigy2nx_leds[] in usb_mixer_interface
struct into the private_value of each kctl, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.h        |   1 -
 sound/usb/mixer_quirks.c | 148 +++++++++++++++++++++++++++++------------------
 2 files changed, 92 insertions(+), 57 deletions(-)

diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index 05d812f7d5e5..a9697fe93aef 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -23,7 +23,6 @@ struct usb_mixer_interface {
 	struct usb_ctrlrequest *rc_setup_packet;
 	u8 rc_buffer[6];
 
-	u8 audigy2nx_leds[3];
 	u8 xonar_u1_status;
 };
 
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 4cc32892dc6f..b412d085e593 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -144,6 +144,32 @@ static int snd_create_std_mono_table(struct usb_mixer_interface *mixer,
 	return 0;
 }
 
+static int add_single_ctl_with_resume(struct usb_mixer_interface *mixer,
+				      int id,
+				      usb_mixer_elem_resume_func resume,
+				      const struct snd_kcontrol_new *knew,
+				      struct usb_mixer_elem_list **listp)
+{
+	struct usb_mixer_elem_list *list;
+	struct snd_kcontrol *kctl;
+
+	list = kzalloc(sizeof(*list), GFP_KERNEL);
+	if (!list)
+		return -ENOMEM;
+	if (listp)
+		*listp = list;
+	list->mixer = mixer;
+	list->id = id;
+	list->resume = resume;
+	kctl = snd_ctl_new1(knew, list);
+	if (!kctl) {
+		kfree(list);
+		return -ENOMEM;
+	}
+	kctl->private_free = snd_usb_mixer_elem_free;
+	return snd_usb_mixer_add_control(list, kctl);
+}
+
 /*
  * Sound Blaster remote control configuration
  *
@@ -271,84 +297,90 @@ static int snd_usb_soundblaster_remote_init(struct usb_mixer_interface *mixer)
 
 static int snd_audigy2nx_led_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
-	struct usb_mixer_interface *mixer = snd_kcontrol_chip(kcontrol);
-	int index = kcontrol->private_value;
-
-	ucontrol->value.integer.value[0] = mixer->audigy2nx_leds[index];
+	ucontrol->value.integer.value[0] = kcontrol->private_value >> 8;
 	return 0;
 }
 
-static int snd_audigy2nx_led_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+static int snd_audigy2nx_led_update(struct usb_mixer_interface *mixer,
+				    int value, int index)
 {
-	struct usb_mixer_interface *mixer = snd_kcontrol_chip(kcontrol);
-	int index = kcontrol->private_value;
-	int value = ucontrol->value.integer.value[0];
-	int err, changed;
+	struct snd_usb_audio *chip = mixer->chip;
+	int err;
 
-	if (value > 1)
-		return -EINVAL;
-	changed = value != mixer->audigy2nx_leds[index];
-	down_read(&mixer->chip->shutdown_rwsem);
-	if (mixer->chip->shutdown) {
+	down_read(&chip->shutdown_rwsem);
+	if (chip->shutdown) {
 		err = -ENODEV;
 		goto out;
 	}
-	if (mixer->chip->usb_id == USB_ID(0x041e, 0x3042))
-		err = snd_usb_ctl_msg(mixer->chip->dev,
-			      usb_sndctrlpipe(mixer->chip->dev, 0), 0x24,
+	if (chip->usb_id == USB_ID(0x041e, 0x3042))
+		err = snd_usb_ctl_msg(chip->dev,
+			      usb_sndctrlpipe(chip->dev, 0), 0x24,
 			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
 			      !value, 0, NULL, 0);
 	/* USB X-Fi S51 Pro */
-	if (mixer->chip->usb_id == USB_ID(0x041e, 0x30df))
-		err = snd_usb_ctl_msg(mixer->chip->dev,
-			      usb_sndctrlpipe(mixer->chip->dev, 0), 0x24,
+	if (chip->usb_id == USB_ID(0x041e, 0x30df))
+		err = snd_usb_ctl_msg(chip->dev,
+			      usb_sndctrlpipe(chip->dev, 0), 0x24,
 			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
 			      !value, 0, NULL, 0);
 	else
-		err = snd_usb_ctl_msg(mixer->chip->dev,
-			      usb_sndctrlpipe(mixer->chip->dev, 0), 0x24,
+		err = snd_usb_ctl_msg(chip->dev,
+			      usb_sndctrlpipe(chip->dev, 0), 0x24,
 			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
 			      value, index + 2, NULL, 0);
  out:
-	up_read(&mixer->chip->shutdown_rwsem);
-	if (err < 0)
-		return err;
-	mixer->audigy2nx_leds[index] = value;
-	return changed;
+	up_read(&chip->shutdown_rwsem);
+	return err;
 }
 
-static struct snd_kcontrol_new snd_audigy2nx_controls[] = {
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "CMSS LED Switch",
-		.info = snd_audigy2nx_led_info,
-		.get = snd_audigy2nx_led_get,
-		.put = snd_audigy2nx_led_put,
-		.private_value = 0,
-	},
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Power LED Switch",
-		.info = snd_audigy2nx_led_info,
-		.get = snd_audigy2nx_led_get,
-		.put = snd_audigy2nx_led_put,
-		.private_value = 1,
-	},
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Dolby Digital LED Switch",
-		.info = snd_audigy2nx_led_info,
-		.get = snd_audigy2nx_led_get,
-		.put = snd_audigy2nx_led_put,
-		.private_value = 2,
-	},
+static int snd_audigy2nx_led_put(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
+	struct usb_mixer_interface *mixer = list->mixer;
+	int index = kcontrol->private_value & 0xff;
+	int value = ucontrol->value.integer.value[0];
+	int old_value = kcontrol->private_value >> 8;
+	int err;
+
+	if (value > 1)
+		return -EINVAL;
+	if (value == old_value)
+		return 0;
+	kcontrol->private_value = (value << 8) | index;
+	err = snd_audigy2nx_led_update(mixer, value, index);
+	return err < 0 ? err : 1;
+}
+
+static int snd_audigy2nx_led_resume(struct usb_mixer_elem_list *list)
+{
+	int priv_value = list->kctl->private_value;
+
+	return snd_audigy2nx_led_update(list->mixer, priv_value >> 8,
+					priv_value & 0xff);
+}
+
+/* name and private_value are set dynamically */
+static struct snd_kcontrol_new snd_audigy2nx_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.info = snd_audigy2nx_led_info,
+	.get = snd_audigy2nx_led_get,
+	.put = snd_audigy2nx_led_put,
+};
+
+static const char * const snd_audigy2nx_led_names[] = {
+	"CMSS LED Switch",
+	"Power LED Switch",
+	"Dolby Digital LED Switch",
 };
 
 static int snd_audigy2nx_controls_create(struct usb_mixer_interface *mixer)
 {
 	int i, err;
 
-	for (i = 0; i < ARRAY_SIZE(snd_audigy2nx_controls); ++i) {
+	for (i = 0; i < ARRAY_SIZE(snd_audigy2nx_led_names); ++i) {
+		struct snd_kcontrol_new knew;
+
 		/* USB X-Fi S51 doesn't have a CMSS LED */
 		if ((mixer->chip->usb_id == USB_ID(0x041e, 0x3042)) && i == 0)
 			continue;
@@ -361,12 +393,16 @@ static int snd_audigy2nx_controls_create(struct usb_mixer_interface *mixer)
 			 mixer->chip->usb_id == USB_ID(0x041e, 0x30df) ||
 			 mixer->chip->usb_id == USB_ID(0x041e, 0x3048)))
 			break; 
-		err = snd_ctl_add(mixer->chip->card,
-				  snd_ctl_new1(&snd_audigy2nx_controls[i], mixer));
+
+		knew = snd_audigy2nx_control;
+		knew.name = snd_audigy2nx_led_names[i];
+		knew.private_value = (1 << 8) | i; /* LED on as default */
+		err = add_single_ctl_with_resume(mixer, 0,
+						 snd_audigy2nx_led_resume,
+						 &knew, NULL);
 		if (err < 0)
 			return err;
 	}
-	mixer->audigy2nx_leds[1] = 1; /* Power LED is on by default */
 	return 0;
 }
 
-- 
2.1.3
