Return-Path: <SRS0=PPjj=MG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF21C07E9A
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jul 2021 15:35:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F1C06008E
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jul 2021 15:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F1C06008E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A9D716A6;
	Wed, 14 Jul 2021 17:34:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A9D716A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626276912;
	bh=kqskMrFbvKYf5mXMhHXhVzisq96e77cdFazCZKncELY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ggc8kHCyRujYvAQRO6IT4CDGrqnua3dbCNJbbNtMgGOq0gC2sc2cz4mFPL5Szjg0x
	 GCmE0u3Zn0D0I2WcFi4xOy9EEMnk91w0y6Atg7pFTwNSD7wQqnoXDsTFTcO/o/gV6H
	 Fr83x/f4qc33I1ju2eKIXYZvtqhFU6Ofb/jObDRo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F24EEF80527;
	Wed, 14 Jul 2021 17:31:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 474D8F8051C; Wed, 14 Jul 2021 17:31:19 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 78ED8F804FB
 for <alsa-devel@alsa-project.org>; Wed, 14 Jul 2021 17:31:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78ED8F804FB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="agLBPgKG"
Received: by mail-wm1-x335.google.com with SMTP id f190so282741wmf.4
 for <alsa-devel@alsa-project.org>; Wed, 14 Jul 2021 08:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=idmBojPKMaEqXxTsPN9NMivz3VoeKNs2nUJ6x42cpzc=;
 b=agLBPgKG6NCQ7IVxrRVEplMT6waFwhNQPFhzQQpnpJKX7/YBMSJxK8w0vmN7DtVDGL
 n6ikaA3s1XieoJ4wRldmKO6pq8vcxxFdy8IS5k8GTYZzMzC+iKIUz673QMQaI8WmL9cZ
 hv2rjCDIlmlUxI4wLEsVn8lUOjIJugBtWJ6S4X1UsBmQM4Usmmy6uM++A73uREFhxFYd
 aFSNA+OW9gwsGk0HhsAlBlgQ3DRIlFuYyzyi6gDhUb+1/Erymzr82qHYGhfPHpJnB2dx
 u35VhguFMJxpiwV+YLjjbLR8WZ0BgLRIrGShF2Wvn25hY2xJVgDmnOKLaz0v/UjyFavT
 FeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=idmBojPKMaEqXxTsPN9NMivz3VoeKNs2nUJ6x42cpzc=;
 b=hAd+9MuMtuRqPMDyRr5OiYEIzEwObY/szVmjAJ12ZqKMjUUkOm/cAs2uaHmGB8eDh/
 ybpkyDD49Ixyy/YitgiDjQFBlNiMaX2J3eMaWk84jl/HBrTPTu/yrDfASZ3T6RoR1AWc
 mvnYHl8WjY+ykrSO7Nbp5eIPXxh8EdnEHMVUubBvoBX0C7Y6SDaVUKRD+BLe0hnwYfpW
 7jU5f/JVTiymCs4iWgR0wdjC/sMF/e016Xzk+n1P78px6lIXIn3QI1c79omLahQVHcxf
 cNNZaiIM17kQoHW/NWYG7tkaJbQgedBBUOXJPvoJFQb4bW0mar2qzaja2ShaGGMFws+m
 z7Wg==
X-Gm-Message-State: AOAM532HjBfyofhz+apDIwacNjkRcaLQ+XeR863nGVYub1cxcyO0gTd4
 IfaZLiJLueU0RNJMOdhWRHi53w==
X-Google-Smtp-Source: ABdhPJyFR8qTlHqmBxq+Y/7qdiBh4rN3/klZm8ldzfOe2/EYYw/757jwvFtTjLXf6nZHKQSaQPgvpA==
X-Received: by 2002:a1c:80cd:: with SMTP id b196mr4732641wmd.179.1626276672854; 
 Wed, 14 Jul 2021 08:31:12 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id y6sm2465174wma.48.2021.07.14.08.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jul 2021 08:31:12 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: bjorn.andersson@linaro.org,
	broonie@kernel.org,
	robh@kernel.org
Subject: [PATCH v2 11/16] ASoC: qcom: dt-bindings: add bindings for Proxy
 Resource Manager
Date: Wed, 14 Jul 2021 16:30:34 +0100
Message-Id: <20210714153039.28373-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
References: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.de,
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

This patch adds bindings support for Qualcomm Proxy Resource Manager
service in Audio DSP.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,q6prm.yaml | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6prm.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6prm.yaml b/Documentation/devicetree/bindings/sound/qcom,q6prm.yaml
new file mode 100644
index 000000000000..6f14146c1ea1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6prm.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,q6prm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Q6 Proxy Resource Manager
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  Proxy Resource Manager module is core module used to manage
+  core dsp resources like clocks
+
+properties:
+  compatible:
+    const: qcom,q6prm
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    gpr {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        gprservice@2 {
+          compatible = "qcom,q6prm";
+          reg = <2>;
+          #clock-cells = <2>;
+       };
+    };
-- 
2.21.0

