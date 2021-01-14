Return-Path: <SRS0=k679=GR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7780CC433E9
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Jan 2021 13:35:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B181F23A5E
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Jan 2021 13:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B181F23A5E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B564616D0;
	Thu, 14 Jan 2021 14:34:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B564616D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610631339;
	bh=5feUocNsPVkK0oDWEJrQhycAmpNmrGyF2Gpr/FM/hbc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D9EONShAvStY5ThCB/feaKNrrpnYC9vWIGKY8Y3ziq3+9bgZBh9C8sNX7pTw4wmC7
	 lRwVl/zrq5HFC0mSydH/cEYzKIdlTPJXJr5cc8iyx0EN4g+wF6KDfqQn8P9S5Rih3i
	 o4SWe95vMZMBOZhiKOtwsK9Y/5Sce+I6rTnaydxY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 00E34F804C2;
	Thu, 14 Jan 2021 14:33:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B5AA1F80134; Thu, 14 Jan 2021 14:33:51 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8FDA3F80118
 for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2021 14:33:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8FDA3F80118
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id EF690AE12;
 Thu, 14 Jan 2021 13:33:40 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/3] ASoC: tegra: Simplify with dma_set_mask_and_coherent()
Date: Thu, 14 Jan 2021 14:33:37 +0100
Message-Id: <20210114133337.1039-4-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210114133337.1039-1-tiwai@suse.de>
References: <20210114133337.1039-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>
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

ASoC tegra PCM code still has explicit calls of dma_set_mask() and
dma_set_coherent_mask().

Let's simplify with dma_set_mask_and_coherent().

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/tegra/tegra_pcm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/tegra/tegra_pcm.c b/sound/soc/tegra/tegra_pcm.c
index b3f36515cbc1..573374b89b10 100644
--- a/sound/soc/tegra/tegra_pcm.c
+++ b/sound/soc/tegra/tegra_pcm.c
@@ -255,11 +255,7 @@ static int tegra_pcm_dma_allocate(struct snd_soc_pcm_runtime *rtd,
 	struct snd_pcm *pcm = rtd->pcm;
 	int ret;
 
-	ret = dma_set_mask(card->dev, DMA_BIT_MASK(32));
-	if (ret < 0)
-		return ret;
-
-	ret = dma_set_coherent_mask(card->dev, DMA_BIT_MASK(32));
+	ret = dma_set_mask_and_coherent(card->dev, DMA_BIT_MASK(32));
 	if (ret < 0)
 		return ret;
 
-- 
2.26.2

