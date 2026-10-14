Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0328CC6B1A
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2026 10:20:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B3C946038F;
	Wed, 14 Oct 2026 12:20:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B3C946038F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791973239;
	bh=Xm5bTDHFaz8S2D9OupThCi4LJN7wUFRyC++OYCdqSDU=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=L0q6lBuyi5xp1LkxD/Ej6grksxdgWznBdJdVs63fgtuqf0oqx68D45Y0g8+oNoT5A
	 tKJ+ugmDys2O1f/VBwMbaPahQv6RszFB6X/QF0BpONsF8oEpg/2GTJET9W/EHRR9bB
	 mUgrtNmDzxsEArEs2cuEmiwF5H2Ts/eiD4kQ8hmE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 15803F80637; Wed, 14 Oct 2026 12:19:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0BC97F80612;
	Wed, 14 Oct 2026 12:19:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6BC67F80495; Wed, 14 Oct 2026 12:19:31 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.27
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791973167;
	b=V+LpNRJ+zAiJ6QIsbkxfK+b0i0OI5gtjZ4DhtjcqhUDHiuWmfL6CFSnTdMOT8EXuifKU
	 blgl9oxm2SWaIUHuYey98uShGBc0FQpRGXNcYdAn1Jm93rUG3zMVosSYefRYqmkbtBn9C
	 A7603IxNkPdziQWHfw9ej253r1lZyhKKsSPsrTMGOYKDcL76cETJGc94fMu5+Gyw+vGaf
	 6K0ctKXNdDxuXc1hi0j0IYwLDAVPTNkf3qhVfC10NYAkmvK0PF4frv9OMDJxnFYq9B8el
	 WCxvJfybHHSPASlIam569H/rmS/+hhlhcNO3R+LYTKHhtxG5Pxr/oMmuG55rHG1XxfA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791973167;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Xm5bTDHFaz8S2D9OupThCi4LJN7wUFRyC++OYCdqSDU=;
	b=QOm0z8q0Wjfu0DYKGF6P5KXE+mMiNo3IZi4+UXhoPpi6AcetKKA5XMnB2Bd48e5IdxcP
	 JIbiLJx0WUyWrv8GnL8m1fsgwONH1ARMmYiOWIBLum4EUb4VS1LbhUT2+A+7ih8AE1mxB
	 FhSWmnajrSf8oRb6UcfeSsEilT58VkhbXjj/OencIszabIORxdfhXzKBft7YsR1hLXnLY
	 wTWWUDcr4WvCc/pZuvzSbwv7A6Jf+Q81vORDuDa+7/nmQCBS1DJB1tA9DM2ekrEpqjFc3
	 i/5xZ3cR4wOgMeSx7fZz3K7PgkVncuqCduYmjkCdK6c4OlQwU0bQzCyE9tNsQ54YM/g==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=sCYdn4Sv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.27
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011027.outbound.protection.outlook.com [52.101.52.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 396F9F80038;
	Wed, 14 Oct 2026 12:19:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 396F9F80038
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=sCYdn4Sv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4eObiL85BQzrOVXMD9PPXQ6+hWlKpG883axS/cM8Lqp8jzceG1dFlZ6GAojCmMRn3LienvZ/8QUorJZ1J47MTQ9O9skgpJhFFEg1XIb15Ni1OkYsSJF5rYSrcWZTmc1dyxE8iwhjQLZW+P9pEuDwy7TXjBOUOYCN0gvTNTSx1UjxJmAYAu757/apyvaX5vZ6oXM871O2oN/UBtDNnvlO9vhb7nrmdoFsIllwWQgYV6nI7mxwcDmt6oVrRyx60P5eSmt6AMW2ldyCnKbxjurz4dtiWrmJTcgTOU4ftFxWjpG/Si4UzWsPholX2gzqJP0IYNTN41I5C/lYB/C6/fX2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfnwLdjlUE1lTHCDy6NrPBvm9pfouD6Ti+IjscdNhgc=;
 b=RlPRtRw2pU43EXpYX8U73C2gtusvpVl0GV3lNAUMlYTkcWUaMQwVqevROCFN955Mb+NSiykm3XceZgQJwMjXQ+wYmsZPrBMgZUX0QQZ6ErKJPqCY5+nQEAe4f6EhLvbZE9PcXlXw1EUARP+cm4k80EwTD+rzzqV8zlSPdOBGAkdWm9PyiFMkZJnYw2E7hEEbDK+fJ26PJsNg19BYhz2PNPCF395/+O5oIpMzOR8y3aYwOVUfK1m80kyOcQa2YZKrzLS0uoVS+uiW5BTKZM2tWCDPhghxtWYHGgegwUOLR06+bO3ZK9SV1VBGXMvJhmiqnuiwF/ObYtes7WpE8I70zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfnwLdjlUE1lTHCDy6NrPBvm9pfouD6Ti+IjscdNhgc=;
 b=sCYdn4SvUnQiudrgmyLRUnRFog/7lxPGJkRP2upNIC9yZrGreKsLnOCKpADWuG7gpIjPKq7It3Qcb3N6rw4/eTt76/po7vNiOJ2K7+DH81kOV8Mb13I3L6o1yiQ+/sIJgL8MWFGeiSEc0bGEBu7a91x3Zz4L9r4WkG3r0tDZFWs=
Received: from CYZPR10CA0013.namprd10.prod.outlook.com (2603:10b6:930:8a::21)
 by DS3PR12MB999215.namprd12.prod.outlook.com (2603:10b6:8:38f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 10:19:19 +0000
Received: from CY4PEPF000392DC.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::28) by CYZPR10CA0013.outlook.office365.com
 (2603:10b6:930:8a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 14 Oct 2026 10:19:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF000392DC.mail.protection.outlook.com (10.167.247.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 10:19:18 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 05:19:11 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 05:19:11 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Wed, 14 Oct 2026 05:19:07 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <yung-chuan.liao@linux.intel.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<Vijendar.Mukunda@amd.com>, <Poojitha.N@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sound-open-firmware@alsa-project.org>
Subject: [PATCH 00/13] ASoC: amd: acp: ACP7.B/7.F SoundWire machine driver
 support
Date: Wed, 14 Oct 2026 15:46:19 +0530
Message-ID: <20261014101817.1240200-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DC:EE_|DS3PR12MB999215:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b99300c-d688-49d3-db76-08df29dc9b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|56012099006|261009223027099003|11063799006|10067099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: 
	dEYwZKRfldi+5qTCQ3sJsmZ7QVfORUCUra4OimxJPssVVJJvz1HNk1zLr3vR6VK9pe4wAe91PkgLQU4qlr7KJVa/mOGQbjM35HYsDHrxl2mOdhbabbWsD5MFq6MJcWuKos0v+b1SrlZayOOhodRQ2bx7AcwHeTGgHqfbslHbZat676NJqJDtdrCF8ppj95bpTIh5eY1O46Trf1GeYEMeT3AcNrQ16xJtxJSDFc3kH4eABMyvIeZLug3+BIZKvSYx80H3PUFVnzzpoL8t1nZl/3vqdsY6X1LNHMzqz579KSpkxLYv+EOkd9LzK5rI00LWuXYSU5DVw0bsJjiXKvqalsl9kXHx21d9AFW3R5Ob/GXUWhBVz7bvrmwTSHhXYycsKty1tSQIU0gOOmslPr3dqHnSqiDdiH6tn9alNJ49sXNBrp8skB2+JdmRw8bjE5UOtw04NRJxan5hwCWRMiHbPnI7tqMesGH5dr5vd2hAzfiH1nbmysaBN193rYYg9MRXTj5o/IJd3dL/GQjp5tMIMltQYR2fsjWeH99k82j/lBqN/52/ooJTl1/eaA/k/u9m20zQboyboLs3tNqc+c/A3Ys64TMsUeFwvfkx0YgPmA0O5NutpGRsSlGf4N0KuU6PA1waAKUXq6/X+i11w5VYRQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(261009223027099003)(11063799006)(10067099003)(18002099003)(6133799003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	x3xDtqBYbxcESjSRSFEu1SRYpphAbYCWIfXm1SCPwQ+L8/jKGyBpLmE0g5EDkOPS8slfhM4OcXDmW7/UbyAy/lRfJwmK1U3AzKrKGvQs/s3wqerPTqw+fFXYgN99//z0Awm7biHeUb8VQy8Oe2SpHLyUBwqdlHzbeUZDdew6FYz3DzVpnJFYubHqteiEPGNglWWiiCsCTRWodMXyDn6AtRCpIc14C6sdO8k9A5+pM0b5vTvFfWVqNW0B5bFsjIDUlv+hVZvTIY7Xf77guKuVRY+qkwU+pdcrrgs1xVSON5uvD/MWR1RGi8CibxAfzW8A2pYedD0GMsDvvGuB4geKGXAg/1hCpcKGbGRHvbE4lAAawTtBDdgcrnL2AS6NBLY+bS8buMiiyTgsCL29SzWLwMiVD1bY3kdNe4bpyiDybk4rGBB/K6yfJ++5ItC82xKD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 10:19:18.4726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 5b99300c-d688-49d3-db76-08df29dc9b56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CY4PEPF000392DC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999215
Message-ID-Hash: BUGSQHA5RMEH6LEPNI22YTA4YHPTR5NH
X-Message-ID-Hash: BUGSQHA5RMEH6LEPNI22YTA4YHPTR5NH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BUGSQHA5RMEH6LEPNI22YTA4YHPTR5NH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This series extends the AMD ACP SoundWire machine driver to support
ACP7.B and ACP7.F platforms, adds ACPI machine tables for SoundWire
codec configurations, and fixes several issues in the SOF SoundWire
machine driver.

Patches 1-2 add the infrastructure for ACP7.B/7.F SoundWire support.
Patch 1 adds PCI revision constants and the ACP7X_SDW_MAX_LINKS (4)
constant to soc_amd_sdw_common.h, and switches mc_probe() to set
max_sdw_links based on PCI revision. Patch 2 adds the get_acp7x_cpu_pin_id()
function and hooks it into create_sdw_dailink() for ACP7.B/7.F alongside
the existing ACP63 and ACP70 paths.

Patches 3-7 address DMIC DAI link selection and components string
handling for ACP7.B/7.F platforms. Patch 3 fixes the PDM quirk
evaluation order: ASOC_SDW_ACP_DMIC1 was checked before dmi_check_system()
and quirk_override were applied, making the fallback dead code. It also
corrects the condition to use else if, since only one PDM controller
can be active at a time. Patch 4 adds ASOC_SDW_ACP_DMIC1 to log_quirks()
for boot-time diagnostics. Patch 5 extends the DMIC DAI link enable
condition to also check amd_ctx->pdm_sel so that ACPI-selected PDM
controllers on ACP7.B/7.F are handled without requiring a DMI quirk.
Patch 6 moves the ignore_internal_dmic gate to the DMIC enable condition,
removing dead code and demoting a spurious dev_warn to dev_dbg. Patch 7
appends the DMIC components string to card->components in mc_probe()
when a DMIC link will be registered, mirroring the condition used in
sof_card_dai_links_create().

Patch 8 propagates the PCI subsystem vendor and device IDs to the ALSA
card via snd_soc_card_set_pci_ssid() for correct device identification.

Patch 9 fixes a pre-existing typo: the MODULE_AUTHOR macro call was
missing the closing '>' in the email address.

Patches 10-13 add ACPI machine tables and wire them into the SOF
descriptors. Patch 10 introduces amd-acp7x-acpi-match.c with four
ACP7.F SoundWire machine entries covering RT721+RT1320 (L0+L3),
RT721+RT1320 (L0+L1), standalone RT721, and standalone RT722. Patch 11
registers the ACP7.F SoundWire table as alt_machines in the ACP7.F SOF
descriptor. Patch 12 adds a single ACP7.B entry for RT721 (L0) + RT1320
(L3). Patch 13 registers the ACP7.B SoundWire table as alt_machines in
the ACP7.B SOF descriptor.

This patch series has dependency on the following SOF patch series:
https://lore.kernel.org/alsa-devel/20261014100902.1215212-1-Vijendar.Mukunda@amd.com/T/#t

Vijendar Mukunda (13):
  ASoC: amd: acp: add ACP7.B/7.F SoundWire link count for machine driver
  ASoC: amd: acp: add ACP7.B/7.F SoundWire DAI link support
  ASoC: amd: acp: fix PDM1 quirk and PDM controller selection for
    ACP7.B/7.F
  ASoC: amd: acp: log ASOC_SDW_ACP_DMIC1 quirk in SOF SoundWire machine
    driver
  ASoC: amd: acp7x: enable DMIC DAI link based on PDM controller
    selection
  ASoC: amd: acp: move ignore_internal_dmic gate to DMIC enable
    condition
  ASoC: amd: acp: add DMIC components string for SOF SoundWire machine
    driver
  ASoC: amd: acp: set PCI subsystem ID for SOF SoundWire machine driver
  ASoC: amd: acp: fix MODULE_AUTHOR missing closing angle bracket
  ASoC: amd: acp: add ACPI machine tables for ACP7.F SoundWire
  ASoC: SOF: amd: add alt_machines for ACP7.F SOF SoundWire
  ASoC: amd: acp: add SoundWire machine table for ACP7.B platform
  ASoC: SOF: amd: register SoundWire alt_machines for ACP7.B

 sound/soc/amd/acp/Makefile               |   2 +-
 sound/soc/amd/acp/acp-sdw-mach-common.c  |  36 +++++
 sound/soc/amd/acp/acp-sdw-sof-mach.c     | 101 ++++++++++--
 sound/soc/amd/acp/amd-acp7x-acpi-match.c | 198 +++++++++++++++++++++++
 sound/soc/amd/acp/soc_amd_sdw_common.h   |  32 ++++
 sound/soc/amd/mach-config.h              |   2 +
 sound/soc/sof/amd/pci-acp7x.c            |   2 +
 7 files changed, 360 insertions(+), 13 deletions(-)
 create mode 100644 sound/soc/amd/acp/amd-acp7x-acpi-match.c

-- 
2.48.1
