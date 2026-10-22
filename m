Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84329606A31A
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Oct 2026 06:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=GdBpkiy/;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JNUC++9V
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F368A60296;
	Thu, 22 Oct 2026 08:14:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F368A60296
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792649655;
	bh=3OxVYR+2GUmqbh3cNH8t3GMZ5kbqlebFWq3ZpcBxx1I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=GdBpkiy/ZQXxHekoWMtoExuEPaUgffQ5s66B5BQC+9leykpdMm7e9LmQ/ZluI6XHO
	 lk/rKFpPe1bn3WEaZeb2+WJR7r8/fKJvqHiprP0wjQcM1mVg1AekmrFWAXoYLC2wp5
	 QBoQE+IJzrWf/YwGtA85uemOm+ZVnMVv5ei6MEBA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ED6C2F80605; Thu, 22 Oct 2026 08:12:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 456F5F80604;
	Thu, 22 Oct 2026 08:12:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ED2B9F80526; Thu, 22 Oct 2026 08:11:57 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010057.outbound.protection.outlook.com
 [40.93.198.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8ACF0F8003A;
	Thu, 22 Oct 2026 08:11:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8ACF0F8003A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=JNUC++9V
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIbXkU4xN0zX/I+e7h19p/r0eJyyqlyPZlxCacpmM8WEABgyQ+AzAh7THAGEJM9AQCXUSwqvny7ms1t950SMFcIYdjPR0P4iQerf80MNGnqY3JCfmGYu0gqVcPncWTAQhDY/8T4AiL/gn5Uv66ZY41DE/kc0+gUhcE60x5tfNuny3Gn6BnhjknOoMmX8DHFvnJ9xMiKC31pr1kD9yacu8JW/NURKyTvzFqAAhT8rqp/QiGaV9fFLJ4r/bMVZvlOH/jBrmskjaE1Iz/ioM2X84Qq8GOZrNaKgynEWqYm14sQrXdXzkr2yZ38ST2HKcThKB8fPIR4QT6njUmkmm2pbXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOVpLSSDc4C3j7+GRueFx7Nf050+MWjqZvPz4EZhpfk=;
 b=YyDQJBC3UNHFReeOBsPp2jzMcTJhuDkHBjwKS+oZYoaIGFT2ENoSC0N3YwnSTOQRSC7cZIJGBHMA1WlRAmq2vG6LyGuuYJ+UI9aqTi+bkWB2MZSpxAPeMFddQrPfFaDIJ9I0IuqPHNYMoX/QErB3WNvx8hz7UD5BRQRJtQfUsBrjPDxhp0FxIFHAtD638Yr6TXtqigsXHjE2PftOemQVURw2bt1LdAXXSeOoOe1DaB3/PrRQ7n6+ZTX6IisTB99+OxkRuiuKI0xWJEJB6rIlOdQRMoOQIYKnxqUR5l05Rbclk3HfaweJ10idSgXI7KSf6rNG430An5rGzzfMRWhwsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOVpLSSDc4C3j7+GRueFx7Nf050+MWjqZvPz4EZhpfk=;
 b=JNUC++9VxT+1Q/1pdFiWin3NtL1f6kWJG/EJ1jaW+snZ8mncdmYvluSs2sZcXMm+eh29R4xCqoFwkwMBg1jljwxAGML1WY+8QwUYCRta2kh+2RmWqht/mQUX/NZvKQRdtUi+jcboAqAMgMMHtbXqVqLSactSg3svU+RPKMZ7If8=
Received: from MN0P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::25)
 by PH8PR12MB6796.namprd12.prod.outlook.com (2603:10b6:510:1c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Thu, 22 Oct
 2026 06:09:28 +0000
Received: from MN7PEPF0000014B.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::50) by MN0P223CA0021.outlook.office365.com
 (2603:10b6:208:52b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 06:09:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN7PEPF0000014B.mail.protection.outlook.com (10.167.254.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 06:09:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 01:09:24 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 01:09:24 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Thu, 22 Oct 2026 01:09:20 -0500
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
Subject: [PATCH V2 08/13] ASoC: amd: acp: set PCI subsystem ID for SOF
 SoundWire machine driver
Date: Thu, 22 Oct 2026 11:32:18 +0530
Message-ID: <20261022060724.1814741-9-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261022060724.1814741-1-Vijendar.Mukunda@amd.com>
References: <20261022060724.1814741-1-Vijendar.Mukunda@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN7PEPF0000014B:EE_|PH8PR12MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: b9466414-e6a8-47b0-0147-08df300307c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|23010399003|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|261021121427099003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	9PAd/lAV0mAYMOXnScOk4Uf2rBGaGHnUVV5o7H+N7iCmze7ZAaYybzaKsT0z/J0EerZH9vjOJep1lTRMDTajZkeBlc6mJ5CkjXeLYIkQGSczaMP43cfH3mFemAiadbN6/rnIEP4JkjvBEdrKeJvFOIkiByNY7Ck2Lc/0WH73jDnnLYp1vQjDzjrbkkzASWvM8DaDldVJX0LrUUb9vy7PrrP2w8dwmlFRDO26TI85xP/WY6fv1XEMDp0tGXjuN71EMx+dIiocALdCo07MILYEXyjdySuwkAwLK+w7To9vfSg+aXflRL5yWkI0U/RWJ7nQ5HOmqWh0n0ah3ahmJsIcKqGECkBRfFNeHBiEE7SjhZdSu68OUGc6gGWJ4mqzpR6XSvuLvCPYqANPKHtFccXzcDmRSpanF847zpC53CPmX0/dxTdYXxf+zuPwP67+FYbtNs5ewzYMSW6w3hRVrHkGZKwh43VbMGKXClnNhTUaROJzcQVFmnHIRriyGlMO9E5yfcfsEKq3oS37tzUhF8joW2tgBHXXP3cYAZJEPhKOjJ98smbVGEh1K8U7+CNbP9kmFk6v+VX8Gpdqous6nuYtNNJ2tKBwtcOl//edTmTieMofInW5eDU1MpS4LJcXc0/Z9bw1QDgbYAr+MlBs9nkcSJEE2hgtC9hOZckdAI9EG8jtpgvEjFjRn7PQYlkPQmO0G39pWerB/Tc40caTg+Bbvw==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(261021121427099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	NTmNX1Ld2P3yrNFZkTQcmGvlEanhoA3fT+tZXLoL7zfSYKd4KcPbtqBIqNle3J42voxIZA0t4wuC4lbHdH0WvtDCsp4V9nuG8EVCVAboR1GVPmKw8tKs+hN3ZWGf/oUs8qimuyKRFFvioMW4Fj0z4tf9IW8HBc6+zAbWO2w3+gnElRMHSUMuJF25oolUNcy8gVKGeV/t58VlAmKlok7xxcwFupHSbYFdY+iz9EBO0BrdVwb3vwqYkSwk9aPn03lvX2ewUpLYMPvsH2NaKowEnB5MERpiZZNS7xphChrM44I4GsT5jQhmKI1GbAd3NKjS+rWMHj4IGl2wrQ0HluqvfPNUqrGt6IpRKEHBdW6AolJ35yWujYHKV8GHv7bXpeTHs/YLzFgVcq0+d2gLhT1lq6Nz+qlIm9NsEh2UyYdWkVbDFF+2vgHtr4Ddlrso/ai3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 06:09:28.2740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b9466414-e6a8-47b0-0147-08df300307c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MN7PEPF0000014B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6796
Message-ID-Hash: R7BRD535ZHJ3FFWPIS5BDUL22K372SFC
X-Message-ID-Hash: R7BRD535ZHJ3FFWPIS5BDUL22K372SFC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/R7BRD535ZHJ3FFWPIS5BDUL22K372SFC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

Call snd_soc_card_set_pci_ssid() when subsystem_id_set is indicated
in the machine params, propagating the PCI subsystem vendor and device
IDs to the ALSA card for correct device identification on ACP
SoundWire platforms.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-sdw-sof-mach.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
index d7d9e24b82930..6ad4588e69061 100644
--- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
@@ -440,6 +440,11 @@ static int mc_probe(struct platform_device *pdev)
 
 	snd_soc_card_set_drvdata(card, ctx);
 
+	if (mach->mach_params.subsystem_id_set)
+		snd_soc_card_set_pci_ssid(card,
+					  mach->mach_params.subsystem_vendor,
+					  mach->mach_params.subsystem_device);
+
 	dmi_check_system(sof_sdw_quirk_table);
 
 	if (quirk_override != -1) {
-- 
2.48.1

