Return-Path: <SRS0=nXTK=HZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC312C433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Feb 2021 18:21:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C47B464E57
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Feb 2021 18:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47B464E57
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A00F167B;
	Tue, 23 Feb 2021 19:20:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A00F167B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614104508;
	bh=9EEtLwWSezY8Sf8ckHTwieMMidcPrRuv8Cp4CpEaGEc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=snR8qYYtqxTZIpzRpDzhIimkp2elbc7WzMdhR0YgtISicCZSo4mwve387eUwkB6ZC
	 uF/GgSlxtyNv2XCO5YUJK6+xCkx78dWlSw0P3E3uzzdNM6AUxx4AXqm+atzuF92sxz
	 na5v2JZdvfuJtTzodjMH2zUKLLV2eQeyjDPxIIWA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 14E57F80278;
	Tue, 23 Feb 2021 19:20:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 825BAF8026C; Tue, 23 Feb 2021 19:20:09 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 34456F8016A
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2021 19:20:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 34456F8016A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.b="MYvyWNfo"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1614104404; x=1645640404;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9EEtLwWSezY8Sf8ckHTwieMMidcPrRuv8Cp4CpEaGEc=;
 b=MYvyWNfoLslEGY7KSfCkXAL8ssQMa3sEz0J3arDK/KJJDWNF2cG1f75M
 NdStBX3qtYYCmXadSMIXfnSgt0kiA5lViG2zRk3Jcj0I6hdR47/9Ttieb
 AHZ9TnhkCUcEbYKoQabUmKDEXZ0rJrpLaYgDAdq4BwU8rerOE+m0kosNv
 6HRN2eKaw3xYHjPS3Zmvmwm0SfeLpDvrbyEi4dOylVdZqBDVRsIUYN7oM
 HcXZoWNzU7HxYHT/Mpz4JwQ1gwjdqNjViM3w09C4oQ1K1lxbu+KuPMeKM
 MASNltFQwbcIFJv3YXaop5HCM08y5zARi+ZRD593FOWWpWC+umQgrZ8S6 Q==;
IronPort-SDR: dCcWn2EoPHAB3rGDXt78rb0hQIVFSosi7eMqHLOoWMRWEnDaxrE84b8ieSNbcBsHoHu4gPP044
 nhxfX3hpvf89IbVYmBVmunWtqTMO50EB3w3EuV4KKiA3cxvZWV34oF+R2GYFpZ7dcFB9YVZTYO
 jA/0Yq/A1FJ1rYk55s9Jb91S3ihmv+PMovpm1nv7DmkYsMjB7eUxX4kz/wTPwWj5OR1fbp85UU
 Tb95bZy4DWyBmHxzEP/N3vUTjtBUClhoEQLacHwpLreB42FdVByzB2yTxR0rOv6Vw1yjSylRbl
 2VU=
X-IronPort-AV: E=Sophos;i="5.81,200,1610434800"; d="scan'208";a="110827424"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256;
 23 Feb 2021 11:20:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Feb 2021 11:20:01 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 23 Feb 2021 11:19:57 -0700
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To: <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/7] ASoC: convert Microchip I2SMCC binding to yaml
Date: Tue, 23 Feb 2021 20:19:23 +0200
Message-ID: <20210223181929.444640-2-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210223181929.444640-1-codrin.ciubotariu@microchip.com>
References: <20210223181929.444640-1-codrin.ciubotariu@microchip.com>
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

This patch converts the Microchip I2SMCC bindings to DT schema format
using json-schema.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 .../bindings/sound/mchp,i2s-mcc.yaml          | 86 +++++++++++++++++++
 .../bindings/sound/mchp-i2s-mcc.txt           | 43 ----------
 2 files changed, 86 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt

diff --git a/Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml b/Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml
new file mode 100644
index 000000000000..79445f5f2804
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/mchp,i2s-mcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip I2S Multi-Channel Controller
+
+maintainers:
+  - Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
+
+description:
+  The I2SMCC complies with the Inter-IC Sound (I2S) bus specification and
+  supports a Time Division Multiplexed (TDM) interface with external
+  multi-channel audio codecs. It consists of a receiver, a transmitter and a
+  common clock generator that can be enabled separately to provide Adapter,
+  Client or Controller modes with receiver and/or transmitter active.
+
+properties:
+  "#sound-dai-cells":
+    const: 0
+
+  compatible:
+    const: microchip,sam9x60-i2smcc
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
+      - description: Generic Clock (Optional). Should be set mostly when Master
+          Mode is required.
+    minItems: 1
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: gclk
+    minItems: 1
+
+  dmas:
+    items:
+      - description: TX DMA Channel
+      - description: RX DMA Channel
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
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
+    #include <dt-bindings/dma/at91.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    i2s@f001c000 {
+        #sound-dai-cells = <0>;
+        compatible = "microchip,sam9x60-i2smcc";
+        reg = <0xf001c000 0x100>;
+        interrupts = <34 IRQ_TYPE_LEVEL_HIGH 7>;
+        dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+                       AT91_XDMAC_DT_PERID(36))>,
+               <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+                       AT91_XDMAC_DT_PERID(37))>;
+        dma-names = "tx", "rx";
+        clocks = <&i2s_clk>, <&i2s_gclk>;
+        clock-names = "pclk", "gclk";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_i2s_default>;
+    };
diff --git a/Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt b/Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt
deleted file mode 100644
index 91ec83a6faed..000000000000
--- a/Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-* Microchip I2S Multi-Channel Controller
-
-Required properties:
-- compatible:     Should be "microchip,sam9x60-i2smcc".
-- reg:            Should be the physical base address of the controller and the
-                  length of memory mapped region.
-- interrupts:     Should contain the interrupt for the controller.
-- dmas:           Should be one per channel name listed in the dma-names property,
-                  as described in atmel-dma.txt and dma.txt files.
-- dma-names:      Identifier string for each DMA request line in the dmas property.
-		  Two dmas have to be defined, "tx" and "rx".
-- clocks:         Must contain an entry for each entry in clock-names.
-                  Please refer to clock-bindings.txt.
-- clock-names:    Should be one of each entry matching the clocks phandles list:
-                  - "pclk" (peripheral clock) Required.
-                  - "gclk" (generated clock) Optional (1).
-
-Optional properties:
-- pinctrl-0:      Should specify pin control groups used for this controller.
-- princtrl-names: Should contain only one value - "default".
-
-
-(1) : Only the peripheral clock is required. The generated clock is optional
-      and should be set mostly when Master Mode is required.
-
-Example:
-
-	i2s@f001c000 {
-		compatible = "microchip,sam9x60-i2smcc";
-		reg = <0xf001c000 0x100>;
-		interrupts = <34 IRQ_TYPE_LEVEL_HIGH 7>;
-		dmas = <&dma0
-			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
-			 AT91_XDMAC_DT_PERID(36))>,
-		       <&dma0
-			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
-			 AT91_XDMAC_DT_PERID(37))>;
-		dma-names = "tx", "rx";
-		clocks = <&i2s_clk>, <&i2s_gclk>;
-		clock-names = "pclk", "gclk";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_i2s_default>;
-	};
-- 
2.27.0

