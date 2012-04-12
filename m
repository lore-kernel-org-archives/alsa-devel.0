From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 5/6] ALSA: snd-usb: add support for implicit
	feedback
Date: Thu, 12 Apr 2012 13:51:14 +0200
Message-ID: <1334231475-20980-6-git-send-email-zonque@gmail.com>
References: <1334231475-20980-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
	by alsa0.perex.cz (Postfix) with ESMTP id E2AA524349
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Apr 2012 13:51:26 +0200 (CEST)
In-Reply-To: <1334231475-20980-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: gdiffey@gmail.com, tiwai@suse.de, clemens@ladisch.de, linuxaudio@showlabor.de, Daniel Mack <zonque@gmail.com>, blablack@gmail.com
List-Id: alsa-devel@alsa-project.org

Implicit feedback is a streaming mode that does not rely on dedicated
sync endpoints but uses the information provided by record streams to
clock output streams. Now that the streaming logic is decoupled from the
PCM streams, this is easy to implement.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/pcm.c |   37 ++++++++++++++++++++++++++-----------
 1 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 0f10783..2d3a04d 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -301,7 +301,7 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 	struct usb_interface *iface;
 	unsigned int ep, attr;
 	int is_playback = subs->direction == SNDRV_PCM_STREAM_PLAYBACK;
-	int err;
+	int err, implicit_fb = 0;
 
 	iface = usb_ifnum_to_if(dev, fmt->iface);
 	if (WARN_ON(!iface))
@@ -326,25 +326,34 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 	 * assume it as adaptive-out or sync-in.
 	 */
 	attr = fmt->ep_attr & USB_ENDPOINT_SYNCTYPE;
-	if (((is_playback && attr == USB_ENDPOINT_SYNC_ASYNC) ||
-	     (! is_playback && attr == USB_ENDPOINT_SYNC_ADAPTIVE)) &&
-	    altsd->bNumEndpoints >= 2) {
-		switch (subs->stream->chip->usb_id) {
-		case USB_ID(0x0763, 0x2080): /* M-Audio FastTrack Ultra */
-		case USB_ID(0x0763, 0x2081):
+
+	switch (subs->stream->chip->usb_id) {
+	case USB_ID(0x0763, 0x2080): /* M-Audio FastTrack Ultra */
+	case USB_ID(0x0763, 0x2081):
+		if (is_playback) {
+			implicit_fb = 1;
 			ep = 0x81;
 			iface = usb_ifnum_to_if(dev, 2);
+
+			if (!iface || iface->num_altsetting == 0)
+				return -EINVAL;
+
 			alts = &iface->altsetting[1];
 			goto add_sync_ep;
 		}
+	}
 
+	if (((is_playback && attr == USB_ENDPOINT_SYNC_ASYNC) ||
+	     (!is_playback && attr == USB_ENDPOINT_SYNC_ADAPTIVE)) &&
+	    altsd->bNumEndpoints >= 2) {
 		/* check sync-pipe endpoint */
 		/* ... and check descriptor size before accessing bSynchAddress
 		   because there is a version of the SB Audigy 2 NX firmware lacking
 		   the audio fields in the endpoint descriptors */
 		if ((get_endpoint(alts, 1)->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != 0x01 ||
 		    (get_endpoint(alts, 1)->bLength >= USB_DT_ENDPOINT_AUDIO_SIZE &&
-		     get_endpoint(alts, 1)->bSynchAddress != 0)) {
+		     get_endpoint(alts, 1)->bSynchAddress != 0 &&
+		     !implicit_fb)) {
 			snd_printk(KERN_ERR "%d:%d:%d : invalid synch pipe\n",
 				   dev->devnum, fmt->iface, fmt->altsetting);
 			return -EINVAL;
@@ -352,16 +361,22 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 		ep = get_endpoint(alts, 1)->bEndpointAddress;
 		if (get_endpoint(alts, 0)->bLength >= USB_DT_ENDPOINT_AUDIO_SIZE &&
 		    (( is_playback && ep != (unsigned int)(get_endpoint(alts, 0)->bSynchAddress | USB_DIR_IN)) ||
-		     (!is_playback && ep != (unsigned int)(get_endpoint(alts, 0)->bSynchAddress & ~USB_DIR_IN)))) {
+		     (!is_playback && ep != (unsigned int)(get_endpoint(alts, 0)->bSynchAddress & ~USB_DIR_IN)) ||
+		     ( is_playback && !implicit_fb))) {
 			snd_printk(KERN_ERR "%d:%d:%d : invalid synch pipe\n",
 				   dev->devnum, fmt->iface, fmt->altsetting);
 			return -EINVAL;
 		}
+
+		implicit_fb = (get_endpoint(alts, 1)->bmAttributes & USB_ENDPOINT_USAGE_MASK)
+				== USB_ENDPOINT_USAGE_IMPLICIT_FB;
+
 add_sync_ep:
 		subs->sync_endpoint = snd_usb_add_endpoint(subs->stream->chip,
 							   alts, ep, !subs->direction,
-							   SND_USB_ENDPOINT_TYPE_SYNC);
-
+							   implicit_fb ?
+								SND_USB_ENDPOINT_TYPE_DATA :
+								SND_USB_ENDPOINT_TYPE_SYNC);
 		if (!subs->sync_endpoint)
 			return -EINVAL;
 
-- 
1.7.7.6
