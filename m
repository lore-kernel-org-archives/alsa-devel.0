Return-Path: <SRS0=FemE=DN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F662C41604
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Oct 2020 10:14:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40E832068E
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Oct 2020 10:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Uk3VWwa8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="KIPJZlvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E832068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8958C175D;
	Tue,  6 Oct 2020 12:13:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8958C175D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601979238;
	bh=FFIN7ykisjUA1LJ8XTK7nTILol98Xu3XABpIi5JJHmY=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Uk3VWwa82M9oXkKBBTB0YzYxD/tBLmKKTWoJTqa7gEU3A40FIttG0Vo/igFfRiDcw
	 zoDV6cGbHeeRgk0o0iYbJmqfh+QVkNY9NbBRSxk1Qb+WTbWzJa7GR6JXzaaCxK8TWl
	 dYG925j1RuBeyL6JT1BMOXWvCEBB9b6LmGTTfD+Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1ABD4F80129;
	Tue,  6 Oct 2020 12:13:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F005BF8012A; Tue,  6 Oct 2020 12:13:06 +0200 (CEST)
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com
 [IPv6:2607:f8b0:4864:20::749])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 42E7FF80127
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2020 12:13:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42E7FF80127
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="KIPJZlvA"
Received: by mail-qk1-x749.google.com with SMTP id d22so8810344qkb.18
 for <alsa-devel@alsa-project.org>; Tue, 06 Oct 2020 03:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc;
 bh=AibVLWCpvCmlfgrsvKgXujQLNlseYi+yF+LjVwpYD/U=;
 b=KIPJZlvAMwgCihJN5x6pXCsquP9BEWQyRjWMIC9EIMwdvBKo7VN9tK3fkxnp4obC7B
 OePf0ns50VAeveSbSchwGwi/FIh3ABhFm6bj0JqpkrxmrKkBdmSvZdstA1yopcfeaTTp
 YQNE0pi+HGIlL/VOP70aaFQP6Xx4y5FHQD6ogLlvnnULK2jHZpj26Jl9Z5rLhKS/aqoY
 pwTjclggROf/f2UZS5Q+VcViyOzdhxsi7y/A+RTnPViSqYIG5/24NIJTg9WE/Js5vJWf
 QFAL169sxsRPTNAg4uybJ275fvUqLt8gr/ETOoS0JqbrcWeXnSXiy9G2KODwNpiyoCI9
 b3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc;
 bh=AibVLWCpvCmlfgrsvKgXujQLNlseYi+yF+LjVwpYD/U=;
 b=gD234sDHbraKnnPAtCQcfsLvj6ybw7PEXIO0OOku3jkAG1mfbrbGjKOOJwouKnkOG8
 IfRojcJWcMd0JBpkpLt0/rBSBj/Pbhb3KuVvNNlyfANVuk9vKMsiUpKPKXFHZ7rZzDxm
 qTp0guXdq/WmBtm4miqAmt2iGm2l3wrLwu6FlFf6DhFxFbKd5ziav5KY13v7bbSNne9P
 94X6mS6Z2sdvrrl/DRU01HSRM1yfWSkqMqKHYBW1840YuClTF9pKLO3fKxGizEZIkupg
 KjhuSpe7kchHui4arw3ZD3FDt35k5EyQFGFYuxl6jBxT2R/n1RHpw4+WzBldUdM2oQUU
 JwXw==
X-Gm-Message-State: AOAM533aHQHjurNjuLQweMSV02RZ3gZpIYEat4drp+2iXJkKm3UrK+4Y
 9XJg4QKHgWaQbCWr88ZX6rLJSu+JKmZB
X-Google-Smtp-Source: ABdhPJx4TvwdzSZDJm3gGZk/2tU7Fm+WGLN1G8gFvHWlVXaWC0VOFWU0i0yXa7foxEJ++mLuBDOcbyT/XgTV
X-Received: from tzungbi-z840.tpe.corp.google.com
 ([2401:fa00:1:10:725a:fff:fe41:c6a5])
 (user=tzungbi job=sendgmr) by 2002:a0c:9a4e:: with SMTP id
 q14mr3741792qvd.22.1601979182022; Tue, 06 Oct 2020 03:13:02 -0700 (PDT)
Date: Tue,  6 Oct 2020 18:12:52 +0800
Message-Id: <20201006101252.1890385-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH] ASoC: mediatek: mt8183-da7219: fix wrong ops for I2S3
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: tzungbi@google.com, alsa-devel@alsa-project.org
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

DA7219 uses I2S2 and I2S3 for input and output respectively.  Commit
9e30251fb22e ("ASoC: mediatek: mt8183-da7219: support machine driver
with rt1015") introduces a bug that:
- If using I2S2 solely, MCLK to DA7219 is 256FS.
- If using I2S3 solely, MCLK to DA7219 is 128FS.
- If using I2S3 first and then I2S2, the MCLK changes from 128FS to
  256FS.  As a result, no sound output to the headset.  Also no sound
  input from the headset microphone.

Both I2S2 and I2S3 should set MCLK to 256FS.  Fixes the wrong ops for
I2S3.

Fixes: 9e30251fb22e ("ASoC: mediatek: mt8183-da7219: support machine driver with rt1015")
Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
index 4d69ea31bfe4..c2c1eb16fcc0 100644
--- a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
@@ -696,7 +696,7 @@ static int mt8183_da7219_max98357_dev_probe(struct platform_device *pdev)
 			if (card == &mt8183_da7219_max98357_card) {
 				dai_link->be_hw_params_fixup =
 					mt8183_i2s_hw_params_fixup;
-				dai_link->ops = &mt8183_mt6358_i2s_ops;
+				dai_link->ops = &mt8183_da7219_i2s_ops;
 				dai_link->cpus = i2s3_max98357a_cpus;
 				dai_link->num_cpus =
 					ARRAY_SIZE(i2s3_max98357a_cpus);
-- 
2.28.0.806.g8561365e88-goog

