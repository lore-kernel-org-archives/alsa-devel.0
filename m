Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E00C433F5
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Dec 2021 20:57:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6FA7A2903;
	Thu,  2 Dec 2021 21:56:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6FA7A2903
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638478665;
	bh=dGbfCbsvdte0OKKuqTlMDqvFFhTkcpaPxkXWhEAoTuw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nVtmxOuWtki1APB31wb9tBtXi7y9L02yEQEEGHvKcCL//sakW9PHrOUfi3dMXOtSf
	 0FLNNG3MTaelx4hjfuHZDpHM2V03U9+FnIKQECytACo4Pq6xIpbDyEqy/XiPUrXeA3
	 L29KxgSOWD+7Owiil/OLwGHTZVj0mFm8h9v6M1OQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 23CBFF80162;
	Thu,  2 Dec 2021 21:56:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BB169F8024C; Thu,  2 Dec 2021 21:56:22 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9C9CFF80162
 for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2021 21:56:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C9CFF80162
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="224068565"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; d="scan'208";a="224068565"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2021 12:56:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; d="scan'208";a="459805325"
Received: from black.fi.intel.com ([10.237.72.28])
 by orsmga003.jf.intel.com with ESMTP; 02 Dec 2021 12:56:10 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id A9C86109; Thu,  2 Dec 2021 22:56:15 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] ASoC: ti: davinci-mcasp: Get rid of duplicate of_node
 assignment
Date: Thu,  2 Dec 2021 22:56:11 +0200
Message-Id: <20211202205612.76216-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>
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

GPIO library does copy the of_node from the parent device of
the GPIO chip, there is no need to repeat this in the individual
drivers. Remove assignment here.

For the details one may look into the of_gpio_dev_init() implementation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/ti/davinci-mcasp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index 56a19eeec5c7..81c1ccec5904 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -2230,9 +2230,6 @@ static int davinci_mcasp_init_gpiochip(struct davinci_mcasp *mcasp)
 	mcasp->gpio_chip = davinci_mcasp_template_chip;
 	mcasp->gpio_chip.label = dev_name(mcasp->dev);
 	mcasp->gpio_chip.parent = mcasp->dev;
-#ifdef CONFIG_OF_GPIO
-	mcasp->gpio_chip.of_node = mcasp->dev->of_node;
-#endif
 
 	return devm_gpiochip_add_data(mcasp->dev, &mcasp->gpio_chip, mcasp);
 }
-- 
2.33.0

