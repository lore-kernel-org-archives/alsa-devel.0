Return-Path: <SRS0=FucB=QC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF65C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 08:59:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75E546321A
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 08:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 75E546321A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C8DB51681;
	Mon, 15 Nov 2021 09:58:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C8DB51681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636966751;
	bh=SSVFq8V5QgZ8AMrKjuNifJwPRFV2bwVTfXVHbqPj2aU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IN0AuLWZ4D9YViLvKuS9fwb/HMOhMU9hU7eavWFx/ulDqTg2aVEzlyJrdK7kjx8rx
	 MrQbub5Qi5M3tKyuwKYDxxyk4xLyYUJIcSUqysb3YDzk+ujmnv3BmMc/w9r/4NsUTs
	 7LoD5padALuX9yWFUj+Rlv2VwEP/NBSvEY/s/bZU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0EEE5F804ED;
	Mon, 15 Nov 2021 09:57:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E36C8F80163; Mon, 15 Nov 2021 09:55:09 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68CDFF801D5
 for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2021 09:55:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68CDFF801D5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="IWPlOAoN"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9224463222;
 Mon, 15 Nov 2021 08:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636966499;
 bh=SSVFq8V5QgZ8AMrKjuNifJwPRFV2bwVTfXVHbqPj2aU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IWPlOAoNVZ+ir7KGxrildoWGM1mQnaf7ewCJRGxAlh7sp55Kq08VXBsh2HJq0UNxl
 eJrtqrhd9f07DrNoIIYQxXcw0Dj7MyBMWvAjpLeDa0bPZnGyAXGf8Nn/iif0W7tUNF
 aASGKwu2D0mv1fB6bh3667PFZmstR+abS6MkboFwlFENPAACABf6i0vQqciiacp6D+
 CIa/shXrYU7IuqNvw2zRLT7DL94AW8AmV/eR1AVEhs5f+SoYebk81ievQQ/PH1ufo+
 sAfTJSFcuSqXozuveEFZbfN7PIQy3f0IbF7les+K9TRndRM/0BhX+9Zl6TK4QdhdOX
 HbQ0zPRM57fFg==
From: Arnd Bergmann <arnd@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 02/11] spi: pic32: stop setting dma_config->slave_id
Date: Mon, 15 Nov 2021 09:53:54 +0100
Message-Id: <20211115085403.360194-3-arnd@kernel.org>
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

Setting slave_id makes no sense with DT based probing, and
should eventually get removed entirely. Address this driver
by no longer setting the field here.

I could not find which DMA driver is used on PIC32, if it's
in the tree at all, but none of the obvious ones even care
about slave_id any more.

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
2.30.2

