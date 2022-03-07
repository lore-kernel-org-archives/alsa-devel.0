Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA8EC433F5
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Mar 2022 07:44:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B60691705;
	Mon,  7 Mar 2022 08:43:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B60691705
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646639052;
	bh=QQN2j9tMMOvw3T1kbXEjJwZKlF6GXtBW9ks8KtnFlB0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=D2ElUq5A71xoud0Q5Nl14+AstYxa+YVxszam3FwblaqsNI2wBRqQLpnPxnWBMJiSB
	 mTRsftV2PzHZLveGlM59OLhqfbIcs7cM4nfl8BPYIjFnLaLeaSvSCe3HLH4xWVDS17
	 Yj/Jd5ZZQiJbpXh8oWav7CcXGa0tKmAvynz0AMy8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 44E37F80132;
	Mon,  7 Mar 2022 08:43:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 45188F8013F; Mon,  7 Mar 2022 08:43:20 +0100 (CET)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 55DFEF800E9
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2022 08:43:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 55DFEF800E9
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.54])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KBr0w6cvxz1GC3Z;
 Mon,  7 Mar 2022 15:38:24 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 7 Mar
 2022 15:43:10 +0800
From: Wang Wensheng <wangwensheng4@huawei.com>
To: <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
 <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
 <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] soundwire: stream: Fix error return code in
 do_bank_switch()
Date: Mon, 7 Mar 2022 07:40:39 +0000
Message-ID: <20220307074039.117488-1-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
Cc: xuqiang36@huawei.com
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

Fix to return a negative error code from the error handling case instead
of 0, as done elsewhere in this function.

Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
---
 drivers/soundwire/stream.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 980f26d49b66..553131597af6 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -822,6 +822,7 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
 		} else if (multi_link) {
 			dev_err(bus->dev,
 				"Post bank switch ops not implemented\n");
+			ret = -EINVAL;
 			goto error;
 		}
 
-- 
2.17.1

