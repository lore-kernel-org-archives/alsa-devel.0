Return-Path: <SRS0=v4AK=LB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2947FC47082
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 15:31:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9118E61164
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 15:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9118E61164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 40734166F;
	Mon,  7 Jun 2021 17:30:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 40734166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623079857;
	bh=fiqr3x3sbQuzQ8Z4mrijPyg0tgafBA8JLWPfhcDO75A=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ufVsLHKaYxTaHHBbrvqsf88bSubMH58bm0OFd/qiyZmoWl1JoEsPKcix1FG08A+2f
	 BQyomEmXX/lzIcUUzcKAsTN9tdWxfnbMnWJmt8uFGHthfLPuHEdIc6WDar9a1TAqu7
	 X+Kpy4fSW6tdTXAx9lK97R7ZgsdWaWYTJiVRNm7s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2CA40F801EC;
	Mon,  7 Jun 2021 17:30:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DB243F804CF; Mon,  7 Jun 2021 17:29:19 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E1D62F801EC
 for <alsa-devel@alsa-project.org>; Mon,  7 Jun 2021 17:29:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E1D62F801EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="tJomgDBc"
Received: by mail-wr1-x42a.google.com with SMTP id y7so13473109wrh.7
 for <alsa-devel@alsa-project.org>; Mon, 07 Jun 2021 08:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vhIJnb1mQgSu0gmVypIYBdkC4S9c9PzuSNZQUQzKNNY=;
 b=tJomgDBcK0JlDDBHG5N4A3BmQEbquxf/O+e92BfCz1qRVRtleR1Gts4Bcopx/S8yPc
 PSeQZgiL1dD1/JGrQ4BFWbn5oTDzImnqmkHsaiklkOHGP+QZt1np1zwzHgj7a8lRGfz7
 jFh8V2AgiF3Al1+38L+Tuh/iFpimcfMzdLjgyNrL5R3n+lkl3G/c78MzwQxYo5zLWBed
 Qk/uSVj/DKFcEeqVMw6xM5ffu2RN0ZHw8P1Gr0nrFOk3H6gqFsKnxUK7obO3YHHikvCi
 munwdxAkLd+ePvmnY3wBDKUs582u9syKeh/2EyzUyt4PMfTxtNl5FzL/hlTNwHDPB/46
 kM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vhIJnb1mQgSu0gmVypIYBdkC4S9c9PzuSNZQUQzKNNY=;
 b=gn9qP0PBajNKAe11LMFhTUBsgTcaBvdeQE+17jFZZPZB3XRTYs98Dva1hhaRifALZB
 XWlCrD9LS1nKYaIaxw5lvo0gUIlEVdR6O6b7oEnfUa2Af+36Fq2bWHy41YPezbz2e2M5
 arEj78eyIybS2HUxVsETIdQiDTPrK5N5cy92hulaN4QsGGYRS+6CThJ1aiM3eFQTz0sb
 BgmSLrE+OISnZfF7vXe/A/FX9KQ+NdEQ1GkULSM87D3mdTeUseb2gP/lchJRj5MMqVKT
 BVi1demmbnJQPIKJC2ZRDFUK9gkkOjW3uteDVj5mA+cI1PuHMtfAXW/jaZUvwkLUXU/z
 fqrQ==
X-Gm-Message-State: AOAM530Pgm8kNCuKGrxA/7Rk95kKPJ/A+4pFK5emm+zi7wEWnBTDUkZw
 0HktFPFC8lkfhFizWaCtrroBOg==
X-Google-Smtp-Source: ABdhPJxNjr+z1V7LeyDaphGfhZjV6FSkbENIz0QIxQc48rGOBMJhjuXyt948w4Tu+t6N1YbdGRa2Sg==
X-Received: by 2002:adf:f98e:: with SMTP id f14mr17786882wrr.408.1623079740401; 
 Mon, 07 Jun 2021 08:29:00 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id q3sm16370170wrr.43.2021.06.07.08.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jun 2021 08:28:59 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: bjorn.andersson@linaro.org,
	broonie@kernel.org
Subject: [RFC PATCH 01/13] soc: dt-bindings: qcom: add gpr bindings
Date: Mon,  7 Jun 2021 16:28:24 +0100
Message-Id: <20210607152836.17154-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210607152836.17154-1-srinivas.kandagatla@linaro.org>
References: <20210607152836.17154-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: robh@kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
 devicetree@vger.kernel.org, tiwai@suse.de, lgirdwood@gmail.com,
 plai@codeaurora.org, linux-kernel@vger.kernel.org
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

Qualcomm Generic Packet router aka GPR is the IPC mechanism found
in AudioReach next generation signal processing framework to perform
command and response messages between various processors.

GPR has concepts of static and dynamic port, all static services like
APM (Audio Processing Manager), PRM (Proxy resource manager) have
fixed port numbers where as dynamic services like graphs have dynamic
port numbers which are allocated at runtime. All GPR packet messages
will have source and destination domain and port along with opcode
and payload.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/soc/qcom/qcom,gpr.yaml           | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,gpr.yaml

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,gpr.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,gpr.yaml
new file mode 100644
index 000000000000..cc08ec51de6a
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,gpr.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/qcom/qcom,gpr.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Generic Packet Router binding
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  This binding describes the Qualcomm Generic Packet Router,Shared Memory Manager,
+  used to send and receive packets between Audio DSP and Application processor.
+
+properties:
+  compatible:
+    const: qcom,gpr
+
+  qcom,glink-channels:
+    const: adsp_apps
+    description:
+      glink channel associated with gpr function
+
+  qcom,gpr-domain:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 3]
+    description:
+      Selects the processor domain for gpr
+        1 = Modem Domain
+        2 = Audio DSP Domain
+        3 = Application Processor Domain
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+#GPR Services
+patternProperties:
+  'gprservice@[0-9]+$':
+    type: object
+    description:
+      GPR node's client devices use subnodes for desired static port services.
+
+    properties:
+      reg:
+        maxItems: 1
+        description: Service port id
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - qcom,glink-channels
+  - qcom,gpr-domain
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/qcom,gpr.h>
+    gpr {
+        compatible = "qcom,gpr";
+        qcom,glink-channels = "adsp_apps";
+        qcom,gpr-domain = <GPR_DOMAIN_ID_ADSP>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        gprservice@1 {
+          reg = <GPR_APM_MODULE_IID>;
+        };
+    };
-- 
2.21.0

