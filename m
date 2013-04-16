From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v3 4/5] ALSA: snd-usb: add support for
	bit-reversed byte formats
Date: Wed, 17 Apr 2013 00:01:39 +0800
Message-ID: <1366128100-9778-5-git-send-email-zonque@gmail.com>
References: <1366128100-9778-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id AA0402610A8
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 18:01:54 +0200 (CEST)
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

There is quite some confusion around the bit-ordering in DSD samples,
and no general agreement that defines whether hardware is supposed to
expect the oldest sample in the MSB or the LSB of a byte.

ALSA will hence set the rule that on the software API layer, bytes
always carry the oldest bit in the most significant bit of a byte, and
the driver has to translate that at runtime in order to match the
hardware layout.

This patch adds support for this by adding a boolean flag to the
audio format struct.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/card.h |    1 +
 sound/usb/pcm.c  |   19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index 2c05cb7..fcae411 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -29,6 +29,7 @@ struct audioformat {
 	unsigned char clock;		/* associated clock */
 	struct snd_pcm_chmap_elem *chmap; /* (optional) channel map */
 	bool dsd_dop;			/* add DOP headers in case of DSD samples */
+	bool dsd_bitrev;		/* reverse the bits of each DSD sample */
 };
 
 struct snd_usb_substream;
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index b5eae93..c31980c 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -16,6 +16,7 @@
 
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/bitrev.h>
 #include <linux/ratelimit.h>
 #include <linux/usb.h>
 #include <linux/usb/audio.h>
@@ -1264,7 +1265,12 @@ static inline void fill_playback_urb_dsd_dop(struct snd_usb_substream *subs,
 		} else {
 			/* stuff the DSD payload */
 			int idx = (src_idx + subs->dsd_dop.byte_idx - 1) % wrap;
-			dst[dst_idx++] = src[idx];
+
+			if (subs->cur_audiofmt->dsd_bitrev)
+				dst[dst_idx++] = bitrev8(src[idx]);
+			else
+				dst[dst_idx++] = src[idx];
+
 			subs->hwptr_done++;
 		}
 	}
@@ -1330,6 +1336,17 @@ static void prepare_playback_urb(struct snd_usb_substream *subs,
 	if (unlikely(subs->pcm_format == SNDRV_PCM_FORMAT_DSD_U16_LE &&
 		     subs->cur_audiofmt->dsd_dop)) {
 		fill_playback_urb_dsd_dop(subs, urb, bytes);
+	} else if (unlikely(subs->pcm_format == SNDRV_PCM_FORMAT_DSD_U8 &&
+			   subs->cur_audiofmt->dsd_bitrev)) {
+		/* bit-reverse the bytes */
+		u8 *buf = urb->transfer_buffer;
+		for (i = 0; i < bytes; i++) {
+			int idx = (subs->hwptr_done + i)
+				% (runtime->buffer_size * stride);
+			buf[i] = bitrev8(runtime->dma_area[idx]);
+		}
+
+		subs->hwptr_done += bytes;
 	} else {
 		/* usual PCM */
 		if (subs->hwptr_done + bytes > runtime->buffer_size * stride) {
-- 
1.7.10.4
