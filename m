Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57321C43458
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2026 09:36:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9D32D6021A;
	Wed,  8 Jul 2026 11:36:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9D32D6021A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783503389;
	bh=N9HwYvdDZ7MYLfUpffIi2fY9mWUAFzTnzjyafYaB91o=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=pWwYdz/E+CtdMBzzdjGYwKlQvtqPl/P2QURFtirpPlgD7PbEE1Pv24nX9I0JZY8ZC
	 phw1sGcyTqi80ximZSfEkBLjRb9zhL9rSwb/SVw1DSklNexBJXCPsud4WDVwugASdQ
	 oPcdFJuVfoQtbzGt/aj0oZ5w/uNjXdmc8tKagcdc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7DC95F80616; Wed,  8 Jul 2026 11:35:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AFDDBF80571;
	Wed,  8 Jul 2026 11:35:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BA834F8055B; Wed,  8 Jul 2026 11:35:27 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.8
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1783503324;
	b=rfAg5Vs6gGtFZrcvLayONLg66kB3wLd8U1JoRNOEB7hAvHjmw8NatO84GPX2xtLxhmHM
	 UsrVMY4D0TZZvW84GAYkQ16n6woLjBFQQrMz0KJnzdw4Tog0OqQxh9D3WNTo4vXtnGoTd
	 U2jOAlDAmAZ13fKFsGA91wQHSeoLbhlsMY7CuzKkjh/2JTqxkit8qSop8MZvGfnkW6q1M
	 XDZx9ounrynEkIMMfjlgiduVGHHTlxcKekI8APEPW2S4fBsNRiSUhEfRQuEkrcbAWBudB
	 ey2k/rJUJrxD8Ej+xqkKHW3CaSja3RjeUHQ+i6JOLgAZk/w+Rxn3JCatZAFzkih53MA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783503324;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=N9HwYvdDZ7MYLfUpffIi2fY9mWUAFzTnzjyafYaB91o=;
	b=m3B4z8iECyn4U65gKaqR00HVCCCpIFvNh7c9OlCEjHpYvd27uhctf/TEj3OzyaKToamJ
	 XtyfzgzW2bZrNRhAibnCNqr2qZr333rvMeCPCRudopqT2P2T8YXScSdE/8Q21B8hJiyN2
	 eN25cS7ghWNr5dcVtCTTqLdNbCXnwolQwUoPQZ+LEcKUaBoXs/Sbd2rNexXQy5CGG7Fdn
	 8GtXozTYKELOtqVPxU1gnvSB2hxf2YJiFSsIqcx6POx4rwvhj7X8v2PyTpe9f4qYRE6Ip
	 SbuPxCfibvpbgt5KzWV8Vmlrc9fISrGFMjakgpabvNXq6QLEdH8az5iv+VkbZfJdnNQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=amZQ+El0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.8
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11012008.outbound.protection.outlook.com [40.107.75.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D776BF80212
	for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2026 11:35:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D776BF80212
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=amZQ+El0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoOOEaNO6x5D+Us72AaP0nY40YZx4lfkNNJa9gEgTk4tXq+kt02fiX5phBAuRwEIuYaxxyZMO5/fHjClSvJXALeAA5crSWc9HBwoPgHhx3afBXkD4UfcW3whhFAb7Ramuhr43tfU9sH7ZyYCtO+82sW9+zqt+W8DTm7/1s6Te1gRQzCD+v6sTsL6bMbD7bxq8Pv6B1/+FSv9soh7i8bgSeBuTnxkFoRrZ2WaKBckaTpMPcnH9feyvV0gpF9FKJryxqPL8BLsPo1e8LTfRpriA7sU94LJ7ViJHjXvKs3Uq13UGSpshvQZFna5Dpbi+HGHIZUcsPYuXFFSJ7pAS1gFBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzM5toPKezEkkg3su0GY7bV9P2yrivEj+9Lmi3BEmns=;
 b=T41fuZgly6N6qmunVQkr4szNUO2AG0rNUtF1GHr5UOlj86x+zcF9K2R6LdIcCv8zexpgMbDZsl9tBTPR7N8jxIN2/nUDyecU7Au8+nr2uPkWaseyV5iB8lpglYiy37mYE3JV+lnilYbtLS5gK6qLuoBEjhuwek1ymDa4fhMHUB6JZ5rdLWd9ucsToJ3YXotLUaoMWSD2gFFp5POEvWN+4st8Q2H5jRBWmXlYKamKs+X93/ckJ1xG6lw87LZ5zUiPzpWVu7R3I/JubyFv26er+9x6Zt84cSDQ7k8X1k06YyRKtqb/OJ3GjVbDu8XR59xzoDVYoJmVKmfBKpT154O/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzM5toPKezEkkg3su0GY7bV9P2yrivEj+9Lmi3BEmns=;
 b=amZQ+El0wzlealUwNH/s8OHD+Re4dBduCZhcpchV0r+GEFNdUHLdiV/pIE4qQ68Bz7IwL+O+ZRiwH+ZrqVBLz3K0fy8T47n9a+WcD9NyiBuW+mL6IJeiAbiIIevOiS81r+BcHEZuQGGFup/WHKxStx/80X7RjmfO1P+GVhwEhaZ6ajWjvLLDfmCTP/EhN/XYcJ8dJzGIIEhazBQbMB7sAu/ifxwGZ4SN7Xq33r9w0aSXt+IZYysd/hQOBHj3BoUnIdQU7DNeZii0VWGzFxNyJv4ENb3o8btm2i1wr9b2vH5UTfYo2v0qz+tZFF8Tmmjyr2X0c6E1Rbo5zoeQYut/kw==
Received: from PS2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:300:2d::35) by TYZPR03MB6954.apcprd03.prod.outlook.com
 (2603:1096:400:285::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 8 Jul 2026
 09:35:14 +0000
Received: from TY2PEPF0000AB83.apcprd03.prod.outlook.com
 (2603:1096:300:2d:cafe::67) by PS2PR01CA0023.outlook.office365.com
 (2603:1096:300:2d::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Wed, 8
 Jul 2026 09:35:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 TY2PEPF0000AB83.mail.protection.outlook.com (10.167.253.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 09:35:14 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Wed, 8 Jul
 2026 17:35:12 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Wed, 8 Jul
 2026 17:35:12 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Wed, 8 Jul 2026 17:35:12 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Neo
 Chang" <YLCHANG2@nuvoton.com>
Subject: [PATCH v6 1/2] ASoC: dt-bindings: nuvoton,nau8360: Add NAU83G60
Date: Wed, 8 Jul 2026 17:35:05 +0800
Message-ID: <20260708093506.895481-2-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260708093506.895481-1-YLCHANG2@nuvoton.com>
References: <20260708093506.895481-1-YLCHANG2@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB83:EE_|TYZPR03MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: 74de3183-2f2e-4fc5-5309-08dedcd436aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|6133799003|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	zs+FnSzyBN49g8JztBXySILApbK1LESiSI8SHeXQ/nmkIZVnAe/4hhjAVE3E8HFM87wqRXv+LSdwebCgpcsDRdc9tIpofUaJezi1rltZLdUMfTBDVKqppWvYwi8rhltuDP3npxKH51Lue9aYCpPdwVJGkIol5jvF2zLL0ZpjgVAfKYAbTVzLRS38fy4rmCV/ItV+yaHyJs7oV9TSvJld1SFNXrYLO/jVYC6fydy+uKY3PFW7vYRAnWJGPcxllaG0Pq596WhNOeldt6NYK6uPhMg0F2ch1pGULBYoLKPcLnhJ8lIiD5B86C8J5U2W+VgzDpiS0+OA6pcGrarOLMe5s6Bpinwe1kmlWdHeUCL9KETq9RHsU/7F9TJp/IzqCeY85be2GyyFzIGB/5Pwn9iNP218D/IfzsMEPZ/bzx9gIc786IvjO/KQdTb3dqRLlLPABSM95Q3pNZcHcMYaZh+sutQr4QvUKSVNleFRzqTQTG9d6tn5CMiaEH9LBCNsQnIdgL+BkjEddRQGcx/9Hl3VDqb1NOio/hjbdnM2Rx6G3dVTurGV6oYMewgUlpd5zIAq7Ts5A7+EeW2OtO1VUQInL3UlDFZ0ZuoieYqh6zG+XBR7HDHOJ5DCJe77ffPMXY1uVEam0cjzCQIhztxtRz7XaA==
X-Forefront-Antispam-Report: 
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	bjkw1PMd9dr+CslcDd375KLLQe1KkLs+KWbEaA5dQFBdwahm+Owkrv5yYym8+tQy9qUsvQ9tIJn5jpEf/ivuW8U7Z2SKCMd5bQtqGsRpAYoucaCc6Lf2o6jzoHO2rLf2TX7aBbATbXEW+FNkJAIrugXJGAA1pyqk1zFvcv2GtbD33P2bGoEntzWpHxaRoGvlGydE51BfB95KfEn3RFFMdEF9XgdwzotASxEkITZ+v0rbddb23FXTLE36kzz7velehyuN3cO3/b9n7el3XAb8Usmb7jQM5cX8Bm3saSC0LUhrF+DPq4cBe8jV5Rtks+f+dF/xEIvjLU1D5WyeKBnyNPCKw/vsJ931RkDOD/ufAvOPnOoxxh0xhyXvbZDPG7Gyam46/P3MG6/pyDC+/QIazyhX2YsL7IUrDVBSPNKePxHR93r55htZGcO/Vv0orpdT
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 09:35:14.0543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 74de3183-2f2e-4fc5-5309-08dedcd436aa
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	TY2PEPF0000AB83.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6954
Message-ID-Hash: 7662VUX67RWKW3WIETPVTOBRF2V3OW6V
X-Message-ID-Hash: 7662VUX67RWKW3WIETPVTOBRF2V3OW6V
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7662VUX67RWKW3WIETPVTOBRF2V3OW6V/>
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
Changes in v6:
- Removed '|' from descriptions.
- Add firmware-name in required.
- Add "nuvoton,dsp-tx-slot-mapping" and "nuvoton,dsp-rx-slot-mapping" properties.

Changes in v5:
- Remove the detailed datasheet information, keep only the valid I2C address enum
- Simplify the firmware firmware-name items definition by removing the redundant
minItems/maxItems and moving the channel descriptions directly into individual
item entries.

Changes in v4:
- Refine the `firmware-name` description to clarify the loading order
 (Left then Right) and the PBTL mode behavior.
- Remove the "dsp bypass" option description.
- Update the example node to follow devicetree coding styles.

Changes in v3:
- Remove colon to resolve YAML build warnings.
- Fix 'firmware-name' property definition to comply with binding schemas

Changes in v2:
- Dropped the word "driver" from the description.
- Removed runtime/software configuration properties:
  nuvoton,low-latency, nuvoton,anc-enable, nuvoton,aec-enable,
  nuvoton,vbat-microvolt, and nuvoton,tdm-channel-length.
- Added missing "nuvoton,dac-cur-enable" property for static speaker impedance matching.
- Removed unnecessary '|' formatting from single-line descriptions.
- Fixed typo in firmware-name property.
---
 .../bindings/sound/nuvoton,nau8360.yaml       | 113 ++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml

diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
new file mode 100644
index 000000000000..3aa3df0bcb93
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
@@ -0,0 +1,113 @@
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
+    description: The I2C address is determined by the hardware pins.
+    enum: [0x1a, 0x1b, 0x4a, 0x4b]
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
+          Left DSP core firmware.
+          In PBTL mode, the Left firmware is ignored and only the Right is applied.
+      - description: Right DSP core firmware.
+
+  nuvoton,pbtl-enable:
+    type: boolean
+    description: NAU83G60 supports PBTL mode for mono output.
+
+  nuvoton,dac-cur-enable:
+    type: boolean
+    description:
+      Adjust DAC output current to match speaker impedance and prevent
+      hardware damage. +3.2dB when present, 0dB by default.
+
+  nuvoton,dsp-rx-slot-mapping:
+    description:
+      Configures the TDM slot routing for DSP RX functions.
+      Each integer assigns a specific DSP internal function to a TDM slot.
+      The indices of the array correspond to the following hardware functions
+        (0) DACL
+        (1) DACR
+        (2) ANCL
+        (3) ANCR
+      Assigned slots must be unique, except 255 which disables the function.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 4
+    maxItems: 4
+    items:
+      enum: [ 0, 1, 2, 3, 4, 5, 6, 7, 255 ]
+
+  nuvoton,dsp-tx-slot-mapping:
+    description:
+      Configures the TDM slot routing for DSP TX functions.
+      Each integer assigns a specific DSP internal function to a TDM slot.
+      The indices of the array correspond to the following hardware functions
+        (0) AECL (Acoustic echo cancellation left)
+        (1) AECR (Acoustic echo cancellation right)
+        (2) ISNSL (Current sense left)
+        (3) ISNSR (Current sense right)
+        (4) VSNSL (Voltage sense left)
+        (5) VSNSR (Voltage sense right)
+        (6) TJ (Junction temperature)
+        (7) VBAT (Battery voltage)
+      Assigned slots must be unique, except 255 which disables the function.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 8
+    maxItems: 8
+    items:
+      enum: [ 0, 1, 2, 3, 4, 5, 6, 7, 255 ]
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
+        codec@1a {
+            compatible = "nuvoton,nau8360";
+            reg = <0x1a>;
+            #sound-dai-cells = <0>;
+            firmware-name = "NAU83G60.kcs.bin.l", "NAU83G60.kcs.bin.r";
+            nuvoton,dac-cur-enable;
+            nuvoton,pbtl-enable;
+            nuvoton,dsp-rx-slot-mapping = <0 1 2 3>;
+            nuvoton,dsp-tx-slot-mapping = <0 1 2 3 4 5 6 7>;
+        };
+    };
-- 
2.25.1

