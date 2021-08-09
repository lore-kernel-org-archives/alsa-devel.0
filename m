Return-Path: <SRS0=CTIr=NA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DE4C4338F
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Aug 2021 11:29:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60E506101E
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Aug 2021 11:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 60E506101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CEBB516AC;
	Mon,  9 Aug 2021 13:28:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CEBB516AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628508545;
	bh=fndkAEZkKGN195dwQTh5pz4PJrIPoDVHnw38+upRSl0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L7geSrtJVXOwCJuKwxyTRms2MeyhNsC55h5FWO7PkdXSs4cNF4swMEuotx8iv1zDJ
	 LPry3RhOw+ZpDN9+h+qr7ILUmwpXjI8FogVO/0gGgylY7NLUOfDhbPtF3aPSSFFJKW
	 wu5IZFdt34XIlzofytk+wh4EDstCtf5vxC01blDw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C3E17F80528;
	Mon,  9 Aug 2021 13:25:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A485CF804D2; Mon,  9 Aug 2021 13:24:54 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B95A8F804D2
 for <alsa-devel@alsa-project.org>; Mon,  9 Aug 2021 13:24:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B95A8F804D2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="Ko4dlkca"
Received: by mail-wm1-x332.google.com with SMTP id
 w21-20020a7bc1150000b02902e69ba66ce6so68857wmi.1
 for <alsa-devel@alsa-project.org>; Mon, 09 Aug 2021 04:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RwkBekoVHbR6mINfcBzFLlTHGm7nkcct6qC3KOCM4UE=;
 b=Ko4dlkcapKjwQM7b2WlbCeTw2m/Z43Q8i747F7qcLEADAty8vNtbyR5Y7x6LdEwbLo
 lxy2H6he0DyVdbNupc4fUtKSJ2LzYFOrnZRrlug1cr5NUStj/Be+IOq+imtsGRMYZ3Yt
 yNWBEDKEtkPv3EY8ADih6U5w9HGMKArikvDiBojNSXZUQRow4O4lAdkQT9TYuKGO63jF
 XkPOajF2hk7fztruSIO4lYvVGMro6M3jxl5wKMx4F9EbRlt6FsxS3sL7+stS1o5K346e
 UfI+Vz4uDJtklfyiSSXMBm2/y2I+FGzCZ8chz0CdOgYlHXHH+V9HqSglIGQovMgmk1LC
 A3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RwkBekoVHbR6mINfcBzFLlTHGm7nkcct6qC3KOCM4UE=;
 b=tBW+ja9NsFqYMx1kfg2JZoQmdQcRKmcASztkMjSKd+RDEIFZhT6oypZW0cxyKlHFNQ
 ICnSIWq5+HXICyeGxVBCWJgSY/Dytf9/LrH+Ttmv2Ba5XYbPosWr6f596+rfhOdYldp+
 2mLp04+1DeJ6Xu1Yfy392CMIXxOF6823MGInjpr6T6SAhakQaxFxwPD9GrqHRS390ZPR
 4HwmQOhekYDzpjJqQOJGGjWGVOqnH2Bd1anYAYht3e9YfKTDHcFHF2iD1pRsI/U7YIYo
 zM+FFC8AvonXtQSUv5NJMRiWJyjBTl2PP05EOtcQDocl0mlPDN7omTFFcCUNqeKhGZCk
 VnkA==
X-Gm-Message-State: AOAM531CeKElf/14fgYUKoJm1VrGkB9qD/5BqdDr2QKrch5ks0Javuv7
 eY8u87gPVvtPjrtTZyWmjqc4BQ==
X-Google-Smtp-Source: ABdhPJzAVta+ZCRikkesgjsVzopWoMoMQmcdgNEg1v1Buea1bemOpbJUVpYjF1/4f4UetZcfkTAuMQ==
X-Received: by 2002:a05:600c:41d6:: with SMTP id
 t22mr33384323wmh.66.1628508283797; 
 Mon, 09 Aug 2021 04:24:43 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id b80sm7774900wmb.2.2021.08.09.04.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Aug 2021 04:24:43 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: bjorn.andersson@linaro.org,
	broonie@kernel.org,
	robh@kernel.org
Subject: [PATCH v4 12/20] ASoC: dt-bindings: add q6apm digital audio stream
 bindings
Date: Mon,  9 Aug 2021 12:23:31 +0100
Message-Id: <20210809112339.8368-13-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210809112339.8368-1-srinivas.kandagatla@linaro.org>
References: <20210809112339.8368-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, tiwai@suse.de, plai@codeaurora.org,
 lgirdwood@gmail.com
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
---
 .../bindings/sound/qcom,q6apm-dai.yaml        | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml b/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml
new file mode 100644
index 000000000000..75431d1c0b2a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml
@@ -0,0 +1,50 @@
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
+    gpr {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        gprservice@1 {
+          compatible = "qcom,q6apm";
+          reg = <1>;
+
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          apm@1 {
+            compatible = "qcom,q6apm-dais";
+            iommus = <&apps_smmu 0x1801 0x0>;
+            reg = <1>;
+          };
+        };
+    };
-- 
2.21.0

