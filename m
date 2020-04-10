Return-Path: <SRS0=EEmF=52=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3265CC2BA2B
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Apr 2020 11:58:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C7820769
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Apr 2020 11:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="J2yu/bZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C7820769
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 05DB2168F;
	Fri, 10 Apr 2020 13:57:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 05DB2168F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586519906;
	bh=3+MUY16Q8r1g3puIbcqUwYtJ4P6gFu58YrxQJhMb0SI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=J2yu/bZ92G+L+cRYPvY7ZCSJeovokcCSVi8UGfsFHae5QIX3B/mWtnjffY1wJlg93
	 UIXvGornNsaA/RahC53p9BgsR3OoebKSKvhAqHPphrDg0VX2lKmaNRIlJ/muJwcJg6
	 K0+E6QhMWlWm+R59D3plABUaCfaIkZGYNaOaUaJg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 862C5F800CB;
	Fri, 10 Apr 2020 13:57:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 27675F80143; Fri, 10 Apr 2020 13:57:34 +0200 (CEST)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9FC98F800CB
 for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2020 13:57:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9FC98F800CB
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 85BE7B3CD520036BAC6B;
 Fri, 10 Apr 2020 19:57:23 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Fri, 10 Apr 2020
 19:57:17 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <vkoul@kernel.org>, <sanyog.r.kale@intel.com>,
 <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH -next] soundwire: intel: Make sdw_intel_init static
Date: Fri, 10 Apr 2020 19:57:08 +0800
Message-ID: <20200410115708.27708-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Cc: alsa-devel@alsa-project.org, YueHaibing <yuehaibing@huawei.com>,
 linux-kernel@vger.kernel.org
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

Fix sparse warning:

drivers/soundwire/intel_init.c:193:6: warning:
 symbol 'sdw_intel_init' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/soundwire/intel_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 4b769409f6f8..ad7053463889 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -190,7 +190,8 @@ static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
  * This scans the namespace and creates SoundWire link controller devices
  * based on the info queried.
  */
-void *sdw_intel_init(acpi_handle *parent_handle, struct sdw_intel_res *res)
+static void *sdw_intel_init(acpi_handle *parent_handle,
+			    struct sdw_intel_res *res)
 {
 	acpi_status status;
 
-- 
2.17.1


