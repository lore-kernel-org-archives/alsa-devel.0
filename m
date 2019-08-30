Return-Path: <SRS0=nNdU=W2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C11EC3A59B
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Aug 2019 21:08:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8228B23428
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Aug 2019 21:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="p62/79IP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8228B23428
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A82CC165F;
	Fri, 30 Aug 2019 23:07:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A82CC165F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567199284;
	bh=NsQKkAYgcJBWMSOGUnpSdGHNTesppjKHT/96IZuaCCw=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p62/79IPifmSJInrjc6JRvk/mUHBb3sZpvYMn8loPdLlkb6HIBo1Nq6dJPIpFpq0w
	 k2bNw1rq6+wclCW7PHpiiy4G3pWvSvjJKKMwQ1ekq86JL2JnniYooFID3F0FOZ9zaG
	 eMb7jSoJOEazXsnkXo1GojoEv7cCX+fqGmLkG0nE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 32470F8038F;
	Fri, 30 Aug 2019 23:06:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 44FEBF800E7; Fri, 30 Aug 2019 23:06:19 +0200 (CEST)
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 97BBAF800E7
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 23:06:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 97BBAF800E7
Received: from localhost.localdomain (unknown [91.224.148.103])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id C09AA100004;
 Fri, 30 Aug 2019 21:06:14 +0000 (UTC)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Date: Fri, 30 Aug 2019 23:06:06 +0200
Message-Id: <20190830210607.22644-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190830210607.22644-1-miquel.raynal@bootlin.com>
References: <20190830210607.22644-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Michal Simek <michal.simek@xilinx.com>,
 Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, alexandre@bootlin.com,
 linux-arm-kernel@lists.infradead.org
Subject: [alsa-devel] [PATCH 2/3] dt-bindings: sound: Add Xilinx logicPD-I2S
	FPGA IP bindings
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Message-ID: <20190830210606.2kGRcHwc91Ses4mUDpMz_j7MLJIwGEyHVDRYfUjdkxM@z>

Document the logicPD I2S FPGA block bindings in yaml.

Syntax verified with dt-doc-validate.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../bindings/sound/xlnx,logicpd-i2s.yaml      | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,logicpd-i2s.yaml

diff --git a/Documentation/devicetree/bindings/sound/xlnx,logicpd-i2s.yaml b/Documentation/devicetree/bindings/sound/xlnx,logicpd-i2s.yaml
new file mode 100644
index 000000000000..cbff641af199
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/xlnx,logicpd-i2s.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/xlnx,logicpd-i2s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Device-Tree bindings for Xilinx logicPD I2S FPGA block
+
+maintainers:
+  - Miquel Raynal <miquel.raynal@bootlin.com>
+
+description: |
+  The IP supports I2S playback/capture audio. It acts as a slave and
+  clocks should come from the codec. It only supports two channels and
+  S16_LE format.
+
+properties:
+  compatible:
+    items:
+      - const: xlnx,logicpd-i2s
+
+  reg:
+    maxItems: 1
+    description:
+      Base address and size of the IP core instance.
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+    items:
+      - description: tx interrupt
+      - description: rx interrupt
+    description:
+      Either the Tx interruption or the Rx interruption or both.
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      - const: tx
+      - const: rx
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupts-controller
+
+examples:
+  - |
+    logii2s_dai: logii2s-dai@43c10000 {
+        reg = <0x43c10000 0x1000>;
+        compatible = "xlnx,logicpd-i2s-dai";
+        interrupt-parent = <&intc>;
+        interrupts = <0 29 IRQ_TYPE_LEVEL_HIGH>, <0 30 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "rx", "tx";
+    };
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
