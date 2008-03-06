From: Eliot Blennerhassett <linux@audioscience.com>
Subject: [PATCH 1/5] asihpi: minor checkpatch cleanups
Date: Thu, 06 Mar 2008 14:40:44 +1300
Message-ID: <200803061440.44772.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id D13DD10385F
	for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2008 02:36:40 +0100 (CET)
Received: from zaphod (121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JXA00C5XCGFQ700@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 06 Mar 2008 14:36:18 +1300 (NZDT)
Content-disposition: inline
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
List-Id: alsa-devel@alsa-project.org

A few minor checkpatch cleanups. Make hpi ioctl cmd unique.

Signed-off-by: Eliot Blennerhassett <linux@audioscience.com>
---
diff -r 6def4892d3f5 pci/asihpi/hpi6000.c
--- a/pci/asihpi/hpi6000.c	Mon Mar 03 11:05:48 2008 +0100
+++ b/pci/asihpi/hpi6000.c	Wed Mar 05 21:59:25 2008 +1300
@@ -923,15 +923,15 @@ static short Hpi6000_AdapterBootLoadDsp(
 		   0 -
 		   1 -
 		   2 -
-		   3 CLK2EN=1	CLKOUT2 enabled
-		   4 CLK1EN=0	CLKOUT1 disabled
-		   5 EKEN=1 <----------------!! C6713 specific, enables ECLKOUT
+		   3 CLK2EN = 1   CLKOUT2 enabled
+		   4 CLK1EN = 0   CLKOUT1 disabled
+		   5 EKEN = 1 <--!! C6713 specific, enables ECLKOUT
 		   6 -
-		   7 NOHOLD=1	external HOLD disabled
-		   8 HOLDA=0	HOLDA output is low
-		   9 HOLD=0		HOLD input is low
-		   10 ARDY=1	ARDY input is high
-		   11 BUSREQ=0	 BUSREQ output is low
+		   7 NOHOLD = 1   external HOLD disabled
+		   8 HOLDA = 0	  HOLDA output is low
+		   9 HOLD = 0		  HOLD input is low
+		   10 ARDY = 1	  ARDY input is high
+		   11 BUSREQ = 0   BUSREQ output is low
 		   12,13 Reserved = 1
 		 */
 		HpiWriteWord(pdo, 0x01800000, 0x34A8);
@@ -952,12 +952,12 @@ static short Hpi6000_AdapterBootLoadDsp(
 		/* EMIF SDRAM Extension
 		   31-21	0
 		   20		WR2RD = 0
-		   19-18	WR2DEAC=1
-		   17		WR2WR=0
-		   16-15	R2WDQM=2
-		   14-12	RD2WR=4
-		   11-10	RD2DEAC=1
-		   9		RD2RD= 1
+		   19-18	WR2DEAC = 1
+		   17		WR2WR = 0
+		   16-15	R2WDQM = 2
+		   14-12	RD2WR = 4
+		   11-10	RD2DEAC = 1
+		   9		RD2RD = 1
 		   8-7		THZP = 10b
 		   6-5		TWR  = 2-1 = 01b (tWR = 10ns)
 		   4		TRRD = 0b = 2 ECLK (tRRD = 14ns)
diff -r 6def4892d3f5 pci/asihpi/hpi6205.h
--- a/pci/asihpi/hpi6205.h	Mon Mar 03 11:05:48 2008 +0100
+++ b/pci/asihpi/hpi6205.h	Wed Mar 05 22:06:08 2008 +1300
@@ -30,14 +30,14 @@ Copyright AudioScience, Inc., 2003
 /***********************************************************
 	Defines used for basic messaging
 ************************************************************/
-#define H620_HIF_RESET		0
-#define H620_HIF_IDLE		1
-#define H620_HIF_GET_RESP	2
-#define H620_HIF_DATA_DONE	3
-#define H620_HIF_DATA_MASK	0x10
-#define H620_HIF_SEND_DATA	0x14
-#define H620_HIF_GET_DATA	0x15
-#define H620_HIF_UNKNOWN		0xffff
+#define H620_HIF_RESET          0
+#define H620_HIF_IDLE           1
+#define H620_HIF_GET_RESP       2
+#define H620_HIF_DATA_DONE      3
+#define H620_HIF_DATA_MASK      0x10
+#define H620_HIF_SEND_DATA      0x14
+#define H620_HIF_GET_DATA       0x15
+#define H620_HIF_UNKNOWN                0xffff
 
 /***********************************************************
 	Types used for mixer control caching
@@ -48,7 +48,7 @@ Copyright AudioScience, Inc., 2003
 #define HPI_NMIXER_CONTROLS 2048
 
 /*********************************************************************
-	This is used for background buffer bus mastering stream buffers.
+This is used for background buffer bus mastering stream buffers.
 **********************************************************************/
 struct hostbuffer_status_6205 {
 	u32 dwSamplesProcessed;
@@ -62,7 +62,7 @@ struct hostbuffer_status_6205 {
 };
 
 /*********************************************************************
-	This is used for dynamic control cache allocation
+This is used for dynamic control cache allocation
 **********************************************************************/
 struct controlcache_6205 {
 	u32 dwNumberOfControls;
@@ -71,7 +71,7 @@ struct controlcache_6205 {
 };
 
 /*********************************************************************
-	This is used for dynamic allocation of async event array
+This is used for dynamic allocation of async event array
 **********************************************************************/
 struct async_event_buffer_6205 {
 	u32 dwPhysicalPCI32address;
@@ -80,8 +80,8 @@ struct async_event_buffer_6205 {
 };
 
 /***********************************************************
-	The Host located memory buffer that the 6205 will bus master
-	in and out of.
+The Host located memory buffer that the 6205 will bus master
+in and out of.
 ************************************************************/
 #define HPI6205_SIZEOF_DATA (16*1024)
 struct bus_master_interface {
diff -r 6def4892d3f5 pci/asihpi/hpimsginit.c
--- a/pci/asihpi/hpimsginit.c	Mon Mar 03 11:05:48 2008 +0100
+++ b/pci/asihpi/hpimsginit.c	Thu Mar 06 12:21:47 2008 +1300
@@ -29,7 +29,7 @@ static u16 aMsgSize[HPI_OBJ_MAXINDEX + 1
 /* The actual response size for each object type */
 static u16 aResSize[HPI_OBJ_MAXINDEX + 1] = HPI_RESPONSE_SIZE_BY_OBJECT;
 /* Flag to enable alternate message type for SSX2 bypass. */
-static u16 gwSSX2Bypass = 0;
+static u16 gwSSX2Bypass;
 
 /** \internal
   * Used by ASIO driver to disable SSX2 for a single process
diff -r 6def4892d3f5 pci/asihpi/hpios.h
--- a/pci/asihpi/hpios.h	Mon Mar 03 11:05:48 2008 +0100
+++ b/pci/asihpi/hpios.h	Wed Mar 05 21:58:51 2008 +1300
@@ -27,13 +27,6 @@ HPI Operating System function declaratio
 
 #ifndef STR_SIZE
 #define STR_SIZE(a) (a)
-#endif
-
-#ifndef __user
-#define __user
-#endif
-#ifndef __iomem
-#define __iomem
 #endif
 
 /* physical memory allocation */
diff -r 6def4892d3f5 pci/asihpi/hpios_linux_kernel.h
--- a/pci/asihpi/hpios_linux_kernel.h	Mon Mar 03 11:05:48 2008 +0100
+++ b/pci/asihpi/hpios_linux_kernel.h	Wed Mar 05 21:59:18 2008 +1300
@@ -28,6 +28,7 @@ HPI Operating System Specific macros for
 #endif
 
 #include <asm/io.h>
+#include <asm/system.h>
 #include <linux/ioctl.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -35,10 +36,7 @@ HPI Operating System Specific macros for
 #include <linux/firmware.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2 , 5 , 0))
-#    include <linux/device.h>
-#endif
+#include <linux/device.h>
 
 #define INLINE inline
 
@@ -104,9 +102,8 @@ struct hpi_ioctl_linux {
 
 /* Conflict?: H is already used by a number of drivers hid, bluetooth hci,
    and some sound drivers sb16, hdsp, emu10k. AFAIK 0xFC is ununsed command
+*/
 #define HPI_IOCTL_LINUX _IOWR('H', 0xFC, struct hpi_ioctl_linux)
-*/
-#define HPI_IOCTL_LINUX _IOWR('H', 1, struct hpi_ioctl_linux)
 
 #define HPI_DEBUG_FLAG_ERROR   KERN_ERR
 #define HPI_DEBUG_FLAG_WARNING KERN_WARNING
