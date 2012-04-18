From: Benedikt Bergenthal <benedikt@kdrennert.de>
Subject: [PATCH 32/33] Sound: USB: card.c : Fixed various style errors
Date: Wed, 18 Apr 2012 16:12:12 +0200
Message-ID: <1334758333-4906-1-git-send-email-benedikt@kdrennert.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz
Cc: tiwai@suse.de, zonque@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Benedikt Bergenthal <benedikt@kdrennert.de>
List-Id: alsa-devel@alsa-project.org

Fixed Various style issues from checkpath

Signed-off-by: Benedikt Bergenthal <benedikt@kdrennert.de>
---
 sound/usb/card.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 4a7be7b..a2f7cc1 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -186,7 +186,7 @@ static int snd_usb_create_stream(struct snd_usb_audio *chip, int ctrlif, int int
 		return -EINVAL;
 	}
 
-	if (! snd_usb_parse_audio_interface(chip, interface)) {
+	if (!snd_usb_parse_audio_interface(chip, interface)) {
 		usb_set_interface(dev, interface, 0); /* reset the current interface */
 		usb_driver_claim_interface(&usb_audio_driver, iface, (void *)-1L);
 		return -EINVAL;
@@ -331,7 +331,7 @@ static int snd_usb_audio_create(struct usb_device *dev, int idx,
 	}
 
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-	if (! chip) {
+	if (!chip) {
 		snd_card_free(card);
 		return -ENOMEM;
 	}
@@ -351,7 +351,8 @@ static int snd_usb_audio_create(struct usb_device *dev, int idx,
 	INIT_LIST_HEAD(&chip->midi_list);
 	INIT_LIST_HEAD(&chip->mixer_list);
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	if (err < 0) {
 		snd_usb_audio_free(chip);
 		snd_card_free(card);
 		return err;
@@ -474,12 +475,12 @@ snd_usb_audio_probe(struct usb_device *dev,
 			break;
 		}
 	}
-	if (! chip) {
+	if (!chip) {
 		/* it's a fresh one.
 		 * now look for an empty slot and create a new card instance
 		 */
 		for (i = 0; i < SNDRV_CARDS; i++)
-			if (enable[i] && ! usb_chip[i] &&
+			if (enable[i] && !usb_chip[i] &&
 			    (vid[i] == -1 || vid[i] == USB_ID_VENDOR(id)) &&
 			    (pid[i] == -1 || pid[i] == USB_ID_PRODUCT(id))) {
 				if (snd_usb_audio_create(dev, i, quirk, &chip) < 0) {
@@ -507,7 +508,8 @@ snd_usb_audio_probe(struct usb_device *dev,
 	err = 1; /* continue */
 	if (quirk && quirk->ifnum != QUIRK_NO_INTERFACE) {
 		/* need some special handlings */
-		if ((err = snd_usb_create_quirk(chip, intf, &usb_audio_driver, quirk)) < 0)
+		err = snd_usb_create_quirk(chip, intf, &usb_audio_driver, quirk);
+		if (err < 0)
 			goto __error;
 	}
 
@@ -639,7 +641,7 @@ static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
 				as = list_entry(p, struct snd_usb_stream, list);
 				snd_pcm_suspend_all(as->pcm);
 			}
- 		}
+		}
 	} else {
 		/*
 		 * otherwise we keep the rest of the system in the dark
@@ -687,7 +689,7 @@ err_out:
 #define usb_audio_resume	NULL
 #endif		/* CONFIG_PM */
 
-static struct usb_device_id usb_audio_ids [] = {
+static struct usb_device_id usb_audio_ids[] = {
 #include "quirks-table.h"
     { .match_flags = (USB_DEVICE_ID_MATCH_INT_CLASS | USB_DEVICE_ID_MATCH_INT_SUBCLASS),
       .bInterfaceClass = USB_CLASS_AUDIO,
-- 
1.7.9.5
