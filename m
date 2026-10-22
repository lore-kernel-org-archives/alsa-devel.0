Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E24606A323
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Oct 2026 06:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=G1ADp7Mj;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ls6POOIz
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6AF966027B;
	Thu, 22 Oct 2026 08:12:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6AF966027B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792649581;
	bh=RJf270KOsZqGtRTGmzFA0PRteiVrVwEYACiVInu4qUg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=G1ADp7MjsG4+8FIcB/fluVePjdJ75ae8HcCWzWzixoRdWxjeb2LxWWZ08TP4FJ0KV
	 snAHOPuVJb92cZ0jRWDkHhrH5aMJxdzoMEXxdoUWXl7t7aXxwgxOMEjm770LJyGwbQ
	 Cvji064xR4m9l05D5dbGt+5hORzPCs3bGPKesbKk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 786E3F80834; Thu, 22 Oct 2026 08:10:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C2498F80622;
	Thu, 22 Oct 2026 08:10:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 30481F8076B; Thu, 22 Oct 2026 08:09:56 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 17D2FF805EE;
	Thu, 22 Oct 2026 08:09:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 17D2FF805EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ls6POOIz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDsfLE2Xd8cmSqDMOg9F+N7mdeb1vAC+iVJA5fcrhDJy6weOnuTvtlJjuOL1aXU3wxMsJ1/YMKxtVl7+x84tHQh+TqwAxbEQkf5faaMgNRZLjOP+mQn6Y0gk1mS9DfddJAbgN/ta8kpsmr7PsqWJi4AuIxgwDafkwO2vC8K0yM9ZTgQX8Gv+y6rFX4xjGH64+wMh/65k2juOHSpgaofS9uHBIos4i9k+9wJkb1ps2f95AqSPe3l1/Npxl6obIRtZ+yQnrW2pBCQBC4164Iu4yM7EskyR99/eqVDI+mx0C71d52mw1NcCfGV5OZtVuGCbT8fLCHmzWq6mQSdnymZK4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jk3uKBqqMdrXg51aR71N7qZGo68EbVXi8zWAHS1yb9w=;
 b=h7DnVZB7vKln4zwJIyEcThh9U5x1jueJxPIr3us0imutPj/2xZmLtj4+ySkO24GcYu9gNFy4t+Khu6A+tyaHBxNVUSGYPc0GgpjNAUQSdCHNAlgHP4yvVZ8wXAtGiKdrKq4BCKomnsZOQNhQaQToUjK3LWNQOO64gBkCCtqvkD0x9SFnSeEKfeXQ80K66NY27+NB2jTmDBHnBnAmX1qgua6mD3iQXj2yh2lxU70kGNQEZwKkL5ukpw0oIkQSr2nf+YwgQdXEIVSHoxtgVgauHJfRkoC2/D7lkKak66peBKTv2JCv4EofnYwVs36eP7s6eZOPaypOwOn5AWNB/jJ6Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jk3uKBqqMdrXg51aR71N7qZGo68EbVXi8zWAHS1yb9w=;
 b=ls6POOIzUmSBmYQV4gx2q6/lDabMZIZXMZI+/BLMZyXcpwGiXvUKlWLX2mp+c3z4VSQ224BUKDCDsNVcPSuKk7GmcorRLbfPLi65IL4hqxnGEt2+he8dWrKgmnFM4z+URtIKo8Wtp1toY1KT7JxbDzW9D6C7bMqPe7mqf2Nzl7U=
