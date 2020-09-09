Return-Path: <SRS0=lIjM=CS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5973C433E2
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:59:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3F8421D7F
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bXkad/q+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F8421D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A50416D3;
	Wed,  9 Sep 2020 15:58:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A50416D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599659953;
	bh=Z0H5Hi0FFAc4DYYdhT+B7VAvXfyMGbm+vI5QzAbWAH4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bXkad/q+Z9x1w75UZrsigKdMLFdr6VejHA9TMx05Q0H4kw0PBV/ifuIoBxlalQi/e
	 yaSby4xDy3YI0lhERFVwmCbqGPGoQdh4DkAE3ceC1QyMe7XtXaZ+vmFrkpOrczME0q
	 r8QC1RNekbkOxJDAi7xiHn9UVr5PJKB8faAUvYhk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 22A19F8021C;
	Wed,  9 Sep 2020 15:58:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9F843F80256; Wed,  9 Sep 2020 15:58:20 +0200 (CEST)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3594DF800E9
 for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2020 15:58:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3594DF800E9
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 94AA83FBFB2294DE67E2;
 Wed,  9 Sep 2020 21:58:05 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 21:57:58 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <perex@perex.cz>, <tiwai@suse.com>, <yuehaibing@huawei.com>
Subject: [PATCH 04/19] ALSA: pcm: Remove unused inline function snd_mask_sizeof
Date: Wed, 9 Sep 2020 21:57:44 +0800
Message-ID: <20200909135744.33464-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

There is no caller in tree, so can remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/sound/pcm_params.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/sound/pcm_params.h b/include/sound/pcm_params.h
index 36f94735d23d..ba184f49f7e1 100644
--- a/include/sound/pcm_params.h
+++ b/include/sound/pcm_params.h
@@ -23,11 +23,6 @@ int snd_pcm_hw_param_value(const struct snd_pcm_hw_params *params,
 #define MASK_OFS(i)	((i) >> 5)
 #define MASK_BIT(i)	(1U << ((i) & 31))
 
-static inline size_t snd_mask_sizeof(void)
-{
-	return sizeof(struct snd_mask);
-}
-
 static inline void snd_mask_none(struct snd_mask *mask)
 {
 	memset(mask, 0, sizeof(*mask));
-- 
2.17.1


