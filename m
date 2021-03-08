Return-Path: <SRS0=LCrH=IG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A9BC433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 13:38:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 840B1651C7
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 13:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840B1651C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED9FD18A3;
	Mon,  8 Mar 2021 14:37:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED9FD18A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615210695;
	bh=Lt7IbXTkSCNnTE8wKy9XN0Dos8uRbszm1cBdlu3q3/Q=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HKqaFLA2hFie7TSeP4PCAvk7eWODvahgvEoNExWSD24PlRvLIoZa2Ifkbb1DrZ2bX
	 Ufyti8DKTI91O8np/y84VpbNtKB/t6eZXASpf2nqGbSr+QEk/Pzes0KoiPoQM916W0
	 tMUD1Vyp1mCQAjczb+N+fAuhFcNarRDMhVnWrklA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7BAB7F80475;
	Mon,  8 Mar 2021 14:35:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AA0C6F80482; Mon,  8 Mar 2021 14:35:51 +0100 (CET)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D51A5F801ED
 for <alsa-devel@alsa-project.org>; Mon,  8 Mar 2021 14:35:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D51A5F801ED
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8C6A81A0BB7;
 Mon,  8 Mar 2021 14:35:38 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B0E631A0BB1;
 Mon,  8 Mar 2021 14:35:31 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id EF06B402AC;
 Mon,  8 Mar 2021 14:35:22 +0100 (CET)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org,
 devicetree@vger.kernel.org
Subject: [PATCH v4 3/6] ASoC: dt-bindings: fsl_rpmsg: Add binding doc for
 rpmsg cpu dai driver
Date: Mon,  8 Mar 2021 21:22:27 +0800
Message-Id: <1615209750-2357-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615209750-2357-1-git-send-email-shengjiu.wang@nxp.com>
References: <1615209750-2357-1-git-send-email-shengjiu.wang@nxp.com>
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

fsl_rpmsg cpu dai driver is driver for rpmsg audio, which is mainly used
for getting the user's configuration from device tree and configure the
clocks which is used by Cortex-M core. So in this document define the
needed property.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../devicetree/bindings/sound/fsl,rpmsg.yaml  | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml

diff --git a/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml b/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
new file mode 100644
index 000000000000..5731c1fbc0a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
@@ -0,0 +1,118 @@
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
+  fsl_rpmsg cpu dai driver is virtual driver for rpmsg audio, which doesn't
+  touch hardware. It is mainly used for getting the user's configuration
+  from device tree and configure the clocks which is used by Cortex-M core.
+  So in this document define the needed property.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx7ulp-rpmsg
+      - fsl,imx8mn-rpmsg
+      - fsl,imx8mm-rpmsg
+      - fsl,imx8mp-rpmsg
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
+    minItems: 5
+
+  clock-names:
+    items:
+      - const: ipg
+      - const: mclk
+      - const: dma
+      - const: pll8k
+      - const: pll11k
+    minItems: 5
+
+  power-domains:
+    maxItems: 1
+
+  fsl,audioindex:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    default: 0
+    description: Instance index for sound card in
+                 M core side, which share one rpmsg
+                 channel.
+
+  fsl,version:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2]
+    default: 2
+    description: The version of M core image, which is
+                 to make driver compatible with different image.
+
+  fsl,buffer-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: pre allocate dma buffer size
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
+  fsl,codec-type:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
+    default: 0
+    description: Sometimes the codec is registered by
+                 driver not by the device tree, this items
+                 can be used to distinguish codecs.
+
+  audio-codec:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of the audio codec
+
+  memory-region:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the reserved memory nodes
+
+required:
+  - compatible
+  - fsl,audioindex
+  - fsl,version
+  - fsl,buffer-size
+
+additionalProperties: false
+
+examples:
+  - |
+    rpmsg_audio: rpmsg_audio {
+        compatible = "fsl,imx8mn-rpmsg";
+        fsl,audioindex = <0> ;
+        fsl,version = <2>;
+        fsl,buffer-size = <0x6000000>;
+        fsl,enable-lpa;
+    };
-- 
2.27.0

