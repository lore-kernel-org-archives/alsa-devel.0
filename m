From: Thomas Pugliese <thomas.pugliese-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] sound: usb: support wireless devices in snd_usb_parse_datainterval
Date: Tue,  1 Oct 2013 14:32:57 -0500
Message-ID: <1380655977-1403-1-git-send-email-thomas.pugliese@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Thomas Pugliese <thomas.pugliese-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi, 
This patch adds support for dev speed USB_SPEED_WIRELESS in 
snd_usb_parse_datainterval which allows the usb sound core to create 
ISO urbs with the correct number and size of buffers.

Signed-off-by: Thomas Pugliese <thomas.pugliese-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 sound/usb/helper.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/helper.c b/sound/usb/helper.c
index 6209024..51ed1ac 100644
--- a/sound/usb/helper.c
+++ b/sound/usb/helper.c
@@ -118,6 +118,7 @@ unsigned char snd_usb_parse_datainterval(struct snd_usb_audio *chip,
 {
 	switch (snd_usb_get_speed(chip->dev)) {
 	case USB_SPEED_HIGH:
+	case USB_SPEED_WIRELESS:
 	case USB_SPEED_SUPER:
 		if (get_endpoint(alts, 0)->bInterval >= 1 &&
 		    get_endpoint(alts, 0)->bInterval <= 4)
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
