Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C65AC79FB9
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:26:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 27BE7602D5;
	Thu, 10 Sep 2026 15:26:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 27BE7602D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789046800;
	bh=epaQzHc444A+gAp+tg79saxtCMLmHlx5qvqxhpqd/bw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VBNPivvqnIjnpamKFQwL8hPgeBcNHX9XBpRpyfSKCtmdHrq3aWXhS7S99Wv51cftv
	 Cc3fKs3Z0tE9c/p6J5XhjO4Vpj+uoOcwWtayELvtqLCONLZ71mH7QWUI+ShmsQ20oy
	 cragJayVNxFV8EZj0hh0sdYx9KGjbAA23+isrmwI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D1BC9F806CB; Thu, 10 Sep 2026 15:24:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EE02FF806CB;
	Thu, 10 Sep 2026 15:24:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6B50DF80682; Thu, 10 Sep 2026 15:24:34 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.9
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789046673;
	b=edWomYwvT6U4GRc7DSFdrkWa6d8f5GFejDf7JI+wHl1miuGSnX1yEjiuj+iaqP1vZZqG
	 8cTCvyE823GD6twfLElDqAd6ACMeDKHYrH0UOHq9Esxpa/AiWmvdlT007+Atsoycqpo9k
	 T5wvmVxXg9XkdP3qNWuD+3cCPyw83bgypwnWkq76YbFh0LNyOZRmSXQwUeTb8m00O1rEF
	 N3XBwaOOX5A/wH6U4+dvpGONvevm2SDroLLQt1wafPGDERGqOy53kd2PgV7JKFSEXBHZY
	 KE1g5VDXRt+EwoHt2SWkPd16nkXop67m9oDxc3icOL5tmpmNAPdHT24V2xi+XJm6jeA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789046673;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=epaQzHc444A+gAp+tg79saxtCMLmHlx5qvqxhpqd/bw=;
	b=GDVVEkKHxqAlU6/kfbt5pBlMrSmmgJ3pLS+cvgVLVztiANzhh5/KG+OXxdbdhslHvqNN
	 yaOc2GSoMLP97j5wODx7Q/tMkGbaQcJSBpFSXYYW9S9un/iFJ3ZqUBeYzgrm976+wA2b7
	 wmhaSVkMORW/9em56+AIS/nLoqEe5rXXa2YwMcAlipAFsIy0F+bZ4SBfxWO5XGz8oWcpN
	 5fIvA2TohhjXgi8MblX5U0xSHLVR533ObjXozOf3usoN1pCmp3Bu6BWKPGpwthr2KwbZR
	 0hHOXOcAEILpqqe2zCjFFBJHflmaExFGz9hBexnghEfJP9dh5dEpC/pilnUww+tLr6g==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=a3uXBOLZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.9
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EC539F80659;
	Thu, 10 Sep 2026 15:24:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC539F80659
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=a3uXBOLZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrOyz2dEdArCqQxEbmQcBZMyaKktevaDcgtvIYhkT1DBzvpdghRfGwhL9QIt3FZ97YtSo3Y2U2z6zDYoYM0xbr+YAo7m2aEwGwBY+3zhnWqU+hcDXsNrNo8NkO1IhbxHxHTYpCSIObJlZRfGwKLWuH+VYIA09duoWp+qNd60I354GR6l+rMUtbtBYVIePhf+HEDfP989soMbqzuhiMCJQ9iDFaWsfKz3t+vKaqAaD0EhoVR0OfpXG6cHz7qPP72gDhtBhY2nzE7NICoUZMfsu1iB12XmE+jAUWGuIwv3DwAYdYfTcvO3/09uGBQ/4FhS9/Ta+yZh7gzCPzXY9dNv2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nKQ1qbralWzZiOCqbjUvln8Lv3aYlfnHkUpVgGzFLg=;
 b=Q03pTev4tuO/mTvKSUdAX2gDGbmnP91d/0dAc9fpVuWdJU1fMKZnWvcMWBGQ+WrEdZuYdFUWVamyJ/sEe9KIE8jX6mn2FnrfBcOuKyVzwQKug8EQBbwFECw2GDKO03gFpj7TnW/hc8r0Z1zPgC143RM9RRsXhmYuZud9whX5n5Zmv4flv+LBpjU00/iQWSyU75HcmGnLDFGlzuyudWvOD21v7D+RN5qsM1kpqamoASyr3BjnCm9SJnspTqB3TvydOCxixwrFXBlzF7fzjLm1yAyp+ApwGvyprlk1ub+weH2a6WXBPScetbTSlFkU1CZAx+fdG7aXtWiC/ZIMXzMhQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nKQ1qbralWzZiOCqbjUvln8Lv3aYlfnHkUpVgGzFLg=;
 b=a3uXBOLZx+Egs4rXNBQxaxL+QFsY42D0TJSSuFDD2o0QkOcaZQlEyJnkGjRaorTKw9flx0fKexgarN3vX+F4eijfDHupiLy7dkFMwa21aECyZpUXwJff93jVWzbobOpWqLs+lcL76OOmTeRwMfHBu9LJ+aoopfUt+lWZRl6C2a4=
