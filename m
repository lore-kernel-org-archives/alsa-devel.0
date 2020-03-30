Return-Path: <SRS0=jBUr=5P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B686AC43331
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:57:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF9B2073B
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SDG1M/Wr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF9B2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A816C15F9;
	Mon, 30 Mar 2020 15:56:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A816C15F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585576662;
	bh=84XR/kmAYuvrz4WThvTqKMY9cMOYbn7CIEC+zWMi9Fc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SDG1M/Wr9OTTwwYcAkhXqw2LCUre0Qzg0oyLCKIFO94WHFKqLElLj0tP10HhS9oBl
	 jxYQ4ueVLP4f4J3ZtapXTPQE4oTmYAEoxg0DsC6CQ8ykJdSOmylLj2xy7ewhkCjquh
	 08uzfH36Tt2Ku2j2T8UWu8wt5uPrLyjdu0ZsqZMw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0542CF80145;
	Mon, 30 Mar 2020 15:56:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C9861F80148; Mon, 30 Mar 2020 15:56:50 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 34BA9F800EB
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2020 15:56:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 34BA9F800EB
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5035CAD57;
 Mon, 30 Mar 2020 13:56:46 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: bcm: Fix pointer cast warning
Date: Mon, 30 Mar 2020 15:56:45 +0200
Message-Id: <20200330135645.9707-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: alsa-devel@alsa-project.org
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

The NULL check can be done gracefully without cast.  It fixes a
compile warning like:
  sound/soc/bcm/bcm63xx-pcm-whistler.c:184:6: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]

Fixes: 88eb404ccc3e ("ASoC: brcm: Add DSL/PON SoC audio driver")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/bcm/bcm63xx-pcm-whistler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/bcm/bcm63xx-pcm-whistler.c b/sound/soc/bcm/bcm63xx-pcm-whistler.c
index e46c390683e7..b7a1efc7406e 100644
--- a/sound/soc/bcm/bcm63xx-pcm-whistler.c
+++ b/sound/soc/bcm/bcm63xx-pcm-whistler.c
@@ -181,7 +181,7 @@ bcm63xx_pcm_pointer(struct snd_soc_component *component,
 	snd_pcm_uframes_t x;
 	struct bcm63xx_runtime_data *prtd = substream->runtime->private_data;
 
-	if ((void *)prtd->dma_addr_next == NULL)
+	if (!prtd->dma_addr_next)
 		prtd->dma_addr_next = substream->runtime->dma_addr;
 
 	x = bytes_to_frames(substream->runtime,
-- 
2.16.4

