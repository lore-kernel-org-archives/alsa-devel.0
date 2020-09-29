Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CE3C4727F
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:43:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0458207F7
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FYPDQn5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0458207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 12FE31783;
	Thu,  1 Oct 2020 15:42:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 12FE31783
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601559778;
	bh=5d/yoQrgtmRbA4pSy0Ped+OD8GfsWp3NXCuBaWeLCtw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FYPDQn5OSRSWKizXr/V8ojZk2GT3KMXT6U9rNoL8EfbGWpB2iyRe5AsZWUzdU6CnN
	 7XHZW37qEgfIYW8VmlaprFwLYSQYcgIZ9ZlQotNUrK/MoQ9MBp5j76bluOy1NWSohc
	 z/3VvatRQ48w5jmjsSF9x3cc6uG9rYDFf8sp1LNg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A550F802E2;
	Thu,  1 Oct 2020 15:40:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B681EF80273; Tue, 29 Sep 2020 13:29:55 +0200 (CEST)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A16BFF800DD
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2020 13:29:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A16BFF800DD
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id D3D948DCFE26822F7923;
 Tue, 29 Sep 2020 19:29:47 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Tue, 29 Sep 2020 19:29:41 +0800
From: Qinglang Miao <miaoqinglang@huawei.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Thierry
 Reding" <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH -next] ASoC: tegra: trimslice.c: use
 devm_snd_soc_register_card()
Date: Tue, 29 Sep 2020 19:29:39 +0800
Message-ID: <20200929112939.47661-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 01 Oct 2020 15:40:08 +0200
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Qinglang Miao <miaoqinglang@huawei.com>
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

Using devm_snd_soc_register_card() can make the code
shorter and cleaner.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 sound/soc/tegra/trimslice.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/sound/soc/tegra/trimslice.c b/sound/soc/tegra/trimslice.c
index cdb386d6e..baae4cce7 100644
--- a/sound/soc/tegra/trimslice.c
+++ b/sound/soc/tegra/trimslice.c
@@ -143,7 +143,7 @@ static int tegra_snd_trimslice_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = snd_soc_register_card(card);
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
 			ret);
@@ -153,15 +153,6 @@ static int tegra_snd_trimslice_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int tegra_snd_trimslice_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_card(card);
-
-	return 0;
-}
-
 static const struct of_device_id trimslice_of_match[] = {
 	{ .compatible = "nvidia,tegra-audio-trimslice", },
 	{},
@@ -174,7 +165,6 @@ static struct platform_driver tegra_snd_trimslice_driver = {
 		.of_match_table = trimslice_of_match,
 	},
 	.probe = tegra_snd_trimslice_probe,
-	.remove = tegra_snd_trimslice_remove,
 };
 module_platform_driver(tegra_snd_trimslice_driver);
 
-- 
2.23.0

