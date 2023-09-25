Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C626EE7735F
	for <alsa-devel@archiver.kernel.org>; Sat, 30 Sep 2023 08:04:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C7C4BE8A;
	Sat, 30 Sep 2023 10:03:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C7C4BE8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696061054;
	bh=BwO8jlQ3ykFmKEt8IzdK1EEYo6KiH5lYXYXHAnO5pNE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Maj+l8oGBFE8Zk+vT510h/TlEMOcXiu57Oc/7Cpgv85o0VbMdbC3VWfQeuB27TafL
	 6an/H/YJNGT78SpBC8BLsWaQM1iORN3sRa9GrONZvaD1sfx1gA2/fDO5jxBGmnk6/e
	 /sAvYfzz+qs4iyMeIBy2AxeV6m3cTuFLGcrTMG6I=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C36EDF80587; Sat, 30 Sep 2023 10:03:01 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 356C1F80549;
	Sat, 30 Sep 2023 10:03:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1F2B2F8016A; Mon, 25 Sep 2023 18:57:31 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 61FA3F800AA
	for <alsa-devel@alsa-project.org>; Mon, 25 Sep 2023 18:57:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 61FA3F800AA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=erTWOzc2
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-690bd8f89baso5112324b3a.2
        for <alsa-devel@alsa-project.org>;
 Mon, 25 Sep 2023 09:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695661042; x=1696265842;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KNPKfLP0E+UkNkw5CTvEwC/Bj3Ev7o9rQHtsP3/MgPM=;
        b=erTWOzc2qd7PjRIFhRhhRXr4WkQmvrSm4tDEmJyOG1riuhHLgW3H01Bn2V66cE3EGP
         848xyqlAMEFBxlKpJYsSMqmiwmpe1dWIl96KktMRZclZFPm9GrUNVWh7LF24i3LwSmbZ
         DC9HEaZNES0uW1CEbbPJWNbUuH9rg8TnKyi1G/EAnwIO17BzXuRNIhNIUMu0sb1Ck+/+
         uacJ54zMH/ZpnLLOl7ar2gJNHVODgy8b91DBdsHbUfpwNcZwDk4AaIHb4rQFslg/E8wi
         L3bxOjmleq4iMAay2MCWz6SIm4m+JKaR/3NXJTb/PCTH27p2RxoeILGxfUwYgG5ckuFp
         pyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695661042; x=1696265842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KNPKfLP0E+UkNkw5CTvEwC/Bj3Ev7o9rQHtsP3/MgPM=;
        b=K8dZJoB8ZaGwv5bCj5s0HjnMhVPdDS0ShsW/qJ8HN0tEc1IMjfWHsqX2nfr1K3iULu
         Qx61yyGXj6Hk2SDQi44Hh8XHZOK+KTn56TUEsPQsB++xma2Y6nTQUhe0kZ8CO2uhF9ll
         1bwQibUAf3PJayzphEHfT2X6c+2EbMMnMOsN90rHxOY6KKmmPc9ynrb2SaP3GGSX0FuF
         qY47A7j4RuC6p+YusaZZQN0W3T0TXo26/RQfUP/GSr8rUBG8/pwNoA8a1os125KEcNwS
         jbYleknz89IdJMTdMo0qP6HiRVNc4dlCAzjmi/ujbyPvJ0edrjhxwyoNogicSc+uyQOn
         6w/A==
X-Gm-Message-State: AOJu0YybuQ/bgT0PhKjNecEePq0IRw3+SXgl7E5kFKBMyhkyCqQYp7mW
	k/X5lq0eWwm0VfI4wxk6XFU=
X-Google-Smtp-Source: 
 AGHT+IGgAIdPUxAnztT0fJPj4/tqnX0ygspeJDX0q+y8/ITWvnKA6PxrzpaVbgnvmtZnsupmDazAKA==
X-Received: by 2002:a05:6a21:601:b0:155:5c28:ea74 with SMTP id
 ll1-20020a056a21060100b001555c28ea74mr5201556pzb.12.1695661042173;
        Mon, 25 Sep 2023 09:57:22 -0700 (PDT)
Received: from brag-vm.localdomain ([27.4.138.218])
        by smtp.gmail.com with ESMTPSA id
 jw1-20020a170903278100b001c452f827casm9158507plb.257.2023.09.25.09.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 09:57:21 -0700 (PDT)
From: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: rt5616: Convert to dtschema
Date: Mon, 25 Sep 2023 22:27:15 +0530
Message-Id: <20230925165715.34883-1-bragathemanick0908@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: bragathemanick0908@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: N2WMZW662HPXLDH7IIH5NFVZ2BLN6ENG
X-Message-ID-Hash: N2WMZW662HPXLDH7IIH5NFVZ2BLN6ENG
X-Mailman-Approved-At: Sat, 30 Sep 2023 08:02:57 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/N2WMZW662HPXLDH7IIH5NFVZ2BLN6ENG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Convert the rt5616 audio CODEC bindings to DT schema
No error/warning seen when running make dt_binding_check

Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
---
 .../bindings/sound/realtek,rt5616.yaml        | 53 +++++++++++++++++++
 .../devicetree/bindings/sound/rt5616.txt      | 32 -----------
 2 files changed, 53 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5616.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/rt5616.txt

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5616.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5616.yaml
new file mode 100644
index 000000000000..00ff9b4e3c7e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5616.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/realtek,rt5616.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek rt5616 ALSA SoC audio codec driver
+
+description: |
+  Pins on the device (for linking into audio routes) for RT5616:
+
+      * IN1P
+      * IN2P
+      * IN2N
+      * LOUTL
+      * LOUTR
+      * HPOL
+      * HPOR
+
+maintainers:
+  - Bard Liao <bardliao@realtek.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: realtek,rt5616
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - '#sound-dai-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        codec@1b {
+            compatible = "realtek,rt5616";
+            reg = <0x1b>;
+            #sound-dai-cells = <0>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/rt5616.txt b/Documentation/devicetree/bindings/sound/rt5616.txt
deleted file mode 100644
index 540a4bf252e4..000000000000
--- a/Documentation/devicetree/bindings/sound/rt5616.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-RT5616 audio CODEC
-
-This device supports I2C only.
-
-Required properties:
-
-- compatible : "realtek,rt5616".
-
-- reg : The I2C address of the device.
-
-Optional properties:
-
-- clocks: The phandle of the master clock to the CODEC.
-
-- clock-names: Should be "mclk".
-
-Pins on the device (for linking into audio routes) for RT5616:
-
-  * IN1P
-  * IN2P
-  * IN2N
-  * LOUTL
-  * LOUTR
-  * HPOL
-  * HPOR
-
-Example:
-
-rt5616: codec@1b {
-	compatible = "realtek,rt5616";
-	reg = <0x1b>;
-};
-- 
2.34.1

