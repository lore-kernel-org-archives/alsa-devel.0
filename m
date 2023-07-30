Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CB2C00528
	for <alsa-devel@archiver.kernel.org>; Sun, 30 Jul 2023 19:44:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 893911E8;
	Sun, 30 Jul 2023 21:43:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 893911E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690746246;
	bh=jeCS7wvxq8qRllGrpot4N7ZdSbbZOGHjTSZBv99Qdi8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=bCBlLCjofQr68fmBxXAoDWPwNFwUdGYgfKa78BJgiAuBcto8rbB0OwD6+bQ+G+w4V
	 iOVYzK9S+O5iuNWBxlVPkhXujIMgkaqiWmn8YTOi3fyzXxIpKAg8zrssh9B/fce8/3
	 /FZSvMQxXR0ANttytqTKiCrQ19ARrQX3mUWgu7P4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 075BAF80087; Sun, 30 Jul 2023 21:42:48 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B11F4F8016D;
	Sun, 30 Jul 2023 21:42:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7530AF8016D; Sun, 30 Jul 2023 21:42:44 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C655EF80153
	for <alsa-devel@alsa-project.org>; Sun, 30 Jul 2023 21:42:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C655EF80153
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=vc9CMHFK
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-99bf3f59905so369517366b.3
        for <alsa-devel@alsa-project.org>;
 Sun, 30 Jul 2023 12:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690746152; x=1691350952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hOIx3c8bCXmFks0uYOhLCtUYhVUu2tl5xgP/O/vVgJI=;
        b=vc9CMHFKnR97qG1GwBTBh1ObSMRpa+wldPux2V3EY50WpG3b32cD7AfyEgXv2R1kYf
         ra4VmLBQgV8qmxTS7GbE1ytMiKZvZbZ7mH8zkIlfJm1OVdE+b6GFYkEPI3/4DR8ispKv
         J1Wv3gJ6G2bL+MEm0ff+gJE0w83tIFpHZviCXbwrovuTRZRA30CuunaNfIA6KK7IOipA
         8+niPbaue2B0au8MR+aMoF0fgFIZK+Lk+NdXhstMC6U/s8mQr298EQWH8F5bYY6Q978G
         lSO+icKCFPo+xMg5J+cMQJz5tfHBvUQltXrOtk44S3djsGrQF2XmjjE1f96QqmBxjk4N
         D7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690746152; x=1691350952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hOIx3c8bCXmFks0uYOhLCtUYhVUu2tl5xgP/O/vVgJI=;
        b=NT7TfUO7QyT+65CWWtr82OxXoXRSFgWFxD2+l14oIUIJ+BT+HUr9F/uRaqRgrj3BlN
         qeXclurpJLeFxdaC6UCZlaF4P6qKapShvPj6PmVb7/nlib3z9dab2293HkmIiRwWv+cb
         RSE3Ou511l7fwA1gaPZbqrGfBWJvPiqegjRUdG1epZ5GeTrDIfYPYF4N1fPATAjWR3Lp
         bQ2I86eKpoR7xgNBDbNe2i5aFWisGdwcodrDK1i+UZh1oz7tQpwrVqgl4fGP8Y4qDjMx
         IcNUH/zCBAnZTmlrmkDWg7PsLNp5Zr0CNyNd0Dlcex6PhToVvIYHmKa2e61LeT16Gb6T
         4PEw==
X-Gm-Message-State: ABy/qLYRLgoGFAgCZhUT69A2SWYzkudZGFps5lvhrB6D+0F8BOuXlmd6
	wfEIErKbEkTmKJek3db2CO/egg==
X-Google-Smtp-Source: 
 APBJJlF+nwd2cY5Tl1A0VVfn6wBKe5tUmj/bu9lDv5yNX/9MfkMSk0RHzpD27NBOLmdO4E94ht1w2A==
X-Received: by 2002:a17:906:76c8:b0:99b:ef1e:3836 with SMTP id
 q8-20020a17090676c800b0099bef1e3836mr6340313ejn.9.1690746152559;
        Sun, 30 Jul 2023 12:42:32 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id
 j25-20020a170906255900b0099b4d86fbccsm5140490ejb.141.2023.07.30.12.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 12:42:32 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryan Lee <ryans.lee@maximintegrated.com>,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: dt-bindings: Convert maxim,max98925 to DT schema
