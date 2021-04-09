Return-Path: <SRS0=zNzy=JG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A39C433ED
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 17:12:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8B65610CC
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 17:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B65610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C7AD1687;
	Fri,  9 Apr 2021 19:11:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C7AD1687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617988332;
	bh=mzlk7ovxLrgcWdMO5HvqgAurQwn7AcSAw2CgK+ksztc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ABvy1oHfwow13ssQW7VhEDveLSyx/siJ5CWEzwD/LqSu1DA1n9hrbe/laLpg26XgW
	 i/nejO+pMbca7no2m1FeeFQFz3Nin6KckudTr4wrOwUcOQpXqyDPtS7f8TGzjf47vN
	 TLebsxHnAHT0Hf/hOaXtyhic80E52/XISQ65eypw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B42A7F80475;
	Fri,  9 Apr 2021 19:09:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D62F8F8016A; Fri,  9 Apr 2021 13:03:10 +0200 (CEST)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3F995F80113
 for <alsa-devel@alsa-project.org>; Fri,  9 Apr 2021 13:02:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3F995F80113
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FGwCW5kDRz9xkg;
 Fri,  9 Apr 2021 19:00:39 +0800 (CST)
Received: from DESKTOP-EFRLNPK.china.huawei.com (10.174.176.196) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Fri, 9 Apr 2021 19:02:47 +0800
From: Qiheng Lin <linqiheng@huawei.com>
To: <linqiheng@huawei.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Philipp Zabel <p.zabel@pengutronix.de>, Kuninori Morimoto
 <kuninori.morimoto.gx@renesas.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] ASoC: sun4i-codec: remove redundant dev_err call in
 sun4i_codec_probe()
Date: Fri, 9 Apr 2021 19:02:46 +0800
Message-ID: <20210409110246.96-1-linqiheng@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.196]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Fri, 09 Apr 2021 19:09:35 +0200
Cc: Hulk Robot <hulkci@huawei.com>, alsa-devel@alsa-project.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
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

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
---
 sound/soc/sunxi/sun4i-codec.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 6c13cc84b3fb..00b73b7444b7 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -1706,10 +1706,8 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(base)) {
-		dev_err(&pdev->dev, "Failed to map the registers\n");
+	if (IS_ERR(base))
 		return PTR_ERR(base);
-	}
 
 	quirks = of_device_get_match_data(&pdev->dev);
 	if (quirks == NULL) {

