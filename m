Return-Path: <SRS0=GC6S=PO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C71AC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Oct 2021 10:42:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 895C360E0B
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Oct 2021 10:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 895C360E0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0157C1700;
	Tue, 26 Oct 2021 12:41:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0157C1700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635244965;
	bh=wMkgM8CoglY0fvE9Zf5Mt39swOo7BxD8RsI2fUnIV9I=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YXmY0GqFViqx8s9Yk+vq+6BMs8SDPiZgMaHISVtOrvPXWDsu3pcdmdZyrC7bu+5UF
	 G+ttlE/EPzPk+QNBhJ1DKdqLJqBqOe24Y4dUwgDNDq+J+2rvbFmLlhDkqG5Fjs4+kV
	 1bSZvN8FCGs592yVi352DcnpGR1NmoC+P32fM3rg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E061F80506;
	Tue, 26 Oct 2021 12:39:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DBBBBF80527; Tue, 26 Oct 2021 12:38:58 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 67EC4F804E2
 for <alsa-devel@alsa-project.org>; Tue, 26 Oct 2021 12:38:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 67EC4F804E2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="K+NA3hT8"
Received: by mail-wr1-x433.google.com with SMTP id u18so14963574wrg.5
 for <alsa-devel@alsa-project.org>; Tue, 26 Oct 2021 03:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZUTQPGMld1NjfHqBeBgP6Q5d4oV2F6unCGQSSDbPgkI=;
 b=K+NA3hT8cgsu8NeXDwft35uRQ+2KoEvrDrW+jENpyTKH+oKAW+tkfskUV0S82wJ90r
 wIoo5LM6lvfliX2eO388SzIA7MrGYB1hKIjHjcwlhQntPucfmfuihzIFWfAiQEznoOu1
 VhuzDNSZYXQk9CHRx6WUBxEKz6g5QTipayKoLeISkgPxdCSo/r9F4uyhHFduiimphqoe
 tbDNhmKBAO6J9aDUlHPtVBPRaqZ+HjcgkcTY+MQ8xYUY6B23k2PoXbIGDADbFTYGaq/6
 TPP7t/VQfmvI+CO5HMQUTb3yYGcPZBZhwpZw+wh8vRQ2DLQ1lMy4aDKj6wBh9NLTbTw6
 WDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZUTQPGMld1NjfHqBeBgP6Q5d4oV2F6unCGQSSDbPgkI=;
 b=t1FEuSlPxI/B9nJDCRxQEk35sYQzMhrwHKV9P8KQrXsTXH7iDpkfxqY2GIrJ6NCiXH
 tydWd7bBVQYnXaoozw+wPvYTXpHbHjzgX5o5D+V1dn19KXzwKXUI6TqVqH7PA6RK4mz3
 VWqAgH/OuooQnf+g1OYnAP8q2tcB2sgfwVSM5e+J+Q2tfFgtjSRQXQLl+cFy8PU2ewc/
 rgK1AvCDLFtAKcXm39ptVkROT4mAfqgaPTzw2Brxczchf0/ssFIn4LBlCEUd/i3Ar6Cn
 1rL+h2m4g8kUN8D9PERMfz7AY8yx1lEeqFOitUNCZWGjxJalsDq7sppZpql7ldUENQPS
 bF1Q==
X-Gm-Message-State: AOAM531leeFS5U2kIuXReVOtvzcSWLCO/ErpGqXjHLXXY2gYWEh2Cxd2
 XTXetsOkR1s5n6uNFld/JxlSwC2cY8vpAw==
X-Google-Smtp-Source: ABdhPJzj2A14U2LgQ95zRukJ2nZ0wqbWBEwoNqx54/9mABKZHZnT5XhsO8BMPjwmcAGXcJmq7xfE5Q==
X-Received: by 2002:a05:6000:8a:: with SMTP id
 m10mr30573168wrx.115.1635244718624; 
 Tue, 26 Oct 2021 03:38:38 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id x21sm221397wmc.14.2021.10.26.03.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Oct 2021 03:38:38 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org,
	bjorn.andersson@linaro.org,
	robh@kernel.org
Subject: [RESEND PATCH v10 08/17] ASoC: dt-bindings: add q6apm digital audio
 stream bindings
Date: Tue, 26 Oct 2021 11:38:06 +0100
Message-Id: <20211026103815.19468-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211026103815.19468-1-srinivas.kandagatla@linaro.org>
References: <20211026103815.19468-1-srinivas.kandagatla@linaro.org>
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

Hi Rob, 

You might see a dt_binding_check errors as QCOM SoC relevant non-audio patches
in this series have been merged into the Qualcomm drivers-for-5.16 tree,
as this series depends those patches an immutable tag is available at:
https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git
tags/20210927135559.738-6-srinivas.kandagatla@linaro.org

thanks,
srini

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

