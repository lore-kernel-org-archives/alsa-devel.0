From: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH v2 8/9] ALSA: caiaq: Add yet more sanity checks for invalid EPs
Date: Wed, 11 Oct 2017 12:36:45 +0200
Message-ID: <20171011103646.11879-9-tiwai@suse.de>
References: <20171011103646.11879-1-tiwai@suse.de>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171011103646.11879-1-tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrey Konovalov <andreyknvl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

A few other places in caiaq driver have the URB handling with the
fixed endpoints without checking the validity, too.  Add the sanity
check with the new helper function at each appropriate place for
avoiding the spurious kernel warnings due to invalid EPs.

Signed-off-by: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
---
 sound/usb/caiaq/input.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/usb/caiaq/input.c b/sound/usb/caiaq/input.c
index 4b3fb91deecd..e883659ea6e7 100644
--- a/sound/usb/caiaq/input.c
+++ b/sound/usb/caiaq/input.c
@@ -718,6 +718,9 @@ int snd_usb_caiaq_input_init(struct snd_usb_caiaqdev *cdev)
 				  usb_rcvbulkpipe(usb_dev, 0x4),
 				  cdev->ep4_in_buf, EP4_BUFSIZE,
 				  snd_usb_caiaq_ep4_reply_dispatch, cdev);
+		ret = usb_urb_ep_type_check(cdev->ep4_in_urb);
+		if (ret < 0)
+			goto exit_free_idev;
 
 		snd_usb_caiaq_set_auto_msg(cdev, 1, 10, 5);
 
@@ -757,6 +760,9 @@ int snd_usb_caiaq_input_init(struct snd_usb_caiaqdev *cdev)
 				  usb_rcvbulkpipe(usb_dev, 0x4),
 				  cdev->ep4_in_buf, EP4_BUFSIZE,
 				  snd_usb_caiaq_ep4_reply_dispatch, cdev);
+		ret = usb_urb_ep_type_check(cdev->ep4_in_urb);
+		if (ret < 0)
+			goto exit_free_idev;
 
 		snd_usb_caiaq_set_auto_msg(cdev, 1, 10, 5);
 
@@ -802,6 +808,9 @@ int snd_usb_caiaq_input_init(struct snd_usb_caiaqdev *cdev)
 				  usb_rcvbulkpipe(usb_dev, 0x4),
 				  cdev->ep4_in_buf, EP4_BUFSIZE,
 				  snd_usb_caiaq_ep4_reply_dispatch, cdev);
+		ret = usb_urb_ep_type_check(cdev->ep4_in_urb);
+		if (ret < 0)
+			goto exit_free_idev;
 
 		snd_usb_caiaq_set_auto_msg(cdev, 1, 10, 5);
 		break;
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
