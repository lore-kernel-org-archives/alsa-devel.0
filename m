Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63A3C7EE29
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jun 2023 14:20:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C4290A4E;
	Sat, 10 Jun 2023 16:19:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C4290A4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686406810;
	bh=ac6GPsTZQrz4OwOaWW9dl2LWsN9bMfwjmWFUwEHKwGE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=aeM/ia3O4tV2RaJNAhnEg9SYoQ0iMcv4mkO81Cy8XpeazO7s1wvzN9rb6i3CnzPwj
	 m63IOgaO3cFiZ+TSHyWdRtAFKs4FNV0xlnFBG3XstHz9c7nX9EDOLsk1vPUdNSP8Gg
	 Dq0pc8+2CblADo9qjmtUtV0NKIwRgVMZMQDtui5w=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1C279F805A0; Sat, 10 Jun 2023 16:18:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DA8C4F80199;
	Sat, 10 Jun 2023 16:18:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 441CDF80520; Sat, 10 Jun 2023 16:18:36 +0200 (CEST)
Received: from n169-112.mail.139.com (n169-112.mail.139.com [120.232.169.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2FB4BF80589
	for <alsa-devel@alsa-project.org>; Sat, 10 Jun 2023 16:18:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2FB4BF80589
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM: 
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[183.194.158.241])
	by rmsmtp-lg-appmail-22-12025 (RichMail) with SMTP id 2ef96484862f5b2-5a5f5;
	Sat, 10 Jun 2023 22:18:26 +0800 (CST)
X-RM-TRANSID: 2ef96484862f5b2-5a5f5
From: Shenghao Ding <13916275206@139.com>
To: broonie@kernel.org,
	devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	lgirdwood@gmail.com,
	perex@perex.cz,
	pierre-louis.bossart@linux.intel.com
Cc: kevin-lu@ti.com,
	shenghao-ding@ti.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	x1077012@ti.com,
	peeyush@ti.com,
	navada@ti.com,
	gentuser@gmail.com,
	Ryan_Chu@wistron.com,
	Sam_Wu@wistron.com,
	tiwai@suse.de,
	Shenghao Ding <13916275206@139.com>
Subject: [PATCH v5 4/4] ASoC: dt-bindings: Add tas2781 amplifier
Date: Sat, 10 Jun 2023 22:18:21 +0800
Message-Id: <20230610141821.576926-1-13916275206@139.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: RQNK2WNF7NOB2ZEV4R7OFDLHM7PGVYHL
X-Message-ID-Hash: RQNK2WNF7NOB2ZEV4R7OFDLHM7PGVYHL
X-MailFrom: 13916275206@139.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RQNK2WNF7NOB2ZEV4R7OFDLHM7PGVYHL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Create tas2781.yaml for tas2781 driver.

Signed-off-by: Shenghao Ding <13916275206@139.com>

---
Changes in v5:
 - remove ti,broadcast-addr
 - remove address-cells
 - remove size-cells
 - put compatible item first in properties
 - change the maxItems of reg from 4 to 8
 - remove white space around <>
 - correct the reg format to <0x38>, <0x3a> etc
 - remove '\t' in the file
 - correct a comment in the example
---
 .../devicetree/bindings/sound/ti,tas2781.yaml | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,tas2781.yaml

diff --git a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
new file mode 100644
index 000000000000..61db14a39630
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 - 2023 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ti,tas2781.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TAS2781 SmartAMP
+
+maintainers:
+  - Shenghao Ding <shenghao-ding@ti.com>
+
+description:
+  The TAS2781 is a mono, digital input Class-D audio amplifier
+  optimized for efficiently driving high peak power into small
+  loudspeakers. Integrated an on-chip DSP supports Texas Instruments
+  Smart Amp speaker protection algorithm. The integrated speaker
+  voltage and current sense provides for real time
+  monitoring of loudspeaker behavior.
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ti,tas2781
+
+  reg:
+    description:
+      I2C address, in multiple tas2781s case, all the i2c address
+      aggreate as one Audio Device to support multiple audio slots.
+    maxItems: 8
+    items:
+      minimum: 0x38
+      maximum: 0x3f
+
+  reset-gpios:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  '#sound-dai-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+   #include <dt-bindings/gpio/gpio.h>
+   i2c {
+     /* example with quad tas2781s, such as tablet or pad device */
+     #address-cells = <1>;
+     #size-cells = <0>;
+     quad: codec@38 {
+       compatible = "ti,tas2781";
+       reg = <0x38>, /* Audio slot 0 */
+             <0x3a>, /* Audio slot 1 */
+             <0x39>, /* Audio slot 2 */
+             <0x3b>; /* Audio slot 3 */
+
+       #sound-dai-cells = <1>;
+       reset-gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
+       interrupt-parent = <&gpio1>;
+       interrupts = <15>;
+     };
+   };
+...
-- 
2.34.1


