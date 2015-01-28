From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/7] ALSA: line6: Move the contents of
	usbdefs.h into driver.h
Date: Wed, 28 Jan 2015 17:41:26 +0100
Message-ID: <1422463289-19135-5-git-send-email-tiwai@suse.de>
References: <1422463289-19135-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 17437264EE5
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 17:41:37 +0100 (CET)
In-Reply-To: <1422463289-19135-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

Most of them are rather relevant with the definitions in driver.h,
and there are only a few lines, so just rip it off.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/driver.c   |  1 -
 sound/usb/line6/driver.h   | 16 ++++++++++++++++
 sound/usb/line6/midi.c     |  1 -
 sound/usb/line6/pcm.h      |  1 -
 sound/usb/line6/pod.c      |  1 -
 sound/usb/line6/podhd.c    |  1 -
 sound/usb/line6/toneport.c |  1 -
 sound/usb/line6/usbdefs.h  | 27 ---------------------------
 sound/usb/line6/variax.c   |  1 -
 9 files changed, 16 insertions(+), 34 deletions(-)
 delete mode 100644 sound/usb/line6/usbdefs.h

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 786b38159ad6..2328ec9a1ca8 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -22,7 +22,6 @@
 #include "driver.h"
 #include "midi.h"
 #include "playback.h"
-#include "usbdefs.h"
 
 #define DRIVER_AUTHOR  "Markus Grabner <grabner@icg.tugraz.at>"
 #define DRIVER_DESC    "Line 6 USB Driver"
diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index 80d42a0fd889..fa877a345860 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -20,6 +20,12 @@
 
 #define DRIVER_NAME "line6usb"
 
+#define USB_INTERVALS_PER_SECOND 1000
+
+/* Fallback USB interval and max packet size values */
+#define LINE6_FALLBACK_INTERVAL 10
+#define LINE6_FALLBACK_MAXPACKETSIZE 16
+
 #define LINE6_TIMEOUT 1
 #define LINE6_BUFSIZE_LISTEN 32
 #define LINE6_MESSAGE_MAXLEN 256
@@ -84,6 +90,16 @@ struct line6_properties {
 	unsigned ep_audio_w;
 };
 
+/* Capability bits */
+enum {
+	/* device supports settings parameter via USB */
+	LINE6_CAP_CONTROL =	1 << 0,
+	/* device supports PCM input/output via USB */
+	LINE6_CAP_PCM =		1 << 1,
+	/* device support hardware monitoring */
+	LINE6_CAP_HWMON =	1 << 2,
+};
+
 /*
 	 Common data shared by all Line 6 devices.
 	 Corresponds to a pair of USB endpoints.
diff --git a/sound/usb/line6/midi.c b/sound/usb/line6/midi.c
index beeedf9a2cbe..cebea9b7f769 100644
--- a/sound/usb/line6/midi.c
+++ b/sound/usb/line6/midi.c
@@ -17,7 +17,6 @@
 
 #include "driver.h"
 #include "midi.h"
-#include "usbdefs.h"
 
 #define line6_rawmidi_substream_midi(substream) \
 	((struct snd_line6_midi *)((substream)->rmidi->private_data))
diff --git a/sound/usb/line6/pcm.h b/sound/usb/line6/pcm.h
index 19c12f0a9008..3a3cfba40ec7 100644
--- a/sound/usb/line6/pcm.h
+++ b/sound/usb/line6/pcm.h
@@ -19,7 +19,6 @@
 #include <sound/pcm.h>
 
 #include "driver.h"
-#include "usbdefs.h"
 
 /* number of URBs */
 #define LINE6_ISO_BUFFERS	2
diff --git a/sound/usb/line6/pod.c b/sound/usb/line6/pod.c
index bc20cf141719..3f7ff661b3dd 100644
--- a/sound/usb/line6/pod.c
+++ b/sound/usb/line6/pod.c
@@ -21,7 +21,6 @@
 #include "capture.h"
 #include "driver.h"
 #include "playback.h"
-#include "usbdefs.h"
 
 /*
 	Locate name in binary program dump
diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index c4e83ab33a21..5e4e02c1f4b5 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -17,7 +17,6 @@
 
 #include "driver.h"
 #include "pcm.h"
-#include "usbdefs.h"
 
 enum {
 	LINE6_PODHD300,
diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index 9024acb2b850..cffcd7f83bfd 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -21,7 +21,6 @@
 #include "capture.h"
 #include "driver.h"
 #include "playback.h"
-#include "usbdefs.h"
 
 enum line6_device_type {
 	LINE6_GUITARPORT,
diff --git a/sound/usb/line6/usbdefs.h b/sound/usb/line6/usbdefs.h
deleted file mode 100644
index 5ef7bcd24e18..000000000000
--- a/sound/usb/line6/usbdefs.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * Line 6 Linux USB driver
- *
- * Copyright (C) 2005-2008 Markus Grabner (grabner@icg.tugraz.at)
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License as
- *	published by the Free Software Foundation, version 2.
- *
- */
-
-#ifndef USBDEFS_H
-#define USBDEFS_H
-
-#define USB_INTERVALS_PER_SECOND 1000
-
-/* device supports settings parameter via USB */
-#define LINE6_CAP_CONTROL (1 << 0)
-/* device supports PCM input/output via USB */
-#define LINE6_CAP_PCM (1 << 1)
-/* device support hardware monitoring */
-#define LINE6_CAP_HWMON (1 << 2)
-
-#define LINE6_FALLBACK_INTERVAL 10
-#define LINE6_FALLBACK_MAXPACKETSIZE 16
-
-#endif
diff --git a/sound/usb/line6/variax.c b/sound/usb/line6/variax.c
index 44042cbdef01..9dfbe7916d99 100644
--- a/sound/usb/line6/variax.c
+++ b/sound/usb/line6/variax.c
@@ -17,7 +17,6 @@
 #include <sound/core.h>
 
 #include "driver.h"
-#include "usbdefs.h"
 
 #define VARIAX_STARTUP_DELAY1 1000
 #define VARIAX_STARTUP_DELAY3 100
-- 
2.2.2
