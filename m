From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ALSA: usb-audio: Flatten probe and
	disconnect functions
Date: Mon,  3 Nov 2014 14:02:04 +0100
Message-ID: <1415019726-25710-2-git-send-email-tiwai@suse.de>
References: <1415019726-25710-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 715F926047B
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 14:02:08 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 41D0CAC9F
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 13:02:08 +0000 (UTC)
In-Reply-To: <1415019726-25710-1-git-send-email-tiwai@suse.de>
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

The usb-audio probe and disconnect functions have been split just for
adapting the (new!) API at 2.5 kernel time.  We left them until now,
partly because we wanted to build with the pretty old kernels in the
external alsa-driver tree.  But the support of such old kernels has
been longly stopped, so it's good time to clean up this mess.

One good point by this cleanup is that now the probe function returns
a proper error code instead of only -EIO.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/card.c | 75 +++++++++++++++++++++++---------------------------------
 1 file changed, 30 insertions(+), 45 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 7ecd0e8a5c51..be16bdc53c2a 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -112,7 +112,7 @@ static struct usb_driver usb_audio_driver;
 
 /*
  * disconnect streams
- * called from snd_usb_audio_disconnect()
+ * called from usb_audio_disconnect()
  */
 static void snd_usb_stream_disconnect(struct list_head *head)
 {
@@ -475,14 +475,14 @@ static int snd_usb_audio_create(struct usb_interface *intf,
  * only at the first time.  the successive calls of this function will
  * append the pcm interface to the corresponding card.
  */
-static struct snd_usb_audio *
-snd_usb_audio_probe(struct usb_device *dev,
-		    struct usb_interface *intf,
-		    const struct usb_device_id *usb_id)
+static int usb_audio_probe(struct usb_interface *intf,
+			   const struct usb_device_id *usb_id)
 {
-	const struct snd_usb_audio_quirk *quirk = (const struct snd_usb_audio_quirk *)usb_id->driver_info;
-	int i, err;
+	struct usb_device *dev = interface_to_usbdev(intf);
+	const struct snd_usb_audio_quirk *quirk =
+		(const struct snd_usb_audio_quirk *)usb_id->driver_info;
 	struct snd_usb_audio *chip;
+	int i, err;
 	struct usb_host_interface *alts;
 	int ifnum;
 	u32 id;
@@ -492,10 +492,11 @@ snd_usb_audio_probe(struct usb_device *dev,
 	id = USB_ID(le16_to_cpu(dev->descriptor.idVendor),
 		    le16_to_cpu(dev->descriptor.idProduct));
 	if (quirk && quirk->ifnum >= 0 && ifnum != quirk->ifnum)
-		goto __err_val;
+		return -ENXIO;
 
-	if (snd_usb_apply_boot_quirk(dev, intf, quirk) < 0)
-		goto __err_val;
+	err = snd_usb_apply_boot_quirk(dev, intf, quirk);
+	if (err < 0)
+		return err;
 
 	/*
 	 * found a config.  now register to ALSA
@@ -508,6 +509,7 @@ snd_usb_audio_probe(struct usb_device *dev,
 		if (usb_chip[i] && usb_chip[i]->dev == dev) {
 			if (usb_chip[i]->shutdown) {
 				dev_err(&dev->dev, "USB device is in the shutdown state, cannot create a card instance\n");
+				err = -EIO;
 				goto __error;
 			}
 			chip = usb_chip[i];
@@ -523,15 +525,16 @@ snd_usb_audio_probe(struct usb_device *dev,
 			if (enable[i] && ! usb_chip[i] &&
 			    (vid[i] == -1 || vid[i] == USB_ID_VENDOR(id)) &&
 			    (pid[i] == -1 || pid[i] == USB_ID_PRODUCT(id))) {
-				if (snd_usb_audio_create(intf, dev, i, quirk,
-							 &chip) < 0) {
+				err = snd_usb_audio_create(intf, dev, i, quirk,
+							   &chip);
+				if (err < 0)
 					goto __error;
-				}
 				chip->pm_intf = intf;
 				break;
 			}
 		if (!chip) {
 			dev_err(&dev->dev, "no available usb audio device\n");
+			err = -ENODEV;
 			goto __error;
 		}
 	}
@@ -548,28 +551,32 @@ snd_usb_audio_probe(struct usb_device *dev,
 	err = 1; /* continue */
 	if (quirk && quirk->ifnum != QUIRK_NO_INTERFACE) {
 		/* need some special handlings */
-		if ((err = snd_usb_create_quirk(chip, intf, &usb_audio_driver, quirk)) < 0)
+		err = snd_usb_create_quirk(chip, intf, &usb_audio_driver, quirk);
+		if (err < 0)
 			goto __error;
 	}
 
 	if (err > 0) {
 		/* create normal USB audio interfaces */
-		if (snd_usb_create_streams(chip, ifnum) < 0 ||
-		    snd_usb_create_mixer(chip, ifnum, ignore_ctl_error) < 0) {
+		err = snd_usb_create_streams(chip, ifnum);
+		if (err < 0)
+			goto __error;
+		err = snd_usb_create_mixer(chip, ifnum, ignore_ctl_error);
+		if (err < 0)
 			goto __error;
-		}
 	}
 
 	/* we are allowed to call snd_card_register() many times */
-	if (snd_card_register(chip->card) < 0) {
+	err = snd_card_register(chip->card);
+	if (err < 0)
 		goto __error;
-	}
 
 	usb_chip[chip->index] = chip;
 	chip->num_interfaces++;
 	chip->probing = 0;
+	usb_set_intfdata(intf, chip);
 	mutex_unlock(&register_mutex);
-	return chip;
+	return 0;
 
  __error:
 	if (chip) {
@@ -578,17 +585,16 @@ snd_usb_audio_probe(struct usb_device *dev,
 		chip->probing = 0;
 	}
 	mutex_unlock(&register_mutex);
- __err_val:
-	return NULL;
+	return err;
 }
 
 /*
  * we need to take care of counter, since disconnection can be called also
  * many times as well as usb_audio_probe().
  */
-static void snd_usb_audio_disconnect(struct usb_device *dev,
-				     struct snd_usb_audio *chip)
+static void usb_audio_disconnect(struct usb_interface *intf)
 {
+	struct snd_usb_audio *chip = usb_get_intfdata(intf);
 	struct snd_card *card;
 	struct list_head *p;
 
@@ -630,27 +636,6 @@ static void snd_usb_audio_disconnect(struct usb_device *dev,
 	}
 }
 
-/*
- * new 2.5 USB kernel API
- */
-static int usb_audio_probe(struct usb_interface *intf,
-			   const struct usb_device_id *id)
-{
-	struct snd_usb_audio *chip;
-	chip = snd_usb_audio_probe(interface_to_usbdev(intf), intf, id);
-	if (chip) {
-		usb_set_intfdata(intf, chip);
-		return 0;
-	} else
-		return -EIO;
-}
-
-static void usb_audio_disconnect(struct usb_interface *intf)
-{
-	snd_usb_audio_disconnect(interface_to_usbdev(intf),
-				 usb_get_intfdata(intf));
-}
-
 #ifdef CONFIG_PM
 
 int snd_usb_autoresume(struct snd_usb_audio *chip)
-- 
2.1.3
