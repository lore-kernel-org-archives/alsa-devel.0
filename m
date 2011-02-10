From: linux@audioscience.com
Subject: [PATCH 12/28] Reduce number of error codes returned to
	upper layers.
Date: Thu, 10 Feb 2011 17:26:05 +1300
Message-ID: <1297311981-30448-13-git-send-email-linux@audioscience.com>
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

Create and use HPI_ERROR_DSP_COMMUNICATION _DSP_BOOTLOAD, rather than
backend-specific error codes (now returned as data with the error).


Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/hpi.h     |   43 +++++++++++++++++++------------------
 pci/asihpi/hpi6000.c |   58 ++++++++++++++++++++++++++++++++-----------------
 pci/asihpi/hpi6205.c |   15 +++++++++++-
 3 files changed, 73 insertions(+), 43 deletions(-)

diff --git a/pci/asihpi/hpi.h b/pci/asihpi/hpi.h
index efed0c1..212a016 100644
--- a/pci/asihpi/hpi.h
+++ b/pci/asihpi/hpi.h
@@ -43,8 +43,8 @@ i.e 3.05.02 is a development version
 #define HPI_VER_RELEASE(v) ((int)(v & 0xFF))
 
 /* Use single digits for versions less that 10 to avoid octal. */
-#define HPI_VER HPI_VERSION_CONSTRUCTOR(4L, 5, 17)
-#define HPI_VER_STRING "4.05.17"
+#define HPI_VER HPI_VERSION_CONSTRUCTOR(4L, 5, 19)
+#define HPI_VER_STRING "4.05.19"
 
 /* Library version as documented in hpi-api-versions.txt */
 #define HPI_LIB_VER  HPI_VERSION_CONSTRUCTOR(9, 0, 0)
@@ -433,11 +433,14 @@ return true.
 
 /** Adapter mode commands
 
-Used in wQueryOrSet field of HPI_AdapterSetModeEx().
+Used in wQueryOrSet parameter of HPI_AdapterSetModeEx().
 \ingroup adapter
 */
 enum HPI_ADAPTER_MODE_CMDS {
+	/** Set the mode to the given parameter */
 	HPI_ADAPTER_MODE_SET = 0,
+	/** Return 0 or error depending whether mode is valid,
+	but don't set the mode */
 	HPI_ADAPTER_MODE_QUERY = 1
 };
 
