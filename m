Return-Path: <SRS0=nkEL=LG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5F0C48BCF
	for <alsa-devel@archiver.kernel.org>; Sat, 12 Jun 2021 03:36:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31FDD61108
	for <alsa-devel@archiver.kernel.org>; Sat, 12 Jun 2021 03:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31FDD61108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F0A601AB3;
	Sat, 12 Jun 2021 05:35:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F0A601AB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623468974;
	bh=JoUoA6g8FGPsqf2WoxAUUMJYkOrzdwQyt5o4XCvXaWY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WOpXP6CsovqG9d4fbLF2j1Z07JhdKwGaH98p4ixMPURYyb30/dlN6dvJCY1maOI4u
	 aOVdayzNCoFK4iA1ARujliNsPLL+FgSeK4lHHKzbMx1SB4X3cu4TGWKQjPf/X01G6p
	 zeNRf5vIf2aKwFQUW6v4IUQfJ5u0M/YEV9a4VvFc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 86581F8020D;
	Sat, 12 Jun 2021 05:35:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0BBBFF80218; Sat, 12 Jun 2021 05:35:21 +0200 (CEST)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8A820F80149
 for <alsa-devel@alsa-project.org>; Sat, 12 Jun 2021 05:35:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8A820F80149
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G23BC4HCjz1BLdg;
 Sat, 12 Jun 2021 11:30:11 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 12 Jun 2021 11:35:02 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 12
 Jun 2021 11:35:02 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <perex@perex.cz>, <tiwai@suse.com>
Subject: [PATCH -next] ALSA: trident: Fix build error
Date: Sat, 12 Jun 2021 11:34:58 +0800
Message-ID: <20210612033458.42928-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema769-chm.china.huawei.com (10.1.198.211)
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

sound/pci/trident/trident_memory.c: In function ‘set_tlb_bus’:
sound/pci/trident/trident_memory.c:85:35: error: ‘pagetr’ undeclared (first use in this function); did you mean ‘page’?
  for (i = 0; i < UNIT_PAGES; i++, pagetr++) {
                                   ^~~~~~
                                   page

Fixes: 74fb98311c4e ("ALSA: trident: Drop shadow TLB pointer table")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/pci/trident/trident_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/trident/trident_memory.c b/sound/pci/trident/trident_memory.c
index f831ec02702f..4ad3855101c9 100644
--- a/sound/pci/trident/trident_memory.c
+++ b/sound/pci/trident/trident_memory.c
@@ -82,7 +82,7 @@ static inline void set_tlb_bus(struct snd_trident *trident, int page,
 {
 	int i;
 	page *= UNIT_PAGES;
-	for (i = 0; i < UNIT_PAGES; i++, pagetr++) {
+	for (i = 0; i < UNIT_PAGES; i++, page++) {
 		__set_tlb_bus(trident, page, addr);
 		addr += SNDRV_TRIDENT_PAGE_SIZE;
 	}
-- 
2.17.1

