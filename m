Return-Path: <SRS0=OYz8=2I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E58C43603
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:00:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E5AE2082E
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bnl+xaTk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5AE2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 510A1852;
	Wed, 18 Dec 2019 19:59:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 510A1852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576695641;
	bh=BvxalPN1pQJ+38pJ/BVZ4dVjTl2Lbv0J0ruE8ZF3T98=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bnl+xaTkkT2uplw90HIF2r6nColXxqg7CbPVGFrDwiRtEvxOJ9erX1ezt7asT7/ck
	 j1IyMVRLxPUHFMnEGVD+sIPaV+c1cAPjwcTInR9CXHfDRHmvu0x4JC3z5EFYu+GCqd
	 6DxGzFmJxf+JNQD8f5z4z4uWmtgyeUc2mNpjVrxw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B7373F80096;
	Wed, 18 Dec 2019 19:59:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4AAE4F8022C; Wed, 18 Dec 2019 19:59:49 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 046DBF80096
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2019 19:59:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 046DBF80096
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A67441FB;
 Wed, 18 Dec 2019 10:59:44 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 252A33F67D;
 Wed, 18 Dec 2019 10:59:43 -0800 (PST)
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>
Date: Wed, 18 Dec 2019 18:59:38 +0000
Message-Id: <20191218185938.38282-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Tzung-Bi Shih <tzungbi@google.com>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] [PATCH] ASoC: max98090: Remove empty suspend function
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The suspend function is empty so can be removed.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98090.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index da23810f958e..68271042f586 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2838,15 +2838,10 @@ static int max98090_resume(struct device *dev)
 
 	return 0;
 }
-
-static int max98090_suspend(struct device *dev)
-{
-	return 0;
-}
 #endif
 
 static const struct dev_pm_ops max98090_pm = {
-	SET_RUNTIME_PM_OPS(max98090_runtime_suspend,
+	SET_RUNTIME_PM_OPS(NULL,
 		max98090_runtime_resume, NULL)
 	SET_SYSTEM_SLEEP_PM_OPS(max98090_suspend, max98090_resume)
 };
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
