Return-Path: <SRS0=v/9x=ND=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E5DC4338F
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Aug 2021 11:40:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3E4160F91
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Aug 2021 11:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F3E4160F91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7A4151A93;
	Thu, 12 Aug 2021 13:39:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7A4151A93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628768411;
	bh=5OjQgrp++HR0IRPtk7x4XxHwD+0u27Den1yKlj4aggk=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TMVh5yvW2QT3jZ5A3GXqbVsOm39cQ74j8B3W55a+rmP6kykBrubPjVoO75y+uiPGs
	 ZHqVs2fpyXwouk7pTS1dwj7R7aevneVvGJXxF/Np/MxQGPO/lLpsptPxJFRUVcHMoZ
	 71J9jdyuyEAKmPAtUsnIo/fAqaMQkxIfWtBBbGD8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3223BF802E3;
	Thu, 12 Aug 2021 13:38:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EAA01F80245; Thu, 12 Aug 2021 13:38:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 87B31F80148
 for <alsa-devel@alsa-project.org>; Thu, 12 Aug 2021 13:38:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 87B31F80148
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="r3URR2hd"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="LfPURyHb"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 184EB1FF3D
 for <alsa-devel@alsa-project.org>; Thu, 12 Aug 2021 11:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1628768300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2stFaf3rA9JiwmWh3rIMSINZGi3/Xxaz7uzcLtuqtV0=;
 b=r3URR2hd8upeapB/6lOLMN5NCtFvWvEhKARcykHVbhblBVz7b6qKtltzJBmpt2Hmv1pWtM
 XDikf3Bnkv2neJ12siAyAqgACoCiislDiEl/YKQMc/NrUWoHEvCl88qkhFSIU9INm95oFF
 XjH2qaLxvbSTPbuM4plUqfXDUHJRBSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1628768300;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2stFaf3rA9JiwmWh3rIMSINZGi3/Xxaz7uzcLtuqtV0=;
 b=LfPURyHbx+PZNFHG4UDoCti33b0meB6+rhoUEBwxczeYLtFXr+iBebZQC1s3IO8B12MwMJ
 jUtYMxC+5JrwcFBw==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 06764A3EFB;
 Thu, 12 Aug 2021 11:38:20 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH RFC v2 4/4] ALSA: memalloc: Support for non-coherent page
 allocation
Date: Thu, 12 Aug 2021 13:38:18 +0200
Message-Id: <20210812113818.6479-5-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210812113818.6479-1-tiwai@suse.de>
References: <20210812113818.6479-1-tiwai@suse.de>
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

This patch adds the new non-coherent contiguous page allocation to the
standard memalloc helper.  Like the previous patch to add the
non-contig SG-buffer support, this non-coherent type is also direction
and requires the explicit sync, too.  Hence the driver using this type
of buffer would have to set SNDRV_PCM_INFO_EXPLICIT_SYNC flag to the
PCM hardware.info as well.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/memalloc.h |  1 +
 sound/core/memalloc.c    | 43 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/sound/memalloc.h b/include/sound/memalloc.h
index 30284985c8e9..0bea11c7a3b1 100644
--- a/include/sound/memalloc.h
+++ b/include/sound/memalloc.h
@@ -49,6 +49,7 @@ struct snd_dma_device {
 #endif
 #define SNDRV_DMA_TYPE_VMALLOC		7	/* vmalloc'ed buffer */
 #define SNDRV_DMA_TYPE_NONCONTIG	8	/* non-coherent SG buffer */
+#define SNDRV_DMA_TYPE_NONCOHERENT	9	/* non-coherent buffer */
 
 /*
  * info for buffer allocation
diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index ff8d5d59c9e7..5a7d2bffa7b9 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -552,6 +552,48 @@ static const struct snd_malloc_ops snd_dma_noncontig_ops = {
 	.get_chunk_size = snd_dma_vmalloc_get_chunk_size,
 };
 
+/*
+ * Non-coherent pages allocator
+ */
+static void *snd_dma_noncoherent_alloc(struct snd_dma_buffer *dmab, size_t size)
+{
+	return dma_alloc_noncoherent(dmab->dev.dev, size, &dmab->addr,
+				     dmab->dev.dir, DEFAULT_GFP);
+}
+
+static void snd_dma_noncoherent_free(struct snd_dma_buffer *dmab)
+{
+	dma_free_noncoherent(dmab->dev.dev, dmab->bytes, dmab->area,
+			     dmab->addr, dmab->dev.dir);
+}
+
+static int snd_dma_noncoherent_mmap(struct snd_dma_buffer *dmab,
+				    struct vm_area_struct *area)
+{
+	area->vm_page_prot = vm_get_page_prot(area->vm_flags);
+	return dma_mmap_pages(dmab->dev.dev, area,
+			      area->vm_end - area->vm_start,
+			      virt_to_page(dmab->area));
+}
+
+static void snd_dma_noncoherent_sync(struct snd_dma_buffer *dmab,
+				     enum snd_dma_sync_mode mode)
+{
+	if (mode == SNDRV_DMA_SYNC_CPU)
+		dma_sync_single_for_cpu(dmab->dev.dev, dmab->addr,
+					dmab->bytes, dmab->dev.dir);
+	else
+		dma_sync_single_for_device(dmab->dev.dev, dmab->addr,
+					   dmab->bytes, dmab->dev.dir);
+}
+
+static const struct snd_malloc_ops snd_dma_noncoherent_ops = {
+	.alloc = snd_dma_noncoherent_alloc,
+	.free = snd_dma_noncoherent_free,
+	.mmap = snd_dma_noncoherent_mmap,
+	.sync = snd_dma_noncoherent_sync,
+};
+
 #endif /* CONFIG_HAS_DMA */
 
 /*
@@ -564,6 +606,7 @@ static const struct snd_malloc_ops *dma_ops[] = {
 	[SNDRV_DMA_TYPE_DEV] = &snd_dma_dev_ops,
 	[SNDRV_DMA_TYPE_DEV_WC] = &snd_dma_wc_ops,
 	[SNDRV_DMA_TYPE_NONCONTIG] = &snd_dma_noncontig_ops,
+	[SNDRV_DMA_TYPE_NONCOHERENT] = &snd_dma_noncoherent_ops,
 #ifdef CONFIG_GENERIC_ALLOCATOR
 	[SNDRV_DMA_TYPE_DEV_IRAM] = &snd_dma_iram_ops,
 #endif /* CONFIG_GENERIC_ALLOCATOR */
-- 
2.26.2

