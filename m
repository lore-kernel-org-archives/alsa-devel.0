Return-Path: <SRS0=SelE=A3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113EAC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 07:19:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A48E2067D
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 07:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ctVWNLvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A48E2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 015C4886;
	Thu, 16 Jul 2020 09:18:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 015C4886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594883942;
	bh=d9DH14uGU+40C2zCw10rjbLbIOuNFWLTIHm/2sRBDR4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ctVWNLvJU1TcQdx/ki2yjoJEVlQpi+uUhvpyO1iP61XsR9AZVOLh21kRpRBGRhtfB
	 ewp8iFVKEkuMX73LT0HfhvxCiHh8QQ9OFlDP7LAJa77ilNc2yypyHZm5qUx9D1E53s
	 eiGN5rdOSLL3f74ay3F3uJYSds1GOrRzUniqsmF8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 85A09F8016F;
	Thu, 16 Jul 2020 09:18:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 75258F8019B; Tue, 14 Jul 2020 10:05:57 +0200 (CEST)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9781EF80113
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2020 10:05:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9781EF80113
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 5F5CE3D63C8E597CD903;
 Tue, 14 Jul 2020 16:05:42 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Tue, 14 Jul 2020 16:05:31 +0800
From: Jing Xiangfeng <jingxiangfeng@huawei.com>
To: <cezary.rojewski@intel.com>, <pierre-louis.bossart@linux.intel.com>,
 <liam.r.girdwood@linux.intel.com>, <yang.jie@linux.intel.com>,
 <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
 <hdegoede@redhat.com>, <kuninori.morimoto.gx@renesas.com>,
 <paul@crapouillou.net>
Subject: [PATCH] ASoC: Intel: bytcht_es8316: Add missed put_device()
Date: Tue, 14 Jul 2020 16:09:18 +0800
Message-ID: <20200714080918.148196-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 16 Jul 2020 09:18:10 +0200
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 jingxiangfeng@huawei.com
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

snd_byt_cht_es8316_mc_probe() misses to call put_device() in an error
path. Add the missed function call to fix it.

Fixes: ba49cf6f8e4a ("ASoC: Intel: bytcht_es8316: Add quirk for inverted jack detect")
Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 sound/soc/intel/boards/bytcht_es8316.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 9e5fc9430628..ecbc58e8a37f 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -543,8 +543,10 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 
 	if (cnt) {
 		ret = device_add_properties(codec_dev, props);
-		if (ret)
+		if (ret) {
+			put_device(codec_dev);
 			return ret;
+		}
 	}
 
 	devm_acpi_dev_add_driver_gpios(codec_dev, byt_cht_es8316_gpios);
-- 
2.17.1

