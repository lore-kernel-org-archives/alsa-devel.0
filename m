Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDB1606A31A
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Oct 2026 08:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=a8QUOhrQ;
	dkim=pass (2048-bit key, unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256 header.s=selector1 header.b=oF88Okql
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B3F5A601E2;
	Thu, 22 Oct 2026 10:41:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B3F5A601E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792658506;
	bh=pNYyEY8zBJ9SwoS/kbYoDOky6MBLftLWAQTWfThbtQk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=a8QUOhrQC6EO4Ht3lzNyRKlrsUvMf42UkHnkIkAX5QkAVx3cTs5Q4bMK8f+70FjWq
	 lpsTZe3qkAGN5ScIXdkLSoSLEJtJ0s3VIie6Ve4fPPYvY7vc++5nYqhfYIRizPMdrc
	 ZETypD/FcrUxaQNXavLEB2FJS7DT4/rJwKhTKL9Q=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F167EF8060F; Thu, 22 Oct 2026 10:41:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 77CE7F8060F;
	Thu, 22 Oct 2026 10:41:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 894BCF80526; Thu, 22 Oct 2026 10:40:58 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11013014.outbound.protection.outlook.com [52.101.127.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8720AF804B4
	for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2026 10:40:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8720AF804B4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=oF88Okql
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPVGOOuSkY89Q7dOIO9UNPZ6plPYrXiWfsDMXPYatZmEKsb2NaGmSYUdiZ1fz8sEkO7svaAS6troFdLnQ5X7wtcAdTQq2e3QcTdxhdqbqDmpyjkli25evhuxGLYOHxfcHCoMCVbSEf1rTa9PZjtNPqjF8qn2whBMlCboqdwPHUYcU4xi1zFLYCVn4C1eYTfrn59IKzITgMYf5M5H83mpFVugGp43yKel3O6cBoErLsYkQYPtn3TwUfT4ESSXBHXVwVs0apio0aEd8Yqn1fOKPVgFVADFO5ZOTWJkVhRxkSoUneVYycFQtZloVAYE3eaq2AxYO8ThQ1V8M7KVHyaMYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdm1QdsVbJO3gQaLvQwd57ITuCOqKvaLIN2DJRn93Ss=;
 b=mzdAuPVpF9/Ry4KFAIM21HP9L+iin5thYjeWENIBSUb4N7NbhAjspWnmbD9lnGwUATyMKMDI9iMY2OvxeMlXYKgsmCcXjFuF/dKG1+/DUSj8c1b05wHBVvNxIBR4woe3dtQzaY/2E64B+oWvZU7RxOBrQtfkdag2b2Qq3aLhFyS08WhhkVL1hGRhILV4IVlEvP2FXflyXFh46G6Y5WECWeAbrcVd9gauFL9d5YZTSX7E392oJj5mkYQ7NuTM0RTgDM+F4RutqRjDRgE4JFmi6o5yzHLZrBamllrsD/CTBjFhpRMwOW8NIvRCXm7/a+gOCx5ws6dE5rCgZgfNWf4PDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdm1QdsVbJO3gQaLvQwd57ITuCOqKvaLIN2DJRn93Ss=;
 b=oF88Okql/1lyG4JWjiOaXT40TztHYJ8aNYgFBPpqUGRSih/v2LRmcLKFKEzuq+Lk8+voEdCnAq+FLI0nOUxjZPjM5yRRlNappLUA6Di7xDPgzss7Yi8ef49m8lTEGeavAG1ak8tVA01EMfgixBZL4mK1qnMpiZ/TKxnJIjIpyMktFTfJsEVQ8FBwaq/q6qEvcrpnFzcHugE1Eo1dj0K0a7cVOgl1s5awk99dytyChvAknrpC9SJAYWk9DBniTwoKY5wagpKCqU6KegCHki1Mdly4E/SvkSpdYzJA3bjyF9m7yzfUPFex8cRRg4L5r40LcOugqv761pvMzGUmudheVw==
Received: from SI1PR02CA0029.apcprd02.prod.outlook.com (2603:1096:4:1f4::20)
 by KUZPR03MB10265.apcprd03.prod.outlook.com (2603:1096:d10:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 08:40:42 +0000
Received: from SG2PEPF000B66C9.apcprd03.prod.outlook.com
 (2603:1096:4:1f4:cafe::99) by SI1PR02CA0029.outlook.office365.com
 (2603:1096:4:1f4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 08:40:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 175.98.123.7) smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS02.nuvoton.com; pr=C
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 SG2PEPF000B66C9.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 08:40:42 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Thu, 22 Oct
 2026 16:40:39 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Thu, 22 Oct
 2026 16:40:39 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Thu, 22 Oct 2026 16:40:39 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Neo
 Chang" <YLCHANG2@nuvoton.com>
Subject: [PATCH v1 1/2] ASoC: dt-bindings: nuvoton,nau8310: Add NAU83G10
Date: Thu, 22 Oct 2026 16:40:36 +0800
Message-ID: <20261022084037.259983-2-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261022084037.259983-1-YLCHANG2@nuvoton.com>
References: <20261022084037.259983-1-YLCHANG2@nuvoton.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66C9:EE_|KUZPR03MB10265:EE_
X-MS-Office365-Filtering-Correlation-Id: dd914ac1-f379-44df-f151-08df3018282e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|6133799003|18002099003|10067099003|261021121427099003|13003099007|3023799007|22082099003|261021123027099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	NSEWRkKo7OpPFIrA+reWyt/RkdIf+fet3jXI3Za2PUEq1fvs3R1+Qe5MIna430qSzmxPS1wb4i1ZB+80xn2r9949jBiKRiFVPPz6iuwdxJBvKN+wdIp3UzIOFW5MXFUJSjY2TNyLf3n65ygnpX9uklV3dJEzRMCEhBqlREe3rFfW6ZjEfqrI11wBsQ7X2PWYsEIH35Qm66RwHQz+acEZ7Ohz7RLX93hbRwJ6oYM5FTshnGOb0RN17nCjznZt5mZWQj4Ob0wVss9tAPiSlPH+wjENBQB3HPA747BK5iyul7YcmxgfwzxnAlaBfzv8W/WdTCV5pE7MfLnNauFp49s6xX9zI1J6OekwiKCNfzqBMU1VEOaA/XP0MF9ksFL7qBBzZPD/kIdcSqiAs6VIzWp4Pre35IBLAi8XBUcXAWgI4aYIth8lxUa27+B9sixPixTSSFqJkCltrlfNWLvpl9Tps+jzjSYZmofAGqsyJx4I8rofkz+3xbfnb/zyu26tY1o4U8CH56OYLy5b9Ie3cjUceZCtoOgTqufrutdqpnpLMdEYSmnT2QonOF4LZ15rNhYYkDOJObc9NNuxa32wv8fji6BOwaEMiAj8XRU8/+Hmebp5Y+OpwA9MIrWOjN90vhksdQ/JNv9XM5kJtkoC53BsVA==
X-Forefront-Antispam-Report: 
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(6133799003)(18002099003)(10067099003)(261021121427099003)(13003099007)(3023799007)(22082099003)(261021123027099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	qBsy8lqQnC8CHfkRbFwRCkUCWzwhzLfh+hHpxi3rs3Ni1Uajq8MpJZUPBOLemgdCFaw6zX0s25tDlBMIBntYRTaV6SF7pLMCjjSHnZbs44vrBBz6wNW3VHQ5CdL2yB/NDe0ZJZOyS7x2h6Mwc8sd/NZS1MXvzubLFmsV+RkDZVJ1Z7N67Q+bC3xL30RBoAMeCiln+QekNUDyRb8JqL5nlaDFcCPlMzvwd9V9HcSvmizPS/rwj+SzcC2sPZTwm7+hN0zalnI8inKkef4FygWQojiDt/YEAd2WKnCH5ORh7gHPapinN11e7Q2lnkm97i0wIGEqiQ1KFdub+Mby8+PI564WJmguzVDf0L0XBC+Ze5G2axH8ezSECHZ+m3x7/2gK1gYcgXyOfxa5LqC/y47f68mLp0HDVOGXel0XhkRnBamjcYNMbQOqiHhtA37Ga9Ne
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:40:42.0228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 dd914ac1-f379-44df-f151-08df3018282e
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SG2PEPF000B66C9.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR03MB10265
Message-ID-Hash: QI64DHV6HFNONVGCHZAVLSVKPBTP2C7V
X-Message-ID-Hash: QI64DHV6HFNONVGCHZAVLSVKPBTP2C7V
X-MailFrom: YLCHANG2@nuvoton.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QI64DHV6HFNONVGCHZAVLSVKPBTP2C7V/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

Add device tree bindings documentation for the Nuvoton NAU83G10
audio amplifier.

Signed-off-by: Neo Chang <YLCHANG2@nuvoton.com>
---
 .../bindings/sound/nuvoton,nau8310.yaml       | 200 ++++++++++++++++++
 1 file changed, 200 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8310.yaml

diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8310.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8310.yaml
new file mode 100644
index 000000000000..5a5142a583ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8310.yaml
@@ -0,0 +1,200 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nuvoton,nau8310.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NAU83G10/20 Mono Class-D Amplifier with DSP
+
+description:
+  Mono Class-D Amplifier with DSP and I/V-sense.
+  This device supports I2C.
+
+maintainers:
+  - Neo Chang <YLCHANG2@nuvoton.com>
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,nau8310
+      - nuvoton,nau8320
+
+  reg:
+    description: The I2C address is determined by the hardware pins.
+    enum: [0x10, 0x11, 0x40, 0x41]
+
+  "#sound-dai-cells":
+    const: 0
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: mclk
+
+  firmware-name:
+    items:
+      - description:
+          DSP core firmware.
+
+  nuvoton,vref-impedance:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      VREF Impedance Selection.
+    enum:
+      - 0 # Open
+      - 1 # 25 kOhm
+      - 2 # 125 kOhm
+      - 3 # 2.5 kOhm
+    default: 0
+
+  nuvoton,dac-vref:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      DAC Reference Voltage Setting.
+    enum:
+      - 0 # Voltage source directly from VDDA pin
+      - 1 # VDDA * 1.5/1.8V
+      - 2 # VDDA * 1.6/1.8V
+      - 3 # VDDA * 1.7/1.8V
+    default: 1
+
+  nuvoton,sar-voltage:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      SAR Gain Tracking Selection.
+    enum:
+      - 0 # VDDA
+      - 1 # VDDA * 1.0
+      - 2 # VDDA * 1.1
+      - 3 # VDDA * 1.2
+      - 4 # VDDA * 1.3
+      - 5 # VDDA * 1.4
+      - 6 # VDDA * 1.54
+      - 7 # VDDA * 3.12
+    default: 0
+
+  nuvoton,sar-compare-time:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      SAR compare time.
+    enum:
+      - 0 # 500 ns
+      - 1 # 1 us
+      - 2 # 2 us
+      - 3 # 4 us
+    default: 1
+
+  nuvoton,sar-sampling-time:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      SAR sampling time.
+    enum:
+      - 0 # 2 us
+      - 1 # 4 us
+      - 2 # 8 us
+      - 3 # 16 us
+    default: 1
+
+  nuvoton,clock-det-disable:
+    type: boolean
+    description:
+      Enable Clock Detection Module.
+
+  nuvoton,clock-det-data:
+    type: boolean
+    description:
+      Clock detection non-zero samples configuration for power up signal.
+
+  nuvoton,boost-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Boost Control Hold Timer in decrement (msec).
+    enum:
+      - 0 # 0 msec
+      - 1 # 1 msec
+      - 2 # 2 msec
+      - 3 # 4 msec
+      - 4 # 8 msec
+      - 5 # 16 msec
+      - 6 # 32 msec
+      - 7 # 64 msec
+      - 8 # 128 msec
+    default: 0
+
+  nuvoton,boost-convert-enable:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Boost Convert Enable.
+    enum:
+      - 0 # BOOST CONVERTER disabled
+      - 1 # BOOST CONVERTER enable gated by POWERUP signal
+      - 2 # BOOST CONVERTER disabled
+      - 3 # BOOST CONVERTER enabled
+    default: 0
+
+  nuvoton,boost-target-limit:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Boost Control Target Value Limit.
+      The value ranges from 0 to 63, representing 0V to 12V with a 0.19V step.
+    minimum: 0
+    maximum: 63
+    default: 63
+
+  nuvoton,boost-target-margin:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Boost Margin Value between Boost Target Voltage and peak output level.
+      The value ranges from 0 to 63, representing 0V to 12V with a 0.19V step.
+    minimum: 0
+    maximum: 63
+    default: 0
+
+  nuvoton,temp-compensation:
+    type: boolean
+    description:
+      Enable Temperature Compensation.
+
+  nuvoton,normal-iis-data:
+    type: boolean
+    description:
+      Enable Normal I2S Audio Data mode. The I2S interface
+      transmits only audio data without SAR ADC data.
+
+required:
+  - compatible
+  - reg
+  - firmware-name
+
+allOf:
+  - $ref: dai-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        codec@10 {
+            compatible = "nuvoton,nau8310";
+            reg = <0x10>;
+            #sound-dai-cells = <0>;
+            firmware-name = "NAU83G10.kcs.bin";
+            nuvoton,vref-impedance = <2>;
+            nuvoton,dac-vref = <1>;
+            nuvoton,sar-voltage = <0>;
+            nuvoton,sar-compare-time = <1>;
+            nuvoton,sar-sampling-time = <1>;
+            nuvoton,clock-det-disable;
+            nuvoton,clock-det-data;
+            nuvoton,boost-delay = <0x8>;
+            nuvoton,boost-convert-enable = <1>;
+            nuvoton,boost-target-limit = <0x32>;
+            nuvoton,boost-target-margin = <0x2>;
+            nuvoton,temp-compensation;
+            nuvoton,normal-iis-data;
+        };
+    };
-- 
2.25.1

