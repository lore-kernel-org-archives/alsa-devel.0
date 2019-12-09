Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A353AC00454
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:38:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BB7B205C9
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="P4F33fCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB7B205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 721AA1658;
	Mon,  9 Dec 2019 19:37:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 721AA1658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575916688;
	bh=vhnLoywJVpl1ap+f3rpdMACyzE6+ozdLYPsOnEAxGMw=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P4F33fCDUxNG+t3+iYLYR3jCCxjKoCfVXfdYGGHprVYT0TpMMY7hhZOLMKXNNOzl5
	 hSuaZzJGiDJw3tuXbHfGmEAokb5rMfOzd9WlRjNfHW+hJiHfVCu/5RchhU86fYZOxE
	 /7fUQgCI5s9Z4pdP49TOEFsgicZtnXDAFVe853TA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F7BBF80265;
	Mon,  9 Dec 2019 19:35:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BD232F80257; Mon,  9 Dec 2019 19:35:30 +0100 (CET)
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa1.perex.cz (Postfix) with ESMTP id 0090BF80234
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 19:35:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0090BF80234
Received: from zenbar.fritz.box (pD95EF75D.dip0.t-ipconnect.de [217.94.247.93])
 by mail.bugwerft.de (Postfix) with ESMTPSA id A76232E5CDE;
 Mon,  9 Dec 2019 18:29:06 +0000 (UTC)
From: Daniel Mack <daniel@zonque.org>
To: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Date: Mon,  9 Dec 2019 19:35:03 +0100
Message-Id: <20191209183511.3576038-4-daniel@zonque.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191209183511.3576038-1-daniel@zonque.org>
References: <20191209183511.3576038-1-daniel@zonque.org>
MIME-Version: 1.0
Cc: lars@metafoo.de, sboyd@kernel.org, mturquette@baylibre.com,
 robh+dt@kernel.org, broonie@kernel.org, pascal.huerst@gmail.com,
 lee.jones@linaro.org, Daniel Mack <daniel@zonque.org>
Subject: [alsa-devel] [PATCH 03/10] dt-bindings: gpio: Add documentation for
	ad242x GPIO controllers
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

This device must be place as a sub-device of an AD242x MFD node.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 .../bindings/gpio/adi,ad242x-gpio.yaml        | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/adi,ad242x-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/adi,ad242x-gpio.yaml b/Documentation/devicetree/bindings/gpio/adi,ad242x-gpio.yaml
new file mode 100644
index 000000000000..0a5a339fc84e
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/adi,ad242x-gpio.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/gpio/adi,ad242x-gpio.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Analog Devices AD242x GPIO controller
+
+maintainers:
+  - Daniel Mack <daniel@zonque.org>
+
+description: |
+  This module is part of the AD242x MFD device. For more details and an example
+  refer to Documentation/devicetree/bindings/mfd/ad242x.yaml.
+
+properties:
+  compatible:
+    enum:
+      - adi,ad2428w-gpio
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-controller: true
+
+  gpio-over-distance:
+    type: object
+    description: |
+      Sub-node to configure pins as 'GPIO over distance'.
+      Pins in this mode are not accessible as regular GPIOs; instead, their
+      state is transparantly mirrored between one or multiple nodes.
+
+      Each child node of the 'gpio-over-distance' node describes one pin
+      that is to be configured in 'over distance' mode
+
+    properties:
+      pin:
+        type: object
+        properties:
+          reg:
+            maxItems: 1
+
+          adi,virtual-port-mask:
+            $ref: '/schemas/types.yaml#/definitions/uint32'
+            description: |
+              The virtual port mask to assign this GPIO to.
+              Multiple GPIOs can use the same virtual port to link them
+              together. Refer to the datasheet for the details.
+
+          adi,gpio-output:
+            type: boolean
+            description: Configures this GPIO as output. Defaults to input mode.
+
+          adi,gpio-inverted:
+            type: boolean
+            description: Inverts the GPIO value
+
+        required:
+          - reg
+          - adi,virtual-port-mask
+
+required:
+  - compatible
+  - '#gpio-cells'
+  - gpio-controller
-- 
2.23.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
