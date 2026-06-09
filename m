Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9B0CD6E79
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2026 02:42:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF597601CF;
	Tue,  9 Jun 2026 04:42:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF597601CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780972965;
	bh=QL7fiM4Rg7dMMbB0VUzMRc7gRxOBeGVjzEduCsj+5T4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=eVH2HUT+AgdUikbpCVhO5+sKaLxEXiGsvQOTn3qSxDVbSGHLG9kzMxPnf9Rt9IdY+
	 jM8k8g6jmjMdj2Gf7+m9u84L0NQiihsDq9nshR4fl9nTGEbD7hqvyAqysBTTlkaK4B
	 Pfvvaeqk4sbgGNi0NFPZc4ggwzJ2Q5+F3JvzsF08=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DC40EF80615; Tue,  9 Jun 2026 04:42:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 97427F80613;
	Tue,  9 Jun 2026 04:42:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 47F84F801F5; Tue,  9 Jun 2026 04:41:57 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.61
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1780972914;
	b=igFgIWeOgWZxD/JLG28a7s2FNtoXmFzr9TRsZw5uMVEu4Kf0rCWPymqUg7tDelnbX8BO
	 KLV7o2dM28hYIIzG2QNOguQRyJrq92y51ClcsrHB2wNb0suwBrh/iBnhQ0Yc5GJ0PkXmy
	 xd6gf16KWpl4McnbwBvdiPXIp2sTSPFP+QiixsblhPiD7iSj9sjh82ercrU7Z9b/yOnbt
	 oxKMYBYRyL6cUGutvDArGzvOEWnvkzQvMIUGu+xngOTq/UJBypqPBh+hMcqqaxDCxCtK6
	 kDKJjYHMWrcHrUL+6HmwX1P2DGG/IlgfSU80apSelKFdEWbMq/4JXEb32D+VbfsoZ/Q==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780972914;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=QL7fiM4Rg7dMMbB0VUzMRc7gRxOBeGVjzEduCsj+5T4=;
	b=p4i8qpZY/SuEHm6CmRW9O1VRx8jdavUFE2wEvGUxsmkEuCixoknlGKDipbsVbOzrYDrd
	 ZUxEESInfyEKpt8PDJsU2Dlt+k/+pHyUEczD3+q5TzoUGxI2hUhGNOfKwMgycJcBgMw02
	 pwMl14haWjmJUkHGLA+k1rK3X9m3a3WG2/FZxVMvuUvkOJ01e3HfD4tPh9Ztm5CrGxEfI
	 PaXqznSaP23PVWodmdNYuIAYe3iK7+RTl4KSzbLmXgYIBh8DRByU93y024GPU4DZfzwLa
	 bCorz5x4ALcvCfds/drfm9mU1lVW3P0/CcVw7L/V6YMMZb/2IS12t35yQZ3y6QImP3w==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=iP7zim6+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.61
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11012061.outbound.protection.outlook.com [52.101.126.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E731AF801F5
	for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2026 04:41:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E731AF801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=iP7zim6+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fzFQtJ2MVAVRDX6kMpMl9BlODLRl61WwyR/Tjf3aUP0/lOMhXc3c1I88+X5qcXTmDEP709SyIgSmbHmxHvpVdmP3lYfIDUPmXssUYjq4ycCDgUTWDqhXRofSOFLoHg7r7iQuDOzY7dynsTRphebdDIyScD6x+NztLwkkNNGBKndzj7LKHaNU2s1NXzziFGNNX6vC5d1jydDVVhY7FAdD62LpgfqqDVxDoM8kfxIU6yeaNutiwho5iK7Qu4T8767yDgAi55LkLLBkgdDN+KIuPQ5+AJ+16tqRQ2kBZ7Sc4VWNeDp0OV8zILevlxPQXNHTb+JoIVN/bu5APFtMHfs0yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8hrTmPRv+NqkBwPcrOjI6rbL8MTldOupruJyjkCLeI=;
 b=wE6vxECAhY0gQl/r48LVPv1PcnE3WWrIIcgJhXZpvMwmEbvTkOF2hMG9XtallY3eGVcqzykTRiPd4INW0ebDNaS9+/K7FjCPbbZo4mAY5XKxDWFUvD3fQttJ6FC0C3seGPpf03GN8db24uW6hkUN1mVWZGmpLsLN5JvrQ+pVcLOh3/3u4eYr2+kyVyNdwC54ipqtR41J6TLhf1HnWvhavG2IrwdZotPBjbPy5tA5Bg5u93pY8TwmnTgaC3S4u/4uX+g5C/tmxaJNc/bM8XMO4z5V4OODNXf9iMcsY36+g+p+8g5DblTFCz8MZ8Ch8eI/nU6lfmh6sBWtVl2psfJ1ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8hrTmPRv+NqkBwPcrOjI6rbL8MTldOupruJyjkCLeI=;
 b=iP7zim6+5v4QS20CLC7X5BwH7rS0JO/DbGMnatjAjTzn+xI5fPQGZKrBcaZFvLUDWphXl1jr6rBnqZ1Z+H8etpd09taNDW31yIRh3aQIg6jYkytA+mZ33lmBxzbSeYpZCUCt+RcthUmKk2m5EC3r9Bp6Nv+uSZS9NAzyWORP0/H7ypKUNMlCp1qot8X/pCAjrW0ow1YGl6SzqrVcovx5c+R5DlicJ2ULafAX+u2oeEW/Koyjsj5Rb/sj2Cv0phAZWvwjjnJBpvD6fdX4ubLEfuFnpWQLtzaDaLtu2ltAjhW78H9Wug5+zpwhzNCL/7Iy1GUMa2ZYpVra5y4p71eyiw==
Received: from PS2PR03CA0009.apcprd03.prod.outlook.com (2603:1096:300:5b::21)
 by SEYPR03MB7435.apcprd03.prod.outlook.com (2603:1096:101:13a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.10; Tue, 9 Jun
 2026 02:41:43 +0000
Received: from TY2PEPF0000AB8A.apcprd03.prod.outlook.com
 (2603:1096:300:5b:cafe::27) by PS2PR03CA0009.outlook.office365.com
 (2603:1096:300:5b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 02:41:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS02.nuvoton.com; pr=C
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 TY2PEPF0000AB8A.mail.protection.outlook.com (10.167.253.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 02:41:43 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 9 Jun
 2026 10:41:40 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Tue, 9 Jun 2026 10:41:40 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Neo
 Chang" <YLCHANG2@nuvoton.com>
Subject: [PATCH v4 1/2] ASoC: dt-bindings: nuvoton,nau8360: Add NAU83G60
Date: Tue, 9 Jun 2026 10:41:27 +0800
Message-ID: <20260609024128.585938-2-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260609024128.585938-1-YLCHANG2@nuvoton.com>
References: <20260609024128.585938-1-YLCHANG2@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB8A:EE_|SEYPR03MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: a27d7b71-031a-4307-ceef-08dec5d0a434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|11063799006|56012099006|3023799007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	exp0wJulHZyPfuuOs7yc2AKKyZkyv1XYNIAgbB6bcQ4nHpnyvty9HjeAHw6W8iL4z3g9KjImEya3jhxM64Z7ki0uZxd9fi+B6Y4Pi1I2fpQ9bmThgOWNZVccI1oJbA4OOlGls5xVVu08TdSQOAALnSIcu+8Nh3v6x3PrMpLR6yLJd+PdZn1h9Xh0aRBcFJG6uo7hvi667ivdxCZSQIyye5Pa5pbrUrBJV6A1KvGCzX0IxKYVPTYvunt7YJc9rfwBTL6bbmAd/STDMtby4npLDIxYUDnVcfEQumwrx1y4HUsTQMLe/seSBBwT9ttHrA73MntQUocS/s7k0prnl4l6HhY6ZfMf9K31Q0KFe85R33eucNKyuL9OFMXprhzn+9Sfs6zOdvKhNWBhB60oTjRrBUN/kTlmOJz63n2bi1K5hzRdKBTSER4QVyFyKoA1ux20dJ61OZPeGoGXPXOTj4y8qEqBjjogFYzrlYQ+O7Ox4tWl8wlQuM6VGGHpV0JqwsuyN6GVnPZo7Y2Zqp/0DnDgry8QloiYxoYYwf1QHCrqqJSw8vEFAQTPw+l9TR2yEoo2cfkvr8F6xSLEgGFw7Gt3ktuqaEc17WhvCrLVTlEIraJgXIgXG4qgjiIJpWJJ4SsdW6M3yczY//sDISRBuhxTREDl+vQng3+u1RhKEh9IN6pqa/P4FVvlSwx3R7qhX9rO
X-Forefront-Antispam-Report: 
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(11063799006)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	u7m6AWdUjwgA8+6xrACDI8kx7nQmOrOSkkJbKH34YEYiXAHlA2jyApML2awr93utMAi34WpjoEzyXdr5ZU2x3t5YJRaMoNy7n7+5rs2km9db51QN5AYSeEoz5kvdk9g4RY+o+oj1w7C9c9B+eiWpr1CJu+8U7YsmfaFBHqZZvm5Z7W0OK1GQGX1WhIzVfweZ6w6X2SBqyixeepFi9wHv9UAGPGpRv20OL/mA0T9zrXsKrSvzqwoawWyqnCSF0yCqWoNL3tIHGT4FPxIPt5Gb2rY9QG5Iqzrkl23eUkak5IVxHLZohXiQk6HUMtVs5yUzCMt+uFK5Q96CseG+tPyEI6Brn9EEtQCJI+zHrws/S1s0dWr/NDE3PE1y+tFxhFbvgPjeNUJ37JAzVIUsokuxJOFqfHltpwFQTVhn5tlTI6g/RigQiMXLqGZlzay+7ys7
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 02:41:43.1050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a27d7b71-031a-4307-ceef-08dec5d0a434
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	TY2PEPF0000AB8A.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7435
Message-ID-Hash: DXF4DFV4PQYLGALFPNYJACUM3NS4EN2J
X-Message-ID-Hash: DXF4DFV4PQYLGALFPNYJACUM3NS4EN2J
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DXF4DFV4PQYLGALFPNYJACUM3NS4EN2J/>
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
 .../bindings/sound/nuvoton,nau8360.yaml       | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml

diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
new file mode 100644
index 000000000000..2d19aedf1419
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
@@ -0,0 +1,83 @@
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
+  firmware-name:
+    minItems: 2
+    maxItems: 2
+    description:
+      Assign firmware filenames for Left and Right DSP cores.
+      The first firmware is for the Left channel,
+      and the second is for the Right channel.
+      In PBTL mode, the Left firmware is ignored and only the Right is applied.
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

