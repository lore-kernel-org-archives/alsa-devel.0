Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E514C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Nov 2021 08:30:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 78C5B16D1;
	Tue, 23 Nov 2021 09:29:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 78C5B16D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637656211;
	bh=mEZeKwAu9cmy86njGDu0eXHIrGjfEnYmGSI37A9u8C4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oJEV8m1n0gEkxE4xLzDo5BDaR8oy/NnwwykdLUeaqVmJmXAj4GO0sFztdPE3vJe0f
	 KF5NkYNny+6PgaLoIQEdQw9vaMNDdSKVDE+qW698jp3+wshqL7qNlzH5dfWFuu893m
	 qnRKVVCCrTy1sVHm8+2olzUExmFIIAYEK7+duEqU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BAD50F805C0;
	Tue, 23 Nov 2021 09:22:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 83EF2F80245; Mon, 22 Nov 2021 23:23:18 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C7DE2F80141
 for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2021 23:23:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C7DE2F80141
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Mds7UvBa"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9540861051;
 Mon, 22 Nov 2021 22:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637619791;
 bh=mEZeKwAu9cmy86njGDu0eXHIrGjfEnYmGSI37A9u8C4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Mds7UvBahSLSVHiBQ9v2Ytg5G1Sxspx3HwfkVRigOS+lcbEmjTSyArF7E1ugjwBBD
 2YqSubbC7b6D0R0dyKzHjgFlTme434/IjPEnvZwi2CG9RIUhvUPIqM1M6Qfe8xBdtS
 n7Cbk51NQppDYReLPMyQPjV7wY1ln/ndhpewTxxkL/meQAovg2HWZHUjvGmZNShKh4
 +lzzUkQ+p/BnGqZl17YTexH1jnjJNGGbt90k/iXE3j4vagAjUI+gZPiuTSca+PmE0+
 vis7Va7kgZlXo6RAiCjJUtA+avyjvYe+q5Y2LJSAAPAoO/7sW8Al8MVdglg/v4rbAT
 AcAek++ntYExw==
From: Arnd Bergmann <arnd@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2 06/11] dmaengine: pxa/mmp: stop referencing config->slave_id
Date: Mon, 22 Nov 2021 23:21:58 +0100
Message-Id: <20211122222203.4103644-7-arnd@kernel.org>
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

The last driver referencing the slave_id on Marvell PXA and MMP platforms
was the SPI driver, but this stopped doing so a long time ago, so the
TODO from the earlier patch can no be removed.

Fixes: b729bf34535e ("spi/pxa2xx: Don't use slave_id of dma_slave_config")
Fixes: 13b3006b8ebd ("dma: mmp_pdma: add filter function")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/mmp_pdma.c | 6 ------
 drivers/dma/pxa_dma.c  | 7 -------
 2 files changed, 13 deletions(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index a23563cd118b..5a53d7fcef01 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -727,12 +727,6 @@ static int mmp_pdma_config_write(struct dma_chan *dchan,
 
 	chan->dir = direction;
 	chan->dev_addr = addr;
-	/* FIXME: drivers should be ported over to use the filter
-	 * function. Once that's done, the following two lines can
-	 * be removed.
-	 */
-	if (cfg->slave_id)
-		chan->drcmr = cfg->slave_id;
 
 	return 0;
 }
diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 52d04641e361..6078cc81892e 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -909,13 +909,6 @@ static void pxad_get_config(struct pxad_chan *chan,
 		*dcmd |= PXA_DCMD_BURST16;
 	else if (maxburst == 32)
 		*dcmd |= PXA_DCMD_BURST32;
-
-	/* FIXME: drivers should be ported over to use the filter
-	 * function. Once that's done, the following two lines can
-	 * be removed.
-	 */
-	if (chan->cfg.slave_id)
-		chan->drcmr = chan->cfg.slave_id;
 }
 
 static struct dma_async_tx_descriptor *
-- 
2.29.2

