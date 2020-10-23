Return-Path: <SRS0=Lvkp=D6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4194C388F9
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2020 09:26:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EF7524182
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2020 09:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="R50SmXvK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b="HoL3z71p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF7524182
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 55D0117F4;
	Fri, 23 Oct 2020 11:25:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 55D0117F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603445155;
	bh=2sIfXNoEhTl+hbC30PGOioYEx+/AGfNa5Qy4xesiXJU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=R50SmXvK90l3HPosso06A6sBj2B7SD6F/4GkkIP1vTy0OEMBIHg+LwraZaoyga/dv
	 ujhnbP9JrVccsBSoknI2v+rIUyGVTJF4bSzXvADwGvmiuh94be0W54kE5Vcnz1uOTy
	 tspRVw34efdowz70Y5RdG7yhFF953yK/lF0Zu1gY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D934EF800BD;
	Fri, 23 Oct 2020 11:25:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1FDC9F8025A; Fri, 23 Oct 2020 11:25:03 +0200 (CEST)
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 62987F80247
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2020 11:24:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 62987F80247
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de
 header.b="HoL3z71p"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de; 
 s=default2002;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=eyX4nfoNjxF3CPh9On0HU2VfKtBouuxXvrfw4xIt1LY=; b=HoL3z71pcGpq+HfmwgO4lhLMHq
 Kh34alCFdtL6NNCmuYjCrzfCBbFcrRvFriCwOq+v7t64n9ne0aGHIOLZTm1DJvQ9SWiC8ISZku9lZ
 /Qd8BtzarQNQOC/Io0NaPHK5+7Wd2hBN9QZwbb/+4ePDUnb0kO2n3iPvTL5XB5vWITpYNsp4lRcoc
 8eHROx8HD0sBWaowEw2aGOVYo09kBYXvkfp6XVm8DXr2uXXfcyJUmcWXCo+MXJAcBk5mk0w3WBbLp
 QVovk8AMn+Rs7RB0eAJu6Uthmg7YT7BOyoClGSawNkE5pIRaOwaDoGNR5Toi/qXmtdDtDT3g987B4
 y5hNjoYQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
 by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92.3) (envelope-from <lars@metafoo.de>)
 id 1kVtJg-0003Pv-4k; Fri, 23 Oct 2020 11:24:56 +0200
Received: from [2001:a61:2478:ca01:9e5c:8eff:fe01:8578]
 (helo=lars-desktop.fritz.box)
 by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <lars@metafoo.de>)
 id 1kVtJg-000XSo-1G; Fri, 23 Oct 2020 11:24:56 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: jz4740-i2s: Remove manual DMA peripheral ID assignment
Date: Fri, 23 Oct 2020 11:23:46 +0200
Message-Id: <20201023092346.5777-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25965/Thu Oct 22 14:59:23 2020)
Cc: Paul Cercueil <paul@crapouillou.net>, alsa-devel@alsa-project.org,
 Lars-Peter Clausen <lars@metafoo.de>
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

All platforms that use the jz4740-i2s driver have been switched to
devicetree for a while now and the assignment of the DMA peripheral ID
is done in the devicetree.

It is no longer necessary to manually assign the peripheral ID in the
driver, so remove that. The DMA driver does not even look at the value
assigned in the driver anymore and always uses the value provided by the
devicetree.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/jz4740/jz4740-i2s.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index c7bd20104b20..e8bc7ca5ee5e 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -26,9 +26,6 @@
 
 #include "jz4740-i2s.h"
 
-#define JZ4740_DMA_TYPE_AIC_TRANSMIT 24
-#define JZ4740_DMA_TYPE_AIC_RECEIVE 25
-
 #define JZ_REG_AIC_CONF		0x00
 #define JZ_REG_AIC_CTRL		0x04
 #define JZ_REG_AIC_I2S_FMT	0x10
@@ -377,13 +374,11 @@ static void jz4740_i2c_init_pcm_config(struct jz4740_i2s *i2s)
 	/* Playback */
 	dma_data = &i2s->playback_dma_data;
 	dma_data->maxburst = 16;
-	dma_data->slave_id = JZ4740_DMA_TYPE_AIC_TRANSMIT;
 	dma_data->addr = i2s->phys_base + JZ_REG_AIC_FIFO;
 
 	/* Capture */
 	dma_data = &i2s->capture_dma_data;
 	dma_data->maxburst = 16;
-	dma_data->slave_id = JZ4740_DMA_TYPE_AIC_RECEIVE;
 	dma_data->addr = i2s->phys_base + JZ_REG_AIC_FIFO;
 }
 
-- 
2.20.1

