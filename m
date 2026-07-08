Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47AEC43458
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2026 09:36:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 70C056020D;
	Wed,  8 Jul 2026 11:35:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 70C056020D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783503358;
	bh=Vo7QavFbNi5asETs1rhmZFGp/a3gFbxD7P5gppkrO8s=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=vNX/JeaZOl7Y19W9cP9pVSF93D2/71zi3O6iEozSaiBrLlFIC4swd8CY6ChPlBIPF
	 qUNQ8Z2fW4cMaDrjpaI90wK030NiuGgrPTjc9UMcbAE/H0ySAorsIYdvR9zWXkLzk3
	 mDNgFoUR9zs/8+prBUBmvb6Dn00+oOMF+Xzr8qn4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E4E05F805F4; Wed,  8 Jul 2026 11:35:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 81C2DF805F5;
	Wed,  8 Jul 2026 11:35:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A1B7DF8055C; Wed,  8 Jul 2026 11:35:26 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.70
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1783503322;
	b=o2UYnbTWKIX7/WIvc5ESrI2p5rh5yOU+xBaYg3gcb/WqVQKDuOwkZLElxhV8rt8olg5e
	 QoqDE8lVe0SeBsUnMaPNY8N5KtiJrNTL2LSq4ddT2TzwRNeQdCSQmSZaUSkNR+pI5i3qY
	 WXB15tIaPn1NNTXziLkzUWARaxeDWgVVxF7FLPQU7Z0iNuBfxnSR/x7vHYeEzI+V3aXJr
	 xvuqdP4BOaO6eap22O9NqTGT0Dp9IxttjIf7yeABdEeOWOIR80ugaLEE4CWoulpweaFdz
	 KkvVHjl9LA6Ek+qwbC1PFlQHTUWApPOj0x6hV3VrRjKrNgyn0SVKHMPQs/KZvpAWupw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783503322;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Vo7QavFbNi5asETs1rhmZFGp/a3gFbxD7P5gppkrO8s=;
	b=KEIRytYrEmKKUBrCbupckVIOV6J9GyQDG5qElAIacaLMEs5w1oiXj7aJtCsMzSszjRX5
	 HSUYHVyKHTxNyGKP+cvvRy1mXWLn2KkJWlvlUs04GR1/ma7UaaPQZ0SQxlJBUcKZ4xNYX
	 23aS24OleDBIYv/ihKN/EU2dsHz1XzGwZbcBEtIDB1GDv+PZUGLarjbyzGthqPP2iImTX
	 YaPcWWJQs4mj0oMUvjWOGc89Z4rDR4+pRy+1LzpANUTzaMLuhYWSgFfXLmqXAwcR7zvvN
	 qQMw7DmxLg/tYAMq3Vsl+BoLFr56RkmCq36nOCiTc/ulBwg9IKnZMmOsIGgdKte+Zww==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=ieRM3NRz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.70
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11013070.outbound.protection.outlook.com [52.101.127.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5A7FCF80224
	for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2026 11:35:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5A7FCF80224
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=ieRM3NRz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Azry1GfjTROSSyas32VFz9IRzAB5iYeToPkN4QvtMf1fZXBiLGAKZRz/EGu/hWZUCovC721JbIQm2mbOvRRArsogESA/hkBKkFosw7oKVSpUs85WDq6oXmTGdRkHjd4EAPNsvyjuPcKMiF6amp2oqliVnxk4eRD0Md5EBKT1kCRWatlk0pZes/LifiHKn5p7UmQewUmui+jGRodQAFvKoe+nKT6+G1/exFiSqOiBA9RO/NOzXGokmpRCXBSb7/aaEFMVUqVZT5fZmv/yrYALi8zV3jQD+xaeqYQh52yubwdmjJRTeZkAAc0eyKydXfIDMhCO18glTn2I/18MO79n4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZoYuLI3GQaWZ2UOk7osYzdBDatsZsxJir/TjlrntbA=;
 b=esOKKXXYtlmA2r7fFH2IpgQBasAlk1NbEzKqyghOPOZv3LudFMHZo0DZoMDbQfwCMdzY1BCidsLsxEzjAreqTz0IXLl/RNiPH+ktOF4OfrQXVhD5a4BQ06/4rR6Bz100qxyodXAso4y8Vw7cUdMwyWPajpJI5boCp/T8dleP2j5ZzIgBLstTc6W+ESbK3VwQvAK8f7ZsenF70R+DxBKuhgL0VfLx5VaMmztJnYpiE5N6kILVx40CVz5MeAQzC2Qfuj17jeGrFGEFAX9OiZxs8h6RavahwQTmjccEvgRwCnY2TeakHtkIFII6Cv8Nwml17a90xvC9HUWeBUDwZvhuPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZoYuLI3GQaWZ2UOk7osYzdBDatsZsxJir/TjlrntbA=;
 b=ieRM3NRzeCRUOx7g09Dfg1z6kmvxpsJ5GJpaHDysnImAHPfxKFnLSGCAtjFwAOhwakoRyk5+LOgO+7ChmelNXO/V91tjPR1RhWKNcJMlcVQrIyQO48eOICphPx0IsaembMMh4UJT2BUMk2KCHX9uPhlZjtIN1iEXFu68JDICUDMx8oB0qxD43WR7Bb07AnnOB3sjTFQRoYB7BguyrrQqnALwgxAEn851JUBmjov41AejhXcucYzmfz1VgGYcYBG23emBvLlDE8p04pnpQfu1v9yj1458ocJ9BeCAobugEOdyHBJPJWtxhUUlIoMqn21jyoGVtA+Lh4PtRULT5pq81A==
Received: from PS2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:300:2d::27) by SEZPR03MB8582.apcprd03.prod.outlook.com
 (2603:1096:101:22c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 09:35:13 +0000
Received: from TY2PEPF0000AB83.apcprd03.prod.outlook.com
 (2603:1096:300:2d:cafe::a7) by PS2PR01CA0015.outlook.office365.com
 (2603:1096:300:2d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Wed, 8
 Jul 2026 09:35:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 TY2PEPF0000AB83.mail.protection.outlook.com (10.167.253.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 09:35:12 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Wed, 8 Jul
 2026 17:35:11 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Wed, 8 Jul
 2026 17:35:11 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Wed, 8 Jul 2026 17:35:11 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Neo
 Chang" <YLCHANG2@nuvoton.com>
Subject: [PATCH v6 0/2] ASoC: codecs: Add Nuvoton NAU83G60 audio codec driver
Date: Wed, 8 Jul 2026 17:35:04 +0800
Message-ID: <20260708093506.895481-1-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB83:EE_|SEZPR03MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: 50ea5432-3cf2-4631-ed36-08dedcd43602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|30052699003|3023799007|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 
	Gohjs/EZ6hwNo07tBHah7p/9z2sNVY4+r2cp2W2AUstxU2NlZ13mPZEwwQRgcqoVe3v+jc8JKHO5JjaDdgW5H5FLdmzxW5b6EHbFkwIfeGMx6rUqTbgpACCQT/me3/IsQkElpDBPmvMoCASUdGyNHLx7SDV0jPIMtMusT1jAqTQGdwwLvKh1ykIo3WN1RqQTyFMpGoFbOK3j9WucCr4QRJ4pjWjtZsn124GA4kmUm8zzb3QMXNXStd5o6Ga+44xK5stHjpb1B0hYeYKDipAw3r1j43fqIhiCvfE35awL4QeS733WYJk8l3kdxHSP5rHGqhBGY/FrVvwqsWDVJIIK2DwgInsX8wW2+AqGq3M+3Vq9vqB6XONT3AssQOz5b4bG9HVORULtVmrGYduntDvSKy5uIbvhEwzwiQhtL7JAn8M3kys7b9LQJ1m9wNSMOkbsrY84J9jcSuIfoy0ZJvDH/GNZ08koZXQO+lx0tO0Il6r4VRm0okxL+NhhSBCOAJL2NrP/4RkHacx1cejz5B20eZis1MgK/UO65VIVePw5wc24vXzm8l0VgQGYX+bJcZCcrdvzgQ5ok9MX1mdQiIp/ou6D7BXWV5qbluyY/nLtW+5LGAf1dEIUNrqs/vibRmlwvQJKWe+FNfzCamoDmfGPmn/+VF54+kqrrTdiNdeb0wBV7dOKG2rEFCb+MbI7SiFKuWRfQaMhzsgYoalO0cBtww==
X-Forefront-Antispam-Report: 
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(30052699003)(3023799007)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	plXzIknaWrv2wfWD8le+/q94CGN/RFI702tyOhM8cKBNVUnI9WVYN+iWVvaZJxpFEGMSulUD8fOYuJpMMcefkVs6XygJQoJaHncODs6/aCsaNd0IZJCQhoUZxi+Zl91iGymG9EiAI6CDejmfO7zGaAc/fVEecxWcws10HYYihxo+5u0B4/iQGUSqbXsPuIcEJIO0PR4WiGlBqJXnjvPd/oFMYEZCyTVp0gDRQ/GKSt2rFv+s2ZggfTXqbOKC0VbfZzx/snMxgo9Z5eK6quFkPRSqOc+YrDwTRjSNxgKZ3/qX+Armrlp4NZ+prqHCtEWttawBJqOY6YS5AQvUHNrOoCvVzGD0Gdp/k2OyC3Pe94Tbr4oxLYvH2stVEyDKEUUOiEftzii4EjGyAtdKboi/E0wZeu1wb6fsNIENdpokV9IwE2YJfRnJC20iyTKIxga/
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 09:35:12.9185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 50ea5432-3cf2-4631-ed36-08dedcd43602
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	TY2PEPF0000AB83.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8582
Message-ID-Hash: 7GLBL7RIKD5TDT2W77EGWH44GZKJ6XN5
X-Message-ID-Hash: 7GLBL7RIKD5TDT2W77EGWH44GZKJ6XN5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7GLBL7RIKD5TDT2W77EGWH44GZKJ6XN5/>
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

Changes in v6:
[dt-bindings]
- Removed '|' from descriptions.
- Add firmware-name in required.
- Add "nuvoton,dsp-tx-slot-mapping" and "nuvoton,dsp-rx-slot-mapping" properties.

[codec driver]
- Fix Use-After-Free during device unbind by properly synchronizing asynchronous firmware loading.
- Fallback to default firmware names if the "firmware-name" property is missing.
- Parse "nuvoton,dsp-tx-slot-mapping" and "nuvoton,dsp-rx-slot-mapping" properties for static TDM routing.
- Drop dynamic TDM slot mapping via ALSA kcontrols.
- Replace cached tdm_chan_len with direct register reads via nau8360_get_tdm_chan_len().

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

 .../bindings/sound/nuvoton,nau8360.yaml       |  113 +
 sound/soc/codecs/Kconfig                      |   11 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/nau8360-dsp.c                |  665 +++++
 sound/soc/codecs/nau8360-dsp.h                |  122 +
 sound/soc/codecs/nau8360.c                    | 2241 +++++++++++++++++
 sound/soc/codecs/nau8360.h                    |  913 +++++++
 7 files changed, 4067 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
 create mode 100644 sound/soc/codecs/nau8360-dsp.c
 create mode 100644 sound/soc/codecs/nau8360-dsp.h
 create mode 100644 sound/soc/codecs/nau8360.c
 create mode 100644 sound/soc/codecs/nau8360.h

-- 
2.25.1

