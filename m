Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABB7C433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  6 May 2022 14:06:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9DC5817F0;
	Fri,  6 May 2022 16:05:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9DC5817F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651846005;
	bh=PbcAlAczhXqewXENvdgc3A+p9OccBWCAEJUEZ84Z6pk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LRFcH0OdfrxM40+jeNjo8jdh87QS9e6HHiI3mdjAUCJZRYUu8vsM1hn2JDBvhss+i
	 r/RpxiBY2C8AsnhnQ5WmopDdn4c9qHhRj+S2JC7YD2hLKRro8ntIGYABUGuXfAoh7/
	 9tAu3N0QtyzqTyVwLHctTiPYuSaE/19zh5AfbyBk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 36E60F800E3;
	Fri,  6 May 2022 16:05:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 54DF6F8014B; Fri,  6 May 2022 16:05:54 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 1DAE7F800E3
 for <alsa-devel@alsa-project.org>; Fri,  6 May 2022 16:05:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1DAE7F800E3
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 467C31576;
 Fri,  6 May 2022 07:05:45 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C66E33F885;
 Fri,  6 May 2022 07:05:43 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v2 04/11] dt-bindings: sound: add Arm PL041 AACI DT schema
Date: Fri,  6 May 2022 15:05:26 +0100
Message-Id: <20220506140533.3566431-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506140533.3566431-1-andre.przywara@arm.com>
References: <20220506140533.3566431-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Will Deacon <will@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
 Takashi Iwai <tiwai@suse.com>, Robin Murphy <robin.murphy@arm.com>,
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

The Arm PrimeCell Advanced Audio CODEC Interface (AACI aka PL041) is
a peripheral that provides communication with an audio CODEC.

Add a simple DT schema binding for it, so that DTs can be validated
automatically.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../devicetree/bindings/sound/arm,pl041.yaml  | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/arm,pl041.yaml

diff --git a/Documentation/devicetree/bindings/sound/arm,pl041.yaml b/Documentation/devicetree/bindings/sound/arm,pl041.yaml
new file mode 100644
index 0000000000000..7896b8150cf0f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/arm,pl041.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/arm,pl041.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Arm Ltd. PrimeCell PL041 AACI sound interface
+
+maintainers:
+  - Andre Przywara <andre.przywara@arm.com>
+
+description:
+  The Arm PrimeCell Advanced Audio CODEC Interface (AACI) is an AMBA compliant
+  peripheral that provides communication with an audio CODEC using the AC-link
+  protocol.
+
+# We need a select here so we don't match all nodes with 'arm,primecell'
+select:
+  properties:
+    compatible:
+      contains:
+        const: arm,pl041
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: arm,pl041
+      - const: arm,primecell
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description: APB register access clock
+
+  clock-names:
+    const: apb_pclk
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    audio-controller@40000 {
+        compatible = "arm,pl041", "arm,primecell";
+        reg = <0x040000 0x1000>;
+        interrupts = <11>;
+        clocks = <&v2m_clk24mhz>;
+        clock-names = "apb_pclk";
+    };
+
+...
-- 
2.25.1

