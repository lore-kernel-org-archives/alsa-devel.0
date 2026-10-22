Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8983606A322
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Oct 2026 06:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=qMBuse/j;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Uop6Ep6i
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D591C6016D;
	Thu, 22 Oct 2026 08:11:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D591C6016D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792649513;
	bh=DSDqLIK3gkNieoBfh9wrHQ8XJaUfTmvNQSA3sccPAYU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qMBuse/jVx8UKKCEhRW/9BYCYRdqU240Ue2ydXwh4zN2Bidr1iPPpW9aeWEc9pnt1
	 S69s61EJbddtl445XCU6Wd3haM4pHBkumZmbPJOSug3AV6/v5nht9xx5+JX+HM2UxN
	 cNrFybF7jAOow/SVvCH4v0rEwD85jMsEOTmIU6Ds=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7AF54F80606; Thu, 22 Oct 2026 08:09:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4E280F80714;
	Thu, 22 Oct 2026 08:09:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D323DF806C8; Thu, 22 Oct 2026 08:09:36 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012062.outbound.protection.outlook.com [52.101.43.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7906AF806B8;
	Thu, 22 Oct 2026 08:09:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7906AF806B8
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Uop6Ep6i
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6Q+PhwDyULXUP/V7/xuCAuKoHGb0DOVJd8PU7FDoPBdpqwQqDPhFoIsTcVG7uFp05ZacZhbnGXMBMpEV21Q/GtFA6iHIsVuhimcfTJhw4/XriO/6aKsKsk2H4CXK9pPuz3TfJCuB3raQjjhBK2LxmytsjQzOz90NTrmBlZ4723/Nb1oDDl9PaCLr/hIssgYlELXe0TV5NEKq2Uo4PwLAk1Y+dLQfDsK9MHjDbOkYNYCiKt7m0R6kpN8iBTosTC2crr1CF2kctM0wqFGP0yweKZpLFum7dGJ7T438r/t5k3g8SmANc7k+y8TAPA2VoMEiBoBpm1Dhy18bqez57eLBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WT6nZJSSvN43UAE/RXEuq/Q5QCbgipL1gR6aocsT+F0=;
 b=Rmpf6vppI5PWHW4FJBKJQg3XHvE6kF6UvQVMthNs/etWTMBENVh6Gng6TPIb+e64JNGX4FARgp/SQLmTANeN+0WOh3HMRrBucjh/4oBJCqH3OBKiG1zu/5/KA678tHmImcVGqM/1fNaN9PrBIiCfPjU7DcMtkl76HaAv+XvbuYUEFrzE6mMV5mE3LqKiQfv5MtlYo1mxOTPWaqKQYz1Xp9Zogl9s2A4tonGA9+g5/zfXrlhJh/oCgBZTFVTxfyI7H+eThFk71pxB1nyriophM1II+yO2O3ClN2Nim7oj9Cgi3WhhWf/L1he1f1ZuIr6jfSXC5TbAKh0THFNF7JR4Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WT6nZJSSvN43UAE/RXEuq/Q5QCbgipL1gR6aocsT+F0=;
 b=Uop6Ep6iLwH45Yx/9roXRVhjViNW0x9jWpddePiSQnXlkA9G2d5HlK/TRemdBUB7T2uB1Cl0526qYvxRI9Qyvd4j4zvKYon8kw7G6LtJaTrsiVxZR3kSZNXDe6y0dD2c9xCNb1G+av0epDeWnEjk1MRm9u9CjPRK10A7zS6IHmo=
Received: from BL1PR13CA0176.namprd13.prod.outlook.com (2603:10b6:208:2bd::31)
 by SN7PR12MB6982.namprd12.prod.outlook.com (2603:10b6:806:262::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Thu, 22 Oct
 2026 06:09:24 +0000
Received: from MN7PEPF0000014F.namprd04.prod.outlook.com
 (2603:10b6:208:2bd:cafe::60) by BL1PR13CA0176.outlook.office365.com
 (2603:10b6:208:2bd::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 06:09:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN7PEPF0000014F.mail.protection.outlook.com (10.167.254.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 06:09:24 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 01:09:19 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Thu, 22 Oct 2026 01:09:15 -0500
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
Subject: [PATCH V2 07/13] ASoC: amd: acp: add DMIC components string for SOF
 SoundWire machine driver
Date: Thu, 22 Oct 2026 11:32:17 +0530
Message-ID: <20261022060724.1814741-8-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261022060724.1814741-1-Vijendar.Mukunda@amd.com>
References: <20261022060724.1814741-1-Vijendar.Mukunda@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN7PEPF0000014F:EE_|SN7PR12MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 068724e8-3972-4a3f-69e2-08df30030586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|7416014|36860700016|82310400026|376014|1800799024|23010399003|261021121427099003|22082099003|10067099003|261021123027099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	LFwDGEFK6jPYlwr7xHREI6CwEMtIJiAXbGiipoeG7aH7U+I6ndj7WMQYztl+L7S3MXuaxjdkQcZqhPYjljbEHCZ54bRbCHH2AW2S+5iC3NFbr5AOoojztKAV9KmDILcxcjPzEfQIk57lhH/TGtwsMAeJTzT5M9U05RPU8wtk7NGIVfbYouDJu1V8bEysFJn0IEd2YUWRVWHLz6AUerFNlDBTYV2xlVP0pn9EEXdpVH8qXUx1NZKyZiFvmsTM07iP/mGn1yX+XCgtoUdUjpYPv6v98TzE4WapTxa+hkGSd3CUc06UxbkMr/KH5x9rwWIgpdgN9tepIhy3+fYY+CmyUGJBA4xVR3MkOffAm11ipWAO3B1kZ5ui9XhAqAnh6x0gzhDY9S/DW0FedkuA4stJ6NQNdKdGyvO6GL6UhpcWxPKCzixCwTm8VSNs2KcAhXgjCQd8llOes6we+AwctPwjC1u58wHSD5CmHS4bMoZ1oodZf5IOh7Y7VfLhQFuuHT6pJKlbn55kU+40pFYUFzE4J3e/MVBsbPQ4P8z4Nfo5XNfVq9FjBRkoX7DR9uRXxeAsc3i/ixcV5xRiv68UjgzeGdOSPqam9Ff0CznsaWDPH/MNG2DZ68bwVEYR5RH08di6cMqF//HZSL8sjaO5xVpnsaBO9XdRq8yca7s6fdXrrkKLLmB3UXsVQiV/v5n5j+RDdYKAWbazSwdXi8YDbLu0+g==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(261021121427099003)(22082099003)(10067099003)(261021123027099003)(18002099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	kujzvabWTerzW1EYsAKauHE1ILTIdSGXBnj/d4C7WGvthbPDzOZF7yPTQb1jDgjSofBHDzKKz2V2hT/a8WoIMQOxfrgceGxnEQ/vamaolZsVQAwzAf3IYjQWGI7XA+g/fbdqj9UHw37Ps3PZKaAHG8z8ypoAjViYrgKxeqA3YqM+yOW3RmH0YLjNbFwebPsxe815vXQCkdUSPIS9aJzo5SUpox9U3jmclbKEPAfjxJMA8wOilN37SRwsrVEXuXp/V3s0fsRS7zymOpa4HvXTiwMpMkw0J+vnUB7WxQBHMFFSxRVjBgIoGwbTYOHglsOUs3H69O5eTHyNnWNVkeUC027dJY3g9KSDS+j5cTeV81l4dCbqns/4F89jxOEIFK/CZ4TMQ9V0Dsz4lkk5O7GzLxjXGbOrPvw6BlBYvUjwL7LOJspiQumceH5LfF565/GY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 06:09:24.5151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 068724e8-3972-4a3f-69e2-08df30030586
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MN7PEPF0000014F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6982
Message-ID-Hash: GB2LKITVGLRBTXEBD7QNGKGKQOFAOXGQ
X-Message-ID-Hash: GB2LKITVGLRBTXEBD7QNGKGKQOFAOXGQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GB2LKITVGLRBTXEBD7QNGKGKQOFAOXGQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

Append "mic:acp-dmic cfg-mics:N" to card->components in mc_probe()
when a DMIC DAI link will be registered, keeping the components string
consistent with what sof_card_dai_links_create() actually creates.

Gate on the same three-way condition used in sof_card_dai_links_create()
(ASOC_SDW_ACP_DMIC quirk, mach_params->dmic_num, or amd_ctx->pdm_sel)
and suppress when ctx->ignore_internal_dmic is set. Use
mach_params->dmic_num for the mic count when platform-reported; fall
back to 1 for quirk and pdm_sel paths.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-sdw-sof-mach.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
index b6ccf618773a0..d7d9e24b82930 100644
--- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
@@ -406,7 +406,7 @@ static int mc_probe(struct platform_device *pdev)
 	struct snd_soc_card *card;
 	struct amd_mc_ctx *amd_ctx;
 	struct asoc_sdw_mc_private *ctx;
-	int amp_num = 0, i;
+	int amp_num = 0, i, dmic_num;
 	int ret;
 
 	amd_ctx = devm_kzalloc(&pdev->dev, sizeof(*amd_ctx), GFP_KERNEL);
@@ -489,6 +489,17 @@ static int mc_probe(struct platform_device *pdev)
 	if (!card->components)
 		return -ENOMEM;
 
+	if ((sof_sdw_quirk & ASOC_SDW_ACP_DMIC || mach->mach_params.dmic_num ||
+	     amd_ctx->pdm_sel) && !ctx->ignore_internal_dmic) {
+		dmic_num = mach->mach_params.dmic_num ? mach->mach_params.dmic_num : 1;
+		card->components = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+						  "%s mic:acp-dmic cfg-mics:%d",
+						  card->components,
+						  dmic_num);
+		if (!card->components)
+			return -ENOMEM;
+	}
+
 	/* Register the card */
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
-- 
2.48.1

