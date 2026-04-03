Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6238EE7E362
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Apr 2026 10:07:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 887C3601F9;
	Fri,  3 Apr 2026 12:07:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 887C3601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775210854;
	bh=W0yun0JjCaWJ63h9WhtPJjJOHyGjRKTg0IDU5raKUBs=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=GC8QK3MFXdp94fOWkzrkDD2RCnF4BnFUPkUzWqMMfAMLsvDoQDYAyPgNezSgFmeJo
	 iyAbXp9vkPtgx4Rz4wm5LabbwgFKl+t3ggHOW5Z53sI8vffM3hDooj8tkVg2Kso+pA
	 JrlUD9Fi17wOD1oUhnd382KJVcptgJJMZcTvJ/9E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 78EDBF805F6; Fri,  3 Apr 2026 12:07:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D5184F805EC;
	Fri,  3 Apr 2026 12:06:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 30CC0F80589; Fri,  3 Apr 2026 12:06:48 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010040.outbound.protection.outlook.com
 [52.101.193.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6792DF8011B
	for <alsa-devel@alsa-project.org>; Fri,  3 Apr 2026 12:06:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6792DF8011B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Cqp/Jl6X
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIpKkKWkzWGzos9PDm6QiMCHW6U0eNiCURs2r4wZ8qdbwBHRb9ao4qZdNnjPepxOTylL3QOv6R0yJOGiabjXSLuVvgX2dh1WlAzVFFJPd8Gll0agqlc2m6fxV1ngFE6r4WHoVxI2REU+bS65ejP330VygJ5WRCPDXMcc63y3rmQytL62JbHAsWja1h6VNzOPgFUGuBEn0NTaHUlzNiCaMHfUpf2f4URj0Z4rVC5PNGcp8ZhNkTZqA8hQ+qvvtnWFiXxA4ZzJV3IrlCHP6BzREyVYytK/+7XCHIcSNIcZ2d2gHLMkIbKWNKl8c1YW1UCKWpkkSMD+9o9+/EpuYQxRgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PX55t48KkvihFFWb4Yqv9ieaZUF2FA3VvQwOCBbGofM=;
 b=on21av1MN4R672TWgkgroD9oKIQRhW2I6b1ewPOhYe+gYeNl1gmf6NNi0JU/uoZPL/nzmb0VKC+mn3nIYzB+Dtx9sMcafTD1dt+IevrgPzFI13uIyKRp9S4985ZQBTjW/mzoLiJqFBJwfFlNvvls4dQ8MN9A1g7TqnqTqlKlloNyI1PG2Ip5waWwL238O/jKvZXL2HoHrq59sy5ZVJmVQ44Ia0g4HwVkm4gUt26YADynupOXTaB62AEuemsPcJmkDdLADnes+hn5JdX12aosHT/0Ds4n0RxvGQxTKyeQVGVQ8fZA7W9ABIDr2s0TxP8GMqNckOVAnHodEwoEJOy2tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PX55t48KkvihFFWb4Yqv9ieaZUF2FA3VvQwOCBbGofM=;
 b=Cqp/Jl6XBjlzKJWmx704VvFZdLLE1YiK1ikHDzeA1zg8ZWdEFH4UdAAsD16OqA22wBJ26MmFvQ6PSNrgTm75e04MzzGYbFdkuLAlVKAhVZhJ9tOnzZ2t5eCe0aXyaPigVFHRYk8WkZ0F5o51NYIAH1FAn/yYUVt2hQd5uo2l6FY=
Received: from DM6PR21CA0030.namprd21.prod.outlook.com (2603:10b6:5:174::40)
 by DS4PR12MB9561.namprd12.prod.outlook.com (2603:10b6:8:282::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 3 Apr
 2026 10:06:35 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:5:174:cafe::62) by DM6PR21CA0030.outlook.office365.com
 (2603:10b6:5:174::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.12 via Frontend Transport; Fri,
 3 Apr 2026 10:06:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.0 via Frontend Transport; Fri, 3 Apr 2026 10:06:35 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Apr
 2026 05:06:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Apr
 2026 03:06:34 -0700
Received: from amd-B550M-DS3H.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Apr 2026 05:06:25 -0500
From: Syed Saba Kareem <syed.sabakareem@amd.com>
To: Mark Brown <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Sunil-kumar Dommati
	<Sunil-kumar.Dommati@amd.com>, Syed Saba Kareem <syed.sabakareem@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>, Syed Saba Kareem
	<Syed.SabaKareem@amd.com>, Venkata Prasad Potturu
	<venkataprasad.potturu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kees Cook
	<kees@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	"open list:AMD ASoC DRIVERS" <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2] ASoC: amd: ps: fix the pcm device numbering for acp pdm
 dmic
Date: Fri, 3 Apr 2026 15:36:17 +0530
Message-ID: <20260403100624.676953-1-syed.sabakareem@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|DS4PR12MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a250cb-6662-436e-bba3-08de9168b075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	BgTXNK/+IERZryIyGKfn7K5QsyakBiXdgObNMlSkjiBZN2b/yV3tGYl1VfUEysO53fxzYwbtc9uLuw5u+CnDac+t+NPOpyGwgyFtGDDJLGd/11mCktzCtG6zoPjdPxN2bvpGWPt5TDeB2qpxJDp7WHzA8CJdqD8zk+rA6mr4pg+BpevsSrJ0O97Yz95HByfCwPcLA+E7CrZyvOPqZh2b/AnavNeVM4xfEf3iD5s8EnrEyA1mw/XT4ali709vKne8ZeOwFOOLRWq8XV9Y97PS9S5wg+8T1m5YwsJ+xgToGjLkh12GHoUhHfHLjjbgVH80q8veznrAock4GH45Hi1ZQVvlEIW1rMXdlmGQ9+dBoINffDH6/e10FO5JyjThKYvwjKXAxYSu8jsP9YuW0U8No7FpgOx8fwnjFu9E3ud3GnlKUUVdb8YmoQxk+O/FkHSIa9AAmb3oNS1y2hUtRe+cjdHz+mx0uf3zmXn7YVGKFDmiGTriU8/VGyF40PZGLUCLAMnGUeI0eb/mR7eRYsNS3HfwZ/GyJfcNPNOdUdV0SMdsFM+hOf0hzbhrsqr5iA0Eden7u1WwKMFRBnIKvzgtHPJ5jh/2zwayR7TbPNDwkctN7vTqeqKHWipziX/ZehI5xC1YHNseDpEn2Ixv/vu+9/9MxM7LKbQ84eWkIbr5TeSreGAUcqha6ctXUyBsw/O2k4yrxkP7VHe/xoHOxmA6Ion6zsNd5ik4wHCNVnRYlG7zyVfdgkJSyCkkzgKOxymHNsfJp0kpmZWK9mzEehQquQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	m0rWPTscSKk93ja8BfOmVUx+tMkbHIV9Uv5Y9BEF9NlBhD8IGZZV3hRKmVnJ7oVzFs4joZgGwgL5XHDMl3vn5ey2vWL8lNsPcGnMVwmK8xDQ2EgaaEOU8zMwnzE6ftMUisRvxSh9iZWxhIPyYBLY3YXgs2QBH4Vstu7/snSBk57cU9BDjstRvrSTZlpntYIcsHTx6tpmDsSWGYbebNfoSUVHUR2W92+0N9qwBNjJVUM03U3DcWwGi7HgZJaDCMZE7CZmOWpWpKOjTkdfPAXikp/hUfJfxLIryu7PrkKPE/D8dzMGmsKjGFkF4zlgVQ+uDB34xwApkynjTKZABywy5zLx1LFYCEHywiAUxR3zdpSt6bzBctxr7jw05Czq2ej4/8eyuff/sJJwlfQLIqm71O5z/ojR+kBJy11PJpLAKI/YnhtOVnGfna/AZ/JSl5K2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 10:06:35.5777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e0a250cb-6662-436e-bba3-08de9168b075
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9561
Message-ID-Hash: CN2GEK4RVN7LDFQ6YSZ74O5DHVG6OEMZ
X-Message-ID-Hash: CN2GEK4RVN7LDFQ6YSZ74O5DHVG6OEMZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CN2GEK4RVN7LDFQ6YSZ74O5DHVG6OEMZ/>
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
platform. This will fix the pcm device numbering based on dai_link->id.

Fixes: 33cea6bbe488 ("ASoC: amd: add acp6.2 pdm platform driver")
Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
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

