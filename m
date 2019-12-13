Return-Path: <SRS0=T7nt=2D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EEEC43603
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Dec 2019 05:07:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4AD6214D8
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Dec 2019 05:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XewF3yYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4AD6214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 175831731;
	Fri, 13 Dec 2019 06:06:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 175831731
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576213667;
	bh=BKojAhxYEX8ONMVmtZleAQzTDDBV0NFaVwmO8Fp9QhA=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XewF3yYxRowlF/lbEUtxPEGwT5UXerIrG/vW/IT1vHPCsM7DdhF1VgIBvY5ZkGgS5
	 pJ2YmrckXkEELaTNyZ07ZY4syHiFfITBoUM7ALQ7vtrSlbKcSqn203CntCyVH0pX7j
	 m5nwC0r9VRmEQt5d951dGzfw5wjkObnTo6d3iQXU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2636CF8025E;
	Fri, 13 Dec 2019 06:04:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74D52F8023F; Fri, 13 Dec 2019 06:04:36 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D6DE9F8021D
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2019 06:04:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6DE9F8021D
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Dec 2019 21:04:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,308,1571727600"; d="scan'208";a="208340703"
Received: from vbagrodi-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.130.70])
 by orsmga008.jf.intel.com with ESMTP; 12 Dec 2019 21:04:20 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Thu, 12 Dec 2019 23:03:58 -0600
Message-Id: <20191213050409.12776-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213050409.12776-1-pierre-louis.bossart@linux.intel.com>
References: <20191213050409.12776-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: [alsa-devel] [PATCH v4 04/15] soundwire: bus_type: rename sdw_drv_
	to sdw_slave_drv
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

Before we add master driver support, make sure there is no ambiguity
and no occurrences of sdw_drv_ functions.

No functionality change.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus_type.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 2b2830b622fa..9a0fd3ee1014 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -67,7 +67,7 @@ struct bus_type sdw_bus_type = {
 };
 EXPORT_SYMBOL_GPL(sdw_bus_type);
 
-static int sdw_drv_probe(struct device *dev)
+static int sdw_slave_drv_probe(struct device *dev)
 {
 	struct sdw_slave *slave = to_sdw_slave_device(dev);
 	struct sdw_driver *drv = to_sdw_slave_driver(dev->driver);
@@ -113,7 +113,7 @@ static int sdw_drv_probe(struct device *dev)
 	return 0;
 }
 
-static int sdw_drv_remove(struct device *dev)
+static int sdw_slave_drv_remove(struct device *dev)
 {
 	struct sdw_slave *slave = to_sdw_slave_device(dev);
 	struct sdw_driver *drv = to_sdw_slave_driver(dev->driver);
@@ -127,7 +127,7 @@ static int sdw_drv_remove(struct device *dev)
 	return ret;
 }
 
-static void sdw_drv_shutdown(struct device *dev)
+static void sdw_slave_drv_shutdown(struct device *dev)
 {
 	struct sdw_slave *slave = to_sdw_slave_device(dev);
 	struct sdw_driver *drv = to_sdw_slave_driver(dev->driver);
@@ -155,13 +155,13 @@ int __sdw_register_slave_driver(struct sdw_driver *drv,
 	}
 
 	drv->driver.owner = owner;
-	drv->driver.probe = sdw_drv_probe;
+	drv->driver.probe = sdw_slave_drv_probe;
 
 	if (drv->remove)
-		drv->driver.remove = sdw_drv_remove;
+		drv->driver.remove = sdw_slave_drv_remove;
 
 	if (drv->shutdown)
-		drv->driver.shutdown = sdw_drv_shutdown;
+		drv->driver.shutdown = sdw_slave_drv_shutdown;
 
 	return driver_register(&drv->driver);
 }
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
