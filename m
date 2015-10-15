From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: [PATCH 5/7] ALSA: USB-audio: Add quirk for Zoom R16
	playback
Date: Thu, 15 Oct 2015 12:57:35 +0200
Message-ID: <1444906657-16791-6-git-send-email-ricardw@axis.com>
References: <1444906657-16791-1-git-send-email-ricardw@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id AE962260464
 for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2015 12:57:40 +0200 (CEST)
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

Stuff 4 byte (S32_LE) length descriptor at the start of each isochronous
packet.

Tested with Zoom R16, full duplex.

Signed-off-by: Ricard Wanderlof <ricardw@axis.com>
---
 sound/usb/card.h         |  1 +
 sound/usb/endpoint.c     | 25 ++++++++++++++++++++-----
 sound/usb/pcm.c          | 32 +++++++++++++++++++++++++++++++-
 sound/usb/quirks-table.h |  7 ++++---
 sound/usb/quirks.c       |  3 +++
 sound/usb/stream.c       |  1 +
 sound/usb/usbaudio.h     |  1 +
 7 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index ef580b4..71778ca 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -122,6 +122,7 @@ struct snd_usb_substream {
 	unsigned int buffer_periods;	/* current periods per buffer */
 	unsigned int altset_idx;     /* USB data format: index of alternate setting */
 	unsigned int txfr_quirk:1;	/* allow sub-frame alignment */
+	unsigned int tx_length_quirk:1;	/* add length specifier to transfers */
 	unsigned int fmt_type;		/* USB audio format type (1-3) */
 	unsigned int pkt_offset_adj;	/* Bytes to drop from beginning of packets (for non-compliant devices) */
 
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 825a06c..1c5280a 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -188,9 +188,17 @@ static void prepare_silent_urb(struct snd_usb_endpoint *ep,
 {
 	struct urb *urb = ctx->urb;
 	unsigned int offs = 0;
+	unsigned int extra = 0;
+	u32 packet_length;
 	int i;
 
+	/* For tx_length_quirk, put packet length at start of packet */
+	if (ep->chip->tx_length_quirk)
+		extra = sizeof(packet_length);
+
 	for (i = 0; i < ctx->packets; ++i) {
+		unsigned int offset;
+		unsigned int length;
 		int counts;
 
 		if (ctx->packet_size[i])
@@ -198,15 +206,22 @@ static void prepare_silent_urb(struct snd_usb_endpoint *ep,
 		else
 			counts = snd_usb_endpoint_next_packet_size(ep);
 
-		urb->iso_frame_desc[i].offset = offs * ep->stride;
-		urb->iso_frame_desc[i].length = counts * ep->stride;
+		length = counts * ep->stride; /* number of silent bytes */
+		offset = offs * ep->stride + extra * i;
+		urb->iso_frame_desc[i].offset = offset;
+		urb->iso_frame_desc[i].length = length + extra;
+		if (extra) {
+			packet_length = cpu_to_le32(length);
+			memcpy(urb->transfer_buffer + offset,
+			       &packet_length, sizeof(packet_length));
+		}
+		memset(urb->transfer_buffer + offset + extra,
+		       ep->silence_value, length);
 		offs += counts;
 	}
 
 	urb->number_of_packets = ctx->packets;
-	urb->transfer_buffer_length = offs * ep->stride;
-	memset(urb->transfer_buffer, ep->silence_value,
-	       offs * ep->stride);
+	urb->transfer_buffer_length = offs * ep->stride + ctx->packets * extra;
 }
 
 /*
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index e3c5bc0..ec3d381 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1409,6 +1409,32 @@ static void copy_to_urb(struct snd_usb_substream *subs, struct urb *urb,
 		subs->hwptr_done -= runtime->buffer_size * stride;
 }
 
+static unsigned int copy_to_urb_quirk(struct snd_usb_substream *subs,
+				      struct urb *urb, int stride,
+				      unsigned int bytes)
+{
+	u32 packet_length;
+	int i;
+
+	/* Put U32_LE length descriptor at start of each packet. */
+	for (i = 0; i < urb->number_of_packets; i++) {
+		unsigned int length = urb->iso_frame_desc[i].length;
+		unsigned int offset = urb->iso_frame_desc[i].offset;
+
+		packet_length = cpu_to_le32(length);
+		offset += i * sizeof(packet_length);
+		urb->iso_frame_desc[i].offset = offset;
+		urb->iso_frame_desc[i].length += sizeof(packet_length);
+		memcpy(urb->transfer_buffer + offset,
+		       &packet_length, sizeof(packet_length));
+		copy_to_urb(subs, urb, offset + sizeof(packet_length),
+			    stride, length);
+	}
+	/* Adjust transfer size accordingly. */
+	bytes += urb->number_of_packets * sizeof(packet_length);
+	return bytes;
+}
+
 static void prepare_playback_urb(struct snd_usb_substream *subs,
 				 struct urb *urb)
 {
@@ -1488,7 +1514,11 @@ static void prepare_playback_urb(struct snd_usb_substream *subs,
 			subs->hwptr_done -= runtime->buffer_size * stride;
 	} else {
 		/* usual PCM */
-		copy_to_urb(subs, urb, 0, stride, bytes);
+		if (!subs->tx_length_quirk)
+			copy_to_urb(subs, urb, 0, stride, bytes);
+		else
+			bytes = copy_to_urb_quirk(subs, urb, stride, bytes);
+			/* bytes is now amount of outgoing data */
 	}
 
 	/* update delay with exact number of samples queued */
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index e475665..4a8ca637 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3184,8 +3184,9 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950Q"),
 	 * ZOOM R16/24 in audio interface mode.
 	 * Mixer descriptors are garbage, further quirks will be needed
 	 * to make any of it functional, thus disabled for now.
-	 * Playback stream appears to start and run fine but no sound
-	 * is produced, so also disabled for now.
+	 * Playback requires an extra four byte LE length indicator
+	 * at the start of each isochronous packet. This quirk is
+	 * enabled in create_standard_audio_quirk().
 	 */
 	USB_DEVICE(0x1686, 0x00dd),
 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
@@ -3200,7 +3201,7 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950Q"),
 			{
 				/* Playback  */
 				.ifnum = 1,
-				.type = QUIRK_IGNORE_INTERFACE,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE,
 			},
 			{
 				/* Capture */
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 00ebc0c..79a9540 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -115,6 +115,9 @@ static int create_standard_audio_quirk(struct snd_usb_audio *chip,
 	struct usb_interface_descriptor *altsd;
 	int err;
 
+	if (chip->usb_id == USB_ID(0x1686, 0x00dd)) /* Zoom R16 */
+		chip->tx_length_quirk = 1;
+
 	alts = &iface->altsetting[0];
 	altsd = get_iface_desc(alts);
 	err = snd_usb_parse_audio_interface(chip, altsd->bInterfaceNumber);
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 9700860..8ee14f2 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -92,6 +92,7 @@ static void snd_usb_init_substream(struct snd_usb_stream *as,
 	subs->direction = stream;
 	subs->dev = as->chip->dev;
 	subs->txfr_quirk = as->chip->txfr_quirk;
+	subs->tx_length_quirk = as->chip->tx_length_quirk;
 	subs->speed = snd_usb_get_speed(subs->dev);
 	subs->pkt_offset_adj = 0;
 
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 33a1764..15a1271 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -43,6 +43,7 @@ struct snd_usb_audio {
 	atomic_t usage_count;
 	wait_queue_head_t shutdown_wait;
 	unsigned int txfr_quirk:1; /* Subframe boundaries on transfers */
+	unsigned int tx_length_quirk:1; /* Put length specifier in transfers */
 	
 	int num_interfaces;
 	int num_suspended_intf;
-- 
2.1.4
