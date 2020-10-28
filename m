Return-Path: <SRS0=HcWj=ED=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0489C4363A
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Oct 2020 09:45:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EFB7246A3
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Oct 2020 09:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NHWxFyZk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EFB7246A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A4F80166F;
	Wed, 28 Oct 2020 10:44:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A4F80166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603878333;
	bh=kCyEW4no949xpXYArQfMvtbz0dCn9usi1MQUkEQzYKE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NHWxFyZkQocNOjEFW3eh98BLKhlcWHVtLSpDwHrI8lcqQ0up9k/EHu0zr+g/5hBw8
	 wGbmm3oj803xBak9IEm9PnT/liGZxLaVBPTYPIAhExBwnutLU6c5Jjoil/Xew6dh3p
	 eZiYLhgdcuDRiqUqnAunN0HY4YtjOwpGb9iGyCSk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D7936F801D5;
	Wed, 28 Oct 2020 10:44:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 44295F80249; Wed, 28 Oct 2020 10:44:41 +0100 (CET)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9857AF80134
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2020 10:44:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9857AF80134
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6DEB81A1508;
 Wed, 28 Oct 2020 10:44:33 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5510D1A14FF;
 Wed, 28 Oct 2020 10:44:28 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id BFE44402B7;
 Wed, 28 Oct 2020 10:44:21 +0100 (CET)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com, robh+dt@kernel.org,
 devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] ASoC: dt-bindings: fsl_aud2htx: Add binding doc for
 aud2htx module
Date: Wed, 28 Oct 2020 17:38:49 +0800
Message-Id: <1603877930-10553-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

AUD2HTX (Audio Subsystem TO HDMI TX Subsystem) is a new
IP module found on i.MX8MP.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in v2:
- fix indentation issue
- remove nodename

 .../bindings/sound/fsl,aud2htx.yaml           | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml

diff --git a/Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml b/Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml
new file mode 100644
index 000000000000..6d9ba2946bfb
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/fsl,aud2htx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP Audio Subsystem to HDMI RTX Subsystem Controller
+
+maintainers:
+  - Shengjiu Wang <shengjiu.wang@nxp.com>
+
+properties:
+  compatible:
+    const: fsl,imx8mp-aud2htx
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Peripheral clock
+
+  clock-names:
+    items:
+      - const: bus
+
+  dmas:
+    items:
+      - description: DMA controller phandle and request line for TX
+
+  dma-names:
+    items:
+      - const: tx
+
+  power-domains:
+    maxItems: 1
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
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/imx8mp-clock.h>
+
+    aud2htx: aud2htx@30cb0000 {
+        compatible = "fsl,imx8mp-aud2htx";
+        reg = <0x30cb0000 0x10000>;
+        interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&audiomix_clk IMX8MP_CLK_AUDIOMIX_AUD2HTX_IPG>;
+        clock-names = "bus";
+        dmas = <&sdma2 26 2 0>;
+        dma-names = "tx";
+        power-domains = <&audiomix_pd>;
+    };
-- 
2.27.0

