Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48C0C3DA7A
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Jan 2023 16:41:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B4CD614831;
	Fri,  6 Jan 2023 17:40:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B4CD614831
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673023286;
	bh=GYaUhXsPb0SuJnvYcWVomdLjFr9K1hWqWlMPv0IsRCE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ZMoYTGpjGED6A37WvRffLTUbEuh9xwFHwjSDJtq/no1PiqcODDhBsszwx3J/fDkjJ
	 2mCOEKRMMtW7ogplbL1/j3nIw70yXBUSH+DF30Po5GKnOwh2232FD7XTLvvmWJVdfC
	 8esz/UuUBSHcpmM99QabLd/DuXn0wVW2kNilvUow=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A10BF805A0;
	Fri,  6 Jan 2023 17:38:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6D6C4F80587; Fri,  6 Jan 2023 17:38:29 +0100 (CET)
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::231])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C132EF80579
 for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2023 17:38:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C132EF80579
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=SByRr+7g
Received: (Authenticated sender: herve.codina@bootlin.com)
 by mail.gandi.net (Postfix) with ESMTPA id B7F1B10000A;
 Fri,  6 Jan 2023 16:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1673023105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fwN9f1Uf9OnuRKb5i5JlqxFqzREU6PwCAerriE9fsNU=;
 b=SByRr+7gcbkYBRtLXB4anCzVQoz1maVymSN3z+wF+otU00mpOnYch44/qrM1I6jvs9Qqlr
 0rABT7GUvTMfkMg/cbpNa8kjcvjAfSY7Si23euyx/+M41eZL4V9zd3yV8l08WVYU/sZ3eY
 C4yOGeBoJHCw3iu4bO71Dqkz3HmlZO4B0SIsYYluT9jQsyQJCQ+3Q7IlhtYorKBCDIpI2z
 dgn13k5IMkWAPBT66hAR7s1oU6YiW4RR7SlEOpmJg30I/e/34a7SA00tHiB+/MMdpKCpsL
 VDFwPNHDjsOwQ2cqi3MpGuKIGaSZlhVEctPbZCZzB0DfVS0YoDZ+DViLQwddBw==
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
Subject: [PATCH v2 08/10] dt-bindings: sound: Add support for QMC audio
Date: Fri,  6 Jan 2023 17:37:44 +0100
Message-Id: <20230106163746.439717-9-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230106163746.439717-1-herve.codina@bootlin.com>
References: <20230106163746.439717-1-herve.codina@bootlin.com>
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
 .../bindings/sound/fsl,qmc-audio.yaml         | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml

diff --git a/Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml b/Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml
new file mode 100644
index 000000000000..b3774be36c19
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml
@@ -0,0 +1,110 @@
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
+properties:
+  compatible:
+    items:
+      - const: fsl,qmc-audio
+
+  '#address-cells':
+    const: 1
+  '#size-cells':
+    const: 0
+  '#sound-dai-cells':
+    const: 1
+
+patternProperties:
+  "^dai@([0-9]|[1-5][0-9]|6[0-3])$":
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
+      qmc-chan:
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+        description: phandle to the QMC channel
+        maxItems: 1
+
+    required:
+      - reg
+      - qmc-chan
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
+    qmc_audio: qmc_audio {
+        compatible = "fsl,qmc-audio";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        #sound-dai-cells = <1>;
+        dai@16 {
+            reg = <16>;
+            qmc-chan = <&scc_qmc 16>;
+        };
+        dai@17 {
+            reg = <17>;
+            qmc-chan = <&scc_qmc 17>;
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
+                sound-dai = <&qmc_audio 16>;
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
+                sound-dai = <&qmc_audio 17>;
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

