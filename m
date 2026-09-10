Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86085C79FB9
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:28:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5D8E7601F3;
	Thu, 10 Sep 2026 15:28:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5D8E7601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789046902;
	bh=1opZJ/yjEYNE5y5eys04lmKQQJGh4VFdp8aMlNyhTDQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=r+NF6Nyy2HBCQUeA0d4+xkkb1LWKMR04eR4GU5qD1k8GnrAhs5OglKMwtndb6g+zm
	 LSFYTCXOucYCVhEuZuEb56gLymtfB0P5Ox6mdHMihrSbHQYX3LpVhRINlDwlu3WE6Y
	 lCvbT4JqMJsFJupAObCX4QwETZXEMrySoiGQy6iI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0FB82F808C8; Thu, 10 Sep 2026 15:24:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 41330F8087C;
	Thu, 10 Sep 2026 15:24:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D597CF806EF; Thu, 10 Sep 2026 15:24:46 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.52
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789046684;
	b=ngNXuGCErOsVBfg91TJlDLbpfvrCOxysDAOOONUQdwEBzhU//QOnJ2+LHuoxBmPJTZAk
	 2gIgzfZPetvm4UN8EKZUZgK6RGJHKKO6UEJSJKETSv9SlvVOQX7pHyVPWDCj9HPU0n/Ee
	 ysxiElz0N4zxKbBMUA6O+1JzAaQNuA5BR8pyzHeTT+6jdq7GAshuVIXfe/j8dyVfFf9Hw
	 tN4rzO4zJg8uOeibwZNz7qLRjJAAOnijhgsA9uE/SLhAotXm2od0Un8YdSgZf3t5XbNPh
	 VMkT0GzY8OURkRMwqz01nYA6/UfRw0hIOQx9lAfJwGP2zxAelQmywwm7nHej4zWBp5A==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789046684;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=1opZJ/yjEYNE5y5eys04lmKQQJGh4VFdp8aMlNyhTDQ=;
	b=BCDBV0PAg2mYxvTS9r1FDHPpVmi+9JRstQv4W6/k0c73tfBLrW6BDT8Frr4DxDswXYxQ
	 i8OSIC9+GTfvul+zVKx8wKjukaSW2dpGxCfhMHcZhCDvuAYoIG/isjfTU2Veexfd9I7xq
	 5u56OSuTz2qKx+/FeSQXy5FgcTYRm9q7g2HO7cnbNhGpn0n4YqxIW19ebWNfca6Abc0Le
	 OtsTFAcWCs9IG/5bilFJBRm+jl06h/gkFqVx/Z4LUbqf/NFwE6IyVMhkvIdnn94uBNbhC
	 FOGzWCp9JQQIiljcAbgvFEbbSW6n5XoiLVwWt51BZGNXRmf2ZYF+VNJCRXiHBe7N15A==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=QvwK20FZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.52
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012052.outbound.protection.outlook.com [52.101.53.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 198C2F806EF;
	Thu, 10 Sep 2026 15:24:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 198C2F806EF
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=QvwK20FZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fv/Zh6F3UFnVYo2au8MATKnbZ/gKE6AZKv/Jdr7lz/VkeqNqS9XqC4JG8XRTXQXPgcfoJWCDuk/F6OhctSH6J7O9m8EeAVmiig24k+iemSPoF9ZYxCWozKa82NIUIhrSVtX4ELxi3d0UDN6dwn6KuMk89aHChO0W3SllkwDR8Qe6BUXftv05jlg1R6OihD0F6htELgFDuj9S28V2T4L0+cnMGjLunl0+RWTCfRfMIgPRoOFo++/GxyhP2XJIi8HKtnmZWbUICiE52fx/TAkDkXzuaQwZpmq7uKxtgzGLe82Jc013lAeQHWBd04yEMjQaJSdx4mnQKn2qcYxvENckLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgVlPsthvwnyWUtwx4gOuU8oMMCiC162pioCSqOutCY=;
 b=I4BVmp4kZSmTvrIrEFv3OgyFvAOMXuH+RRUfBwWo8eNSH2KuQhvVccC1CsS04MPVlOgarXURom+dGbd39aziDWCGCMDSox8XlCwg3KkHJQ4w3lXz0ELZLkeV1UP4Tmc4H7VoW9h7zsO812cXAuBjGeTvZ6KPjJkla106bwGwCuRVFJ0L5fKkFpZs4EJ7wk4WIqT7FLfm0DpiDE0vxVcXLF0L+U+e5kbeRTs+ZvwXJ7/6OpRSlWjo/B+5cKXWiv1liKS4gjsq3HDonOf2J0SLgfaRMreRaq2gSf83fabJK+yy8l13JaT4Wo7TDhLFaafYaySo072e/H9B6r8BFQma/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgVlPsthvwnyWUtwx4gOuU8oMMCiC162pioCSqOutCY=;
 b=QvwK20FZ5ubOtifJuvusWrMpFrNIQR4lHKemml3Xd2vxeXVF5Fw21MZSkjh28gJxuU11ITRmtVMm6SkwmPhed6AYkXmiWQSpGdlqSvpbnusWSb8FFhvMGni9L+RMCP6MhtBFI8CnHn8aAMNeAu4htLag2hVLGRfdL+w+f6HUh3Q=
Received: from BL1PR13CA0267.namprd13.prod.outlook.com (2603:10b6:208:2ba::32)
 by DS2PR12MB741322.namprd12.prod.outlook.com (2603:10b6:8:3c0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Thu, 10 Sep
 2026 13:24:38 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::51) by BL1PR13CA0267.outlook.office365.com
 (2603:10b6:208:2ba::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.6 via Frontend Transport; Thu, 10
 Sep 2026 13:24:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 13:24:38 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 08:24:37 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Thu, 10 Sep 2026 08:24:33 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<perex@perex.cz>, <tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<Syed.SabaKareem@amd.com>, <Mario.Limonciello@amd.com>,
	<Richard.Gong@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 08/11] ASoC: SOF: amd: add ACP7.B/7.F clock-stop detection in
 check_acp_sdw_enable_status
Date: Thu, 10 Sep 2026 18:50:08 +0530
Message-ID: <20260910132251.1171943-9-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260910132251.1171943-1-Vijendar.Mukunda@amd.com>
References: <20260910132251.1171943-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|DS2PR12MB741322:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3866f4-aa5c-4c5e-4434-08df0f3edd41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|7416014|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	1Q7ZIyA7CuT+pzDXJ7vCvyUf/Q+QfeYbtE6UVB/etl94EyyAj5YyoXllgn6KJ6K74rsFdT/M3GX8O+HHmnFD1nqJhljm6m7xNGtO3dDJ6L1VJVnif7LlNEXMMy+lMPrWy8K1LvEBGlD7qPQxRXCbxRlvWSslzBZjKOzOfMwZyxUMi1+SMn9+2BugrhBD7Sx8V4UJ8rqTuOn3vNgXvQGu6KN/bsh6utVa9k+EhlrYbICQv/9DxzkN/tbXnrBi0VuhgIv7GG//pMTwvDWIGKKAUHq5bHaL2gnq6uqIhBYHjw0FMa4bETQVus1j0t05xyd10DW2/LOP1CQtWgyve3KKZQeHIfKZrw6x+f+9H/f6ASrmcEpZRhMbhhoEkmncAih5L3JOpgKzwM4JzqC5uGBJ3RYAZaX2DnxBuTgDAv+X12ns3d/eESIOtJiGIkVyqaKZchQB5acAUIgmIcJMVwAZ4Ol+M/MBAGybSrFiLg+j96pevNTD8M2rux9+QOWXMzdAiqbUoYxM2vWPb8rxJdxZky+wus6I0YbVz7mSM6bDb/YHog5D971Db5bty24zAE2KBUO3+yx3IK0iOFh8yajro2xNLSfZu21M6knCMvaUJxIz0rMFNy3mUyJa8lHHvFqzbeHgUC+ec5IJS6YRuxj/wClXR6nnslQPRNTh6HnKWOKcg6G33LyxxUT5+7KIi54IcvZcb8tXC4cO8WSvCGV+zg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(7416014)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	2s36wi3cbCIkRVrvz93NCKKot2XIk8aq1tdTJT2QVNpryOwQVVEDaLeEb+OXYEDO+vNlf9rDLyPgDsWUyGiEdsBfPRIp23slB+E2CpZ8m5jb5a6ay/1no8ZpBIXe+SneXcXG7YZh4s2076OCtFjzO6AaSbO7xaIjDwTr0eVqE/GMECcwTjBPA6QFaF2rgkfvNTDNwD6wdbcRjczdRymuPw753ILT6AGqzVV8+DeoO9ZKAEHWjaqeo2Qur29nk0kKayo0gHHTY4mQQV5yoU2TpxrENnKGL/z3d501NQ+a2oTFLRoyCfpV8n4HuA3kONoTLpRgY08d4/ttHywfZ9uyFkZ/JCssnDrOALdclQ0waNwC485FnyC7zq/vtbLJzdOW91LpR7hc8PF2gql09qDn/lNJgbwGwQQFj7QG6jJ8TiJb39sI155R7iXA8fwYLN6j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 13:24:38.3913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 fe3866f4-aa5c-4c5e-4434-08df0f3edd41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB741322
Message-ID-Hash: LGTVNK3SMN4TGQTJ4VSY2PYUCZMTPIH5
X-Message-ID-Hash: LGTVNK3SMN4TGQTJ4VSY2PYUCZMTPIH5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LGTVNK3SMN4TGQTJ4VSY2PYUCZMTPIH5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Extend check_acp_sdw_enable_status() with a pci_rev switch so that
ACP7.B/7.F, which has 4 SoundWire manager instances, reads all four
SW_EN registers to determine whether any manager is in clock-stop mode.
The existing two-manager read (ACP_SW0_EN, ACP_SW1_EN) is preserved for
ACP63/ACP70/ACP71/ACP72 platforms.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp-dsp-offset.h |  2 ++
 sound/soc/sof/amd/acp.c            | 23 +++++++++++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/amd/acp-dsp-offset.h b/sound/soc/sof/amd/acp-dsp-offset.h
index bea1bd3afa70..74abbc834d71 100644
--- a/sound/soc/sof/amd/acp-dsp-offset.h
+++ b/sound/soc/sof/amd/acp-dsp-offset.h
@@ -156,5 +156,7 @@
 #define ACP7X_IDMA_ERROR_MASK			0x1FF9FF
 #define ACP7X_ZSC_DSP_CTRL			0x001014
 #define ACP7X_PME_EN				ACP70_PME_EN
+/* SW enable base for SDW0; manager N uses ACP7X_SW_EN + (N * 0x2000) */
+#define ACP7X_SW_EN				0x5200
 
 #endif
diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index a900dbc1de20..a4ca4f78e106 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -779,15 +779,30 @@ static int acp_init(struct snd_sof_dev *sdev)
 static bool check_acp_sdw_enable_status(struct snd_sof_dev *sdev)
 {
 	struct acp_dev_data *acp_data;
-	u32 sdw0_en, sdw1_en;
+	u32 sdw0_en, sdw1_en, sdw2_en, sdw3_en;
 
 	acp_data = sdev->pdata->hw_pdata;
 	if (!acp_data->sdw)
 		return false;
 
-	sdw0_en = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP_SW0_EN);
-	sdw1_en = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP_SW1_EN);
-	acp_data->sdw_en_stat = sdw0_en || sdw1_en;
+	switch (acp_data->pci_rev) {
+	case ACP63_PCI_ID:
+	case ACP70_PCI_ID:
+	case ACP71_PCI_ID:
+	case ACP72_PCI_ID:
+		sdw0_en = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP_SW0_EN);
+		sdw1_en = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP_SW1_EN);
+		acp_data->sdw_en_stat = sdw0_en || sdw1_en;
+		break;
+	case ACP7B_PCI_ID:
+	case ACP7F_PCI_ID:
+		sdw0_en = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP7X_SW_EN + (0 * 0x2000));
+		sdw1_en = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP7X_SW_EN + (1 * 0x2000));
+		sdw2_en = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP7X_SW_EN + (2 * 0x2000));
+		sdw3_en = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP7X_SW_EN + (3 * 0x2000));
+		acp_data->sdw_en_stat = sdw0_en || sdw1_en || sdw2_en || sdw3_en;
+		break;
+	}
 	return acp_data->sdw_en_stat;
 }
 
-- 
2.48.1

