Return-Path: <SRS0=iUFt=IV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A0FC433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Mar 2021 01:01:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7E96619A8
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Mar 2021 01:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E96619A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20251166A;
	Tue, 23 Mar 2021 02:00:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20251166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616461261;
	bh=LncX7slZWpXuYPbwgVAskAneN+Y+f3M+sicUeqO/OMY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DCHEABcd+1P3MuBxMV3xhoF5hamN8JaFdWXOcYU7H1UIDwr9qBlSbhao505Fc49j5
	 FsZxhw/DIw+dfxoczlZ3jeCeO11Em7/fLyFHnY6m64fR1CIw/T61WrHMhkI1QW9UXR
	 tFAjqbdVBb4zqd6garN98gFiaxxhoc1Y3fUQGIR4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0FD2DF80259;
	Tue, 23 Mar 2021 01:59:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E160FF8028D; Tue, 23 Mar 2021 01:59:19 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7E523F80107
 for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2021 01:59:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7E523F80107
IronPort-SDR: 1Zg/1iaktZ4NYFTJVBYzacJYDXMppSYeKjeRSwBXKTTNTclEIUDWRj7bFsVSwIebH64B+hzIoR
 XbysYZrfSO0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="275477948"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; d="scan'208";a="275477948"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2021 17:59:12 -0700
IronPort-SDR: sRu60T7p7qXveA0sE8lUKGVPJidnBMHfWbq7Sy41RVxRT9rRuwU5CWysHVNcZdoZgGk/sg+plu
 pIcGZBFS1TmA==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; d="scan'208";a="414728338"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2021 17:59:09 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 2/5] soundwire: bandwidth_allocation: add missing \n in
 dev_err()
Date: Tue, 23 Mar 2021 08:58:52 +0800
Message-Id: <20210323005855.20890-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210323005855.20890-1-yung-chuan.liao@linux.intel.com>
References: <20210323005855.20890-1-yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 hui.wang@canonical.com, srinivas.kandagatla@linaro.org,
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

We fixed a lot of warnings in 2019 but the magic of copy-paste keeps
adding new ones...

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/generic_bandwidth_allocation.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
index 0bdef38c9a30..a9abb9722fde 100644
--- a/drivers/soundwire/generic_bandwidth_allocation.c
+++ b/drivers/soundwire/generic_bandwidth_allocation.c
@@ -406,14 +406,14 @@ int sdw_compute_params(struct sdw_bus *bus)
 	/* Computes clock frequency, frame shape and frame frequency */
 	ret = sdw_compute_bus_params(bus);
 	if (ret < 0) {
-		dev_err(bus->dev, "Compute bus params failed: %d", ret);
+		dev_err(bus->dev, "Compute bus params failed: %d\n", ret);
 		return ret;
 	}
 
 	/* Compute transport and port params */
 	ret = sdw_compute_port_params(bus);
 	if (ret < 0) {
-		dev_err(bus->dev, "Compute transport params failed: %d", ret);
+		dev_err(bus->dev, "Compute transport params failed: %d\n", ret);
 		return ret;
 	}
 
-- 
2.17.1

