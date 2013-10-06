From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH v4 15/15] ALSA: usb-audio: improve logging
	messages
Date: Sun,  6 Oct 2013 22:31:20 +0200
Message-ID: <1381091480-23636-16-git-send-email-eldad@fogrefinery.com>
References: <1381091480-23636-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f54.google.com (mail-bk0-f54.google.com
 [209.85.214.54])
 by alsa0.perex.cz (Postfix) with ESMTP id C4B8C261AAA
 for <alsa-devel@alsa-project.org>; Sun,  6 Oct 2013 22:31:45 +0200 (CEST)
Received: by mail-bk0-f54.google.com with SMTP id mz12so2387072bkb.27
 for <alsa-devel@alsa-project.org>; Sun, 06 Oct 2013 13:31:45 -0700 (PDT)
In-Reply-To: <1381091480-23636-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>, Nikolay Martynov <mar.kolya@gmail.com>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Add -EBUSY to the list of returned USB error strings.
Change some debugging messages to KERN_DEBUG.
Add the calling function for usb_submit_urb related errors.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/endpoint.c | 12 +++++++-----
 sound/usb/pcm.c      |  4 ++--
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 81056b6..ac4dedf 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -114,6 +114,8 @@ static const char *usb_error_string(int err)
 	case -EFBIG:
 	case -EMSGSIZE:
 		return "internal error";
+	case -EBUSY:
+		return "device busy";
 	default:
 		return "unknown error";
 	}
@@ -333,8 +335,8 @@ static void queue_pending_output_urbs(struct snd_usb_endpoint *ep)
 
 		err = usb_submit_urb(ctx->urb, GFP_ATOMIC);
 		if (err < 0)
-			snd_printk(KERN_ERR "Unable to submit urb #%d: %d (urb %p)\n",
-				   ctx->index, err, ctx->urb);
+			snd_printk(KERN_ERR "%s: cannot submit urb #%d: %d (urb %p)\n",
+				   __func__, ctx->index, err, ctx->urb);
 		else
 			set_bit(ctx->index, &ep->active_mask);
 	}
@@ -387,7 +389,7 @@ static void snd_complete_urb(struct urb *urb)
 	if (err == 0)
 		return;
 
-	snd_printk(KERN_ERR "cannot submit urb (err = %d)\n", err);
+	snd_printk(KERN_ERR "%s: cannot submit urb (err = %d)\n", __func__, err);
 	//snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
 
 exit_clear:
@@ -948,8 +950,8 @@ int snd_usb_endpoint_start(struct snd_usb_endpoint *ep)
 
 		err = usb_submit_urb(urb, GFP_ATOMIC);
 		if (err < 0) {
-			snd_printk(KERN_ERR "cannot submit urb %d, error %d: %s\n",
-				   i, err, usb_error_string(err));
+			snd_printk(KERN_ERR "%s: cannot submit urb %d, error %d: %s\n",
+				   __func__, i, err, usb_error_string(err));
 			goto __error;
 		}
 		set_bit(i, &ep->active_mask);
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index f3d48d4..8897da7 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -606,7 +606,7 @@ static int match_endpoint_audioformats(struct audioformat *fp,
 	if (fp->channels == match->channels)
 		score++;
 
-	snd_printdd("%s: (fmt @%p) score %d\n", __func__, fp, score);
+	snd_printdd(KERN_DEBUG "%s: (fmt @%p) score %d\n", __func__, fp, score);
 
 	return score;
 }
@@ -660,7 +660,7 @@ static int configure_sync_endpoint(struct snd_usb_substream *subs)
 	if (sync_fp->channels != subs->channels) {
 		sync_period_bytes = (subs->period_bytes / subs->channels) *
 			sync_fp->channels;
-		snd_printdd("%s: adjusted sync ep period bytes (%d -> %d)\n",
+		snd_printdd(KERN_DEBUG "%s: adjusted sync ep period bytes (%d -> %d)\n",
 			__func__, subs->period_bytes, sync_period_bytes);
 	}
 
-- 
1.8.1.5
