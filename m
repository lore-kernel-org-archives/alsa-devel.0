Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66001C27C7A
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Aug 2023 10:13:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C778AE9;
	Thu, 17 Aug 2023 12:12:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C778AE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692267179;
	bh=DkaU+2xc7pvdbNW6k+0jHoMw5bxGFoAD81sUUsF4v1g=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=VdZuEOgi1j4FpP1/FZ7mAOYkgfvlD0nc3RI27/4dJjoZcy8js4bGg7/sZl4CZsCCm
	 7Un+90F6TRltAHikJ80MnHLwt0egYgFsXSe6i6F2xCsKGhxHfVtO+QOYwdv/kkJvuO
	 jr4vhSSoITCvZH8cf064IaQKlmpMSwzfrA1MHrKg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8333AF805B2; Thu, 17 Aug 2023 12:10:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F2081F805AD;
	Thu, 17 Aug 2023 12:10:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DD3FEF8016D; Thu, 17 Aug 2023 11:38:33 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 922E2F80027
	for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2023 11:38:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 922E2F80027
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RRKbb4v6CzNn2P;
	Thu, 17 Aug 2023 17:34:51 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 17:38:23 +0800
From: Ruan Jinjie <ruanjinjie@huawei.com>
To: <alsa-devel@alsa-project.org>, <ivan.orlov0322@gmail.com>,
	<schnelle@linux.ibm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v2] ALSA: Make SND_PCMTEST depend on DEBUG_FS
Date: Thu, 17 Aug 2023 17:37:39 +0800
Message-ID: <20230817093740.1732738-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-MailFrom: ruanjinjie@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 2HRR3JVZ2DJV5PMDCMKT2Y6AHKDT6CKC
X-Message-ID-Hash: 2HRR3JVZ2DJV5PMDCMKT2Y6AHKDT6CKC
X-Mailman-Approved-At: Thu, 17 Aug 2023 10:10:25 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2HRR3JVZ2DJV5PMDCMKT2Y6AHKDT6CKC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Since pcmtest is a test module that manipulates or gets
notification via debugfs, without DEBUG_FS it can not work fine.
So make SND_PCMTEST depend on DEBUG_FS.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
v2:
- make it depend on DEBUG_FS instead of dropping error check.
---
 sound/drivers/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/drivers/Kconfig b/sound/drivers/Kconfig
index 41c171468c1e..6debd8e95cb7 100644
--- a/sound/drivers/Kconfig
+++ b/sound/drivers/Kconfig
@@ -111,6 +111,7 @@ config SND_ALOOP
 
 config SND_PCMTEST
 	tristate "Virtual PCM test driver"
+	depends on DEBUG_FS
 	select SND_PCM
 	help
 	  Say 'Y' or 'M' to include support for the Virtual PCM test driver.
-- 
2.34.1

