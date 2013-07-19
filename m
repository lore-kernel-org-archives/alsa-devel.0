From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH RFC 04/10] ALSA: usb-audio: move implicit fb
	quirks to separate function
Date: Fri, 19 Jul 2013 20:23:24 +0200
Message-ID: <1374258210-14486-5-git-send-email-eldad@fogrefinery.com>
References: <1374258210-14486-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f177.google.com (mail-ea0-f177.google.com
 [209.85.215.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 5720A2657BC
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 20:23:50 +0200 (CEST)
Received: by mail-ea0-f177.google.com with SMTP id j14so2527019eak.36
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 11:23:50 -0700 (PDT)
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

Separate implicit feedback quirks from setting a sync endpoint
(which may also be explicit feedback or async).

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/pcm.c | 71 +++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 17 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index f667b7f..549964a 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -327,24 +327,16 @@ static int search_roland_implicit_fb(struct usb_device *dev, int ifnum,
 	return 0;
 }
 
-
-static int set_sync_endpoint(struct snd_usb_substream *subs,
-			     struct audioformat *fmt,
-			     struct usb_host_interface *alts,
-			     struct usb_interface_descriptor *altsd)
+static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
+					 struct usb_device *dev,
+					 struct usb_interface_descriptor *altsd,
+					 unsigned int attr)
 {
+	struct usb_host_interface *alts;
 	struct usb_interface *iface;
-	struct usb_device *dev = subs->dev;
 	int is_playback = subs->direction == SNDRV_PCM_STREAM_PLAYBACK;
-	unsigned int ep, attr;
 	int implicit_fb = 0;
-
-	/* we need a sync pipe in async OUT or adaptive IN mode */
-	/* check the number of EP, since some devices have broken
-	 * descriptors which fool us.  if it has only one EP,
-	 * assume it as adaptive-out or sync-in.
-	 */
-	attr = fmt->ep_attr & USB_ENDPOINT_SYNCTYPE;
+	unsigned int ep;
 
 	switch (subs->stream->chip->usb_id) {
 	case USB_ID(0x0763, 0x2030): /* M-Audio Fast Track C400 */
@@ -381,13 +373,59 @@ static int set_sync_endpoint(struct snd_usb_substream *subs,
 	    altsd->bInterfaceProtocol == 2 &&
 	    altsd->bNumEndpoints == 1 &&
 	    USB_ID_VENDOR(subs->stream->chip->usb_id) == 0x0582 /* Roland */ &&
-	    search_roland_implicit_fb(dev, altsd->bInterfaceNumber + 1,
+	    search_roland_implicit_fb(subs->dev, altsd->bInterfaceNumber + 1,
 				      altsd->bAlternateSetting,
 				      &alts, &ep) >= 0) {
 		implicit_fb = 1;
 		goto add_sync_ep;
 	}
 
+	/* No quirk */
+	return 0;
+
+add_sync_ep:
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
+	return 0;
+}
+
+
+
+static int set_sync_endpoint(struct snd_usb_substream *subs,
+			     struct audioformat *fmt,
+			     struct usb_device *dev,
+			     struct usb_host_interface *alts,
+			     struct usb_interface_descriptor *altsd)
+{
+	int is_playback = subs->direction == SNDRV_PCM_STREAM_PLAYBACK;
+	unsigned int ep, attr;
+	int implicit_fb = 0;
+	int err;
+
+	if (subs->sync_endpoint)
+		return 0;
+	
+	/* we need a sync pipe in async OUT or adaptive IN mode */
+	/* check the number of EP, since some devices have broken
+	 * descriptors which fool us.  if it has only one EP,
+	 * assume it as adaptive-out or sync-in.
+	 */
+	attr = fmt->ep_attr & USB_ENDPOINT_SYNCTYPE;
+
+	err = set_sync_ep_implicit_fb_quirk(subs, dev, altsd, attr);
+	if (err < 0)
+		return err;
+	if (subs->sync_endpoint)
+		return 0;
+
 	if (((is_playback && attr == USB_ENDPOINT_SYNC_ASYNC) ||
 	     (!is_playback && attr == USB_ENDPOINT_SYNC_ADAPTIVE)) &&
 	    altsd->bNumEndpoints >= 2) {
@@ -420,7 +458,6 @@ static int set_sync_endpoint(struct snd_usb_substream *subs,
 		implicit_fb = (get_endpoint(alts, 1)->bmAttributes & USB_ENDPOINT_USAGE_MASK)
 				== USB_ENDPOINT_USAGE_IMPLICIT_FB;
 
-add_sync_ep:
 		subs->sync_endpoint = snd_usb_add_endpoint(subs->stream->chip,
 							   alts, ep, !subs->direction,
 							   implicit_fb ?
@@ -493,7 +530,7 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 	if (!subs->data_endpoint)
 		return -EINVAL;
 
-	err = set_sync_endpoint(subs, fmt, alts, altsd);
+	err = set_sync_endpoint(subs, fmt, dev, alts, altsd);
 	if (err < 0)
 		return err;
 
-- 
1.8.1.5
