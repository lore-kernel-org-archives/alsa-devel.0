Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF10C001DB
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Aug 2023 14:30:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6704282B;
	Mon, 14 Aug 2023 16:29:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6704282B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692023399;
	bh=QIeeZ1pM1uPwbJ6uNuH9QINRBiqNaqujgRGvAShBnx8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=NE3K8IaG1r2d0KU90p5d+tdGBJur+aNUe6nRkI85wXKD3b8Wf5tbQrT1HD4Fc26+C
	 sp+t7B3r0NERHnuVu1Bxee/opzkyTHdayZnMkEroIfoumeNZd2OgeylYpnqeYHAe9C
	 4atF+knVaXwn6P614huSDJkDRhfbRP0rkBs5TyvM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6D5F3F805DF; Mon, 14 Aug 2023 16:27:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C9A8F805D9;
	Mon, 14 Aug 2023 16:26:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 27193F80510; Mon, 14 Aug 2023 10:06:45 +0200 (CEST)
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com
 [61.152.239.71])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DFD95F80272
	for <alsa-devel@alsa-project.org>; Mon, 14 Aug 2023 10:06:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DFD95F80272
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 43B3A82CB;
	Mon, 14 Aug 2023 16:06:21 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 14 Aug
 2023 16:06:21 +0800
Received: from ubuntu.localdomain (183.27.98.20) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 14 Aug
 2023 16:06:20 +0800
From: Hal Feng <hal.feng@starfivetech.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Claudiu
 Beznea" <claudiu.beznea@microchip.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Walker Chen <walker.chen@starfivetech.com>, Xingyu Wu
	<xingyu.wu@starfivetech.com>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Hal Feng <hal.feng@starfivetech.com>
CC: <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/3] ASoC: dt-bindings: Add StarFive JH7110 PWM-DAC
 controller
Date: Mon, 14 Aug 2023 16:06:16 +0800
Message-ID: <20230814080618.10036-2-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230814080618.10036-1-hal.feng@starfivetech.com>
References: <20230814080618.10036-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.98.20]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable
X-MailFrom: hal.feng@starfivetech.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: DUK5XDBIVQNIFYLGNYWMKQ5QQ5U6VFAG
X-Message-ID-Hash: DUK5XDBIVQNIFYLGNYWMKQ5QQ5U6VFAG
X-Mailman-Approved-At: Mon, 14 Aug 2023 14:26:37 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DUK5XDBIVQNIFYLGNYWMKQ5QQ5U6VFAG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add bindings for the PWM-DAC controller on the JH7110
RISC-V SoC by StarFive Ltd.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../sound/starfive,jh7110-pwmdac.yaml         | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/starfive,jh71=
10-pwmdac.yaml

diff --git a/Documentation/devicetree/bindings/sound/starfive,jh7110-pwmd=
ac.yaml b/Documentation/devicetree/bindings/sound/starfive,jh7110-pwmdac.=
yaml
new file mode 100644
index 000000000000..e2b4db6aa2fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/starfive,jh7110-pwmdac.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/starfive,jh7110-pwmdac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 PWM-DAC Controller
+
+description:
+  The PWM-DAC Controller uses PWM square wave generators plus RC filters=
 to
+  form a DAC for audio play in StarFive JH7110 SoC. This audio play cont=
roller
+  supports 16 bit audio format, up to 48K sampling frequency, up to left=
 and
+  right dual channels.
+
+maintainers:
+  - Hal Feng <hal.feng@starfivetech.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: starfive,jh7110-pwmdac
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: PWMDAC APB
+      - description: PWMDAC CORE
+
+  clock-names:
+    items:
+      - const: apb
+      - const: core
+
+  resets:
+    maxItems: 1
+    description: PWMDAC APB
+
+  dmas:
+    maxItems: 1
+    description: TX DMA Channel
+
+  dma-names:
+    const: tx
+
+  "#sound-dai-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - dmas
+  - dma-names
+  - "#sound-dai-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    pwmdac@100b0000 {
+        compatible =3D "starfive,jh7110-pwmdac";
+        reg =3D <0x100b0000 0x1000>;
+        clocks =3D <&syscrg 157>,
+                 <&syscrg 158>;
+        clock-names =3D "apb", "core";
+        resets =3D <&syscrg 96>;
+        dmas =3D <&dma 22>;
+        dma-names =3D "tx";
+        #sound-dai-cells =3D <0>;
+    };
--=20
2.38.1

