Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F13CC6B1A
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2026 10:21:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9DB9E602B5;
	Wed, 14 Oct 2026 12:21:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9DB9E602B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791973310;
	bh=ymEpA8IWlTDt84IaubWf+5b6UBAedmVzhKoHvv3kRQg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=XBUNDwBRkPeV0In4pFzWRA+LdKEICZ4R/f9BRNT9yWyakpJSTbt9zwh2wGU2FrhhX
	 D2wQk8xRcFpbyIYukYUTsMEq0Vv4nEX1ltXsG5DIsPrZnyCIPEPBfcf0tz/SyOiWec
	 yNiKqJYRjbnGqkqZJgd7I8nLFVXMm8mSjOjPAZ2o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0927FF806CE; Wed, 14 Oct 2026 12:20:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0DD79F806D1;
	Wed, 14 Oct 2026 12:20:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D57A4F80641; Wed, 14 Oct 2026 12:19:50 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.62
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791973189;
	b=qjUUYhmCPBBRWj8CTCp2AGHIpmUu2yLDbAqLljtYKLEB3y1B5lKGkySfeGXcpUrEBSg9
	 hwMSc5ibk/AV1k8hBBt51YR2T/0OepvdvmWdR7Ib0T8Uh92YlQ+Sd5tbnFE4qB1O/BBe8
	 20vornWiy8Psc2GUtM60EOJto2RYczhuhMbMFSWjRyGD3hRV9bvT//OE536BbSykE3Gpe
	 2J/xOUkBdBlsV5spSxre97IFOk3/37cND7ytnuBYaS7M+ytuEDmrYcyEpLhyvoUOgn171
	 ks3RvaSNS0YaqV5Ee4bu4sGbNXN5XdinprU0TqFJzEKfJZ9LuLfFXJdjYxL/2Funmmg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791973189;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ymEpA8IWlTDt84IaubWf+5b6UBAedmVzhKoHvv3kRQg=;
	b=GTcRvSrESwWO2GT/rkCKZyFIuakUfKIOEWGovZSPJ7X6//3+pMvN32IMmpdsbTX8Veo5
	 52WXqya50o0s898WyKJitHAKpF6nNIm5opCe5PB9p9vXIpfAMbP8XRfc7Gl5xjcfV/vCo
	 hTbgHG4FTCINvfjx+TUvnb/yUSFZexh/sVlpIJViSUD57z1Qr56XFel9PYQ0DF1NqQZvl
	 x5IUfXnLhqGVepfvHadnIPNX3wu2gn6IVMOFoU0NA/3HE9XCeT6dWEY/tjsbp0JvtXKP6
	 f96yhxbpGQYE42yo6leBsnJkp7fZZDzmDiYOlM67F/6lIxamOAisrCR1kjtZLvcM4SA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=AVNQFZ7S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.62
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010062.outbound.protection.outlook.com
 [40.93.198.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 223A0F80632;
	Wed, 14 Oct 2026 12:19:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 223A0F80632
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=AVNQFZ7S
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pR4VTbEp2IBBMMy0Uu8CFcLOzib3Mze8lnS0soRhzQWn524hdRf7ilJKFIk6u8+phfcEioWHrC4Z+aZwKAbTHJx5v/k60XRxDQ4UJm15uOhGM1iuKiNCL2qDMNziHywvxDwNkx4M7/SYjUwxUvX9YaD3GBBOtk+vHlr5dMv9lGlkqdNJRnvmgYsgT3vow+3bGihBqZh0pxk02tr7hbI3duZtXH13KTe93dOjJSLPpHuXBcOxeZdHhntAgLrAGcheG+depUzoKuYAqVYIqnCTxvhBi+bf3H6B9JNJ+gh53LeGtOo+1/2yFfsHVYUJskoKqz+BAlz7G23PsanuxncNoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRSqRQM3yZpMQSa/Rf1zw777k/CosxTuwbwSOO8Vjbw=;
 b=jeLIQidLIW9eO8w5hqaPZ3KxvgtwP5naXOeoH4MuysNRsghOGPzt+xs/PtdkjYQj9MCeFVa/lrqUtVE03RjP0GE22fnaGP2Cw5DCWSyAw6dryLsGcsxfgiXIuHnl2hQmYU+OaW4lmtFDjlaf1erjAP5KmCLr13QUN5adifTCHr7pM8265heE6qIG5VvPYIzqUqxEB6NJUb/BpOMBx8gSsjyugrKUw09xUDeqq1SURjhme5b+5hqKsdkqbnqIyQ+p0NMwqFeJkhNQwCUHr4r2AzmUEvFn816fZypATNi2bK47sw+wKTl/roAtHs77X7Vd5V62qcQKCDvuU3eNowV3HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRSqRQM3yZpMQSa/Rf1zw777k/CosxTuwbwSOO8Vjbw=;
 b=AVNQFZ7S5b6b4GKdDe66PPmaT7hWaUVuaPF0GYC7oLyVgwoEAKwz+wo0of5bRg/noYFe+7DrVHLMghcgfYqb/odLemjHzg1pDVVQg4z5TEG88Qc24g/g378u2vyr/lEL79+EHZPbckq5aHhS7Xjx3BQM7D/OV7NnvlZQKSttF0k=
Received: from DS3P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:45e::17) by
 PH7PR12MB9074.namprd12.prod.outlook.com (2603:10b6:510:2f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 10:19:42 +0000
Received: from CY4PEPF000392DB.namprd03.prod.outlook.com
 (2603:10b6:8:45e:cafe::8b) by DS3P221CA0012.outlook.office365.com
 (2603:10b6:8:45e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 14
 Oct 2026 10:19:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF000392DB.mail.protection.outlook.com (10.167.247.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 10:19:41 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 05:19:35 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Wed, 14 Oct 2026 05:19:31 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <yung-chuan.liao@linux.intel.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<Vijendar.Mukunda@amd.com>, <Poojitha.N@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sound-open-firmware@alsa-project.org>
Subject: [PATCH 05/13] ASoC: amd: acp7x: enable DMIC DAI link based on PDM
 controller selection
Date: Wed, 14 Oct 2026 15:46:24 +0530
Message-ID: <20261014101817.1240200-6-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261014101817.1240200-1-Vijendar.Mukunda@amd.com>
References: <20261014101817.1240200-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DB:EE_|PH7PR12MB9074:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a5b301-ab6f-45fa-479c-08df29dca939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|18002099003|22082099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	N8y79+565ryxlwrP1zvEOD6neyK1ILXSboozcZR5UoXDVQxsXwjyEjO3WXbxV1FTCvK48oypUB67LA4lV/lfzAeVTP5p2Wuptz9wUMPnbABYvYFL25QJKPj1sM2kem5L35pZJoTHy3QbAKSbxehsKdOGRfzIhuslQMh/q6bLphakA2O749BSRypgn6hXJjEsA0GNaFzX1LyfwiAh2k98h2JbXEXmBb9hrvmh4OV+CxW7cuDFAT3a4p2d/u1E/ilxUxpOg0+fnZK0OHqDtsKvF97Lbph2jKxw0jAjqbpGUCYYOZqWcFxJE0O2bOi4nWdU3S1vvf01zhbptYySOZ+nyNO7S/z6XxP4zZT/giG9J84czhvjrxo+0ZvWuIAJjAWwjuRCGr3jTmrrN3jenodskNC7SZS0AE0pPCJ6+cnOEPuzb0OxYYtvmiFVrbJHeTlNfwkH3sAcUWcIzLKav9kybNcu1V47LVIzStMJrA3/LHiyjrgrv27KhGHmwD3ypa6kttoyxGnZv9woYnMnBzi3qqsOBnSG+AISFO8WFJQA4hyDSnlBWomiZZy7cMZp0dRN/hMM0fXeWzdwj6wne6q6q5kh+Qof1CQa8MYOmHgR2aFNg3BcfkP4HC9+EGs54CLzy6GdkcOZTGCYizv2XKRGWhmRzWNCxoxDyaays6pRN2e1VsVXsIMwsNly6/SY2x6XtonPHs7mvx8L9oaml6JFhQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	tKIx6H3w0lzmJwsfPmD9172ZUXKnxtyRDvihRXRc93kRO2NgJB6oKa+jmhy/FyBJFK0UgxNZbjlTXe4geVOVcPjFnhQ9y2Orkib1DCFbvl8FZOVPAYPhwXPan+aXmt6tedWKpB2rqaItzZglW9wq7i1qLZAMyojadXHX7UP59XT7seXVmhmuGVZ/BMnMmcDlZbNH+sw1MDADoSa93JiGU9HxeQq9534CFQnYXAWh+/FNRgSgnPqFtKN1FHv9M8TvHkAsGwxIOJ2voG4uOCLxeDL5ap2pF/yBP9PEfjytP4HKky+Dhi2x0OVOuLTOVcj+QQAH0+UsjcGT7OPWwExahItlhD9BwYEhtV6yd1xA8CL8+akrPahm+qn+nA7pRz/5c0dH8uVOGVwvnLa/lqkfzHHRd00Q1sZCL9BChaKTvQHNhFeIBQ3QSEwezmH0Ui5k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 10:19:41.7707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 39a5b301-ab6f-45fa-479c-08df29dca939
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CY4PEPF000392DB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9074
Message-ID-Hash: PQK5JW3YVSXQ2TJXBV62PQFIO7IF5WLD
X-Message-ID-Hash: PQK5JW3YVSXQ2TJXBV62PQFIO7IF5WLD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PQK5JW3YVSXQ2TJXBV62PQFIO7IF5WLD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Extend the DMIC DAI link enable condition in sof_card_dai_links_create()
to also check amd_ctx->pdm_sel. On ACP7.B/7.F platforms the PDM
controller is selected via ACPI rather than a DMI quirk, so
ASOC_SDW_ACP_DMIC may not be set. Enabling the DMIC link when
amd_ctx->pdm_sel is non-zero ensures the link is created whenever
a valid PDM controller has been identified from ACPI _DSD.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-sdw-sof-mach.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
index 41160f47b1201..ac4c9e852f671 100644
--- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
@@ -308,6 +308,7 @@ static int sof_card_dai_links_create(struct snd_soc_card *card)
 	struct snd_soc_acpi_mach *mach = dev_get_platdata(card->dev);
 	int sdw_be_num = 0, dmic_num = 0;
 	struct asoc_sdw_mc_private *ctx = snd_soc_card_get_drvdata(card);
+	struct amd_mc_ctx *amd_ctx = (struct amd_mc_ctx *)ctx->private;
 	struct snd_soc_acpi_mach_params *mach_params = &mach->mach_params;
 	struct snd_soc_aux_dev *sof_aux;
 	struct snd_soc_codec_conf *codec_conf;
@@ -350,7 +351,8 @@ static int sof_card_dai_links_create(struct snd_soc_card *card)
 	sdw_be_num = ret;
 
 	/* enable dmic */
-	if (sof_sdw_quirk & ASOC_SDW_ACP_DMIC || mach_params->dmic_num)
+	if (sof_sdw_quirk & ASOC_SDW_ACP_DMIC || mach_params->dmic_num ||
+	    amd_ctx->pdm_sel)
 		dmic_num = 1;
 
 	dev_dbg(dev, "sdw %d, dmic %d", sdw_be_num, dmic_num);
-- 
2.48.1

