Return-Path: <SRS0=wMTJ=I5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62974C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Mar 2021 01:16:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D1A2619CF
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Mar 2021 01:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D1A2619CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC3361683;
	Wed, 31 Mar 2021 03:15:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC3361683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617153360;
	bh=Mv5VxNBbhiqaEX55SDGkQkZWsxlvqA/DPd7cetwxQuA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i2CRXPyxxyhEAfQ0thJqRAwrCuGohelnCqaEKuHrkJqTPC/xpZuXFwrpt2WLas0ND
	 fllXE1T2xGn9bIq15jIFH/yD0N8iR6gHr3C2ZtthEWljowdDtnaUWzypTlb/VC5deF
	 42LB3vTUDKDr9cj+X5vEsCo/7vq0F+skcBYbAWvE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 514C1F8027D;
	Wed, 31 Mar 2021 03:14:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B11F6F8027D; Wed, 31 Mar 2021 03:14:24 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1D343F80141
 for <alsa-devel@alsa-project.org>; Wed, 31 Mar 2021 03:14:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D343F80141
IronPort-SDR: eD2+11JVUOq19lacGWAip20M4beGl0eNJCQZNnZcrQqv7sQ1qu3DhegyF/ld+qeA/kYV3z0c8u
 V9ZpiedmtV/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="191919208"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; d="scan'208";a="191919208"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2021 18:14:15 -0700
IronPort-SDR: NDDo1b2SD8xVgU/wPY6rVx9AvmSYbjDOmRcHed39T5hFHifFsfd//K2jaEgtL7AyV6Pz5LNHwK
 qLRv5k0RDuKA==
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; d="scan'208";a="418414702"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2021 18:14:11 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 1/2] soundwire: add macro to selectively change error levels
Date: Wed, 31 Mar 2021 09:13:54 +0800
Message-Id: <20210331011355.14313-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210331011355.14313-1-yung-chuan.liao@linux.intel.com>
References: <20210331011355.14313-1-yung-chuan.liao@linux.intel.com>
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

We sometimes discard -ENODATA when reporting errors and lose all
traces of issues in the console log, add a macro to add use dev_dbg()
in such cases.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 40354469860a..8370216f95d4 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -227,4 +227,12 @@ int sdw_bwrite_no_pm_unlocked(struct sdw_bus *bus, u16 dev_num, u32 addr, u8 val
 void sdw_clear_slave_status(struct sdw_bus *bus, u32 request);
 int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size);
 
+#define sdw_dev_dbg_or_err(dev, is_err, fmt, ...)			\
+	do {								\
+		if (is_err)						\
+			dev_err(dev, fmt, __VA_ARGS__);			\
+		else							\
+			dev_dbg(dev, fmt, __VA_ARGS__);			\
+	} while (0)
+
 #endif /* __SDW_BUS_H */
-- 
2.17.1

