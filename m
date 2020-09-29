Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDEEC4727F
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:43:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3199206FC
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JVomuTqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3199206FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5746918A6;
	Thu,  1 Oct 2020 15:42:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5746918A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601559822;
	bh=I/LOdq9n9dcrZFkzAAFLSxcgBn45eOXSMum2Wjem9DM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JVomuTqq49v5iO36oEFpq8Lhc1O4BbtcOqeJLSWwr2bn32FINzyjxFiowCLiAzRwu
	 DK+ZdKbPXP4hBYyhnWd7NW4T1163wEJP/f9AnnClU3IPj8Ha/e6iDXjwOqG1oPo/Hz
	 3VPmKOCeJSzP2vCCyLKA4m/Bkefy+4bhteU9TY5Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 04ACEF802E9;
	Thu,  1 Oct 2020 15:40:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2287AF800AB; Tue, 29 Sep 2020 13:29:55 +0200 (CEST)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8AC6EF800AB
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2020 13:29:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8AC6EF800AB
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 84D83840CDE957B3B0ED;
 Tue, 29 Sep 2020 19:29:41 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 29 Sep 2020 19:29:33 +0800
From: Qinglang Miao <miaoqinglang@huawei.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH -next] ASoC: fsl: mx27vis-aic32x4: use
 devm_snd_soc_register_card()
Date: Tue, 29 Sep 2020 19:29:32 +0800
Message-ID: <20200929112932.46926-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 01 Oct 2020 15:40:08 +0200
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

Using devm_snd_soc_register_card() can make the code
shorter and cleaner.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 sound/soc/fsl/mx27vis-aic32x4.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/sound/soc/fsl/mx27vis-aic32x4.c b/sound/soc/fsl/mx27vis-aic32x4.c
index 4ead537e0..8d3b18973 100644
--- a/sound/soc/fsl/mx27vis-aic32x4.c
+++ b/sound/soc/fsl/mx27vis-aic32x4.c
@@ -176,7 +176,7 @@ static int mx27vis_aic32x4_probe(struct platform_device *pdev)
 	mx27vis_amp_muter_gpio = pdata->amp_muter_gpio;
 
 	mx27vis_aic32x4.dev = &pdev->dev;
-	ret = snd_soc_register_card(&mx27vis_aic32x4);
+	ret = devm_snd_soc_register_card(&pdev->dev, &mx27vis_aic32x4);
 	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
 			ret);
@@ -199,19 +199,11 @@ static int mx27vis_aic32x4_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mx27vis_aic32x4_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_card(&mx27vis_aic32x4);
-
-	return 0;
-}
-
 static struct platform_driver mx27vis_aic32x4_audio_driver = {
 	.driver = {
 		.name = "mx27vis",
 	},
 	.probe = mx27vis_aic32x4_probe,
-	.remove = mx27vis_aic32x4_remove,
 };
 
 module_platform_driver(mx27vis_aic32x4_audio_driver);
-- 
2.23.0

