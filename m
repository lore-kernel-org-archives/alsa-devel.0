Return-Path: <SRS0=EjE+=M2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067B3C4338F
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 13:00:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2659560F38
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 13:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2659560F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C855017BD;
	Tue,  3 Aug 2021 14:59:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C855017BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627995599;
	bh=z+Ao7PQGszntMfzRsPPTZrswtVVGWo0py2dHWSpkAAM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kxwi5NUOgL898Pwq5PzPr53USauRxwZCmLQsuCil4TdzGHgX81uRfvkSYujFKLpSp
	 3UIXs+i0K6G8adBqQMEmsAvhsY2NHNyMOuJtfCJKrBROgmRiqraJ3SALDkJPR9NRkA
	 Wuk5x+PY2x1pU4mVRh07uHw4PGa/SPa/21NreoVE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3BE41F80548;
	Tue,  3 Aug 2021 14:54:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BE9F7F80537; Tue,  3 Aug 2021 14:54:47 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DF69FF804E7
 for <alsa-devel@alsa-project.org>; Tue,  3 Aug 2021 14:54:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DF69FF804E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="fnXtAII9"
Received: by mail-wr1-x42f.google.com with SMTP id d8so25185177wrm.4
 for <alsa-devel@alsa-project.org>; Tue, 03 Aug 2021 05:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=srjL+CjaMsC+td6kJ/KJXLzzpzYR+bTd3helCWOhv3s=;
 b=fnXtAII90N3qUIMkvucVX1eXqXiMt43kp3SWqNK9UwWsGVovkl6VxfWDwjTV7VnD71
 hf1N2CjE2V985JVP8PJv7YlscCCYIJa49Uf4/yl/VAFazVxQ1qKNW8RTB3AJ8H5g0bCj
 FWnej9PpVNHs+5iu38dYgUVXPzTZ7k7RWxF1VU3zyvbG+0KKAl5PzCeqIUlW7U/kKf/P
 ku/UM/UeJ77c8Kaj41F/NsHbS3qEkoW7AMDnh5GIIqBIuZHtH5pZ7peKsNwZ3mUFm8po
 hryaOfPKCqTwoJ+/D2ueQ0cKyvz7z10npOi7o67WYvkYXcCzHYeyDfxTLOZarD4LLMyD
 JiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=srjL+CjaMsC+td6kJ/KJXLzzpzYR+bTd3helCWOhv3s=;
 b=XZQYFVdeoQI1ZjTmsPATDGFgHM33HmVuiDl2iE+KJFU8tlcVnils82cW6KlBLX3nig
 RzvJFYRiwnTNWIyzV/5ShyWvChHapc4nH3vJwP+4UPTLuMK+s3dvewsNOLRMJASgdw/J
 tTgnvrVVCjeyh7d6T5ZxscVppS3SSeDrNDmQ1ZR0u6ceOKMTxo5Ll6k5HBXMSNDl0q5k
 D5PjUFATN9SZuryqOwyvcGHVT/V+MCWRAXifFVZW7+zoXohICU9vClBfKLdm25lBCt2y
 v9yyxv6zmPZthZmYTS3ZURpgyepe/wGFYT6EX85IqeKcOfbQsr3VkJU8cjZyVL4oqaVU
 xMcQ==
X-Gm-Message-State: AOAM533IkE7ycxvyGiGT6gW6fmqPgWpYvZ0p/azF75mLPe6qzJSTrhCF
 b0jQA6aQ12hcOqkDMyKJ4WybQw==
X-Google-Smtp-Source: ABdhPJxLXKHQ2laoK+Irqvkzqjef2sVBopk2gQP9LMUhszrAhx1kmno6gnNgTKYCgtU0lU+8Zn2wXg==
X-Received: by 2002:adf:f68a:: with SMTP id v10mr22935528wrp.366.1627995271039; 
 Tue, 03 Aug 2021 05:54:31 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id h14sm14695574wrp.55.2021.08.03.05.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Aug 2021 05:54:30 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: bjorn.andersson@linaro.org,
	broonie@kernel.org,
	robh@kernel.org
Subject: [PATCH v3 07/20] ASoC: dt-bindings: replace q6asm with q6dsp audio
 stream bindings
