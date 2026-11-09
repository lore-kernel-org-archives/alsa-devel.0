Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC5F606A31C
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=DoceWinz;
	dkim=pass (2048-bit key, unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256 header.s=selector1 header.b=OWjYv4xC
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7AA7160204;
	Mon,  9 Nov 2026 06:13:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7AA7160204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794201246;
	bh=pNYyEY8zBJ9SwoS/kbYoDOky6MBLftLWAQTWfThbtQk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=DoceWinzXqoRRTJfaMyKIt6UksxP3yGQnviVF4MpdJWlhgGbqTuM4pBGULavbCO6V
	 lD5F8Cl29xL8LGxH3hbNAWVB+cbAEG6hL0uFGgdXAbKXhFZckQGsHRktcxbFmPm6k8
	 VRtczIYzb8r5eEN0kl7jK/NkRT+PnAyV/YiZ5YAU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F1A24F80610; Mon,  9 Nov 2026 06:13:21 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 61CBCF8060D;
	Mon,  9 Nov 2026 06:13:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D6208F80124; Mon,  9 Nov 2026 06:13:12 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.35
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1794201188;
	b=sSo6bt11YT66ihh9m46LnJggs73GHyyEd55tT62IsDm7CGPQLCEZQ+vCr+CVr8pXfbVY
	 IpLqk4OxVM8CqUOWhbH6ZIzUXAub0FP7vKG7UQpCVxbpuMU3K4VQ3O9UAA/X9PbpZqYpm
	 NYsB65vKUn3hcGaSRiH9idXZlu1UIqkrZC/crwSG56jCwjcci7SPE6Cm6TbCS43poxcc0
	 CDZ+MB6HYNdWBnUJK1UTK3ITe2sE01SXnWkho1i6AKQjL+VsFjy+5i7nIuBmszmHdQ8oo
	 4q7M+FE0hf/wyzHdfMJFZf1uxvc8aWuvPAcIRMHLyRP1yhrQeaAE6oOxgGgt/t6g+9Q==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794201188;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=pNYyEY8zBJ9SwoS/kbYoDOky6MBLftLWAQTWfThbtQk=;
	b=iqsDHesgnMr1IrtYsPPYTEUCvpxyzu3rj7PixCZ1hlP2CfcgEC2CQ/utstIB85CmvWR8
	 5Jt4IGo9wxrPG/H9hU52XQ0GucVCA36FnqQAoJKuCjYoiPuL6rPF+7Gg1iH6LQZOJ3vGh
	 oY9h7uI3Uq7XuOLJ3uVhGdRru2T0CAxb7Mpwk9LT6/Pv3VTI0l3r6s2SmlV8IGI9SE3Vf
	 oF2oYxseKroaodUS+oHcHEinKnsnb4rCQ+jtkz09v1Hw0zc0pcFvZcBCdTAXWsvNIWRbT
	 /BXlLh+DwZcoOROwJDzXTRw0QHhW9murhqFF5cgZ9UtORaQ76M91JNum0ZRiILtNSpQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=OWjYv4xC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.35
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11013035.outbound.protection.outlook.com [52.101.127.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7E3F2F80124
	for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2026 06:13:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7E3F2F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=OWjYv4xC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uniTx5fbdQH5UY0TIdQtZ+cMxuY3PwPiqEf8MkEPWfjtH27LXNcs+fyVnlGz+sNysesp8N+AcXgmVDlXqV1X1wyn7xaSYK1kE0zK37GaB/7U03rqKua9By2kXqhigk3sSgQ6TJmrhx2bgDEG19qh4IAhrENS3af3jeCMNuCXsuaQujy36iWgKlod6BJkbpRh+P9KL7W+h/xrwAl5HFadinf+tItmWWLYgQU4An6uPO7uPH4fOECvED3ZtzH2czDN3vNC37DnSzD+oRGBOU8fcmbDHSscevDoyr3sF0iQZcBg0cCM8aPD3hseTaZVRzP4vJbJMfiX6bV1Vw1X2zLntQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdm1QdsVbJO3gQaLvQwd57ITuCOqKvaLIN2DJRn93Ss=;
 b=aGT/19wr4eXoBtYNyhsq3zOo1icuzAEKIiGJrTmTUKAwReAr88Ea20xOQlSw8/E205MIs6J92p6OhocvtnyvpnaKvAeDCh834VTo6HfJ9S14t1MzLjBZ+HktG2/TvXJTBGRzR73zfnuvxoeq+B5/O7yA167eUL/6m+Erd08UL7+UH7xDfDe8Bo1SZ709rO4x09H+X4jYYV2o5RCFXtF4+SYhHfjrdTnqWRJ1iZ8t3RMEZsLxzTZ8n+bLbNCB8c58ennvdlqG2oNsTLvjNBWugq1IZphLsNIvl4kFGrkzXANwMZw3WDDuBq1pjea9uYXAwI/URQ1VxvtNHuB0uAe4ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdm1QdsVbJO3gQaLvQwd57ITuCOqKvaLIN2DJRn93Ss=;
 b=OWjYv4xCMOXi2ZuGkeGTG8geEYiqbo5ip3WVbJPUPBh/o8tkZmlwTZJOuoBcdG3DOoeUp87Czg6FtLf1tGP76zyYI1HIU3ySy2JKGFnDQTCv+KftPBUSm4cV9hMegwWotCQR0nICRNtE3S5ar2wq/lmPd94LxJausKDiVjntm+MWOHuwpquRYySpFaPI9NKrkWDezjjf0COL3xv1L4dqWg9yqOo4X3nfndOX7HhXqULS5Y5m5Cmzye8ciMzfTptUjt3oFN/WkQ8O5w8baYoeUf8U0XE6o00Soa2G9szsVfS//7STqMbm7rksZ5DRekBOSpK02qxlmP5xFHm8dZYbNA==
Received: from SG2PR02CA0126.apcprd02.prod.outlook.com (2603:1096:4:188::11)
 by KL1PR03MB7872.apcprd03.prod.outlook.com (2603:1096:820:ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 05:12:57 +0000
Received: from OSA0EPF000000C7.apcprd02.prod.outlook.com
 (2603:1096:4:188:cafe::6) by SG2PR02CA0126.outlook.office365.com
 (2603:1096:4:188::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 05:12:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 211.75.126.7) smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 OSA0EPF000000C7.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 05:12:57 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Mon, 9 Nov
 2026 13:12:53 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Mon, 9 Nov 2026 13:12:53 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>,
	<lkp@intel.com>, Neo Chang <YLCHANG2@nuvoton.com>
Subject: [PATCH v2 1/2] ASoC: dt-bindings: nuvoton,nau8310: Add NAU83G10
Date: Mon, 9 Nov 2026 13:12:50 +0800
Message-ID: <20261109051251.471879-2-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261109051251.471879-1-YLCHANG2@nuvoton.com>
References: <20261109051251.471879-1-YLCHANG2@nuvoton.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C7:EE_|KL1PR03MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b5c7b6f-8dc1-43b3-1a89-08df3e201e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|82310400026|36860700016|11063799006|56012099006|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: 
	lbUhi31dsnkyX3QCY98AwbjRCCJBwzHUSPy9pD6Qxj7MGE1Va4qZrhi/gWO++N+QwWaZ1dX9a4NhoXJwR1iE+9oaec8aOvVAaju9RRUpUSXGanCbumPejnAHmP4sUjFqCfADzVTZxyQNmcSF70nAevTHNJtdwPJ3ost7nl1Vnp0aTi4b+Il56qM5BoBZw1Ql0LYTPxkAfLMALvUA1kmv8tofkLxmOhl1r01+MPCUe2ZH/D3VaLymAgLi762jGP/DpuOkFMzQN3l7Ttu+Cni5bpJCEMqLX87QaqmJLJVls4v/vmw8DLXZ73UvlB5TJCJuWqEKsWrODtcrGPkqXwAmOHIXtrAj4rR5cZuxwtRBBYi+7h8zzAeohl3FL2+o4wWaGJ4W1pCHQDDtp9wXAULyC5Roqv2Z8ep2Cb0KgCUyXEA2uvHlzF5DaGJJlzY4nIZpYgh2MK4LS/rUf17OEz0vbOri53c+i+xziia7+PxX+U7CMQmvwNAGOfNjJK3mlUT046lv7J6BWeT090AAAyhjaVr931QgYk/q06soUWaWoYdif/ui1q2uULcOmFkI7dzg037pVwfotXdrO72Gh3C1NWlISPAqcb/6Ht+kbcOMAHMY8+/ZJTr3Yzw9yR88bvmkHh3KpxkzYooZ9Elfp/C0Yg==
X-Forefront-Antispam-Report: 
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	JGCfI9pytpsz9099YjfVB91HULEQjDrCORfYPdKgzSD7Vy+qkBMCYHjNPIoi8s2Chimx0N725KWNc9pLOXiYgYsn4VMjY/nX9hoZ+Yo3b5aBH3V1exG07IsiudzdRwUioqmBHYsK+XeafelKTOwyCU5HqbORQe9WSjc4iQM1qTA4xMBVlABOa0G6+3cneK2Q6AfiPbNDZ8pK8vSPscOfUiWtQGPHuMp5eEAWgCUAbEbIwuiTOjgHDbo8iktAHoxo24GiSpf5N2PSMHnqcnKtDcLz71NXeuOSAQTC8J9FgNi8/ndltZd8FEtiEMleLT1+UdahSjN6q3IPQuaMolukmzYQUjYk4qoxJ5xv0eX29fYGrsTWk36SrdKZ/8MMmfbwNffUiMIYXSOzeLw0j0wYBO8tqekCqp15O713dpxt60DMcknWGOVN6o79C/7asFm4
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 05:12:57.2156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 0b5c7b6f-8dc1-43b3-1a89-08df3e201e04
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	OSA0EPF000000C7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7872
Message-ID-Hash: MW73CG4ZUJ7TN5TWBRAT5PWV6KSAEZTB
X-Message-ID-Hash: MW73CG4ZUJ7TN5TWBRAT5PWV6KSAEZTB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MW73CG4ZUJ7TN5TWBRAT5PWV6KSAEZTB/>
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

