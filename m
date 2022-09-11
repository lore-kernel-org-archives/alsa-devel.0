Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F58ECAAA1
	for <alsa-devel@archiver.kernel.org>; Sun, 11 Sep 2022 09:35:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E1A2716B5;
	Sun, 11 Sep 2022 11:34:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E1A2716B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662888942;
	bh=4GKExmaL4LZPH4K34NcUQUitslKhTXB3EET1JX7DC5M=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BZ2VgUIK39mQB6d9i06qwX1DftF/WghgqmEcucdnV1Qen2lCWZ8r8H2FvhFgX4Txw
	 BnsM8y2F3YXCh1rmQLD8A3xn+FHHHiRD9JryvFosdoW9TwoIldI3NHPfjytladukge
	 +M8ceglULyPHozkCokzFUXBqc9xKH+y1sCUGz/GE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 783D4F80169;
	Sun, 11 Sep 2022 11:34:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 91C73F80256; Sun, 11 Sep 2022 11:34:51 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A865DF8011C
 for <alsa-devel@alsa-project.org>; Sun, 11 Sep 2022 11:34:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A865DF8011C
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MQPc64PgRzmVJ2;
 Sun, 11 Sep 2022 17:31:02 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 11 Sep 2022 17:34:43 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
 <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
 <cuigaosheng1@huawei.com>, <shreyas.nc@intel.com>
Subject: [PATCH] soundwire: cadence: remove unused sdw_cdns_master_ops
 declaration
Date: Sun, 11 Sep 2022 17:34:42 +0800
Message-ID: <20220911093442.3221637-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Cc: alsa-devel@alsa-project.org
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

sdw_cdns_master_ops has been removed since
commit c91605f48938 ("soundwire: Remove cdns_master_ops"),
so remove it.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/soundwire/cadence_master.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index ca9e805bab88..273eca3cb0b7 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -142,7 +142,6 @@ struct sdw_cdns {
 /* Exported symbols */
 
 int sdw_cdns_probe(struct sdw_cdns *cdns);
-extern struct sdw_master_ops sdw_cdns_master_ops;
 
 irqreturn_t sdw_cdns_irq(int irq, void *dev_id);
 irqreturn_t sdw_cdns_thread(int irq, void *dev_id);
-- 
2.25.1

