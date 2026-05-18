Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F43CD4F3C
	for <alsa-devel@archiver.kernel.org>; Mon, 18 May 2026 02:48:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2CA7C60208;
	Mon, 18 May 2026 04:48:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2CA7C60208
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779072497;
	bh=d5yGhPnLvVidyilPRk2XwyeECp78GE0H7MqweQF7q9E=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=cBchc5QTRGcBi0ulivfN45/r+OBpsdsaexr6UQiOguOrJOwIkK9X+YOc+1vH1vGdZ
	 K24/csKhY6vHcVB9XFQQRecVDqukx2ZO4Cip5w4994zJgSNj+hlMjHLiPvb7BKnNzY
	 nAiV/qyrLk0FmexVo3/VM9S/wbLFM6OcTzQlyllA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 30ED0F805F3; Mon, 18 May 2026 04:47:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E578F805F1;
	Mon, 18 May 2026 04:47:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6EC84F804F3; Mon, 18 May 2026 04:47:30 +0200 (CEST)
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11012005.outbound.protection.outlook.com [52.101.126.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6A898F80088
	for <alsa-devel@alsa-project.org>; Mon, 18 May 2026 04:47:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A898F80088
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=oOW6+Ml8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTu6a8yTQKebyhi+BRgtuRy9fQDptx8P7HbbVCt0jZzJU6FRRvgUGVZpC5TLNFWYDjWW7VWb+3tsTCm2Ffs4vImBkJuXDH1zPwMBNdJNHgU8CtkVTdFADTBnVp07WZBc4P2A0NgpRZ/r0mu4vj9861QyhzxxEITbwcnNTXH7b/oCRO/4Xn8RMajtGai/DEVLzLCzysjIPPIpiw0Lc8XHJd4J2Fg0q4BUk7ImfvHnth+L//80K554fIqkuZ5LBIkT3DAlBpzOi1qm+LCZkeIGfE/7cTf5Wtaa9ygCHkwbfrR4MSDNLdUd28dzcqy5NNWO67DbOeIDFlaC8mjV+w+4rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYiEkg6Hqid8AjshCKGM1nBEI6HCekW52k20ISwnC10=;
 b=CRKAgqEZLSaTTFovJvGki/kJFtwWJND6gO3SDni2rYPQoc0xcSBS2fxItY02q56f8bQPnBBu1JF06s9xF+cB3+Vs669pAmBx+BgfwCxC7PGXrgSEDxgAuDG7tjVgtgoWtItjABPftEr5M63sinCXPhJHM8lJwcB1JOT32wC6dM3UIs6ZNJdr09Ik/YgbSHzfkOtFzQRtacNQ5P6BOqqKgH7VBeTjh674V6EBivBzrWg/HS+AlfSERUwN8YvNuuVtTDimICDA+bYy5hTIk754pOjqjnODDV0AFcotYU0cG8sGeWLFjQjP+yi2bYqQ/kDxinaQ+UiOKm/w400HPpohkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYiEkg6Hqid8AjshCKGM1nBEI6HCekW52k20ISwnC10=;
 b=oOW6+Ml8YlWrbyOgI5oziSN0VfwpGrp4CjLkkiOniJM19GbWlZar4WsAvxMWJjQyh89l5dz7v7eQuBmrQHyMhWHL8LPIy6ElXs7FrPF82b0iCPQ/0PdDWCKG60AmcsKggSTydAp3d30MujkKJoXDMnJbavHcVhwKrg4BI/QfPLlUC6kVxG/4/f/ds+XK5E2bNbsj80KeYm4Fhaq8pO5rESNGkPVfAz/6zH7imp4Jv4cqrtyXQXczkrxjZ/oe18OOQoqxxyMfDiECV2u2GXqUMyt0/pB5+xtWwz9Z7lGg2DxWsKLNlOCRABGIZwU/NsYB4YSJW+VgSMzRx6SuFVqA3Q==
Received: from SG2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096::13) by
 OSQPR03MB9372.apcprd03.prod.outlook.com (2603:1096:604:427::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.13; Mon, 18 May
 2026 02:47:13 +0000
Received: from SG2PEPF000B66D0.apcprd03.prod.outlook.com
 (2603:1096::cafe:0:0:89) by SG2P153CA0003.outlook.office365.com
 (2603:1096::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.2 via Frontend Transport; Mon, 18
 May 2026 02:47:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS02.nuvoton.com; pr=C
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 SG2PEPF000B66D0.mail.protection.outlook.com (10.167.240.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 02:47:13 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Mon, 18 May
 2026 10:47:12 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Mon, 18 May
 2026 10:47:11 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Mon, 18 May 2026 10:47:11 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Neo
 Chang" <YLCHANG2@nuvoton.com>
Subject: [PATCH v2 0/2] ASoC: codecs: Add Nuvoton NAU83G60 audio codec driver
Date: Mon, 18 May 2026 10:47:02 +0800
Message-ID: <20260518024704.118613-1-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66D0:EE_|OSQPR03MB9372:EE_
X-MS-Office365-Filtering-Correlation-Id: b55d82a9-3d5a-4b84-2dc0-08deb487c3e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: 
	L8VoHMy3nvUQc5cQPacG+8i6699mUUKTSMfs1iitPnl4meAxcqGR+d+tQwW/97LVrHDzNlDmz1fIZZMYqZzCYkw+NuFw6YilwcyfzK8bQGP7T4m4KROVIdayiS2M5ifp/hctMjbJEA8ncy6GvIps8xy+Dkech7juXa2TtT11LSU7Hmf4l2NJi1PHcV9X4jNS6lnnNoHWyqgiwrOUiVHu5RgpU7XKaC/uv7NVB+/B4/K4WsQ1FWux4cgdUqOhw+xRPWH/1gsQjKQ+FUMXsocIdvAQ/DnCZtHxa6EL3VJzqdQWBia440fPJL/khUHPueRmO7IZ92VYvdj0YAatsd2yhcMdtbjJK/nyRaoQW7DKthBpfC1MTSssYDN/UrdVI0r1A+MHY+ZbtPnCNOYmMOdXv+3u8+4jsiFiKD4HB23TisC0QqfDGn5loMuyfBkMYbMyZP3m3lKrFsolbX1hG0P1T6ojrF70WYO3lM7MVt5N6L2f2VIt6Ebp5Ud61LgDc4YLHxtrllkRHH03aC6o8OMeEn8kcu8O6bE8wUanWD7+JGXhotzOhVi6BLhOlPH74HvXU8XR/YwqUzsp2qCU1zwPx9viy7nImRvdpS76h9u4o4eIebX3HgKLVcv31o34btB3vbFTgQU5b5SuxvWzQJ67iQ9xxni9FyhW/LHbkEiBmjOYBfbUggK74lXgxsSMpv+azOpJvqz3YQ4AGU4DMMLCUaKEUUCUBQTlIkFPpUV8sRI=
X-Forefront-Antispam-Report: 
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	IpQAg/7vN8086ugOO6LxAadXVAHwhRca6Z6BB4z4jqWVuAygc8Rrsas3gSynuIdcv4grzS44UV1uqK5NlKZkkbo3a4el9WsiU85v6M21zvg9pOHWtitD2SyHpn3hxiGQfwjQnKx7LG4vBXJSRYyglKcMgwc+PwJsLbUFZQyUix6gAAC9d/BL+yYZr7gT6NcmUaBV0/RM+c5y5fvrzoOw5uwkq+Ykz+QSpOIQpNHtiqWJgO4hSauWs9YVrpBDCGC2mkLqUyv8mHCx0tb8eQD8TLoMAsq1KAEB7KHUS15BG5BxEpmhH/OThICIADg/oiklbKOuTlfiCNxHUfwmVSPffCMFOcTyEccGzJkJwlUH/2yqGyq3pHXRDk/3CW/vZGN8g09ZMa2yhKzssFX4/II6ezNarUM+zDXAHPAwbxXHKJNy8oOB/Tczioyo2gmauQZb
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 02:47:13.2252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b55d82a9-3d5a-4b84-2dc0-08deb487c3e6
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SG2PEPF000B66D0.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB9372
Message-ID-Hash: AOLYUU7STTBSEB265HCMC64RN5X2W5ES
X-Message-ID-Hash: AOLYUU7STTBSEB265HCMC64RN5X2W5ES
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AOLYUU7STTBSEB265HCMC64RN5X2W5ES/>
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

Changes in v2:

[dt-bindings]
- Dropped the word "driver" from the description.
- Removed runtime/software configuration properties:
  nuvoton,low-latency, nuvoton,anc-enable, nuvoton,aec-enable,
  nuvoton,vbat-microvolt, and nuvoton,tdm-channel-length.
- Added missing "nuvoton,dac-cur-enable" property for static speaker
  impedance matching.
- Removed unnecessary '|' formatting from single-line descriptions.
- Fixed typo in firmware-name property.

[codec driver]
- Fixed nau8360_peq_coeff_put() to return 1 on value change.
- Refactored TDM slot routing to use ALSA kcontrols instead of
  custom masks in set_tdm_slot().
- Switched regmap cache type to REGCACHE_MAPLE.
- Dropped hardcoded DAC gain initialization to retain chip defaults.
- Used devm_snd_soc_register_component() for safe unregistration.
- Separated TDM TX/RX logic in shutdown() to safely support
  full-duplex operation.
- Refactored TDM enable/disable logic: moved RX enable from
  startup to hw_params,
  TX enable from startup to set_tdm_slot, and handled disable logic
  in shutdown.
- Moved software/runtime configurations from DT properties
  to ALSA kcontrols (e.g., DSP bypass, low latency).
- Corrected supported PDM data length from 24 to 32 bits per
  datasheet specifications.
- Updated firmware DT property parsing to use standard firmware-name.
- Removed redundant VBAT bounds check in nau8360_sawtooth_params()
  as it is already validated by the caller.
- Read VBAT level dynamically via register instead of relying on
  a DT property.
- Cleaned up magic numbers by introducing PEQ band enumerations.
- Set dsp_fws_num to 0 to use default firmware paths if
  "firmware-name" is missing.

Neo Chang (2):
  ASoC: dt-bindings: nuvoton,nau8360: Add NAU83G60
  ASoC: codecs: nau8360: Add support for NAU83G60 amplifier

 .../bindings/sound/nuvoton,nau8360.yaml       |   86 +
 sound/soc/codecs/nau8360-dsp.c                |  704 +++++
 sound/soc/codecs/nau8360-dsp.h                |  117 +
 sound/soc/codecs/nau8360.c                    | 2334 +++++++++++++++++
 sound/soc/codecs/nau8360.h                    |  904 +++++++
 5 files changed, 4145 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
 create mode 100644 sound/soc/codecs/nau8360-dsp.c
 create mode 100644 sound/soc/codecs/nau8360-dsp.h
 create mode 100644 sound/soc/codecs/nau8360.c
 create mode 100644 sound/soc/codecs/nau8360.h

-- 
2.25.1

