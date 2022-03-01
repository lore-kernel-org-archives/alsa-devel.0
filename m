Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05944C433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Mar 2022 12:43:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D9B801B1E;
	Tue,  1 Mar 2022 13:43:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D9B801B1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646138632;
	bh=d6sozcIg4ACbLA+8iUq/0BA4ApO/fe9Ut+dhSx5tY48=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A/4sK0HzzORrkv3iUy5a/gHA4HQL3J1AkAP88MlUh55gyf08edJz3ZCtOqKn6pPUk
	 FMnfa9rkWQDLtjrRil7/5fVCBKq38eU5W3Efgb8/kJVNmSv8r1RV1cFD6cLnvkDHiD
	 AO5yJdKOH70cMCWvSkpuR22wG59wSI1tjBl3nK/0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A38C3F80518;
	Tue,  1 Mar 2022 13:42:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A62C9F80167; Tue,  1 Mar 2022 13:42:17 +0100 (CET)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [85.215.255.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CD8C3F80167
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2022 13:42:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD8C3F80167
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net
 header.b="CyupNifZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1646138525;
 s=strato-dkim-0002; d=gerhold.net;
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
 From:Subject:Sender;
 bh=Znlo/K3f7ZM1OI2X+Dlir6ob8K70SHoTC+P3PBMezhY=;
 b=CyupNifZJqC/kXZie75hhhlEl3cWhkxmsUOr3w6IQdoRhuYPYJhmuNIo0H5YQM/qZ3
 6oHsHTMI42VmUO3IuvOuUi3JPO+qD6m+S6vBcpy8E1JIV2/obSjoh0rdhIVpdzKcXIBe
 2xp7uyFLVHyDD+35snx4QEF9uRev1rcp1rl+K1uDZROZgoBIGKgDn56QetzNHvjgkskX
 MQVqrsE+MSr/4B1VDwHFL2HwbnbG7vQeImDaMi+VuW9//U27cl1VzHlec1XIEng17/i/
 M+f07d6Vw7Uq+Jn/p3r3FfCKfZdL4hfZnqj3KLLqmtcbqZrO0P1sCjmaqJ28WxhMJMHw
 SFUQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQ7UOGqRde+a0fiL2ZP6Q"
X-RZG-CLASS-ID: mo00
Received: from droid.. by smtp.strato.de (RZmta 47.40.1 AUTH)
 with ESMTPSA id kdc58dy21Cg5a4n
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 1 Mar 2022 13:42:05 +0100 (CET)
From: Stephan Gerhold <stephan@gerhold.net>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] ASoC: dt-bindings: Add schema for "awinic,aw8738"
Date: Tue,  1 Mar 2022 13:37:41 +0100
Message-Id: <20220301123742.72146-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301123742.72146-1-stephan@gerhold.net>
References: <20220301123742.72146-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Stephan Gerhold <stephan@gerhold.net>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, ~postmarketos/upstreaming@lists.sr.ht,
 Jonathan Albrieux <jonathan.albrieux@gmail.com>
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

Add a DT schema for describing Awinic AW8738 audio amplifiers. They are
fairly simple and controlled using a single GPIO. The number of pulses
during power up selects one of a few pre-defined amplifier modes.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../bindings/sound/awinic,aw8738.yaml         | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/awinic,aw8738.yaml

diff --git a/Documentation/devicetree/bindings/sound/awinic,aw8738.yaml b/Documentation/devicetree/bindings/sound/awinic,aw8738.yaml
new file mode 100644
index 000000000000..83934a835fd7
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/awinic,aw8738.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/awinic,aw8738.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Awinic AW8738 Audio Amplifier
+
+maintainers:
+  - Stephan Gerhold <stephan@gerhold.net>
+
+description:
+  The Awinic AW8738 is a simple audio amplifier using
+  one-wire pulse control to set the amplifier mode.
+
+allOf:
+  - $ref: name-prefix.yaml#
+
+properties:
+  compatible:
+    const: awinic,aw8738
+
+  enable-gpios:
+    maxItems: 1
+
+  awinic,mode:
+    description: Amplifier mode (number of pulses for one-wire pulse control)
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+
+  sound-name-prefix: true
+
+required:
+  - compatible
+  - enable-gpios
+  - awinic,mode
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    audio-amplifier {
+        compatible = "awinic,aw8738";
+        enable-gpios = <&msmgpio 114 GPIO_ACTIVE_HIGH>;
+        awinic,mode = <5>;
+        sound-name-prefix = "Speaker Amp";
+    };
-- 
2.35.1

