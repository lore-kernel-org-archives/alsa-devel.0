Return-Path: <SRS0=+sGq=OL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F278CC433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 13:45:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A7C610E8
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 13:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 76A7C610E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 187D882E;
	Tue, 21 Sep 2021 15:44:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 187D882E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632231933;
	bh=IgZwZ1eS04lFXZZ28Tmag0IUOrzAuofrvddmbZU346Q=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qZW8fVuIzyR/M8zjXkab7EdTnO3YpxFY7yznUFk+7XitqGAovEfN9TEBnFcSmvsHI
	 IZY/1VtjyiwbPpY4hICWK70djOT6c6go4lj1fh5AU0KnwTwI3EzmtZWm0OxLIBgW2f
	 455JYMNMvA6loJW6JlwIbGaXqYgA5Y2ml+FvdR1A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C3D71F8057A;
	Tue, 21 Sep 2021 15:39:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 45ABDF8057A; Tue, 21 Sep 2021 15:39:44 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 80BC8F804E3
 for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2021 15:39:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 80BC8F804E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="MlKcAK9y"
Received: by mail-ed1-x529.google.com with SMTP id r5so5504312edi.10
 for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2021 06:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=imP3Ut5HB4n6q2DrZyy9qRcidcMnxdcc3SMVUqr3MKw=;
 b=MlKcAK9yudhd8orryUu2gwgOv3zjTZj5J1L4qY1dlrUmk/rshjCenRybgcXk2a/W6j
 Vha4HRqyWLohBS3wgMxpcEuNdVqKnZtVczcijnyn6JPB1GXR/Q1ni+jYls3Q3yIUR/ZG
 STvxCTmzWSqq43ri994MSHcLhmHaPyE7lTdiLxZFfl7170bx5n5ZKMRwFfKxlJycKxXZ
 UvECeo5rZBsO+MikMIHR4Xr3cd5Olh4L8kFNQoAWl6FJejji+BoGdgB9Jw5yo+jaVs7r
 fEMsQnJgrxx4PCNjsy+MS9GdeLZw23z/2FjKRx0L+2uHcwiXdAQRA1QN2ZLqej5K6iAm
 Gawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=imP3Ut5HB4n6q2DrZyy9qRcidcMnxdcc3SMVUqr3MKw=;
 b=YfvmeUf0AoVbEI6q/Pp0sh4adQktq2M1+HVmxPwBL72eY/4xp7cIyfzLj95RJRYzIn
 GsXLVnBx5zQ8IIHRP1os7eL8t950TmyPZWVfAbqFJnQVurI0bb/JAnJS0rVuyXpMCFY5
 9STygwW2U2vFsYa7MbFJaIcqNCmP4x3cpAfBxX6kd5YFmZOj3zllalb7zT3/OgDxXPIN
 DooUAa6mKAAtazUVOramX4R7qby/nSjNfcSDFxRJuXtvbSMcUgKP6EjTXNCajzpwMMjw
 A0STHGwriBU+VNaVq9yENVjK/eF3y5ho8tqrW3rkOJ+WcANh65bCnTGkKT/p8vHs0aXj
 KDCA==
X-Gm-Message-State: AOAM530DrwvvnVxqGdMLdNYQzDGI5scfORcPTBmdvZydt2TBX3JHisme
 kMWRFQtHwde6G0Uk9vBTFnhhQw==
X-Google-Smtp-Source: ABdhPJzoHGOnJSXvoF8lqjXeE5UQ1yyDsPjiPewakmGDTeePuZY40oUXw2YyC3z50fel65RNahlTsw==
X-Received: by 2002:a17:906:c205:: with SMTP id
 d5mr35205409ejz.74.1632231453626; 
 Tue, 21 Sep 2021 06:37:33 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id b3sm7915799edx.55.2021.09.21.06.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Sep 2021 06:37:33 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: bjorn.andersson@linaro.org,
	broonie@kernel.org,
	robh@kernel.org
Subject: [PATCH v7 07/22] ASoC: dt-bindings: move LPASS clocks related
 bindings out of q6afe
Date: Tue, 21 Sep 2021 14:36:54 +0100
Message-Id: <20210921133709.4973-8-srinivas.kandagatla@linaro.org>
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

