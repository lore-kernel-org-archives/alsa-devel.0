From: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/4] USB: Gadget: Audio: Move string IDs to audio.c
Date: Thu,  2 Feb 2012 22:01:12 +0530
Message-ID: <1328200272-32020-1-git-send-email-jaswinder.singh@linaro.org>
References: <CABb+yY3X0XDk0zByZZcJOO0h2Kxu14UD4w-GS7p1HPAAWU3SVA@mail.gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CABb+yY3X0XDk0zByZZcJOO0h2Kxu14UD4w-GS7p1HPAAWU3SVA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, yadi.brar01-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jaredwiltshire-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Move manufacturer and product string ids into audio.c so
as to be reusable by the new uac2 version of gadget driver.

Signed-off-by: Yadi Brar <yadi.brar01-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/usb/gadget/audio.c  |   23 +++++++++++++++++++++++
 drivers/usb/gadget/f_uac1.c |   23 -----------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/gadget/audio.c b/drivers/usb/gadget/audio.c
index 056a2d9..33e9327 100644
--- a/drivers/usb/gadget/audio.c
+++ b/drivers/usb/gadget/audio.c
@@ -33,6 +33,29 @@
 #include "config.c"
 #include "epautoconf.c"
 
+/* string IDs are assigned dynamically */
+
+#define STRING_MANUFACTURER_IDX		0
+#define STRING_PRODUCT_IDX		1
+
+static char manufacturer[50];
+
+static struct usb_string strings_dev[] = {
+	[STRING_MANUFACTURER_IDX].s = manufacturer,
+	[STRING_PRODUCT_IDX].s = DRIVER_DESC,
+	{  } /* end of list */
+};
+
+static struct usb_gadget_strings stringtab_dev = {
+	.language = 0x0409,	/* en-us */
+	.strings = strings_dev,
+};
+
+static struct usb_gadget_strings *audio_strings[] = {
+	&stringtab_dev,
+	NULL,
+};
+
 #include "u_uac1.c"
 #include "f_uac1.c"
 
diff --git a/drivers/usb/gadget/f_uac1.c b/drivers/usb/gadget/f_uac1.c
index e4c060f..1a5dcd5 100644
--- a/drivers/usb/gadget/f_uac1.c
+++ b/drivers/usb/gadget/f_uac1.c
@@ -216,29 +216,6 @@ static struct usb_descriptor_header *f_audio_desc[] __initdata = {
 	NULL,
 };
 
-/* string IDs are assigned dynamically */
-
-#define STRING_MANUFACTURER_IDX		0
-#define STRING_PRODUCT_IDX		1
-
-static char manufacturer[50];
-
-static struct usb_string strings_dev[] = {
-	[STRING_MANUFACTURER_IDX].s = manufacturer,
-	[STRING_PRODUCT_IDX].s = DRIVER_DESC,
-	{  } /* end of list */
-};
-
-static struct usb_gadget_strings stringtab_dev = {
-	.language	= 0x0409,	/* en-us */
-	.strings	= strings_dev,
-};
-
-static struct usb_gadget_strings *audio_strings[] = {
-	&stringtab_dev,
-	NULL,
-};
