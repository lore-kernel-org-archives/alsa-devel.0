Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12D1C79FBF
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2026 16:20:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 61A8160294;
	Thu, 10 Sep 2026 18:20:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 61A8160294
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789057240;
	bh=Yrys5e57L0rhXCc2Dv36dgOOmuZ20jNiKJ+VJCUK8IM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BKtHkTKdKlFYLkRXhq8gjiBr1UQ1V2/LtuCPueH9XNYsvjPA8ZbrIiyWLwGs+mvA0
	 XElod4q6xKpp8JtPjm7m/hpb/a8lWLjUi9pX/x4Jptv4JE/aoz65hzLoUom+qrDfca
	 LXJphmi9/swbVZaj11uaU+u1D/YfZxVmQUFYdCaU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 23DA9F806AF; Thu, 10 Sep 2026 18:19:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 59CEAF806A6;
	Thu, 10 Sep 2026 18:19:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8D3EDF80636; Thu, 10 Sep 2026 18:19:02 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.7
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789057142;
	b=JQZYaZAoAr2aCavNRJL36tuYlWpl1Ql8ZpHC9hV503V1D3E0pvUzRKkr/PwlieQTE1uc
	 amdp/r+t7hTINO+aOVn/TSVhpH4OJMX0OpcNsIYxBZPLE9ROp11mPoU9KwiIHqYMMwfBl
	 qDVvxEf6NR5dvRzJfBcamxD373fJwGabGD17Z7U/+8AWx3P4+2NnXmy1IQqtB4dfgww78
	 KXQ/ZunpdjSgT1ez/0oJOY6HRnDHjPNEKSx2DD+QOwEhkEpt5daPST04QInjQllTJIBTR
	 770wAt67Ug743QY3UGDlJ43iMcHBHEjzVevH9YUT+JebYNRJPUGHUkkGv2znMArNxbw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789057142;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Yrys5e57L0rhXCc2Dv36dgOOmuZ20jNiKJ+VJCUK8IM=;
	b=Q8v0cQAJWP/pq+2G/a/raxXbO+B70BGvq4ZOpKord84CO3rN3RT4OuozW25Q19A8N5Aw
	 A4wnWQyfjUzYtNHeqWNp9wNolmtWBpxg7ZBkK8WeDzs8nTznFfqXr5Bm+czm3lnvx1PHq
	 y2qbytAwcuzGpR9/8qRQb++osCyVLlk9pPGpE2esAcGgC0iMdr8yNnC/viUroE0kHDFj9
	 OCwOb6P01sq6FSmsGpQEDerFToz+6BqNKGD9yiQdYBzS/1KFtGDmMnfyXUGkx2el6GVEK
	 0QZkx65J+WcrtjgET95zNRfATIGX9rsV0vPR5VbVyg32ynjyP2S8tCBxcHhJhWRTYUQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=gfpt1n6x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.7
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013007.outbound.protection.outlook.com
 [40.93.201.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C9932F80603
	for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2026 18:19:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C9932F80603
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=gfpt1n6x
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9xsx4viqyz8CaxiQ0JPL8HiRnM/UYXyXM/U3Z8BY439Qsz6XCq0PzLmIg2o0K2aMAktSRaKSQMPXwJNwuTPmdG4SFZ9TTNhlrMIFueIffi1qsIHj6CoCp0R/bD4eFEVxfQTEggNHnOQ1pdOv+/0RAufqQz1rDZFZLR6KGs2dgGRbRfSGe0hHY7xTxSeDTjwPUGGdSqGLPQTkWDRGVD3jnfOzSV6/2t7EAE0gdxBjwxyaG/qcA0P4ZDXZ3FjBtczhxzJXyp7n8rQo/ga5WEaq+QpLXq1VzOxkvTwNGilU4XRDkdaAckqfxFwzL+z+UgzEsIu/lf3WL+uurEOrpe2Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSaRTzIkpeS5m0cRDpY0BsLDAMngdicA8HTW+5aDLMk=;
 b=Ma6NPs8UcfgC1FwuMUjrCSfJstodVBFnF5HiyVEoIawvf/mNo0w1TFwb7U+72nC+hSEX+a62zNLzCmpMqxatOai6WZ5391sbFQc9IZNokaGIy4uNjSV/v7jbx/FU3zTwRqN1UVq2oy6uxW90NZ6iALMM5whZOeA79LlwekHUzKNbjQ5Zd2Jo3/yPfdg++k0yaRgkwsvGmcEl5zzvO0/wD2a8H946yTYkCw2CPpLE71r43nk5vH4L87nrstB64Wmf70fkNurm1lnFZqfO+XYNkLY3CpZ/fYMi2LYqx3vKPIx4UFabfHWpgvgu2jwO4xXHHi9WrNKVn7OWihuAh0zdDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSaRTzIkpeS5m0cRDpY0BsLDAMngdicA8HTW+5aDLMk=;
 b=gfpt1n6xhpWY7GqLiEv5BocZ24P+YI9mNMUWkLytnKuPzAt+2ngbept0agClzertK+dSCC9XSY5vdb8H8+0C7qpmWck5lAlS4FhlV1QFZgasUbmk738QG+Mi/rCxIdsyJfQv3rF5jHjrEcBRzw3xC069x5wKMZkSOGyfFKuFXbE=
Received: from SJ0PR05CA0024.namprd05.prod.outlook.com (2603:10b6:a03:33b::29)
 by SN7PR12MB8004.namprd12.prod.outlook.com (2603:10b6:806:341::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 16:18:50 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:33b:cafe::9c) by SJ0PR05CA0024.outlook.office365.com
 (2603:10b6:a03:33b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Thu,
 10 Sep 2026 16:18:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 16:18:49 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 11:18:48 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Thu, 10 Sep 2026 11:18:44 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <yung-chuan.liao@linux.intel.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<ckeepax@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 4/4] ASoC: amd: acp: fix card name length warning in SOF
 SoundWire machine driver
Date: Thu, 10 Sep 2026 21:46:49 +0530
Message-ID: <20260910161728.1452808-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260910161728.1452808-1-Vijendar.Mukunda@amd.com>
References: <20260910161728.1452808-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|SN7PR12MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: 466cd05a-b708-4cf2-ac2b-08df0f57329c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	bY90c+D0RhlRUswEs+VyE4GJPfbCW0cBfNcnR8e3fJ/US1OB1E63DDX+wFfbfAAFl8vnzcNaVwKa2HfU7h5oab5xw8pDRbjz89NxRT9XTQDFwfT3uuCsI2nnCvu3lWh+JgUZ/Xr/nbr+hWG90hFpSiMWhjXEPpgxItwIzby6ywoJioKU+ki35KZIB6VF9iNKLo//7ZKjgkeaK17TpYlYQxYRb3au59jJvR0/OVcKMeK+YeIapahag2AcWZkWhutpGcniYyEMgJblFbTR8iwCLIOGkJCUcUKCL/WPs+ZzZrtnumBWbWiFlwVZXUJBjaQVcYxHRTGmWihRGXXZSBxJpLXhaGztqQtYw7n9da4THO7pQpBu6hX3plhnVNE233YIXieBcXcJi9JpgdYvxZRqogvkT7ZC2QOE5Cqn3HYjCNYEZioRHhkyXMaHvbTS7iDmsYd0lH7etGAkI0kqb5HP84pI2A2N3r2oO+2pPmT8SRpu6L3dryywlAz3pXG6gn1N1S9VsoThwGqEKlBJc4gBDzKU//eYZvy8J53Ie0OXuSzmDH4EmO89PwCj5RBnEcdjglqrRbaitjh+yZUNpSBAx+AfGNtP1NZzeZnWfG3+lAlcpjf9ZKfGxKRtOYOWvAssf52cLqzkgL76VLVetFYRfBWlB4ZWw2KsCGEFNVUVBz4ylmDkXtoDFYlBbD/Xsa4ZFvIK92gOqHuTKx43GaLZJg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	HhUCkIIEk94GFjQu37GUPLY6BxRWGM/2Sl+JImXLdIRPaM8xmHfszX2H+1mKE6n4QAsNDlKKv8MP+JrvXCqldrZnKsf2D2Vwz+zb28dpvUt3aFUzQF1reS9Xd5jGmxDb+ZnWaj1PdAnWvUzZamKi0hxf3k9HUBnMWmecdXm9KUGPibfHDbokKuoTghF/Oae4CHG1KXDJBgsvLNR0rPPClYZhDJPnjROTfv/hqnJM2+SqtZ5ZmaOBZSI4wEl1EXmcmUkcH/MSqZbVqRq/33zioF0OhrSxQ1ijxCWJrYdVhj4Hu7JgKkHrE1TmijQkAbZ1f3tWqvzXSWBuITaz2KCho/1GBUxq9/382O1CXntBta0Ev3oorLIOllLKeUVUvMA1os5+8jXcJu4uynexYxq00kgdEPvKp4waiJeSf6UZH+cGQLc0q6XKXwlna4xpacD7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 16:18:49.4341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 466cd05a-b708-4cf2-ac2b-08df0f57329c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8004
Message-ID-Hash: RREBEFK6Z4JPUTDIQGGPAS3EKZN654GR
X-Message-ID-Hash: RREBEFK6Z4JPUTDIQGGPAS3EKZN654GR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RREBEFK6Z4JPUTDIQGGPAS3EKZN654GR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The ALSA snd_card driver[] field is 16 bytes (including the NUL
terminator), leaving 15 usable characters. The SOF framework
prepends a "sof-" prefix when registering the card, so
card->name = "amd-soundwire" becomes driver name "sof-amd-soundwire"
which is 17 characters and overflows the driver[16] buffer, triggering
a kernel warning.

Fix by shortening the card name to "amd-sdw"; the resulting driver
name "sof-amd-sdw" fits within the 15-character limit.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-sdw-sof-mach.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
index e6d545fd665e..ec3e1f5f1052 100644
--- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
@@ -390,7 +390,7 @@ static int mc_probe(struct platform_device *pdev)
 	ctx->private = amd_ctx;
 	card = &ctx->card;
 	card->dev = &pdev->dev;
-	card->name = "amd-soundwire";
+	card->name = "amd-sdw";
 	card->owner = THIS_MODULE;
 	card->late_probe = asoc_sdw_card_late_probe;
 
-- 
2.48.1

