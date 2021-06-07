Return-Path: <SRS0=v4AK=LB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E719C47082
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 15:34:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A785A611AD
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 15:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A785A611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2DAEA1685;
	Mon,  7 Jun 2021 17:33:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2DAEA1685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623080076;
	bh=kqskMrFbvKYf5mXMhHXhVzisq96e77cdFazCZKncELY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NIURlTwBS2iUMzpGk288L81svhKvA+paBgUE+IX5lCZ/n8+c2OFSa4HlxF9C1ArWR
	 UEoQFsu7z+715bSRnilQCvR4tvGhOyH3Z+24z2r/6uEcS6NBCik/TPN7Yk8dfFw3oI
	 u8UMUpo5DfPjwyuBuQli43RxsrJEVSyi6xZVt79o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 018E6F804ED;
	Mon,  7 Jun 2021 17:30:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7D39DF8032D; Mon,  7 Jun 2021 17:29:38 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9DD02F8032C
 for <alsa-devel@alsa-project.org>; Mon,  7 Jun 2021 17:29:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9DD02F8032C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="vbXNC70U"
Received: by mail-wr1-x430.google.com with SMTP id y7so13473899wrh.7
 for <alsa-devel@alsa-project.org>; Mon, 07 Jun 2021 08:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=idmBojPKMaEqXxTsPN9NMivz3VoeKNs2nUJ6x42cpzc=;
 b=vbXNC70ULxFFKb2gCHU+vvjhZgISGdWZ3B66ixqhsf3LWTQMUe7MN2fQfMQKBczDXu
 AJBltuf8DLQxCUEAsnoWbQdbRUt4598NJViyUyLY9ix8uAAr/UVBfqmLkAH9VxhdYhYN
 Lu2bVDSLdhPMRtHQE+RKUkId0BYQfrmEGwuWbvzw81oEnSQgJThgttlyZhgfsLwGOcOH
 HV7FWiLS4GpkrY7mvM1TAJepNBjVw6ngc/1dxB7E1Nz4E7/XJvKQtBtl2pa4vLvXXF0P
 DjpFuOHy4iDUubcbpAYQWWVrzyqMC6+V6pEQSJclbIohaBv8Am7+5Nkvhas4TMjeDeng
 E5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=idmBojPKMaEqXxTsPN9NMivz3VoeKNs2nUJ6x42cpzc=;
 b=IO4SOnY+NHEO5xBcbIYJ/KbdwWFHl7UtgGoWGgQ5MRF1oMQwZKS7UbPkt3XqmIXUYQ
 ik50/3p+NZjhubB3x0XwE/w5grefqQQOVAOkmJNfyulVIjtQG9ezCz365zG4+WPY8rbE
 bVevc40acPZhEkXwBqXuwj6/kh/zDfUEjGkONhofSvPoZwMkQuyFzmowSBDJz6ZpipsL
 Ged+sUT/JEHkS6sF8Wpbo1xYKPlkRIShZ0OWTxXcYjoIgH/jn/PZI4b64LVYwShucIBH
 jgHnEbc4T4FItXWBxnwH448mONOdND7Kb7dp6W4hIQvk0wUceBKq7TR34gi6O+VPLVCa
 Tf2g==
X-Gm-Message-State: AOAM530bz2o082DJo9LSNfCrew2qflq+cgdXhWwrJwCUEPhVnd1EX0Gz
 h7zjyEVwH75qEj/doKKckU5nCw==
X-Google-Smtp-Source: ABdhPJyihoRf0jBti0BaOD0KEen6Y1OrOVBSTVZrojU+gBnh4nUMuKYPhsE3C1kCmUHxfCUoA6+v/A==
X-Received: by 2002:adf:de91:: with SMTP id w17mr17979866wrl.352.1623079753520; 
 Mon, 07 Jun 2021 08:29:13 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id q3sm16370170wrr.43.2021.06.07.08.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jun 2021 08:29:13 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: bjorn.andersson@linaro.org,
	broonie@kernel.org
Subject: [RFC PATCH 10/13] ASoC: qcom: dt-bindings: add bindings for Proxy
 Resource Manager
Date: Mon,  7 Jun 2021 16:28:33 +0100
Message-Id: <20210607152836.17154-11-srinivas.kandagatla@linaro.org>
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

