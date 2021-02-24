Return-Path: <SRS0=BjaJ=H2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB0BC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Feb 2021 01:31:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DEEF64E6F
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Feb 2021 01:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DEEF64E6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3D8D5822;
	Wed, 24 Feb 2021 02:30:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3D8D5822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614130286;
	bh=rsvD9eHAYeJihUFa2deZVZPuu8bBVJgaeM9f7kezj3c=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ga86TMP6B6juUOuLuzKX+KEOyh1EcyAqFwvfcjuHtBAbSOYSjYUyXTjlgTbABNYSs
	 5Fr08Kge9OWGjc9qdQarof+/pFnhGfRvuW7oFqV5RJTti3RkjQ2Wlris2CVe3K1IW5
	 VwuwBpOQok/kQ+J17VilfFduSrWpwANRY9NOcNsE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 86AF8F80169;
	Wed, 24 Feb 2021 02:30:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CBC15F8016A; Wed, 24 Feb 2021 02:29:19 +0100 (CET)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DBC25F80167
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2021 02:29:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DBC25F80167
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DldZM5G9Cz16950;
 Wed, 24 Feb 2021 09:27:23 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Wed, 24 Feb 2021 09:28:52 +0800
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Hulk Robot <hulkci@huawei.com>, Jaroslav Kysela <perex@perex.cz>,
 "Takashi Iwai" <tiwai@suse.com>, Lauri Kasanen <cand@gmx.com>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH -next] sound: n64: Fix return value check in n64audio_probe()
Date: Wed, 24 Feb 2021 01:38:03 +0000
Message-ID: <20210224013803.2146953-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Cc: alsa-devel@alsa-project.org, Wei Yongjun <weiyongjun1@huawei.com>,
 linux-kernel@vger.kernel.org
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

In case of error, the function devm_platform_ioremap_resource()
returns ERR_PTR() and never returns NULL. The NULL test in the
return value check should be replaced with IS_ERR().

Fixes: 1448f8acf4cc ("sound: Add n64 driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/mips/snd-n64.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/mips/snd-n64.c b/sound/mips/snd-n64.c
index ca6b4b99da98..e35e93157755 100644
--- a/sound/mips/snd-n64.c
+++ b/sound/mips/snd-n64.c
@@ -312,14 +312,14 @@ static int __init n64audio_probe(struct platform_device *pdev)
 	}
 
 	priv->mi_reg_base = devm_platform_ioremap_resource(pdev, 0);
-	if (!priv->mi_reg_base) {
-		err = -EINVAL;
+	if (IS_ERR(priv->mi_reg_base)) {
+		err = PTR_ERR(priv->mi_reg_base);
 		goto fail_dma_alloc;
 	}
 
 	priv->ai_reg_base = devm_platform_ioremap_resource(pdev, 1);
-	if (!priv->ai_reg_base) {
-		err = -EINVAL;
+	if (IS_ERR(priv->ai_reg_base)) {
+		err = PTR_ERR(priv->ai_reg_base);
 		goto fail_dma_alloc;
 	}
 

