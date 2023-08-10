Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7950CC001DB
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Aug 2023 10:49:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A3A983B;
	Thu, 10 Aug 2023 12:48:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A3A983B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691664548;
	bh=ScGk93Y2dNlMmrR0MgykPBeTqSPNMT7za/shT+UCoxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ffjnPqCvIMqpCrEy6gC/PtlvSE40EWudIcG0Xh8I00X/pas6WK2NdDCHGaPngIKTk
	 CXzdCqC4Ai3rbIyrLHCt7HNLtp2zJmbw57/KyLSrYyMLRMBLgZU096ri3LRuFqL5Qr
	 eRGnYfKWETLa4Y6nlBTAifPUL8t1wR9MeZ915HZA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 492CFF80568; Thu, 10 Aug 2023 12:48:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 60850F80571;
	Thu, 10 Aug 2023 12:48:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E25ADF801EB; Thu, 10 Aug 2023 12:48:00 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0CD20F80166
	for <alsa-devel@alsa-project.org>; Thu, 10 Aug 2023 12:47:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0CD20F80166
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=cq1kU20n
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-52256241c50so962321a12.3
        for <alsa-devel@alsa-project.org>;
 Thu, 10 Aug 2023 03:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691664474; x=1692269274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdCk7OUtlyVla0geNv76Vk4CNU64Mjej9PSyuuwP9Mg=;
        b=cq1kU20nMj6zkP5dpHC0Hptq8NDMOxwqXMIyqFGDLtXHdhylP/8FUA5sLq0QpIHQIn
         R6aRN019gA0L336WxdmXNVzP9H5PB795+pAKYjntNoFZwliERBALI2KEdPDDN4h7yJ7k
         /wNGeKxG5ZUdAKtmwd8Uql/mAj42Wkd4FeXd2mE1g6+aCRY0H/Xydvfx2LngX62guhQf
         Q3Z92vB+nZf827DmAqmBMJJSv+FPrc1lHcIoILW7T4qVr2jlt1WlRwYv9JKmis44Xg5e
         rzrcwyp8+z1Pk2cZktUcFxabe/SEpMY1Ukio/T9ZiJOfp3w6zfgY3FbqF8SAGFn+Ty6n
         R/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691664474; x=1692269274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdCk7OUtlyVla0geNv76Vk4CNU64Mjej9PSyuuwP9Mg=;
        b=cjSobgREZkQ6D2pLTIFbm1hy0+0T1IlLeoY3/P06sYkbtaUqSSi3vEoxbQyeK2y0U4
         NuHANN0Hp3R0N9Frf3qmkQncBPVJvG2oMaLYmBu5bVLnW7i8gEqIFd1zokMUrXeVQc2h
         +Xu9E7e91D0v3oPZuEJ39N73ct+f6gVXrkGTK48CYU1NaTP0AiAuZ50NbM7oxId7nkkG
         8j3Kbf1fsObcjy+0k7VOWNbP3nnMG0vybP0dwxkceC1b4i1S9oR5o3SMwvuJGKryCnIz
         I6nxp+S1DkN4PQRL8uuS96gpj6/NUoTtOLBNcNndpzSz6Ntip/gNkHqrII0Olm1Y336u
         Vqfg==
X-Gm-Message-State: AOJu0Yx4S5sMcfs22JExBy0fAPw57Vgn6aH/f0fmltDObxJJMCPF2HGm
	wxy4Qs9hjA6E36/VCuYU0xU6jA==
X-Google-Smtp-Source: 
 AGHT+IEnAtHjVByssGhPTqQELF84XSx5/0DHEL7BVsY09r1D07osAN5bMweLFHfpBNKn1GaFZacbBg==
X-Received: by 2002:a50:fb91:0:b0:523:102f:3ce0 with SMTP id
 e17-20020a50fb91000000b00523102f3ce0mr1833711edq.21.1691664474683;
        Thu, 10 Aug 2023 03:47:54 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id
 x20-20020aa7cd94000000b0051dfa2e30b2sm653854edv.9.2023.08.10.03.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:47:54 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	llvm@lists.linux.dev
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] ASoC: codecs: tlv320aic32x4: fix
 Wvoid-pointer-to-enum-cast warning
Date: Thu, 10 Aug 2023 12:47:44 +0200
Message-Id: <20230810104749.164827-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810104749.164827-1-krzysztof.kozlowski@linaro.org>
References: <20230810104749.164827-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: DU35KPYKG7CGFBA7RXWJILRYWWY5OAQR
X-Message-ID-Hash: DU35KPYKG7CGFBA7RXWJILRYWWY5OAQR
X-MailFrom: krzysztof.kozlowski@linaro.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DU35KPYKG7CGFBA7RXWJILRYWWY5OAQR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

'type' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  tlv320aic32x4.c:1352:18: error: cast to smaller integer type 'enum aic32x4_type' from 'void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/tlv320aic32x4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index ffe1828a4b7e..6829834a412f 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -1349,7 +1349,7 @@ int aic32x4_probe(struct device *dev, struct regmap *regmap)
 		return -ENOMEM;
 
 	aic32x4->dev = dev;
-	aic32x4->type = (enum aic32x4_type)dev_get_drvdata(dev);
+	aic32x4->type = (uintptr_t)dev_get_drvdata(dev);
 
 	dev_set_drvdata(dev, aic32x4);
 
-- 
2.34.1

