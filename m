Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBB7C5B572
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Aug 2026 02:30:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9C21460253;
	Thu, 20 Aug 2026 04:30:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9C21460253
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787193031;
	bh=cHEv5oY/hZWmFsPV+YxvtlK+eN1WKAKjGOtAmmW4zN4=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=awXa0eO1PkWaXtAmT+tM4w2EPPD43MK43oqBxWiNZhBn7D8cXQTC8ATiFZNS25zqf
	 r2DflDDHZ31c+iGjjXwJYujEBTZoncCReoyXMMnf/c9xztpmEkrDaKm8r/Lap+s9Da
	 BN3zmdPR/Wz63NL8IAfqAtG4y3dmqXQ786ZJr+10=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1443AF80601; Thu, 20 Aug 2026 04:29:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0D4A0F80602;
	Thu, 20 Aug 2026 04:29:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D0EDEF80587; Thu, 20 Aug 2026 04:29:46 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.4
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1787192982;
	b=bo5Nj+v5pkOzXUdgbS+5cW+6qHGZsCOq0bkrcc0DJZsFCVOT6PXzW8FT46vgcpoEo3KI
	 0u1Ly3e+Bv45gCmkIlvz4/R8y1BAkZrtksxfs8VhYIey6rZYzdg/rQdr/TS9v7/07Mo2u
	 p+R/MAVDZMnlygwnPCetvv+JzOl/0uZ9kK/dUlF8nPS5pjMcJB4JeFQTl6lxCsDZC3NTl
	 eXkjfON+dVZwyXKxlA/IPA9ZOQtjhM76utGrMxykWyXSWwNp477A2X9pRKs0BWdPXrzH6
	 tYL3CnUZFp51Ybn3xH5ZVgRcWp0vZbtwgFMw40zzzb4JC3CANYKtdAvjBJ6ypDpeR/g==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787192982;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=cHEv5oY/hZWmFsPV+YxvtlK+eN1WKAKjGOtAmmW4zN4=;
	b=HBOiw93zSBmzWuHSc5hZHQhYjwoyHpsapUWDp0l+ZcS1S95WQgIbLYfn6YJe3FZXtudy
	 C0hP6eLJwuPGR6e/SrZ4YiZmsvE4n1RDXAArJP3RTVgL5xmoLDqtWHX1WWKvyZBGDhAEa
	 ggxFLHk+XZ7ozpI8AT/nTByoCMWavRiV5jxtN4a2bwXlfFk22G/b9ldmEeniMGTVFzZg4
	 El35n2Z61X+bAxkMPSs/IXzRN1mwvkUMGfdpGJ47Ir93RTHBxj/oEW0DqyEwnG1Pj16ZG
	 Z5vzSpzRRCnq3hwuoR5XfpsjkxTitCQP/7Ku4igBVkuc60rJsVsT90724UFyJZh2A0g==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b="rv2sTh/p";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.4
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11012004.outbound.protection.outlook.com [40.107.75.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E76AAF80246
	for <alsa-devel@alsa-project.org>; Thu, 20 Aug 2026 04:29:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E76AAF80246
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=rv2sTh/p
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHCKyrlMyE5yazUbL8ak4CS2rEHW5hakgIbFnHYVpZtkZeRB6Va29qWchgVtE+83yC8306c4Aai2jKUfTg0zmKSQWqXVoJXMiiz4ysRvp9Y8+nlxu+zjAK/jd94tK+qQ3HB/HmRBsthJuH1/mW9xDjGG/9vMn6Ey8E5tAA1IJhKOYSMPIyWWSNQmILBWzi1b+mgq505zbiAelZ1XFPNtcgEmDoYjhRmFkUdyAceqHMV99cm0YSMjOJ7Cg4fHiETByuoZppsNGfZUXfE/IGdYnGq3D3k2bChjRiLBDkFmHJbd7S5VZOyM4gDS7yZN0IiHlNe+ZlcnkoW5l4g4HYZgUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpnt91yumBjhpiLaosnTdcznESxpfMk/PA13NtYxCCY=;
 b=M6jrFqZxoz+MZfXw9N4NRJQVMSPJODjxeoLS9lQgIZf8aAHR7ztHhbC3d63KlmogtKySQzFxe+HJaC8llKYh8kdfPuLR5470drPhxuP5vwDZa4QPbH1W8+8NA+D+ZtxZ5yCYWwX9/1sDUuYvW3xmWdYiB3HoYCYJ7NxtVch6ncrKSYBuhm49bxAUt0YLwRj3AgJWAUV3el7aghJLMbltQA4bI6fvaPpFevLGfdgz8rnBPKTAmg4pHvroShIne1gx7pF9cLKi0SsIFTv3C7Mr+HiUNIMOCQ0j7l/NScDkUe4UrlTWuXSjL08ZnPHNeLA5NGM1sP+KaloyaWcIG+Rjzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpnt91yumBjhpiLaosnTdcznESxpfMk/PA13NtYxCCY=;
 b=rv2sTh/pthmJCuEsWRBhKQeo6y9u6GKjEruMGtBk045r21cFR8KiG5mPB4FWtTWND66j47vku3EVnJnOXFTwTJ2g8Fsu36GWp7oaxsqGmTuRZdRPs6u2tgv9CXbxVnM/KCdZJFmhJigBsTQHmTFBRqUe5DZl03jBLQG+hjpNwAEz/GXCGH/qqeOmzIQWBfB4ha6hsV73NKsUff7Z2jQ30F+Wi7ZA3Ju5nUfCBmfF+6fyf0P32zfcrZFB/CSk79OnBwJPGGOyo0QyW5X2jb3VrttVOgs+D+Qr66Mi01+gpGv+cEChCG6yOshUMqyxByR1dWpCmXtrOv47aMIt1t3TGw==
Received: from SI3PR02CA0004.apcprd02.prod.outlook.com (2603:1096:4:295::17)
 by PS1PPFFB2C7A3AE.apcprd03.prod.outlook.com (2603:1096:308::2f1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 02:29:29 +0000
Received: from OSA0EPF000000C9.apcprd02.prod.outlook.com
 (2603:1096:4:295:cafe::7f) by SI3PR02CA0004.outlook.office365.com
 (2603:1096:4:295::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Thu, 20
 Aug 2026 02:29:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS02.nuvoton.com; pr=C
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 OSA0EPF000000C9.mail.protection.outlook.com (10.167.240.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 02:29:28 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Thu, 20 Aug
 2026 10:29:26 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Thu, 20 Aug 2026 10:29:26 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Neo
 Chang" <YLCHANG2@nuvoton.com>
Subject: [PATCH v9 0/2] ASoC: codecs: Add Nuvoton NAU83G60 audio codec driver
Date: Thu, 20 Aug 2026 10:29:23 +0800
Message-ID: <20260820022925.1174132-1-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C9:EE_|PS1PPFFB2C7A3AE:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f69517f-0083-4220-4ffc-08defe62dc53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|3023799007|56012099006|10067099003|6133799003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	Z2CQijmWKjq9phUqHn/wW7hgHlL+ZBFRDz9IVVlzCBOfI6txC5T/TyyjHUc54v6Ss+PPmPQ8NrR58k2fU73IOGw6Bl153sDDA4qCnePgq3U9v8ic0sjzn8cnsuYlf125Cws0D8lk9KnoW/36/119DrQI4dFIKWm9XireNFdCFXa+nAc9HXVkS8aBYKh55el7U4FDVDeUFo+GyaoaL9yKnf7f3UMwc3avZPTBPSHhD0dEp2G7/T4jvv4MMlx9ueiXpndxaeeL6Dr8hH8Al4TEzbGRgUDHaIVr0eJFagBizu3EsODZfhXBPceV6BK8SxYU9fURZ+zyMURXOC/R3JNViK5LE5mG83E3h6SUiqrIN3dSCj6m+c8A6NBthIr1kLERUK3/GutpTBHxXscZyw7zwI95zwtEQBxjGQYKbECv0IR0i9eNpWloAP7oTuJ6TjbwZK+CMJlKQh89+VjpZLxL2y/PuHIhpW03kdE5PyCPywT5/70yhE653l0K6SsQUc5ADJTPPsiiXK1Nc+yJ1689MhrkVQ+FAF8/T9J3nVoegRJwkrsscLYEaPW76V+0/4ct01dnXJu/tGSz1N0N+lzyhQVEuW2LlTlLGYv5NUMUd2A7ePWIXvP8JGsHQTK+DKLLn2RkqbOFICQB3u+2Ap6IE0rZggZliSB3TR+8DeJYziKJnbwm4Hz1VBeUvMV9B9F009iSWxLhD62p25qaSdG3UA==
X-Forefront-Antispam-Report: 
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(3023799007)(56012099006)(10067099003)(6133799003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	qmrmlyuFkrTzZk26KYCsB8vkbQw4sWr2MZnFHADOysTL/RfXcdjEUW63NKBx8Sr0yxSfmqY6yrG4M0Oj5kRSt6yASg7rzBAq0o2VwsyngYJpjajuoS9QXzd/WKcVbcLxALnMfZSI1+Q99K9jGVnW1SW5NmdH1lWMAeqQQ2V6QftjTxUQD1dI6BFdzrPKHVbFj0xRG6NeZ6QoOOGCqasLmDdI6ejzcCIb2heiwO9g/1HazuLOnkwxFD/rGIJx0F6oEVe+EL3ltaZSwHN7iN7fi3Avu3GAOVMubwJFw8pffulf5spQIA+ScHCC5na1nof6I9Vt6a4Zb3+j5lH7Ndi+ZNZZuxQAZ0KbKlyavirEnq/SHuNEPlzNGSOd5gBD4mg5i6jSs1rJLlHmgqVrt3+/9mn+PlL0bXCBuWQACNJoJrlj8toehY8AiKVagbI9hSSi
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 02:29:28.8915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 0f69517f-0083-4220-4ffc-08defe62dc53
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	OSA0EPF000000C9.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPFFB2C7A3AE
Message-ID-Hash: S2MEE463XLAXEOWQMP643G3VUNDUA6SO
X-Message-ID-Hash: S2MEE463XLAXEOWQMP643G3VUNDUA6SO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/S2MEE463XLAXEOWQMP643G3VUNDUA6SO/>
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
 sound/soc/codecs/nau8360-dsp.c                |  633 +++++
 sound/soc/codecs/nau8360-dsp.h                |  122 +
 sound/soc/codecs/nau8360.c                    | 2295 +++++++++++++++++
 sound/soc/codecs/nau8360.h                    |  911 +++++++
 7 files changed, 4089 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
 create mode 100644 sound/soc/codecs/nau8360-dsp.c
 create mode 100644 sound/soc/codecs/nau8360-dsp.h
 create mode 100644 sound/soc/codecs/nau8360.c
 create mode 100644 sound/soc/codecs/nau8360.h

-- 
2.25.1

