From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/24] ALSA: usb: Convert to snd_card_new()
	with a device pointer
Date: Wed, 12 Feb 2014 11:35:22 +0100
Message-ID: <1392201340-27113-7-git-send-email-tiwai@suse.de>
References: <1392201340-27113-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DDCE0264FEB
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:35:50 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 80C5DAC6E
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 10:35:50 +0000 (UTC)
In-Reply-To: <1392201340-27113-1-git-send-email-tiwai@suse.de>
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

Also remove superfluous snd_card_set_dev() calls.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/6fire/chip.c     |  5 ++---
 sound/usb/caiaq/device.c   |  6 +++---
 sound/usb/card.c           | 10 ++++++----
 sound/usb/hiface/chip.c    | 10 +++++-----
 sound/usb/misc/ua101.c     |  7 +++----
 sound/usb/usx2y/us122l.c   | 11 ++++++-----
 sound/usb/usx2y/usbusx2y.c | 11 ++++++-----
 7 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/sound/usb/6fire/chip.c b/sound/usb/6fire/chip.c
index 66edc4a7917f..e0fe0d92db8c 100644
--- a/sound/usb/6fire/chip.c
+++ b/sound/usb/6fire/chip.c
@@ -124,8 +124,8 @@ static int usb6fire_chip_probe(struct usb_interface *intf,
 		snd_printk(KERN_ERR PREFIX "can't set first interface.\n");
 		return -EIO;
 	}
