Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC78C05027
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Feb 2023 18:09:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8EAB884D;
	Mon,  6 Feb 2023 19:08:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8EAB884D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675706976;
	bh=p4PK9fiV2BbKMqZAfIXByxuFG3SScP0B9yc/0rbK0Wk=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=MeLEITl7UL1P4fg99mSZwpsB0PQthjQ+YtFX/MSPgWu2lYxlZnffO19n/BJzeoqiv
	 RTyxE1bcx4e2t1GQ3fiCKHObc90S4MiOs57dUAfRc3okJt0OhyGF34ZmmAS5jNCykY
	 TcTDIjmrUaRe3U8ENwm4W+WFsvJSjg1TSa5EhPkU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8F58CF80543;
	Mon,  6 Feb 2023 19:08:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1752EF804FB; Mon,  6 Feb 2023 19:08:17 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 00A20F800F5
 for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2023 19:08:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00A20F800F5
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=li8K7Lik
Received: by mail-wr1-x42d.google.com with SMTP id i5so4039629wrc.0
 for <alsa-devel@alsa-project.org>; Mon, 06 Feb 2023 10:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tn5oHPpbipDMcz7STqyrZPY8+V7f853nhQ3tf36w4Eo=;
 b=li8K7Lik3LGY7JOaQ7GiUdzLXPHgOnG1lFTZlz8/YpiYdkE/lkZGLo6epPXMts6GON
 kBwXRaV1MYXx6zDSdCrsdad/d8JLDqpubAbNtkrJLpwRRp6tCK0cSZDCV+2bqAIFew+j
 bip60U5h8FtqNzjDABYqo6+7U+ZX2DQ2bWqCrcEFTD9Rm5jKt/0cxfodJPbSDjcan/Pu
 ckM62PF2lTwyBYmiONAK5dENFmT1hBy1No3p7FN35GD+YKISb3ag/ses6i37SbulBoQR
 bZdFco0aGOq7yYqhl4zsb3v4w8SzXPq7b79ilbjmKJ9soli9twQinp0rKHGB6r2ICtdL
 bjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tn5oHPpbipDMcz7STqyrZPY8+V7f853nhQ3tf36w4Eo=;
 b=AEd2YfUaF55RV69pdr4iI/bGl+MM02ffJHkf+BJ1pTxlQFkAD+DwwCOXd7uGeSbO1X
 hFeKuipf4FlNgKbiNGLoIqWQmAFs+KfxrdipWQRYnMQjdN3fVZUjBzZrUV50ZJhkFlmq
 biQj8KXI4lgYKCHy4xGlQ+yBCg/B9tcNhPs3TRH8B9D9uHZXGK1F+8GPq3XnzQRMlxmy
 ssbZlm9hL14lLIVGYYJnE3Tkd6Vr38zRGub1hZxbQi9Q5xxBbG/xbdr4gu71T7VJAsPc
 o2/jEcFytzfbO1PJoysQ1f3/IA/1S33UBDhwdGJFSU4UlxtZjRe7gR4pd1ySxWVK+1lS
 Z+YQ==
X-Gm-Message-State: AO0yUKU5WMQhXm4yyLcM5kHqVPkB4sHTDXhO+a2GrRigTXreoE1lUwct
 bmFrR1PXOfxwgumc+CROWpGkAw==
X-Google-Smtp-Source: AK7set9dnqk2147Pm0mc3fAGlCuyJDoc1kM1Q9A0N2U32IxhrwhVkkjlG7LBYt4A8Oy8QWwh5NAw0w==
X-Received: by 2002:a5d:6805:0:b0:2c3:eda4:adde with SMTP id
 w5-20020a5d6805000000b002c3eda4addemr2518807wru.53.1675706890160; 
 Mon, 06 Feb 2023 10:08:10 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144]) by smtp.gmail.com with ESMTPSA id
 d18-20020a5d6452000000b002c3f1214e33sm365451wrw.100.2023.02.06.10.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Feb 2023 10:08:09 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 2/3] ASoC: dt-bindings: qcom,
 wcd934x: Describe slim-ifc-dev
Date: Mon,  6 Feb 2023 19:08:04 +0100
Message-Id: <20230206180805.6621-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230206180805.6621-1-krzysztof.kozlowski@linaro.org>
References: <20230206180805.6621-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The "slim-ifc-dev" property should not be just "true", because it allows
any type.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
index 184e8ccbdd13..39b27126cfc1 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
@@ -28,7 +28,9 @@ properties:
     description: GPIO spec for reset line to use
     maxItems: 1
 
-  slim-ifc-dev: true
+  slim-ifc-dev:
+    description: IFC device interface
+    $ref: /schemas/types.yaml#/definitions/phandle
 
   clocks:
     maxItems: 1
-- 
2.34.1

