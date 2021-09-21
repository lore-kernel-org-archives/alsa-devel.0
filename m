Return-Path: <SRS0=+sGq=OL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A803C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 13:40:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56581610E8
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 13:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 56581610E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB3A11654;
	Tue, 21 Sep 2021 15:39:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB3A11654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632231650;
	bh=rGnpjmDFV1wmhq/brOeQrLyWCt8iJXrJL9MieP0na84=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iNrUjdkGga9+GX9tX+/inm+E9thCEtag0VGaVYSc+b46xKYCeVpMfOur7diwyb7C0
	 0VLTb3+OvH5fTBFW0qUoCsYs/9w7sSykZYXsC2YQqzNbjJiZ9XodeLXFRmXkcosbnN
	 2a0A3MV/sJrlN8PH8eIV1mnKMkGcn3BDo/1fHhpw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 90A9CF804F3;
	Tue, 21 Sep 2021 15:38:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 67A25F804EC; Tue, 21 Sep 2021 15:38:49 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BD305F8025F
 for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2021 15:38:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD305F8025F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="gV9Hy9Wz"
Received: by mail-ed1-x533.google.com with SMTP id h17so74560874edj.6
 for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2021 06:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9h1xMEiV0P0T+5NxtCB5k6xQoY2x3NNYvUmlcG7EV4s=;
 b=gV9Hy9Wzz18Zk9xzayAO6Qwv1zz5f0BSPLh2v7NtY1+pErcSf8ifM1g4E5ISw2+QQs
 igyYMWmVaNhUKE+1vPcA2t2hnobsjaAjDHXKvG0/CY65TsZLXPJe7Rj9blQJdLe5cIWs
 4ZIy3ULh7PG5eNdVpkqhGiJXsCfNuNzq35MyUPpwMThVBZ+RbRwlrJLh7m4ydlXixdSU
 C8c2hyV3VlZma1+7mzEd6NzDO2Kt7ofHcnAt1nL3Tvx6TeX4LjwPeh8L2TxKE/UcivGN
 ALa240x9V9HFM+0w6KA5965Kk6+jhuohexZDJdE6/Crt9ABzzgPwTcOIZhLVgN+yccq+
 heIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9h1xMEiV0P0T+5NxtCB5k6xQoY2x3NNYvUmlcG7EV4s=;
 b=FmlIRhJdD3G/awlClcX1a5NUCGF8rora66vz3e5343qhtv+fTZuEMEVEbVTVby8Jcj
 ZnYb8ZyvpU3OWiJfWY/lFe+g+rmkPNSGMg64q8S++UBKXruSCTh7eMHHHp3yjJPprNhd
 eY9FBYWSfdPtEgmkmcXOZ9Fu+OmShWnclTHmnU/uWCZgddZFqjr4NYVGGNel8rPKYDNg
 ocpRcUogGlMclFpkr0IYkvlxFDQlDgENGngBLWePSO8Ldo6ZrOrLuRk86uRzyjKfpaNi
 +iLpnZ07GU8O+8+MBeW0xX8pyDrKPTqrNoMzFV9e+/zYxFD4+gF2rySRZ7eSpeXx7mv1
 aibw==
X-Gm-Message-State: AOAM533x2+zdDhELTXf5Zg0GiCaEOhgBbpujGZPWB8TShfhPriuoEMFD
 Q+CUYVaAy54H3vaJvb0oKcbbHA==
X-Google-Smtp-Source: ABdhPJyLOM4RhikT3hoSmqkkuebCsb1AALv5R6RGvk9J4fE/ArGD8/topGzss01SGnvab8kAM5ZoCw==
X-Received: by 2002:a17:907:11c2:: with SMTP id
 va2mr14250678ejb.160.1632231449372; 
 Tue, 21 Sep 2021 06:37:29 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id b3sm7915799edx.55.2021.09.21.06.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Sep 2021 06:37:28 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: bjorn.andersson@linaro.org,
	broonie@kernel.org,
	robh@kernel.org
Subject: [PATCH v7 04/22] soc: dt-bindings: qcom: add gpr bindings
Date: Tue, 21 Sep 2021 14:36:51 +0100
Message-Id: <20210921133709.4973-5-srinivas.kandagatla@linaro.org>
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

Qualcomm Generic Packet router aka GPR is the IPC mechanism found
in AudioReach next generation signal processing framework to perform
command and response messages between various processors.

