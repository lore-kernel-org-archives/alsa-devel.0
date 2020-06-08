Return-Path: <SRS0=Yvqk=7V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E04C433DF
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:48:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8C9F20774
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bfkpSn1z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbY8uGvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C9F20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 37DF015E5;
	Mon,  8 Jun 2020 19:47:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 37DF015E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591638485;
	bh=tZJy/NueJrR8WvzEsiwZwUm3mJvzeewM9GjxOe6KUPM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bfkpSn1zzdo8dXltqL7rxZTtPqC0Cm1NBt8ImIjBCC5ZC74rfDBwG5hpIoRL5fRUd
	 kYR68LsHyZgk2CK4vVb1Kh5Bw58VJt006j253Tf+fS97bo53ayxli4RTl7dxO1UazR
	 HEQbKQuWd/QkEGys4bIColpAvWJLnW1O70nc70Qo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A2A80F801F7;
	Mon,  8 Jun 2020 19:47:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 167F3F8021C; Mon,  8 Jun 2020 19:47:13 +0200 (CEST)
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com
 [IPv6:2a00:1450:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B0BF5F80124
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2020 19:47:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0BF5F80124
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="VbY8uGvf"
Received: by mail-ej1-x641.google.com with SMTP id l12so15518349ejn.10
 for <alsa-devel@alsa-project.org>; Mon, 08 Jun 2020 10:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5DU+mTFc8FCBMOx2TCs92eA+mmZPO6K1jVR+xUTvb6A=;
 b=VbY8uGvfw2F9GkWoelKfBW9Q+30lGEsS9oq7xu5wWNYo+plc8iWc8NFW/vQcMzhux+
 FEX4pYAZxSBK4HraYe2fhNc/TGkjDoNrqaaF9yHD2U/M+jVUwq8pZLL/F+Ml9EfDuUvn
 SxQ5U3pHPcK8uTzo+L6D/axJIFG7lBoti4lrvhsd3izSJw97XfjPcW8wRGa0LocwnKV7
 B+5p5Dot1vgF4Ay3g2RAbr7ia4s+vmkkHB/8v/9i7f1G2kJ5A01wMTZhdnVfIF7J79uS
 Z+KXvrixSVuBiveqPAchbWHn3HBwrXPg44d82poWCkqWkn4h4D3GRuDbktC4SPWGYsFG
 +KzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5DU+mTFc8FCBMOx2TCs92eA+mmZPO6K1jVR+xUTvb6A=;
 b=uhbIvo9jjebqKscitd29Ups/VlG81wPulvjIbZRvEFmKMjXFV9S5RQBh5M1IzVR9LV
 dykotjSMVOrPcour+0hIFD0Mh6Ce3NGGarjQEJcZMydXPExp7rr2iAg5FPRkS7GxpXX8
 c4wgHRWRqwlUKock6JJiOJU4LbeP26tVcBHnw61O4VXKXLqK4dI3BwyWDWIzlCWMI7xt
 UJhIleFYuGCHP5M82WlkVf5mkWkWpwI/wbUwrr3BeR1rzsS+UQF1KX6ffmGJWOu2bCeP
 Q9f5dWBwq63yR4yr/nD9VbGSOB5eH5u76Cm6KD+AvmkyWphUPKr0d+BbSU2KNE7ny+ur
 556A==
X-Gm-Message-State: AOAM532XiyDLseZPaTZup6CYsJ7HaPCW5zPx+4i+O15RKbV7gJm0lMof
 5EZ5xM23LVTXoo6GWRq7MvxIdtzK
X-Google-Smtp-Source: ABdhPJyWOjPLm++B+G4sil9tNkyqOvrVuTj5HLVTT06yuLdkdZuZui7VyePUa7uBGPQlGovBjrVP3g==
X-Received: by 2002:a17:906:7083:: with SMTP id
 b3mr21055647ejk.57.1591638422606; 
 Mon, 08 Jun 2020 10:47:02 -0700 (PDT)
Received: from localhost
 (p200300e41f3ad20076d02bfffe273f51.dip0.t-ipconnect.de.
 [2003:e4:1f3a:d200:76d0:2bff:fe27:3f51])
 by smtp.gmail.com with ESMTPSA id k22sm13219055edr.93.2020.06.08.10.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 10:47:01 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <robh+dt@kernel.org>
Subject: [PATCH] dt-bindings: sound: sgtl5000: Convert to json-schema
Date: Mon,  8 Jun 2020 19:46:58 +0200
Message-Id: <20200608174658.1315325-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>
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

From: Thierry Reding <treding@nvidia.com>

Convert the Freescale SGTL5000 device tree bindings from free-form text
format to json-schema.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../devicetree/bindings/sound/sgtl5000.txt    |  60 ----------
 .../devicetree/bindings/sound/sgtl5000.yaml   | 103 ++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |   2 -
 3 files changed, 103 insertions(+), 62 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/sgtl5000.txt
 create mode 100644 Documentation/devicetree/bindings/sound/sgtl5000.yaml

diff --git a/Documentation/devicetree/bindings/sound/sgtl5000.txt b/Documentation/devicetree/bindings/sound/sgtl5000.txt
deleted file mode 100644
index 9d9ff5184939..000000000000
--- a/Documentation/devicetree/bindings/sound/sgtl5000.txt
+++ /dev/null
@@ -1,60 +0,0 @@
-* Freescale SGTL5000 Stereo Codec
-
-Required properties:
-- compatible : "fsl,sgtl5000".
-
-- reg : the I2C address of the device
-
-- #sound-dai-cells: must be equal to 0
-
-- clocks : the clock provider of SYS_MCLK
-
-- VDDA-supply : the regulator provider of VDDA
-
-- VDDIO-supply: the regulator provider of VDDIO
-
-Optional properties:
-
-- VDDD-supply : the regulator provider of VDDD
-
-- micbias-resistor-k-ohms : the bias resistor to be used in kOhms
-	The resistor can take values of 2k, 4k or 8k.
-	If set to 0 it will be off.
-	If this node is not mentioned or if the value is unknown, then
-	micbias	resistor is set to 4K.
-
-- micbias-voltage-m-volts : the bias voltage to be used in mVolts
-	The voltage can take values from 1.25V to 3V by 250mV steps
-	If this node is not mentioned or the value is unknown, then
-	the value is set to 1.25V.
-
-- lrclk-strength: the LRCLK pad strength. Possible values are:
-0, 1, 2 and 3 as per the table below:
-
-VDDIO		1.8V		2.5V		3.3V
-0 = 		Disable
-1 =		1.66 mA		2.87 mA		4.02  mA
-2 =		3.33 mA		5.74 mA		8.03  mA
-3 =		4.99 mA		8.61 mA		12.05 mA
-
-- sclk-strength: the SCLK pad strength. Possible values are:
-0, 1, 2 and 3 as per the table below:
-
-VDDIO		1.8V		2.5V		3.3V
-0 = 		Disable
-1 =		1.66 mA		2.87 mA		4.02  mA
-2 =		3.33 mA		5.74 mA		8.03  mA
-3 =		4.99 mA		8.61 mA		12.05 mA
-
-Example:
-
-sgtl5000: codec@a {
-	compatible = "fsl,sgtl5000";
-	reg = <0x0a>;
-	#sound-dai-cells = <0>;
-	clocks = <&clks 150>;
-	micbias-resistor-k-ohms = <2>;
-	micbias-voltage-m-volts = <2250>;
-	VDDA-supply = <&reg_3p3v>;
-	VDDIO-supply = <&reg_3p3v>;
-};
diff --git a/Documentation/devicetree/bindings/sound/sgtl5000.yaml b/Documentation/devicetree/bindings/sound/sgtl5000.yaml
new file mode 100644
index 000000000000..4f29b63c54d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sgtl5000.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/sgtl5000.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale SGTL5000 Stereo Codec
+
+maintainers:
+  - Fabio Estevam <festevam@gmail.com>
+
+properties:
+  compatible:
+    const: fsl,sgtl5000
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+  clocks:
+    items:
+      - description: the clock provider of SYS_MCLK
+
+  VDDA-supply:
+    description: the regulator provider of VDDA
+
+  VDDIO-supply:
+    description: the regulator provider of VDDIO
+
+  VDDD-supply:
+    description: the regulator provider of VDDD
+
+  micbias-resistor-k-ohms:
+    description: The bias resistor to be used in kOhms. The resistor can take
+      values of 2k, 4k or 8k. If set to 0 it will be off. If this node is not
+      mentioned or if the value is unknown, then micbias resistor is set to
+      4k.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    enum: [ 0, 2, 4, 8 ]
+
+  micbias-voltage-m-volts:
+    description: The bias voltage to be used in mVolts. The voltage can take
+      values from 1.25V to 3V by 250mV steps. If this node is not mentioned
+      or the value is unknown, then the value is set to 1.25V.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    enum: [ 1250, 1500, 1750, 2000, 2250, 2500, 2750, 3000 ]
+
+  lrclk-strength:
+    description: |
+      The LRCLK pad strength. Possible values are: 0, 1, 2 and 3 as per the
+      table below:
+
+        VDDIO		1.8V		2.5V		3.3V
+        0 =		Disable
+        1 =		1.66 mA		2.87 mA		4.02  mA
+        2 =		3.33 mA		5.74 mA		8.03  mA
+        3 =		4.99 mA		8.61 mA		12.05 mA
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    enum: [ 0, 1, 2, 3 ]
+
+  sclk-strength:
+    description: |
+      The SCLK pad strength. Possible values are: 0, 1, 2 and 3 as per the
+      table below:
+
+        VDDIO		1.8V		2.5V		3.3V
+        0 =		Disable
+        1 =		1.66 mA		2.87 mA		4.02  mA
+        2 =		3.33 mA		5.74 mA		8.03  mA
+        3 =		4.99 mA		8.61 mA		12.05 mA
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    enum: [ 0, 1, 2, 3 ]
+
+required:
+  - compatible
+  - reg
+  - "#sound-dai-cells"
+  - clocks
+  - VDDA-supply
+  - VDDIO-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        codec@a {
+            compatible = "fsl,sgtl5000";
+            reg = <0x0a>;
+            #sound-dai-cells = <0>;
+            clocks = <&clks 150>;
+            micbias-resistor-k-ohms = <2>;
+            micbias-voltage-m-volts = <2250>;
+            VDDA-supply = <&reg_3p3v>;
+            VDDIO-supply = <&reg_3p3v>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 4165352a590a..b7e94fe8643f 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -80,8 +80,6 @@ properties:
           - fsl,mpl3115
             # MPR121: Proximity Capacitive Touch Sensor Controller
           - fsl,mpr121
-            # SGTL5000: Ultra Low-Power Audio Codec
-          - fsl,sgtl5000
             # G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire Interface
           - gmt,g751
             # Infineon IR38064 Voltage Regulator
-- 
2.24.1

