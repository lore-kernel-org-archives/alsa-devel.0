Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04892CD5BC9
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2026 02:00:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7B3B7601BB;
	Tue, 26 May 2026 03:59:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7B3B7601BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779760797;
	bh=B+beyt6bp1/wSZYXzSSOVJZbRF6QR/i3P4CR5D92oDA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qFGykpJB8DmtvgMSU5zJQNy58/MQIlu2QhReb2tZqx1LDU7/uyDsmqVaXZFfNW2pK
	 vWw/Yi5ijtGOLYHC3Rwwy+4crk12zuXer0r4GfqHWKAR8YhfPJSYZTNAY0EEtHhpSm
	 uMvJ4sEbkTeerays3HMnuQ5cAV2JnkzSVX3olg2c=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 13825F80614; Tue, 26 May 2026 03:59:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C3905F805FB;
	Tue, 26 May 2026 03:59:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9D671F80217; Tue, 26 May 2026 03:59:03 +0200 (CEST)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11013050.outbound.protection.outlook.com
 [40.107.44.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 22F09F800D0
	for <alsa-devel@alsa-project.org>; Tue, 26 May 2026 03:58:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22F09F800D0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=hxHeCgJL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jucLbyTBXJjFacigzyFiTT12geBpYTTHObovHu/UhV79l8qNH9BIWp6IOdYmFGkhCjfdpo0W9nPVVW0giqeKEoW/nmWxeGEnDJTNWWJKLO82BQgDaYKjkXcv8N4KcQup6w1xzsGg5r20EzJUxOcjCN8+XlK0YEFrAYlpUNyJS1gnVgcx8hPi8Asl0hUePM85Ltzm+QiHNIMGi1mUl9hricGw4TdcUXeAkVOHmwvU3+XaS1IKBWiEGjHU8Uq5QazSlX4ckF3wChG1a/Exmt62K4F0LUsaZRV/Hgxhn14Q9vpO6HZLxLXr2zAtbia0OSsAKQJ3YgKHrvrVr9vxbbO1Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUhwDJEYLcrdiWWKN8kweVmx04Xk5P4rCV+9vl7mvA8=;
 b=Xn2xbMzp19P63LGeQ0zLDRCjDkc7jetC58e26hw4m4w8ZXo6jFW/03t0JTX+GhHbPxPWeIOnFRDYcKINSH0zAY3qwmKZ79im6fDU4tZ4Oo/P7vCs1QTbXeifZcYlhSG5gktyt/brqMXA8e65tHCv2CyKMQ04tvSihGw5wYqJLa6SMfKvPcwIoJ5NXpE4sN8p5oBHGaPfQDrFLnBN6ukCbsHWsKRB/ZQznY2PAzYei7ja2VaOcTPtiwRiwp6VuMwLLBONqle1nQgwAiZYYjb5WIRYyNsnFjFsKD2eKzK9xn5TDemrjrPHvWRxvwMBW5AA9P1Xf00yspH/ghK9+ncfqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUhwDJEYLcrdiWWKN8kweVmx04Xk5P4rCV+9vl7mvA8=;
 b=hxHeCgJLKpqG8GyG0f6Mk+X1TAPVX56Rc98CiOiT+5HPWHg7rC9v2VssLoCd7I9AfLlK9tVqToV0seLrkDxVLl/4OaPbLVf/Qu5TUqJ/Fd3FqJxEoG68xS2fWJa7DV4ufqFCpap6JqBaNdI5+UJSnyIFIwWijmpE8YC36zwFOIBXrdPidiWMHbkaZXJogxI26G4yA38KsYOQBqVdIlAOUtxZUCOWnyIkx9k8Y6huGWVnJP18/bu5O9Gf2vhwqkXeJ5go74ga2Pbz/hxel+TfIowUPQK2y3t/+ss7Kj2qLfJH8GaGyfchU2XXxlfZNOg7q/9g+ZYse5qPOuMaF7p2bw==
Received: from SG2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::10) by
 TYZPR03MB6920.apcprd03.prod.outlook.com (2603:1096:400:28d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.11; Tue, 26 May 2026 01:58:50 +0000
Received: from OSA0EPF000000CC.apcprd02.prod.outlook.com
 (2603:1096:4:c7:cafe::56) by SG2P153CA0023.outlook.office365.com
 (2603:1096:4:c7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.2 via Frontend Transport; Tue, 26
 May 2026 01:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS02.nuvoton.com; pr=C
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 OSA0EPF000000CC.mail.protection.outlook.com (10.167.240.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 01:58:48 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 26 May
 2026 09:58:46 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Tue, 26 May 2026 09:58:46 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Neo
 Chang" <YLCHANG2@nuvoton.com>
Subject: [PATCH v3 1/2] ASoC: dt-bindings: nuvoton,nau8360: Add NAU83G60
Date: Tue, 26 May 2026 09:58:25 +0800
Message-ID: <20260526015826.440769-2-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260526015826.440769-1-YLCHANG2@nuvoton.com>
References: <20260526015826.440769-1-YLCHANG2@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CC:EE_|TYZPR03MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: af6e07b0-60d3-4442-1720-08debaca53a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|13003099007|56012099003|18002099003|22082099003|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	JMPSB2OCbg+YQ5mVKWuimkp38OGLjEuoHMD/xP8i4q/9LYrCGwibWk17HoCgVVsLrhgGar6KA36gNWWKZ8St9Fbm34mEn/2+CR1LGvCELDMAAYVenXGgkXDxfxJ/gdsdmb8pI5W+If4bOPUa2yxWCGGVtQjRdRS8bHKw/v9iYKwvx4oBaqHYhg66+YC5k4SUIUY73H5jS7m7CRnIA4Mu6J0itaYd7YsmewF4G//SytF9B29HDl6RusCexNrWL6GGyAngLn51Ni+eVnyQyFOu/8+xdnYpnv70WbBvEsgbgCtsmlYuohr3uDVvat9qXH3GJ3JNrgEUSDIZqhX6aDN24N4uI8nN6l8lkZPEPUbc1rUtDSVesrPqwMOZLXv4sRl7yB3/UFj9IPkGuZ4QvKfdjaiCJ45aRPLpZUC2hL+5ecbxCXwLySeCRRS1fvcieA0Bgx3TuvNm167cjmiG2RRx97qxk3a8d0zzgmLPZweS2x9fyizNrudi+PgXDp5kLjTo18F7bQW0s/OyaNIt+caKUBiiu/e2ciSlMi3xHe2EIPLjmeJZp7lePhNOW/ndXgwvcenyIcPy7pw/KBnofj9Sc6fJDJs0WJh+d8KAlZPDyyBmwhTIPBytFgsl60mn93kbDacjUbA+wtdYB5MQdeqXPu1idWERUf1NPKJA0/pmn+Njv0AnJ/i6Xpp55/G0QnlK
X-Forefront-Antispam-Report: 
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(13003099007)(56012099003)(18002099003)(22082099003)(11063799006)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	XZnmkgwMEzA+WwIlO3wAadSlMRYvN3NR+j2uamRRML2hq9IbC4L7JJpqiuycOuJEJNs1Cmok5icHy2eaxqcrx91yX8o5xLXyzKuaVyhoWjKk9MDdLDQhYeJpEbNAsN/CwQ/BeU285nZI3voDpL7KUMdY1/3OFL3gCTimYMX4wHmTfpjuggzaXAFxz6RQzjav3bJ16EsYv4f29FerUCazX6tUPeciwxhYBPsNlqy1B7hFIRaJC3T0xy7vhDjvjfe0n7PSyoR54i+rrcImGpA2ibQm9BSSilB1q2lECbPZ75QE8VxVrkQB3M+qrYtmkcDNy5dp7Ga4tznQaN52O8J2UAK5JI77wSmXIQ3c/L1KN4fGklb0dwcHNMWpVCHD7hkDGnTXHPp8wqnBcrDyQZ/gNQvgoUqFNsbIAZW10V5d16DxOOhsXY8GSKuLoO4tAdXQ
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 01:58:48.1625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 af6e07b0-60d3-4442-1720-08debaca53a3
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	OSA0EPF000000CC.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6920
Message-ID-Hash: XD7WWGX45QABBQQYPSFA5DC6JTHUIPMG
X-Message-ID-Hash: XD7WWGX45QABBQQYPSFA5DC6JTHUIPMG
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XD7WWGX45QABBQQYPSFA5DC6JTHUIPMG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add device tree bindings documentation for the Nuvoton NAU83G60
audio amplifier.

Signed-off-by: Neo Chang <YLCHANG2@nuvoton.com>
---
Changes in v3:
Remove colon to resolve YAML build warnings.
Fix 'firmware-name' property definition to comply with binding schemas
---
 .../bindings/sound/nuvoton,nau8360.yaml       | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml

diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
new file mode 100644
index 000000000000..906c3ae3b72a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nuvoton,nau8360.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NAU83G60 Stereo Class-D Amplifier with DSP
+
+description:
+  Stereo Class-D Amplifier with DSP and I/V-sense.
+  This device supports I2C.
+
+maintainers:
+  - Neo Chang <YLCHANG2@nuvoton.com>
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,nau8360
+
+  reg:
+    maxItems: 1
+    description:
+      The I2C address of the device. The address is determined by the external
+      hardware configuration of GPIO1 and GPIO2 pins.
+       - 0x1a (GPIO2=Low, GPIO1=Low)
+       - 0x1b (GPIO2=Low, GPIO1=High)
+       - 0x4a (GPIO2=High, GPIO1=Low)
+       - 0x4b (GPIO2=High, GPIO1=High)
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
+  nuvoton,dsp-bypass:
+    type: boolean
+    description:
+      Forcibly disable/bypass DSP path.
+
+  nuvoton,pbtl-enable:
+    type: boolean
+    description:
+      NAU83G60 supports PBTL mode for mono output.
+
+  nuvoton,dac-cur-enable:
+    type: boolean
+    description:
+      Adjust DAC output current to match speaker impedance and prevent
+      hardware damage. +3.2dB when present, 0dB by default.
+
+  firmware-name:
+    minItems: 2
+    maxItems: 2
+    description:
+      Assign firmware filenames for left and right DSP cores.
+
+required:
+  - compatible
+  - reg
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
+        codec@1a {
+            #sound-dai-cells = <0>;
+            compatible = "nuvoton,nau8360";
+            reg = <0x1a>;
+            nuvoton,dsp-bypass;
+            nuvoton,pbtl-enable;
+            nuvoton,dac-cur-enable;
+            firmware-name = "NAU83G60.kcs.bin.l" , "NAU83G60.kcs.bin.r";
+        };
+    };
-- 
2.25.1

