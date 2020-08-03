Return-Path: <SRS0=KW3j=BN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58494C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 04:03:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D937A20719
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 04:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sNpfDiZ2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ExnEfLKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D937A20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E54A41657;
	Mon,  3 Aug 2020 06:02:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E54A41657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596427419;
	bh=VxwEkX3rv4GnfRUveNt//KrLsYdh8pndoy41p/lHw1c=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sNpfDiZ2GLCvtpta0M/HiEyq5tWgZfZ47TP6iH1cu/KkBav4ibbVyxsJdBY+BU9bZ
	 E0fF/7yhGXaZImaA4KrshLEKUD+437T6V8eSa2TgvQh1753loX6P8d1SmqbrM+Vthm
	 rcgI4sZfUHcgCKCv80ZkTVY6+Fw4tiM27auOMquc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 26193F802C3;
	Mon,  3 Aug 2020 06:01:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0C389F802C4; Mon,  3 Aug 2020 06:01:53 +0200 (CEST)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20::1041])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 62838F800B7
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2020 06:01:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 62838F800B7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="ExnEfLKv"
Received: by mail-pj1-x1041.google.com with SMTP id d4so781641pjx.5
 for <alsa-devel@alsa-project.org>; Sun, 02 Aug 2020 21:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HddkWWY8Rx43iOmkebsAosLkWhk0laALdAzS7aNVW0o=;
 b=ExnEfLKvpQuoR44gsXAbve07rZhvE0L8IQkIIeHBAjvUZaydxSYN8AyjPX+0t96SfW
 tJfMaq17X20bLRNxQ7uLG+3zqxuM0ScVRYAhcqbaSdOE4wkA12+AU0Lxc5+0NhzG2iFX
 mS7CWKaWdWXJIQ/MnDjJPvE2sd+fqNKXR5QsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HddkWWY8Rx43iOmkebsAosLkWhk0laALdAzS7aNVW0o=;
 b=chXA99JIRTlJdWeh4Lj2V0vlJlTZAQg+2y9PPITPRHqXVBYp5uut9JsoTO/ywaqhfO
 iiRUljVKk7v1j89VsEE89PW+phhGN/diGKpzhy0ZCHJewkM916e0OzFv3kHu6zZLEZa+
 QwsBE+uvkGL0edUIsHlcfwykgzOeb0ZSkvVsQTD12FwtYPivj7++y9L+ikX5Sx1yjIfG
 /5CUmzN28SLAkF8E2uoNvqNpQovs8VGlFxaDH15edJlvUzMIWnkjTZpTnPlPLZawSusm
 OKzjkg5G4l2N6IbhvPfKrJidTYNwJSFBCRTbOGHb/06hD3HpuhXNpSFtLpkAA2R1Tcgq
 oxLQ==
X-Gm-Message-State: AOAM533V0MrGWi0A20uec0E8Rkqn4W0SMEuDl262HelTl4H8rpoRcGCu
 t/Pv3SpBJ4/VQ8vjwOLtqCH8MA==
X-Google-Smtp-Source: ABdhPJwnMRgGqxCkQaAC3q6BdFwkxHy8qbbV7wbFd54Qi87GMPeA5DwSJbHIZo6TiVnS1w9dDkVo/w==
X-Received: by 2002:a17:90a:20af:: with SMTP id
 f44mr14182023pjg.169.1596427299437; 
 Sun, 02 Aug 2020 21:01:39 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:de4a:3eff:fe7d:d39c])
 by smtp.gmail.com with ESMTPSA id p11sm17549569pgh.80.2020.08.02.21.01.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Aug 2020 21:01:38 -0700 (PDT)
From: Cheng-Yi Chiang <cychiang@chromium.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] ASoC: qcom: dt-bindings: Add sc7180 machine bindings
Date: Mon,  3 Aug 2020 12:01:21 +0800
Message-Id: <20200803040122.2063634-2-cychiang@chromium.org>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803040122.2063634-1-cychiang@chromium.org>
References: <20200803040122.2063634-1-cychiang@chromium.org>
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
 .../bindings/sound/qcom,sc7180.yaml           | 113 ++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,sc7180.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml b/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
new file mode 100644
index 000000000000..c74f0fe9fb3b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
@@ -0,0 +1,113 @@
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
+    contains:
+      const: qcom,sc7180-sndcard
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
+patternProperties:
+  "^dai-link(@[0-9]+)?$":
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
+        $ref: /schemas/types.yaml#/definitions/uint32
+        maxItems: 1
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
2.28.0.163.g6104cc2f0b6-goog

