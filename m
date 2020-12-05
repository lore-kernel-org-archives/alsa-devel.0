Return-Path: <SRS0=jDen=FJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089D4C4361A
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Dec 2020 00:18:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07EDA22B40
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Dec 2020 00:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07EDA22B40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 16C5E18B4;
	Sat,  5 Dec 2020 01:17:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 16C5E18B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607127510;
	bh=uvFMb7TsHQjQ5lBT6+EI6/iw0AKgMAx9mgXF0pTbIWM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=D6r6Qh0fSn+uOtaeCIMz1thdriMAAlbQqizej8WlQaZWvbU2aiso7oVkMw9ARDUKq
	 5nQBgYDFmTqiLmleb38SDqpBDBxJBpRx0mt9Yr99aALl9d8oweuK6REezKGuSBNSGd
	 T7GSSMC//bMzkRmcp6+18tWa1YD8xgd50mcddGQc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1C796F800E2;
	Sat,  5 Dec 2020 01:16:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 13D82F804AB; Sat,  5 Dec 2020 01:16:49 +0100 (CET)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A46ECF800E2
 for <alsa-devel@alsa-project.org>; Sat,  5 Dec 2020 01:16:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A46ECF800E2
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr
 [86.194.74.19]) (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 5CC9DC0006;
 Sat,  5 Dec 2020 00:16:36 +0000 (UTC)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] dt-bindings: add simple-audio-mux binding
Date: Sat,  5 Dec 2020 01:15:07 +0100
Message-Id: <20201205001508.346439-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>
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

Add devicetree documentation for simple audio multiplexers

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
Cc: Rob Herring <robh+dt@kernel.org>

 .../bindings/sound/simple-audio-mux.yaml      | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/simple-audio-mux.yaml

diff --git a/Documentation/devicetree/bindings/sound/simple-audio-mux.yaml b/Documentation/devicetree/bindings/sound/simple-audio-mux.yaml
new file mode 100644
index 000000000000..5986d1fcbb54
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/simple-audio-mux.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/simple-audio-mux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Simple Audio Multiplexer
+
+maintainers:
+  - Alexandre Belloni <aleandre.belloni@bootlin.com>
+
+description: |
+  Simple audio multiplexers are driven using gpios, allowing to select which of
+  their input line is connected to the output line.
+
+properties:
+  compatible:
+    const: simple-audio-mux
+
+  mux-gpios:
+    description: |
+      GPIOs used to select the input line.
+
+  sound-name-prefix:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Used as prefix for sink/source names of the component. Must be a
+      unique string among multiple instances of the same component.
+
+required:
+  - compatible
+  - mux-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    mux {
+        compatible = "simple-audio-mux";
+        mux-gpios = <&gpio 3 0>;
+    };
-- 
2.28.0

