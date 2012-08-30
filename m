From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/3] ALSA: snd-usb: fix calls to
	next_packet_size
Date: Thu, 30 Aug 2012 18:52:30 +0200
Message-ID: <1346345551-8956-3-git-send-email-zonque@gmail.com>
References: <1346345551-8956-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id DF27B2660BB
 for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2012 18:52:56 +0200 (CEST)
In-Reply-To: <1346345551-8956-1-git-send-email-zonque@gmail.com>
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
Cc: tiwai@suse.de, clemens@ladisch.de, linuxaudio@showlabor.de, Daniel Mack <zonque@gmail.com>, "[v3.5+]"@mail.zonque.de, linux@romal.de, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

In order to support devices with implicit feedback streaming models,
packet sizes are now stored with each individual urb, and the PCM
handling code which fills the buffers purely relies on the size fields
now.

However, calling snd_usb_audio_next_packet_size() for all possible
packets in an URB at once, prior to letting the PCM code do its job
does in fact not lead to the same behaviour than what the old code did:
The PCM code will break its loop once a period boundary is reached,
consequently using up less packets that it really could.

As snd_usb_audio_next_packet_size() implements a feedback mechanism to
the endpoints phase accumulator, the number of calls to that function
matters, and when called too often, the data rate runs out of bounds.

Fix this by making the next_packet function public, and call it from the
PCM code as before if the packet data sizes are not defined.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: stable@kernel.org [v3.5+]
---
 sound/usb/endpoint.c | 13 +------------
 sound/usb/endpoint.h |  1 +
 sound/usb/pcm.c      |  7 ++++++-
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index b896c55..d6e2bb4 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -141,7 +141,7 @@ int snd_usb_endpoint_implict_feedback_sink(struct snd_usb_endpoint *ep)
  *
  * For implicit feedback, next_packet_size() is unused.
  */
-static int next_packet_size(struct snd_usb_endpoint *ep)
+int snd_usb_endpoint_next_packet_size(struct snd_usb_endpoint *ep)
 {
 	unsigned long flags;
 	int ret;
@@ -177,15 +177,6 @@ static void retire_inbound_urb(struct snd_usb_endpoint *ep,
 		ep->retire_data_urb(ep->data_subs, urb);
 }
 
-static void prepare_outbound_urb_sizes(struct snd_usb_endpoint *ep,
-				       struct snd_urb_ctx *ctx)
-{
-	int i;
-
-	for (i = 0; i < ctx->packets; ++i)
-		ctx->packet_size[i] = next_packet_size(ep);
-}
-
 /*
  * Prepare a PLAYBACK urb for submission to the bus.
  */
@@ -370,7 +361,6 @@ static void snd_complete_urb(struct urb *urb)
 			goto exit_clear;
 		}
 
-		prepare_outbound_urb_sizes(ep, ctx);
 		prepare_outbound_urb(ep, ctx);
 	} else {
 		retire_inbound_urb(ep, ctx);
@@ -857,7 +847,6 @@ int snd_usb_endpoint_start(struct snd_usb_endpoint *ep, int can_sleep)
 			goto __error;
 
 		if (usb_pipeout(ep->pipe)) {
-			prepare_outbound_urb_sizes(ep, urb->context);
 			prepare_outbound_urb(ep, urb->context);
 		} else {
 			prepare_inbound_urb(ep, urb->context);
diff --git a/sound/usb/endpoint.h b/sound/usb/endpoint.h
index a8e60c1..cbbbdf2 100644
--- a/sound/usb/endpoint.h
+++ b/sound/usb/endpoint.h
@@ -21,6 +21,7 @@ int  snd_usb_endpoint_deactivate(struct snd_usb_endpoint *ep);
 void snd_usb_endpoint_free(struct list_head *head);
 
 int snd_usb_endpoint_implict_feedback_sink(struct snd_usb_endpoint *ep);
+int snd_usb_endpoint_next_packet_size(struct snd_usb_endpoint *ep);
 
 void snd_usb_handle_sync_urb(struct snd_usb_endpoint *ep,
 			     struct snd_usb_endpoint *sender,
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 5ceb8f1..e80b668 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1029,6 +1029,7 @@ static void prepare_playback_urb(struct snd_usb_substream *subs,
 				 struct urb *urb)
 {
 	struct snd_pcm_runtime *runtime = subs->pcm_substream->runtime;
+	struct snd_usb_endpoint *ep = subs->data_endpoint;
 	struct snd_urb_ctx *ctx = urb->context;
 	unsigned int counts, frames, bytes;
 	int i, stride, period_elapsed = 0;
@@ -1040,7 +1041,11 @@ static void prepare_playback_urb(struct snd_usb_substream *subs,
 	urb->number_of_packets = 0;
 	spin_lock_irqsave(&subs->lock, flags);
 	for (i = 0; i < ctx->packets; i++) {
-		counts = ctx->packet_size[i];
+		if (ctx->packet_size[i])
+			counts = ctx->packet_size[i];
+		else
+			counts = snd_usb_endpoint_next_packet_size(ep);
+
 		/* set up descriptor */
 		urb->iso_frame_desc[i].offset = frames * stride;
 		urb->iso_frame_desc[i].length = counts * stride;
-- 
1.7.11.4