Received: from CH2PR07CA0037.namprd07.prod.outlook.com (2603:10b6:610:5b::11)
 by SA0PR12MB4496.namprd12.prod.outlook.com (2603:10b6:806:9b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 13:24:11 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::49) by CH2PR07CA0037.outlook.office365.com
 (2603:10b6:610:5b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 10
 Sep 2026 13:24:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 13:24:11 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 08:24:08 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 08:24:08 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Thu, 10 Sep 2026 08:24:03 -0500
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
Subject: [PATCH 02/11] ASoC: SOF: amd: fix amd_sof_acp_remove() teardown
 ordering
Date: Thu, 10 Sep 2026 18:50:02 +0530
Message-ID: <20260910132251.1171943-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260910132251.1171943-1-Vijendar.Mukunda@amd.com>
References: <20260910132251.1171943-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|SA0PR12MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: ba2286ca-c32a-40ee-1920-08df0f3ecd36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|36860700016|82310400026|56012099006|11063799006|22082099003|18002099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: 
	j2gy2u+gkhh3TA8JyW83/068vvWTHJ8Bt6XB69anMoWJFWrUeZ+vMnA4srH3KKf/3kKNy9/FgHtUL7Hr718C+6J+zK915qNL4hc9aIa8pTmZE6datLV0rUJuBpL+WKH1wwY7kAyCfSDejH2N31qcKfGz4bXi0of6liYSh7IcTezRHrQ5k7RX+M0HIRo7DR7+fGnzrhCj+9/YgvWK3mXN5fjH6gN/hC7y9ag6UbaHqXZwrV0uHBp4Rs36aPX3zPN64R7I4cVM+iLCCIXy83IUU1dqU2gVEc9sZqCmOSK2mZ3T7h9rOjedvWIwo22ml1VTaL+B1CsyFiJxyzOMf+ovDaw0mRKO7jltuVfIhXAynFotzsX9i0kVHw/nVk+xhmLPQ2841ET3IChnCaKgs1dMuSeGp4UEcZ/LnAs2ly1mxefDnmTNZOWg9NRjIxWkxj0nvB9ydeH5M8Xd4Awj0kSc8MX8e04nisZxQc6rouhUEcj/gML1sgbh6gvANR8rWC8xylR+br4VbUsIdid+YHgGW2QIhh/dB7PAv14lBy5Joulr/eWN0EIMVICFDBOhaweeAeBkUfptddDqC5PJO7EknOWlzp8DonFNxcEnndkUIrNZz9O/kzsG2ArUT+LDwLusAN7cpfYcHHSroFabFoxqMsJOdagT9h1wW8n30SxZYyLh9P2ePPsa6RSU99Vn3seChqIN1bFPTic7QrIaxlck9A==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	UFQ7XrZwYmTf1JG/2NqYxkP6LbU7GSByLO05hSN47kWMk849UgxZ+ZW42wRxkygbfHb7vmVAF0zYHERMEg1pRnZHJiMXi/j/D6AZ3EoOFjmm6asQIwWGxfFRDQ38KR3FLJFNKCZ2fAEDTwypltpaH4yDHC+yBdMiB8es66oG0c8LQZNqLhNlzNds7xH5HWv+mrRbPWEQk+kHA/lRHBk3cj8CY5diwfkm0JXFzioKziXZgo2yC8p2Ipq7XKsXHuNZGj7sOYHJx9Sy4xT7Lk7nNAaP2z7x8A8ky4gghlSfQW7gCOrjmW1myv5jto6y14+bwuBLL67xRFusx73MGJMVmEECiYpWzHKLIzlOEbsHQF9fjwgtVdTei8vsmjoBt/2MlbvprVlwqKE6nsVza9nYxIabnX2P7rRjBxKzxgj0Un5nAaf9EnBUEfsFrW+WQQtK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 13:24:11.4733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ba2286ca-c32a-40ee-1920-08df0f3ecd36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4496
Message-ID-Hash: 2LLUJCEPR5QREMZXSOK4VSN5YCPRW2PE
X-Message-ID-Hash: 2LLUJCEPR5QREMZXSOK4VSN5YCPRW2PE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2LLUJCEPR5QREMZXSOK4VSN5YCPRW2PE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Call free_irq() before amd_sof_sdw_exit() in amd_sof_acp_remove().
amd_sof_sdw_exit() sets adata->sdw to NULL; if an IRQ fires between
that point and the subsequent free_irq(), acp_irq_handler() may
dereference the now-NULL pdev[] pointer, causing a use-after-free.

Fixes: d948218424bf ("ASoC: SOF: amd: add code for invoking soundwire manager helper functions")
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 688df7acd2e2..e4cdb74c075d 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -1048,12 +1048,12 @@ void amd_sof_acp_remove(struct snd_sof_dev *sdev)
 {
 	struct acp_dev_data *adata = sdev->pdata->hw_pdata;
 
-	if (adata->sdw)
-		amd_sof_sdw_exit(sdev);
-
 	if (sdev->ipc_irq)
 		free_irq(sdev->ipc_irq, sdev);
 
+	if (adata->sdw)
+		amd_sof_sdw_exit(sdev);
+
 	if (adata->dmic_dev)
 		platform_device_unregister(adata->dmic_dev);
 
-- 
2.48.1

