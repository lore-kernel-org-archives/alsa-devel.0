Return-Path: <SRS0=PPjj=MG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9D2C07E95
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jul 2021 01:43:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26F4461360
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jul 2021 01:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F4461360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 311761690;
	Wed, 14 Jul 2021 03:42:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 311761690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626227015;
	bh=RvRu5zehQkKQfBEsnQ46TMGajM2cQv4gVwGtAr0AMNs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FDFbg8MYn/DdN2O8W1wI5ipB5LzbjgeKzmG7MIi4lT/2PX7RWmiaBvb/uGVs2Uob/
	 VpJaq+8SHXDfg7ve2y6shsucFJOHQ1uilawjYvnZ9schM4ulKcfCzSWeGsph4R5O0D
	 ziH9wGNAEtCmueHqicRz4aL/m8h9X57o3dK4xZqo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A5CDEF8020C;
	Wed, 14 Jul 2021 03:42:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5CA11F80217; Wed, 14 Jul 2021 03:42:43 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1B367F800ED
 for <alsa-devel@alsa-project.org>; Wed, 14 Jul 2021 03:42:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1B367F800ED
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="197455083"
X-IronPort-AV: E=Sophos;i="5.84,237,1620716400"; d="scan'208";a="197455083"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2021 18:42:20 -0700
X-IronPort-AV: E=Sophos;i="5.84,237,1620716400"; d="scan'208";a="459796564"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2021 18:42:17 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH] soundwire: bus: filter out more -EDATA errors on clock stop
Date: Wed, 14 Jul 2021 09:42:09 +0800
Message-Id: <20210714014209.17357-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: vinod.koul@linaro.org, gregkh@linuxfoundation.org,
 pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
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

We've added quite a few filters to avoid throwing errors if a Device
does not respond to commands during the clock stop sequences, but we
missed one.

This will lead to an isolated message
[ 6115.294412] soundwire sdw-master-1: SDW_SCP_STAT bread failed:-61

The callers already filter this error code, so there's no point in
keeping it at the lower level.

Since this is a recoverable error, make this dev_err() conditional and
only log cases with Command Failed.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 3e6d4addac2f..278a4fbdb88d 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -896,7 +896,8 @@ static int sdw_bus_wait_for_clk_prep_deprep(struct sdw_bus *bus, u16 dev_num)
 	do {
 		val = sdw_bread_no_pm(bus, dev_num, SDW_SCP_STAT);
 		if (val < 0) {
-			dev_err(bus->dev, "SDW_SCP_STAT bread failed:%d\n", val);
+			if (val != -ENODATA)
+				dev_err(bus->dev, "SDW_SCP_STAT bread failed:%d\n", val);
 			return val;
 		}
 		val &= SDW_SCP_STAT_CLK_STP_NF;
-- 
2.17.1

