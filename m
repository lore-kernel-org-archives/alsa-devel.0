From: eliot@blennerhassett.gen.nz
Subject: [PATCH 05/10] ALSA: asihpi: Refactor control cache
	code.
Date: Thu, 20 Nov 2014 16:22:52 +1300
Message-ID: <1416453777-7155-6-git-send-email-eliot@blennerhassett.gen.nz>
References: <1416453777-7155-1-git-send-email-eliot@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CE19265876
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 04:25:43 +0100 (CET)
Received: from mxin1-orange.clear.net.nz
 (lb2-srcnat.clear.net.nz [203.97.32.237])
 by smtp3.clear.net.nz (CLEAR Net Mail)
 with ESMTP id <0NFB007VJIU9ZE20@smtp3.clear.net.nz> for
 alsa-devel@alsa-project.org; Thu, 20 Nov 2014 16:25:41 +1300 (NZDT)
In-reply-to: <1416453777-7155-1-git-send-email-eliot@blennerhassett.gen.nz>
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

Signed-off-by: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
---
 sound/pci/asihpi/hpicmn.c | 107 +++++++++++++++++++++++++++-------------------
 1 file changed, 63 insertions(+), 44 deletions(-)

diff --git a/sound/pci/asihpi/hpicmn.c b/sound/pci/asihpi/hpicmn.c
index 7ed5c26..c775124 100644
--- a/sound/pci/asihpi/hpicmn.c
+++ b/sound/pci/asihpi/hpicmn.c
@@ -1,7 +1,7 @@
 /******************************************************************************
 
     AudioScience HPI driver
-    Copyright (C) 1997-2011  AudioScience Inc. <support@audioscience.com>
+    Copyright (C) 1997-2014  AudioScience Inc. <support@audioscience.com>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of version 2 of the GNU General Public License as
@@ -206,6 +206,14 @@ static unsigned int control_cache_alloc_check(struct hpi_control_cache *pC)
 			struct hpi_control_cache_info *info =
 				(struct hpi_control_cache_info *)
 				&p_master_cache[byte_count];
+			u16 control_index = info->control_index;
+
+			if (control_index >= pC->control_count) {
+				HPI_DEBUG_LOG(INFO,
+					"adap %d control index %d out of range, cache not ready?\n",
+					pC->adap_idx, control_index);
+				return 0;
+			}
 
 			if (!info->size_in32bit_words) {
 				if (!i) {
@@ -225,10 +233,10 @@ static unsigned int control_cache_alloc_check(struct hpi_control_cache *pC)
 			}
 
 			if (info->control_type) {
-				pC->p_info[info->control_index] = info;
+				pC->p_info[control_index] = info;
 				cached++;
 			} else {	/* dummy cache entry */
-				pC->p_info[info->control_index] = NULL;
+				pC->p_info[control_index] = NULL;
 			}
 
 			byte_count += info->size_in32bit_words * 4;
