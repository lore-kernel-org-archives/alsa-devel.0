From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] usb-audio: don't use empty packets at start of playback
Date: Thu, 12 Jan 2006 09:44:29 +0100
Message-ID: <20060112084429.GA18332@turing.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: stable@kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Some widespread USB interface chips with adaptive iso endpoints hang
after receiving a series of empty packets when they expect data.  This
completely disables audio playback on those devices.  To avoid this, we
have to send packets containing silence (zero samples) instead.

ALSA bug: http://bugtrack.alsa-project.org/alsa-bug/view.php?id=1585

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

Index: linux-2.6.15/sound/usb/usbaudio.c
===================================================================
--- linux-2.6.15.orig/sound/usb/usbaudio.c	2006-01-06 16:11:26.000000000 +0100
+++ linux-2.6.15/sound/usb/usbaudio.c	2006-01-11 19:29:18.000000000 +0100
@@ -480,22 +480,38 @@ static int retire_playback_sync_urb_hs(s
 /*
  * Prepare urb for streaming before playback starts.
  *
- * We don't care about (or have) any data, so we just send a transfer delimiter.
+ * We don't yet have data, so we send a frame of silence.
  */
 static int prepare_startup_playback_urb(snd_usb_substream_t *subs,
 					snd_pcm_runtime_t *runtime,
 					struct urb *urb)
 {
-	unsigned int i;
+	unsigned int i, offs, counts;
 	snd_urb_ctx_t *ctx = urb->context;
+	int stride = runtime->frame_bits >> 3;
 
+	offs = 0;
 	urb->dev = ctx->subs->dev;
 	urb->number_of_packets = subs->packs_per_ms;
 	for (i = 0; i < subs->packs_per_ms; ++i) {
-		urb->iso_frame_desc[i].offset = 0;
-		urb->iso_frame_desc[i].length = 0;
+		/* calculate the size of a packet */
+		if (subs->fill_max)
+			counts = subs->maxframesize; /* fixed */
+		else {
+			subs->phase = (subs->phase & 0xffff)
+				+ (subs->freqm << subs->datainterval);
+			counts = subs->phase >> 16;
+			if (counts > subs->maxframesize)
+				counts = subs->maxframesize;
+		}
+		urb->iso_frame_desc[i].offset = offs * stride;
+		urb->iso_frame_desc[i].length = counts * stride;
+		offs += counts;
 	}
-	urb->transfer_buffer_length = 0;
+	urb->transfer_buffer_length = offs * stride;
+	memset(urb->transfer_buffer,
+	       subs->cur_audiofmt->format == SNDRV_PCM_FORMAT_U8 ? 0x80 : 0,
+	       offs * stride);
 	return 0;
 }
 


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
