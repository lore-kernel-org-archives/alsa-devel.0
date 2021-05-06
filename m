Return-Path: <SRS0=TimU=KB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E74C433B4
	for <alsa-devel@archiver.kernel.org>; Thu,  6 May 2021 10:57:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9805C61185
	for <alsa-devel@archiver.kernel.org>; Thu,  6 May 2021 10:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9805C61185
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 28EF7843;
	Thu,  6 May 2021 12:57:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 28EF7843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620298674;
	bh=odXIwjmvO4TjkheT5uUkH9rWzyN7m+vEEmZvqNYXprg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NakvrUdjrQplkRoO0ZVyrm79of5soNE1mt6nRVEF1ezbflgzvXEnBADDTpuZBUJyG
	 IGAvBwMpUS348raoB+k2HXJkKOkYNKdQtCal8WOUYa05ToKQtJfXq7Wu+YBBxAV99I
	 W0ZXIY4MbxDzt+NqgPLq8pZUE4Rq7MftZRQOSoCw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A7F80F801F7;
	Thu,  6 May 2021 12:57:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B4C68F8021C; Thu,  6 May 2021 12:57:02 +0200 (CEST)
Received: from out4436.biz.mail.alibaba.com (out4436.biz.mail.alibaba.com
 [47.88.44.36])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0812F80108
 for <alsa-devel@alsa-project.org>; Thu,  6 May 2021 12:56:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0812F80108
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424;
 MF=jiapeng.chong@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0UXyl1SF_1620298592; 
Received: from
 j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com
 fp:SMTPD_---0UXyl1SF_1620298592) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 06 May 2021 18:56:50 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: lgirdwood@gmail.com
Subject: [PATCH] ASoC: amd: renoir: Remove redundant assignment to pdm_ctrl
 and pdm_enable and pdm_dma_enable
Date: Thu,  6 May 2021 18:56:30 +0800
Message-Id: <1620298590-29749-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com,
 broonie@kernel.org
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

Variable pdm_ctrl and pdm_enable and pdm_dma_enable are set to '0x00',
but they are overwritten later on, so these are redundant assignments
that can be removed.

Clean up the following clang-analyzer warning:

sound/soc/amd/renoir/acp3x-pdm-dma.c:148:2: warning: Value stored to
'pdm_dma_enable' is never read [clang-analyzer-deadcode.DeadStores].

sound/soc/amd/renoir/acp3x-pdm-dma.c:147:2: warning: Value stored to
'pdm_enable' is never read [clang-analyzer-deadcode.DeadStores].

sound/soc/amd/renoir/acp3x-pdm-dma.c:80:2: warning: Value stored to
'pdm_ctrl' is never read [clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/soc/amd/renoir/acp3x-pdm-dma.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/amd/renoir/acp3x-pdm-dma.c b/sound/soc/amd/renoir/acp3x-pdm-dma.c
index 4c2810e..bd20622b 100644
--- a/sound/soc/amd/renoir/acp3x-pdm-dma.c
+++ b/sound/soc/amd/renoir/acp3x-pdm-dma.c
@@ -77,7 +77,6 @@ static void enable_pdm_clock(void __iomem *acp_base)
 	u32 pdm_clk_enable, pdm_ctrl;
 
 	pdm_clk_enable = ACP_PDM_CLK_FREQ_MASK;
-	pdm_ctrl = 0x00;
 
 	rn_writel(pdm_clk_enable, acp_base + ACP_WOV_CLK_CTRL);
 	pdm_ctrl = rn_readl(acp_base + ACP_WOV_MISC_CTRL);
@@ -144,9 +143,6 @@ static int stop_pdm_dma(void __iomem *acp_base)
 	u32 pdm_enable, pdm_dma_enable;
 	int timeout;
 
-	pdm_enable = 0x00;
-	pdm_dma_enable  = 0x00;
-
 	pdm_enable = rn_readl(acp_base + ACP_WOV_PDM_ENABLE);
 	pdm_dma_enable = rn_readl(acp_base + ACP_WOV_PDM_DMA_ENABLE);
 	if (pdm_dma_enable & 0x01) {
-- 
1.8.3.1

