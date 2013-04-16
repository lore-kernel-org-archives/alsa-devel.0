From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v3 3/5] ALSA: snd-usb: add support for DSD DOP
	stream transport
Date: Wed, 17 Apr 2013 00:01:38 +0800
Message-ID: <1366128100-9778-4-git-send-email-zonque@gmail.com>
References: <1366128100-9778-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 74C162610B7
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 18:01:53 +0200 (CEST)
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

In order to provide a compatibility way for pushing DSD
samples through ordinary PCM channels, the "DoP open Standard" was
invented. See http://www.dsd-guide.com for the official document.

The host is required to stuff DSD marker bytes (0x05, 0xfa,
alternating) in the MSB of 24 bit wide samples on the bus, in addition
to the 16 bits of actual DSD sample payload.

To support this, the hardware and software stride logic in the driver
has to be tweaked a bit, as we make the userspace believe we're
operating on 16 bit samples, while we in fact push one more byte per
channel down to the hardware.

The DOP runtime information is stored in struct snd_usb_substream, so
we can keep track of our state across multiple calls to
prepare_playback_urb_dsd_dop().

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/card.h     |    7 ++++
 sound/usb/endpoint.c |    9 ++++++
 sound/usb/pcm.c      |   87 +++++++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 92 insertions(+), 11 deletions(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index 8a751b4..2c05cb7 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -28,6 +28,7 @@ struct audioformat {
 	unsigned int *rate_table;	/* rate table */
 	unsigned char clock;		/* associated clock */
 	struct snd_pcm_chmap_elem *chmap; /* (optional) channel map */
+	bool dsd_dop;			/* add DOP headers in case of DSD samples */
 };
 
 struct snd_usb_substream;
@@ -138,6 +139,12 @@ struct snd_usb_substream {
 
 	int last_frame_number;          /* stored frame number */
 	int last_delay;                 /* stored delay */
+
+	struct {
+		int marker;
+		int channel;
+		int byte_idx;
+	} dsd_dop;
 };
 
 struct snd_usb_stream {
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 7e9c55a..32d0b41 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -578,6 +578,15 @@ static int data_ep_set_params(struct snd_usb_endpoint *ep,
 	int is_playback = usb_pipeout(ep->pipe);
 	int frame_bits = snd_pcm_format_physical_width(pcm_format) * channels;
 
+	if (pcm_format == SNDRV_PCM_FORMAT_DSD_U16_LE && fmt->dsd_dop) {
+		/*
+		 * When operating in DSD DOP mode, the size of a sample frame
+		 * in hardware differs from the actual physical format width
+		 * because we need to make room for the DOP markers.
+		 */
+		frame_bits += channels << 3;
+	}
+
 	ep->datainterval = fmt->datainterval;
 	ep->stride = frame_bits >> 3;
 	ep->silence_value = pcm_format == SNDRV_PCM_FORMAT_U8 ? 0x80 : 0;
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 6f85202..b5eae93 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1120,6 +1120,12 @@ static int snd_usb_pcm_open(struct snd_pcm_substream *substream, int direction)
 	runtime->private_data = subs;
 	subs->pcm_substream = substream;
 	/* runtime PM is also done there */
+
+	/* initialize DSD/DOP context */
+	subs->dsd_dop.byte_idx = 0;
+	subs->dsd_dop.channel = 0;
+	subs->dsd_dop.marker = 1;
+
 	return setup_hw_info(runtime, subs);
 }
 
@@ -1214,6 +1220,56 @@ static void retire_capture_urb(struct snd_usb_substream *subs,
 		snd_pcm_period_elapsed(subs->pcm_substream);
 }
 
+static inline void fill_playback_urb_dsd_dop(struct snd_usb_substream *subs,
+					     struct urb *urb, unsigned int bytes)
+{
+	struct snd_pcm_runtime *runtime = subs->pcm_substream->runtime;
+	unsigned int stride = runtime->frame_bits >> 3;
+	unsigned int dst_idx = 0;
+	unsigned int src_idx = subs->hwptr_done;
+	unsigned int wrap = runtime->buffer_size * stride;
+	u8 *dst = urb->transfer_buffer;
+	u8 *src = runtime->dma_area;
+	u8 marker[] = { 0x05, 0xfa };
+
+	/*
+	 * The DSP DOP format defines a way to transport DSD samples over
+	 * normal PCM data endpoints. It requires stuffing of marker bytes
+	 * (0x05 and 0xfa, alternating per sample frame), and then expects
+	 * 2 additional bytes of actual payload. The whole frame is stored
+	 * LSB.
+	 *
+	 * Hence, for a stereo transport, the buffer layout looks like this,
+	 * where L refers to left channel samples and R to right.
+	 *
+	 *   L1 L2 0x05   R1 R2 0x05   L3 L4 0xfa  R3 R4 0xfa
+	 *   L5 L6 0x05   R5 R6 0x05   L7 L8 0xfa  R7 R8 0xfa
+	 *   .....
+	 *
+	 */
+
+	while (bytes--) {
+		if (++subs->dsd_dop.byte_idx == 3) {
+			/* frame boundary? */
+			dst[dst_idx++] = marker[subs->dsd_dop.marker];
+			src_idx += 2;
+			subs->dsd_dop.byte_idx = 0;
+
+			if (++subs->dsd_dop.channel % runtime->channels == 0) {
+				/* alternate the marker */
+				subs->dsd_dop.marker++;
+				subs->dsd_dop.marker %= ARRAY_SIZE(marker);
+				subs->dsd_dop.channel = 0;
+			}
+		} else {
+			/* stuff the DSD payload */
+			int idx = (src_idx + subs->dsd_dop.byte_idx - 1) % wrap;
+			dst[dst_idx++] = src[idx];
+			subs->hwptr_done++;
+		}
+	}
+}
+
 static void prepare_playback_urb(struct snd_usb_substream *subs,
 				 struct urb *urb)
 {
@@ -1270,19 +1326,28 @@ static void prepare_playback_urb(struct snd_usb_substream *subs,
 			break;
 	}
 	bytes = frames * ep->stride;
-	if (subs->hwptr_done + bytes > runtime->buffer_size * stride) {
-		/* err, the transferred area goes over buffer boundary. */
-		unsigned int bytes1 =
-			runtime->buffer_size * stride - subs->hwptr_done;
-		memcpy(urb->transfer_buffer,
-		       runtime->dma_area + subs->hwptr_done, bytes1);
-		memcpy(urb->transfer_buffer + bytes1,
-		       runtime->dma_area, bytes - bytes1);
+
+	if (unlikely(subs->pcm_format == SNDRV_PCM_FORMAT_DSD_U16_LE &&
+		     subs->cur_audiofmt->dsd_dop)) {
+		fill_playback_urb_dsd_dop(subs, urb, bytes);
 	} else {
-		memcpy(urb->transfer_buffer,
-		       runtime->dma_area + subs->hwptr_done, bytes);
+		/* usual PCM */
+		if (subs->hwptr_done + bytes > runtime->buffer_size * stride) {
+			/* err, the transferred area goes over buffer boundary. */
+			unsigned int bytes1 =
+				runtime->buffer_size * stride - subs->hwptr_done;
+			memcpy(urb->transfer_buffer,
+			       runtime->dma_area + subs->hwptr_done, bytes1);
+			memcpy(urb->transfer_buffer + bytes1,
+			       runtime->dma_area, bytes - bytes1);
+		} else {
+			memcpy(urb->transfer_buffer,
+			       runtime->dma_area + subs->hwptr_done, bytes);
+		}
+
+		subs->hwptr_done += bytes;
 	}
-	subs->hwptr_done += bytes;
+
 	if (subs->hwptr_done >= runtime->buffer_size * stride)
 		subs->hwptr_done -= runtime->buffer_size * stride;
 
-- 
1.7.10.4
