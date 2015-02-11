From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 6/6] ALSA: line6: toneport: Use explicit type for firmware version
Date: Tue, 10 Feb 2015 23:03:17 -0600
Message-ID: <1423630997-25464-7-git-send-email-chris@rorvick.com>
References: <1423630997-25464-1-git-send-email-chris@rorvick.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423630997-25464-1-git-send-email-chris@rorvick.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Chris Rorvick <chris@rorvick.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@gmail.com>
List-Id: alsa-devel@alsa-project.org

The firmware version is a single byte so have the variable type agree.
Since the address to this member is passed to the read function, using
an int is not even portable.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 sound/usb/line6/toneport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index ddf7368..6d4c50c 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -52,7 +52,7 @@ struct usb_line6_toneport {
 	u32 serial_number;
 
 	/* Firmware version (x 100) */
-	int firmware_version;
+	u8 firmware_version;
 
 	/* Timer for delayed PCM startup */
 	struct timer_list timer;
-- 
2.1.0
