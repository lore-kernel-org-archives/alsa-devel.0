From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 1/3] ALSA: usb-audio: Refer to chip->usb_id
	for quirks and MIDI creation
Date: Mon, 11 Jan 2016 17:59:14 +0100
Message-ID: <1452531556-32622-2-git-send-email-tiwai@suse.de>
References: <1452531556-32622-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EB962265057
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2016 17:59:22 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 879BCAD84
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2016 16:59:21 +0000 (UTC)
In-Reply-To: <1452531556-32622-1-git-send-email-tiwai@suse.de>
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

This is a preliminary patch for the later change to allow a better
quirk ID management.  In the current USB-audio code, there are a few
places looking at usb_device idVendor and idProduct fields directly
even though we have already a static member in snd_usb_audio.usb_id.
This patch modifies such codes to refer to the latter field.

For achieving this, two slightly intensive changes have been done:
- The snd_usb_audio object is set/reset via dev_getdrv() for the given
  USB device; it's needed for minimizing the changes for some existing
  quirks that take only usb_device object.

- __snd_usbmidi_create() is introduced to receive the pre-given usb_id
  argument.  The exported snd_usbmidi_create() is unchanged by calling
  this new function internally.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/card.c   |  9 ++++++---
 sound/usb/midi.c   | 15 +++++++++------
 sound/usb/midi.h   | 14 ++++++++++++--
 sound/usb/quirks.c | 34 ++++++++++++++++++++--------------
 sound/usb/quirks.h |  3 ++-
 5 files changed, 49 insertions(+), 26 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 18f56646ce86..7b5648b98ea4 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -171,8 +171,9 @@ static int snd_usb_create_stream(struct snd_usb_audio *chip, int ctrlif, int int
 	if ((altsd->bInterfaceClass == USB_CLASS_AUDIO ||
 	     altsd->bInterfaceClass == USB_CLASS_VENDOR_SPEC) &&
 	    altsd->bInterfaceSubClass == USB_SUBCLASS_MIDISTREAMING) {
-		int err = snd_usbmidi_create(chip->card, iface,
-					     &chip->midi_list, NULL);
+		int err = __snd_usbmidi_create(chip->card, iface,
+					     &chip->midi_list, NULL,
+					     chip->usb_id);
 		if (err < 0) {
 			dev_err(&dev->dev,
 				"%u:%d: cannot create sequencer device\n",
@@ -311,6 +312,7 @@ static int snd_usb_audio_free(struct snd_usb_audio *chip)
 		snd_usb_endpoint_free(ep);
 
 	mutex_destroy(&chip->mutex);
+	dev_set_drvdata(&chip->dev->dev, NULL);
 	kfree(chip);
 	return 0;
 }
@@ -484,7 +486,7 @@ static int usb_audio_probe(struct usb_interface *intf,
 	if (quirk && quirk->ifnum >= 0 && ifnum != quirk->ifnum)
 		return -ENXIO;
 
-	err = snd_usb_apply_boot_quirk(dev, intf, quirk);
+	err = snd_usb_apply_boot_quirk(dev, intf, quirk, id);
 	if (err < 0)
 		return err;
 
@@ -503,6 +505,7 @@ static int usb_audio_probe(struct usb_interface *intf,
 				goto __error;
 			}
 			chip = usb_chip[i];
+			dev_set_drvdata(&dev->dev, chip);
 			atomic_inc(&chip->active); /* avoid autopm */
 			break;
 		}
diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index cc39f63299ef..b79875ebec1e 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -2320,10 +2320,11 @@ EXPORT_SYMBOL(snd_usbmidi_resume);
 /*
  * Creates and registers everything needed for a MIDI streaming interface.
  */
-int snd_usbmidi_create(struct snd_card *card,
-		       struct usb_interface *iface,
-		       struct list_head *midi_list,
-		       const struct snd_usb_audio_quirk *quirk)
+int __snd_usbmidi_create(struct snd_card *card,
+			 struct usb_interface *iface,
+			 struct list_head *midi_list,
+			 const struct snd_usb_audio_quirk *quirk,
+			 unsigned int usb_id)
 {
 	struct snd_usb_midi *umidi;
 	struct snd_usb_midi_endpoint_info endpoints[MIDI_MAX_ENDPOINTS];
@@ -2341,8 +2342,10 @@ int snd_usbmidi_create(struct snd_card *card,
 	spin_lock_init(&umidi->disc_lock);
 	init_rwsem(&umidi->disc_rwsem);
 	mutex_init(&umidi->mutex);
-	umidi->usb_id = USB_ID(le16_to_cpu(umidi->dev->descriptor.idVendor),
+	if (!usb_id)
+		usb_id = USB_ID(le16_to_cpu(umidi->dev->descriptor.idVendor),
 			       le16_to_cpu(umidi->dev->descriptor.idProduct));
+	umidi->usb_id = usb_id;
 	setup_timer(&umidi->error_timer, snd_usbmidi_error_timer,
 		    (unsigned long)umidi);
 
@@ -2464,4 +2467,4 @@ int snd_usbmidi_create(struct snd_card *card,
 	list_add_tail(&umidi->list, midi_list);
 	return 0;
 }
-EXPORT_SYMBOL(snd_usbmidi_create);
+EXPORT_SYMBOL(__snd_usbmidi_create);
diff --git a/sound/usb/midi.h b/sound/usb/midi.h
index ad8a3211f8e7..5e25a3fd6c1d 100644
--- a/sound/usb/midi.h
+++ b/sound/usb/midi.h
@@ -39,10 +39,20 @@ struct snd_usb_midi_endpoint_info {
 
 /* for QUIRK_MIDI_AKAI, data is NULL */
 
-int snd_usbmidi_create(struct snd_card *card,
+int __snd_usbmidi_create(struct snd_card *card,
+			 struct usb_interface *iface,
+			 struct list_head *midi_list,
+			 const struct snd_usb_audio_quirk *quirk,
+			 unsigned int usb_id);
+
+static inline int snd_usbmidi_create(struct snd_card *card,
 		       struct usb_interface *iface,
 		       struct list_head *midi_list,
-		       const struct snd_usb_audio_quirk *quirk);
+		       const struct snd_usb_audio_quirk *quirk)
+{
+	return __snd_usbmidi_create(card, iface, midi_list, quirk, 0);
+}
+
 void snd_usbmidi_input_stop(struct list_head *p);
 void snd_usbmidi_input_start(struct list_head *p);
 void snd_usbmidi_disconnect(struct list_head *p);
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 23ea6d800c4c..599ed1e6c658 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -446,8 +446,9 @@ static int create_uaxx_quirk(struct snd_usb_audio *chip,
 		const struct snd_usb_audio_quirk *quirk =
 			chip->usb_id == USB_ID(0x0582, 0x002b)
 			? &ua700_quirk : &uaxx_quirk;
-		return snd_usbmidi_create(chip->card, iface,
-					  &chip->midi_list, quirk);
+		return __snd_usbmidi_create(chip->card, iface,
+					  &chip->midi_list, quirk,
+					  chip->usb_id);
 	}
 
 	if (altsd->bNumEndpoints != 1)
@@ -974,11 +975,9 @@ int snd_usb_apply_interface_quirk(struct snd_usb_audio *chip,
 
 int snd_usb_apply_boot_quirk(struct usb_device *dev,
 			     struct usb_interface *intf,
-			     const struct snd_usb_audio_quirk *quirk)
+			     const struct snd_usb_audio_quirk *quirk,
+			     unsigned int id)
 {
-	u32 id = USB_ID(le16_to_cpu(dev->descriptor.idVendor),
-			le16_to_cpu(dev->descriptor.idProduct));
-
 	switch (id) {
 	case USB_ID(0x041e, 0x3000):
 		/* SB Extigy needs special boot-up sequence */
@@ -1182,7 +1181,7 @@ void snd_usb_endpoint_start_quirk(struct snd_usb_endpoint *ep)
 	 * "Playback Design" products send bogus feedback data at the start
 	 * of the stream. Ignore them.
 	 */
-	if ((le16_to_cpu(ep->chip->dev->descriptor.idVendor) == 0x23ba) &&
+	if (USB_ID_VENDOR(ep->chip->usb_id) == 0x23ba &&
 	    ep->type == SND_USB_ENDPOINT_TYPE_SYNC)
 		ep->skip_packets = 4;
 
@@ -1201,39 +1200,46 @@ void snd_usb_endpoint_start_quirk(struct snd_usb_endpoint *ep)
 
 void snd_usb_set_interface_quirk(struct usb_device *dev)
 {
+	struct snd_usb_audio *chip = dev_get_drvdata(&dev->dev);
+
+	if (!chip)
+		return;
 	/*
 	 * "Playback Design" products need a 50ms delay after setting the
 	 * USB interface.
 	 */
-	if (le16_to_cpu(dev->descriptor.idVendor) == 0x23ba)
+	if (USB_ID_VENDOR(chip->usb_id) == 0x23ba)
 		mdelay(50);
 }
 
+/* quirk applied after snd_usb_ctl_msg(); not applied during boot quirks */
 void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
 			   __u8 request, __u8 requesttype, __u16 value,
 			   __u16 index, void *data, __u16 size)
 {
+	struct snd_usb_audio *chip = dev_get_drvdata(&dev->dev);
+
+	if (!chip)
+		return;
 	/*
 	 * "Playback Design" products need a 20ms delay after each
 	 * class compliant request
 	 */
-	if ((le16_to_cpu(dev->descriptor.idVendor) == 0x23ba) &&
+	if (USB_ID_VENDOR(chip->usb_id) == 0x23ba &&
 	    (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
 		mdelay(20);
 
 	/* Marantz/Denon devices with USB DAC functionality need a delay
 	 * after each class compliant request
 	 */
-	if (is_marantz_denon_dac(USB_ID(le16_to_cpu(dev->descriptor.idVendor),
-					le16_to_cpu(dev->descriptor.idProduct)))
+	if (is_marantz_denon_dac(chip->usb_id)
 	    && (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
 		mdelay(20);
 
 	/* Zoom R16/24 needs a tiny delay here, otherwise requests like
 	 * get/set frequency return as failed despite actually succeeding.
 	 */
-	if ((le16_to_cpu(dev->descriptor.idVendor) == 0x1686) &&
-	    (le16_to_cpu(dev->descriptor.idProduct) == 0x00dd) &&
+	if (chip->usb_id == USB_ID(0x1686, 0x00dd) &&
 	    (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
 		mdelay(1);
 }
@@ -1250,7 +1256,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 					unsigned int sample_bytes)
 {
 	/* Playback Designs */
-	if (le16_to_cpu(chip->dev->descriptor.idVendor) == 0x23ba) {
+	if (USB_ID_VENDOR(chip->usb_id) == 0x23ba) {
 		switch (fp->altsetting) {
 		case 1:
 			fp->dsd_dop = true;
diff --git a/sound/usb/quirks.h b/sound/usb/quirks.h
index 2cd71ed1201f..192ff5ce9452 100644
--- a/sound/usb/quirks.h
+++ b/sound/usb/quirks.h
@@ -16,7 +16,8 @@ int snd_usb_apply_interface_quirk(struct snd_usb_audio *chip,
 
 int snd_usb_apply_boot_quirk(struct usb_device *dev,
 			     struct usb_interface *intf,
-			     const struct snd_usb_audio_quirk *quirk);
+			     const struct snd_usb_audio_quirk *quirk,
+			     unsigned int usb_id);
 
 void snd_usb_set_format_quirk(struct snd_usb_substream *subs,
 			      struct audioformat *fmt);
-- 
2.7.0
