Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B798BC61DBE
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:18:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 63ED6602A8;
	Tue, 25 Aug 2026 13:17:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 63ED6602A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787656685;
	bh=O3DPLmK/UR9wi0ynj87MBRI630IoFY0A+jZMzcAOHPE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Lz4QbQitYsfNW/C74fvdv8oiRiOqISirlSsB7j/ZH5P+9jaShPUVnxyu2yVVKJ5Kq
	 UaGs0/p04I+gJwmmfWjSszMTkzNl58eGIFvNKF1YHTnc3RTklRswYR92zZVJvrtU6U
	 fPChEYo+2ghpp0ZomGWMskGTaJ7UYHv6pZgtluOU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D5380F80600; Tue, 25 Aug 2026 13:17:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 702C1F805EF;
	Tue, 25 Aug 2026 13:17:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D2460F802BE; Tue, 25 Aug 2026 04:17:03 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.56
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1787624220;
	b=FIbQIqTL1H3ilHAr5hyCRry1uETpRjBvMDDRLTEV2QB2M/dK2AJnOkmKVWjZ01AtR/tx
	 n2bNd3y51ajuVvYQpg4pLAEyjvkW+e8+AKYdqYUYpEUA7gpFj38kUdRBo8mNY9fHALxM3
	 s/JGdShHuJU++BfN9pYW4d1MBSxxlHBsE9w2i3beF1Y4TutMCoVjTa2oTRa/wJ1s//X+M
	 Ec+ebP7pjdyV0DuQ6I+d0L1AZTxlx3Kup2ktBsS71AbvoPrzsyOfbto2DQSqyRk20up6F
	 lV/aqJ2lYszwIsCCBkNLCns767uSXcpLFVS/MybITDuManaPMkO1XjkNZk621y8y2ow==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787624220;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=O3DPLmK/UR9wi0ynj87MBRI630IoFY0A+jZMzcAOHPE=;
	b=jWocadTkjV336WHjdOy3nfdXjqtQvjtXM5uLReIhB5nQAXm4hx+hP/5PgxhEJu/qwK4U
	 8yoiimgs9+4RXq8KIcWPPx7zPIFzmSkWC87NbUs8ncOPbGaAvwaAZQzdInr8s+irYogA6
	 FeGyyTCBY9TDAvx8PNC2Nfczv3ELwWvTFLjHcUNBUSUzb3gLvR2FKXMU6BauBkZodP91H
	 /5+yNCHXGmlO/UAuO/3KWWXnjD3Fv1iSSPoD8CCmVOhiTD5/CTryrbSHPEnKVZaNHazPl
	 /kYzaUBTsmQMx9g+lp3WWnIEv2EtlrEQI0qPzMIBqGV8lEz+ctROVdg+qfsT6T2aP/Q==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=ZXJ1wopv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.56
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11012056.outbound.protection.outlook.com [40.107.75.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2FB0FF80185
	for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2026 04:16:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2FB0FF80185
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=ZXJ1wopv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUmjkepGUj0b5qy+SzJbhf2rY2p+qtMgMigGrotVyU8TiWzKuCihLsSXcatda/nlri2EI+/wT2uxk/WLK9v7kP8rRSJZ+whslWgMQtr/kVc0t8qfoX8DjywuF40ksQLVoNt23bPycDt3mzPskd3/804iAHLThU1anY+cWrx8q9REJ0Q0kxtuFvQk/1WiTmSF/u8QHwGZ2uQ0QCoROaCf4/TY/cv46HGJfwDzDHk/WmL2/WOBjqvsTXYamYrq0sI4GRt+b5n7bti+ny1yHBWkVSBoURHU4a89x1w+Wu0/zAFliphNee2f9IxcmTCWVGRLdXypFgIQmAcCYdwB6KrAvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dozaAEMvDNqbyYuBLjYXmZkSw5iRPKf2/z+UhZWuWa0=;
 b=UqB9wqht4YymC+c+MVYOO44tlvlktZjdVtDz6QoLs26sjJI/HncVUYZdg+f+7KAV+O1Uflo/UMlBnYoIKQp29eKgUEhZa1BCfNKbUCwA7sa6nWS5ZyyW3XOnFySB+zrtDVtH2WjAV9TUxYAftz9ik0mcoUVWo21XG/k2sgsZyObn9pEm63eZBnkR61ma36YDJjFYrgszhiVYynLWQ8yA0pWOs1QD2xZ+zY+la5iKSCRvO0iVBqpoFLy6opzUeXh0NLFMgrSB31j7fN2P1EnDPIRJ62G9OH402lQw/I30yxL2VeEdkC8FtYs7WDWOQ97JL5f6spLnJMy6dJoFQj97sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dozaAEMvDNqbyYuBLjYXmZkSw5iRPKf2/z+UhZWuWa0=;
 b=ZXJ1wopvqsd2WEDQjM2a7OF3g6PwWizS+e36bUzBluSh8vl4vi9LjX86t+fUEtD0erIgJ9TkS9doN3d9HRmIoGB9hpw+B8/gPqPacc+miv+Y8T0Xt/BtGVWnUypsD6r5eavQy+RA+UocuWm0EVsHxNyjMe4KXIEaxhM6MRhp3aA+xmOAksaLvfIgU17rsZe4PyzUTA3HM6G2ey6hbBMjKypJVSOZbyIM8yteG3HpvPvSOHlE+KbnDHRFzCDtCPWEcMQQNT/GnIvswPfhbkRJOAom3qtRqY9cGExK9p43krCclVtl7RzpcwWEF3g9cI8z8AYn04XkoFY6tcRx6iTykw==
Received: from TYCP286CA0276.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c9::13)
 by SEZPR03MB10259.apcprd03.prod.outlook.com (2603:1096:101:33c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 02:16:49 +0000
Received: from TY2PEPF0000AB83.apcprd03.prod.outlook.com
 (2603:1096:400:3c9:cafe::6f) by TYCP286CA0276.outlook.office365.com
 (2603:1096:400:3c9::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 02:16:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS02.nuvoton.com; pr=C
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 TY2PEPF0000AB83.mail.protection.outlook.com (10.167.253.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 02:16:48 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 25 Aug
 2026 10:16:47 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Tue, 25 Aug 2026 10:16:47 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Neo
 Chang" <YLCHANG2@nuvoton.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v10 1/2] ASoC: dt-bindings: nuvoton,nau8360: Add NAU83G60
Date: Tue, 25 Aug 2026 10:16:43 +0800
Message-ID: <20260825021644.1203076-2-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260825021644.1203076-1-YLCHANG2@nuvoton.com>
References: <20260825021644.1203076-1-YLCHANG2@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB83:EE_|SEZPR03MB10259:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e866ec-4dca-4ae8-600a-08df024eeb7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|376014|7416014|1800799024|13003099007|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	9QaXrIScWVMogJbs7+iwXQLdBPazVH+yrgFSeWLgArWX5n+2beAk7EbXoMN7BoJBKvhC2RvjcQ4aXDa11tyZfJFKYBvucHIwBmIUX35GCLHYHnh5kTkoOL3sVuTtzrEbkjWklgAMPex9zsOm9/k8vuHrZsRUubwLrJUI+O/sdANfDgSaNEm5lh9oXyecyk3AlaK4FdBM4BlbpmCfE/dt/ZvhxgaX4hyqnCHwkzi5QhBJmg2OzseKFlkyIw7MfkQScYiuFKxPwKt1wwPY/rb+9uVaiMgQQmmK6aOKghwZu8u9z8AbNX8oma//L978guwsD7/ektMjb/gdM4JHmz1zElTPUNkitrZOOSbSs4ZhoGiaG3A3uTCXcuM5Aq8b/DA31aJGpusw8by9wejhDzQNo8tROr8oZPDpm5uhyhln9Ybd07qVcm7uMgXxv7/VvD5HKJKdTreR88TcvZfU6qFgJg2OtgJNqBtfDQm+t04O4jgjvBPaXcbvlDDukUGR9IRGQcfG3e/u0s4fCloCwvtan4v0L8dVwt/FwUyx4uJ+APdox2S1wM0WTLNuBxTjwXOkJDjXWdNMVnRYrldReGOi2ye+QgUMejDry8w4GDN4xvE2TH4XeyQCqCMSBiqlhiZt6MS4fdwzrpMgEj4r4ahR4w==
X-Forefront-Antispam-Report: 
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(7416014)(1800799024)(13003099007)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	r7aat6oBe8BhCRsPVV4Pltpz1uet8Bscc571O54s6WtfWlyn63AFngx2j3LVCHrBTtdgRkGTf2LG5FXKus/u3zy0tAah7S8hDRRMdRiSvnCLBaypDpkW/1THOOoUtRXpGeJ3IxhoE2J6866xpq/mbgm4BRmBhHhfaliichl4usgbn7aQQGIy4vmMktDQZnFImhcBvV0n9nguD8Vnx0Sxnk7ioQ+i+bUovP6dls4bZjYF2/Ewv6JTrPkMNXufsWuyyx4ruyQz3ZqgIZaKwizR+4FS594z5PN3jyaGXnygRW5vHHCqUTPLK5GggJhhRXeiuyIRiMS2cIXJfTsPYbB2fmbnEBSaZINWsQ/O+xJjj/Pt+Ll+TgCVZx9c0E3lfcJlLB9GLHepFYdUk2RZ2isdLPVvfebzYGd/fStzZYJkI8Ap4E75ztghF4OQ2zU6SsGg
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 02:16:48.9994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 81e866ec-4dca-4ae8-600a-08df024eeb7a
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	TY2PEPF0000AB83.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB10259
X-MailFrom: YLCHANG2@nuvoton.com
X-Mailman-Rule-Hits: implicit-dest
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
Message-ID-Hash: 7GGSCDYYU3UNWI6AZMWBHDSVKMYWDDSD
X-Message-ID-Hash: 7GGSCDYYU3UNWI6AZMWBHDSVKMYWDDSD
X-Mailman-Approved-At: Tue, 25 Aug 2026 11:17:22 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7GGSCDYYU3UNWI6AZMWBHDSVKMYWDDSD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add device tree bindings documentation for the Nuvoton NAU83G60
audio amplifier.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Neo Chang <YLCHANG2@nuvoton.com>
---
Changes in v10:
- No changes, added Krzysztof's Reviewed-by tag.

Changes in v9:
- Correct firmware-name descriptions for Left/Right DSP binary requirement

Changes in v8:
- No changes, added Krzysztof's Reviewed-by tag.

Changes in v7:
- No changes, added Krzysztof's Reviewed-by tag.

Changes in v6:
- Remove '|' from descriptions.
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
 .../bindings/sound/nuvoton,nau8360.yaml       | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml

diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
new file mode 100644
index 000000000000..3edab944a4e9
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
+    description:
+      List of DSP core firmware filenames. Both Left and Right DSP firmware
+      must be provided and loaded. In PBTL mode, the Left DSP must use the
+      same binary file as the Right DSP.
+    items:
+      - description: Left DSP core firmware filename.
+      - description: Right DSP core firmware filename.
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

