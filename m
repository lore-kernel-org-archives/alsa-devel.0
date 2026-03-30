Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50306FF4957
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2026 07:26:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 89FE8601CC;
	Mon, 30 Mar 2026 09:26:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 89FE8601CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774855583;
	bh=E00njkPAY9UQACurq//KzDS0kJ2Q6GmvveLZq5NJnXg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=HMwGyP6WRHwlFTdlcgF4C8QnXtbMmlurVIA15R6VBc/jRQvNaBav2uNLA4OD4/6s0
	 RmsK4mMHQLQA+sEV0QzsmlrWHQj5+leb8+JacnPP7i4TJPSn4aTw+myuhyQTSink+r
	 mPxu1qgwSrvn0zkG/FyEN2c+9BifPGO1rvdAfbfI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A0AD3F80639; Mon, 30 Mar 2026 09:25:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F255BF80639;
	Mon, 30 Mar 2026 09:25:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CAC60F80423; Mon, 30 Mar 2026 09:25:00 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011001.outbound.protection.outlook.com
 [40.93.194.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A2F29F8027B
	for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2026 09:24:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A2F29F8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=BKq85MEW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7/e3TKS9gO6qe3hbRhSLiF94iCoEBSWgXny/my7CwGKOefKyYPLnhnASswVBsVxZIl0gzZIb3OUd0Cxdhj0WjP8L8gJX0KqkPgwhjJCokTJpGqF2VY7gGJeIKFQMuMXofsiu3A6nW/Oo1i6SUW3vW8UmGgewwjKoydkSjFu6MaVinEyWYkgfToCcvJPN6D7Pxo4flZFEbbmSKakB8iTqTVfSXeSIyLHu34RlJXoXCMCEALxF3mYkR+dlHBGK6Xu/uXI6DHBhIWzJDjIhzItuw198BLn2a9dGjV37A/ukUaW5936QNrHamJvLxUErBO2cQoFiAnvYhggODq1wRWJ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gkIpRxjwFy9Usbk5Qfl+LT/crIxZ1j0HixNa7C9FOs=;
 b=HOLr0QS3s5k42a0XYJGnt1mUMb/gKLfCH86ZZYiRAl2nlo3FS993ye0rF10x9PGxhqW7FnrUmzcLST0DCi6FmirBn8FNAQY0rXoqWCaxxo1VcSJXzgK3rFCJ5JvokE3ZybSRrjZyNdrvPU2+bs2b/GBn4fzWwBjVzwUNaUvdcv5u7FToPjJwwT+xDSQqMnFWRG+3ayTfNIsKqoAfCcSDTjhAkRq/GLGwCW82nYneE8Ks5wNtgsCYRvzGtsClinQzyTKjFJbhomUXmkgNfLV7GW3qJCjdDEjnLVQrxq13gKl/QS2fRgdbRS45esgx6bCmQX/KNdWAgCirrqL+tMzYhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gkIpRxjwFy9Usbk5Qfl+LT/crIxZ1j0HixNa7C9FOs=;
 b=BKq85MEWsePnJ8ugjUrQoj4gOohl3Y/c77pCSn/pA4Ud+qsIDy75x1shtLWQg75Fxa21c2Udao1jSYIW57tB1xGFuydPno8dnUyXF8hTezT6fP4/YY+W9hTGeReYcolDXxT3szaT1ei9TqXMpCtuP1wj4AJfMdiUuFJvuudUCbE=
Received: from BL1PR13CA0213.namprd13.prod.outlook.com (2603:10b6:208:2bf::8)
 by CYXPR12MB9318.namprd12.prod.outlook.com (2603:10b6:930:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 07:24:53 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::84) by BL1PR13CA0213.outlook.office365.com
 (2603:10b6:208:2bf::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 07:24:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 07:24:52 +0000
Received: from vijendar-linux.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 02:24:49 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <yung-chuan.liao@linux.intel.com>,
	<lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
	<superm1@kernel.org>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 2/2] ASoC: amd: acp-sdw-legacy: rename the dmic component name
Date: Mon, 30 Mar 2026 12:50:28 +0530
Message-ID: <20260330072431.3512358-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260330072431.3512358-1-Vijendar.Mukunda@amd.com>
References: <20260330072431.3512358-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|CYXPR12MB9318:EE_
X-MS-Office365-Filtering-Correlation-Id: c68cd2fe-f56e-447f-a64e-08de8e2d6f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	DoB0Hh6UC/LZKUdQ/a7LuErsaf9AJWOZAgsJ4lzO7EfV8wFTzhBhOA7aSzy1gAQcPc3zC1IX3u+1TAwN1/qgwcglSPa9dKwlXN7nalbgW47LFiaw3dhpuVYmy6Cpl0815EvlnbhcxdZfbzIAXb3Yz/1F1y7MTEwpXcwMAJOQ3OhfC6Augn0/8y0RbN/JZFJ7/XdEWSd7FwW5/YwGJW497vk9GbWkvhEpbXbGovXTRYVZkHVGeFjB+eQ6uU3IbpvUsNlvbz5pST/p2YFEDkTFnLsbMI5fSNAugRchAIFPiY17kKUIEZ3MRktXZMRn7Tk3rHF65iQHu594ko75WSZmn1CNn0dR3MeIn9A8wIyWSDOYQ4yms1drBne4NDJm/u4BRnW9inHfKaYDYMaakSo9ICISwPNOhxzvPZ2cZxtwCmKsQl1v8B5IJBWY3cU0WBJDRTfetYJzf64VL6BJzBAn4uUqpn0RLrG7/HDcKMhde9AU0FFPNSrhWga7dWvFSqo46OEZ5vHV95OpnEEJOfIX/LQaIwoUU0Q3BOPdsBec9RsN2kxYrkVNJw4FWpZ127VV2uQqabdsH0DTgOZbKomgCPJC4IPCwFdKk0s0mqZcfrFeO3xAVHTD0QzIJC7ADH5Ecr/D4U3BtM3uSLrb/UqJ2FiSNfGMeTOXk/muqV7BwCm+y2j9kAKSe9vjR5aZBgvCVqOU5kbJuKxalIUEr7Vf4mtNjFvexQ6ZlmFjGTjrKQQfs0RdoHTc09SDvzLBJ9Xp2znxuQhN9X6zMaka7TRoKQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	RYC7HJ6uJaa4/DuvXe8mpqS4yoiTxFDNQIdSNY2lhIiKaCryh4w7sNByVFs+jXlvq0eVQ2L8As/i9yO6bePQEA+cg0r/Ua1OeqzGrD8Df3rYHjKRb37RFR1sgfVXQXROL8B/XbSaoECjwxZdgpZ3uAkLrEcpqwUlHN8Dw7lrdELJ2jHM4LUzYEAG6+mpdTDoEqXIAg/F+FhnAdcllI5uHXQJswlbpC+kXJnXd46GNOkap0PJqpe5Yszzl7/wN1sHzS/qYuBBw0VwSII01Jsb9b7CaMBHQOW3Q976ibN2akUlNCo+DEyKT0ppMLVWhxqxVPV7UR8L9GTD6VAUaIRicNExjlwkHtgZBHZuV7IA1vBIAquLGJdcUFkTwKDvdQb/LlZ+ZVCOtl9ALNYfnyQUaF47N63q1VLVxopsPahKeVfkBSYmy0r944udgDclDFYv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 07:24:52.6795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c68cd2fe-f56e-447f-a64e-08de8e2d6f6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9318
Message-ID-Hash: RKYREDI4BVY6IIG5X4H63GTQRGQ3JPZX
X-Message-ID-Hash: RKYREDI4BVY6IIG5X4H63GTQRGQ3JPZX
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RKYREDI4BVY6IIG5X4H63GTQRGQ3JPZX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

For acp pdm dmic use case, user space needs a reliable identifier
to select the correct UCM configuration. Rename component string
as acp-dmic to select the correct UCM configuration for acp pdm dmic.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-sdw-legacy-mach.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-sdw-legacy-mach.c b/sound/soc/amd/acp/acp-sdw-legacy-mach.c
index fa9b4b994e41..05484c72f9a8 100644
--- a/sound/soc/amd/acp/acp-sdw-legacy-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-legacy-mach.c
@@ -537,7 +537,7 @@ static int mc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	if (soc_sdw_quirk & ASOC_SDW_ACP_DMIC) {
 		card->components = devm_kasprintf(card->dev, GFP_KERNEL,
-						  "%s mic:dmic cfg-mics:%d",
+						  "%s mic:acp-dmic cfg-mics:%d",
 						  card->components,
 						  1);
 		if (!card->components)
-- 
2.48.1

