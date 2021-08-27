Return-Path: <SRS0=XrcS=NS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6993CC432BE
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Aug 2021 18:51:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E60BB60E90
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Aug 2021 18:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E60BB60E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 718AB170D;
	Fri, 27 Aug 2021 20:50:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 718AB170D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630090272;
	bh=1FunearmyWhFMFAho+kSNLr4bUFtZ6lVmQlr+z/riGc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AOVX4ksLOewWGqm1bm0zun6VQaBNrnzmD0LtALZOwwuJ3A3VUFLG0QoFuzXVjyI0N
	 iXCSzYXhQZqtY3rFeTVXNLZFHDuMKxkG1Wg3G25aeXFAq5/HEFtbedQOWl/Z3rhoPs
	 +Biyo1X3nxpJnfdH5oP8Z0IZaSfZSohRihs5T5v0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 07FD0F800FD;
	Fri, 27 Aug 2021 20:50:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D56E7F80129; Fri, 27 Aug 2021 20:50:15 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 964A3F80054
 for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2021 20:50:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 964A3F80054
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com
 header.b="PrLIcK+K"
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net
 [80.193.200.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id CF9CF3F232; 
 Fri, 27 Aug 2021 18:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1630090204;
 bh=6DS/6l+5PcmW6BogA40VziIkdEr3BoKs9rilBqjn/18=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
 b=PrLIcK+K9UeZcMGIqjktvzJIbSAHNDa7GA4fSxO/7p5AebXiIUbDu7eKogM8n7Vuq
 h0OmDyUCgW6+v5c7EwLqxOkZTnnBGlN57uRefivwfNBr0uY0XHbcL5DN/J4vYOfCyo
 1jLkHghf0ODx+D0njodSiydSq8PBvKvVMEolUoF2n5bFvWeLesQHEv/Ru9ZLZpdUTj
 7NSxWc6P3sq4HnKwlr/bZtMf2ks7dH3DXLuBmJTNF0HFMPg8juIoQIdnABIZx8Uavs
 y5CEgdjuuL9UCTzRdv5OQiMn9IVT/nSnVcuhhmivqOMjNlH1sVeo/nx/a7jUscQDf7
 wAyJ7WdhfxfNg==
From: Colin King <colin.king@canonical.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: samsung: s3c24xx_simtec: fix spelling mistake "devicec"
 -> "device"
Date: Fri, 27 Aug 2021 19:50:03 +0100
Message-Id: <20210827185003.507006-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
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

There is a spelling mistake in a dev_err error message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/samsung/s3c24xx_simtec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/s3c24xx_simtec.c b/sound/soc/samsung/s3c24xx_simtec.c
index 81a29d12c57d..0cc66774b85d 100644
--- a/sound/soc/samsung/s3c24xx_simtec.c
+++ b/sound/soc/samsung/s3c24xx_simtec.c
@@ -327,7 +327,7 @@ int simtec_audio_core_probe(struct platform_device *pdev,
 
 	snd_dev = platform_device_alloc("soc-audio", -1);
 	if (!snd_dev) {
-		dev_err(&pdev->dev, "failed to alloc soc-audio devicec\n");
+		dev_err(&pdev->dev, "failed to alloc soc-audio device\n");
 		ret = -ENOMEM;
 		goto err_gpio;
 	}
-- 
2.32.0

