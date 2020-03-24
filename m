Return-Path: <SRS0=1tVn=5J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA30C4332B
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2020 09:42:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5F5520775
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2020 09:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IM4Cmlre";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPSgghiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F5520775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 14C4386F;
	Tue, 24 Mar 2020 10:42:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 14C4386F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585042973;
	bh=1hjPTmemhU+5DDglOCLPbzIWcWikC99fFWBewyMQb0k=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IM4Cmlre+LNDeQTqRbqPwvs1jvzDNIou01Q/ED3brpaAcIjkzEConWn/CTc/S7jNK
	 qbf638gOBhsfDITpBOQnyYaXcwzk3J3Zfz37pbEQp/0HzpiRcn7GDPtbeJz8qKecKD
	 CjOlD+Rqy7X0mttt37sZimwV61au/LG5N41551eY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 37967F80227;
	Tue, 24 Mar 2020 10:42:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3521CF80234; Tue, 24 Mar 2020 10:42:01 +0100 (CET)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3520CF800B9
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2020 10:41:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3520CF800B9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="WPSgghiH"
Received: by mail-wr1-x441.google.com with SMTP id 31so14513359wrs.3
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2020 02:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=UfwyyCOVp7fJ/e8HRRUukv3oRa/wd6NHXME/Nbpa+ws=;
 b=WPSgghiHRVzrwArc/G6qj7hS8TULYEmNI5RNn7iywgiMvs1JuSfMgnIRnzNDlwdlZd
 iH9wOswp2PzsKjU2K1d/QTcsBK01Bk01UYy4FW03l/Lbqi3SghtaXWTkmCmt6usq6nhV
 sTkAWHDkP9ZVSFl+TF4/xUAJrtdaqbWfHTrSzmxzn1qLeoiDM9S7PcrijO5e36VBEKI4
 C0osWAsK3zHTaEXUPiSDdLamAtSsG65g4U/jsfTj9kXoJanekC0nvdP1FRRJNSEgbHb7
 50djO41DN0X/DGnttXM+4dOqtOPXvPhmGwhgvhedb1RNcDMVQ9WsZWlbUhMaQKy2Mg/Z
 rYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=UfwyyCOVp7fJ/e8HRRUukv3oRa/wd6NHXME/Nbpa+ws=;
 b=qNukTG6xeKtyIpqwzqJHB0A4T7KwVT7f9MSW281F1/uTFVG1zYuIWsLru0PwOIdIQ/
 Iw1e7u4Rdkmc044SjwOFTQyKpAPvegVANH9PZ2mt5i4hzZ/RnW3ycQvgRyGyaQUdJ3oI
 kPII2186KP1VsmxighboBSpd7hRC6uT2BdD+T9QkjcPxrtLwJPwtMxa0IkxOs09UAsic
 46Hu3iHT9SbJmp0V7cpe9h//nyMDykIh3CYzrHu4fQqxlNq1cBBFdvkKeiZyFOkBOV/o
 nZEOxBzcIaoKW5BLXUN8i7CHERMHDWSLCh2aDzuBT0ie5psELWdYTXqvbAnTXPMkQVMV
 fiHQ==
X-Gm-Message-State: ANhLgQ12Iu1pIYGsunKWiTi7o2/uW/C8LY6MyYx2B3m8xda/JUiCc49T
 /thZJuKK7wdKrddaIOxleHw=
X-Google-Smtp-Source: ADFU+vsqACwnEGdz/AJwhtKAn07kBM93otHuS309xoHIHLRUqkWj8CpyfKBlB8yVQzRrgyFFZ3Drow==
X-Received: by 2002:adf:d846:: with SMTP id k6mr2544744wrl.268.1585042917062; 
 Tue, 24 Mar 2020 02:41:57 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id r15sm22489916wra.19.2020.03.24.02.41.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 24 Mar 2020 02:41:56 -0700 (PDT)
From: Johan Jonker <jbx6244@gmail.com>
To: lgirdwood@gmail.com
Subject: [PATCH v2 1/3] dt-bindings: sound: convert rockchip i2s bindings to
 yaml
Date: Tue, 24 Mar 2020 10:41:47 +0100
Message-Id: <20200324094149.6904-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, heiko@sntech.de,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 linux-rockchip@lists.infradead.org, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org
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

Current dts files with 'i2s' nodes are manually verified.
In order to automate this process rockchip-i2s.txt
has to be converted to yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changed V2:
  Add Reviewed-by
