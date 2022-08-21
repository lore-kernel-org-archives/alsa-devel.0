Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57612C00140
	for <alsa-devel@archiver.kernel.org>; Sun, 21 Aug 2022 08:23:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 77A9F950;
	Sun, 21 Aug 2022 10:22:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 77A9F950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661070227;
	bh=xxCLLLFTOG8uj8K1aQQ8GIA0gLzjhS276w0YlVg/G8c=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jzXKOfDW/fIlEGRdojc2s1e1l+3tgsyOMw9J/WqK06TjYuwbDln1kz0qIVBHAZqsP
	 Q35BowgLQZj5V5AOyj1mqDV+9PRXktJ+JOoL7HK2Vds/xfCg5MTtPCqsbvMEgNWQtD
	 eAhtqrQcFg6O5GNrwBkwJOtNrFxCIk5IMAZ+8E2U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 18EA5F80236;
	Sun, 21 Aug 2022 10:22:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 54497F804AC; Sun, 21 Aug 2022 10:22:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 04219F80128
 for <alsa-devel@alsa-project.org>; Sun, 21 Aug 2022 10:22:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04219F80128
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="njKzEBzw"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="ifo++N3H"
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 52F1D346DF;
 Sun, 21 Aug 2022 08:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1661070163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JRBczgZkS8FDM1aj2Qbhx4S35Aoy3Q/DbJn4/7rj8l0=;
 b=njKzEBzw2aHpHCucJiUyL9BgyZQbVU3memG38wwdTVDj9Ax+XbdLMRCCW8vI/65pSZpPk7
 zq2AyHL1w6ittj+XAxGioIdoNFNYoGqo32CKyn1NgPPs0UHJqrM+V/QUHtdOT4tX4CfdCr
 YA0u9mBBonLIgps83wyHFECbAPvFSaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1661070163;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JRBczgZkS8FDM1aj2Qbhx4S35Aoy3Q/DbJn4/7rj8l0=;
 b=ifo++N3HrCgeyzF+nW0peiUUZ5OZddhfiTLcNBlIsi6+VcsXrBSQz3NUGQaRbhBPEudkE0
 7sgDooJe5dPC/rBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 32C62139C7;
 Sun, 21 Aug 2022 08:22:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1N90C1PrAWMIRgAAMHmgww
 (envelope-from <tiwai@suse.de>); Sun, 21 Aug 2022 08:22:43 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: memalloc: Revive x86-specific WC page allocations again
Date: Sun, 21 Aug 2022 10:22:41 +0200
Message-Id: <20220821082241.23722-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

We dropped the x86-specific hack for WC-page allocations with a hope
that the standard dma_alloc_wc() works nowadays.  Alas, it doesn't,
and we need to take back some workaround again, but in a different
form, as the previous one was broken for some platforms.

This patch re-introduces the x86-specific WC-page allocations, but it
uses rather the manual page allocations instead of
dma_alloc_coherent().  The use of dma_alloc_coherent() was also a
potential problem in the recent addition of the fallback allocation
for noncontig pages, and this patch eliminates both at once.

Fixes: 9882d63bea14 ("ALSA: memalloc: Drop x86-specific hack for WC allocations")
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=216363
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/memalloc.c | 87 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 71 insertions(+), 16 deletions(-)

diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index d3885cb02270..90d74855d988 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -20,6 +20,13 @@
 
 static const struct snd_malloc_ops *snd_dma_get_ops(struct snd_dma_buffer *dmab);
 
+#ifdef CONFIG_SND_DMA_SGBUF
+static void *do_alloc_fallback_pages(struct device *dev, size_t size,
+				     dma_addr_t *addr, bool wc);
+static void do_free_fallback_pages(void *p, size_t size, bool wc);
+static void *snd_dma_sg_fallback_alloc(struct snd_dma_buffer *dmab, size_t size);
+#endif
+
 /* a cast to gfp flag from the dev pointer; for CONTINUOUS and VMALLOC types */
 static inline gfp_t snd_mem_get_gfp_flags(const struct snd_dma_buffer *dmab,
 					  gfp_t default_gfp)
@@ -277,16 +284,21 @@ EXPORT_SYMBOL(snd_sgbuf_get_chunk_size);
 /*
  * Continuous pages allocator
  */
-static void *snd_dma_continuous_alloc(struct snd_dma_buffer *dmab, size_t size)
+static void *do_alloc_pages(size_t size, dma_addr_t *addr, unsigned long gfp)
 {
-	gfp_t gfp = snd_mem_get_gfp_flags(dmab, GFP_KERNEL);
 	void *p = alloc_pages_exact(size, gfp);
 
 	if (p)
-		dmab->addr = page_to_phys(virt_to_page(p));
+		*addr = page_to_phys(virt_to_page(p));
 	return p;
 }
 
