Return-Path: <SRS0=75ci=BI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8257FC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jul 2020 10:22:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AA26206D4
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jul 2020 10:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Xn2kHpum";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vQjqvq74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA26206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 62EB416AD;
	Wed, 29 Jul 2020 12:21:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 62EB416AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596018137;
	bh=KZDY0T6Oj5kZPX2bvi28/V5jMbm1TjGpBdiPQdVnlgs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Xn2kHpummVl8rLDqzQVnmRvhJtTRtiIGnpGhXrRgPewHdJnlVPiAf/f26jbfZhtk8
	 NHCpq/3Pxi9Dj5JWajO0m9ZSSN/fQ/ond8zbTJtItVqaw5Oz2N3ZQZCCIq37C+yFJb
	 CEAL/bX8fuYp3WsFfhdcZvqIEE1hsSlhdj16uZAE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EF464F80171;
	Wed, 29 Jul 2020 12:21:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C174FF801A3; Wed, 29 Jul 2020 12:21:25 +0200 (CEST)
Received: from esa4.microchip.iphmx.com (esa4.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7AB5AF8012F
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2020 12:21:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7AB5AF8012F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.b="vQjqvq74"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1596018080; x=1627554080;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=KZDY0T6Oj5kZPX2bvi28/V5jMbm1TjGpBdiPQdVnlgs=;
 b=vQjqvq74EKkLvcKtA5X5ZpMpSknqnPtkI0+naZPbA6YcNA4H5Q0AIoM9
 EIC6UyLnCPhMOAAN1sty5gXPswUsnfwFEMLbhyiyL8XElQROY4Z+BBkTp
 rKBpOWa/4bcl4VvVnaXrZf6nUAlDbR438hSNhRyo6qfhk9OhAaj7oeS1Q
 uC0j1QpoLxOrS2k+hhMVlGD8gS1h5bOBmwbPqvrrbxZn9y16Hb90zw8Fq
 aXxLaaVrmGYc4YrmpkN+WP6Zy/qt4cgZGOSyMUx2by7h2KGsGd/H17EvM
 lWVj/3GFjoJhbYG4AXqPQEst2CpcrsMTmR5iRgMsJgjriK7AauKE8R0se w==;
IronPort-SDR: /1NWZyD0fKGEaB+J+GQxSEnytQBCoc/xzTua5KVjSATKO1f1DjS/352C5rNuHUzCfse5D2crBu
 5cyA42IWp4xMBcZlqSsSGRG8siKzYVYKLUKas1t1eUE7qEI2ruyk+opwyQjAU7w3r6xO9zgNWb
 aLafBTKuV7z01lVsIYkwfyDEkc3lTyMhcLZTpvsz09wcVHfo6TGrVbh2F0vfIG0JltHSc+U1p8
 PsU6axUSpLYOaMEr9z9VNzlhkllZVJOEmCldbH4CqzRxtW9oul3yw5LGgwSqVvn3bA+t+5hXl1
 bq0=
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800"; d="scan'208";a="81629155"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256;
 29 Jul 2020 03:21:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 29 Jul 2020 03:21:11 -0700
Received: from rob-ult-m19940.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 29 Jul 2020 03:19:07 -0700
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To: <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: sound: add DT bindings for Microchip
 S/PDIF TX Controller
Date: Wed, 29 Jul 2020 13:19:21 +0300
Message-ID: <20200729101922.3033616-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Cc: alexandre.belloni@bootlin.com, lgirdwood@gmail.com,
 nicolas.ferre@microchip.com, robh+dt@kernel.org, tiwai@suse.com,
 ludovic.desroches@microchip.com, broonie@kernel.org, Codrin
 Ciubotariu <codrin.ciubotariu@microchip.com>
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

This patch adds DT bindings for the new Microchip S/PDIF TX Controller
embedded inside sama7g5 SoCs.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Changes in v2:
 - replaced https with http
 - reworked example, included bindings;

 .../bindings/sound/mchp,spdiftx.yaml          | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml

diff --git a/Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml b/Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml
new file mode 100644
index 000000000000..2b7c27391f0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/mchp,spdiftx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip S/PDIF Tx Controller Device Tree Bindings
+
+maintainers:
+  - Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
+
+description:
+        The Microchip Sony/Philips Digital Interface Transmitter is a
+        serial port compliant with the IEC-60958 standard.
+
+properties:
+  "#sound-dai-cells":
+    const: 0
+
+  compatible:
+    oneOf:
+      - const: microchip,sama7g5-spdiftx
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Peripheral Bus Clock
+      - description: Generic Clock
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: gclk
+
+  dmas:
+    description: TX DMA Channel
+
+  dma-names:
+    const: tx
+
+  pinctrl-0: true
+
+  pinctrl-names:
+    const: default
+
+required:
+  - "#sound-dai-cells"
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - dmas
+  - dma-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/at91.h>
+    #include <dt-bindings/dma/at91.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spdiftx@e1618000 {
+        #sound-dai-cells = <0>;
+        compatible = "microchip,sama7g5-spdiftx";
+        reg = <0xe1618000 0x4000>;
+        interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+        dmas = <&dma0 AT91_XDMAC_DT_PERID(50)>;
+        dma-names = "tx";
+        clocks = <&pmc PMC_TYPE_PERIPHERAL 85>, <&pmc PMC_TYPE_GCK 85>;
+        clock-names = "pclk", "gclk";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_spdiftx_default>;
+    };
-- 
2.25.1

