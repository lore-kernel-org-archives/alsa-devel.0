Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F83ECAAD3
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Sep 2022 10:21:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 49F3A16AE;
	Wed,  7 Sep 2022 12:20:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 49F3A16AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662546077;
	bh=KQWPkD12Rs7o8LNa474rxh7DzkidhXlStJCX4fjFzso=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DjB/6X7XqHH8U6QEc59cjH+v3LusAfI8iNFhO+yN+Pdj338bGqejy0GHnODiYMSTA
	 kl7Nwtkwt+tglx7hzitLDq908TqteTM6VoLh32rsxrLqR0laUZWgocW5Pu2qxuDXX6
	 NYhjRxPQXOUnhup8pS3Ui28IEUkOAdMhs3L8axPY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 13665F8057F;
	Wed,  7 Sep 2022 12:16:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2F55FF8057F; Wed,  7 Sep 2022 12:16:44 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E452BF805AB
 for <alsa-devel@alsa-project.org>; Wed,  7 Sep 2022 12:16:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E452BF805AB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="SqYGb2Sg"
Received: by mail-lf1-x12c.google.com with SMTP id bt10so21697258lfb.1
 for <alsa-devel@alsa-project.org>; Wed, 07 Sep 2022 03:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=RR3PjHV9nmH/GbIhDoQ0i32DEOxqy1Cnfemy+zsHX2M=;
 b=SqYGb2SgUnHjteGhc8NyokrY/38tgAr0fl5azwYi3dQL4RVhNvyLC8pdKB6kdq+hTO
 d5RZ6EfJPA9+LkKSmbv1gKKIZeEmpdR1UqoJ6CPDG3wBfgU4MzXXOQMksXsLfLsq2zku
 3RJxa4McHvggTOEWIb/tbjWSgQHLZTXlos3o2+IwtGosQV/xuRDpRUoVzta5Zl4/T3bE
 /sRGCP2tjz91SpHg82OgRzWZZrugB5AxybUo1khCBEqN2rC9xH0U7yhpkM4FA2WQe4Go
 kDYU6s3aHcwY7iNg4Fu8cDpxZz6Sw/iSZ7NTDgfhifBPVP9VEp1gtDMnG21gtiLjiyVA
 W8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=RR3PjHV9nmH/GbIhDoQ0i32DEOxqy1Cnfemy+zsHX2M=;
 b=6YbMlunVPNB17vkdw7w2jgCcJSPF0LsFYkekEsC3mRdrkGUR8uqmgog4QclnDGaQkE
 JhVA8rT42x3fPba3F3/PJBW2b0XF1gDmJqFb7kTnU+oIAj7IjnijIyo84GAKTL8yhrdm
 hfyRSv9qbahxrZ3InjCVdAHOiH7uFPbmIkDROZNJ3nQ3HdMHJiooXq2dc1OBlpsP3Cy4
 O0P1abT7RuC152CrVVh9PBsMr9ueP4Z2NZUKO5HIbai1X8cZ8WB2zPFS1szbnSZvvJF7
 yV1wxZfRnJqUBDSr7so/eMYykK8gleOsgRSf6UO+Y3vak+SOeZGWKEd3W8xW6dRjRh0j
 Dqqg==
X-Gm-Message-State: ACgBeo1NPZkSL318MnCaXtAv5dJRAVXgJw9IdZTTNTmpb7jE1hhTuyZ/
 1ruVc+1MUYeEvpmu/0dds0psgQ==
X-Google-Smtp-Source: AA6agR6DyUOR+dEKXcroet8OSjPW5hDJTdHMyxeQlbulwrF+Cf1t0W2pj2y21Qq1pTGqu8uHmK0r5w==
X-Received: by 2002:ac2:4901:0:b0:494:88dc:7efc with SMTP id
 n1-20020ac24901000000b0049488dc7efcmr843550lfi.408.1662545783806; 
 Wed, 07 Sep 2022 03:16:23 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
 by smtp.gmail.com with ESMTPSA id
 u9-20020a2ea169000000b0026ab0e480bcsm960734ljl.39.2022.09.07.03.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Sep 2022 03:16:23 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH v2 14/14] dt-bindings: soc: qcom: apr: add missing properties
Date: Wed,  7 Sep 2022 12:15:56 +0200
Message-Id: <20220907101556.37394-15-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907101556.37394-1-krzysztof.kozlowski@linaro.org>
References: <20220907101556.37394-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

The APR bindings were not describing all properties already used in DTS:
1. Add qcom,glink-channels, qcom,smd-channels and qcom,intents (widely
   used).
2. Add power-domains for MSM8996.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/soc/qcom/qcom,apr.yaml           | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
index 5b9b9c86e61f..02a261ace221 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
@@ -20,6 +20,9 @@ properties:
       - qcom,apr-v2
       - qcom,gpr
 
+  power-domains:
+    maxItems: 1
+
   qcom,apr-domain:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [1, 2, 3, 4, 5, 6, 7]
@@ -52,6 +55,26 @@ properties:
         2 = Audio DSP Domain
         3 = Application Processor Domain
 
+  qcom,glink-channels:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: Channel name used for the communication
+    items:
+      - const: apr_audio_svc
+
+  qcom,intents:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      List of (size, amount) pairs describing what intents should be
+      preallocated for this virtual channel. This can be used to tweak the
+      default intents available for the channel to meet expectations of the
+      remote.
+
+  qcom,smd-channels:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: Channel name used for the communication
+    items:
+      - const: apr_audio_svc
+
   '#address-cells':
     const: 1
 
@@ -171,6 +194,30 @@ required:
   - compatible
   - qcom,domain
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,gpr
+    then:
+      properties:
+        power-domains: false
+
+  - if:
+      required:
+        - qcom,glink-channels
+    then:
+      properties:
+        qcom,smd-channels: false
+
+  - if:
+      required:
+        - qcom,smd-channels
+    then:
+      properties:
+        qcom,glink-channels: false
+
 additionalProperties: false
 
 examples:
-- 
2.34.1

