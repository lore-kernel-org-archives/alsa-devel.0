Return-Path: <SRS0=dMuI=H3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5502C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Feb 2021 11:32:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8263764F10
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Feb 2021 11:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8263764F10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D258616B6;
	Thu, 25 Feb 2021 12:31:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D258616B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614252720;
	bh=t/HegKaCY8iAKPJd71Ru1pLwLhXkVYwjQCS0OWq7C84=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IgV6to0+A64qe1pOcMjYTLm1FgjcxbkZ+pUosNvK1RZM8g4GI/E3pzD4L8HLV5y53
	 KNOnPeEFcFDE3U3SWkMaGVE6ZGjAFfMYlPCjzj3BiATm+1+r3ikbZKSlXs3lHaaJKs
	 heni+onueSslwsX+wV0/0FLeA7eBKo5r/WhLfFN0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B80DCF804F2;
	Thu, 25 Feb 2021 12:26:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7CF5BF8016C; Wed, 24 Feb 2021 09:54:42 +0100 (CET)
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
 (using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E18DEF800F2
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2021 09:54:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E18DEF800F2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=163.com header.i=@163.com
 header.b="J6ApnJxa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=cQIIy
 A026Smy/5bkFC5TNpl130WLwuskncZWiZurTAU=; b=J6ApnJxaW6KFXkLMiuQpp
 Lx+dg+uHP9LAn96qxIg9SqPA1eD1l5xMWEOiSDxGx58kd02xauCJIDPBbKFzVie2
 DLIJNJtYfgsv94hgobWKLGelRTvJ9qrZxgHBPlgwDC0fvj4H+lHZiiNRVj+Qn/yH
 1EoBcAD+K+w+Dp4hg8ZwpQ=
Received: from COOL-20201222LC.ccdomain.com (unknown [218.94.48.178])
 by smtp10 (Coremail) with SMTP id DsCowAA3xkJGFDZg3SRTmQ--.51774S2;
 Wed, 24 Feb 2021 16:54:31 +0800 (CST)
From: dingsenjie@163.com
To: perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
Subject: [PATCH] sound: soc/uniphier: Simplify the return expression of
 uniphier_aio_startup
Date: Wed, 24 Feb 2021 16:54:07 +0800
Message-Id: <20210224085407.22120-1-dingsenjie@163.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowAA3xkJGFDZg3SRTmQ--.51774S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw4UXrykCw4UJry8ZFyftFb_yoWfZFc_G3
 4Fvws8WFWjkr4YqrZFvws7Zr9xt3929w1DGw1aqrsxCr13Ar4rAw17CrZ3Gay8Wr4fJa4D
 uFs5KF47tFy2qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0DCztUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5glqw25hqmxvi6rwjhhfrp/1tbipQlDyFUMceCRMAACsM
X-Mailman-Approved-At: Thu, 25 Feb 2021 12:25:30 +0100
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 dingsenjie <dingsenjie@yulong.com>
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

From: dingsenjie <dingsenjie@yulong.com>

Simplify the return expression in the aio-cpu.c.

Signed-off-by: dingsenjie <dingsenjie@yulong.com>
---
 sound/soc/uniphier/aio-cpu.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/uniphier/aio-cpu.c b/sound/soc/uniphier/aio-cpu.c
index 25c40c2..cf98141 100644
--- a/sound/soc/uniphier/aio-cpu.c
+++ b/sound/soc/uniphier/aio-cpu.c
@@ -256,17 +256,12 @@ static int uniphier_aio_startup(struct snd_pcm_substream *substream,
 {
 	struct uniphier_aio *aio = uniphier_priv(dai);
 	struct uniphier_aio_sub *sub = &aio->sub[substream->stream];
-	int ret;
 
 	sub->substream = substream;
 	sub->pass_through = 0;
 	sub->use_mmap = true;
 
-	ret = aio_init(sub);
-	if (ret)
-		return ret;
-
-	return 0;
+	return aio_init(sub);
 }
 
 static void uniphier_aio_shutdown(struct snd_pcm_substream *substream,
-- 
1.9.1


