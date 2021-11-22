Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6FFC433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Nov 2021 08:29:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F85616B5;
	Tue, 23 Nov 2021 09:28:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F85616B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637656156;
	bh=zgLZXkTyZeT2yxDxiCRe3tFY2/P5W/tmmoA+2l/FQdQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vnFfWFsXJJnaNOPv2A/fw5iYC9/ja4HLryJNP+N/Egm8+T35kFdUu1Houn69T5jnt
	 c3itP4Wkn2cxPRyaD5oiCOEoDr+uKPtJwQNKGyk/klD4HuGyUxjQH8Y9eSIWlU184F
	 jD/db+jsQqC/hmImi+o/Uqo5I8CWKTtM57My9NMw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C457DF804DF;
	Tue, 23 Nov 2021 09:22:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 14425F80141; Mon, 22 Nov 2021 23:22:57 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 90E87F80141
 for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2021 23:22:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 90E87F80141
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Vu62Qhxe"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26DA261037;
 Mon, 22 Nov 2021 22:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637619772;
 bh=zgLZXkTyZeT2yxDxiCRe3tFY2/P5W/tmmoA+2l/FQdQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Vu62QhxeOG1cTVOI1XJg/cEM/6feijvDUEtMYFy8XGtjFmu3J1wivNmJYFrS1UcOV
 D+7e8/dcFQJTEA2AuE8XH0Mo5hqIkvIU7jr7CXg/xJJcBc/3gkswZgRMRHG8yZS0C6
 A3RlkUSxzEV8XzxTLRQEg6uwnlfUqY5RyXCBxp+xRMO+dd1lHyAqALGLeMHvmaTpcw
 I7KwaDzzGuTLRIA8G7Pjt3vR4BnO8qW8/WDSQVat4v/Pe4kmO2BGzBrfFp32eScXMa
 WlyfUsLnnvlA2nG0tzpq6/XyXcfBH7wJwB0PO2DRQHs2fGLdesV9Gr4tLV3qGoyVAl
 oM4+hQ4U+pU9g==
From: Arnd Bergmann <arnd@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2 03/11] spi: pic32: stop setting dma_config->slave_id
Date: Mon, 22 Nov 2021 23:21:55 +0100
Message-Id: <20211122222203.4103644-4-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211122222203.4103644-1-arnd@kernel.org>
References: <20211122222203.4103644-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 23 Nov 2021 09:20:57 +0100
Cc: alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>, linux-tegra@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>, linux-mtd@lists.infradead.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 linux-spi@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>,
 Lars-Peter Clausen <lars@metafoo.de>, Chunyan Zhang <zhang.lyra@gmail.com>,
 linux-staging@lists.linux.dev, Michal Simek <michal.simek@xilinx.com>,
 Jon Hunter <jonathanh@nvidia.com>, Andy Gross <agross@kernel.org>,
 bcm-kernel-feedback-list@broadcom.com, linux-serial@vger.kernel.org,
 Orson Zhai <orsonzhai@gmail.com>, Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Manivannan Sadhasivam <mani@kernel.org>,
 linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, linux-rpi-kernel@lists.infradead.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, Scott Branden <sbranden@broadcom.com>,
 Hyun Kwon <hyun.kwon@xilinx.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 Laxman Dewangan <ldewangan@nvidia.com>, Baolin Wang <baolin.wang7@gmail.com>
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

From: Arnd Bergmann <arnd@arndb.de>

Setting slave_id makes no sense with DT based probing, and
should eventually get removed entirely. Address this driver
by no longer setting the field here.

I could not find which DMA driver is used on PIC32, if it's
in the tree at all, but none of the obvious ones even care
about slave_id any more.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/spi/spi-pic32.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 5eb7b61bbb4d..f86433b29260 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -370,7 +370,6 @@ static int pic32_spi_dma_config(struct pic32_spi *pic32s, u32 dma_width)
 	cfg.src_addr_width = dma_width;
 	cfg.dst_addr_width = dma_width;
 	/* tx channel */
-	cfg.slave_id = pic32s->tx_irq;
 	cfg.direction = DMA_MEM_TO_DEV;
 	ret = dmaengine_slave_config(master->dma_tx, &cfg);
 	if (ret) {
@@ -378,7 +377,6 @@ static int pic32_spi_dma_config(struct pic32_spi *pic32s, u32 dma_width)
 		return ret;
 	}
 	/* rx channel */
-	cfg.slave_id = pic32s->rx_irq;
 	cfg.direction = DMA_DEV_TO_MEM;
 	ret = dmaengine_slave_config(master->dma_rx, &cfg);
 	if (ret)
-- 
2.29.2

