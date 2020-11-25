Return-Path: <SRS0=zi5T=E7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D01CC5519F
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Nov 2020 06:47:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A46E420708
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Nov 2020 06:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WcWARB9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A46E420708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 113A41710;
	Wed, 25 Nov 2020 07:46:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 113A41710
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606286842;
	bh=mRqHZOQEeYtIMjxy/buEM7vxirHzoTybe8DB10o9lAE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WcWARB9RsrkEh3VavJu16c3PuObdF+oQaBixe4bjgeKfVzLtHtqg313vgbCtFJA5O
	 l690+n5TgVSPyt1+DAo4lHHH3RRLF19fFXHLsv5TeseqNCviUkdcTxd1r1Qwca7thM
	 eH01QNWBGnVaekTleGPrqi8Rh/Bdn2Kq7nwSs1Yg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 80664F8015F;
	Wed, 25 Nov 2020 07:46:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CA292F8019D; Wed, 25 Nov 2020 07:46:29 +0100 (CET)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E8213F8015A
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2020 07:46:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8213F8015A
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cgrxs0FjzzkfbD;
 Wed, 25 Nov 2020 14:45:53 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Wed, 25 Nov 2020 14:46:12 +0800
From: Qinglang Miao <miaoqinglang@huawei.com>
To: Vinod Koul <vkoul@kernel.org>, Bard Liao
 <yung-chuan.liao@linux.intel.com>, Pierre-Louis Bossart
 <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH] soundwire: Fix error return code in sdw_compute_port_params
Date: Wed, 25 Nov 2020 14:50:35 +0800
Message-ID: <20201125065035.154262-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Qinglang
 Miao <miaoqinglang@huawei.com>
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

Fix to return the error code -EINVAL in sdw_compute_port_params
instead of 0.

Fixes: 9026118f20e2 ("soundwire: Add generic bandwidth allocation algorithm")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/soundwire/generic_bandwidth_allocation.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
index 0bdef38c9..ad857ac62 100644
--- a/drivers/soundwire/generic_bandwidth_allocation.c
+++ b/drivers/soundwire/generic_bandwidth_allocation.c
@@ -283,8 +283,10 @@ static int sdw_compute_port_params(struct sdw_bus *bus)
 	if (ret < 0)
 		return ret;
 
-	if (group.count == 0)
+	if (group.count == 0) {
+		ret = -EINVAL;
 		goto out;
+	}
 
 	params = kcalloc(group.count, sizeof(*params), GFP_KERNEL);
 	if (!params) {
-- 
2.23.0

