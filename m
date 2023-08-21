Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61514C3DA6F
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Aug 2023 07:36:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B2B5E847;
	Thu, 24 Aug 2023 09:35:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B2B5E847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692862590;
	bh=eYYuIguSF1/jPXSxfuXL3BDNIn2AiTma6JWLnRNaeJc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=PnU7Djf4n6IWD0Nb0mqnvNJVJk4wOgQZGHsx0bbwZ3IKEcmqe6/BMXMX0DF5y/O17
	 Fo9dWh5ilkB0Ml0bKNaf59vG+1Qp4jPal3c46jzQuB3pIIizJRn4mmLhgqSclZIK1Y
	 x1n5HxIgblYop78L+/zQfXjv91/BpXMIOVwmk12M=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3911FF805F0; Thu, 24 Aug 2023 09:32:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6C53DF805F1;
	Thu, 24 Aug 2023 09:32:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C7109F800F8; Mon, 21 Aug 2023 16:43:13 +0200 (CEST)
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1BBD6F8025E
	for <alsa-devel@alsa-project.org>; Mon, 21 Aug 2023 16:42:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1BBD6F8025E
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id 7A17224E17F;
	Mon, 21 Aug 2023 22:41:53 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 21 Aug
 2023 22:41:53 +0800
Received: from localhost.localdomain (113.72.145.205) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 21 Aug
 2023 22:41:52 +0800
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Claudiu Beznea <Claudiu.Beznea@microchip.com>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maxim Kochetkov
	<fido_max@inbox.ru>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor.dooley@microchip.com>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>
CC: Jose Abreu <joabreu@synopsys.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Walker Chen <walker.chen@starfivetech.com>, "Xingyu
 Wu" <xingyu.wu@starfivetech.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<linux-riscv@lists.infradead.org>
Subject: [PATCH v2 1/5] ASoC: dt-bindings: snps,designware-i2s: Add StarFive
 JH7110 SoC support
Date: Mon, 21 Aug 2023 22:41:47 +0800
Message-ID: <20230821144151.207339-2-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230821144151.207339-1-xingyu.wu@starfivetech.com>
References: <20230821144151.207339-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.145.205]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable
X-MailFrom: xingyu.wu@starfivetech.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 63R3B36ZHWM5FSGFVT6W2VP33D5YIPA4
X-Message-ID-Hash: 63R3B36ZHWM5FSGFVT6W2VP33D5YIPA4
X-Mailman-Approved-At: Thu, 24 Aug 2023 07:32:02 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/63R3B36ZHWM5FSGFVT6W2VP33D5YIPA4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add the StarFive JH7110 (TX0/TX1/RX channel) SoC support in the bindings
of Designware I2S controller. The I2S controller needs two reset items
to work properly on the JH7110 SoC. And TX0 channel as master mode needs
5 clock items and TX1/RX channels as slave mode need 9 clock items on
the JH7110 SoC. The RX channel needs System Register Controller property
to enable it and other platforms do not need it.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 .../bindings/sound/snps,designware-i2s.yaml   | 108 +++++++++++++++++-
 1 file changed, 105 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/snps,designware-i2s.=
yaml b/Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml
index a970fd264b21..a48d040b0a4f 100644
--- a/Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml
@@ -17,6 +17,9 @@ properties:
           - const: snps,designware-i2s
       - enum:
           - snps,designware-i2s
+          - starfive,jh7110-i2stx0
+          - starfive,jh7110-i2stx1
+          - starfive,jh7110-i2srx
=20
   reg:
     maxItems: 1
@@ -29,15 +32,36 @@ properties:
     maxItems: 1
=20
   clocks:
-    description: Sampling rate reference clock
-    maxItems: 1
+    items:
+      - description: Sampling rate reference clock
+      - description: APB clock
+      - description: Audio master clock
+      - description: Inner audio master clock source
+      - description: External audio master clock source
+      - description: Bit clock
+      - description: Left/right channel clock
+      - description: External bit clock
+      - description: External left/right channel clock
+    minItems: 1
=20
   clock-names:
-    const: i2sclk
+    items:
+      - const: i2sclk
+      - const: apb
+      - const: mclk
+      - const: mclk_inner
+      - const: mclk_ext
+      - const: bclk
+      - const: lrck
+      - const: bclk_ext
+      - const: lrck_ext
+    minItems: 1
=20
   resets:
     items:
       - description: Optional controller resets
+      - description: controller reset of Sampling rate
+    minItems: 1
=20
   dmas:
     items:
@@ -51,6 +75,17 @@ properties:
       - const: rx
     minItems: 1
=20
+  starfive,syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to System Register Controller sys_sysco=
n node.
+          - description: I2S-rx enabled control offset of SYS_SYSCONSAIF=
__SYSCFG register.
+          - description: I2S-rx enabled control mask
+    description:
+      The phandle to System Register Controller syscon node and the I2S-=
rx(ADC)
+      enabled control offset and mask of SYS_SYSCONSAIF__SYSCFG register=
.
+
 allOf:
   - $ref: dai-common.yaml#
   - if:
@@ -66,6 +101,73 @@ allOf:
       properties:
         "#sound-dai-cells":
           const: 0
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: snps,designware-i2s
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          maxItems: 1
+        resets:
+          maxItems: 1
+    else:
+      properties:
+        resets:
+          minItems: 2
+          maxItems: 2
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: starfive,jh7110-i2stx0
+    then:
+      properties:
+        clocks:
+          minItems: 5
+          maxItems: 5
+        clock-names:
+          minItems: 5
+          maxItems: 5
+      required:
+        - resets
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: starfive,jh7110-i2stx1
+    then:
+      properties:
+        clocks:
+          minItems: 9
+          maxItems: 9
+        clock-names:
+          minItems: 9
+          maxItems: 9
+      required:
+        - resets
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: starfive,jh7110-i2srx
+    then:
+      properties:
+        clocks:
+          minItems: 9
+          maxItems: 9
+        clock-names:
+          minItems: 9
+          maxItems: 9
+      required:
+        - resets
+        - starfive,syscon
+    else:
+      properties:
+        starfive,syscon: false
=20
 required:
   - compatible
--=20
2.25.1

