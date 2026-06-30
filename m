Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA16C43327
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Jun 2026 02:16:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 38DB260200;
	Tue, 30 Jun 2026 04:16:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 38DB260200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782785785;
	bh=86QkZaoLveBOEkFOT78J9dX72lB2YN6EWMQn901778A=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=SAbyJEGr2ua/22WGQGGJZuq8b6XwPtJA01g7Mym/rFr43kVmrpI07pvQ4truVp+o9
	 6YdbMUZLZ6+mMJ49OJ+MdQWGIc+OwpVmCyM6Maq9ihai5i8kdPxge8XL2zbK2bPwY7
	 No3UkLSVB81WJZenqJ3uL/BtG9pIyhLkPjAKTvus=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C3F04F805F6; Tue, 30 Jun 2026 04:15:48 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D2D2FF805F4;
	Tue, 30 Jun 2026 04:15:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6636AF80423; Tue, 30 Jun 2026 04:15:39 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.68
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1782785736;
	b=H93ynKZDPnQuPxkWSzwtuk1HdwXe7YVc10Op0gc/KlRLlRtCsCzlv6xy1L0vimgdeUzV
	 kwLqhvgvP8kqvmYAlhSl87sJ/rY+Oc81GC3rFA5c/54tOpyZHiAW/Ghr6bt8FcIojkIBE
	 8u91/N838KaeenfXlJna1gRCqMTbNLStbAUL1S6iLHx4ickBOzsoVmx8LEdSjUsuQ4P49
	 OFbNNTDq5eU9glZsvyhhFxoyLuhwMsvouAUIDsVo3xLFY+FF9gJviaxX1P3d9f0THHA0h
	 gNUgHRJMHAHpW7MBz4g4ICW5KIejD9ht1JpBLnUikICLKMdiZZKb4LypnJOAioMcQGQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782785736;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=86QkZaoLveBOEkFOT78J9dX72lB2YN6EWMQn901778A=;
	b=HYWCZ6/G6tHQvui8MXvdOIOQFEIt9g6hstyyYeUE+ZTfxi6WjkpFw/CPd8lRh6PEcWib
	 SLiuduHAUpled+HYok1pET5XSTciK1jInKmBkAh3fHxv5y1UQvuRSodwHqFplHFZ7X02R
	 QekVf/yCIawu6yqp+sqEiexWrBUUrWkDR8iznMXCCXWUwys43vI+d/JutQG34YMkh7ain
	 RqS2HsyFR0K4R2WIqyEib15bjqm5kRKC4/063r4LGzmcHr+GQLpcMnI2AZ3K5BnOOvPn3
	 +ErNRoDGUu+bCnQg0qMcfg5erjRrf4j+wKAsMJhJc9AsMwgI0lUCnOSPS+xesy+8nPA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=lxQslqcb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.68
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11013068.outbound.protection.outlook.com
 [40.107.44.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 08E8BF80423
	for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2026 04:15:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 08E8BF80423
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=lxQslqcb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5MSxyrQnSy6qmQ00BBi+tG2tix2sh5tT/CXnNx1aZDCFX213Fin6uNaj/1h9FQyQAGndrKbvm2Pogw0rz2e6dQCo6UzP1gbh0NbH+E9UzcyHwsQChuxjIBsxTSq+iQAtpyXrKQ/fWkuCvgnRNTmVjPNVlCICevWaQvNEp23+X7Kwsx6GPhcaU5v4/iVdhpRyjdNOyzDtzLz8x4Z3Wq8akvhXkCzr6hn7Gs9B1rmLvkXl3wYE6zYQwx+VVatwxVZPFktGmpwReeLVEtQEzJVRo+M+wk6hJ+dfwacXOqNer+VbVbJWstkPbnbHAh4y4yOFFFRkjpCG0ejEk0MqjIv4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxiS37uCS/2LtAgz2fnZTdroD4LUjts2dALSYZzhyhE=;
 b=j1sFV1rw6HExFF+Tgd6CY4rPWxZvXabCXC6Xhd63dY7tve5xsteoGDWNnL0adpDU0TfM7zYoMb4GFKsAHL+KPRNR5DvHqiIFUIPjGQYDCo+jsEIWMS1Ei9owG+NH9DUr64nypMUPYV+vGmND0RnnhwoYyEk0mAqTLJjipHSeSZQcx1mmEAzSMOVoMvPiLEPSnjn1wttz8eWbb0U4c414PQSRRskhmS0P/jZbR62s56jOsgfa3L/rMDjPT3vXP4iVSGtzM228xSge1ScHF8Wzgyt8V7YAwVL92GZVLsrSaUVXOymni3jBUKZzmrws7vI38yZ78AYOeAU0H2ubVqgQ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxiS37uCS/2LtAgz2fnZTdroD4LUjts2dALSYZzhyhE=;
 b=lxQslqcbKlsO91smsq8BCwkdhXdd7mxYkNOTAt1B3aguXeLi6s5MUQOg+JIT8YfUZC42XNmpOgCFYMvDtbaRA7bWe6OSQ2S+V5l9OmLMhlf8p9bU8+ocqL0WJy/OJp237N5qJhF2Psc8ar5J49E12uaZC4+fPAVwskxPOUaSyflvC+fwhud26o61gvDJDbPc9sGqQtkuA6WUqmnIkC6hj1Lq2ar6HxnERdIwh1of5O5bBSv63tsIF6daRkGZxdn/o3lNsRnHGCtwcVsLTYeyyrqPlT5yXeYg/mmt9vM8y8DmOrm+wArUPtIret1u1iRkq0xabMTTamKmQFddn8Ox0w==
Received: from PUVP216CA0018.KORP216.PROD.OUTLOOK.COM (2603:1096:301:16e::18)
 by TYNPR03MB9845.apcprd03.prod.outlook.com (2603:1096:405:3b3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 02:15:26 +0000
Received: from OSA0EPF000000C6.apcprd02.prod.outlook.com
 (2603:1096:301:16e:cafe::47) by PUVP216CA0018.outlook.office365.com
 (2603:1096:301:16e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 02:15:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS02.nuvoton.com; pr=C
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 OSA0EPF000000C6.mail.protection.outlook.com (10.167.240.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 02:15:26 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 30 Jun
 2026 10:15:16 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 30 Jun
 2026 10:15:16 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Tue, 30 Jun 2026 10:15:16 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Neo
 Chang" <YLCHANG2@nuvoton.com>
Subject: [PATCH v5 1/2] ASoC: dt-bindings: nuvoton,nau8360: Add NAU83G60
Date: Tue, 30 Jun 2026 10:15:09 +0800
Message-ID: <20260630021510.821919-2-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260630021510.821919-1-YLCHANG2@nuvoton.com>
References: <20260630021510.821919-1-YLCHANG2@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C6:EE_|TYNPR03MB9845:EE_
X-MS-Office365-Filtering-Correlation-Id: be16e07a-9a66-4189-ef2a-08ded64d72f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|3023799007|6133799003|22082099003|11063799006|18002099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info: 
	57KMyWD5rSTn0L25OTF3Mg2uF8zoSKexD+PE2hkcYs8/tFIpdMYdmAAuov09t/jEaIWhlo5ox8DJQV/83Q/l3NJyVFXCYpoY/vHkhG40BXKAa5uJuzVDNM84AAmO6IfTVTpePrPY6cfcJmIE1GonkXXT9KgCUHmAnND6HDBrd7ABsswfJovdoeFl9NGzmA4bgpETlLHvByaRzcmgAkoY3tfHH3PdWTefVPovvhdqhJ/aOmhVK1zXHoIx5yK3nxNtP9gkRt7xR22/O31xP+I4Qbc5b1zZygx3zkKf53kAJ+Bm8PJN4PtBam5iiagbben7giBFjeUK5juwiAI7Ei3KWp3HZUJ2KObWUKS72CYWqm3xsa6RFsgO3gn+MWkYiCYoT2pFXSQP+h4W9CUdoTePb6/tV9of7GpENw+tnlxpv10U6CMLtHPcLj2ShJYUmk4GxttZx0aqXbYeE4TykYt0eZd7nHCjKEE/7/P4IbNTMNHpKP2QYi05iIqlxrWFpcWJBFVhiU8b9gKhwXvCUlkwKyRITlVJJVH6596Y7ckJ6t5+AKBZxhIywwgnwWqNXlMK03S8qAuQNZGOUPmeWghKrygFKV2t4ewsBzLjzZn4H5FfgdBih/2jhJAhrmFoCV1IAeAc7+0Vj/W1RBFh94517w==
X-Forefront-Antispam-Report: 
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(3023799007)(6133799003)(22082099003)(11063799006)(18002099003)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Ip3vmHrIoBvTd2bDPobhst2Z7kpdwKN8lCKmQIlQYQ0naVwiLn8YWZW0Yyy6J3Wc4sIbKEWcNmwB5KfVhVVW0mZCR7W1NzkqZiRQS+i6xQzociq1gnrtkE3uuUsDmscJa6Rt5iZvG7J+ne57ymk3jCyWqCXkPCsXRbwBasjhzRnu/jwDrrLywWpA3CE3te/bEa2DAgOo4ObC3JVjjoxeiJhJpR1MFhBNWzZeNSvmZux/bpmu3duWeIjCf0VOZrIf8JXHVL/q8OrfhVLbhlgFpZR1ZYr7SSX6fowFawKfRxOBfglYIdcCzIMHlGCHSDdAk3N1GvafHUm4HBmHJAjMuederNmLkXwm87D0i5u9W9vojy3Ytu+k97vlzfvSdbpy2a4LRq1xe/lp/+N/jBEaB9belrNSn/dJpn1CyBgmOjavZ6+8qqGF59ant8fPQhk0
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 02:15:26.1638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 be16e07a-9a66-4189-ef2a-08ded64d72f6
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	OSA0EPF000000C6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR03MB9845
Message-ID-Hash: FBDJF32BM5I4FYJMK734OF5IUVAIAA7E
X-Message-ID-Hash: FBDJF32BM5I4FYJMK734OF5IUVAIAA7E
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FBDJF32BM5I4FYJMK734OF5IUVAIAA7E/>
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
Changes in v5:
- Remove the detailed datasheet information, keep only the valid I2C address enum
- Simplify the firmware firmware-name items definition by removing the redundant
  minItems/maxItems and moving the channel descriptions directly into individual item entries.

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
 .../bindings/sound/nuvoton,nau8360.yaml       | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml

diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
new file mode 100644
index 000000000000..96a5fce12416
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
@@ -0,0 +1,74 @@
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
+      - description: |
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
+    description: |
+      Adjust DAC output current to match speaker impedance and prevent
+      hardware damage. +3.2dB when present, 0dB by default.
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
+            compatible = "nuvoton,nau8360";
+            reg = <0x1a>;
+            #sound-dai-cells = <0>;
+            firmware-name = "NAU83G60.kcs.bin.l", "NAU83G60.kcs.bin.r";
+            nuvoton,dac-cur-enable;
+            nuvoton,pbtl-enable;
+        };
+    };
-- 
2.25.1