@@ -309,35 +317,18 @@ static const struct pad_ofs_size pad_desc[] = {
 /** CheckControlCache checks the cache and fills the struct hpi_response
  * accordingly. It returns one if a cache hit occurred, zero otherwise.
  */
-short hpi_check_control_cache(struct hpi_control_cache *p_cache,
+short hpi_check_control_cache_single(struct hpi_control_cache_single *pC,
 	struct hpi_message *phm, struct hpi_response *phr)
 {
-	short found = 1;
-	struct hpi_control_cache_info *pI;
-	struct hpi_control_cache_single *pC;
 	size_t response_size;
-	if (!find_control(phm->obj_index, p_cache, &pI)) {
-		HPI_DEBUG_LOG(VERBOSE,
-			"HPICMN find_control() failed for adap %d\n",
-			phm->adapter_index);
-		return 0;
-	}
-
-	phr->error = 0;
-	phr->specific_error = 0;
-	phr->version = 0;
+	short found = 1;
 
 	/* set the default response size */
 	response_size =
 		sizeof(struct hpi_response_header) +
 		sizeof(struct hpi_control_res);
 
-	/* pC is the default cached control strucure. May be cast to
-	   something else in the following switch statement.
-	 */
-	pC = (struct hpi_control_cache_single *)pI;
-
-	switch (pI->control_type) {
+	switch (pC->u.i.control_type) {
 
 	case HPI_CONTROL_METER:
 		if (phm->u.c.attribute == HPI_METER_PEAK) {
@@ -467,7 +458,7 @@ short hpi_check_control_cache(struct hpi_control_cache *p_cache,
 		break;
 	case HPI_CONTROL_PAD:{
 			struct hpi_control_cache_pad *p_pad;
-			p_pad = (struct hpi_control_cache_pad *)pI;
+			p_pad = (struct hpi_control_cache_pad *)pC;
 
 			if (!(p_pad->field_valid_flags & (1 <<
 						HPI_CTL_ATTR_INDEX(phm->u.c.
@@ -531,7 +522,8 @@ short hpi_check_control_cache(struct hpi_control_cache *p_cache,
 
 	HPI_DEBUG_LOG(VERBOSE, "%s Adap %d, Ctl %d, Type %d, Attr %d\n",
 		found ? "Cached" : "Uncached", phm->adapter_index,
-		pI->control_index, pI->control_type, phm->u.c.attribute);
+		pC->u.i.control_index, pC->u.i.control_type,
+		phm->u.c.attribute);
 
 	if (found) {
 		phr->size = (u16)response_size;
@@ -543,34 +535,36 @@ short hpi_check_control_cache(struct hpi_control_cache *p_cache,
 	return found;
 }
 
-/** Updates the cache with Set values.
-
-Only update if no error.
-Volume and Level return the limited values in the response, so use these
-Multiplexer does so use sent values
-*/
-void hpi_cmn_control_cache_sync_to_msg(struct hpi_control_cache *p_cache,
+short hpi_check_control_cache(struct hpi_control_cache *p_cache,
 	struct hpi_message *phm, struct hpi_response *phr)
 {
-	struct hpi_control_cache_single *pC;
 	struct hpi_control_cache_info *pI;
 
-	if (phr->error)
-		return;
-
 	if (!find_control(phm->obj_index, p_cache, &pI)) {
 		HPI_DEBUG_LOG(VERBOSE,
 			"HPICMN find_control() failed for adap %d\n",
 			phm->adapter_index);
-		return;
+		return 0;
 	}
 
-	/* pC is the default cached control strucure.
-	   May be cast to something else in the following switch statement.
-	 */
-	pC = (struct hpi_control_cache_single *)pI;
+	phr->error = 0;
+	phr->specific_error = 0;
+	phr->version = 0;
+
+	return hpi_check_control_cache_single((struct hpi_control_cache_single
+			*)pI, phm, phr);
+}
+
+/** Updates the cache with Set values.
 
-	switch (pI->control_type) {
+Only update if no error.
+Volume and Level return the limited values in the response, so use these
+Multiplexer does so use sent values
+*/
+void hpi_cmn_control_cache_sync_to_msg_single(struct hpi_control_cache_single
+	*pC, struct hpi_message *phm, struct hpi_response *phr)
+{
+	switch (pC->u.i.control_type) {
 	case HPI_CONTROL_VOLUME:
 		if (phm->u.c.attribute == HPI_VOLUME_GAIN) {
 			pC->u.vol.an_log[0] = phr->u.c.an_log_value[0];
@@ -625,6 +619,30 @@ void hpi_cmn_control_cache_sync_to_msg(struct hpi_control_cache *p_cache,
 	}
 }
 
+void hpi_cmn_control_cache_sync_to_msg(struct hpi_control_cache *p_cache,
+	struct hpi_message *phm, struct hpi_response *phr)
+{
+	struct hpi_control_cache_single *pC;
+	struct hpi_control_cache_info *pI;
+
+	if (phr->error)
+		return;
+
+	if (!find_control(phm->obj_index, p_cache, &pI)) {
+		HPI_DEBUG_LOG(VERBOSE,
+			"HPICMN find_control() failed for adap %d\n",
+			phm->adapter_index);
+		return;
+	}
+
+	/* pC is the default cached control strucure.
+	   May be cast to something else in the following switch statement.
+	 */
+	pC = (struct hpi_control_cache_single *)pI;
+
+	hpi_cmn_control_cache_sync_to_msg_single(pC, phm, phr);
+}
+
 /** Allocate control cache.
 
 \return Cache pointer, or NULL if allocation fails.
@@ -637,12 +655,13 @@ struct hpi_control_cache *hpi_alloc_control_cache(const u32 control_count,
 	if (!p_cache)
 		return NULL;
 
-	p_cache->p_info = kcalloc(control_count, sizeof(*p_cache->p_info),
-				  GFP_KERNEL);
+	p_cache->p_info =
+		kcalloc(control_count, sizeof(*p_cache->p_info), GFP_KERNEL);
 	if (!p_cache->p_info) {
 		kfree(p_cache);
 		return NULL;
 	}
+
 	p_cache->cache_size_in_bytes = size_in_bytes;
 	p_cache->control_count = control_count;
 	p_cache->p_cache = p_dsp_control_buffer;
-- 
1.9.1
