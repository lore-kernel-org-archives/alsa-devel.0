Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC65FA3744
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Oct 2022 13:44:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 173471670;
	Mon, 31 Oct 2022 14:44:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 173471670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667223893;
	bh=hyneCm479zd0bR4fv3bx7EGLU12t+6Ed6Njv3CjifdA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WrExMSt2cTVsRU7ZLKOzstla/uD/Sb3uFUJbWNY87ro8SMtNetwCZa0uBfIkp1LSi
	 AYIM+t/g0o81JNTCCs7QyIvCxZBwBCqM2hC1jhn638EfR31257XocuRokKr9gnX7RB
	 WbZKlC+f/jqM4Xl2qbDMolL/yQDbFNP2ts2ogRLc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A6D42F8015B;
	Mon, 31 Oct 2022 14:44:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F2A78F80163; Mon, 31 Oct 2022 14:44:01 +0100 (CET)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D22ACF800E1
 for <alsa-devel@alsa-project.org>; Mon, 31 Oct 2022 14:43:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D22ACF800E1
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N1DrQ0R0JzHvVP;
 Mon, 31 Oct 2022 21:43:34 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 21:43:51 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 21:43:51 +0800
From: Chen Zhongjin <chenzhongjin@huawei.com>
To: <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
Subject: [PATCH] ASoC: soc-utils: Remove __exit for snd_soc_util_exit()
Date: Mon, 31 Oct 2022 21:40:31 +0800
Message-ID: <20221031134031.256511-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
Cc: tiwai@suse.com, broonie@kernel.org, chenzhongjin@huawei.com,
 lgirdwood@gmail.com
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

snd_soc_util_exit() is called in __init snd_soc_init() for cleanup.
Remove the __exit annotation for it to fix the build warning:

WARNING: modpost: sound/soc/snd-soc-core.o: section mismatch in reference: init_module (section: .init.text) -> snd_soc_util_exit (section: .exit.text)

Fixes: 6ec27c53886c ("ASoC: core: Fix use-after-free in snd_soc_exit()")
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 sound/soc/soc-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index a3b6df2378b4..a4dba0b751e7 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -264,7 +264,7 @@ int __init snd_soc_util_init(void)
 	return ret;
 }
 
-void __exit snd_soc_util_exit(void)
+void snd_soc_util_exit(void)
 {
 	platform_driver_unregister(&soc_dummy_driver);
 	platform_device_unregister(soc_dummy_dev);
-- 
2.17.1

