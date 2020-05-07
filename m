Return-Path: <SRS0=eFJe=6V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB0AC38A24
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2020 07:19:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16D45207DD
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2020 07:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gLJFfnZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D45207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 514A617E0;
	Thu,  7 May 2020 09:18:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 514A617E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588835949;
	bh=l/69gPcatMDSLbjjBsky73LE8GrfsaWuoK68d2VrpJw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gLJFfnZC4cxUK28CJUqpHCZy0VZ3dj42AhYxpEoDctu3Un4bX3Ti4cGtq6fRzXhsc
	 mKBv9nPMeL+1FhjU7A6AxP1jIAaTm38OOXYIw6FcfadvjAqcYGiF4Ll6xEnOecMUHs
	 MtbdAEdgx9tDFMsq03YCHUMqKbRLe8scFyfE+nfg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BEA3BF80291;
	Thu,  7 May 2020 09:16:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 10F7BF8015F; Thu,  7 May 2020 08:33:42 +0200 (CEST)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 07924F800AD
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2020 08:33:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07924F800AD
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 4C5D4A87EB3CBC1BFCE0;
 Thu,  7 May 2020 14:33:21 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 14:33:14 +0800
From: Samuel Zou <zou_wei@huawei.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>
Subject: [PATCH -next] ASoC: amd: acp3x-pcm-dma: Use bitwise instead of
 arithmetic operator for flags
Date: Thu, 7 May 2020 14:39:22 +0800
Message-ID: <1588833562-14417-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 07 May 2020 09:16:08 +0200
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Samuel Zou <zou_wei@huawei.com>
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

Fix the following coccinelle warnings:

sound/soc/amd/raven/acp3x-pcm-dma.c:161:39-40: WARNING: sum of probable bitmasks, consider |
sound/soc/amd/raven/acp3x-pcm-dma.c:172:39-40: WARNING: sum of probable bitmasks, consider |
sound/soc/amd/raven/acp3x-pcm-dma.c:183:39-40: WARNING: sum of probable bitmasks, consider |
sound/soc/amd/raven/acp3x-pcm-dma.c:194:39-40: WARNING: sum of probable bitmasks, consider |

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Samuel Zou <zou_wei@huawei.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index e362f0b..b0cc0fe 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -158,7 +158,7 @@ static void config_acp3x_dma(struct i2s_stream_instance *rtd, int direction)
 		switch (rtd->i2s_instance) {
 		case I2S_BT_INSTANCE:
 			reg_dma_size = mmACP_BT_TX_DMA_SIZE;
-			acp_fifo_addr = ACP_SRAM_PTE_OFFSET +
+			acp_fifo_addr = ACP_SRAM_PTE_OFFSET |
 						BT_PB_FIFO_ADDR_OFFSET;
 			reg_fifo_addr = mmACP_BT_TX_FIFOADDR;
 			reg_fifo_size = mmACP_BT_TX_FIFOSIZE;
@@ -169,7 +169,7 @@ static void config_acp3x_dma(struct i2s_stream_instance *rtd, int direction)
 		case I2S_SP_INSTANCE:
 		default:
 			reg_dma_size = mmACP_I2S_TX_DMA_SIZE;
-			acp_fifo_addr = ACP_SRAM_PTE_OFFSET +
+			acp_fifo_addr = ACP_SRAM_PTE_OFFSET |
 						SP_PB_FIFO_ADDR_OFFSET;
 			reg_fifo_addr =	mmACP_I2S_TX_FIFOADDR;
 			reg_fifo_size = mmACP_I2S_TX_FIFOSIZE;
@@ -180,7 +180,7 @@ static void config_acp3x_dma(struct i2s_stream_instance *rtd, int direction)
 		switch (rtd->i2s_instance) {
 		case I2S_BT_INSTANCE:
 			reg_dma_size = mmACP_BT_RX_DMA_SIZE;
-			acp_fifo_addr = ACP_SRAM_PTE_OFFSET +
+			acp_fifo_addr = ACP_SRAM_PTE_OFFSET |
 						BT_CAPT_FIFO_ADDR_OFFSET;
 			reg_fifo_addr = mmACP_BT_RX_FIFOADDR;
 			reg_fifo_size = mmACP_BT_RX_FIFOSIZE;
@@ -191,7 +191,7 @@ static void config_acp3x_dma(struct i2s_stream_instance *rtd, int direction)
 		case I2S_SP_INSTANCE:
 		default:
 			reg_dma_size = mmACP_I2S_RX_DMA_SIZE;
-			acp_fifo_addr = ACP_SRAM_PTE_OFFSET +
+			acp_fifo_addr = ACP_SRAM_PTE_OFFSET |
 						SP_CAPT_FIFO_ADDR_OFFSET;
 			reg_fifo_addr = mmACP_I2S_RX_FIFOADDR;
 			reg_fifo_size = mmACP_I2S_RX_FIFOSIZE;
-- 
2.6.2

