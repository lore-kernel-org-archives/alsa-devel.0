From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: usb-audio: Trigger PCM XRUN at XRUN
Date: Thu,  6 Nov 2014 13:59:06 +0100
Message-ID: <1415278746-5112-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BF4EA2651A8
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 13:59:07 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 95EF4AB07
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 12:59:07 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

The usb-audio driver detects XRUN at its complete callback, but the
actual code to trigger PCM XRUN is commented out because it caused
deadlock in the past.  This patch revives the PCM trigger properly.
It resulted in more than just enabling snd_pcm_stop(), but it had to
deduce the PCM substream with proper NULL checks and holds the stream
lock around the call.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/endpoint.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 167d0c1643e1..a4679913b0aa 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -348,6 +348,8 @@ static void snd_complete_urb(struct urb *urb)
 {
 	struct snd_urb_ctx *ctx = urb->context;
 	struct snd_usb_endpoint *ep = ctx->ep;
+	struct snd_pcm_substream *substream;
+	unsigned long flags;
 	int err;
 
 	if (unlikely(urb->status == -ENOENT ||		/* unlinked */
@@ -364,8 +366,6 @@ static void snd_complete_urb(struct urb *urb)
 			goto exit_clear;
 
 		if (snd_usb_endpoint_implicit_feedback_sink(ep)) {
-			unsigned long flags;
-
 			spin_lock_irqsave(&ep->lock, flags);
 			list_add_tail(&ctx->ready_list, &ep->ready_playback_urbs);
 			spin_unlock_irqrestore(&ep->lock, flags);
@@ -389,7 +389,12 @@ static void snd_complete_urb(struct urb *urb)
 		return;
 
 	usb_audio_err(ep->chip, "cannot submit urb (err = %d)\n", err);
-	//snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
+	if (ep->data_subs && ep->data_subs->pcm_substream) {
+		substream = ep->data_subs->pcm_substream;
+		snd_pcm_stream_lock_irqsave(substream, flags);
+		snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
+		snd_pcm_stream_unlock_irqrestore(substream, flags);
+	}
 
 exit_clear:
 	clear_bit(ctx->index, &ep->active_mask);
-- 
2.1.3
