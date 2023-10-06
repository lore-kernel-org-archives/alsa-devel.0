Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51E6E81DFD
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Oct 2023 13:48:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6D75886E;
	Fri,  6 Oct 2023 15:47:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6D75886E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696600112;
	bh=eObD6Y61uE/FIXO2g6KI1xEFA+/bAwbiQUGCINAWMC4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gY7R3j+Cs+fOp+/xTuiBMMJK6Qf7VhRrx1E0+Jv3OQQQTRQP1mgZPFuotSbbLMMJ7
	 H1bNOrnQ6oGhzRJ0pKFDf6g67/Y6LJnPPGWfSgoJCTWG/Vv9edQf79NVe5EPvdUbrz
	 D+SPYMFnKCkUCBULHe0boFEf40zj4Sje5g+PqQII=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4F619F80589; Fri,  6 Oct 2023 15:46:48 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B7689F80549;
	Fri,  6 Oct 2023 15:46:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B2B4CF80558; Fri,  6 Oct 2023 15:46:39 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 37430F801EB
	for <alsa-devel@alsa-project.org>; Fri,  6 Oct 2023 15:46:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 37430F801EB
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Q34td4WN
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-504b84d59cbso2836102e87.3
        for <alsa-devel@alsa-project.org>;
 Fri, 06 Oct 2023 06:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696599988; x=1697204788;
 darn=alsa-project.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tcctjBppf75NLO6YkO8Pl2INJRmj2vKxlHT5saQtZoY=;
        b=Q34td4WNzCOg5YcBKPntcbxBMYz/KwwF4Wiq4CSDWLqYLoZRh9qAlvbQL1dT4DzMvC
         gDTdrzlgqWaROFN25qoTErvfiJ9apoTTh4gxgb/mJiAv/qjoOw6UQcEooAeTFqSJmrVA
         KsIK1rx0efPWo5f6Sq3C+W/hauHIv5nlMVN2FWPA+ycdbMaHJ4qFNNojMXu47shzXE8l
         RhMyCp80J2I9lQrduUgAsQXkcuyNehRUjRcMUOX66c4MlgRM2JyWKPF8xmzLzB0wQ2mh
         jad9F+0hIRbxdp84/CCUT+1eCM4oKBugTihIPLLIbq6n3jJFsEg3zyYFxRtMskNeKa5y
         CdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696599988; x=1697204788;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcctjBppf75NLO6YkO8Pl2INJRmj2vKxlHT5saQtZoY=;
        b=QfktZWSyxuopjzRhUqDCkPfYxHcSn5o9xdet+NdJWsufkR0r6hok6DZHQnAluXlsZL
         mZb4Rg3SBplAT/L2hq7YLCntQZf/0r/JCOcSLAhf8Ord9ObE2W7pWHLxN17fRutpopSU
         c+6NhZ6SJwYokYsgEHk/jlQGwkpYrUe+x05RL9qfNgsQHh0E4YUQBQzewfertwzcuuaI
         0QAM6XP+rf2t9mwg8N7hj8U8fmfjvYdWtO7YT5Pgyau8sZ29oNLqLAKKDA60HZQeoyRA
         zSyQkKD85MFo0VNXjNDqjIv0chAj3rUhtIGhnGJUjE4XpoeHqvn8M2p95g/W/iFW7K+D
         NGGQ==
X-Gm-Message-State: AOJu0YxXfYf+C9n0RWoKvC57G76gxqNKtsuqFZUnBYcTr50wNdvgN/Yo
	8TQB8UBwZGCfTqiNaXZwNND8nw==
X-Google-Smtp-Source: 
 AGHT+IGGfV3zI+nczOVhjRr4Mwdj1t6P4p9VuGFvQPwS1+LInpdbM8MctPtTPICaU62NLB0lwNF8YA==
X-Received: by 2002:ac2:5f62:0:b0:4fe:5860:7abf with SMTP id
 c2-20020ac25f62000000b004fe58607abfmr5744253lfc.13.1696599988003;
        Fri, 06 Oct 2023 06:46:28 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id
 v25-20020a197419000000b004fe37199b87sm308733lfe.156.2023.10.06.06.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 06:46:27 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 06 Oct 2023 15:46:24 +0200
Subject: [PATCH 1/8] gpiolib: of: Add quirk for mt2701-cs42448 ASoC sound
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231006-descriptors-asoc-mediatek-v1-1-07fe79f337f5@linaro.org>
References: <20231006-descriptors-asoc-mediatek-v1-0-07fe79f337f5@linaro.org>
In-Reply-To: <20231006-descriptors-asoc-mediatek-v1-0-07fe79f337f5@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
Message-ID-Hash: 73JIKBOI2ZWFCUO7EQYZES4ROLX5M7PZ
X-Message-ID-Hash: 73JIKBOI2ZWFCUO7EQYZES4ROLX5M7PZ
X-MailFrom: linus.walleij@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/73JIKBOI2ZWFCUO7EQYZES4ROLX5M7PZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

These gpio names are due to old DT bindings not following the
"-gpio"/"-gpios" conventions. Handle it using a quirk so the
driver can just look up the GPIOs.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-of.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 531faabead0f..d9525d95e818 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -512,6 +512,10 @@ static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
 #if IS_ENABLED(CONFIG_SND_SOC_CS42L56)
 		{ "reset",	"cirrus,gpio-nreset",	"cirrus,cs42l56" },
 #endif
+#if IS_ENABLED(CONFIG_SND_SOC_MT2701_CS42448)
+		{ "i2s1-in-sel-gpio1",	NULL,	"mediatek,mt2701-cs42448-machine" },
+		{ "i2s1-in-sel-gpio2",	NULL,	"mediatek,mt2701-cs42448-machine" },
+#endif
 #if IS_ENABLED(CONFIG_SND_SOC_TLV320AIC3X)
 		{ "reset",	"gpio-reset",	"ti,tlv320aic3x" },
 		{ "reset",	"gpio-reset",	"ti,tlv320aic33" },

-- 
2.34.1

