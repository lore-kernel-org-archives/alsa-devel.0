Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892E4C5DF9C
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2026 02:17:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7E143602AB;
	Tue, 25 Aug 2026 04:17:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7E143602AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787624263;
	bh=k1lDT9FlVn63n6LZAGyWeCDiShEIrecU/TxMyRRWHjE=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=rda86yH02ntSJmfUB3SBsQ9PSViA/JYiXQ5uApsO98e4xzy1thHc+IV7uSRyMxGJk
	 +JbHDcTb0mv1/iaUUI7P2F73k5TJDqLOz3oBo3TVlyATEiKI9IX4uBOwuwfm9Hwu8C
	 W0fNlRjwDCRmUiIBOUlx1Rc2YxXUVJqaeg8+uck4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2BCC1F805F5; Tue, 25 Aug 2026 04:17:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8332FF805FA;
	Tue, 25 Aug 2026 04:17:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C2417F8049C; Tue, 25 Aug 2026 04:17:02 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.31
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1787624219;
	b=IKfCbZ8wLn+imzXUCKQOznayludngSAT/KfCEuKMmWzM5F1lR50JThCdxpsTnfg503wA
	 JrdkA9fvd3dXeMI/mk6+Vco+oGk4NaccNM0rbEZF+tuU6CPn+T7YbGCXpkoiaDkoRwg0X
	 18w5m5WzLWabc8pHk0O16JEbvAtNK47QXmRatOaMywG4nSmK2H0Kt0vsL8HzTE+Hzwqeb
	 TiM+qOLNdkmEAcuZUarsqsh0NuwB5bHD0CDLejJct17cKVLUWCSa7mJF03OCd9VptlIFT
	 S4HXovaE4N04r3PXq/2ECUFUEAgZ0FQeg+hJuBGMHvPsjsnQlZ0nDwd2lMtlItebd1Q==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787624219;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=k1lDT9FlVn63n6LZAGyWeCDiShEIrecU/TxMyRRWHjE=;
	b=eBE+C7pTOyA9Dk/mYUfAZE5y9HoJISgec+7lBBooyrckcFguCc4rlWaQDnY2AxJ2y4MN
	 ICuo+NdPSI/kWZva8taKHX7bYPFEQZ+wtpZwHd+CAL7B+1Lwmjgryy023uLgzBOMeUf1O
	 o9K8Bkr4kcgh7jtpNLOOYyFFkaWKOgoOEX1Ftra6AZIKq8CqsHL2K3xCaxQP5VXQG8xng
	 p4Z1btFBj4QFFsFFiQd2Vj+r6ky7P4HQPr6ulQpBjqyP99gFU16hikyKtKB7cOWrrhMMO
	 RzrY4qVvZlqkhbshLE0fdJQ7Aqo1AmUNLLiIgtzfp8nSsltzHh6uz3GAYXjWp8rEtvg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=hlaxc4lK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.31
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11013031.outbound.protection.outlook.com
 [40.107.44.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 39C13F800B6
	for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2026 04:16:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 39C13F800B6
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=hlaxc4lK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNy2GpxzUAH52RRx2Yw7L2LBHSpf9xY1E6+VPNLChFtjMUL2nCyOix+L17+WWqrkuk4keclkuFTr6cSv0/+AjV0Lq2OknUgDD/RD/pXRDxi0pPC1InNbSiEUFS64URhRI5sbqcKf0AN3vQhIEFJBmatSlSqeM8z1h8X7PvIq9o3GdAWxsSXSVp6yXUPBZ312md0vTdACa6Y1ZI5UHd8H49DWkchUnCMDbGsMDQghyFUbfKcVX6xMgVooEBL7ChHz4vBAnpvK3roLSy2tvkqvhUolwqK7pv6S9QUvx9O9lgjwY+ZOAUHbFggW+Q+iJ6XPA30ro3FgRANISI8YoA7cgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqgGpQwYwmIxIifpit/dS67eXzp29+HZAMv3Gubk3J8=;
 b=i36OyIr5zZw+mT7A9j33RFnXNrG+H+hcRAIgCmYbKZ2GAXnczFeSVSqaP/6n9IXGtjULVyyEFsMfjuz3MQ8R3O35wLlXVq+AgBIE2qZQywBmue81DopUaxeP7YDZT+hzWu5UqR8ruJtDuZ+YPrY0dFf70mBocq9KY0AApJe4+CRpTQ96pqFNT3hJZdPjFLdE7ZV6objxH4PtT4JZf3qiIkmSGGnrO0v9WyDQmcU84D07mbzDB5eZFz87EeQo7H+NXl/O+cGBLZvHffIkyFujqaBMWgUbD/xvwpofzAunogx8KRyCJHeLTiNoRtNnl74TsGxqgfv3wZSV53R22BC/Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqgGpQwYwmIxIifpit/dS67eXzp29+HZAMv3Gubk3J8=;
 b=hlaxc4lKAStgZmvzrKX3xi/vByevCXPY0IaXsesIW4Q6zz0AHbkXwPlZ75bT4rHqBq4RFuLzFZLwL8lMruy6cb7enNPzPabHWVA0kfhOXg0XQ8eZ70w/W8zFsRgqNo94EfK/9NV4wwgyqsv2v8oCAZ2/aHj2KsWHh8fZ0HiD3xVS3w+1nDkPc2vITIsh9HA/zUx9A7cSrDbKT7kiXieJla56qXpEtBtN+9SVNTx3OoOmo3+l0WQNLH6J948XCHMCw+JPncXbz00VR2JJpabh6G5mmc5jbHhFIUdT8dgfZJhP3CBff/3WSrK5AxpLPRSFsK9VCAF0Hu2WPHCYvo095Q==
Received: from TYCP286CA0271.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c9::16)
 by SEZPR03MB8096.apcprd03.prod.outlook.com (2603:1096:101:17f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 02:16:48 +0000
Received: from TY2PEPF0000AB83.apcprd03.prod.outlook.com
 (2603:1096:400:3c9:cafe::66) by TYCP286CA0271.outlook.office365.com
 (2603:1096:400:3c9::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 02:16:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS02.nuvoton.com; pr=C
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 TY2PEPF0000AB83.mail.protection.outlook.com (10.167.253.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 02:16:47 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 25 Aug
 2026 10:16:46 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 25 Aug
 2026 10:16:46 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Tue, 25 Aug 2026 10:16:46 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Neo
 Chang" <YLCHANG2@nuvoton.com>
Subject: [PATCH v10 0/2] ASoC: codecs: Add Nuvoton NAU83G60 audio codec driver
Date: Tue, 25 Aug 2026 10:16:42 +0800
Message-ID: <20260825021644.1203076-1-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB83:EE_|SEZPR03MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: b78753c7-6945-4408-a3bd-08df024eead9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|6133799003|3023799007|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	VFP31oALFdUL22cwIAb1ZE1BsS6IZPF9BYwrVxLLLzEh1J9nNkJRKffsrUtPvctoLFaV637pE2h175IvMupQi7OjKaVa7goswxp7sVwf9gx5aYefmtjMl4ZXCRlPJ88X4iNzbSohyAEwhdOHJOm6LY/qNLdaGXPvHnuiZPbHA11ENuvlNW1x8vv4jecWAC7uTHEJjeYaZm1b3ZFA0+Y8IjXoxgb2A9obcKPlevQywyJCc0o/qcI5N7cYbBTP22YX8BofJdB3/abU71XqBnvs4AvzM6yDQ4AtBuRHzG3jf0V/qDkpskz6STqWdgFv8zD6wr8fYJAiCI22kJzLEnjfLS2DhjvlfD13THKr4RvCvtlqhSqtM9PAqtCuXn2xj68hx+6P+MzHAHkXVsIN2QjOGYnrTYg7kWp8Re/TzuEAyWOgF76LTqR5ChrLBih6xrh+RPEfMdnSILR7AEjv5DJcK78ybp22cueax7ALfPLfwxPIeJmcOrHmDaF0v2e9n+wtkNkeRsszH/XrcEtzsitDZaQmFo/N6RL9MIyzVNFdUruKarIN9pAtAzWZgDBKSrhh1/YrB1wdHAPNAPQJJBByZSfyJJ2CFPWMG+yM5RSSrh6rmBKqNJYAnSN5IVexW/NvnS71Ez9s/zLq4xMcdAVykpBIyb5uVy0nAlEc8gu3lwXMKBi1CdhwU/9ZqNHOEbIZxfX9Ir2GTGCZxWWeFAmdXg==
X-Forefront-Antispam-Report: 
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	4RzztxFnbD36e5K0z6xRvT7GDlzzuQTb/uS/p4Uu7Mm1UcxrPFuYYRB11jl4sOjQTp3qpKlO2KLK/1+6p4rd4X+dyLXiK86HnVtdc0UUgxq3wBnxUP9GqBPBD8je8ZYncq3pe7GOXt50u8PXbxqeimax/8HZE/9RWQmJsKB0b4JCn53bph3EobXusLRHWT1fArVQ36sXCIYC5b3+4z5dQ0E+MAbCp/maiX6Io1pZCO5haQXwrvR+DCKFqS+lzMV+zS2fnjHz+MXtV/j/y59Qn3BQIh6SNlw+LXi6zGWmWf0kNjvO2CxBS1NLyTFHE+fLYC+eNEM1foEFmDmpp9aWG8loWh6uI4HvpCMs4/gf2QhY8cBfcGBIwP+TPHlGeCAdfupTC7MEy1x8OkOP3xmHkcsIcDSfpBhZtLRrPac8vOWPZVdMX2/0klrMIqTW0tht
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 02:16:47.9623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b78753c7-6945-4408-a3bd-08df024eead9
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	TY2PEPF0000AB83.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8096
Message-ID-Hash: RMMVOTBH3XCTO2XVR4JZQ5UD2I7L6T75
X-Message-ID-Hash: RMMVOTBH3XCTO2XVR4JZQ5UD2I7L6T75
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RMMVOTBH3XCTO2XVR4JZQ5UD2I7L6T75/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This patch series adds support for the Nuvoton NAU83G60 audio codec.

The NAU83G60 is a stereo Class-D amplifier with an integrated DSP and
I/V-sense capabilities. The driver supports I2C register access through
regmap, DAPM widgets and routes, TDM interface configuration, and DSP
firmware loading.

The series is structured as follows:
- Patch 1: Adds the YAML device tree bindings documentation.
- Patch 2: Adds the ASoC codec driver implementation.

Changes in v10:
[dt-bindings]
- No changes, added Krzysztof's Reviewed-by tag.

[codec driver]
- Fix SET_KCS_SETUP command to expect no reply data.
- Expand lock in nau8360_anc_put() to sync hardware/software states.
- Move lock to nau8360_dac_mux_put_enum() for atomic DSP transitions.
- Return -EBUSY for PEQ updates during active streams.
- Add flush_work() in startup to wait for firmware loading.
- Use get/put_unaligned_*() macros for I2C read/write.

Changes in v9:
[dt-bindings]
- Correct firmware-name descriptions for Left/Right DSP binary requirement

[codec driver]
- Protect PEQ access with DAPM lock and component active check to prevent
  race conditions during power state transitions.
- Remove the global PRE and POST PMU/PMD widgets and consolidate the
  mute/unmute logic directly into the HV event handler, preventing
  unintended execution during capture-only streams.
- Fix firmware memory leak on DSP setup error path.
- Fix out-of-bounds array read in dev_dbg by validating the `source` parameter.
- Fix uninitialized stack memory usage by checking regmap_read return value.

Changes in v8:
[dt-bindings]
- No changes, added Krzysztof's Reviewed-by tag.

[codec driver]
- Replaced request_firmware_nowait() with a dedicated workqueue-driven
  firmware loading mechanism to prevent use-after-free.
- Fixed regmap cache_only mode handling to ensure cache sync and DSP setup
  succeed during resume.
- Fixed potential data race in nau8360_dsp_switch() when accessing
  'anc_enable' and hardware registers.
- Prevented uninitialized stack memory usage in nau8360_dsp_kcs_setup()
  when handling short DSP fragments.
- Fixed undefined bit-shift behavior caused by out-of-bounds
  'tdm_tx_func_slot' configurations.
- Fixed incompatible pointer type warning in nau8360_validate_tdm_slots().
- Fixed audio format configurations for Left-Justified and
  Right-Justified modes.
- Explicitly included <linux/bitfield.h> to resolve implicit header
  dependencies.
- Set symmetric_rates = 1 in the DAI driver configuration.
- Removed internal fine-grained clock dividers.

Changes in v7:
[dt-bindings]
- No changes, added Krzysztof's Reviewed-by tag.

[codec driver]
- Fix potential DMA cache coherency issue in I2C transfers by separating
  TX and RX buffers.
- Change tdm_tx_func_slot and tdm_rx_func_slot types to u32 to fix
  incompatible pointer type warnings.
- Fix TDM channel enabling logic to check against slot IDs instead of
  function indices
- Add bounds check for TDM slot indices in nau8360_validate_tdm_slots
  to prevent out-of-bounds shift operations.
- Fix payload reading loop in nau8360_read_data_payload to break early
  when data consumption is complete, preventing protocol errors.
- Add wait_for_completion during driver removal/suspend to synchronize asyn
  firmware loading and prevent use-after-free issues.
- Refactor resume flow to properly handle regcache synchronization and
  PEQ memory enablement.
- Move PEQ Memory Clear process to execute after DSP reset.

Changes in v6:
[dt-bindings]
- Removed '|' from descriptions.
- Add firmware-name in required.
- Add "nuvoton,dsp-tx-slot-mapping" and "nuvoton,dsp-rx-slot-mapping"
  properties.

[codec driver]
- Fix Use-After-Free during device unbind by properly synchronizing
  asynchronous firmware loading.
- Fallback to default firmware names if the "firmware-name" property is
  missing.
- Parse "nuvoton,dsp-tx-slot-mapping" and "nuvoton,dsp-rx-slot-mapping"
  properties for static TDM routing.
- Drop dynamic TDM slot mapping via ALSA kcontrols.
- Replace cached tdm_chan_len with direct register reads via
  nau8360_get_tdm_chan_len().

Changes in v5:
[dt-bindings]
- Remove detailed datasheet information, keeping only the valid
  I2C address enum.
- Simplify the `firmware-name` items definition by removing redundant
  minItems/maxItems
  and moving channel descriptions directly into individual item entries.

[codec driver]
- Add FW_LOADER dependency to prevent silent probe failure.
- Fix uninitialized return variables and add error checks for underlying
  I2C reads.
- Replace stack-allocated buffers in I2C transfers with heap-allocated
  memory.
- Eliminate potential Use-After-Free by synchronizing firmware loading.
- Protect PEQ memory control operations with mutex locks to ensure
  thread-safe register updates.
- Resolve TDM slot configuration races using mutex protection.
- Correct mathematically invalid TDM TX slot offsets during channel
  length changes.
- Ensure TDM streams are explicitly disabled when slots or slot_width
  is zero.
- Fix DSP protocol corruption due to missing locking in the DAPM
  clock event handler.
- Use FIELD_PREP() in protocol packing functions to replace manual
  bit-shifting.
- Replace deprecated of_property_count_strings() with
  device_property_read_string().
- Remove unnecessary CONFIG_ACPI ifdefs as struct acpi_device_id is
  universally available.
- Refactor repetitive DAPM event handlers (adacl/adacr/dacl/dacr).
- Simplify code flow by removing redundant gotos, variables,
  debug messages, and dev_get_platdata().
- Standardize driver style using switch-cases, positive logic checks,
  and reduced conditional nesting.

Changes in v4:
[dt-bindings]
- Refine the firmware-name description to clarify the loading order
 (Left then Right) and the PBTL mode behavior.
- Remove the "dsp bypass" option description.
- Update the example node to follow devicetree coding styles.

[codec driver]
- Clean up unused DSP state flags (dsp_enable, dsp_created, dsp_fws_num).
- Fixed the use of an uninitialized stack variable.
- Fixed unhandled failures in nau8360_dsp_init() that caused duplicated
  DAPM widgets to leak.
- Add mutex protection for PEQ memory and TDM slot caches.
- Restored the missing hardware memory access bit during suspend/resume
  to prevent PEQ coefficients from being silently lost.
- Handled regmap_read() failure in nau8360_vbat_level() to prevent
  the usage of uninitialized stack memory.
- Removed improper dynamic creation of DAPM widgets and routes within
  ALSA kcontrol
  `put` handlers, using proper static instantiation instead.
- Moved RX enable logic to startup() for consistent stream state.
- Replaced synchronous request_firmware() with request_firmware_nowait()
  to prevent deadlocks and avoid blocking the kernel during firmware I/O.
- Explicitly disable TDM RX/TX when slots or slot_width is zero.

Changes in v2/v3:
- v3: Resolved YAML build warnings, added Kconfig/Makefile entries,
  fixed stack buffer overflows in DSP parsing, and refactored TDM slot
  validation logic.
- v2: Migrated software/runtime configurations from DT properties to
  ALSA kcontrols, refactored TDM routing, and improved firmware path
  handling.

Neo Chang (2):
  ASoC: dt-bindings: nuvoton,nau8360: Add NAU83G60
  ASoC: codecs: nau8360: Add support for NAU83G60 amplifier

 .../bindings/sound/nuvoton,nau8360.yaml       |  115 +
 sound/soc/codecs/Kconfig                      |   11 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/nau8360-dsp.c                |  634 +++++
 sound/soc/codecs/nau8360-dsp.h                |  122 +
 sound/soc/codecs/nau8360.c                    | 2300 +++++++++++++++++
 sound/soc/codecs/nau8360.h                    |  911 +++++++
 7 files changed, 4095 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
 create mode 100644 sound/soc/codecs/nau8360-dsp.c
 create mode 100644 sound/soc/codecs/nau8360-dsp.h
 create mode 100644 sound/soc/codecs/nau8360.c
 create mode 100644 sound/soc/codecs/nau8360.h

-- 
2.25.1

