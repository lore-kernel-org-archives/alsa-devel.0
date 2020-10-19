Return-Path: <SRS0=H+KG=D4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6778DC388F9
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Oct 2020 13:46:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73E492065C
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Oct 2020 13:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WJlWGBxl";
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="RpMfgr0m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E492065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=126.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DA8501790;
	Wed, 21 Oct 2020 15:45:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DA8501790
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603288002;
	bh=QZ+zX+EfCnbLLfe0lKvEERnB7MS9f8BNIUZF7+C/uDI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WJlWGBxl7ZPocoVH1XdK3V1JmzNsuJsDs9dCshVr/EXKCpzkJpDIU6iWx51p1YBi3
	 //rK6A9TgB3mpZbeu5lrOtOm6d/3/h9Jn+iq0jTI8og95t/GI19xzCj2M7squhtrSq
	 apL8Nyq88q7dXKcnBcLopAnAxoRll8uYzVJ6XcWo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 870C3F80539;
	Wed, 21 Oct 2020 15:37:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5F3E4F80247; Mon, 19 Oct 2020 14:32:05 +0200 (CEST)
Received: from m15111.mail.126.com (m15111.mail.126.com [220.181.15.111])
 (using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AB8AAF800AD
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2020 14:31:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB8AAF800AD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=126.com header.i=@126.com
 header.b="RpMfgr0m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=hLfIQIHuyLNmd+qchF
 0iMkyztO/7yUc2IbZTbVRiJyI=; b=RpMfgr0mJqGp+g+dat3z/td2OnhOXL6w2a
 plj+lFyWuj1vTLz68O5JaQ3HyvmKoVJhANV2n3uKssPo3lFlD+lwpLNedIsU/cga
 2i032g+is2b2e0XijgprS4/4Xvw1mSF8o64RMYoW1SBUespGHQvKd08m84GejoQg
 UpXTxu3Xs=
Received: from localhost.localdomain (unknown [36.112.86.14])
 by smtp1 (Coremail) with SMTP id C8mowACHgx00h41fyctCKg--.6S2;
 Mon, 19 Oct 2020 20:31:53 +0800 (CST)
From: Defang Bo <bodefang@126.com>
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 Vishnuvardhanrao.Ravulapati@amd.com
Subject: [PATCH] ASoC: amd: move the call to devm_kzalloc below
 platform_get_resource()
Date: Mon, 19 Oct 2020 20:31:29 +0800
Message-Id: <1603110689-5015-1-git-send-email-bodefang@126.com>
X-Mailer: git-send-email 1.9.1
X-CM-TRANSID: C8mowACHgx00h41fyctCKg--.6S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrtFW7try7tr13WryxAr48tFb_yoW8JrW3p3
 93KFZxtrWrJrWUZ3y8GF48ZF1Ygry29a1UKrs8Z3y3Za45GrWkKFs7JFy0kFWSyFWvka1x
 XryDta1FvFn0qrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bFPEfUUUUU=
X-Originating-IP: [36.112.86.14]
X-CM-SenderInfo: pergvwxdqjqiyswou0bp/1tbitBDC11pEBvHlDgAAsz
X-Mailman-Approved-At: Wed, 21 Oct 2020 15:37:33 +0200
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Defang Bo <bodefang@126.com>, akshu.agrawal@amd.com
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

Just as the commit <4cb79ef9c6c4>("ASoC: amd: Fix potential NULL pointer dereference"),it makes no sense to allocate any resources if res = platform_get_resource(pdev, IORESOURCE_MEM, 0); fails,so move the call to devm_kzalloc() below the mentioned code.

Signed-off-by: Defang Bo <bodefang@126.com>
---
 sound/soc/amd/raven/acp3x-i2s.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-i2s.c b/sound/soc/amd/raven/acp3x-i2s.c
index a532e01..c9c69eb 100644
--- a/sound/soc/amd/raven/acp3x-i2s.c
+++ b/sound/soc/amd/raven/acp3x-i2s.c
@@ -302,16 +302,14 @@ static int acp3x_dai_probe(struct platform_device *pdev)
 	struct i2s_dev_data *adata;
 	int ret;
 
-	adata = devm_kzalloc(&pdev->dev, sizeof(struct i2s_dev_data),
-			GFP_KERNEL);
-	if (!adata)
-		return -ENOMEM;
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
 		return -ENOMEM;
 	}
+	adata = devm_kzalloc(&pdev->dev, sizeof(struct i2s_dev_data), GFP_KERNEL);
+	if (!adata)
+		return -ENOMEM;
 	adata->acp3x_base = devm_ioremap(&pdev->dev, res->start,
 						resource_size(res));
 	if (!adata->acp3x_base)
-- 
1.9.1

