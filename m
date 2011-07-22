From: linux@audioscience.com
Subject: [PATCH 15/15] ALSA: asihpi - HPI version 4.08
Date: Fri, 22 Jul 2011 15:53:04 +1200
Message-ID: <1311306785-23116-30-git-send-email-linux@audioscience.com>
References: <1311306785-23116-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1311306785-23116-1-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: tiwai@suse.de, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

HPI Version is used to check for firmware compatibility.
This version  will accept 4.08.xx released firmware,
and will also accept 4.09.xx beta firmware

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/hpi.h |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/pci/asihpi/hpi.h b/sound/pci/asihpi/hpi.h
index 9538f12..f207272 100644
--- a/sound/pci/asihpi/hpi.h
+++ b/sound/pci/asihpi/hpi.h
@@ -1,7 +1,7 @@
 /******************************************************************************
 
     AudioScience HPI driver
-    Copyright (C) 1997-2010  AudioScience Inc. <support@audioscience.com>
+    Copyright (C) 1997-2011  AudioScience Inc. <support@audioscience.com>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of version 2 of the GNU General Public License as
@@ -42,12 +42,11 @@ i.e 3.05.02 is a development version
 #define HPI_VER_MINOR(v) ((int)((v >> 8) & 0xFF))
 #define HPI_VER_RELEASE(v) ((int)(v & 0xFF))
 
-/* Use single digits for versions less that 10 to avoid octal. */
-#define HPI_VER HPI_VERSION_CONSTRUCTOR(4L, 6, 0)
-#define HPI_VER_STRING "4.06.00"
+#define HPI_VER HPI_VERSION_CONSTRUCTOR(4L, 8, 0)
+#define HPI_VER_STRING "4.08.00"
 
 /* Library version as documented in hpi-api-versions.txt */
-#define HPI_LIB_VER  HPI_VERSION_CONSTRUCTOR(9, 0, 0)
+#define HPI_LIB_VER  HPI_VERSION_CONSTRUCTOR(10, 0, 0)
 
 #include <linux/types.h>
 #define HPI_BUILD_EXCLUDE_DEPRECATED
-- 
1.7.0.4
