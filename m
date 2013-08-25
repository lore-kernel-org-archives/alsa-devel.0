From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH v3 11/11] ALSA: usb-audio: rename alt_idx to
	altsetting
Date: Sun, 25 Aug 2013 17:45:55 +0200
Message-ID: <1377445555-5923-6-git-send-email-eldad@fogrefinery.com>
References: <1377445399-5678-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f53.google.com (mail-bk0-f53.google.com
 [209.85.214.53])
 by alsa0.perex.cz (Postfix) with ESMTP id C19EA2619D1
 for <alsa-devel@alsa-project.org>; Sun, 25 Aug 2013 17:46:22 +0200 (CEST)
Received: by mail-bk0-f53.google.com with SMTP id d7so827514bkh.12
 for <alsa-devel@alsa-project.org>; Sun, 25 Aug 2013 08:46:22 -0700 (PDT)
In-Reply-To: <1377445399-5678-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

As Clemens Ladisch kindly explained:
 "Please note that there are two methods to identify alternate settings:
  the number, which is the value in bAlternateSetting, and the index,
  which is the index in the descriptor array.  There might be some wording
  in the USB spec that these two values must be the same, but in reality,
  [insert standard rant about firmware writers], bAlternateSetting
  must be treated as a random ID value."

This patch changes the name to express the correct usage semantics.
No functional change.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/card.h     | 2 +-
 sound/usb/endpoint.c | 6 +++---
 sound/usb/pcm.c      | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index 0fd3f8b..ce204d8 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -96,7 +96,7 @@ struct snd_usb_endpoint {
 	unsigned int syncinterval;	/* P for adaptive mode, 0 otherwise */
 	unsigned char silence_value;
 	unsigned int stride;
-	int iface, alt_idx;
+	int iface, altsetting;
 	int skip_packets;		/* quirks for devices to ignore the first n packets
 					   in a stream */
 
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 7e04ebb..86aece0 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -426,9 +426,9 @@ struct snd_usb_endpoint *snd_usb_add_endpoint(struct snd_usb_audio *chip,
 	list_for_each_entry(ep, &chip->ep_list, list) {
 		if (ep->ep_num == ep_num &&
 		    ep->iface == alts->desc.bInterfaceNumber &&
-		    ep->alt_idx == alts->desc.bAlternateSetting) {
+		    ep->altsetting == alts->desc.bAlternateSetting) {
 			snd_printdd(KERN_DEBUG "Re-using EP %x in iface %d,%d @%p\n",
-					ep_num, ep->iface, ep->alt_idx, ep);
+					ep_num, ep->iface, ep->altsetting, ep);
 			goto __exit_unlock;
 		}
 	}
@@ -447,7 +447,7 @@ struct snd_usb_endpoint *snd_usb_add_endpoint(struct snd_usb_audio *chip,
 	ep->type = type;
 	ep->ep_num = ep_num;
 	ep->iface = alts->desc.bInterfaceNumber;
-	ep->alt_idx = alts->desc.bAlternateSetting;
+	ep->altsetting = alts->desc.bAlternateSetting;
 	INIT_LIST_HEAD(&ep->ready_playback_urbs);
 	ep_num &= USB_ENDPOINT_NUMBER_MASK;
 
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 5018b30..283e6c0 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -306,17 +306,17 @@ static int start_endpoints(struct snd_usb_substream *subs, bool can_sleep)
 		struct snd_usb_endpoint *ep = subs->sync_endpoint;
 
 		if (subs->data_endpoint->iface != subs->sync_endpoint->iface ||
-		    subs->data_endpoint->alt_idx != subs->sync_endpoint->alt_idx) {
+		    subs->data_endpoint->altsetting != subs->sync_endpoint->altsetting) {
 			err = snd_usb_set_interface(subs,
 						    subs->sync_endpoint->iface,
-						    subs->sync_endpoint->alt_idx);
+						    subs->sync_endpoint->altsetting);
 			if (err < 0) {
 				clear_bit(SUBSTREAM_FLAG_SYNC_EP_STARTED, &subs->flags);
 				snd_printk(KERN_ERR
 					   "%d:%d:%d: cannot set interface (%d)\n",
 					   subs->dev->devnum,
 					   subs->sync_endpoint->iface,
-					   subs->sync_endpoint->alt_idx, err);
+					   subs->sync_endpoint->altsetting, err);
 				return -EIO;
 			}
 		}
-- 
1.8.1.5
