From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH v2 4/9] ALSA: usb-audio: move implicit fb
	quirks to separate function
Date: Sat,  3 Aug 2013 10:50:18 +0200
Message-ID: <1375519823-25718-5-git-send-email-eldad@fogrefinery.com>
References: <1375519823-25718-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f44.google.com (mail-bk0-f44.google.com
 [209.85.214.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CA6F2617AA
 for <alsa-devel@alsa-project.org>; Sat,  3 Aug 2013 10:50:42 +0200 (CEST)
Received: by mail-bk0-f44.google.com with SMTP id mz10so461206bkb.31
 for <alsa-devel@alsa-project.org>; Sat, 03 Aug 2013 01:50:42 -0700 (PDT)
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

Separate setting implicit feedback quirks from setting
a sync endpoint (which may also be explicit feedback or async).

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>

---
v2: removed check to return early if subs->sync_endpoint is
already set, as this is a functional change (although it is
initialized to NULL and set to NULL on disconnect).
---
 sound/usb/pcm.c | 60 ++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 15 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index e24ce7d..0016f28 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -327,24 +327,16 @@ static int search_roland_implicit_fb(struct usb_device *dev, int ifnum,
 	return 0;
 }
 
-
-static int set_sync_endpoint(struct snd_usb_substream *subs,
-			     struct audioformat *fmt,
-			     struct usb_device *dev,
-			     struct usb_host_interface *alts,
-			     struct usb_interface_descriptor *altsd)
+static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
+					 struct usb_device *dev,
+					 struct usb_interface_descriptor *altsd,
+					 unsigned int attr)
 {
+	struct usb_host_interface *alts;
 	struct usb_interface *iface;
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
@@ -388,6 +380,45 @@ static int set_sync_endpoint(struct snd_usb_substream *subs,
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
+
 	if (((is_playback && attr == USB_ENDPOINT_SYNC_ASYNC) ||
 	     (!is_playback && attr == USB_ENDPOINT_SYNC_ADAPTIVE)) &&
 	    altsd->bNumEndpoints >= 2) {
@@ -420,7 +451,6 @@ static int set_sync_endpoint(struct snd_usb_substream *subs,
 		implicit_fb = (get_endpoint(alts, 1)->bmAttributes & USB_ENDPOINT_USAGE_MASK)
 				== USB_ENDPOINT_USAGE_IMPLICIT_FB;
 
-add_sync_ep:
 		subs->sync_endpoint = snd_usb_add_endpoint(subs->stream->chip,
 							   alts, ep, !subs->direction,
 							   implicit_fb ?
-- 
1.8.1.5
