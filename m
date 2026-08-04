Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32959C55174
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2026 10:29:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CBAB460205;
	Wed,  5 Aug 2026 12:29:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CBAB460205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785925772;
	bh=27LBooZoLEAXXMRuAqBzIbjmJV3UI9TBTMoBNEC44dU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Fdc56wGsmo1vX8viqDFVaq0LLHELXqTbBcRpTctvsCRqvPZdKvB2VySFS6tx+OYZb
	 5IMtzVvdvm4QQnpYy96mcWgNuc99zZz9vR9uGwx1cPvhdW3HxjP63G3fehyofaQsDj
	 bEdnfBUEhEOz0B9Q96z0M3tPVpcovUT4GFUx/gkc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 73A69F80615; Wed,  5 Aug 2026 12:28:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3BDE3F80611;
	Wed,  5 Aug 2026 12:28:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 81BEDF805AC; Tue,  4 Aug 2026 05:30:14 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.52
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1785814209;
	b=aFgrvuNRtiAAUZlTymFDtwADBLJ4Op29coFUhgO9w2zzOMnrOj+09lcTu2IOAaTm8wYj
	 kSF1bmgX7tIFRvrr2jUEIKNiRyhGIeeH8LbTZ+fD2OYoHTR12zlJk02DmTi1eUL0aiO2M
	 JG1TzRbC0AFDYmmdxy7DS7k6nx8zsFLqk9uGx/bwAHpj1QUgrGUJtzR/4yMDojEyizS1X
	 LeGmy//CWz/2vf7ilqdtjwq1QTLmOmJndikGo2ovdqXDsz4Zie+7Tpj8Op01tdt2kR0+e
	 uOGIQcWMkLjwfgIN4C8GbOBlkxqD+osLjkMgDZ+ZYGXsZ2CFWb1qgzS4C7w9NtOMCnA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785814209;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=27LBooZoLEAXXMRuAqBzIbjmJV3UI9TBTMoBNEC44dU=;
	b=ZYxlvUhJnNUz9/86rXamA1cb3Ip7jiY1aJfqaF0IKO/o8073WyStHbEWCaofpv+HlD7J
	 SDtSoIPjRZX5s4/792ghFd43DYQdyujTJiZD6IuQ9T8Bwc51TANareP+wxcdhedDnOMBu
	 2eSpLPuhHjOJNq8h0pShM1k7F/z226I1gHM13aWofLPhDN8X/hZYnkdjOzkURrHYU4hfx
	 j5FBN92aaRideySfl9ipPEpqmkgJmieFxpMa+KN9YzfEQ1gdkwsRxM6hRUWXJ8amcnUn2
	 TImmeT+pFd6geEyxOlX4dlN84E3YyAoUsSOv5InHhyo7PrhoBVc57/WNZMKOg7+lKqg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=mzbsmHtp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.52
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11012052.outbound.protection.outlook.com [40.107.75.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CA0C1F8027B
	for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2026 05:30:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CA0C1F8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=mzbsmHtp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUNYjinc8FHaIc6uWtia/yi4AS+tpcIyFT1tjVbriOTHoWL34HvEUugTckfG0BG4iW0KHeZjbJzL9CY+4+V0uqdbjwDWFAU8udP7OEdpNo64LJna3aDizCGIC33USIarzc43c+k7NmxEDJC3+wg6aJzIP8irmdL0+j4cn/6cJrW5fe16AjM1ECrYFAWtOM52m+PIVlH9LAxtGpg0z6pC8y1TUxMEt5q22Hs4vl8EKvl4ok0k9jbslksA46ajSMIbVWDpuw2VoS1iCCsIxPatblw0+l6WW2wNgwmTUdQEzaf5a+U70CEiVHfi4o5T7gejSbH/apDsKLwIOy0IvlSpHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+z35HvFpqgloy0iaGcob0s5GEcPF/Uoy4bFwdKO4Mu4=;
 b=kPpTAs1go+VrBy1hTOCfDMGlOcG5ArB4Z1Zb0LURcwweohZKgwzvwz1yVEVQdQF3x7o0E7Yu82u8N5TxCS22Svs3cBlc3SjwE8Vxur5MoauveBjfrBRQJRduEQx/UxXtn/YdpgPfpi7r5xrnVJfmm0KtsjVN3Ei4VBOGMgC7pI5KN5a6pBibIBoWdY6Jhqvu3CwmD30WY3rCTBWVylcMDvIErDTGiL3VBHGLLqihtuL6bxaIgfGXv3T+XQA5fey9vzCI6Bs0azbvIn9iY4aap8Scws3GtO+Mf5RDgkADS89kmc2rYCNFPLfMJJwCQwbRuCHK6OFypNbxeu8hejBLUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+z35HvFpqgloy0iaGcob0s5GEcPF/Uoy4bFwdKO4Mu4=;
 b=mzbsmHtpDf2tqeZBgwhgVx/493jhGOFf9eoRTnHk7ldoW/7Vpg8/RtOdHyQzGQJuje3NEwPaUTMS3a9Ixkmo0Oj5+EOylk6zvhD6jszTwag454h+NRh1MKtxFtmKquEIAfGGSDbJfKfMyZlbJBkHcaIxZ4D8GVd/3Sbu1zeEukW8ls3d1ytagI2gdIdYt4zwpMYYSttGEKmO4T7C5E6t3dlVrAMq45B4agAB590DzliCDh+neXuoHJ2TEYu609b4p5rGk8I01nr9DjRIxZLPHjJiUh/uDIl0jW3np8A1YId0NgFFo3d9CQnJxqAanx31S9xlAfHCkqHu6+RAcrEC4g==
Received: from PUZP153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::6) by
 SI2PR03MB6806.apcprd03.prod.outlook.com (2603:1096:4:1ed::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.17; Tue, 4 Aug 2026 03:29:58 +0000
Received: from TY2PEPF0000AB87.apcprd03.prod.outlook.com
 (2603:1096:301:c2:cafe::38) by PUZP153CA0001.outlook.office365.com
 (2603:1096:301:c2::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.3 via Frontend Transport; Tue, 4
 Aug 2026 03:29:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 TY2PEPF0000AB87.mail.protection.outlook.com (10.167.253.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 03:29:57 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 4 Aug
 2026 11:29:55 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Tue, 4 Aug 2026 11:29:55 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Neo
 Chang" <YLCHANG2@nuvoton.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v7 1/2] ASoC: dt-bindings: nuvoton,nau8360: Add NAU83G60
Date: Tue, 4 Aug 2026 11:29:50 +0800
Message-ID: <20260804032951.1069901-2-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260804032951.1069901-1-YLCHANG2@nuvoton.com>
References: <20260804032951.1069901-1-YLCHANG2@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB87:EE_|SI2PR03MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: 349d729f-bfe5-4f10-f97e-08def1d8a8a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|376014|1800799024|82310400026|6133799003|3023799007|56012099006|10067099003|11063799006|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	r9ZUcnpzd7I1ecdnsWruIm6ViFhDoRRwNtq4My1VmvPT2gWj/knZD8xuoBfJDqYCpRGBO93kBO5Qd7gVJFpOTDcxKs0hgg6KXHn9UajRC08AgaqzeIRfgsPZnrYYgoViDCqr4IBGyRbsVXtAnMC1fuaSDviSG2vvjRCx63NDVcLPHwrVsdFv4WYYdR6Q4TL+k6riv/F7km1rIz3c5OGdutD6MULOwJuU7ysTQE/RaRuU/BdvZZ48HXZkl0Sjq1RvakofPE184DLdCw+tuk36Ru6N8o+8Bh0rBmBgK5uDmiwXP78t4UFDdZgtLbVPUoQd+y3v6LDRfT6jdtqLQckDXZ5QmFetaU6Ds52swKMktkI8lbt3Ee3iCIJBxYL0wFHTfu9reo4eOhAeYtrnJ5yjbA6NuMrLNM7wt1XxVvnn4fNestjNJ/ej+rD0VXV71bxji/U2MKLSH8aXAPHD6MiBL+SLxGcwYQkolTZjInLE+28X0dt77tUN3xQ2sqnheL62PHknf8W9nsASqN+IADaaYZT9rrQQnFcEcf3X4AhdWZsNH9guh1LloxOmexirLtb31NlB7YbaRT0Ct5ZrVIdX9lAZ2yXPm6UprZRpsUi5I51TRZDrwSKv97vEkVCFUqlupmPyWXh3xewJhYP/uvqq1w==
X-Forefront-Antispam-Report: 
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(376014)(1800799024)(82310400026)(6133799003)(3023799007)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	oAWNaE5/jrXIUB72X/vdvLdZysvrFSBwMUby/SXtSAxmeq/usjpmWLv4gu6Z4v82vmhWnSzFOx5fNjnhdl3dcmGmMBxmwZwMErFEodpbwRMh/bspPgAGhUuBmlqWzKb/eML7dHAEdvf5uatQpo5uN6KC1rzMDRrgWmeSj3KkJ6nmYaJoT6z2Nu16Ps+RwQwQGMnhiCra1gYbip1uY7y+EUnE9LhE4UX4cA7UkKHNNkz+E2Fo4mkBDUTK6HCba43Ed5FAjWpyPP1Mjpni8u7TVcDS95oLUIbFk978edxfks0EZHssuHFAPQLTd1tk/PAK1XiPaloWosKXALRcnJHSJi7vi8VFS4uqkUQSicE9cGYPRWKQnC/5w/wZDTbge4zaAzWRA30bjbFubbaAfzy/S5iHid+QX/paYyhD4MoWEeM7FA/FcxXpTM9qOcdSkecM
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 03:29:57.7109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 349d729f-bfe5-4f10-f97e-08def1d8a8a7
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	TY2PEPF0000AB87.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6806
X-MailFrom: YLCHANG2@nuvoton.com
X-Mailman-Rule-Hits: implicit-dest
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
Message-ID-Hash: UGWLXYAPNJAD56MOBC3EWRAH7VCMYXRK
X-Message-ID-Hash: UGWLXYAPNJAD56MOBC3EWRAH7VCMYXRK
X-Mailman-Approved-At: Wed, 05 Aug 2026 10:28:36 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UGWLXYAPNJAD56MOBC3EWRAH7VCMYXRK/>
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

