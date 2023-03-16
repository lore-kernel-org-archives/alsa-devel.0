Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FF8C6FD1F
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Mar 2023 19:22:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 515C210A6;
	Thu, 16 Mar 2023 20:21:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 515C210A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678994519;
	bh=lD0CDqZaTiCr2kiC/Wa2gMO5fMjETsZzZDPHbJ2zSbo=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=sQ2RUt+gtnDTLkjHfD+2NyuUXOeIc6PMkuxBTi7Y6rTBF9KMhLkeo0bf5VF7TotSH
	 e2V9tkVBLx7nCM2TiwdqioCzoEmemQMeNZlBm8Jb73g3WcEak1vV06kMThUL9NxGLT
	 NLpygaOcocSMTy0g5wi9r4UlLBHII0hf15MsNm9Y=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2DE82F80423;
	Thu, 16 Mar 2023 20:20:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BA444F80423; Thu, 16 Mar 2023 20:19:31 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DD374F800C9
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2023 20:19:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD374F800C9
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Cw4np8IY
Received: by mail-ed1-x535.google.com with SMTP id x3so11715677edb.10
        for <alsa-devel@alsa-project.org>;
 Thu, 16 Mar 2023 12:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678994367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=90d6EZJHhEShbZuOARV563ZCCttMirKZkXghPJBLmlk=;
        b=Cw4np8IY84u1QT6in23c/ZTCQqKGWKCE9102S8kdWJqD/2lw6RpSaQETeLwFzEPKK/
         IrMdQgLw2py51Fp7DjMvABeQ9rjA79ShpOfX/tnv60TyTsxieqQJ0zgHyMoq3JiIIw4V
         d1d/a6sthfMJDOwv9EyLSpiP8/qmwVtwG1b4re1BaVfggSqNVxN/INRkCx3jKIcQ7q6U
         a9K01YB0sTrFY/tbzJtVEJSyU8mk6ubwwzBpceg/zdndOCOSHZZH82T17gVrHqci+8Ni
         tetCiXsZVP5yurD1QRPYRDa+5o210sJrHCkCDYwHK0P0+moAxSafPMp8vtYBGOtlO4h+
         c74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678994367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=90d6EZJHhEShbZuOARV563ZCCttMirKZkXghPJBLmlk=;
        b=nK/aDUJdhILrH98PfV4uPGCpKsQi7j+f6ImBw7OTqh4mQJIJMRnFgWZUHbUiDY4aUt
         U2MODTg6ForoeuJxgvywr6MQsADzsIqmIY8LgYbPGrH3eK7edOAhpkE9sJIIt6/N955j
         3JMBMbKPC4ToJxegqhmTwYD3WIAD1Vf7JtV9hZwoUcw99S+lFxasUz08ShyqzzySWo4G
         Aop+UrjXDq7f1eZIHSX6Zre12DnIh7u+pPocZHA8sCZVgMQqvO1m7LVy1+oRX4rSeDCU
         3t7cUq1m5e7d+wLCD7QB++RIthP2AAY/lwPzY/nUAM3f4frY68V3l0av0V09Bid3MMUW
         i05Q==
X-Gm-Message-State: AO0yUKXEPFRstrY7hIAXDr4RbTDUnFCrcMTYSRHN96ZQS+t4TF9YnocH
	BjyIILK9+gjVLRvTfbak5Ui6yA==
X-Google-Smtp-Source: 
 AK7set/rm7TAVGUo96+eJ+4VC45QVThvUaS6aZsQf8HKQ7yinBKnymIaUD/mNsYnsLSRS8LwInJJMQ==
X-Received: by 2002:a17:906:d96f:b0:914:859:1408 with SMTP id
 rp15-20020a170906d96f00b0091408591408mr12053924ejb.25.1678994367001;
        Thu, 16 Mar 2023 12:19:27 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id
 s9-20020a170906454900b008f89953b761sm18527ejq.3.2023.03.16.12.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 12:19:26 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: adi,adau17x1: fix indentaion and example
Date: Thu, 16 Mar 2023 20:19:18 +0100
Message-Id: <20230316191918.266312-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ZPL6NUTTF4LDEWPX7FZLB7EKMFPZW63R
X-Message-ID-Hash: ZPL6NUTTF4LDEWPX7FZLB7EKMFPZW63R
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZPL6NUTTF4LDEWPX7FZLB7EKMFPZW63R/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Fix errors in binding indentation and example:

  adi,adau17x1.yaml:8:2: [warning] wrong indentation: expected 2 but found 1 (indentation)
  adi,adau17x1.example.dts:29.3-30.1 syntax error

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/sound/adi,adau17x1.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/adi,adau17x1.yaml b/Documentation/devicetree/bindings/sound/adi,adau17x1.yaml
index 45955f38b6fd..8ef1e7f6ec91 100644
--- a/Documentation/devicetree/bindings/sound/adi,adau17x1.yaml
+++ b/Documentation/devicetree/bindings/sound/adi,adau17x1.yaml
@@ -4,8 +4,7 @@
 $id: http://devicetree.org/schemas/sound/adi,adau17x1.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title:
- Analog Devices ADAU1361/ADAU1461/ADAU1761/ADAU1961/ADAU1381/ADAU1781 Codec
+title: Analog Devices ADAU1361/ADAU1461/ADAU1761/ADAU1961/ADAU1381/ADAU1781 Codec
 
 maintainers:
   - Lars-Peter Clausen <lars@metafoo.de>
@@ -50,3 +49,4 @@ examples:
         clock-names = "mclk";
         clocks = <&audio_clock>;
       };
+    };
-- 
2.34.1

