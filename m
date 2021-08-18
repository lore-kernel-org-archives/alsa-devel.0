Return-Path: <SRS0=kMQ4=NJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D838C4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 03:02:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 018FE60EFE
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 03:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 018FE60EFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4C280851;
	Wed, 18 Aug 2021 05:01:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4C280851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629255767;
	bh=08KVNrV2Gth35lB3r4eMrDt3FqiB6jmTHXktM8BJEZ4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IoyxT+LikzNm/2XR+IriYrYZql2Tqi8ZBO0PYLpBYQVWAlx4h0nIW1NT0M3GbBTbW
	 grZJUKXzw/aUgkTsJ35hL9Dw/xy22CGl2ePpynhzq1iBlwMz+mnSChoi+v4WpgzVE5
	 I/tV5Wq6DqIGLy3q0h9yQrzhhVLcjPwK+QmG4tRo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D648BF80246;
	Wed, 18 Aug 2021 05:01:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2A1D1F80249; Wed, 18 Aug 2021 05:01:55 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1176CF80163
 for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2021 05:01:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1176CF80163
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="213120366"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; d="scan'208";a="213120366"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2021 20:01:41 -0700
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; d="scan'208";a="462602171"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2021 20:01:38 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH] soundwire: cadence: do not extend reset delay
Date: Wed, 18 Aug 2021 11:01:30 +0800
Message-Id: <20210818030130.17113-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: vinod.koul@linaro.org, gregkh@linuxfoundation.org,
 pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
 sanyog.r.kale@intel.com, bard.liao@intel.com
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

The duration of the hw_reset is defined as 4096 cycles. The Cadence IP
allows for an additional delay which doesn't seem necessary in
practice: the actual reset sequence duration is defined by the sync_go
mechanism, not by the IP itself.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 0b7f037e6cd0..4fcc3ba93004 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1032,10 +1032,7 @@ EXPORT_SYMBOL(sdw_cdns_check_self_clearing_bits);
  */
 int sdw_cdns_exit_reset(struct sdw_cdns *cdns)
 {
-	/* program maximum length reset to be safe */
-	cdns_updatel(cdns, CDNS_MCP_CONTROL,
-		     CDNS_MCP_CONTROL_RST_DELAY,
-		     CDNS_MCP_CONTROL_RST_DELAY);
+	/* keep reset delay unchanged to 4096 cycles */
 
 	/* use hardware generated reset */
 	cdns_updatel(cdns, CDNS_MCP_CONTROL,
-- 
2.17.1

