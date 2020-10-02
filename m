Return-Path: <SRS0=qvVP=DJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBB8C4363C
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:05:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 602FA20758
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="exTwrIyM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ieoqNqjB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602FA20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BEEDF1F27;
	Fri,  2 Oct 2020 18:04:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BEEDF1F27
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601654713;
	bh=WnJFaAsuf8XICIieeva6yD00uy3IL/eDLKGXHIhOzJI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=exTwrIyMr5tE+EZhKgxeyukrzW7sHoEj0K6Zk/l09xefv5QjTOR+qj+fX3v5JWTiP
	 Ty7jn6O6ZtZk/fHDSjTR/LZE33dvmjWRXrNhod5ZL+ODbS8ksF4rk0TyV1JQXM/8uh
	 BqFX/HoozZMFK1Z3zI6NjApGz6fRYXibj4uy3/So=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D5431F8028E;
	Fri,  2 Oct 2020 18:03:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E9729F80292; Fri,  2 Oct 2020 18:03:31 +0200 (CEST)
Received: from esa5.microchip.iphmx.com (esa5.microchip.iphmx.com
 [216.71.150.166])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B764BF800E5
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2020 18:03:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B764BF800E5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.b="ieoqNqjB"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1601654606; x=1633190606;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WnJFaAsuf8XICIieeva6yD00uy3IL/eDLKGXHIhOzJI=;
 b=ieoqNqjBVK4l+aobECzWCBZkSR0+8T5CjkfvXQHNKal5lnEKUkJ3+1LO
 zUT8F5CimtzTnM7TDwI0Q2PZ98AZBZYPYoeq+3BJqWY6UAzWJQo5pnjiq
 ICU0DOBmK7ln86Wb7lDWVC1MzH+FGWpz/bK4+kiv2cDA8eJ2/hTIty/KX
 C3M+fz3wxoQPWEeJUoa2fz+F3l6WaGLT3bwuIHIg65sBwwqELqBiOnC+e
 i1/7VGcA5zfbNWCZXCletLrW4AErmdU8OYPYWC0gReWZqoryPOyqI0HhZ
 qv6fuNFfUfDWIruZG0ZiuZoK74Vk9qk6UuJ8QEaqjtFA9psgxBdt+sp5B A==;
IronPort-SDR: Kb3tl5lnhIbvL2vAiAxCiB62r6vNSlu9RZgOmsbUp1v4/cWt1yFdAj2bglNRwEZc18iqqeSLjj
 KjxWxYyXLwnAVJGlJ04bJASA2RC2fOnYW0YZqoDRV3HlQShfUzdxaY0g2Y7ObxItlbgmPmJpkh
 rL/12guPSVqrvlZzNpvu1NY6iLGnoSYojDit0vHPNInqhq6IVsbtLvHuYGu3M/mYiHH2FlT9we
 fGKPbsEo3m/V/q8cyOHQ1skH48K8D2R9bdVhL6iO8mbZzNK/9HvHKFXLC4XG8Opn6UWlPVw5XT
 6Yo=
X-IronPort-AV: E=Sophos;i="5.77,328,1596524400"; d="scan'208";a="93228967"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256;
 02 Oct 2020 09:03:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 2 Oct 2020 09:03:19 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 2 Oct 2020 09:02:41 -0700
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To: <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/2] dt-bindings: sound: add DT bindings for Microchip S/PDIF
 RX Controller
Date: Fri, 2 Oct 2020 19:03:04 +0300
Message-ID: <20201002160305.815523-2-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201002160305.815523-1-codrin.ciubotariu@microchip.com>
References: <20201002160305.815523-1-codrin.ciubotariu@microchip.com>
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

This patch adds DT bindings for the new Microchip S/PDIF RX Controller
embedded inside sama7g5 SoCs.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 .../bindings/sound/mchp,spdifrx.yaml          | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mchp,spdifrx.yaml

diff --git a/Documentation/devicetree/bindings/sound/mchp,spdifrx.yaml b/Documentation/devicetree/bindings/sound/mchp,spdifrx.yaml
new file mode 100644
index 000000000000..7d8bd4e14434
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mchp,spdifrx.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/mchp,spdifrx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip S/PDIF Rx Controller Device Tree Bindings
+
+maintainers:
+  - Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
+
+description:
+        The Microchip Sony/Philips Digital Interface Receiver is a
+        serial port compliant with the IEC-60958 standard.
+
+properties:
+  "#sound-dai-cells":
+    const: 0
+
+  compatible:
+    const: microchip,sama7g5-spdifrx
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
+    description: RX DMA Channel
+    maxItems: 1
+
+  dma-names:
+    const: rx
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
+    spdifrx: spdifrx@e1614000 {
+        #sound-dai-cells = <0>;
+        compatible = "microchip,sama7g5-spdifrx";
+        reg = <0xe1614000 0x4000>;
+        interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+        dmas = <&dma0 AT91_XDMAC_DT_PERID(49)>;
+        dma-names = "rx";
+        clocks = <&pmc PMC_TYPE_PERIPHERAL 84>, <&pmc PMC_TYPE_GCK 84>;
+        clock-names = "pclk", "gclk";
+    };
-- 
2.25.1

