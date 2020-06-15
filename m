Return-Path: <SRS0=afjW=74=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AEBC433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:02:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E82320679
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aV62COA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E82320679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 12D0D1655;
	Mon, 15 Jun 2020 18:01:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 12D0D1655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592236960;
	bh=LI5e9jfSKxkkOHBpDMhC8aRwfh20aL94/sP3PZXgPUY=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aV62COA44KuhKDjjPThHqZPStdgYXlyli2DUP9t7sCj2tnyTaNGxp0jNkZwLwndPo
	 qT0mlUfZN5jys00RVjsUAQ0Pz8kOh0rPLyMFsYW4kGtwyBSzvR1Gwi+e0wiEfdEyrL
	 f1BGAS2Wmaq75VhEpZwGRGHBMqki9LGQq6LENrdI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 98A49F80171;
	Mon, 15 Jun 2020 18:00:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A2C9DF801ED; Mon, 15 Jun 2020 18:00:54 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5B7E1F800EF
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2020 18:00:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B7E1F800EF
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 39B66ADF2
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2020 16:00:51 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/4] ALSA: memalloc: Initialize all fields of snd_dma_buffer
 properly
Date: Mon, 15 Jun 2020 18:00:43 +0200
Message-Id: <20200615160045.2703-3-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200615160045.2703-1-tiwai@suse.de>
References: <20200615160045.2703-1-tiwai@suse.de>
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

Some fields in snd_dma_buffer aren't touched in snd_dma_alloc_pages()
and might be left uninitialized.  Let's clear all fields properly, so
that we can use a NULL check (e.g. dmab->private_data) as conditional
in a later patch.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/memalloc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index bea46ed157a6..d8f28d030985 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -135,16 +135,17 @@ int snd_dma_alloc_pages(int type, struct device *device, size_t size,
 	dmab->dev.type = type;
 	dmab->dev.dev = device;
 	dmab->bytes = 0;
+	dmab->area = NULL;
+	dmab->addr = 0;
+	dmab->private_data = NULL;
 	switch (type) {
 	case SNDRV_DMA_TYPE_CONTINUOUS:
 		gfp = snd_mem_get_gfp_flags(device, GFP_KERNEL);
 		dmab->area = alloc_pages_exact(size, gfp);
-		dmab->addr = 0;
 		break;
 	case SNDRV_DMA_TYPE_VMALLOC:
 		gfp = snd_mem_get_gfp_flags(device, GFP_KERNEL | __GFP_HIGHMEM);
 		dmab->area = __vmalloc(size, gfp);
-		dmab->addr = 0;
 		break;
 #ifdef CONFIG_HAS_DMA
 #ifdef CONFIG_GENERIC_ALLOCATOR
@@ -171,8 +172,6 @@ int snd_dma_alloc_pages(int type, struct device *device, size_t size,
 #endif
 	default:
 		pr_err("snd-malloc: invalid device type %d\n", type);
-		dmab->area = NULL;
-		dmab->addr = 0;
 		return -ENXIO;
 	}
 	if (! dmab->area)
-- 
2.16.4

