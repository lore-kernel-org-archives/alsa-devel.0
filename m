Return-Path: <SRS0=6VrY=KF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAACC433ED
	for <alsa-devel@archiver.kernel.org>; Mon, 10 May 2021 10:29:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7B2461458
	for <alsa-devel@archiver.kernel.org>; Mon, 10 May 2021 10:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B2461458
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BF781823;
	Mon, 10 May 2021 12:28:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BF781823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620642544;
	bh=pwFhuJejnko0vhd8OzSR82mCzZ46rKCxdmSTF+wv9xM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fWt1XXO5QUTGqZa4rc+Tx8tB1Rh8GJIQsPv54IL8Log1USlDkd5DTdv52ZQDoNsqq
	 vtIcv0DxPwboKJsoNUhkxcgGTfmfypmEs3Gv7RErLFfl2XTvO+sp5aLLt07pQrXPGS
	 JLDdNV8riFKp2tdDPi0qH4Z3cYPNhKlYgBLSmugs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4BA4BF8020C;
	Mon, 10 May 2021 12:28:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 03E86F80240; Mon, 10 May 2021 12:28:09 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 937BCF800E9
 for <alsa-devel@alsa-project.org>; Mon, 10 May 2021 12:28:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 937BCF800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="QkKSXtPu"
Received: by mail-pf1-x435.google.com with SMTP id b21so6202730pft.10
 for <alsa-devel@alsa-project.org>; Mon, 10 May 2021 03:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=314DroehraaonWcTjTH0R5/hEXI7UJ2gguYdw49op1o=;
 b=QkKSXtPu66DwSuiRaGwTwnDXVUXBbM4aBSOXgHW4gDMFQUzhLHO2w/9XN4B75gucpN
 xHR6Ouz9hWBrxXwVcvabzYDmnZBb6GZGSNTDVo4mvM6GV6udoYKGIHUo3f7hLwNpMzPm
 w4fpHwKLg30OyBMkRdTQjy0WMuj2c9vSNRP6aW0oKzeSMjecnWvlc9/wjI2T+6dC0ffM
 83Zs2PgAbrTLCaeXAwAIFswefQNeqPo1adUA2nTdMS+6pIasKimyZlON4gDcSPVnEdf2
 hLBjMLavq7RWzOItWOGH0D/49sQOfrJL6wjRLpw2ac4AAYa2f/mMOrCA2TEbCIo46k8y
 trcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=314DroehraaonWcTjTH0R5/hEXI7UJ2gguYdw49op1o=;
 b=OUpuxaJfkowmHWdFFgNCnib5+FRyWrmRkz5ng9+OoyrhkcRFPbcV0CLiz8m2t+LDSR
 M0RqKdclQbkhnF+5iX20Na+Lfqyx+ClnMj+k++zLuzVmTLUDNoMwE6ZbZDE0+8KYNrPb
 9ktYROQef8kLNdT20K9AFHaw41qr3xHLCycRx0yZSoGpo9M5dCTvriQHDKyLgrZxeAFo
 toKhap/f8suvB0yXUsCSOjJNhImshP1rwVemwX9fzvV6Ic9v5SCnkc3NRifm3l7B1LEv
 0SnFnfd6gSmP9hmGc4By7KZfnTtKXh6Mltd3Ts4ljS6p13t6NBAjPGPSqmih3asZL3Rb
 R2CQ==
X-Gm-Message-State: AOAM5338FoamWs5iGNKkDuR0Yw4uKN0drqY3qeLFMhxwdH1euHSk3b35
 TJMwWc/Zrek4QlKcsrWQUn8j4Gfv/b3/+A==
X-Google-Smtp-Source: ABdhPJzACrhB0UoKaRJsr7yGACXsuLoijXHum4Hz51YabYmIgSmzJT1Z7JEoJZYP4V8KaGeqFsS77w==
X-Received: by 2002:a05:6a00:2401:b029:28e:823b:fd53 with SMTP id
 z1-20020a056a002401b029028e823bfd53mr24326749pfh.71.1620642480636; 
 Mon, 10 May 2021 03:28:00 -0700 (PDT)
Received: from masabert ([202.12.244.3])
 by smtp.gmail.com with ESMTPSA id q27sm10863759pfl.41.2021.05.10.03.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 May 2021 03:28:00 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
 id 4D907236045C; Mon, 10 May 2021 19:27:57 +0900 (JST)
From: Masanari Iida <standby24x7@gmail.com>
To: linux-kernel@vger.kernel.org, dunlap@infradead.org,
 srinivas.kandagatla@linaro.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, bgoswami@codeaurora.org
Subject: [PATCH] ASoC:q6dsp:q6afe-dai: Fix a typo in module description
Date: Mon, 10 May 2021 19:27:52 +0900
Message-Id: <20210510102752.40620-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Masanari Iida <standby24x7@gmail.com>
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

This patch fixes a spelling typo in MODULE_DESCRIPTION
in q6afe-dai.c

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index b539af86e8f7..2166fc305c8f 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -1706,5 +1706,5 @@ static struct platform_driver q6afe_dai_platform_driver = {
 };
 module_platform_driver(q6afe_dai_platform_driver);
 
-MODULE_DESCRIPTION("Q6 Audio Fronend dai driver");
+MODULE_DESCRIPTION("Q6 Audio Frontend dai driver");
 MODULE_LICENSE("GPL v2");
-- 
2.25.0

