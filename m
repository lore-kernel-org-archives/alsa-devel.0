Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E825AC77B7F
	for <alsa-devel@archiver.kernel.org>; Sun, 14 May 2023 22:54:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6BC103E7;
	Mon, 15 May 2023 00:53:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6BC103E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684104853;
	bh=QReEtWq0pxtlD3V9RRBZLxn5G9GJU4OFedYY+8TN6jg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=OaZaAXwriSKG8nS2lGxDtbDoc/B4XAHeXuL3CitN70NbyLPFDLm/5fwG+7pSJlKFo
	 xWeP6OJHoA2freLuY347S/EstFA8kEkXgJlTCYNqkWKnDNSWQVD0Xt5HskvWCOYec4
	 I163D92t3Aag6YpnKaGHZAjOJ8rDrEPaQlR6oY3Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9C2CAF80548; Mon, 15 May 2023 00:53:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 16504F80272;
	Mon, 15 May 2023 00:53:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C6843F80272; Mon, 15 May 2023 00:53:10 +0200 (CEST)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1BBCAF8016D
	for <alsa-devel@alsa-project.org>; Mon, 15 May 2023 00:53:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1BBCAF8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=denx.de header.i=@denx.de header.a=rsa-sha256
 header.s=phobos-20191101 header.b=thXosdtW
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id C315182721;
	Mon, 15 May 2023 00:53:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1684104781;
	bh=8278qfdJLJmGtt8Qh8DdNJl3+DEkpTOnmYeoRqtPpVE=;
	h=From:To:Cc:Subject:Date:From;
	b=thXosdtWLiUzrK6qj/LqkEC3wkbR24ZbBjpH3YWkVXwG7TA8/7uABBHglju9AwABM
	 +vK3Ya24/Fe0vBLUGWm11OVT7rSSXLZRudleUMDnBfUQJjSAB/EDye/3eYJzG6fj/I
	 qyNSRV74bV6a79+yN5l0qR/Qqvtl0edRTtDY68Vz82+fl9gb1k7q+Q0m3TCEf5txnu
	 Fn2lSVRMIp0KZIcJJu0dzo5oxCuX8Ss6pIAjckJGyT2h0tt8v3d7TGVgfx5peKvuvN
	 1WruRPAJMVl+DzCE9rPSUEaE4UBP4FImVbDDEocwP6YWUeqrFeOpP7XhXpNc6wJRoB
	 C5cd5x0ziYJIw==
From: Marek Vasut <marex@denx.de>
To: devicetree@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: dt-bindings: ssm2518: Convert to dtschema
Date: Mon, 15 May 2023 00:52:43 +0200
Message-Id: <20230514225243.777504-1-marex@denx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Message-ID-Hash: IR5LIENSPXWSMVNDDSUV72LEV2L22S7P
X-Message-ID-Hash: IR5LIENSPXWSMVNDDSUV72LEV2L22S7P
X-MailFrom: marex@denx.de
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IR5LIENSPXWSMVNDDSUV72LEV2L22S7P/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Convert the ADI SSM2518 audio CODEC bindings to DT schema.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: alsa-devel@alsa-project.org
Cc: devicetree@vger.kernel.org
---
 .../bindings/sound/adi,ssm2518.yaml           | 47 +++++++++++++++++++
 .../devicetree/bindings/sound/ssm2518.txt     | 20 --------
 2 files changed, 47 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/adi,ssm2518.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/ssm2518.txt

diff --git a/Documentation/devicetree/bindings/sound/adi,ssm2518.yaml b/Documentation/devicetree/bindings/sound/adi,ssm2518.yaml
new file mode 100644
index 0000000000000..f3f32540779c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/adi,ssm2518.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/adi,ssm2518.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices SSM2518 audio amplifier
+
+maintainers:
+  - Lars-Peter Clausen <lars@metafoo.de>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: adi,ssm2518
+
+  reg:
+    maxItems: 1
+    description: |
+       I2C address of the device. This will either be 0x34 (ADDR pin low)
+       or 0x35 (ADDR pin high)
+
+  gpios:
+    maxItems: 1
+    description: |
+       GPIO connected to the nSD pin. If the property is not present
+       it is assumed that the nSD pin is hardwired to always on.
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+   i2c {
+     #address-cells = <1>;
+     #size-cells = <0>;
+     codec@34 {
+       compatible = "adi,ssm2518";
+       reg = <0x34>;
+       gpios = <&gpio 5 0>;
+     };
+   };
diff --git a/Documentation/devicetree/bindings/sound/ssm2518.txt b/Documentation/devicetree/bindings/sound/ssm2518.txt
deleted file mode 100644
index 59381a778c797..0000000000000
--- a/Documentation/devicetree/bindings/sound/ssm2518.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-SSM2518 audio amplifier
-
-This device supports I2C only.
-
-Required properties:
-  - compatible : Must be "adi,ssm2518"
-  - reg : the I2C address of the device. This will either be 0x34 (ADDR pin low)
-	or 0x35 (ADDR pin high)
-
-Optional properties:
-  - gpios : GPIO connected to the nSD pin. If the property is not present it is
-	        assumed that the nSD pin is hardwired to always on.
-
-Example:
-
-	ssm2518: ssm2518@34 {
-		compatible = "adi,ssm2518";
-		reg = <0x34>;
-		gpios = <&gpio 5 0>;
-	};
-- 
2.39.2

