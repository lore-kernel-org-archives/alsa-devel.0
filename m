From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: asihpi - fix return type of
	hpios_locked_mem_alloc()
Date: Wed, 28 Mar 2012 09:57:02 +0300
Message-ID: <20120328065702.GA9113@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcsinet15.oracle.com (rcsinet15.oracle.com [148.87.113.117])
	by alsa0.perex.cz (Postfix) with ESMTP id D7F31103EC5
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Mar 2012 08:57:28 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This function returns zero or -ENOMEM, but because it's type is u16, the
-ENOMEM gets changed to 65524.  None of the callers care, but lets fix
it anyway as a cleanup.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/pci/asihpi/hpi_internal.h b/sound/pci/asihpi/hpi_internal.h
index 4cc315d..8c63200 100644
--- a/sound/pci/asihpi/hpi_internal.h
+++ b/sound/pci/asihpi/hpi_internal.h
@@ -42,7 +42,7 @@ On error *pLockedMemHandle marked invalid, non-zero returned.
 If this function succeeds, then HpiOs_LockedMem_GetVirtAddr() and
 HpiOs_LockedMem_GetPyhsAddr() will always succed on the returned handle.
 */
-u16 hpios_locked_mem_alloc(struct consistent_dma_area *p_locked_mem_handle,
+int hpios_locked_mem_alloc(struct consistent_dma_area *p_locked_mem_handle,
 							   /**< memory handle */
 	u32 size, /**< Size in bytes to allocate */
 	struct pci_dev *p_os_reference
diff --git a/sound/pci/asihpi/hpios.c b/sound/pci/asihpi/hpios.c
index 2d7d1c2..87f4385 100644
--- a/sound/pci/asihpi/hpios.c
+++ b/sound/pci/asihpi/hpios.c
@@ -43,7 +43,7 @@ void hpios_delay_micro_seconds(u32 num_micro_sec)
 
 On error, return -ENOMEM, and *pMemArea.size = 0
 */
-u16 hpios_locked_mem_alloc(struct consistent_dma_area *p_mem_area, u32 size,
+int hpios_locked_mem_alloc(struct consistent_dma_area *p_mem_area, u32 size,
 	struct pci_dev *pdev)
 {
 	/*?? any benefit in using managed dmam_alloc_coherent? */
