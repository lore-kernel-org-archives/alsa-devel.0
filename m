Return-Path: <SRS0=FucB=QC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E830EC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 08:59:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63BCF6321F
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 08:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 63BCF6321F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AE9A61677;
	Mon, 15 Nov 2021 09:58:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AE9A61677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636966776;
	bh=6T6nVYUZYeuHx0KVvy6d2aAfM4hqSW/xkD9UxCrEiew=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ewx2lQvdrLg0y+tGx+QwfwP/kqW9PGz3CbKmo6sM4pSJOjEWTklffEKuOnoU6bS9q
	 8RIBoIM53eNZHP35QwNhCcEQXNEJ0YqjxvSFVIXL4Tm01E6k2bnS3cJ/qspqa51y+T
	 EwST/3sJZvoav+FrSjXFrr2m8YM/RRL2e6k3XkPI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B07E8F804F2;
	Mon, 15 Nov 2021 09:57:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A3C1DF8027D; Mon, 15 Nov 2021 09:55:11 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 275DBF800FA
 for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2021 09:55:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 275DBF800FA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="XE1rkoS2"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C1DE63227;
 Mon, 15 Nov 2021 08:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636966506;
 bh=6T6nVYUZYeuHx0KVvy6d2aAfM4hqSW/xkD9UxCrEiew=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XE1rkoS26Hg1qVOUe/8JhihPWyqzwdxtSu6KpZSliRxpkj1mrD33TUzc4f3D7Z563
 QLiO1buUzxFjE4Smwu3DKTXQuDLm+gytZAgIqSOnAvyzoAXeDNMVaxRSz5FfYVxdzx
 fxlDZ6etPDPs4+Tui9Els9qLGXd+sLiGd5gsTfkJ6/smITicktBYHNkHB4AAvmw0pc
 NRLtSgumom3wapnQ8lOIVnzIUsTm+82JiaSwVIuKcuOx5tpNurM5w5orGkJkyh4UkT
 ImBiCpR78cdAYk6E0uXXpxENctgamiDTvLJByR5cyn6kcnDn0EUp+6TdkBa4HYzUNn
 uP4cknrvguDtA==
From: Arnd Bergmann <arnd@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 03/11] mmc: bcm2835: stop setting chan_config->slave_id
Date: Mon, 15 Nov 2021 09:53:55 +0100
Message-Id: <20211115085403.360194-4-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211115085403.360194-1-arnd@kernel.org>
References: <20211115085403.360194-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 15 Nov 2021 09:57:03 +0100
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

The field is not interpreted by the DMA engine driver, as all the data
is passed from devicetree instead. Remove the assignment so the field
can eventually be deleted.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/bcm2835.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 8c2361e66277..463b707d9e99 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1293,14 +1293,12 @@ static int bcm2835_add_host(struct bcm2835_host *host)
 
 		host->dma_cfg_tx.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 		host->dma_cfg_tx.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		host->dma_cfg_tx.slave_id = 13;		/* DREQ channel */
 		host->dma_cfg_tx.direction = DMA_MEM_TO_DEV;
 		host->dma_cfg_tx.src_addr = 0;
 		host->dma_cfg_tx.dst_addr = host->phys_addr + SDDATA;
 
 		host->dma_cfg_rx.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 		host->dma_cfg_rx.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		host->dma_cfg_rx.slave_id = 13;		/* DREQ channel */
 		host->dma_cfg_rx.direction = DMA_DEV_TO_MEM;
 		host->dma_cfg_rx.src_addr = host->phys_addr + SDDATA;
 		host->dma_cfg_rx.dst_addr = 0;
-- 
2.30.2

