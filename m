From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 2/2] ALSA: line6: Remove unused line6_midibuf_skip_message()
Date: Sun,  1 Feb 2015 01:01:09 -0600
Message-ID: <1422774069-17328-3-git-send-email-chris@rorvick.com>
References: <1422774069-17328-1-git-send-email-chris@rorvick.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422774069-17328-1-git-send-email-chris@rorvick.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Chris Rorvick <chris@rorvick.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@gmail.com>
List-Id: alsa-devel@alsa-project.org

Use of this function ended with commits 3e58c868db1d ("staging: line6:
drop midi_mask_receive") and af89d2897a71 ("staging: line6: drop
midi_mask_transmit".)

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 sound/usb/line6/midibuf.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/sound/usb/line6/midibuf.c b/sound/usb/line6/midibuf.c
index 3b8b59b..36a610b 100644
--- a/sound/usb/line6/midibuf.c
+++ b/sound/usb/line6/midibuf.c
@@ -245,17 +245,6 @@ int line6_midibuf_ignore(struct midi_buffer *this, int length)
 	return length;
 }
 
-int line6_midibuf_skip_message(struct midi_buffer *this, unsigned short mask)
-{
-	int cmd = this->command_prev;
-
-	if ((cmd >= 0x80) && (cmd < 0xf0))
-		if ((mask & (1 << (cmd & 0x0f))) == 0)
-			return 1;
-
-	return 0;
-}
-
 void line6_midibuf_destroy(struct midi_buffer *this)
 {
 	kfree(this->buf);
-- 
2.1.0
