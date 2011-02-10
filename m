From: linux@audioscience.com
Subject: [PATCH 09/28] Checkpatch line lengths etc.
Date: Thu, 10 Feb 2011 17:26:02 +1300
Message-ID: <1297311981-30448-10-git-send-email-linux@audioscience.com>
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

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/hpi6000.c  |    3 ++-
 pci/asihpi/hpicmn.c   |   31 +++++++++++++++++--------------
 pci/asihpi/hpidebug.c |    2 +-
 pci/asihpi/hpidebug.h |    8 ++++----
 4 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/pci/asihpi/hpi6000.c b/pci/asihpi/hpi6000.c
index c486af1..4346583 100644
--- a/pci/asihpi/hpi6000.c
+++ b/pci/asihpi/hpi6000.c
@@ -43,7 +43,8 @@
 #define HPI_HIF_ERROR_MASK      0x4000
 
 /* HPI6000 specific error codes */
-#define HPI6000_ERROR_BASE                              900	/* not actually used anywhere */
+#define HPI6000_ERROR_BASE 900	/* not actually used anywhere */
+
 /* operational/messaging errors */
 #define HPI6000_ERROR_MSG_RESP_IDLE_TIMEOUT             901
 
diff --git a/pci/asihpi/hpicmn.c b/pci/asihpi/hpicmn.c
index 85c2972..8346aea 100644
--- a/pci/asihpi/hpicmn.c
+++ b/pci/asihpi/hpicmn.c
@@ -46,17 +46,19 @@ static struct hpi_adapters_list adapters;
 u16 hpi_validate_response(struct hpi_message *phm, struct hpi_response *phr)
 {
 	if (phr->type != HPI_TYPE_RESPONSE) {
-		HPI_DEBUG_LOG(ERROR, "header type %d invalid", phr->type);
+		HPI_DEBUG_LOG(ERROR, "header type %d invalid\n", phr->type);
 		return HPI_ERROR_INVALID_RESPONSE;
 	}
 
 	if (phr->object != phm->object) {
-		HPI_DEBUG_LOG(ERROR, "header object %d invalid", phr->object);
+		HPI_DEBUG_LOG(ERROR, "header object %d invalid\n",
+			phr->object);
 		return HPI_ERROR_INVALID_RESPONSE;
 	}
 
 	if (phr->function != phm->function) {
-		HPI_DEBUG_LOG(ERROR, "header type %d invalid", phr->function);
+		HPI_DEBUG_LOG(ERROR, "header type %d invalid\n",
+			phr->function);
 		return HPI_ERROR_INVALID_RESPONSE;
 	}
 
@@ -114,7 +116,7 @@ struct hpi_adapter_obj *hpi_find_adapter(u16 adapter_index)
 	struct hpi_adapter_obj *pao = NULL;
 
 	if (adapter_index >= HPI_MAX_ADAPTERS) {
-		HPI_DEBUG_LOG(VERBOSE, "find_adapter invalid index %d ",
+		HPI_DEBUG_LOG(VERBOSE, "find_adapter invalid index %d\n",
 			adapter_index);
 		return NULL;
 	}
@@ -203,9 +205,10 @@ static unsigned int control_cache_alloc_check(struct hpi_control_cache *pC)
 						pC->adap_idx);
 					return 0;
 				}
-				/* ? This is a severe error, the cache is probably
-				   corrupted.  Minimum valid entry size is
-				   sizeof(struct hpi_control_cache_info) */
+				/* The cache is invalid.
+				 * Minimum valid entry size is
+				 * sizeof(struct hpi_control_cache_info)
+				 */
 				HPI_DEBUG_LOG(ERROR,
 					"adap %d zero size cache entry %d\n",
 					pC->adap_idx, i);
@@ -226,9 +229,10 @@ static unsigned int control_cache_alloc_check(struct hpi_control_cache *pC)
 				info->control_index, info->control_type,
 				info->size_in32bit_words);
 
