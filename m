From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH RFC 06/10] ALSA: usb-audio: do not initialize
	and check implicit_fb
Date: Fri, 19 Jul 2013 20:23:26 +0200
Message-ID: <1374258210-14486-7-git-send-email-eldad@fogrefinery.com>
References: <1374258210-14486-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f172.google.com (mail-ea0-f172.google.com
 [209.85.215.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 023102657CC
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 20:23:56 +0200 (CEST)
Received: by mail-ea0-f172.google.com with SMTP id q10so2583704eaj.31
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 11:23:56 -0700 (PDT)
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

Since implicit_fb is not changed, !implicit_fb will always
be true - it is set only after these checks.
Similarly, there's also no need to set it at the top of the function.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/pcm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index b6dee7a..8865833 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -397,8 +397,6 @@ add_sync_ep:
 	return 0;
 }
 
-
-
 static int set_sync_endpoint(struct snd_usb_substream *subs,
 			     struct audioformat *fmt,
 			     struct usb_device *dev,
@@ -407,7 +405,7 @@ static int set_sync_endpoint(struct snd_usb_substream *subs,
 {
 	int is_playback = subs->direction == SNDRV_PCM_STREAM_PLAYBACK;
 	unsigned int ep, attr;
-	int implicit_fb = 0;
+	int implicit_fb;
 	int err;
 
 	if (subs->sync_endpoint)
@@ -439,8 +437,7 @@ static int set_sync_endpoint(struct snd_usb_substream *subs,
 	   the audio fields in the endpoint descriptors */
 	if ((get_endpoint(alts, 1)->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_ISOC ||
 	    (get_endpoint(alts, 1)->bLength >= USB_DT_ENDPOINT_AUDIO_SIZE &&
-	     get_endpoint(alts, 1)->bSynchAddress != 0 &&
-	     !implicit_fb)) {
+	     get_endpoint(alts, 1)->bSynchAddress != 0)) {
 		snd_printk(KERN_ERR "%d:%d:%d : invalid sync pipe. bmAttributes %02x, bLength %d, bSynchAddress %02x\n",
 			   dev->devnum, fmt->iface, fmt->altsetting,
 			   get_endpoint(alts, 1)->bmAttributes,
@@ -449,8 +446,7 @@ static int set_sync_endpoint(struct snd_usb_substream *subs,
 		return -EINVAL;
 	}
 	ep = get_endpoint(alts, 1)->bEndpointAddress;
-	if (!implicit_fb &&
-	    get_endpoint(alts, 0)->bLength >= USB_DT_ENDPOINT_AUDIO_SIZE &&
+	if  (get_endpoint(alts, 0)->bLength >= USB_DT_ENDPOINT_AUDIO_SIZE &&
 	    (( is_playback && ep != (unsigned int)(get_endpoint(alts, 0)->bSynchAddress | USB_DIR_IN)) ||
 	     (!is_playback && ep != (unsigned int)(get_endpoint(alts, 0)->bSynchAddress & ~USB_DIR_IN)))) {
 		snd_printk(KERN_ERR "%d:%d:%d : invalid sync pipe. is_playback %d, ep %02x, bSynchAddress %02x\n",
-- 
1.8.1.5
