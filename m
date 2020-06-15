Return-Path: <SRS0=afjW=74=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF68C433E1
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:04:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2657420679
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="exPQqaNQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2657420679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B0A2A1665;
	Mon, 15 Jun 2020 18:03:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B0A2A1665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592237065;
	bh=0zuBWB+YJ2/CgXmPYAQvN+VS5/OdBlzp1askvRMxp8E=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=exPQqaNQJfIEtccCnvB6wZEDxSlXPzb0iSQfMPqGg5Z0/lqmIQByAfsavDrSvvoSR
	 gWWX3T8/ebvCpdKnf5A5/yt8gF59N84v960VrAfy8Dmp3NrPT09cCYkNF6aUhn7c3G
	 oY1I5KoZnLZCvx0Xfz89OOV+gvKOoYAiPYGjkzE0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D3AA8F802DD;
	Mon, 15 Jun 2020 18:01:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8B58CF802A1; Mon, 15 Jun 2020 18:01:00 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 64B26F801D9
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2020 18:00:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 64B26F801D9
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 365FDAD85
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2020 16:00:51 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/4] ALSA: pcm: Use dma_mmap_coherent() on x86, too
Date: Mon, 15 Jun 2020 18:00:42 +0200
Message-Id: <20200615160045.2703-2-tiwai@suse.de>
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

We avoided the explicit use of dma_mmap_coherent() on x86 because of a
spurious warning in x86 APT code in the past.  However, this blindly
assumes that the pages allocated via dma_alloc_coherent() on x86 are
the ones convertible via virt_to_page() (that is used in the default
mmap handler), and it's no longer true; with the indirect DMA ops,
this can be handled differently.  The only certain way for doing mmap
such pages is the dma_mmap_coherent(), and the warning seems already
gone in the recent code, so let's use it consistently.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 9630d2523948..1e51c849d3d4 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3713,7 +3713,6 @@ int snd_pcm_lib_default_mmap(struct snd_pcm_substream *substream,
 				area->vm_end - area->vm_start, area->vm_page_prot);
 	}
 #endif /* CONFIG_GENERIC_ALLOCATOR */
-#ifndef CONFIG_X86 /* for avoiding warnings arch/x86/mm/pat.c */
 	if (IS_ENABLED(CONFIG_HAS_DMA) && !substream->ops->page &&
 	    (substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV ||
 	     substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV_UC))
@@ -3722,7 +3721,6 @@ int snd_pcm_lib_default_mmap(struct snd_pcm_substream *substream,
 					 substream->runtime->dma_area,
 					 substream->runtime->dma_addr,
 					 substream->runtime->dma_bytes);
-#endif /* CONFIG_X86 */
 	/* mmap with fault handler */
 	area->vm_ops = &snd_pcm_vm_ops_data_fault;
 	return 0;
-- 
2.16.4

