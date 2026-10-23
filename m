Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B30606A31E
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2026 06:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=nlq8Qhqf;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aKMNORSa
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E23060181;
	Fri, 23 Oct 2026 08:54:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E23060181
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792738494;
	bh=E14QWJMTtOE3KSI5IBtGCRdoZlKdL6yvSDRv7NUzACc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=nlq8QhqfmYbR9/+nt7nJsBWeHWM8GcEDRl6ENP/zzJDWTdwWuwnOjL0qkCUUe8KXh
	 fj4JsGNp9UOQyWY/FAdQKr9AT+BepL44Dj9pho3vjPzMAjcYqDfz0H4M71lqTPGai6
	 b3nx2C1MEyRm68W+6pC98l0D4F2f6msZ3oSa0MRE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 00B1AF8061C; Fri, 23 Oct 2026 08:54:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E8F7F80606;
	Fri, 23 Oct 2026 08:54:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C73CBF805A0; Fri, 23 Oct 2026 08:54:06 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012069.outbound.protection.outlook.com [52.101.53.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F1A87F800EE;
	Fri, 23 Oct 2026 08:54:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1A87F800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=aKMNORSa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B188CEHqJPoWv4V0YyP0x2FqVP0RS46l4nU+81600D3rwo7iY2sjc0cTRUW3E6xLb5HPJnc0sGxZeyfNEngiwIoxqZoOsZyVtBQywTEM+JF3B8XnBpx8VuXGDUscvQkMk18ACXhta9UKNZLOmGSnrikgw1GV+JtgCTpzqmySfaXNpdIfEjsh3hXccVJMezu+VG7K9AwjlTB5JUTeo37w0d9M9Ly9YH5YHfeYK7fuxeYtZerEJMFA8FufPHPiaE0QIAig7n4CtpK89hK6MKbOuyRQGL9IFNAiJD9bALCRSxl7N5kmZm000B7roQkI/V7rwxan4ugbfpfWeX3n3YPAdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09pF8QdF90ITXeW1/tPh4eN41BdHZ3vEegQaX7NnWhY=;
 b=l6w7qzMU3EJIHAehmxMK6JZh3imHT3erskOvyLO3x+inb0z4qH3nXVmKW02gqvtq65MhsOFd7tWATX+syYWQe33WO9VZgBF1gwjTHjBBrPRooQaQ/eLBSltA8KKKB3xqtea2AxUHh06Ecq1ETKz+RQRjumNBNb7yfI2nIKMqPhES8iNSg5inbRpgHtmQlGKsWfqoFeaS5/lSZMl4col+f+NRzPofIbAttL6sapsOTNCS5mpzZF43EClLALm8wdn2L5IEoSmfFaBiXI1MR2+Go7zDZXrFc3v6cCc/wisVjZ1VDuZ08tLp4c2tbtbQQmH3udCa9jEzyrhjRpgcO4Wa5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09pF8QdF90ITXeW1/tPh4eN41BdHZ3vEegQaX7NnWhY=;
 b=aKMNORSajaHnWTkWEDrREVXYHFQF+2Fd8+PRQTIP38XR4ho1w2/36AyJIDBbyd1S5x3PePVFZLIAWEGfiByfQhgIMQMZ/VTGv0IlsNnvuJVHNeGroKBw7AiD4AFEvprBxG1SSTPIqYjFLno6/OW52vWejGnlNBMmqnfBPo0/y9c=
Received: from MW4PR04CA0191.namprd04.prod.outlook.com (2603:10b6:303:86::16)
 by MN2PR12MB4391.namprd12.prod.outlook.com (2603:10b6:208:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Fri, 23 Oct
 2026 06:53:58 +0000
Received: from CO1PEPF00012E62.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::87) by MW4PR04CA0191.outlook.office365.com
 (2603:10b6:303:86::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 06:53:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E62.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 06:53:58 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 01:53:57 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Fri, 23 Oct 2026 01:53:53 -0500
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
Subject: [PATCH v3 07/13] ASoC: amd: acp: add DMIC components string for SOF
 SoundWire machine driver
Date: Fri, 23 Oct 2026 12:20:43 +0530
Message-ID: <20261023065216.3473883-8-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261023065216.3473883-1-Vijendar.Mukunda@amd.com>
References: <20261023065216.3473883-1-Vijendar.Mukunda@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E62:EE_|MN2PR12MB4391:EE_
X-MS-Office365-Filtering-Correlation-Id: d83aac0d-58e3-40cc-461a-08df30d26986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|7416014|376014|23010399003|36860700016|1800799024|82310400026|261009223027099003|10067099003|56012099006|261021123027099003|261022105027099003|22082099003|18002099003|11063799006|261021121427099003;
X-Microsoft-Antispam-Message-Info: 
	sn4yR/CNvDI/3pAA2ccuRhTFXKuYRpcSROFqlvzjztgCpcRXHXVdvq5Eh9E+UU9yFmJdR4kpPQnGvVbIfHu+moxuizjhh2RHGAiEzBHeJsN5+rKRMJfwXAkYzdZD+9ITvZK4rCPIEvfGCSeT5SYQjDHXfb+k974PfbHVKHXbZ1V6WtzeoI4KVgaJzBmTdvmk2c4j/7GYxUTWtXN9onBHePuD0kKQFKL7aY93yf1qmHXgvMNiGppctI6Pqonv8JrUXCr4evG3I2voRpj/LepafsBnuUbL8Uzf7WSvuuFKym6HFSb3cYdTgCf9jxR32lE5dheWB9wQ1LkVvqMI31g3ypbbUhOs9nMDpnQs5BTxnEWirWP7s/n5jIMx8IktfQ2RPaOimtXMtHspfi46WfC0Tth8h3/7JHiAfNQ/stPZQzOvn8Pr6YEXCZYXsadJ4VVCj6O4r2j3lfXWRwfv9chAp6Hbno6wdlFwW819K2glgzDXAEBDCZnodqtKGy2QgJeydiCitsLhLoXELx9rbkNLgfVWRkYa0f+BoNtV76XcbIEsQixlgWdSGCH6O52r79zlaSlcP99kEY86zJX54lVHQ5XOfJOEdbfbK+aG7B963Y2nlogDyDPcmP8CpJB03CIK4SDE/a9/xYeDdlCk/Lj3O1XdOSQn6MK+8z6F/YRzleXKMUklcbXInwmQiHQPB4ZlykRX04mJDTTIRs6SCef1jQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(261009223027099003)(10067099003)(56012099006)(261021123027099003)(261022105027099003)(22082099003)(18002099003)(11063799006)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	hZzt1XJeMrA/W24YfuylxoSGwcbUVfUafJpimR0LrPZ8Hioj08hQelvYViMhKewJhxanpOUzoWsVpLDwMvQE6qprmf0aXxbXJjxhqnGD7ZKVWcwj9FLZT20koglCLyuZmJV9gEmHRSAUvOlfIABH5eKhQxRrGcJKCcJsYlPVBlAZRQ09Aw9NkAvttfUlhv9/N77t/9LiO8rUZFpbyR+0RlxUbPmzipGRGEdrLNN84qkCVQimfNW6p4IFTpRghGKPTbgEFW9NqFGpU9uHx1BzFvt7raTtziMULenhL3nyjfwqXybHqhf/8jT9UXU2hHScLseL8SerQmh+WM4MbcdqqeVap2KSEUkq6jp9x1RSPlxMM67uPzrfWQmcs9EvscqtexdHAJJZzzss9O8l53npPZRETB5GYJJ2tpHSzRO3TikRBsYuOkpdxLplM6uKORF1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 06:53:58.0444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d83aac0d-58e3-40cc-461a-08df30d26986
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CO1PEPF00012E62.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4391
Message-ID-Hash: AEWTGAVHYMMDFTLFXFIIDBCHN3OHXAG3
X-Message-ID-Hash: AEWTGAVHYMMDFTLFXFIIDBCHN3OHXAG3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AEWTGAVHYMMDFTLFXFIIDBCHN3OHXAG3/>
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
index 5c201d0b3bef9..4c171e52410a6 100644
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

