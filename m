From: linux@audioscience.com
Subject: [PATCH 04/15] ALSA: asihpi - DSP code loader API now
	independent of OS
Date: Fri, 22 Jul 2011 15:52:42 +1200
Message-ID: <1311306785-23116-8-git-send-email-linux@audioscience.com>
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

The loader API has been revised so that OS specific data is kept
local to hpidspcd.c, and the public API is unchanged across OSes.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/hpi6000.c  |    7 +--
 sound/pci/asihpi/hpi6205.c  |    5 +-
 sound/pci/asihpi/hpidspcd.c |  136 +++++++++++++++++-------------------------
 sound/pci/asihpi/hpidspcd.h |   72 ++++++++++++----------
 4 files changed, 98 insertions(+), 122 deletions(-)

diff --git a/sound/pci/asihpi/hpi6000.c b/sound/pci/asihpi/hpi6000.c
index c8db36e..3cc6f11 100644
--- a/sound/pci/asihpi/hpi6000.c
+++ b/sound/pci/asihpi/hpi6000.c
@@ -946,11 +946,8 @@ static short hpi6000_adapter_boot_load_dsp(struct hpi_adapter_obj *pao,
 		}
 
 		/* write the DSP code down into the DSPs memory */
-		/*HpiDspCode_Open(nBootLoadFamily,&DspCode,pdwOsErrorCode); */
-		dsp_code.ps_dev = pao->pci.pci_dev;
-
-		error = hpi_dsp_code_open(boot_load_family, &dsp_code,
-			pos_error_code);
+		error = hpi_dsp_code_open(boot_load_family, pao->pci.pci_dev,
+			&dsp_code, pos_error_code);
 
 		if (error)
 			return error;
diff --git a/sound/pci/asihpi/hpi6205.c b/sound/pci/asihpi/hpi6205.c
index d011932..3e31a3f 100644
--- a/sound/pci/asihpi/hpi6205.c
+++ b/sound/pci/asihpi/hpi6205.c
@@ -1371,9 +1371,8 @@ static u16 adapter_boot_load_dsp(struct hpi_adapter_obj *pao,
 			return err;
 
 		/* write the DSP code down into the DSPs memory */
-		dsp_code.ps_dev = pao->pci.pci_dev;
-		err = hpi_dsp_code_open(boot_code_id[dsp], &dsp_code,
-			pos_error_code);
+		err = hpi_dsp_code_open(boot_code_id[dsp], pao->pci.pci_dev,
+			&dsp_code, pos_error_code);
 		if (err)
 			return err;
 
diff --git a/sound/pci/asihpi/hpidspcd.c b/sound/pci/asihpi/hpidspcd.c
index 5c6ea11..a03eb86 100644
--- a/sound/pci/asihpi/hpidspcd.c
+++ b/sound/pci/asihpi/hpidspcd.c
@@ -1,8 +1,8 @@
 /***********************************************************************/
-/*!
+/**
 
     AudioScience HPI driver
-    Copyright (C) 1997-2010  AudioScience Inc. <support@audioscience.com>
+    Copyright (C) 1997-2011  AudioScience Inc. <support@audioscience.com>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of version 2 of the GNU General Public License as
@@ -18,90 +18,61 @@
     Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 
 \file
-Functions for reading DSP code to load into DSP
-
-(Linux only:) If DSPCODE_FIRMWARE_LOADER is defined, code is read using
+Functions for reading DSP code using
 hotplug firmware loader from individual dsp code files
-
-If neither of the above is defined, code is read from linked arrays.
-DSPCODE_ARRAY is defined.
-
-HPI_INCLUDE_**** must be defined
-and the appropriate hzz?????.c or hex?????.c linked in
-
- */
+*/
 /***********************************************************************/
 #define SOURCEFILE_NAME "hpidspcd.c"
 #include "hpidspcd.h"
 #include "hpidebug.h"
+#include "linux/pci.h"
 
-/**
- Header structure for binary dsp code file (see asidsp.doc)
- This structure must match that used in s2bin.c for generation of asidsp.bin
- */
-
-#ifndef DISABLE_PRAGMA_PACK1
-#pragma pack(push, 1)
-#endif
-
-struct code_header {
-	u32 size;
-	char type[4];
-	u32 adapter;
-	u32 version;
-	u32 crc;
+struct dsp_code_private {
+	/**  Firmware descriptor */
+	const struct firmware *firmware;
+	struct pci_dev *dev;
 };
 
-#ifndef DISABLE_PRAGMA_PACK1
-#pragma pack(pop)
-#endif
-
 #define HPI_VER_DECIMAL ((int)(HPI_VER_MAJOR(HPI_VER) * 10000 + \
 	    HPI_VER_MINOR(HPI_VER) * 100 + HPI_VER_RELEASE(HPI_VER)))
 
