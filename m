Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D9D606A323
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Oct 2026 06:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=FmABI5IF;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TqkWyoYh
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AAC79601FA;
	Thu, 22 Oct 2026 08:09:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AAC79601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792649402;
	bh=mwaNglps+dBbljkG17AxxS+Yzi4Sbnm88aSNzW5ZUrg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=FmABI5IFPVK5o7dRjyCBMHaothYT8SiIGQep+7caqvkPypkm2CUxOy4OEJPQyPHWw
	 hNcK/K97E+Nt8KzLvIf6OHdQxzNUvo8aZN4tSigbfKLiH7+9QhvVrr27uf0mVtBIu1
	 XSDUMGwKt1hSW0SBmj5iH+cm6+G+BJN/lQgTZAfU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F24C1F8061E; Thu, 22 Oct 2026 08:09:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AE0D3F8062F;
	Thu, 22 Oct 2026 08:09:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 90053F804CC; Thu, 22 Oct 2026 08:09:02 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010037.outbound.protection.outlook.com
 [40.93.198.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4DF02F8003A;
	Thu, 22 Oct 2026 08:08:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4DF02F8003A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=TqkWyoYh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f57wxpl/9R+X03dXyc3+5PdmR0xHlZ/voKebV1wpKP9uuw3Xpb4zyRk+cOF/oWHMtzMlG5ywVh2bePrjaQOqrsfllwfKlt4jgfc8eeSnmBxWn+3vvHdiiALd+19/uRV9MgHTXoGQ6tz/NarOoKSwAOSUA5m52FF2L3AN1uRHlaalrO8ZD5m1xFM1acZ291Tf574qQCNBE3igYB8xrXRwioGovGJzmxEsz2DKdpEdn0xBNutX467+MPRyClzpGR58yWB90AF/j8Wio5f4f7FbEzdyqR2GerNlMV7lIlB5fFeEqp/DE0+YDc0l61E9DsA8aJ6/3sh0DlJuPryKOgUF9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4LYA9DVKQ//XspoeU1lrtARSIA9xi5s02DewEwPAww=;
 b=W0my3y+ZPqB5kJI3AGr0Uk9yQmTysShxl7Kns+fqGVt+SUIf7v+3syLTL0spMBJR5n4FlofQOei71mpQ0lmQGgbeIz7g07y4gGzmyLMpr6ttJfDIoYzgngGzci+Qg/AeHbga70O5o8y9tOztUYfRF77ep2IYDUGhpMnVsMCC+2IWCYb6UZvT+K+dUam6PkEYxvFp03N590NVdPaSP43kp3MZsSNjUAFJ3E8TMH7gMV8XWTkG4hfFRjQo818NwsUD8JEdreyKE2t5FQFIuiKlVDmcmkk5xkW0vEjiz1kxQdW7qLm99AdoTKdgxW0bvdKXF6tMhy6qlBaMpr0IAROxMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4LYA9DVKQ//XspoeU1lrtARSIA9xi5s02DewEwPAww=;
 b=TqkWyoYhvQ+5NcbE2zd21e/ED1Dc/M/kIWL0ILi7tKinJAj0YGrU3ZR9EiTWS9oxgOp/0gx/R4DH4Yn7E9nGDCfRZdH5ijh//CHnYnihsGreMuBYmokN+kTTW3GgJbfwck3d0unTUp3yw8T/KhOWvjXZf3I5vhqR7B9H/U4ueZo=
Received: from CH2PR17CA0004.namprd17.prod.outlook.com (2603:10b6:610:53::14)
 by LV1PR12MB999329.namprd12.prod.outlook.com (2603:10b6:408:3f8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 06:08:51 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::48) by CH2PR17CA0004.outlook.office365.com
 (2603:10b6:610:53::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 06:08:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 06:08:50 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 01:08:50 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Thu, 22 Oct 2026 01:08:46 -0500
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
Subject: [PATCH V2 03/13] ASoC: amd: acp: fix PDM1 quirk and PDM controller
 selection for ACP7.B/7.F
Date: Thu, 22 Oct 2026 11:32:13 +0530
Message-ID: <20261022060724.1814741-4-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261022060724.1814741-1-Vijendar.Mukunda@amd.com>
References: <20261022060724.1814741-1-Vijendar.Mukunda@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|LV1PR12MB999329:EE_
X-MS-Office365-Filtering-Correlation-Id: b9e32804-c87e-4b9b-1b67-08df3002f181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|7416014|23010399003|1800799024|82310400026|376014|36860700016|261021123027099003|11063799006|56012099006|260925021911599003|261009223027099003|260925021311599003|260925022911599003|10067099003|18002099003|22082099003|6133799003|261021121427099003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	jinaJymUJr/PvFWPoSylnjP6vV6XSTfgD1spdGd3STZQfd+Fuju+jlw71GnEVEexus/B7VC63WmPnxPthA6ODaRGhJ0vjcd1ybz7dIMaVWlrQw0Z7o7zi2q3lTd5RTNUYPsMJ6UuLoeQjPrK/aY6Qx0xD1LvWmXTfn4eolZFfs7VEw1yfIzJlPzxOCAHBeZLGx3EQazbsf1kxU0IAN87UNRS/1QiL7W0V/2y6CgCqWHROJkoWeN0LfQrin2ma7/GSVJ5GaXo3nhIZxeSMTkFttRBJXAnoGw6zu6LinfFeI54U/1LgeFKdWj6XioIVgz5ZkZxn/lBYt9ECafR0akdd0C1yJp02D9935hVsc2EGCGjECE+m8zAjwlk4cv11kr7SZK3GWoGK3zvRJOCsMTRY9KEBCTzRq0HcSGuDG2eLxL4dzqfFWBh41TsfXdOweeEO1DQn/Z6MQM9oHFlGy8R2WUbqUcuEtN0XMug5lQbL0vUeQEJ7Yk7yBnx9vcT3CHa2kr5kKgbJrrFD5Do5ni1w139lOBEYwGKwzMSeQVyzsadMFXoSM8MSNN0fGN4M1JAX/+Z58cIlQ+k1s3msWLal5lxWFRoAE8R+nBDrz0q/qbNoakPJ/rhOuysuPzrKx29xxoBTvkui/rb2K9hGH0GxcgojCwfk/kKuGfBYPMQI1r0TgrtYGqQL0h/pECGGAChyMcgNa/MA6bilMplrcycsA==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(261021123027099003)(11063799006)(56012099006)(260925021911599003)(261009223027099003)(260925021311599003)(260925022911599003)(10067099003)(18002099003)(22082099003)(6133799003)(261021121427099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	XkNfZMCVzMIpTzb2kwkoDUL/54kFIwZqJGujfNUKFqddAO3B9L7tFvumGsYeM64r2OQAlVjFssfo6MYuT3kV1w0UzNBYPuw2TIqG06ShTeVzOQYjVHpzyP1MOmUtoi5TE4P1Om7chrLObAUx04fMPkSBTThmzCcsox2BtFBONZ8k42kUaz/SUnw3qFG6JKanUC0mQUglWs6xx1v/iWzhK0cvlF6l2/tvOXhbYUk5HcbrIiHiUFGOUwm6qykOqwBlGuD04xJPYdmoWDFToEZ2k4EylGTJZi0Tfcx16IwcxRzPNI5MVzXHHpDmu5d6EP/Kn4QZ6LrMS0CbltvldCDjrq+XaJtloidHL6m6uMNXUY81W4DvoBEJ3A5UMf0urRZgZlOC8Mkr4k4dWbXd88eU7sD0x7HkFnNq8WxYG7JfIVfRO+zOqQzvcPi2TC3LCOQc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 06:08:50.9189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b9e32804-c87e-4b9b-1b67-08df3002f181
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999329
Message-ID-Hash: VON2DGCNUM357UINVFFMFM7N7KWT2NRJ
X-Message-ID-Hash: VON2DGCNUM357UINVFFMFM7N7KWT2NRJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VON2DGCNUM357UINVFFMFM7N7KWT2NRJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

The ASOC_SDW_ACP_DMIC1 quirk was evaluated before dmi_check_system()
and quirk_override were applied, so the pdm_sel fallback always saw
the compile-time default and was effectively dead code. Move it to
after the quirk is fully resolved and restrict it to ACP7B/7F revisions
where PDM controller selection is meaningful.

Since ACP7.B/7.F exposes exactly one active PDM controller, use
else if for the DMIC0 fallback: check ASOC_SDW_ACP_DMIC1 first; only
fall back to ASOC_SDW_ACP_DMIC (DMIC0) when DMIC1 is not set.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-sdw-sof-mach.c   | 44 +++++++++++++++++++++++++-
 sound/soc/amd/acp/soc_amd_sdw_common.h |  3 ++
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
index 6855141293e34..2fb5c7ecafd8b 100644
--- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
@@ -265,11 +265,31 @@ static int create_dmic_dailinks(struct snd_soc_card *card,
 				struct snd_soc_dai_link **dai_links, int *be_id, int no_pcm)
 {
 	struct device *dev = card->dev;
+	struct asoc_sdw_mc_private *ctx = snd_soc_card_get_drvdata(card);
+	struct amd_mc_ctx *amd_ctx = (struct amd_mc_ctx *)ctx->private;
+	const char *cpu_dai_name;
 	int ret;
 
+	/*
+	 * For ACP7.B/7.F platforms the PDM controller is selected from ACPI
+	 * acp-audio-ep-port and stored in amd_ctx->pdm_sel.  Use the
+	 * matching SOF DAI name ("acp-sof-dmic0" or "acp-sof-dmic1").
+	 * All other platforms use the generic "acp-sof-dmic" DAI.
+	 */
+	switch (amd_ctx->acp_rev) {
+	case ACP7B_PCI_REV:
+	case ACP7F_PCI_REV:
+		cpu_dai_name = (amd_ctx->pdm_sel == ACP7X_PDM_DMIC1) ?
+				"acp-sof-dmic1" : "acp-sof-dmic0";
+		break;
+	default:
+		cpu_dai_name = "acp-sof-dmic";
+		break;
+	}
+
 	ret = asoc_sdw_init_simple_dai_link(dev, *dai_links, be_id, "acp-dmic-codec",
 					    0, 1, // DMIC only supports capture
-					    "acp-sof-dmic", platform_component->name,
+					    cpu_dai_name, platform_component->name,
 					    "dmic-codec", "dmic-hifi", no_pcm,
 					    asoc_sdw_dmic_init, NULL);
 	if (ret)
@@ -378,6 +398,7 @@ static int sof_card_dai_links_create(struct snd_soc_card *card)
 static int mc_probe(struct platform_device *pdev)
 {
 	struct snd_soc_acpi_mach *mach = dev_get_platdata(&pdev->dev);
+	struct amd_pdm_pdata *pdm_pdata;
 	struct snd_soc_card *card;
 	struct amd_mc_ctx *amd_ctx;
 	struct asoc_sdw_mc_private *ctx;
@@ -398,6 +419,10 @@ static int mc_probe(struct platform_device *pdev)
 		amd_ctx->max_sdw_links = ACP63_SDW_MAX_LINKS;
 		break;
 	}
+	if (mach->pdata) {
+		pdm_pdata = mach->pdata;
+		amd_ctx->pdm_sel = pdm_pdata->pdm_sel;
+	}
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
@@ -419,6 +444,23 @@ static int mc_probe(struct platform_device *pdev)
 		sof_sdw_quirk = quirk_override;
 	}
 
+	/*
+	 * If ACPI did not set pdm_sel (no acp-audio-ep-port in _DSD), derive
+	 * it from the quirk bits. ACPI takes priority: quirks are only
+	 * consulted when pdm_sel is still zero. PDM controller selection is
+	 * only meaningful on ACP7B/7F platforms.
+	 * ASOC_SDW_ACP_DMIC selects DMIC0 (default); ASOC_SDW_ACP_DMIC1
+	 * overrides to DMIC1.
+	 */
+	if (!amd_ctx->pdm_sel &&
+	    (amd_ctx->acp_rev == ACP7B_PCI_REV ||
+	     amd_ctx->acp_rev == ACP7F_PCI_REV)) {
+		if (sof_sdw_quirk & ASOC_SDW_ACP_DMIC1)
+			amd_ctx->pdm_sel = ACP7X_PDM_DMIC1;
+		else if (sof_sdw_quirk & ASOC_SDW_ACP_DMIC)
+			amd_ctx->pdm_sel = ACP7X_PDM_DMIC0;
+	}
+
 	log_quirks(&pdev->dev);
 
 	ctx->mc_quirk = sof_sdw_quirk;
diff --git a/sound/soc/amd/acp/soc_amd_sdw_common.h b/sound/soc/amd/acp/soc_amd_sdw_common.h
index 9e4c86bed3003..86c8e38a19bb1 100644
--- a/sound/soc/amd/acp/soc_amd_sdw_common.h
+++ b/sound/soc/amd/acp/soc_amd_sdw_common.h
@@ -30,6 +30,7 @@
 #define SOC_JACK_JDSRC(quirk)		((quirk) & GENMASK(3, 0))
 #define ASOC_SDW_FOUR_SPK		BIT(4)
 #define ASOC_SDW_ACP_DMIC		BIT(5)
+#define ASOC_SDW_ACP_DMIC1		BIT(6)	/* select DMIC1 controller for ACP7.B/7.F */
 #define ASOC_SDW_CODEC_SPKR		BIT(15)
 
 #define AMD_SDW0	0
@@ -83,6 +84,8 @@
 struct amd_mc_ctx {
 	unsigned int acp_rev;
 	unsigned int max_sdw_links;
+	/* PDM controller selection, copied from amd_pdm_pdata at probe time */
+	unsigned int pdm_sel;
 };
 
 int get_acp63_cpu_pin_id(u32 sdw_link_id, int be_id, int *cpu_pin_id, struct device *dev);
-- 
2.48.1

