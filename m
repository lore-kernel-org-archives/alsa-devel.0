Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F31FB3CEB
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:47:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 829CD601F1;
	Mon, 30 Mar 2026 11:47:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 829CD601F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774864066;
	bh=ToKFkjvJBnKIcbFLUMUai1X7jaLxGlPnWPdBdTKGxxU=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=X2Jfq+3fxrzwd1gTHE4LZ3w8W3Tic55/ud1zS8kAX1CJPBBlB5+s06XP0bwo44TjS
	 WgcELP6PPjdBoDTR+iubRJc0bU+OWJlmWHJN0jMwQSIvghwSXOrbUzExIzIaYXI427
	 jpIFOhCXFW7mbFidjshfxLYZ1MHELSFgd8KmCkpQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2B5A5F805EC; Mon, 30 Mar 2026 11:47:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 37C41F805F4;
	Mon, 30 Mar 2026 11:47:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9779BF8052D; Mon, 30 Mar 2026 11:47:03 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3830FF80087
	for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2026 11:46:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3830FF80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=vayxJhQt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGdsHwqyKRvsDMEyLSbn9a0n/GAb7NWZfIXooQjkFQuPxUfwuX7SOgq72zvMKIoLS8XzDRiYm8nCQRgQcJJqb/EFL41viVOTtuRZCXBk7LKPhO02HKtrLagw3dEPbD92x9kxLWHcoRlHYmupur+CkPk9eUHJ/0KfQikpddQTTJuDGorkDC0lgzfb0mK4UkCmbMC41lX20aXZSuxm0AyWGDbHs9HK2kfeVAPemHGxWqfm6F0DCq4q58niU8uyLsjlr4r/acEXKF2SL6dHi1bv7WJlJtK3rAZVioT2ACAKABmoD9svm542vkq9edSjeOWi1LRhT1N7rzaigZO1nHHWcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZju8pLmNg3j5wbD9JEWuZeQzFlezyas4fEeYTM92zs=;
 b=OWfwva/EJ8uTlBqaqgL8AjWVN1Z/4WZ7Il9glbpKbHSJ9LFVIezppCdM0h5ugNYuM3tmmTD1mf9MDdIsfIEGofzya5rOwtPeJH+QpajX7Ex0mTsOoHqdkSYlyMvgpT2TKh7dTRYuOyUu74mxB/fDmXs3PbF2PDTxkbNplJCcQ+Fbf6BbEPONXqaxlZwsqOlszJOQ4ZbbkTjv+uOsJYEV0TqmrsKAEAd5JHk0nNW4Gcaybo/8SBb0zvDvn9cER2miOIhPwSwCdrcmMj0gfCMxBFKQcxkI+Yl7R5RvbXasBdQP4ldeQfQ5UKd284U+G5VBph96fQeFCc1U7U8oxxXwDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZju8pLmNg3j5wbD9JEWuZeQzFlezyas4fEeYTM92zs=;
 b=vayxJhQtb8MeBhuqChLaBOMQEfU0kvE9D20uitjRp45Ae5LhMjkbvtiysyyQKxgLIhW3D5blyiwiShEpNP8tOdV0V8b0pS/tWnGtb7Do9hsgGPNG4LyRCO/rNN/dSxQ9UdakDpZZz/ceIovvBZ4XM9bnW9LF3TO4x7y8nsyLZwo=
Received: from DM5PR07CA0071.namprd07.prod.outlook.com (2603:10b6:4:ad::36) by
 SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Mon, 30 Mar 2026 09:46:47 +0000
