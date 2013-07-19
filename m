From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH RFC 05/10] ALSA: usb-audio: reverse condition
	logic in set_sync_endpoint
Date: Fri, 19 Jul 2013 20:23:25 +0200
Message-ID: <1374258210-14486-6-git-send-email-eldad@fogrefinery.com>
References: <1374258210-14486-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f170.google.com (mail-ea0-f170.google.com
 [209.85.215.170])
 by alsa0.perex.cz (Postfix) with ESMTP id C38862657CF
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 20:23:53 +0200 (CEST)
Received: by mail-ea0-f170.google.com with SMTP id h10so2564143eaj.29
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 11:23:53 -0700 (PDT)
In-Reply-To: <1374258210-14486-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Daniel Mack <zonque@gmail.com>, Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Reverse logic on the conditions required to qualify for a sync endpoint
and remove one level of indendation.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/pcm.c | 81 ++++++++++++++++++++++++++++++---------------------------
 1 file changed, 42 insertions(+), 39 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 549964a..b6dee7a 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -426,48 +426,51 @@ static int set_sync_endpoint(struct snd_usb_substream *subs,
 	if (subs->sync_endpoint)
 		return 0;
 
-	if (((is_playback && attr == USB_ENDPOINT_SYNC_ASYNC) ||
-	     (!is_playback && attr == USB_ENDPOINT_SYNC_ADAPTIVE)) &&
-	    altsd->bNumEndpoints >= 2) {
-		/* check sync-pipe endpoint */
-		/* ... and check descriptor size before accessing bSynchAddress
-		   because there is a version of the SB Audigy 2 NX firmware lacking
-		   the audio fields in the endpoint descriptors */
-		if ((get_endpoint(alts, 1)->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_ISOC ||
-		    (get_endpoint(alts, 1)->bLength >= USB_DT_ENDPOINT_AUDIO_SIZE &&
-		     get_endpoint(alts, 1)->bSynchAddress != 0 &&
-		     !implicit_fb)) {
-			snd_printk(KERN_ERR "%d:%d:%d : invalid sync pipe. bmAttributes %02x, bLength %d, bSynchAddress %02x\n",
-				   dev->devnum, fmt->iface, fmt->altsetting,
-				   get_endpoint(alts, 1)->bmAttributes,
-				   get_endpoint(alts, 1)->bLength,
-				   get_endpoint(alts, 1)->bSynchAddress);
-			return -EINVAL;
-		}
-		ep = get_endpoint(alts, 1)->bEndpointAddress;
-		if (!implicit_fb &&
-		    get_endpoint(alts, 0)->bLength >= USB_DT_ENDPOINT_AUDIO_SIZE &&
-		    (( is_playback && ep != (unsigned int)(get_endpoint(alts, 0)->bSynchAddress | USB_DIR_IN)) ||
-		     (!is_playback && ep != (unsigned int)(get_endpoint(alts, 0)->bSynchAddress & ~USB_DIR_IN)))) {
-			snd_printk(KERN_ERR "%d:%d:%d : invalid sync pipe. is_playback %d, ep %02x, bSynchAddress %02x\n",
-				   dev->devnum, fmt->iface, fmt->altsetting,
-				   is_playback, ep, get_endpoint(alts, 0)->bSynchAddress);
-			return -EINVAL;
-		}
+	if (altsd->bNumEndpoints < 2)
+		return 0;
 
-		implicit_fb = (get_endpoint(alts, 1)->bmAttributes & USB_ENDPOINT_USAGE_MASK)
-				== USB_ENDPOINT_USAGE_IMPLICIT_FB;
+	if ((is_playback && attr != USB_ENDPOINT_SYNC_ASYNC) ||
+	     (!is_playback && attr != USB_ENDPOINT_SYNC_ADAPTIVE))
+	     return 0;
+
+	/* check sync-pipe endpoint */
+	/* ... and check descriptor size before accessing bSynchAddress
+	   because there is a version of the SB Audigy 2 NX firmware lacking
+	   the audio fields in the endpoint descriptors */
+	if ((get_endpoint(alts, 1)->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_ISOC ||
+	    (get_endpoint(alts, 1)->bLength >= USB_DT_ENDPOINT_AUDIO_SIZE &&
+	     get_endpoint(alts, 1)->bSynchAddress != 0 &&
+	     !implicit_fb)) {
+		snd_printk(KERN_ERR "%d:%d:%d : invalid sync pipe. bmAttributes %02x, bLength %d, bSynchAddress %02x\n",
+			   dev->devnum, fmt->iface, fmt->altsetting,
+			   get_endpoint(alts, 1)->bmAttributes,
+			   get_endpoint(alts, 1)->bLength,
+			   get_endpoint(alts, 1)->bSynchAddress);
+		return -EINVAL;
+	}
+	ep = get_endpoint(alts, 1)->bEndpointAddress;
+	if (!implicit_fb &&
+	    get_endpoint(alts, 0)->bLength >= USB_DT_ENDPOINT_AUDIO_SIZE &&
+	    (( is_playback && ep != (unsigned int)(get_endpoint(alts, 0)->bSynchAddress | USB_DIR_IN)) ||
+	     (!is_playback && ep != (unsigned int)(get_endpoint(alts, 0)->bSynchAddress & ~USB_DIR_IN)))) {
+		snd_printk(KERN_ERR "%d:%d:%d : invalid sync pipe. is_playback %d, ep %02x, bSynchAddress %02x\n",
+			   dev->devnum, fmt->iface, fmt->altsetting,
+			   is_playback, ep, get_endpoint(alts, 0)->bSynchAddress);
+		return -EINVAL;
+	}
 
-		subs->sync_endpoint = snd_usb_add_endpoint(subs->stream->chip,
-							   alts, ep, !subs->direction,
-							   implicit_fb ?
-								SND_USB_ENDPOINT_TYPE_DATA :
-								SND_USB_ENDPOINT_TYPE_SYNC);
-		if (!subs->sync_endpoint)
-			return -EINVAL;
+	implicit_fb = (get_endpoint(alts, 1)->bmAttributes & USB_ENDPOINT_USAGE_MASK)
+			== USB_ENDPOINT_USAGE_IMPLICIT_FB;
 
-		subs->data_endpoint->sync_master = subs->sync_endpoint;
-	}
+	subs->sync_endpoint = snd_usb_add_endpoint(subs->stream->chip,
+						   alts, ep, !subs->direction,
+						   implicit_fb ?
+							SND_USB_ENDPOINT_TYPE_DATA :
+							SND_USB_ENDPOINT_TYPE_SYNC);
+	if (!subs->sync_endpoint)
+		return -EINVAL;
+
+	subs->data_endpoint->sync_master = subs->sync_endpoint;
 
 	return 0;
 }
-- 
1.8.1.5