Received: from BL1PR13CA0120.namprd13.prod.outlook.com (2603:10b6:208:2b9::35)
 by DS0PR12MB7746.namprd12.prod.outlook.com (2603:10b6:8:135::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 06:09:42 +0000
Received: from MN7PEPF0000014D.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::31) by BL1PR13CA0120.outlook.office365.com
 (2603:10b6:208:2b9::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 06:09:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN7PEPF0000014D.mail.protection.outlook.com (10.167.254.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 06:09:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 01:09:39 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 01:09:39 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Thu, 22 Oct 2026 01:09:34 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <pierre-louis.bossart@linux.dev>,
	<yung-chuan.liao@linux.intel.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<Syed.SabaKareem@amd.com>, <Mario.Limonciello@amd.com>,
	<Richard.Gong@amd.com>, <Vijendar.Mukunda@amd.com>, <Poojitha.N@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sound-open-firmware@alsa-project.org>
Subject: [PATCH V2 11/13] ASoC: SOF: amd: add alt_machines for ACP7.F SOF
 SoundWire
Date: Thu, 22 Oct 2026 11:32:21 +0530
Message-ID: <20261022060724.1814741-12-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261022060724.1814741-1-Vijendar.Mukunda@amd.com>
References: <20261022060724.1814741-1-Vijendar.Mukunda@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN7PEPF0000014D:EE_|DS0PR12MB7746:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e94b37-6803-4f4b-4226-08df30030fc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|82310400026|36860700016|56012099006|11063799006|261009223027099003|18002099003|10067099003|22082099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: 
	DL0kZtWvcseX6uOSA/tw+G/B5m/N2CxpfepaoNYldJbq17+Cx7SWX9o45TQwCmCcuFaTzRgWfMCNejKatM5lk7MFuUwhuLsikm8JjxE5Eb65hiq9UCUz2srpZmUAxJ45WJ4+Pwv+QZLiwl7ujcs2YkHqVuBDhlYyLIFrbj59oDHzqOToWshhC3c0fqLFX9w8GWxtH9noI5+f9ht6IYZKOLjEKyJmeI/8L1ENY945G0u32+SeNqttgFvuPc/pxRhXDjcLSz/uN2hco3HYvTNo1k31kHwThS2VamwMvQdk+yKgEPTdB+hdZFhWA81w5r8Hztv10VRcSLeb2sJNWpgEKtfjo9nM65W7Y6qfJj8f03A3wM51jCevP+kARJtURwsbF756CC7ADTu05cfScm1dn2TCV+s66P4U/6Pt82n+p9UYebqzPtPVnxMChRtzH8WmUSrg8f8Mbm/WiuUqyfUn/9ETHrS2qdB5vsbfoWAHdnKWd9fh5vZ6rHaMBEIPeuyl8QyKK0IwTes8Z151Sl+YGa8FpgpsTwLwTz08XAsLAWfjbPZv9+WE0boMv6EYs4LNzb1muv7NanKzYiY1owxg/vmGHTymCXGN6pkicMrqKOgU78agkWYYD0zEIplDlIV9C3NbwXduO1zNdBuQSXUpC31W45Wuv2QcuAubbnWkoKZf9LzNPHs+naIAK8IDJrS/9VHq4sED79zfvL4AOSgu3g==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(18002099003)(10067099003)(22082099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	KMj4b+0tqyGTaEWx0U1V6LnsYm88P+Smo6/DUm5siR/7KUYRCPwKCVpq1AegyiAoSgKRwj/B52k7Z86Nn3bkkStIa9XwznbsoK6GL3aFg0gTa1F0KMOphIFW5DjX8jN+jdfvtLllUz8PJ7P8n13DCALGC/ifGq7OQSY1YbN3+Fqnx862ORWCUoWLPBQL+HOo855CeV30YHM5E5/Nwxql4wUAscNrIRarWF2zOTaUeNCoPUWV2T4tU16PXoInM2P6XZEiKnvWVwSOwcRPLD3ab8ZKIbn+J602e2WWVGXGYpnoMICUrAx07obFB8LjyZgJ6FILJ8Dk7//btnejqG1Jj1rds2lBanRi1KoFjDm1wGEw5G0h5X8m4YSEe+P8SF4F0zUQTrkgx+xHFJ9WWbwTXlZpu5tOnrAi8PW1Q4hvZjfBZlfo1NRFyUYDDuipp3oE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 06:09:41.7375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 03e94b37-6803-4f4b-4226-08df30030fc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MN7PEPF0000014D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7746
Message-ID-Hash: RDIL65TYWKDN77MRGQBKIFTMGPUQO6IO
X-Message-ID-Hash: RDIL65TYWKDN77MRGQBKIFTMGPUQO6IO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RDIL65TYWKDN77MRGQBKIFTMGPUQO6IO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

Register snd_soc_acpi_amd_acp7f_sof_sdw_machines as alt_machines in
the ACP7.F SOF device descriptor so that the SOF core selects the
SoundWire machine driver when ADR devices are detected on ACP7.F
platforms.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/pci-acp7x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/amd/pci-acp7x.c b/sound/soc/sof/amd/pci-acp7x.c
index 5a21ab8ebb4b9..2999dc6d72a63 100644
--- a/sound/soc/sof/amd/pci-acp7x.c
+++ b/sound/soc/sof/amd/pci-acp7x.c
@@ -89,6 +89,7 @@ static const struct sof_amd_acp_desc acp7f_chip_info = {
 
 static const struct sof_dev_desc acp7f_desc = {
 	.machines		= snd_soc_acpi_amd_acp7f_sof_machines,
+	.alt_machines		= snd_soc_acpi_amd_acp7f_sof_sdw_machines,
 	.resindex_lpe_base	= 0,
 	.resindex_pcicfg_base	= -1,
 	.resindex_imr_base	= -1,
-- 
2.48.1

