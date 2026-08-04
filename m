Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA02C55184
	for <alsa-devel@archiver.kernel.org>; Tue,  4 Aug 2026 03:30:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8398C601FA;
	Tue,  4 Aug 2026 05:30:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8398C601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785814256;
	bh=TbXvh0nEvkReX6SgdZxQ2k0qcvIGXnOxX7kpjyGVdps=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=rqeORbLx4TiD99LVWQN2ajaJrnQ86AQ+b4wm1RyrqPWmy+Gae4iQO+bQaou/DgSoZ
	 UZR+EQWE3HKKh3CIEPvcEgGZn8GB4lyIFZ2KfSFw5lTCWb7hr4doC/u5H3kq5Z2X9q
	 OGMQYOnyAfgCqeuy94PxCEXcRht82bt8xVK2kg1E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 736E9F805FC; Tue,  4 Aug 2026 05:30:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 42748F80602;
	Tue,  4 Aug 2026 05:30:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 14933F805AC; Tue,  4 Aug 2026 05:30:13 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.15
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1785814208;
	b=SnSWecbUk7PNCUbW6jaBM9qkSpqfsHYDAqXmBPEOzPhciOwGLcgNF7qNDp28bYffCFPm
	 ybAw5U3lvEQcyTaonQk0T/znRJYB+FzkpVhD/NTXrk6XlURS9/jPnC4Dbde4ORHCTdpsb
	 YKj84VJoHgNEtOIpvFPXBeXcYZbKcS9NpqY3cNrk08YF2HLeloYD+T1dUVgT0xbOEhErL
	 f/jxwEoeyvLmNIw7HFJ7W6AYwIk2xtpuTVYs4r4kKMuQid0PGeYEsiwpdjWwrztRts9Mj
	 zOh46QrOCi1Eo+iR66hbWZdBawRvDoYTrLxvZHexuttC5mbWB5LSSBb8CrCpXRqKTcg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785814208;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=TbXvh0nEvkReX6SgdZxQ2k0qcvIGXnOxX7kpjyGVdps=;
	b=jtgt8Am1ZuXsZRK7ZvGKcAGIob6MXU0a4r4J+w40/e4w1YjpfEUdInTRPu4Cv/EQj6Lg
	 yL2ZqgYi8zY/hYEALTuCmSS97iu5geTvASCGhoQUrD9BvPk7hQJcVv8XAT1wb01lzg5uM
	 4cdIZmOr0iS6CrT7xgJ+h4KbyfW+5qnAJ2oOQfTAjm24nKto5F47lwivDoM+eaM97YbJJ
	 U7XXY3zZna0AHuNSMkQIYgjWmRCOUVsI/nZpVP1929hpPE1zGUjgaTBjp9CD6boMfEtPh
	 1FeFrSO5QtS3TFsCKJvvjPaPHUlkJ3Wi46CVlrAE//n3K85rOc7GQ9R/ollvPws8EkQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=LwHU2TwM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.15
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11012015.outbound.protection.outlook.com [40.107.75.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CB14AF802BE
	for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2026 05:30:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB14AF802BE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=LwHU2TwM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5l2YrUQM3HbW9SgB3PNa727ajmcOIdYAl1usKikvchNMESFRJKaD9bRswsBQBsd7JYklG9JkIu4rUKMHkBWGXHnm0Mb+4Ib07llfWa3/eFRoZrctjPaI1sH/spuhz2qVlLBKqWpn3o2l9hREajHDC+XReskxn1/B7BTkYo1bO51W2z3cGcZSIWIaPAIYTSDf490AJaTMcGlRxZ8a/tq/csvLBqLq6wQ8j6dO/0A64ehstLrBZ6C6yBjoNWL9JZbEBOSnGB3DyadZuJvMyulvhEfl1PzTuJwfpgPp23/QVO3FbSB/Wtb2M594HUsEb0bVySeYaO1U2wpifnkE0or9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5Uw/ZPNZQXddV+GiYWGI3AlGsWVY8FzmpeC1WS1H6U=;
 b=JzeVz1OuNPNtD/ddCDRtV0vC1mVrN0H2Mosh0Ry1u0VcpUeYmGpcjN7w+rMSZzziaHr/g/OEsB59s1mM4F/LEP4aXKHLvHaJ/j5iPs5RqeALO5jRO1nu0iD7FBMJnkcfEyRtbidqvLON4SSx5ra4mvP1ThimFcROsk3DekcgWjXwxWoHPmR1ESKFc+E2Jfq/Iy8eYv5HLjXYmF79WIY3tikKj9HVuOuyQTI+KV2L1o5imBN93z94vFZ+95zOSNVkUvFQF1ZBrr62XxS4SYukfFVLy0RKzcE5aTBSL0A+knkLnkTfyDBAtmpemr4B2BltjuGz6kWGB7Z3DlPcGWV3yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5Uw/ZPNZQXddV+GiYWGI3AlGsWVY8FzmpeC1WS1H6U=;
 b=LwHU2TwMjv5h4vrqO3nUswhNK324b8VAB9huT/pfZ77AisAoTFFaSG10OUIeVFZ8BJ3VDVsx14Z9oRU4GpQRnmgHmx4Ztb4o9VsRm4FweMKo1YlxuZqvyvvccrwmQz+gW1r3xB01Sb9RBSg0a2O3IjlB4luQHnbWlbSdsgdrSrjgUjoPQxah2xT1fCAW6Vq8KrFKRgEWfJrYiQsxsQL9Y8umNd8M+JkUhgLrV404+x1R+jsOFDv7ZMRokVuw2mWPWQjhBDEjn+YGe3yjU5v0zmk0zjbOW4zYhV7UUM/ujb/kyitKHo73PbNkp1NXhq5ZMSv59K85LwlsHAD/QTVagA==
Received: from PUZP153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::22)
 by SEZPR03MB7170.apcprd03.prod.outlook.com (2603:1096:101:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 03:29:56 +0000
Received: from TY2PEPF0000AB87.apcprd03.prod.outlook.com
 (2603:1096:301:c2:cafe::4) by PUZP153CA0005.outlook.office365.com
 (2603:1096:301:c2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.3 via Frontend Transport; Tue, 4
 Aug 2026 03:29:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 TY2PEPF0000AB87.mail.protection.outlook.com (10.167.253.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 03:29:56 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 4 Aug
 2026 11:29:54 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Tue, 4 Aug 2026 11:29:54 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Neo
 Chang" <YLCHANG2@nuvoton.com>
Subject: [PATCH v7 0/2] ASoC: codecs: Add Nuvoton NAU83G60 audio codec driver
Date: Tue, 4 Aug 2026 11:29:49 +0800
Message-ID: <20260804032951.1069901-1-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB87:EE_|SEZPR03MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: 47295f98-f1ac-449b-dd90-08def1d8a7e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|6133799003|11063799006|3023799007|56012099006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	rlQl393FMxRM17O7bzL4/2jxrQfkOl++zimHtZiMa8PX3mbeeV3bW2oWeNuUyMAl4cJgfoFF7HdSFmcvzA8AosWtxQGcnp8x3WeiAHFZUojnRnJhA6nIE/SD389AnFWyNuV3VWG2dZNc0tZz6t3ijUFLRTRDk8KxMW8o2b65lGIMLmTJEH1hWRAHZbcTBgfaQ5h+cO+1AEJmZ3h8ZWGbF7hhFR9TEJkZ0m9rAxxuM46uOG6j569a0QwnChb9r0FSk8s0vIO1Z3i8YEQM11gzneD5T+GuWACd9qtBeqNDCZt426eua1ZUbFbNjhodwLcV2AyXVHDMkY8dU+hnNdlh0cOF4ABP60SuvSqCAkW4QitJF2uqZWydsOQvtw58fLofU06rYThhZyO6D7GiiuDkqHMQwR3ehCF+7blI/f08+6+xVZJzLHEQONv8ZFwzrunU4P6cBYcsz/gBzgEk0cRsubG2uGsRapBabJEq190X463/gkBIhxdzdG/SIgSW/goiMdqMAkE8sDdc1Q0MO3A8ztRxhCfiPHmByj1Co3ybVrcwljB8mDuMUcdoWRXNHX3WGxZNKmxQUN7pjtsQdEuFwhJetlOjwxmQapMKK923qCFeqDxKdmU2XLjqdDUqVvldyLQD678FxspLOe93x/9YLyyOACHakvqz4iXRVN0Vwti8DICUV/++PfKu/yy7rtJMac7sgtbZhfq1UOJ52aVACw==
X-Forefront-Antispam-Report: 
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(6133799003)(11063799006)(3023799007)(56012099006)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	q3mhtDpSqBmVcwlyLHfvsYKjZix4QrvbyLj00Y44aW/fxsnrQNe+ygbqsilws8oH64VzH4hS00wW+hDMo4ab/QotcvRZYJmTSbBm3I7WRrq23IgZT5cencjykBfTB04YHiM2NWizRx7M7sSTjCp5xhdnxnqbOwSNxkjHn80hvDvo1dE1rgEZdEt01O7Up58vXpgot3HZy99wOGXXnJEvgAdzLYpVsKnsucpmcmqRckFA2J5Wd92McWIc7aEF1n8CvcE4UdZShDK/Dm0eHdjUMY4R8TwwYnr1yZc4JWgZCNk5Itm2Ayf2jXzjpVJzxNgnc2fXV9YhbYrMLJ6aOHf43O0RQLS9gcRuIJN+bkL1dLrcUPAaKChUfl25ICp8DyS0wEPUxg+/8xBZcDahiLRHhtmF1bWsh0Hv8VuA8RiF3o2F4FQesmzV5BvBZ/QEtoE/
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 03:29:56.4557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 47295f98-f1ac-449b-dd90-08def1d8a7e7
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	TY2PEPF0000AB87.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7170
Message-ID-Hash: 7CRAHV6WA2M32FLYODVGBUR44HGEZSAD
X-Message-ID-Hash: 7CRAHV6WA2M32FLYODVGBUR44HGEZSAD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7CRAHV6WA2M32FLYODVGBUR44HGEZSAD/>
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

Changes in v7:
[dt-bindings]
- No changes, added Krzysztof's Reviewed-by tag.

[codec driver]
- Fix potential DMA cache coherency issue in I2C transfers by separating TX and RX buffers.
- Change tdm_tx_func_slot and tdm_rx_func_slot types to u32 to fix incompatible pointer type warnings.
- Fix TDM channel enabling logic to check against slot IDs instead of function indices
- Add bounds check for TDM slot indices in nau8360_validate_tdm_slots to prevent out-of-bounds shift operations.
- Fix payload reading loop in nau8360_read_data_payload to break early when data consumption is complete, preventing protocol errors.
- Add wait_for_completion during driver removal/suspend to synchronize async firmware loading and prevent use-after-free issues.
- Refactor resume flow to properly handle regcache synchronization and PEQ memory enablement.
- Move PEQ Memory Clear process to execute after DSP reset.

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

 .../bindings/sound/nuvoton,nau8360.yaml       |   83 +
 sound/soc/codecs/Kconfig                      |   11 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/nau8360-dsp.c                |  667 +++++
 sound/soc/codecs/nau8360-dsp.h                |  122 +
 sound/soc/codecs/nau8360.c                    | 2273 +++++++++++++++++
 sound/soc/codecs/nau8360.h                    |  916 +++++++
 7 files changed, 4074 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
 create mode 100644 sound/soc/codecs/nau8360-dsp.c
 create mode 100644 sound/soc/codecs/nau8360-dsp.h
 create mode 100644 sound/soc/codecs/nau8360.c
 create mode 100644 sound/soc/codecs/nau8360.h

-- 
2.25.1

