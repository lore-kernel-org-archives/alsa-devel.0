From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 1/2] ALSA: line6: Remove unused line6_midibuf_status()
Date: Sun,  1 Feb 2015 01:01:08 -0600
Message-ID: <1422774069-17328-2-git-send-email-chris@rorvick.com>
References: <1422774069-17328-1-git-send-email-chris@rorvick.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422774069-17328-1-git-send-email-chris@rorvick.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Chris Rorvick <chris@rorvick.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@gmail.com>
List-Id: alsa-devel@alsa-project.org

This function has not been used since merging the driver into the kernel
(and a good while before that.)

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 sound/usb/line6/midibuf.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/usb/line6/midibuf.c b/sound/usb/line6/midibuf.c
index b5c4d79..3b8b59b 100644
--- a/sound/usb/line6/midibuf.c
+++ b/sound/usb/line6/midibuf.c
@@ -67,13 +67,6 @@ int line6_midibuf_init(struct midi_buffer *this, int size, int split)
 	return 0;
 }
 
-void line6_midibuf_status(struct midi_buffer *this)
-{
-	pr_debug("midibuf size=%d split=%d pos_read=%d pos_write=%d full=%d command_prev=%02x\n",
-		 this->size, this->split, this->pos_read, this->pos_write,
-		 this->full, this->command_prev);
-}
-
 int line6_midibuf_bytes_free(struct midi_buffer *this)
 {
 	return
-- 
2.1.0
