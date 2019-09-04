Return-Path: <SRS0=zeHb=W7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567FFC3A5A7
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Sep 2019 08:41:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1B9520870
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Sep 2019 08:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HbGqjnNQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B9520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 02D401689;
	Wed,  4 Sep 2019 10:40:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 02D401689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567586488;
	bh=zpV3DvYKwjF/h4/U1y/ynLO0AkOCaBZpmcjz2YAURSg=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HbGqjnNQOobcaZxaeDZKAzP/jc0qPFrhyWJ7pB2hpAeGPw/Y232BYKyhuD9AGgqC8
	 kvrIL+QaFFUxymaqxkjtXZquVZzu2sNGjYNDetEllLvDnoYkiJXz+xEecSzdiz9otX
	 MA7n4EleTLoMRH2B8QCc0B5dujZqnIIdUrcz00sE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7CF98F80394;
	Wed,  4 Sep 2019 10:40:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 19467F803A6; Wed,  4 Sep 2019 10:40:35 +0200 (CEST)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0074BF80171
 for <alsa-devel@alsa-project.org>; Wed,  4 Sep 2019 10:40:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0074BF80171
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id B48CFF872193D02F1BFB;
 Wed,  4 Sep 2019 16:40:28 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Sep 2019
 16:40:21 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
 <yuehaibing@huawei.com>, <alexios.zavras@intel.com>,
 <gregkh@linuxfoundation.org>, <rfontana@redhat.com>, <tglx@linutronix.de>
Date: Wed, 4 Sep 2019 16:39:09 +0800
Message-ID: <20190904083909.18804-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH -next] ASoC: tegra: use
	devm_platform_ioremap_resource() to simplify code
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/tegra/tegra30_ahub.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c
index 9523812..635eacb 100644
--- a/sound/soc/tegra/tegra30_ahub.c
+++ b/sound/soc/tegra/tegra30_ahub.c
@@ -511,7 +511,7 @@ static int tegra30_ahub_probe(struct platform_device *pdev)
 	const struct tegra30_ahub_soc_data *soc_data;
 	struct reset_control *rst;
 	int i;
-	struct resource *res0, *res1;
+	struct resource *res0;
 	void __iomem *regs_apbif, *regs_ahub;
 	int ret = 0;
 
@@ -587,8 +587,7 @@ static int tegra30_ahub_probe(struct platform_device *pdev)
 	}
 	regcache_cache_only(ahub->regmap_apbif, true);
 
-	res1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	regs_ahub = devm_ioremap_resource(&pdev->dev, res1);
+	regs_ahub = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(regs_ahub))
 		return PTR_ERR(regs_ahub);
 
-- 
2.7.4


_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
