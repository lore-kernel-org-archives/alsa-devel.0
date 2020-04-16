Return-Path: <SRS0=OoyA=6A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3164C2BB55
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2020 15:05:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F758206D9
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2020 15:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kTENBCwg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Usb+FvXd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F758206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9302D167D;
	Thu, 16 Apr 2020 17:04:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9302D167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587049548;
	bh=Py1t3WtY3Cj6mRD67xr0rn+5WyEdVDntxMuYA9qdaJ4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kTENBCwggnR13kxD6SoCbWZAnR9Mmp3ckbBSzWKz9F4WAXzvklkDpozzhzfZ+QMbc
	 SjsDbXV19eXjl+BGqaMkh7DZKcwxbWZ1vuc6Uzq1HLCA5+YU/TDLFAL0lkYuGKaP6y
	 U66SdS/h3U9sf6GGZ0n9daLQLDfvSSZyIbnYl7g0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 51A83F802DB;
	Thu, 16 Apr 2020 17:00:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 01C20F8016F; Thu, 16 Apr 2020 17:00:41 +0200 (CEST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CD3FBF80278
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2020 17:00:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD3FBF80278
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="Usb+FvXd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=yyuJrtfVyD3fUEUFSeqLWA3IrF2yJjSqrC/bf4Fe8oE=; b=Usb+FvXdnqXan+JxkQBhdGOZlg
 wA8UpejFK3n0fE9XGKnHea/t+aVmCLNRdL7zyLOKMHR/dWmt8G+Uti19C3t90dgjsk4S7ZmmczWW/
 Ez3AKbTKg6yUn6tUW5+u4MpklOAJAQnTCpStyLhkGLJDPCmD0JQX8BrT1uo7sHkztqwtq1fc9ZM2b
 o78zCaIVcICZg6b86ord1mHoE9JLaN/VgoJYMDdw8Sgqo+kfaEwvvg/+opdzznV32stUMmPSO0mvj
 LXNeSO8BGPnOt71kyP+5iI5jquMiHZDOCO0MSCezo82fW/woNvE7xDCV4KBMauuhWx5/PsaqHRErw
 2IXgzbiQ==;
Received: from [2001:4bb8:184:4aa1:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jP60F-00037B-JH; Thu, 16 Apr 2020 15:00:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 7/7] MIPS: use ioremap_page_range
Date: Thu, 16 Apr 2020 17:00:11 +0200
Message-Id: <20200416150011.820984-8-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416150011.820984-1-hch@lst.de>
References: <20200416150011.820984-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-mips@vger.kernel.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Use the generic ioremap_page_range helper instead of reimplementing it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/mm/ioremap.c | 112 ++++-------------------------------------
 1 file changed, 11 insertions(+), 101 deletions(-)

diff --git a/arch/mips/mm/ioremap.c b/arch/mips/mm/ioremap.c
index c5b5181c7cd0..b6dad2fd5575 100644
--- a/arch/mips/mm/ioremap.c
+++ b/arch/mips/mm/ioremap.c
@@ -14,99 +14,14 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/mm_types.h>
+#include <linux/io.h>
 #include <asm/cacheflush.h>
-#include <asm/io.h>
 #include <asm/tlbflush.h>
 #include <ioremap.h>
 
 #define IS_LOW512(addr) (!((phys_addr_t)(addr) & (phys_addr_t) ~0x1fffffffULL))
 #define IS_KSEG1(addr) (((unsigned long)(addr) & ~0x1fffffffUL) == CKSEG1)
 
-static inline void remap_area_pte(pte_t * pte, unsigned long address,
-	phys_addr_t size, phys_addr_t phys_addr, unsigned long flags)
-{
-	phys_addr_t end;
-	unsigned long pfn;
-	pgprot_t pgprot = __pgprot(_PAGE_GLOBAL | _PAGE_PRESENT | __READABLE
-				   | __WRITEABLE | flags);
-
-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
-	BUG_ON(address >= end);
-	pfn = phys_addr >> PAGE_SHIFT;
-	do {
-		if (!pte_none(*pte)) {
-			printk("remap_area_pte: page already exists\n");
-			BUG();
-		}
-		set_pte(pte, pfn_pte(pfn, pgprot));
-		address += PAGE_SIZE;
-		pfn++;
-		pte++;
-	} while (address && (address < end));
-}
-
-static inline int remap_area_pmd(pmd_t * pmd, unsigned long address,
-	phys_addr_t size, phys_addr_t phys_addr, unsigned long flags)
-{
-	phys_addr_t end;
-
-	address &= ~PGDIR_MASK;
-	end = address + size;
-	if (end > PGDIR_SIZE)
-		end = PGDIR_SIZE;
-	phys_addr -= address;
-	BUG_ON(address >= end);
-	do {
-		pte_t * pte = pte_alloc_kernel(pmd, address);
-		if (!pte)
-			return -ENOMEM;
-		remap_area_pte(pte, address, end - address, address + phys_addr, flags);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address && (address < end));
-	return 0;
-}
-
-static int remap_area_pages(unsigned long address, phys_addr_t phys_addr,
-	phys_addr_t size, unsigned long flags)
-{
-	int error;
-	pgd_t * dir;
-	unsigned long end = address + size;
-
-	phys_addr -= address;
-	dir = pgd_offset(&init_mm, address);
-	flush_cache_all();
-	BUG_ON(address >= end);
-	do {
-		p4d_t *p4d;
-		pud_t *pud;
-		pmd_t *pmd;
-
-		error = -ENOMEM;
-		p4d = p4d_alloc(&init_mm, dir, address);
-		if (!p4d)
-			break;
-		pud = pud_alloc(&init_mm, p4d, address);
-		if (!pud)
-			break;
-		pmd = pmd_alloc(&init_mm, pud, address);
-		if (!pmd)
-			break;
-		if (remap_area_pmd(pmd, address, end - address,
-					 phys_addr + address, flags))
-			break;
-		error = 0;
-		address = (address + PGDIR_SIZE) & PGDIR_MASK;
-		dir++;
-	} while (address && (address < end));
-	flush_tlb_all();
-	return error;
-}
-
 static int __ioremap_check_ram(unsigned long start_pfn, unsigned long nr_pages,
 			       void *arg)
 {
@@ -135,7 +50,7 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, unsigned long size,
 	unsigned long offset, pfn, last_pfn;
 	struct vm_struct *area;
 	phys_addr_t last_addr;
-	void *addr;
+	unsigned long vaddr;
 	void __iomem *cpu_addr;
 
 	cpu_addr = plat_ioremap(phys_addr, size, flags);
@@ -183,27 +98,22 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, unsigned long size,
 	area = get_vm_area(size, VM_IOREMAP);
 	if (!area)
 		return NULL;
-	addr = area->addr;
-	if (remap_area_pages((unsigned long) addr, phys_addr, size, flags)) {
-		vunmap(addr);
+	vaddr = (unsigned long)area->addr;
+
+	flags |= _PAGE_GLOBAL | _PAGE_PRESENT | __READABLE | __WRITEABLE;
+	if (ioremap_page_range(vaddr, vaddr + size, phys_addr,
+			__pgprot(flags))) {
+		free_vm_area(area);
 		return NULL;
 	}
 
-	return (void __iomem *) (offset + (char *)addr);
+	return (void __iomem *)(vaddr + offset);
 }
 EXPORT_SYMBOL(ioremap_prot);
 
 void iounmap(const volatile void __iomem *addr)
 {
-	struct vm_struct *p;
-
-	if (plat_iounmap(addr) || IS_KSEG1(addr))
-		return;
-
-	p = remove_vm_area((void *) (PAGE_MASK & (unsigned long __force) addr));
-	if (!p)
-		printk(KERN_ERR "iounmap: bad address %p\n", addr);
-
-	kfree(p);
+	if (!plat_iounmap(addr) && !IS_KSEG1(addr))
+		vunmap((void *)((unsigned long)addr & PAGE_MASK));
 }
 EXPORT_SYMBOL(iounmap);
-- 
2.25.1

