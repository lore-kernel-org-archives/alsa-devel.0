Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADFA606A31D
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Oct 2026 06:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=SXr1uhSf;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Z2UKcEIy
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E5256601D9;
	Thu, 22 Oct 2026 08:09:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E5256601D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792649383;
	bh=M3x0JTQFNPZzlx6rbaZXMCAaYDEAm+Mc22jUoo2tQUc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=SXr1uhSfbo95FC8grCTMd7qJ1UcCSrF+nPKp9c97GhiaG7+2OQPlQrY9JvecBZMz6
	 VAUy7EG2pn/TINqwYWko4L+B3xcmm/idNTFfsHPKP6XUcASjb50s5CIcWSwZvwpNRr
	 QfmTK8z+xAL9Hxwvi2kc0XayyXZbQHZk39WaRHqs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BBDC3F80603; Thu, 22 Oct 2026 08:09:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 34483F805F9;
	Thu, 22 Oct 2026 08:09:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 35EB2F804CC; Thu, 22 Oct 2026 08:08:57 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010070.outbound.protection.outlook.com [52.101.85.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 400CCF804B4;
	Thu, 22 Oct 2026 08:08:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 400CCF804B4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Z2UKcEIy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVwIVsHE94F1+l2wLAdTm38GX+ypg2lmyiUK5WV2JTm6nEJDw7c0ebRfEIUymfkbEfvij5FEmyszi9MLHAnLJgz4R3Rmc3O5QmAr8rjLu/kScq34YBxg5bOHG8W99n+zuUfzi35TCl5ykHf8kJS34mlglH7vgyo7qEEUpuvydggiZ6robfz+8VteLN0BYGFNbrzCQvHu7VSiA7sBEx4VX4Vb7TjCsala7V5fQ7urvQpStqfzpbRmikPfYiJxLOq1dOpYxARFIMsvrqrWkHWCdOoSWNc9bGiUcqUezxWv4yg9pCy0QpNJENMoPPDf1KSMG3cF9mz/wTGbfUGypVeo8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LRNJpbQ+fV3P8N+iK+VOukEtIWc5Awe0abppaetwas=;
 b=OwpXAKHTCloSPgestDjIGKxEIUh2BmitymkXyUzzFAahZGkJo2Pbwf+3TnLycx8g5H4kEqvBJbw3LLW7CxOdbbB2dBX955dvViCUVEV6qKQgBL+5FjovludxC5ZXOvs1qlNng6fCMhNbhW1vzdkB88O3IaXt5/uyT927W7VZJGMxLoO9U9J5ojIIThrZMMuWxQpuPBdine+VZz/oIhSwVpeIiV0+LJ0sGac4xaRVb9ffh+pJGnbSDUVwQ1t9q3k4/7Zfo3j5IyFhqB0HITP0JlFixX+9c+bELLPzPn8W83QmSU8Wfqm8wyO1R5w7Mas6+ohU++XwrIj+7cAqXHxM5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LRNJpbQ+fV3P8N+iK+VOukEtIWc5Awe0abppaetwas=;
 b=Z2UKcEIyzWwxq8G1JfMsL3Nk/rQqni+YAS57yPFTjZViuOii87lZWUB6NIEYBpBrCmf1Nqf7VlU8nhZs4wkCBINooeZxC0hLMzAb5s4Du2rYWvH/eVvfcqZTTABdEsca3THVVoS0GSsAhrL9YMyQ/HY0a/IktF+54JafcH4Wshg=
Received: from CH0PR08CA0029.namprd08.prod.outlook.com (2603:10b6:610:33::34)
 by PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 22 Oct
 2026 06:08:41 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::11) by CH0PR08CA0029.outlook.office365.com
 (2603:10b6:610:33::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 06:08:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 06:08:41 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 01:08:40 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Thu, 22 Oct 2026 01:08:36 -0500
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
Subject: [PATCH V2 01/13] ASoC: amd: acp: add ACP7.B/7.F SoundWire link count
 for machine driver
Date: Thu, 22 Oct 2026 11:32:11 +0530
Message-ID: <20261022060724.1814741-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261022060724.1814741-1-Vijendar.Mukunda@amd.com>
References: <20261022060724.1814741-1-Vijendar.Mukunda@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|PH7PR12MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: 415cd978-9039-4304-63d0-08df3002ebf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|7416014|1800799024|376014|6133799003|22082099003|10067099003|261021123027099003|18002099003|11063799006|261009223027099003|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	gHQPisTbBJlQjXnhOU65SufaXLplyU4zb1ZMZy0gGtozSmCoMCqAgEyPZMwplJDMvJCf5zcWWnBF1AV7zPvHVvKYE2nP5XdFNzgwb1HMtyVFJ30oRFZRG7YsEXQNZjrNoXW7R6yn0MAVqt8kyBU3HDzZyqu30aeYjfaXjVU3ngqiT+h/VZCUNhew1kyE5X4lw2NgrOSyMau+x195gERWBBzUUBzQZmNQ8Q94GNUYAb7/unW+NvmmK5SishD+yL/UdFDk3bfq6yIbOi7kaBC3Qwhd3Qt2tkwGqOnjrkq5chP43TLtdwyqmnwfvYg24kUGa+tZ+q9gecGqqBwj9pGIg+6zJeBtryGwpDv9UmunGn7jJqhTwjn2+rOn4u3zjdKjFpHxCDf5fbuCFsQmzokPwmdRr0L90v2jixa+s0auV//trHt0mK/bvjgjJz01Jy+y8F4vfh4AEoskT47KWsb3QDPpHCc/M6n1FG4yLOmBlXFHo4ehDr05z/Jac4a2uARyt5A6gHY1H5RLZE9FClV6b0Rp/IAchxZJhN4jJieJ5SczGsfOB8UKbR6fIEYQ6yNhKlsIIwh29XuXgDadOk3mygw+NjX1mpEkK7Q0Is6kgCnt1XrYh+yGZLCtwRW6h/QsiUSd1YtaftF1rjvFw22BoHhmPg8mlmS4vsznB+V/SYHvqKWzGaVQMZtWXsM61uNo
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(7416014)(1800799024)(376014)(6133799003)(22082099003)(10067099003)(261021123027099003)(18002099003)(11063799006)(261009223027099003)(261021121427099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	vYHvpYeujNOExEOsMs1mdcBtsdtI7DaAO/Sydgp0Fg3shzRiDemb0j16COQu9BMnTLNaef63myxUjo58H2N8F6gXG1BvY/aHE03GctyzYQiKLXSIi9npG1jZWJ6+lxswxWcIsj9uzVR/KjW+ke9xLvTaq1sveWl3L6b4uAz4VbDxR4iWprYCj7pMOqU60NzQgcn3up+xIug/dS9RFhYq+pjRMjs4YfiC1/aozG5NS8RoAkGwjyda/X372XxmFL4i2wsAGCBcjowFzCxyDl/5JjW6CgM9EvTQ0Al9itOWO2q1Hh2o2hGmDY9krM0jlORusdZeJMoPG30zN1ippsuNUxb85qS3CdHLf7gpPb0EOI5zznGvAEv1Mvb0mQHIBptNBchPl5UQWjb1ULM7l7yE+iVvWYwOF89mZNTKspYEZZRya5fWj+0la+opp3vzgOq6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 06:08:41.6452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 415cd978-9039-4304-63d0-08df3002ebf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282
Message-ID-Hash: 7GF7AG2ZB574P5PWMGC67Q27B4SKJEKU
X-Message-ID-Hash: 7GF7AG2ZB574P5PWMGC67Q27B4SKJEKU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7GF7AG2ZB574P5PWMGC67Q27B4SKJEKU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

ACP7.B/7.F platforms expose four SoundWire managers, whereas earlier
platforms use two. Add PCI revision constants and ACP7X_SDW_MAX_LINKS
to soc_amd_sdw_common.h, and set max_sdw_links in mc_probe() based on
PCI revision so the machine driver validates DAI links against the
correct manager count.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-sdw-sof-mach.c   | 10 +++++++++-
 sound/soc/amd/acp/soc_amd_sdw_common.h |  3 +++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
index ec3e1f5f1052c..ad8a024321dfa 100644
--- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
@@ -382,7 +382,15 @@ static int mc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	amd_ctx->acp_rev = mach->mach_params.subsystem_rev;
-	amd_ctx->max_sdw_links = ACP63_SDW_MAX_LINKS;
+	switch (amd_ctx->acp_rev) {
+	case ACP7B_PCI_REV:
+	case ACP7F_PCI_REV:
+		amd_ctx->max_sdw_links = ACP7X_SDW_MAX_LINKS;
+		break;
+	default:
+		amd_ctx->max_sdw_links = ACP63_SDW_MAX_LINKS;
+		break;
+	}
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
diff --git a/sound/soc/amd/acp/soc_amd_sdw_common.h b/sound/soc/amd/acp/soc_amd_sdw_common.h
index 034c9ab6e4ea6..5b9410eff56eb 100644
--- a/sound/soc/amd/acp/soc_amd_sdw_common.h
+++ b/sound/soc/amd/acp/soc_amd_sdw_common.h
@@ -17,12 +17,15 @@
 
 #define ACP63_SDW_MAX_CPU_DAIS		8
 #define ACP63_SDW_MAX_LINKS		2
+#define ACP7X_SDW_MAX_LINKS		4
 
 #define AMD_SDW_MAX_GROUPS		9
 #define ACP63_PCI_REV			0x63
 #define ACP70_PCI_REV			0x70
 #define ACP71_PCI_REV			0x71
 #define ACP72_PCI_REV			0x72
+#define ACP7B_PCI_REV			0x7b
+#define ACP7F_PCI_REV			0x7f
 
 #define SOC_JACK_JDSRC(quirk)		((quirk) & GENMASK(3, 0))
 #define ASOC_SDW_FOUR_SPK		BIT(4)
-- 
2.48.1

