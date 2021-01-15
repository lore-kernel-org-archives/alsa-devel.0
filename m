Return-Path: <SRS0=73/o=GS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02923C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jan 2021 05:40:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E9AF239EF
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jan 2021 05:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E9AF239EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E478017BE;
	Fri, 15 Jan 2021 06:39:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E478017BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610689232;
	bh=c16L2UmjxdNA3HdRbwCKje8jde+iaqRXKVWGaGH7gwc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oLF5JQZluOIxU53p7mt9kgrDNDmcZYuqioLXuogS9Nfa/+UA5XsxYkz53tDzRLG8v
	 EEsl23Wwinhd1ngzsTWg6REiP4lM2LfAYYuz7js6dWKqgkGUs7JTZsGB1PBkJFoo99
	 5p1j8q+Wv3yH5E4cF8anMOgivR1bxi2P6IyRxTuc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 89AA1F804D8;
	Fri, 15 Jan 2021 06:38:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 218B5F8026B; Fri, 15 Jan 2021 06:37:58 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EF02AF80132
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2021 06:37:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EF02AF80132
IronPort-SDR: +ObRv/2mcGUgoTaFpsWhSPNilo79+2+JBqBRvNSuYid/HT83ydsZ94K7RBB3i2bcpQTGsZje3A
 iqDwHB86+hWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="240046289"
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; d="scan'208";a="240046289"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2021 21:37:47 -0800
IronPort-SDR: ewqWG8xDgNFLSwPtAA30s5IyQgMGygfb2JfnHnzckq47SJB6bdlNFvsM1xcxCaZoRT/dqSH6jH
 9oedpshJ5RGw==
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; d="scan'208";a="382542456"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2021 21:37:44 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 3/5] soundwire: bus: add more details to track failed transfers
Date: Fri, 15 Jan 2021 13:37:36 +0800
Message-Id: <20210115053738.22630-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210115053738.22630-1-yung-chuan.liao@linux.intel.com>
References: <20210115053738.22630-1-yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 hui.wang@canonical.com, srinivas.kandagatla@linaro.org, jank@cadence.com,
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

The current error log does not provide details on the type of
transfers and which address/count was requested. All this information
can help locate in which parts of the configuration process an error
occurred.

Co-developed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 3cc006bfae71..6e1c988f3845 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -267,8 +267,10 @@ static int sdw_transfer_unlocked(struct sdw_bus *bus, struct sdw_msg *msg)
 
 	ret = do_transfer(bus, msg);
 	if (ret != 0 && ret != -ENODATA)
-		dev_err(bus->dev, "trf on Slave %d failed:%d\n",
-			msg->dev_num, ret);
+		dev_err(bus->dev, "trf on Slave %d failed:%d %s addr %x count %d\n",
+			msg->dev_num, ret,
+			(msg->flags & SDW_MSG_FLAG_WRITE) ? "write" : "read",
+			msg->addr, msg->len);
 
 	if (msg->page)
 		sdw_reset_page(bus, msg->dev_num);
-- 
2.17.1

