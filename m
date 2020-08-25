Return-Path: <SRS0=PqWm=CF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29BFC433E1
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Aug 2020 16:54:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F352087C
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Aug 2020 16:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mU3TQo3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F352087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BAE081810;
	Thu, 27 Aug 2020 18:53:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BAE081810
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598547252;
	bh=hx8iWLP9YF8BHlvBzI0REp4X1ABP9RmmCuS3vQnKqGU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mU3TQo3eLMZXfbmWJIC91v6HZcT2DaUuUnGhhTrAOMou0GSglVyWRgS0r+V7bVKQs
	 NGTgQtPe7hslpnEqMABOqdoBmlLhQWvEo6mS2yyMgXtWqHHuQ5Gv2ZBFrNGB9gh6H6
	 38zrzaEsn8zJ7GND2SlluDkGfHe8tGqxgulcB1yY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 13783F802DD;
	Thu, 27 Aug 2020 18:50:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 518DEF8025A; Tue, 25 Aug 2020 15:03:03 +0200 (CEST)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C2D5DF80143
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2020 15:02:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C2D5DF80143
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id AEB24C7A2EAAA29B03A7;
 Tue, 25 Aug 2020 21:02:52 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Tue, 25 Aug 2020
 21:02:44 +0800
From: Yu Kuai <yukuai3@huawei.com>
To: <timur@kernel.org>, <nicoleotsuka@gmail.com>, <Xiubo.Lee@gmail.com>,
 <festevam@gmail.com>, <shengjiu.wang@gmail.com>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
 <shawnguo@kernel.org>, <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
 <linux-imx@nxp.com>, <xobs@kosagi.com>
Subject: [PATCH V2] ASoC: fsl: imx-es8328: add missing put_device() call in
 imx_es8328_probe()
Date: Tue, 25 Aug 2020 21:02:24 +0800
Message-ID: <20200825130224.1488694-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 27 Aug 2020 18:50:46 +0200
Cc: alsa-devel@alsa-project.org, yi.zhang@huawei.com,
 linux-kernel@vger.kernel.org, yukuai3@huawei.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
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

if of_find_device_by_node() succeed, imx_es8328_probe() doesn't have
a corresponding put_device(). Thus add a jump target to fix the exception
handling for this function implementation.

Fixes: 7e7292dba215 ("ASoC: fsl: add imx-es8328 machine driver")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
Changes from V1:
 - remove the first patch in patch series

 sound/soc/fsl/imx-es8328.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/imx-es8328.c b/sound/soc/fsl/imx-es8328.c
index 15a27a2cd0ca..fad1eb6253d5 100644
--- a/sound/soc/fsl/imx-es8328.c
+++ b/sound/soc/fsl/imx-es8328.c
@@ -145,13 +145,13 @@ static int imx_es8328_probe(struct platform_device *pdev)
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data) {
 		ret = -ENOMEM;
-		goto fail;
+		goto put_device;
 	}
 
 	comp = devm_kzalloc(dev, 3 * sizeof(*comp), GFP_KERNEL);
 	if (!comp) {
 		ret = -ENOMEM;
-		goto fail;
+		goto put_device;
 	}
 
 	data->dev = dev;
@@ -182,12 +182,12 @@ static int imx_es8328_probe(struct platform_device *pdev)
 	ret = snd_soc_of_parse_card_name(&data->card, "model");
 	if (ret) {
 		dev_err(dev, "Unable to parse card name\n");
-		goto fail;
+		goto put_device;
 	}
 	ret = snd_soc_of_parse_audio_routing(&data->card, "audio-routing");
 	if (ret) {
 		dev_err(dev, "Unable to parse routing: %d\n", ret);
-		goto fail;
+		goto put_device;
 	}
 	data->card.num_links = 1;
 	data->card.owner = THIS_MODULE;
@@ -196,10 +196,12 @@ static int imx_es8328_probe(struct platform_device *pdev)
 	ret = snd_soc_register_card(&data->card);
 	if (ret) {
 		dev_err(dev, "Unable to register: %d\n", ret);
-		goto fail;
+		goto put_device;
 	}
 
 	platform_set_drvdata(pdev, data);
+put_device:
+	put_device(&ssi_pdev->dev);
 fail:
 	of_node_put(ssi_np);
 	of_node_put(codec_np);
-- 
2.25.4

