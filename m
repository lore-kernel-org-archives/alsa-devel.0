Return-Path: <SRS0=nO8j=OR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABCEC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 14:01:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C44AD61002
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 14:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C44AD61002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A9A116AD;
	Mon, 27 Sep 2021 16:00:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A9A116AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632751294;
	bh=+e8dvEgXvMvi1kon22tMa51uyw/ukVGI/s19D5VXDhg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TYPKeJYI2je6gWVkPPG7YT02pVIY0jok+RlqOEgLQFVfzYCYYoRy3ewqfx+0NUBnN
	 cAy2R1MrnzxoanHMkHxqtMCwnzh1V3XI1yb4/GkzBcWCaX23yNLZ4G82vc7xSE2yoq
	 ixFSlaua4RQthiNLxpp2251VOqrkiXcom+Pcis5w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9EA71F80549;
	Mon, 27 Sep 2021 15:56:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AC1C7F80524; Mon, 27 Sep 2021 15:56:50 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1CEECF8050F
 for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2021 15:56:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1CEECF8050F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="QhW2b23S"
Received: by mail-wr1-x42f.google.com with SMTP id k7so236234wrd.13
 for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2021 06:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kwISwd5A9r+96Ga/POOsImhvVy//AhRYwgp/dJ/hQjg=;
 b=QhW2b23SXyuEaheFD2fi3QY3VWRNyHwbOdpagD6nZXsmotZ5Ns1Egv9moaBLY5pcP5
 mRmIveuhiIgVsZIkDFPUGLDTrO8GhrkJ3032PYsYBRWC2kMGMB+S8lM1qVgApxtVoYYR
 xaMlA6rdaRnugAFTlcPAvHBgt5qThesA7PgNwKDHXFripCL9Rxmiad690GANm/ki1QGc
 nLVfzVCHumPKyQvZhZsBVItv/noVmm+I3i2QfDW7q02ayzWnh1ViGQoyLMGDLaQYd1Pz
 JpmFZSaXFb0tW8CVpVuW9JmUdNmUJSWtyictuGG99WM3QhnAWwO7RBWbp+Cw4tN85ZnH
 nEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kwISwd5A9r+96Ga/POOsImhvVy//AhRYwgp/dJ/hQjg=;
 b=W73Srz9yugVwQm0/9bgBo6iGiHRlUP95sOkuKeMOnyKWUnvN682hG04p8qcZSnvH0m
 stejQu+Q6O+aftoMvGTTPnPkdMrPsA8jFceBl4GpEZ1oNQQJU6GOmtl5T95sLUOxB4IP
 6ICLNaxIljQWWF5xYWiDt/VtSPOpeCwRUM/nqejhuNhePJ184P/8fjXsMxb81fr8qo/F
 9UTgcHtF3r2S2FrT9l7pwTS1Hdg9WgGAgHh0NK5zSpwEPd01orcXnaUcBxQs6nPj+3Ot
 M7wt/kjZlxOsdg1Y93T6uWrLmYqUplLGGHWjtkniG9l6SzKUnZOZdPXodqMkXKgjldZO
 /Pvw==
X-Gm-Message-State: AOAM53118ugtc18FtlKF5LwBBdRhFl+HqFfHF/sI5AeYQdFYgrLxYTpr
 a/R0hKnF97mceSBIMxMean53Nw==
X-Google-Smtp-Source: ABdhPJyrjsoH6+H2cF6S7DOEI8u/vuhZU5pqPSEr+QF5gTiI7BdwQxFScga6CpwRstkjwSEYqNAyvA==
X-Received: by 2002:a5d:4a4e:: with SMTP id v14mr27979375wrs.271.1632751001157; 
 Mon, 27 Sep 2021 06:56:41 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id b7sm20485606wrm.9.2021.09.27.06.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Sep 2021 06:56:38 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: bjorn.andersson@linaro.org,
	broonie@kernel.org,
	robh@kernel.org
Subject: [PATCH v8 13/22] ASoC: dt-bindings: add q6apm digital audio stream
 bindings
Date: Mon, 27 Sep 2021 14:55:50 +0100
Message-Id: <20210927135559.738-14-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210927135559.738-1-srinivas.kandagatla@linaro.org>
References: <20210927135559.738-1-srinivas.kandagatla@linaro.org>
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

On AudioReach audio Framework, Audio Streams (PCM/Compressed) are managed by
Q6APM(Audio Process Manager) service. This patch adds bindings for this DAIs
exposed by the DSP.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/sound/qcom,q6apm-dai.yaml        | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml b/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml
new file mode 100644
index 000000000000..5d972784321d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/sound/qcom,q6apm-dai.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Audio Process Manager Digital Audio Interfaces binding
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  This binding describes the Qualcomm APM DAIs in DSP
+
+properties:
+  compatible:
+    const: qcom,q6apm-dais
+
+  reg:
+    maxItems: 1
+
+  iommus:
+    maxItems: 1
+
+required:
+  - compatible
+  - iommus
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/qcom,gpr.h>
+    gpr {
+        compatible = "qcom,gpr";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        qcom,domain = <GPR_DOMAIN_ID_ADSP>;
+        service@1 {
+          compatible = "qcom,q6apm";
+          reg = <1>;
+
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          apm-dai@1 {
+            compatible = "qcom,q6apm-dais";
+            iommus = <&apps_smmu 0x1801 0x0>;
+            reg = <1>;
+          };
+        };
+    };
-- 
2.21.0

