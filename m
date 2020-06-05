Return-Path: <SRS0=S+eB=7S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD10C433DF
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Jun 2020 05:29:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF31A207F7
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Jun 2020 05:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="I/uDI9ZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF31A207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 154921671;
	Fri,  5 Jun 2020 07:28:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 154921671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591334941;
	bh=B3V3MTZHqGT81Zv4orLaAJOEuGuR6fQ42kTD4gHq38s=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I/uDI9ZWR/PRmDVs4rnhpDMCX8t9++TtFt50R4wdmeyr3QwURJB5VU1dYhO8f93O+
	 6BP7dCCY13DKyJWExSw20oiCB/K99HwFhjwBirNlQK2bNZum0lid6c6fAN+GY3CvCp
	 ydU9JLI5gjyH5pPO2weCTlLfT2F14/sEi67AQRHc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 08CFCF8029A;
	Fri,  5 Jun 2020 07:26:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 19F6DF80140; Fri,  5 Jun 2020 07:23:26 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AD445F801F5
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2020 07:22:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AD445F801F5
IronPort-SDR: w1tcnTOI3P4EPR0MWFaW5+MNpRuBbXyWUToIcHDGtjAzd96+OYhPJ+HdDFft38D2pdfS8w5j54
 BEhQ9Ai0z4dw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2020 22:22:16 -0700
IronPort-SDR: tQ46PPfJAcWPOEX2ta/3cA2N3EEgZ+LfKPUTK5GYb1TsQhXU6QbH/TwIKQLD57YvjBIWKHxcfr
 KQdY6tPHErRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,475,1583222400"; d="scan'208";a="259091181"
Received: from unknown (HELO jsia-HP-Z620-Workstation.png.intel.com)
 ([10.221.118.135])
 by fmsmga008.fm.intel.com with ESMTP; 04 Jun 2020 22:22:14 -0700
From: Sia Jee Heng <jee.heng.sia@intel.com>
To: <alsa-devel@alsa-project.org>
Subject: [PATCH v4 3/3] dt-bindings: sound: Add documentation for KeemBay i2s
Date: Fri,  5 Jun 2020 13:08:57 +0800
Message-Id: <1591333737-3231-4-git-send-email-jee.heng.sia@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1591333737-3231-1-git-send-email-jee.heng.sia@intel.com>
References: <1591333737-3231-1-git-send-email-jee.heng.sia@intel.com>
Cc: cezary.rojewski@intel.com, andriy.shevchenko@intel.com, tiwai@suse.com,
 pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com,
 broonie@kernel.org
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

Document Intel KeemBay i2s DT bindings.

Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
---
 .../bindings/sound/intel,keembay-i2s.yaml          | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml

diff --git a/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml b/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml
new file mode 100644
index 0000000..175e4fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2020 Intel Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/intel,keembay-i2s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel KeemBay I2S Device Tree Bindings
+
+maintainers:
+  - Sia, Jee Heng <jee.heng.sia@intel.com>
+
+description: |
+ Intel KeemBay I2S
+
+properties:
+  compatible:
+    enum:
+      - intel,keembay-i2s
+
+  "#sound-dai-cells":
+    const: 0
+
+  reg:
+    items:
+      - description: I2S configuration
+
+  reg-names:
+    items:
+      - const: i2s-regs
+      - const: i2s_gen_cfg
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Bus Clock
+      - description: Module Clock
+
+  clock-names:
+    items:
+      - const: osc
+      - const: apb_clk
+
+required:
+  - compatible
+  - "#sound-dai-cells"
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+examples:
+  - |
+     #include <dt-bindings/interrupt-controller/arm-gic.h>
+     #include <dt-bindings/interrupt-controller/irq.h>
+     #define KEEM_BAY_PSS_AUX_I2S3
+     #define KEEM_BAY_PSS_I2S3
+     i2s3: i2s@20140000 {
+         compatible = "intel,keembay-i2s";
+         #sound-dai-cells = <0>;
+         reg = <0x20140000 0x200 0x202a00a4 0x4>;
+         reg-names = "i2s-regs", "i2s_gen_cfg";
+         interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+         clock-names = "osc", "apb_clk";
+         clocks = <&scmi_clk KEEM_BAY_PSS_AUX_I2S3>, <&scmi_clk KEEM_BAY_PSS_I2S3>;
+     };
-- 
1.9.1