+static void *snd_dma_continuous_alloc(struct snd_dma_buffer *dmab, size_t size)
+{
+	return do_alloc_pages(size, &dmab->addr,
+			      snd_mem_get_gfp_flags(dmab, GFP_KERNEL));
+}
+
 static void snd_dma_continuous_free(struct snd_dma_buffer *dmab)
 {
 	free_pages_exact(dmab->area, dmab->bytes);
@@ -463,6 +475,25 @@ static const struct snd_malloc_ops snd_dma_dev_ops = {
 /*
  * Write-combined pages
  */
+/* x86-specific allocations */
+#ifdef CONFIG_SND_DMA_SGBUF
+static void *snd_dma_wc_alloc(struct snd_dma_buffer *dmab, size_t size)
+{
+	return do_alloc_fallback_pages(dmab->dev.dev, size, &dmab->addr, true);
+}
+
+static void snd_dma_wc_free(struct snd_dma_buffer *dmab)
+{
+	do_free_fallback_pages(dmab->area, dmab->bytes, true);
+}
+
+static int snd_dma_wc_mmap(struct snd_dma_buffer *dmab,
+			   struct vm_area_struct *area)
+{
+	area->vm_page_prot = pgprot_writecombine(area->vm_page_prot);
+	return snd_dma_continuous_mmap(dmab, area);
+}
+#else
 static void *snd_dma_wc_alloc(struct snd_dma_buffer *dmab, size_t size)
 {
 	return dma_alloc_wc(dmab->dev.dev, size, &dmab->addr, DEFAULT_GFP);
@@ -479,6 +510,7 @@ static int snd_dma_wc_mmap(struct snd_dma_buffer *dmab,
 	return dma_mmap_wc(dmab->dev.dev, area,
 			   dmab->area, dmab->addr, dmab->bytes);
 }
+#endif /* CONFIG_SND_DMA_SGBUF */
 
 static const struct snd_malloc_ops snd_dma_wc_ops = {
 	.alloc = snd_dma_wc_alloc,
@@ -486,10 +518,6 @@ static const struct snd_malloc_ops snd_dma_wc_ops = {
 	.mmap = snd_dma_wc_mmap,
 };
 
-#ifdef CONFIG_SND_DMA_SGBUF
-static void *snd_dma_sg_fallback_alloc(struct snd_dma_buffer *dmab, size_t size);
-#endif
-
 /*
  * Non-contiguous pages allocator
  */
@@ -669,6 +697,37 @@ static const struct snd_malloc_ops snd_dma_sg_wc_ops = {
 	.get_chunk_size = snd_dma_noncontig_get_chunk_size,
 };
 
+/* manual page allocations with wc setup */
+static void *do_alloc_fallback_pages(struct device *dev, size_t size,
+				     dma_addr_t *addr, bool wc)
+{
+	void *p;
+	unsigned long gfp = DEFAULT_GFP & ~__GFP_COMP;
+
+ again:
+	p = do_alloc_pages(size, addr, gfp);
+	if (!p || (*addr + size - 1) & ~dev->coherent_dma_mask) {
+		if (IS_ENABLED(CONFIG_ZONE_DMA32) && !(gfp & GFP_DMA32)) {
+			gfp |= GFP_DMA32;
+			goto again;
+		}
+		if (IS_ENABLED(CONFIG_ZONE_DMA) && !(gfp & GFP_DMA)) {
+			gfp = (gfp & ~GFP_DMA32) | GFP_DMA;
+			goto again;
+		}
+	}
+	if (p && wc)
+		set_memory_wc((unsigned long)(p), size >> PAGE_SHIFT);
+	return p;
+}
+
+static void do_free_fallback_pages(void *p, size_t size, bool wc)
+{
+	if (wc)
+		set_memory_wb((unsigned long)(p), size >> PAGE_SHIFT);
+	free_pages_exact(p, size);
+}
+
 /* Fallback SG-buffer allocations for x86 */
 struct snd_dma_sg_fallback {
 	size_t count;
@@ -679,14 +738,11 @@ struct snd_dma_sg_fallback {
 static void __snd_dma_sg_fallback_free(struct snd_dma_buffer *dmab,
 				       struct snd_dma_sg_fallback *sgbuf)
 {
+	bool wc = dmab->dev.type == SNDRV_DMA_TYPE_DEV_WC_SG_FALLBACK;
 	size_t i;
 
-	if (sgbuf->count && dmab->dev.type == SNDRV_DMA_TYPE_DEV_WC_SG_FALLBACK)
-		set_pages_array_wb(sgbuf->pages, sgbuf->count);
 	for (i = 0; i < sgbuf->count && sgbuf->pages[i]; i++)
-		dma_free_coherent(dmab->dev.dev, PAGE_SIZE,
-				  page_address(sgbuf->pages[i]),
-				  sgbuf->addrs[i]);
+		do_free_fallback_pages(page_address(sgbuf->pages[i]), PAGE_SIZE, wc);
 	kvfree(sgbuf->pages);
 	kvfree(sgbuf->addrs);
 	kfree(sgbuf);
@@ -698,6 +754,7 @@ static void *snd_dma_sg_fallback_alloc(struct snd_dma_buffer *dmab, size_t size)
 	struct page **pages;
 	size_t i, count;
 	void *p;
+	bool wc = dmab->dev.type == SNDRV_DMA_TYPE_DEV_WC_SG_FALLBACK;
 
 	sgbuf = kzalloc(sizeof(*sgbuf), GFP_KERNEL);
 	if (!sgbuf)
@@ -712,15 +769,13 @@ static void *snd_dma_sg_fallback_alloc(struct snd_dma_buffer *dmab, size_t size)
 		goto error;
 
 	for (i = 0; i < count; sgbuf->count++, i++) {
-		p = dma_alloc_coherent(dmab->dev.dev, PAGE_SIZE,
-				       &sgbuf->addrs[i], DEFAULT_GFP);
+		p = do_alloc_fallback_pages(dmab->dev.dev, PAGE_SIZE,
+					    &sgbuf->addrs[i], wc);
 		if (!p)
 			goto error;
 		sgbuf->pages[i] = virt_to_page(p);
 	}
 
-	if (dmab->dev.type == SNDRV_DMA_TYPE_DEV_WC_SG_FALLBACK)
-		set_pages_array_wc(pages, count);
 	p = vmap(pages, count, VM_MAP, PAGE_KERNEL);
 	if (!p)
 		goto error;
-- 
2.35.3

