Return-Path: <SRS0=4dkw=PN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D55DC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 17:18:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F0AE60C49
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 17:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0F0AE60C49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A801616B3;
	Mon, 25 Oct 2021 19:17:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A801616B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635182295;
	bh=IgZwZ1eS04lFXZZ28Tmag0IUOrzAuofrvddmbZU346Q=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SjbgodTyFPxV9gowY64qx7WCVCGUYpPYO6zVRUnjSFUeofJFB2sWzmLR2D8JcfQvZ
	 qWTZkvmQe1NLk4+XMkA3KYKhaE0mzg65lj7oq0vBpPDFrKVh3mQY6nM6fn/uWN0zJH
	 PrCa+oJ+uBE56zDtJPy5Jo8yxBSyhibLC9j4pa58=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 66EDCF804AF;
	Mon, 25 Oct 2021 19:17:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 93D6BF804AF; Mon, 25 Oct 2021 19:17:21 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5155AF8010A
 for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2021 19:17:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5155AF8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="ytmeHT7b"
Received: by mail-wr1-x436.google.com with SMTP id p14so8141105wrd.10
 for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2021 10:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=imP3Ut5HB4n6q2DrZyy9qRcidcMnxdcc3SMVUqr3MKw=;
 b=ytmeHT7b8bD7ME97opCDFy9ymvzz2JSucp5wAIyAREAmRulcGoqIU+peD/bWfwDpfL
 yZClh9WJRvqdxt+OkseIl+/JhiqineYwgX+ldMA8gBenYIfbycbmOH2+q9ZSMOoRzC8k
 r4ZYrCpFOWKNnjWJ4gsrEE08uLD4LsbCjO2I1+tgbJUeUAwJtBb6ONxCu+Z6QZDNr5/J
 wVCZK/AtT4hdPgM2+Qs5OcMP/L53oUD6Lzl2+DHKEWgm/2/nTiotpaYuaIsbfjmuUARG
 6oJlauTUh+GsPd0GOXZ8M3Md9t3lTr90CLG3aHOzIZCkMFcvJJpc+ntXzW/MQl2HOk7l
 lG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=imP3Ut5HB4n6q2DrZyy9qRcidcMnxdcc3SMVUqr3MKw=;
 b=IuRlkVufFDzNQA/sL//JAv5YA3DNReqW7QEcACAK9ItRMraNuEYpTQkGzccT1hoChq
 lNNn9ipsvoHRz2z0D5fmkF194ZES661zjAzgJyWr81PRRJbfskDBMjs5/NFb3G3WvW35
 3auf2COMhhrhLLHLF/1X8aNCmqzWSXQ/n4+Ngc8NbS8ge6dEOqbj6xS5xLjchOYmjWDt
 elI5daKvI0ZzUsdt3YyG8ieFu5QQCM3+A1kgj653AprAbXzKf0tUcacUBVL0WegxnEdO
 5x5GaIXO70yLHuBKw+NvCPZCyo/ERO+HC0GJ+B6auWF6s2gOwoiL8U5Gi7ExjfCIsYQA
 njxQ==
X-Gm-Message-State: AOAM5318Xi/SYfK1mHXYAxiQogN6BsU9DdpaZQQXBKuAa5DZqi07ineK
 mzHnxtcEr2V4uRQ9FWYV2iJ27w==
X-Google-Smtp-Source: ABdhPJzQSTTPH8B996xcbO7hA8Gu01AB4NaazJBxaMjqu5rGhZl+exkX3x2ifxKoptxXfvC1g5em3A==
X-Received: by 2002:adf:a1cc:: with SMTP id v12mr25227806wrv.48.1635182232872; 
 Mon, 25 Oct 2021 10:17:12 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id r11sm5181012wrt.42.2021.10.25.10.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Oct 2021 10:17:12 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org,
	bjorn.andersson@linaro.org,
	robh@kernel.org
Subject: [PATCH v10 02/17] ASoC: dt-bindings: move LPASS clocks related
 bindings out of q6afe
Date: Mon, 25 Oct 2021 18:16:34 +0100
Message-Id: <20211025171649.17730-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211025171649.17730-1-srinivas.kandagatla@linaro.org>
References: <20211025171649.17730-1-srinivas.kandagatla@linaro.org>
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

