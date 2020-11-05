Return-Path: <SRS0=j4zi=EL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12383C00A89
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Nov 2020 11:36:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D59A2206FB
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Nov 2020 11:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qZbpjNVS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bg8F75qD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59A2206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC9331681;
	Thu,  5 Nov 2020 12:36:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC9331681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604576212;
	bh=9RC/mHGJYJfqjWsO67lG+hriR1tFWKimqofYozqfcjc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qZbpjNVSX7HcTBhbzn1SBsGvlun9cjX50yw7KCf1inQQgUAiY4bkf14oZDtVbmsJU
	 +0zb0agh4/S1fggYPvPpV2Q+90s/gKk/77Qfz+P4dACjcrndQcMC5NLvf5/LCWylFb
	 YQE1kyHQ/fmbbKZrU4ZACDUzwaV6bDVTE920O8cg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 952CBF80245;
	Thu,  5 Nov 2020 12:35:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0B615F802A9; Thu,  5 Nov 2020 12:35:10 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5E430F800BA
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2020 12:35:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E430F800BA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="Bg8F75qD"
Received: by mail-wr1-x430.google.com with SMTP id w1so1362403wrm.4
 for <alsa-devel@alsa-project.org>; Thu, 05 Nov 2020 03:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O0nELbaPuoZuw7n2kK2InfOxpklKvuZiw/YN5nvB5ZE=;
 b=Bg8F75qD1t0buJgZKe3m9CAY34R3lRU5P+FXqaEhjCHOiR5eMBjVjVFVS/rJawUAR8
 QWqQ+vM9Y+FcdhPadGSRi2xROAO+lbNEQCG/ZvaI/K8VyZ42gfQ+Oo8fPLvkc3tIG3+7
 4p9FjBnCU9bv5p0SEpQm2OL9rY4DYdMDq2fFdBZwSl+Ruir8M0MpUVzHT14NotN5fkpz
 G6ljSC+cIqCt94LxmIWpfBHobl5ox8BZPAq5HDVLL1g+NAclZ/R1jBiOI61zBzVu2dMH
 F1ElPylLigyp3PlkyR945L8g+9/wjSBCwgUs89MKlX/HBtx/kzuagSwo7czDqZ8ik7g+
 ByVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O0nELbaPuoZuw7n2kK2InfOxpklKvuZiw/YN5nvB5ZE=;
 b=t0OoSb85YmffuIHStehFhI4MZuEJqqHdGA6PU+AzekZxFgVVODyCweC+sJycic0g5E
 z4QRR4MNOHoBW4H8WAsfzJCTR8kIEy3V1/8k0WztPD1FDMNiEIFclVaNJ9Z1B5fR7cdt
 VukN6OVZ9a+n9IdEe5Sm5r58l1IIA7Utt4k7x7SdH/aJ7NFHSoH+xZ8nRJNTaui9DLb6
 StCGwnx2PXu6YBlsmzHfAw/1IR+6Qsd8SlxR24V9/LLReGqyT9RRoEYw6HAUGw5IxrLz
 H1ZEPY0IcNSARqoF6Ia49PqNNiK1Ro/XLR97PESFwplYa9ERJrHUD8K0BundDUHiclIo
 smWA==
X-Gm-Message-State: AOAM530j05QXTXsGM2Acik1jJZ3bROn01RvH+p8fWKpqJVA/pHEIRWxD
 LLeFsVNddyOiicVH6vXwRYExpg==
X-Google-Smtp-Source: ABdhPJxTVmVQUrNEA4GTeoFaIN01h8QI27hO2N2sXTb+CiyJJUppgxi+Aebf0Vpo0haN3OnpMj0Oxg==
X-Received: by 2002:adf:f3c7:: with SMTP id g7mr2576474wrp.394.1604576103192; 
 Thu, 05 Nov 2020 03:35:03 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id t199sm2096129wmt.46.2020.11.05.03.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 03:35:02 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH v3 1/6] ASoC: qcom: dt-bindings: add bindings for lpass wsa
 macro codec
Date: Thu,  5 Nov 2020 11:34:53 +0000
Message-Id: <20201105113458.12360-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201105113458.12360-1-srinivas.kandagatla@linaro.org>
References: <20201105113458.12360-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Rob Herring <robh@kernel.org>, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
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

This binding is for LPASS has internal codec WSA macro which is
for connecting with WSA Smart speakers.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/sound/qcom,lpass-wsa-macro.yaml  | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
new file mode 100644
index 000000000000..435b019a1e3d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,lpass-wsa-macro.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LPASS(Low Power Audio Subsystem) VA Macro audio codec DT bindings
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+properties:
+  compatible:
+    const: qcom,sm8250-lpass-wsa-macro
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
+    maxItems: 5
+
+  clock-names:
+    items:
+      - const: mclk
+      - const: npl
+      - const: macro
+      - const: dcodec
+      - const: fsgen
+
+  clock-output-names:
+    items:
+      - const: mclk
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
+    codec@3240000 {
+      compatible = "qcom,sm8250-lpass-wsa-macro";
+      reg = <0x3240000 0x1000>;
+      #sound-dai-cells = <1>;
+      #clock-cells = <0>;
+      clocks = <&audiocc 1>,
+               <&audiocc 0>,
+               <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+               <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+               <&vamacro>;
+      clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
+      clock-output-names = "mclk";
+    };
-- 
2.21.0

