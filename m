Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EA9C61DB3
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Jan 2023 10:41:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 11A9C9C47;
	Fri, 13 Jan 2023 11:40:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 11A9C9C47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673606497;
	bh=539Rhr8oTmKwee6LhwUiwwoo6EZu02HQx59O3ADkTbU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=pfjJgozc8hIDJX/kl1ZBHfXPVXp8tKWqLj8S2GBNz5nAaFOhhidA3GZKe99mRTUeW
	 mPDBbt794uoiwcpStKTS24nr7OtY5FU/fgIWHWJwKkD8mOTELwDnedC1Cd0KxLoFQ6
	 wX9TYA4SU7X58T3RU1wBYrbqxXM7mj0S4dXjIMAQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5F10FF8059F;
	Fri, 13 Jan 2023 11:38:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E8959F80589; Fri, 13 Jan 2023 11:38:39 +0100 (CET)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A92B4F8057E
 for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2023 11:38:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A92B4F8057E
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=XlOprv3Z
Received: (Authenticated sender: herve.codina@bootlin.com)
 by mail.gandi.net (Postfix) with ESMTPA id 069CAFF81B;
 Fri, 13 Jan 2023 10:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1673606315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZqR1sbzJlEP7+ZXzooqfoTsDW4e3sPJzR7dwt0b3cSs=;
 b=XlOprv3ZimuihHQZvNbxcgHZYx3GRRS/kt8qkLz0LvmzfBkZGHV0LeXQScDykpF5WgsIgA
 q8/sJmyiBZIUk6l74Xw/l4ejMwY9VUtgzSK13vex1i25TlV0kcQfnU8PYwsE+ZCAoT7eKs
 NqZbpfcOqzCVN7Ozg21RoPdQhcHEg9G2bRTyi4etOE5eVz3ZtangySUvdVqnzadhheKqE6
 jLK/Wza3mDbkPajmXlphBWit9011Pfjsyw07xo/ruvsPhH1F+hMxz+NaxqzyhJATnYIP1r
 CyomeAJ07UihdEIpNnzot0t13kCHgFyShvQPu9dK+vqCMcrPLtjGx3jsFsMJYw==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>, Li Yang <leoyang.li@nxp.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Shengjiu Wang <shengjiu.wang@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v3 08/10] dt-bindings: sound: Add support for QMC audio
Date: Fri, 13 Jan 2023 11:37:57 +0100
Message-Id: <20230113103759.327698-9-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230113103759.327698-1-herve.codina@bootlin.com>
References: <20230113103759.327698-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The QMC (QUICC mutichannel controller) is a controller
present in some PowerQUICC SoC such as MPC885.
The QMC audio is an ASoC component that uses the QMC
controller to transfer the audio data.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../bindings/sound/fsl,qmc-audio.yaml         | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml

diff --git a/Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml b/Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml
new file mode 100644
index 000000000000..ff5cd9241941
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml
@@ -0,0 +1,117 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/fsl,qmc-audio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: QMC audio
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+description: |
+  The QMC audio is an ASoC component which uses QMC (QUICC Multichannel
+  Controller) channels to transfer the audio data.
+  It provides as many DAI as the number of QMC channel used.
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: fsl,qmc-audio
+
+  '#address-cells':
+    const: 1
+  '#size-cells':
+    const: 0
+  '#sound-dai-cells':
+    const: 1
+
+patternProperties:
+  '^dai@([0-9]|[1-5][0-9]|6[0-3])$':
+    description:
+      A DAI managed by this controller
+    type: object
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 63
+        description:
+          The DAI number
+
+      fsl,qmc-chan:
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+        items:
+          - items:
+              - description: phandle to QMC node
+              - description: Channel number
+        description:
+          Should be a phandle/number pair. The phandle to QMC node and the QMC
+          channel to use for this DAI.
+
+    required:
+      - reg
+      - fsl,qmc-chan
+
+required:
+  - compatible
+  - '#address-cells'
+  - '#size-cells'
+  - '#sound-dai-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    audio_controller: audio-controller {
+        compatible = "fsl,qmc-audio";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        #sound-dai-cells = <1>;
+        dai@16 {
+            reg = <16>;
+            fsl,qmc-chan = <&qmc 16>;
+        };
+        dai@17 {
+            reg = <17>;
+            fsl,qmc-chan = <&qmc 17>;
+        };
+    };
+
+    sound {
+        compatible = "simple-audio-card";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        simple-audio-card,dai-link@0 {
+            reg = <0>;
+            format = "dsp_b";
+            cpu {
+                sound-dai = <&audio_controller 16>;
+            };
+            codec {
+                sound-dai = <&codec1>;
+                dai-tdm-slot-num = <4>;
+                dai-tdm-slot-width = <8>;
+                /* TS 3, 5, 7, 9 */
+                dai-tdm-slot-tx-mask = <0 0 0 1 0 1 0 1 0 1>;
+                dai-tdm-slot-rx-mask = <0 0 0 1 0 1 0 1 0 1>;
+            };
+        };
+        simple-audio-card,dai-link@1 {
+            reg = <1>;
+            format = "dsp_b";
+            cpu {
+                sound-dai = <&audio_controller 17>;
+            };
+            codec {
+                sound-dai = <&codec2>;
+                dai-tdm-slot-num = <4>;
+                dai-tdm-slot-width = <8>;
+                /* TS 2, 4, 6, 8 */
+                dai-tdm-slot-tx-mask = <0 0 1 0 1 0 1 0 1>;
+                dai-tdm-slot-rx-mask = <0 0 1 0 1 0 1 0 1>;
+            };
+        };
+    };
-- 
2.38.1

