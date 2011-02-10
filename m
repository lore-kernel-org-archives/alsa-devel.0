From: linux@audioscience.com
Subject: [PATCH 13/28] Code cleanup.
Date: Thu, 10 Feb 2011 17:26:06 +1300
Message-ID: <1297311981-30448-14-git-send-email-linux@audioscience.com>
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

Remove unused function.
Simplify hpi_alloc_control_cache.
Remove useless assignment to struct subsequently freed.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/hpicmn.c |   42 +++++++++---------------------------------
 pci/asihpi/hpicmn.h |   15 +++++++--------
 2 files changed, 16 insertions(+), 41 deletions(-)

diff --git a/pci/asihpi/hpicmn.c b/pci/asihpi/hpicmn.c
index 8346aea..4d696ab 100644
--- a/pci/asihpi/hpicmn.c
+++ b/pci/asihpi/hpicmn.c
@@ -156,7 +156,7 @@ static void subsys_get_adapter(struct hpi_message *phm,
 	/* find the nCount'th nonzero adapter in array */
 	for (index = 0; index < HPI_MAX_ADAPTERS; index++) {
 		if (adapters.adapter[index].adapter_type) {
-			if (count == 0)
+			if (!count)
 				break;
 			count--;
 		}
@@ -199,7 +199,7 @@ static unsigned int control_cache_alloc_check(struct hpi_control_cache *pC)
 				&p_master_cache[byte_count];
 
 			if (!info->size_in32bit_words) {
-				if (i == 0) {
+				if (!i) {
 					HPI_DEBUG_LOG(INFO,
 						"adap %d cache not ready?\n",
 						pC->adap_idx);
@@ -279,28 +279,6 @@ static short find_control(u16 control_index,
 	return 1;
 }
 
-/** Used by the kernel driver to figure out if a buffer needs mapping.
- */
-short hpi_check_buffer_mapping(struct hpi_control_cache *p_cache,
-	struct hpi_message *phm, void **p, unsigned int *pN)
-{
-	*pN = 0;
-	*p = NULL;
-	if ((phm->function == HPI_CONTROL_GET_STATE)
-		&& (phm->object == HPI_OBJ_CONTROLEX)
-		) {
-		struct hpi_control_cache_info *pI;
-
-		if (!find_control(phm->obj_index, p_cache, &pI)) {
-			HPI_DEBUG_LOG(VERBOSE,
-				"HPICMN find_control() failed for adap %d\n",
-				phm->adapter_index);
-			return 0;
-		}
-	}
-	return 0;
-}
-
 /* allow unified treatment of several string fields within struct */
 #define HPICMN_PAD_OFS_AND_SIZE(m)  {\
 	offsetof(struct hpi_control_cache_pad, m), \
@@ -612,24 +590,24 @@ void hpi_cmn_control_cache_sync_to_msg(struct hpi_control_cache *p_cache,
 	}
 }
 
-struct hpi_control_cache *hpi_alloc_control_cache(const u32
-	number_of_controls, const u32 size_in_bytes, u8 *pDSP_control_buffer)
+struct hpi_control_cache *hpi_alloc_control_cache(const u32 control_count,
+	const u32 size_in_bytes, u8 *p_dsp_control_buffer)
 {
 	struct hpi_control_cache *p_cache =
 		kmalloc(sizeof(*p_cache), GFP_KERNEL);
 	if (!p_cache)
 		return NULL;
+
 	p_cache->p_info =
-		kmalloc(sizeof(*p_cache->p_info) * number_of_controls,
-			GFP_KERNEL);
+		kmalloc(sizeof(*p_cache->p_info) * control_count, GFP_KERNEL);
 	if (!p_cache->p_info) {
 		kfree(p_cache);
 		return NULL;
 	}
+	memset(p_cache->p_info, 0, sizeof(*p_cache->p_info) * control_count);
 	p_cache->cache_size_in_bytes = size_in_bytes;
-	p_cache->control_count = number_of_controls;
-	p_cache->p_cache =
-		(struct hpi_control_cache_single *)pDSP_control_buffer;
+	p_cache->control_count = control_count;
+	p_cache->p_cache = p_dsp_control_buffer;
 	p_cache->init = 0;
 	return p_cache;
 }
@@ -638,8 +616,6 @@ void hpi_free_control_cache(struct hpi_control_cache *p_cache)
 {
 	if (p_cache) {
 		kfree(p_cache->p_info);
-		p_cache->p_info = NULL;
-		p_cache->init = 0;
 		kfree(p_cache);
 	}
 }
diff --git a/pci/asihpi/hpicmn.h b/pci/asihpi/hpicmn.h
index 2708c4d..6db1e0b 100644
--- a/pci/asihpi/hpicmn.h
+++ b/pci/asihpi/hpicmn.h
@@ -33,15 +33,15 @@ struct hpi_adapter_obj {
 };
 
 struct hpi_control_cache {
-	u16 init;	     /**< indicates whether the
-				structures are initialized */
+	/** indicates whether the structures are initialized */
+	u16 init;
 	u16 adap_idx;
 	u32 control_count;
 	u32 cache_size_in_bytes;
-	struct hpi_control_cache_info
-	**p_info;		 /**< pointer to allocated memory of
-				lookup pointers. */
-	u8 *p_cache;	/**< pointer to DSP's control cache. */
+	/** pointer to allocated memory of lookup pointers. */
+	struct hpi_control_cache_info **p_info;
+	/** pointer to DSP's control cache. */
+	u8 *p_cache;
 };
 
 struct hpi_adapter_obj *hpi_find_adapter(u16 adapter_index);
@@ -57,6 +57,5 @@ void hpi_free_control_cache(struct hpi_control_cache *p_cache);
 
 void hpi_cmn_control_cache_sync_to_msg(struct hpi_control_cache *pC,
 	struct hpi_message *phm, struct hpi_response *phr);
+
 u16 hpi_validate_response(struct hpi_message *phm, struct hpi_response *phr);
-short hpi_check_buffer_mapping(struct hpi_control_cache *p_cache,
-	struct hpi_message *phm, void **p, unsigned int *pN);
-- 
1.7.0.4
