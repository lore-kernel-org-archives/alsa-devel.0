From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: snd-usb-usx2y: fix incorrect indentation on if statement
Date: Wed, 14 Jan 2015 11:57:33 +0000
Message-ID: <1421236653-4627-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Minor style issue, statement needs an extra tab indentation
on the if statement.

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
2.1.4
