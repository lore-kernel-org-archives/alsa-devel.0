From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: [PATCH 3/7] ALSA: USB-audio: Break out creation of
	silent urbs from prepare_outbound_urb()
Date: Thu, 15 Oct 2015 12:57:33 +0200
Message-ID: <1444906657-16791-4-git-send-email-ricardw@axis.com>
References: <1444906657-16791-1-git-send-email-ricardw@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 90B9C26049A
 for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2015 12:57:42 +0200 (CEST)
In-Reply-To: <1444906657-16791-1-git-send-email-ricardw@axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Ricard Wanderlof <ricardw@axis.com>, Ricard Wanderlof <ricard2005@butoba.net>
List-Id: alsa-devel@alsa-project.org

Refactoring in preparation for adding Zoom R16 quirk.

Signed-off-by: Ricard Wanderlof <ricardw@axis.com>
---
 sound/usb/endpoint.c | 46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index a77d9c8..825a06c 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -183,13 +183,38 @@ static void retire_inbound_urb(struct snd_usb_endpoint *ep,
 		ep->retire_data_urb(ep->data_subs, urb);
 }
 
+static void prepare_silent_urb(struct snd_usb_endpoint *ep,
+			       struct snd_urb_ctx *ctx)
+{
+	struct urb *urb = ctx->urb;
+	unsigned int offs = 0;
+	int i;
+
+	for (i = 0; i < ctx->packets; ++i) {
+		int counts;
+
+		if (ctx->packet_size[i])
+			counts = ctx->packet_size[i];
+		else
+			counts = snd_usb_endpoint_next_packet_size(ep);
+
+		urb->iso_frame_desc[i].offset = offs * ep->stride;
+		urb->iso_frame_desc[i].length = counts * ep->stride;
+		offs += counts;
+	}
+
+	urb->number_of_packets = ctx->packets;
+	urb->transfer_buffer_length = offs * ep->stride;
+	memset(urb->transfer_buffer, ep->silence_value,
+	       offs * ep->stride);
+}
+
 /*
  * Prepare a PLAYBACK urb for submission to the bus.
  */
 static void prepare_outbound_urb(struct snd_usb_endpoint *ep,
 				 struct snd_urb_ctx *ctx)
 {
-	int i;
 	struct urb *urb = ctx->urb;
 	unsigned char *cp = urb->transfer_buffer;
 
@@ -201,24 +226,7 @@ static void prepare_outbound_urb(struct snd_usb_endpoint *ep,
 			ep->prepare_data_urb(ep->data_subs, urb);
 		} else {
 			/* no data provider, so send silence */
-			unsigned int offs = 0;
-			for (i = 0; i < ctx->packets; ++i) {
-				int counts;
-
-				if (ctx->packet_size[i])
-					counts = ctx->packet_size[i];
-				else
-					counts = snd_usb_endpoint_next_packet_size(ep);
-
-				urb->iso_frame_desc[i].offset = offs * ep->stride;
-				urb->iso_frame_desc[i].length = counts * ep->stride;
-				offs += counts;
-			}
-
-			urb->number_of_packets = ctx->packets;
-			urb->transfer_buffer_length = offs * ep->stride;
-			memset(urb->transfer_buffer, ep->silence_value,
-			       offs * ep->stride);
+			prepare_silent_urb(ep, ctx);
 		}
 		break;
 
-- 
2.1.4
