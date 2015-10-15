From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: [PATCH 2/7] ALSA: USB-audio: Also move out hwptr_done
	wrap from prepare_playback_urb()
Date: Thu, 15 Oct 2015 12:57:32 +0200
Message-ID: <1444906657-16791-3-git-send-email-ricardw@axis.com>
References: <1444906657-16791-1-git-send-email-ricardw@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 171F1260453
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

Refactoring in preparation for adding Zoom R16 quirk.

Signed-off-by: Ricard Wanderlof <ricardw@axis.com>
---
 sound/usb/pcm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 4292bad..ee8dd9e 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1383,6 +1383,8 @@ static inline void fill_playback_urb_dsd_dop(struct snd_usb_substream *subs,
 			subs->hwptr_done++;
 		}
 	}
+	if (subs->hwptr_done >= runtime->buffer_size * stride)
+		subs->hwptr_done -= runtime->buffer_size * stride;
 }
 
 static void copy_to_urb(struct snd_usb_substream *subs,
@@ -1403,6 +1405,8 @@ static void copy_to_urb(struct snd_usb_substream *subs,
 		       runtime->dma_area + subs->hwptr_done, bytes);
 	}
 	subs->hwptr_done += bytes;
+	if (subs->hwptr_done >= runtime->buffer_size * stride)
+		subs->hwptr_done -= runtime->buffer_size * stride;
 }
 
 static void prepare_playback_urb(struct snd_usb_substream *subs,
@@ -1480,14 +1484,13 @@ static void prepare_playback_urb(struct snd_usb_substream *subs,
 		}
 
 		subs->hwptr_done += bytes;
+		if (subs->hwptr_done >= runtime->buffer_size * stride)
+			subs->hwptr_done -= runtime->buffer_size * stride;
 	} else {
 		/* usual PCM */
 		copy_to_urb(subs, urb, stride, bytes);
 	}
 
-	if (subs->hwptr_done >= runtime->buffer_size * stride)
-		subs->hwptr_done -= runtime->buffer_size * stride;
-
 	/* update delay with exact number of samples queued */
 	runtime->delay = subs->last_delay;
 	runtime->delay += frames;
-- 
2.1.4
