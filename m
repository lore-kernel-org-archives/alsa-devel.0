Return-Path: <SRS0=GC6S=PO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E99C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Oct 2021 10:40:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1744460E75
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Oct 2021 10:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1744460E75
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 85F6816DD;
	Tue, 26 Oct 2021 12:39:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 85F6816DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635244830;
	bh=IgZwZ1eS04lFXZZ28Tmag0IUOrzAuofrvddmbZU346Q=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kVhnRmAh3V37AP9AjqEb1t7ilQ7pUoRRSbj4cdD41rXmJJR9HUFI6lcU64D8s9EUI
	 UzNBW2/Mimb0JpHXAmfDZYYhgq1vY5vGpWeF8nLro2elHdr5PDfjel8zll2aTT4+No
	 t63lX4qWRqAznfjqn7lYpA+CJJLT2sHdcvBoCpow=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C3DAF804F3;
	Tue, 26 Oct 2021 12:38:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4DE8CF804E5; Tue, 26 Oct 2021 12:38:43 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 08AA6F80269
 for <alsa-devel@alsa-project.org>; Tue, 26 Oct 2021 12:38:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 08AA6F80269
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="ca0+xkQk"
Received: by mail-wm1-x333.google.com with SMTP id
 b82-20020a1c8055000000b0032ccc728d63so403161wmd.1
 for <alsa-devel@alsa-project.org>; Tue, 26 Oct 2021 03:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=imP3Ut5HB4n6q2DrZyy9qRcidcMnxdcc3SMVUqr3MKw=;
 b=ca0+xkQkspIjAbnlNU/dpmhLt3A9LClUwvLdbFuAWWTJDbrqAEkfP1G9C9KHsg5jwf
 CyEU+R3VSxuYntiOIw8p3QfET1i9pNr8WSz3zpzGVOPptb2AuTNPP5sX8zuXBO9i7ZpI
 pmkRg+wAgfX2RscCB4WhBjz4KkkpGR3hQn2hKQuujQ42Ipon45UU+tX6wmg0zMwZZzEz
 NNFn+Seoy9i7KEWN1W54w0lj4l62qawCyQCiFY5t/XQr4rErSYSDf+2eGIbON97DpxKa
 ZlHs8trbJyAggD7v3sFcKJkGyy9O4Hx0P4WHcAOHXwPthlyyTtgK35NPJ2Mvd+DVI8q1
 sVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=imP3Ut5HB4n6q2DrZyy9qRcidcMnxdcc3SMVUqr3MKw=;
 b=TR/g0M76+v7PEn9XYEXzU+3FwMjC8NvK0p2Hg4NG15kwctNjrk/+NFAvzGRiVZuXtM
 GdPYnG8TEZObXWd7cGsjlCiYgnPmT/pxNIdNQ2oYax9ZCoMLEJbTAmLQgAN/3Gshfh36
 J1ZJiP9DOnmxNO2tVGzxIc5okNLrEK377I8UpyRMa78xnSo9wMpQDjuZo3WbLnplzyUV
 AF9QB3SoyEErTQ2mTxUlIXOzeD/CkeBFLHGUZK6vXmzpjQg9OGbhFH3VaxCCaNo+AB7n
 B85pA+zIaSY4YWiPQutbTt30lpevAVF5bz3EunIiL87P0zoeStxjWTyiLysLKAaL2oKo
 E4hg==
X-Gm-Message-State: AOAM530FRy7WAGh6T6e2qIkzqbtxlyiav5afnZKeHr/c6B0fO+cPDrXM
 AJGK6E+rArSGdqXVjUUSQvThHQ==
X-Google-Smtp-Source: ABdhPJz4F//xalzFT1DaX9rRyuiJSheNz6FS1MgIWE0IL21Kh/7FvJ657OEGlQlkMB49k3JxqYrZ8w==
X-Received: by 2002:a05:600c:35cd:: with SMTP id
 r13mr6342336wmq.24.1635244711594; 
 Tue, 26 Oct 2021 03:38:31 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id x21sm221397wmc.14.2021.10.26.03.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Oct 2021 03:38:31 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org,
	bjorn.andersson@linaro.org,
	robh@kernel.org
Subject: [RESEND PATCH v10 02/17] ASoC: dt-bindings: move LPASS clocks related
 bindings out of q6afe
Date: Tue, 26 Oct 2021 11:38:00 +0100
Message-Id: <20211026103815.19468-3-srinivas.kandagatla@linaro.org>
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

q6afe (Audio Front End) is one of the DSP service that handles both
LPASS (Low Power Audio SubSystem) Audio ports and LPASS clocks.
As LPASS is a hardwware IP and commonly used by Qualcomm Audio DSP.
In order to allow  multiple DSP frameworks to use these bindings
its best to move it out from the dsp specific bindings.

For compatibility reasons and not breaking which is already working
we still maintain same compatible string "qcom,q6afe-clocks"

Also as part of this change convert these LPASS clocks related bindings
into yaml format.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/sound/qcom,q6afe.txt  | 23 --------
 .../sound/qcom,q6dsp-lpass-clocks.yaml        | 56 +++++++++++++++++++
 2 files changed, 56 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
index fcf81058504c..bc6b5f1fe4f1 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
@@ -12,32 +12,9 @@ used by all apr services. Must contain the following properties.
 		  from DSP.
 		  example "qcom,q6afe"
 
-= AFE CLOCKSS
-"clocks" subnode of the AFE node. It represents q6afe clocks
-"clocks" node should have following properties.
-- compatible:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "qcom,q6afe-clocks"
-
-- #clock-cells:
-	Usage: required
-	Value type: <u32>
-	Definition: Must be 2. Clock Id followed by
-		below valid clock coupling attributes.
-		1 - for no coupled clock
-		2 - for dividend of the coupled clock
-		3 - for divisor of the coupled clock
-		4 - for inverted and no couple clock
-
 = EXAMPLE
 
 apr-service@4 {
 	compatible = "qcom,q6afe";
 	reg = <APR_SVC_AFE>;
-
-	clocks {
-		compatible = "qcom,q6afe-clocks";
-		#clock-cells = <2>;
-	};
 };
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml
new file mode 100644
index 000000000000..c686164732aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/sound/qcom,q6dsp-lpass-clocks.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm DSP LPASS Clock Controller binding
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  This binding describes the Qualcomm DSP Clock Controller
+
+properties:
+  compatible:
+    enum:
+      - qcom,q6afe-clocks
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 2
+    description:
+      Clock Id is followed by clock coupling attributes.
+        1 = for no coupled clock
+        2 = for dividend of the coupled clock
+        3 = for divisor of the coupled clock
+        4 = for inverted and no couple clock
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/qcom,apr.h>
+    #include <dt-bindings/sound/qcom,q6afe.h>
+    apr {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        apr-service@4 {
+            reg = <APR_SVC_AFE>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            clock-controller@2 {
+              compatible = "qcom,q6afe-clocks";
+              reg = <2>;
+              #clock-cells = <2>;
+            };
+        };
+      };
-- 
2.21.0

