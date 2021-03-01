Return-Path: <SRS0=WtzT=H7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B269CC433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 17:49:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D39964F56
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 17:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D39964F56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B725D16A0;
	Mon,  1 Mar 2021 18:48:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B725D16A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614620969;
	bh=xDnWmsPB7eNkquy/dMopWBFnoDfFVV9JpIadZW3dQ6Y=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SDdFO8pQaGGzg8wdNC8JrhktVixVIjA9yOD1Jx0OdwY4rnjnJ163E7bwsMmpcbcoy
	 aW2UppwI225yPnfjX5t47wkqXRZ8CLuU+Lbu/p30ztxDxu+Kj8pGSbDkRrEPxKVdqr
	 i4JUpxfVxgmBNmhHn/pUPzHwQiuRNNz5hzBEjkU4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D67C4F80482;
	Mon,  1 Mar 2021 18:47:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E2222F8049C; Mon,  1 Mar 2021 18:47:27 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 24015F80431
 for <alsa-devel@alsa-project.org>; Mon,  1 Mar 2021 18:47:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 24015F80431
IronPort-SDR: YlLVDhud2RAQi+cmqiWmM2O5mIIQ2zj9GWEbL0FGncriRT8ClS9pN41gqGj59GRTgYP8i90q87
 YdFf099xctkg==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="186598121"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; d="scan'208";a="186598121"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 09:47:23 -0800
IronPort-SDR: WICg7SInxXqGc6GeO2aaqo9X8Q/9IuQhopX2ZmY5ajJc9VQgCoYDX6EkxqTjRSe5NmCrEgVu21
 obytjI+Dq2mQ==
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; d="scan'208";a="434363295"
Received: from mhuang8-mobl3.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.25.220])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 09:47:22 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2] soundwire: cadence_master: fix kernel-doc
Date: Mon,  1 Mar 2021 11:47:14 -0600
Message-Id: <20210301174714.117172-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, vkoul@kernel.org, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

v5.12-rc1 flags new warnings with make W=1, fix missing or broken
function descriptors.

drivers/soundwire/cadence_master.c:914: warning: expecting prototype
for To update slave status in a work since we will need to
handle(). Prototype was for cdns_update_slave_status_work() instead

drivers/soundwire/cadence_master.c:976: warning: expecting prototype
for sdw_cdns_enable_slave_interrupt(). Prototype was for
cdns_enable_slave_interrupts() instead

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index d05442e646a3..e5c3f304b8f6 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -905,7 +905,7 @@ irqreturn_t sdw_cdns_irq(int irq, void *dev_id)
 EXPORT_SYMBOL(sdw_cdns_irq);
 
 /**
- * To update slave status in a work since we will need to handle
+ * cdns_update_slave_status_work - update slave status in a work since we will need to handle
  * other interrupts eg. CDNS_MCP_INT_RX_WL during the update slave
  * process.
  * @work: cdns worker thread
@@ -968,7 +968,7 @@ int sdw_cdns_exit_reset(struct sdw_cdns *cdns)
 EXPORT_SYMBOL(sdw_cdns_exit_reset);
 
 /**
- * sdw_cdns_enable_slave_interrupt() - Enable SDW slave interrupts
+ * cdns_enable_slave_interrupts() - Enable SDW slave interrupts
  * @cdns: Cadence instance
  * @state: boolean for true/false
  */
-- 
2.25.1

