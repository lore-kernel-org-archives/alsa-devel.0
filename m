Return-Path: <SRS0=dfEF=IF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15889C433DB
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Mar 2021 07:24:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFD8065015
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Mar 2021 07:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD8065015
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6A55F1F54;
	Sun,  7 Mar 2021 08:23:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6A55F1F54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615101844;
	bh=wlIsYJ6DnnbnWx/V7XZjrUBtkHTUlUeQI2w/oBDgh2I=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MOMzfdw/MEz4mt6fMelTdJgKajVBJDvNVr+ytNV8XL2vkzoR57oyF0lYeUxke9BzK
	 2yn0Y3QvqxbfKXzjyKJNMKUBc0T8QvkeopEv68L1eKDGbXXcZMazvl4yil93nzZAxn
	 OqHBlj1XyBcimBQ7Wax+Zo7MLLFYdvNySNNOawO4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 97356F8019B;
	Sun,  7 Mar 2021 08:23:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DEDE6F80227; Sun,  7 Mar 2021 08:23:11 +0100 (CET)
Received: from cmccmta3.chinamobile.com (cmccmta3.chinamobile.com
 [221.176.66.81])
 by alsa1.perex.cz (Postfix) with ESMTP id 47F67F800ED
 for <alsa-devel@alsa-project.org>; Sun,  7 Mar 2021 08:23:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 47F67F800ED
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by
 rmmx-syy-dmz-app12-12012 (RichMail) with SMTP id 2eec60447f32d35-f005c;
 Sun, 07 Mar 2021 15:22:26 +0800 (CST)
X-RM-TRANSID: 2eec60447f32d35-f005c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.0.144.162])
 by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee960447f2e720-83653;
 Sun, 07 Mar 2021 15:22:26 +0800 (CST)
X-RM-TRANSID: 2ee960447f2e720-83653
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: broonie@kernel.org, paul@crapouillou.net, lgirdwood@gmail.com,
 perex@perex.cz
Subject: [PATCH] ASoC: codecs/jz4770: Remove superfluous error message
Date: Sun,  7 Mar 2021 15:21:33 +0800
Message-Id: <20210307072133.10832-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
 linux-kernel@vger.kernel.org, Tang Bin <tangbin@cmss.chinamobile.com>
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

The function devm_platform_ioremap_resource has already contained
error message if failed, so remove superfluous dev_err here.

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/codecs/jz4770.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/jz4770.c b/sound/soc/codecs/jz4770.c
index 298689a07..5a24471a5 100644
--- a/sound/soc/codecs/jz4770.c
+++ b/sound/soc/codecs/jz4770.c
@@ -900,11 +900,8 @@ static int jz4770_codec_probe(struct platform_device *pdev)
 	codec->dev = dev;
 
 	codec->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(codec->base)) {
-		ret = PTR_ERR(codec->base);
-		dev_err(dev, "Failed to ioremap mmio memory: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(codec->base))
+		return PTR_ERR(codec->base);
 
 	codec->regmap = devm_regmap_init(dev, NULL, codec,
 					&jz4770_codec_regmap_config);
-- 
2.20.1.windows.1



