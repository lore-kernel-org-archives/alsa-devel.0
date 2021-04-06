Return-Path: <SRS0=qvmA=JD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF5FC433B4
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Apr 2021 01:02:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 428D0613EA
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Apr 2021 01:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 428D0613EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CB73A15F9;
	Tue,  6 Apr 2021 03:01:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CB73A15F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617670942;
	bh=lZpSAHh1bVUImn7lJp+oYP1ggrY6Uvtl3AyVmTJ/9jk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OLzMx8hKnwjQPgQhQ8dNWuKkM9IZyKc6x8Jsg2PB//GjuoU3nctt7CqzcuE5Qb3dA
	 93op7j+XJAoodgog0c2HvCxcDib7zTFFSpR+nfy1z4IhC8A34s+25EnHTB5HLHSjQ+
	 vqcWyjA5gj0moLZk6Uxt+5OAq0JVBo5wU6dvdGe8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 38A12F80169;
	Tue,  6 Apr 2021 03:01:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BCBFDF8016A; Tue,  6 Apr 2021 03:01:30 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B2FDF8003A
 for <alsa-devel@alsa-project.org>; Tue,  6 Apr 2021 03:01:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B2FDF8003A
IronPort-SDR: uxU1oAwZ5Ss1MwItn9Nu9Epe1WtDmKWNPrDbgfrcdk1zdVEjNYpvVgEmOSZDrimCpOcctAucum
 dSDVh80iMkkg==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="256941414"
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; d="scan'208";a="256941414"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Apr 2021 18:01:12 -0700
IronPort-SDR: 6iD/G2z2w+mrZJ8DqCNu+CTlcmqDXXqNx50efMxLLpCFr1ZZhJ8oRC25Ohv9gwO7EUb/bc8nux
 Kkot7cYHSBgA==
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; d="scan'208";a="420964332"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Apr 2021 18:01:09 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v2] soundwire: intel_init: test link->cdns
Date: Tue,  6 Apr 2021 09:01:01 +0800
Message-Id: <20210406010101.11442-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: vinod.koul@linaro.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 hui.wang@canonical.com, sanyog.r.kale@intel.com, rander.wang@linux.intel.com,
 bard.liao@intel.com
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

intel_link_probe() could return error and dev_get_drvdata() will return
null in such case. So we have to test link->cdns after
link->cdns = dev_get_drvdata(&ldev->auxdev.dev);
Otherwise, we will meet the "kernel NULL pointer dereference" error.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
v2:
 - Rebase to latest code base.
---
 drivers/soundwire/intel_init.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 05b726cdfebc..30ce95ec2d70 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -178,6 +178,15 @@ static struct sdw_intel_ctx
 		link->pdev = pdev;
 		link->cdns = platform_get_drvdata(pdev);
 
+		if (!link->cdns) {
+			dev_err(&adev->dev, "failed to get link->cdns\n");
+			/*
+			 * 1 will be subtracted from i in the err label, but we need to call
+			 * intel_link_dev_unregister for this ldev, so plus 1 now
+			 */
+			i++;
+			goto err;
+		}
 		list_add_tail(&link->list, &ctx->link_list);
 		bus = &link->cdns->bus;
 		/* Calculate number of slaves */
-- 
2.17.1

