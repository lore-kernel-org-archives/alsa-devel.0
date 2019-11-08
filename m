Return-Path: <SRS0=0Fuw=ZA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5419C5DF60
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Nov 2019 16:57:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27D742178F
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Nov 2019 16:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mJQQ/tqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D742178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4AFB71665;
	Fri,  8 Nov 2019 17:56:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4AFB71665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573232246;
	bh=3vOKaoVWQfdewCBscsNbp9LHulJeMIssz/GXG4TCMi8=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mJQQ/tqhq8AZAgX1ppSWW7GQogKyj0aqYExzdaWIn41PZ2lADPpvAqtfMO62ia3wP
	 TshbK/IQM4LL5u22Zwn+ZLOviW/XWsP4ZP4VfVy8tcEp4lKiZaUT0O1JAcsRABSmXA
	 EuYCKUJX4nBw/6wMiHltNK4x2yKNzZBuUXGepSdU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C826FF80321;
	Fri,  8 Nov 2019 17:56:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 241ADF803D0; Fri,  8 Nov 2019 17:56:31 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B0E31F800F3
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2019 17:56:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0E31F800F3
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 84342AD44
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2019 16:56:27 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri,  8 Nov 2019 17:56:26 +0100
Message-Id: <20191108165626.5947-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Subject: [alsa-devel] [PATCH] ALSA: pcm: Yet another missing check of
	non-cached buffer type
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

For non-x86 architectures, SNDRV_DMA_TYPE_DEV_UC should be treated
equivalent with SNDRV_DMA_TYPE_DEV, where the default mmap handler
still checks only about SNDRV_DMA_TYPE_DEV.  Make the check more
proper.

Note that all existing users of *_UC buffer types are x86-only, so
this doesn't fix any bug, but just for consistency.

Fixes: 42e748a0b325 ("ALSA: memalloc: Add non-cached buffer type")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 998c63192ae4..0c27009dc3df 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3416,7 +3416,8 @@ int snd_pcm_lib_default_mmap(struct snd_pcm_substream *substream,
 #endif /* CONFIG_GENERIC_ALLOCATOR */
 #ifndef CONFIG_X86 /* for avoiding warnings arch/x86/mm/pat.c */
 	if (IS_ENABLED(CONFIG_HAS_DMA) && !substream->ops->page &&
-	    substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV)
+	    (substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV ||
+	     substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV_UC))
 		return dma_mmap_coherent(substream->dma_buffer.dev.dev,
 					 area,
 					 substream->runtime->dma_area,
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
