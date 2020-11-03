Return-Path: <SRS0=G+7e=EJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D59C388F2
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 10:07:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F60C2224E
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 10:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AM58XDMD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JKSjzwr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F60C2224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D1FD21753;
	Tue,  3 Nov 2020 11:06:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D1FD21753
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604398022;
	bh=CpIQVbUPn7Qa9HKtqlGnFT7rJ7XYZdsaF2CbmGkma88=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AM58XDMD3kV2DQHFKppgrrfE6/bx7wJ55fraEucZrtGxJAoxI5TNqGjSJB3R48MZe
	 aBpeve09wYsc8OGU5jEsmHSbdUep+L8/lemBKQQ93AmgluzDMQ5C6WOmaGFGTZlk8/
	 A5303ZSpZuCwzteizB9JhwwR/sUI1eD02iXdcDbU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5FBFBF80083;
	Tue,  3 Nov 2020 11:06:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A965DF80171; Tue,  3 Nov 2020 11:06:11 +0100 (CET)
Received: from esa6.microchip.iphmx.com (esa6.microchip.iphmx.com
 [216.71.154.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 54708F80083
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2020 11:06:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 54708F80083
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.b="JKSjzwr6"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1604397965; x=1635933965;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=CpIQVbUPn7Qa9HKtqlGnFT7rJ7XYZdsaF2CbmGkma88=;
 b=JKSjzwr6umKozoxKdUPowF7IgR09tTPyEZbHEFedmNIWpUbGtPk8sEPQ
 k2Y9c/KQ1kGJwOwyJu1F4Drex5p2I+7SsQalRhxWozNo4Z6nJXbVzVIbg
 Osw0ZOyUl+hfWLeMCnQ+bap6HeoSKHAmXFwrUxZynfVOeW1osu0r8kDcx
 5fYgcAbMkvo4/6xGrYQJEpJgNrH4nxmD3ExHCiLhM+Ml/lozdKQNjHQrv
 LKZXwbadixs8NM8Xy3NJMBw5IuKcMsm2puOIIXyqSi8JATGo1kyyEF525
 U1cWl0+Dj4107m1HB1WXjbWZNlL1uq0OpuG8gDQipYCt3GOC5FcgXwlZE A==;
IronPort-SDR: vBlDUkTh34wc9Her5awDtIWlmIwQafxmUGuBMbNkIBXVq8t7Y9uVUulw53W0wcGPdJQM5ezvOt
 UmOCaFVxuOS18gbczcel9/SYdu0uqIxzxkIfmtKqTep6dJEuZooQI08M9ppkybrzgiaoUKzCLd
 yDg2SzWGergQwN5mtSI9yOCaqZvUD0afiiFvwJkANprOCuiiZqKOTeQ6NZ0TLNEuzlKszJS4mN
 G9n5jlZq7RUBBWMmaHPKVTuETCkF3sc8aNQGcUsDsUFOCKDMn/ZESA22LwanzcTtljjIfogmUJ
 apA=
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; d="scan'208";a="32192205"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256;
 03 Nov 2020 03:06:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 3 Nov 2020 03:06:00 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 3 Nov 2020 03:05:57 -0700
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To: <alsa-devel@alsa-project.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: atmel-i2s: do not warn if muxclk is missing
Date: Tue, 3 Nov 2020 12:05:54 +0200
Message-ID: <20201103100554.1307190-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Cc: alexandre.belloni@bootlin.com, lgirdwood@gmail.com,
 nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
 broonie@kernel.org, Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
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

Besides the fact that muxclk is optional, muxclk can be set using
assigned-clocks, removing the need to set it in driver. The warning is
thus unneeded, so we can transform it in a debug print, eventually to just
reflect that muxclk was not set by the driver.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/atmel/atmel-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/atmel-i2s.c b/sound/soc/atmel/atmel-i2s.c
index bbe2b638abb5..232300dda548 100644
--- a/sound/soc/atmel/atmel-i2s.c
+++ b/sound/soc/atmel/atmel-i2s.c
@@ -563,8 +563,8 @@ static int atmel_i2s_sama5d2_mck_init(struct atmel_i2s_dev *dev,
 		err = PTR_ERR(muxclk);
 		if (err == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
-		dev_warn(dev->dev,
-			 "failed to get the I2S clock control: %d\n", err);
+		dev_dbg(dev->dev,
+			"failed to get the I2S clock control: %d\n", err);
 		return 0;
 	}
 
-- 
2.25.1