GPR has concepts of static and dynamic port, all static services like
APM (Audio Processing Manager), PRM (Proxy resource manager) have
fixed port numbers where as dynamic services like graphs have dynamic
port numbers which are allocated at runtime. All GPR packet messages
will have source and destination domain and port along with opcode
and payload.

This support is added using existing APR driver to reuse most of
the code.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/soc/qcom/qcom,apr.yaml           | 41 +++++++++++++++----
 include/dt-bindings/soc/qcom,gpr.h            | 19 +++++++++
 2 files changed, 53 insertions(+), 7 deletions(-)
 create mode 100644 include/dt-bindings/soc/qcom,gpr.h

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
index bfe04fca8aa3..028c5d105adb 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
@@ -4,20 +4,21 @@
 $id: "http://devicetree.org/schemas/soc/qcom/qcom,apr.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
-title: Qualcomm APR (Asynchronous Packet Router) binding
+title: Qualcomm APR/GPR (Asynchronous/Generic Packet Router) binding
 
 maintainers:
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 
 description: |
-  This binding describes the Qualcomm APR, APR is a IPC protocol for
-  communication between Application processor and QDSP. APR is mainly
+  This binding describes the Qualcomm APR/GPR, APR/GPR is a IPC protocol for
+  communication between Application processor and QDSP. APR/GPR is mainly
   used for audio/voice services on the QDSP.
 
 properties:
   compatible:
     enum:
       - qcom,apr-v2
+      - qcom,gpr
 
   qcom,apr-domain:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -46,6 +47,10 @@ properties:
         5 = Application processor Domain
         6 = Modem2 Domain
         7 = Application Processor2 Domain
+      Selects the processor domain for gpr
+        1 = Modem Domain
+        2 = Audio DSP Domain
+        3 = Application Processor Domain
 
   '#address-cells':
     const: 1
@@ -53,12 +58,12 @@ properties:
   '#size-cells':
     const: 0
 
-#APR Services
+#APR/GPR Services
 patternProperties:
-  "^service@[3-9a-d]$":
+  "^service@[1-9a-d]$":
     type: object
     description:
-      APR node's client devices use subnodes for desired static port services.
+      APR/GPR node's client devices use subnodes for desired static port services.
 
     properties:
       compatible:
@@ -67,9 +72,11 @@ patternProperties:
           - qcom,q6asm
           - qcom,q6afe
           - qcom,q6adm
+          - qcom,q6apm
+          - qcom,q6prm
 
       reg:
-        minimum: 3
+        minimum: 1
         maximum: 13
         description:
           APR Service ID
@@ -84,6 +91,11 @@ patternProperties:
             11 = Core voice processor.
             12 = Ultrasound stream manager.
             13 = Listen stream manager.
+          GPR Service ID
+            1 = Audio Process Manager Service
+            2 = Proxy Resource Manager Service.
+            3 = AMDB Service.
+            4 = Voice processing manager.
 
       qcom,protection-domain:
         $ref: /schemas/types.yaml#/definitions/string-array
@@ -148,3 +160,18 @@ examples:
           qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
         };
     };
+
+  - |
+    #include <dt-bindings/soc/qcom,gpr.h>
+    gpr {
+        compatible = "qcom,gpr";
+        qcom,domain = <GPR_DOMAIN_ID_ADSP>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        service@1 {
+          compatible = "qcom,q6apm";
+          reg = <GPR_APM_MODULE_IID>;
+          qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+        };
+    };
diff --git a/include/dt-bindings/soc/qcom,gpr.h b/include/dt-bindings/soc/qcom,gpr.h
new file mode 100644
index 000000000000..3107da59319c
--- /dev/null
+++ b/include/dt-bindings/soc/qcom,gpr.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+
+#ifndef __DT_BINDINGS_QCOM_GPR_H
+#define __DT_BINDINGS_QCOM_GPR_H
+
+/* DOMAINS */
+
+#define GPR_DOMAIN_ID_MODEM	1
+#define GPR_DOMAIN_ID_ADSP	2
+#define GPR_DOMAIN_ID_APPS	3
+
+/* Static Services */
+
+#define GPR_APM_MODULE_IID		1
+#define GPR_PRM_MODULE_IID		2
+#define GPR_AMDB_MODULE_IID		3
+#define GPR_VCPM_MODULE_IID		4
+
+#endif /* __DT_BINDINGS_QCOM_GPR_H */
-- 
2.21.0

