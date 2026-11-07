Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569D1606A326
	for <alsa-devel@archiver.kernel.org>; Sat,  7 Nov 2026 17:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=gdGynFEC;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dJiBQ312
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 62143601DC;
	Sat,  7 Nov 2026 18:56:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 62143601DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794074192;
	bh=UsSJbwx/fSM0YXjcOHBMSm89rOFikeOqVnK3NaqiZ14=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gdGynFECgCbQ9pZccrKxYupXoW/TWKCtIcgrRzfmREDaIFYBv/frggOJ0TptX2W+A
	 VPMAYWCf9CP6DQobZwS7Udbpc9rTJ/wHpJhpduno5ChxJ8CPqhgqY8Vy79kBEDTZP+
	 FIAGrnTbNQUEb7aDfWVwLz1muiXSFGPoRZ5J6+Vw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2B674F8067F; Sat,  7 Nov 2026 18:55:23 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 94422F805E5;
	Sat,  7 Nov 2026 18:55:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 68E2AF8062F; Sat,  7 Nov 2026 18:55:18 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.46
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1794074116;
	b=FxWRloKAF2jiwmn6qx6LDgQmgqSbacnk0V6peT1ZpjsMTPLHvXJlceuBAiT77J6bz1w0
	 7YxguxQyRrmzS2V4AJCMeKODtiSUd2q6HD1AdeT+gha26c8KVbpYdGHgAFlMZxyq2AHpR
	 ukJqNQa3i1o/4agiWp4Ww1J+HUiOup9XHOugIOoNiyiBNqlut0izAda6sa75YTg4+J7Gz
	 Ouzx0usYCumnD8TgPFTrRtFrmyZfPI/9d6oGirTltTSakm5cX4mz/8pE5aMTSeQ2sQkAW
	 vDt2YZyn8tznnTxhq/zJA4eg3XLaHG/r/kPW8xFRN3F1qwtY1oIAF42anHji+/BNVtw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794074116;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=UsSJbwx/fSM0YXjcOHBMSm89rOFikeOqVnK3NaqiZ14=;
	b=HMLz0OkhCSWTKr0t+s1uuoXUmoeEveaUawdhQw8ezCOfESnf5jPI6kMAojlnlamPi043
	 IiwGXRo8A7SSd8/iXdnLyFzD9zSUvsXBM+ODp69RXkKFWYYGdsKfxq19EvjmTnXf8Jl8E
	 3AVXYWrk8DAFFtesyMDzKvF3Lg7u+f3M/waYQgO6gPkGAI8+Kkkjr1PZRRLFQ+8Jae3vy
	 yzfMVCv0/neSI8VLs9CTiFvqePboYn1DX/FD/2/6d4zGK6f+1HFMTuT5TXDe6h06S6MrC
	 j+kiQDDPdOyEsN1OxFDUaVXjFaiJ/kysC9Q1pwF2ZoNm0kJAiLfQTAaGaMFGluc59mA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=dJiBQ312;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.46
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012046.outbound.protection.outlook.com
 [40.93.195.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 861D2F80610;
	Sat,  7 Nov 2026 18:55:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 861D2F80610
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=dJiBQ312
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYBdNQS9VnIDkzH6BM4J4O9n/1zTdxulwdcNDmIhaNU+3+QczaDi/bmBcSvPoEJiOIKwn4WYTcQnSoAAA2n6lA+Lzg22NKIf48d88/9Qvc8D4ZPwOAe6SAqQl4Mvu/BJ4g5ICqaoTbevHWKUg3PKXRBNmZaXzao3bMfNIe0xTCB3bf9o+lCytTF1bb/bcgRV3BTDmoLDZUxs+mNl1L/5FFVx5Expu+3AckxJrxmUUh4Nx3/0UpwWtkPNLzmGBEPqw9z3I4GsXZkamHRzYpLjcJZ9BaF13PumXkTiSK0d8Vmr8LwngTgR/XSa5QzX5hSDFdCySvCUe7Z9xrULKRPYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5NBdpsOyG2OHoxN4IymsOvzNhtvuzLuRq+PFHZ8Yxc=;
 b=jHiary48vlGnAaAIrgaOZ7FQC03asZwI/gflYtmpdXcQ729XMesTxL9wyfVXt38Sih6QDVMCmm4dKcfFZyj11KKJkICMkvpMpgw81mKUtB4Fz5YCwMHngstEet3qjAI4cETKajfgxX+qnWDoZ1fCnpyoT+/F4/St61LaNi8NhN2eLFq2QLai48lgfgFavFjg/QTAyzVf1EusmoE7xrDvU+OYQtgCeqPExRSY8y9J+eVX+vSpv4pOHlaZZRBZjcIyfk+q6OyFwU7nPsMd1SEJmLqwpIeqnnzq3+jMQhMW9/Hl1P53voRiIsWMFVJKTqrAFrAxMPLEbxjYsNOM2k5y1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5NBdpsOyG2OHoxN4IymsOvzNhtvuzLuRq+PFHZ8Yxc=;
 b=dJiBQ312tMSY6jLnkRIOodgx0JeM6UW7Lfd+8KBVYnoObAN67hq0wPRl1E/4YWJbYtOrApbRTUh20yjzGCHdrm7Dk2cA3cWPewXUqG9XpvjrDIfOTqsNxAvROcWmr6EJK9MYXxpA0qJvnuKT2/kqY4iOyrYiMK5lEbTFPB7+DcA=
Received: from BN9PR03CA0093.namprd03.prod.outlook.com (2603:10b6:408:fd::8)
 by MW4PR12MB5601.namprd12.prod.outlook.com (2603:10b6:303:168::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Sat, 7 Nov 2026
 17:55:07 +0000
Received: from BN6PEPF00000071.namprd03.prod.outlook.com
 (2603:10b6:408:fd:cafe::5b) by BN9PR03CA0093.outlook.office365.com
 (2603:10b6:408:fd::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Sat, 7
 Nov 2026 17:55:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN6PEPF00000071.mail.protection.outlook.com (10.167.248.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sat, 7 Nov 2026 17:55:06 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sat, 7 Nov
 2026 11:55:06 -0600
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Sat, 7 Nov 2026 11:55:01 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <vkoul@kernel.org>, <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
	<perex@perex.cz>, <tiwai@suse.com>, <yung-chuan.liao@linux.intel.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>, <Poojitha.N@amd.com>,
	<lee@kernel.org>, <Vijendar.Mukunda@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>
Subject: [PATCH 3/4] ASoC: SOF: amd: guard SDW IRQ work scheduling with
 interrupt_enabled flag
Date: Sat, 7 Nov 2026 23:22:28 +0530
Message-ID: <20261107175339.3547918-4-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107175339.3547918-1-Vijendar.Mukunda@amd.com>
References: <20261107175339.3547918-1-Vijendar.Mukunda@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000071:EE_|MW4PR12MB5601:EE_
X-MS-Office365-Filtering-Correlation-Id: e77ba783-056e-4b89-f266-08df3cf84223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|7416014|18002099003|22082099003|10067099003|261102123227099003|11063799006|261021123027099003|261022075727099003|261021121427099003|261009223027099003|56012099006|261026121527099003;
X-Microsoft-Antispam-Message-Info: 
	mkRLfIIQeXNvTcRFvQUPtYassqxgXfaYruX4VOO2w6gY142ZA7sYB9eU6SJzc+/2/koIPvNZWwNfUSYh4nsrcg8eRCuSSMMGp1W987xuYqUxExq2hjjxzls0dF2WUya70gpDEVmudwYIk7j9NlL7Y+Jch3Xz5AnlzjYIcRGOlGL7inZekEiDqQ1hh/yqM5qJXGJZLf2FZKO2/7usSbowkzM+DM3YnTPn+yF7flSbHyoaBVzOx3YwK8ECLlWrFmc+yjfvBtECZqUEPMV0V8lNA5BV4HZlrZsFZj9Rz7UECBc0T/tcfH1k9KnAjSGp9nD9/RhQLFRtWNWWLdAV0WUMaBPoDdPCC2bCkrQEnwU/KtdRPxMbSmKjQz9r0u6eA/LHBenYt33XUU7axjGX8F2pvE7lUEYdKaldNhwuIb0p7tEmw/vF+8IwqCPA6K9ozxCqnRq2OAGUEKsfo3dFgdsZulPTsy3Q/fmcA9k4SnbsU6G7x4UsEOJQ0NEMqrT/Ic161pYu4FB+Yodl4GXyuRic5QVLlaVNA+xO3hgBCVd38wY8NBslHU0uXfNATA4aYwr4nEKcYF4opDCmgY1kZJU26GvqrtRPxk+9GDzdA62fkvJJPifGk07eA672hQSdWB1gatsuRQnXguke5CRSszGidQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(7416014)(18002099003)(22082099003)(10067099003)(261102123227099003)(11063799006)(261021123027099003)(261022075727099003)(261021121427099003)(261009223027099003)(56012099006)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	EKRL6TSlRdVgeDyJnEcT262NLT4EW5G5wS7tPY5gzDcI/PwUDNUkUn9xzOEZ9neXYkO2iSj2NSpee8lrpoTrtVWRi2U166aD/8HcaT+ls/UHfYsvtFl+DarPbPhWfiX9rzKcjeGZKpeT6exFk0xGiwx/1dCbY7+58GAfTxmWeH6EJWD0p1lMR13/Ns7pUQ0FGNJjflRokRqOuhAax2gAafyoUR/wEva4iolTcWciFX41rN7bEghoCT0aY0PTlFau6tv4WONwwYS1HbPsXXcwUcduZ6iLC/DQSaEx8zuP5DJb9D9/TC4cFwfdw09QPkqvI5OffnAd1aqw0jlWwqTDie0FhixKQpRr/e+pvZWRSuXwt5gOGh2T6zzj776so/OLcBDaIDrb3xhGcXvQhVEdWdC4tsgKjAA+Sm6WaZLx6iwFCqxWG4teXDxctHGbdaG+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 17:55:06.8712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e77ba783-056e-4b89-f266-08df3cf84223
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN6PEPF00000071.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5601
Message-ID-Hash: QJIWYRCOSTC3IPZUY4VD2OTAMVISR2OJ
X-Message-ID-Hash: QJIWYRCOSTC3IPZUY4VD2OTAMVISR2OJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QJIWYRCOSTC3IPZUY4VD2OTAMVISR2OJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

acp_irq_handler() in sound/soc/sof/amd/acp.c called schedule_work()
for the SoundWire manager workqueue guarded only by a NULL check on
amd_manager, the same gap fixed in the PS platform IRQ handler.

Add the interrupt_enabled check so that an in-flight IRQ arriving while
the SoundWire manager is being torn down does not queue new work after
amd_disable_sdw_interrupts() has cleared the flag.

Reported-by: Lee Jones <lee@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-ab458b2e-f505-4a41-8238-a93ceb5d9c77
Fixes: 96eb81851012 ("ASoC: SOF: amd: add interrupt handling for SoundWire manager devices")
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 623e016f38b8..5c4eab0be497 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -586,7 +586,7 @@ static irqreturn_t acp_irq_handler(int irq, void *dev_id)
 		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_stat, ACP_SDW0_IRQ_MASK);
 		if (adata->sdw) {
 			amd_manager = dev_get_drvdata(&adata->sdw->pdev[0]->dev);
-			if (amd_manager)
+			if (amd_manager && amd_manager->interrupt_enabled)
 				schedule_work(&amd_manager->amd_sdw_irq_thread);
 		}
 		irq_flag = 1;
@@ -618,7 +618,7 @@ static irqreturn_t acp_irq_handler(int irq, void *dev_id)
 					  ACP_SDW1_IRQ_MASK);
 			if (adata->sdw) {
 				amd_manager = dev_get_drvdata(&adata->sdw->pdev[1]->dev);
-				if (amd_manager)
+				if (amd_manager && amd_manager->interrupt_enabled)
 					schedule_work(&amd_manager->amd_sdw_irq_thread);
 			}
 			irq_flag = 1;
-- 
2.53.0

