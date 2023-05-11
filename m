Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFDFC77B7C
	for <alsa-devel@archiver.kernel.org>; Thu, 11 May 2023 15:07:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D043BED9;
	Thu, 11 May 2023 17:06:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D043BED9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683817662;
	bh=CSUQEL5n9/eZar15lW4jaif3f1BMAmxtD6wV7xkTSAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=JT14GND1QJZel72Gn5rGyrbgKISEz6+mfWAiZ7b28OhS7hpyt06ewkY9Q8dB3WtMp
	 9oeyekIVhLI+SHbY0LiIRxa8sM6waMRvl+nSMxbDPjdmbMuRktsn5mcV3eejw7dDG0
	 XSddN6Tvu7JTy40gQdMy1ty52bSkSKCbb0Ox8y0U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 560DBF80544; Thu, 11 May 2023 17:06:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F179DF8014C;
	Thu, 11 May 2023 17:06:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3D665F80310; Thu, 11 May 2023 17:06:25 +0200 (CEST)
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E7822F80310
	for <alsa-devel@alsa-project.org>; Thu, 11 May 2023 17:06:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E7822F80310
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=cutebit.org header.i=@cutebit.org header.a=rsa-sha256
 header.s=mail header.b=m+c9kFV4
From: =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
	t=1683817579; bh=LUXpft4LGfCn5GgpYQv6QU3QQmD6+DR/XZsk9hOWCGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m+c9kFV4LIiEFh1DscaoTKxX7uZPMsuDU5gVOGJJkRH7CCfqbWyeM/CT3vaMw61Lj
	 p7bi+S31cUb8snlx/h8qv3YFs5nJD3QoC71AnBotJgty5sj5isC85I2fu2UnYCP+Gt
	 S09R9hS8PvRFyOJznORnq3ePMbvW2wZWuwu1AUxY=
To: =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: asahi@lists.linux.dev,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ASoC: dt-bindings: Add adi,ssm3515 amp schema
Date: Thu, 11 May 2023 17:05:45 +0200
Message-Id: <20230511150546.8499-2-povik+lin@cutebit.org>
In-Reply-To: <20230511150546.8499-1-povik+lin@cutebit.org>
References: <20230511150546.8499-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: XY3OFOI6HM74BTUNK4WBT25ZTQW5WQFT
X-Message-ID-Hash: XY3OFOI6HM74BTUNK4WBT25ZTQW5WQFT
X-MailFrom: povik+lin@cutebit.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XY3OFOI6HM74BTUNK4WBT25ZTQW5WQFT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add a DT schema for the SSM3515 amp by Analog Devices. It's a simple
mono amplifier with digital input.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 .../bindings/sound/adi,ssm3515.yaml           | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/adi,ssm3515.yaml

diff --git a/Documentation/devicetree/bindings/sound/adi,ssm3515.yaml b/Documentation/devicetree/bindings/sound/adi,ssm3515.yaml
new file mode 100644
index 000000000000..144450df5869
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/adi,ssm3515.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/adi,ssm3515.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices SSM3515 Audio Amplifier
+
+maintainers:
+  - Martin Povišer <povik+lin@cutebit.org>
+
+description: |
+  SSM3515 is a mono Class-D audio amplifier with digital input.
+
+  https://www.analog.com/media/en/technical-documentation/data-sheets/SSM3515.pdf
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - adi,ssm3515
+
+  reg:
+    maxItems: 1
+
+  '#sound-dai-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      codec@14 {
+        compatible = "adi,ssm3515";
+        reg = <0x14>;
+        #sound-dai-cells = <0>;
+        sound-name-prefix = "Left Tweeter";
+      };
+    };
-- 
2.38.3

