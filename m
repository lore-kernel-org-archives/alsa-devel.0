Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43369C43458
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:03:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0566960294;
	Wed,  1 Jul 2026 12:03:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0566960294
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782900227;
	bh=oKwR4CkTSNx528SYIB6yNDrVfjBZsJwD8IMVETrjLMM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=X5hFaRziOpypn6rRlKx5tXerElMcLNwSffm6vwIVQc3NwfjaTuuprIXzcEnAdRTIP
	 EPHEmeJ0X2rl1EdywXK4iZtS0G8QAkCHhq6D9qOhHqNEDXRucIZxAdE2EEyU3N4qq1
	 YIBGIbQ50Vz6E++RCqNA6QhlGfdup6TBbOIGXVS8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 39AFBF80CBA; Wed,  1 Jul 2026 11:59:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C9905F80C98;
	Wed,  1 Jul 2026 11:59:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5F467F8077D; Wed,  1 Jul 2026 11:59:26 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.50
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1782899962;
	b=Fcf3HS2PqFpZuBeJ1fqZNlO6SG4R5lkwZG8U9Ve/B0hCc5oFNurY4U3S8zOFjXO6dlVm
	 uAu61ZDw58ppEup9ts3kBXDkw+lJY3NIE0czoIfBNyvW03O4wSCBwTXmJ8xZGLs/yQPYj
	 g9hDC4i7jlw0R54uVCuRS1FBRWM/wX81TvEa1I9GZqE6rPgF7I+huzpC7MxgUJNbwnfA7
	 yvzl9r80dx0m+dYLv494/fLaK5f0mT6CdrCT8RH/S4t/u8KrkkvPBxTvoSgkF/NNsw6nv
	 RqeYXFwDzjDMObm0D2Y9iSNkmVSGbDBPoaFZ+zEGWYHWYjqkFNCq2HGfkNSRodMgsUQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782899962;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=oKwR4CkTSNx528SYIB6yNDrVfjBZsJwD8IMVETrjLMM=;
	b=Eac8rqj/Ly2WS+Sf+b9oUj/sxRFoXIbTwKdMbTL+fT1TcHMLD2FisAJAqEX6ayEbxqsn
	 FTrVS0i2Y8ZVvLwS5A4FkpRH2sfG+Dmn90SWbgPNTKUXsRoQfEhnV0a2VxWEKipM9OCz9
	 8HdcwJKJTOYzjAUjVMiKjIGEqFXkKd+TkWpNXZ0Iz1dcXyZ/f7CpOvnZvLRuXZxyF66Zi
	 XM3S1/OqMLzkP1b/Mdt6eONnySOpc0runM1M9Z8xXGAx6/u9qlNZByS2CEp3OD9biQp2/
	 hb0dLp3sp8WzBSJOZl04fBmTc7plTfMvQ6pbpIukzKLM5ARWZJaoZmDQ1l3joWocWew==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=zaawdLxE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.50
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010050.outbound.protection.outlook.com [52.101.201.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 30032F80733;
	Wed,  1 Jul 2026 11:59:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 30032F80733
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=zaawdLxE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2XXTCCyikd816YUS8BiS2hA/6nMI08yGTvTvdTbU7QNlQJgD1JLkUCv0EpL76NrmNXlinTuuJWaF/lNOY4zD06dTcwFdWHb35e88+piBPmGH691gaep3iUOaDSlwGwRv0JQAfqrbUWaUBujdWZFzo1eEF8m36En1YVmSqaxf5/BIqMChU7n9btdRKdgpXqHGWze1swBs2q2Y55HEQlssfhPn4nhlnqiaIzbSPyL4HyjuL+oke7EglOpXwpiPYpHR1xdawFDqayF4tpmAVeoeZM1Wr6qsXTUwPtS730EIUhVrsEkGyvDiIARfBXjAfC+KFNXsVkFw53oDFSrLoL0Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOFAs+kvU8DNWFSeLvKLWmwIrKh6EbhNA7wEeVcNzgg=;
 b=Apwk9dq18eLUN9QNZRQz/ieO9jjfobR9r6fOkJyL2+SSSHGV6wRmZoGxt+r5SpjHD/VDTvAnZcIWFkbG0sOWlFa8Y18YjMF1ysUPTCC8swjSli37e+TSSKo/tPMnUFY25FoGjB/79qLUHGTw8pgs9ou8sIH7YjkQ3XkNyI9SAeGBbHr67QwyAYNuVSJ1Bn8RBPjaQc7HsV+vvhLj2/MKA5r8WBnH8o4mC749tQTcbcM4W3X2ZqSJ+sp/hLY30ySh4qQK3+JUlEKV9H3x8jSq6nYRmwegtD6UboHGbOZLA8ucGZbQ+ImMfE1ZG0gxVf8TXttwDteunE0CyOufoyKzxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOFAs+kvU8DNWFSeLvKLWmwIrKh6EbhNA7wEeVcNzgg=;
 b=zaawdLxE5RyRtvreqvP5Q4aiCRn8qagEwZGFfTgizWkKrpZ1cfu0ushN4BMX8ouvOODV097tgFeWmtuZ8jeY5vDzMASYh8lfoXxvlx5LPv9ub2EbwhEPsfWoyx9jMdjq4PFD4AVrzDLjiN2nvhDT4WtMakCSiYoTZ7s0q/C63gg=
Received: from PH7PR17CA0054.namprd17.prod.outlook.com (2603:10b6:510:325::18)
 by DM4PR12MB6541.namprd12.prod.outlook.com (2603:10b6:8:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 09:59:12 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:510:325:cafe::3) by PH7PR17CA0054.outlook.office365.com
 (2603:10b6:510:325::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 09:59:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 09:59:11 +0000
Received: from vijendar-linux.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 04:59:07 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<perex@perex.cz>, <tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<mario.limonciello@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 11/16] ASoC: SOF: amd: extend configure_and_run_sha_dma for
 ACPI signed FW flag
Date: Wed, 1 Jul 2026 15:25:12 +0530
Message-ID: <20260701095759.1012929-12-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260701095759.1012929-1-Vijendar.Mukunda@amd.com>
References: <20260701095759.1012929-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|DM4PR12MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e4f3758-70ff-40d6-e899-08ded75766cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|7416014|376014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	U664uJME2Otx4fHuBzVWcSwX5jtAeMZfj5UattY++/bMBaEw30MPN9kqwSL9SI0Z7lFmi7yc6L1VSpLl8/iMMfC1WEI00pNuVTHU++OBepmpyIbdsEAR+1Jbw0xfF1okf+oztscczWnw3V6+SzSZwuS7V/7pXvoG2i2eXQ2fq3sE69npNDcjtjYruaINOixilTN/jJJcDxvenBWeRCUSeGeJRnHN0Z+gawLwZwO5Rr6Q0psbADJGbuEGoGFvX9stnjA4aHGZkB7VypSOfpibVIBqGfIk32caqNtqnpvrRDXWfYKAyl4XnJTzctnQU6GFOAPyS9hgsjeQ6g/gzyO6f3/aTPTMWRASl2SgUaMca/W0/aFSyWKicuQBD2ykcitKzJGb7Fv+hB3G9OUuzDY7jY1qwqiKKG4a1hqa1qcDWrYwbF76NtPVm8rZw7aJS94/lFPum/uSUYF/fsVHvkW0fd9ovvKnZydbvEaSfDy7KE74IZ6RyGiav+CVDlA7va5Rw/98pmBQrlJ9t+TlrsbWrHMxeqvm3QPdfwKic5zTZBvEWzCMP1E89iF9KGBnazSFJAJBT3rerZSaM9OeLa+n/HJxiawBCYx4ny+m+pNBlaeRYsIhZmxB6/ex8KV5M/jLYanscfgD4Z8DFmNGardhSoksb/gaQH+85sLdzjSbsDn9ZHPRhNjL8Iu0iUfFO9ZVpxfNoi+AXZCEL58zlFOMIA==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(7416014)(376014)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	ProOo1srfs4F7mBZS8hP1E6HT6Pp7LzdgQjSfVzXl5JSVlVB0nRXkgO7gfwkAZIK9Wc8/FxyiU7EwuDWpNoqpyficbck8xFzcFgwSoqqehgBlsSCuwQhak6d2/MecTaDa/pcSHSdE9RfSe1K4pL345k5tlolLtIIr2HtBbK800jl2YjP5cSmHCd1slDx1OY1+Git6kSZjqiJxQ89nZCtEQKuJiqwAK1zrwWLfJ8cPBlXrDZl66iIHpxlAn0OTzCltwDgZmomYD3JOdMvpOptiNYpxHgjtgtKBBi7poN83gRdzKXkhP2nyV69HhHMbuXQjvEvHqBj6vYalbJUD8ybi2o88mL657TqE5r0Q4Ez+7yAD/w8beZbEDqwbcT0yZFfl/7D+TqHcqonI0FpI+FeR8otClWsLO/AyQL5bg+6GEiqWN0dCVAni+iPihpJ+Xem
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 09:59:11.9389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 8e4f3758-70ff-40d6-e899-08ded75766cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6541
Message-ID-Hash: IDAMINJWEMJLPSOU7IVO7I27YBPIKRBF
X-Message-ID-Hash: IDAMINJWEMJLPSOU7IVO7I27YBPIKRBF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IDAMINJWEMJLPSOU7IVO7I27YBPIKRBF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Check adata->acp_sof_signed_firmware_image alongside the existing quirk
flag so that ACP7.B/7.F platforms configured through ACPI also get the
SHA DMA header included during signed firmware loading.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/amd/acp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 5df984b93dec..c2143821fb83 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -288,7 +288,8 @@ int configure_and_run_sha_dma(struct acp_dev_data *adata, void *image_addr,
 		}
 	}
 
-	if (adata->quirks && adata->quirks->signed_fw_image)
+	if ((adata->quirks && adata->quirks->signed_fw_image) ||
+	    adata->acp_sof_signed_firmware_image)
 		snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SHA_DMA_INCLUDE_HDR, ACP_SHA_HEADER);
 
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SHA_DMA_STRT_ADDR, start_addr);
-- 
2.45.2

