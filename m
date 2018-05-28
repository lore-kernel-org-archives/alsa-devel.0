From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ALSA: usb-audio: Avoid lowlevel device
	object
Date: Mon, 28 May 2018 11:58:19 +0200
Message-ID: <20180528095821.28710-2-tiwai@suse.de>
References: <20180528095821.28710-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2573126763F
 for <alsa-devel@alsa-project.org>; Mon, 28 May 2018 17:53:59 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 61DC5AE40
 for <alsa-devel@alsa-project.org>; Mon, 28 May 2018 15:53:58 +0000 (UTC)
In-Reply-To: <20180528095821.28710-1-tiwai@suse.de>
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

Simplify the device management by replacing the lowlevel device object
allocation with the card->private_data.  Nowadays there is almost no
advantage by the lowlevel device, and with card->private_data, the
code becomes cleaner.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/card.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index f6c3c1cd591e..615ee1e92de9 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -342,8 +342,9 @@ static int snd_usb_create_streams(struct snd_usb_audio *chip, int ctrlif)
  *
  */
 
-static int snd_usb_audio_free(struct snd_usb_audio *chip)
+static void snd_usb_audio_free(struct snd_card *card)
 {
+	struct snd_usb_audio *chip = card->private_data;
 	struct snd_usb_endpoint *ep, *n;
 
 	list_for_each_entry_safe(ep, n, &chip->ep_list, list)
@@ -353,13 +354,6 @@ static int snd_usb_audio_free(struct snd_usb_audio *chip)
 	if (!atomic_read(&chip->shutdown))
 		dev_set_drvdata(&chip->dev->dev, NULL);
 	kfree(chip);
-	return 0;
-}
-
-static int snd_usb_audio_dev_free(struct snd_device *device)
-{
-	struct snd_usb_audio *chip = device->device_data;
-	return snd_usb_audio_free(chip);
 }
 
 static void usb_audio_make_shortname(struct usb_device *dev,
@@ -459,9 +453,6 @@ static int snd_usb_audio_create(struct usb_interface *intf,
 	struct snd_usb_audio *chip;
 	int err;
 	char component[14];
-	static struct snd_device_ops ops = {
-		.dev_free =	snd_usb_audio_dev_free,
-	};
 
 	*rchip = NULL;
 
@@ -479,18 +470,13 @@ static int snd_usb_audio_create(struct usb_interface *intf,
 	}
 
 	err = snd_card_new(&intf->dev, index[idx], id[idx], THIS_MODULE,
-			   0, &card);
+			   sizeof(*chip), &card);
 	if (err < 0) {
 		dev_err(&dev->dev, "cannot create card instance %d\n", idx);
 		return err;
 	}
 
-	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-	if (! chip) {
-		snd_card_free(card);
-		return -ENOMEM;
-	}
-
+	chip = card->private_data;
 	mutex_init(&chip->mutex);
 	init_waitqueue_head(&chip->shutdown_wait);
 	chip->index = idx;
@@ -508,11 +494,7 @@ static int snd_usb_audio_create(struct usb_interface *intf,
 	INIT_LIST_HEAD(&chip->midi_list);
 	INIT_LIST_HEAD(&chip->mixer_list);
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
-		snd_usb_audio_free(chip);
-		snd_card_free(card);
-		return err;
-	}
+	card->private_free = snd_usb_audio_free;
 
 	strcpy(card->driver, "USB-Audio");
 	sprintf(component, "USB%04x:%04x",
-- 
2.16.3
