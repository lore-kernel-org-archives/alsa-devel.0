From: linux@audioscience.com
Subject: [PATCH 01/21] Split hpi version info into separate
	header file.
Date: Thu, 22 Dec 2011 13:38:31 +1300
Message-ID: <1324514331-22570-2-git-send-email-linux@audioscience.com>
References: <1324514331-22570-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 181CF103BF2
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 01:40:01 +0100 (CET)
Received: from localhost.localdomain
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LWK00D3EXTHNQ40@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 22 Dec 2011 13:39:21 +1300 (NZDT)
In-reply-to: <1324514331-22570-1-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

and update HPI version to 4.10

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/hpi.h         |   18 ------------------
 sound/pci/asihpi/hpi_version.h |   32 ++++++++++++++++++++++++++++++++
 sound/pci/asihpi/hpidspcd.c    |   23 ++++++++++++-----------
 sound/pci/asihpi/hpidspcd.h    |    4 ----
 sound/pci/asihpi/hpimsgx.c     |    3 ++-
 sound/pci/asihpi/hpioctl.c     |    1 +
 6 files changed, 47 insertions(+), 34 deletions(-)
 create mode 100644 sound/pci/asihpi/hpi_version.h

diff --git a/sound/pci/asihpi/hpi.h b/sound/pci/asihpi/hpi.h
index f207272..7714937 100644
--- a/sound/pci/asihpi/hpi.h
+++ b/sound/pci/asihpi/hpi.h
@@ -30,26 +30,8 @@
 
 #ifndef _HPI_H_
 #define _HPI_H_
-/* HPI Version
-If HPI_VER_MINOR is odd then its a development release not intended for the
-public. If HPI_VER_MINOR is even then is a release version
-i.e 3.05.02 is a development version
-*/
-#define HPI_VERSION_CONSTRUCTOR(maj, min, rel) \
-	((maj << 16) + (min << 8) + rel)
-
-#define HPI_VER_MAJOR(v) ((int)(v >> 16))
-#define HPI_VER_MINOR(v) ((int)((v >> 8) & 0xFF))
-#define HPI_VER_RELEASE(v) ((int)(v & 0xFF))
-
-#define HPI_VER HPI_VERSION_CONSTRUCTOR(4L, 8, 0)
-#define HPI_VER_STRING "4.08.00"
-
-/* Library version as documented in hpi-api-versions.txt */
-#define HPI_LIB_VER  HPI_VERSION_CONSTRUCTOR(10, 0, 0)
 
 #include <linux/types.h>
-#define HPI_BUILD_EXCLUDE_DEPRECATED
 #define HPI_BUILD_KERNEL_MODE
 
 /******************************************************************************/
diff --git a/sound/pci/asihpi/hpi_version.h b/sound/pci/asihpi/hpi_version.h
new file mode 100644
index 0000000..e9146e5
--- /dev/null
+++ b/sound/pci/asihpi/hpi_version.h
@@ -0,0 +1,32 @@
+/** HPI Version Definitions
+Development releases have odd minor version.
+Production releases have even minor version.
+
+\file hpi_version.h
+*/
+
+#ifndef _HPI_VERSION_H
+#define _HPI_VERSION_H
+
+/* Use single digits for versions less that 10 to avoid octal. */
+/* *** HPI_VER is the only edit required to update version *** */
+/** HPI version */
+#define HPI_VER HPI_VERSION_CONSTRUCTOR(4, 10, 1)
+
+/** HPI version string in dotted decimal format */
+#define HPI_VER_STRING "4.10.01"
+
+/** Library version as documented in hpi-api-versions.txt */
+#define HPI_LIB_VER  HPI_VERSION_CONSTRUCTOR(10, 2, 0)
+
+/** Construct hpi version number from major, minor, release numbers */
+#define HPI_VERSION_CONSTRUCTOR(maj, min, r) ((maj << 16) + (min << 8) + r)
+
+/** Extract major version from hpi version number */
+#define HPI_VER_MAJOR(v) ((int)(v >> 16))
+/** Extract minor version from hpi version number */
+#define HPI_VER_MINOR(v) ((int)((v >> 8) & 0xFF))
+/** Extract release from hpi version number */
+#define HPI_VER_RELEASE(v) ((int)(v & 0xFF))
+
+#endif
diff --git a/sound/pci/asihpi/hpidspcd.c b/sound/pci/asihpi/hpidspcd.c
index 71d32c8..21cdb9e 100644
--- a/sound/pci/asihpi/hpidspcd.c
+++ b/sound/pci/asihpi/hpidspcd.c
@@ -25,6 +25,7 @@ hotplug firmware loader from individual dsp code files
 #define SOURCEFILE_NAME "hpidspcd.c"
 #include "hpidspcd.h"
 #include "hpidebug.h"
