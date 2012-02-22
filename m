From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: [PATCH v3 1/5] snd-usb-6fire: remove driver version
	information
Date: Wed, 22 Feb 2012 15:20:45 +0100
Message-ID: <20120222152045.42615bffe13f8ef7ac5c1d78@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id 35C11104061
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 15:20:52 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Remove unused driver version information from the individual files.

Signed-off-by: Torsten Schenk <torsten.schenk@zoho.com>

diff -Nur a/sound/usb/6fire/chip.c b/sound/usb/6fire/chip.c
--- a/sound/usb/6fire/chip.c	2012-01-09 21:55:55.863579333 +0100
+++ b/sound/usb/6fire/chip.c	2012-01-09 22:33:49.857786986 +0100
@@ -5,7 +5,6 @@
  *
  * Author:	Torsten Schenk <torsten.schenk@zoho.com>
  * Created:	Jan 01, 2011
- * Version:	0.3.0
  * Copyright:	(C) Torsten Schenk
  *
  * This program is free software; you can redistribute it and/or modify
@@ -29,7 +28,7 @@
 #include <sound/initval.h>
 
 MODULE_AUTHOR("Torsten Schenk <torsten.schenk@zoho.com>");
-MODULE_DESCRIPTION("TerraTec DMX 6Fire USB audio driver, version 0.3.0");
+MODULE_DESCRIPTION("TerraTec DMX 6Fire USB audio driver");
 MODULE_LICENSE("GPL v2");
 MODULE_SUPPORTED_DEVICE("{{TerraTec, DMX 6Fire USB}}");
 
diff -Nur a/sound/usb/6fire/chip.h b/sound/usb/6fire/chip.h
--- a/sound/usb/6fire/chip.h	2012-01-09 21:55:55.000000000 +0100
+++ b/sound/usb/6fire/chip.h	2012-01-09 22:33:38.469409108 +0100
@@ -3,7 +3,6 @@
  *
  * Author:	Torsten Schenk <torsten.schenk@zoho.com>
  * Created:	Jan 01, 2011
- * Version:	0.3.0
  * Copyright:	(C) Torsten Schenk
  *
  * This program is free software; you can redistribute it and/or modify
diff -Nur a/sound/usb/6fire/comm.c b/sound/usb/6fire/comm.c
--- a/sound/usb/6fire/comm.c	2012-01-09 21:55:55.000000000 +0100
+++ b/sound/usb/6fire/comm.c	2012-01-09 22:33:11.620517902 +0100
@@ -5,7 +5,6 @@
  *
  * Author:	Torsten Schenk <torsten.schenk@zoho.com>
  * Created:	Jan 01, 2011
- * Version:	0.3.0
  * Copyright:	(C) Torsten Schenk
  *
  * This program is free software; you can redistribute it and/or modify
diff -Nur a/sound/usb/6fire/comm.h b/sound/usb/6fire/comm.h
--- a/sound/usb/6fire/comm.h	2012-01-09 21:55:55.000000000 +0100
+++ b/sound/usb/6fire/comm.h	2012-01-09 22:33:16.900693132 +0100
@@ -3,7 +3,6 @@
  *
  * Author:	Torsten Schenk <torsten.schenk@zoho.com>
  * Created:	Jan 01, 2011
- * Version:	0.3.0
  * Copyright:	(C) Torsten Schenk
  *
  * This program is free software; you can redistribute it and/or modify
diff -Nur a/sound/usb/6fire/common.h b/sound/usb/6fire/common.h
--- a/sound/usb/6fire/common.h	2012-01-09 21:55:55.000000000 +0100
+++ b/sound/usb/6fire/common.h	2012-01-09 22:33:24.636949983 +0100
@@ -3,7 +3,6 @@
  *
  * Author:	Torsten Schenk <torsten.schenk@zoho.com>
  * Created:	Jan 01, 2011
- * Version:	0.3.0
  * Copyright:	(C) Torsten Schenk
  *
  * This program is free software; you can redistribute it and/or modify
