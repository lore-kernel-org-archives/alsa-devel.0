From: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/4] USB: Gadget: Rename audio function to uac1
Date: Thu,  2 Feb 2012 21:59:53 +0530
Message-ID: <1328200193-31939-1-git-send-email-jaswinder.singh@linaro.org>
References: <CABb+yY3X0XDk0zByZZcJOO0h2Kxu14UD4w-GS7p1HPAAWU3SVA@mail.gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CABb+yY3X0XDk0zByZZcJOO0h2Kxu14UD4w-GS7p1HPAAWU3SVA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, yadi.brar01-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jaredwiltshire-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

The extant USB-Audio function driver complies to UAC_1 spec.
So name the files accordingly, paving way for inclusion of
a new UAC_2 specified driver.

Signed-off-by: Yadi Brar <yadi.brar01-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/usb/gadget/audio.c                 |    6 +++---
 drivers/usb/gadget/{f_audio.c => f_uac1.c} |    2 +-
 drivers/usb/gadget/{u_audio.c => u_uac1.c} |    4 ++--
 drivers/usb/gadget/{u_audio.h => u_uac1.h} |    2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)
 rename drivers/usb/gadget/{f_audio.c => f_uac1.c} (99%)
 rename drivers/usb/gadget/{u_audio.c => u_uac1.c} (99%)
 rename drivers/usb/gadget/{u_audio.h => u_uac1.h} (94%)

diff --git a/drivers/usb/gadget/audio.c b/drivers/usb/gadget/audio.c
index 9d89ae47..056a2d9 100644
--- a/drivers/usb/gadget/audio.c
+++ b/drivers/usb/gadget/audio.c
@@ -14,7 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/utsname.h>
 
-#include "u_audio.h"
+#include "u_uac1.h"
 
 #define DRIVER_DESC		"Linux USB Audio Gadget"
 #define DRIVER_VERSION		"Dec 18, 2008"
@@ -33,8 +33,8 @@
 #include "config.c"
 #include "epautoconf.c"
 
-#include "u_audio.c"
-#include "f_audio.c"
+#include "u_uac1.c"
+#include "f_uac1.c"
 
 /*-------------------------------------------------------------------------*/
 
diff --git a/drivers/usb/gadget/f_audio.c b/drivers/usb/gadget/f_uac1.c
similarity index 99%
rename from drivers/usb/gadget/f_audio.c
rename to drivers/usb/gadget/f_uac1.c
index ec7ffcd..e4c060f 100644
--- a/drivers/usb/gadget/f_audio.c
+++ b/drivers/usb/gadget/f_uac1.c
@@ -14,7 +14,7 @@
 #include <linux/device.h>
 #include <linux/atomic.h>
 
-#include "u_audio.h"
+#include "u_uac1.h"
 
 #define OUT_EP_MAX_PACKET_SIZE	200
 static int req_buf_size = OUT_EP_MAX_PACKET_SIZE;
diff --git a/drivers/usb/gadget/u_audio.c b/drivers/usb/gadget/u_uac1.c
similarity index 99%
rename from drivers/usb/gadget/u_audio.c
rename to drivers/usb/gadget/u_uac1.c
index 59ffe1e..af98989 100644
--- a/drivers/usb/gadget/u_audio.c
+++ b/drivers/usb/gadget/u_uac1.c
@@ -1,5 +1,5 @@
 /*
- * u_audio.c -- ALSA audio utilities for Gadget stack
+ * u_uac1.c -- ALSA audio utilities for Gadget stack
  *
  * Copyright (C) 2008 Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
  * Copyright (C) 2008 Analog Devices, Inc
@@ -17,7 +17,7 @@
 #include <linux/random.h>
 #include <linux/syscalls.h>
 
-#include "u_audio.h"
+#include "u_uac1.h"
 
 /*
  * This component encapsulates the ALSA devices for USB audio gadget
diff --git a/drivers/usb/gadget/u_audio.h b/drivers/usb/gadget/u_uac1.h
similarity index 94%
rename from drivers/usb/gadget/u_audio.h
rename to drivers/usb/gadget/u_uac1.h
index 08ffce3..18c2e72 100644
--- a/drivers/usb/gadget/u_audio.h
+++ b/drivers/usb/gadget/u_uac1.h
@@ -1,5 +1,5 @@
 /*
- * u_audio.h -- interface to USB gadget "ALSA AUDIO" utilities
+ * u_uac1.h -- interface to USB gadget "ALSA AUDIO" utilities
  *
  * Copyright (C) 2008 Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
  * Copyright (C) 2008 Analog Devices, Inc
-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
