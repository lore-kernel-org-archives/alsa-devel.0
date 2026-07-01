Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89193C43458
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2026 09:59:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 00E0A60233;
	Wed,  1 Jul 2026 11:59:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 00E0A60233
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782899963;
	bh=nSUKwpv0U4V0EoNjwBrmFwPHcyT3p1zBl+oEsdtbEdU=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=KhTRvy9SXkDcnMc8o3+Hz/7X4PGrZ7rQUMtHSYBxflcwWWH9iIY+Gb77cEYuoUdpi
	 qEftykKW4uQAG8QZsdTNC6WtnZDJULvkrTUAtjour2S1cxUVIcchjhlu2AOXokKKsI
	 VKTjUvKoxYcnqvmJ2aUfPqHjn5zBDx6pWVamjREE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CEC63F8053D; Wed,  1 Jul 2026 11:58:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 93032F805F8;
	Wed,  1 Jul 2026 11:58:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 361DEF8051F; Wed,  1 Jul 2026 11:58:40 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.6
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1782899919;
	b=OVIfbMGAyiw+hPyM6FIOnnHcpu9wU1tJwTCTzlfPK50aD3Dj6zEkBaDtTpsZA6is6c25
	 kuDfwqsBIHBXIdYhRCWuO2FuxtCkFjnVz6jS+YUZwK2V1c4KKCgjczDtICEZXpeTXuM+9
	 pJc1/r5xb1i23yjsdpdHV6PxFZrsRsqD5Sj/VlqpFu1pdQyIhlaSNriNCIWw1l++YiEzj
	 IINj2Hc+B3d8QyrRzCBFoMeHymtAdmfO+Y2g39qhNnyA26zjfp8B/QiMI989QzQpFMlUA
	 uGoVX+wooKf/K9JBEF1j01ZRmfSZkIRf27WrzRP1Hpz9soTkRSXZkfug2aFYTBPODyg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782899919;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=nSUKwpv0U4V0EoNjwBrmFwPHcyT3p1zBl+oEsdtbEdU=;
	b=bCf+Ql7/irXF3VZteV0tqNFNMmF/oHRJ1eoxOEmsFqFf+oKaNl58NZe5DqWDYxMA9LTB
	 /1nfGcRt2Q7JXF7rZDAeXwinSaxppXqh91nj/ygjkLy32lUGN2//GocafAQE9xApAdEi8
	 hIwU1d+hIdK5oIyP1rf+cIYqAqBEi/ctjuBLpSmsP2PvsKZhrbGi5+ESRoZZBiWxvQQpb
	 /OP5ZJ3ddo0AzjRXbKbYMxa9lSAvU65+iPFn5d8zyKVHaeziwtL7TzdJzXChfgsJvkCwd
	 fwnWaNLnozGZdpPotZEjE38Z/N8t/TYsTkcI9bCxTUt3UPkabCCA+HZ1+zJ9Q9wrwMQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=dpzJaWal;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.6
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AC7F2F80152;
	Wed,  1 Jul 2026 11:58:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC7F2F80152
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=dpzJaWal
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHe00FCGdHqwHAi51SKlrcfgakn4Fralj7ODlL6l/0+XUmVw+Bg6v7IteptLAz0ub0OvzDAdEQRjMIo9YiRtMdQ6PfG+eUL0GqKsd0F2W+hIthT8q1OolMAm5PoLmolSUqJ2+PAVdOTmF5H4WFy+46ANs0XBIcQlxmHaMOgSvCV4FyuDLv+KU/n7oQa/kJLrSAbUtUSno/bminS048M+Ss1w1lTJx3lqbSx6FuJGKgA0Vd+CJLI5HwuFoyivynFcHjQSxHzUvf/xbv534mKTfsT+Ez3kM8H5lXbrL8D4036jUc2sFQf70QfWJHt371UrfNu30F6+B3lk5c3dIF6wJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6FiZ8zfe2wVGgB7t1Gr3Eq8jdwVDVO9p0Bn/Oxj++A=;
 b=C+XjfN+b2Ic4L6+9PptC4okzF6RWhbhqZOkJg4hqhYv1JNgI6F/k1D6Hk8nb0OWOdPP8EO6fhmY6KjRg893nR2pzlrU+MT9GLnl5M0VZ290LYTiGHSqtEQBRR7jx19VBtyldpIwzQQykVkzyopsQWo+UCM8bXNcIlFIEbs5RYgf2myT9oX9iJEvo52XXNlRjy72840eeXwYyNHjbZ6UoSTFeO4bDGpDVrs8+QRVLxy3yCIeZ6LoXMv6nfuh4f009V+FaDWjPslktgo6ksqdz/eyfodm5cvjhENonwuG0g7SJ3AhdZWbuabIPawS1l38rxsXVVBzpUh5DteCHtW8I1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6FiZ8zfe2wVGgB7t1Gr3Eq8jdwVDVO9p0Bn/Oxj++A=;
 b=dpzJaWal7InWRWV75+L4rcMZ9KSvmGW3SVyWDonzXn6LwVkqYNSSvxuDmmNLUopSF7E2gJrVK39jPbWbRFwOr+DDatntWa6eJXxGIU5a4JqOolV+uHtZ7cGDIhZcytjnSpPpwNoC7su1mIQsV6P/aawPDi6EZX9eD8JGsRatYts=
