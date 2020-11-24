Return-Path: <SRS0=dVJd=E6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBEEC83023
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Nov 2020 13:28:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BFE32083E
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Nov 2020 13:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lEzg7hMx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BFE32083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2935816A2;
	Tue, 24 Nov 2020 14:27:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2935816A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606224522;
	bh=vZchKs6GJWa9i156tUhfvao3KvcaUC6jPEFeZ8EBDXQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lEzg7hMxPA2A92uk4Pq3bIH/p3n72cClTTP+jBNrv3xAVZHSDVrGfKz+pVex9SX+M
	 +UD89aZE8Hj6J2JRBhh78d2S6MTGr3PkKwlnGtHdzFHstXUZqZSHfHVTEi2UkO65Yy
	 wFh99DMJzYUQkDnULLqO6rvOunIIFhM9TrczKlWk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C0A51F804BD;
	Tue, 24 Nov 2020 14:26:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5F328F802C4; Tue, 24 Nov 2020 14:26:18 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8F60EF80165
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2020 14:26:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8F60EF80165
IronPort-SDR: SfWpRf+NWhwDW8vsL+/GuQEu0b6k0YK8UMqjAjDHWXls4l1GEJR3Y2IYeNUl5AosIuDZ1BvKxt
 TiYdDxuRjwNw==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="172039547"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; d="scan'208";a="172039547"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2020 05:26:06 -0800
IronPort-SDR: Z79BzXFxMMG9aF5DZvuzBcD+PMBJrwiMM724QUDfhkr9qZfLupN9lZPLLxScMMUuGddpYWwL/u
 Wxys2rA3CMYg==
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; d="scan'208";a="546830597"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2020 05:26:02 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 2/5] soundwire: bus: reset slave_notify status at each loop
Date: Tue, 24 Nov 2020 09:33:15 +0800
Message-Id: <20201124013318.8963-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201124013318.8963-1-yung-chuan.liao@linux.intel.com>
References: <20201124013318.8963-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
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

The code loops multiple times to deal with pending interrupts, but we
never reset the slave_notify status.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 45131b9f5080..d6e646521819 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1425,7 +1425,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 	u8 clear = 0, bit, port_status[15] = {0};
 	int port_num, stat, ret, count = 0;
 	unsigned long port;
-	bool slave_notify = false;
+	bool slave_notify;
 	u8 sdca_cascade = 0;
 	u8 buf, buf2[2], _buf, _buf2[2];
 	bool parity_check;
@@ -1467,6 +1467,8 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 	}
 
 	do {
+		slave_notify = false;
+
 		/*
 		 * Check parity, bus clash and Slave (impl defined)
 		 * interrupt
-- 
2.17.1

