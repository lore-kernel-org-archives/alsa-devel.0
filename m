Return-Path: <SRS0=TbbB=CE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740F2C433E1
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:07:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC7A2083B
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QmTaVZ0M";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SODSLjCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC7A2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 44458173C;
	Wed, 26 Aug 2020 13:06:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 44458173C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598440021;
	bh=5MRbFVFDOhHo12FgJ0zucgin7OvUyWCg4JZakq8zd70=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QmTaVZ0Mbxm+GrzgjfBb8RwCUi4oyuciIgbF0YPuVpD0DZq/K1q6mpQf1XH81eRlw
	 fF9mO8NyVP9uCZMbYrzQumbt7YAjX45yQ5XQDkQdv6YgUprwgosMn8xJlBVsX+3CMI
	 G/s+G4ZKi0YlxdhBU5r4Kmq5g4Qbrm6X1Vc6YoKo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ADC7AF801EC;
	Wed, 26 Aug 2020 13:05:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 42A16F801D9; Wed, 26 Aug 2020 13:05:24 +0200 (CEST)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20::1042])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7698EF801EC
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2020 13:05:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7698EF801EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="SODSLjCJ"
Received: by mail-pj1-x1042.google.com with SMTP id i13so725174pjv.0
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2020 04:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=57ATY6rlaZ9eWDcltcMWl9pjLEa9gziieo3Id6n6Wg8=;
 b=SODSLjCJPxJuz8GNvtiwPEG9mbBU6waV9kB51eDienSbClMJV7QUxvAjRWVOjIjT1x
 gG2LhvG30xscwrLxUrCcfJVFDeKX5Epw91nWxx3ikTQLnnzCPF6o3sFfrgwsBGnZ6jm6
 g/puoak4Ejacz/UATbtTw739rS7Jl33YuIdsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=57ATY6rlaZ9eWDcltcMWl9pjLEa9gziieo3Id6n6Wg8=;
 b=Q/+vkiPqdkScUD6wfERQ4Ee1JUZ1yUlAjRot/Vbofa/ILIMeADJRlGZ0wkeF2TgWZ8
 y3A2W0TEP2RtYnK9IXMqpr1ni/s9IfD+lBSMAND/G9vZ2H79xSWSIlSell2BvXW0ODK1
 X9qlT5o94H1I8P/E+JZDSRHIVI/UNag2644VxbmAqQLHU5DTh0hGhk5s4N0owSxADl2g
 WBw0Ag6ioGs4ZPpfv/LcSzQlH1JMAEzCHRNYVP8r8PrKrEizalkQqSTLM+SWNKo7IP77
 sLu3SS/gdV6n3fccc1erOnfosTHlf9qC9oFDlIdmYthC0WizxHmf6eOD+Mo7BgM89wjq
 bBHw==
X-Gm-Message-State: AOAM530Br1Ziv01Swztob4McQVCuz5qRu95kHlUumuanhqzldhWkZmV3
 fQe8JLND5icZZaPfLW7HAN6S1A==
X-Google-Smtp-Source: ABdhPJzYRhsn/wYXuVMOpPBm4M674M05q8cS5wEqqc7VfH+Jxwmu3FKrFuPJeVxUpfirXrS2ykg3rQ==
X-Received: by 2002:a17:902:bb87:: with SMTP id
 m7mr11409065pls.61.1598439909717; 
 Wed, 26 Aug 2020 04:05:09 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:de4a:3eff:fe7d:d39c])
 by smtp.gmail.com with ESMTPSA id o65sm2578660pfg.105.2020.08.26.04.05.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2020 04:05:09 -0700 (PDT)
From: Cheng-Yi Chiang <cychiang@chromium.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] ASoC: qcom: dt-bindings: Add sc7180 machine bindings
Date: Wed, 26 Aug 2020 19:04:53 +0800
Message-Id: <20200826110454.1811352-2-cychiang@chromium.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200826110454.1811352-1-cychiang@chromium.org>
References: <20200826110454.1811352-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
 tzungbi@chromium.org, Banajit Goswami <bgoswami@codeaurora.org>,
 Stephan Gerhold <stephan@gerhold.net>, linux-arm-msm@vger.kernel.org,
 Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, alsa-devel@alsa-project.org,
 Andy Gross <agross@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>,
 Mark Brown <broonie@kernel.org>, dianders@chromium.org,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, dgreid@chromium.org,
 linux-arm-kernel@lists.infradead.org, Cheng-Yi Chiang <cychiang@chromium.org>
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

Add devicetree bindings documentation file for sc7180 sound card.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 .../bindings/sound/qcom,sc7180.yaml           | 124 ++++++++++++++++++
 1 file changed, 124 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,sc7180.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml b/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
new file mode 100644
index 000000000000..a85375974a4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
@@ -0,0 +1,124 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,sc7180.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies Inc. SC7180 ASoC sound card driver
+
+maintainers:
+  - Rohit kumar <rohitkr@codeaurora.org>
+  - Cheng-Yi Chiang <cychiang@chromium.org>
+
+description:
+  This binding describes the SC7180 sound card which uses LPASS for audio.
+
+properties:
+  compatible:
+    const: qcom,sc7180-sndcard
+
+  audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description:
+      A list of the connections between audio components. Each entry is a
+      pair of strings, the first being the connection's sink, the second
+      being the connection's source.
+
+  model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: User specified audio sound card name
+
+  aux-dev:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle of the codec for headset detection
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^dai-link(@[0-9])?$":
+    description:
+      Each subnode represents a dai link. Subnodes of each dai links would be
+      cpu/codec dais.
+
+    type: object
+
+    properties:
+      link-name:
+        description: Indicates dai-link name and PCM stream name.
+        $ref: /schemas/types.yaml#/definitions/string
+        maxItems: 1
+
+      reg:
+        description: dai link address.
+
+      cpu:
+        description: Holds subnode which indicates cpu dai.
+        type: object
+        properties:
+          sound-dai: true
+
+      codec:
+        description: Holds subnode which indicates codec dai.
+        type: object
+        properties:
+          sound-dai: true
+
+    required:
+      - link-name
+      - cpu
+      - codec
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - model
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+
+  - |
+    sound {
+        compatible = "qcom,sc7180-sndcard";
+        model = "sc7180-snd-card";
+
+        audio-routing =
+                    "Headphone Jack", "HPOL",
+                    "Headphone Jack", "HPOR";
+
+        aux-dev = <&alc5682>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dai-link@0 {
+            link-name = "MultiMedia0";
+            reg = <0>;
+            cpu {
+                sound-dai = <&lpass_cpu 0>;
+            };
+
+            codec {
+                sound-dai = <&alc5682 0>;
+            };
+        };
+
+        dai-link@1 {
+            link-name = "MultiMedia1";
+            reg = <1>;
+            cpu {
+                sound-dai = <&lpass_cpu 1>;
+            };
+
+            codec {
+                sound-dai = <&max98357a>;
+            };
+        };
+    };
-- 
2.28.0.297.g1956fa8f8d-goog

