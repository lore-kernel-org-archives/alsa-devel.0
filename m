Return-Path: <SRS0=+sGq=OL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FADBC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 13:47:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B93CB61131
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 13:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B93CB61131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F17F6169E;
	Tue, 21 Sep 2021 15:46:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F17F6169E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632232036;
	bh=FTNshx8mgD/4dsjBE7iHgoCsCH/9Xhlk/9MW2GTlrRw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QCAt1wQeRy0KdSh7SuX29o3ervAHT9WWQhKlu8mApEnsaQPp+OOoJqCWzZBk4I/LZ
	 wDsMrC2xnli97VbsaUY9NtZ9KG/z8sNybLXJjMYpWC0ybyNLo6l5VWN71MoeJXuPsi
	 Ydp2cUHAC/6WG7S7EEH1DFTX8UVF0wM4TsJYdknQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D226DF805BB;
	Tue, 21 Sep 2021 15:39:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9ED5EF805A8; Tue, 21 Sep 2021 15:39:53 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B3A3FF8057C
 for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2021 15:39:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B3A3FF8057C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="asG8G0Cy"
Received: by mail-ed1-x535.google.com with SMTP id c21so73130646edj.0
 for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2021 06:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0TebeQ0TXJpETl5yyZtrFs6HbXMx9cchKOW5rtUhE/g=;
 b=asG8G0Cy7N6oDlz+uZjY3tkYV7m6YfYA4UitzcWyLH0oFiUbnRybNZ0jfkY9zjDbTc
 2GwV1NM+OoeZHhCbS1A+rCxSV5iFrbyV5HKQ6dL+rPIQLdz/hnlp1wHJuDiglSj++5be
 nKHIagQSJgr85q9oYHhBlazj5QOtIDR0N+cRhk88JsraatQD9UQwipHlpPVErx08o6xL
 XartguHfkooEy0tYpL0DNYMU7t0e84ac7Pa5+1XEKllDjccC7V3ahQDyMpBbLAgKVPc6
 xHtrDCENsORxikIyK+5RXmudKn7B130vZEYJZi0SJ3pTrpA0oAHgrWO3wvcrlD+8Ym8F
 Zq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0TebeQ0TXJpETl5yyZtrFs6HbXMx9cchKOW5rtUhE/g=;
 b=A2kEtsKoKI/efI79PKZ8AXTHiClrdDfFv7MSwyrST41XNMu9AHfY7wWG643vtfzGkA
 /5L8gt2KPSy8EJ+UOq3oy0/TMMEVB8HjAPCFMaQ+9SulEyMcq+xvV/LvzTuZfu8LihPK
 F1gbD6/Xp8yJEdde2Qt1508+H/FNXuLXrs92jN2ZygdWgQoKdEOIx5kn+1ZBDE2WkfKR
 zj2nFeVrByPjT8n2Y39eTmYL3CWdHsQU84Zo/TkbQodUti7pyTSG7vlaSRiQ/jn1cA+9
 60xoVdACvivgNm+1pDl7zM6NICb1XqQLnAR2zmUkBV/xLZHc7dLAi3lIaghqEBYZMHIR
 mGpA==
X-Gm-Message-State: AOAM531BNbAHV4RJr2gS/FLRFPjJ98s9hnSiCTUSHedrkAdio0x1gQns
 e3y9RBpfp+1kfdf45Oib3EybzQ==
X-Google-Smtp-Source: ABdhPJyJIhR6Fkv0gjSorfwETvJDf9crA2rKm6C//0VTBuSQJckctgW428NOy4bAUwO347jqWwcVVQ==
X-Received: by 2002:a50:da0a:: with SMTP id z10mr7383569edj.298.1632231460397; 
 Tue, 21 Sep 2021 06:37:40 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id b3sm7915799edx.55.2021.09.21.06.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Sep 2021 06:37:39 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: bjorn.andersson@linaro.org,
	broonie@kernel.org,
	robh@kernel.org
Subject: [PATCH v7 11/22] ASoC: dt-bindings: q6dsp: add q6apm-lpass-dai
 compatible
Date: Tue, 21 Sep 2021 14:36:58 +0100
Message-Id: <20210921133709.4973-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210921133709.4973-1-srinivas.kandagatla@linaro.org>
References: <20210921133709.4973-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.de,
 plai@codeaurora.org, pierre-louis.bossart@linux.intel.com
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

on AudioReach audio Framework access to LPASS ports is via
Q6APM(Audio Process Manager) service, so add a dedicated compatible
string for this.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../sound/qcom,q6dsp-lpass-ports.yaml         | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
index e6148c17419b..dc7fba7b92d5 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
@@ -16,6 +16,7 @@ properties:
   compatible:
     enum:
       - qcom,q6afe-dais
+      - qcom,q6apm-lpass-dais
 
   reg:
     maxItems: 1
@@ -169,6 +170,32 @@ examples:
               #size-cells = <0>;
               #sound-dai-cells = <1>;
 
+              dai@22 {
+                reg = <QUATERNARY_MI2S_RX>;
+                qcom,sd-lines = <0 1 2 3>;
+              };
+            };
+        };
+      };
+  - |
+    #include <dt-bindings/soc/qcom,gpr.h>
+    gpr {
+        compatible = "qcom,gpr";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        qcom,domain = <GPR_DOMAIN_ID_ADSP>;
+        service@1 {
+            compatible = "qcom,q6apm";
+            reg = <GPR_APM_MODULE_IID>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            q6apmdai@1 {
+              compatible = "qcom,q6apm-lpass-dais";
+              reg = <1>;
+              #address-cells = <1>;
+              #size-cells = <0>;
+              #sound-dai-cells = <1>;
+
               dai@22 {
                 reg = <QUATERNARY_MI2S_RX>;
                 qcom,sd-lines = <0 1 2 3>;
-- 
2.21.0

