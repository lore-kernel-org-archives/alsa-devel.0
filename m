Return-Path: <SRS0=CIz3=4U=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD72C3F2CD
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:40:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CF1F20409
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jmLic9T7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF1F20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE6491616;
	Tue,  3 Mar 2020 11:39:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE6491616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583232005;
	bh=DJeixem0Ix1O39sbEGrxJrEzizKgWQlG47JHEOJjsA0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jmLic9T7VcRoOkFnT+lQCpvh9mx9po1HbDIWfFtLOf1eqS8SqY2glK+0WOPn95QOn
	 ASspeHu0oSHLrgPe4svJ0J6bEv+EUXoEt3KnJNuJexqfOuBMnmjGX+m2F8dfs1hNgx
	 q5AJKMbqXND2RpPA0B9PlgBj35mPKFxzZSvpXJ4o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2ECC5F8011C;
	Tue,  3 Mar 2020 11:39:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C0A2EF8025F; Tue,  3 Mar 2020 11:39:13 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 24113F8011C
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2020 11:39:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 24113F8011C
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <colin.king@canonical.com>)
 id 1j94x5-0004rs-MU; Tue, 03 Mar 2020 10:39:03 +0000
From: Colin King <colin.king@canonical.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Akshu Agrawal <akshu.agrawal@amd.com>, alsa-devel@alsa-project.org
Subject: [PATCH][next] ASoc: amd: use correct format specifier for a long int
Date: Tue,  3 Mar 2020 10:39:03 +0000
Message-Id: <20200303103903.9259-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

From: Colin Ian King <colin.king@canonical.com>

Currently the format specifier %d is being used for a long int. Fix
the by using %ld instead.

Fixes warning:
sound/soc/amd/acp3x-rt5682-max9836.c:341:23: warning: format '%d'
 expects argument of type 'int', but argument 3 has type
 'long int' [-Wformat=]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/amd/acp3x-rt5682-max9836.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp3x-rt5682-max9836.c b/sound/soc/amd/acp3x-rt5682-max9836.c
index 511b8b1722aa..521c9ab4c29c 100644
--- a/sound/soc/amd/acp3x-rt5682-max9836.c
+++ b/sound/soc/amd/acp3x-rt5682-max9836.c
@@ -338,7 +338,7 @@ static int acp3x_probe(struct platform_device *pdev)
 
 	dmic_sel = devm_gpiod_get(&pdev->dev, "dmic", GPIOD_OUT_LOW);
 	if (IS_ERR(dmic_sel)) {
-		dev_err(&pdev->dev, "DMIC gpio failed err=%d\n",
+		dev_err(&pdev->dev, "DMIC gpio failed err=%ld\n",
 			PTR_ERR(dmic_sel));
 		return PTR_ERR(dmic_sel);
 	}
-- 
2.25.0

