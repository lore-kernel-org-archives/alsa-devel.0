Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BFDC0015E
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Aug 2023 13:30:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C0B7183A;
	Wed,  9 Aug 2023 15:30:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C0B7183A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691587854;
	bh=l2JKHlzo8CqN5xNY7fOpHVVlsFR80Qj4Zd0qsne4JTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Ppyf4c1ayiwIimmKYewOZDYRuSzEL3S/P3aRyMidAJCCsR6UJWwg9Q1c1hqsKIv+h
	 WtD3X4DC1THStY8IKbHyGCtEk0R5snpeV+Nm1steYEC/rk8CLK0lF65hLEZH4yBFGg
	 sOLP8IcMpD9g36r+pGtDxdronrEQRlixdWyxmXfI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4C913F805C3; Wed,  9 Aug 2023 15:28:50 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 79A00F805C5;
	Wed,  9 Aug 2023 15:28:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 91B29F80134; Wed,  9 Aug 2023 15:28:33 +0200 (CEST)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::222])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E1D00F800F4
	for <alsa-devel@alsa-project.org>; Wed,  9 Aug 2023 15:28:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E1D00F800F4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=c0wz82JN
Received: by mail.gandi.net (Postfix) with ESMTPA id E51A040015;
	Wed,  9 Aug 2023 13:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1691587699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3JD+3fKGnMbSvdz1F67euTX0+sfYtpi8OvnsedJgBLQ=;
	b=c0wz82JNYLUNv3xyAjAZVJp3guw2pXI+9LbiLhL3ka2EuoPEKN8NHlGP6TWDJVgyekrpU6
	/WOnIlP4xvVWpCoHTcwypdqn2MMgYzFLlqu5CyD5qYcnhEfBQZ+L73b0gc9wZwAWGWJ1Ho
	+vltVn/Qxbfg8c4oGyCaEhOVqMW4W/VaqsR0O1oefNS+vP4tVhDv4km+dF7lwNJJ2/Kg4F
	OamiwYRWvzB7BDscOdWsMAiwhNLYuFkWHsWcJiUcsIwAxb4OaVPAJ9tTN/1NblOMwqq2Wm
	5NrlcsGQZ19FodnA+X4k1uu7dQyInbDze5rHs536a0uZ/9SWXtWwVwQETtip1Q==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	alsa-devel@alsa-project.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 06/28] dt-bindings: net: Add support for QMC HDLC
Date: Wed,  9 Aug 2023 15:27:33 +0200
Message-ID: <20230809132757.2470544-7-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809132757.2470544-1-herve.codina@bootlin.com>
References: <20230809132757.2470544-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
Message-ID-Hash: FOHXIVQECKCFB3FATHGDXH5ZCXOJG7OM
X-Message-ID-Hash: FOHXIVQECKCFB3FATHGDXH5ZCXOJG7OM
X-MailFrom: herve.codina@bootlin.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FOHXIVQECKCFB3FATHGDXH5ZCXOJG7OM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The QMC (QUICC mutichannel controller) is a controller present in some
PowerQUICC SoC such as MPC885.
The QMC HDLC uses the QMC controller to transfer HDLC data.

Additionally, a framer can be connected to the QMC HDLC.
If present, this framer is the interface between the TDM bus used by the
QMC HDLC and the E1/T1 line.
The QMC HDLC can use this framer to get information about the E1/T1 line
and configure the E1/T1 line.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../devicetree/bindings/net/fsl,qmc-hdlc.yaml | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml

diff --git a/Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml b/Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml
new file mode 100644
index 000000000000..13f3572f0feb
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/fsl,qmc-hdlc.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/fsl,qmc-hdlc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale/NXP QUICC Multichannel Controller (QMC) HDLC
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+description: |
+  The QMC HDLC uses a QMC (QUICC Multichannel Controller) channel to transfer
+  HDLC data.
+
+properties:
+  compatible:
+    const: fsl,qmc-hdlc
+
+  fsl,qmc-chan:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to QMC node
+          - description: Channel number
+    description:
+      Should be a phandle/number pair. The phandle to QMC node and the QMC
+      channel to use.
+
+  framer:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to the framer node
+
+required:
+  - compatible
+  - fsl,qmc-chan
+
+additionalProperties: false
+
+examples:
+  - |
+    hdlc {
+        compatible = "fsl,qmc-hdlc";
+        fsl,qmc-chan = <&qmc 16>;
+    };
-- 
2.41.0

