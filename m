Return-Path: <SRS0=YLi8=6B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F876C2BB55
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Apr 2020 08:53:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 074582076D
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Apr 2020 08:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FIwIV9jx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 074582076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4EB821677;
	Fri, 17 Apr 2020 10:52:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4EB821677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587113593;
	bh=2QFm0Wo20Rfh/JkTada04gufI50ZQO+dO5ytWRgWt+k=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FIwIV9jxOgvQsoklcSOM7AgEN6iOmGrXkQO73iuN0l+TlUWcmqZPWoVlRatGVKKWT
	 6srgFQ2MSmboqj71nR9wojgxGsYzrqzcFY3mP+h2LeboK1vcPtQCrBGI6Iy8xxc3iI
	 Pee/xuKkrM4K4cowLK0OSBEHK2Pz8IyyiJZlSYZg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D23AF8028B;
	Fri, 17 Apr 2020 10:50:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C7110F80266; Fri, 17 Apr 2020 10:50:44 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 219A0F800DE
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2020 10:50:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 219A0F800DE
IronPort-SDR: d8ZTupZpqDT+nHPzUKkZrC8Lj5DDCxfiXcOQi5WR175hkh3+TFY5SSnNf7L/S6dMwI0UTFngM3
 Xjw40d4P+xaw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2020 01:50:36 -0700
IronPort-SDR: gfOsYFLTybkPRyrNv0LcZc8ObkXbC0NWu4yG6cCK6Ebtn8V7eHtEW5UAm9rxoSnlPAClz8FHCk
 xZMHp0/p72Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,394,1580803200"; d="scan'208";a="454661457"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by fmsmga005.fm.intel.com with ESMTP; 17 Apr 2020 01:50:32 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [RFC 2/5] soundwire: master: use device node pointer from master
 device
Date: Fri, 17 Apr 2020 04:55:21 +0800
Message-Id: <20200416205524.2043-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416205524.2043-1-yung-chuan.liao@linux.intel.com>
References: <20200416205524.2043-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
 slawomir.blauciak@intel.com, sanyog.r.kale@intel.com,
 rander.wang@linux.intel.com
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

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

device_node pointer is required for scanning slave devices, update
it from the master device.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soundwire/master.c b/drivers/soundwire/master.c
index 094518817601..c930c871caae 100644
--- a/drivers/soundwire/master.c
+++ b/drivers/soundwire/master.c
@@ -49,6 +49,7 @@ struct sdw_master_device
 	md->link_ops = link_ops;
 
 	md->dev.parent = parent;
+	md->dev.of_node = parent->of_node;
 	md->dev.fwnode = fwnode;
 	md->dev.bus = &sdw_bus_type;
 	md->dev.type = &sdw_master_type;
-- 
2.17.1

