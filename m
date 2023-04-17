Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABCFC77B77
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Apr 2023 14:16:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 56A92E0F;
	Mon, 17 Apr 2023 16:16:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 56A92E0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1681741017;
	bh=oS6pyzH9OeeJ1yhGlB+srxJpmWqxcw2IuQixGOm9Rkk=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=oZ6tWHg0jl7t5d2T8vlAoHssm9/m3TiojWje13TdqINfJRyMOWpDBZaqLx5u2g4DI
	 mPQtiToijYeYntG79C1yGHhCAr35amIP6iB6wRlgc+ZEpTCN26NX1TELoWf4hxlwHa
	 J8qzDdnkiJk2cXg1rV6VsIJytMYh5/AqQ1OYatiU=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4A642F80533;
	Mon, 17 Apr 2023 16:15:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 10F5BF80533; Mon, 17 Apr 2023 16:15:12 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 508A6F80266
	for <alsa-devel@alsa-project.org>; Mon, 17 Apr 2023 16:15:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 508A6F80266
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=NhvozIn9
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-506b2a08877so191452a12.2
        for <alsa-devel@alsa-project.org>;
 Mon, 17 Apr 2023 07:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681740900; x=1684332900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+Gqwd50O978CgcnfFnllVcskvaI5UoRb9w8Mjh4Qt4=;
        b=NhvozIn9uNmaKOvuqJ4W3H9KLBsRVfD3pBTemHy3QP44mHjFSwo3ili22DRVQ4xWD2
         OENCn9eEIw0SMkaOA13LqHh5rbD7i+R0pxasR8Gto4yvtRxOdNYS7CT9T+lpWTPEMvxY
         5vZG9kd5Y3MhRasLTy+paVpBOWBMGe5Pf3CfaRG+XzYCvPfK+5c9FJoRbLQO7SeMJJWU
         VLK9DT7gjljEdPIhzFuQM8YbEIbjSUFqIumrHJ1BNFpzaQwx/uDRfN2SRMAy0u+JGZ2H
         D2z63Fdwi7Ef0StiEurf7clLKLKs5Yrzesf6m6AXNmVp10RwfIZh62BWxFtp70qdHlOw
         6soQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681740900; x=1684332900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+Gqwd50O978CgcnfFnllVcskvaI5UoRb9w8Mjh4Qt4=;
        b=LcYDBSb14bIsggFFXD6JdWJnEvQFIRWG7iq4YD7TetIcfmxWrWCisUzlKFgrTJN+2p
         qonvvs6JxchDZCJN2AWrZV7ei813z6H7lgSgLSIhosVQsxeacRsfFFNTW9H9/+97tQFP
         Mrpxr+cHImC7XI6iSGVZPBPvmd7mJf85dIR48yhbr19faPU46NX+jRGQbSwFECULOvtg
         AGk0SkFSdk+YsbA6UJ7zu8TeZhxLR92EU0iQTlAQK2Q7XmFdODdpZNsyFTYJ6T9nOamC
         apNbRQm4mpc/0GJMc+p0lQAS8qI6aozD3vVVhMg6EQiIbSA6e+nrbLy5rtA27qnx8zdB
         5K3g==
X-Gm-Message-State: AAQBX9cKKqRxqUJ50wqIVNAOP6dSsaFGwACeqacYC3ZcItQY6dr0UaCO
	z954DNdj0xPnumGZWAfy8J0THg==
X-Google-Smtp-Source: 
 AKy350bTx5UrQe52hGZ0GfeZUicEE0hKJ0FthhddapTmbFaB6awlUd7hq072M3AacWUZkbPTwr9Zaw==
X-Received: by 2002:aa7:c90b:0:b0:506:7385:9653 with SMTP id
 b11-20020aa7c90b000000b0050673859653mr13444365edt.39.1681740900005;
        Mon, 17 Apr 2023 07:15:00 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:96aa:60eb:e021:6511])
        by smtp.gmail.com with ESMTPSA id
 q6-20020a056402040600b004f9e6495f94sm5832034edv.50.2023.04.17.07.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 07:14:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ASoC: codecs: wcd938x: Simplify with dev_err_probe
Date: Mon, 17 Apr 2023 16:14:53 +0200
Message-Id: <20230417141453.919158-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230417141453.919158-1-krzysztof.kozlowski@linaro.org>
References: <20230417141453.919158-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: EXVSQNMUIM6SPDWLJ4BATSZ27OIC3PMT
X-Message-ID-Hash: EXVSQNMUIM6SPDWLJ4BATSZ27OIC3PMT
X-MailFrom: krzysztof.kozlowski@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EXVSQNMUIM6SPDWLJ4BATSZ27OIC3PMT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Code can be a bit simpler with dev_err_probe().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd938x.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index f033f79ed238..11b264a63b04 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -4235,18 +4235,15 @@ static int wcd938x_populate_dt_data(struct wcd938x_priv *wcd938x, struct device
 	int ret;
 
 	wcd938x->reset_gpio = of_get_named_gpio(dev->of_node, "reset-gpios", 0);
-	if (wcd938x->reset_gpio < 0) {
-		dev_err(dev, "Failed to get reset gpio: err = %d\n",
-			wcd938x->reset_gpio);
-		return wcd938x->reset_gpio;
-	}
+	if (wcd938x->reset_gpio < 0)
+		return dev_err_probe(dev, wcd938x->reset_gpio,
+				     "Failed to get reset gpio\n");
 
 	wcd938x->us_euro_gpio = devm_gpiod_get_optional(dev, "us-euro",
 						GPIOD_OUT_LOW);
-	if (IS_ERR(wcd938x->us_euro_gpio)) {
-		dev_err(dev, "us-euro swap Control GPIO not found\n");
-		return PTR_ERR(wcd938x->us_euro_gpio);
-	}
+	if (IS_ERR(wcd938x->us_euro_gpio))
+		return dev_err_probe(dev, PTR_ERR(wcd938x->us_euro_gpio),
+				     "us-euro swap Control GPIO not found\n");
 
 	cfg->swap_gnd_mic = wcd938x_swap_gnd_mic;
 
@@ -4256,16 +4253,12 @@ static int wcd938x_populate_dt_data(struct wcd938x_priv *wcd938x, struct device
 	wcd938x->supplies[3].supply = "vdd-mic-bias";
 
 	ret = regulator_bulk_get(dev, WCD938X_MAX_SUPPLY, wcd938x->supplies);
-	if (ret) {
-		dev_err(dev, "Failed to get supplies: err = %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get supplies\n");
 
 	ret = regulator_bulk_enable(WCD938X_MAX_SUPPLY, wcd938x->supplies);
-	if (ret) {
-		dev_err(dev, "Failed to enable supplies: err = %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable supplies\n");
 
 	wcd938x_dt_parse_micbias_info(dev, wcd938x);
 
-- 
2.34.1

