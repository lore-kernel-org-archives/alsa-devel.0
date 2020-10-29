Return-Path: <SRS0=XEtc=EE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617B6C2D0A3
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 11:11:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7563420727
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 11:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WOTuCBvB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HM3q6a3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7563420727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C47341664;
	Thu, 29 Oct 2020 12:10:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C47341664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603969880;
	bh=B8KMotMuI3MSQVKtRu8AQG0Wh61rWg0sXCNmrbKarrE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WOTuCBvBkt7557JMrNwXcM56WJiSsROLdvYTEtLjQ1axUcm0HeiAL2IaDYNmxLnlV
	 zCx6vY8BMmb/BjUYXN9eZqs9xhHvPMPWlWR64utdayWDEFMx5FimNYwY9Gqk+R6i/U
	 04ExHq9y0yAcU9fqmY74g4HSSNjKHj2AtB0yPmk4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 054F5F804D2;
	Thu, 29 Oct 2020 12:08:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 65F00F804C1; Thu, 29 Oct 2020 12:08:54 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0E4DEF80227
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2020 12:08:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0E4DEF80227
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="HM3q6a3y"
Received: by mail-wr1-x431.google.com with SMTP id t9so2249651wrq.11
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2020 04:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Pb7xypbNoJbZw5gP7ennlwPkwkNiPmMk0DOyYJok4RQ=;
 b=HM3q6a3yJCGdXY1DBlswPFUkHxkfvm4jfKDKHbt3jmHArOSddOjmbKEoY3kMN6T56y
 FZVVmpnQhkKM6VXHY3obPjGwtTuBJ1HSjQ28T4MH3ggIbVCOnK9j6YdqSkpbMUO5TBkN
 WDPoyTzo7Tm0Dxg9xHLy2y+1S3bg7VIDL87ZwlwTsf8E9tmNGowwP5+g6Ea2SkWqOrKY
 Qrdy0Hsi5Q+O1DbFpNCEIKjkgGvm+qMPyJXm1AXm97VFTY/LC67955IM20JkiapwOqb5
 VfrRpxv386HDPvUeMaB2G05U8Q7n/L/b/magbSXBQ6gTHTHf5jM+u0VVwf/GBrIkO52v
 5mtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Pb7xypbNoJbZw5gP7ennlwPkwkNiPmMk0DOyYJok4RQ=;
 b=LaodEaRlZTHU0yuthp+VKuIOqhslWpHXrhceO/LHQGutZPDajRHmqdtAe6I+leXDKL
 lr1D8k0vRtJwYHZ3lBWXyF/5Bx3XE1eLS9UkgjtLGD7nGvzI6dd09uE9HkcXLO1+1UPe
 1I88SV4VLnRrHIm8AHO9w8xDode9wE4qD93mw3ZwuV3csluJc/O7v9cLMjOrykoE9upW
 QoeseftjzV7jLkBzBgiBSnEtDMn82mVHmq4Nc3th8kG6rGDF+P0wdZP6GaS1zJNGi85Y
 UXFPdEwrFVxvlhxZihWuCgS1U4416w8gfokw2HAEl0kg1DZuE+E1S2w9vJLrixIzbmTE
 NjOQ==
X-Gm-Message-State: AOAM532/gZ0mid1GLExKZwJ5aH3IjBuDD5ttKy/bA5OSMS/29YMte1xb
 VzJBwl82k/b8UvZnYZTxnv768Q==
X-Google-Smtp-Source: ABdhPJwsY44TbhELz8IScFVHaVqQ/MSSf0v7ECfkzqf94KE5Uk+twFQZdBNS6b6K4AR1kVCEzZqLaQ==
X-Received: by 2002:adf:cc82:: with SMTP id p2mr4949833wrj.177.1603969726157; 
 Thu, 29 Oct 2020 04:08:46 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id n4sm3710830wmi.32.2020.10.29.04.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 04:08:45 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH v2 4/6] ASoC: qcom: dt-bindings: add bindings for lpass va
 macro codec
Date: Thu, 29 Oct 2020 11:08:27 +0000
Message-Id: <20201029110829.16425-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201029110829.16425-1-srinivas.kandagatla@linaro.org>
References: <20201029110829.16425-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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

This binding is for LPASS has internal codec VA macro which is
for connecting with DMICs.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/sound/qcom,lpass-va-macro.yaml   | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
new file mode 100644
index 000000000000..679b49cbe30f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,lpass-va-macro.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LPASS(Low Power Audio Subsystem) VA Macro audio codec DT bindings
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+properties:
+  compatible:
+    const: qcom,sm8250-lpass-va-macro
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 1
+
+  '#clock-cells':
+    const: 0
+
+  clocks:
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: mclk
+      - const: core
+      - const: dcodec
+
+  clock-output-names:
+    items:
+      - const: fsgen
+
+  qcom,dmic-sample-rate:
+    description: dmic sample rate
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  vdd-micb-supply:
+    description: phandle to voltage regulator of MIC Bias
+
+required:
+  - compatible
+  - reg
+  - "#sound-dai-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/sound/qcom,q6afe.h>
+    codec@3370000 {
+      compatible = "qcom,sm8250-lpass-va-macro";
+      reg = <0x3370000 0x1000>;
+      #sound-dai-cells = <1>;
+      #clock-cells = <0>;
+      clocks = <&aoncc 0>,
+               <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+               <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+      clock-names = "mclk", "core", "dcodec";
+      clock-output-names = "fsgen";
+      qcom,dmic-sample-rate = <600000>;
+      vdd-micb-supply = <&vreg_s4a_1p8>;
+    };
-- 
2.21.0

