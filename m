Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6CEC433DF
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 11:13:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B03420702
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 11:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vqERTLFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B03420702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C2EC0820;
	Tue,  7 Jul 2020 13:12:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C2EC0820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594120408;
	bh=wOnVbaPwYdvO4ll1/i4Wv3AO6B2sCSXcllfC+iesHKM=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vqERTLFUczRXo65v7Zgon5G6+ymTJzr8u+S/Xw3bZDaK7JMOhLHsg90v/Ux194anY
	 4VcHRYah7ijDDn+636aiosmELtKUQoschbf5t9yOjkhcLx2eiueDbmNLFK0s1MhIaY
	 Hh2UjvdFcQ9wNRNlNbYrlE2uXi2efd9W6FmtODrw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C660F801F9;
	Tue,  7 Jul 2020 13:12:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DEC56F80216; Tue,  7 Jul 2020 13:12:36 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0CDBF800DF
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 13:12:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0CDBF800DF
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B2536B163
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 11:12:26 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: pcm: Fix build error on m68k and others
Date: Tue,  7 Jul 2020 13:12:25 +0200
Message-Id: <20200707111225.26826-1-tiwai@suse.de>
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

The commit 3ad796cbc36a ("ALSA: pcm: Use SG-buffer only when direct
DMA is available") introduced a check of the DMA type and this caused
a build error on m68k (and possibly some others) due to the lack of
dma_is_direct() definition.  Since the check is needed only for
CONFIG_SND_DMA_SGBUF enablement (i.e. solely x86), use #ifdef instead
of IS_ENABLED() for avoiding such a build error.

Fixes: 3ad796cbc36a ("ALSA: pcm: Use SG-buffer only when direct DMA is available")
Reported-by: Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_memory.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_memory.c b/sound/core/pcm_memory.c
index 8326d16d3596..795af1b88051 100644
--- a/sound/core/pcm_memory.c
+++ b/sound/core/pcm_memory.c
@@ -41,8 +41,9 @@ static int do_alloc_pages(struct snd_card *card, int type, struct device *dev,
 	    card->total_pcm_alloc_bytes + size > max_alloc_per_card)
 		return -ENOMEM;
 
-	if (IS_ENABLED(CONFIG_SND_DMA_SGBUF) &&
-	    (type == SNDRV_DMA_TYPE_DEV_SG || type == SNDRV_DMA_TYPE_DEV_UC_SG) &&
+
+#ifdef CONFIG_SND_DMA_SGBUF
+	if ((type == SNDRV_DMA_TYPE_DEV_SG || type == SNDRV_DMA_TYPE_DEV_UC_SG) &&
 	    !dma_is_direct(get_dma_ops(dev))) {
 		/* mutate to continuous page allocation */
 		dev_dbg(dev, "Use continuous page allocator\n");
@@ -51,6 +52,7 @@ static int do_alloc_pages(struct snd_card *card, int type, struct device *dev,
 		else
 			type = SNDRV_DMA_TYPE_DEV_UC;
 	}
+#endif /* CONFIG_SND_DMA_SGBUF */
 
 	err = snd_dma_alloc_pages(type, dev, size, dmab);
 	if (!err) {
-- 
2.16.4