-/***********************************************************************/
 #include <linux/pci.h>
 /*-------------------------------------------------------------------*/
-short hpi_dsp_code_open(u32 adapter, struct dsp_code *ps_dsp_code,
-	u32 *pos_error_code)
+short hpi_dsp_code_open(u32 adapter, void *os_data, struct dsp_code *dsp_code,
+	u32 *os_error_code)
 {
-	const struct firmware *ps_firmware = ps_dsp_code->ps_firmware;
+	const struct firmware *firmware;
+	struct pci_dev *dev = os_data;
 	struct code_header header;
 	char fw_name[20];
 	int err;
 
 	sprintf(fw_name, "asihpi/dsp%04x.bin", adapter);
 
-	err = request_firmware(&ps_firmware, fw_name,
-		&ps_dsp_code->ps_dev->dev);
+	err = request_firmware(&firmware, fw_name, &dev->dev);
 
-	if (err != 0) {
-		dev_printk(KERN_ERR, &ps_dsp_code->ps_dev->dev,
+	if (err || !firmware) {
+		dev_printk(KERN_ERR, &dev->dev,
 			"%d, request_firmware failed for  %s\n", err,
 			fw_name);
 		goto error1;
 	}
-	if (ps_firmware->size < sizeof(header)) {
-		dev_printk(KERN_ERR, &ps_dsp_code->ps_dev->dev,
-			"Header size too small %s\n", fw_name);
-		goto error2;
-	}
-	memcpy(&header, ps_firmware->data, sizeof(header));
-	if (header.adapter != adapter) {
-		dev_printk(KERN_ERR, &ps_dsp_code->ps_dev->dev,
-			"Adapter type incorrect %4x != %4x\n", header.adapter,
-			adapter);
+	if (firmware->size < sizeof(header)) {
+		dev_printk(KERN_ERR, &dev->dev, "Header size too small %s\n",
+			fw_name);
 		goto error2;
 	}
-	if (header.size != ps_firmware->size) {
-		dev_printk(KERN_ERR, &ps_dsp_code->ps_dev->dev,
-			"Code size wrong  %d != %ld\n", header.size,
-			(unsigned long)ps_firmware->size);
+	memcpy(&header, firmware->data, sizeof(header));
+
+	if ((header.type != 0x45444F43) ||	/* "CODE" */
+		(header.adapter != adapter)
+		|| (header.size != firmware->size)) {
+		dev_printk(KERN_ERR, &dev->dev, "Invalid firmware file\n");
 		goto error2;
 	}
 
-	if (header.version / 100 != HPI_VER_DECIMAL / 100) {
-		dev_printk(KERN_ERR, &ps_dsp_code->ps_dev->dev,
+	if ((header.version / 100 & ~1) != (HPI_VER_DECIMAL / 100 & ~1)) {
+		dev_printk(KERN_ERR, &dev->dev,
 			"Incompatible firmware version "
 			"DSP image %d != Driver %d\n", header.version,
 			HPI_VER_DECIMAL);
@@ -109,67 +80,70 @@ short hpi_dsp_code_open(u32 adapter, struct dsp_code *ps_dsp_code,
 	}
 
 	if (header.version != HPI_VER_DECIMAL) {
-		dev_printk(KERN_WARNING, &ps_dsp_code->ps_dev->dev,
+		dev_printk(KERN_WARNING, &dev->dev,
 			"Firmware: release version mismatch  DSP image %d != Driver %d\n",
 			header.version, HPI_VER_DECIMAL);
 	}
 
 	HPI_DEBUG_LOG(DEBUG, "dsp code %s opened\n", fw_name);
-	ps_dsp_code->ps_firmware = ps_firmware;
-	ps_dsp_code->block_length = header.size / sizeof(u32);
-	ps_dsp_code->word_count = sizeof(header) / sizeof(u32);
-	ps_dsp_code->version = header.version;
-	ps_dsp_code->crc = header.crc;
+	dsp_code->pvt = kmalloc(sizeof(*dsp_code->pvt), GFP_KERNEL);
+	if (!dsp_code->pvt)
+		return HPI_ERROR_MEMORY_ALLOC;
+
+	dsp_code->pvt->dev = dev;
+	dsp_code->pvt->firmware = firmware;
+	dsp_code->header = header;
+	dsp_code->block_length = header.size / sizeof(u32);
+	dsp_code->word_count = sizeof(header) / sizeof(u32);
 	return 0;
 
 error2:
-	release_firmware(ps_firmware);
+	release_firmware(firmware);
 error1:
-	ps_dsp_code->ps_firmware = NULL;
-	ps_dsp_code->block_length = 0;
+	dsp_code->block_length = 0;
 	return HPI_ERROR_DSP_FILE_NOT_FOUND;
 }
 
 /*-------------------------------------------------------------------*/
-void hpi_dsp_code_close(struct dsp_code *ps_dsp_code)
+void hpi_dsp_code_close(struct dsp_code *dsp_code)
 {
-	if (ps_dsp_code->ps_firmware != NULL) {
+	if (dsp_code->pvt->firmware) {
 		HPI_DEBUG_LOG(DEBUG, "dsp code closed\n");
-		release_firmware(ps_dsp_code->ps_firmware);
-		ps_dsp_code->ps_firmware = NULL;
+		release_firmware(dsp_code->pvt->firmware);
+		dsp_code->pvt->firmware = NULL;
 	}
+	kfree(dsp_code->pvt);
 }
 
 /*-------------------------------------------------------------------*/
-void hpi_dsp_code_rewind(struct dsp_code *ps_dsp_code)
+void hpi_dsp_code_rewind(struct dsp_code *dsp_code)
 {
 	/* Go back to start of  data, after header */
-	ps_dsp_code->word_count = sizeof(struct code_header) / sizeof(u32);
+	dsp_code->word_count = sizeof(struct code_header) / sizeof(u32);
 }
 
 /*-------------------------------------------------------------------*/
-short hpi_dsp_code_read_word(struct dsp_code *ps_dsp_code, u32 *pword)
+short hpi_dsp_code_read_word(struct dsp_code *dsp_code, u32 *pword)
 {
-	if (ps_dsp_code->word_count + 1 > ps_dsp_code->block_length)
+	if (dsp_code->word_count + 1 > dsp_code->block_length)
 		return HPI_ERROR_DSP_FILE_FORMAT;
 
-	*pword = ((u32 *)(ps_dsp_code->ps_firmware->data))[ps_dsp_code->
+	*pword = ((u32 *)(dsp_code->pvt->firmware->data))[dsp_code->
 		word_count];
-	ps_dsp_code->word_count++;
+	dsp_code->word_count++;
 	return 0;
 }
 
 /*-------------------------------------------------------------------*/
 short hpi_dsp_code_read_block(size_t words_requested,
-	struct dsp_code *ps_dsp_code, u32 **ppblock)
+	struct dsp_code *dsp_code, u32 **ppblock)
 {
-	if (ps_dsp_code->word_count + words_requested >
-		ps_dsp_code->block_length)
+	if (dsp_code->word_count + words_requested > dsp_code->block_length)
 		return HPI_ERROR_DSP_FILE_FORMAT;
 
 	*ppblock =
-		((u32 *)(ps_dsp_code->ps_firmware->data)) +
-		ps_dsp_code->word_count;
-	ps_dsp_code->word_count += words_requested;
+		((u32 *)(dsp_code->pvt->firmware->data)) +
+		dsp_code->word_count;
+	dsp_code->word_count += words_requested;
 	return 0;
 }
diff --git a/sound/pci/asihpi/hpidspcd.h b/sound/pci/asihpi/hpidspcd.h
index 65f0ca7..b228811 100644
--- a/sound/pci/asihpi/hpidspcd.h
+++ b/sound/pci/asihpi/hpidspcd.h
@@ -2,7 +2,7 @@
 /**
 
     AudioScience HPI driver
-    Copyright (C) 1997-2010  AudioScience Inc. <support@audioscience.com>
+    Copyright (C) 1997-2011  AudioScience Inc. <support@audioscience.com>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of version 2 of the GNU General Public License as
@@ -20,19 +20,6 @@
 \file
 Functions for reading DSP code to load into DSP
 
- hpi_dspcode_defines HPI DSP code loading method
-Define exactly one of these to select how the DSP code is supplied to
-the adapter.
-
-End users writing applications that use the HPI interface do not have to
-use any of the below defines; they are only necessary for building drivers
-
-HPI_DSPCODE_FILE:
-DSP code is supplied as a file that is opened and read from by the driver.
-
-HPI_DSPCODE_FIRMWARE:
-DSP code is read using the hotplug firmware loader module.
-     Only valid when compiling the HPI kernel driver under Linux.
 */
 /***********************************************************************/
 #ifndef _HPIDSPCD_H_
@@ -40,37 +27,56 @@ DSP code is read using the hotplug firmware loader module.
 
 #include "hpi_internal.h"
 
-#ifndef DISABLE_PRAGMA_PACK1
-#pragma pack(push, 1)
-#endif
+/** Code header version is decimal encoded e.g. 4.06.10 is 40601 */
+#define HPI_VER_DECIMAL ((int)(HPI_VER_MAJOR(HPI_VER) * 10000 + \
+HPI_VER_MINOR(HPI_VER) * 100 + HPI_VER_RELEASE(HPI_VER)))
+
+/** Header structure for dsp firmware file
+ This structure must match that used in s2bin.c for generation of asidsp.bin
+ */
+/*#ifndef DISABLE_PRAGMA_PACK1 */
+/*#pragma pack(push, 1) */
+/*#endif */
+struct code_header {
+	/** Size in bytes including header */
+	u32 size;
+	/** File type tag "CODE" == 0x45444F43 */
+	u32 type;
+	/** Adapter model number */
+	u32 adapter;
+	/** Firmware version*/
+	u32 version;
+	/** Data checksum */
+	u32 checksum;
+};
+/*#ifndef DISABLE_PRAGMA_PACK1 */
+/*#pragma pack(pop) */
+/*#endif */
+
+/*? Don't need the pragmas? */
+compile_time_assert((sizeof(struct code_header) == 20), code_header_size);
 
 /** Descriptor for dspcode from firmware loader */
 struct dsp_code {
-	/**  Firmware descriptor */
-	const struct firmware *ps_firmware;
-	struct pci_dev *ps_dev;
+	/** copy of  file header */
+	struct code_header header;
 	/** Expected number of words in the whole dsp code,INCL header */
-	long int block_length;
+	u32 block_length;
 	/** Number of words read so far */
-	long int word_count;
-	/** Version read from dsp code file */
-	u32 version;
-	/** CRC read from dsp code file */
-	u32 crc;
-};
+	u32 word_count;
 
-#ifndef DISABLE_PRAGMA_PACK1
-#pragma pack(pop)
-#endif
+	/** internal state of DSP code reader */
+	struct dsp_code_private *pvt;
+};
 
-/** Prepare *psDspCode to refer to the requuested adapter.
- Searches the file, or selects the appropriate linked array
+/** Prepare *psDspCode to refer to the requested adapter's firmware.
+Code file name is obtained from HpiOs_GetDspCodePath
 
 \return 0 for success, or error code if requested code is not available
 */
 short hpi_dsp_code_open(
 	/** Code identifier, usually adapter family */
-	u32 adapter,
+	u32 adapter, void *pci_dev,
 	/** Pointer to DSP code control structure */
 	struct dsp_code *ps_dsp_code,
 	/** Pointer to dword to receive OS specific error code */
-- 
1.7.0.4
