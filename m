From: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 6/9] ALSA: usx2y: Add sanity checks for invalid EPs
Date: Tue, 10 Oct 2017 15:38:16 +0200
Message-ID: <20171010133819.10567-7-tiwai@suse.de>
References: <20171010133819.10567-1-tiwai@suse.de>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171010133819.10567-1-tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrey Konovalov <andreyknvl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

usx2y driver sets up URBs containing the fixed endpoints without
validation.  This may end up with an oops-like kernel warning when
submitted.

For avoiding it, this patch adds the calls of the new sanity-check
helper for URBs.

Signed-off-by: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
---
 sound/usb/usx2y/usbusx2y.c      | 8 ++++++++
 sound/usb/usx2y/usbusx2yaudio.c | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index 4569c0efac0a..55a631ccfa25 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -244,6 +244,9 @@ static void i_usX2Y_In04Int(struct urb *urb)
 								  usb_sndbulkpipe(usX2Y->dev, 0x04), &p4out->val.vol,
 								  p4out->type == eLT_Light ? sizeof(struct us428_lights) : 5,
 								  i_usX2Y_Out04Int, usX2Y);
+						err = usb_urb_ep_type_check(usX2Y->AS04.urb[j]);
+						if (err < 0)
+							break;
 						err = usb_submit_urb(usX2Y->AS04.urb[j], GFP_ATOMIC);
 						us428ctls->p4outSent = send;
 						break;
@@ -279,6 +282,9 @@ int usX2Y_AsyncSeq04_init(struct usX2Ydev *usX2Y)
 						usX2Y->AS04.buffer + URB_DataLen_AsyncSeq*i, 0,
 						i_usX2Y_Out04Int, usX2Y
 				);
+			err = usb_urb_ep_type_check(usX2Y->AS04.urb[i]);
+			if (err < 0)
+				break;
 		}
 	return err;
 }
@@ -298,6 +304,8 @@ int usX2Y_In04_init(struct usX2Ydev *usX2Y)
 			 usX2Y->In04Buf, 21,
 			 i_usX2Y_In04Int, usX2Y,
 			 10);
+	if (usb_urb_ep_type_check(usX2Y->In04urb))
+		return -EINVAL;
 	return usb_submit_urb(usX2Y->In04urb, GFP_KERNEL);
 }
 
diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudio.c
index f93b355756e6..345e439aa95b 100644
--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -677,6 +677,9 @@ static int usX2Y_rate_set(struct usX2Ydev *usX2Y, int rate)
 			usb_fill_bulk_urb(us->urb[i], usX2Y->dev, usb_sndbulkpipe(usX2Y->dev, 4),
 					  usbdata + i, 2, i_usX2Y_04Int, usX2Y);
 		}
+		err = usb_urb_ep_type_check(us->urb[0]);
+		if (err < 0)
+			goto cleanup;
 		us->submitted =	0;
 		us->len =	NOOF_SETRATE_URBS;
 		usX2Y->US04 =	us;
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
