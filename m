From: linux@audioscience.com
Subject: [PATCH] ALSA: asihpi - fix return value of
	hpios_locked_mem_alloc()
Date: Fri, 30 Mar 2012 09:52:25 +1300
Message-ID: <1333054345-1416-1-git-send-email-linux@audioscience.com>
References: <s5hk424t1h9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
	by alsa0.perex.cz (Postfix) with ESMTP id AB1B8104547
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 22:52:41 +0200 (CEST)
Received: from mxin3-orange.clear.net.nz
	(lb2-srcnat.clear.net.nz [203.97.32.237])
	by smtp5.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0M1N001FNZB7MR20@smtp5.clear.net.nz> for
	alsa-devel@alsa-project.org; Fri, 30 Mar 2012 09:52:38 +1300 (NZDT)
In-reply-to: <s5hk424t1h9.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Make this function consistent with others in this module by
returning 1 for error, instead of -ENOMEM
(reverts function signature change from a938fb1e)

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/hpi_internal.h |    4 ++--
 sound/pci/asihpi/hpios.c        |   10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/pci/asihpi/hpi_internal.h b/sound/pci/asihpi/hpi_internal.h
index 8c63200..bc86cb7 100644
--- a/sound/pci/asihpi/hpi_internal.h
+++ b/sound/pci/asihpi/hpi_internal.h
@@ -1,7 +1,7 @@
 /******************************************************************************
 
     AudioScience HPI driver
-    Copyright (C) 1997-2011  AudioScience Inc. <support@audioscience.com>
+    Copyright (C) 1997-2012  AudioScience Inc. <support@audioscience.com>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of version 2 of the GNU General Public License as
@@ -42,7 +42,7 @@ On error *pLockedMemHandle marked invalid, non-zero returned.
 If this function succeeds, then HpiOs_LockedMem_GetVirtAddr() and
 HpiOs_LockedMem_GetPyhsAddr() will always succed on the returned handle.
 */
-int hpios_locked_mem_alloc(struct consistent_dma_area *p_locked_mem_handle,
+u16 hpios_locked_mem_alloc(struct consistent_dma_area *p_locked_mem_handle,
 							   /**< memory handle */
 	u32 size, /**< Size in bytes to allocate */
 	struct pci_dev *p_os_reference
diff --git a/sound/pci/asihpi/hpios.c b/sound/pci/asihpi/hpios.c
index 87f4385..5ef4fe9 100644
--- a/sound/pci/asihpi/hpios.c
+++ b/sound/pci/asihpi/hpios.c
@@ -1,7 +1,7 @@
 /******************************************************************************
 
     AudioScience HPI driver
-    Copyright (C) 1997-2011  AudioScience Inc. <support@audioscience.com>
+    Copyright (C) 1997-2012  AudioScience Inc. <support@audioscience.com>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of version 2 of the GNU General Public License as
@@ -39,11 +39,11 @@ void hpios_delay_micro_seconds(u32 num_micro_sec)
 
 }
 
-/** Allocated an area of locked memory for bus master DMA operations.
+/** Allocate an area of locked memory for bus master DMA operations.
 
-On error, return -ENOMEM, and *pMemArea.size = 0
+If allocation fails, return 1, and *pMemArea.size = 0
 */
-int hpios_locked_mem_alloc(struct consistent_dma_area *p_mem_area, u32 size,
+u16 hpios_locked_mem_alloc(struct consistent_dma_area *p_mem_area, u32 size,
 	struct pci_dev *pdev)
 {
 	/*?? any benefit in using managed dmam_alloc_coherent? */
@@ -62,7 +62,7 @@ int hpios_locked_mem_alloc(struct consistent_dma_area *p_mem_area, u32 size,
 		HPI_DEBUG_LOG(WARNING,
 			"failed to allocate %d bytes locked memory\n", size);
 		p_mem_area->size = 0;
-		return -ENOMEM;
+		return 1;
 	}
 }
 
-- 
1.7.0.4
