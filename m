Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CE2FAD3F0
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2026 03:41:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 59ACE601AF;
	Fri, 24 Apr 2026 05:41:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 59ACE601AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777002096;
	bh=glrxDe9efmfVOuwfMFcee8wItqq/ECj4s+qeDPJ11eI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VJ6wS1uZ/TSpoPlNEYV1S5dhaNmAeuSJ2A04bJRZ+AEceBPMciL6iO2nBZXKZnO9P
	 V12Zyb/AKVkhH0bF1yWdIghIES6+pUUuPBEAs+l/ZcHm2d0oFEQ+V3eamrm+AU34DP
	 JrQJLCn+83vhigVkaIoRAO4AMbY16lmP9yKOTR8k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 40B04F8060D; Fri, 24 Apr 2026 05:40:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F4E3F80604;
	Fri, 24 Apr 2026 05:40:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 722FEF8011B; Fri, 24 Apr 2026 05:40:35 +0200 (CEST)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11013045.outbound.protection.outlook.com [52.101.127.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A57FAF8011B
	for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2026 05:40:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A57FAF8011B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=VQG78nLD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PS/39Mp6aqRdvGVDiIc2wDaGJQ1Mi+5NFEyef9PmN/2QukBbcPn3ujIY8nOgP1n2j1NFRgpoDZ3GKKxI9eOHkMU/1GY77UOsoEhjbIOV+wuZ36kWmBK5L2y345NdvDmtvcabE0CSpK+aXu+zC3vVt0gR5wBhog3y7XHSGIfjYx5HwpfiUuwp4J+7P6QpMrYQ1wS9tfnflvXeA4YFBxaiGc9bvNu7ohSPfdt5Ks0kHl+gqp9/U0GIgIFK9oLEo8jgulBN85zXRRQS2WuTWKDxZUe5mWIQIj95xoUAJmW3t5Z86vXMO8KsOci/wA0recczeWOvpO3krMMFZY7kSMdtsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbMFzCej24nXfP9xWrTbS4GKBiHzBNNyrAf//cXa0PE=;
 b=lc53At/r1inj9Y5OLxfpngHAvBpcPSKBJ0yfbDwepp+vdjV/U6bepxTreqjgphvaF7q40Yve2JD2p2s7OsiRJ2xrsUvNq1MTE1NMf6maR6109vsUeMNSExF03BtHaM9I3MalaxHu0N4QPKrePMaC/h5WcKLMUNZGr5ASR9tQONMfiapt26T+buQlfo6j3Y46ZVbJaeV0NFapMwVke8sdFRRnmlil++xkCPR6340mSD9aG5Z4tA8q9Swv9UfaG/SlWJVaFhkO+4/mo/7NiKk1x1tgNAo2PDs9iqRxAhitKHHOgCyQvoWjvvsnZyn5WJM86Gn0ecQMDKCoGBcznqwHCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbMFzCej24nXfP9xWrTbS4GKBiHzBNNyrAf//cXa0PE=;
 b=VQG78nLD6C95MyV+Z/k7mADrRhWfKdmxtb0VA1QyPiwC+t0Sjvn8LmpOtNahKZ5fYqfIrdz0KhTRROtBpZRtjIQRE1xVafet1yw4nQxvUd2WGn8R5Q18bSw8Y7y9OkQKHNwryZJ5g6NDYx9u3Vo0cwdw8EMTJNYwhiOjThbWKe26/7+pvmZmcCfe9mD0iPKF/6IXhrTg36iOBqOBRbefzakA9g2zg44G4CsfyRiDDYJS+bgvyZrOeYkgNG69LbsN6wRYOnrcjwNZJGFSjIMdy0erTwjely/tS0AvLgIM+pcU1fBSQLdtW7z70aAF++ahr2rJU6xtVMZiX4qnYVlIPw==
Received: from OSAPR01CA0309.jpnprd01.prod.outlook.com (2603:1096:604:2c::33)
 by TYZPR03MB7601.apcprd03.prod.outlook.com (2603:1096:400:419::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 03:40:21 +0000
Received: from OSA0EPF000000C8.apcprd02.prod.outlook.com
 (2603:1096:604:2c:cafe::35) by OSAPR01CA0309.outlook.office365.com
 (2603:1096:604:2c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 03:40:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 OSA0EPF000000C8.mail.protection.outlook.com (10.167.240.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 03:40:21 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 24 Apr
 2026 11:40:19 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Fri, 24 Apr 2026 11:40:19 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Neo
 Chang" <YLCHANG2@nuvoton.com>
Subject: [PATCH 1/2] ASoC: dt-bindings: nuvoton,nau8360: Add bindings for
 NAU83G60
Date: Fri, 24 Apr 2026 11:39:52 +0800
Message-ID: <20260424033953.280520-2-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260424033953.280520-1-YLCHANG2@nuvoton.com>
References: <20260424033953.280520-1-YLCHANG2@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C8:EE_|TYZPR03MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: c185cb28-5c46-4b51-abee-08dea1b33653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|56012099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	hkrwehQoevdRud/aMWHtfcBBbgRTDcpFfanH9/RqScWqgySoGnG206rfsuZOwIzz1/5iAS04KCSvEHaSN8vt+PGr1ToDaZFMVD8St7xeJwt0naxniWBtwdt8HZFQ4HGlAhia0uyzg0B+qppS+wnjA0x12HLchEw0zpB05h63KyIcPYRXLJJ3E59z3ACYM+a0lO5sZ5NMUPMwoV20wHttbCYzir4GoFGnuBsiujaFG8GdG8S5VKpTBQyFU0JczY9XD/A+h11fRNvZEYGdXw3b8T2WDc3Mn9HkOFGITSqdwFPsBQW8M81iLD3yYF5Lj/GmsZ2mBI50Ongm2QxGLR5+tf2D/rUidvlgnrxIjyO2048JL19EL4OHHfrkxk7Pl8/H5gyO7jR8ATT5NT3S0Z1JNj5NqcCGyGWuCb8GXTXURSPdcEtRxyDgSwbyt566cjic6Tw9SA4jHSLgUAOsQS/Z1gXdf6iA1eFx6St7VzLKAcSN8xoUT9fHbskzOxZGgv6Wd+xDLIXvCFrZz7t4WJbvZXyztTATcLNWMfURdORNNcYWm5DHT2r8DVi/7IptTpei3FW8OlMmXiEJhmVZkAOk4gWr9uj2fRXJ4O14cFcrg97DtkyNThAkkh8DPG9jzuBJcB26kTijGlK5/i7EKkUaiMJQZtmx+dcB8Slk0ldp/MQpREoaeUycHmHMpfIsjJyS40XnZ3ReLdvFOhUzpGSm29/1f36ZcSCC56hczD0Yc9w=
X-Forefront-Antispam-Report: 
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	WNrgTVZDPkPIaySDpYS4+R5VlRraAplssxUrr188PLDIN2cP5R73XlQZgkNPtgGC4zTBwRKNvlXWHWrs71dDTdaz7jeha1Ac19i83Z70hx3wllTBfGeSMXL77phe+iKP/Yi3JI8uAsVZUq8CAugcMEdsnK4g48rnO+9XkFY4Kwcw7hgn6mp1dJzzDOOGhJVpHunPZttEoYhWkp+e49x3HrQapMwnBifyXLcYJROOxaFmqW7uiGuz1yuJ22YAc7tN11lzGWSg+dWi0enFw7XWiWnMyS5iW6P4m9SD34CGbDUHLMMz/gKhgRpoJRDBGjy98HUIoyy94X87hO/pvFjTY/s3SzkofHLRuMv++Iqxj0spUNgE+1y8a0nYFuu4+Vs56oTr+Asirz1t+yTiE1qJa9nwzoY4P/yHVFUZdhmHH8Qmr64k0MAiu+uEitHVhqT4
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 03:40:21.4797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c185cb28-5c46-4b51-abee-08dea1b33653
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	OSA0EPF000000C8.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7601
Message-ID-Hash: XM4UXOFPNNGF7BBI5TMBRGJ7RTREO5RV
X-Message-ID-Hash: XM4UXOFPNNGF7BBI5TMBRGJ7RTREO5RV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XM4UXOFPNNGF7BBI5TMBRGJ7RTREO5RV/>
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
 .../bindings/sound/nuvoton,nau8360.yaml       | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml

diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
new file mode 100644
index 000000000000..29b10155c4f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
@@ -0,0 +1,115 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nuvoton,nau8360.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NAU83G60 Stereo Class-D Amplifier with DSP
+
+description: |
+  Stereo Class-D Amplifier with DSP and I/V-sense driver.
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
+    description: |
+      The I2C address of the device. The address is determined by the external
+      hardware configuration of GPIO1 and GPIO2 pins:
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
+    description: |
+      Forcibly disable/bypass DSP path.
+
+  nuvoton,low-latency:
+    type: boolean
+    description: |
+      Enable low latency mode.
+      Please note the feature helps sensing performance
+      but worsens power consumption.
+
+  nuvoton,anc-enable:
+    type: boolean
+    description: |
+      Enable ANC (Active Noise Cancellation) feature.
+      NAU83G60 provides configurable low latency ANC path to Advanced DSP through TDM-RX.
+      To reduce latency, the ANC path only supports 48 kHz sample rates.
+
+  nuvoton,aec-enable:
+    type: boolean
+    description: |
+      Enable AEC (Acoustic Echo Cancellation) feature.
+      NAU83G60 provides Advanced DSP processed audio data as AEC reference through TDM-TX.
+      The AEC path only supports 48 kHz sample rates.
+
+  nuvoton,pbtl-enable:
+    type: boolean
+    description: |
+      NAU83G60 supports PBTL mode for mono output.
+
+  nuvoton,vbat-microvolt:
+    minimum: 8000000 # 8V
+    maximum: 24000000 # 24V
+    description: |
+      VBAT supply voltage in microvolts.
+      This is the analog power supply, provided by an external power source
+      or battery, and must be between 8V and 24V.
+
+  nuvoton,tdm-channel-length:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [16, 24, 32]
+    description: |
+      Assign TDM channel length.
+      The length must be 16, 24, or 32.
+
+  nuvoton,dsp-fw-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    minItems: 2
+    maxItems: 2
+    description: |
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
+            nuvoton,vbat-microvolt = <12000000>;
+        };
+    };
-- 
2.25.1

