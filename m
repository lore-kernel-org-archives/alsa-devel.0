Return-Path: <SRS0=XQZd=IK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15C7C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 02:56:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71B4864F87
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 02:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B4864F87
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D22331702;
	Fri, 12 Mar 2021 03:55:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D22331702
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615517805;
	bh=1glU3pf6iNuDwsQHhCBMbL+PiPQefMND7gMcISBLyvk=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FePTeVfbgA/xNK1xrAgRgp2LH1F2e4QDnTRtkC1Za0rBTW5NryHx/qcnqt0JzysQP
	 VybFQJheXH6nThIbaK289QnUCF0yUiljxyTSUu4vA123IGAm34r/M+dJ2Zq5pJYz2i
	 x/Rp51SjooNFODI1ueiAqPBn4YRJXYmSkFL+7j6U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 44E5CF80272;
	Fri, 12 Mar 2021 03:54:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5B1BEF80424; Fri, 12 Mar 2021 03:54:19 +0100 (CET)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 891EDF800AB
 for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2021 03:54:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 891EDF800AB
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 367012007AA;
 Fri, 12 Mar 2021 03:54:05 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 548B420079F;
 Fri, 12 Mar 2021 03:53:58 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id F2804402D6;
 Fri, 12 Mar 2021 03:53:48 +0100 (CET)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org,
 devicetree@vger.kernel.org
Subject: [PATCH v5 3/6] ASoC: dt-bindings: fsl_rpmsg: Add binding doc for
 rpmsg audio device
Date: Fri, 12 Mar 2021 10:38:42 +0800
Message-Id: <1615516725-4975-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615516725-4975-1-git-send-email-shengjiu.wang@nxp.com>
References: <1615516725-4975-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
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

fsl_rpmsg is a virtual audio device. Mapping to real hardware
devices are SAI, DMA controlled by Cortex M core. What we see from
Linux side is a device which provides audio service by rpmsg channel.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../devicetree/bindings/sound/fsl,rpmsg.yaml  | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml

diff --git a/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml b/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
new file mode 100644
index 000000000000..b4c190bddd84
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/fsl,rpmsg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP Audio RPMSG CPU DAI Controller
+
+maintainers:
+  - Shengjiu Wang <shengjiu.wang@nxp.com>
+
+description: |
+  fsl_rpmsg is a virtual audio device. Mapping to real hardware devices
+  are SAI, DMA controlled by Cortex M core. What we see from Linux
+  side is a device which provides audio service by rpmsg channel.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx7ulp-rpmsg-audio
+      - fsl,imx8mn-rpmsg-audio
+      - fsl,imx8mm-rpmsg-audio
+      - fsl,imx8mp-rpmsg-audio
+
+  model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: User specified audio sound card name
+
+  clocks:
+    items:
+      - description: Peripheral clock for register access
+      - description: Master clock
+      - description: DMA clock for DMA register access
+      - description: Parent clock for multiple of 8kHz sample rates
+      - description: Parent clock for multiple of 11kHz sample rates
+
+  clock-names:
+    items:
+      - const: ipg
+      - const: mclk
+      - const: dma
+      - const: pll8k
+      - const: pll11k
+
+  power-domains:
+    description:
+      List of phandle and PM domain specifier as documented in
+      Documentation/devicetree/bindings/power/power_domain.txt
+    maxItems: 1
+
+  memory-region:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to a node describing reserved memory (System RAM memory)
+      The M core can't access all the DDR memory space on some platform,
+      So reserved a specific memory for dma buffer which M core can
+      access.
+      (see bindings/reserved-memory/reserved-memory.txt)
+
+  audio-codec:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle to a node of audio codec
+
+  audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description: |
+      A list of the connections between audio components. Each entry is a
+      pair of strings, the first being the connection's sink, the second
+      being the connection's source.
+
+  fsl,enable-lpa:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: enable low power audio path.
+
+  fsl,rpmsg-out:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      This is a boolean property. If present, the transmitting function
+      will be enabled.
+
+  fsl,rpmsg-in:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      This is a boolean property. If present, the receiving function
+      will be enabled.
+
+required:
+  - compatible
+  - model
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8mn-clock.h>
+
+    rpmsg_audio: rpmsg_audio {
+        compatible = "fsl,imx8mn-rpmsg-audio";
+        model = "wm8524-audio";
+        fsl,enable-lpa;
+        fsl,rpmsg-out;
+        clocks = <&clk IMX8MN_CLK_SAI3_IPG>,
+                 <&clk IMX8MN_CLK_SAI3_ROOT>,
+                 <&clk IMX8MN_CLK_SDMA3_ROOT>,
+                 <&clk IMX8MN_AUDIO_PLL1_OUT>,
+                 <&clk IMX8MN_AUDIO_PLL2_OUT>;
+        clock-names = "ipg", "mclk", "dma", "pll8k", "pll11k";
+    };
-- 
2.27.0

