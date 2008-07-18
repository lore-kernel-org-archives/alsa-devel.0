From: linux@audioscience.com
Subject: [PATCH - asihpi 5/5] Update to hpi_internal.h. Minor
	cleanups
Date: Fri, 18 Jul 2008 18:00:19 +1200
Message-ID: <1216360819-1847-5-git-send-email-linux@audioscience.com>
References: <1216360819-1847-1-git-send-email-linux@audioscience.com>
	<1216360819-1847-2-git-send-email-linux@audioscience.com>
	<1216360819-1847-3-git-send-email-linux@audioscience.com>
	<1216360819-1847-4-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1216360819-1847-4-git-send-email-linux@audioscience.com>
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
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>


Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>

diff --git a/pci/asihpi/hpi6000.c b/pci/asihpi/hpi6000.c
index 6d1834e..2409490 100644
--- a/pci/asihpi/hpi6000.c
+++ b/pci/asihpi/hpi6000.c
@@ -30,7 +30,7 @@
 *******************************************************************************/
 #define SOURCEFILE_NAME "hpi6000.c"
 
-#include "hpi.h"
+#include "hpi_internal.h"
 #include "hpidebug.h"
 #include "hpi6000.h"
 #include "hpidspcd.h"
@@ -1318,20 +1318,19 @@ static void HpiWriteBlock(
 	u32 dwLength
 )
 {
+	u16 wLength = dwLength - 1;
+
 	if (dwLength == 0)
 		return;
 
 	if (HpiSetAddress(pdo, dwAddress))
 		return;
 
-	{
-		u16 wLength = dwLength - 1;
-		iowrite32_rep(pdo->prHPIDataAutoInc, pdwData, wLength);
+	iowrite32_rep(pdo->prHPIDataAutoInc, pdwData, wLength);
 
-		/* take care of errata in revB DSP (2.0.1) */
-		/* must end with non auto-inc */
-		iowrite32(*(pdwData + dwLength - 1), pdo->prHPIData);
-	}
+	/* take care of errata in revB DSP (2.0.1) */
+	/* must end with non auto-inc */
+	iowrite32(*(pdwData + dwLength - 1), pdo->prHPIData);
 }
 
 /** read a block of 32bit words from the DSP HPI port using auto-inc mode
@@ -1343,20 +1342,19 @@ static void HpiReadBlock(
 	u32 dwLength
 )
 {
+	u16 wLength = dwLength - 1;
+
 	if (dwLength == 0)
 		return;
 
 	if (HpiSetAddress(pdo, dwAddress))
 		return;
 
-	{
-		u16 wLength = dwLength - 1;
-		ioread32_rep(pdo->prHPIDataAutoInc, pdwData, wLength);
+	ioread32_rep(pdo->prHPIDataAutoInc, pdwData, wLength);
 
-		/* take care of errata in revB DSP (2.0.1) */
-		/* must end with non auto-inc */
-		*(pdwData + dwLength - 1) = ioread32(pdo->prHPIData);
-	}
+	/* take care of errata in revB DSP (2.0.1) */
+	/* must end with non auto-inc */
+	*(pdwData + dwLength - 1) = ioread32(pdo->prHPIData);
 }
 
 static u16 Hpi6000_DspBlockWrite32(
diff --git a/pci/asihpi/hpi6205.c b/pci/asihpi/hpi6205.c
index ff010a7..b0c646f 100644
--- a/pci/asihpi/hpi6205.c
+++ b/pci/asihpi/hpi6205.c
@@ -27,7 +27,7 @@
 *******************************************************************************/
 #define SOURCEFILE_NAME "hpi6205.c"
 
-#include "hpi.h"
+#include "hpi_internal.h"
 #include "hpidebug.h"
 #include "hpi6205.h"
 #include "hpidspcd.h"
@@ -618,6 +618,7 @@ static u16 CreateAdapterObj(
 	pHw6205->prDSPP =
 		pao->Pci.apMemBase[1] +
 		C6205_BAR1_DSPP / sizeof(*pao->Pci.apMemBase[1]);
+
 	pao->wHasControlCache = 0;
 
 	if (HpiOs_LockedMem_Alloc(&pHw6205->hLockedMem,
@@ -2108,7 +2109,7 @@ static short Hpi6205_TransferData(
 {
 	struct hpi_hw_obj *pHw6205 = pao->priv;
 	u32 dwDataTransferred = 0;
-	/*u8  *pData =(u8  *)phm->u.d.u.Data.dwpbData; */
+	/*u8 *pData =(u8 *)phm->u.d.u.Data.dwpbData; */
 	/*u16 wTimeOut=8; */
 	u16 err = 0;
 	u32 dwTimeOut, dwTemp2;
diff --git a/pci/asihpi/hpi6205.h b/pci/asihpi/hpi6205.h
index 2c92d59..66fe202 100644
--- a/pci/asihpi/hpi6205.h
+++ b/pci/asihpi/hpi6205.h
@@ -25,7 +25,7 @@ Copyright AudioScience, Inc., 2003
 #ifndef _HPI6205_H_
 #define _HPI6205_H_
 
-#include "hpi.h"
+#include "hpi_internal.h"
 
 /***********************************************************
 	Defines used for basic messaging
diff --git a/pci/asihpi/hpidebug.c b/pci/asihpi/hpidebug.c
index bb470a4..9cfc860 100644
--- a/pci/asihpi/hpidebug.c
+++ b/pci/asihpi/hpidebug.c
@@ -20,8 +20,7 @@ Debug macro translation.
 
 ************************************************************************/
 
-#include "hpi.h"
-#include "hpios.h"
+#include "hpi_internal.h"
 #include "hpidebug.h"
 
 /* Debug level; 0 quiet; 1 informative, 2 debug, 3 verbose debug.  */
diff --git a/pci/asihpi/hpidebug.h b/pci/asihpi/hpidebug.h
index d99a685..d7dfb3b 100644
--- a/pci/asihpi/hpidebug.h
+++ b/pci/asihpi/hpidebug.h
@@ -23,8 +23,7 @@ Debug macros.
 #ifndef _HPIDEBUG_H
 #define _HPIDEBUG_H
 
-#include "hpi.h"
-#include "hpios.h"
+#include "hpi_internal.h"
 
 #ifdef __cplusplus
 /* *INDENT-OFF* */
@@ -262,9 +261,10 @@ function_count_check(HPI_NVMEMORY, 3);
   "HPI_GPIO_OPEN",            \
   "HPI_GPIO_READ_BIT",        \
   "HPI_GPIO_WRITE_BIT",       \
-  "HPI_GPIO_READ_ALL"\
+  "HPI_GPIO_READ_ALL",                \
+  "HPI_GPIO_WRITE_STATUS"\
 }
-function_count_check(HPI_GPIO, 4);
+function_count_check(HPI_GPIO, 5);
 
 #define HPI_WATCHDOG_STRINGS    \
 {                               \
@@ -346,11 +346,12 @@ compile_time_assert((HPI_CONTROL_LAST_INDEX + 1) == (25),
 	"HPI_SOURCENODE_CLOCK_SOURCE", \
 	"HPI_SOURCENODE_RAW_BITSTREAM", \
 	"HPI_SOURCENODE_MICROPHONE", \
-	"HPI_SOURCENODE_COBRANET" \
+	"HPI_SOURCENODE_COBRANET", \
+	"HPI_SOURCENODE_ANALOG" \
 }
 
 compile_time_assert((HPI_SOURCENODE_LAST_INDEX - HPI_SOURCENODE_BASE + 1) ==
-	(10), sourcenode_strings_dont_match_defs);
+	(11), sourcenode_strings_dont_match_defs);
 
 #define HPI_DESTNODE_STRINGS \
 { \
@@ -360,9 +361,10 @@ compile_time_assert((HPI_SOURCENODE_LAST_INDEX - HPI_SOURCENODE_BASE + 1) ==
 	"HPI_DESTNODE_AESEBU_OUT", \
 	"HPI_DESTNODE_RF", \
 	"HPI_DESTNODE_SPEAKER", \
-	"HPI_DESTNODE_COBRANET" \
+	"HPI_DESTNODE_COBRANET", \
+	"HPI_DESTNODE_ANALOG" \
 }
-compile_time_assert((HPI_DESTNODE_LAST_INDEX - HPI_DESTNODE_BASE + 1) == (7),
+compile_time_assert((HPI_DESTNODE_LAST_INDEX - HPI_DESTNODE_BASE + 1) == (8),
 	destnode_strings_dont_match_defs);
 
 #define HPI_CONTROL_CHANNEL_MODE_STRINGS \
diff --git a/pci/asihpi/hpidspcd.h b/pci/asihpi/hpidspcd.h
index 140c095..100a290 100644
--- a/pci/asihpi/hpidspcd.h
+++ b/pci/asihpi/hpidspcd.h
@@ -28,11 +28,10 @@ and the appropriate hzz?????.c or hex?????.c linked in
 If USE_ZLIB is defined, hpizlib.c must also be linked
 */
 /***********************************************************************/
-#ifndef _HPIDSPLD_H_
-#define _HPIDSPLD_H_
+#ifndef _HPIDSPCD_H_
+#define _HPIDSPCD_H_
 
-/*#include <stdio.h> */
-#include "hpi.h"
+#include "hpi_internal.h"
 
 #ifndef DISABLE_PRAGMA_PACK1
 #pragma pack(push, 1)
diff --git a/pci/asihpi/hpimsginit.c b/pci/asihpi/hpimsginit.c
index 5eaeacc..c9698e2 100644
--- a/pci/asihpi/hpimsginit.c
+++ b/pci/asihpi/hpimsginit.c
@@ -21,7 +21,7 @@
  (C) Copyright AudioScience Inc. 2007
 *******************************************************************************/
 
-#include "hpi.h"
+#include "hpi_internal.h"
 #include "hpimsginit.h"
 
 /* The actual message size for each object type */
diff --git a/pci/asihpi/hpimsgx.c b/pci/asihpi/hpimsgx.c
index b843e9f..6ee60dd 100644
--- a/pci/asihpi/hpimsgx.c
+++ b/pci/asihpi/hpimsgx.c
@@ -21,7 +21,7 @@ Extended Message Function With Response Cacheing
 (C) Copyright AudioScience Inc. 2002
 *****************************************************************************/
 #define SOURCEFILE_NAME "hpimsgx.c"
-#include "hpi.h"
+#include "hpi_internal.h"
 #include "hpimsgx.h"
 #include "hpidebug.h"
 
diff --git a/pci/asihpi/hpimsgx.h b/pci/asihpi/hpimsgx.h
index d1009a3..1d8ec33 100644
--- a/pci/asihpi/hpimsgx.h
+++ b/pci/asihpi/hpimsgx.h
@@ -24,7 +24,7 @@
 #ifndef _HPIMSGX_H_
 #define _HPIMSGX_H_
 
-#include "hpi.h"
+#include "hpi_internal.h"
 
 #ifdef __cplusplus
 /* *INDENT-OFF* */
diff --git a/pci/asihpi/hpioctl.c b/pci/asihpi/hpioctl.c
index a13748d..86c67d0 100644
--- a/pci/asihpi/hpioctl.c
+++ b/pci/asihpi/hpioctl.c
@@ -20,7 +20,7 @@ Common Linux HPI ioctl and module probe/remove functions
 *******************************************************************************/
 #define SOURCEFILE_NAME "hpioctl.c"
 
-#include "hpi.h"
+#include "hpi_internal.h"
 #include "hpidebug.h"
 #include "hpimsgx.h"
 #include "hpioctl.h"
@@ -342,11 +342,10 @@ int __devinit asihpi_adapter_probe(
 	mutex_init(&adapters[adapter.index].mutex);
 	pci_set_drvdata(pci_dev, &adapters[adapter.index]);
 
-	/* printk(KERN_INFO
-	   "Probe found adapter ASI%04X HPI index #%d.\n",
-	   adapter.type,
-	   adapter.index);
-	 */
+	printk(KERN_INFO
+		"Probe found adapter ASI%04X HPI index #%d.\n",
+		adapter.type, adapter.index);
+
 	return 0;
 
 err:
diff --git a/pci/asihpi/hpios.h b/pci/asihpi/hpios.h
index 6d7e6aa..002587c 100644
--- a/pci/asihpi/hpios.h
+++ b/pci/asihpi/hpios.h
@@ -25,10 +25,6 @@ HPI Operating System function declarations
 
 #include "hpios_linux_kernel.h"
 
-#ifndef STR_SIZE
-#define STR_SIZE(a) (a)
-#endif
-
 /* physical memory allocation */
 void HpiOs_LockedMem_Init(
 	void
diff --git a/pci/asihpi/hpios_linux_kernel.h b/pci/asihpi/hpios_linux_kernel.h
index e7ad1fd..00a4deb 100644
--- a/pci/asihpi/hpios_linux_kernel.h
+++ b/pci/asihpi/hpios_linux_kernel.h
@@ -33,10 +33,10 @@ HPI Operating System Specific macros for Linux
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/version.h>
+#include <linux/device.h>
 #include <linux/firmware.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
-#include <linux/device.h>
 
 #define INLINE inline
 
-- 
1.5.4.3
