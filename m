Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22766C48BF6
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Feb 2024 13:48:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9013BA4A;
	Wed, 21 Feb 2024 14:48:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9013BA4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1708523332;
	bh=ac+wf98nfeb4OKJmSgUmAqslHEbIxNi/Hsi0N/Bh9PE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=XRpQZcC9V2Vb+2IzS4do6kF9Suk9Z8oUTzchbA2EFxrmsoqaZUgWfUMZ9tqEwxMjM
	 om2bHJeV32ZluLgaimzZ9XRcj3gDx3E9EJgJr73mvEnF8MxjuOfbX7YZBzakPe4JUW
	 7MGJPlKdwcmAg75fZRETh/Pnr0uUhBCBgB33G8UQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7E1C5F80587; Wed, 21 Feb 2024 14:48:19 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DE407F80496;
	Wed, 21 Feb 2024 14:48:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 49770F80496; Wed, 21 Feb 2024 14:48:13 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0A950F800ED
	for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2024 14:48:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0A950F800ED
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=U4d4E4Wg
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4127188dd5cso11144395e9.0
        for <alsa-devel@alsa-project.org>;
 Wed, 21 Feb 2024 05:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708523286; x=1709128086;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iKh8l/wR7FFRHsHkLZEao+9h2Y4w+XNM8/7IgkcvxQc=;
        b=U4d4E4WgavsxGns1RxQtWOKIJG93mt4cPnXd/zDoQ4qKyiDf7gD1lPml3iTjb9Jc/f
         q17V6pQeSs+E1hzwspbk5JBTcJazhSv+so2D9gk9/n4b5Q1idjPLXATau81JCJuxU3h3
         d6L8itE18OXoK78kunefgyvlDzoatiLMavgBn0/yooZXoGfGVCkvXUpHWuMtAeI+FP4v
         grSVhTmCenuXdsB4X73jZM37GZIukenlGh/dA91mAwAnr1D3/CEe+kQkBbZs4zr9xxAz
         DqvEasjHEfFXaDSA+T5bSioSTjP+j2qm6KiUuQnbjOyOp6X44BjTAZO4aRPhLk8GMwZP
         jSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708523286; x=1709128086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iKh8l/wR7FFRHsHkLZEao+9h2Y4w+XNM8/7IgkcvxQc=;
        b=L1VPw43wekM4MOzQDSLN2synALYerw1uwUpNTLjAwSpJc8HOulczO3RLAhiCubdt1p
         yHR3zTVxNZ0x6Yy0dvvDhgSox00qdzRWd2IeSRowvwISL5lIimPu9ToH33rBGEsup2oz
         38qtEYi5YvvDYdUDdIKaRPpffslLgE8bRn2qEiF4ZjktZw/J/0llrMXs8l2P5FXGXAbO
         6Yedlvyqjk2IvonO9CxTwW9JofMVjuVmMNkot+OEf/PS/TAmpTzV/pyxtGVdgRLvzcy4
         T9aEFnP3CqcI/ed8IMdeusd1ckpd73WFIMjy8XCeI3rOeYwyMKetGoZk4rJ+4QeNAMfP
         jYNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCViu+ffUHy0KzB9tkobjn1rgCftYg+7qNGvq/9es6aFNjIhxgQmXWLRdrRVxRd6Lon69a8NtPmi9j5Ufk9RjJV9ApRiRZ7zWA2X2jw=
X-Gm-Message-State: AOJu0YzG7FmYOioUXNrcmtOsyYZZWyXRqhtCYyfH1d2Wov+QqBZwyh2h
	NkrLjUu0jfojZnIMRFeXW/bhQfmEyc1GPmpZLL+y3rdqa1+/WZop
X-Google-Smtp-Source: 
 AGHT+IF4CLj+iwCbayJVWUxt0v3FY77n7cusG5cKy/J5D8iRjLv1ENQXPDQDbV3uR6yV71zBaWKskA==
X-Received: by 2002:adf:e84f:0:b0:33d:82a8:f59e with SMTP id
 d15-20020adfe84f000000b0033d82a8f59emr698097wrn.47.1708523285669;
        Wed, 21 Feb 2024 05:48:05 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net.
 [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id
 p6-20020adfe606000000b0033cdbe335bcsm17062934wrm.71.2024.02.21.05.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 05:48:05 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
	Venkata Prasad Potturu <quic_potturu@quicinc.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: qcom: Fix uninitialized pointer dmactl
Date: Wed, 21 Feb 2024 13:48:04 +0000
Message-Id: <20240221134804.3475989-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID-Hash: U32KJPOAFX56EHE3QG6KPRFISIJVCEBA
X-Message-ID-Hash: U32KJPOAFX56EHE3QG6KPRFISIJVCEBA
X-MailFrom: colin.i.king@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/U32KJPOAFX56EHE3QG6KPRFISIJVCEBA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

In the case where __lpass_get_dmactl_handle is called and the driver
id dai_id is invalid the pointer dmactl is not being assigned a value,
and dmactl contains a garbage value since it has not been initialized
and so the null check may not work. Fix this to initialize dmactl to
NULL. One could argue that modern compilers will set this to zero, but
it is useful to keep this initialized as per the same way in functions
__lpass_platform_codec_intf_init and lpass_cdc_dma_daiops_hw_params.

Cleans up clang scan build warning:
sound/soc/qcom/lpass-cdc-dma.c:275:7: warning: Branch condition
evaluates to a garbage value [core.uninitialized.Branch]

Fixes: b81af585ea54 ("ASoC: qcom: Add lpass CPU driver for codec dma control")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/qcom/lpass-cdc-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-cdc-dma.c b/sound/soc/qcom/lpass-cdc-dma.c
index 48b03e60e3a3..8106c586f68a 100644
--- a/sound/soc/qcom/lpass-cdc-dma.c
+++ b/sound/soc/qcom/lpass-cdc-dma.c
@@ -259,7 +259,7 @@ static int lpass_cdc_dma_daiops_trigger(struct snd_pcm_substream *substream,
 				    int cmd, struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *soc_runtime = snd_soc_substream_to_rtd(substream);
-	struct lpaif_dmactl *dmactl;
+	struct lpaif_dmactl *dmactl = NULL;
 	int ret = 0, id;
 
 	switch (cmd) {
-- 
2.39.2