-	ret = snd_card_create(index[regidx], id[regidx], THIS_MODULE,
-			sizeof(struct sfire_chip), &card);
+	ret = snd_card_new(&intf->dev, index[regidx], id[regidx],
+			   THIS_MODULE, sizeof(struct sfire_chip), &card);
 	if (ret < 0) {
 		snd_printk(KERN_ERR PREFIX "cannot create alsa card.\n");
 		return ret;
@@ -134,7 +134,6 @@ static int usb6fire_chip_probe(struct usb_interface *intf,
 	strcpy(card->shortname, "TerraTec DMX6FireUSB");
 	sprintf(card->longname, "%s at %d:%d", card->shortname,
 			device->bus->busnum, device->devnum);
-	snd_card_set_dev(card, &intf->dev);
 
 	chip = card->private_data;
 	chips[regidx] = chip;
diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index bc55f708a696..b871ba407e4e 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -418,8 +418,9 @@ static int create_card(struct usb_device *usb_dev,
 	if (devnum >= SNDRV_CARDS)
 		return -ENODEV;
 
-	err = snd_card_create(index[devnum], id[devnum], THIS_MODULE,
-			      sizeof(struct snd_usb_caiaqdev), &card);
+	err = snd_card_new(&intf->dev,
+			   index[devnum], id[devnum], THIS_MODULE,
+			   sizeof(struct snd_usb_caiaqdev), &card);
 	if (err < 0)
 		return err;
 
@@ -429,7 +430,6 @@ static int create_card(struct usb_device *usb_dev,
 	cdev->chip.usb_id = USB_ID(le16_to_cpu(usb_dev->descriptor.idVendor),
 				  le16_to_cpu(usb_dev->descriptor.idProduct));
 	spin_lock_init(&cdev->spinlock);
-	snd_card_set_dev(card, &intf->dev);
 
 	*cardp = card;
 	return 0;
diff --git a/sound/usb/card.c b/sound/usb/card.c
index 025224136129..0cfdc2d3b631 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -328,7 +328,8 @@ static void remove_trailing_spaces(char *str)
 /*
  * create a chip instance and set its names.
  */
-static int snd_usb_audio_create(struct usb_device *dev, int idx,
+static int snd_usb_audio_create(struct usb_interface *intf,
+				struct usb_device *dev, int idx,
 				const struct snd_usb_audio_quirk *quirk,
 				struct snd_usb_audio **rchip)
 {
@@ -354,7 +355,8 @@ static int snd_usb_audio_create(struct usb_device *dev, int idx,
 		return -ENXIO;
 	}
 
-	err = snd_card_create(index[idx], id[idx], THIS_MODULE, 0, &card);
+	err = snd_card_new(&intf->dev, index[idx], id[idx], THIS_MODULE,
+			   0, &card);
 	if (err < 0) {
 		snd_printk(KERN_ERR "cannot create card instance %d\n", idx);
 		return err;
@@ -513,10 +515,10 @@ snd_usb_audio_probe(struct usb_device *dev,
 			if (enable[i] && ! usb_chip[i] &&
 			    (vid[i] == -1 || vid[i] == USB_ID_VENDOR(id)) &&
 			    (pid[i] == -1 || pid[i] == USB_ID_PRODUCT(id))) {
-				if (snd_usb_audio_create(dev, i, quirk, &chip) < 0) {
+				if (snd_usb_audio_create(intf, dev, i, quirk,
+							 &chip) < 0) {
 					goto __error;
 				}
-				snd_card_set_dev(chip->card, &intf->dev);
 				chip->pm_intf = intf;
 				break;
 			}
diff --git a/sound/usb/hiface/chip.c b/sound/usb/hiface/chip.c
index b0dcb3924ce5..2670d646bda9 100644
--- a/sound/usb/hiface/chip.c
+++ b/sound/usb/hiface/chip.c
@@ -64,7 +64,8 @@ struct hiface_vendor_quirk {
 	u8 extra_freq;
 };
 
-static int hiface_chip_create(struct usb_device *device, int idx,
+static int hiface_chip_create(struct usb_interface *intf,
+			      struct usb_device *device, int idx,
 			      const struct hiface_vendor_quirk *quirk,
 			      struct hiface_chip **rchip)
 {
@@ -76,7 +77,8 @@ static int hiface_chip_create(struct usb_device *device, int idx,
 	*rchip = NULL;
 
 	/* if we are here, card can be registered in alsa. */
-	ret = snd_card_create(index[idx], id[idx], THIS_MODULE, sizeof(*chip), &card);
+	ret = snd_card_new(&intf->dev, index[idx], id[idx], THIS_MODULE,
+			   sizeof(*chip), &card);
 	if (ret < 0) {
 		dev_err(&device->dev, "cannot create alsa card.\n");
 		return ret;
@@ -132,12 +134,10 @@ static int hiface_chip_probe(struct usb_interface *intf,
 		goto err;
 	}
 
-	ret = hiface_chip_create(device, i, quirk, &chip);
+	ret = hiface_chip_create(intf, device, i, quirk, &chip);
 	if (ret < 0)
 		goto err;
 
-	snd_card_set_dev(chip->card, &intf->dev);
-
 	ret = hiface_pcm_init(chip, quirk ? quirk->extra_freq : 0);
 	if (ret < 0)
 		goto err_chip_destroy;
diff --git a/sound/usb/misc/ua101.c b/sound/usb/misc/ua101.c
index 509315937f25..a1bab149df4d 100644
--- a/sound/usb/misc/ua101.c
+++ b/sound/usb/misc/ua101.c
@@ -1243,8 +1243,9 @@ static int ua101_probe(struct usb_interface *interface,
 		mutex_unlock(&devices_mutex);
 		return -ENOENT;
 	}
-	err = snd_card_create(index[card_index], id[card_index], THIS_MODULE,
-			      sizeof(*ua), &card);
+	err = snd_card_new(&interface->dev,
+			   index[card_index], id[card_index], THIS_MODULE,
+			   sizeof(*ua), &card);
 	if (err < 0) {
 		mutex_unlock(&devices_mutex);
 		return err;
@@ -1283,8 +1284,6 @@ static int ua101_probe(struct usb_interface *interface,
 		}
 	}
 
-	snd_card_set_dev(card, &interface->dev);
-
 	err = detect_usb_format(ua);
 	if (err < 0)
 		goto probe_error;
diff --git a/sound/usb/usx2y/us122l.c b/sound/usb/usx2y/us122l.c
index 999550bbad40..cf5dc33f4a6d 100644
--- a/sound/usb/usx2y/us122l.c
+++ b/sound/usb/usx2y/us122l.c
@@ -535,7 +535,9 @@ static void snd_us122l_free(struct snd_card *card)
 		snd_us122l_card_used[index] = 0;
 }
 
-static int usx2y_create_card(struct usb_device *device, struct snd_card **cardp)
+static int usx2y_create_card(struct usb_device *device,
+			     struct usb_interface *intf,
+			     struct snd_card **cardp)
 {
 	int		dev;
 	struct snd_card *card;
@@ -546,8 +548,8 @@ static int usx2y_create_card(struct usb_device *device, struct snd_card **cardp)
 			break;
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE,
-			      sizeof(struct us122l), &card);
+	err = snd_card_new(&intf->dev, index[dev], id[dev], THIS_MODULE,
+			   sizeof(struct us122l), &card);
 	if (err < 0)
 		return err;
 	snd_us122l_card_used[US122L(card)->card_index = dev] = 1;
@@ -578,11 +580,10 @@ static int us122l_usb_probe(struct usb_interface *intf,
 	struct snd_card *card;
 	int err;
 
-	err = usx2y_create_card(device, &card);
+	err = usx2y_create_card(device, intf, &card);
 	if (err < 0)
 		return err;
 
-	snd_card_set_dev(card, &intf->dev);
 	if (!us122l_create_card(card)) {
 		snd_card_free(card);
 		return -EINVAL;
diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index 5a51b18c50fe..e38c87302b15 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -332,7 +332,9 @@ static struct usb_device_id snd_usX2Y_usb_id_table[] = {
 	{ /* terminator */ }
 };
 
-static int usX2Y_create_card(struct usb_device *device, struct snd_card **cardp)
+static int usX2Y_create_card(struct usb_device *device,
+			     struct usb_interface *intf,
+			     struct snd_card **cardp)
 {
 	int		dev;
 	struct snd_card *	card;
@@ -343,8 +345,8 @@ static int usX2Y_create_card(struct usb_device *device, struct snd_card **cardp)
 			break;
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE,
-			      sizeof(struct usX2Ydev), &card);
+	err = snd_card_new(&intf->dev, index[dev], id[dev], THIS_MODULE,
+			   sizeof(struct usX2Ydev), &card);
 	if (err < 0)
 		return err;
 	snd_usX2Y_card_used[usX2Y(card)->card_index = dev] = 1;
@@ -382,10 +384,9 @@ static int usX2Y_usb_probe(struct usb_device *device,
 	     le16_to_cpu(device->descriptor.idProduct) != USB_ID_US428))
 		return -EINVAL;
 
-	err = usX2Y_create_card(device, &card);
+	err = usX2Y_create_card(device, intf, &card);
 	if (err < 0)
 		return err;
-	snd_card_set_dev(card, &intf->dev);
 	if ((err = usX2Y_hwdep_new(card, device)) < 0  ||
 	    (err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
-- 
1.8.5.2
