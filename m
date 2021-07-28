Return-Path: <SRS0=/xSo=MU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0156C4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jul 2021 11:25:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FAB2600D1
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jul 2021 11:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3FAB2600D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A4D9E17C8;
	Wed, 28 Jul 2021 13:24:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A4D9E17C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627471546;
	bh=L1esxKvnRj5DoGuPzGs+ditowOSHUk8EvpV0iBVvIe0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r3Z7qwB5XT5gRAzTv+gxT5/JlGaUVGIuq5rK6TXjogxo9mXfrCCWUeyGv5TTskNup
	 YsPOMkGNLceq4BS1haKndam7NL7Ta1jkXbe6ikk61pTQPCI/YqvUjmTH33EEVf85Fu
	 B+8CKWWEQrfcQSKpIRJz7uToIpITUwZEvu73pstw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5F5D9F804CF;
	Wed, 28 Jul 2021 13:24:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 602FDF804DF; Wed, 28 Jul 2021 13:24:06 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D3099F80127
 for <alsa-devel@alsa-project.org>; Wed, 28 Jul 2021 13:23:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D3099F80127
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="MjK+r6LH"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="cwmQsrL0"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 9E02122318;
 Wed, 28 Jul 2021 11:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1627471434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kLNE5iXLSb9YoiScs/jMmgMOKs5H0No9v7cRRFOmhOY=;
 b=MjK+r6LH4NfjfG7sjSH9mjPFrdW5Avs2gkI1pEExkgzZoB7oxkDmeIuQQLlEYoykjVy8/8
 E07qzOb9Rth6Cp6O2kDzH7QFFAo1e/vsCULQfw7mojBA28Rn5toAw9jXwmX0ETNhNzXEUD
 t9Ov/pLllVGATzsyAwWE7n8k2E/kRZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1627471434;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kLNE5iXLSb9YoiScs/jMmgMOKs5H0No9v7cRRFOmhOY=;
 b=cwmQsrL0nt80h7apeLfKPvCuMHwWADQrVjZFQLYMHpRIKcSbJiED3VrEJYNySM/NO5zK4T
 tG8bHiP/zLJxGBCA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 8EE4DA3B81;
 Wed, 28 Jul 2021 11:23:54 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 4/5] ASoC: uniphier: Fix reference to PCM buffer address
Date: Wed, 28 Jul 2021 13:23:52 +0200
Message-Id: <20210728112353.6675-5-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210728112353.6675-1-tiwai@suse.de>
References: <20210728112353.6675-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
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

Along with the transition to the managed PCM buffers, the driver now
accepts the dynamically allocated buffer, while it still kept the
reference to the old preallocated buffer address.  This patch corrects
to the right reference via runtime->dma_addr.

(Although this might have been already buggy before the cleanup with
the managed buffer, let's put Fixes tag to point that; it's a corner
case, after all.)

Fixes: d55894bc2763 ("ASoC: uniphier: Use managed buffer allocation")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/uniphier/aio-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/uniphier/aio-dma.c b/sound/soc/uniphier/aio-dma.c
index 3c1628a3a1ac..3d9736e7381f 100644
--- a/sound/soc/uniphier/aio-dma.c
+++ b/sound/soc/uniphier/aio-dma.c
@@ -198,7 +198,7 @@ static int uniphier_aiodma_mmap(struct snd_soc_component *component,
 	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
 
 	return remap_pfn_range(vma, vma->vm_start,
-			       substream->dma_buffer.addr >> PAGE_SHIFT,
+			       substream->runtime->dma_addr >> PAGE_SHIFT,
 			       vma->vm_end - vma->vm_start, vma->vm_page_prot);
 }
 
-- 
2.26.2

