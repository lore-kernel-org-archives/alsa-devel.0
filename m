From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/9] ALSA: usb-audio: Add sanity checks for
	invalid EPs
Date: Tue, 10 Oct 2017 15:38:15 +0200
Message-ID: <20171010133819.10567-6-tiwai@suse.de>
References: <20171010133819.10567-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E02626737B
 for <alsa-devel@alsa-project.org>; Tue, 10 Oct 2017 15:38:22 +0200 (CEST)
In-Reply-To: <20171010133819.10567-1-tiwai@suse.de>
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
Cc: Andrey Konovalov <andreyknvl@google.com>, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

USB-audio driver may set up a URB containing the fixed EP without
validating its presence for some non-class-compliant devices.  This
may end up with an oops-like kernel warning when submitted.

For avoiding it, this patch adds the call of the new sanity-check
helper for URBs.  The checks are needed only for MIDI I/O as the other
places have already some other checks.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/midi.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index a92e2b2a91ec..7ab25de5ca0a 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1282,6 +1282,7 @@ static int snd_usbmidi_in_endpoint_create(struct snd_usb_midi *umidi,
 	unsigned int pipe;
 	int length;
 	unsigned int i;
+	int err;
 
 	rep->in = NULL;
 	ep = kzalloc(sizeof(*ep), GFP_KERNEL);
@@ -1292,8 +1293,8 @@ static int snd_usbmidi_in_endpoint_create(struct snd_usb_midi *umidi,
 	for (i = 0; i < INPUT_URBS; ++i) {
 		ep->urbs[i] = usb_alloc_urb(0, GFP_KERNEL);
 		if (!ep->urbs[i]) {
-			snd_usbmidi_in_endpoint_delete(ep);
-			return -ENOMEM;
+			err = -ENOMEM;
+			goto error;
 		}
 	}
 	if (ep_info->in_interval)
@@ -1305,8 +1306,8 @@ static int snd_usbmidi_in_endpoint_create(struct snd_usb_midi *umidi,
 		buffer = usb_alloc_coherent(umidi->dev, length, GFP_KERNEL,
 					    &ep->urbs[i]->transfer_dma);
 		if (!buffer) {
-			snd_usbmidi_in_endpoint_delete(ep);
-			return -ENOMEM;
+			err = -ENOMEM;
+			goto error;
 		}
 		if (ep_info->in_interval)
 			usb_fill_int_urb(ep->urbs[i], umidi->dev,
@@ -1318,10 +1319,20 @@ static int snd_usbmidi_in_endpoint_create(struct snd_usb_midi *umidi,
 					  pipe, buffer, length,
 					  snd_usbmidi_in_urb_complete, ep);
 		ep->urbs[i]->transfer_flags = URB_NO_TRANSFER_DMA_MAP;
+		err = usb_urb_ep_type_check(ep->urbs[i]);
+		if (err < 0) {
+			dev_err(&umidi->dev->dev, "invalid MIDI in EP %x\n",
+				ep_info->in_ep);
+			goto error;
+		}
 	}
 
 	rep->in = ep;
 	return 0;
+
+ error:
+	snd_usbmidi_in_endpoint_delete(ep);
+	return -ENOMEM;
 }
 
 /*
@@ -1357,6 +1368,7 @@ static int snd_usbmidi_out_endpoint_create(struct snd_usb_midi *umidi,
 	unsigned int i;
 	unsigned int pipe;
 	void *buffer;
+	int err;
 
 	rep->out = NULL;
 	ep = kzalloc(sizeof(*ep), GFP_KERNEL);
@@ -1367,8 +1379,8 @@ static int snd_usbmidi_out_endpoint_create(struct snd_usb_midi *umidi,
 	for (i = 0; i < OUTPUT_URBS; ++i) {
 		ep->urbs[i].urb = usb_alloc_urb(0, GFP_KERNEL);
 		if (!ep->urbs[i].urb) {
-			snd_usbmidi_out_endpoint_delete(ep);
-			return -ENOMEM;
+			err = -ENOMEM;
+			goto error;
 		}
 		ep->urbs[i].ep = ep;
 	}
@@ -1406,8 +1418,8 @@ static int snd_usbmidi_out_endpoint_create(struct snd_usb_midi *umidi,
 					    ep->max_transfer, GFP_KERNEL,
 					    &ep->urbs[i].urb->transfer_dma);
 		if (!buffer) {
-			snd_usbmidi_out_endpoint_delete(ep);
-			return -ENOMEM;
+			err = -ENOMEM;
+			goto error;
 		}
 		if (ep_info->out_interval)
 			usb_fill_int_urb(ep->urbs[i].urb, umidi->dev,
@@ -1419,6 +1431,12 @@ static int snd_usbmidi_out_endpoint_create(struct snd_usb_midi *umidi,
 					  pipe, buffer, ep->max_transfer,
 					  snd_usbmidi_out_urb_complete,
 					  &ep->urbs[i]);
+		err = usb_urb_ep_type_check(ep->urbs[i].urb);
+		if (err < 0) {
+			dev_err(&umidi->dev->dev, "invalid MIDI out EP %x\n",
+				ep_info->out_ep);
+			goto error;
+		}
 		ep->urbs[i].urb->transfer_flags = URB_NO_TRANSFER_DMA_MAP;
 	}
 
@@ -1437,6 +1455,10 @@ static int snd_usbmidi_out_endpoint_create(struct snd_usb_midi *umidi,
 
 	rep->out = ep;
 	return 0;
+
+ error:
+	snd_usbmidi_out_endpoint_delete(ep);
+	return err;
 }
 
 /*
-- 
2.14.2
