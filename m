Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17782CC6B12
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:50:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 18F06601DD;
	Tue, 13 Oct 2026 17:50:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 18F06601DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791906633;
	bh=6/MZkYvLJPngPFGb4TVkMWAkxigbEWMVGvCPDtBDXqY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hrZRUV+7ETKtL/MvGzCBRiaJp8RaCGKLb5BSQMI3gWHd6CRi9Op+bU6XlYVkfqFdY
	 49lSFoEdCpW9e3nNVElBUmj+Nf1lGnFPQ0cihBjZ2iVnawrtL8DL06HQCZX5Xf9dM7
	 hrn01lezm2z44rqiAbaCxqjEk1foVxIR1vfhhZHM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 692E8F805F7; Tue, 13 Oct 2026 17:48:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5891EF8070B;
	Tue, 13 Oct 2026 17:48:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E4C8BF805D3; Tue, 13 Oct 2026 17:48:28 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.11
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791906508;
	b=JfMf7cfW0/pKjiL84BMq0hqENLxxWZdxqmTjXDnr1/A+X4d6aUlpsFEM9MdJlYpJ29t7
	 R9oazVcCv+gedAzqWZaYO1YfdecKbkaMcZQqKKe4eDkZFQrR7C+OiqQMFOflPExjqKXZc
	 C+aQbhSfEXv0LZZmbGaBiQUwIPRniqFaGYLW12E0gb/0YIxUMIzCUrNVgjRBZwW8hE86J
	 8qtaTC6omr5wpWRJPN2XLUJEsjvvYbjo+noj4/8Rr55UkXNPgVbn0hpW8R8J+xbFfnVXL
	 zS43FWhusx+RSExFEle8IkxNipHrthKHDckFd4cONDJvJjWWVEZ2hUcVMsGNoTVHehQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791906508;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6/MZkYvLJPngPFGb4TVkMWAkxigbEWMVGvCPDtBDXqY=;
	b=CCvHE43I/FWXf1TgiqspHrXafGppme+otK5IPhR6i2ZtOfd4C/ntYW/Xcp3EGs+0bqEN
	 hb9S9KfhQJB7sy9c34aHyJkqU1syqnXNVxRuOs6P+w7tFZXTRg9nDVaXAyj+ghjV8P16O
	 dM0QRuiL0Ji7UZQAcdPXAhnoYDonyhVl+99Xpxz7zcs98n2DUfMr86YAbzyHwwJCYv4EG
	 paNIgVJm6c+w3byHPRF1/x3uR2CaTefz/gkFa/HPdI7Pfk+O6rB8/X+LrbU9mSTsQcBh1
	 cAyLz2pZB7tCEsMu8F7QRhr9Ag4bsCPRZrv3R1Da2HoLcm5EWpUrDKD0+Q/psTZH0Ig==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=rcjsAW12;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.11
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013011.outbound.protection.outlook.com
 [40.93.196.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B1739F806E3;
	Tue, 13 Oct 2026 17:48:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B1739F806E3
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=rcjsAW12
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbT53zBKWqGz7IbAteFQPafU/k7g8dZpB9BvoyhbDxa7Jy+fa1bRMWf9XPJALZdHClyUHCTE1A9Q+wbjlLYmKuIaD4xBIT7PrlHnUl4GbO1X6TLqQw0QlBZ+EFpXg8qoMzXfljzcM6N8b18e4yAKnuifmLcWzICs/6TcrbIIIliTPzCwVml4QRWTXknTErd9R3zdhYGUZKGyP+FCQ7f9FtQTypNj/eE9a67N6ZyZVXEuxIyftFunPbOxtI7bH907scGUtnViri5u/mExLslp/jUYXOkP9Hommpk0ZsQoWGoLS06uDAfJitGc94NJ5//7FNH8Si8SdwsGlSGxckyBJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=om9tuvhRHcnLtVZQqdBvfwddX5+Ep98xURSjkDQaU1A=;
 b=Q/uUtxuABzembVTbZQ5BqP2eB2W5aVJCsBf4Geke/XVtQvvL25Hpq9kz6W/AT/ERfKU6LysYrm3atxs9eVozn3skgsxrHUwYSY6le6o2646pdCAw5rjJQc0oBZPjZHMa0NesOW6OG78UeOCuUqvXnVwh8A6cce3kfDSFnsWiGLkvVpzWfR/+9uCIITD8Hj6KiMkPw4s44+hxzcqV0EKluqmXKQeeYvgo5ea8Sj/i4GjYos2gJMHd50fJkXVXBIyYCpLbFQX61vWQprXrBhRRomfaqrrRbPOg2qafPwOxHaUS3c4QDPysY/r/jf+/5lnIf5IPRHPjPk1oaKzHmG6QBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=om9tuvhRHcnLtVZQqdBvfwddX5+Ep98xURSjkDQaU1A=;
 b=rcjsAW12FXh+NyiVG18KTZlIL594f5KDlbTfrTRIIfuQ3hXyFfPA7MNVcPy9mwbQwI/ZKMSeNS23Q0MLfftpY48KNj/w54QJv2VNCK+0ZZQHkRUVaLVCp9PwzPUDKr/8hwtDKFfVzcERSACsi1wy+ugaf/UFqMvr9BlG2yd5DqI=
Received: from DS7PR03CA0224.namprd03.prod.outlook.com (2603:10b6:5:3ba::19)
 by FT1PR12MB455478.namprd12.prod.outlook.com (2603:10b6:170:3d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 15:48:22 +0000
Received: from DM2PEPF00003FC4.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::44) by DS7PR03CA0224.outlook.office365.com
 (2603:10b6:5:3ba::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 15:48:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM2PEPF00003FC4.mail.protection.outlook.com (10.167.23.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 15:48:22 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 10:48:05 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 10:48:05 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Tue, 13 Oct 2026 10:48:00 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <yung-chuan.liao@linux.intel.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<Vijendar.Mukunda@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>
Subject: [PATCH 6/9] ASoC: SOF: amd: consolidate local variable declarations
Date: Tue, 13 Oct 2026 21:11:38 +0530
Message-ID: <20261013154644.3788064-7-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261013154644.3788064-1-Vijendar.Mukunda@amd.com>
References: <20261013154644.3788064-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC4:EE_|FT1PR12MB455478:EE_
X-MS-Office365-Filtering-Correlation-Id: c7987053-6180-42b9-2385-08df29416917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|18002099003|22082099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	PPVi+89ToTApho96Z4WIA0B2cbOlf/iLtIhWxbhg5RkzuqABvKMqRrY0RGHwHgGoymo8FwSDiBl+TRovP4zLQv3Q3Hg5GAywePpBhL4FpNpE9zTtSSXhTTTVm08DX2ENBZaYCXzY+D7TmRVGQKX+SYSoWDTa7sbN0nbgel7PAfT7sBlfZh72mBgP2T6ycsuJWeO6DACbmqO7IGEPUCdXzoHBqhT27y1a/WApgVq+Ku3fDNH42filCWzAcXirb+bOPCMErhRkCmv7o73dl/VkQjHnYvmLOyWdYKKHxcH5QIhoiSW2MEo+sLm59Ct0PwwB1sSNyC6OCeyQNX+aS3sPQ5jvhYfHNHvW0xq4hsh63ZU/VhqozJ6XaftocIYorx0SFUsfVTqR9uxAIvmV38ZlOJ9GfimpzZ/kAIEvq4hkLA8AQMeoQJ/VgX6+W95r46Ep5wxp5KkwbywZm3W9cGtCJMfxlequXfTjtHcU3tmNa6IAG4fW0aIM1SHie+bIXBkDcj5QPb68wm6y27TjafBj93Paa9AJPq3uIpgXq9OkvjQGlohmQQaj7jwhnTtZpSGcJNb77rFUeu3yea7BwdPgh00548ZOOPOsy5e0QfyjzX5TxNrJ38cyfYdWMt8zUNXJwjgcSJZDok2zQVC7CUTopIi5JPPLDxmGUtGz68OwR/Popw8s1oaA7aAOpc99fgCB9PILIH64LGBf42eGIicJEQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Rlh3JXC4iicaD+mqG919DPd6wbymfEO8fo+sB5Hu7+YpHIzE5JpEL2Tyy8rey2GklwdRo4MdhNK7WRUouDb+c4yauTGerb9c9wrnnp/VOMOMlOsAOPbU06I1WKsds4VFWaAIpd16Mq9LSD1fwxsSThFmYjRnImJ5hx22G4dByM127LE+wF+JaYmUB/J3SLDeCnHe7V/IGOI8EH0QkZ6wANg9+hu5c2aQhjtygN99cASZu38ZQCpVUJRSx7KwE0Lo0BhJ4vPSV98x7vxmd9dCcmXbVHqJsSGHLWP5D22IQBtQkyoqP2XlcaQd9L1YywmfrOaLP/AV2dOGp5J9aaSBABVarlSTNgoiy43jZ0oD7uCozHQGXFAJKXImj4uXX3xjX5Q4Eok1XbakAIFWPFyKBWfg97cdWiKdbL946KzdXIdaxzjkQduSlU4FVIHnmCY3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 15:48:22.1877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c7987053-6180-42b9-2385-08df29416917
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DM2PEPF00003FC4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB455478
Message-ID-Hash: YUICOYDD4PDZIJLBOQAQ2FUP7SIOV24S
X-Message-ID-Hash: YUICOYDD4PDZIJLBOQAQ2FUP7SIOV24S
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YUICOYDD4PDZIJLBOQAQ2FUP7SIOV24S/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Use u32 instead of unsigned int for hardware register variables and
combine related declarations onto single lines in
sof_amd_check_and_handle_acp7x_sdw_wake_irq() and
handle_amd_sof_acp7x_sdw_pme_event().

No functional change.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 71c39eb36194e..790af65be34a2 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -674,9 +674,8 @@ static int sof_amd_check_and_handle_acp7x_sdw_wake_irq(struct snd_sof_dev *sdev)
 {
 	struct acp_dev_data *adata = sdev->pdata->hw_pdata;
 	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
-	unsigned int ext_intr_stat1;
-	unsigned int sdw_pme_stat, sdw_wake_en;
-	unsigned int i;
+	u32 ext_intr_stat1, sdw_pme_stat, sdw_wake_en;
+	u32 i;
 	bool sdw_wake_irq = false;
 
 	ext_intr_stat1 = snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->ext_intr_stat1);
@@ -1445,10 +1444,7 @@ static void handle_amd_sof_acp7x_sdw_pme_event(struct snd_sof_dev *sdev)
 {
 	struct acp_dev_data *adata;
 	struct amd_sdw_manager *amd_manager;
-	u32 sdw_pme_stat;
-	u32 sdw_wake_en;
-	u32 pme_reg;
-	u32 wake_mask;
+	u32 sdw_pme_stat, sdw_wake_en, pme_reg, wake_mask;
 	unsigned int instance;
 
 	adata = sdev->pdata->hw_pdata;
-- 
2.48.1

