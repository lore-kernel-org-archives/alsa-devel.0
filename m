Return-Path: <SRS0=FucB=QC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464C0C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 09:01:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB6D63221
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 09:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AEB6D63221
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2149E1698;
	Mon, 15 Nov 2021 10:00:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2149E1698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636966882;
	bh=dcMQMZncG8IjNijKZNej/gmwTiTYDPeCFK23hEXOfto=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WpQOe8zxKRcyloVANkUKLZeDa7jCijUHDbUov5tU70IriwrSVhygc8wBRWzwFZdVV
	 w6RZc2a33Dz9YRVMzR8l7DEPMyNRaL1bhHJsKYu9vk7RgaQCbZATzPG2SXyn75hAbs
	 tyrZMAWVDsijObsbFLKHxavtPryEl8+B1x3Nu7wM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 34545F80524;
	Mon, 15 Nov 2021 09:57:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E405AF8028B; Mon, 15 Nov 2021 09:55:49 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6A947F800FA
 for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2021 09:55:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A947F800FA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="VYuJvxO5"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2223663223;
 Mon, 15 Nov 2021 08:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636966545;
 bh=dcMQMZncG8IjNijKZNej/gmwTiTYDPeCFK23hEXOfto=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VYuJvxO5lVR/GiGcXXlpTenpQL8tS/RiB2q/z0CMEjbvV3OtExgDGliJ9mPslll9Z
 gJF9jW4NvrAMcYVtan/DOPn491D5evV0DjVoLO4PKbj3djKSiupC9gs/o/JDRousmF
 VfKHtJYY+yuBV0OABHqDiHSUkpE6qGp8SFfe7NSJEmA0l/mxODuVE3wHHx7vsA5sov
 Wa36nu6IAmzkpbTK/7+6RaXeDPwWYCIT8QDeBGczguXuJlI760X3i1oAk8E/g82B3L
 MDBneNRRk20n1rSG1Z9mUgJiWRhrqnptEhFZTTbLf+wXfy+4WmVGvjS1fVUD20TPas
 ktKoOqahs6Lsg==
From: Arnd Bergmann <arnd@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 09/11] dmaengine: tegra20-apb: stop checking config->slave_id
Date: Mon, 15 Nov 2021 09:54:01 +0100
Message-Id: <20211115085403.360194-10-arnd@kernel.org>
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

Nothing sets the slave_id field any more, so stop accessing
it to allow the removal of this field.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/tegra20-apb-dma.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index b7260749e8ee..eaafcbe4ca94 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -343,12 +343,6 @@ static int tegra_dma_slave_config(struct dma_chan *dc,
 	}
 
 	memcpy(&tdc->dma_sconfig, sconfig, sizeof(*sconfig));
-	if (tdc->slave_id == TEGRA_APBDMA_SLAVE_ID_INVALID &&
-	    sconfig->device_fc) {
-		if (sconfig->slave_id > TEGRA_APBDMA_CSR_REQ_SEL_MASK)
-			return -EINVAL;
-		tdc->slave_id = sconfig->slave_id;
-	}
 	tdc->config_init = true;
 
 	return 0;
-- 
2.30.2

