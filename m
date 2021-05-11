Return-Path: <SRS0=Cjbi=KG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F86FC433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 06:02:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EEAB61926
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 06:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEAB61926
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 338F61771;
	Tue, 11 May 2021 07:50:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 338F61771
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620712299;
	bh=WC+CE2sZjpnX9YSQaGpUf0AKVlLe3q+0qnDQoR2Jc4I=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LYYMhUC1oX6KstZglM77xnTku8UDeprRTuU0dfiinLmr+ED6vFLoEFxmS3VxMS5eF
	 dEGrj4+LKeN+zNyFN5TA3WEq5g+76+uHhFfulntlf3TXklKhZCcvDynQc9MmmR8mFO
	 uSUrxRNp/jBmGoWja5Ll1i1Uqj65wU+ozz7KKtdE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B695EF80129;
	Tue, 11 May 2021 07:50:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E8BD9F80163; Tue, 11 May 2021 07:50:47 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 18708F80129
 for <alsa-devel@alsa-project.org>; Tue, 11 May 2021 07:50:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 18708F80129
IronPort-SDR: kpw7RIog8cSxp7CHVJMjWP7LmpAEq/AHP4u7M3aayV8GISwLFmgZl0G1do2c/GY5PWvVOw/+Hf
 FjJ+3oTk/QLw==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="284849664"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; d="scan'208";a="284849664"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2021 22:50:34 -0700
IronPort-SDR: JwxCby8GjlLqq08831+dJxFqvOpq93xdcW725vcuaLR5Ksvy/7B7iN6SFcCMpMqd0YfIFpC0Hm
 +ZZ7MRHWE4LA==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; d="scan'208";a="471020665"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2021 22:49:57 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH] soundwire: bandwidth allocation: improve error messages
Date: Tue, 11 May 2021 13:49:45 +0800
Message-Id: <20210511054945.29558-1-yung-chuan.liao@linux.intel.com>
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

In rare corner cases, we see an error with the log:

[  838.297840] soundwire sdw-master-1: Compute bus params failed: -22

That's not very useful, there can be two different error conditions
with the same -EINVAL code provided to the caller.

Let's add better dev_err() messages to figure out what went wrong.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/generic_bandwidth_allocation.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
index 84d129587084..f7c66083a4dd 100644
--- a/drivers/soundwire/generic_bandwidth_allocation.c
+++ b/drivers/soundwire/generic_bandwidth_allocation.c
@@ -382,12 +382,18 @@ static int sdw_compute_bus_params(struct sdw_bus *bus)
 		 */
 	}
 
-	if (i == clk_values)
+	if (i == clk_values) {
+		dev_err(bus->dev, "%s: could not find clock value for bandwidth %d\n",
+			__func__, bus->params.bandwidth);
 		return -EINVAL;
+	}
 
 	ret = sdw_select_row_col(bus, curr_dr_freq);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err(bus->dev, "%s: could not find frame configuration for bus dr_freq %d\n",
+			__func__, curr_dr_freq);
 		return -EINVAL;
+	}
 
 	bus->params.curr_dr_freq = curr_dr_freq;
 	return 0;
@@ -404,10 +410,8 @@ int sdw_compute_params(struct sdw_bus *bus)
 
 	/* Computes clock frequency, frame shape and frame frequency */
 	ret = sdw_compute_bus_params(bus);
-	if (ret < 0) {
-		dev_err(bus->dev, "Compute bus params failed: %d\n", ret);
+	if (ret < 0)
 		return ret;
-	}
 
 	/* Compute transport and port params */
 	ret = sdw_compute_port_params(bus);
-- 
2.17.1

