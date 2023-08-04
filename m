Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8467C001DB
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Aug 2023 08:58:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5AB787F4;
	Fri,  4 Aug 2023 10:57:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5AB787F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691139500;
	bh=C5+FWrng63sIPJa8OZgcxEExYnM/Z7qsx3WnIsX6ACU=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=jr4TZwqgN0KoyhkCwTef3o0siCJKIHdRb1MbQwTEicVbidi35pwQtap3vUty526bt
	 2VoiXQ3GOEJ69FxetIsNA1Ysv8s7rdS2ATdnMy7EgdIKFPi849Y6MawSbgUsLxobwz
	 D7jIUB6Pq3DX04HAGwq0ZbIVC74W1L5hCP3PjqRE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 129F2F802BE; Fri,  4 Aug 2023 10:57:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BF085F802BE;
	Fri,  4 Aug 2023 10:57:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 455CEF8025A; Fri,  4 Aug 2023 10:56:59 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8BCD5F8016D
	for <alsa-devel@alsa-project.org>; Fri,  4 Aug 2023 10:56:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8BCD5F8016D
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RHKHl51byztRrS;
	Fri,  4 Aug 2023 16:53:23 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 16:56:47 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 16:56:46 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <alsa-devel@alsa-project.org>
CC: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
	<tiwai@suse.com>, <yangyingliang@huawei.com>
Subject: [PATCH -next] ASoC: ti: davinci-evm: simplify the code with
 module_platform_driver
Date: Fri, 4 Aug 2023 16:54:02 +0800
Message-ID: <20230804085402.1328033-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Message-ID-Hash: 3NFSXNJYVYO224GQGDX7NKY3RPHARX32
X-Message-ID-Hash: 3NFSXNJYVYO224GQGDX7NKY3RPHARX32
X-MailFrom: yangyingliang@huawei.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3NFSXNJYVYO224GQGDX7NKY3RPHARX32/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The init/exit() of driver only calls platform_driver_register/unregister,
it can be simpilfied with module_platform_driver.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/soc/ti/davinci-evm.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/sound/soc/ti/davinci-evm.c b/sound/soc/ti/davinci-evm.c
index 983d69b951b0..544cb3da50eb 100644
--- a/sound/soc/ti/davinci-evm.c
+++ b/sound/soc/ti/davinci-evm.c
@@ -257,18 +257,7 @@ static struct platform_driver davinci_evm_driver = {
 	},
 };
 
-static int __init evm_init(void)
-{
-	return platform_driver_register(&davinci_evm_driver);
-}
-
-static void __exit evm_exit(void)
-{
-	platform_driver_unregister(&davinci_evm_driver);
-}
-
-module_init(evm_init);
-module_exit(evm_exit);
+module_platform_driver(davinci_evm_driver);
 
 MODULE_AUTHOR("Vladimir Barinov");
 MODULE_DESCRIPTION("TI DAVINCI EVM ASoC driver");
-- 
2.25.1

