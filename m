Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC824CD5BC8
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2026 01:59:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0EB6C6020D;
	Tue, 26 May 2026 03:59:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0EB6C6020D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779760784;
	bh=TMdtmVrPze5v80uf5JpknVLKFE7rMBsK3lXJvf8nxmg=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=M01eXJvwEU/m7U5M6VgVJMYA5xNq8OGWUqkefyE3JREJBAxBzlEQBYeAqyzmwZtwu
	 r85BbemyKJBa2stxWkMI1NMZL9gq33Pl8RRljqkTYsgLF16Nm//MsYR/x2dp5yeou1
	 Vhlq/8qwvsS+GTzMOvQONY7/3XQAKOTJDgBifn4E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3BB64F805F4; Tue, 26 May 2026 03:59:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D3122F805F5;
	Tue, 26 May 2026 03:59:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BF7EDF80217; Tue, 26 May 2026 03:59:00 +0200 (CEST)
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11012028.outbound.protection.outlook.com [52.101.126.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 24E63F8001F
	for <alsa-devel@alsa-project.org>; Tue, 26 May 2026 03:58:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 24E63F8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=Wloz3vmA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEgAfCMGmJK0vzjGPUbOit8B5OOoPzZj3jh6SGzohAOLra/G5KQ4uXIT5+FnoHGCEeBoWsdpJhjEimOm6O3SWJoItoSCUv+BfdcRll5MaSH8nbTFXJF2+O/xQSROIZD1FR8e73PSHJ2z3+vfuNq6XLdHYXLpsA3Sf1lGg8c2pi1v7uS4Q8onPzgd5hveCTSGmWyHg2m6X1W8t/zGCGXNzll44vNh2FOK1rzaxPKTB3oOzfJrEutQkGKrfxxtzkLE2O08TQxF01/8ITCS/1RpOh9N+IIwcZRdA90zwv+M2eZB5yeiDLf3I+INp72yKCfd7fKKC3n9COjcmUUM7gx0zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8ijlKxMTEzADqJFMf+JZ2YCmRnyTT0MQ7Mwm93P5UY=;
 b=czhNIvvoYjyw5ztkO4G1SWk/UfJTPFLquI92Lga45AsDL5rjEslxxgsdzz6m7bDOv6OI5csP47cm3/hiTdJfVDSjpIuwj35BU/PCyqjqC55iAXKBBIBRBuzb+LLSX2ORPDAp2ytUGHblfVD3jrUlnW4POLjSDbttTVHRp2qRFtGniQeX1WJpeGm2BdkZiBzNNLu8xPrbKdiACIcDF68Ja7TxrzQAhSMZYfHPAyu8k+hmSTNjeq/VC7KHWkAPPlwW36+2Vskg/RRx/b+5ttD5LsQ5fSGMO20JX7YYif4RTlgtf0XyngmS2s77ROzHHzsEKAWnFb/Jruxov/lMdy5tjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8ijlKxMTEzADqJFMf+JZ2YCmRnyTT0MQ7Mwm93P5UY=;
 b=Wloz3vmA+VXYRK8S4SCrAPCZNdWzaJ93axSjrHaB+Sv4wshgHpP+X8Cr0bar+o9vEOPlhO2oRu8Jyp+M4cSrMt10/JkeVM9C6Sgzz1+wkDlr6kAODrvoF7GwLWsFZmozZDmEu5wFbJ6jVK9wgjMyE985fLwvXh6iGwhQDkXQzaclj9fVZYArPdq3VhBqilF4QJN8feS+BU7oJ4EQeEye8NWleI5kKBqvueMe2jZ+/Fklw1jjVbZeLyiBD855z9K1Rc1MiF3KsRgFrXYelDKaPFMFnqVPdph3tlej6a9VeDG0ziN5DbITSdYVy1f4Opip90rT/tTt+z+BGSHfhdJ82g==
Received: from PS2PR02CA0078.apcprd02.prod.outlook.com (2603:1096:300:5c::18)
 by KL1PR03MB8824.apcprd03.prod.outlook.com (2603:1096:820:140::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 01:58:46 +0000
Received: from OSA0EPF000000C7.apcprd02.prod.outlook.com
 (2603:1096:300:5c:cafe::7d) by PS2PR02CA0078.outlook.office365.com
 (2603:1096:300:5c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Tue, 26
 May 2026 01:58:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS02.nuvoton.com; pr=C
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 OSA0EPF000000C7.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 01:58:45 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 26 May
 2026 09:58:43 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 26 May
 2026 09:58:43 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Tue, 26 May 2026 09:58:43 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Neo
 Chang" <YLCHANG2@nuvoton.com>
Subject: [PATCH v3 0/2] ASoC: codecs: Add Nuvoton NAU83G60 audio codec driver
Date: Tue, 26 May 2026 09:58:24 +0800
Message-ID: <20260526015826.440769-1-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C7:EE_|KL1PR03MB8824:EE_
X-MS-Office365-Filtering-Correlation-Id: e0620bda-afcf-4c4e-03c2-08debaca5221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003|3023799007|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	aQ7RTfWGkd2hwQllv2IiP3u3hKWvQGIMjKrSrKkFgIc1D4twDxIZVQZResCtUfRT8MQjPF5NkyA95z5aqUhw8/zNK4z0YUPpErXcu/U2SEF4nSbq3P+AKzST8jlpDdzMPwKA4j1keDXiWIeLvbX0E5X5BCtZclu66dKCsyBDcnpbonTNUnCgVPryXF7SJr0/gDHKN51s3B+ppQV14eTesMyRTuxHZtPlgAuNlXUScUeYmFsjnWVPrwy1+cLJcliphEjam9tynuvQ7HoDhG9vWGLdGUnMzhQ6TzvyxWhG/K14k+XQxce403aToQXY1OZDh4hbUDGCfNhCEhcOc1b7eW1kuNNoQUxbyWNdnRL3TPNkZUvRlS55mJl8AWdFQiQ0t3k+gMPXved1n3m0uSHg1is3ENh5vt/t1q3Eld+IVcw/RDd7BHZ6nYk3iIVk/a68QMeoU5xVlSbuAQjP0kPUplZAmtv6j/dFvyGC72N0boXrCxl2ydQDpxn2226so0hyRFv7uKygcx7p4sTZ/J+mMfdiyoqur9CqkLF57cTjmUFZll25LYp8n35LIfWYjuS79rNMrM3GdcJq7gmDo2c6ZtS7K1++GowlIOkCtzZ9YL+s0fKsbCyixxg9doldSjnVrUWHtGPrBLPVw1RPZi/CbBxvHxDAcBwe7ERJKd7G3fk6lzTOeAIM7Xtdafx5EVITE3GTtL0bAUOcnvwJMjG+uQdpa69fON3a4cU7Ksbqh4M=
X-Forefront-Antispam-Report: 
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003)(3023799007)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	OOQuiqo/Rmp2G/1w9M6jK/66+4r88M7XMt/wMLeqXFFBSVBG8BDgrhD9LYC2HO6Nj9bibLXbw4lqUxTWB44vFR5XL7XlLawi3t9th6+HifqOD0fhjC8kF/sh5uJWRzfzlrat/mvusfbG9ab2A0wa7T7iVNCdzojJKK4evHvv6x01LnTOxZ4qdA/kuHVa7/XJf43pu/albqg3CO3EJbxYwobiIsjDiwfy4S4XBocrojtq9/NDNdi+M2ui2Gb90Zn63hfloOEnWKooAcEriWPB/9SmLabuJfe4CcgEuvOxDiRGLnR5ERyPPVNVrJaN1meiAHRDFHGrex7x4yY6NLo/wwhW8YEUlv6/fBu31cOyuMPCZpeHm8D4hEaDN9RoHcn2daIFU1ElPB9Z534sOGpA8gP+w+jg9KPYEtCafmrJDKc2Bd2nMb+y22wnHlvaINfG
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 01:58:45.6292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e0620bda-afcf-4c4e-03c2-08debaca5221
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	OSA0EPF000000C7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8824
Message-ID-Hash: O6BZGFNRKDKKT3TKNJKTBJL4LS4IE2LU
X-Message-ID-Hash: O6BZGFNRKDKKT3TKNJKTBJL4LS4IE2LU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/O6BZGFNRKDKKT3TKNJKTBJL4LS4IE2LU/>
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

Changes in v3:

[dt-bindings]
 - Remove colon to resolve YAML build warnings.
 - Fix 'firmware-name' property definition to comply with binding schemas

[codec driver]
 - Add Kconfig and Makefile entries for the building system.
 - Change block comments to C++ style.
 - Add initialization for 'data_count' before usage.
 - Fix a potential stack buffer overflow in DSP reply parsing by adding a strict 'data_count <= 0' check.
 - Replace magic numbers with descriptive macros.
 - Return -EBUSY in `nau8360_dac_mux_put_enum()` to prevent playback disruption.
 - Remove the 'GFP_DMA' flag as DMA memory is not strictly required here.
 - Convert multiple 'if' statements to 'switch' statements.
 - Remove internal hardware debugging code for GPIO1 to GPIO3.
 - Initialize TDM slot arrays to resolve `nau8360_set_tdm_slot()` setup failures.
 - Fix event_missing and event_spurious in TDM/PEQ put functions.
 - Fix uninitialized variable usage in TDM slot put.
 - Add "Slot None" mapping with custom _get functions, and optimize I2C reads for this state.
 - Refactor TDM slot validation into nau8360_validate_tdm_slots().

Neo Chang (2):
  ASoC: dt-bindings: nuvoton,nau8360: Add NAU83G60
  ASoC: codecs: nau8360: Add support for NAU83G60 amplifier

 .../bindings/sound/nuvoton,nau8360.yaml       |   86 +
 sound/soc/codecs/Kconfig                      |   10 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/nau8360-dsp.c                |  704 +++++
 sound/soc/codecs/nau8360-dsp.h                |  116 +
 sound/soc/codecs/nau8360.c                    | 2454 +++++++++++++++++
 sound/soc/codecs/nau8360.h                    |  904 ++++++
 7 files changed, 4276 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
 create mode 100644 sound/soc/codecs/nau8360-dsp.c
 create mode 100644 sound/soc/codecs/nau8360-dsp.h
 create mode 100644 sound/soc/codecs/nau8360.c
 create mode 100644 sound/soc/codecs/nau8360.h

-- 
2.25.1

