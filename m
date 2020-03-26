Return-Path: <SRS0=OLeW=5L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B33C2D0E5
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:12:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44D8C2078E
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TUIskfZq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D8C2078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 106C91671;
	Thu, 26 Mar 2020 22:11:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 106C91671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585257122;
	bh=kiCTf67dJUfKE+yJMo6AvC6ZAtIwGP1bH4oKmeoGg/E=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TUIskfZq1odHD1eB4gu+6jP2LEUONPLRe+HlnDiYp/auXv+qrVbUWOXl/EuD/A4YS
	 d3TB7ShxU0GvAvd3hFW8vCB614Kye60gONqLXFnmhRKZgCjIpPFoHjxWwxZKPcl6KG
	 MnrA+ce0BBQf98Ju0QAPiJ54VxiCSonqTdaTQa0Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 24EE9F80273;
	Thu, 26 Mar 2020 22:10:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AB188F80249; Thu, 26 Mar 2020 22:10:15 +0100 (CET)
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by alsa1.perex.cz (Postfix) with ESMTP id C0C10F8011B
 for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2020 22:10:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C0C10F8011B
Received: from localhost (p54B3331F.dip0.t-ipconnect.de [84.179.51.31])
 by pokefinder.org (Postfix) with ESMTPSA id 686792C1F8F;
 Thu, 26 Mar 2020 22:10:12 +0100 (CET)
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Subject: [PATCH 1/1] ASoC: pxa: magician: convert to use
 i2c_new_client_device()
Date: Thu, 26 Mar 2020 22:10:10 +0100
Message-Id: <20200326211010.13471-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326211010.13471-1-wsa+renesas@sang-engineering.com>
References: <20200326211010.13471-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
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

Move away from the deprecated API and return the shiny new ERRPTR where
useful.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 sound/soc/pxa/magician.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index 6483cff5b73d..3bafd86bfb93 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -358,10 +358,10 @@ static int __init magician_init(void)
 	adapter = i2c_get_adapter(0);
 	if (!adapter)
 		return -ENODEV;
-	client = i2c_new_device(adapter, i2c_board_info);
+	client = i2c_new_client_device(adapter, i2c_board_info);
 	i2c_put_adapter(adapter);
-	if (!client)
-		return -ENODEV;
+	if (IS_ERR(client))
+		return PTR_ERR(client);
 
 	ret = gpio_request(EGPIO_MAGICIAN_SPK_POWER, "SPK_POWER");
 	if (ret)
-- 
2.20.1

