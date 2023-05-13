Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848E3C77B7C
	for <alsa-devel@archiver.kernel.org>; Sat, 13 May 2023 09:03:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 68B11A4C;
	Sat, 13 May 2023 11:03:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 68B11A4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683968632;
	bh=4xeQXVf/AnyfS/XxLgZ898CfNRM20tlxYdkJUCSVYOg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=W3bZqAoO+XShQCroBkaN0Q5RMRjSnZAMWf0XB5Z3j41ueTH+W2bcsjhBZAT/kT1pm
	 HdjLkwKRObsjFZyxQ925haL7WXmmShBVAQ7LclwF9NezA55w+5iQMigOWtdYdjZbWc
	 6iO/fOn+JTaQqay1lHNx8W017j+7QLNS3F7Tb72w=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B9FFFF80549; Sat, 13 May 2023 11:03:01 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B0A0F8052E;
	Sat, 13 May 2023 11:03:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 68D16F8052E; Sat, 13 May 2023 11:02:46 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 81F85F802E8
	for <alsa-devel@alsa-project.org>; Sat, 13 May 2023 11:02:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 81F85F802E8
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=vc7Ye+F6
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9659f452148so1952884566b.1
        for <alsa-devel@alsa-project.org>;
 Sat, 13 May 2023 02:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683968558; x=1686560558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HXSOlaN4/Bv4YilVOwCC/M+d+MgGbw/gHZ0ONLamDV8=;
        b=vc7Ye+F6KjYi1P1vwEMBbV3cPmrH6ynQnOLsQ7R7QCKXSaLinreMF0ZgD6bMjEji8V
         epvXfMgat8BsqAH+NcBWFA6+OxvsoTMIvjqI1hToBTWofTVZe1lB+8W4r8pNra6nILBz
         rmPfib0MFYhJFHvHpDq5+nTemLpz4nQO5j5mPA487EpXrCqOsrXUvJMdsWL4M3LdCDgE
         fltXOnDB89luilEPvDsZtOGrEy8OK2/VAlOr90Bqw+KzsFlCVVmFPzMqrYvNeZZafvCF
         1/jdxZhTXAaAxJq1hyZXVNFpq0uiGgZc+ShOqCJbcePM6xEbAk4CEK1KmVkN8plzkh3r
         vEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683968558; x=1686560558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HXSOlaN4/Bv4YilVOwCC/M+d+MgGbw/gHZ0ONLamDV8=;
        b=a86sFfv8IIIsKBTwa6z9MCAlQoAqVWS9fLVq5zuWIyOsETjmbPuwWzhdL+WYmlSc3a
         2aBXpSfSyC7OfZ1JciMGJ3YsieQyRzanzSrcCDKwi3v/IVXssxD7ajvfeutDDVVWa1+W
         sOIjpx/oIZIFxqBcqO2A1vR3espekT9NbtfizOy2EuFJS7Qh28G0mxGeFMS+ZSc7RCAO
         x/RWnXb1m8DTgtrMhVkAQnxSVIp7mWC5Vz4S70Woynt1qJ+GGEvPtLUrScPTbeGu8b6t
         jDyVZV4OBbuE8/EojIDZgJiVmXjFDAj8IEGIA6ABSsuuxtqIqTTbrHny5wrsu9rvcb3N
         f/Tg==
X-Gm-Message-State: AC+VfDyv1f29OWIA4d5XNyUJQ/4a28V4UvUdUCqfR+AGqIhCPoGQcUCO
	J68upZXlFGjL72B/261fhTvX3A==
X-Google-Smtp-Source: 
 ACHHUZ67161rnDoLfMuLThXGPyOgzGXRs8UQzENpp+61zaIgMeOcqx8yp7rZWHiV3lazI+uGB7v95g==
X-Received: by 2002:a17:907:7214:b0:96a:c661:fa1 with SMTP id
 dr20-20020a170907721400b0096ac6610fa1mr2653328ejc.46.1683968557696;
        Sat, 13 May 2023 02:02:37 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:1d0:810a:586c:c5ba])
        by smtp.gmail.com with ESMTPSA id
 jx26-20020a170907761a00b0096629607bb2sm6504247ejc.98.2023.05.13.02.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 02:02:37 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: linux-samsung-soc@vger.kernel.org,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: MAINTAINERS: drop Krzysztof Kozlowski from Samsung
 audio
Date: Sat, 13 May 2023 11:02:28 +0200
Message-Id: <20230513090228.4340-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: BIXF6B6KRJ6E254JOXKTTRLU2CEJP5CK
X-Message-ID-Hash: BIXF6B6KRJ6E254JOXKTTRLU2CEJP5CK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BIXF6B6KRJ6E254JOXKTTRLU2CEJP5CK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Remove Krzysztof Kozlowski from maintainer of Samsung SoC Audio drivers
and change the status to maintenance (no one is reality being paid for
looking at this).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c7082004ac55..746ec43ff244 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18581,10 +18581,9 @@ F:	Documentation/admin-guide/LSM/SafeSetID.rst
 F:	security/safesetid/
 
 SAMSUNG AUDIO (ASoC) DRIVERS
-M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-S:	Supported
+S:	Maintained
 B:	mailto:linux-samsung-soc@vger.kernel.org
 F:	Documentation/devicetree/bindings/sound/samsung*
 F:	sound/soc/samsung/
-- 
2.34.1

