Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF40606A31C
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=pUTSlGun;
	dkim=pass (2048-bit key, unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256 header.s=selector1 header.b=XIC8Q/g2
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C2796014D;
	Wed, 18 Nov 2026 09:43:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C2796014D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794991418;
	bh=C5edYBzmZWLYGEfbkMpqmhRB7PbQQ/Vk+cjPrhmOA4k=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=pUTSlGunESi03zGWhU//p+3VyPbIjZFrEUg+LOaELSSLJrdviOWLKMvLhGVQOcG5K
	 0op0PU/yOHZeOCpo11Xi5HgM7rhWLldWVU9hu2gH36Kwuv2+7SxmH4Q39/ra1z7lGs
	 k/9aMatXbDEqJkdvGrd8JDvyniYzQ9rm+rEfWLAQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A64B5F8061F; Wed, 18 Nov 2026 09:42:52 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 66CC6F8061B;
	Wed, 18 Nov 2026 09:42:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 41363F80538; Wed, 18 Nov 2026 09:42:40 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.9
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1794991357;
	b=Q9HQinVdm9kRZLJ5BVGxJVqLGCyH526onlsfawHaAqsAbERB1qEyk4q6h9tMHXN5EhZY
	 IS1t1t4sXQKNrDsK1vA2cG4LU1ueopXaKxUY2t5kmaImv8vph6Cdej8qJn5nyl9hBmxKk
	 x5+8AS+qGCpsvJvYUuE6tuBCHz8PqB5YwXM4+1G0ltUnEeZ3bNogJcnkVCTz2bJlb81Y1
	 kGWQtYdiT9SHO7zKX5pDyEgspv/CqHeWP0uGD62ZTrxP/SvCGpHjxuzXyFs0/n7XbDTHJ
	 AsirR6gTDCQ27xYqOQC6B1ihbjbFnsCITMdUyy7SGAdAgEMv1KGlT/QWyH6g4Eh3p/g==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794991357;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=C5edYBzmZWLYGEfbkMpqmhRB7PbQQ/Vk+cjPrhmOA4k=;
	b=ITTHUEuH5GlAO/hVPojQtmYlTKjtLkQhhwtBRII5zYCynRXH4nBxbLnsJBOx3olGaB7J
	 xgZc4Ih9YEhjAxOpV/8M3erXlzzJSc0VbZ0ivy1w0naIhAomu+UClC8mYt/tIYgPEEx/J
	 yqU7lbdpqcg8gigDEkyB7nBoVCmQ8D8fF6UYJXStOpOvsy07O0rqnhumqqb0fWWlerkyC
	 cmLayJ/Q2Y+okIWDt7KF+TNvX0i3A5Ep4c5hAdZelxBfLYmt2Swa0asBrP3T4ZbxlRWZe
	 rnIpbs3JGgK0cXxygzLclvw4bFbDw62L5BdXBmhW6y+0rfeXz9hol6tOJV+iCDYKNbQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b="XIC8Q/g2";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.9
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11013009.outbound.protection.outlook.com [40.107.44.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1AF74F80510
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2026 09:42:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1AF74F80510
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=XIC8Q/g2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aWK1EmELzX0+dBBCvPlh6IbQMpCJrtMBZGSSknD5hWaFBv4mXCppr45sXvHS+0H0OGKvqvU5SLMXTESYV/ipzvVXTfbW5y2BfLv9xLLIohPRwCxrnlrACo7sg8UcmjIpkjLVkZzUx9Lz+4vWM6Jgm9Khh6+JPyLjZr+oa3rpzdn6285/RWTlODSKIiBUJWCXCurtdzaKuNSYA3givxTskOeXN+FDgLJggibHpk4iCtOaGfsQNykd/IUJ9pA/+nA4kZ4D+TdW7m41ZO7TifwDvidrLhksexx77XMZwrrf8zxFPprVMuE2iI8iW/s4kzt3hUD8bDaa5j0anEX8uB3wtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpyPcMGIkXeNd0FXabT2eKUT321oJfEvTjdN75ppqjs=;
 b=R5iOIKHijPp+1C3/fCxJnMG/2RGWHFlKfdZ7vtXs3RfNzrKXCGlciYz33JwDZH0JWpfZwxUMmgVn/uTCq8+xiRT0IFGR3DPJMWzvAXEU1n2KwN2qs50oCnecHIosGJFaQbbkqEy2IJ5AX3Jo22iDJ/LEuvGwoXh+F/i+diGz4y8k4T3LpwGcDQTK5hApn16dAI4YXz65FTiQAw1ONNZDgtXd2/Kmkav07hoYBVZtTXWrbEms0RpSVz13oVzVwu3cPZOn6QQFUuIqXYL9fidYpv69AxluPWSSK41/kaELxeLBHrXQziKRCpBaAv7r6LT+2OITb7dF8UM17xT1TPg5dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpyPcMGIkXeNd0FXabT2eKUT321oJfEvTjdN75ppqjs=;
 b=XIC8Q/g2n80V9ppXnOdqcT7NbdBRb7vS4qQ8zokAWmIiOxYBzk5sjrj9QcmJZThV3r4E1hT5av+cK5LxQu40L6YRME1OK3IRnMjThFkcbR5wwpn6kJaltotvjMU004TPUKR0ogD6F+rtV0iuXgH0P5WcEKyflkp2lAgmU8zTO546tcX0NjCFc+IcNtgEnexiJR58ihYelx++ZOZrYGue4gxin56NGms9h8h2cwCBm0FNmV7pytUIG84JGUVB/RsdI/xMsofVvfRpV15MHm9ImeCFfA740L7YYfy0aaK0WeH4XpptILGoN44hDfCNT6WdFX/oBK3od3lyeIeHxB8UbA==
Received: from SI1PR02CA0004.apcprd02.prod.outlook.com (2603:1096:4:1f7::12)
 by KUYPR03MB10285.apcprd03.prod.outlook.com (2603:1096:d10:9c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 08:42:22 +0000
Received: from OSA0EPF000000C8.apcprd02.prod.outlook.com
 (2603:1096:4:1f7:cafe::7e) by SI1PR02CA0004.outlook.office365.com
 (2603:1096:4:1f7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 08:42:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 175.98.123.7) smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS02.nuvoton.com; pr=C
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 OSA0EPF000000C8.mail.protection.outlook.com (10.167.240.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Wed, 18 Nov 2026 08:42:22 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Wed, 18 Nov
 2026 16:42:17 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Wed, 18 Nov
 2026 16:42:16 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Wed, 18 Nov 2026 16:42:16 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Neo
 Chang" <YLCHANG2@nuvoton.com>
Subject: [PATCH v3 1/2] ASoC: dt-bindings: nuvoton,nau8310: Add NAU83G10
Date: Wed, 18 Nov 2026 16:42:13 +0800
Message-ID: <20261118084214.527804-2-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261118084214.527804-1-YLCHANG2@nuvoton.com>
References: <20261118084214.527804-1-YLCHANG2@nuvoton.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C8:EE_|KUYPR03MB10285:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c9430e0-ae44-4809-7d2f-08df454fdd06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|6133799003|18002099003|22082099003|261009223027099003|3023799007|11063799006|56012099006|261102123227099003|261028144727099003|10067099003|261026121527099003|261026140227099003|261021121427099003|261022105027099003|261022075727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: 
	S2ZARM2F8pstCW9GP4+uf9ozcQiG0AqG93oOPDhkpr7WPVstBmKdqHCkPDw9au66nbj+/drOFq2YqhwZY/sCXGjLUkxnshtOgoNVXL+g9sj3e/TVnFP+fFKyQltv4QBax9y8UcWuOo+UCiBxTxjpOxTVpjFNDXKbZxnR2BkJTztQIqKP4PGqgudvlJVxKt1uYCE9XtKbZMfUPhwuJcW9Da+7LKvMlJQHOU3R0LbzHlSiOrc4VsndHAT5nI9YjigDyWC2Lj8Kpk/gyyRxWEZeZyEpFXmtFsUog19CT6prjApS7hRlCXGS2OMi1wTqyShKprj/l9bMG6ZT5vEwhK2GuTxAn4Nz7PDZf5OLWQIQnGm2ORWFKWkk3eQDE/o/7UHWUUxyQb8NtMcIANm80yEpOp1TlBTxUQtOe57ThgRqo3AHLeg0zaqZm64Ve4NKwzo7WD6b9moax3kLMOFPnDwneY2mvkqBV9vI5ZsbQE+ltaO9ArXyMgwsU+tmAvtoRAKOIEAt5VVOKOeUkT9OyqVqcJbgQXp6WHNHer6yxYlYYLGU2UKSYLfHfCg1K6pkDbKgPZ+bYeqqeLN496TVBrvVU+Ffhr9nTxDZ6ThED5JBDTj7dX1r0Xy66rPXuW0d5GbG/0OIAIElKd7dBppFw8jPyA==
X-Forefront-Antispam-Report: 
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(261009223027099003)(3023799007)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(10067099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	N6eEfWfWeLv/nBT3zMZQH0oFoB9lXSGKMB04ya4VXbZeXCPJaohQXOvCrOeKpiE++BRFvnRcjWrc2p+lV/OG3kTwPfLpyPrI998i+JmnRspHT+xe8EeWVZFQ0luUdMriJzfDWe0FULjXSPOGX+OSPLe/EonS8PR/uCC/hRQUgItV3EV8CJ/3VmNMH824DlyiuUllvpTSia+56umNlOl7K9MOF1X+SlnrPrG9ubf++HXFLbsqQtWTVnDAGnnYyKlWPnm2XsAZv7/ugVBaHgfkTEj8y5M3g1stCSKIgcyLxPhsp3TwaUsin7lRfOmerd3sJZjqYswh4cBjBNwLyOy/JTVw7NhN6VhRR0/I2T44cLVDjy3o/pWQHJfkt1m/xs5GZMtyh0a1BF1UuvDyvHRuhAxzT22E0cSKHx0jN6/z0lUSHMp6iF6EFmi0YpzSd/St
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 08:42:22.1893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 4c9430e0-ae44-4809-7d2f-08df454fdd06
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	OSA0EPF000000C8.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR03MB10285
Message-ID-Hash: D7QSXMDXJQ772ZEKYO4TPAN2SC7SYODJ
X-Message-ID-Hash: D7QSXMDXJQ772ZEKYO4TPAN2SC7SYODJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/D7QSXMDXJQ772ZEKYO4TPAN2SC7SYODJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

Add device tree bindings documentation for the Nuvoton NAU83G10/20
audio amplifier.

Signed-off-by: Neo Chang <YLCHANG2@nuvoton.com>

---
Changes in v3:
- Utilized standard physical unit suffixes (e.g., -microvolt, -ms, -ns) for
  electrical and timing properties rather than exposing raw register values.
- Corrected the description of the clock detection disable property.
- Added an 'allOf' constraint block to explicitly disallow boost-related
  properties for the NAU8320 variant.
- Adds a usage example for the NAU8320 codec in the dt-bindings yaml.

Changes in v2:
- No changes since v1.
---
 .../bindings/sound/nuvoton,nau8310.yaml       | 186 ++++++++++++++++++
 1 file changed, 186 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8310.yaml

diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8310.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8310.yaml
new file mode 100644
index 000000000000..16b0dd1cdbef
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8310.yaml
@@ -0,0 +1,186 @@
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
+  nuvoton,vref-impedance-ohms:
+    description:
+      VREF Impedance Selection.
+    enum: [0, 25000, 125000, 2500]
+
+  nuvoton,dac-vref-microvolt:
+    description:
+      The DAC vref to be used in voltage. DAC reference voltage setting. Can
+      be used for minor tuning of the output level. Since the VDDA is range
+      between 1.62 to 1.98 voltage, the typical value for design is 1.8V. After
+      the minor tuning, the final microvolt are as the below.
+    enum: [1800000, 2700000, 2880000, 3060000]
+
+  nuvoton,sar-voltage-microvolt:
+    description:
+      SAR Gain Tracking Selection in microvolts.
+      Assuming the typical VDDA design value is 1.8V, the SAR voltage is
+      calculated by multiplying VDDA by the gain tracking ratio.
+    enum: [1800000, 1980000, 2160000, 2340000, 2520000, 2772000, 5616000]
+
+  nuvoton,sar-compare-time-ns:
+    description:
+      SAR compare time.
+    enum: [500, 1000, 2000, 4000]
+
+  nuvoton,sar-sampling-time-us:
+    description:
+      SAR sampling time.
+    enum: [2, 4, 8, 16]
+
+  nuvoton,clock-detection-disable:
+    type: boolean
+    description:
+      Disable the Clock Detection Module. By default, clock detection is enabled.
+      When clock detection is enabled, it will detect whether MCLK
+      and FS are within the range. MCLK range is from 2.048MHz to 24.576MHz.
+      FS range is from 8kHz to 96kHz. And also needs to detect the ratio
+      MCLK_SRC/LRCK of 256, 400 or 500, and needs to detect the BCLK
+      to make sure data is present. There needs to be at least 32 BCLK
+      cycles per Frame Sync.
+
+  nuvoton,clock-det-data:
+    type: boolean
+    description:
+      Clock detection non-zero samples configuration for power up signal.
+
+  nuvoton,boost-delay-ms:
+    description:
+      Boost Control Hold Timer in decrement (msec).
+    enum: [0, 1, 2, 4, 8, 16, 32, 64, 128]
+
+  nuvoton,boost-convert-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Boost Converter operating mode.
+    enum:
+      - 0 # BOOST CONVERTER disabled
+      - 1 # BOOST CONVERTER enable gated by POWERUP signal
+      - 3 # BOOST CONVERTER enabled
+
+  nuvoton,boost-target-limit-microvolt:
+    description:
+      Boost Control Target Value Limit.
+      The step size is 190000uV (0.19V).
+    minimum: 0
+    maximum: 11970000
+
+  nuvoton,boost-target-margin-microvolt:
+    description:
+      Boost Margin Value between Boost Target Voltage and peak output level.
+      The step size is 190000uV (0.19V).
+    minimum: 0
+    maximum: 11970000
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
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nuvoton,nau8320
+    then:
+      properties:
+        nuvoton,boost-delay-ms: false
+        nuvoton,boost-convert-mode: false
+        nuvoton,boost-target-limit-microvolt: false
+        nuvoton,boost-target-margin-microvolt: false
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
+            nuvoton,vref-impedance-ohms = <125000>;
+            nuvoton,dac-vref-microvolt = <2700000>;
+            nuvoton,sar-voltage-microvolt = <1800000>;
+            nuvoton,sar-compare-time-ns = <1000>;
+            nuvoton,sar-sampling-time-us = <4>;
+            nuvoton,clock-detection-disable;
+            nuvoton,clock-det-data;
+            nuvoton,boost-delay-ms = <128>;
+            nuvoton,boost-convert-mode = <1>;
+            nuvoton,boost-target-limit-microvolt = <9500000>;
+            nuvoton,boost-target-margin-microvolt = <380000>;
+            nuvoton,temp-compensation;
+            nuvoton,normal-iis-data;
+        };
+
+        codec@11 {
+            compatible = "nuvoton,nau8320";
+            reg = <0x11>;
+            #sound-dai-cells = <0>;
+            firmware-name = "NAU83G20.kcs.bin";
+            nuvoton,vref-impedance-ohms = <125000>;
+            nuvoton,dac-vref-microvolt = <2700000>;
+            nuvoton,sar-voltage-microvolt = <1800000>;
+            nuvoton,sar-compare-time-ns = <1000>;
+            nuvoton,sar-sampling-time-us = <4>;
+            nuvoton,clock-detection-disable;
+            nuvoton,clock-det-data;
+            nuvoton,temp-compensation;
+            nuvoton,normal-iis-data;
+        };
+    };
-- 
2.25.1