Date: Sun, 30 Jul 2023 21:42:30 +0200
Message-Id: <20230730194230.34447-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ZQN3VYL5JWPFR7JASZDVQRWSOMRRCIEJ
X-Message-ID-Hash: ZQN3VYL5JWPFR7JASZDVQRWSOMRRCIEJ
X-MailFrom: krzysztof.kozlowski@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZQN3VYL5JWPFR7JASZDVQRWSOMRRCIEJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Convert the Maxim Integrated MAX98925/MAX98926/MAX98927 speaker
amplifier bindings to DT schema format.  Changes during conversion: add
sound-dai-cells, already used by DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Ryan,
As original author, I added you as bindings maintainer. Is that okay or
maybe someone else from Maxim should take care about the bindings?
---
 .../devicetree/bindings/sound/max9892x.txt    |  44 --------
 .../bindings/sound/maxim,max98925.yaml        | 100 ++++++++++++++++++
 2 files changed, 100 insertions(+), 44 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/max9892x.txt
 create mode 100644 Documentation/devicetree/bindings/sound/maxim,max98925.yaml

diff --git a/Documentation/devicetree/bindings/sound/max9892x.txt b/Documentation/devicetree/bindings/sound/max9892x.txt
deleted file mode 100644
index 98cb9ba5b328..000000000000
--- a/Documentation/devicetree/bindings/sound/max9892x.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-Maxim Integrated MAX98925/MAX98926/MAX98927 Speaker Amplifier
-
-This device supports I2C.
-
-Required properties:
-
-  - compatible : should be one of the following
-    - "maxim,max98925"
-    - "maxim,max98926"
-    - "maxim,max98927"
-
-  - vmon-slot-no : slot number used to send voltage information
-                   or in inteleave mode this will be used as
-                   interleave slot.
-                   MAX98925/MAX98926 slot range : 0 ~ 30,  Default : 0
-                   MAX98927 slot range : 0 ~ 15,  Default : 0
-
-  - imon-slot-no : slot number used to send current information
-                   MAX98925/MAX98926 slot range : 0 ~ 30,  Default : 0
-                   MAX98927 slot range : 0 ~ 15,  Default : 0
-
-  - interleave-mode : When using two MAX9892X in a system it is
-                   possible to create ADC data that that will
-                   overflow the frame size. Digital Audio Interleave
-                   mode provides a means to output VMON and IMON data
-                   from two devices on a single DOUT line when running
-                   smaller frames sizes such as 32 BCLKS per LRCLK or
-                   48 BCLKS per LRCLK.
-                   Range : 0 (off), 1 (on),  Default : 0
-
-  - reg : the I2C address of the device for I2C
-
-Optional properties:
-  - reset-gpios : GPIO to reset the device
-
-Example:
-
-codec: max98927@3a {
-   compatible = "maxim,max98927";
-   vmon-slot-no = <0>;
-   imon-slot-no = <1>;
-   interleave-mode = <0>;
-   reg = <0x3a>;
-};
diff --git a/Documentation/devicetree/bindings/sound/maxim,max98925.yaml b/Documentation/devicetree/bindings/sound/maxim,max98925.yaml
new file mode 100644
index 000000000000..a01a130ef686
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/maxim,max98925.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/maxim,max98925.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX98925/MAX98926/MAX98927 speaker amplifier
+
+maintainers:
+  - Ryan Lee <ryans.lee@maximintegrated.com>
+
+properties:
+  compatible:
+    enum:
+      - maxim,max98925
+      - maxim,max98926
+      - maxim,max98927
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  '#sound-dai-cells':
+    const: 0
+
+  vmon-slot-no:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 30
+    default: 0
+    description:
+      Slot number used to send voltage information or in inteleave mode this
+      will be used as interleave slot.
+
+  imon-slot-no:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 30
+    default: 0
+    description:
+      Slot number used to send current information.
+
+  interleave-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    default: 0
+    description:
+      When using two MAX9892X in a system it is possible to create ADC data
+      that will overflow the frame size. Digital Audio Interleave mode provides
+      a means to output VMON and IMON data from two devices on a single DOUT
+      line when running smaller frames sizes such as 32 BCLKS per LRCLK or 48
+      BCLKS per LRCLK.
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: dai-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - maxim,max98927
+    then:
+      properties:
+        vmon-slot-no:
+          minimum: 0
+          maximum: 15
+
+        imon-slot-no:
+          minimum: 0
+          maximum: 15
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        #include <dt-bindings/gpio/gpio.h>
+        audio-codec@3a {
+            compatible = "maxim,max98927";
+            reg = <0x3a>;
+            #sound-dai-cells = <0>;
+
+            pinctrl-0 = <&speaker_default>;
+            pinctrl-names = "default";
+
+            reset-gpios = <&tlmm 69 GPIO_ACTIVE_LOW>;
+
+            vmon-slot-no = <1>;
+            imon-slot-no = <0>;
+        };
+    };
-- 
2.34.1

