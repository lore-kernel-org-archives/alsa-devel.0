From: Wenwen Wang <wang6495@umn.edu>
Subject: [PATCH v2] ALSA: usx2y: fix a double free bug
Date: Mon, 29 Apr 2019 12:45:40 -0500
Message-ID: <1556559941-26684-1-git-send-email-wang6495@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wenwen Wang <wang6495@umn.edu>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kees Cook <keescook@chromium.org>, "moderated list:SOUND" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

In usX2Y_In04_init(), a new urb is firstly created through usb_alloc_urb()
and saved to 'usX2Y->In04urb'. Then, a buffer is allocated through
kmalloc() and saved to 'usX2Y->In04Buf'. If the allocation of the buffer
fails, the error code ENOMEM is returned after usb_free_urb(), which frees
the created urb. However, the urb is actually freed at card->private_free
callback, i.e., snd_usX2Y_card_private_free(). So the free operation here
leads to a double free bug.

To fix the above issue, simply remove usb_free_urb().

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 sound/usb/usx2y/usbusx2y.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index da4a5a5..1f0b0100 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -293,10 +293,8 @@ int usX2Y_In04_init(struct usX2Ydev *usX2Y)
 	if (! (usX2Y->In04urb = usb_alloc_urb(0, GFP_KERNEL)))
 		return -ENOMEM;
 
-	if (! (usX2Y->In04Buf = kmalloc(21, GFP_KERNEL))) {
-		usb_free_urb(usX2Y->In04urb);
+	if (! (usX2Y->In04Buf = kmalloc(21, GFP_KERNEL)))
 		return -ENOMEM;
-	}
 	 
 	init_waitqueue_head(&usX2Y->In04WaitQueue);
 	usb_fill_int_urb(usX2Y->In04urb, usX2Y->dev, usb_rcvintpipe(usX2Y->dev, 0x4),
-- 
2.7.4