Received: from PH5P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::6)
 by LV3PR12MB9402.namprd12.prod.outlook.com (2603:10b6:408:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 09:58:28 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:510:34b:cafe::77) by PH5P222CA0006.outlook.office365.com
 (2603:10b6:510:34b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 09:58:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 09:58:27 +0000
Received: from vijendar-linux.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 04:58:23 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<perex@perex.cz>, <tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<mario.limonciello@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 00/16] ASoC: SOF: amd: add support for ACP7.B/7.F platforms
Date: Wed, 1 Jul 2026 15:25:01 +0530
Message-ID: <20260701095759.1012929-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|LV3PR12MB9402:EE_
X-MS-Office365-Filtering-Correlation-Id: 9787dbc6-1ee5-4b7c-8565-08ded7574c6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|7416014|376014|1800799024|11063799006|56012099006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	QLgZK0rZFl8ynrQybty0/di3S/7wv84kSPCPvh88aFwAYQa4bLsnhiwt3B9bP41hIYzaQ9p1J8cS03N6jV/PKAavLJwtPP3V+oaqebPzwTlo/6iM1ExGcsDYoQ1xpf5sAckYj8zT67bM3gakYFUQsv92Zau11m4IzmGL5EEF9aokCZXABXmVBnbLguYJdSuW6qQ2EaR6e7kuUlBso/q+NbPX3S1xBWa9lsiJ5Nid0446vpvBte4CQqiYjUIVpwqTzrvKvuToQINGvPmwvOSkYbvtZtPOPIlvao6l9X6HxywYfULHY45Qy/PbTyTrO3i4hHpI4Kc8GgAZz4r1TZyecUeKG1zeNNc55xS8zmWLPw4VibGcEmf2jcigWdMlIIqUHkJnhj1syWW5E+TD68xft0psAb9MYkGKRKOYFmQi6QI8Nkca0YOxZIkBJ/hheqO818NWMYezXCd+9oDYpLuhqC7d6eptGN3IQjfl2WVzt5XA9sLz7j5BD2AQXV5eOovBlbC1su8SWw6L2IyLGNul9SfxfLp1Ihp6LyvmDpekBffM0IA12jGqfLDXq5ioIglsVc6BDnaeHKFf9bVF1NB880OanZvLsDtV2m5AD92d7/2ldBzDZuC3N/twWMvlUFqIxcLiEB3ZxZXUJ2FgdPGelt4MnABAEUoBDOciagKxWnTiYPkUJztkuCr1mxwU+l2/u0Tdprw7Cn7AOEN5w8fSNA==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(7416014)(376014)(1800799024)(11063799006)(56012099006)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	zHiylWyCl/+ySxY4TOsg1ZGBAVinCS6E+u+JDLsbAxWs7OpRRGbHEkqa/q2qkFSi+IJMd2o4jHbBHm0tF2lFW3uujxEQV1Afp17aXtn5Ij80NoMam8yTjH7C/16YVgtEjrSVysGzamz4EZF+mruZyJ1BhJiqxedX1ptXgGkVMGbCctdHABXqx4trc6boyVPjT/WIqUt5nEkqrCGP8Tch7LLcdYAx1OptzbZ2jMJn6BQvCLSwX+pFvH5ppZyIQJoSVzeYrAJW6pv6axCPW+HAS9Oa6DZ8ksZqTb5AULQOG4/HOOaBBWNJ6j3sEpo016QrHZ7uGMr4cf5Owp31GrZu8GAL9fC2s4nTmSn592I/tjrGTL3N6rCYdIR5yt7nUg/PPHrZdEmovRYgJkk1wqiRiMyNFYsUYZm6o944D3A4JmoXW6LDqMuNlUMg4sfPV49d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 09:58:27.7171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 9787dbc6-1ee5-4b7c-8565-08ded7574c6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9402
Message-ID-Hash: E2IJRAHR5DO5RKK5SPX4K2RTSETOI6ZB
X-Message-ID-Hash: E2IJRAHR5DO5RKK5SPX4K2RTSETOI6ZB
X-MailFrom: Vijendar.Mukunda@amd.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/E2IJRAHR5DO5RKK5SPX4K2RTSETOI6ZB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This patch series adds Sound Open Firmware (SOF) enablement for AMD
ACP7.B/ACP7.F platforms by introducing a dedicated ACP7x PCI driver/ops
layer built on the existing ACP SOF infrastructure, plus required IPC3
topology/token extensions for ACP7x I2S/TDM.

