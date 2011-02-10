From: linux@audioscience.com
Subject: [PATCH 24/28] Minor define updates
Date: Thu, 10 Feb 2011 17:26:17 +1300
Message-ID: <1297311981-30448-25-git-send-email-linux@audioscience.com>
References: <1297311981-30448-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1297311981-30448-1-git-send-email-linux@audioscience.com>
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

HPI version 4.05.32
Tweak HPI error code for backward compatibility.
Add BUILD to build-related defines.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/hpi.h          |   25 +++++++++++++++++--------
 pci/asihpi/hpi_internal.h |    7 +++----
 pci/asihpi/hpios.h        |    6 ++----
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/pci/asihpi/hpi.h b/pci/asihpi/hpi.h
index ec19df5..dec1c30 100644
--- a/pci/asihpi/hpi.h
+++ b/pci/asihpi/hpi.h
@@ -43,14 +43,15 @@ i.e 3.05.02 is a development version
 #define HPI_VER_RELEASE(v) ((int)(v & 0xFF))
 
 /* Use single digits for versions less that 10 to avoid octal. */
-#define HPI_VER HPI_VERSION_CONSTRUCTOR(4L, 5, 19)
-#define HPI_VER_STRING "4.05.19"
+#define HPI_VER HPI_VERSION_CONSTRUCTOR(4L, 5, 32)
+#define HPI_VER_STRING "4.05.32"
 
 /* Library version as documented in hpi-api-versions.txt */
 #define HPI_LIB_VER  HPI_VERSION_CONSTRUCTOR(9, 0, 0)
 
 #include <linux/types.h>
-#define HPI_EXCLUDE_DEPRECATED
+#define HPI_BUILD_EXCLUDE_DEPRECATED
+#define HPI_BUILD_KERNEL_MODE
 
 /******************************************************************************/
 /********       HPI API DEFINITIONS                                       *****/
@@ -933,11 +934,9 @@ enum HPI_ERROR_CODES {
 	/** Adapter number out of range or not set properly. */
 	HPI_ERROR_BAD_ADAPTER_NUMBER = 202,
 	/** 2 adapters with the same adapter number. */
-	HPI_DUPLICATE_ADAPTER_NUMBER = 203,
+	HPI_ERROR_DUPLICATE_ADAPTER_NUMBER = 203,
 	/** DSP code failed to bootload. (unused?) */
 	HPI_ERROR_DSP_BOOTLOAD = 204,
-	/** Communication with DSP failed */
-	HPI_ERROR_DSP_COMMUNICATION = 205,
 	/** Couldn't find or open the DSP code file. */
 	HPI_ERROR_DSP_FILE_NOT_FOUND = 206,
 	/** Internal DSP hardware error. */
@@ -1056,8 +1055,18 @@ enum HPI_ERROR_CODES {
 	/** hpioct32.c can't obtain mutex */
 	HPI_ERROR_MUTEX_TIMEOUT = 700,
 
-	/** errors from HPI backends have values >= this */
-	HPI_ERROR_BACKEND_BASE = 900
+	/** Backend errors used to be greater than this.
+	    \deprecated Now, all backends return only errors defined here in hpi.h
+	*/
+	HPI_ERROR_BACKEND_BASE = 900,
+
+	/** Communication with DSP failed */
+	HPI_ERROR_DSP_COMMUNICATION = 900
+		/* Note that the dsp communication error is set to this value so that
+		   it remains compatible with any software that expects such errors
+		   to be backend errors i.e. >= 900.
+		   Do not define any new error codes with values > 900.
+		 */
 };
 
 /** \defgroup maximums HPI maximum values
diff --git a/pci/asihpi/hpi_internal.h b/pci/asihpi/hpi_internal.h
index ca5b844..af678be 100644
--- a/pci/asihpi/hpi_internal.h
+++ b/pci/asihpi/hpi_internal.h
@@ -309,8 +309,8 @@ enum HPI_CONTROL_ATTRIBUTES {
 
 #define HPI_ETHERNET_UDP_PORT (44600)	/*!< UDP messaging port */
 
-/** Base network time out is set to 100 milli-seconds. */
-#define HPI_ETHERNET_TIMEOUT_MS      (100)
+/** Default network timeout in milli-seconds. */
+#define HPI_ETHERNET_TIMEOUT_MS 500
 
 /** Locked memory buffer alloc/free phases */
 enum HPI_BUFFER_CMDS {
@@ -389,8 +389,7 @@ enum HPI_OBJECT_TYPES {
 };
 
 #define HPI_OBJ_FUNCTION_SPACING 0x100
-#define HPI_FUNC_ID(obj, index) \
-	(HPI_OBJ_##obj * HPI_OBJ_FUNCTION_SPACING + index)
+#define HPI_FUNC_ID(obj, i) (HPI_OBJ_##obj * HPI_OBJ_FUNCTION_SPACING + i)
 
 #define HPI_EXTRACT_INDEX(fn) (fn & 0xff)
 
diff --git a/pci/asihpi/hpios.h b/pci/asihpi/hpios.h
index 90879b1..03273e7 100644
--- a/pci/asihpi/hpios.h
+++ b/pci/asihpi/hpios.h
@@ -27,9 +27,7 @@ HPI Operating System Specific macros for Linux Kernel driver
 #define HPI_OS_LINUX_KERNEL
 
 #define HPI_OS_DEFINED
-#define HPI_KERNEL_MODE
-
-#define HPI_REASSIGN_DUPLICATE_ADAPTER_IDX
+#define HPI_BUILD_KERNEL_MODE
 
 #include <linux/io.h>
 #include <asm/system.h>
@@ -142,7 +140,7 @@ static inline void cond_unlock(struct hpios_spinlock *l)
 #define hpios_dsplock_unlock(obj)  cond_unlock(&(obj)->dsp_lock)
 
 #ifdef CONFIG_SND_DEBUG
-#define HPI_DEBUG
+#define HPI_BUILD_DEBUG
 #endif
 
 #define HPI_ALIST_LOCKING
-- 
1.7.0.4
