Return-Path: <SRS0=kxA9=GW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2602C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Jan 2021 07:18:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48D692312D
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Jan 2021 07:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D692312D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AEED01861;
	Tue, 19 Jan 2021 08:17:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AEED01861
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611040728;
	bh=12bvdWliR0DiU3ILD3dH9fdrTxWTP7VodO8+SmzWLHg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SMKmEbauMshIu9k8PPBdl6ptuvSDLAVQtefduK7BWK1rW26CXvP+dfBVuBPsHs0JL
	 7ZFZzhehDVAVa+qybLA7XlUIExhhAh8n7HMQnHD2prM+hnfqm84CYQUvltifMNL+tq
	 6/ZByAytgAYgx7aewcNxMcrWCb8GLL9b2iNf26vg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 29856F80255;
	Tue, 19 Jan 2021 08:17:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 384F1F80257; Tue, 19 Jan 2021 08:17:53 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 56F4AF80117
 for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2021 08:17:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 56F4AF80117
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="kDVBhl47"
Received: by mail-oi1-x234.google.com with SMTP id x71so4423621oia.9
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2021 23:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jvcrSxD1ATraRj0smzrNy77aHDYuL+QWFJcD8g6nwgI=;
 b=kDVBhl47hptkZEpTH6JSvU6tgpzDhOem0BUYo7bZedEj8XmmHJ6SWQ0bMbhqGw12Ak
 ziIXabBuI6LnooLRz5NLPl8KJPzkEGfD1IZLElKP45TixL65notLzQ5mL15emx3BdFoM
 sV/69v5jrdXpyg9nulczbmf0+ZiLXPNbF3rdJcCPB/77+NN1DfZGcNhAVap+SnbjQOpL
 2ytfYc3GHaSgKNsa+NYivF6NbDg1o0ePHOMEE1PC0H4gK7UndW8TyCNuoB7Zm8AiKuVN
 BRFdS1SdzlJakYx6h1w2P7azwn+exFIfcNoBcmFoDNgkc8GGEEYBIu2xk5r17Atn3rcu
 NSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jvcrSxD1ATraRj0smzrNy77aHDYuL+QWFJcD8g6nwgI=;
 b=aZHsx5ywKjSwelnmcuUyhQ8ZMdOXuqwAHY2hIiW/tUeIwSzXHEP/fsR0vHH0Khpv9F
 DvrrcDQHtpp80QkdoyKiWuPwlbE9gEok8SjNvVfsRMohGON2du+h9RrsmYS+CZoVWzfl
 +ApqKu0+xDp/bUr4A9hg+hGy1PZOw0l+deVvBTRM9KQXiOlTiskl1nwTztN0CpvWAImi
 xSynRyzjOSQsvcgOFckdcOETc+CIFJB4R61i//EVAxEUDf95UVerurs5++r9Ip1Sk44q
 bSkbHxwM3eobkLOWI5B2L1SpqHPLvUxvPZCWPLRKa0ENrQIJDpb7jM6n6omVqG8QU2jV
 Oy3Q==
X-Gm-Message-State: AOAM530KKlQNooZFM6jaetgGatNi7SzmMcNtROaD5Js1f4ucXVr9AWAw
 qDEFqEXrXBQfo7EWOf0w1nf1kQ==
X-Google-Smtp-Source: ABdhPJyLMnQti8ZgjeK6nNQd8nqWgLmIOJhVQkbyjx2ddDynFegNgeAssRhPyNaw67mMtl/ZL9XDXw==
X-Received: by 2002:aca:5e03:: with SMTP id s3mr1740211oib.125.1611040662434; 
 Mon, 18 Jan 2021 23:17:42 -0800 (PST)
Received: from localhost.localdomain (li519-153.members.linode.com.
 [66.175.222.153])
 by smtp.gmail.com with ESMTPSA id m7sm4054075ool.29.2021.01.18.23.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Jan 2021 23:17:41 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
To: srinivas.kandagatla@linaro.org
Subject: [PATCH] ASoC: qcom: lpass: Fix i2s ctl register bit map
Date: Tue, 19 Jan 2021 15:17:18 +0800
Message-Id: <20210119071718.3867961-1-jun.nie@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Jun Nie <jun.nie@linaro.org>, plai@codeaurora.org, bgoswami@codeaurora.org,
 alsa-devel@alsa-project.org
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

Fix bitwidth mapping in i2s ctl register per APQ8016 document.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 sound/soc/qcom/lpass-apq8016.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-apq8016.c b/sound/soc/qcom/lpass-apq8016.c
index 0aedb3a0a798..7c0e774ad062 100644
--- a/sound/soc/qcom/lpass-apq8016.c
+++ b/sound/soc/qcom/lpass-apq8016.c
@@ -250,7 +250,7 @@ static struct lpass_variant apq8016_data = {
 	.micmode		= REG_FIELD_ID(0x1000, 4, 7, 4, 0x1000),
 	.micmono		= REG_FIELD_ID(0x1000, 3, 3, 4, 0x1000),
 	.wssrc			= REG_FIELD_ID(0x1000, 2, 2, 4, 0x1000),
-	.bitwidth		= REG_FIELD_ID(0x1000, 0, 0, 4, 0x1000),
+	.bitwidth		= REG_FIELD_ID(0x1000, 0, 1, 4, 0x1000),
 
 	.rdma_dyncclk		= REG_FIELD_ID(0x8400, 12, 12, 2, 0x1000),
 	.rdma_bursten		= REG_FIELD_ID(0x8400, 11, 11, 2, 0x1000),
-- 
2.25.1