+#include "hpi_version.h"
 
 struct dsp_code_private {
 	/**  Firmware descriptor */
@@ -32,9 +33,6 @@ struct dsp_code_private {
 	struct pci_dev *dev;
 };
 
-#define HPI_VER_DECIMAL ((int)(HPI_VER_MAJOR(HPI_VER) * 10000 + \
-	    HPI_VER_MINOR(HPI_VER) * 100 + HPI_VER_RELEASE(HPI_VER)))
-
 /*-------------------------------------------------------------------*/
 short hpi_dsp_code_open(u32 adapter, void *os_data, struct dsp_code *dsp_code,
 	u32 *os_error_code)
@@ -66,22 +64,25 @@ short hpi_dsp_code_open(u32 adapter, void *os_data, struct dsp_code *dsp_code,
 	if ((header.type != 0x45444F43) ||	/* "CODE" */
 		(header.adapter != adapter)
 		|| (header.size != firmware->size)) {
-		dev_printk(KERN_ERR, &dev->dev, "Invalid firmware file\n");
+		dev_printk(KERN_ERR, &dev->dev,
+			"Invalid firmware header size %d != file %zd\n",
+			header.size, firmware->size);
 		goto error2;
 	}
 
-	if ((header.version / 100 & ~1) != (HPI_VER_DECIMAL / 100 & ~1)) {
+	if ((header.version >> 9) != (HPI_VER >> 9)) {
+		/* Consider even and subsequent odd minor versions to be compatible */
 		dev_printk(KERN_ERR, &dev->dev,
 			"Incompatible firmware version "
-			"DSP image %d != Driver %d\n", header.version,
-			HPI_VER_DECIMAL);
+			"DSP image %X != Driver %X\n", header.version,
+			HPI_VER);
 		goto error2;
 	}
 
-	if (header.version != HPI_VER_DECIMAL) {
-		dev_printk(KERN_WARNING, &dev->dev,
-			"Firmware: release version mismatch  DSP image %d != Driver %d\n",
-			header.version, HPI_VER_DECIMAL);
+	if (header.version != HPI_VER) {
+		dev_printk(KERN_INFO, &dev->dev,
+			"Firmware: release version mismatch  DSP image %X != Driver %X\n",
+			header.version, HPI_VER);
 	}
 
 	HPI_DEBUG_LOG(DEBUG, "dsp code %s opened\n", fw_name);
diff --git a/sound/pci/asihpi/hpidspcd.h b/sound/pci/asihpi/hpidspcd.h
index b228811..659d19c 100644
--- a/sound/pci/asihpi/hpidspcd.h
+++ b/sound/pci/asihpi/hpidspcd.h
@@ -27,10 +27,6 @@ Functions for reading DSP code to load into DSP
 
 #include "hpi_internal.h"
 
-/** Code header version is decimal encoded e.g. 4.06.10 is 40601 */
-#define HPI_VER_DECIMAL ((int)(HPI_VER_MAJOR(HPI_VER) * 10000 + \
-HPI_VER_MINOR(HPI_VER) * 100 + HPI_VER_RELEASE(HPI_VER)))
-
 /** Header structure for dsp firmware file
  This structure must match that used in s2bin.c for generation of asidsp.bin
  */
diff --git a/sound/pci/asihpi/hpimsgx.c b/sound/pci/asihpi/hpimsgx.c
index 2e77942..d4790dd 100644
--- a/sound/pci/asihpi/hpimsgx.c
+++ b/sound/pci/asihpi/hpimsgx.c
@@ -1,7 +1,7 @@
 /******************************************************************************
 
     AudioScience HPI driver
-    Copyright (C) 1997-2010  AudioScience Inc. <support@audioscience.com>
+    Copyright (C) 1997-2011  AudioScience Inc. <support@audioscience.com>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of version 2 of the GNU General Public License as
@@ -22,6 +22,7 @@ Extended Message Function With Response Caching
 *****************************************************************************/
 #define SOURCEFILE_NAME "hpimsgx.c"
 #include "hpi_internal.h"
+#include "hpi_version.h"
 #include "hpimsginit.h"
 #include "hpicmn.h"
 #include "hpimsgx.h"
diff --git a/sound/pci/asihpi/hpioctl.c b/sound/pci/asihpi/hpioctl.c
index f6b9517..75f7a2d 100644
--- a/sound/pci/asihpi/hpioctl.c
+++ b/sound/pci/asihpi/hpioctl.c
@@ -21,6 +21,7 @@ Common Linux HPI ioctl and module probe/remove functions
 #define SOURCEFILE_NAME "hpioctl.c"
 
 #include "hpi_internal.h"
+#include "hpi_version.h"
 #include "hpimsginit.h"
 #include "hpidebug.h"
 #include "hpimsgx.h"
-- 
1.7.0.4
