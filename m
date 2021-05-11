Return-Path: <SRS0=Cjbi=KG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDEAC433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 03:03:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A77610A7
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 03:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A77610A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DAAE3178B;
	Tue, 11 May 2021 05:02:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DAAE3178B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620702228;
	bh=bCzrmL6MKF3sdq8A6iirzCWDVeZidLosjFfqxuA3mwU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F3ehS+AIuKPbUGh3qm8WfIk1MzAcsBXOrjXIvk1nzEkEikFB5fDuYQbC+hSpWY32k
	 cj5v5ABuyp8q+FUjrq6abUKK3XARVqaNP4xUmNERbNNq0pjQrNhifMH4AcFBwMJsNJ
	 7GzT9EVWoP/gGRc/uhf+vLTzPdDjJSDBbE3JuIjc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E1E2F804AD;
	Tue, 11 May 2021 05:01:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 19E0AF804AE; Tue, 11 May 2021 05:01:23 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A9440F80430
 for <alsa-devel@alsa-project.org>; Tue, 11 May 2021 05:01:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9440F80430
IronPort-SDR: iFI61q/sCSwaNNv8VY7UEOSBFvKugfsxNygpqI/AUP+uPMT+INwDGAfXwUwkjFP9ZYdqlNujPk
 hqYpA7nqLiJg==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="186784954"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; d="scan'208";a="186784954"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2021 20:01:13 -0700
IronPort-SDR: KuvNB2phG5i6FvdNgs7VV6zDQb4HBrgFAoGjjo0g2AAjVBu5aX6Pn1F3i16sgDKVu2KBtbtr0Y
 Lb5eLPuRyq6A==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; d="scan'208";a="436431181"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2021 20:01:10 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [RESEND PATCH 4/4] soundwire: bus: add missing \n in dynamic debug
Date: Tue, 11 May 2021 11:00:48 +0800
Message-Id: <20210511030048.25622-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210511030048.25622-1-yung-chuan.liao@linux.intel.com>
References: <20210511030048.25622-1-yung-chuan.liao@linux.intel.com>
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

They were missed in previous contributions.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 100d904bf700..85bcf60f9697 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -886,7 +886,7 @@ static int sdw_bus_wait_for_clk_prep_deprep(struct sdw_bus *bus, u16 dev_num)
 		}
 		val &= SDW_SCP_STAT_CLK_STP_NF;
 		if (!val) {
-			dev_dbg(bus->dev, "clock stop prep/de-prep done slave:%d",
+			dev_dbg(bus->dev, "clock stop prep/de-prep done slave:%d\n",
 				dev_num);
 			return 0;
 		}
@@ -895,7 +895,7 @@ static int sdw_bus_wait_for_clk_prep_deprep(struct sdw_bus *bus, u16 dev_num)
 		retry--;
 	} while (retry);
 
-	dev_err(bus->dev, "clock stop prep/de-prep failed slave:%d",
+	dev_err(bus->dev, "clock stop prep/de-prep failed slave:%d\n",
 		dev_num);
 
 	return -ETIMEDOUT;
-- 
2.17.1

