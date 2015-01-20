From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 3/3] ALSA: line6: Remove driver version from
	header comment
Date: Tue, 20 Jan 2015 02:20:50 -0600
Message-ID: <1421742050-13299-4-git-send-email-chris@rorvick.com>
References: <1421742050-13299-1-git-send-email-chris@rorvick.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f176.google.com (mail-ig0-f176.google.com
 [209.85.213.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C81926054D
 for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2015 09:21:07 +0100 (CET)
Received: by mail-ig0-f176.google.com with SMTP id hl2so14431344igb.3
 for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2015 00:21:06 -0800 (PST)
In-Reply-To: <1421742050-13299-1-git-send-email-chris@rorvick.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, alsa-devel@alsa-project.org, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

The driver version string was removed in an ealier commit for being
useless.  These are equally useless.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 sound/usb/line6/capture.c  | 2 +-
 sound/usb/line6/capture.h  | 2 +-
 sound/usb/line6/driver.c   | 2 +-
 sound/usb/line6/driver.h   | 2 +-
 sound/usb/line6/midi.c     | 2 +-
 sound/usb/line6/midi.h     | 2 +-
 sound/usb/line6/midibuf.c  | 2 +-
 sound/usb/line6/midibuf.h  | 2 +-
 sound/usb/line6/pcm.c      | 2 +-
 sound/usb/line6/pcm.h      | 2 +-
 sound/usb/line6/playback.c | 2 +-
 sound/usb/line6/playback.h | 2 +-
 sound/usb/line6/pod.c      | 2 +-
 sound/usb/line6/toneport.c | 2 +-
 sound/usb/line6/usbdefs.h  | 2 +-
 sound/usb/line6/variax.c   | 2 +-
 16 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index 9da3117..5a010ba 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -1,5 +1,5 @@
 /*
- * Line 6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver
  *
  * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
  *
diff --git a/sound/usb/line6/capture.h b/sound/usb/line6/capture.h
index ff172fb..0939f40 100644
--- a/sound/usb/line6/capture.h
+++ b/sound/usb/line6/capture.h
@@ -1,5 +1,5 @@
 /*
- * Line 6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver
  *
  * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
  *
diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index c668e07..93cd4da 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -1,5 +1,5 @@
 /*
- * Line 6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver
  *
  * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
  *
diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index ff52169..efd58ac 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -1,5 +1,5 @@
 /*
- * Line 6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver
  *
  * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
  *
diff --git a/sound/usb/line6/midi.c b/sound/usb/line6/midi.c
index 64e242b..b5a58a7 100644
--- a/sound/usb/line6/midi.c
+++ b/sound/usb/line6/midi.c
@@ -1,5 +1,5 @@
 /*
- * Line 6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver
  *
  * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
  *
diff --git a/sound/usb/line6/midi.h b/sound/usb/line6/midi.h
index 68e7d3a..ba6bf38 100644
--- a/sound/usb/line6/midi.h
+++ b/sound/usb/line6/midi.h
@@ -1,5 +1,5 @@
 /*
- * Line 6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver
  *
  * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
  *
diff --git a/sound/usb/line6/midibuf.c b/sound/usb/line6/midibuf.c
index 55df0da..b5c4d79 100644
--- a/sound/usb/line6/midibuf.c
+++ b/sound/usb/line6/midibuf.c
@@ -1,5 +1,5 @@
 /*
- * Line 6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver
  *
  * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
  *
diff --git a/sound/usb/line6/midibuf.h b/sound/usb/line6/midibuf.h
index 18eed75..05dbf11 100644
--- a/sound/usb/line6/midibuf.h
+++ b/sound/usb/line6/midibuf.h
@@ -1,5 +1,5 @@
 /*
- * Line 6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver
  *
  * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
  *
diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index a31a86b..8a6059a 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -1,5 +1,5 @@
 /*
- * Line 6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver
  *
  * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
  *
diff --git a/sound/usb/line6/pcm.h b/sound/usb/line6/pcm.h
index 715e84b3..c742b33 100644
--- a/sound/usb/line6/pcm.h
+++ b/sound/usb/line6/pcm.h
@@ -1,5 +1,5 @@
 /*
- * Line 6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver
  *
  * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
  *
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index 660094b..1c9f95a 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -1,5 +1,5 @@
 /*
- * Line 6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver
  *
  * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
  *
diff --git a/sound/usb/line6/playback.h b/sound/usb/line6/playback.h
index 0dfca5e..78a8851132 100644
--- a/sound/usb/line6/playback.h
+++ b/sound/usb/line6/playback.h
@@ -1,5 +1,5 @@
 /*
- * Line 6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver
  *
  * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
  *
diff --git a/sound/usb/line6/pod.c b/sound/usb/line6/pod.c
index 7766f53..bf027fc 100644
--- a/sound/usb/line6/pod.c
+++ b/sound/usb/line6/pod.c
@@ -1,5 +1,5 @@
 /*
- * Line 6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver
  *
  * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
  *
diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index 77ad98c..c1f61cd 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -1,5 +1,5 @@
 /*
- * Line 6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver
  *
  * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
  *                         Emil Myhrman (emil.myhrman@gmail.com)
diff --git a/sound/usb/line6/usbdefs.h b/sound/usb/line6/usbdefs.h
index 3aab2e7..5ef7bcd 100644
--- a/sound/usb/line6/usbdefs.h
+++ b/sound/usb/line6/usbdefs.h
@@ -1,5 +1,5 @@
 /*
- * Line 6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver
  *
  * Copyright (C) 2005-2008 Markus Grabner (grabner@icg.tugraz.at)
  *
diff --git a/sound/usb/line6/variax.c b/sound/usb/line6/variax.c
index 5e4da466..99a58cb 100644
--- a/sound/usb/line6/variax.c
+++ b/sound/usb/line6/variax.c
@@ -1,5 +1,5 @@
 /*
- * Line 6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver
  *
  * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
  *
-- 
2.1.0