Received: from DM2PEPF00003FC3.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::61) by DM5PR07CA0071.outlook.office365.com
 (2603:10b6:4:ad::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 09:46:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC3.mail.protection.outlook.com (10.167.23.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 09:46:47 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 04:46:47 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 04:46:46 -0500
Received: from amd-B550M-DS3H.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 30 Mar 2026 04:46:43 -0500
From: Syed Saba Kareem <syed.sabakareem@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>, Syed Saba Kareem
	<syed.sabakareem@amd.com>, Venkata Prasad Potturu
	<venkataprasad.potturu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kees Cook
	<kees@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	"open list:AMD ASoC DRIVERS" <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: ps: fix the pcm device numbering for acp pdm dmic
Date: Mon, 30 Mar 2026 15:16:25 +0530
Message-ID: <20260330094642.3088923-1-syed.sabakareem@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC3:EE_|SA0PR12MB4365:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cfb52a9-024b-4f6f-fa7c-08de8e4142c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	UJj6BdmVSsBZrOXs4oPRIiJUQnhRBpjxuNW4f6GH2OP38GA4FSl9YV7ss4DlnhGW5b6KGiaIOFpmnvksUasA58cns869noiqEHkzzRP4TqxOHo1kLbOIrfMzlqu3InUXRDW0R5FLlsqiCg8uGCwVjjZmq9RlYa6BgkVhAdwyxICj1MS9Zv/lrncDEBLHY77oBgrCeSbqRzSG7L/dyw8AdPxpxBqMBqp9nYr/WPfFNQh9lV1TX2nGl2Z+RLuQbH7U0Py3ysd+tSFvzbJ+GiQVEEQgUnVMyHh2pIDwrRxrcVKL+g/yPakdYjVlpdaYqmpMMDDmrEAzO2vVtlJrdROyboT/nECWHCgcxkEsDQKQqy5XDqTUHtGamxti37ZZ91pOFkdw70PQIgcSM5FzNUngjsMC7iyEQ0Iw6UZEOoQrS+T19e3WFXodVtFfTIB6O90idsKuCQAWO2NXgicci/N70f5oKV2CAQgMJ/jm2noo6wzzM5DRXIeYApykLWShdVif1pBEGob2KszRo8pc3KeSXsWITdT30wDWxESp0SP+gTkaZNgzxcwgVPhnc7imj8uGmrXbC9z919f0CzJ8o46nLjzom4/M70guRempk4thofIgXGepv0nAkGAbVc4iC7H/fziH/S2mwFSgFMrE8UIqnVCr6jziAveGV30Wy0uak54jwx1B0OD4Z5RXm7eKUcKUsTycrQbLOQUUKCdwNefmfyKNSsiQsFZVFQYZgRD1+35v16dEmThDHLJzpQFtBxAHMjlNimnqQfydm8n1waKVew==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	CtTec7znip1PQfvBD0i6WiIt4M7jZe6E9NFyHECfhUTzAzKOfInrfIyG8RcvelxtGYUSBs9y/go0C2M/wHAyv3w3J9m6Qm1gXsoUa/oea4n1sTLWBtBbck0NEwzRq2w52riFUBekwa2tBeW1lmvX9PrRUv1pUzpDdO+UrrhebOUof3GBPsXYIq5OQKd+ZSJGfdc7Bul/+lvAe5tFRMXPNdMwDeJjC3w3PM3vjpQzzkfR5Pj7YKaVwrkrN0dN/uAXW4bOcsar6gImoBa6KFroAiKgiOy2retyK/tO/I9e2ZtEfvgqEaRwuR4AMfDlZ/tYYDDez3R5Vr3kPoLj+PWzA4D/8xcqhfx/Xednfo9vRkA4c5g4bjGZPTbEoZJ2OOXtcJ3cAUYhV6JkC9GZz+Zz5SV4jf4Lle9jeXycr7FFNE84PsAIvw+ax9bNwQXE1VCg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 09:46:47.6876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 7cfb52a9-024b-4f6f-fa7c-08de8e4142c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DM2PEPF00003FC3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365
Message-ID-Hash: QCZAVKZDO3C5BXTAARJ5PI3DPHGDPX3Y
X-Message-ID-Hash: QCZAVKZDO3C5BXTAARJ5PI3DPHGDPX3Y
X-MailFrom: Syed.SabaKareem@amd.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QCZAVKZDO3C5BXTAARJ5PI3DPHGDPX3Y/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Fixed PCM device numbering is required for acp pdm dmic pcm device
to have a common UCM changes.
Set the 'use_dai_pcm_id' flag true in acp pdm dma driver for acp 6.3
platform. To fix the pcm device numbering based on dai_link->id.

Signed-off-by: Syed Saba Kareem <syed.sabakareem@amd.com>
---
 sound/soc/amd/ps/ps-pdm-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/amd/ps/ps-pdm-dma.c b/sound/soc/amd/ps/ps-pdm-dma.c
index c6cd844d458c..04c014349347 100644
--- a/sound/soc/amd/ps/ps-pdm-dma.c
+++ b/sound/soc/amd/ps/ps-pdm-dma.c
@@ -352,6 +352,7 @@ static const struct snd_soc_component_driver acp63_pdm_component = {
 	.hw_params	= acp63_pdm_dma_hw_params,
 	.pointer	= acp63_pdm_dma_pointer,
 	.pcm_new	= acp63_pdm_dma_new,
+	.use_dai_pcm_id = true,
 };
 
 static int acp63_pdm_audio_probe(struct platform_device *pdev)
-- 
2.43.0

