Return-Path: <SRS0=8vjL=HK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062EDC433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 14:21:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41DF064E6C
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 14:21:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DF064E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B610D1698;
	Mon,  8 Feb 2021 15:20:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B610D1698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612794105;
	bh=q6YNvbktcqe/3+uMVir/pSc2XEQDqkgVUaZDOHK4d6k=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AreEG+Y3un4r5exbYalDUgUMOR5NWHkhz62NC+SnemY90QkQY/ki4aR4hZ/yacCwr
	 Ewq1Iot0r12Xs7UXexCvOchXrIrM5lLfQDLKAidRDunulJIOJwRd4xH9dFkhbDXVhx
	 ZodwCiJv2kJA8ZlYzgfmS5bjiHTwZ1SN05rzrx4s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7AD4FF804E2;
	Mon,  8 Feb 2021 15:18:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74A02F8027C; Mon,  8 Feb 2021 15:17:49 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0FBDDF80290
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2021 15:17:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0FBDDF80290
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="jV8Z1ig+"
Received: by mail-wr1-x42b.google.com with SMTP id r21so1091383wrr.9
 for <alsa-devel@alsa-project.org>; Mon, 08 Feb 2021 06:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=y4A5Uf4Os6WPGl/YWHkNN/4TU8yF2iW13SGgEG1fF60=;
 b=jV8Z1ig+Su7OIrGcQaFNH8CIZy9+023ye/zVak11ID87bCZCHtCeozlxFNBqIEIU3K
 zNUb8jFukFI/sqSK7cOBTRhCrtg0vZ0lbi9cGnu8LmiVIk3w+zmsbom+7pEzQIDCrfIo
 COWkndOu8X8uD77Rv+Jhhcd2fgqzWzxbQwXipJe7VMaDrzCIc8W/AIIxgJim9aflfvtf
 AgWG8fcIa94jiNpHL7KaiutAoO/PpSeyO7CXhB2eN/fM+dQZe0krntFdL4QgylIT6Ep7
 O7IqeN9l4MObVhnyhDRK1s6tXSJAm7zScAtUNIZ39zd7qpYU5ESeqWTWUpKDPc66XaCW
 b5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y4A5Uf4Os6WPGl/YWHkNN/4TU8yF2iW13SGgEG1fF60=;
 b=n6ip3SaCboru8Yu1SmAZvun7Qpwkr5KHz175M4UutqAZUlG/7dgMUJrM3YkoeX9jjC
 bRShCI/m9tm4B9iZeeQ4/vz5UsRHtoL90kAWjXTvcuG0ncY4tKxgglmMw+atCQxH9DjD
 8NES7YxDnRGEBa0bH24URlnyBdxiN97qpaszrB/bnhaf6wdjtkD6Z6YCD+xE0VEvMRjC
 79SdhIvCOxQ6Dcp9zi9cbVSNVSUuFZujY9GG7uJYiuZfnffFXYOGKgAYVcizKgCze3Gq
 O38cKb95JwvlJs5eqF6I4DIA4WHba7z2j4Ry0862XTqCgboVUW3R4c5xu75QIGz9D8Ul
 29Mg==
X-Gm-Message-State: AOAM53279K80cgoiSjgP242fftUsTxkoChzjfxBPL9YPjOyGpi4iNQ2O
 e59YbDi/OVzV3S0mSM+OhXF6Fw==
X-Google-Smtp-Source: ABdhPJxGGgwhHrnK38ud1EOpjc6OdajzbB2uaUeOkwnXljXr6KEbJBJxZzRPw7qtb3ok3crsEsOnYA==
X-Received: by 2002:adf:b749:: with SMTP id n9mr19880629wre.267.1612793853741; 
 Mon, 08 Feb 2021 06:17:33 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id t18sm27949809wrr.56.2021.02.08.06.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Feb 2021 06:17:32 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH v2 5/7] ASoC: qcom: dt-bindings: add bindings for lpass tx
 macro codec
Date: Mon,  8 Feb 2021 14:17:17 +0000
Message-Id: <20210208141719.23305-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210208141719.23305-1-srinivas.kandagatla@linaro.org>
References: <20210208141719.23305-1-srinivas.kandagatla@linaro.org>
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

This binding is for LPASS has internal codec TX macro which is
for connecting with Soundwire TX codecs like WCD938x.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/sound/qcom,lpass-tx-macro.yaml   | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
new file mode 100644
index 000000000000..6b5ca02ccce4
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,lpass-tx-macro.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LPASS(Low Power Audio Subsystem) TX Macro audio codec DT bindings
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+properties:
+  compatible:
+    const: qcom,sm8250-lpass-tx-macro
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
+    codec@3220000 {
+      compatible = "qcom,sm8250-lpass-tx-macro";
+      reg = <0x3220000 0x1000>;
+      #sound-dai-cells = <1>;
+      #clock-cells = <0>;
+      clocks = <&aoncc 0>,
+               <&aoncc 1>,
+               <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+               <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+               <&vamacro>;
+      clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
+      clock-output-names = "mclk";
+      qcom,dmic-sample-rate = <600000>;
+    };
-- 
2.21.0

