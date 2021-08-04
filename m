Return-Path: <SRS0=vE6Q=M3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAC0C4338F
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Aug 2021 06:35:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98AFB60F94
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Aug 2021 06:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 98AFB60F94
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 522C21701;
	Wed,  4 Aug 2021 08:34:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 522C21701
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628058917;
	bh=ZSbv02WKdIHQXD4UeZVhZUHqd37GfH1SZZcNB5RJ8Og=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=R25CwopJTxNRchEFoFtK3YmTHExJbNgMOZNZtoUBT2+CSpHjirMnBKBXJu+iJLTvF
	 0faRt+WO58Pqj+LxWvujDWaofEySjkWeFJ5DRgr8eBGtUMcDuhMIHSHLoCh09HZAMz
	 VkaOISsBoC2pPEb8SPvfHd41EJ/qGYGTYJULlNmg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AFCB9F8010A;
	Wed,  4 Aug 2021 08:34:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F3DB6F8025F; Wed,  4 Aug 2021 08:34:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9FE07F8010A
 for <alsa-devel@alsa-project.org>; Wed,  4 Aug 2021 08:34:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9FE07F8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="Uswu9fNU"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="odNXeAh5"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id ABA4020023
 for <alsa-devel@alsa-project.org>; Wed,  4 Aug 2021 06:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1628058857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5iGgOKDdB/jPZetrykY8pbwVZMwmZNgHHJ+D3Onh4fk=;
 b=Uswu9fNUDOMRWVRCvNtUIxrib7CbzUMXSIegr1kExHd+ejO4p4pLRfYm+pUeoKLhF8e1Ud
 E0XqfiMDUjzxsO01PzSMhcbB74CEqqPdXggtnqEoFmCUNvdYiZgMeu/z6f5MKfW9zU1w7+
 MHcc6PbpvlSTUW2TJCGMxNXIwVX5od8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1628058857;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5iGgOKDdB/jPZetrykY8pbwVZMwmZNgHHJ+D3Onh4fk=;
 b=odNXeAh5+kynhfmHg5PQt9egRYvWhS1PKo2Cm/TMI+CZycgS45EnBoj3Jlh3giAPiYs4rz
 ZXEKsuWateR8TnAw==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id A65A2A3B84;
 Wed,  4 Aug 2021 06:34:17 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: memalloc: Store snd_dma_buffer.addr for continuous
 pages, too
Date: Wed,  4 Aug 2021 08:34:15 +0200
Message-Id: <20210804063415.3076-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
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

In the recent fix commit eda80d7c9c4d ("ALSA: memalloc: Fix regression
with SNDRV_DMA_TYPE_CONTINUOUS"), we replaced the pfn argument of the
remap_page_pfn() call from the uninitialized dmab->addr.  It was the
right fix, but it'd be more generic if we actually initialize
dmab->area for SNDRV_DMA_TYPE_CONTINOUS, too.  e.g. the field is used
in the common snd_sgbuf_get_addr(), too.

This patch adds the initialization of addr field and does revert of
the previous change to refer to it again in the mmap call.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/memalloc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index 084b2600a423..21f57f1e81a4 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -242,8 +242,11 @@ EXPORT_SYMBOL(snd_sgbuf_get_chunk_size);
 static void *snd_dma_continuous_alloc(struct snd_dma_buffer *dmab, size_t size)
 {
 	gfp_t gfp = snd_mem_get_gfp_flags(dmab, GFP_KERNEL);
+	void *p = alloc_pages_exact(size, gfp);
 
-	return alloc_pages_exact(size, gfp);
+	if (p)
+		dmab->addr = page_to_phys(virt_to_page(dmab->area));
+	return p;
 }
 
 static void snd_dma_continuous_free(struct snd_dma_buffer *dmab)
@@ -255,7 +258,7 @@ static int snd_dma_continuous_mmap(struct snd_dma_buffer *dmab,
 				   struct vm_area_struct *area)
 {
 	return remap_pfn_range(area, area->vm_start,
-			       page_to_pfn(virt_to_page(dmab->area)),
+			       dmab->addr >> PAGE_SHIFT,
 			       area->vm_end - area->vm_start,
 			       area->vm_page_prot);
 }
-- 
2.26.2

