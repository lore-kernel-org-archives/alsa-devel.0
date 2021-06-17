Return-Path: <SRS0=NYZN=LL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34568C2B9F4
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Jun 2021 10:36:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92FEF613B9
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Jun 2021 10:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92FEF613B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0700616EA;
	Thu, 17 Jun 2021 12:35:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0700616EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623926206;
	bh=Z0M7Y4S17pq4hokQMPXY5dYP1gmP4JDQ6s09aELK2P0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=I3lbWt4T5c1Mxml8ci1CoVzOv2vrBO3GQieZul+xaZ97QMWXd/+J8wfSEI0FMY+pZ
	 xGALA3bbkO+fXgq3UBIL5BsTxvJCVTAaBaKxW4V8qh4Of2ZL+Hs7x0LsdGe1KRIWGW
	 zlM1nTX95unLK9RJbv6FJHi0PYG1oNFlCTEPr9xA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9309DF80171;
	Thu, 17 Jun 2021 12:35:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0D98CF8025A; Thu, 17 Jun 2021 12:35:54 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 19435F80148
 for <alsa-devel@alsa-project.org>; Thu, 17 Jun 2021 12:35:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 19435F80148
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G5JJH4Hhqz6yLC;
 Thu, 17 Jun 2021 18:31:43 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 18:35:42 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 18:35:42 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>, Pierre-Louis Bossart
 <pierre-louis.bossart@linux.intel.com>, Liam Girdwood
 <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, "Mark
 Brown" <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, alsa-devel <alsa-devel@alsa-project.org>
Subject: [PATCH 1/1] ASoC: Intel: bdw-rt5677: remove unnecessary oom message
Date: Thu, 17 Jun 2021 18:35:38 +0800
Message-ID: <20210617103538.1818-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Cc: Zhen Lei <thunder.leizhen@huawei.com>
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

Fixes scripts/checkpatch.pl warning:
WARNING: Possible unnecessary 'out of memory' message

Remove it can help us save a bit of memory.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 sound/soc/intel/boards/bdw-rt5677.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bdw-rt5677.c b/sound/soc/intel/boards/bdw-rt5677.c
index 021bc59aac80..e01b7a90ca6c 100644
--- a/sound/soc/intel/boards/bdw-rt5677.c
+++ b/sound/soc/intel/boards/bdw-rt5677.c
@@ -423,10 +423,8 @@ static int bdw_rt5677_probe(struct platform_device *pdev)
 	/* Allocate driver private struct */
 	bdw_rt5677 = devm_kzalloc(&pdev->dev, sizeof(struct bdw_rt5677_priv),
 		GFP_KERNEL);
-	if (!bdw_rt5677) {
-		dev_err(&pdev->dev, "Can't allocate bdw_rt5677\n");
+	if (!bdw_rt5677)
 		return -ENOMEM;
-	}
 
 	/* override plaform name, if required */
 	mach = pdev->dev.platform_data;
-- 
2.25.1


