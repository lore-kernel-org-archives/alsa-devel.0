From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: usb-audio: Fake also USB device id when
	alias is given
Date: Fri, 31 Mar 2017 11:26:20 +0200
Message-ID: <20170331092620.21980-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BA4D2669DD
 for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2017 11:26:22 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id F1A66AB46
 for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2017 09:26:21 +0000 (UTC)
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

Recently snd-usb-audio driver received a new option, quirk_alias, to
allow user to apply the existing quirk for a different device.  This
works for many quirks as is, but some still need more tune-ups:
namely, some quirks check the USB vendor/device IDs in various places,
thus it doesn't work as long as the ID is different from the expected
one.

With this patch, the driver stores the aliased USB ID, so that these
rest quirks per device ID are applied.  The transition to use the
cached USB ID was already done in the past, so what we needed now is
only to overwrite chip->usb_id.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/card.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index f36cb068dad3..6640277a725b 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -332,6 +332,7 @@ static int snd_usb_audio_dev_free(struct snd_device *device)
 static int snd_usb_audio_create(struct usb_interface *intf,
 				struct usb_device *dev, int idx,
 				const struct snd_usb_audio_quirk *quirk,
+				unsigned int usb_id,
 				struct snd_usb_audio **rchip)
 {
 	struct snd_card *card;
@@ -381,8 +382,7 @@ static int snd_usb_audio_create(struct usb_interface *intf,
 	atomic_set(&chip->usage_count, 0);
 	atomic_set(&chip->shutdown, 0);
 
-	chip->usb_id = USB_ID(le16_to_cpu(dev->descriptor.idVendor),
-			      le16_to_cpu(dev->descriptor.idProduct));
+	chip->usb_id = usb_id;
 	INIT_LIST_HEAD(&chip->pcm_list);
 	INIT_LIST_HEAD(&chip->ep_list);
 	INIT_LIST_HEAD(&chip->midi_list);
@@ -569,7 +569,7 @@ static int usb_audio_probe(struct usb_interface *intf,
 			    (vid[i] == -1 || vid[i] == USB_ID_VENDOR(id)) &&
 			    (pid[i] == -1 || pid[i] == USB_ID_PRODUCT(id))) {
 				err = snd_usb_audio_create(intf, dev, i, quirk,
-							   &chip);
+							   id, &chip);
 				if (err < 0)
 					goto __error;
 				chip->pm_intf = intf;
-- 
2.11.1
