From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: [PATCH v2 4/7] ALSA: USB-audio: Add offset parameter
	to copy_to_urb()
Date: Mon, 19 Oct 2015 08:52:52 +0200
Message-ID: <1445237575-396-5-git-send-email-ricardw@axis.com>
References: <1444906657-16791-1-git-send-email-ricardw@axis.com>
 <1445237575-396-1-git-send-email-ricardw@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A53226572A
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2015 08:53:05 +0200 (CEST)
In-Reply-To: <1445237575-396-1-git-send-email-ricardw@axis.com>
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

Preparation for adding Zoom R16/24 quirk.
No functional change.

Signed-off-by: Ricard Wanderlof <ricardw@axis.com>
---
 sound/usb/pcm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index ee8dd9e..e3c5bc0 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1387,8 +1387,8 @@ static inline void fill_playback_urb_dsd_dop(struct snd_usb_substream *subs,
 		subs->hwptr_done -= runtime->buffer_size * stride;
 }
 
-static void copy_to_urb(struct snd_usb_substream *subs,
-		       struct urb *urb, int stride, unsigned int bytes)
+static void copy_to_urb(struct snd_usb_substream *subs, struct urb *urb,
+			int offset, int stride, unsigned int bytes)
 {
 	struct snd_pcm_runtime *runtime = subs->pcm_substream->runtime;
 
@@ -1396,12 +1396,12 @@ static void copy_to_urb(struct snd_usb_substream *subs,
 		/* err, the transferred area goes over buffer boundary. */
 		unsigned int bytes1 =
 			runtime->buffer_size * stride - subs->hwptr_done;
-		memcpy(urb->transfer_buffer,
+		memcpy(urb->transfer_buffer + offset,
 		       runtime->dma_area + subs->hwptr_done, bytes1);
-		memcpy(urb->transfer_buffer + bytes1,
+		memcpy(urb->transfer_buffer + offset + bytes1,
 		       runtime->dma_area, bytes - bytes1);
 	} else {
-		memcpy(urb->transfer_buffer,
+		memcpy(urb->transfer_buffer + offset,
 		       runtime->dma_area + subs->hwptr_done, bytes);
 	}
 	subs->hwptr_done += bytes;
@@ -1488,7 +1488,7 @@ static void prepare_playback_urb(struct snd_usb_substream *subs,
 			subs->hwptr_done -= runtime->buffer_size * stride;
 	} else {
 		/* usual PCM */
-		copy_to_urb(subs, urb, stride, bytes);
+		copy_to_urb(subs, urb, 0, stride, bytes);
 	}
 
 	/* update delay with exact number of samples queued */
-- 
2.1.4
