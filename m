From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/9] ALSA: line6: use usb_fill_int_urb()
Date: Tue, 19 Jun 2018 23:55:14 +0200
Message-ID: <20180619215521.13688-3-bigeasy@linutronix.de>
References: <20180619215521.13688-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from Galois.linutronix.de (galois.linutronix.de [146.0.238.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 95F1D2675EC
 for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2018 23:55:31 +0200 (CEST)
In-Reply-To: <20180619215521.13688-1-bigeasy@linutronix.de>
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
Cc: tglx@linutronix.de, linux-usb@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: alsa-devel@alsa-project.org

Using usb_fill_int_urb() helps to find code which initializes an
URB. A grep for members of the struct (like ->complete) reveal lots
of other things, too.
Data pointer & size is filled out later so they are not considered.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 sound/usb/line6/capture.c  | 16 ++++++----------
 sound/usb/line6/playback.c | 16 ++++++----------
 2 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index d8a14d769f48..4ee54ba436df 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -52,7 +52,6 @@ static int submit_audio_in_urb(struct snd_line6_pcm *line6pcm)
 	    line6pcm->in.buffer +
 	    index * LINE6_ISO_PACKETS * line6pcm->max_packet_size_in;
 	urb_in->transfer_buffer_length = urb_size;
-	urb_in->context = line6pcm;
 
 	ret = usb_submit_urb(urb_in, GFP_ATOMIC);
 
@@ -280,17 +279,14 @@ int line6_create_audio_in_urbs(struct snd_line6_pcm *line6pcm)
 		if (urb == NULL)
 			return -ENOMEM;
 
-		urb->dev = line6->usbdev;
-		urb->pipe =
-		    usb_rcvisocpipe(line6->usbdev,
-				    line6->properties->ep_audio_r &
-				    USB_ENDPOINT_NUMBER_MASK);
+		usb_fill_int_urb(urb, line6->usbdev,
+				 usb_rcvisocpipe(line6->usbdev,
+						 line6->properties->ep_audio_r &
+						 USB_ENDPOINT_NUMBER_MASK),
+				 NULL, 0, audio_in_callback, line6pcm,
+				 LINE6_ISO_INTERVAL);
 		urb->transfer_flags = URB_ISO_ASAP;
-		urb->start_frame = -1;
 		urb->number_of_packets = LINE6_ISO_PACKETS;
-		urb->interval = LINE6_ISO_INTERVAL;
-		urb->error_count = 0;
-		urb->complete = audio_in_callback;
 	}
 
 	return 0;
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index dec89d2beb57..af1ca09c260e 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -202,7 +202,6 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 	    line6pcm->out.buffer +
 	    index * LINE6_ISO_PACKETS * line6pcm->max_packet_size_out;
 	urb_out->transfer_buffer_length = urb_size;
-	urb_out->context = line6pcm;
 
 	if (test_bit(LINE6_STREAM_PCM, &line6pcm->out.running) &&
 	    !test_bit(LINE6_FLAG_PAUSE_PLAYBACK, &line6pcm->flags)) {
@@ -425,17 +424,14 @@ int line6_create_audio_out_urbs(struct snd_line6_pcm *line6pcm)
 		if (urb == NULL)
 			return -ENOMEM;
 
-		urb->dev = line6->usbdev;
-		urb->pipe =
-		    usb_sndisocpipe(line6->usbdev,
-				    line6->properties->ep_audio_w &
-				    USB_ENDPOINT_NUMBER_MASK);
+		usb_fill_int_urb(urb, line6->usbdev,
+				 usb_sndisocpipe(line6->usbdev,
+						 line6->properties->ep_audio_w &
+						 USB_ENDPOINT_NUMBER_MASK),
+				 NULL, 0, audio_out_callback, line6pcm,
+				 LINE6_ISO_INTERVAL);
 		urb->transfer_flags = URB_ISO_ASAP;
-		urb->start_frame = -1;
 		urb->number_of_packets = LINE6_ISO_PACKETS;
-		urb->interval = LINE6_ISO_INTERVAL;
-		urb->error_count = 0;
-		urb->complete = audio_out_callback;
 	}
 
 	return 0;
-- 
2.17.1
