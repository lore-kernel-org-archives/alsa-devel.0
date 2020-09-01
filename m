Return-Path: <SRS0=rI3+=CL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B25DC433E2
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 03:05:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F5F42068F
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 03:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EpeAlaU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5F42068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 429BF1822;
	Wed,  2 Sep 2020 05:04:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 429BF1822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599015941;
	bh=/dy4tdvCGnmLLYHQLy4G0MUhTDmnkguIgY/xz1iAeVA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EpeAlaU8Vsk8SPHPPY9GGaT+tne+e+5zhFQwK7QIxyZWznLTotu+lHB7/KzURIwNL
	 ni8tdYCNptweEAunUBCvGkLMcd1JbydTh/BbZY7pOwssA6kPaUkO2kQ2ga3xUUWlIU
	 iPUMwhvG7RFMT7VU39gRQlAAm2AWpzYd/vdr/hH4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E9C4DF80322;
	Wed,  2 Sep 2020 05:00:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 99B75F80276; Wed,  2 Sep 2020 05:00:10 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 04003F802A1
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2020 05:00:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04003F802A1
IronPort-SDR: oMB+WyGEzolALD/5IRoZ0k3UwfPSoREiwFuFTocpqQ26Dq4hPMrfPlCqf1Q92tWIeFwiLvhRvD
 mum04GVbOVHw==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="156570768"
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; d="scan'208";a="156570768"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2020 20:00:03 -0700
IronPort-SDR: GREZdfE6O4YCP5rqbgSo15xy0SFNXBT+oegSmZVc14nhs5xx+NvL9DvqEZgPp6nhd5ZgSKT/1t
 /aHnvi/8Fodg==
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; d="scan'208";a="283588154"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2020 19:59:59 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v2 06/10] soundwire: intel: add multi-link hw_synchronization
 information
Date: Tue,  1 Sep 2020 23:05:52 +0800
Message-Id: <20200901150556.19432-7-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901150556.19432-1-yung-chuan.liao@linux.intel.com>
References: <20200901150556.19432-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
 sanyog.r.kale@intel.com, rander.wang@linux.intel.com, bard.liao@intel.com
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

set the flags as required by hardware implementation

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 8634d33c388c..272826973426 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1400,7 +1400,14 @@ int intel_master_startup(struct platform_device *pdev)
 		dev_dbg(dev, "Multi-link is disabled\n");
 		bus->multi_link = false;
 	} else {
+		/*
+		 * hardware-based synchronization is required regardless
+		 * of the number of segments used by a stream: SSP-based
+		 * synchronization is gated by gsync when the multi-master
+		 * mode is set.
+		 */
 		bus->multi_link = true;
+		bus->hw_sync_min_links = 1;
 	}
 
 	/* Initialize shim, controller */
-- 
2.17.1

