Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEB0C4727F
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:45:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B37FB206FC
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QLSE0ajn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B37FB206FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 495C718C9;
	Thu,  1 Oct 2020 15:44:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 495C718C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601559928;
	bh=uim+/G+9qxLETm9LsUIncFj6SUdCGpnVJJECPQweDI8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QLSE0ajnwMdym+bOf7ocv9E3SjBG74QyxjZ6rThv38VVgnohO8qC6fp1/5cBX4zob
	 TDg95sOP0qI0cju4QL66xCTdhUKh205+TaBuG8SoaRoSz92Zo4Gc40DRGWetOPe1lj
	 cWmy7IEiA7E+2tmqswiNxNuqPPfIKs3W5iUUNKuc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 131EAF80308;
	Thu,  1 Oct 2020 15:40:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A34EDF800AB; Tue, 29 Sep 2020 13:30:01 +0200 (CEST)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F1008F801F5
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2020 13:29:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1008F801F5
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 5097DC68BBB112D265BD;
 Tue, 29 Sep 2020 19:29:43 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Tue, 29 Sep 2020 19:29:32 +0800
From: Qinglang Miao <miaoqinglang@huawei.com>
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 "Shengjiu Wang" <shengjiu.wang@gmail.com>, Liam Girdwood
 <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH -next] ASoC: fsl: imx-mc13783: use devm_snd_soc_register_card()
Date: Tue, 29 Sep 2020 19:29:30 +0800
Message-ID: <20200929112930.46848-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 01 Oct 2020 15:40:08 +0200
Cc: alsa-devel@alsa-project.org, Qinglang Miao <miaoqinglang@huawei.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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
 sound/soc/fsl/imx-mc13783.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/sound/soc/fsl/imx-mc13783.c b/sound/soc/fsl/imx-mc13783.c
index dd9c1ac81..d9dca7bbc 100644
--- a/sound/soc/fsl/imx-mc13783.c
+++ b/sound/soc/fsl/imx-mc13783.c
@@ -96,7 +96,7 @@ static int imx_mc13783_probe(struct platform_device *pdev)
 
 	imx_mc13783.dev = &pdev->dev;
 
-	ret = snd_soc_register_card(&imx_mc13783);
+	ret = devm_snd_soc_register_card(&pdev->dev, &imx_mc13783);
 	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
 			ret);
@@ -140,19 +140,11 @@ static int imx_mc13783_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int imx_mc13783_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_card(&imx_mc13783);
-
-	return 0;
-}
-
 static struct platform_driver imx_mc13783_audio_driver = {
 	.driver = {
 		.name = "imx_mc13783",
 	},
 	.probe = imx_mc13783_probe,
-	.remove = imx_mc13783_remove
 };
 
 module_platform_driver(imx_mc13783_audio_driver);
-- 
2.23.0

