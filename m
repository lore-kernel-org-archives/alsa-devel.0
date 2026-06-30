Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343A1C43458
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Jun 2026 02:16:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1B6D9601ED;
	Tue, 30 Jun 2026 04:16:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1B6D9601ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782785806;
	bh=5Vkc7J84VPD4J8ZOQfg4eSQmSxp9zexkmmMyJhUdjLo=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ByF/HKMLqjY9Hf5o0h/gsw+ZGfsGqWMxsLkQJlBFHEwvCVJHq3txnL8FoeAE3tOBT
	 8WXiyfF7a0zj6peGKJ5OBDG4AE4AGbDTKtndfyECfS5OdywfdaHP+I6LVM/oPulFxG
	 vDzd52HH4+EpdsmKCkLau8Oq2o/6DMYWI8LBXII0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2950FF8061E; Tue, 30 Jun 2026 04:15:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A702EF8053D;
	Tue, 30 Jun 2026 04:15:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D784AF80587; Tue, 30 Jun 2026 04:15:40 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.32
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1782785739;
	b=Wv/68iIYX024OmXcsCfZ9Zve5Mx3r5GpJRUz+k3Iw70DXGEYu5ahlByG3ueyjYYaaKZY
	 zRAURutLAXKfAJnDzaveaRfngGI5bQkRfxkViYeUgALhD0xwkR7rHxcBcKFO3+6uIuhaT
	 1qPEuD1U7tReKW8vPhQESBNPxxsbU/GzS5SCIUv6CbVnmKX51Bn33JJrlTrneTUQvq/iR
	 jJaiaNbC4cxk8q4heMcxV6Yc0QIbzSpzDawSQg7fh4pIFgvf1r0GEkmIwi1zWE15XGiSj
	 h/a9JmIyIILsNXfhP5HUlyvhBtGBEvcwhNW+hQ4QPu7RfkCrR5vJ6FKFnfY55hQRGVA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782785739;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=5Vkc7J84VPD4J8ZOQfg4eSQmSxp9zexkmmMyJhUdjLo=;
	b=QSD9eJrpYSRLJx+x0sRls/VUK0zLm9rkJPW1Sk6E7Nel+ZdXWdYYlJ1w/zytiSqY3vpt
	 8HR8uMUaPDXSqgin01yXNAJgMZ8v7oAgIV/shkXLpgXSpC4EFhRS9R4Tt6kieijCIq7gz
	 qJMU0nT/KGLmWZO7IFDNBkkzjb2w8V7fTTSnB8fUg2Hn9QWjHQHavpQZ5iCAFR6pTEvPa
	 Of3NlPUrzo9+VBtpULvUepauO2sNQATWTWkIWxGc5uUrMTKQ+W9YlFJH56ST7HGpFxBi8
	 CvhjyoUNmM1JVFrfkbMYZRCMUNcAvARAl901r2q3J7jqhPkD3xMWCDj+CTP5XzZSLtA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=mZX5VpxD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.32
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11013032.outbound.protection.outlook.com [52.101.127.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 07D15F8053D
	for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2026 04:15:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07D15F8053D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=mZX5VpxD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xWOK/1G0Q7Ds7YjJb8uf9sZJQvuPJupeSxHntyaO/rOJcgm1nlqAY3qOg+Cl25GZJwm0bZwDvdmWo2JaB5XRBbcvE97t5Zvxtu3egG03gprPj1lKHG/aPhSWM4uK8ka6U7IQmH3zYlGtuCQOGDD4wB908JiYAaYgP/cOMvsUnVWkSstJTU5T0apJoAR/f64l+fSPNQfabxaMKT20kNViJas1j1jB51/9sXpRYbTEd4jex4uT7r0NYLRw6KIUjhyxW1IIhCHNKQjVaLpAW1yCcbqqr/auUupuDiAK/sblhOIUP12NLmPL2xjXpgqx9e+HsJaY7GCY4xFjFH0mYeZEqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQSBGHFoyT8snehWcN101RzA4aCX4Dzqfnbk8G1VExA=;
 b=NaWznZFSmL+ShRkn4r4PBVj1uYdPf8KajoBpGYq9QyGzNC5NGmx9TyQcTyzEHSw8AnA97MGdPt3rsDw1gJxTLXqINHApK+eCAcbOwNtG3YYInC8IIIQTQdOP090nOkdi49AwV81o5pQwAc/oyuU+oc2OtwradFq7YFy58Jsg1GqIFHBNdKUOz+okQAeDPww049E22xJxT2AMI72/I4s2Muse4gmYHY7gB4USTqrNtkh2fFnwDKyKZEX6qp80yC3lRka4SzaYiTjI+bYy6b/r6+7MnEMXYdz8yMmVHoaTLei8pXX4e9QfBMATJZSVAPHd6rLKBwpcOdDe3pxQw3/JpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQSBGHFoyT8snehWcN101RzA4aCX4Dzqfnbk8G1VExA=;
 b=mZX5VpxDcLLQPD7uxjtrAXNjF9agKvy3NWHnKiAw2jwwyHSJhGNSCM5nVHElUAxatZoShU0sPMr31vhymi/4REhhcN8/mQahIVvLplo9+O2PxY1uqMJYZ++Zu4E+09RTswaYvIbu2T645QOmOCjggdSPmMj3DqPVHwomI7u6v8op+4rH2RnFq4tY7QvFtZcOjl7trB9M7qPpcDMFKU9g2w0EG8hLAFtRG2ZMIjU/QSEbuCvzqrwHc2wGOq1zijmlXI651gdfByZoHzvYkbN4r0dFcTeLwD9S5shLHV1T+Upy71WHsaYmevuqPeatQaFsZo2q0+ztSDej8aTQDR6CIA==
Received: from SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) by SEZPR03MB7874.apcprd03.prod.outlook.com
 (2603:1096:101:182::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 02:15:29 +0000
Received: from OSA0EPF000000C9.apcprd02.prod.outlook.com
 (2603:1096:4:191:cafe::96) by SI2PR01CA0005.outlook.office365.com
 (2603:1096:4:191::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 02:15:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 OSA0EPF000000C9.mail.protection.outlook.com (10.167.240.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 02:15:27 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 30 Jun
 2026 10:15:15 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Tue, 30 Jun 2026 10:15:15 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Neo
 Chang" <YLCHANG2@nuvoton.com>
Subject: [PATCH v5 0/2] ASoC: codecs: Add Nuvoton NAU83G60 audio codec driver
Date: Tue, 30 Jun 2026 10:15:08 +0800
Message-ID: <20260630021510.821919-1-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C9:EE_|SEZPR03MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: 07492111-af65-41ba-79bf-08ded64d7410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|30052699003|82310400026|23010399003|36860700016|18002099003|3023799007|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	AaSdckCPVn9CNDhFJrQG6FKpkSpbxOFHEiymLNCBWsaa8VPTocoZxTZ5IL3HU3+OefpmJNskKh/sykIxt1NvB+Q1X4+DnFZElLaRKDWIoZCtVpa1HRyUKISN3rQoJlUuKpDqcVOoSUPNcrO81S+2KE4HXnnOjnxVjvKrHlNj2UnwuR/c3DZ3XRkS4oZ0dVLXWHSCrQ5LSx5iMZBgytVMQQUO8DHHw1l+zTDxiXy/CLakvw5Ix0ZgPjEuXyrODAetAvJCc+vnWLHIV0njufkLe74U3pcx/hMVP29Ry/5Oa/5D6UrfqQzHHgIMUbTVrFh7tU7ieEXT+aDdXmvd530I2CToj9rt2LslcKb5WJdqYaD5fx1TWgviEjmY2De9Q7EpsRvsZnVJzo6cMimWyUq1siy5hk7PbNmigiKGS9G1ENyvjhYlX8nSJreNh86ACRLl4WbX4Ud/Uv1vKpI51umFGXlBaz2NVZDFG2bc5jDaJnBdSJl8V5Rhk3NnUosMaZWJ568tc3Y4syDVz+tUHIZkYaf7LMyb0n48CJ1HSAj6d7eFItqYxqCYLpdtuafrTSmaTnZ/ndOYVw+UFkJhINGxSxbmsOsTiOMAxz8o3Qi/40t8XIEXZ7udQ2IviWA7YmyH5cEIJpz0KgMDsXxJjBAQtYgdVDKL5T4ifekOmjy89cD9e12zxVnmPOy6XnlB09DjKIi0CDxzt9eYNf4X052saA==
X-Forefront-Antispam-Report: 
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(376014)(30052699003)(82310400026)(23010399003)(36860700016)(18002099003)(3023799007)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	rhxVtxszyFnWQnTkWPXKWcWijaypsLMDE2K3VewNfo8uh/13cdhPk1aWyQz24QVDhQsib2AXrvSBTzyE0Yl4VsL9EJ+Gta0icGMxS8w/Rp862kZUxKfgG0sbnZdGBe+lB+z9vhyo/LsTeuKm3kUxsgZZm3rqCbjeXERVS6+uD9LuaXNO9FxpTkRJfHKPTndnOXV+Lf+qpaxTEtp/NEHeok9ZHCuMxodEq6cdntbl+qZe4CpFmJULvjBPIH/0HYvLz1U03TcU1yUBLpHyU3/lmE85Pzkf+IXAU/dN38Sm+VE4MNiMUOR/A4eNMCCsIxzIyg75glKL2/XMmU/fVPqrKWxNIUPDbUD3b9ZJZyaxwzbw+V7dYxngA/WUe1F1IT5yfjJxrG34krYRjzon9MZYmhN2wQs5upMm7j/PT8RJMv4RUtszGCTOXYEByhe5uT2e
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 02:15:27.7984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 07492111-af65-41ba-79bf-08ded64d7410
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	OSA0EPF000000C9.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7874
Message-ID-Hash: UUSK5SNFZOGZFAY2RPAAPBDCWHEPJVLX
X-Message-ID-Hash: UUSK5SNFZOGZFAY2RPAAPBDCWHEPJVLX
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UUSK5SNFZOGZFAY2RPAAPBDCWHEPJVLX/>
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

 .../bindings/sound/nuvoton,nau8360.yaml       |   74 +
 sound/soc/codecs/Kconfig                      |   11 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/nau8360-dsp.c                |  659 +++++
 sound/soc/codecs/nau8360-dsp.h                |  121 +
 sound/soc/codecs/nau8360.c                    | 2500 +++++++++++++++++
 sound/soc/codecs/nau8360.h                    |  914 ++++++
 7 files changed, 4281 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
 create mode 100644 sound/soc/codecs/nau8360-dsp.c
 create mode 100644 sound/soc/codecs/nau8360-dsp.h
 create mode 100644 sound/soc/codecs/nau8360.c
 create mode 100644 sound/soc/codecs/nau8360.h

-- 
2.25.1

