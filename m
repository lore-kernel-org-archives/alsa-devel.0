Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A032A606A31A
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2026 06:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=eKFnrNH1;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vjEEp2tM
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B66296021B;
	Fri, 23 Oct 2026 08:57:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B66296021B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792738669;
	bh=6L3GkQGstKjWhz99IMCXsT13MVwnSvb+OuvT8HUH5tE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=eKFnrNH1sLI4hNLlB69NuIGu0Dt+Vsm7v3nUPnW2bdtMOS5/8OPsNaEsBldzUsJr4
	 QBFQamhLnSD/xrcfgC14bktRNP3hdwjTVmSVD06JnXJdZL3w53oVY+7OkC4ZRpfXYX
	 PiJl71FfCTB3Uf8R/KPgjv9RL1xVUqjkhN0i315Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A9071F80806; Fri, 23 Oct 2026 08:54:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4D3CBF807D1;
	Fri, 23 Oct 2026 08:54:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 06D58F80766; Fri, 23 Oct 2026 08:54:52 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011034.outbound.protection.outlook.com [52.101.62.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3100CF806F2;
	Fri, 23 Oct 2026 08:54:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3100CF806F2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=vjEEp2tM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omfBgZ70M50lZs3G2dh4+jWBk7LKVYIIDPKk5mB8cXI96ciVEgIcdt8h6ALEYtoBfoubivRshcLNN6Cm3itqn+PAZtTWoMqyB2SGHIKzcjYtFVbfO6Wr6ETKn2PD0/1a/zxrCrTm3Tawfcb1TCaSddnBQmHGJmVshYJ5mzQi0VYIVl18fPO5KBiArtm/q0yZ+IBiw4XHCUxWZMg6GDKFTxTTirH7eUplf+wjAtQnBD2XmAD88BtG2dn5xHNgd+S3hCqSMJ/oBMRqw+AohKsuh8VR1csauZY/PeMvKeXjTN8lttgRR+dCSONUzZWH7lHFJJNCP1H9IF8CxYmJWcGxcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ezbw+oaa6Ywv1WiM6dkTEVCVoAVF+Kq0hGQ1DzymAak=;
 b=TjImOVtSLPk8kwKthBIg/8k0pdkLCrc323W8WZybR/XCoIIIUmPVqs6RHpUpavatPSSWD2GqFR4RVMKjaNte54SZ02K3SjPW7uTFXeq8qVftEQmvaQi5Je8OG1WEp+szsL7S++dpyMJVnqp/Y5DTpKp7ZAT8EKjFEQZgDYtTcV9F5m71ucP14wenLPgqo1Adk5oSGO/Di1f/Szw/xVkmA2tH/FkUgp90lh2pFt2ZtDWcOzjoXR+1BcAUpeZ9Kuk6pRaUZE7Nm0bwlX5eBePGDzM3WKjpydjlQqC/CudfOKfRXiF4udjQwh2UEQN8qU5wgNoar1xhROBe4VcS8zlMwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ezbw+oaa6Ywv1WiM6dkTEVCVoAVF+Kq0hGQ1DzymAak=;
 b=vjEEp2tMNZr/r8+kk+vxaKMBFStKK6dPSCpy3lZmOQfD3eMfy/EwxJabYcwsW52tudJLoKZQKN9lqJZkwi2LU8Qff+L/gURyC1ZUQzAKTOBqIs1IZsZRxGQ92kFpGd9rPlG7TzPas70V1qFGVWK0DH9yWvjHvtIJuE2bAAacq/4=
Received: from BL1PR13CA0271.namprd13.prod.outlook.com (2603:10b6:208:2bc::6)
 by CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 06:54:04 +0000
Received: from MN7PEPF0000014F.namprd04.prod.outlook.com
 (2603:10b6:208:2bc:cafe::1) by BL1PR13CA0271.outlook.office365.com
 (2603:10b6:208:2bc::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.3 via Frontend Transport; Fri, 23
 Oct 2026 06:54:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN7PEPF0000014F.mail.protection.outlook.com (10.167.254.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 06:54:03 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 01:54:02 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 01:54:02 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Fri, 23 Oct 2026 01:53:58 -0500
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
Subject: [PATCH v3 08/13] ASoC: amd: acp: set PCI subsystem ID for SOF
 SoundWire machine driver
Date: Fri, 23 Oct 2026 12:20:44 +0530
Message-ID: <20261023065216.3473883-9-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261023065216.3473883-1-Vijendar.Mukunda@amd.com>
References: <20261023065216.3473883-1-Vijendar.Mukunda@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN7PEPF0000014F:EE_|CY8PR12MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: 2457b301-fa1b-4896-208a-08df30d26c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|7416014|376014|82310400026|23010399003|36860700016|1800799024|261009223027099003|56012099006|11063799006|10067099003|22082099003|18002099003|261021121427099003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	04Xc8Hw/XZ9iSDgykYj7fONvEi+FKf1/ZYpcgnAnfVNpWAJq0rlhZkL5pcDMV5JAPDwSKYFeX1iU/ldsl4DDTFmGFs2moNNdSH23hTWz/MBS142m+Usak8eNJ0z4FeyH77oncseMLr4PFMyzeHtFXvwxjQUCkmg1AabEWbOS4MFouBWdrWc6Fq8L07OBF8mV89JySKnV8bVmwteklcfAs0vB4iZeJxCkW26WAeyIgeMCmvf5UCMNeWx5GviJxfkDOutPQFaQegfZW2ebGlBTGpeN+7Dw1wWLsEbQGCWttdfyhJLyOtFAG8QleGAGLiu8MU1eFnG3+PY5k393IdC7GvXAUoxICFvwWjX1q/B/qe9mo/hfhCgXo+5DNpskwYTMEq4NcJ3LviZPNL745HJER40FQ8S+VrfaWipmYo2LVLCISG57yy7G1L03zTdmrmGSdKyX87F7LcMZcSL7Nh2Q23+E8TdmCiBlIYPpksB8ohbQidY/MISDyB8pEQA4p6wvdKX6oib1BUjWZbFv4yUwYC3Si9rpkThaU4BJwUqeMVUGVcZsLDwWxut1DHW7NLUIACYXAT4VO4vTQBaOOUaDPcxTnEzKPuM3QVNllqPpYIrGKSb04d56yWYMS82MIKwbKdKdylSew4JzD8whBGptpg4BBpxJxV+eXKhTNZR8x2kHAiwV/vLRDwDFW200cCb9QWrGd+XCmXJindSHvBDgLw==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(261009223027099003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(261021121427099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	N/QOBjoUn2VHtfuOWvhTAac0Ch68PTKvJg9P2bu7p2HEA73UdzpykBHTPHdw8+cJey6tpgkurN94/IDkRB4HPNP0L9R9Y6arp/oxHyDY3cc/l1mh7XvtNEn5cAh4FZnverztor50T5ITQHFXdxUYVvwCMNfw/WACaxyGaKpEio2yd/wEuFl+ia4zPgOWqvbVcxkPq2vQOhnpuRRt0V2fZScTE60mUpl1Z28fS5p88YvfE7BTUS15+aTjIgHQ3hPPYpnyF/2IfxtKLcIKqWZ/wqQAXfLT2wUcBD/CirD6HjJuVqLih7dhZqXav8XyVtBB+EcVy6DYUHAJYzCivOfEKRh9l8rE02l0SHeviVCLEf3jweVKfCHNG1fw+obQKwqf/DMzi8e1gBXFRXRDMGS1r3ruHMaooZtdTWR6BO1BKah25EhSJlKtQss2D30NO5h2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 06:54:03.2701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2457b301-fa1b-4896-208a-08df30d26c99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MN7PEPF0000014F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8339
Message-ID-Hash: HGI3EA6SEAD4Y2QFU5RKGLGVLBLDZKDG
X-Message-ID-Hash: HGI3EA6SEAD4Y2QFU5RKGLGVLBLDZKDG
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HGI3EA6SEAD4Y2QFU5RKGLGVLBLDZKDG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

Call snd_soc_card_set_pci_ssid() when subsystem_id_set is indicated
in the machine params, propagating the PCI subsystem vendor and device
IDs to the ALSA card for correct device identification on ACP
SoundWire platforms.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-sdw-sof-mach.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
index 4c171e52410a6..1013f60b2818a 100644
--- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
@@ -440,6 +440,11 @@ static int mc_probe(struct platform_device *pdev)
 
 	snd_soc_card_set_drvdata(card, ctx);
 
+	if (mach->mach_params.subsystem_id_set)
+		snd_soc_card_set_pci_ssid(card,
+					  mach->mach_params.subsystem_vendor,
+					  mach->mach_params.subsystem_device);
+
 	dmi_check_system(sof_sdw_quirk_table);
 
 	if (quirk_override != -1) {
-- 
2.48.1

