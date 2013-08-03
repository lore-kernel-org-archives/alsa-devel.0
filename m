From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH v2 5/9] ALSA: usb-audio: reverse condition
	logic in set_sync_endpoint
Date: Sat,  3 Aug 2013 10:50:19 +0200
Message-ID: <1375519823-25718-6-git-send-email-eldad@fogrefinery.com>
References: <1375519823-25718-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f42.google.com (mail-bk0-f42.google.com
 [209.85.214.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 97185261987
 for <alsa-devel@alsa-project.org>; Sat,  3 Aug 2013 10:50:45 +0200 (CEST)
Received: by mail-bk0-f42.google.com with SMTP id jk14so456233bkc.1
 for <alsa-devel@alsa-project.org>; Sat, 03 Aug 2013 01:50:45 -0700 (PDT)
In-Reply-To: <1375519823-25718-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Eldad Zack <eldad@fogrefinery.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Reverse logic on the conditions required to qualify for a sync endpoint
and remove one level of indendation.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>

---
v2: identation and whitespace corrections
---
 sound/usb/pcm.c | 81 ++++++++++++++++++++++++++++++---------------------------
 1 file changed, 42 insertions(+), 39 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 0016f28..c31dbdc 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -419,49 +419,52 @@ static int set_sync_endpoint(struct snd_usb_substream *subs,
 	if (err < 0)
 		return err;
 
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
-
-		implicit_fb = (get_endpoint(alts, 1)->bmAttributes & USB_ENDPOINT_USAGE_MASK)
-				== USB_ENDPOINT_USAGE_IMPLICIT_FB;
+	if (altsd->bNumEndpoints < 2)
+		return 0;
 
-		subs->sync_endpoint = snd_usb_add_endpoint(subs->stream->chip,
-							   alts, ep, !subs->direction,
-							   implicit_fb ?
-								SND_USB_ENDPOINT_TYPE_DATA :
-								SND_USB_ENDPOINT_TYPE_SYNC);
-		if (!subs->sync_endpoint)
-			return -EINVAL;
+	if ((is_playback && attr != USB_ENDPOINT_SYNC_ASYNC) ||
+	    (!is_playback && attr != USB_ENDPOINT_SYNC_ADAPTIVE))
+		return 0;
 
-		subs->data_endpoint->sync_master = subs->sync_endpoint;
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
+	    ((is_playback && ep != (unsigned int)(get_endpoint(alts, 0)->bSynchAddress | USB_DIR_IN)) ||
+	     (!is_playback && ep != (unsigned int)(get_endpoint(alts, 0)->bSynchAddress & ~USB_DIR_IN)))) {
+		snd_printk(KERN_ERR "%d:%d:%d : invalid sync pipe. is_playback %d, ep %02x, bSynchAddress %02x\n",
+			   dev->devnum, fmt->iface, fmt->altsetting,
+			   is_playback, ep, get_endpoint(alts, 0)->bSynchAddress);
+		return -EINVAL;
 	}
 
+	implicit_fb = (get_endpoint(alts, 1)->bmAttributes & USB_ENDPOINT_USAGE_MASK)
+			== USB_ENDPOINT_USAGE_IMPLICIT_FB;
+
+	subs->sync_endpoint = snd_usb_add_endpoint(subs->stream->chip,
+						   alts, ep, !subs->direction,
+						   implicit_fb ?
+							SND_USB_ENDPOINT_TYPE_DATA :
+							SND_USB_ENDPOINT_TYPE_SYNC);
+	if (!subs->sync_endpoint)
+		return -EINVAL;
+
+	subs->data_endpoint->sync_master = subs->sync_endpoint;
+
 	return 0;
 }
 
-- 
1.8.1.5
