Return-Path: <SRS0=8Lk6=LD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017DFC48BCD
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Jun 2021 16:27:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DBB3613C0
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Jun 2021 16:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DBB3613C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8BFE916C7;
	Wed,  9 Jun 2021 18:26:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8BFE916C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623256069;
	bh=wIcbUcrhr8DjGd+LTtToF7B/qEBTL5ZJ+ct7uJ1Dj9Y=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zwi7iHNM3paFrU04C9F6jUsbtK+ZssfBeitXE5lG8HmUjb/AwTxMv5HZlilIqZE4u
	 cHFBSO+dMRHUFC7yA3HcyB8DhgDK4MnBW8MBF0zy9vTbwv/I2hPuZx2hEPCB1ZACXv
	 wl3vSBJAwnUseVC6T2BjWOE12dLZCMt9OaZ6zKi4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 09D9BF8032B;
	Wed,  9 Jun 2021 18:26:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7777DF802DF; Wed,  9 Jun 2021 18:26:06 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D92C0F800F4
 for <alsa-devel@alsa-project.org>; Wed,  9 Jun 2021 18:25:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D92C0F800F4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="yPozEAiC"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="np6Q10IR"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 665AE219BB
 for <alsa-devel@alsa-project.org>; Wed,  9 Jun 2021 16:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623255954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QG36/Dj1I+IoRxpO9YEYCuHQtClvDu+QtO22T3wPDD8=;
 b=yPozEAiCW5kUT/Es9jJNhHpD+q/0jMMuBriyqKR04wMD4njIJKEjhPvzYMGuEZA9LrPwPv
 vAlgrwPo6zwhYf302EOBq4oXAqbIIy3guxIzwl78OWtpD+at8CvXNu7bQ7uyt93EG1xbEM
 9rrGG8KmxHLE3BeM26k9UCmWOf4DheA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623255954;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QG36/Dj1I+IoRxpO9YEYCuHQtClvDu+QtO22T3wPDD8=;
 b=np6Q10IR3EeGLVapZnUnyAzYVKR/YHf+NS4aA9xDMXWiKdDluWpwIPfEWBNpXXtm/n6Iyr
 5M2Q0cYqfjJtfPAw==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 61C63A3B89;
 Wed,  9 Jun 2021 16:25:54 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 5/5] ALSA: core: Add continuous and vmalloc mmap ops
Date: Wed,  9 Jun 2021 18:25:51 +0200
Message-Id: <20210609162551.7842-6-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210609162551.7842-1-tiwai@suse.de>
References: <20210609162551.7842-1-tiwai@suse.de>
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

The mmap of continuous pages and vmalloc'ed pages are relatively
easily done in a shot with the existing helper functions.
Implement the mmap ops for those types, so that the mmap works without
relying on the page fault handling.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/memalloc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index bdcb9230acf8..83b79edfa52d 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -211,9 +211,19 @@ static void snd_dma_continuous_free(struct snd_dma_buffer *dmab)
 	free_pages_exact(dmab->area, dmab->bytes);
 }
 
+static int snd_dma_continuous_mmap(struct snd_dma_buffer *dmab,
+				   struct vm_area_struct *area)
+{
+	return remap_pfn_range(area, area->vm_start,
+			       dmab->addr >> PAGE_SHIFT,
+			       area->vm_end - area->vm_start,
+			       area->vm_page_prot);
+}
+
 static const struct snd_malloc_ops snd_dma_continuous_ops = {
 	.alloc = snd_dma_continuous_alloc,
 	.free = snd_dma_continuous_free,
+	.mmap = snd_dma_continuous_mmap,
 };
 
 /*
@@ -232,6 +242,12 @@ static void snd_dma_vmalloc_free(struct snd_dma_buffer *dmab)
 	vfree(dmab->area);
 }
 
+static int snd_dma_vmalloc_mmap(struct snd_dma_buffer *dmab,
+				struct vm_area_struct *area)
+{
+	return remap_vmalloc_range(area, dmab->area, 0);
+}
+
 static dma_addr_t snd_dma_vmalloc_get_addr(struct snd_dma_buffer *dmab,
 					   size_t offset)
 {
@@ -259,6 +275,7 @@ snd_dma_vmalloc_get_chunk_size(struct snd_dma_buffer *dmab,
 static const struct snd_malloc_ops snd_dma_vmalloc_ops = {
 	.alloc = snd_dma_vmalloc_alloc,
 	.free = snd_dma_vmalloc_free,
+	.mmap = snd_dma_vmalloc_mmap,
 	.get_addr = snd_dma_vmalloc_get_addr,
 	.get_page = snd_dma_vmalloc_get_page,
 	.get_chunk_size = snd_dma_vmalloc_get_chunk_size,
-- 
2.26.2

