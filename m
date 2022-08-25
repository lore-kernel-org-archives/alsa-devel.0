Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F298EC04AA5
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Aug 2022 11:32:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE4B3827;
	Thu, 25 Aug 2022 13:31:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE4B3827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661427151;
	bh=z/MKl19DY8KR5aGgEb3Si8aFHMZO4AmrC7luLxODNeE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kz4OxHf9Pw7uyvJF69W3qgtnA2FqgJEv9aNZRpasqJT9urDu1FEjtqWYWc15FFfSA
	 OfThuNt4xH52Ucr0GlO2Y+Ft0IzXNXwZ0BkmIq+NPjk3db/642Exv8sfGfzSyHpxcD
	 9FLkVWEEc3Ps3ClPA/AlV0nEt3qVZAefvdTGWx/I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D65BDF804FD;
	Thu, 25 Aug 2022 13:31:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AB5FFF8025A; Thu, 25 Aug 2022 03:25:08 +0200 (CEST)
Received: from mail.nfschina.com (unknown
 [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
 by alsa1.perex.cz (Postfix) with ESMTP id 5375EF800BD
 for <alsa-devel@alsa-project.org>; Thu, 25 Aug 2022 03:25:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5375EF800BD
Received: from localhost (unknown [127.0.0.1])
 by mail.nfschina.com (Postfix) with ESMTP id 05B451E80C99;
 Thu, 25 Aug 2022 09:20:55 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
 by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9CIsm4tv8qoT; Thu, 25 Aug 2022 09:20:52 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
 (Authenticated sender: yuzhe@nfschina.com)
 by mail.nfschina.com (Postfix) with ESMTPA id BB6CD1E80C8D;
 Thu, 25 Aug 2022 09:20:51 +0800 (CST)
From: Yu Zhe <yuzhe@nfschina.com>
To: daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
 perex@perex.cz, tiwai@suse.com
Subject: [PATCH] ARM: pxa: pxa2xx-ac97-lib: fix tests for platform_get_irq()
 failure
Date: Thu, 25 Aug 2022 09:24:02 +0800
Message-Id: <20220825012402.10259-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Mailman-Approved-At: Thu, 25 Aug 2022 13:31:12 +0200
Cc: liqiong@nfschina.com, Yu Zhe <yuzhe@nfschina.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
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

The platform_get_irq() returns negative error codes.  It can't actually
return zero.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 sound/arm/pxa2xx-ac97-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index e55c0421718b..1f4c4749a6fb 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -402,7 +402,7 @@ int pxa2xx_ac97_hw_probe(struct platform_device *dev)
 		goto err_clk2;
 
 	irq = platform_get_irq(dev, 0);
-	if (!irq)
+	if (irq < 0)
 		goto err_irq;
 
 	ret = request_irq(irq, pxa2xx_ac97_irq, 0, "AC97", NULL);
-- 
2.11.0