diff -Nur a/sound/usb/6fire/control.c b/sound/usb/6fire/control.c
--- a/sound/usb/6fire/control.c	2012-01-09 21:55:55.000000000 +0100
+++ b/sound/usb/6fire/control.c	2012-01-09 22:33:01.512182294 +0100
@@ -5,7 +5,6 @@
  *
  * Author:	Torsten Schenk <torsten.schenk@zoho.com>
  * Created:	Jan 01, 2011
- * Version:	0.3.0
  * Copyright:	(C) Torsten Schenk
  *
  * This program is free software; you can redistribute it and/or modify
diff -Nur a/sound/usb/6fire/control.h b/sound/usb/6fire/control.h
--- a/sound/usb/6fire/control.h	2012-01-09 21:55:55.000000000 +0100
+++ b/sound/usb/6fire/control.h	2012-01-09 22:32:56.088002206 +0100
@@ -3,7 +3,6 @@
  *
  * Author:	Torsten Schenk <torsten.schenk@zoho.com>
  * Created:	Jan 01, 2011
- * Version:	0.3.0
  * Copyright:	(C) Torsten Schenk
  *
  * This program is free software; you can redistribute it and/or modify
diff -Nur a/sound/usb/6fire/firmware.c b/sound/usb/6fire/firmware.c
--- a/sound/usb/6fire/firmware.c	2012-01-09 21:55:55.000000000 +0100
+++ b/sound/usb/6fire/firmware.c	2012-01-09 22:33:30.933158868 +0100
@@ -5,7 +5,6 @@
  *
  * Author:	Torsten Schenk <torsten.schenk@zoho.com>
  * Created:	Jan 01, 2011
- * Version:	0.3.0
  * Copyright:	(C) Torsten Schenk
  *
  * This program is free software; you can redistribute it and/or modify
diff -Nur a/sound/usb/6fire/midi.c b/sound/usb/6fire/midi.c
--- a/sound/usb/6fire/midi.c	2012-01-09 21:55:55.000000000 +0100
+++ b/sound/usb/6fire/midi.c	2012-01-09 22:35:07.356357430 +0100
@@ -5,7 +5,6 @@
  *
  * Author:	Torsten Schenk <torsten.schenk@zoho.com>
  * Created:	Jan 01, 2011
- * Version:	0.3.0
  * Copyright:	(C) Torsten Schenk
  *
  * This program is free software; you can redistribute it and/or modify
diff -Nur a/sound/usb/6fire/midi.h b/sound/usb/6fire/midi.h
--- a/sound/usb/6fire/midi.h	2012-01-09 21:55:55.000000000 +0100
+++ b/sound/usb/6fire/midi.h	2012-01-09 22:33:58.866085888 +0100
@@ -3,7 +3,6 @@
  *
  * Author:	Torsten Schenk <torsten.schenk@zoho.com>
  * Created:	Jan 01, 2011
- * Version:	0.3.0
  * Copyright:	(C) Torsten Schenk
  *
  * This program is free software; you can redistribute it and/or modify
diff -Nur a/sound/usb/6fire/pcm.c b/sound/usb/6fire/pcm.c
--- a/sound/usb/6fire/pcm.c	2012-01-09 21:55:55.000000000 +0100
+++ b/sound/usb/6fire/pcm.c	2012-01-09 22:34:04.546274285 +0100
@@ -5,7 +5,6 @@
  *
  * Author:	Torsten Schenk <torsten.schenk@zoho.com>
  * Created:	Jan 01, 2011
- * Version:	0.3.0
  * Copyright:	(C) Torsten Schenk
  *
  * This program is free software; you can redistribute it and/or modify
diff -Nur a/sound/usb/6fire/pcm.h b/sound/usb/6fire/pcm.h
--- a/sound/usb/6fire/pcm.h	2012-01-09 21:55:55.000000000 +0100
+++ b/sound/usb/6fire/pcm.h	2012-01-09 22:34:07.798382278 +0100
@@ -3,7 +3,6 @@
  *
  * Author:	Torsten Schenk <torsten.schenk@zoho.com>
  * Created:	Jan 01, 2011
- * Version:	0.3.0
  * Copyright:	(C) Torsten Schenk
  *
  * This program is free software; you can redistribute it and/or modify
