Return-Path: <SRS0=FUiO=CY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96966C433E2
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:30:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB1A32074B
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iaguxZjw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="olAOSynY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1A32074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 55F4C1680;
	Tue, 15 Sep 2020 18:29:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 55F4C1680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600187405;
	bh=1eArOufbe3qIYvt5/xMaki0hdGLLCbd+Yp3z9uR4/PE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iaguxZjw0jJwSIQFc90rpGnAGPPpvNiJL99a9pIXjuh1V+E4azk7ho9V45BRO82IH
	 DsVOxc12d6moYssHsU1v7UstdeLf3TkQhN9IbnDpsqPLHS/rWVHj3hur/Bd1gYpnOm
	 IYC4REm8SzHHWVafnG+Gm8dHeq6t7J0abYybSKEI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E8EFAF800F1;
	Tue, 15 Sep 2020 18:29:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9482AF8025E; Tue, 15 Sep 2020 18:29:13 +0200 (CEST)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A16F4F800F1
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2020 18:29:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A16F4F800F1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="olAOSynY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=1/bEcy21h9dr4Lop81Jp+A+3tsDr/+YN8bI8sHR6ers=; b=olAOSynYlsHEGJhf6TUlmrckuE
 /r0LGBccgU4hRqqI8td0cmd/yN43a1NVzzTHUUoIBhJriadMr+CZIn81GdOqHwGRRCnoGg0Lpn2As
 D87gTkZYobl3hk2YFKI39vdQ/6KaZsMZZHwt9r8yylGEHBzR9RNXvP3ZAPY1xXRi6Vcg2UuFPe53e
 0Nr6Ng4Fo3q7nEb85kHX3sqaqpJfeXNhK6gIhRiDcpSKQqPiwby8Brgzeb7Q8bHIHFeQFHcfeCFaO
 30AdYUq1MYULU/w9BF2KXnq/TBqPJ/HePxZDgzUFxWt8R3Pzl7zV2oGhwr/DJ8H/v8eE7+ssTVi/j
 0mVYXghw==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIDon-0005qq-4D; Tue, 15 Sep 2020 16:28:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Joonyoung Shim <jy0922.shim@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, Ben Skeggs <bskeggs@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Tomasz Figa <tfiga@chromium.org>,
 Matt Porter <mporter@kernel.crashing.org>, iommu@lists.linux-foundation.org
Subject: [PATCH 16/18] dma-mapping: add new {alloc,
 free}_noncoherent dma_map_ops methods
Date: Tue, 15 Sep 2020 17:51:20 +0200
Message-Id: <20200915155122.1768241-17-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915155122.1768241-1-hch@lst.de>
References: <20200915155122.1768241-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-doc@vger.kernel.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org,
 Stefan Richter <stefanr@s5r6.in-berlin.de>, netdev@vger.kernel.org,
 linux1394-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
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

This will allow IOMMU drivers to allocate non-contigous memory and
return a vmapped virtual address.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-mapping.h |  5 +++++
 kernel/dma/mapping.c        | 33 +++++++++++++++++++++++++++------
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index bf592cf0db4acb..b4b5d75260d6dc 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -80,6 +80,11 @@ struct dma_map_ops {
 			gfp_t gfp);
 	void (*free_pages)(struct device *dev, size_t size, struct page *vaddr,
 			dma_addr_t dma_handle, enum dma_data_direction dir);
+	void* (*alloc_noncoherent)(struct device *dev, size_t size,
+			dma_addr_t *dma_handle, enum dma_data_direction dir,
+			gfp_t gfp);
+	void (*free_noncoherent)(struct device *dev, size_t size, void *vaddr,
+			dma_addr_t dma_handle, enum dma_data_direction dir);
 	int (*mmap)(struct device *, struct vm_area_struct *,
 			  void *, dma_addr_t, size_t,
 			  unsigned long attrs);
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 6f86c925b8251d..8614d7d2ee59a9 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -502,19 +502,40 @@ EXPORT_SYMBOL_GPL(dma_free_pages);
 void *dma_alloc_noncoherent(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
 {
-	struct page *page;
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+	void *vaddr;
 
-	page = dma_alloc_pages(dev, size, dma_handle, dir, gfp);
-	if (!page)
-		return NULL;
-	return page_address(page);
+	if (!ops || !ops->alloc_noncoherent) {
+		struct page *page;
+
+		page = dma_alloc_pages(dev, size, dma_handle, dir, gfp);
+		if (!page)
+			return NULL;
+		return page_address(page);
+	}
+
+	size = PAGE_ALIGN(size);
+	vaddr = ops->alloc_noncoherent(dev, size, dma_handle, dir, gfp);
+	if (vaddr)
+		debug_dma_map_page(dev, virt_to_page(vaddr), 0, size, dir,
+				   *dma_handle);
+	return vaddr;
 }
 EXPORT_SYMBOL_GPL(dma_alloc_noncoherent);
 
 void dma_free_noncoherent(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_handle, enum dma_data_direction dir)
 {
-	dma_free_pages(dev, size, virt_to_page(vaddr), dma_handle, dir);
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	if (!ops || !ops->free_noncoherent) {
+		dma_free_pages(dev, size, virt_to_page(vaddr), dma_handle, dir);
+		return;
+	}
+
+	size = PAGE_ALIGN(size);
+	debug_dma_unmap_page(dev, dma_handle, size, dir);
+	ops->free_noncoherent(dev, size, vaddr, dma_handle, dir);
 }
 EXPORT_SYMBOL_GPL(dma_free_noncoherent);
 
-- 
2.28.0

