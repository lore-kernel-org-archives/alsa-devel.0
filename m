From: Wolfram Sang <wsa-dev-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Subject: [PATCH] ALSA: usb: caiaq: audio: don't print error when allocating urb fails
Date: Thu, 11 Aug 2016 22:40:11 +0200
Message-ID: <1470948012-22897-2-git-send-email-wsa-dev@sang-engineering.com>
References: <1470948012-22897-1-git-send-email-wsa-dev@sang-engineering.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1470948012-22897-1-git-send-email-wsa-dev-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-dev-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

kmalloc will print enough information in case of failure.

Signed-off-by: Wolfram Sang <wsa-dev-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
---
 sound/usb/caiaq/audio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
index 327f8642ca80e6..8f66ba730d69d9 100644
--- a/sound/usb/caiaq/audio.c
+++ b/sound/usb/caiaq/audio.c
@@ -739,7 +739,6 @@ static struct urb **alloc_urbs(struct snd_usb_caiaqdev *cdev, int dir, int *ret)
 	for (i = 0; i < N_URBS; i++) {
 		urbs[i] = usb_alloc_urb(FRAMES_PER_URB, GFP_KERNEL);
 		if (!urbs[i]) {
-			dev_err(dev, "unable to usb_alloc_urb(), OOM!?\n");
 			*ret = -ENOMEM;
 			return urbs;
 		}
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
