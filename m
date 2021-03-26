Return-Path: <SRS0=Z4e1=IY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB110C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 09:17:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A10E961A36
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 09:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10E961A36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 98B411669;
	Fri, 26 Mar 2021 10:16:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 98B411669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616750242;
	bh=YFxsKnElqnieosl3kL/Fkjbb5PzxGySe5CFgFQVPjgU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BxcUgXcTJiS37X8CXfiv/k4VaTRZszxTzAVxX7kujylbARYlP/qs2onaXk8t/Uz3u
	 O5vmSmy04xbmoMJv7pO4UyZELed1jxbqAED3oUKyVIAWpOB0PjVUa6l5n2v9SV9s4P
	 CqVS9MKE7uPi1u/ueOMaEWhde0giOLNL2pUFi970=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33597F801D5;
	Fri, 26 Mar 2021 10:15:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B045EF8032B; Fri, 26 Mar 2021 10:15:43 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F1FAEF80104
 for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2021 10:15:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1FAEF80104
IronPort-SDR: Z5EPilNoFHtMVdAaUIaE/DfELltJnAQyvFlSg4VzldCPPe9uGup4/bHSKj4Bb/kmiUFAyIfIAq
 Q8PvKw7SyMPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="276249423"
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; d="scan'208";a="276249423"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2021 02:15:29 -0700
IronPort-SDR: wakWu590u1fj/QX2ZX55eYBrOP/7Rg+7N9gtsePFygXwMEt+JRV6oTLkU/hWAy/T7kGi9Lq8gi
 HXxavQpwMh+g==
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; d="scan'208";a="416463097"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2021 02:15:27 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [RESEND PATCH 01/11] soundwire: bus: use correct driver name in error
 messages
Date: Fri, 26 Mar 2021 17:15:04 +0800
Message-Id: <20210326091514.20751-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210326091514.20751-1-yung-chuan.liao@linux.intel.com>
References: <20210326091514.20751-1-yung-chuan.liao@linux.intel.com>
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

None of the existing codec drivers set the sdw_driver.name, but
instead set sdw_driver.driver.name.

This leads to error messages such as
[   23.935355] rt700 sdw:2:25d:700:0: Probe of (null) failed: -19

We could remove this sdw_driver.name if it doesn't have any
purpose. This patch only suggests using the proper indirection.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus_type.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 575b9bad99d5..893296f3fe39 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -82,6 +82,7 @@ static int sdw_drv_probe(struct device *dev)
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
 	struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
 	const struct sdw_device_id *id;
+	const char *name;
 	int ret;
 
 	/*
@@ -108,7 +109,10 @@ static int sdw_drv_probe(struct device *dev)
 
 	ret = drv->probe(slave, id);
 	if (ret) {
-		dev_err(dev, "Probe of %s failed: %d\n", drv->name, ret);
+		name = drv->name;
+		if (!name)
+			name = drv->driver.name;
+		dev_err(dev, "Probe of %s failed: %d\n", name, ret);
 		dev_pm_domain_detach(dev, false);
 		return ret;
 	}
@@ -174,11 +178,16 @@ static void sdw_drv_shutdown(struct device *dev)
  */
 int __sdw_register_driver(struct sdw_driver *drv, struct module *owner)
 {
+	const char *name;
+
 	drv->driver.bus = &sdw_bus_type;
 
 	if (!drv->probe) {
-		pr_err("driver %s didn't provide SDW probe routine\n",
-		       drv->name);
+		name = drv->name;
+		if (!name)
+			name = drv->driver.name;
+
+		pr_err("driver %s didn't provide SDW probe routine\n", name);
 		return -EINVAL;
 	}
 
-- 
2.17.1

