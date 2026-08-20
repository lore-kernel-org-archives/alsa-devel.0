Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7099C5DF85
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Aug 2026 02:31:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ACB3C6025B;
	Thu, 20 Aug 2026 04:30:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ACB3C6025B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787193063;
	bh=kqOs+mjbTp6TbCnYCGK3EYgIQUhokI8j1wllxv0+VDw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=mAUqEQ+Xo+YzQSmwH5fu8xR+g9KaWS7WD18G7yfzgNIepLmFf1doPWfaQoU4IF/pk
	 aY7bLT8N0wcu4dRzSE2WzdsFl6v+g/6YK90gSGIFExiTnltDwNy7SQHt4bttahhzYp
	 In9tFTJWCGGgOYqD7TEHDdA389uKquNc6P1vVv64=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4661BF805BE; Thu, 20 Aug 2026 04:30:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6CE67F805EB;
	Thu, 20 Aug 2026 04:30:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0A3B8F80600; Thu, 20 Aug 2026 04:29:58 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.56
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1787192989;
	b=PboMK8RHIBASaNBmDniyweouzFlERdEQpB07ogaIUqny2KCzwy/uy2f2HqgIGNCXCnZh
	 oHyddldFV7YJ1NflKY/qpCqjPDgP7SQhTLMcfuFpzSxrKcYBarI75fSv1ni0wsNY+1/V2
	 lMOlNtHsZ6aEnTauDrD0cA9a8m08pjyH5fjNsIRlfuPQC+sJFULxqqlUwJR6WCvRXy4mB
	 li7nyZwBK0S467gw3e1AM17ow8miZsxuEyJsAoYBhIgRFXQs2F4PLZyS4DsWcu+S1fnux
	 aZPFxWzgaN4spNPEvT7rJ/CaRKhlr85QdLtzHndgEYhcCkwf7eRFyDw6rEY3ulPrkiQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787192989;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=kqOs+mjbTp6TbCnYCGK3EYgIQUhokI8j1wllxv0+VDw=;
	b=L9cGnhNOOaYtoBmGJEG7y9IINGN9zSrcrk+CCN+sSd/q0HRq3ZXAWutQW7lAjhv7mI6+
	 53yY2yAQYOtpH1gXw0LeucUh/6FkbrXY1iZgO4QHwOK2Zw0NczoFKXkNblfxcIL1LBS0r
	 LOwEX+qEz9gidqRa7pUwDySXUqM6tbNF8UQ2xBtvcFHpD2hDfo2hqNunCU8KIGWjp6vUL
	 xsMKfDX2IPRhVh32FUtlyDM5c9fCrASQYL4yDpGy/ZAJcTXWG7DDAehXYb0W8WS9TZpql
	 R+myZgqN2+GuX7Ih29/7DzZgjs8qqq3KQFDRjjpA64w7esu+DXRTQqIhMspKEQcVjgA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=fSUEBHs5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.56
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11012056.outbound.protection.outlook.com [52.101.126.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E9636F804D6
	for <alsa-devel@alsa-project.org>; Thu, 20 Aug 2026 04:29:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9636F804D6
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=fSUEBHs5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLrjgY/74jlYsjqiNpF9JKAOncyTQyQz4GBOkj+4eLZIRW1K7s32O/ijFSRsbNKLoxLMAx6AlnIg7nA0DxFi0V23bmt1AUEF1qAHUbfIUX7npZvXrcGNt0/K7xhVLbHeyiekJqCOboYRdfk2FZMhHbIL+PSP0sdzKZldxjWaQwPtWyLJyVUi3fzXeTcXXhpHfgQLJt/f7cQKGnigFJHLDpBCAnSrmwcCZo/mrgGu+a5ZFMyi7kzgNyVHeli//FzA1K1nnMG7Uwt3UbHdx09VHxUrBjvTEzaah+wTi08zkKOou3aDxK9HARQv4yVUkufr45ENfo8rO9pmTLZ6YkFIZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUqpMTRYZ3EhueU7OPJYTwHaEKPqTsVyGxfQDAzL+Yk=;
 b=pNo4L346JEYyO+qk7x5xEroqfBaV5/cl7tBuuiCgcOFvsQh6HtvW5aFjByZiYM7WWx7K2uPJ9SC/p+k0DpTIFsijDrTURaJpJ4VK81E90pbdCFRyvN19uRqcO0fkLztrrmTsPjZhZKU1cg+CtYDzKwu4Pnv8nmf1mDbTm6OvxMnm7Q9yZLcW3S5xFeXf6k6ry+bm2vh1GCLq2WGggvf+7tDlee5F1jdW0YHsT70pUGxIMNiyfYCQfoqWqZUB1KWz/LQse2TS0vXDR9SOBvpo8jhwcw5IaAtxvcB+aOQS+MIHunV1mw2etxBmy5OYuwaSTAhts+a+DoglClzDysglBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUqpMTRYZ3EhueU7OPJYTwHaEKPqTsVyGxfQDAzL+Yk=;
 b=fSUEBHs5fwrIjwJ8mi0sOcYZCK1AtULSyutDXXojo4QbMXk6pfZz2UEJl45WaNn45bBSwdMucyp720+mRpwDv7vGRdm6toMevd7c+PhVBupwQTsfA3PFdhCJDKBIh4N850lJZ3JkZaLJZpm++L53/khRnp1GqX1JyXk6MlEldeS4m6UQeMCBvJtI1bna1nUrZu75+xibqHlOE01TzQt7D3d+XeHWJ32tK/ycH98eYlTlHn7Wr8KiqnU7OQJyP3H2EutLm/QiwQwTKNQxBGjUNx+COcip26yL3I7rXGApCCyz5XU5qlBPmXmZncmR9GeNFyS4+yhor/H+y++ABlxd2g==
Received: from PS2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:300:2d::13) by JH0PR03MB7926.apcprd03.prod.outlook.com
 (2603:1096:990:30::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 02:29:30 +0000
Received: from TY2PEPF0000AB8A.apcprd03.prod.outlook.com
 (2603:1096:300:2d:cafe::19) by PS2PR01CA0001.outlook.office365.com
 (2603:1096:300:2d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Thu, 20
 Aug 2026 02:29:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 TY2PEPF0000AB8A.mail.protection.outlook.com (10.167.253.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 02:29:30 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Thu, 20 Aug
 2026 10:29:29 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Thu, 20 Aug
 2026 10:29:28 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Thu, 20 Aug 2026 10:29:28 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Neo
 Chang" <YLCHANG2@nuvoton.com>
Subject: [PATCH v9 2/2] ASoC: codecs: nau8360: Add support for NAU83G60
 amplifier
Date: Thu, 20 Aug 2026 10:29:25 +0800
Message-ID: <20260820022925.1174132-3-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260820022925.1174132-1-YLCHANG2@nuvoton.com>
References: <20260820022925.1174132-1-YLCHANG2@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB8A:EE_|JH0PR03MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: d92daf95-e513-4404-2f4c-08defe62dd17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|30052699003|6133799003|3023799007|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	37sZfbHgc+MsC248MK/qvJ+8Gygp2YIkUqB1ojMu4bV/dLop5G1bWpOdeaQcPQQ2IfKwwGHEeNN7fFEN+ws8dQaFIDwvj+VBA/KbvY3x59AmdHIOX4heL56bJKMCIhoyz+qSOEqqT4K+PW0fTjG35uuqnzUeF2cY8m3YxeTIvG2tCfzrEhQavn7ybdM8K+PcTAoOpeJR0L+qztYWu2aLm4IEpc2a3Qhe1859pooq1wvZHkzrRs1YR+HjoQbxRiRuqv8vbrCB3YP4d3wC5pubyKb0eLqfgJH/jvWv1Vmvd4xqcJdBBCGxHTe4URKecjHcPvTtHiv5iZlTQuj+0ncBZReyzY3p7BL5Qi7JKn7DTm2BzMDtyZaDoJ8UOIqYb5BaodNtzl2vK+CT5Zm5gC4xyw70AXf4pcuwXvR9E2v0Cx2MFMFlBigknhEN+0wF+6f2kl3L4wrrLV5PlVGMILHu7ypZHV+Oulkx08d89xZX/lcjtxsYVQWDY9J4c4LAxnu3qnYDd7hFWq1mL/LtsLAtzitYF/cPyHCMtkyaZVtvgcVSjYSNYzZSd3ho7nk1Fqg0E5blG9OOqVygXLYFX/5DSLw4BpJNtjkfMZnf1AFsmAAg+yCbwzrj5eT7Td37DtGvTgyT4i5L67dhsPePqrpROnm7ZbJ52kn9lOjb2GiIKZ0Um8t0gQ9g/YNaM9kkeVHRZZLa15s092Je6/vHwg0lrA==
X-Forefront-Antispam-Report: 
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(30052699003)(6133799003)(3023799007)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	536lt489mYOWQYF2dw6QpJpaOu6X4bUN73+c64HO6EjztmSyaOvcBOIxI0aqWXdxk71LG5t9Ed1Yr4KDjgzgJ2JJKPlXbvljzkPqtS81x328LKi3bzdy29B+3XzE6PqS4q8EDHcsz6ILQO3gtT/OthoCRDhzAxQtBcTjG2jA+CaZlrGJhDvsqdvOePgDdXhG4rk3QssOBVUZjT+gegMo5qlUklayC2PgbYeW1v61YgVMw7dP/hjK006eUELGlxMxXe1erxgInFsQrIBpmwHalgZBPc2de/ZMDmwlt8iqtQ24g81HilSXcSxnRy/e/xGMMAGz084BwtBxYq6b+C8qXISYePYKFfjwKv9R3B0qG1wiZeejnd6Cikx2G1Ug/Wu3/TQ8KZnhJI4z3WL6lEVMj/+R98gaT18s1wbuaSn2X7iksVlkjZ3QxNxd7CXtPGxz
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 02:29:30.1813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d92daf95-e513-4404-2f4c-08defe62dd17
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	TY2PEPF0000AB8A.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7926
Message-ID-Hash: UOX3H66DDTQK3UJXD5YWS7Y3AIZWIX6X
X-Message-ID-Hash: UOX3H66DDTQK3UJXD5YWS7Y3AIZWIX6X
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UOX3H66DDTQK3UJXD5YWS7Y3AIZWIX6X/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add support for the Nuvoton NAU83G60 audio codec. The NAU83G60 is a
stereo 30W+30W smart amplifier with an integrated low-latency
Advanced Audio DSP.

Signed-off-by: Neo Chang <YLCHANG2@nuvoton.com>

---
Changes in v9:
- Protect PEQ access with DAPM lock and component active check to prevent
  race conditions during power state transitions.
- Remove the global PRE and POST PMU/PMD widgets and consolidate the
  mute/unmute logic directly into the HV event handler, preventing
  unintended execution during capture-only streams.
- Fix firmware memory leak on DSP setup error path.
- Fix out-of-bounds array read in dev_dbg by validating the `source` parameter.
- Fix uninitialized stack memory usage by checking regmap_read return value.

Changes in v8:
- Replaced request_firmware_nowait() with a dedicated workqueue-driven
  firmware loading mechanism to prevent use-after-free.
- Fixed regmap cache_only mode handling to ensure cache sync and DSP
  setup succeed during resume.
- Fixed potential data race in nau8360_dsp_switch() when accessing
  'anc_enable' and hardware registers.
- Prevented uninitialized stack memory usage in nau8360_dsp_kcs_setup()
  when handling short DSP fragments.
- Fixed undefined bit-shift behavior caused by out-of-bounds
  'tdm_tx_func_slot' configurations.
- Fixed incompatible pointer type warning in nau8360_validate_tdm_slots().
- Fixed audio format configurations for Left-Justified and Right-Justified modes.
- Explicitly included <linux/bitfield.h> to resolve implicit header dependencies.
- Set symmetric_rates = 1 in the DAI driver configuration.
- Removed internal fine-grained clock dividers.

Changes in v7:
- Fix potential DMA cache coherency issue in I2C transfers by separating TX and RX buffers.
- Change tdm_tx_func_slot and tdm_rx_func_slot types to u32 to fix incompatible pointer type warnings.
- Fix TDM channel enabling logic to check against slot IDs instead of function indices
- Add bounds check for TDM slot indices in nau8360_validate_tdm_slots to prevent out-of-bounds shift operations.
- Fix payload reading loop in nau8360_read_data_payload to break early when data consumption is complete, preventing protocol errors.
- Add wait_for_completion during driver removal/suspend to synchronize async firmware loading and prevent use-after-free issues.
- Refactor resume flow to properly handle regcache synchronization and PEQ memory enablement.
- Move PEQ Memory Clear process to execute after DSP reset.

Changes in v6:
- Fix Use-After-Free during device unbind by properly synchronizing asynchronous firmware loading.
- Fallback to default firmware names if the "firmware-name" property is missing.
- Parse "nuvoton,dsp-tx-slot-mapping" and "nuvoton,dsp-rx-slot-mapping" properties for static TDM routing.
- Drop dynamic TDM slot mapping via ALSA kcontrols.
- Replace cached tdm_chan_len with direct register reads via nau8360_get_tdm_chan_len().

Changes in v5:
- Add FW_LOADER to prevent silent probe failure
- Fix uninitialized return variables and add error checks for underlying I2C reads.
- Replace stack-allocated buffers in I2C transfers with heap-allocated memory.
- Eliminate potential Use-After-Free by synchronizing firmware loading.
- Protect PEQ memory control operations with mutex locks to ensure thread-safe register updates.
- Resolve TDM slot configuration races using mutex protection.
- Correct mathematically invalid TDM TX slot offsets during channel length changes.
- Ensure TDM streams are explicitly disabled when slots or slot_width is zero.
- Fix DSP protocol corruption due to missing locking in the DAPM clock event handler.
- Use FIELD_PREP() in protocol packing functions to replace manual bit-shifting.
- Replace deprecated of_property_count_strings() with device_property_read_string().
- Remove unnecessary CONFIG_ACPI ifdefs; struct acpi_device_id is available.
- Refactor repetitive DAPM event handlers (adacl/adacr/dacl/dacr).
- Simplify code flow by removing redundant gotos, variables, debug messages, and dev_get_platdata().
- Standardize driver style using switch-cases, positive logic checks, and reduced conditional nesting.

Changes in v4:
- Clean up unused DSP state flags (dsp_enable, dsp_created, dsp_fws_num).
- Fixed the use of an uninitialized stack variable (`status`).
- Fixed unhandled failures in `nau8360_dsp_init()` that caused duplicated
  DAPM widgets to leak.
- Add mutex protection for PEQ memory and TDM slot caches.
- Restored the missing hardware memory access bit during suspend/resume
  to prevent PEQ coefficients from being silently lost.
- Handled `regmap_read()` failure in `nau8360_vbat_level()` to prevent
  the usage of uninitialized stack memory.
- Removed improper dynamic creation of DAPM widgets and routes within ALSA kcontrol
  `put` handlers, using proper static instantiation instead.
- Moved RX enable logic to `startup()` for consistent stream state.
- Replaced synchronous `request_firmware()` with `request_firmware_nowait()`
  to prevent deadlocks and avoid blocking the kernel during firmware I/O.
- Explicitly disable TDM RX/TX when slots or slot_width is zero.

Changes in v3:
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

Changes in v2:
- Fixed nau8360_peq_coeff_put() to return 1 on value change.
- Refactored TDM slot routing to use ALSA kcontrols instead of custom masks in set_tdm_slot().
- Switched regmap cache type to REGCACHE_MAPLE.
- Dropped hardcoded DAC gain initialization to retain chip defaults.
- Used devm_snd_soc_register_component() for safe unregistration.
- Separated TDM TX/RX logic in shutdown() to safely support full-duplex operation.
- Refactored TDM enable/disable logic: moved RX enable from startup to hw_params,
  TX enable from startup to set_tdm_slot, and handled disable logic in shutdown.
- Moved software/runtime configurations from DT properties to ALSA kcontrols (e.g., DSP bypass, low latency).
- Corrected supported PDM data length from 24 to 32 bits per datasheet specifications.
- Updated firmware DT property parsing to use standard firmware-name.
- Removed redundant VBAT bounds check in nau8360_sawtooth_params() as it is already validated by the caller.
- Read VBAT level dynamically via register instead of relying on a DT property.
- Cleaned up magic numbers by introducing PEQ band enumerations.
- Set dsp_fws_num to 0 to use default firmware paths if "firmware-name" is missing.
---
 sound/soc/codecs/Kconfig       |   11 +
 sound/soc/codecs/Makefile      |    2 +
 sound/soc/codecs/nau8360-dsp.c |  633 +++++++++
 sound/soc/codecs/nau8360-dsp.h |  122 ++
 sound/soc/codecs/nau8360.c     | 2295 ++++++++++++++++++++++++++++++++
 sound/soc/codecs/nau8360.h     |  911 +++++++++++++
 6 files changed, 3974 insertions(+)
 create mode 100644 sound/soc/codecs/nau8360-dsp.c
 create mode 100644 sound/soc/codecs/nau8360-dsp.h
 create mode 100644 sound/soc/codecs/nau8360.c
 create mode 100644 sound/soc/codecs/nau8360.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 252f683be3c1..cfadeca26551 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -173,6 +173,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_MT6660
 	imply SND_SOC_NAU8315
 	imply SND_SOC_NAU8325
+	imply SND_SOC_NAU8360
 	imply SND_SOC_NAU8540
 	imply SND_SOC_NAU8810
 	imply SND_SOC_NAU8821
@@ -2875,6 +2876,16 @@ config SND_SOC_NAU8825
 	tristate
 	depends on I2C
 
+config SND_SOC_NAU8360
+	tristate "Nuvoton Technology Corporation NAU83G60 Stereo Smart Amplifier"
+	depends on I2C
+	select FW_LOADER
+	help
+	  The NAU83G60 is a stereo 30W+30W smart amplifier with integrated
+	  low-latency Advanced Audio DSP running the KCS (Klippel Controlled
+	  Sound) speaker control algorithm. KCS provides mechanical and
+	  thermal speaker protection with voltage and current sensing.
+
 config SND_SOC_NTPFW
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index aa0396e5b575..0cbacd0d3fc0 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -197,6 +197,7 @@ snd-soc-mt6359-accdet-y := mt6359-accdet.o
 snd-soc-mt6660-y := mt6660.o
 snd-soc-nau8315-y := nau8315.o
 snd-soc-nau8325-y := nau8325.o
+snd-soc-nau8360-y := nau8360.o nau8360-dsp.o
 snd-soc-nau8540-y := nau8540.o
 snd-soc-nau8810-y := nau8810.o
 snd-soc-nau8821-y := nau8821.o
@@ -633,6 +634,7 @@ obj-$(CONFIG_SND_SOC_MT6359_ACCDET) += mt6359-accdet.o
 obj-$(CONFIG_SND_SOC_MT6660)	+= snd-soc-mt6660.o
 obj-$(CONFIG_SND_SOC_NAU8315)   += snd-soc-nau8315.o
 obj-$(CONFIG_SND_SOC_NAU8325)   += snd-soc-nau8325.o
+obj-$(CONFIG_SND_SOC_NAU8360)   += snd-soc-nau8360.o
 obj-$(CONFIG_SND_SOC_NAU8540)   += snd-soc-nau8540.o
 obj-$(CONFIG_SND_SOC_NAU8810)   += snd-soc-nau8810.o
 obj-$(CONFIG_SND_SOC_NAU8821)   += snd-soc-nau8821.o
diff --git a/sound/soc/codecs/nau8360-dsp.c b/sound/soc/codecs/nau8360-dsp.c
new file mode 100644
index 000000000000..e37afbe8547b
--- /dev/null
+++ b/sound/soc/codecs/nau8360-dsp.c
@@ -0,0 +1,633 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// The NAU83G60 Stereo Class-D Amplifier with DSP and I/V-sense driver.
+//
+// Copyright (C) 2026 Nuvoton Technology Corp.
+// Author: David Lin <ctlin0@nuvoton.com>
+//         Seven Lee <wtli@nuvoton.com>
+//         John Hsu <kchsu0@nuvoton.com>
+//         Neo Chang <ylchang2@nuvoton.com>
+
+#include <linux/delay.h>
+#include <linux/firmware.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/bitfield.h>
+#include <sound/soc.h>
+
+#include "nau8360-dsp.h"
+#include "nau8360.h"
+
+#define NAU8360_DSP_IDLE_RETRY 10
+const unsigned short nau8360_dsp_addr[NAU8360_DSP_FW_NUM] = {
+	NAU8360_RF000_DSP_COMM, NAU8360_RF002_DSP_COMM };
+
+static int nau8360_dsp_chan_kcs_setup(struct snd_soc_component *cp,
+	const char *fw_name, int dsp_addr);
+
+#define NAU_DSP_CMD(_id, _msg, _setup, _reply) \
+	[_id] = { \
+		.cmd_id = _id, \
+		.msg_param = _msg, \
+		.setup_data = _setup, \
+		.reply_data = _reply, \
+	}
+
+#define NAU_DSP_CMD_ID(_id) \
+	[_id] = { \
+		.cmd_id = _id, \
+	}
+
+/**
+ * Preamble Fragment Masks:
+ * FIELD           | BITS   | SHIFT | MASK | DETAILS
+ * ----------------|--------|-------|------|---------------------------------
+ * length high     | [31:24]| 24    | 0xff | Upper 8 bits of total length (LEN[9:2])
+ * cmd_id          | [23:18]| 18    | 0x3f | Command identifier (6 bits)
+ * length low      | [17:16]| 16    | 0x03 | Lower 2 bits of total length (LEN[1:0])
+ * preamble magic  | [15:0] | 0     |0xffff| Preamble signature (0xB2A1)
+ */
+#define NAU8360_HOST_LEN_HIGH_MASK	GENMASK(31, 24)
+#define NAU8360_HOST_CMD_ID_MASK	GENMASK(23, 18)
+#define NAU8360_HOST_LEN_LOW_MASK	GENMASK(17, 16)
+#define NAU8360_HOST_PREAMBLE_MASK	GENMASK(15, 0)
+
+/**
+ * Payload Fragment Masks:
+ * FIELD           | BITS   | SHIFT | MASK | DETAILS
+ * ----------------|--------|-------|------|---------------------------------
+ * param_size      | [31:16]| 16    |0xffff| Size of parameter data (16 bits)
+ * param_offset    | [15:0] | 0     |0xffff| Starting offset (16 bits)
+ */
+#define NAU8360_HOST_PARAM_SIZE_MASK	GENMASK(31, 16)
+#define NAU8360_HOST_PARAM_OFFSET_MASK	GENMASK(15, 0)
+
+/**
+ * Trailing Fragment Masks:
+ * FIELD           | BITS   | SHIFT | MASK | DETAILS
+ * ----------------|--------|-------|------|---------------------------------
+ * length high     | [15:14]| 14    | 0x03 | Upper 2 bits of total length
+ * padding         | [13:12]| 12    | 0x03 | Padding bytes count
+ * length low      | [7:0]  | 0     | 0xff | Lower 8 bits of total length
+ * Note: Reassembled length = (length_high << 8) | length_low (Total 10 bits)
+ */
+#define NAU8360_TRAIL_LEN_LOW_MASK	GENMASK(7, 0)
+#define NAU8360_TRAIL_PAD_MASK		GENMASK(13, 12)
+#define NAU8360_TRAIL_LEN_HIGH_MASK	GENMASK(15, 14)
+
+/**
+ * Reply Preamble Masks:
+ * FIELD           | BITS   | SHIFT | MASK | DETAILS
+ * ----------------|--------|-------|------|---------------------------------
+ * length high     | [31:24]| 24    | 0xff | Upper 8 bits of total length
+ * reply_id        | [23:18]| 18    | 0x3f | Reply identifier (6 bits)
+ * length low      | [17:16]| 16    | 0x03 | Lower 2 bits of total length
+ * Note: Reassembled length = (length_high << 2) | length_low (Total 10 bits)
+ */
+#define NAU8360_REPLY_LEN_HIGH_MASK	GENMASK(31, 24)
+#define NAU8360_REPLY_ID_MASK		GENMASK(23, 18)
+#define NAU8360_REPLY_LEN_LOW_MASK	GENMASK(17, 16)
+
+static const struct nau8360_cmd_info nau8360_dsp_cmd_table[] = {
+	NAU_DSP_CMD(NAU8360_DSP_CMD_GET_COUNTER,      0, 0, 1),
+	NAU_DSP_CMD(NAU8360_DSP_CMD_GET_FRAME_STATUS, 0, 0, 1),
+	NAU_DSP_CMD(NAU8360_DSP_CMD_GET_REVISION,     0, 0, 1),
+	NAU_DSP_CMD(NAU8360_DSP_CMD_GET_KCS_RSLTS,    1, 0, 1),
+	NAU_DSP_CMD(NAU8360_DSP_CMD_GET_KCS_SETUP,    1, 0, 1),
+	NAU_DSP_CMD(NAU8360_DSP_CMD_SET_KCS_SETUP,    1, 1, 1),
+	NAU_DSP_CMD_ID(NAU8360_DSP_CMD_CLK_STOP),
+	NAU_DSP_CMD_ID(NAU8360_DSP_CMD_CLK_RESTART),
+};
+
+static const char *const dsp_cmd_table[] = {
+	[NAU8360_DSP_CMD_GET_COUNTER] = "GET_COUNTER",
+	[NAU8360_DSP_CMD_GET_FRAME_STATUS] = "GET_FRAME_STATUS",
+	[NAU8360_DSP_CMD_GET_REVISION] = "GET_REVISION",
+	[NAU8360_DSP_CMD_GET_KCS_RSLTS] = "GET_KCS_RSLTS",
+	[NAU8360_DSP_CMD_GET_KCS_SETUP] = "GET_KCS_SETUP",
+	[NAU8360_DSP_CMD_SET_KCS_SETUP] = "SET_KCS_SETUP",
+	[NAU8360_DSP_CMD_CLK_STOP] = "CLK_STOP",
+	[NAU8360_DSP_CMD_CLK_RESTART] = "CLK_RESTART",
+};
+
+static int nau8360_dsp_idle(struct snd_soc_component *cp, unsigned short dsp_addr)
+{
+	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(cp);
+	unsigned int idle_pattern, timeout = NAU8360_DSP_IDLE_RETRY * USEC_PER_MSEC;
+	int ret = 0;
+
+	ret = regmap_read_poll_timeout(nau8360->regmap, dsp_addr, idle_pattern,
+		idle_pattern == NAU8360_DSP_COMM_IDLE_WORD, USEC_PER_MSEC, timeout);
+	if (ret)
+		dev_err(nau8360->dev, "Timeout waiting for DSP idle state: %d", ret);
+
+	return ret;
+}
+
+/**
+ * nau8360_pack_preamble - Pack DSP preamble fragment
+ * @cmd_id: Command ID for the DSP message
+ * @frag_len: Total length of the message fragments
+ *
+ * Return: 32-bit packed payload in Little Endian format.
+ */
+static inline u32 nau8360_pack_preamble(u8 cmd_id, u16 frag_len)
+{
+	return FIELD_PREP(NAU8360_HOST_PREAMBLE_MASK, NAU8360_DSP_COMM_PREAMBLE) |
+		FIELD_PREP(NAU8360_HOST_CMD_ID_MASK, cmd_id) |
+		FIELD_PREP(NAU8360_HOST_LEN_LOW_MASK, frag_len) |
+		FIELD_PREP(NAU8360_HOST_LEN_HIGH_MASK, frag_len >> 2);
+}
+
+/**
+ * nau8360_pack_param - Pack DSP parameter fragment
+ * @param_offset: Starting offset of the parameter data
+ * @param_size: Size of the parameter data in bytes
+ *
+ * Return: 32-bit packed payload in Little Endian format.
+ */
+static inline u32 nau8360_pack_param(u16 param_offset, u16 param_size)
+{
+	return FIELD_PREP(NAU8360_HOST_PARAM_OFFSET_MASK, param_offset) |
+		FIELD_PREP(NAU8360_HOST_PARAM_SIZE_MASK, param_size);
+}
+
+/**
+ * nau8360_pack_trailing - Pack DSP trailing fragment
+ * @frag_cnt: Current fragment count
+ * @padding: Number of padding bytes added to the final data fragment
+ *
+ * Return: 32-bit packed payload in Little Endian format.
+ */
+static inline u32 nau8360_pack_trailing(u16 frag_cnt, u8 padding)
+{
+	return FIELD_PREP(NAU8360_TRAIL_LEN_LOW_MASK, frag_cnt) |
+		FIELD_PREP(NAU8360_TRAIL_PAD_MASK, padding) |
+		FIELD_PREP(NAU8360_TRAIL_LEN_HIGH_MASK, frag_cnt >> 8);
+}
+
+static void nau8360_send_data_payload(struct snd_soc_component *cp,
+	unsigned short dsp_addr, const void *param_data, int param_size,
+	int *frag_cnt, int *padding)
+{
+	const u8 *data = (const u8 *)param_data;
+	u32 payload = 0;
+	int i, data_size = 0;
+
+	for (i = 0; i < param_size; i++) {
+		payload |= data[i] << (data_size * 8);
+		data_size++;
+
+		if (data_size == NAU8360_DSP_DATA_BYTE) {
+			snd_soc_component_write(cp, dsp_addr, payload);
+			data_size = 0;
+			payload = 0;
+			(*frag_cnt)++;
+		}
+	}
+
+	if (data_size > 0) {
+		*padding = NAU8360_DSP_DATA_BYTE - data_size;
+		snd_soc_component_write(cp, dsp_addr, payload);
+		(*frag_cnt)++;
+	}
+}
+
+static int nau8360_message_to_dsp(struct snd_soc_component *cp,
+	const struct nau8360_cmd_info *cmd_info, int frag_len, int param_offset,
+	int param_size, void *param_data, unsigned short dsp_addr)
+{
+	unsigned int payload;
+	int ret, padding = 0, frag_cnt = 0;
+
+	ret = nau8360_dsp_idle(cp, dsp_addr);
+	if (ret)
+		return ret;
+
+	/* sending preamble fragment */
+	payload = nau8360_pack_preamble(cmd_info->cmd_id, frag_len);
+	snd_soc_component_write(cp, dsp_addr, payload);
+
+	if (!cmd_info->msg_param)
+		return ret;
+
+	/* sending payload + padding */
+	payload = nau8360_pack_param(param_offset, param_size);
+	snd_soc_component_write(cp, dsp_addr, payload);
+	frag_cnt++;
+
+	if (cmd_info->setup_data)
+		nau8360_send_data_payload(cp, dsp_addr, param_data, param_size,
+			&frag_cnt, &padding);
+
+	/* sending trailing fragment */
+	frag_cnt++;
+	payload = nau8360_pack_trailing(frag_cnt, padding);
+	snd_soc_component_write(cp, dsp_addr, payload);
+
+	if (frag_cnt != frag_len) {
+		dev_err(cp->dev, "message error (CMD_ID 0x%x, LEN 0x%x) !!!",
+			cmd_info->cmd_id, frag_cnt);
+		return -EPROTO;
+	}
+
+	return 0;
+}
+
+static int nau8360_dsp_replied(struct nau8360 *nau8360, int *length,
+	unsigned short dsp_addr)
+{
+	unsigned int reply_preamble;
+	int ret, reply_id;
+
+	ret = regmap_read_poll_timeout(nau8360->regmap, dsp_addr, reply_preamble,
+		(reply_preamble & 0xffff) == NAU8360_DSP_COMM_PREAMBLE,
+		USEC_PER_MSEC, NAU8360_DSP_IDLE_RETRY * USEC_PER_MSEC);
+	if (ret) {
+		dev_err(nau8360->dev, "timeout for reply preamble: %d", ret);
+		return ret;
+	}
+
+	*length = FIELD_GET(NAU8360_REPLY_LEN_LOW_MASK, reply_preamble);
+	*length |= FIELD_GET(NAU8360_REPLY_LEN_HIGH_MASK, reply_preamble) << 2;
+	reply_id = FIELD_GET(NAU8360_REPLY_ID_MASK, reply_preamble);
+
+	return (reply_id != NAU8360_DSP_REPLY_OK) ? -reply_id : 0;
+}
+
+static int nau8360_validate_trailing(struct snd_soc_component *cp,
+	unsigned short dsp_addr, int frag_len, int pad_len_exp)
+{
+	int ret, len_pos, pad_len;
+	unsigned int payload;
+	struct device *dev = cp->dev;
+	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(cp);
+
+	/* reading trailing fragment */
+	ret = regmap_read(nau8360->regmap, dsp_addr, &payload);
+	if (ret) {
+		dev_err(dev, "failed to read trailing fragment");
+		return ret;
+	}
+
+	len_pos = FIELD_GET(NAU8360_TRAIL_LEN_LOW_MASK, payload);
+	len_pos |= FIELD_GET(NAU8360_TRAIL_LEN_HIGH_MASK, payload) << 8;
+
+	if (len_pos != frag_len) {
+		dev_err(dev, "LEN_POST %02X, expect %02X", len_pos, frag_len);
+		return -EPROTO;
+	}
+
+	pad_len = FIELD_GET(NAU8360_TRAIL_PAD_MASK, payload);
+	if (pad_len != pad_len_exp) {
+		dev_err(dev, "PAD_LEN %02X, expect %02X", pad_len, pad_len_exp);
+		return -EPROTO;
+	}
+
+	return 0;
+}
+
+static int nau8360_read_data_payload(struct snd_soc_component *cp,
+	unsigned short dsp_addr, int frag_len, bool msg_param,
+	void *data, int data_size, int *data_count)
+{
+	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(cp);
+	struct device *dev = cp->dev;
+	unsigned int payload;
+	u32 *data_buf = data;
+	int i, j, ret;
+
+	*data_count = (msg_param) ? data_size : 0;
+	for (i = 0; i < frag_len - 1; i++) {
+		ret = regmap_read(nau8360->regmap, dsp_addr, &payload);
+		if (ret) {
+			dev_err(dev, "failed to read payload of dsp");
+			return ret;
+		}
+
+		if (!msg_param) {
+			*data_buf++ = payload;
+			break;
+		}
+
+		if (*data_count >= NAU8360_DSP_DATA_BYTE) {
+			*data_buf++ = payload;
+			*data_count -= NAU8360_DSP_DATA_BYTE;
+		} else if (*data_count > 0) {
+			for (j = 0; j < *data_count; j++)
+				((u8 *)data_buf)[j] = (payload >> (j * 8)) & 0xff;
+
+			*data_count = 0;
+		}
+
+		if (*data_count == 0)
+			break;
+	}
+
+	return 0;
+}
+
+static int nau8360_reply_from_dsp(struct snd_soc_component *cp,
+	const struct nau8360_cmd_info *cmd_info, int data_size,
+	void *data, unsigned short dsp_addr)
+{
+	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(cp);
+	struct device *dev = cp->dev;
+	int ret, frag_len, pad_len_exp, data_count = 0;
+
+	ret = nau8360_dsp_replied(nau8360, &frag_len, dsp_addr);
+	if (ret)
+		return ret;
+	if (!frag_len || !cmd_info->reply_data)
+		return 0;
+	if (!data || frag_len == 1)
+		return -EINVAL;
+
+	ret = nau8360_read_data_payload(cp, dsp_addr, frag_len,
+		cmd_info->msg_param, data, data_size, &data_count);
+	if (ret)
+		return ret;
+
+	/* check the reply length same as request */
+	if (data_count && (cmd_info->cmd_id == NAU8360_DSP_CMD_GET_KCS_RSLTS ||
+		cmd_info->cmd_id == NAU8360_DSP_CMD_GET_KCS_SETUP))
+		dev_warn(dev, "payload_len %d, expected %d",
+			data_size - data_count, data_size);
+
+	pad_len_exp = cmd_info->msg_param ?
+		(frag_len - 1) * NAU8360_DSP_DATA_BYTE - (data_size - data_count) : 0;
+	return nau8360_validate_trailing(cp, dsp_addr, frag_len, pad_len_exp);
+}
+
+/**
+ * nau8360_send_dsp_command - Send command to DSP
+ *
+ * @component:  component to register
+ * @cmd_id:  DSP supported command ID
+ * @kcs_setup: KCS setup structure
+ * @dsp_addr: DSP address
+ *
+ * The communication protocol is a Master-Slave type protocol
+ * where the host processor is the master and DSP is the slave.
+ * The Master initiates the communication and can either write or
+ * read back from the slave.
+ * Transactions from the Master are called "Messages",
+ * and read-back data from the Slave is called a "Reply".
+ *
+ * The function sends command to DSP according to the command ID.
+ * These commands include getting the information of DSP,
+ * getting or setting KCS configuration, or making DSP control.
+ */
+static int nau8360_send_dsp_command(struct snd_soc_component *cp, int cmd_id,
+	struct nau8360_kcs_setup *kcs_setup, unsigned short dsp_addr)
+{
+	const struct nau8360_cmd_info *cmd_info;
+	int ret = 0, frag_len = 0;
+
+	cmd_info = &nau8360_dsp_cmd_table[cmd_id];
+	if ((cmd_info->msg_param && !kcs_setup->set_len) ||
+		(cmd_info->setup_data && !kcs_setup->set_kcs_data) ||
+		(cmd_info->reply_data && !kcs_setup->get_data))
+		return -EFAULT;
+
+	/* Read up to 1kB data because the LEN field to request data is 10-bits
+	 * long; and not beyond 3kB offset.
+	 */
+	if (cmd_id == NAU8360_DSP_CMD_GET_KCS_SETUP &&
+		(kcs_setup->set_len > NAU8360_DSP_KCS_DAT_LEN_MAX ||
+		kcs_setup->set_kcs_offset > NAU8360_DSP_KCS_OFFSET_MAX))
+		return -ERANGE;
+
+	/* one fragment for offset and size parameters
+	 * one fragment for a postamble fragment
+	 */
+	if (cmd_info->msg_param)
+		frag_len += 2;
+
+	/* fragments for KCS setup writen */
+	if (cmd_info->setup_data)
+		frag_len += DIV_ROUND_UP(kcs_setup->set_len, NAU8360_DSP_DATA_BYTE);
+
+	ret = nau8360_message_to_dsp(cp, cmd_info, frag_len,
+		kcs_setup->set_kcs_offset, kcs_setup->set_len,
+		kcs_setup->set_kcs_data, dsp_addr);
+	if (ret)
+		return ret;
+
+	return nau8360_reply_from_dsp(cp, cmd_info, kcs_setup->get_len,
+		kcs_setup->get_data, dsp_addr);
+}
+
+static inline int nau8360_dsp_exec_command(struct snd_soc_component *cp, int cmd_id,
+	int offset, int set_len, void *set_data, int get_len, void *get_data,
+	int dsp_addr)
+{
+	struct nau8360_kcs_setup kcs_setup = {
+		.set_kcs_offset = offset,
+		.set_len = set_len,
+		.set_kcs_data = set_data,
+		.get_len = get_len,
+		.get_data = get_data,
+	};
+
+	return nau8360_send_dsp_command(cp, cmd_id, &kcs_setup, dsp_addr);
+}
+
+static inline int nau8360_send_dsp_broadcast(struct snd_soc_component *cp, int cmd_id)
+{
+	int i, ret;
+
+	for (i = 0; i < NAU8360_DSP_FW_NUM; i++) {
+		ret = nau8360_dsp_exec_command(cp, cmd_id, 0, 0, NULL, 0, NULL,
+			nau8360_dsp_addr[i]);
+		if (ret) {
+			dev_err(cp->dev, "DSP %x fail (%d)", nau8360_dsp_addr[i], ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * nau8360_dsp_kcs_setup - Send KCS setup command to DSP
+ *
+ * @component:  component to register
+ * @offset: address offset relative to KCS start
+ * @size: size of data writen to KCS
+ * @data: data writen to KCS setup
+ * @dsp_addr : DSP address
+ *
+ * The function sends KCS setup command to DSP for
+ * setting KCS configuration. The maximum size that you can transfer into
+ * the DSP is 96 bytes. Therefore, the driver has to split the data into
+ * 96 bytes chucks, if the setup configuration over the threshold.
+ */
+static int nau8360_dsp_kcs_setup(struct snd_soc_component *cp, int offset, int size,
+	const void *data, unsigned short dsp_addr)
+{
+	u8 *data_buf = (u8 *)data;
+	unsigned int kcs_rst = 0;
+	int retries = 0, ret, data_len, data_rem, addr_offset;
+
+	/* Limit full load of KCS_SETUP data and not beyond 3kB offset. */
+	if (!data || size > NAU8360_DSP_KCS_DAT_LEN_MAX ||
+		offset > NAU8360_DSP_KCS_OFFSET_MAX)
+		return -EINVAL;
+
+	/* sending fragments for KCS setup */
+	addr_offset = offset;
+	data_rem = size;
+
+	while (data_rem) {
+		data_len = min(data_rem, NAU8360_DSP_KCS_TX_MAX);
+
+		ret = nau8360_dsp_exec_command(cp, NAU8360_DSP_CMD_SET_KCS_SETUP,
+			addr_offset, data_len, (void *)data_buf, 0, &kcs_rst, dsp_addr);
+		if (ret) {
+			if (retries++ < NAU8360_DSP_RETRY_MAX)
+				continue;
+			return ret;
+		}
+
+		data_buf += (u8)data_len;
+		addr_offset += data_len;
+		data_rem -= data_len;
+
+		/* checking KCS result */
+		ret = nau8360_dsp_exec_command(cp, NAU8360_DSP_CMD_GET_KCS_RSLTS,
+			0, NAU8360_DSP_DATA_BYTE, NULL,
+			NAU8360_DSP_DATA_BYTE, &kcs_rst, dsp_addr);
+		if (ret)
+			return ret;
+		if (kcs_rst != NAU8360_DSP_KCS_RSLTS_SUCCESS)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int nau8360_dsp_get_cmd_put(struct snd_soc_component *cp,
+	int dsp_addr, int cmd, int *value)
+{
+	struct device *dev = cp->dev;
+	int ret;
+
+	dev_dbg(dev, "send DSP %x command %s", dsp_addr, dsp_cmd_table[cmd]);
+
+	ret = nau8360_dsp_exec_command(cp, cmd, 0, sizeof(int), NULL,
+		sizeof(int), value, dsp_addr);
+	if (ret) {
+		dev_err(dev, "do command fail (%d)", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int nau8360_dsp_clock_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *cp = snd_soc_dapm_to_component(w->dapm);
+	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(cp);
+	int ret = 0;
+
+	mutex_lock(&nau8360->lock);
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		ret = nau8360_send_dsp_broadcast(cp, NAU8360_DSP_CMD_CLK_RESTART);
+	else if (SND_SOC_DAPM_EVENT_OFF(event))
+		ret = nau8360_send_dsp_broadcast(cp, NAU8360_DSP_CMD_CLK_STOP);
+
+	mutex_unlock(&nau8360->lock);
+
+	return ret;
+}
+
+static const struct snd_soc_dapm_widget nau8360_dsp_dapm_widgets[] = {
+	SND_SOC_DAPM_SUPPLY("DSP Clock", SND_SOC_NOPM, 0, 0, nau8360_dsp_clock_event,
+		SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+};
+
+static const struct snd_soc_dapm_route nau8360_dsp_dapm_routes[] = {
+	{ "DSP", NULL, "HW3 Engine" },
+	{ "DSP", NULL, "DSP Clock" },
+};
+
+static int nau8360_dsp_chan_kcs_setup(struct snd_soc_component *cp,
+	const char *fw_name, int dsp_addr)
+{
+	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(cp);
+	const struct firmware *fw;
+	int buf_off, buf_len;
+	int ret = 0, status = 0;
+
+	mutex_lock(&nau8360->lock);
+	ret = nau8360_dsp_get_cmd_put(cp, dsp_addr,
+		NAU8360_DSP_CMD_GET_FRAME_STATUS, &status);
+	mutex_unlock(&nau8360->lock);
+	if (ret || !(status & NAU8360_DSP_ALGO_OK)) {
+		dev_err(cp->dev, "DSP %x is not ready", dsp_addr);
+		return -EIO;
+	}
+
+	dev_info(cp->dev, "DSP %x is ready to load firmware %s, status %x",
+		dsp_addr, fw_name, status);
+
+	ret = request_firmware(&fw, fw_name, cp->dev);
+	if (ret) {
+		dev_err(cp->dev, "failed to load firmware (%d)", ret);
+		return ret;
+	}
+
+	buf_off = 0;
+	buf_len = nau8360->kcs_setup_size = fw->size;
+	mutex_lock(&nau8360->lock);
+	ret = nau8360_dsp_kcs_setup(cp, buf_off, buf_len, fw->data, dsp_addr);
+	mutex_unlock(&nau8360->lock);
+	if (ret) {
+		dev_err(cp->dev, "send DSP command %s fail (%d)",
+			dsp_cmd_table[NAU8360_DSP_CMD_SET_KCS_SETUP], ret);
+	}
+	release_firmware(fw);
+
+	return ret;
+}
+
+int nau8360_dsp_init(struct snd_soc_component *cp)
+{
+	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(cp);
+	int i, ret;
+
+	for (i = 0; i < NAU8360_DSP_FW_NUM; i++) {
+		ret = nau8360_dsp_chan_kcs_setup(cp, nau8360->dsp_firmware[i], nau8360_dsp_addr[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int nau8360_dsp_setup_controls(struct snd_soc_component *cp)
+{
+	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(cp);
+	struct snd_soc_dapm_context *dapm = nau8360->dapm;
+	int ret;
+
+	ret = snd_soc_dapm_new_controls(dapm, nau8360_dsp_dapm_widgets,
+			ARRAY_SIZE(nau8360_dsp_dapm_widgets));
+	if (ret) {
+		dev_err(cp->dev, "add DSP widget fail (%d)", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dapm_add_routes(dapm, nau8360_dsp_dapm_routes,
+			ARRAY_SIZE(nau8360_dsp_dapm_routes));
+	if (ret) {
+		dev_err(cp->dev, "add DSP route fail (%d)", ret);
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/sound/soc/codecs/nau8360-dsp.h b/sound/soc/codecs/nau8360-dsp.h
new file mode 100644
index 000000000000..f8c2c97a25c4
--- /dev/null
+++ b/sound/soc/codecs/nau8360-dsp.h
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// The NAU83G60 Stereo Class-D Amplifier with DSP and I/V-sense driver.
+//
+// Copyright (C) 2026 Nuvoton Technology Corp.
+// Author: David Lin <ctlin0@nuvoton.com>
+//         Seven Lee <wtli@nuvoton.com>
+//         John Hsu <kchsu0@nuvoton.com>
+//         Neo Chang <ylchang2@nuvoton.com>
+
+#ifndef __NAU8360_DSP_H__
+#define __NAU8360_DSP_H__
+
+#define NAU8360_DSP_COMM_IDLE_WORD		0xf4f3f2f1
+#define NAU8360_DSP_COMM_PREAMBLE		0xb2a1
+#define NAU8360_DSP_DATA_BYTE			4
+#define NAU8360_DSP_DATA_LEN			(NAU8360_DSP_DATA_BYTE << 3)
+/* max bytes of data to transfer into DSP each time during the KCS setup */
+#define NAU8360_DSP_KCS_TX_MAX			96
+#define NAU8360_DSP_RETRY_MAX			3
+#define NAU8360_DSP_KCS_DAT_LEN_MAX		1024
+#define NAU8360_DSP_KCS_OFFSET_MAX		3072
+#define NAU8360_DSP_KCS_RSLTS_SUCCESS	0x10
+
+/* FRAME_STATUS (0x9) */
+#define NAU8360_DSP_SNS_OVF_SFT			31
+#define NAU8360_DSP_SNS_OVF			(0x1 << NAU8360_DSP_SNS_OVF_SFT)
+#define NAU8360_DSP_AUD_UVF_SFT			30
+#define NAU8360_DSP_AUD_UVF			(0x1 << NAU8360_DSP_AUD_UVF_SFT)
+#define NAU8360_DSP_AUD_OVF_SFT			29
+#define NAU8360_DSP_AUD_OVF			(0x1 << NAU8360_DSP_AUD_OVF_SFT)
+#define NAU8360_DSP_ALC_STS_SFT			28
+#define NAU8360_DSP_ALC_STS			(0x1 << NAU8360_DSP_ALC_STS_SFT)
+#define NAU8360_DSP_CLK_STOP_SFT		25
+#define NAU8360_DSP_CLK_STOP			(0x1 << NAU8360_DSP_CLK_STOP_SFT)
+#define NAU8360_DSP_OCP_OTP_SFT			24
+#define NAU8360_DSP_OCP_OTP			(0x1 << NAU8360_DSP_OCP_OTP_SFT)
+#define NAU8360_DSP_UVLO_SFT			22
+#define NAU8360_DSP_UVLO			(0x1 << NAU8360_DSP_UVLO_SFT)
+#define NAU8360_DSP_OVP_SFT			21
+#define NAU8360_DSP_OVP				(0x1 << NAU8360_DSP_OVP_SFT)
+#define NAU8360_DSP_APWR_DWN_SFT		20
+#define NAU8360_DSP_APWR_DWN			(0x1 << NAU8360_DSP_APWR_DWN_SFT)
+#define NAU8360_DSP_SNSR_RATE_SFT		12
+#define NAU8360_DSP_SNSR_RATE_MASK		(0xff << NAU8360_DSP_SNSR_RATE_SFT)
+#define NAU8360_DSP_AUD_RATE_SFT		4
+#define NAU8360_DSP_AUD_RATE_MASK		(0xff << NAU8360_DSP_AUD_RATE_SFT)
+#define NAU8360_DSP_FEED_TRU_SFT		1
+#define NAU8360_DSP_FEED_TRU			(0x1 << NAU8360_DSP_FEED_TRU_SFT)
+#define NAU8360_DSP_ALGO_OK			0x1
+
+#define NAU8360_DSP_FIRMDIR			"Nuvoton/"
+#define NAU8360_DSP_FIRMWARE			NAU8360_DSP_FIRMDIR"NAU83G60.kcs.bin"
+#define NAU8360_DSP_FW_NUM			NAU8360_DSP_CORE_NUM
+#define NAU8360_DSP_FW_NAMELEN			64
+#define NAU8360_IS_DSP_REG(reg) \
+	((reg) == NAU8360_RF000_DSP_COMM || (reg) == NAU8360_RF002_DSP_COMM)
+
+enum {
+	NAU8360_DSP_REPLY_OK,
+	NAU8360_DSP_REPLY_MSG_INTEGRETY_ERR,
+	NAU8360_DSP_REPLY_EXECUTION_ERR,
+	NAU8360_DSP_REPLY_COMMAND_DOESNT_EXISTS_ERR,
+	NAU8360_DSP_REPLY_UNKNOWN_ERR,
+	NAU8360_DSP_REPLY_MSG_TOO_LONG,
+};
+
+enum {
+	NAU8360_DSP_CMD_GET_COUNTER	= 0x1,
+	NAU8360_DSP_CMD_GET_FRAME_STATUS	= 0x9,
+	NAU8360_DSP_CMD_GET_REVISION	= 0xa,
+	NAU8360_DSP_CMD_GET_KCS_RSLTS	= 0x4,
+	NAU8360_DSP_CMD_GET_KCS_SETUP	= 0x6,
+	NAU8360_DSP_CMD_SET_KCS_SETUP	= 0x7,
+	NAU8360_DSP_CMD_CLK_STOP	= 0xb,
+	NAU8360_DSP_CMD_CLK_RESTART	= 0xc,
+};
+
+/**
+ * struct nau8360_cmd_info - DSP command information structure
+ * @cmd_id:     The command identification number
+ * @msg_param:  Message parameters including offset, size, and data
+ * @setup_data: Setup data for write-only operations
+ * @reply_data: Reply data received from the DSP
+ */
+struct nau8360_cmd_info {
+	int cmd_id;
+	bool msg_param;
+	bool setup_data;
+	bool reply_data;
+};
+
+/**
+ * struct nau8360_kcs_setup - KCS setup configuration structure
+ * @set_len:        Length of data written in bytes
+ * @set_kcs_offset: Address offset relative to the start of KCS
+ * @set_kcs_data:   Pointer to the data written to KCS
+ * @get_len:        Length of data from the reply in bytes
+ * @get_data:       Pointer to the buffer for reply data
+ */
+struct nau8360_kcs_setup {
+	int set_len;
+	int set_kcs_offset;
+	void *set_kcs_data;
+	int get_len;
+	void *get_data;
+};
+
+/**
+ * struct nau8360_dsp_ctx - DSP context structure for firmware loading
+ * @cp:       Pointer to the ALSA SoC component structure
+ * @dsp_addr: Register address of the DSP core (Left or Right channel)
+ */
+struct nau8360_dsp_ctx {
+	struct snd_soc_component *cp;
+	int dsp_addr;
+};
+
+int nau8360_dsp_init(struct snd_soc_component *component);
+int nau8360_dsp_setup_controls(struct snd_soc_component *component);
+
+#endif /* __NAU8360_DSP_H__ */
diff --git a/sound/soc/codecs/nau8360.c b/sound/soc/codecs/nau8360.c
new file mode 100644
index 000000000000..cfc58ea219af
--- /dev/null
+++ b/sound/soc/codecs/nau8360.c
@@ -0,0 +1,2295 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// The NAU83G60 Stereo Class-D Amplifier with DSP and I/V-sense driver.
+//
+// Copyright (C) 2026 Nuvoton Technology Corp.
+// Author: David Lin <ctlin0@nuvoton.com>
+//         Seven Lee <wtli@nuvoton.com>
+//         John Hsu <kchsu0@nuvoton.com>
+//         Neo Chang <ylchang2@nuvoton.com>
+
+
+#include <linux/acpi.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/units.h>
+#include <linux/workqueue.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include "nau8360-dsp.h"
+#include "nau8360.h"
+
+/* range of Master Clock MCLK (Hz) */
+#define MASTER_CLK_MIN 11025000
+#define MASTER_CLK_MAX 24576000
+/* DSP Optimal Clock Range 120MHz~126M(Hz) */
+#define DSP_OP_CLK48 122880000
+#define DSP_OP_CLK44 112896000
+/* the maximum frequency of DAC and IV sense clock */
+#define CLK_DA_IVSNS_MAX 6144000
+#define ADSP_SR_48000 48000
+#define ADSP_SR_44100 44100
+
+static const int ivsns_clk_div[] = { 1, 2, 4, 5, 8, 10 };
+
+static const int dac_clk_div[] = { 1, 2, 4, 8 };
+
+static const char * const nau8360_rx_func_names[] = {
+	[NAU8360_TDM_DACL] = "DAC_L",
+	[NAU8360_TDM_DACR] = "DAC_R",
+	[NAU8360_TDM_ANCL] = "ANC_L",
+	[NAU8360_TDM_ANCR] = "ANC_R",
+};
+
+static const char * const nau8360_tx_func_names[] = {
+	[NAU8360_TDM_AECL]  = "AEC_L",
+	[NAU8360_TDM_AECR]  = "AEC_R",
+	[NAU8360_TDM_ISNSL] = "ISNS_L",
+	[NAU8360_TDM_ISNSR] = "ISNS_R",
+	[NAU8360_TDM_VSNSL] = "VSNS_L",
+	[NAU8360_TDM_VSNSR] = "VSNS_R",
+	[NAU8360_TDM_TJ]    = "TJ",
+	[NAU8360_TDM_VBAT]  = "VBAT",
+};
+
+/* PLL threshold */
+#define PLL_FREQ_MIN 1000000
+#define PLL_FREQ_MAX 32000000
+#define PLL_FOUT_MIN 12500000
+#define PLL_FOUT_MAX 125000000
+#define PLL_FREF_MAX 8000000
+#define PLL_FVCO_MIN 50000000
+#define MSEL_MAX 32
+#define RSEL_MAX 4
+
+static const struct reg_default nau8360_reg_defaults[] = {
+	{ NAU8360_R02_I2C_ADDR, 0x0000 },
+	{ NAU8360_R03_CLK_CTRL0, 0x0000 },
+	{ NAU8360_R04_CLK_CTRL1, 0x0000 },
+	{ NAU8360_R05_INTERRUPT_CTRL, 0x40ff },
+	{ NAU8360_R07_GP_CTRL, 0xaa30 },
+	{ NAU8360_R08_GP_CTRL0, 0x1e1e },
+	{ NAU8360_R09_GP_CTRL1, 0x1e1e },
+	{ NAU8360_R0A_GP_CTRL2, 0x0000 },
+	{ NAU8360_R0B_I2S_PCM_CTRL1, 0x0702 },
+	{ NAU8360_R0C_I2S_PCM_CTRL2, 0x0a10 },
+	{ NAU8360_R0D_I2S_PCM_CTRL3, 0x1300 },
+	{ NAU8360_R0E_I2S_DATA_CTRL1, 0x0304 },
+	{ NAU8360_R0F_I2S_DATA_CTRL2, 0x080b },
+	{ NAU8360_R10_I2S_DATA_CTRL3, 0x0014 },
+	{ NAU8360_R11_I2S_DATA_CTRL4, 0x0014 },
+	{ NAU8360_R12_PATH_CTRL, 0x0400 },
+	{ NAU8360_R17_I2S0_DATA_CTRL5, 0x0014 },
+	{ NAU8360_R1A_DSP_CORE_CTRL2, 0x0010 },
+	{ NAU8360_R2C_ALC_CTRL1, 0x2000 },
+	{ NAU8360_R2D_ALC_CTRL2, 0x8400 },
+	{ NAU8360_R2E_ALC_CTRL3, 0x2083 },
+	{ NAU8360_R31_UVLOP_CTRL1, 0x0000 },
+	{ NAU8360_R32_UVLOP_CTRL2, 0x8400 },
+	{ NAU8360_R33_UVLOP_CTRL3, 0x0000 },
+	{ NAU8360_R40_CLK_DET_CTRL, 0xca60 },
+	{ NAU8360_R41_CLK_CTL2, 0xc400 },
+	{ NAU8360_R5D_SINC_CFG, 0x0010 },
+	{ NAU8360_R5F_ANA_TRIM_CFG1, 0x8400 },
+	{ NAU8360_R60_RST, 0x0010 },
+	{ NAU8360_R67_ANALOG_CONTROL_0, 0x0160 },
+	{ NAU8360_R68_ANALOG_CONTROL_1, 0x00d4 },
+	{ NAU8360_R6A_SARADC_CFG0, 0x5c09 },
+	{ NAU8360_R6B_SARADC_CFG1, 0x0008 },
+	{ NAU8360_R6C_IVSNS_CFG0, 0xf040 },
+	{ NAU8360_R6D_IVSNS_CFG1, 0x3555 },
+	{ NAU8360_R6E_DAC_CFG0, 0x0ed5 },
+	{ NAU8360_R71_CLK_DIV_CFG, 0x0211 },
+	{ NAU8360_R72_PLL_CFG0, 0xccc4 },
+	{ NAU8360_R73_PLL_CFG1, 0x0101 },
+	{ NAU8360_R74_PLL_CFG2, 0x0000 },
+	{ NAU8360_R7A_DAC_TRIM_CFG2, 0x0000 },
+	{ NAU8360_R7B_IVSNS_TRIM_CFG, 0x0000 },
+	{ NAU8360_R7C_MISC_TRIM_CFG, 0x72d5 },
+	{ NAU8360_R86_HW3_CTL0, 0x2000 },
+	{ NAU8360_R88_ALC_CTRL6, 0x0000 },
+	{ NAU8360_R8A_HW3_VL_CTL7, 0xc000 },
+	{ NAU8360_R8B_HW3_VR_CTL8, 0xc000 },
+	{ NAU8360_R8C_HW3_CTL6, 0x0000 },
+	{ NAU8360_R8D_HW3_IL_CTL7, 0xc000 },
+	{ NAU8360_R8E_HW3_IR_CTL8, 0xc000 },
+	{ NAU8360_R8F_HW3_CTL9, 0x0000 },
+	{ NAU8360_R90_HW2_CTL0, 0x2000 },
+	{ NAU8360_R96_HW2_CTL6, 0x0000 },
+	{ NAU8360_R97_HW2_CTL7, 0xc000 },
+	{ NAU8360_R98_HW2_CTL8, 0xc000 },
+	{ NAU8360_R99_HW2_CTL9, 0x0000 },
+	{ NAU8360_R9A_HW1_CTL0, 0xc000 },
+	{ NAU8360_R9B_HW1_CTL1, 0xc000 },
+	{ NAU8360_R9C_HW1_CTL2, 0x0800 },
+	{ NAU8360_R9D_PEQ_CTL, 0x0001 },
+	{ NAU8360_RA0_LEFT_XODRC_CTRL, 0x0000 },
+	{ NAU8360_RA2_RIGHT_XODRC_CTRL, 0x0000 },
+	{ NAU8360_RA4_ANA_REG_0, 0x7f86 },
+	{ NAU8360_RA5_ANA_REG_1, 0x276e },
+};
+
+static bool nau8360_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case NAU8360_R00_SOFTWARE_RST ... NAU8360_R12_PATH_CTRL:
+	case NAU8360_R17_I2S0_DATA_CTRL5:
+	case NAU8360_R1A_DSP_CORE_CTRL2:
+	case NAU8360_R21_VBAT_READOUT ... NAU8360_R22_TEMP_READOUT:
+	case NAU8360_R2C_ALC_CTRL1 ... NAU8360_R2E_ALC_CTRL3:
+	case NAU8360_R31_UVLOP_CTRL1 ... NAU8360_R33_UVLOP_CTRL3:
+	case NAU8360_R40_CLK_DET_CTRL ... NAU8360_R41_CLK_CTL2:
+	case NAU8360_R46_I2C_DEVICE_ID:
+	case NAU8360_R5D_SINC_CFG:
+	case NAU8360_R5F_ANA_TRIM_CFG1 ... NAU8360_R60_RST:
+	case NAU8360_R67_ANALOG_CONTROL_0 ... NAU8360_R6E_DAC_CFG0:
+	case NAU8360_R71_CLK_DIV_CFG ... NAU8360_R74_PLL_CFG2:
+	case NAU8360_R77_SOFT_SD ... NAU8360_R7C_MISC_TRIM_CFG:
+	case NAU8360_R7E_CLK_GATED_EN:
+	case NAU8360_R86_HW3_CTL0:
+	case NAU8360_R88_ALC_CTRL6:
+	case NAU8360_R8A_HW3_VL_CTL7 ... NAU8360_R90_HW2_CTL0:
+	case NAU8360_R96_HW2_CTL6 ... NAU8360_R9D_PEQ_CTL:
+	case NAU8360_RA0_LEFT_XODRC_CTRL:
+	case NAU8360_RA2_RIGHT_XODRC_CTRL:
+	case NAU8360_RA4_ANA_REG_0 ... NAU8360_RA5_ANA_REG_1:
+	case NAU8360_R100_LEFT_BIQ0_COE ... (NAU8360_R100_LEFT_BIQ0_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R10C_LEFT_BIQ1_COE ... (NAU8360_R10C_LEFT_BIQ1_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R118_LEFT_BIQ2_COE ... (NAU8360_R118_LEFT_BIQ2_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R124_LEFT_BIQ3_COE ... (NAU8360_R124_LEFT_BIQ3_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R130_LEFT_BIQ4_COE ... (NAU8360_R130_LEFT_BIQ4_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R13C_LEFT_BIQ5_COE ... (NAU8360_R13C_LEFT_BIQ5_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R148_LEFT_BIQ6_COE ... (NAU8360_R148_LEFT_BIQ6_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R154_LEFT_BIQ7_COE ... (NAU8360_R154_LEFT_BIQ7_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R160_LEFT_BIQ8_COE ... (NAU8360_R160_LEFT_BIQ8_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R16C_LEFT_BIQ9_COE ... (NAU8360_R16C_LEFT_BIQ9_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R178_LEFT_BIQ10_COE ... (NAU8360_R178_LEFT_BIQ10_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R184_LEFT_BIQ11_COE ... (NAU8360_R184_LEFT_BIQ11_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R190_LEFT_BIQ12_COE ... (NAU8360_R190_LEFT_BIQ12_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R19C_LEFT_BIQ13_COE ... (NAU8360_R19C_LEFT_BIQ13_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R1A8_LEFT_BIQ14_COE ... (NAU8360_R1A8_LEFT_BIQ14_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R200_RIGHT_BIQ0_COE ... (NAU8360_R200_RIGHT_BIQ0_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R20C_RIGHT_BIQ1_COE ... (NAU8360_R20C_RIGHT_BIQ1_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R218_RIGHT_BIQ2_COE ... (NAU8360_R218_RIGHT_BIQ2_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R224_RIGHT_BIQ3_COE ... (NAU8360_R224_RIGHT_BIQ3_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R230_RIGHT_BIQ4_COE ... (NAU8360_R230_RIGHT_BIQ4_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R23C_RIGHT_BIQ5_COE ... (NAU8360_R23C_RIGHT_BIQ5_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R248_RIGHT_BIQ6_COE ... (NAU8360_R248_RIGHT_BIQ6_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R254_RIGHT_BIQ7_COE ... (NAU8360_R254_RIGHT_BIQ7_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R260_RIGHT_BIQ8_COE ... (NAU8360_R260_RIGHT_BIQ8_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R26C_RIGHT_BIQ9_COE ... (NAU8360_R26C_RIGHT_BIQ9_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R278_RIGHT_BIQ10_COE ... (NAU8360_R278_RIGHT_BIQ10_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R284_RIGHT_BIQ11_COE ... (NAU8360_R284_RIGHT_BIQ11_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R290_RIGHT_BIQ12_COE ... (NAU8360_R290_RIGHT_BIQ12_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R29C_RIGHT_BIQ13_COE ... (NAU8360_R29C_RIGHT_BIQ13_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R2A8_RIGHT_BIQ14_COE ... (NAU8360_R2A8_RIGHT_BIQ14_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_RF000_DSP_COMM:
+	case NAU8360_RF002_DSP_COMM:
+		return true;
+	default:
+		return false;
+	}
+
+}
+
+static bool nau8360_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case NAU8360_R00_SOFTWARE_RST ... NAU8360_R12_PATH_CTRL:
+	case NAU8360_R17_I2S0_DATA_CTRL5:
+	case NAU8360_R1A_DSP_CORE_CTRL2:
+	case NAU8360_R2C_ALC_CTRL1 ... NAU8360_R2E_ALC_CTRL3:
+	case NAU8360_R31_UVLOP_CTRL1 ... NAU8360_R33_UVLOP_CTRL3:
+	case NAU8360_R40_CLK_DET_CTRL ... NAU8360_R41_CLK_CTL2:
+	case NAU8360_R5D_SINC_CFG:
+	case NAU8360_R5F_ANA_TRIM_CFG1:
+	case NAU8360_R60_RST:
+	case NAU8360_R67_ANALOG_CONTROL_0 ... NAU8360_R68_ANALOG_CONTROL_1:
+	case NAU8360_R6A_SARADC_CFG0 ... NAU8360_R6E_DAC_CFG0:
+	case NAU8360_R71_CLK_DIV_CFG ... NAU8360_R74_PLL_CFG2:
+	case NAU8360_R77_SOFT_SD ... NAU8360_R7C_MISC_TRIM_CFG:
+	case NAU8360_R7E_CLK_GATED_EN:
+	case NAU8360_R86_HW3_CTL0:
+	case NAU8360_R88_ALC_CTRL6:
+	case NAU8360_R8A_HW3_VL_CTL7 ... NAU8360_R90_HW2_CTL0:
+	case NAU8360_R96_HW2_CTL6 ... NAU8360_R9D_PEQ_CTL:
+	case NAU8360_RA4_ANA_REG_0 ... NAU8360_RA5_ANA_REG_1:
+	case NAU8360_R100_LEFT_BIQ0_COE ... (NAU8360_R100_LEFT_BIQ0_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R10C_LEFT_BIQ1_COE ... (NAU8360_R10C_LEFT_BIQ1_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R118_LEFT_BIQ2_COE ... (NAU8360_R118_LEFT_BIQ2_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R124_LEFT_BIQ3_COE ... (NAU8360_R124_LEFT_BIQ3_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R130_LEFT_BIQ4_COE ... (NAU8360_R130_LEFT_BIQ4_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R13C_LEFT_BIQ5_COE ... (NAU8360_R13C_LEFT_BIQ5_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R148_LEFT_BIQ6_COE ... (NAU8360_R148_LEFT_BIQ6_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R154_LEFT_BIQ7_COE ... (NAU8360_R154_LEFT_BIQ7_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R160_LEFT_BIQ8_COE ... (NAU8360_R160_LEFT_BIQ8_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R16C_LEFT_BIQ9_COE ... (NAU8360_R16C_LEFT_BIQ9_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R178_LEFT_BIQ10_COE ... (NAU8360_R178_LEFT_BIQ10_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R184_LEFT_BIQ11_COE ... (NAU8360_R184_LEFT_BIQ11_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R190_LEFT_BIQ12_COE ... (NAU8360_R190_LEFT_BIQ12_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R19C_LEFT_BIQ13_COE ... (NAU8360_R19C_LEFT_BIQ13_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R1A8_LEFT_BIQ14_COE ... (NAU8360_R1A8_LEFT_BIQ14_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R200_RIGHT_BIQ0_COE ... (NAU8360_R200_RIGHT_BIQ0_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R20C_RIGHT_BIQ1_COE ... (NAU8360_R20C_RIGHT_BIQ1_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R218_RIGHT_BIQ2_COE ... (NAU8360_R218_RIGHT_BIQ2_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R224_RIGHT_BIQ3_COE ... (NAU8360_R224_RIGHT_BIQ3_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R230_RIGHT_BIQ4_COE ... (NAU8360_R230_RIGHT_BIQ4_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R23C_RIGHT_BIQ5_COE ... (NAU8360_R23C_RIGHT_BIQ5_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R248_RIGHT_BIQ6_COE ... (NAU8360_R248_RIGHT_BIQ6_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R254_RIGHT_BIQ7_COE ... (NAU8360_R254_RIGHT_BIQ7_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R260_RIGHT_BIQ8_COE ... (NAU8360_R260_RIGHT_BIQ8_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R26C_RIGHT_BIQ9_COE ... (NAU8360_R26C_RIGHT_BIQ9_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R278_RIGHT_BIQ10_COE ... (NAU8360_R278_RIGHT_BIQ10_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R284_RIGHT_BIQ11_COE ... (NAU8360_R284_RIGHT_BIQ11_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R290_RIGHT_BIQ12_COE ... (NAU8360_R290_RIGHT_BIQ12_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R29C_RIGHT_BIQ13_COE ... (NAU8360_R29C_RIGHT_BIQ13_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_R2A8_RIGHT_BIQ14_COE ... (NAU8360_R2A8_RIGHT_BIQ14_COE +
+					NAU8360_PEQ_REG_WIDTH):
+	case NAU8360_RF000_DSP_COMM:
+	case NAU8360_RF002_DSP_COMM:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool nau8360_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case NAU8360_R00_SOFTWARE_RST ... NAU8360_R02_I2C_ADDR:
+	case NAU8360_R06_INT_CLR_STATUS:
+	case NAU8360_R21_VBAT_READOUT ... NAU8360_R22_TEMP_READOUT:
+	case NAU8360_R41_CLK_CTL2:
+	case NAU8360_R46_I2C_DEVICE_ID:
+	case NAU8360_R69_ANALOG_CONTROL_3:
+	case NAU8360_R77_SOFT_SD ... NAU8360_R79_EN_HIRC48M:
+	case NAU8360_R7E_CLK_GATED_EN:
+	case NAU8360_R9D_PEQ_CTL:
+	case NAU8360_RF000_DSP_COMM:
+	case NAU8360_RF002_DSP_COMM:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int nau8360_get_tdm_chan_len(struct nau8360 *nau8360)
+{
+	int val = 0;
+
+	regmap_read(nau8360->regmap, NAU8360_R0C_I2S_PCM_CTRL2, &val);
+	val = (val & NAU8360_TDM_CLEN_MASK) >> NAU8360_TDM_CLEN_SFT;
+
+	return (val << 3) + 16;
+}
+
+static inline bool nau8360_dsp_active(struct snd_soc_component *comp)
+{
+	return ((snd_soc_component_read(comp, NAU8360_R12_PATH_CTRL) >>
+		NAU8360_DAC_SEL_SFT) & 0x1) == 1;
+}
+
+static int nau8360_anc_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cp = snd_kcontrol_chip(kcontrol);
+	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(cp);
+	int ret, value = NAU8360_PEQ_BAND_8;
+
+	ret = snd_soc_put_volsw(kcontrol, ucontrol);
+	/* update anc flag if return value 1 and register value changed */
+	if (ret != 1)
+		return ret;
+
+	mutex_lock(&nau8360->lock);
+	nau8360->anc_enable = ucontrol->value.integer.value[0];
+	if (nau8360_dsp_active(cp))
+		value = nau8360->anc_enable ? NAU8360_PEQ_BAND_15 : NAU8360_PEQ_BAND_12;
+	regmap_update_bits(nau8360->regmap, NAU8360_R9D_PEQ_CTL, NAU8360_PEQ_BAND_MASK,
+		value << NAU8360_PEQ_BAND_SFT);
+	mutex_unlock(&nau8360->lock);
+
+	return ret;
+}
+
+static inline void nau8360_peq_mem_enable(struct regmap *regmap, bool enable)
+{
+	regmap_update_bits(regmap, NAU8360_R9D_PEQ_CTL,
+		NAU8360_HW1_MEM_TEST, enable ? NAU8360_HW1_MEM_TEST : 0);
+}
+
+static inline int nau8360_peq_regaddr(const char *id_name)
+{
+	int reg, band_num, dsp_addr = NAU8360_DSP_ADDR_BYNAME(id_name);
+	char *band = strstr(id_name, "BIQ");
+
+	if (!band || kstrtoint((band + 3), 10, &band_num))
+		return -EINVAL;
+	reg = dsp_addr == NAU8360_RF000_DSP_COMM ? NAU8360_R100_LEFT_BIQ0_COE :
+		NAU8360_R200_RIGHT_BIQ0_COE;
+	reg += band_num * NAU8360_TOT_BAND_COE_RANGE;
+
+	return reg;
+}
+
+static int nau8360_peq_coeff_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cp = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_to_dapm(cp);
+	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(cp);
+	struct soc_bytes_ext *params = (void *)kcontrol->private_value;
+	int i, value, reg, ret = 0;
+	u16 *val = (u16 *)ucontrol->value.bytes.data;
+
+	/* Use the DAPM lock to prevent race conditions during DAPM power-up
+	 * state transitions, and check component active status to prohibit
+	 * PEQ access during active audio streams (playback and capture).
+	 */
+	snd_soc_dapm_mutex_lock(dapm);
+	if (snd_soc_component_active(cp)) {
+		dev_dbg(nau8360->dev,
+			"PEQ coefficient access is ignored during audio is active");
+		goto unlock_dapm;
+	}
+
+	reg = nau8360_peq_regaddr(kcontrol->id.name);
+	if (reg < 0) {
+		ret = reg;
+		goto unlock_dapm;
+	}
+
+	mutex_lock(&nau8360->lock);
+	nau8360_peq_mem_enable(nau8360->regmap, true);
+	for (i = 0; i < params->max / sizeof(u16); i++) {
+		value = snd_soc_component_read(cp, reg + i);
+		*(val + i) = cpu_to_be16(value);
+	}
+	nau8360_peq_mem_enable(nau8360->regmap, false);
+	mutex_unlock(&nau8360->lock);
+
+unlock_dapm:
+	snd_soc_dapm_mutex_unlock(dapm);
+
+	return ret;
+}
+
+static int nau8360_peq_coeff_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cp = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_to_dapm(cp);
+	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(cp);
+	struct soc_bytes_ext *params = (void *)kcontrol->private_value;
+	int i, reg, ret = 0;
+	__be16 *data = NULL;
+	bool changed = false;
+
+	/* Use the DAPM lock to prevent race conditions during DAPM power-up
+	 * state transitions, and check component active status to prohibit
+	 * PEQ access during active audio streams (playback and capture).
+	 */
+	snd_soc_dapm_mutex_lock(dapm);
+	if (snd_soc_component_active(cp)) {
+		dev_dbg(nau8360->dev,
+			"PEQ coefficient access is ignored during audio is active");
+		goto unlock_dapm;
+	}
+
+	reg = nau8360_peq_regaddr(kcontrol->id.name);
+	if (reg < 0) {
+		ret = reg;
+		goto unlock_dapm;
+	}
+
+	data = kmemdup(ucontrol->value.bytes.data, params->max, GFP_KERNEL);
+	if (!data) {
+		ret = -ENOMEM;
+		goto unlock_dapm;
+	}
+
+	mutex_lock(&nau8360->lock);
+	nau8360_peq_mem_enable(nau8360->regmap, true);
+	for (i = 0; i < params->max / sizeof(u16); i++) {
+		if (snd_soc_component_read(cp, reg + i) != be16_to_cpu(*(data + i))) {
+			snd_soc_component_write(cp, reg + i, be16_to_cpu(*(data + i)));
+			changed = true;
+		}
+	}
+	nau8360_peq_mem_enable(nau8360->regmap, false);
+	mutex_unlock(&nau8360->lock);
+
+	ret = changed ? 1 : 0;
+
+unlock_dapm:
+	snd_soc_dapm_mutex_unlock(dapm);
+	kfree(data);
+
+	return ret;
+}
+
+#define NAU8360_PEQ_COEF_BYTES_EXT(ch, band) \
+	SND_SOC_BYTES_EXT(ch " PEQ Coefficients " band, 20, nau8360_peq_coeff_get, \
+		nau8360_peq_coeff_put)
+
+static const struct snd_kcontrol_new nau8360_snd_controls[] = {
+	NAU8360_PEQ_COEF_BYTES_EXT("Left", "BIQ0"),
+	NAU8360_PEQ_COEF_BYTES_EXT("Left", "BIQ1"),
+	NAU8360_PEQ_COEF_BYTES_EXT("Left", "BIQ2"),
+	NAU8360_PEQ_COEF_BYTES_EXT("Left", "BIQ3"),
+	NAU8360_PEQ_COEF_BYTES_EXT("Left", "BIQ4"),
+	NAU8360_PEQ_COEF_BYTES_EXT("Left", "BIQ5"),
+	NAU8360_PEQ_COEF_BYTES_EXT("Left", "BIQ6"),
+	NAU8360_PEQ_COEF_BYTES_EXT("Left", "BIQ7"),
+	NAU8360_PEQ_COEF_BYTES_EXT("Left", "BIQ8"),
+	NAU8360_PEQ_COEF_BYTES_EXT("Left", "BIQ9"),
+	NAU8360_PEQ_COEF_BYTES_EXT("Left", "BIQ10"),
+	NAU8360_PEQ_COEF_BYTES_EXT("Left", "BIQ11"),
+	NAU8360_PEQ_COEF_BYTES_EXT("Left", "BIQ12"),
+	NAU8360_PEQ_COEF_BYTES_EXT("Left", "BIQ13"),
+	NAU8360_PEQ_COEF_BYTES_EXT("Left", "BIQ14"),
+
+	NAU8360_PEQ_COEF_BYTES_EXT("Right", "BIQ0"),
+	NAU8360_PEQ_COEF_BYTES_EXT("Right", "BIQ1"),
+	NAU8360_PEQ_COEF_BYTES_EXT("Right", "BIQ2"),
+	NAU8360_PEQ_COEF_BYTES_EXT("Right", "BIQ3"),
+	NAU8360_PEQ_COEF_BYTES_EXT("Right", "BIQ4"),
+	NAU8360_PEQ_COEF_BYTES_EXT("Right", "BIQ5"),
+	NAU8360_PEQ_COEF_BYTES_EXT("Right", "BIQ6"),
+	NAU8360_PEQ_COEF_BYTES_EXT("Right", "BIQ7"),
+	NAU8360_PEQ_COEF_BYTES_EXT("Right", "BIQ8"),
+	NAU8360_PEQ_COEF_BYTES_EXT("Right", "BIQ9"),
+	NAU8360_PEQ_COEF_BYTES_EXT("Right", "BIQ10"),
+	NAU8360_PEQ_COEF_BYTES_EXT("Right", "BIQ11"),
+	NAU8360_PEQ_COEF_BYTES_EXT("Right", "BIQ12"),
+	NAU8360_PEQ_COEF_BYTES_EXT("Right", "BIQ13"),
+	NAU8360_PEQ_COEF_BYTES_EXT("Right", "BIQ14"),
+	SOC_SINGLE("Low Latency Switch", NAU8360_R96_HW2_CTL6,
+		NAU8360_HW2_LATENCY_SFT, 1, 0),
+	SOC_SINGLE_EXT("ANC Path Switch", NAU8360_R96_HW2_CTL6, NAU8360_HW1_ANC_EN_SFT,
+		1, 0, snd_soc_get_volsw, nau8360_anc_put),
+};
+
+static int nau8360_adci_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		snd_soc_component_update_bits(component, NAU8360_R6C_IVSNS_CFG0,
+			NAU8360_PD_ISNS_R_PMD | NAU8360_PD_ISNS_L_PMD, 0);
+	else if (SND_SOC_DAPM_EVENT_OFF(event))
+		snd_soc_component_update_bits(component, NAU8360_R6C_IVSNS_CFG0,
+			NAU8360_PD_ISNS_R_PMD | NAU8360_PD_ISNS_L_PMD,
+			NAU8360_PD_ISNS_R_PMD | NAU8360_PD_ISNS_L_PMD);
+
+	return 0;
+}
+
+static int nau8360_adcv_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		snd_soc_component_update_bits(component, NAU8360_R6C_IVSNS_CFG0,
+			NAU8360_PD_VSNS_R_PMD | NAU8360_PD_VSNS_L_PMD, 0);
+	else if (SND_SOC_DAPM_EVENT_OFF(event))
+		snd_soc_component_update_bits(component, NAU8360_R6C_IVSNS_CFG0,
+			NAU8360_PD_VSNS_R_PMD | NAU8360_PD_VSNS_L_PMD,
+			NAU8360_PD_VSNS_R_PMD | NAU8360_PD_VSNS_L_PMD);
+
+	return 0;
+}
+
+static int nau8360_aif_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+
+	if (SND_SOC_DAPM_EVENT_OFF(event))
+		snd_soc_component_update_bits(component, NAU8360_R67_ANALOG_CONTROL_0,
+			NAU8360_HV_EN, 0);
+
+	return 0;
+}
+
+static int nau8360_hw1_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+
+	if (SND_SOC_DAPM_EVENT_OFF(event))
+		snd_soc_component_update_bits(component, NAU8360_R67_ANALOG_CONTROL_0,
+			NAU8360_ANA_MUTE, NAU8360_ANA_MUTE);
+
+	return 0;
+}
+
+static int nau8360_hw1_mux_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+
+	if (SND_SOC_DAPM_EVENT_OFF(event)) {
+		snd_soc_component_update_bits(component, NAU8360_R68_ANALOG_CONTROL_1,
+			NAU8360_DRVCTL_SEGL_FULL | NAU8360_DRVCTL_SEGR_FULL, 0);
+		snd_soc_component_update_bits(component, NAU8360_RA5_ANA_REG_1,
+			NAU8360_CLASSD_SHT_IN | NAU8360_HVEN_SYNC_SAW,
+			NAU8360_CLASSD_SHT_IN | NAU8360_HVEN_SYNC_SAW);
+		msleep(20);
+	}
+
+	return 0;
+}
+
+static int nau8360_hw2_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+
+	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		snd_soc_component_update_bits(component, NAU8360_R99_HW2_CTL9,
+			NAU8360_HW2_CH_MUTE, 0);
+		snd_soc_component_update_bits(component, NAU8360_R9C_HW1_CTL2,
+			NAU8360_HW1_CH_MUTE, 0);
+	}
+
+	return 0;
+}
+
+static int nau8360_dac_power_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *cp = snd_soc_dapm_to_component(w->dapm);
+	unsigned int mask = 1 << w->shift;
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		snd_soc_component_update_bits(cp, NAU8360_R6E_DAC_CFG0, mask, 0);
+	else if (SND_SOC_DAPM_EVENT_OFF(event))
+		snd_soc_component_update_bits(cp, NAU8360_R6E_DAC_CFG0, mask, mask);
+
+	return 0;
+}
+
+static int nau8360_hv_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+
+	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		/* enable Class D HV power after DAC power is stable */
+		snd_soc_component_update_bits(component, NAU8360_R67_ANALOG_CONTROL_0,
+			NAU8360_HV_EN, NAU8360_HV_EN);
+		msleep(50);
+		/* Class D modulator input short setting for mute and de-pop purpose.
+		 * Restore normal after initiation. Set segment driver as full driving
+		 * strength.
+		 */
+		snd_soc_component_update_bits(component, NAU8360_RA5_ANA_REG_1,
+			NAU8360_CLASSD_SHT_IN | NAU8360_HVEN_SYNC_SAW, 0);
+		snd_soc_component_update_bits(component, NAU8360_R68_ANALOG_CONTROL_1,
+			NAU8360_DRVCTL_SEGL_FULL | NAU8360_DRVCTL_SEGR_FULL,
+			NAU8360_DRVCTL_SEGL_FULL | NAU8360_DRVCTL_SEGR_FULL);
+
+		snd_soc_component_update_bits(component, NAU8360_R67_ANALOG_CONTROL_0,
+			NAU8360_ANA_MUTE, 0);
+	} else if (SND_SOC_DAPM_EVENT_OFF(event)) {
+		snd_soc_component_update_bits(component, NAU8360_R9C_HW1_CTL2,
+			NAU8360_HW1_CH_MUTE, NAU8360_HW1_CH_MUTE);
+		snd_soc_component_update_bits(component, NAU8360_R99_HW2_CTL9,
+			NAU8360_HW2_CH_MUTE, NAU8360_HW2_CH_MUTE);
+	}
+
+	return 0;
+}
+
+static inline void nau8360_dsp_enable(struct regmap *regmap, bool enable)
+{
+	regmap_update_bits(regmap, NAU8360_R86_HW3_CTL0, NAU8360_HW3_STALL,
+		enable ? 0 : NAU8360_HW3_STALL);
+	regmap_update_bits(regmap, NAU8360_R1A_DSP_CORE_CTRL2, NAU8360_DSP_RUNSTALL,
+		enable ? 0 : NAU8360_DSP_RUNSTALL);
+}
+
+static void nau8360_dsp_switch(struct snd_soc_component *component, bool enable)
+{
+	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(component);
+	struct regmap *regmap = nau8360->regmap;
+	int value = NAU8360_PEQ_BAND_8;
+
+	mutex_lock(&nau8360->lock);
+
+	/* If DSP is enabled, unstall HW3 engine and DSP, loading DSP firmware,
+	 * and configure PEQ after dsp reset.
+	 */
+	if (enable) {
+		value = nau8360->anc_enable ? NAU8360_PEQ_BAND_15 : NAU8360_PEQ_BAND_12;
+		nau8360_dsp_enable(regmap, true);
+	} else {
+		dev_dbg(nau8360->dev, "Bypass DSP path");
+		nau8360_dsp_enable(regmap, false);
+	}
+	regmap_update_bits(regmap, NAU8360_R9D_PEQ_CTL, NAU8360_PEQ_BAND_MASK,
+		value << NAU8360_PEQ_BAND_SFT);
+
+	mutex_unlock(&nau8360->lock);
+}
+
+static int nau8360_dac_mux_put_enum(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_to_dapm(kcontrol);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
+	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(component);
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	unsigned int *item = ucontrol->value.enumerated.item;
+	int ret = 0;
+
+	if (snd_soc_dapm_get_bias_level(dapm) > SND_SOC_BIAS_STANDBY) {
+		dev_warn(nau8360->dev, "changing path is not allowed during playback");
+		return ret;
+	}
+
+	ret = snd_soc_dapm_put_enum_double(kcontrol, ucontrol);
+	if (ret <= 0)
+		return ret;
+
+	nau8360_dsp_switch(component, snd_soc_enum_item_to_val(e, item[0]));
+
+	return ret;
+}
+
+/* Select HW1 output source (enables PEQ bypass) */
+static const char *const nau8360_hw1out_src[] = { "Audio", "PEQ" };
+
+static SOC_ENUM_SINGLE_DECL(nau8360_hw1out_enum, NAU8360_R12_PATH_CTRL,
+	NAU8360_SEL_HW1_SFT, nau8360_hw1out_src);
+
+static const struct snd_kcontrol_new nau8360_hw1out_mux =
+	SOC_DAPM_ENUM("HW1 Output Source", nau8360_hw1out_enum);
+
+/* Select DAC input source (enables DSP bypass) */
+static const char *const nau8360_dac_src[] = { "HW1", "DSP" };
+
+static SOC_ENUM_SINGLE_DECL(nau8360_dac_enum, NAU8360_R12_PATH_CTRL,
+	NAU8360_DAC_SEL_SFT, nau8360_dac_src);
+
+static const struct snd_kcontrol_new nau8360_dac_mux =
+	SOC_DAPM_ENUM_EXT("DAC Source", nau8360_dac_enum,
+		snd_soc_dapm_get_enum_double, nau8360_dac_mux_put_enum);
+
+static const struct snd_soc_dapm_widget nau8360_dapm_widgets[] = {
+	SND_SOC_DAPM_SIGGEN("Sense"),
+	SND_SOC_DAPM_ADC_E("ADC_I", NULL, SND_SOC_NOPM, 0, 0, nau8360_adci_event,
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_ADC_E("ADC_V", NULL, SND_SOC_NOPM, 0, 0, nau8360_adcv_event,
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_PGA("DSP", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("HW3 Engine", NAU8360_R8C_HW3_CTL6, 3, 0, NULL, 0),
+
+	SND_SOC_DAPM_AIF_IN_E("AIFRX", "Playback", 0, SND_SOC_NOPM, 0, 0,
+		nau8360_aif_event, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_PGA_S("HW1 Engine", 0, NAU8360_R9D_PEQ_CTL, 0, 1,
+		nau8360_hw1_event, SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MUX_E("HW1 Mux", SND_SOC_NOPM, 0, 0, &nau8360_hw1out_mux,
+		nau8360_hw1_mux_event, SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_MUX("DAC Mux", SND_SOC_NOPM, 0, 0, &nau8360_dac_mux),
+
+	SND_SOC_DAPM_PGA_S("HW2 Engine", 1, NAU8360_R96_HW2_CTL6, 5, 0,
+		nau8360_hw2_event, SND_SOC_DAPM_POST_PMU),
+
+	SND_SOC_DAPM_SUPPLY("DAC Clock", NAU8360_R71_CLK_DIV_CFG, 9, 1, NULL, 0),
+	SND_SOC_DAPM_DAC_E("DACL", NULL, SND_SOC_NOPM, NAU8360_PD_DACL_SFT, 0,
+		nau8360_dac_power_event, SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_DAC_E("DACR", NULL, SND_SOC_NOPM, NAU8360_PD_DACR_SFT, 0,
+		nau8360_dac_power_event, SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_PGA_S("ADACL", 2, SND_SOC_NOPM, NAU8360_PD_DACL_SFT, 0,
+		nau8360_dac_power_event, SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_PGA_S("ADACR", 2, SND_SOC_NOPM, NAU8360_PD_DACR_SFT, 0,
+		nau8360_dac_power_event, SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_PGA_S("Class D", 3, SND_SOC_NOPM, 0, 0,
+		nau8360_hv_event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_OUTPUT("OUTL"),
+	SND_SOC_DAPM_OUTPUT("OUTR"),
+};
+
+static const struct snd_soc_dapm_route nau8360_dapm_routes[] = {
+	{ "ADC_I", NULL, "Sense" },
+	{ "ADC_V", NULL, "Sense" },
+	{ "HW3 Engine", NULL, "ADC_I" },
+	{ "HW3 Engine", NULL, "ADC_V" },
+	{ "Capture", NULL, "HW3 Engine" },
+
+	{ "HW1 Engine", NULL, "AIFRX" },
+	{ "HW1 Mux", "Audio", "AIFRX" },
+	{ "HW1 Mux", "PEQ", "HW1 Engine" },
+
+	{ "DSP", NULL, "HW1 Mux" },
+	{ "DAC Mux", "HW1", "HW1 Mux" },
+	{ "DAC Mux", "DSP", "DSP" },
+
+	{ "HW2 Engine", NULL, "DAC Mux" },
+	{ "DACL", NULL, "HW2 Engine" },
+	{ "DACR", NULL, "HW2 Engine" },
+	{ "DACL", NULL, "DAC Clock" },
+	{ "DACR", NULL, "DAC Clock" },
+
+	{ "ADACL", NULL, "DACL" },
+	{ "ADACR", NULL, "DACR" },
+	{ "Class D", NULL, "ADACL" },
+	{ "Class D", NULL, "ADACR" },
+
+	{ "OUTL", NULL, "Class D" },
+	{ "OUTR", NULL, "Class D" },
+};
+
+static int nau8360_startup(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(component);
+	unsigned int i2s_mask = NAU8360_FRAME_START_MASK | NAU8360_RX_OFFSET_MASK;
+	unsigned int i2s_fmt = NAU8360_FRAME_START_H2L | NAU8360_RX_OFFSET_I2S;
+	int val = 0;
+
+	if (!nau8360->load_fw_done) {
+		dev_warn(nau8360->dev, "DSP firmware is not ready yet!");
+		return -EBUSY;
+	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		regmap_read(nau8360->regmap, NAU8360_R0B_I2S_PCM_CTRL1, &val);
+		if ((val & i2s_mask) == i2s_fmt)
+			regmap_update_bits(nau8360->regmap, NAU8360_R0B_I2S_PCM_CTRL1,
+				NAU8360_EN_TDM_RX, NAU8360_EN_TDM_RX);
+
+		if (nau8360_dsp_active(component))
+			snd_soc_dapm_enable_pin(nau8360->dapm, "Sense");
+	}
+
+	return 0;
+}
+
+static void nau8360_shutdown(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(component);
+	unsigned int tdm_mask;
+
+	tdm_mask = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
+		NAU8360_EN_TDM_RX : NAU8360_EN_TDM_TX;
+	regmap_update_bits(nau8360->regmap, NAU8360_R0B_I2S_PCM_CTRL1,
+		tdm_mask, 0);
+	if (nau8360_dsp_active(component) &&
+		substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		snd_soc_dapm_disable_pin(nau8360->dapm, "Sense");
+}
+
+static int nau8360_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(component);
+	unsigned int val_len, val_srate;
+	int dlen = params_width(params);
+
+	if (dlen > nau8360_get_tdm_chan_len(nau8360)) {
+		dev_err(nau8360->dev, "Invalid data length");
+		return -EINVAL;
+	}
+
+	switch (dlen) {
+	case 16:
+		val_len = NAU8360_TDM_DLEN_16;
+		break;
+	case 20:
+		val_len = NAU8360_TDM_DLEN_20;
+		break;
+	case 24:
+		val_len = NAU8360_TDM_DLEN_24;
+		break;
+	case 32:
+		val_len = NAU8360_TDM_DLEN_32;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (params_rate(params)) {
+	case 16000:
+		val_srate = NAU8360_SRATE_16000;
+		break;
+	case 32000:
+		val_srate = NAU8360_SRATE_32000;
+		break;
+	case 44100:
+	case 48000:
+		val_srate = NAU8360_SRATE_48000;
+		break;
+	case 88200:
+	case 96000:
+		val_srate = NAU8360_SRATE_96000;
+		break;
+	case 176400:
+	case 192000:
+		val_srate = NAU8360_SRATE_192000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(nau8360->regmap, NAU8360_R0C_I2S_PCM_CTRL2,
+		NAU8360_TDM_DLEN_MASK, val_len);
+	regmap_update_bits(nau8360->regmap, NAU8360_R40_CLK_DET_CTRL,
+		NAU8360_SRATE_MASK, val_srate);
+
+	return 0;
+}
+
+static int nau8360_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_component *component = dai->component;
+	unsigned int ctrl_val, ctrl1_val;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBC_CFC:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		ctrl_val = NAU8360_FRAME_START_H2L | NAU8360_RX_OFFSET_I2S;
+		ctrl1_val = NAU8360_TX_OFFSET_I2S;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		ctrl_val = NAU8360_RX_OFFSET_LEFT | NAU8360_RX_LEFT_JUSTIFY;
+		ctrl1_val = NAU8360_TX_OFFSET_LEFT;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		ctrl_val = NAU8360_RX_OFFSET_RIGHT | NAU8360_RX_RIGHT_JUSTIFY;
+		ctrl1_val = NAU8360_TX_OFFSET_RIGHT;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		ctrl_val = NAU8360_RX_OFFSET_PCM_A;
+		ctrl1_val = NAU8360_TX_OFFSET_PCM_A;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		ctrl_val = NAU8360_RX_OFFSET_PCM_B;
+		ctrl1_val = NAU8360_TX_OFFSET_PCM_B;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	snd_soc_component_update_bits(component, NAU8360_R0B_I2S_PCM_CTRL1,
+		NAU8360_FRAME_START_MASK | NAU8360_RX_OFFSET_MASK |
+		NAU8360_RX_JUSTIFY_MASK, ctrl_val);
+	snd_soc_component_update_bits(component, NAU8360_R0D_I2S_PCM_CTRL3,
+		NAU8360_TX_OFFSET_MASK, ctrl1_val);
+	return 0;
+}
+
+static void nau8360_set_tdm_rx_slot(struct snd_soc_component *cp, int type, int slot)
+{
+	switch (type) {
+	case NAU8360_TDM_DACL:
+		snd_soc_component_update_bits(cp, NAU8360_R0C_I2S_PCM_CTRL2,
+			NAU8360_RX_DACL_MASK, slot);
+		break;
+
+	case NAU8360_TDM_DACR:
+		snd_soc_component_update_bits(cp, NAU8360_R0C_I2S_PCM_CTRL2,
+			NAU8360_RX_DACR_MASK, (slot << NAU8360_RX_DACR_SFT));
+		break;
+
+	case NAU8360_TDM_ANCL:
+		snd_soc_component_update_bits(cp, NAU8360_R10_I2S_DATA_CTRL3,
+			NAU8360_RX_ANC_L_MASK, (slot << NAU8360_RX_ANC_L_SFT));
+		break;
+
+	case NAU8360_TDM_ANCR:
+		snd_soc_component_update_bits(cp, NAU8360_R10_I2S_DATA_CTRL3,
+			NAU8360_RX_ANC_R_MASK, (slot << NAU8360_RX_ANC_R_SFT));
+		break;
+	}
+}
+
+static void nau8360_set_tdm_tx_slot(struct snd_soc_component *cp, int type, int slot)
+{
+	switch (type) {
+	case NAU8360_TDM_AECL:
+		snd_soc_component_update_bits(cp, NAU8360_R17_I2S0_DATA_CTRL5,
+			NAU8360_AEC_L_SLOT_MASK, slot << NAU8360_AEC_L_SLOT_SFT);
+		break;
+
+	case NAU8360_TDM_AECR:
+		snd_soc_component_update_bits(cp, NAU8360_R17_I2S0_DATA_CTRL5,
+			NAU8360_AEC_R_SLOT_MASK, slot);
+		break;
+
+	case NAU8360_TDM_ISNSL:
+		snd_soc_component_update_bits(cp, NAU8360_R0E_I2S_DATA_CTRL1,
+			NAU8360_ISNS_L_SLOT_MASK, slot << NAU8360_ISNS_L_SLOT_SFT);
+		break;
+
+	case NAU8360_TDM_ISNSR:
+		snd_soc_component_update_bits(cp, NAU8360_R11_I2S_DATA_CTRL4,
+			NAU8360_ISNS_R_SLOT_MASK, slot);
+		break;
+
+	case NAU8360_TDM_VSNSL:
+		snd_soc_component_update_bits(cp, NAU8360_R0D_I2S_PCM_CTRL3,
+			NAU8360_VSNS_L_SLOT_MASK, slot);
+		break;
+
+	case NAU8360_TDM_VSNSR:
+		snd_soc_component_update_bits(cp, NAU8360_R11_I2S_DATA_CTRL4,
+			NAU8360_VSNS_R_SLOT_MASK, slot << NAU8360_VSNS_R_SLOT_SFT);
+		break;
+
+	case NAU8360_TDM_TJ:
+		snd_soc_component_update_bits(cp, NAU8360_R10_I2S_DATA_CTRL3,
+			NAU8360_TEMP_SLOT_MASK, slot);
+		break;
+
+	case NAU8360_TDM_VBAT:
+		snd_soc_component_update_bits(cp, NAU8360_R0F_I2S_DATA_CTRL2,
+			NAU8360_VBAT_SLOT_MASK, slot << NAU8360_VBAT_SLOT_SFT);
+		break;
+	}
+}
+
+static void nau8360_set_tdm_tx_func(struct snd_soc_component *cp, int type, bool enable)
+{
+	switch (type) {
+	case NAU8360_TDM_AECL:
+		snd_soc_component_update_bits(cp, NAU8360_R17_I2S0_DATA_CTRL5,
+			NAU8360_AEC_L_EN, enable ? NAU8360_AEC_L_EN : 0);
+		break;
+	case NAU8360_TDM_AECR:
+		snd_soc_component_update_bits(cp, NAU8360_R17_I2S0_DATA_CTRL5,
+			NAU8360_AEC_R_EN, enable ? NAU8360_AEC_R_EN : 0);
+		break;
+	case NAU8360_TDM_ISNSL:
+		snd_soc_component_update_bits(cp, NAU8360_R0E_I2S_DATA_CTRL1,
+			NAU8360_ISNS_L_TX_EN, enable ? NAU8360_ISNS_L_TX_EN : 0);
+		break;
+	case NAU8360_TDM_ISNSR:
+		snd_soc_component_update_bits(cp, NAU8360_R11_I2S_DATA_CTRL4,
+			NAU8360_ISNS_R_TX_EN, enable ? NAU8360_ISNS_R_TX_EN : 0);
+		break;
+	case NAU8360_TDM_VSNSL:
+		snd_soc_component_update_bits(cp, NAU8360_R0D_I2S_PCM_CTRL3,
+			NAU8360_VSNS_L_TX_EN, enable ? NAU8360_VSNS_L_TX_EN : 0);
+		break;
+	case NAU8360_TDM_VSNSR:
+		snd_soc_component_update_bits(cp, NAU8360_R11_I2S_DATA_CTRL4,
+			NAU8360_VSNS_R_TX_EN, enable ? NAU8360_VSNS_R_TX_EN : 0);
+		break;
+	case NAU8360_TDM_TJ:
+		snd_soc_component_update_bits(cp, NAU8360_R10_I2S_DATA_CTRL3,
+			NAU8360_TEMP_TX_EN, enable ? NAU8360_TEMP_TX_EN : 0);
+		break;
+	case NAU8360_TDM_VBAT:
+		snd_soc_component_update_bits(cp, NAU8360_R0F_I2S_DATA_CTRL2,
+			NAU8360_VBAT_TX_EN, enable ? NAU8360_VBAT_TX_EN : 0);
+		break;
+	}
+}
+
+static int nau8360_validate_tdm_slots(struct device *dev, unsigned int mask,
+	const u32 *func_slots, const char * const *func_names,
+	int num_funcs, const char *dir,
+	unsigned int *slot_used)
+{
+	int i;
+	unsigned int func_slot;
+	*slot_used = 0;
+
+	if (!mask)
+		return 0;
+
+	for (i = 0; i < num_funcs; i++) {
+		func_slot = func_slots[i];
+		if (func_slot == TDM_SLOT_NONE) {
+			dev_warn(dev, "%s %s slot disabled",
+				dir, func_names[i]);
+			continue;
+		}
+
+		if (!(mask & BIT(func_slot))) {
+			dev_warn(dev, "%s %s mapped to slot %d, but disabled by mask!",
+				dir, func_names[i], func_slot);
+			continue;
+		}
+
+		if (*slot_used & BIT(func_slot)) {
+			dev_err(dev, "%s %s slot %d collision!",
+				dir, func_names[i], func_slot);
+			return -EINVAL;
+		}
+
+		*slot_used |= BIT(func_slot);
+	}
+
+	return 0;
+}
+
+static void nau8360_enable_tdm_channels(struct snd_soc_component *cp,
+	int rx_slot_used, int tx_slot_used)
+{
+	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(cp);
+	int i, slot;
+	unsigned int val = 0;
+	bool enable;
+
+	for (i = 0; i < NAU8360_TDM_TXN; i++) {
+		slot = nau8360->tdm_tx_func_slot[i];
+		enable = (slot != TDM_SLOT_NONE) && (tx_slot_used & BIT(slot));
+		nau8360_set_tdm_tx_func(cp, i, enable);
+	}
+
+	if (rx_slot_used)
+		val |= NAU8360_EN_TDM_RX;
+	if (tx_slot_used)
+		val |= NAU8360_EN_TDM_TX;
+
+	snd_soc_component_update_bits(cp, NAU8360_R0B_I2S_PCM_CTRL1,
+		NAU8360_EN_TDM_RX | NAU8360_EN_TDM_TX, val);
+}
+
+static void nau8360_tdm_apply(struct snd_soc_component *cp, int slot_width)
+{
+	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(cp);
+	int i, chan_tx;
+
+	for (i = 0; i < NAU8360_TDM_TXN; i++) {
+		if (nau8360->tdm_tx_func_slot[i] == TDM_SLOT_NONE)
+			continue;
+
+		/* compute the slot location in bytes according to slot/chan width */
+		chan_tx = (slot_width >> 3) * nau8360->tdm_tx_func_slot[i];
+		nau8360_set_tdm_tx_slot(cp, i, chan_tx);
+	}
+
+	regmap_update_bits(nau8360->regmap, NAU8360_R0C_I2S_PCM_CTRL2,
+		NAU8360_TDM_CLEN_MASK,
+		((slot_width - 16) >> 3) << NAU8360_TDM_CLEN_SFT);
+}
+
+static int nau8360_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
+	unsigned int rx_mask, int slots, int slot_width)
+{
+	struct snd_soc_component *cp = dai->component;
+	struct device *dev = cp->dev;
+	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(cp);
+	unsigned int tx_slot_used = 0, rx_slot_used = 0;
+	int ret = 0;
+
+	if (!slots || !slot_width) {
+		nau8360_enable_tdm_channels(cp, 0, 0);
+		return ret;
+	}
+
+	if (slots > NAU8360_TDM_MAX_CHAN) {
+		dev_err(dev, "Invalid TDM slots: %d", slots);
+		return -EINVAL;
+	}
+
+	if (slot_width != 16 && slot_width != 24 && slot_width != 32) {
+		dev_err(dev, "Invalid TDM channel length: %d", slot_width);
+		return -EINVAL;
+	}
+
+	ret = nau8360_validate_tdm_slots(cp->dev, rx_mask,
+		nau8360->tdm_rx_func_slot,
+		nau8360_rx_func_names,
+		NAU8360_TDM_RXN, "RX",
+		&rx_slot_used);
+	if (ret < 0)
+		goto err;
+
+	ret = nau8360_validate_tdm_slots(cp->dev, tx_mask,
+		nau8360->tdm_tx_func_slot,
+		nau8360_tx_func_names,
+		NAU8360_TDM_TXN, "TX",
+		&tx_slot_used);
+	if (ret < 0)
+		goto err;
+
+	if (nau8360_get_tdm_chan_len(nau8360) != slot_width)
+		nau8360_tdm_apply(cp, slot_width);
+
+	nau8360_enable_tdm_channels(cp, rx_slot_used, tx_slot_used);
+
+	dev_dbg(dev, "TDM: tx_mask 0x%x, rx_mask 0x%x", tx_mask, rx_mask);
+err:
+	return ret;
+}
+
+static inline int dyn_clk_div(int div_max, int fin, int fout)
+{
+	int clk_div;
+
+	if (!fin || !fout)
+		return -EINVAL;
+
+	for (clk_div = 0; clk_div <= div_max; clk_div++)
+		if (fin / (clk_div + 1) <= fout)
+			break;
+	if (clk_div > div_max)
+		return -EINVAL;
+
+	return clk_div;
+}
+
+static inline int tab_clk_div(const int clk_div[], int num_div, int fin)
+{
+	int i;
+
+	if (!fin)
+		return -EINVAL;
+
+	for (i = 0; i < num_div; i++)
+		if ((fin / clk_div[i]) <= CLK_DA_IVSNS_MAX)
+			break;
+	if (i == num_div)
+		return -EINVAL;
+
+	return i;
+}
+
+static int nau8360_set_sysclk_output(struct nau8360 *nau8360, unsigned int freq)
+{
+	struct device *dev = nau8360->dev;
+	int ratio = 0, mclk_rate;
+
+	if (freq < MASTER_CLK_MIN || freq > MASTER_CLK_MAX) {
+		dev_err(dev, "system clock %d Hz exceed range", freq);
+		return -EINVAL;
+	}
+
+	if (freq % ADSP_SR_48000 == 0)
+		ratio = freq / ADSP_SR_48000;
+	else if (freq % ADSP_SR_44100 == 0)
+		ratio = freq / ADSP_SR_44100;
+
+	switch (ratio) {
+	case NAU8360_MCLK_FS_RATIO_250:
+		mclk_rate = NAU8360_MCLK_RATE_12000;
+		break;
+	case NAU8360_MCLK_FS_RATIO_256:
+		mclk_rate = NAU8360_MCLK_RATE_12288;
+		break;
+	case NAU8360_MCLK_FS_RATIO_400:
+		mclk_rate = NAU8360_MCLK_RATE_19200;
+		break;
+	case NAU8360_MCLK_FS_RATIO_500:
+		mclk_rate = NAU8360_MCLK_RATE_24000;
+		break;
+	case NAU8360_MCLK_FS_RATIO_512:
+		mclk_rate = NAU8360_MCLK_RATE_24576;
+		break;
+	default:
+		dev_err(dev, "invalid sysclk %d", freq);
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "sysclk %d Hz, ratio %d", freq, ratio);
+
+	nau8360->sys_clk = freq;
+	regmap_update_bits(nau8360->regmap, NAU8360_R40_CLK_DET_CTRL,
+		NAU8360_MCLK_RATE_MASK, mclk_rate);
+
+	return 0;
+}
+
+static int nau8360_dig_sys_clk(struct nau8360 *nau8360, int source, unsigned int freq)
+{
+	struct device *dev = nau8360->dev;
+	struct regmap *regmap = nau8360->regmap;
+	int value, mclk_div;
+
+	switch (source) {
+	case NAU8360_CLK_SRC_MCLK:
+		value = NAU8360_MCLK_SEL_MCLK;
+		break;
+
+	case NAU8360_CLK_SRC_PLL:
+		value = NAU8360_MCLK_SEL_PLL;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(regmap, NAU8360_R04_CLK_CTRL1, NAU8360_MCLK_SEL_MASK, value);
+
+	mclk_div = dyn_clk_div(NAU8360_MCLK_DIV_MAX, freq, nau8360->sys_clk);
+	if (mclk_div < 0) {
+		dev_err(dev, "mclk_div (%d -> %d):  error", freq, nau8360->sys_clk);
+		return -EINVAL;
+	}
+	regmap_update_bits(regmap, NAU8360_R03_CLK_CTRL0, NAU8360_MCLK_DIV_MASK,
+		mclk_div << NAU8360_MCLK_DIV_SFT);
+
+	dev_dbg(dev, " mclk_div (%d -> %d): %d", freq, nau8360->sys_clk, mclk_div + 1);
+
+	return 0;
+}
+
+static int nau8360_ana_sys_clk(struct nau8360 *nau8360, int source, unsigned int freq)
+{
+	struct device *dev = nau8360->dev;
+	struct regmap *regmap = nau8360->regmap;
+	struct nau8360_pll *pll = &nau8360->pll;
+	int value, pclk_div, ivdiv_sel, ddiv_sel;
+
+	switch (source) {
+	case NAU8360_CLK_SRC_PLL:
+		value = NAU8360_CLK_ANA_SEL_PLL;
+		break;
+	case NAU8360_CLK_SRC_MCLK:
+		value = NAU8360_CLK_ANA_SEL_MCLK;
+		break;
+	case NAU8360_CLK_SRC_BCLK:
+		value = NAU8360_CLK_ANA_SEL_BCLK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (source == NAU8360_CLK_SRC_PLL) {
+		freq = pll->output;
+		pclk_div = dyn_clk_div(NAU8360_PLLOUT_DIV_MAX, freq, nau8360->sys_clk);
+		if (pclk_div < 0) {
+			dev_err(dev, "pll_div (%d -> %d): error", freq, nau8360->sys_clk);
+			return -EINVAL;
+		}
+
+		dev_dbg(dev, " pll_div (%d -> %d): %d", freq, nau8360->sys_clk, pclk_div + 1);
+
+		regmap_update_bits(regmap, NAU8360_R72_PLL_CFG0, NAU8360_PLLOUT_DIV_MASK,
+			pclk_div << NAU8360_PLLOUT_DIV_SFT);
+		freq /= (pclk_div + 1);
+	}
+
+	ivdiv_sel = tab_clk_div(ivsns_clk_div, ARRAY_SIZE(ivsns_clk_div), freq);
+	if (ivdiv_sel < 0) {
+		dev_err(dev, "iv_div (%d -> %d): error", freq, CLK_DA_IVSNS_MAX);
+		return -EINVAL;
+	}
+	value |= ivdiv_sel << NAU8360_IVSNS_CLK_DIV_SFT;
+
+	ddiv_sel = tab_clk_div(dac_clk_div, ARRAY_SIZE(dac_clk_div), freq);
+	if (ddiv_sel < 0) {
+		dev_err(dev, "dac_div (%d -> %d): error", freq, CLK_DA_IVSNS_MAX);
+		return -EINVAL;
+	}
+	value |= ddiv_sel << NAU8360_DAC_CLK_DIV_SFT;
+
+	dev_dbg(dev, " clk_div (%d -> %d): ivsns %d, dac %d", freq, CLK_DA_IVSNS_MAX,
+		ivsns_clk_div[ivdiv_sel], dac_clk_div[ddiv_sel]);
+
+	regmap_update_bits(regmap, NAU8360_R71_CLK_DIV_CFG, NAU8360_CLK_ANA_SEL_MASK |
+		NAU8360_IVSNS_CLK_DIV_MASK | NAU8360_DAC_CLK_DIV_MASK, value);
+
+	return 0;
+}
+
+static int nau8360_dsp_hw_clk(struct nau8360 *nau8360, int source, unsigned int freq)
+{
+	struct device *dev = nau8360->dev;
+	struct regmap *regmap = nau8360->regmap;
+	int val_dsp, val_hw, clk_div, dsp_clk;
+
+	if (freq % ADSP_SR_48000 == 0)
+		dsp_clk = DSP_OP_CLK48;
+	else if (freq % ADSP_SR_44100 == 0)
+		dsp_clk = DSP_OP_CLK44;
+	else
+		return -EINVAL;
+	clk_div = dyn_clk_div(NAU8360_DSP_CLK_DIV_MAX, freq, dsp_clk);
+	if (clk_div < 0) {
+		dev_err(dev, "dsp/hw clk_div (%d -> %d): error", freq, dsp_clk);
+		return -EINVAL;
+	}
+	val_dsp = clk_div << NAU8360_DSP_CLK_DIV_SFT;
+	val_hw = clk_div << NAU8360_HW_CLK_DIV_SFT;
+	if (source == NAU8360_CLK_SRC_MCLK) {
+		val_dsp |= NAU8360_DSP_CLK_SEL_MCLK;
+		val_hw |= NAU8360_HW_CLK_SEL_MCLK;
+	} else if (source == NAU8360_CLK_SRC_PLL) {
+		val_dsp |= NAU8360_DSP_CLK_SEL_PLL;
+		val_hw |= NAU8360_HW_CLK_SEL_PLL;
+	} else
+		return -EINVAL;
+
+	dev_dbg(dev, " dsp/hw clk_div (%d -> %d): %d", freq, dsp_clk, clk_div + 1);
+
+	regmap_update_bits(regmap, NAU8360_R03_CLK_CTRL0, NAU8360_DSP_CLK_SEL_MASK |
+		NAU8360_DSP_CLK_DIV_MASK, val_dsp);
+	regmap_update_bits(regmap, NAU8360_R04_CLK_CTRL1, NAU8360_HW_CLK_SEL_MASK |
+		NAU8360_HW_CLK_DIV_MASK, val_hw);
+
+	return 0;
+}
+
+static int nau8360_set_sysclk(struct snd_soc_component *cp,
+	int clk_id, int source, unsigned int freq, int dir)
+{
+	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(cp);
+	struct regmap *regmap = nau8360->regmap;
+	struct device *dev = nau8360->dev;
+	static const char * const idtab[] = { "DIG", "ANA", "Internal" };
+	static const char * const srctab[] = { "MCLK", "PLL", "HIRC48M", "BCLK" };
+	int ret;
+
+	if (clk_id < 0 || clk_id >= ARRAY_SIZE(idtab))
+		return -EINVAL;
+
+	if (source < 0 || source >= ARRAY_SIZE(srctab))
+		return -EINVAL;
+
+	if (dir == SND_SOC_CLOCK_OUT) {
+		dev_dbg(dev, "sysclk: freq %d (out)", freq);
+		return nau8360_set_sysclk_output(nau8360, freq);
+	}
+
+	switch (clk_id) {
+	case NAU8360_CLK_ID_INT:
+		source = NAU8360_CLK_SRC_ICLK;
+		dev_dbg(dev, "sysclk: id %d (%s), src %d (%s) (in)",
+			clk_id, idtab[clk_id], source, srctab[source]);
+		regmap_update_bits(regmap, NAU8360_R03_CLK_CTRL0,
+			NAU8360_DSP_CLK_SEL_MASK, NAU8360_DSP_CLK_SEL_HIRC48M);
+		regmap_update_bits(regmap, NAU8360_R04_CLK_CTRL1,
+			NAU8360_HW_CLK_SEL_MASK | NAU8360_MCLK_SEL_MASK,
+			NAU8360_HW_CLK_SEL_HIRC48M | NAU8360_MCLK_SEL_HIRC48M);
+		regmap_update_bits(regmap, NAU8360_R72_PLL_CFG0,
+			NAU8360_PD_PLL_MASK, NAU8360_PD_PLL_DIS);
+		break;
+
+	case NAU8360_CLK_ID_DIG:
+		dev_dbg(dev, "sysclk: id %d (%s), src %d (%s), freq %d (in)",
+			clk_id, idtab[clk_id], source, srctab[source], freq);
+
+		if (source == NAU8360_CLK_SRC_BCLK)
+			return -EINVAL;
+
+		if (source == NAU8360_CLK_SRC_MCLK)
+			regmap_update_bits(regmap, NAU8360_R72_PLL_CFG0,
+				NAU8360_PD_PLL_MASK, NAU8360_PD_PLL_DIS);
+
+		ret = nau8360_dig_sys_clk(nau8360, source, freq);
+		if (ret)
+			return -EINVAL;
+		ret = nau8360_dsp_hw_clk(nau8360, source, freq);
+		if (ret)
+			return -EINVAL;
+		break;
+
+	case NAU8360_CLK_ID_ANA:
+		dev_dbg(dev, "sysclk: id %d (%s), src %d (%s), freq %d (in)",
+			clk_id, idtab[clk_id], source, srctab[source], freq);
+
+		if (source == NAU8360_CLK_SRC_MCLK || source == NAU8360_CLK_SRC_BCLK)
+			regmap_update_bits(regmap, NAU8360_R72_PLL_CFG0,
+				NAU8360_PD_PLL_MASK, NAU8360_PD_PLL_DIS);
+
+		ret = nau8360_ana_sys_clk(nau8360, source, freq);
+		if (ret)
+			return -EINVAL;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int nau8360_calc_pll(struct nau8360 *nau8360)
+{
+	struct nau8360_pll *pll = &nau8360->pll;
+	u64 fref = 0ULL, fvco = 0ULL, ratio;
+	int fr, fv;
+
+	if (pll->src != NAU8360_PLL_INTERNAL &&
+		(pll->input > PLL_FREQ_MAX || pll->input < PLL_FREQ_MIN))
+		return -EINVAL;
+
+	if (pll->output > PLL_FOUT_MAX || pll->output < PLL_FOUT_MIN)
+		return -EINVAL;
+
+	for (pll->msel = 1; pll->msel <= MSEL_MAX; pll->msel++) {
+		fr = pll->input / pll->msel;
+		if (fr <= PLL_FREF_MAX) {
+			fref = fr;
+			break;
+		}
+	}
+	if (!fref)
+		return -ERANGE;
+
+	for (pll->rsel = 1; pll->rsel <= RSEL_MAX; pll->rsel++) {
+		fv = pll->output * pll->rsel;
+		if (fv >= PLL_FVCO_MIN) {
+			fvco = fv;
+			break;
+		}
+	}
+	if (!fvco)
+		return -ERANGE;
+
+	dev_dbg(nau8360->dev, "fref(1-8MHz): %lld, fvco(50-125MHz): %lld", fref, fvco);
+
+	/* Calculate the PLL 8-bit integer input and 12-bit fractional */
+	ratio = div_u64(fvco << 12, fref);
+	pll->nsel = (ratio >> 12) & 0xff;
+	pll->xsel = ratio & 0xfff;
+
+	return 0;
+}
+
+static int nau8360_set_pll(struct snd_soc_component *cp, int pll_id, int source,
+	unsigned int freq_in, unsigned int freq_out)
+{
+	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(cp);
+	struct device *dev = nau8360->dev;
+	struct nau8360_pll *pll = &nau8360->pll;
+	int ctrl_val, ret;
+
+	switch (source) {
+	case NAU8360_PLL_MCLK:
+		ctrl_val = NAU8360_PLL_CLK_SEL_MCLK;
+		break;
+	case NAU8360_PLL_BCLK:
+		ctrl_val = NAU8360_PLL_CLK_SEL_BCLK;
+		break;
+	case NAU8360_PLL_INTERNAL:
+		ctrl_val = NAU8360_PLL_CLK_SEL_HIRC;
+		break;
+	default:
+		return -EINVAL;
+	}
+	pll->src = source;
+	pll->input = freq_in;
+	pll->output = freq_out;
+	ret = nau8360_calc_pll(nau8360);
+	if (ret) {
+		dev_err(dev, "clock error input %d output %d", freq_in, freq_out);
+		return ret;
+	}
+	dev_dbg(dev, "src:%d, input:%d, output:%d, M:%d, R:%d, N:%d, X:%d", pll->src,
+		pll->input, pll->output, pll->msel, pll->rsel, pll->nsel, pll->xsel);
+
+	regmap_update_bits(nau8360->regmap, NAU8360_R72_PLL_CFG0, NAU8360_PD_PLL_MASK |
+		NAU8360_PLL_CLK_SEL_MASK, NAU8360_PD_PLL_EN | ctrl_val);
+	regmap_write_bits(nau8360->regmap, NAU8360_R73_PLL_CFG1,
+		NAU8360_RSEL_MASK | NAU8360_MSEL_MASK | NAU8360_NSEL_MASK,
+		(pll->rsel - 1) << NAU8360_RSEL_SFT |
+		(pll->msel - 1) << NAU8360_MSEL_SFT | (pll->nsel - 1));
+	regmap_write_bits(nau8360->regmap, NAU8360_R74_PLL_CFG2, NAU8360_XSEL_MASK,
+		pll->xsel);
+
+	return 0;
+}
+
+static void nau8360_coeff_set_def(struct nau8360 *nau8360)
+{
+	struct regmap *regmap = nau8360->regmap;
+	int i;
+
+	mutex_lock(&nau8360->lock);
+	regmap_update_bits(regmap, NAU8360_R9D_PEQ_CTL, NAU8360_HW1_MEM_CLEAR,
+		NAU8360_HW1_MEM_CLEAR);
+	regmap_update_bits(regmap, NAU8360_R9D_PEQ_CTL, NAU8360_HW1_MEM_CLEAR, 0);
+	nau8360_peq_mem_enable(regmap, true);
+	for (i = 0; i < NAU8360_TOT_BAND_PER_CH; i++) {
+		regmap_write(regmap, NAU8360_R100_LEFT_BIQ0_COE + 1 +
+			i * NAU8360_TOT_BAND_COE_RANGE, 0x20);
+		regmap_write(regmap, NAU8360_R200_RIGHT_BIQ0_COE + 1 +
+			i * NAU8360_TOT_BAND_COE_RANGE, 0x20);
+	}
+	nau8360_peq_mem_enable(regmap, false);
+	mutex_unlock(&nau8360->lock);
+}
+
+static inline int nau8360_vbat_level(struct regmap *regmap, int *vbat)
+{
+	struct device *dev = regmap_get_device(regmap);
+	int value = 0, ret;
+
+	ret = regmap_read(regmap, NAU8360_R21_VBAT_READOUT, &value);
+	if (ret)
+		return ret;
+
+	/* multiple 100 on value scale */
+	*vbat = (value * 100 + NAU8360_VBAT_BASE) / NAU8360_VBAT_STEP;
+	if (*vbat < NAU8360_VBAT_MIN || *vbat > NAU8360_VBAT_MAX) {
+		dev_err(dev, "VBAT %dV is out of valid range (%dV-%dV)",
+			*vbat, NAU8360_VBAT_MIN, NAU8360_VBAT_MAX);
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+static inline void nau8360_sawtooth_params(int vbat, int *vsaw_level, int *vsaw_slope)
+{
+	if (vbat < NAU8360_VBAT_MID_THRES) {
+		*vsaw_level = 0x1;
+		*vsaw_slope = 0x0;
+	} else if (vbat < NAU8360_VBAT_HIGH_THRES) {
+		*vsaw_level = 0x2;
+		*vsaw_slope = 0x1;
+	} else {
+		*vsaw_level = 0x3;
+		*vsaw_slope = 0x2;
+	}
+}
+
+static inline void nau8360_dsp_software_reset(struct snd_soc_component *component)
+{
+	/* Enable PLL for successful DSP reset. After DSP is alive,
+	 * system clock switches to internal clock and disable PLL.
+	 */
+	snd_soc_component_update_bits(component, NAU8360_R72_PLL_CFG0,
+		NAU8360_PD_PLL_MASK, NAU8360_PD_PLL_EN);
+	msleep(50);
+	snd_soc_component_write(component, NAU8360_R01_DSP_SOFTWARE_RST, 0x5a5a);
+	snd_soc_component_write(component, NAU8360_R01_DSP_SOFTWARE_RST, 0xa5a5);
+	snd_soc_component_set_sysclk(component, NAU8360_CLK_ID_INT, 0, 0,
+		SND_SOC_CLOCK_IN);
+}
+
+static void nau8360_dsp_bootup(struct snd_soc_component *component)
+{
+	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(component);
+	struct regmap *regmap = nau8360->regmap;
+
+	regmap_update_bits(regmap, NAU8360_R90_HW2_CTL0, NAU8360_HW2_STALL, 0);
+	nau8360_dsp_software_reset(component);
+	nau8360_dsp_enable(regmap, true);
+}
+
+static void nau8360_tdm_function_config(struct snd_soc_component *cp)
+{
+	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(cp);
+	int i, chan_tx, tdm_chan_len;
+
+	for (i = 0; i < NAU8360_TDM_RXN; i++) {
+		if (nau8360->tdm_rx_func_slot[i] == TDM_SLOT_NONE)
+			continue;
+
+		nau8360_set_tdm_rx_slot(cp, i, nau8360->tdm_rx_func_slot[i]);
+	}
+
+	tdm_chan_len = nau8360_get_tdm_chan_len(nau8360) >> 3;
+	for (i = 0; i < NAU8360_TDM_TXN; i++) {
+		if (nau8360->tdm_tx_func_slot[i] == TDM_SLOT_NONE)
+			continue;
+
+		/* compute the slot location in bytes according to slot/chan width */
+		chan_tx = (tdm_chan_len * nau8360->tdm_tx_func_slot[i]);
+		nau8360_set_tdm_tx_slot(cp, i, chan_tx);
+	}
+}
+
+static void nau8360_dsp_fw_load(struct nau8360 *nau8360)
+{
+	nau8360->load_fw_done = false;
+	schedule_work(&nau8360->load_fw_work);
+}
+
+static void nau8360_load_fw_work(struct work_struct *work)
+{
+	struct nau8360 *nau8360 = container_of(work, struct nau8360, load_fw_work);
+	struct snd_soc_component *cp = snd_soc_dapm_to_component(nau8360->dapm);
+	int ret;
+
+	ret = nau8360_dsp_init(cp);
+	if (ret) {
+		dev_err(nau8360->dev, "Failed to initialize DSP: %d\n", ret);
+		nau8360_dsp_enable(nau8360->regmap, false);
+		return;
+	}
+	nau8360->load_fw_done = true;
+}
+
+static int nau8360_codec_probe(struct snd_soc_component *component)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_to_dapm(component);
+	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(component);
+	struct regmap *regmap = nau8360->regmap;
+	struct device *dev = nau8360->dev;
+	int ret, vbat, vsaw_level, vsaw_slope;
+
+	nau8360->dapm = dapm;
+	nau8360_dsp_bootup(component);
+	nau8360_dsp_fw_load(nau8360);
+	ret = nau8360_dsp_setup_controls(component);
+	if (ret) {
+		nau8360_dsp_enable(regmap, false);
+		dev_err(dev, "DSP setup controls failed(%d)", ret);
+		goto err;
+	}
+	nau8360_tdm_function_config(component);
+
+	/* default disable Sense signal after booting */
+	snd_soc_dapm_disable_pin(nau8360->dapm, "Sense");
+	snd_soc_dapm_sync(nau8360->dapm);
+
+	nau8360_coeff_set_def(nau8360);
+	/* VBAT is sensed by chip. */
+	ret = nau8360_vbat_level(regmap, &vbat);
+	if (ret) {
+		dev_err(dev, "Failed to get valid VBAT level: %d", ret);
+		goto err;
+	}
+	dev_dbg(dev, "VBAT %dV for nau8360", vbat);
+
+	/* Config sawtooth clock according to VBAT. Class D modulator input short setting
+	 * for mute and de-pop purpose. Restore normal after initiation.
+	 */
+	nau8360_sawtooth_params(vbat, &vsaw_level, &vsaw_slope);
+
+	regmap_update_bits(regmap, NAU8360_RA5_ANA_REG_1, NAU8360_VSAW_LV_MASK |
+		NAU8360_KVCO_SAW_MASK, (vsaw_level << NAU8360_VSAW_LV_SFT) |
+		(vsaw_slope << NAU8360_KVCO_SAW_SFT));
+
+	return 0;
+
+err:
+	cancel_work_sync(&nau8360->load_fw_work);
+	return ret;
+}
+
+static int __maybe_unused nau8360_suspend(struct snd_soc_component *component)
+{
+	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(component);
+
+	cancel_work_sync(&nau8360->load_fw_work);
+
+	regmap_update_bits(nau8360->regmap, NAU8360_R90_HW2_CTL0, NAU8360_HW2_STALL,
+		NAU8360_HW2_STALL);
+	nau8360_dsp_enable(nau8360->regmap, false);
+
+	regcache_cache_only(nau8360->regmap, true);
+	regcache_mark_dirty(nau8360->regmap);
+
+	return 0;
+}
+
+static int __maybe_unused nau8360_resume(struct snd_soc_component *component)
+{
+	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(component);
+	struct regmap *regmap = nau8360->regmap;
+
+	regcache_cache_only(regmap, false);
+
+	nau8360_dsp_bootup(component);
+
+	nau8360_peq_mem_enable(regmap, true);
+	regcache_sync(regmap);
+	nau8360_peq_mem_enable(regmap, false);
+
+	/* disable Sense at standby */
+	snd_soc_dapm_disable_pin(nau8360->dapm, "Sense");
+	snd_soc_dapm_sync(nau8360->dapm);
+
+	nau8360_dsp_fw_load(nau8360);
+
+	return 0;
+}
+
+static const struct snd_soc_component_driver soc_comp_dev_nau8360 = {
+	.probe			= nau8360_codec_probe,
+	.set_sysclk		= nau8360_set_sysclk,
+	.set_pll		= nau8360_set_pll,
+	.suspend		= nau8360_suspend,
+	.resume			= nau8360_resume,
+	.controls		= nau8360_snd_controls,
+	.num_controls		= ARRAY_SIZE(nau8360_snd_controls),
+	.dapm_widgets		= nau8360_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(nau8360_dapm_widgets),
+	.dapm_routes		= nau8360_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(nau8360_dapm_routes),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+};
+
+static const struct snd_soc_dai_ops nau8360_dai_ops = {
+	.startup	= nau8360_startup,
+	.shutdown	= nau8360_shutdown,
+	.hw_params	= nau8360_hw_params,
+	.set_fmt	= nau8360_set_fmt,
+	.set_tdm_slot	= nau8360_set_tdm_slot,
+};
+
+#define NAU8360_RATES (SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_32000 | \
+	SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | \
+	SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_192000)
+
+#define NAU8360_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
+	SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver nau8360_dai = {
+	.name = NAU8360_CODEC_DAI,
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 4,
+		.rates = NAU8360_RATES,
+		.formats = NAU8360_FORMATS,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 8,
+		.rates = NAU8360_RATES,
+		.formats = NAU8360_FORMATS,
+	},
+	.ops = &nau8360_dai_ops,
+	.symmetric_rate = 1,
+};
+
+static int nau8360_reg_write(void *context, unsigned int reg, unsigned int value)
+{
+	struct i2c_client *client = context;
+	struct nau8360 *nau8360 = i2c_get_clientdata(client);
+	int ret, count = 0;
+
+	nau8360->i2c_write_buf[count++] = reg >> 8;
+	nau8360->i2c_write_buf[count++] = reg & 0xff;
+	if (NAU8360_IS_DSP_REG(reg)) {
+		/* format for DSP, 4 bytes value and native */
+		nau8360->i2c_write_buf[count++] = value & 0xff;
+		nau8360->i2c_write_buf[count++] = (value >> 8) & 0xff;
+		nau8360->i2c_write_buf[count++] = (value >> 16) & 0xff;
+		nau8360->i2c_write_buf[count++] = (value >> 24) & 0xff;
+	} else {
+		/* format for Codec, 2 bytes value and endian big */
+		nau8360->i2c_write_buf[count++] = value >> 8;
+		nau8360->i2c_write_buf[count++] = value & 0xff;
+	}
+
+	ret = i2c_master_send(client, nau8360->i2c_write_buf, count);
+
+	if (ret == count)
+		return 0;
+	if (ret < 0)
+		return ret;
+
+	return -EIO;
+}
+
+static int nau8360_reg_read(void *context, unsigned int reg, unsigned int *value)
+{
+	struct i2c_client *client = context;
+	struct nau8360 *nau8360 = i2c_get_clientdata(client);
+	struct i2c_msg xfer[2];
+	int ret;
+
+	nau8360->i2c_read_reg[0] = (reg >> 8) & 0xff;
+	nau8360->i2c_read_reg[1] = reg & 0xff;
+	xfer[0].addr = client->addr;
+	xfer[0].len = 2;
+	xfer[0].buf = nau8360->i2c_read_reg;
+	xfer[0].flags = 0;
+
+	xfer[1].addr = client->addr;
+	xfer[1].len = (NAU8360_IS_DSP_REG(reg)) ? 4 : 2;
+	xfer[1].buf = nau8360->i2c_read_buf;
+	xfer[1].flags = I2C_M_RD;
+
+	ret = i2c_transfer(client->adapter, xfer, ARRAY_SIZE(xfer));
+	if (ret < 0)
+		return ret;
+	if (ret != ARRAY_SIZE(xfer))
+		return -EIO;
+
+	if (NAU8360_IS_DSP_REG(reg))
+		*value = nau8360->i2c_read_buf[0] |
+			(nau8360->i2c_read_buf[1] << 8) |
+			(nau8360->i2c_read_buf[2] << 16) |
+			(nau8360->i2c_read_buf[3] << 24);
+	else
+		*value = (nau8360->i2c_read_buf[0] << 8) | nau8360->i2c_read_buf[1];
+
+	return 0;
+}
+
+static const struct regmap_config nau8360_regmap_config = {
+	.reg_bits = NAU8360_REG_ADDR_LEN,
+	.val_bits = NAU8360_REG_DATA_LEN,
+
+	.max_register = NAU8360_REG_MAX,
+	.readable_reg = nau8360_readable_reg,
+	.writeable_reg = nau8360_writeable_reg,
+	.volatile_reg = nau8360_volatile_reg,
+	.reg_read = nau8360_reg_read,
+	.reg_write = nau8360_reg_write,
+
+	.cache_type = REGCACHE_MAPLE,
+	.reg_defaults = nau8360_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(nau8360_reg_defaults),
+};
+
+static inline void nau8360_reset_chip(struct regmap *regmap)
+{
+	regmap_write(regmap, NAU8360_R00_SOFTWARE_RST, 0x5a5a);
+	regmap_write(regmap, NAU8360_R00_SOFTWARE_RST, 0xa5a5);
+}
+
+static void nau8360_init_regs(struct nau8360 *nau8360)
+{
+	struct regmap *regmap = nau8360->regmap;
+
+	/* Enable Digital LDO */
+	regmap_write(regmap, NAU8360_R78_PD_SW_DLDO, NAU8360_PD_SW_DLDO_EN);
+	/* Enable Software Shutdown Mode */
+	regmap_write(regmap, NAU8360_R77_SOFT_SD, NAU8360_SOFT_SD_EN);
+	/* Stall HW1 PEQ Engine and Clear DRAM to Zero */
+	regmap_update_bits(regmap, NAU8360_R9D_PEQ_CTL, NAU8360_PEQ_STALL,
+		NAU8360_PEQ_STALL);
+	/* Stall HW2 engine */
+	regmap_update_bits(regmap, NAU8360_R90_HW2_CTL0, NAU8360_HW2_STALL,
+		NAU8360_HW2_STALL);
+	/* Stall HW3 engine and DSP processor */
+	nau8360_dsp_enable(regmap, false);
+	/* Enable Clock Gate */
+	regmap_write(regmap, NAU8360_R7E_CLK_GATED_EN, NAU8360_CLK_GATED_EN);
+	/* Latch I2C LSB Value */
+	regmap_write(regmap, NAU8360_R02_I2C_ADDR, 0x0001);
+	/* ANC Left/Right Channel as Slot 2/3 and switch */
+	regmap_update_bits(regmap, NAU8360_R10_I2S_DATA_CTRL3,
+		NAU8360_RX_ANC_R_MASK | NAU8360_RX_ANC_L_MASK,
+		0x3 << NAU8360_RX_ANC_R_SFT | 0x2 << NAU8360_RX_ANC_L_SFT);
+	/* Set DAC Clock Divider as 2 and Chopper Divider as 16 */
+	regmap_update_bits(regmap, NAU8360_R71_CLK_DIV_CFG,
+		NAU8360_DAC_CLK_DIV_MASK | NAU8360_DAC_CHOP_CLK_DIV_MASK,
+		NAU8360_DAC_CLK_DIV_2 | NAU8360_DAC_CHOP_CLK_DIV_16);
+	/* Set DAC SINC OSR as 128 and IVSENSE BS OSR as 32 */
+	regmap_update_bits(regmap, NAU8360_R5D_SINC_CFG,
+		NAU8360_DAC_SINC_OSR_MASK | NAU8360_IVSENSE_BS_OSR_MASK,
+		NAU8360_DAC_SINC_OSR_128 | NAU8360_IVSENSE_BS_OSR_32);
+
+	/* Set Trim Bit Control of DLDO and GVDD to The Highest Voltage */
+	regmap_write(regmap, NAU8360_R5F_ANA_TRIM_CFG1, 0xf407);
+
+	/* Disable Data Det and Clock Detection Settings*/
+	regmap_update_bits(regmap, NAU8360_R40_CLK_DET_CTRL, NAU8360_APWRUPEN |
+		NAU8360_CLKPWRUPEN | NAU8360_FS_MCLK_DET | NAU8360_FS_BCLK_DET, 0);
+
+	/* Set HW3 Droop and Filter Sample as 192K */
+	regmap_update_bits(regmap, NAU8360_R8C_HW3_CTL6, NAU8360_HW3_DROOP_MASK |
+		NAU8360_HW3_FS_MASK, NAU8360_HW3_DROOP_192K | NAU8360_HW3_FS_192K);
+	/* Set HW1 Mute, Mute Interval as 699ms and HW1 Zero THD as 0xff */
+	regmap_update_bits(regmap, NAU8360_R9C_HW1_CTL2, NAU8360_MUTE_INTRVL_MASK |
+		NAU8360_HW1_CH_MUTE | NAU8360_HW1_ZERO_THD_MASK,
+		NAU8360_MUTE_INTRVL_699MS | NAU8360_HW1_CH_MUTE | 0xff);
+	/* set HW2 droop with 192K*/
+	regmap_update_bits(regmap, NAU8360_R96_HW2_CTL6, NAU8360_HW2_DROOP_SEL_MASK |
+		NAU8360_HW2_DROOP_EN | NAU8360_HW2_FS_MASK,
+		NAU8360_HW2_DROOP_SEL_LARGE | NAU8360_HW2_DROOP_EN | NAU8360_HW2_FS_192K);
+	/* Set HW2 default volume */
+	regmap_write(regmap, NAU8360_R97_HW2_CTL7, 0xbf66);
+	regmap_write(regmap, NAU8360_R98_HW2_CTL8, 0xbf66);
+	/* Set HW2 Mute and Threshold of Zero Crossing */
+	regmap_update_bits(regmap, NAU8360_R99_HW2_CTL9, NAU8360_HW2_CH_MUTE |
+		NAU8360_HW2_ZERO_THD_MASK, NAU8360_HW2_CH_MUTE | 0xff);
+	/* According to DSP enabled or not, set stream path as
+	 * HW1->DSP->HW2->SINC->HW3 or HW1->HW2->SINC->HW3
+	 */
+	regmap_update_bits(regmap, NAU8360_R12_PATH_CTRL, NAU8360_SEL_HW1_MASK |
+		NAU8360_AUD_SEL_MASK | NAU8360_SEL_HW2_MASK | NAU8360_SEL_HW3_MASK |
+		NAU8360_DAC_SEL_MASK, NAU8360_SEL_HW1_OUT | NAU8360_AUD_SEL_SINCOUT |
+		NAU8360_SEL_HW2_OUT | NAU8360_SEL_HW3_OUT);
+	/* Set Input Status as Low and Input/Output Mode Disable for All GPIO */
+	regmap_write(regmap, NAU8360_R07_GP_CTRL, 0x0000);
+	/* enable SARADC with extra average filter of VBAT */
+	regmap_update_bits(regmap, NAU8360_R6A_SARADC_CFG0, NAU8360_SARADC_EN |
+		NAU8360_VBAT_AVG_EN, NAU8360_SARADC_EN | NAU8360_VBAT_AVG_EN);
+	/* Enable Temperature Sensor, VBATDIV and VRF.
+	 * Set Average Filter Data as 512 for VTEMP and VBAT.
+	 */
+	regmap_update_bits(regmap, NAU8360_R6B_SARADC_CFG1, NAU8360_VTEMP_EN |
+		NAU8360_VBATDIV_EN | NAU8360_VREF_EN | NAU8360_PRELOAD_VREF_EN |
+		NAU8360_VTEMP_AVG_N_MASK | NAU8360_VBAT_AVG_N_MASK, NAU8360_VTEMP_EN |
+		NAU8360_VBATDIV_EN | NAU8360_VREF_EN | NAU8360_PRELOAD_VREF_EN |
+		NAU8360_VTEMP_AVG_N_512 | NAU8360_VBAT_AVG_N_512);
+	/* Enable IV sense internal LDO */
+	regmap_update_bits(regmap, NAU8360_R6C_IVSNS_CFG0,
+		NAU8360_PD_LDO_SDM_IVSNS_PMD, 0);
+	/* Enable Bias Current and Reference Voltage for IVSENSE. Set VSNS Gain
+	 * as 1/12 and ISNS Gain as x16(24dB). Set PGA Current as 2'b11 and SDN
+	 * Delay as 2'b00.
+	 */
+	regmap_write(regmap, NAU8360_R6D_IVSNS_CFG1, 0x0f5c);
+	/* sawtooth clock from ivsense clock, PWM frequency 432 Khz */
+	regmap_update_bits(regmap, NAU8360_RA4_ANA_REG_0, NAU8360_SEL_STCLK_MASK |
+		NAU8360_NSEL_SAW_MASK, NAU8360_SEL_STCLK_IVCLK | 0x8);
+	/* sawtooth PLL APR */
+	regmap_update_bits(regmap, NAU8360_RA5_ANA_REG_1, NAU8360_SAW_PLL_MASK,
+		NAU8360_SAW_PLL_NOR);
+
+	/* Set DAC gain (0dB/+3.2dB) by current cell adjustment */
+	regmap_update_bits(regmap, NAU8360_R6E_DAC_CFG0, NAU8360_DAC_CUR_MASK,
+		nau8360->dac_cur_enable ? NAU8360_DAC_CUR_3_2DB : NAU8360_DAC_CUR_0DB);
+	/* Config trim short current reference. Enable Non-overlap longer delay.
+	 * Set segment driver as half driving strength.
+	 */
+	regmap_update_bits(regmap, NAU8360_R68_ANALOG_CONTROL_1, NAU8360_DTX_EN |
+		NAU8360_TRIMSCR_MASK | NAU8360_DRVCTL_SEGL_FULL |
+		NAU8360_DRVCTL_SEGR_FULL, NAU8360_TRIMSCR_MLOW | NAU8360_DTX_EN);
+	/* Enable SCP Clear Mode and Class D Modulator to Common Mode */
+	regmap_update_bits(regmap, NAU8360_R67_ANALOG_CONTROL_0,
+		NAU8360_SCP_CLEAR_MODE_MASK | NAU8360_CM_COMP_EN,
+		NAU8360_SCP_CLEAR_MODE_AUTO | NAU8360_CM_COMP_EN);
+	/* Set Analog Mute and Class D Modulator Gain as 14dB */
+	regmap_update_bits(regmap, NAU8360_R67_ANALOG_CONTROL_0, NAU8360_ANA_MUTE |
+		NAU8360_MOD_GAIN_MASK, NAU8360_ANA_MUTE | NAU8360_MOD_GAIN_14DB);
+	/* Set Stereo or PBTL Mode */
+	regmap_update_bits(regmap, NAU8360_R67_ANALOG_CONTROL_0,
+		NAU8360_V_PBTL_EN, nau8360->pbtl_enable ? NAU8360_V_PBTL_EN : 0);
+	regmap_update_bits(regmap, NAU8360_R6C_IVSNS_CFG0,
+		NAU8360_PBTL_ISENE_LR_MASK, NAU8360_PBTL_ISENE_LR_ILR);
+	/* adjust HW3 default volume of voltage/current sense */
+	regmap_write(regmap, NAU8360_R8A_HW3_VL_CTL7, 0xbe90);
+	regmap_write(regmap, NAU8360_R8B_HW3_VR_CTL8, 0xbe90);
+	regmap_write(regmap, NAU8360_R8D_HW3_IL_CTL7, nau8360->pbtl_enable ? 0xc3aa : 0xc24c);
+	regmap_write(regmap, NAU8360_R8E_HW3_IR_CTL8, nau8360->pbtl_enable ? 0xc3aa : 0xc24c);
+	/* Set HW3 Zero THD as 0xff */
+	regmap_update_bits(regmap, NAU8360_R8F_HW3_CTL9,
+		NAU8360_HW3_ZERO_THD_MASK, 0xff);
+	/* Enable TX SDOUT and Data at BCLK Rising. */
+	regmap_update_bits(regmap, NAU8360_R0D_I2S_PCM_CTRL3, NAU8360_TX_FILL_MASK,
+		NAU8360_TX_FILL_ZERO);
+	regmap_update_bits(regmap, NAU8360_R0D_I2S_PCM_CTRL3,
+		NAU8360_VSNS_L_SLEN_MASK, NAU8360_VSNS_L_SLEN_16);
+	regmap_update_bits(regmap, NAU8360_R0E_I2S_DATA_CTRL1,
+		NAU8360_ISNS_L_SLEN_MASK, NAU8360_ISNS_L_SLEN_16);
+	regmap_update_bits(regmap, NAU8360_R11_I2S_DATA_CTRL4,
+		NAU8360_VSNS_R_SLEN_MASK | NAU8360_ISNS_R_SLEN_MASK,
+		NAU8360_VSNS_R_SLEN_16 | NAU8360_ISNS_R_SLEN_16);
+	/* set DAC channel temperature trim code slope as 0x7D */
+	regmap_update_bits(regmap, NAU8360_R7A_DAC_TRIM_CFG2,
+		NAU8360_DAC_TEMP_SLOPE_MASK, 0x7D << NAU8360_DAC_TEMP_SLOPE_SFT);
+	/* set ISNS temperature trim code slope as 0x1a */
+	regmap_update_bits(regmap, NAU8360_R7B_IVSNS_TRIM_CFG,
+		NAU8360_ISNS_TEMP_SLOPE_MASK, 0x1a << NAU8360_ISNS_TEMP_SLOPE_SFT);
+	/* set misc trim config as 0x67F0 */
+	regmap_update_bits(regmap, NAU8360_R7C_MISC_TRIM_CFG, NAU8360_DAC_GAIN_SB_MASK |
+		NAU8360_DAC_TEMP_SB_MASK | NAU8360_ISNS_TEMP_SB_MASK |
+		NAU8360_VSNS_TEMP_SB_MASK | NAU8360_ISNS_GAIN_SB_MASK |
+		NAU8360_VSNS_GAIN_SB_MASK, (0x3 << NAU8360_DAC_TEMP_SB_SFT) |
+		(0x7 << NAU8360_ISNS_TEMP_SB_SFT) | (0x3 << NAU8360_VSNS_TEMP_SB_SFT));
+	/* Enable Efuse Initianllization */
+	regmap_update_bits(regmap, NAU8360_R60_RST, NAU8360_EFUSE_CTRL_EN,
+		NAU8360_EFUSE_CTRL_EN);
+	/* Clear HW2 DRAM */
+	regmap_update_bits(regmap, NAU8360_R90_HW2_CTL0,
+		NAU8360_HW2_DRAM_CLR, NAU8360_HW2_DRAM_CLR);
+	/* Finish HW DRAM Clear */
+	regmap_update_bits(regmap, NAU8360_R90_HW2_CTL0, NAU8360_HW2_DRAM_CLR, 0);
+	/* Clear HW3 DRAM */
+	regmap_update_bits(regmap, NAU8360_R86_HW3_CTL0,
+		NAU8360_HW3_DRAM_CLR, NAU8360_HW3_DRAM_CLR);
+	/* Finish HW DRAM Clear */
+	regmap_update_bits(regmap, NAU8360_R86_HW3_CTL0, NAU8360_HW3_DRAM_CLR, 0);
+}
+
+static void nau8360_print_device_properties(struct nau8360 *nau8360)
+{
+	int i;
+
+	dev_dbg(nau8360->dev, "pbtl-enable:         %d", nau8360->pbtl_enable);
+	dev_dbg(nau8360->dev, "dac-cur-enable:      %d", nau8360->dac_cur_enable);
+	for (i = 0; i < NAU8360_DSP_FW_NUM; i++)
+		dev_dbg(nau8360->dev, "firmware-name[%d]:     %s", i,
+			nau8360->dsp_firmware[i]);
+
+	for (i = 0; i < NAU8360_TDM_TXN; i++)
+		dev_dbg(nau8360->dev, "dsp-tx-slot[%d] (%s): %d%s", i,
+			nau8360_tx_func_names[i], nau8360->tdm_tx_func_slot[i],
+			nau8360->tdm_tx_func_slot[i] == TDM_SLOT_NONE ? " (none)" : "");
+
+	for (i = 0; i < NAU8360_TDM_RXN; i++)
+		dev_dbg(nau8360->dev, "dsp-rx-slot[%d] (%s): %d%s", i,
+			nau8360_rx_func_names[i], nau8360->tdm_rx_func_slot[i],
+			nau8360->tdm_rx_func_slot[i] == TDM_SLOT_NONE ? " (none)" : "");
+}
+
+static int nau8360_read_device_properties(struct nau8360 *nau8360)
+{
+	const char *def_fws[NAU8360_DSP_FW_NUM] = {
+		NAU8360_DSP_FIRMWARE".l", NAU8360_DSP_FIRMWARE".r"
+	};
+	struct device *dev = nau8360->dev;
+	const char *firmware_names[NAU8360_DSP_FW_NUM];
+	int i, ret;
+
+	ret = device_property_read_u32_array(dev, "nuvoton,dsp-tx-slot-mapping",
+		nau8360->tdm_tx_func_slot, NAU8360_TDM_TXN);
+	if (ret) {
+		for (i = 0; i < NAU8360_TDM_TXN; i++)
+			nau8360->tdm_tx_func_slot[i] = TDM_SLOT_NONE;
+	} else {
+		for (i = 0; i < NAU8360_TDM_TXN; i++) {
+			if (nau8360->tdm_tx_func_slot[i] == TDM_SLOT_NONE)
+				continue;
+			if (nau8360->tdm_tx_func_slot[i] >= NAU8360_TDM_MAX_CHAN) {
+				dev_warn(dev, "Invalid TX slot %d, set to none\n",
+					nau8360->tdm_tx_func_slot[i]);
+				nau8360->tdm_tx_func_slot[i] = TDM_SLOT_NONE;
+			}
+		}
+	}
+
+	ret = device_property_read_u32_array(dev, "nuvoton,dsp-rx-slot-mapping",
+		nau8360->tdm_rx_func_slot, NAU8360_TDM_RXN);
+	if (ret) {
+		nau8360->tdm_rx_func_slot[NAU8360_TDM_DACL] = 0;
+		nau8360->tdm_rx_func_slot[NAU8360_TDM_DACR] = 1;
+		nau8360->tdm_rx_func_slot[NAU8360_TDM_ANCL] = TDM_SLOT_NONE;
+		nau8360->tdm_rx_func_slot[NAU8360_TDM_ANCR] = TDM_SLOT_NONE;
+	} else {
+		for (i = 0; i < NAU8360_TDM_RXN; i++) {
+			if (nau8360->tdm_rx_func_slot[i] == TDM_SLOT_NONE)
+				continue;
+			if (nau8360->tdm_rx_func_slot[i] >= NAU8360_TDM_MAX_CHAN) {
+				dev_warn(dev, "Invalid RX slot %d, set to none\n",
+					nau8360->tdm_rx_func_slot[i]);
+				nau8360->tdm_rx_func_slot[i] = TDM_SLOT_NONE;
+			}
+		}
+	}
+
+	nau8360->pbtl_enable = device_property_read_bool(dev, "nuvoton,pbtl-enable");
+	nau8360->dac_cur_enable = device_property_read_bool(dev, "nuvoton,dac-cur-enable");
+
+	ret = device_property_read_string_array(dev, "firmware-name",
+		firmware_names, NAU8360_DSP_FW_NUM);
+	if (ret !=  NAU8360_DSP_FW_NUM) {
+		dev_warn(dev, "The firmware-name was not found, using default.");
+		for (i = 0; i < NAU8360_DSP_FW_NUM; i++) {
+			nau8360->dsp_firmware[i] = devm_kstrdup(dev, def_fws[i], GFP_KERNEL);
+
+			if (!nau8360->dsp_firmware[i])
+				return -ENOMEM;
+		}
+	} else {
+		for (i = 0; i < NAU8360_DSP_FW_NUM; i++) {
+			nau8360->dsp_firmware[i] = devm_kasprintf(dev, GFP_KERNEL,
+				NAU8360_DSP_FIRMDIR "%s", firmware_names[i]);
+
+			if (!nau8360->dsp_firmware[i])
+				return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+static struct reg_default *nau8360_alloc_defaults(struct device *dev, int *total_regs)
+{
+	struct reg_default *dyn_defaults;
+	int reg_num = ARRAY_SIZE(nau8360_reg_defaults);
+	int total = reg_num + (2 * NAU8360_TOT_BAND_PER_CH * NAU8360_TOT_BAND_COE);
+	int i, j, idx;
+
+	dyn_defaults = devm_kzalloc(dev, total * sizeof(*dyn_defaults), GFP_KERNEL);
+	if (!dyn_defaults)
+		return NULL;
+
+	memcpy(dyn_defaults, nau8360_reg_defaults, sizeof(*dyn_defaults) * reg_num);
+	idx = reg_num;
+
+	for (i = 0; i < NAU8360_TOT_BAND_PER_CH; i++) {
+		unsigned int range = i * NAU8360_TOT_BAND_COE_RANGE;
+		unsigned int l_base = NAU8360_R100_LEFT_BIQ0_COE + range;
+		unsigned int r_base = NAU8360_R200_RIGHT_BIQ0_COE + range;
+
+		for (j = 0; j < NAU8360_TOT_BAND_COE; j++) {
+			dyn_defaults[idx++].reg = l_base + j;
+			dyn_defaults[idx++].reg = r_base + j;
+		}
+	}
+
+	*total_regs = total;
+
+	return dyn_defaults;
+}
+
+static int nau8360_i2c_probe(struct i2c_client *i2c)
+{
+	struct device *dev = &i2c->dev;
+	struct nau8360 *nau8360;
+	struct regmap_config regmap_cfg = nau8360_regmap_config;
+	struct reg_default *dyn_defaults;
+	int num_total_regs;
+	int ret, value;
+
+	nau8360 = devm_kzalloc(dev, sizeof(*nau8360), GFP_KERNEL);
+	if (!nau8360)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, nau8360);
+	mutex_init(&nau8360->lock);
+	INIT_WORK(&nau8360->load_fw_work, nau8360_load_fw_work);
+
+	dyn_defaults = nau8360_alloc_defaults(dev, &num_total_regs);
+	if (!dyn_defaults)
+		return -ENOMEM;
+
+	regmap_cfg.reg_defaults = dyn_defaults;
+	regmap_cfg.num_reg_defaults = num_total_regs;
+
+	nau8360->regmap = devm_regmap_init(dev, NULL, i2c, &regmap_cfg);
+	if (IS_ERR(nau8360->regmap))
+		return PTR_ERR(nau8360->regmap);
+	nau8360->dev = dev;
+
+	nau8360_reset_chip(nau8360->regmap);
+	ret = regmap_read(nau8360->regmap, NAU8360_R46_I2C_DEVICE_ID, &value);
+	if (ret) {
+		dev_err(dev, "Failed to read NAU83G60 device id %d", ret);
+		return ret;
+	}
+
+	ret = nau8360_read_device_properties(nau8360);
+	if (ret)
+		return ret;
+
+	nau8360_print_device_properties(nau8360);
+	nau8360_init_regs(nau8360);
+
+	return devm_snd_soc_register_component(dev, &soc_comp_dev_nau8360, &nau8360_dai, 1);
+}
+
+static void nau8360_i2c_remove(struct i2c_client *client)
+{
+	struct nau8360 *nau8360 = i2c_get_clientdata(client);
+
+	cancel_work_sync(&nau8360->load_fw_work);
+}
+
+static const struct i2c_device_id nau8360_i2c_ids[] = {
+	{ .name = "nau8360" },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, nau8360_i2c_ids);
+
+static const struct of_device_id nau8360_of_ids[] = {
+	{ .compatible = "nuvoton,nau8360" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, nau8360_of_ids);
+
+static const struct acpi_device_id nau8360_acpi_match[] = {
+	{ .id = "NVTN2002" },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, nau8360_acpi_match);
+
+static struct i2c_driver nau8360_i2c_driver = {
+	.driver = {
+		.name = "nau8360",
+		.of_match_table = of_match_ptr(nau8360_of_ids),
+		.acpi_match_table = ACPI_PTR(nau8360_acpi_match),
+	},
+	.probe = nau8360_i2c_probe,
+	.remove = nau8360_i2c_remove,
+	.id_table = nau8360_i2c_ids,
+};
+module_i2c_driver(nau8360_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC NAU83G60 Stereo Class-D Amplifier with DSP and I/V-sense driver");
+MODULE_AUTHOR("David Lin <ctlin0@nuvoton.com>");
+MODULE_AUTHOR("Seven Lee <wtli@nuvoton.com>");
+MODULE_AUTHOR("John Hsu <kchsu0@nuvoton.com>");
+MODULE_AUTHOR("Neo Chang <ylchang2@nuvoton.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/nau8360.h b/sound/soc/codecs/nau8360.h
new file mode 100644
index 000000000000..cc640ba8c838
--- /dev/null
+++ b/sound/soc/codecs/nau8360.h
@@ -0,0 +1,911 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// The NAU83G60 Stereo Class-D Amplifier with DSP and I/V-sense driver.
+//
+// Copyright (C) 2026 Nuvoton Technology Corp.
+// Author: David Lin <ctlin0@nuvoton.com>
+//         Seven Lee <wtli@nuvoton.com>
+//         John Hsu <kchsu0@nuvoton.com>
+//         Neo Chang <ylchang2@nuvoton.com>
+
+#ifndef __NAU8360_H__
+#define __NAU8360_H__
+
+#define NAU8360_R00_SOFTWARE_RST		0x00
+#define NAU8360_R01_DSP_SOFTWARE_RST		0x01
+#define NAU8360_R02_I2C_ADDR			0x02
+#define NAU8360_R03_CLK_CTRL0			0x03
+#define NAU8360_R04_CLK_CTRL1			0x04
+#define NAU8360_R05_INTERRUPT_CTRL		0x05
+#define NAU8360_R06_INT_CLR_STATUS		0x06
+#define NAU8360_R07_GP_CTRL			0x07
+#define NAU8360_R08_GP_CTRL0			0x08
+#define NAU8360_R09_GP_CTRL1			0x09
+#define NAU8360_R0A_GP_CTRL2			0x0a
+#define NAU8360_R0B_I2S_PCM_CTRL1		0x0b
+#define NAU8360_R0C_I2S_PCM_CTRL2		0x0c
+#define NAU8360_R0D_I2S_PCM_CTRL3		0x0d
+#define NAU8360_R0E_I2S_DATA_CTRL1		0x0e
+#define NAU8360_R0F_I2S_DATA_CTRL2		0x0f
+#define NAU8360_R10_I2S_DATA_CTRL3		0x10
+#define NAU8360_R11_I2S_DATA_CTRL4		0x11
+#define NAU8360_R12_PATH_CTRL			0x12
+#define NAU8360_R16_NO_NAME			0x16
+#define NAU8360_R17_I2S0_DATA_CTRL5		0x17
+#define NAU8360_R1A_DSP_CORE_CTRL2		0x1a
+#define NAU8360_R21_VBAT_READOUT		0x21
+#define NAU8360_R22_TEMP_READOUT		0x22
+#define NAU8360_R2C_ALC_CTRL1			0x2c
+#define NAU8360_R2D_ALC_CTRL2			0x2d
+#define NAU8360_R2E_ALC_CTRL3			0x2e
+#define NAU8360_R31_UVLOP_CTRL1			0x31
+#define NAU8360_R32_UVLOP_CTRL2			0x32
+#define NAU8360_R33_UVLOP_CTRL3			0x33
+#define NAU8360_R40_CLK_DET_CTRL		0x40
+#define NAU8360_R41_CLK_CTL2			0x41
+#define NAU8360_R46_I2C_DEVICE_ID		0x46
+#define NAU8360_R5D_SINC_CFG			0x5d
+#define NAU8360_R5F_ANA_TRIM_CFG1		0x5f
+#define NAU8360_R60_RST				0x60
+#define NAU8360_R67_ANALOG_CONTROL_0		0x67
+#define NAU8360_R68_ANALOG_CONTROL_1		0x68
+#define NAU8360_R69_ANALOG_CONTROL_3		0x69
+#define NAU8360_R6A_SARADC_CFG0			0x6a
+#define NAU8360_R6B_SARADC_CFG1			0x6b
+#define NAU8360_R6C_IVSNS_CFG0			0x6c
+#define NAU8360_R6D_IVSNS_CFG1			0x6d
+#define NAU8360_R6E_DAC_CFG0			0x6e
+#define NAU8360_R71_CLK_DIV_CFG			0x71
+#define NAU8360_R72_PLL_CFG0			0x72
+#define NAU8360_R73_PLL_CFG1			0x73
+#define NAU8360_R74_PLL_CFG2			0x74
+#define NAU8360_R77_SOFT_SD			0x77
+#define NAU8360_R78_PD_SW_DLDO			0x78
+#define NAU8360_R79_EN_HIRC48M			0x79
+#define NAU8360_R7A_DAC_TRIM_CFG2		0x7a
+#define NAU8360_R7B_IVSNS_TRIM_CFG		0x7b
+#define NAU8360_R7C_MISC_TRIM_CFG		0x7c
+#define NAU8360_R7E_CLK_GATED_EN		0x7e
+#define NAU8360_R86_HW3_CTL0			0x86
+#define NAU8360_R88_ALC_CTRL6			0x88
+#define NAU8360_R8A_HW3_VL_CTL7			0x8a
+#define NAU8360_R8B_HW3_VR_CTL8			0x8b
+#define NAU8360_R8C_HW3_CTL6			0x8c
+#define NAU8360_R8D_HW3_IL_CTL7			0x8d
+#define NAU8360_R8E_HW3_IR_CTL8			0x8e
+#define NAU8360_R8F_HW3_CTL9			0x8f
+#define NAU8360_R90_HW2_CTL0			0x90
+#define NAU8360_R96_HW2_CTL6			0x96
+#define NAU8360_R97_HW2_CTL7			0x97
+#define NAU8360_R98_HW2_CTL8			0x98
+#define NAU8360_R99_HW2_CTL9			0x99
+#define NAU8360_R9A_HW1_CTL0			0x9a
+#define NAU8360_R9B_HW1_CTL1			0x9b
+#define NAU8360_R9C_HW1_CTL2			0x9c
+#define NAU8360_R9D_PEQ_CTL			0x9d
+#define NAU8360_RA0_LEFT_XODRC_CTRL		0xa0
+#define NAU8360_RA2_RIGHT_XODRC_CTRL		0xa2
+#define NAU8360_RA4_ANA_REG_0			0xa4
+#define NAU8360_RA5_ANA_REG_1			0xa5
+/* Left PEQ includes 15 band, 10 coeff per band, from start addr 0x100 */
+#define NAU8360_R100_LEFT_BIQ0_COE		0x100
+#define NAU8360_R10C_LEFT_BIQ1_COE		0x10c
+#define NAU8360_R118_LEFT_BIQ2_COE		0x118
+#define NAU8360_R124_LEFT_BIQ3_COE		0x124
+#define NAU8360_R130_LEFT_BIQ4_COE		0x130
+#define NAU8360_R13C_LEFT_BIQ5_COE		0x13c
+#define NAU8360_R148_LEFT_BIQ6_COE		0x148
+#define NAU8360_R154_LEFT_BIQ7_COE		0x154
+#define NAU8360_R160_LEFT_BIQ8_COE		0x160
+#define NAU8360_R16C_LEFT_BIQ9_COE		0x16c
+#define NAU8360_R178_LEFT_BIQ10_COE		0x178
+#define NAU8360_R184_LEFT_BIQ11_COE		0x184
+#define NAU8360_R190_LEFT_BIQ12_COE		0x190
+#define NAU8360_R19C_LEFT_BIQ13_COE		0x19c
+#define NAU8360_R1A8_LEFT_BIQ14_COE		0x1a8
+/* Right PEQ includes 15 band, 10 coeff per band, from start addr 0x200 */
+#define NAU8360_R200_RIGHT_BIQ0_COE		0x200
+#define NAU8360_R20C_RIGHT_BIQ1_COE		0x20c
+#define NAU8360_R218_RIGHT_BIQ2_COE		0x218
+#define NAU8360_R224_RIGHT_BIQ3_COE		0x224
+#define NAU8360_R230_RIGHT_BIQ4_COE		0x230
+#define NAU8360_R23C_RIGHT_BIQ5_COE		0x23c
+#define NAU8360_R248_RIGHT_BIQ6_COE		0x248
+#define NAU8360_R254_RIGHT_BIQ7_COE		0x254
+#define NAU8360_R260_RIGHT_BIQ8_COE		0x260
+#define NAU8360_R26C_RIGHT_BIQ9_COE		0x26c
+#define NAU8360_R278_RIGHT_BIQ10_COE		0x278
+#define NAU8360_R284_RIGHT_BIQ11_COE		0x284
+#define NAU8360_R290_RIGHT_BIQ12_COE		0x290
+#define NAU8360_R29C_RIGHT_BIQ13_COE		0x29c
+#define NAU8360_R2A8_RIGHT_BIQ14_COE		0x2a8
+#define NAU8360_RF000_DSP_COMM			0xf000
+#define NAU8360_RF002_DSP_COMM			0xf002
+#define NAU8360_REG_MAX				NAU8360_RF002_DSP_COMM
+
+/* 16-bit control register address, and 16-bits control register data */
+#define NAU8360_REG_ADDR_LEN			16
+#define NAU8360_REG_DATA_LEN			16
+
+/* NAU8360_R03_CLK_CTRL0 (0x03) */
+#define NAU8360_MCLK_DIV_SFT			10
+#define NAU8360_MCLK_DIV_MAX			0x3f
+#define NAU8360_MCLK_DIV_MASK			(0x3f << NAU8360_MCLK_DIV_SFT)
+#define NAU8360_DSP_CLK_DIV_SFT			7
+#define NAU8360_DSP_CLK_DIV_MAX			0x7
+#define NAU8360_DSP_CLK_DIV_MASK		(0x7 << NAU8360_DSP_CLK_DIV_SFT)
+#define NAU8360_DSP_CLK_SEL_SFT			5
+#define NAU8360_DSP_CLK_SEL_MASK		(0x3 << NAU8360_DSP_CLK_SEL_SFT)
+#define NAU8360_DSP_CLK_SEL_PLL			(0x2 << NAU8360_DSP_CLK_SEL_SFT)
+#define NAU8360_DSP_CLK_SEL_HIRC48M		(0x1 << NAU8360_DSP_CLK_SEL_SFT)
+#define NAU8360_DSP_CLK_SEL_MCLK		(0x0 << NAU8360_DSP_CLK_SEL_SFT)
+
+/* NAU8360_R04_CLK_CTRL1 (0x4) */
+#define NAU8360_MCLK_SEL_SFT			14
+#define NAU8360_MCLK_SEL_MASK			(0x3 << NAU8360_MCLK_SEL_SFT)
+#define NAU8360_MCLK_SEL_PLL			(0x2 << NAU8360_MCLK_SEL_SFT)
+#define NAU8360_MCLK_SEL_HIRC48M		(0x1 << NAU8360_MCLK_SEL_SFT)
+#define NAU8360_MCLK_SEL_MCLK			(0x0 << NAU8360_MCLK_SEL_SFT)
+#define NAU8360_HW_CLK_SEL_SFT			10
+#define NAU8360_HW_CLK_SEL_MASK			(0x3 << NAU8360_HW_CLK_SEL_SFT)
+#define NAU8360_HW_CLK_SEL_PLL			(0x2 << NAU8360_HW_CLK_SEL_SFT)
+#define NAU8360_HW_CLK_SEL_HIRC48M		(0x1 << NAU8360_HW_CLK_SEL_SFT)
+#define NAU8360_HW_CLK_SEL_MCLK			(0x0 << NAU8360_HW_CLK_SEL_SFT)
+#define NAU8360_HW_CLK_DIV_SFT			7
+#define NAU8360_HW_CLK_DIV_MAX			NAU8360_DSP_CLK_DIV_MAX
+#define NAU8360_HW_CLK_DIV_MASK			(0x7 << NAU8360_HW_CLK_DIV_SFT)
+
+/* NAU8360_R07_GP_CTRL (0x7) */
+#define NAU8360_GPIO1_IEOE_SFT			14
+#define NAU8360_GPIO1_IEOE_MASK			(0x3 << NAU8360_GPIO1_IEOE_SFT)
+#define NAU8360_GPIO2_IEOE_SFT			12
+#define NAU8360_GPIO2_IEOE_MASK			(0x3 << NAU8360_GPIO2_IEOE_SFT)
+#define NAU8360_GPIO3_IEOE_SFT			10
+#define NAU8360_GPIO3_IEOE_MASK			(0x3 << NAU8360_GPIO3_IEOE_SFT)
+#define NAU8360_GPIO4_IEOE_SFT			8
+#define NAU8360_GPIO4_IEOE_MASK			(0x3 << NAU8360_GPIO4_IEOE_SFT)
+#define NAU8360_GPIO1_IN_STAT_SFT		7
+#define NAU8360_GPIO1_IN_STAT_MASK		(0x1 << NAU8360_GPIO1_IN_STAT_SFT)
+#define NAU8360_GPIO2_IN_STAT_SFT		6
+#define NAU8360_GPIO2_IN_STAT_MASK		(0x1 << NAU8360_GPIO2_IN_STAT_SFT)
+#define NAU8360_GPIO3_IN_STAT_SFT		5
+#define NAU8360_GPIO3_IN_STAT_MASK		(0x1 << NAU8360_GPIO3_IN_STAT_SFT)
+#define NAU8360_GPIO4_IN_STAT_SFT		4
+#define NAU8360_GPIO4_IN_STAT_MASK		(0x1 << NAU8360_GPIO4_IN_STAT_SFT)
+
+/* NAU8360_R08_GP_CTRL0 (0x8) */
+#define NAU8360_GPIO2_MUX_SFT			14
+#define NAU8360_GPIO2_MUX_MASK			(0x3 << NAU8360_GPIO2_MUX_SFT)
+#define NAU8360_GPIO2_SR_SFT			13
+#define NAU8360_GPIO2_SR_MASK			(0x1 << NAU8360_GPIO2_SR_SFT)
+#define NAU8360_GPIO2_CDS_SFT			11
+#define NAU8360_GPIO2_CDS_MASK			(0x3 << NAU8360_GPIO2_CDS_SFT)
+#define NAU8360_GPIO2_PS_SFT			10
+#define NAU8360_GPIO2_PS_MASK			(0x1 << NAU8360_GPIO2_PS_SFT)
+#define NAU8360_GPIO2_PE_SFT			9
+#define NAU8360_GPIO2_PE_EN			(0x1 << NAU8360_GPIO2_PE_SFT)
+#define NAU8360_GPIO1_MUX_SFT			6
+#define NAU8360_GPIO1_MUX_MASK			(0x3 << NAU8360_GPIO1_MUX_SFT)
+#define NAU8360_GPIO1_SR_SFT			5
+#define NAU8360_GPIO1_SR_MASK			(0x1 << NAU8360_GPIO1_SR_SFT)
+#define NAU8360_GPIO1_CDS_SFT			3
+#define NAU8360_GPIO1_CDS_MASK			(0x3 << NAU8360_GPIO1_CDS_SFT)
+#define NAU8360_GPIO1_PS_SFT			2
+#define NAU8360_GPIO1_PS_MASK			(0x1 << NAU8360_GPIO1_PS_SFT)
+#define NAU8360_GPIO1_PE_SFT			1
+#define NAU8360_GPIO1_PE_EN			(0x1 << NAU8360_GPIO1_PE_SFT)
+
+/* NAU8360_R09_GP_CTRL1 (0x9) */
+#define NAU8360_GPIO4_MUX_SFT			14
+#define NAU8360_GPIO4_MUX_MASK			(0x3 << NAU8360_GPIO4_MUX_SFT)
+#define NAU8360_GPIO4_SR_SFT			13
+#define NAU8360_GPIO4_SR_MASK			(0x1 << NAU8360_GPIO4_SR_SFT)
+#define NAU8360_GPIO4_CDS_SFT			11
+#define NAU8360_GPIO4_CDS_MASK			(0x3 << NAU8360_GPIO4_CDS_SFT)
+#define NAU8360_GPIO4_PS_SFT			10
+#define NAU8360_GPIO4_PS_MASK			(0x1 << NAU8360_GPIO4_PS_SFT)
+#define NAU8360_GPIO4_PE_SFT			9
+#define NAU8360_GPIO4_PE_EN			(0x1 << NAU8360_GPIO4_PE_SFT)
+#define NAU8360_GPIO3_MUX_SFT			6
+#define NAU8360_GPIO3_MUX_MASK			(0x3 << NAU8360_GPIO3_MUX_SFT)
+#define NAU8360_GPIO3_SR_SFT			5
+#define NAU8360_GPIO3_SR_MASK			(0x1 << NAU8360_GPIO3_SR_SFT)
+#define NAU8360_GPIO3_CDS_SFT			3
+#define NAU8360_GPIO3_CDS_MASK			(0x3 << NAU8360_GPIO3_CDS_SFT)
+#define NAU8360_GPIO3_PS_SFT			2
+#define NAU8360_GPIO3_PS_MASK			(0x1 << NAU8360_GPIO3_PS_SFT)
+#define NAU8360_GPIO3_PE_SFT			1
+#define NAU8360_GPIO3_PE_EN			(0x1 << NAU8360_GPIO3_PE_SFT)
+
+/* NAU8360_R0B_I2S_PCM_CTRL1 (0x0b) */
+#define NAU8360_EN_TDM_TX_SFT			15
+#define NAU8360_EN_TDM_TX			(0x1 << NAU8360_EN_TDM_TX_SFT)
+#define NAU8360_EN_TDM_RX_SFT			14
+#define NAU8360_EN_TDM_RX			(0x1 << NAU8360_EN_TDM_RX_SFT)
+#define NAU8360_FRAME_START_SFT			8
+#define NAU8360_FRAME_START_MASK		(0x1 << NAU8360_FRAME_START_SFT)
+#define NAU8360_FRAME_START_H2L			(0x1 << NAU8360_FRAME_START_SFT)
+#define NAU8360_FRAME_START_L2H			(0x0 << NAU8360_FRAME_START_SFT)
+#define NAU8360_RX_JUSTIFY_SFT			7
+#define NAU8360_RX_JUSTIFY_MASK			(0x1 << NAU8360_RX_JUSTIFY_SFT)
+#define NAU8360_RX_RIGHT_JUSTIFY		(0x1 << NAU8360_RX_JUSTIFY_SFT)
+#define NAU8360_RX_LEFT_JUSTIFY			(0x0 << NAU8360_RX_JUSTIFY_SFT)
+#define NAU8360_RX_OFFSET_SFT			2
+#define NAU8360_RX_OFFSET_MASK			(0x1f << NAU8360_RX_OFFSET_SFT)
+#define NAU8360_RX_OFFSET_I2S			(0x1 << NAU8360_RX_OFFSET_SFT)
+#define NAU8360_RX_OFFSET_LEFT			(0x0 << NAU8360_RX_OFFSET_SFT)
+#define NAU8360_RX_OFFSET_RIGHT			(0x0 << NAU8360_RX_OFFSET_SFT)
+#define NAU8360_RX_OFFSET_PCM_A			(0x1 << NAU8360_RX_OFFSET_SFT)
+#define NAU8360_RX_OFFSET_PCM_B			(0x0 << NAU8360_RX_OFFSET_SFT)
+
+/* NAU8360_R0C_I2S_PCM_CTRL2 (0xc) */
+#define NAU8360_TDM_DLEN_SFT			10
+#define NAU8360_TDM_DLEN_MASK			(0x3 << NAU8360_TDM_DLEN_SFT)
+#define NAU8360_TDM_DLEN_32			(0x3 << NAU8360_TDM_DLEN_SFT)
+#define NAU8360_TDM_DLEN_24			(0x2 << NAU8360_TDM_DLEN_SFT)
+#define NAU8360_TDM_DLEN_20			(0x1 << NAU8360_TDM_DLEN_SFT)
+#define NAU8360_TDM_DLEN_16			(0x0 << NAU8360_TDM_DLEN_SFT)
+#define NAU8360_TDM_CLEN_SFT			8
+#define NAU8360_TDM_CLEN_MASK			(0x3 << NAU8360_TDM_CLEN_SFT)
+#define NAU8360_TDM_CLEN_32			(0x2 << NAU8360_TDM_CLEN_SFT)
+#define NAU8360_TDM_CLEN_24			(0x1 << NAU8360_TDM_CLEN_SFT)
+#define NAU8360_TDM_CLEN_16			(0x0 << NAU8360_TDM_CLEN_SFT)
+#define NAU8360_RX_DACR_SFT			4
+#define NAU8360_RX_DACR_MASK			(0xf << NAU8360_RX_DACR_SFT)
+#define NAU8360_RX_DACL_MASK			0xf
+
+/* NAU8360_R0D_I2S_PCM_CTRL3 (0x0d) */
+#define NAU8360_TX_FILL_SFT			12
+#define NAU8360_TX_FILL_MASK			(0x1 << NAU8360_TX_FILL_SFT)
+#define NAU8360_TX_FILL_HIGHZ			(0x1 << NAU8360_TX_FILL_SFT)
+#define NAU8360_TX_FILL_ZERO			(0x0 << NAU8360_TX_FILL_SFT)
+#define NAU8360_TX_OFFSET_SFT			9
+#define NAU8360_TX_OFFSET_MASK			(0x7 << NAU8360_TX_OFFSET_SFT)
+#define NAU8360_TX_OFFSET_I2S			(0x1 << NAU8360_TX_OFFSET_SFT)
+#define NAU8360_TX_OFFSET_LEFT			(0x0 << NAU8360_TX_OFFSET_SFT)
+#define NAU8360_TX_OFFSET_RIGHT			(0x0 << NAU8360_TX_OFFSET_SFT)
+#define NAU8360_TX_OFFSET_PCM_A			(0x1 << NAU8360_TX_OFFSET_SFT)
+#define NAU8360_TX_OFFSET_PCM_B			(0x0 << NAU8360_TX_OFFSET_SFT)
+#define NAU8360_VSNS_L_SLEN_SFT			7
+#define NAU8360_VSNS_L_SLEN_MASK		(0x1 << NAU8360_VSNS_L_SLEN_SFT)
+#define NAU8360_VSNS_L_SLEN_16			(0x1 << NAU8360_VSNS_L_SLEN_SFT)
+#define NAU8360_VSNS_L_SLEN_8			(0x0 << NAU8360_VSNS_L_SLEN_SFT)
+#define NAU8360_VSNS_L_TX_EN_SFT		6
+#define NAU8360_VSNS_L_TX_EN			(0x1 << NAU8360_VSNS_L_TX_EN_SFT)
+#define NAU8360_VSNS_L_SLOT_MASK		0x3f
+
+/* NAU8360_R0E_I2S_DATA_CTRL1 (0x0e) */
+#define NAU8360_ISNS_L_SLEN_SFT			15
+#define NAU8360_ISNS_L_SLEN_MASK		(0x1 << NAU8360_ISNS_L_SLEN_SFT)
+#define NAU8360_ISNS_L_SLEN_16			(0x1 << NAU8360_ISNS_L_SLEN_SFT)
+#define NAU8360_ISNS_L_SLEN_8			(0x0 << NAU8360_ISNS_L_SLEN_SFT)
+#define NAU8360_ISNS_L_TX_EN_SFT		14
+#define NAU8360_ISNS_L_TX_EN			(0x1 << NAU8360_ISNS_L_TX_EN_SFT)
+#define NAU8360_ISNS_L_SLOT_SFT			8
+#define NAU8360_ISNS_L_SLOT_MASK		(0x3f << NAU8360_ISNS_L_SLOT_SFT)
+#define NAU8360_PDM_L_SLEN_SFT			7
+#define NAU8360_PDM_L_SLEN_MASK			(0x1 << NAU8360_PDM_L_SLEN_SFT)
+#define NAU8360_PDM_L_SLEN_24			(0x1 << NAU8360_PDM_L_SLEN_SFT)
+#define NAU8360_PDM_L_SLEN_16			(0x0 << NAU8360_PDM_L_SLEN_SFT)
+#define NAU8360_PDM_L_TX_EN_SFT			6
+#define NAU8360_PDM_L_TX_EN			(0x1 << NAU8360_PDM_L_TX_EN_SFT)
+#define NAU8360_PDM_L_SLOT_MASK			0x3f
+
+/* NAU8360_R0F_I2S_DATA_CTRL2 (0xf) */
+#define NAU8360_VBAT_TX_EN_SFT			14
+#define NAU8360_VBAT_TX_EN			(0x1 << NAU8360_VBAT_TX_EN_SFT)
+#define NAU8360_VBAT_SLOT_SFT			8
+#define NAU8360_VBAT_SLOT_MASK			(0x3f << NAU8360_VBAT_SLOT_SFT)
+#define NAU8360_PDM_R_SLEN_SFT			7
+#define NAU8360_PDM_R_SLEN_MASK			(0x1 << NAU8360_PDM_R_SLEN_SFT)
+#define NAU8360_PDM_R_SLEN_24			(0x1 << NAU8360_PDM_R_SLEN_SFT)
+#define NAU8360_PDM_R_SLEN_16			(0x0 << NAU8360_PDM_R_SLEN_SFT)
+#define NAU8360_PDM_R_TX_EN_SFT			6
+#define NAU8360_PDM_R_TX_EN			(0x1 << NAU8360_PDM_R_TX_EN_SFT)
+#define NAU8360_PDM_R_SLOT_MASK			0x3f
+
+/* NAU8360_R10_I2S_DATA_CTRL3 (0x10) */
+#define NAU8360_RX_ANC_R_SFT			12
+#define NAU8360_RX_ANC_R_MASK			(0xf << NAU8360_RX_ANC_R_SFT)
+#define NAU8360_RX_ANC_L_SFT			8
+#define NAU8360_RX_ANC_L_MASK			(0xf << NAU8360_RX_ANC_L_SFT)
+#define NAU8360_TDM_LOOPBACK_SFT		7
+#define NAU8360_TDM_LOOPBACK			(0x1 << NAU8360_TDM_LOOPBACK_SFT)
+#define NAU8360_TEMP_TX_EN_SFT			6
+#define NAU8360_TEMP_TX_EN			(0x1 << NAU8360_TEMP_TX_EN_SFT)
+#define NAU8360_TEMP_SLOT_MASK			0x3f
+
+/* NAU8360_R11_I2S_DATA_CTRL4 (0x11) */
+#define NAU8360_VSNS_R_SLEN_SFT			15
+#define NAU8360_VSNS_R_SLEN_MASK		(0x1 << NAU8360_VSNS_R_SLEN_SFT)
+#define NAU8360_VSNS_R_SLEN_16			(0x1 << NAU8360_VSNS_R_SLEN_SFT)
+#define NAU8360_VSNS_R_SLEN_8			(0x0 << NAU8360_VSNS_R_SLEN_SFT)
+#define NAU8360_VSNS_R_TX_EN_SFT		14
+#define NAU8360_VSNS_R_TX_EN			(0x1 << NAU8360_VSNS_R_TX_EN_SFT)
+#define NAU8360_VSNS_R_SLOT_SFT			8
+#define NAU8360_VSNS_R_SLOT_MASK		(0x3f << NAU8360_VSNS_R_SLOT_SFT)
+#define NAU8360_ISNS_R_SLEN_SFT			7
+#define NAU8360_ISNS_R_SLEN_MASK		(0x1 << NAU8360_ISNS_R_SLEN_SFT)
+#define NAU8360_ISNS_R_SLEN_16			(0x1 << NAU8360_ISNS_R_SLEN_SFT)
+#define NAU8360_ISNS_R_SLEN_8			(0x0 << NAU8360_ISNS_R_SLEN_SFT)
+#define NAU8360_ISNS_R_TX_EN_SFT		6
+#define NAU8360_ISNS_R_TX_EN			(0x1 << NAU8360_ISNS_R_TX_EN_SFT)
+#define NAU8360_ISNS_R_SLOT_MASK		0x3f
+
+/* NAU8360_R12_PATH_CTRL (0x12) */
+#define NAU8360_SEL_HW1_SFT			9
+#define NAU8360_SEL_HW1_MASK			(0x1 << NAU8360_SEL_HW1_SFT)
+#define NAU8360_SEL_HW1_OUT			(0x1 << NAU8360_SEL_HW1_SFT)
+#define NAU8360_SEL_HW1_BYP			(0x0 << NAU8360_SEL_HW1_SFT)
+#define NAU8360_AUD_SEL_SFT			7
+#define NAU8360_AUD_SEL_MASK			(0x1 << NAU8360_AUD_SEL_SFT)
+#define NAU8360_AUD_SEL_SINCOUT			(0x1 << NAU8360_AUD_SEL_SFT)
+#define NAU8360_AUD_SEL_SINCBYP			(0x0 << NAU8360_AUD_SEL_SFT)
+#define NAU8360_SEL_HW2_SFT			6
+#define NAU8360_SEL_HW2_MASK			(0x1 << NAU8360_SEL_HW2_SFT)
+#define NAU8360_SEL_HW2_OUT			(0x1 << NAU8360_SEL_HW2_SFT)
+#define NAU8360_SEL_HW2_BYP			(0x0 << NAU8360_SEL_HW2_SFT)
+#define NAU8360_DAC_SEL_SFT			5
+#define NAU8360_DAC_SEL_MASK			(0x1 << NAU8360_DAC_SEL_SFT)
+#define NAU8360_DAC_SEL_DSP			(0x1 << NAU8360_DAC_SEL_SFT)
+#define NAU8360_DAC_SEL_BYP			(0x0 << NAU8360_DAC_SEL_SFT)
+#define NAU8360_SEL_HW3_SFT			4
+#define NAU8360_SEL_HW3_MASK			(0x1 << NAU8360_SEL_HW3_SFT)
+#define NAU8360_SEL_HW3_OUT			(0x1 << NAU8360_SEL_HW3_SFT)
+#define NAU8360_SEL_HW3_BYP			(0x0 << NAU8360_SEL_HW3_SFT)
+
+/* NAU8360_R17_I2S0_DATA_CTRL5 (0x17)*/
+#define NAU8360_AEC_L_SLEN_SFT			15
+#define NAU8360_AEC_L_SLEN_MASK			(0x1 << NAU8360_AEC_L_SLEN_SFT)
+#define NAU8360_AEC_L_SLEN_32			(0x1 << NAU8360_AEC_L_SLEN_SFT)
+#define NAU8360_AEC_L_SLEN_16			(0x0 << NAU8360_AEC_L_SLEN_SFT)
+#define NAU8360_AEC_L_EN_SFT			14
+#define NAU8360_AEC_L_EN			(0x1 << NAU8360_AEC_L_EN_SFT)
+#define NAU8360_AEC_L_SLOT_SFT			8
+#define NAU8360_AEC_L_SLOT_MASK			(0x3f << NAU8360_AEC_L_SLOT_SFT)
+#define NAU8360_AEC_R_SLEN_SFT			7
+#define NAU8360_AEC_R_SLEN_MASK			(0x1 << NAU8360_AEC_R_SLEN_SFT)
+#define NAU8360_AEC_R_SLEN_32			(0x1 << NAU8360_AEC_R_SLEN_SFT)
+#define NAU8360_AEC_R_SLEN_16			(0x0 << NAU8360_AEC_R_SLEN_SFT)
+#define NAU8360_AEC_R_EN_SFT			6
+#define NAU8360_AEC_R_EN			(0x1 << NAU8360_AEC_R_EN_SFT)
+#define NAU8360_AEC_R_SLOT_MASK			0x3f
+
+/* NAU8360_R1A_DSP_CORE_CTRL2 (0x1a) */
+#define NAU8360_DSP_RUNSTALL_SFT		4
+#define NAU8360_DSP_RUNSTALL			(0x1 << NAU8360_DSP_RUNSTALL_SFT)
+
+/* NAU8360_R21_VBAT_READOUT (0x21) */
+#define NAU8360_VBAT_BASE 1108
+#define NAU8360_VBAT_STEP 12353
+
+/* NAU8360_R40_CLK_DET_CTRL (0x40) */
+#define NAU8360_APWRUPEN_SFT			15
+#define NAU8360_APWRUPEN			(0x1 << NAU8360_APWRUPEN_SFT)
+#define NAU8360_CLKPWRUPEN_SFT			14
+#define NAU8360_CLKPWRUPEN			(0x1 << NAU8360_CLKPWRUPEN_SFT)
+#define NAU8360_SRATE_SFT			10
+#define NAU8360_SRATE_MASK			(0x7 << NAU8360_SRATE_SFT)
+#define NAU8360_SRATE_192000			(0x4 << NAU8360_SRATE_SFT)
+#define NAU8360_SRATE_96000			(0x3 << NAU8360_SRATE_SFT)
+#define NAU8360_SRATE_48000			(0x2 << NAU8360_SRATE_SFT)
+#define NAU8360_SRATE_32000			(0x1 << NAU8360_SRATE_SFT)
+#define NAU8360_SRATE_16000			(0x0 << NAU8360_SRATE_SFT)
+#define NAU8360_MCLK_RATE_SFT			7
+#define NAU8360_MCLK_RATE_MASK			(0x7 << NAU8360_MCLK_RATE_SFT)
+#define NAU8360_MCLK_RATE_24576			(0x4 << NAU8360_MCLK_RATE_SFT)
+#define NAU8360_MCLK_RATE_24000			(0x3 << NAU8360_MCLK_RATE_SFT)
+#define NAU8360_MCLK_RATE_19200			(0x2 << NAU8360_MCLK_RATE_SFT)
+#define NAU8360_MCLK_RATE_12288			(0x1 << NAU8360_MCLK_RATE_SFT)
+#define NAU8360_MCLK_RATE_12000			(0x0 << NAU8360_MCLK_RATE_SFT)
+#define NAU8360_FS_MCLK_DET_SFT			6
+#define NAU8360_FS_MCLK_DET			(0x1 << NAU8360_FS_MCLK_DET_SFT)
+#define NAU8360_FS_BCLK_DET_SFT			5
+#define NAU8360_FS_BCLK_DET			(0x1 << NAU8360_FS_BCLK_DET_SFT)
+
+/* NAU8360_R41_CLK_CTL2 (0x41) */
+#define NAU8360_NOISE_FILTER_THD_SFT		12
+#define NAU8360_NOISE_FILTER_THDT_MASK		(0xf << NAU8360_NOISE_FILTER_THD_SFT)
+#define NAU8360_SEL_BLOCK_SIZE_SFT		6
+#define NAU8360_SEL_BLOCK_SIZE_MASK		(0x7 << NAU8360_SEL_BLOCK_SIZE_SFT)
+#define NAU8360_EN_ABCLKDET_SFT			3
+#define NAU8360_EN_ABCLKDET			(0x1 << NAU8360_EN_ABCLKDET_SFT)
+#define NAU8360_EN_DBCLKDET_SFT			2
+#define NAU8360_EN_DBCLKDET			(0x1 << NAU8360_EN_DBCLKDET_SFT)
+#define NAU8360_EN_AMCLKDET_SFT			1
+#define NAU8360_EN_AMCLKDET			(0x1 << NAU8360_EN_AMCLKDET_SFT)
+#define NAU8360_EN_DMCLKDET			0x1
+
+/* NAU8360_R46_I2C_DEVICE_ID (0x46) */
+#define NAU8360_REG_SI_REV_MASK			0xff
+#define NAU8360_REG_SI_REV_B			0xf2
+#define NAU8360_REG_SI_REV_C			0xf5
+
+/* NAU8360_R5D_SINC_CFG (0x5d) */
+#define NAU8360_DAC_SINC_OSR_SFT		4
+#define NAU8360_DAC_SINC_OSR_MASK		(0x3 << NAU8360_DAC_SINC_OSR_SFT)
+#define NAU8360_DAC_SINC_OSR_250		(0x3 << NAU8360_DAC_SINC_OSR_SFT)
+#define NAU8360_DAC_SINC_OSR_200		(0x2 << NAU8360_DAC_SINC_OSR_SFT)
+#define NAU8360_DAC_SINC_OSR_128		(0x1 << NAU8360_DAC_SINC_OSR_SFT)
+#define NAU8360_DAC_SINC_OSR_0			(0x0 << NAU8360_DAC_SINC_OSR_SFT)
+#define NAU8360_IVSENSE_BS_OSR_MASK		0x3
+#define NAU8360_IVSENSE_BS_OSR_25		0x3
+#define NAU8360_IVSENSE_BS_OSR_64		0x2
+#define NAU8360_IVSENSE_BS_OSR_32		0x1
+#define NAU8360_IVSENSE_BS_OSR_16		0x0
+
+/* NAU8360_R60_RST (0x60) */
+#define NAU8360_PD_POR5_SFT			4
+#define NAU8360_PD_POR5_PWD			(0x1 << NAU8360_PD_POR5_SFT)
+#define NAU8360_EFUSE_CTRL_SFT			3
+#define NAU8360_EFUSE_CTRL_EN			(0x1 << NAU8360_EFUSE_CTRL_SFT)
+
+/*  NAU8360_R67_ANALOG_CONTROL_0 (0x67) */
+#define NAU8360_SCP_CLEAR_MODE_SFT		15
+#define NAU8360_SCP_CLEAR_MODE_MASK		(0x1 << NAU8360_SCP_CLEAR_MODE_SFT)
+#define NAU8360_SCP_CLEAR_MODE_AUTO		(0x1 << NAU8360_SCP_CLEAR_MODE_SFT)
+#define NAU8360_SCP_CLEAR_MODE_MANU		(0x0 << NAU8360_SCP_CLEAR_MODE_SFT)
+#define NAU8360_SCP_CLEAR_SFT			14
+#define NAU8360_SCP_CLEAR			(0x1 << NAU8360_SCP_CLEAR_SFT)
+#define NAU8360_HV_EN_SFT			13
+#define NAU8360_HV_EN				(0x1 << NAU8360_HV_EN_SFT)
+#define NAU8360_ANA_MUTE_SFT			8
+#define NAU8360_ANA_MUTE			(0x1 << NAU8360_ANA_MUTE_SFT)
+#define NAU8360_MOD_GAIN_SFT			5
+#define NAU8360_MOD_GAIN_MASK			(0x7 << NAU8360_MOD_GAIN_SFT)
+#define NAU8360_MOD_GAIN_20DB			(0x7 << NAU8360_MOD_GAIN_SFT)
+#define NAU8360_MOD_GAIN_18DB			(0x6 << NAU8360_MOD_GAIN_SFT)
+#define NAU8360_MOD_GAIN_16DB			(0x5 << NAU8360_MOD_GAIN_SFT)
+#define NAU8360_MOD_GAIN_14DB			(0x4 << NAU8360_MOD_GAIN_SFT)
+#define NAU8360_MOD_GAIN_12DB			(0x3 << NAU8360_MOD_GAIN_SFT)
+#define NAU8360_MOD_GAIN_10DB			(0x2 << NAU8360_MOD_GAIN_SFT)
+#define NAU8360_MOD_GAIN_8DB			(0x1 << NAU8360_MOD_GAIN_SFT)
+#define NAU8360_MOD_GAIN_6DB			(0x0 << NAU8360_MOD_GAIN_SFT)
+#define NAU8360_CM_COMP_SFT			4
+#define NAU8360_CM_COMP_EN			(0x1 << NAU8360_CM_COMP_SFT)
+#define NAU8360_V_PBTL_SFT			3
+#define NAU8360_V_PBTL_EN			(0x1 << NAU8360_V_PBTL_SFT)
+
+/* NAU8360_R68_ANALOG_CONTROL_1 (0x68) */
+#define NAU8360_TRIMSCR_SFT			6
+#define NAU8360_TRIMSCR_MASK			(0x3 << NAU8360_TRIMSCR_SFT)
+#define NAU8360_TRIMSCR_HIGH			(0x3 << NAU8360_TRIMSCR_SFT)
+#define NAU8360_TRIMSCR_MHIGH			(0x2 << NAU8360_TRIMSCR_SFT)
+#define NAU8360_TRIMSCR_MLOW			(0x1 << NAU8360_TRIMSCR_SFT)
+#define NAU8360_TRIMSCR_LOW			(0x0 << NAU8360_TRIMSCR_SFT)
+#define NAU8360_DTX_SFT				5
+#define NAU8360_DTX_EN				(0x1 << NAU8360_DTX_SFT)
+#define NAU8360_DRVCTL_SEGL_SFT			4
+#define NAU8360_DRVCTL_SEGL_FULL		(0x1 << NAU8360_DRVCTL_SEGL_SFT)
+#define NAU8360_DRVCTL_SEGR_SFT			2
+#define NAU8360_DRVCTL_SEGR_FULL		(0x1 << NAU8360_DRVCTL_SEGR_SFT)
+#define NAU8360_SCP_TEST_SFT			1
+#define NAU8360_SCP_TEST			(0x1 << NAU8360_SCP_TEST_SFT)
+#define NAU8360_SEG_AUTO_CTRL_EN		0x1
+
+/* NAU8360_R69_ANALOG_CONTROL_3 (0x69) */
+#define NAU8360_ANA_STATUS_OTP_SFT		8
+#define NAU8360_ANA_STATUS_OTP_MASK		(0x1 << NAU8360_ANA_STATUS_OTP_SFT)
+#define NAU8360_ANA_STATUS_OVLO_SFT		7
+#define NAU8360_ANA_STATUS_OVLO_MASK		(0x1 << NAU8360_ANA_STATUS_OVLO_SFT)
+#define NAU8360_ANA_STATUS_UVLO_SFT		6
+#define NAU8360_ANA_STATUS_UVLO_MASK		(0x1 << NAU8360_ANA_STATUS_UVLO_SFT)
+#define NAU8360_ANA_STATUS_SCP_SFT		4
+#define NAU8360_ANA_STATUS_SCP_MASK		(0x1 << NAU8360_ANA_STATUS_SCP_SFT)
+#define NAU8360_ANA_STATUS_EN_V2I_SFT		3
+#define NAU8360_ANA_STATUS_EN_V2I_MASK		(0x1 << NAU8360_ANA_STATUS_EN_V2I_SFT)
+#define NAU8360_ANA_STATUS_FAULT_SFT		2
+#define NAU8360_ANA_STATUS_FAULT_MASK		(0x1 << NAU8360_ANA_STATUS_FAULT_SFT)
+#define NAU8360_ANA_STATUS_DC_DET_SFT		1
+#define NAU8360_ANA_STATUS_DC_DET_MASK		(0x1 << NAU8360_ANA_STATUS_DC_DET_SFT)
+#define NAU8360_ANA_STATUS_EN_ALL_MASK		0x1
+
+/* NAU8360_R6A_SARADC_CFG0 (0x6a) */
+#define NAU8360_SARADC_SFT			15
+#define NAU8360_SARADC_EN			(0x1 << NAU8360_SARADC_SFT)
+#define NAU8360_RESETB_SARADC_SFT		14
+#define NAU8360_RESETB_SARADC_MASK		(0x1 << NAU8360_RESETB_SARADC_SFT)
+#define NAU8360_RESETB_SARADC_NOR		(0x1 << NAU8360_RESETB_SARADC_SFT)
+#define NAU8360_RESETB_SARADC_RST		(0x0 << NAU8360_RESETB_SARADC_SFT)
+#define NAU8360_SARADC_CAL_SFT			13
+#define NAU8360_SARADC_CAL			(0x1 << NAU8360_SARADC_CAL_SFT)
+#define NAU8360_SARADC_DIV_SFT			12
+#define NAU8360_SARADC_DIV			(0x1 << NAU8360_SARADC_DIV_SFT)
+#define NAU8360_SARADC_CALSEL_SFT		9
+#define NAU8360_SARADC_CALSEL_MASK		(0x7 << NAU8360_SARADC_CALSEL_SFT)
+#define NAU8360_TRIMSMPL_SFT			3
+#define NAU8360_TRIMSMPL_MASK			(0x7 << NAU8360_TRIMSMPL_SFT)
+#define NAU8360_SAR_INPUT_CH_SEL_SFT		2
+#define NAU8360_SAR_INPUT_CH_SEL_MASK		(0x1 << NAU8360_SAR_INPUT_CH_SEL_SFT)
+#define NAU8360_VBAT_AVG_SFT			1
+#define NAU8360_VBAT_AVG_EN			(0x1 << NAU8360_VBAT_AVG_SFT)
+#define NAU8360_VTEMP_AVG_EN			0x1
+
+/* NAU8360_R6B_SARADC_CFG1 (0x6b) */
+#define NAU8360_VTEMP_SFT			15
+#define NAU8360_VTEMP_EN			(0x1 << NAU8360_VTEMP_SFT)
+#define NAU8360_VBATDIV_SFT			14
+#define NAU8360_VBATDIV_EN			(0x1 << NAU8360_VBATDIV_SFT)
+#define NAU8360_VREF_SFT			10
+#define NAU8360_VREF_EN				(0x1 << NAU8360_VREF_SFT)
+#define NAU8360_PRELOAD_VREF_SFT		9
+#define NAU8360_PRELOAD_VREF_EN			(0x1 << NAU8360_PRELOAD_VREF_SFT)
+#define NAU8360_VTEMP_AVG_N_SFT			2
+#define NAU8360_VTEMP_AVG_N_MASK		(0x3 << NAU8360_VTEMP_AVG_N_SFT)
+#define NAU8360_VTEMP_AVG_N_512			(0x3 << NAU8360_VTEMP_AVG_N_SFT)
+#define NAU8360_VTEMP_AVG_N_128			(0x2 << NAU8360_VTEMP_AVG_N_SFT)
+#define NAU8360_VTEMP_AVG_N_32			(0x1 << NAU8360_VTEMP_AVG_N_SFT)
+#define NAU8360_VTEMP_AVG_N_1			(0x0 << NAU8360_VTEMP_AVG_N_SFT)
+#define NAU8360_VBAT_AVG_N_MASK			0x3
+#define NAU8360_VBAT_AVG_N_512			0x3
+#define NAU8360_VBAT_AVG_N_128			0x2
+#define NAU8360_VBAT_AVG_N_32			0x1
+#define NAU8360_VBAT_AVG_N_1			0
+
+/* NAU8360_R6C_IVSNS_CFG0 (0x6c) */
+#define NAU8360_PD_VSNS_R_SFT			15
+#define NAU8360_PD_VSNS_R_PMD			(0x1 << NAU8360_PD_VSNS_R_SFT)
+#define NAU8360_PD_VSNS_L_SFT			14
+#define NAU8360_PD_VSNS_L_PMD			(0x1 << NAU8360_PD_VSNS_L_SFT)
+#define NAU8360_PD_ISNS_R_SFT			13
+#define NAU8360_PD_ISNS_R_PMD			(0x1 << NAU8360_PD_ISNS_R_SFT)
+#define NAU8360_PD_ISNS_L_SFT			12
+#define NAU8360_PD_ISNS_L_PMD			(0x1 << NAU8360_PD_ISNS_L_SFT)
+#define NAU8360_RESET_SC_VADC_R_SFT		11
+#define NAU8360_RESET_SC_VADC_R_RST		(0x1 << NAU8360_RESET_SC_VADC_R_SFT)
+#define NAU8360_RESET_SC_VADC_L_SFT		10
+#define NAU8360_RESET_SC_VADC_L_RST		(0x1 << NAU8360_RESET_SC_VADC_L_SFT)
+#define NAU8360_RESET_SC_IADC_R_SFT		9
+#define NAU8360_RESET_SC_IADC_R_RST		(0x1 << NAU8360_RESET_SC_IADC_R_SFT)
+#define NAU8360_RESET_SC_IADC_L_SFT		8
+#define NAU8360_RESET_SC_IADC_L_RST		(0x1 << NAU8360_RESET_SC_IADC_L_SFT)
+#define NAU8360_PBTL_ISENE_LR_SFT		7
+#define NAU8360_PBTL_ISENE_LR_MASK		(0x1 << NAU8360_PBTL_ISENE_LR_SFT)
+#define NAU8360_PBTL_ISENE_LR_ILR		(0x1 << NAU8360_PBTL_ISENE_LR_SFT)
+#define NAU8360_PBTL_ISENE_LR_I2R		(0x0 << NAU8360_PBTL_ISENE_LR_SFT)
+#define NAU8360_PD_LDO_SDM_IVSNS_SFT		6
+#define NAU8360_PD_LDO_SDM_IVSNS_PMD		(0x1 << NAU8360_PD_LDO_SDM_IVSNS_SFT)
+
+/* NAU8360_R6D_IVSNS_CFG1 (0x6d) */
+#define NAU8360_PD_V2I_IVSNS_SFT		13
+#define NAU8360_PD_V2I_IVSNS_MASK		(0x1 << NAU8360_PD_V2I_IVSNS_SFT)
+#define NAU8360_PD_VREF_SDM_IVSNS_SFT		12
+#define NAU8360_PD_VREF_SDM_IVSNS_MASK		(0x1 << NAU8360_PD_VREF_SDM_IVSNS_SFT)
+#define NAU8360_VSNS_PGA_CUR_SET_SFT		10
+#define NAU8360_VSNS_PGA_CUR_SET_MASK		(0x3 << NAU8360_VSNS_PGA_CUR_SET_SFT)
+#define NAU8360_VSNS_GAIN_SFT			8
+#define NAU8360_VSNS_GAIN_MASK			(0x3 << NAU8360_VSNS_GAIN_SFT)
+#define NAU8360_VREF_CUR_SFT			6
+#define NAU8360_VREF_CUR_MASK			(0x3 << NAU8360_VREF_CUR_SFT)
+#define NAU8360_ISNS_PGA_CUR_SFT		4
+#define NAU8360_ISNS_PGA_CUR_MASK		(0x3 << NAU8360_ISNS_PGA_CUR_SFT)
+#define NAU8360_ISNS_GAIN_SFT			2
+#define NAU8360_ISNS_GAIN_MASK			(0x3 << NAU8360_ISNS_GAIN_SFT)
+#define NAU8360_SDM_DELAY_TRIM_MASK		0x3
+
+/* NAU8360_R6E_DAC_CFG0 (0x6e) */
+#define NAU8360_PD_DACL_SFT			11
+#define NAU8360_PD_DACL_DIS			(0x1 << NAU8360_PD_DACL_SFT)
+#define NAU8360_PD_DACR_SFT			10
+#define NAU8360_PD_DACR_DIS			(0x1 << NAU8360_PD_DACR_SFT)
+#define NAU8360_PD_CHOP_DAC_SFT			9
+#define NAU8360_PD_CHOP_DAC_MASK		(0x1 << NAU8360_PD_CHOP_DAC_SFT)
+#define NAU8360_DAC_RES_SFT			7
+#define NAU8360_DAC_RES_MASK			(0x1 << NAU8360_DAC_RES_SFT)
+#define NAU8360_DAC_CUR_SFT			6
+#define NAU8360_DAC_CUR_MASK			(0x1 << NAU8360_DAC_CUR_SFT)
+#define NAU8360_DAC_CUR_3_2DB			(0x1 << NAU8360_DAC_CUR_SFT)
+#define NAU8360_DAC_CUR_0DB			(0x0 << NAU8360_DAC_CUR_SFT)
+#define NAU8360_DAC_BUFOPCUR_SFT		4
+#define NAU8360_DAC_BUFOPCUR_MASK		(0x3 << NAU8360_DAC_BUFOPCUR_SFT)
+#define NAU8360_DAC_IVOPCUR_SFT			2
+#define NAU8360_DAC_IVOPCUR_MASK		(0x3 << NAU8360_DAC_IVOPCUR_SFT)
+#define NAU8360_DAC_LPFOP_CUR_MASK		0x3
+
+/* NAU8360_R71_CLK_DIV_CFG (0x71) */
+#define NAU8360_IVSNS_CLK_INV_SEL_SFT		10
+#define NAU8360_IVSNS_CLK_INV_SEL_MASK		(0x1 << NAU8360_IVSNS_CLK_INV_SEL_SFT)
+#define NAU8360_CLK_ANA_SEL_SFT			7
+#define NAU8360_CLK_ANA_SEL_MASK		(0x3 << NAU8360_CLK_ANA_SEL_SFT)
+#define NAU8360_CLK_ANA_SEL_PLL			(0x2 << NAU8360_CLK_ANA_SEL_SFT)
+#define NAU8360_CLK_ANA_SEL_BCLK		(0x1 << NAU8360_CLK_ANA_SEL_SFT)
+#define NAU8360_CLK_ANA_SEL_MCLK		(0x0 << NAU8360_CLK_ANA_SEL_SFT)
+#define NAU8360_IVSNS_CLK_DIV_SFT		4
+#define NAU8360_IVSNS_CLK_DIV_MASK		(0x7 << NAU8360_IVSNS_CLK_DIV_SFT)
+#define NAU8360_DAC_OUTPUT_EDGE_SFT		3
+#define NAU8360_DAC_OUTPUT_EDGE_MASK		(0x1 << NAU8360_DAC_OUTPUT_EDGE_SFT)
+#define NAU8360_DAC_CLK_DIV_SFT			1
+#define NAU8360_DAC_CLK_DIV_MASK		(0x3 << NAU8360_DAC_CLK_DIV_SFT)
+#define NAU8360_DAC_CLK_DIV_8			(0x3 << NAU8360_DAC_CLK_DIV_SFT)
+#define NAU8360_DAC_CLK_DIV_4			(0x2 << NAU8360_DAC_CLK_DIV_SFT)
+#define NAU8360_DAC_CLK_DIV_2			(0x1 << NAU8360_DAC_CLK_DIV_SFT)
+#define NAU8360_DAC_CLK_DIV_1			(0x0 << NAU8360_DAC_CLK_DIV_SFT)
+#define NAU8360_DAC_CHOP_CLK_DIV_MASK		0x1
+#define NAU8360_DAC_CHOP_CLK_DIV_32		0x1
+#define NAU8360_DAC_CHOP_CLK_DIV_16		0x0
+
+/* NAU8360_R72_PLL_CFG0 (0x72) */
+#define NAU8360_PLLOUT_DIV_SFT			10
+#define NAU8360_PLLOUT_DIV_MAX			0x1f
+#define NAU8360_PLLOUT_DIV_MASK			(0x1f << NAU8360_PLLOUT_DIV_SFT)
+#define NAU8360_PLLOUT_DIV_BYPASS		(0x0 << NAU8360_PLLOUT_DIV_SFT)
+#define NAU8360_PLL_CLK_SEL_SFT			8
+#define NAU8360_PLL_CLK_SEL_MASK		(0x3 << NAU8360_PLL_CLK_SEL_SFT)
+#define NAU8360_PLL_CLK_SEL_HIRC		(0x3 << NAU8360_PLL_CLK_SEL_SFT)
+#define NAU8360_PLL_CLK_SEL_BCLK		(0x1 << NAU8360_PLL_CLK_SEL_SFT)
+#define NAU8360_PLL_CLK_SEL_MCLK		(0x0 << NAU8360_PLL_CLK_SEL_SFT)
+#define NAU8360_PD_PLL_SFT			7
+#define NAU8360_PD_PLL_MASK			(0x1 << NAU8360_PD_PLL_SFT)
+#define NAU8360_PD_PLL_DIS			(0x1 << NAU8360_PD_PLL_SFT)
+#define NAU8360_PD_PLL_EN			(0x0 << NAU8360_PD_PLL_SFT)
+
+/* NAU8360_R73_PLL_CFG1 (0x73) */
+#define NAU8360_RSEL_SFT			13
+#define NAU8360_RSEL_MASK			(0x3 << NAU8360_RSEL_SFT)
+#define NAU8360_MSEL_SFT			8
+#define NAU8360_MSEL_MASK			(0x1f << NAU8360_MSEL_SFT)
+#define NAU8360_NSEL_MASK			0xff
+
+/* NAU8360_R74_PLL_CFG2 (0x74) */
+#define NAU8360_XSEL_MASK			0xfff
+
+/* NAU8360_R77_SOFT_SD (0x77) */
+#define NAU8360_SOFT_SD				0x55AA
+#define NAU8360_SOFT_SD_EN			0
+
+/* NAU8360_R78_PD_SW_DLDO (0x78) */
+#define NAU8360_PD_SW_DLDO			0xAA55
+#define NAU8360_PD_SW_DLDO_EN			0
+
+/* NAU8360_R7A_DAC_TRIM_CFG2 (0x7a) */
+#define NAU8360_DAC_TEMP_SLOPE_SFT		8
+#define NAU8360_DAC_TEMP_SLOPE_MASK		(0x7f << NAU8360_DAC_TEMP_SLOPE_SFT)
+
+/* NAU8360_R7B_IVSNS_TRIM_CFG (0x7b) */
+#define NAU8360_ISNS_TEMP_SLOPE_SFT		8
+#define NAU8360_ISNS_TEMP_SLOPE_MASK		(0x7f << NAU8360_ISNS_TEMP_SLOPE_SFT)
+#define NAU8360_VSNS_TEMP_SLOPE_MASK		0x7f
+
+/* NAU8360_R7C_MISC_TRIM_CFG (0x7c) */
+#define NAU8360_DAC_OS_SB_SFT			13
+#define NAU8360_DAC_OS_SB_SFT_MASK		(0x7 << NAU8360_DAC_OS_SB_SFT)
+#define NAU8360_DAC_GAIN_SB_SFT			11
+#define NAU8360_DAC_GAIN_SB_MASK		(0x3 << NAU8360_DAC_GAIN_SB_SFT)
+#define NAU8360_DAC_TEMP_SB_SFT			9
+#define NAU8360_DAC_TEMP_SB_MASK		(0x3 << NAU8360_DAC_TEMP_SB_SFT)
+#define NAU8360_ISNS_TEMP_SB_SFT		6
+#define NAU8360_ISNS_TEMP_SB_MASK		(0x7 << NAU8360_ISNS_TEMP_SB_SFT)
+#define NAU8360_VSNS_TEMP_SB_SFT		4
+#define NAU8360_VSNS_TEMP_SB_MASK		(0x3 << NAU8360_VSNS_TEMP_SB_SFT)
+#define NAU8360_ISNS_GAIN_SB_SFT		2
+#define NAU8360_ISNS_GAIN_SB_MASK		(0x3 << NAU8360_ISNS_GAIN_SB_SFT)
+#define NAU8360_VSNS_GAIN_SB_MASK		0x3
+
+/* NAU8360_R7E_CLK_GATED_EN (0x7e)*/
+#define NAU8360_CLK_GATED_EN			0xa5a5
+#define NAU8360_CLK_GATED_DIS			0
+
+/* NAU8360_R86_HW3_CTL0 (0x86) */
+#define NAU8360_HW3_DRAM_CLR_SFT		14
+#define NAU8360_HW3_DRAM_CLR			(0x1 << NAU8360_HW3_DRAM_CLR_SFT)
+#define NAU8360_HW3_STALL_SFT			13
+#define NAU8360_HW3_STALL			(0x1 << NAU8360_HW3_STALL_SFT)
+
+/* NAU8360_R8C_HW3_CTL6 (0x8c)*/
+#define NAU8360_HW3_DROOP_SFT			2
+#define NAU8360_HW3_DROOP_MASK			(0x1 << NAU8360_HW3_DROOP_SFT)
+#define NAU8360_HW3_DROOP_192K			(0x1 << NAU8360_HW3_DROOP_SFT)
+#define NAU8360_HW3_DROOP_96K			(0x0 << NAU8360_HW3_DROOP_SFT)
+#define NAU8360_HW3_FS_MASK			0x1
+#define NAU8360_HW3_FS_192K			0x1
+#define NAU8360_HW3_FS_96K			0x0
+
+/* NAU8360_R8F_HW3_CTL9 (0x8f)*/
+#define NAU8360_HW3_CH_MUTE_SFT			8
+#define NAU8360_HW3_CH_MUTE			(0x1 << NAU8360_HW3_CH_MUTE_SFT)
+#define NAU8360_HW3_ZERO_THD_MASK		0xff
+
+/* NAU8360_R90_HW2_CTL0 (0x90) */
+#define NAU8360_HW2_DRAM_CLR_SFT		14
+#define NAU8360_HW2_DRAM_CLR			(0x1 << NAU8360_HW2_DRAM_CLR_SFT)
+#define NAU8360_HW2_STALL_SFT			13
+#define NAU8360_HW2_STALL			(0x1 << NAU8360_HW2_STALL_SFT)
+
+/* NAU8360_R96_HW2_CTL6 (0x96) */
+#define NAU8360_HW1_ANC_EN_SFT			15
+#define NAU8360_HW1_ANC_EN			(0x1 << NAU8360_HW1_ANC_EN_SFT)
+#define NAU8360_HW2_DROOP_SEL_SFT		3
+#define NAU8360_HW2_DROOP_SEL_MASK		(0x1 << NAU8360_HW2_DROOP_SEL_SFT)
+#define NAU8360_HW2_DROOP_SEL_LARGE		(0x1 << NAU8360_HW2_DROOP_SEL_SFT)
+#define NAU8360_HW2_DROOP_SEL_SMALL		(0x0 << NAU8360_HW2_DROOP_SEL_SFT)
+#define NAU8360_HW2_DROOP_EN_SFT		2
+#define NAU8360_HW2_DROOP_EN			(0x1 << NAU8360_HW2_DROOP_EN_SFT)
+#define NAU8360_HW2_LATENCY_SFT			1
+#define NAU8360_HW2_LATENCY_MASK		(0x1 << NAU8360_HW2_LATENCY_SFT)
+#define NAU8360_HW2_LATENCY_LOW			(0x1 << NAU8360_HW2_LATENCY_SFT)
+#define NAU8360_HW2_LATENCY_NOR			(0x0 << NAU8360_HW2_LATENCY_SFT)
+#define NAU8360_HW2_FS_MASK			0x1
+#define NAU8360_HW2_FS_192K			0x1
+#define NAU8360_HW2_FS_96K			0x0
+
+/* NAU8360_R99_HW2_CTL9 (0x99) */
+#define NAU8360_HW2_VSR_SFT			9
+#define NAU8360_HW2_VSR_MASK			(0x3 << NAU8360_HW2_VSR_SFT)
+#define NAU8360_HW2_CH_MUTE_SFT			8
+#define NAU8360_HW2_CH_MUTE			(0x1 << NAU8360_HW2_CH_MUTE_SFT)
+#define NAU8360_HW2_ZERO_THD_MASK		0xff
+
+/* NAU8360_R9C_HW1_CTL2 (0x9c) */
+#define NAU8360_MUTE_INTRVL_SFT			11
+#define NAU8360_MUTE_INTRVL_MASK		(0x3 << NAU8360_MUTE_INTRVL_SFT)
+#define NAU8360_MUTE_INTRVL_699MS		(0x3 << NAU8360_MUTE_INTRVL_SFT)
+#define NAU8360_MUTE_INTRVL_466MS		(0x2 << NAU8360_MUTE_INTRVL_SFT)
+#define NAU8360_MUTE_INTRVL_233MS		(0x1 << NAU8360_MUTE_INTRVL_SFT)
+#define NAU8360_HW1_CH_MUTE_SFT			8
+#define NAU8360_HW1_CH_MUTE			(0x1 << NAU8360_HW1_CH_MUTE_SFT)
+#define NAU8360_HW1_ZERO_THD_MASK		0xff
+
+/* NAU8360_R9D_PEQ_CTL (0x9d) */
+#define NAU8360_PEQ_BAND_SFT			12
+#define NAU8360_PEQ_BAND_MASK			(0xf << NAU8360_PEQ_BAND_SFT)
+#define NAU8360_HW1_MEM_TEST_SFT		2
+#define NAU8360_HW1_MEM_TEST			(0x1 << NAU8360_HW1_MEM_TEST_SFT)
+#define NAU8360_HW1_MEM_CLEAR_SFT		1
+#define NAU8360_HW1_MEM_CLEAR			(0x1 << NAU8360_HW1_MEM_CLEAR_SFT)
+#define NAU8360_PEQ_STALL			0x1
+
+/* NAU8360_RA4_ANA_REG_0 (0xa4) */
+#define NAU8360_MSEL_SAW_SFT			8
+#define NAU8360_MSEL_SAW_MASK			(0xff << NAU8360_MSEL_SAW_SFT)
+#define NAU8360_FTRIM_PWM_SFT			6
+#define NAU8360_FTRIM_PWM_MASK			(0x3 << NAU8360_MSEL_SAW_SFT)
+#define NAU8360_SEL_STCLK_SFT			5
+#define NAU8360_SEL_STCLK_MASK			(0x1 << NAU8360_SEL_STCLK_SFT)
+#define NAU8360_SEL_STCLK_IVCLK			(0x1 << NAU8360_SEL_STCLK_SFT)
+#define NAU8360_SEL_STCLK_FREERUN		(0x0 << NAU8360_SEL_STCLK_SFT)
+#define NAU8360_NSEL_SAW_MASK			0x1f
+
+/* NAU8360_RA5_ANA_REG_1 (0xa5) */
+#define NAU8360_ICP_SAW_SET_SFT			14
+#define NAU8360_ICP_SAW_SET_MASK		(0x3 << NAU8360_ICP_SAW_SET_SFT)
+#define NAU8360_VSAW_LV_SFT			12
+#define NAU8360_VSAW_LV_MASK			(0x3 << NAU8360_VSAW_LV_SFT)
+#define NAU8360_KVCO_SAW_SFT			10
+#define NAU8360_KVCO_SAW_MASK			(0x3 << NAU8360_KVCO_SAW_SFT)
+#define NAU8360_TRIM_LPF_SFT			8
+#define NAU8360_TRIM_LPF_MASK			(0x3 << NAU8360_TRIM_LPF_SFT)
+#define NAU8360_SAW_PLL_SFT			7
+#define NAU8360_SAW_PLL_MASK			(0x1 << NAU8360_SAW_PLL_SFT)
+#define NAU8360_SAW_PLL_NOR			(0x1 << NAU8360_SAW_PLL_SFT)
+#define NAU8360_SAW_PLL_RST			(0x0 << NAU8360_SAW_PLL_SFT)
+#define NAU8360_CLASSD_SHT_SFT			6
+#define NAU8360_CLASSD_SHT_IN			(0x1 << NAU8360_CLASSD_SHT_SFT)
+#define NAU8360_HVEN_SYNC_SFT			5
+#define NAU8360_HVEN_SYNC_SAW			(0x1 << NAU8360_HVEN_SYNC_SFT)
+#define NAU8360_SYNC_SAW_CLK_SFT		4
+#define NAU8360_SYNC_SAW_CLK_INVT		(0x1 << NAU8360_SYNC_SAW_CLK_SFT)
+#define NAU8360_DEPOP_CAP_SFT			2
+#define NAU8360_DEPOP_CAP_MASK			(0x3 << NAU8360_DEPOP_CAP_SFT)
+#define NAU8360_DEPOP_CAP_48PF			(0x3 << NAU8360_DEPOP_CAP_SFT)
+#define NAU8360_DEPOP_CAP_36PF			(0x2 << NAU8360_DEPOP_CAP_SFT)
+#define NAU8360_DEPOP_CAP_24PF			(0x1 << NAU8360_DEPOP_CAP_SFT)
+#define NAU8360_DEPOP_CAP_12PF			(0x0 << NAU8360_DEPOP_CAP_SFT)
+#define NAU8360_SW_BG_IO_SFT			1
+#define NAU8360_SW_BG_IO_CONN			(0x1 << NAU8360_SW_BG_IO_SFT)
+#define NAU8360_SW_VPTC_IO_EN			0x1
+
+/* NAU8360 VBAT Range Thresholds */
+#define NAU8360_VBAT_MIN		8
+#define NAU8360_VBAT_MID_THRES		13
+#define NAU8360_VBAT_HIGH_THRES		19
+#define NAU8360_VBAT_MAX		24
+
+/* NAU8360_R100_LEFT_BIQ0_COE (0x100)
+ * NAU8360_R200_RIGHT_BIQ0_COE (0x200)
+ */
+#define NAU8360_TOT_BAND_PER_CH 15
+#define NAU8360_TOT_BAND_COE 10
+#define NAU8360_TOT_BAND_COE_RANGE (NAU8360_TOT_BAND_COE + 2)
+#define NAU8360_PEQ_REG_WIDTH (NAU8360_TOT_BAND_COE - 1)
+
+/* DSP stereo core */
+#define NAU8360_DSP_CORE_NUM 2
+#define NAU8360_DSP_ADDR_BYNAME(x) \
+	(strstr((x), "Left") ? NAU8360_RF000_DSP_COMM : NAU8360_RF002_DSP_COMM)
+
+#define NAU8360_I2C_REG_LEN 2
+#define NAU8360_I2C_RXBUF_LEN 4
+#define NAU8360_I2C_TXBUF_LEN 6
+#define NAU8360_CODEC_DAI "nau8360-hifi"
+
+/* clock source */
+enum {
+	NAU8360_CLK_SRC_MCLK,
+	NAU8360_CLK_SRC_PLL,
+	NAU8360_CLK_SRC_ICLK,
+	NAU8360_CLK_SRC_BCLK,
+};
+
+/* clock target */
+enum {
+	NAU8360_CLK_ID_DIG, /* DIG_SYS + DSP + HW */
+	NAU8360_CLK_ID_ANA, /* IV + DAC */
+	NAU8360_CLK_ID_INT, /* HIRC48M standby  */
+};
+
+enum {
+	NAU8360_MCLK_FS_RATIO_250 = 250,
+	NAU8360_MCLK_FS_RATIO_256 = 256,
+	NAU8360_MCLK_FS_RATIO_400 = 400,
+	NAU8360_MCLK_FS_RATIO_500 = 500,
+	NAU8360_MCLK_FS_RATIO_512 = 512,
+};
+
+enum {
+	NAU8360_PEQ_BAND_8  = 8,
+	NAU8360_PEQ_BAND_12 = 12,
+	NAU8360_PEQ_BAND_15 = 15,
+};
+
+#define NAU8360_TDM_MAX_CHAN 8
+#define TDM_SLOT_NONE 255
+
+enum {
+	NAU8360_TDM_DACL,
+	NAU8360_TDM_DACR,
+	NAU8360_TDM_ANCL,
+	NAU8360_TDM_ANCR,
+	NAU8360_TDM_RXN,
+};
+
+enum {
+	NAU8360_TDM_AECL,
+	NAU8360_TDM_AECR,
+	NAU8360_TDM_ISNSL,
+	NAU8360_TDM_ISNSR,
+	NAU8360_TDM_VSNSL,
+	NAU8360_TDM_VSNSR,
+	NAU8360_TDM_TJ,
+	NAU8360_TDM_VBAT,
+	NAU8360_TDM_TXN,
+};
+
+/* PLL Source */
+enum {
+	NAU8360_PLL_MCLK,
+	NAU8360_PLL_BCLK,
+	NAU8360_PLL_INTERNAL,
+};
+
+struct nau8360_pll {
+	int src;
+	int input;
+	int output;
+	int msel;
+	int rsel;
+	int nsel;
+	int xsel;
+};
+
+struct nau8360 {
+	struct device *dev;
+	struct regmap *regmap;
+	struct mutex lock;
+	struct snd_soc_dapm_context *dapm;
+	int sys_clk;
+	int anc_enable;
+	int pbtl_enable;
+	int dac_cur_enable;
+	int kcs_setup_size;
+	struct nau8360_pll pll;
+	u32 tdm_tx_func_slot[NAU8360_TDM_TXN];
+	u32 tdm_rx_func_slot[NAU8360_TDM_RXN];
+	u8 i2c_read_reg[NAU8360_I2C_REG_LEN] ____cacheline_aligned;
+	u8 i2c_read_buf[NAU8360_I2C_RXBUF_LEN] ____cacheline_aligned;
+	u8 i2c_write_buf[NAU8360_I2C_TXBUF_LEN] ____cacheline_aligned;
+	struct work_struct load_fw_work;
+	const char *dsp_firmware[NAU8360_DSP_CORE_NUM];
+	bool load_fw_done;
+};
+
+#endif /* __NAU8360_H__ */
-- 
2.25.1

