From: linux@audioscience.com
Subject: [[PATCH] snd-asihpi: 8/8] Minor cleanups
Date: Tue, 05 Apr 2011 20:55:48 +1200
Message-ID: <1301993748-21113-8-git-send-email-linux@audioscience.com>
References: <1301993748-21113-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1301993748-21113-1-git-send-email-linux@audioscience.com>
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

Remove some unneeded defintions
Use %pR to print resources
Make some data const
Consistent braces for else

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/hpi_internal.h |    2 --
 pci/asihpi/hpicmn.c       |    9 +++++++--
 pci/asihpi/hpicmn.h       |    2 ++
 pci/asihpi/hpioctl.c      |    9 +++------
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/pci/asihpi/hpi_internal.h b/pci/asihpi/hpi_internal.h
index d829a65..4fab159 100644
--- a/pci/asihpi/hpi_internal.h
+++ b/pci/asihpi/hpi_internal.h
@@ -1583,9 +1583,7 @@ void hpi_stream_response_to_legacy(struct hpi_stream_res *pSR);
 
 /*////////////////////////////////////////////////////////////////////////// */
 /* declarations for individual HPI entry points */
-hpi_handler_func HPI_1000;
 hpi_handler_func HPI_6000;
 hpi_handler_func HPI_6205;
-hpi_handler_func HPI_COMMON;
 
 #endif				/* _HPI_INTERNAL_H_ */
diff --git a/pci/asihpi/hpicmn.c b/pci/asihpi/hpicmn.c
index 0428f28..b15a02e 100644
--- a/pci/asihpi/hpicmn.c
+++ b/pci/asihpi/hpicmn.c
@@ -227,8 +227,9 @@ static unsigned int control_cache_alloc_check(struct hpi_control_cache *pC)
 			if (info->control_type) {
 				pC->p_info[info->control_index] = info;
 				cached++;
-			} else	/* dummy cache entry */
+			} else {	/* dummy cache entry */
 				pC->p_info[info->control_index] = NULL;
+			}
 
 			byte_count += info->size_in32bit_words * 4;
 
@@ -298,7 +299,7 @@ struct pad_ofs_size {
 	unsigned int field_size;
 };
 
-static struct pad_ofs_size pad_desc[] = {
+static const struct pad_ofs_size pad_desc[] = {
 	HPICMN_PAD_OFS_AND_SIZE(c_channel),	/* HPI_PAD_CHANNEL_NAME */
 	HPICMN_PAD_OFS_AND_SIZE(c_artist),	/* HPI_PAD_ARTIST */
 	HPICMN_PAD_OFS_AND_SIZE(c_title),	/* HPI_PAD_TITLE */
@@ -617,6 +618,10 @@ void hpi_cmn_control_cache_sync_to_msg(struct hpi_control_cache *p_cache,
 	}
 }
 
+/** Allocate control cache.
+
+\return Cache pointer, or NULL if allocation fails.
+*/
 struct hpi_control_cache *hpi_alloc_control_cache(const u32 control_count,
 	const u32 size_in_bytes, u8 *p_dsp_control_buffer)
 {
diff --git a/pci/asihpi/hpicmn.h b/pci/asihpi/hpicmn.h
index 590f0b6..d53cdf6 100644
--- a/pci/asihpi/hpicmn.h
+++ b/pci/asihpi/hpicmn.h
@@ -60,3 +60,5 @@ void hpi_cmn_control_cache_sync_to_msg(struct hpi_control_cache *pC,
 	struct hpi_message *phm, struct hpi_response *phr);
 
 u16 hpi_validate_response(struct hpi_message *phm, struct hpi_response *phr);
+
+hpi_handler_func HPI_COMMON;
diff --git a/pci/asihpi/hpioctl.c b/pci/asihpi/hpioctl.c
index 844295e..14bbb94 100644
--- a/pci/asihpi/hpioctl.c
+++ b/pci/asihpi/hpioctl.c
@@ -312,7 +312,7 @@ out:
 int __devinit asihpi_adapter_probe(struct pci_dev *pci_dev,
 	const struct pci_device_id *pci_id)
 {
-	int err, idx, nm;
+	int idx, nm;
 	unsigned int memlen;
 	struct hpi_message hm;
 	struct hpi_response hr;
@@ -346,11 +346,8 @@ int __devinit asihpi_adapter_probe(struct pci_dev *pci_dev,
 	nm = HPI_MAX_ADAPTER_MEM_SPACES;
 
 	for (idx = 0; idx < nm; idx++) {
-		HPI_DEBUG_LOG(INFO, "resource %d %s %08llx-%08llx %04llx\n",
-			idx, pci_dev->resource[idx].name,
-			(unsigned long long)pci_resource_start(pci_dev, idx),
-			(unsigned long long)pci_resource_end(pci_dev, idx),
-			(unsigned long long)pci_resource_flags(pci_dev, idx));
+		HPI_DEBUG_LOG(INFO, "resource %d %pR\n", idx,
+			&pci_dev->resource[idx]);
 
 		if (pci_resource_flags(pci_dev, idx) & IORESOURCE_MEM) {
 			memlen = pci_resource_len(pci_dev, idx);
-- 
1.7.0.4
