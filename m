Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E14EC433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 09:13:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 728CB61494
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 09:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728CB61494
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C371116B5;
	Tue,  2 Mar 2021 10:12:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C371116B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614676413;
	bh=YFxsKnElqnieosl3kL/Fkjbb5PzxGySe5CFgFQVPjgU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OqY646WTgarrgmaA5orS+kpCW7IthzVoNS8N9VI1zjypmHwquxW0HLXaTshvFtuUQ
	 0L6SM2bcIGw6zssnDbqvrChYHmFgSx0+kmW6PK7P0QgTtJ6L50G+OLHhOI9HTeIzw5
	 osD0r/Yuf2b5kd1C1fDffEiTUOwW9Y5iPZUPBXnI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 99985F80423;
	Tue,  2 Mar 2021 10:11:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 816B6F802E2; Tue,  2 Mar 2021 10:11:51 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1F0D0F80269
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 10:11:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1F0D0F80269
IronPort-SDR: qAAZedjSllzvud8lqPOmBT//wKF/S7ExitndNYr0glHZVU0CPsplXl9Ou34UaLIlxDCd0qSQH3
 69v1UMqz3jrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="248158706"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="248158706"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 01:11:34 -0800
IronPort-SDR: 0A1PZdvjVwV5tBhQwN40D5HWYo8Gge6sMoj+GtyFoOX25+n/1yQ25IAvqKzIj2hUS1c2/E/Mze
 8xRAPOcY/2vQ==
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="506262258"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 01:11:32 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de
Subject: [PATCH 01/11] soundwire: bus: use correct driver name in error
 messages
Date: Tue,  2 Mar 2021 17:11:12 +0800
Message-Id: <20210302091122.13952-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210302091122.13952-1-yung-chuan.liao@linux.intel.com>
References: <20210302091122.13952-1-yung-chuan.liao@linux.intel.com>
Cc: vkoul@kernel.org, alsa-devel@alsa-project.org,
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
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