Changes:
	- Add new ACP7x PCI driver + DSP ops, including suspend/resume and
	  IRQ handling paths.
	- Extend AMD ACP firmware loading logic for signed images and
	  SRAM-based data loading on ACP7x.
	- Introduce a new SOF DAI type for AMD I2S/TDM and extend IPC3
	  topology tokens to carry an ACP TDM/I2S format field.

Link: https://github.com/thesofproject/linux/pull/5813

Vijendar Mukunda (16):
  ASoC: amd: acp: add ACPI machine table for ACP7.B/7.F SOF driver
  ASoC: SOF: amd: add base platform support for ACP7.B/7.F
  ASoC: SOF: amd: mask ACP7x PGFSM status poll
  ASoC: SOF: amd: refactor SW1 I2S error reason clear in acp_irq_handler
  ASoC: SOF: amd: add ACP7x probe and remove
  ASoC: SOF: amd: add ACP7x IRQ handler for DSP IPC
  ASoC: SOF: amd: extend signed firmware pre-run for ACP7x
  ASoC: SOF: amd: require full ACP header for ACP7 signed firmware
  ASoC: SOF: amd: validate SizeFWSigned before signed FW length on ACP7x
  ASoC: SOF: amd: add post-firmware-run delay for ACP7x
  ASoC: SOF: amd: extend configure_and_run_sha_dma for ACPI signed FW
    flag
  ASoC: SOF: amd: wire signed firmware load callback for ACP7x via ACPI
  ASoC: SOF: amd: load ACP7.B/7.F signed data firmware to SRAM
  ASoC: SOF: amd: add ACP I2S format field and topology token
  ASoC: SOF: amd: add ACP7x I2S DAI type and topology support
  ASoC: SOF: amd: add system and runtime PM ops for ACP7x

 include/sound/sof/dai-amd.h        |   1 +
 include/sound/sof/dai.h            |   2 +
 include/uapi/sound/sof/tokens.h    |   1 +
 sound/soc/amd/acp-config.c         |  12 ++
 sound/soc/amd/mach-config.h        |   1 +
 sound/soc/sof/amd/Kconfig          |  10 ++
 sound/soc/sof/amd/Makefile         |   2 +
 sound/soc/sof/amd/acp-dsp-offset.h |  17 ++
 sound/soc/sof/amd/acp-ipc.c        |  15 +-
 sound/soc/sof/amd/acp-loader.c     |  37 +++-
 sound/soc/sof/amd/acp.c            | 267 ++++++++++++++++++++++++++++-
 sound/soc/sof/amd/acp.h            |  20 +++
 sound/soc/sof/amd/acp7x.c          | 185 ++++++++++++++++++++
 sound/soc/sof/amd/pci-acp7x.c      | 116 +++++++++++++
 sound/soc/sof/ipc3-pcm.c           |   6 +
 sound/soc/sof/ipc3-topology.c      |  39 ++++-
 sound/soc/sof/topology.c           |   3 +-
 17 files changed, 720 insertions(+), 14 deletions(-)
 create mode 100644 sound/soc/sof/amd/acp7x.c
 create mode 100644 sound/soc/sof/amd/pci-acp7x.c

-- 
2.45.2

