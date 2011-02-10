From: linux@audioscience.com
Subject: [PATCH 07/28] Add adapter index to cache info for
	debug.
Date: Thu, 10 Feb 2011 17:26:00 +1300
Message-ID: <1297311981-30448-8-git-send-email-linux@audioscience.com>
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
 pci/asihpi/hpi6000.c |    3 +++
 pci/asihpi/hpi6205.c |    3 +++
 pci/asihpi/hpicmn.c  |   16 ++++++++++++----
 pci/asihpi/hpicmn.h  |    3 ++-
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/pci/asihpi/hpi6000.c b/pci/asihpi/hpi6000.c
index c85db49..c486af1 100644
--- a/pci/asihpi/hpi6000.c
+++ b/pci/asihpi/hpi6000.c
@@ -582,6 +582,9 @@ static short create_adapter_obj(struct hpi_adapter_obj *pao,
 		pao->adapter_type, pao->index);
 	pao->open = 0;	/* upon creation the adapter is closed */
 
+	if (phw->p_cache)
+		phw->p_cache->adap_idx = pao->index;
+
 	return hpi_add_adapter(pao);
 }
 
diff --git a/pci/asihpi/hpi6205.c b/pci/asihpi/hpi6205.c
index b740edc..5ebf8f8 100644
--- a/pci/asihpi/hpi6205.c
+++ b/pci/asihpi/hpi6205.c
@@ -718,6 +718,9 @@ static u16 create_adapter_obj(struct hpi_adapter_obj *pao,
 
 	pao->open = 0;	/* upon creation the adapter is closed */
 
+	if (phw->p_cache)
+		phw->p_cache->adap_idx = pao->index;
+
 	HPI_DEBUG_LOG(INFO, "bootload DSP OK\n");
 
 	return hpi_add_adapter(pao);
diff --git a/pci/asihpi/hpicmn.c b/pci/asihpi/hpicmn.c
index 793236e..85c2972 100644
--- a/pci/asihpi/hpicmn.c
+++ b/pci/asihpi/hpicmn.c
@@ -197,11 +197,18 @@ static unsigned int control_cache_alloc_check(struct hpi_control_cache *pC)
 				&p_master_cache[byte_count];
 
 			if (!info->size_in32bit_words) {
+				if (i == 0) {
+					HPI_DEBUG_LOG(INFO,
+						"adap %d cache not ready?\n",
+						pC->adap_idx);
+					return 0;
+				}
 				/* ? This is a severe error, the cache is probably
 				   corrupted.  Minimum valid entry size is
 				   sizeof(struct hpi_control_cache_info) */
 				HPI_DEBUG_LOG(ERROR,
-					"zero size cache entry %d\n", i);
+					"adap %d zero size cache entry %d\n",
+					pC->adap_idx, i);
 				break;
 			}
 
@@ -231,12 +238,13 @@ static unsigned int control_cache_alloc_check(struct hpi_control_cache *pC)
 
 		if (byte_count != pC->cache_size_in_bytes)
 			HPI_DEBUG_LOG(WARNING,
-				"bytecount %d != cache size %d", byte_count,
+				"adap %d bytecount %d != cache size %d",
+				pC->adap_idx, byte_count,
 				pC->cache_size_in_bytes);
 		else
 			HPI_DEBUG_LOG(DEBUG,
-				"cache good. bytecount == cache size = %d",
-				byte_count);
+				"adap %d cache good, bytecount == cache size = %d",
+				pC->adap_idx, byte_count);
 
 		pC->init = cached;
 	}
diff --git a/pci/asihpi/hpicmn.h b/pci/asihpi/hpicmn.h
index e2f6f1f..2708c4d 100644
--- a/pci/asihpi/hpicmn.h
+++ b/pci/asihpi/hpicmn.h
@@ -33,8 +33,9 @@ struct hpi_adapter_obj {
 };
 
 struct hpi_control_cache {
-	u32 init;	     /**< indicates whether the
+	u16 init;	     /**< indicates whether the
 				structures are initialized */
+	u16 adap_idx;
 	u32 control_count;
 	u32 cache_size_in_bytes;
 	struct hpi_control_cache_info
-- 
1.7.0.4
