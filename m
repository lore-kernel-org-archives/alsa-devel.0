From: Greg KH <gregkh@suse.de>
Subject: [patch 01/12] usb-audio: don't use empty packets at start of playback
Date: Fri, 27 Jan 2006 18:20:36 -0800
Message-ID: <20060128022036.GB17001@kroah.com>
References: <20060128020629.908825000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422800AbWA1C0u@vger.kernel.org>
Content-Disposition: inline; filename="usb-audio-dont-use-empty-packets-at-start-of-playback.patch"
In-Reply-To: <20060128022023.GA17001@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, clemens@ladisch.de, tiwai@suse.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

2.6.15.2 -stable review patch.  If anyone has any objections, please let
us know.

------------------

From: Clemens Ladisch <clemens@ladisch.de>

Some widespread USB interface chips with adaptive iso endpoints hang
after receiving a series of empty packets when they expect data.  This
completely disables audio playback on those devices.  To avoid this, we
have to send packets containing silence (zero samples) instead.

ALSA bug: http://bugtrack.alsa-project.org/alsa-bug/view.php?id=1585

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 sound/usb/usbaudio.c |   26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

--- linux-2.6.15.1.orig/sound/usb/usbaudio.c
+++ linux-2.6.15.1/sound/usb/usbaudio.c
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
 

--
