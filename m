Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCC8606A31A
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Oct 2026 06:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=rtvSCpkU;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=p+zMrA8t
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B41026021C;
	Thu, 22 Oct 2026 08:10:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B41026021C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792649434;
	bh=qRYAd/L0SWXXN8TCJJBTmnd+JBe0gumou5wtRL21zFM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rtvSCpkUUs5G/yZkeNWy7dgaVpLXSKSKi2eDGbBlc7aAN9HCbOCvtrX9q/lk+pjCl
	 GukU/58kyhP2rLUKhGOdnkFn8JllY0ICQkud1S1acfoCWQ0ybBmLmB0viLjqpZEVQG
	 RttcOHs3Av31SBTngavJ/ECX4GIv5HPPnyuyCIZM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 286D0F80678; Thu, 22 Oct 2026 08:09:17 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D089F8065D;
	Thu, 22 Oct 2026 08:09:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C510AF805ED; Thu, 22 Oct 2026 08:09:07 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010070.outbound.protection.outlook.com [52.101.201.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CD701F8003A;
	Thu, 22 Oct 2026 08:09:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD701F8003A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=p+zMrA8t
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJOhuZvOEZ7F3VQwEK7vXWpX3bdBWIn7eBDeU80+6IzHFz0D40ErL2BLYpOYDSbXCzCZkn5XcCRuS1xgd3V6alrDMyKk68UPwfkzmzq9S7rYqsZwsJEK8QxBVP2+YuKm45OJ+AKnC40GKjMp7JrKlqXLDYd/zFvx/tiLq8KLmwaOyi9t0kXHiYxO5fwysayaDxliwGcGj7nm3xJMa5glRhTXt2CBXUX1esOkNDlhGq42bb+TsrY5fRYRVhwH2ZVhSzjKcbdeUYVuM88wBs/+a2Fahe9txGpFlpPmG7A6DveFIviifNyEHylNNnimDxM3PlVwfl+YtNXakhszghduqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zC+j6RR5YLuxmHD20yKGU3foHh5dckU6AFXHlONT+RY=;
 b=pk6QjFDn3oXZPwMc+9BeOLF5ACR3fOibn4Sw8WR6pCcscV6PvvV3igsPv0aVmKQGJlI1aCbq2AiD870e51wOs4aBAA45xJk8X8xKu0fNjhzS7VJIXYqm5m+o1pa2wTHHOgTyfms9JWNbJyNg9tUwifr6xhMB/5YiYS/JuQeWzL5VPBXa90rBjBWM17mU5aSU0Nf1BVVqIrjAMOY+XtYWmdfFp5fGFDz+8CzI2IPkBckgK4RaGnn0AMx481vxBs9pMEPjaRdTMN076wgPl1Xt0WXdTMkv0i6OYuR5U0MGHJ/3a5I9lu1E3AOqOvROWK+dDWqUOv7N3uq1Y2eh3OCFqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zC+j6RR5YLuxmHD20yKGU3foHh5dckU6AFXHlONT+RY=;
 b=p+zMrA8tpei2aG40towTsPXx2F8CHMDxwqD/ns5cRymu47JWXzW1sw6uFrM8cDYYKrxVSP48cjWPx9e/GYKM5bO4a5taNo1JvGMqna6gNna4NYWQetBGX7dY8bk7YzzkeOgSNXXK4thsNmKUIXizjnfH3YbQQ/TdCm0wTxVOLoE=
Received: from CH2PR07CA0047.namprd07.prod.outlook.com (2603:10b6:610:5b::21)
 by PH7PR12MB8593.namprd12.prod.outlook.com (2603:10b6:510:1b1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 06:08:56 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::3b) by CH2PR07CA0047.outlook.office365.com
 (2603:10b6:610:5b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 06:08:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 06:08:55 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 01:08:55 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Thu, 22 Oct 2026 01:08:50 -0500
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
Subject: [PATCH V2 04/13] ASoC: amd: acp: log ASOC_SDW_ACP_DMIC1 quirk in SOF
 SoundWire machine driver
Date: Thu, 22 Oct 2026 11:32:14 +0530
Message-ID: <20261022060724.1814741-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261022060724.1814741-1-Vijendar.Mukunda@amd.com>
References: <20261022060724.1814741-1-Vijendar.Mukunda@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|PH7PR12MB8593:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e4d748-9887-4172-74c6-08df3002f478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|23010399003|36860700016|261009223027099003|56012099006|11063799006|10067099003|22082099003|18002099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: 
	3tlID/qpSmPkbPqNByq2FMhNc8W2CDTO087WdE25XUXETxoK/66abxFQUxuYZ7OLdKG2An+luK/DCJhEnR0s20zqhN9Sw4XOvfK6oY2lLu60STMcqWP79ndSuoBRZFgS4O12+fzOK8/MDZYAWPXFRDO+LHubme9YoNFU3ZyCgwcT5GGUGqonHWDiVb9HMXz1frSf4F0f0E81tpZ8zbdwwBMeIiy6eqDV3UlWuS6bpEfmUuyeMNU4rkyIYtI54Bdgzl7FUiYZ34bwRAAXf7/pRHZDN/nkqPf2eqhOBQzbiSQDCIGv7WtaoSYLKNFArJ0IHC1jyughnUr4LrAAOLYRQTkrR05fkdF6KRrjDjoe7cpbXbZjSQBl9Y1CotQbGdTslkSSj1A8YZ4VB7yJFpVErosuzIgwtdHZj/mV41oOQhAuWFToDsq7M5PWWbE+AGgg0xG1p4RvSFURaWfi/sVdJf84U0zigOZbjB3VKVPzeiEomCOPn+SiSwB7cU890/GKt53VtdBF9P21AJUwhuYzs3vG2RgokgkCsOVgrmQr5grQRe46FpQa41DCPSd0ow0ZnAOf9WQQRkyG5yR3kqKPEQ7kLSDvbP2/IIjhe8rHnxbtOPdjex179gXmWgESc5L/5L3RxZbboRku5e7sIaN/5SZ3X1a0IRrRcaAbW5HxetBDpRfLpO8R9k6Kej1I7wJVGoUO1hHBiu+3ni5UyAL3Xg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(23010399003)(36860700016)(261009223027099003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	f+LH+63sc6FTiCtd4rtQDCMaIxy0nGxUdqPpgktzHO4tbwzGBjR5xtiXkml+nnS2QyoiTJ/O1j8C7L0k6Q44c/Y2ZoylJG89LAjSQaTWNV9YZOXJJrwI/MIJ3isuyz+1Nqvhd7yYMh/WMpKAL6WWz+BT8zB2PEqshb6gGB25sWLmiUD4O1mk1SaPylJpmB4V1x61ys+KiF7/NpuMubbxBBzJ9QqULOrcpbrZ4b7x1x22jgIyi9L5X4yMXYfs0pb8Aq3Ok8dIylI3s/fKsVSqXOQR/MNVsNFimdKkzyB51LRHK9DMFNIgr4RB1Et1ZQjcGHqI+YQnJXy+0chn+caQASLUZhHwj8AsQwZc0fmlcMWfWX2uveI5vRXcnfYvUZRAwu+YKgJkdHLHoGlupa6GxDVZwb8ApkSi6eMGW24cn+2GdJtr0X7v22jCg12XCbbX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 06:08:55.9201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a8e4d748-9887-4172-74c6-08df3002f478
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8593
Message-ID-Hash: 5MCX42LX4Y4K3AZWPGSYEDXXS2XTPBE5
X-Message-ID-Hash: 5MCX42LX4Y4K3AZWPGSYEDXXS2XTPBE5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5MCX42LX4Y4K3AZWPGSYEDXXS2XTPBE5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

Add ASOC_SDW_ACP_DMIC1 to log_quirks() so the active PDM controller
selection is visible in boot-time diagnostics alongside the other
ACP quirk bits.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-sdw-sof-mach.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
index 2fb5c7ecafd8b..41160f47b1201 100644
--- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
@@ -28,6 +28,8 @@ static void log_quirks(struct device *dev)
 			SOC_JACK_JDSRC(sof_sdw_quirk));
 	if (sof_sdw_quirk & ASOC_SDW_ACP_DMIC)
 		dev_dbg(dev, "quirk SOC_SDW_ACP_DMIC enabled\n");
+	if (sof_sdw_quirk & ASOC_SDW_ACP_DMIC1)
+		dev_dbg(dev, "quirk ASOC_SDW_ACP_DMIC1 enabled\n");
 }
 
 static int sof_sdw_quirk_cb(const struct dmi_system_id *id)
-- 
2.48.1

