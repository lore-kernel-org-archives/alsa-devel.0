Return-Path: <SRS0=bO7z=B5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A38C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Aug 2020 07:01:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D49E720786
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Aug 2020 07:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Uc9YntOh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FfmYzkf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49E720786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 693651816;
	Wed, 19 Aug 2020 09:00:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 693651816
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597820495;
	bh=VCgq8ayi4/0cRbHFwGIv8Y8XbPr7IJHZP4zeH/2PdqI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Uc9YntOhWBZnM9uZFcIOQvFTRyu+DW5oOl2L2RSYJbkMbiFRo2nEuIY0kud+gyzmc
	 5k3srDZIJs3U2ThmtJA2+Ggj7tQsw4qjftx6BkslqO6FlVMQ28GzKpPbtGApW/ttuZ
	 Z9c9AFHf1bagRdT4ICN8HY8END0rOpz0Sj84F6dQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D64FDF80304;
	Wed, 19 Aug 2020 08:56:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5C2EDF802EB; Wed, 19 Aug 2020 08:56:50 +0200 (CEST)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 97A30F802DC
 for <alsa-devel@alsa-project.org>; Wed, 19 Aug 2020 08:56:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 97A30F802DC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="FfmYzkf9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=3H4NansDDN6m4kLuhIk/kp+Z4N3mSn8cpB0zE9ycnQw=; b=FfmYzkf9G6zwFUNNR629I5LzS3
 sycbpl6XBJNQxWdPFjivtYFvAIE2BLJ2qzBGSbrb4qsZMMfJP9/eHP8S4mQZ2+1Qp/sFoX35RiYzA
 HkdgOwz29iCkQAeMrmvVDYWraKQlEbIhijWnbLTMYghTv+7s9PA7sbl0esYUqgLYg5nrbhp5tTocC
 MkluoLqBfAzc4H5hViUIudDFe/lF5vGUx/dU2cLYx7jpBj8d8QnwTRzaMwN5nNPDKwz3V69GXE5aG
 zl6z181fqk4Jsg3atxLUAO9BbSDDhHAHpg0t5QmSPP39kziJBaZbtnr9s/ut+FwVdfRsInPqqIqLh
 2U/MY4HQ==;
Received: from [2001:4bb8:198:f3b2:86b6:2277:f429:37a1] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8I1A-0008Nq-7N; Wed, 19 Aug 2020 06:56:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Joonyoung Shim <jy0922.shim@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Ben Skeggs <bskeggs@redhat.com>,
 Pawel Osciak <pawel@osciak.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Matt Porter <mporter@kernel.crashing.org>, iommu@lists.linux-foundation.org
Subject: [PATCH 10/28] MIPS/jazzdma: decouple from dma-direct
Date: Wed, 19 Aug 2020 08:55:37 +0200
Message-Id: <20200819065555.1802761-11-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819065555.1802761-1-hch@lst.de>
References: <20200819065555.1802761-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: Tom Lendacky <thomas.lendacky@amd.com>, alsa-devel@alsa-project.org,
 linux-samsung-soc@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-doc@vger.kernel.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
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

The jazzdma ops implement support for a very basic IOMMU.  Thus we really
should not use the dma-direct code that takes physical address limits
into account.  This survived through the great MIPS DMA ops cleanup mostly
because I was lazy, but now it is time to fully split the implementations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/jazz/jazzdma.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/mips/jazz/jazzdma.c b/arch/mips/jazz/jazzdma.c
index fe40dbed04c1d6..d0b5a2ba2b1a8a 100644
--- a/arch/mips/jazz/jazzdma.c
+++ b/arch/mips/jazz/jazzdma.c
@@ -16,7 +16,6 @@
 #include <linux/memblock.h>
 #include <linux/spinlock.h>
 #include <linux/gfp.h>
-#include <linux/dma-direct.h>
 #include <linux/dma-noncoherent.h>
 #include <asm/mipsregs.h>
 #include <asm/jazz.h>
@@ -492,26 +491,38 @@ int vdma_get_enable(int channel)
 static void *jazz_dma_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
+	struct page *page;
 	void *ret;
 
-	ret = dma_direct_alloc_pages(dev, size, dma_handle, gfp, attrs);
-	if (!ret)
-		return NULL;
+	if (attrs & DMA_ATTR_NO_WARN)
+		gfp |= __GFP_NOWARN;
 
-	*dma_handle = vdma_alloc(virt_to_phys(ret), size);
-	if (*dma_handle == DMA_MAPPING_ERROR) {
-		dma_direct_free_pages(dev, size, ret, *dma_handle, attrs);
+	size = PAGE_ALIGN(size);
+	page = alloc_pages(gfp, get_order(size));
+	if (!page)
 		return NULL;
-	}
+	ret = page_address(page);
+	*dma_handle = vdma_alloc(virt_to_phys(ret), size);
+	if (*dma_handle == DMA_MAPPING_ERROR)
+		goto out_free_pages;
+
+	if (attrs & DMA_ATTR_NON_CONSISTENT)
+		return ret;
+	arch_dma_prep_coherent(page, size);
+	return (void *)(UNCAC_BASE + __pa(ret));
 
-	return ret;
+out_free_pages:
+	__free_pages(page, get_order(size));
+	return NULL;
 }
 
 static void jazz_dma_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_handle, unsigned long attrs)
 {
 	vdma_free(dma_handle);
-	dma_direct_free_pages(dev, size, vaddr, dma_handle, attrs);
+	if (!(attrs & DMA_ATTR_NON_CONSISTENT))
+		vaddr = __va(vaddr - UNCAC_BASE);
+	__free_pages(virt_to_page(vaddr), get_order(size));
 }
 
 static dma_addr_t jazz_dma_map_page(struct device *dev, struct page *page,
@@ -608,7 +619,6 @@ const struct dma_map_ops jazz_dma_ops = {
 	.sync_single_for_device	= jazz_dma_sync_single_for_device,
 	.sync_sg_for_cpu	= jazz_dma_sync_sg_for_cpu,
 	.sync_sg_for_device	= jazz_dma_sync_sg_for_device,
-	.dma_supported		= dma_direct_supported,
 	.cache_sync		= arch_dma_cache_sync,
 	.mmap			= dma_common_mmap,
 	.get_sgtable		= dma_common_get_sgtable,
-- 
2.28.0

