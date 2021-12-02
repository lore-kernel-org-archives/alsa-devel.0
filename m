Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC78C433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Dec 2021 20:57:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C249F2916;
	Thu,  2 Dec 2021 21:56:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C249F2916
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638478668;
	bh=UBSFmCP/K+XXb27Ai0+0emD8J9fytvHj0MsgarJE4Ks=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bHgSPqEGEHmAi7Xi+r5X5Kv6ocrNz6/zPcB3qsAda6FNZXezPA8B3b4bjg/AAvh1p
	 uByf3VLrqYFxw4JDeyHADr1C6KBveHRg+FmtVslcR5vB0Zp3WCLUi7qgxolR2SqQi2
	 dR35HiYK8LTwdnroRWCti9xwoBFiTIrV/ahPtuUw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AD769F80475;
	Thu,  2 Dec 2021 21:56:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1BA8EF80482; Thu,  2 Dec 2021 21:56:29 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D732FF8023B
 for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2021 21:56:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D732FF8023B
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="236643497"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; d="scan'208";a="236643497"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2021 12:56:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; d="scan'208";a="513356078"
Received: from black.fi.intel.com ([10.237.72.28])
 by orsmga008.jf.intel.com with ESMTP; 02 Dec 2021 12:56:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 5A47C165; Thu,  2 Dec 2021 22:56:16 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] ASoC: ti: davinci-mcasp: Remove unnecessary conditional
Date: Thu,  2 Dec 2021 22:56:12 +0200
Message-Id: <20211202205612.76216-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211202205612.76216-1-andriy.shevchenko@linux.intel.com>
References: <20211202205612.76216-1-andriy.shevchenko@linux.intel.com>
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

Instead of double validating of_node, return value of
the boolean property directly.

We can't remove ifdeffery, because in OF_GPIO=n cases
it might bring unwanted surprises.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/ti/davinci-mcasp.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index 81c1ccec5904..3e105caac95e 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -1870,12 +1870,10 @@ static int mcasp_reparent_fck(struct platform_device *pdev)
 static bool davinci_mcasp_have_gpiochip(struct davinci_mcasp *mcasp)
 {
 #ifdef CONFIG_OF_GPIO
-	if (mcasp->dev->of_node &&
-	    of_property_read_bool(mcasp->dev->of_node, "gpio-controller"))
-		return true;
-#endif
-
+	return of_property_read_bool(mcasp->dev->of_node, "gpio-controller");
+#else
 	return false;
+#endif
 }
 
 static int davinci_mcasp_get_config(struct davinci_mcasp *mcasp,
-- 
2.33.0