Date: Tue,  3 Aug 2021 13:53:58 +0100
Message-Id: <20210803125411.28066-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210803125411.28066-1-srinivas.kandagatla@linaro.org>
References: <20210803125411.28066-1-srinivas.kandagatla@linaro.org>
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

DSP Audio Strem bindings have been documented with DSP services bindings
which makes it difficult to reuse them, so pull them out in to a dedicated
bindings.
Also as part of this change convert them into yaml format.

This patch also removes q6asm bindings as dsp services are now documented in
apr bindings.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,q6asm.txt  | 70 --------------
 .../sound/qcom,q6dsp-audio-stream.yaml        | 94 +++++++++++++++++++
 2 files changed, 94 insertions(+), 70 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/qcom,q6asm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6dsp-audio-stream.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
deleted file mode 100644
index 8c4883becae9..000000000000
--- a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
+++ /dev/null
@@ -1,70 +0,0 @@
-Qualcomm Audio Stream Manager (Q6ASM) binding
-
-Q6ASM is one of the APR audio service on Q6DSP.
-Please refer to qcom,apr.txt for details of the common apr service bindings
-used by the apr service device.
-
-- but must contain the following property:
-
-- compatible:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "qcom,q6asm-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
-		    Or "qcom,q6asm" where the version number can be queried
-		    from DSP.
-		    example "qcom,q6asm-v2.0"
-
-= ASM DAIs (Digial Audio Interface)
-"dais" subnode of the ASM node represents dai specific configuration
-
-- compatible:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "qcom,q6asm-dais".
-
-- #sound-dai-cells
-	Usage: required
-	Value type: <u32>
-	Definition: Must be 1
-
-== ASM DAI is subnode of "dais" and represent a dai, it includes board specific
-configuration of each dai. Must contain the following properties.
-
-- reg
-	Usage: required
-	Value type: <u32>
-	Definition: Must be dai id
-
-- direction:
-	Usage: Required for Compress offload dais
-	Value type: <u32>
-	Definition: Specifies the direction of the dai stream
-			Q6ASM_DAI_TX_RX (0) for both tx and rx
-			Q6ASM_DAI_TX (1) for only tx (Capture/Encode)
-			Q6ASM_DAI_RX (2) for only rx (Playback/Decode)
-
-- is-compress-dai:
-	Usage: Required for Compress offload dais
-	Value type: <boolean>
-	Definition: present for Compress offload dais
-
-
-= EXAMPLE
-#include <dt-bindings/sound/qcom,q6asm.h>
-
-apr-service@7 {
-	compatible = "qcom,q6asm";
-	reg = <APR_SVC_ASM>;
-	q6asmdai: dais {
-		compatible = "qcom,q6asm-dais";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		#sound-dai-cells = <1>;
-
-		dai@0 {
-			reg = <0>;
-			direction = <Q6ASM_DAI_RX>;
-			is-compress-dai;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6dsp-audio-stream.yaml b/Documentation/devicetree/bindings/sound/qcom,q6dsp-audio-stream.yaml
new file mode 100644
index 000000000000..0e70b486b51a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6dsp-audio-stream.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/sound/qcom,q6dsp-audio-stream.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm DSP Audio Stream binding
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  This binding describes the Qualcomm DSP Audio stream
+
+properties:
+  compatible:
+    const: qcom,q6asm-dais
+
+  reg:
+    maxItems: 1
+
+  '#sound-dai-cells':
+    const: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+#Digital Audio Interfaces
+patternProperties:
+  '^dai@[0-9]+$':
+    type: object
+    description:
+      Q6DSP Audio Stream Digital Audio Interfaces.
+
+    properties:
+      reg:
+        description:
+          Digital Audio Interface ID
+
+      direction:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2]
+        description:
+          Compress DAI direction
+            0 = bi-directional
+            1 = tx only
+            2 = rx only
+
+      is-compress-dai:
+        type: boolean
+        description:
+          Indicate if DAI is for compress offload
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#sound-dai-cells"
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/qcom,apr.h>
+    apr {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        apr-service@7 {
+            reg = <APR_SVC_ASM>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            q6asmdai@1 {
+              compatible = "qcom,q6asm-dais";
+              reg = <1>;
+              #address-cells = <1>;
+              #size-cells = <0>;
+              #sound-dai-cells = <1>;
+
+              dai@1 {
+                reg = <1>;
+                is-compress-dai;
+              };
+            };
+        };
+      };
-- 
2.21.0

