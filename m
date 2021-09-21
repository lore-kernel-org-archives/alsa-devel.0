Return-Path: <SRS0=+sGq=OL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFCBC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 13:42:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D89A61159
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 13:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1D89A61159
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B5E591662;
	Tue, 21 Sep 2021 15:41:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B5E591662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632231753;
	bh=+e8dvEgXvMvi1kon22tMa51uyw/ukVGI/s19D5VXDhg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RXhej0iu4cK1QgF2TKwYDEfUYzWTJ8G4x6M9jz3/HxUpWaN/BR1v0IbTphSEut5wY
	 GrplSniC88caonoZ1HUUVtpNlHPKO+yqkJf5Fv1bAFAcALv6INr+hbnK5oAwPP/0r+
	 /mE3RAbtPSdcnyKcrXGk5vIdu7gxWPJw3eQr42uY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1208EF804FE;
	Tue, 21 Sep 2021 15:39:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CDFEFF8051D; Tue, 21 Sep 2021 15:39:05 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2C273F80268
 for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2021 15:38:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2C273F80268
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="z3KkpCkZ"
Received: by mail-ed1-x52e.google.com with SMTP id h17so74564031edj.6
 for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2021 06:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kwISwd5A9r+96Ga/POOsImhvVy//AhRYwgp/dJ/hQjg=;
 b=z3KkpCkZQfQRbI9pDEtxTrKQyMNvLm7FVYe7f2CWiW3A3aXXzsP9lWCn23faCeN/Kt
 GeOfjctpeWrTQd5iyCnsnNWGAAal/aVhkrtuJV+SerPdqAEPGsdt9tDG4UtNSUlENO8H
 8ZMfOLA5sJmNlrcSlBJRNKnew3DXmQ0hSfVQ7c59SJJEVKlMuIcEc2JFPS0c1MCaI82X
 y9It06glRcHF9aA62rJ+cd3d5sxLkc4lhA4Jp1LGcNagfVZhOvu1br9VoyvejRM85HR6
 eVbyvY8T4Y2/veRRa+euFqH3+Ikt+1onBB2zwk0/6muElbyggYQcsdZdl4QRBciL5KKY
 4aYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kwISwd5A9r+96Ga/POOsImhvVy//AhRYwgp/dJ/hQjg=;
 b=wL4LvD0UoV7J+KVz+AfY72x/+PmDnXF2iSgyYjAbuS10VpVplV3CSh6QKkmseZMYBo
 3ibLHHn1DtSlzjqIr0KyslsEcedyoWor/xHKTRB74yHcWVfuGA0m4uYFnr1GO3KNj/mS
 FSwaRkHzuIZdU0Tay8kvRHDofZmUEzQf8ciU8b5q+hMsoxqxH2zxveFXrTIM1GOw2EJ6
 xUEn+uR6z2clv5iywo04OLxB6DR1TYWm4Mw+TFlb51vVFBvczB7WPS1anXOPwc/ipgRn
 XeWqwJ+RQlmefn9pJqMyjt9wiU7wDUeS/2f9cUCWM35SdbZkyN6RNgNloCdrYs+6dLu4
 BDGQ==
X-Gm-Message-State: AOAM532eaH352BbcOg1HRlwB9KbE4DVOAvyW1HA/YhLArEqt2/kGylmY
 MhmwAkmW3EhR+iSvRcb3QfRncw==
X-Google-Smtp-Source: ABdhPJz+wtek4aATVG1fizILW3QoHHUZo5pFL4YsOa4VncXXvvHw9Qt+E8R7ko7xqTEfiq7b/b6agQ==
X-Received: by 2002:a50:e188:: with SMTP id k8mr14841401edl.119.1632231463354; 
 Tue, 21 Sep 2021 06:37:43 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id b3sm7915799edx.55.2021.09.21.06.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Sep 2021 06:37:42 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: bjorn.andersson@linaro.org,
	broonie@kernel.org,
	robh@kernel.org
Subject: [PATCH v7 13/22] ASoC: dt-bindings: add q6apm digital audio stream
 bindings
Date: Tue, 21 Sep 2021 14:37:00 +0100
Message-Id: <20210921133709.4973-14-srinivas.kandagatla@linaro.org>
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

