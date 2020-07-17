Return-Path: <SRS0=vkql=A4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AEDC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2020 06:42:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E93D52071A
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2020 06:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OhKKr+SV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93D52071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B0AF15DC;
	Fri, 17 Jul 2020 08:41:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B0AF15DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594968157;
	bh=W85Q8NUEFxnWAccfvpFBfEsI2Hv7PZ3NM1yUoC9zU7U=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OhKKr+SV2VxXWd+xArH5vY4LW0wTqztiOP73UkLRvrprT5Ll2r0vuSTpnRisK/67c
	 43XXsDeEr8n9ZgPG/+aKSdDNW0RYYYd6ueXOVHw4kigXnYtTItEX/169+XQnIGG6oN
	 b6pjFWHwGi6bJ/xyetnKsI8N7KOpZAXNa50Nj7Cc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 723C1F801D8;
	Fri, 17 Jul 2020 08:41:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 48685F80217; Fri, 17 Jul 2020 08:41:44 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5D751F8014E
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2020 08:41:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D751F8014E
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 8CB46AC20
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2020 06:41:36 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] Revert "ALSA: pcm: Use SG-buffer only when direct DMA is
 available"
Date: Fri, 17 Jul 2020 08:41:30 +0200
Message-Id: <20200717064130.22957-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
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

This reverts commit 3ad796cbc36a ("ALSA: pcm: Use SG-buffer only when
direct DMA is available") also the modification commit 467fd0e82b62
("ALSA: pcm: Fix build error on m68k and others").

Poking the DMA internal helper is a layer violation, so we should
avoid that.  Meanwhile the actual bug has been addressed by the
Kconfig fix in commit dbed452a078d ("dma-pool: decouple DMA_REMAP from
DMA_COHERENT_POOL"), so we can live without this hack.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_memory.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/sound/core/pcm_memory.c b/sound/core/pcm_memory.c
index 795af1b88051..1bf6a3d9e0c2 100644
--- a/sound/core/pcm_memory.c
+++ b/sound/core/pcm_memory.c
@@ -11,7 +11,6 @@
 #include <linux/moduleparam.h>
 #include <linux/vmalloc.h>
 #include <linux/export.h>
-#include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/info.h>
@@ -41,19 +40,6 @@ static int do_alloc_pages(struct snd_card *card, int type, struct device *dev,
 	    card->total_pcm_alloc_bytes + size > max_alloc_per_card)
 		return -ENOMEM;
 
-
-#ifdef CONFIG_SND_DMA_SGBUF
-	if ((type == SNDRV_DMA_TYPE_DEV_SG || type == SNDRV_DMA_TYPE_DEV_UC_SG) &&
-	    !dma_is_direct(get_dma_ops(dev))) {
-		/* mutate to continuous page allocation */
-		dev_dbg(dev, "Use continuous page allocator\n");
-		if (type == SNDRV_DMA_TYPE_DEV_SG)
-			type = SNDRV_DMA_TYPE_DEV;
-		else
-			type = SNDRV_DMA_TYPE_DEV_UC;
-	}
-#endif /* CONFIG_SND_DMA_SGBUF */
-
 	err = snd_dma_alloc_pages(type, dev, size, dmab);
 	if (!err) {
 		mutex_lock(&card->memory_mutex);
-- 
2.16.4