-			/* quit loop early if whole cache has been scanned. */
-			/* pC->dwControlCount is the maximum possible entries, */
-			/* but some may not be in the cache at all */
+			/* quit loop early if whole cache has been scanned.
+			 * dwControlCount is the maximum possible entries
+			 * but some may be absent from the cache
+			 */
 			if (byte_count >= pC->cache_size_in_bytes)
 				break;
 			/* have seen last control index */
@@ -238,15 +242,15 @@ static unsigned int control_cache_alloc_check(struct hpi_control_cache *pC)
 
 		if (byte_count != pC->cache_size_in_bytes)
 			HPI_DEBUG_LOG(WARNING,
-				"adap %d bytecount %d != cache size %d",
+				"adap %d bytecount %d != cache size %d\n",
 				pC->adap_idx, byte_count,
 				pC->cache_size_in_bytes);
 		else
 			HPI_DEBUG_LOG(DEBUG,
-				"adap %d cache good, bytecount == cache size = %d",
+				"adap %d cache good, bytecount == cache size = %d\n",
 				pC->adap_idx, byte_count);
 
-		pC->init = cached;
+		pC->init = (u16)cached;
 	}
 	return pC->init;
 }
@@ -430,7 +434,6 @@ short hpi_check_control_cache(struct hpi_control_cache *p_cache,
 	case HPI_CONTROL_SILENCEDETECTOR:
 		if (phm->u.c.attribute == HPI_SILENCEDETECTOR_STATE) {
 			phr->u.c.param1 = pC->u.silence.state;
-			/*? phr->u.c.dwParam2 = pC->u.silence.dwCount; */
 		} else
 			found = 0;
 		break;
diff --git a/pci/asihpi/hpidebug.c b/pci/asihpi/hpidebug.c
index 4b81c80..b52baf6 100644
--- a/pci/asihpi/hpidebug.c
+++ b/pci/asihpi/hpidebug.c
@@ -48,7 +48,7 @@ int hpi_debug_level_get(void)
 void hpi_debug_message(struct hpi_message *phm, char *sz_fileline)
 {
 	if (phm) {
-		printk("HPI_MSG%d,%d,%d,%d,%d\n", phm->version,
+		printk(KERN_DEBUG "HPI_MSG%d,%d,%d,%d,%d\n", phm->version,
 			phm->adapter_index, phm->obj_index, phm->function,
 			phm->u.c.attribute);
 	}
diff --git a/pci/asihpi/hpidebug.h b/pci/asihpi/hpidebug.h
index 632d7d0..940f54c 100644
--- a/pci/asihpi/hpidebug.h
+++ b/pci/asihpi/hpidebug.h
@@ -80,17 +80,17 @@ void hpi_debug_data(u16 *pdata, u32 len);
 #define HPI_DEBUG_MESSAGE(level, phm) \
 	do { \
 		if (hpi_debug_level >= HPI_DEBUG_LEVEL_##level) { \
-			hpi_debug_message(phm,HPI_DEBUG_FLAG_##level \
+			hpi_debug_message(phm, HPI_DEBUG_FLAG_##level \
 				FILE_LINE __stringify(level)); \
 		} \
 	} while (0)
 
 #define HPI_DEBUG_RESPONSE(phr) \
 	do { \
-		if (((hpi_debug_level >= HPI_DEBUG_LEVEL_DEBUG) && (phr->error)) ||\
+		if (((hpi_debug_level >= HPI_DEBUG_LEVEL_DEBUG) && \
+			(phr->error)) ||\
 		(hpi_debug_level >= HPI_DEBUG_LEVEL_VERBOSE)) \
-			printk(KERN_DEBUG\
-				"HPI_RES%d,%d,%d\n", \
+			printk(KERN_DEBUG "HPI_RES%d,%d,%d\n", \
 				phr->version, phr->error, phr->specific_error); \
 	} while (0)
 
-- 
1.7.0.4
