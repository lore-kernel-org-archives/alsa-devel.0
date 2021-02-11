Return-Path: <SRS0=wAKr=HN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C695C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Feb 2021 12:31:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EE8364DC3
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Feb 2021 12:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE8364DC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C923F16F0;
	Thu, 11 Feb 2021 13:30:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C923F16F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613046662;
	bh=PeW95ykOlZ0UCyjIk/jSfaOZbuhHW966TYBelSVLgII=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WCzd4mE1qWXo7icHgTi1yLf8rTaAnaRCKUhjlLWTmKj1Gasp78N0I0rw6CYCR8BTG
	 XTjttateGQAW1T+XN9jhzGI2jdQ07JPE1J9jlsT0GyIE9oA/KkarRWiq+Ih4fjAYYu
	 gLt32DV4H1I2v9jXnnG1d/vfOLIgqhpT+59kS6R8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EAAEFF80423;
	Thu, 11 Feb 2021 13:28:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A189DF80431; Thu, 11 Feb 2021 13:28:08 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 81AA8F802E0
 for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2021 13:28:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 81AA8F802E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="N12R1Vp4"
Received: by mail-wr1-x433.google.com with SMTP id z6so3959005wrq.10
 for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2021 04:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2yW/hk09p66uX8WS858rHDTLq5rtQMroyjmtenWxC34=;
 b=N12R1Vp4V4jY2vL511pCxty/p5pS8eH5Lp2htNYa1eQlE7UUypEBiHAedhJfIpuAZk
 9ie4lnos6r4RA3ijipYNBhsUjlblhGMuyPlg/kxKtejHR/MsVe3pLTv52gVIz9myejiF
 9IXvhiq5DaJ9WQP5GXnMPaBh1qZBnDdwIQ2BeiwMQN5HSRYe/RUGhmQo0KOYWvtPYFyJ
 L+UvHzsD+w0B7iNHzxrtDEH9im4ixC4duw0jcZOIU/g3OnANYXzNm5pVgLl3apn7tEc4
 Y+pq5twei3Sgtof5WE5KpKrdrJO9qGej0CiDGhG0s6IF6FSLZoMF/Qk6kYQIUZzhpCV8
 xA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2yW/hk09p66uX8WS858rHDTLq5rtQMroyjmtenWxC34=;
 b=VAdqi/w1uc/SpxjX7LScl76E68DbH/1l4MZ4C3HA9tHSRkCbrfWRWpITrbrbVdBbtx
 EVn9jiZRjmDUacB6qx0eWHGeMH8lu7nvBTYZLrEpWvKpDQ2vX50buKERIzqSWRIrqafv
 yWiSpsP7hGuAdkcwNGtcd/13ALXKdsJxREHfmQNK6BulUJBaScMIJ3sh1n+vUWipXUKe
 NikrdhZHawdWcQ3TRQCAkgHD1Jj7GHAFovPxDKhabnRCBHTrJfpm9Tn9VWqkHO2o8bcC
 6qQMSwQsOPXhOAbJnzh9g9bjNHyFhp7e/eKYJ3ywrEfhPP5++ByPNNZbSGEYl4qmreD5
 PfoQ==
X-Gm-Message-State: AOAM531w19Ty2DxcMF8lXRaFbpCkpZrI6anzbhzwO5nMEJ3U7UCuKSe4
 3ixgPCodeS0unMSEv5DZdaQMtw==
X-Google-Smtp-Source: ABdhPJxohTH3t7HtGznisEnUEoJoQNh+tX6fL8+RAwxyUSn40ahbaAQJ8HJvnNLUDzk9Vo5x/N14cg==
X-Received: by 2002:adf:9565:: with SMTP id 92mr5477528wrs.201.1613046482804; 
 Thu, 11 Feb 2021 04:28:02 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id d20sm4026477wrc.12.2021.02.11.04.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Feb 2021 04:28:02 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH v5 5/7] ASoC: qcom: dt-bindings: add bindings for lpass tx
 macro codec
Date: Thu, 11 Feb 2021 12:27:33 +0000
Message-Id: <20210211122735.5691-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210211122735.5691-1-srinivas.kandagatla@linaro.org>
References: <20210211122735.5691-1-srinivas.kandagatla@linaro.org>
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

This binding is for LPASS has internal codec TX macro which is
for connecting with Soundwire TX codecs like WCD938x.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
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

