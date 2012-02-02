From: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/4] USB: UAC2: Add ACHeader and FormatType descriptor
Date: Thu,  2 Feb 2012 22:00:48 +0530
Message-ID: <1328200248-31984-1-git-send-email-jaswinder.singh@linaro.org>
References: <CABb+yY3X0XDk0zByZZcJOO0h2Kxu14UD4w-GS7p1HPAAWU3SVA@mail.gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CABb+yY3X0XDk0zByZZcJOO0h2Kxu14UD4w-GS7p1HPAAWU3SVA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, yadi.brar01-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jaredwiltshire-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Add missing but needed ACHeader and FormatType descriptor definitions.

Signed-off-by: Yadi Brar <yadi.brar01-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 include/linux/usb/audio-v2.h |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/include/linux/usb/audio-v2.h b/include/linux/usb/audio-v2.h
index 964cb60..ed13053 100644
--- a/include/linux/usb/audio-v2.h
+++ b/include/linux/usb/audio-v2.h
@@ -43,6 +43,27 @@ static inline bool uac2_control_is_writeable(u32 bmControls, u8 control)
 	return (bmControls >> (control * 2)) & 0x2;
 }
 
+/* 4.7.2 Class-Specific AC Interface Descriptor */
+struct uac2_ac_header_descriptor {
+	__u8  bLength;			/* 9 */
+	__u8  bDescriptorType;		/* USB_DT_CS_INTERFACE */
+	__u8  bDescriptorSubtype;	/* UAC_MS_HEADER */
+	__le16 bcdADC;			/* 0x0200 */
+	__u8  bCategory;
+	__le16 wTotalLength;		/* includes Unit and Terminal desc. */
+	__u8  bmControls;
+} __packed;
+
+/* 2.3.1.6 Type I Format Type Descriptor (Frmts20 final.pdf)*/
+struct uac2_format_type_i_descriptor {
+	__u8  bLength;			/* in bytes: 6 */
+	__u8  bDescriptorType;		/* USB_DT_CS_INTERFACE */
+	__u8  bDescriptorSubtype;	/* FORMAT_TYPE */
+	__u8  bFormatType;		/* FORMAT_TYPE_1 */
+	__u8  bSubslotSize;		/* {1,2,3,4} */
+	__u8  bBitResolution;
+} __packed;
+
 /* 4.7.2.1 Clock Source Descriptor */
 
 struct uac_clock_source_descriptor {
-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
