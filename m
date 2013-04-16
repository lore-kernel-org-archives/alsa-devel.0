From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v3 2/5] ALSA: snd-usb: use ep->stride from urb
	callbacks
Date: Wed, 17 Apr 2013 00:01:37 +0800
Message-ID: <1366128100-9778-3-git-send-email-zonque@gmail.com>
References: <1366128100-9778-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BFA42610B2
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 18:01:52 +0200 (CEST)
In-Reply-To: <1366128100-9778-1-git-send-email-zonque@gmail.com>
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
Cc: tiwai@suse.de, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>, demian@auraliti.com, ray@auraliti.com, andreas@akdesigninc.com
List-Id: alsa-devel@alsa-project.org

For normal PCM transfer, this change has no effect, as the endpoint's
stride is always frame_bits/8. For DSD DOP streams, however, which is
added later, the hardware stride differs from the software stride, and
the endpoint has the correct information in these cases.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/pcm.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 815a37d..6f85202 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1236,8 +1236,8 @@ static void prepare_playback_urb(struct snd_usb_substream *subs,
 			counts = snd_usb_endpoint_next_packet_size(ep);
 
 		/* set up descriptor */
-		urb->iso_frame_desc[i].offset = frames * stride;
-		urb->iso_frame_desc[i].length = counts * stride;
+		urb->iso_frame_desc[i].offset = frames * ep->stride;
+		urb->iso_frame_desc[i].length = counts * ep->stride;
 		frames += counts;
 		urb->number_of_packets++;
 		subs->transfer_done += counts;
@@ -1251,14 +1251,14 @@ static void prepare_playback_urb(struct snd_usb_substream *subs,
 					frames -= subs->transfer_done;
 					counts -= subs->transfer_done;
 					urb->iso_frame_desc[i].length =
-						counts * stride;
+						counts * ep->stride;
 					subs->transfer_done = 0;
 				}
 				i++;
 				if (i < ctx->packets) {
 					/* add a transfer delimiter */
 					urb->iso_frame_desc[i].offset =
-						frames * stride;
+						frames * ep->stride;
 					urb->iso_frame_desc[i].length = 0;
 					urb->number_of_packets++;
 				}
@@ -1269,7 +1269,7 @@ static void prepare_playback_urb(struct snd_usb_substream *subs,
 		    !snd_usb_endpoint_implicit_feedback_sink(subs->data_endpoint)) /* finish at the period boundary */
 			break;
 	}
-	bytes = frames * stride;
+	bytes = frames * ep->stride;
 	if (subs->hwptr_done + bytes > runtime->buffer_size * stride) {
 		/* err, the transferred area goes over buffer boundary. */
 		unsigned int bytes1 =
@@ -1310,8 +1310,8 @@ static void retire_playback_urb(struct snd_usb_substream *subs,
 {
 	unsigned long flags;
 	struct snd_pcm_runtime *runtime = subs->pcm_substream->runtime;
-	int stride = runtime->frame_bits >> 3;
-	int processed = urb->transfer_buffer_length / stride;
+	struct snd_usb_endpoint *ep = subs->data_endpoint;
+	int processed = urb->transfer_buffer_length / ep->stride;
 	int est_delay;
 
 	/* ignore the delay accounting when procssed=0 is given, i.e.
-- 
1.7.10.4
