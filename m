From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: usx2y: fix inconsistent indenting on if statement
Date: Wed,  2 Dec 2015 11:49:53 +0000
Message-ID: <1449056993-9987-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

minor change, indenting is one tab out.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/usb/usx2y/usbusx2yaudio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudio.c
index 61d5dc2..dd40ca9 100644
--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -166,7 +166,7 @@ static int usX2Y_urb_play_prepare(struct snd_usX2Y_substream *subs,
 			/* set the buffer pointer */
 			urb->transfer_buffer = runtime->dma_area + subs->hwptr * usX2Y->stride;
 			if ((subs->hwptr += count) >= runtime->buffer_size)
-			subs->hwptr -= runtime->buffer_size;			
+				subs->hwptr -= runtime->buffer_size;
 		}
 	else
 		urb->transfer_buffer = subs->tmpbuf;
-- 
2.6.2
