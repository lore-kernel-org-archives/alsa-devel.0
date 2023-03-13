Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41523C6FD19
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Mar 2023 07:59:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2995B1488;
	Mon, 13 Mar 2023 08:58:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2995B1488
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678694343;
	bh=5gHnFM4rOILAVgKBZEHdZoPHi9yJjJVg8IX+esrrYSc=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=GcmCtVFI/q28K1iyQkVqwfvvBzRbTQSyIPnSfO6XsN2UzlJr6kFqRv5p6ztZwMRmA
	 GKqQyZyxOjLKEJnjJ7Ue881RDGGx+j6VRAoZv750zB6oO1cvqM0ypgO5glLxU+oZrr
	 qyTsJPTayMhQrr9uSNp9Xy5wl4KRIvPGiYKnEZCg=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D33DF8053B;
	Mon, 13 Mar 2023 08:57:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1C1BEF804FE; Mon, 13 Mar 2023 08:55:11 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8C547F80425
	for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2023 08:54:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8C547F80425
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=X7IETnH6
Received: by mail-ed1-x52e.google.com with SMTP id er25so16785996edb.5
        for <alsa-devel@alsa-project.org>;
 Mon, 13 Mar 2023 00:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678694095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDF0ZYXFDOllcKLsEzC0jJ5Ov6N9QuMsH10mVyhVQIQ=;
        b=X7IETnH6CFfAF+cv4+iEYutn/JFK96OrOPqlr2bDrSNLdlVGTWojg/IC4IYNp9jVhK
         LCp3GUK68M8n2ysNlF5WRETvc8KwayULthNs/xyTLfvIGrvH1iR+tLSiAIJZvgVv0a8a
         7yKSt9Br5/Sh14bbEw5hmCUBQoB8JcKeDPU3rBv3N4ANzZzOuSqP5iY5EItjykG9QW4D
         TE5h8pBlUIOrUmcshxYGggFyuw7DbqtOglOkieHjrNG5X7qsUIMpDngugsOpFI1MYXTe
         BGpLHVVgiC15OJVvgIBW6/PH6B1RRjblT/wpciCKW23yR2YIBrhfsK5fc4f180wPCMlG
         ujkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678694095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDF0ZYXFDOllcKLsEzC0jJ5Ov6N9QuMsH10mVyhVQIQ=;
        b=hDcQ5tauB5BnBEfm73WBo9V5VUni//O4T3EY52Dc9P6KZkDyb8w3vkCKT1osArZteX
         juotDp+9keoCZZg6WY4jPv0e5ZtnmyurGxpVyUbr3QnzbXO1mSvSTv1hROt6VgbVOqGv
         29qTQoOOhWbjt7dapCV+3rLUmAum/lVoFPaCY5xXiA8J6z6rQKDcVAr81NudTYkBX92o
         +yNpgQoTYeESCEZ3hhz1xtKbU9jEqn+jqxpipmzxQiM2ZOnv8ycXza1+rkmQdzl9Evkn
         7py2JEp7G93Ec3FiG6YvRvirm2zXqoXcyG1h5YgtUEwTmn2F77Hf+wkpoXCyGFi9en62
         MHlQ==
X-Gm-Message-State: AO0yUKWOKIP6NjlxYckATXE3JO0ptE+9QU70Oo2ymoIZSduDfs/AmLkK
	FupSLaCFeH9LDLXe35ju7XA8/Q==
X-Google-Smtp-Source: 
 AK7set/5k1GfTFtBWwJKweA6AzuLqCq0Rpe5GmAk/7GLC53Qn/d/VV3OKEJrtgKjXechPHpjExU3eQ==
X-Received: by 2002:a17:906:5594:b0:928:796d:71e8 with SMTP id
 y20-20020a170906559400b00928796d71e8mr2805289ejp.3.1678694095545;
        Mon, 13 Mar 2023 00:54:55 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:f052:f15:3f90:fcb3])
        by smtp.gmail.com with ESMTPSA id
 g7-20020a1709061c8700b008b980c3e013sm3146943ejh.179.2023.03.13.00.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 00:54:55 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/9] ASoC: dt-bindings: qcom,lpass-tx-macro: Add SM8550 TX
 macro
Date: Mon, 13 Mar 2023 08:54:41 +0100
Message-Id: <20230313075445.17160-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313075445.17160-1-krzysztof.kozlowski@linaro.org>
References: <20230313075445.17160-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: LAMPWWUJVLRXJ6BAUKSZAYUNJQ4DBYHE
X-Message-ID-Hash: LAMPWWUJVLRXJ6BAUKSZAYUNJQ4DBYHE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LAMPWWUJVLRXJ6BAUKSZAYUNJQ4DBYHE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add the TX macro codec on Qualcomm SM8550, which comes without NPL clock
exposed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/sound/qcom,lpass-tx-macro.yaml    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
index 559da2509d8d..9d6e67524daf 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
@@ -15,6 +15,7 @@ properties:
       - qcom,sc7280-lpass-tx-macro
       - qcom,sm8250-lpass-tx-macro
       - qcom,sm8450-lpass-tx-macro
+      - qcom,sm8550-lpass-tx-macro
       - qcom,sc8280xp-lpass-tx-macro
 
   reg:
@@ -96,6 +97,23 @@ allOf:
             - const: dcodec
             - const: fsgen
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm8550-lpass-tx-macro
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          items:
+            - const: mclk
+            - const: macro
+            - const: dcodec
+            - const: fsgen
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1

