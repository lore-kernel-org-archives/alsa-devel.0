From: eliot@blennerhassett.gen.nz
Subject: [PATCH 1/3] ALSA: asihpi: relax firmware version check
Date: Thu, 18 Dec 2014 17:57:13 +1300
Message-ID: <1418878635-18960-1-git-send-email-eliot@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 06E662614AF
 for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2014 05:57:51 +0100 (CET)
Received: from mxin3-orange.clear.net.nz
 (lb2-srcnat.clear.net.nz [203.97.32.237])
 by smtp4.clear.net.nz (CLEAR Net Mail)
 with ESMTP id <0NGR009DFHRSW910@smtp4.clear.net.nz> for
 alsa-devel@alsa-project.org; Thu, 18 Dec 2014 17:57:30 +1300 (NZDT)
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
Cc: tiwai@suse.de, Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>

Some products firmware is no longer being updated
e.g. dsp5000, dsp8700  but it should continue to work
with updated HPI versions.
Avoid regression by allowing this firmware to be loaded as
long as major version is the same.
Warn about mismatching versions, as matching versions are
preferred.

Signed-off-by: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
---
 sound/pci/asihpi/hpidspcd.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/sound/pci/asihpi/hpidspcd.c b/sound/pci/asihpi/hpidspcd.c
index ac91637..3603c24 100644
--- a/sound/pci/asihpi/hpidspcd.c
+++ b/sound/pci/asihpi/hpidspcd.c
@@ -1,8 +1,9 @@
-/***********************************************************************/
-/**
+/***********************************************************************
 
     AudioScience HPI driver
-    Copyright (C) 1997-2011  AudioScience Inc. <support@audioscience.com>
+    Functions for reading DSP code using hotplug firmware loader
+
+    Copyright (C) 1997-2014  AudioScience Inc. <support@audioscience.com>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of version 2 of the GNU General Public License as
@@ -17,11 +18,7 @@
     along with this program; if not, write to the Free Software
     Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 
-\file
-Functions for reading DSP code using
-hotplug firmware loader from individual dsp code files
-*/
-/***********************************************************************/
+***********************************************************************/
 #define SOURCEFILE_NAME "hpidspcd.c"
 #include "hpidspcd.h"
 #include "hpidebug.h"
@@ -68,17 +65,18 @@ short hpi_dsp_code_open(u32 adapter, void *os_data, struct dsp_code *dsp_code,
 		goto error2;
 	}
 
-	if ((header.version >> 9) != (HPI_VER >> 9)) {
-		/* Consider even and subsequent odd minor versions to be compatible */
-		dev_err(&dev->dev, "Incompatible firmware version DSP image %X != Driver %X\n",
+	if (HPI_VER_MAJOR(header.version) != HPI_VER_MAJOR(HPI_VER)) {
+		/* Major version change probably means Host-DSP protocol change */
+		dev_err(&dev->dev,
+			"Incompatible firmware version DSP image %X != Driver %X\n",
 			header.version, HPI_VER);
 		goto error2;
 	}
 
 	if (header.version != HPI_VER) {
-		dev_info(&dev->dev,
-			 "Firmware: release version mismatch  DSP image %X != Driver %X\n",
-			 header.version, HPI_VER);
+		dev_warn(&dev->dev,
+			"Firmware version mismatch: DSP image %X != Driver %X\n",
+			header.version, HPI_VER);
 	}
 
 	HPI_DEBUG_LOG(DEBUG, "dsp code %s opened\n", fw_name);
-- 
1.9.1
