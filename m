From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 4/6] ALSA: line6: Return EIO if read/write not successful
Date: Tue, 10 Feb 2015 23:03:15 -0600
Message-ID: <1423630997-25464-5-git-send-email-chris@rorvick.com>
References: <1423630997-25464-1-git-send-email-chris@rorvick.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423630997-25464-1-git-send-email-chris@rorvick.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Chris Rorvick <chris@rorvick.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 sound/usb/line6/driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 2a33f3e..f8e2eb0 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -349,7 +349,7 @@ int line6_read_data(struct usb_line6 *line6, u16 address, void *data,
 		dev_err(line6->ifcdev,
 			"length mismatch (expected %d, got %d)\n",
 			(int)datalen, (int)len);
-		return -EINVAL;
+		return -EIO;
 	}
 
 	/* receive the result: */
@@ -415,7 +415,7 @@ int line6_write_data(struct usb_line6 *line6, u16 address, void *data,
 		return -EIO;
 	} else if (status != 0) {
 		dev_err(line6->ifcdev, "write failed (error %d)\n", ret);
-		return -EINVAL;
+		return -EIO;
 	}
 
 	return 0;
-- 
2.1.0