@@ -874,8 +877,7 @@ enum HPI_ERROR_CODES {
 	HPI_ERROR_OBJ_ALREADY_OPEN = 105,
 	/** PCI, ISA resource not valid. */
 	HPI_ERROR_INVALID_RESOURCE = 106,
-	/* GetInfo call from SubSysFindAdapters failed. */
-	/*HPI_ERROR_SUBSYSFINDADAPTERS_GETINFO= 107, */
+	/* HPI_ERROR_SUBSYSFINDADAPTERS_GETINFO= 107 */
 	/** Default response was never updated with actual error code. */
 	HPI_ERROR_INVALID_RESPONSE = 108,
 	/** wSize field of response was not updated,
@@ -905,8 +907,7 @@ enum HPI_ERROR_CODES {
 	*/
 	HPI_ERROR_MESSAGE_BUFFER_TOO_SMALL = 117,
 
-	/* Too many adapters. */
-	/* HPI_ERROR_TOO_MANY_ADAPTERS= 200, */
+	/* HPI_ERROR_TOO_MANY_ADAPTERS= 200 */
 	/** Bad adpater. */
 	HPI_ERROR_BAD_ADAPTER = 201,
 	/** Adapter number out of range or not set properly. */
@@ -915,15 +916,15 @@ enum HPI_ERROR_CODES {
 	HPI_DUPLICATE_ADAPTER_NUMBER = 203,
 	/** DSP code failed to bootload. (unused?) */
 	HPI_ERROR_DSP_BOOTLOAD = 204,
-	/** Adapter failed DSP code self test. (unused?) */
-	HPI_ERROR_DSP_SELFTEST = 205,
+	/** Communication with DSP failed */
+	HPI_ERROR_DSP_COMMUNICATION = 205,
 	/** Couldn't find or open the DSP code file. */
 	HPI_ERROR_DSP_FILE_NOT_FOUND = 206,
 	/** Internal DSP hardware error. */
 	HPI_ERROR_DSP_HARDWARE = 207,
 	/** Could not allocate memory */
 	HPI_ERROR_MEMORY_ALLOC = 208,
-	/** Failed to correctly load/config PLD. (unused?) */
+	/** Failed to correctly load/config PLD. (unused) */
 	HPI_ERROR_PLD_LOAD = 209,
 	/** Unexpected end of file, block length too big etc. */
 	HPI_ERROR_DSP_FILE_FORMAT = 210,
@@ -932,8 +933,7 @@ enum HPI_ERROR_CODES {
 	HPI_ERROR_DSP_FILE_ACCESS_DENIED = 211,
 	/** First DSP code section header not found in DSP file. */
 	HPI_ERROR_DSP_FILE_NO_HEADER = 212,
-	/* File read operation on DSP code file failed. */
-	/*HPI_ERROR_DSP_FILE_READ_ERROR= 213, */
+	/* HPI_ERROR_DSP_FILE_READ_ERROR= 213, */
 	/** DSP code for adapter family not found. */
 	HPI_ERROR_DSP_SECTION_NOT_FOUND = 214,
 	/** Other OS specific error opening DSP file. */
@@ -943,8 +943,7 @@ enum HPI_ERROR_CODES {
 	/** DSP code section header had size == 0. */
 	HPI_ERROR_DSP_FILE_NULL_HEADER = 217,
 
-	/* Base number for flash errors. */
-	/* HPI_ERROR_FLASH              = 220, */
+	/* HPI_ERROR_FLASH = 220, */
 
 	/** Flash has bad checksum */
 	HPI_ERROR_BAD_CHECKSUM = 221,
@@ -958,8 +957,8 @@ enum HPI_ERROR_CODES {
 	/** Reserved for OEMs. */
 	HPI_ERROR_RESERVED_1 = 290,
 
-	/* Stream does not exist. */
-	/*HPI_ERROR_INVALID_STREAM= 300, // use HPI_ERROR_INVALID_OBJ_INDEX */
+	/* HPI_ERROR_INVALID_STREAM = 300,
+	   use HPI_ERROR_INVALID_OBJ_INDEX  */
 	/** Invalid compression format. */
 	HPI_ERROR_INVALID_FORMAT = 301,
 	/** Invalid format samplerate */
@@ -970,10 +969,12 @@ enum HPI_ERROR_CODES {
 	HPI_ERROR_INVALID_BITRATE = 304,
 	/** Invalid datasize used for stream read/write. */
 	HPI_ERROR_INVALID_DATASIZE = 305,
-	/* Stream buffer is full during stream write. */
-	/*HPI_ERROR_BUFFER_FULL = 306, // USE HPI_ERROR_INVALID_DATASIZE */
-	/* Stream buffer is empty during stream read. */
-	/*HPI_ERROR_BUFFER_EMPTY = 307, // USE HPI_ERROR_INVALID_DATASIZE */
+	/* Stream buffer is full during stream write.
+	   HPI_ERROR_BUFFER_FULL = 306,
+	   Stream buffer is empty during stream read.
+	   HPI_ERROR_BUFFER_EMPTY = 307,
+	   Use HPI_ERROR_INVALID_DATASIZE
+	 */
 	/** Null data pointer used for stream read/write. */
 	HPI_ERROR_INVALID_DATA_POINTER = 308,
 	/** Packet ordering error for stream read/write. */
@@ -1010,6 +1011,7 @@ enum HPI_ERROR_CODES {
 	HPI_ERROR_CONTROL_DISABLED = 404,
 	/** I2C transaction failed due to a missing ACK. */
 	HPI_ERROR_CONTROL_I2C_MISSING_ACK = 405,
+	HPI_ERROR_I2C_MISSING_ACK = 405,
 	/** Control is busy, or coming out of
 	reset and cannot be accessed at this time. */
 	HPI_ERROR_CONTROL_NOT_READY = 407,
@@ -1020,7 +1022,6 @@ enum HPI_ERROR_CODES {
 	HPI_ERROR_NVMEM_FAIL = 452,
 
 	/** I2C */
-	HPI_ERROR_I2C_MISSING_ACK = 405,	/*HPI_ERROR_CONTROL_I2C_MISSING_ACK */
 	HPI_ERROR_I2C_BAD_ADR = 460,
 
 	/** Entity errors */
diff --git a/pci/asihpi/hpi6000.c b/pci/asihpi/hpi6000.c
index 4346583..9a05672 100644
--- a/pci/asihpi/hpi6000.c
+++ b/pci/asihpi/hpi6000.c
@@ -237,10 +237,19 @@ static void control_message(struct hpi_adapter_obj *pao,
 	switch (phm->function) {
 	case HPI_CONTROL_GET_STATE:
 		if (pao->has_control_cache) {
-			phr->error = hpi6000_update_control_cache(pao, phm);
-
-			if (phr->error)
+			u16 err;
+			err = hpi6000_update_control_cache(pao, phm);
+
+			if (err) {
+				if (err >= HPI_ERROR_BACKEND_BASE) {
+					phr->error =
+						HPI_ERROR_CONTROL_CACHING;
+					phr->specific_error = err;
+				} else {
+					phr->error = err;
+				}
 				break;
+			}
 
 			if (hpi_check_control_cache(((struct hpi_hw_obj *)
 						pao->priv)->p_cache, phm,
@@ -405,7 +414,7 @@ static void subsys_create_adapter(struct hpi_message *phm,
 	struct hpi_adapter_obj ao;
 	struct hpi_adapter_obj *pao;
 	u32 os_error_code;
-	short error = 0;
+	u16 err = 0;
 	u32 dsp_index = 0;
 
 	HPI_DEBUG_LOG(VERBOSE, "subsys_create_adapter\n");
@@ -422,10 +431,16 @@ static void subsys_create_adapter(struct hpi_message *phm,
 	/* create the adapter object based on the resource information */
 	ao.pci = *phm->u.s.resource.r.pci;
 
-	error = create_adapter_obj(&ao, &os_error_code);
-	if (error) {
+	err = create_adapter_obj(&ao, &os_error_code);
+	if (err) {
 		delete_adapter_obj(&ao);
-		phr->error = error;
+		if (err >= HPI_ERROR_BACKEND_BASE) {
+			phr->error = HPI_ERROR_DSP_BOOTLOAD;
+			phr->specific_error = err;
+		} else {
+			phr->error = err;
+		}
+
 		phr->u.s.data = os_error_code;
 		return;
 	}
@@ -434,7 +449,7 @@ static void subsys_create_adapter(struct hpi_message *phm,
 	if (!pao) {
 		/* We just added this adapter, why can't we find it!? */
 		HPI_DEBUG_LOG(ERROR, "lost adapter after boot\n");
-		phr->error = 950;
+		phr->error = HPI_ERROR_BAD_ADAPTER;
 		return;
 	}
 
@@ -1763,17 +1778,11 @@ static void hw_message(struct hpi_adapter_obj *pao, struct hpi_message *phm,
 	hpios_dsplock_lock(pao);
 	error = hpi6000_message_response_sequence(pao, dsp_index, phm, phr);
 
-	/* maybe an error response */
-	if (error) {
-		/* something failed in the HPI/DSP interface */
-		phr->error = error;
-		/* just the header of the response is valid */
-		phr->size = sizeof(struct hpi_response_header);
+	if (error)	/* something failed in the HPI/DSP interface */
 		goto err;
-	}
 
-	if (phr->error != 0)	/* something failed in the DSP */
-		goto err;
+	if (phr->error)	/* something failed in the DSP */
+		goto out;
 
 	switch (phm->function) {
 	case HPI_OSTREAM_WRITE:
@@ -1796,10 +1805,19 @@ static void hw_message(struct hpi_adapter_obj *pao, struct hpi_message *phm,
 		}
 	}
 
-	if (error)
-		phr->error = error;
-
 err:
+	if (error) {
+		if (error >= HPI_ERROR_BACKEND_BASE) {
+			phr->error = HPI_ERROR_DSP_COMMUNICATION;
+			phr->specific_error = error;
+		} else {
+			phr->error = error;
+		}
+
+		/* just the header of the response is valid */
+		phr->size = sizeof(struct hpi_response_header);
+	}
+out:
 	hpios_dsplock_unlock(pao);
 	return;
 }
diff --git a/pci/asihpi/hpi6205.c b/pci/asihpi/hpi6205.c
index a3f650d..5fe535b 100644
--- a/pci/asihpi/hpi6205.c
+++ b/pci/asihpi/hpi6205.c
@@ -478,7 +478,12 @@ static void subsys_create_adapter(struct hpi_message *phm,
 	err = create_adapter_obj(&ao, &os_error_code);
 	if (err) {
 		delete_adapter_obj(&ao);
-		phr->error = err;
+		if (err >= HPI_ERROR_BACKEND_BASE) {
+			phr->error = HPI_ERROR_DSP_BOOTLOAD;
+			phr->specific_error = err;
+		} else {
+			phr->error = err;
+		}
 		phr->u.s.data = os_error_code;
 		return;
 	}
@@ -2242,7 +2247,13 @@ static void hw_message(struct hpi_adapter_obj *pao, struct hpi_message *phm,
 	/* maybe an error response */
 	if (err) {
 		/* something failed in the HPI/DSP interface */
-		phr->error = err;
+		if (err >= HPI_ERROR_BACKEND_BASE) {
+			phr->error = HPI_ERROR_DSP_COMMUNICATION;
+			phr->specific_error = err;
+		} else {
+			phr->error = err;
+		}
+
 		pao->dsp_crashed++;
 
 		/* just the header of the response is valid */
-- 
1.7.0.4
