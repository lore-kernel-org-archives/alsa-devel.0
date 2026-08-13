Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC1EC5CFEB
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2026 06:44:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DD9FA60203;
	Thu, 13 Aug 2026 08:44:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DD9FA60203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786603474;
	bh=89RSwvwQ1ixGRhFguyIvSzl8fI2v9iYMZ+XmaMLnlWk=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=otJl2xGSKG0peNJqD8Jk6ggK1gjVgLmpEC2cdDb+98ROwOXdCedwcQ3NjeqaZRpjS
	 08VvSp6cvHvHSfyWSGSZEAQDmtBHkBoaS/ac4sMUA0VaRGkUOUS9c6BS8FHpSohObJ
	 t3jgFLiGxxc8N5XHAbJhlpC+BmmUuEd/2yK+TU1k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D5DBBF80601; Thu, 13 Aug 2026 08:44:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 55C65F80600;
	Thu, 13 Aug 2026 08:44:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D4ECEF805C8; Thu, 13 Aug 2026 08:43:50 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.48
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1786603426;
	b=e1th4a1QTSdikgpo2938He80y5jvnfkr1lWq03YRDmALs6Q9YDb3uKFQHJfANNI2l5FQ
	 3QrQhUquc+Gn1YtdR8sLgVLZdrlcY2PtmQLWAazqheh7cbZZieNXtgq7Ll+zr/6H/cUBM
	 NTwgqZ3aLWruxNHFxUimewc+r1ltH++AkiXZq/qW0ViWrFShoSw4oBS/mYEgyPnZzMN0r
	 LZLZvaJcOsfa2zLvusc7gHY52K2sepP+EjCagYcmMke+2/W5mpnS90HfWuc53nEpG+y51
	 5i7abJHxrJ+TSwDJk28Tx1scyKQcZGHNsrlBhoi+hvcFIbgtj6VwB/9TenfZlRyWZgg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786603426;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=89RSwvwQ1ixGRhFguyIvSzl8fI2v9iYMZ+XmaMLnlWk=;
	b=OaDFdIYsOLal4mZUtiDn7isp7EMuL+qTcU+tiECehQEG7Wbspq5ey/qsw1M3qGZLZLpJ
	 whqJR/lQf0sz3MSAofxI3C1xaiKei/ancn9Htee3cUX4bu1N1HcrfBXNHZ/l/cJqM8Pgi
	 LlshMdaRzzWpFnYjoL/0IWSL5acHguycJ+fXQ6OCA0pI9WyNhyvzygAa/9zD6WZNjXufn
	 xrrhuU+AJPDI2/gBO+zHN/hjVcMPg9NdOyIIeOSTCKR/vuaeWNJwA7lFibuVFjA8lr8CI
	 vg3auHjLQVNkAHXIi2g22aApZJI3I9n1AuKCa/Y8TxlwzsHydwFczIH6RPTteUg3sag==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=CbRSyBx1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.48
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11013048.outbound.protection.outlook.com
 [40.107.44.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5F0F9F804CF
	for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2026 08:43:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5F0F9F804CF
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=CbRSyBx1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMKW8eYPTaU0AOQ88ZFfz0FsogmFo+8ChwQ9+gVyJRAxugqV3yAjmAaL8Hz8efQzXezCMRL6itgmS0W0Ratg1AeEn/P8o/Q45+4vUaT6EGa1iiyFPLIf3nt5cenqpLAnbd2UEM2zL706Nft63Nz0UTQ72PCfmAJgosj4Yt/gKPZOHM4OetDCY+ESXChbSdTyBHTqcsbcolL1AyAeMGP1zc3cDdk99yM/jW6ufGxPrae6a3BIBqANuVDYrKzKX95sGHuF56gkYkgfstnSBPvK9bpFjGo4ePtKgKibkqBqMU5gBLnlU05dOPabDzQCSNx8ChYIUElE2agGQl2W3eGtcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebHnHpfIuQH3CKNW0FQNKgjLP3jk6cGdQ3vJlJ6qXsI=;
 b=so/lHc+ocXp3qCtpB43m2NvBypRlb5fcmJZl0qat4RvPLr2jAOlLWNxUjZWmrrREYfHRH68iQjPMOyALmX8qejPNTz9RU1WDBQI9RHLpo7zh5DzRbyBPVeWiezNJeyg8wZ3Ep4rsA1laQM+x+ZIjGf6eyeUPL4G6psDWsbuMpADw35HV6UNjqauV91nJy6ZkYSEsZuWjyWkhIaN+fuIbvgEvFk3lQJdcUXsKQOZWZoFvsRnOahCkHAx05tYjBQngK/Pil/ztA4ukCII72qKcjFqT7ctYuMfnrIwUBVAhz+kFTCpD3HTLiPGlVfiiAtQ0bTk7mvUFUbc5zNAfFFLGzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebHnHpfIuQH3CKNW0FQNKgjLP3jk6cGdQ3vJlJ6qXsI=;
 b=CbRSyBx1nborx3ihSUcY4L4N71HZMaaqd8RTMY3wAoTmanWP8K4yVI9rAdTXnP8CzXktAnBmxtoCajdl89uRdwW5RySSGE+i1YfFmh1VfPEs//CTuty6RveiTN7gSYl32lN3epGd5lplbj8tB7HnlCnbEApHUzpLlUbFkl1M3LGFF80FgfpZTsoKGdMNhD3cvP+KeNojZ3Butj+R73lYUTeuZTNYRtOQ+pBXj4Qt/h7jiUyT/KgaMbTill7akYFMctvZHi00dAFKmdB1VDJKIBv3Unx3DkRXiuMxaYEUu2hiB1qTQZ6MtLBCYsb7o3xvug4h88wkKc8HjqBU9x5V4Q==
Received: from PS2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::23) by SEYPR03MB8029.apcprd03.prod.outlook.com
 (2603:1096:101:16e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Thu, 13 Aug
 2026 06:43:33 +0000
Received: from OSA0EPF000000CB.apcprd02.prod.outlook.com
 (2603:1096:300:58:cafe::20) by PS2PR01CA0035.outlook.office365.com
 (2603:1096:300:58::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.13 via Frontend Transport; Thu,
 13 Aug 2026 06:43:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS02.nuvoton.com; pr=C
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 OSA0EPF000000CB.mail.protection.outlook.com (10.167.240.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 13 Aug 2026 06:43:33 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Thu, 13 Aug
 2026 14:43:31 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Thu, 13 Aug
 2026 14:43:31 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Thu, 13 Aug 2026 14:43:31 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Neo
 Chang" <YLCHANG2@nuvoton.com>
Subject: [PATCH v8 0/2] ASoC: codecs: Add Nuvoton NAU83G60 audio codec driver
Date: Thu, 13 Aug 2026 14:43:25 +0800
Message-ID: <20260813064327.1127236-1-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CB:EE_|SEYPR03MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: e6a50364-fe22-4a2a-72b6-08def90631a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|18002099003|11063799006|10067099003|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	GRn0ik+KiTrbOYdCsLQEpkzOONRLawMr8IE/sCRd+Y0vsGly/wQiyqiBm3l0pGg9neXy3tYHHgNCPCZdQUv7WTc+zxRja6/nhseRRNJbAQqm29c8UkfEQ95oi7uzilruIcIA8y/0Xx/DLkMPpJA+i3n9p7ux1viQlL0sBQL0XiudbP+Ikt4NecJAvMJ/omuFttbIfeXTFcEYgfE7oZbsRMtLLb2yGSBCqFGQXcfMq5+Blyt6i/JiTdYzoeKbtrNRXUfwqVXgEufkqfs5egnAWsw0Xq/9x9dt92uyuKeJFISvXjLEWPLW0CP02I3gWYis9Od5zwcCNTGyzL4RT/tYQRfM2MV5YVP1nj1prLCsmmWLySb+Oj7mAUDtcO6JT0SztmPQCYHfAy64ZlmRaZmU5Y/xhoa30WkV5ADho1u928YLju8KYKSAwH3rHOuD21dD84Gq0YXRbx2AphmuGDoZ/5d2fE0tmwn/5V7+cRyMezx2AmCy6+X9twsQ1KI7wSHi9OlhlTpjkeQ20cwTUuhucMO//FFrSFQZN38a6MS4SSF3qW713RbySzzXltGJhPINi86DaMECMAVgayID7seY+5BltONyg8ym6qZpnSdwHcBisLhspjrtzSaA8N3Htw/OCd1alZIGka9wOAL8Sh+NDmioy2mBB4Qwq7rUkvCWVVkFRYkOsDHlxy/gKhcHWpucs1EL74aU4L1e36KDK3uS5w==
X-Forefront-Antispam-Report: 
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(18002099003)(11063799006)(10067099003)(56012099006)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	B6oSMZwr4fKYym7gay8kh+aD5fsBf8LjS4NzwaiF8ZPcUrYt5ak5dyXuwfAdlKB6/z9Q13VZocxEYiVwhjFb8DDlvpX0SYHPS7t1jp79cWswrPstKVyeF7r8xFpiIjVQtb8jZERp97EB+20mMAaMBnpS2v4wGbekOw7EIVJ50WmVKyNCiAfgIV7N8o9uFFFeTef5PleSjM6NzIJFJgpLjm7d+GfUv1uHxTT946CiLaJQF3mKtrZXBbYCWc8KuxzFPYfmEafrqfqMoQEj3DDfDB3NENVfgOoBcK8GYJtV7UlZ6xzkLE0K2eJxPmWiwXMBVD14jTcrEJ8dxeuBUiJuVcN/b5LRBCvJcknQBd1iZ9ZrZFLx17XVMGJZ15+TiuMLK45i0SCuJZPX5XuHJgjd9QWZL47ad+oghSICL7MIxM8Yfn0mj7bUmBmBmHGhG+T0
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 06:43:33.0162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e6a50364-fe22-4a2a-72b6-08def90631a8
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	OSA0EPF000000CB.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8029
Message-ID-Hash: GYP4SL2T2CBVJFM52J4NTY7B5VOFFJQB
X-Message-ID-Hash: GYP4SL2T2CBVJFM52J4NTY7B5VOFFJQB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GYP4SL2T2CBVJFM52J4NTY7B5VOFFJQB/>
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

 .../bindings/sound/nuvoton,nau8360.yaml       |  113 +
 sound/soc/codecs/Kconfig                      |   11 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/nau8360-dsp.c                |  634 +++++
 sound/soc/codecs/nau8360-dsp.h                |  122 +
 sound/soc/codecs/nau8360.c                    | 2286 +++++++++++++++++
 sound/soc/codecs/nau8360.h                    |  911 +++++++
 7 files changed, 4079 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
 create mode 100644 sound/soc/codecs/nau8360-dsp.c
 create mode 100644 sound/soc/codecs/nau8360-dsp.h
 create mode 100644 sound/soc/codecs/nau8360.c
 create mode 100644 sound/soc/codecs/nau8360.h

-- 
2.25.1

