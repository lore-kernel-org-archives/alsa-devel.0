From: linux@audioscience.com
Subject: [PATCH 1/5] Remove unused io map functions.
Date: Thu, 27 May 2010 17:53:51 +1200
Message-ID: <1274939635-1370-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
 sound/pci/asihpi/hpios.c |   23 -----------------------
 sound/pci/asihpi/hpios.h |    9 ---------
 2 files changed, 0 insertions(+), 32 deletions(-)

diff --git a/sound/pci/asihpi/hpios.c b/sound/pci/asihpi/hpios.c
index de615cf..742ee12 100644
--- a/sound/pci/asihpi/hpios.c
+++ b/sound/pci/asihpi/hpios.c
@@ -89,26 +89,3 @@ u16 hpios_locked_mem_free(struct consistent_dma_area *p_mem_area)
 void hpios_locked_mem_free_all(void)
 {
 }
-
-void __iomem *hpios_map_io(struct pci_dev *pci_dev, int idx,
-	unsigned int length)
-{
-	HPI_DEBUG_LOG(DEBUG, "mapping %d %s %08llx-%08llx %04llx len 0x%x\n",
-		idx, pci_dev->resource[idx].name,
-		(unsigned long long)pci_resource_start(pci_dev, idx),
-		(unsigned long long)pci_resource_end(pci_dev, idx),
-		(unsigned long long)pci_resource_flags(pci_dev, idx), length);
-
-	if (!(pci_resource_flags(pci_dev, idx) & IORESOURCE_MEM)) {
-		HPI_DEBUG_LOG(ERROR, "not an io memory resource\n");
-		return NULL;
-	}
-
-	if (length > pci_resource_len(pci_dev, idx)) {
-		HPI_DEBUG_LOG(ERROR, "resource too small for requested %d \n",
-			length);
-		return NULL;
-	}
-
-	return ioremap(pci_resource_start(pci_dev, idx), length);
-}
diff --git a/sound/pci/asihpi/hpios.h b/sound/pci/asihpi/hpios.h
index a62c3f1..370f39b 100644
--- a/sound/pci/asihpi/hpios.h
+++ b/sound/pci/asihpi/hpios.h
@@ -166,13 +166,4 @@ struct hpi_adapter {
 	void __iomem *ap_remapped_mem_base[HPI_MAX_ADAPTER_MEM_SPACES];
 };
 
-static inline void hpios_unmap_io(void __iomem *addr,
-	unsigned long size)
-{
-	iounmap(addr);
-}
-
-void __iomem *hpios_map_io(struct pci_dev *pci_dev, int idx,
-	unsigned int length);
-
 #endif
-- 
1.7.0.4