---
 .../devicetree/bindings/sound/rockchip-i2s.txt     |  49 ----------
 .../devicetree/bindings/sound/rockchip-i2s.yaml    | 106 +++++++++++++++++++++
 2 files changed, 106 insertions(+), 49 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/rockchip-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip-i2s.yaml

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
deleted file mode 100644
index 54aefab71..000000000
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-* Rockchip I2S controller
-
-The I2S bus (Inter-IC sound bus) is a serial link for digital
-audio data transfer between devices in the system.
-
-Required properties:
-
-- compatible: should be one of the following:
-   - "rockchip,rk3066-i2s": for rk3066
-   - "rockchip,px30-i2s", "rockchip,rk3066-i2s": for px30
-   - "rockchip,rk3036-i2s", "rockchip,rk3066-i2s": for rk3036
-   - "rockchip,rk3188-i2s", "rockchip,rk3066-i2s": for rk3188
-   - "rockchip,rk3228-i2s", "rockchip,rk3066-i2s": for rk3228
-   - "rockchip,rk3288-i2s", "rockchip,rk3066-i2s": for rk3288
-   - "rockchip,rk3328-i2s", "rockchip,rk3066-i2s": for rk3328
-   - "rockchip,rk3366-i2s", "rockchip,rk3066-i2s": for rk3366
-   - "rockchip,rk3368-i2s", "rockchip,rk3066-i2s": for rk3368
-   - "rockchip,rk3399-i2s", "rockchip,rk3066-i2s": for rk3399
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- interrupts: should contain the I2S interrupt.
-- dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
-	Documentation/devicetree/bindings/dma/dma.txt
-- dma-names: should include "tx" and "rx".
-- clocks: a list of phandle + clock-specifer pairs, one for each entry in clock-names.
-- clock-names: should contain the following:
-   - "i2s_hclk": clock for I2S BUS
-   - "i2s_clk" : clock for I2S controller
-- rockchip,playback-channels: max playback channels, if not set, 8 channels default.
-- rockchip,capture-channels: max capture channels, if not set, 2 channels default.
-
-Required properties for controller which support multi channels
-playback/capture:
-
-- rockchip,grf: the phandle of the syscon node for GRF register.
-
-Example for rk3288 I2S controller:
-
-i2s@ff890000 {
-	compatible = "rockchip,rk3288-i2s", "rockchip,rk3066-i2s";
-	reg = <0xff890000 0x10000>;
-	interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
-	dmas = <&pdma1 0>, <&pdma1 1>;
-	dma-names = "tx", "rx";
-	clock-names = "i2s_hclk", "i2s_clk";
-	clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>;
-	rockchip,playback-channels = <8>;
-	rockchip,capture-channels = <2>;
-};
diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml b/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
new file mode 100644
index 000000000..eff06b4b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/rockchip-i2s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip I2S controller
+
+description:
+  The I2S bus (Inter-IC sound bus) is a serial link for digital
+  audio data transfer between devices in the system.
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    oneOf:
+      - const: rockchip,rk3066-i2s
+      - items:
+          - enum:
+            - rockchip,px30-i2s
+            - rockchip,rk3036-i2s
+            - rockchip,rk3188-i2s
+            - rockchip,rk3228-i2s
+            - rockchip,rk3288-i2s
+            - rockchip,rk3328-i2s
+            - rockchip,rk3366-i2s
+            - rockchip,rk3368-i2s
+            - rockchip,rk3399-i2s
+          - const: rockchip,rk3066-i2s
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: clock for I2S controller
+      - description: clock for I2S BUS
+
+  clock-names:
+    items:
+      - const: i2s_clk
+      - const: i2s_hclk
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
+  rockchip,capture-channels:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    default: 2
+    description:
+      Max capture channels, if not set, 2 channels default.
+
+  rockchip,playback-channels:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    default: 8
+    description:
+      Max playback channels, if not set, 8 channels default.
+
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      The phandle of the syscon node for the GRF register.
+      Required property for controllers which support multi channel
+      playback/capture.
+
+required:
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
+    #include <dt-bindings/clock/rk3288-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2s@ff890000 {
+      compatible = "rockchip,rk3288-i2s", "rockchip,rk3066-i2s";
+      reg = <0xff890000 0x10000>;
+      interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&cru SCLK_I2S0>, <&cru HCLK_I2S0>;
+      clock-names = "i2s_clk", "i2s_hclk";
+      dmas = <&pdma1 0>, <&pdma1 1>;
+      dma-names = "tx", "rx";
+      rockchip,capture-channels = <2>;
+      rockchip,playback-channels = <8>;
+    };
-- 
2.11.0

