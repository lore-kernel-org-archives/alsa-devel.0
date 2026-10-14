Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C46CC6B1D
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2026 10:23:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 39EA6602B2;
	Wed, 14 Oct 2026 12:23:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 39EA6602B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791973421;
	bh=tWWBxRxWqD7CEyA+zpsbr+VkvhQwkrX0YvXtl/ya4pI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VlcHaZSfECnIV6dX3YtV4JqRDcwAKHq6SHiDEnn8Wigv/Nq65kmG1BIVhJLtrhgF3
	 Fq5YfcoZv0mtEKDY6IhbNcHmEUa34nE7zjYlCalZwg2H/MoORHtPHt//VmNrXiaP+F
	 /LpoKigHZn0Qrw01uQuFdi+6noRU9Ullaa8FAjWI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5B63BF806D8; Wed, 14 Oct 2026 12:20:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 212A5F807B5;
	Wed, 14 Oct 2026 12:20:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3D2A6F80622; Wed, 14 Oct 2026 12:20:36 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.40
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791973230;
	b=nzyZAKmCSChLUr96NtLmQysZCVsvnAsDxVO1FeL97k6DFHjdlDYp7UAQ056uIdO4YfDp
	 ciW0EAAJy7JyMwqkmZFriFCXm6qcXOjQgSMgEFwzlF9/wsV7nUU3fi368IehAt0wfZ1xq
	 749QDYdc+VwW8GxKhOxPGpNyxPXh6U34nCKsBwPy45GAbq9NQphps1285qNzB9Lyg1TNQ
	 oz2Jn3kCmneiJePxQtdtb1D/PUsPr4CgeBMQ3yji/YqfEBna/lPSa+BSq3socA4vhKTTj
	 5025qalQlXE7G9gBgmNQQJ+cUVOl0eTbVDZTJsq41l9msXvkUEprV3oGisdCYLhzdOw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791973230;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=tWWBxRxWqD7CEyA+zpsbr+VkvhQwkrX0YvXtl/ya4pI=;
	b=oBWS9buR0IjHscpBIF6MdCXT+vrpv7g5qlCtmF7h+baF4N/54vZlPb6ii88+4gBo5oKO
	 9ywi8cx8/aUDBY+6OiisVEwH6CdwQ7IIM+1tSrYDlLkteLQMFrjIRgCwaiPVBY1EuPEhw
	 FPT4GWS/LtMdsMSpskUT6eJEavWHeOXAT8GRTimfzyKxFM2TmcmMN5ZfuNeJyKmHurZ9I
	 Y/h1NXKdcF/2WHQX5/WXaTXAMpoqfyLK6mTuvlqQXG7SXuu/u2kGpSDGmRmVwoVzmaBoe
	 qH/FenZ0tnPK1edn1kOZOD+ecpMV7/1shdnMdqquLinlzPzwINcW7FUTp5DNZjPx9uw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=sihTc3u+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.40
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011040.outbound.protection.outlook.com [52.101.52.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2D5A8F807B5;
	Wed, 14 Oct 2026 12:20:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2D5A8F807B5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=sihTc3u+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTpi/9kPfsN/4/CviReFBxK6kJKs5KjswuTLRDV+faNA4J64Vj2Mz5/00GK8uTn0kg/MU4C9Z0Zf9icIGwgmDVpGBVvRkX3h8bXILiCrvSwEc7oh4vtjfNrtfrL9rHLTRRX5WzQwl5QKwdhPsDLoA5t4F8xTBpdxE+kDyRLqidXUIQR41+Ht/VIcF8ECFuulUu65yCY5cOQ7lokxDX1oHevbbkMDJbHjo8FnDvkAcYxCXeVQ73ZW5xpeBxhn20U7BuqC1Urni1lCUYQTr8unAvaUZWidgpUT0+QU1ycv6vWNPm90tcRZLWlOSZ/nsFRJgzVfdFVdzYm2X+HPnAuImw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WC3+dgMuAPV0dVD+o9GkZOO0UoofpWeKaE+7sVTyIlk=;
 b=U3F0AQ4RRWP+x4EzOzT9a2Qy1bjF6grWKzEvdez89A7mPBhkiWsRxJoX5ohxGH+ayUF4CCrmE6DF13K5RFPoyfnZflTSsPN5YFaRKKp7eik7l49JRuPWwj71ZfGVk7SUA+GltKpzNS5wXWLvcfLRDi/wQwe1vcI38fI2QWmH/9O33iI1DfMZzv3fXVcIdUtewkMu0xZR12SX6hORJn7WZA6tx+cXHrR+B/0igW09maQ21r8f55MStSGOVMobKjf2dT9W4UfPiLKYvfJ4zb+WNLdg+maBCjb+VxfMbrOMCJHCfnyaefJlMq1xw6Ukq2ASrRAaUwsxswSXVWqP9tgLXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WC3+dgMuAPV0dVD+o9GkZOO0UoofpWeKaE+7sVTyIlk=;
 b=sihTc3u+3y42/sSnYBBjxrxNIQEGOnvnOQwI1HlGFxFl6pg2ej1OlXN+b9taGGmR1p1ZJ0pwXsLiVDg8AbIa4t+bMdASXYO5i/0qifuF0jBrbB72edj+q9SsSxZTclu9rue5HxcHzXdy+g9TQDNj7oNHxDNdB1n5a6hVv0F2M7s=
Received: from BN9PR03CA0415.namprd03.prod.outlook.com (2603:10b6:408:111::30)
 by DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 10:20:21 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::98) by BN9PR03CA0415.outlook.office365.com
 (2603:10b6:408:111::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 14
 Oct 2026 10:20:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 10:20:20 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 05:20:13 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Wed, 14 Oct 2026 05:20:09 -0500
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
Subject: [PATCH 13/13] ASoC: SOF: amd: register SoundWire alt_machines for
 ACP7.B
Date: Wed, 14 Oct 2026 15:46:32 +0530
Message-ID: <20261014101817.1240200-14-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261014101817.1240200-1-Vijendar.Mukunda@amd.com>
References: <20261014101817.1240200-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3061e7-a130-461d-4dd6-08df29dcc081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|10067099003|261009223027099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	vs/pRR/z41JDpKYqEzrmRaWzOwifUFiIIgPN4KkR4wzFEUAIjRZ7kG13AcoCPJGYg+TDRht/XCft26xpjZDg5zda2sJ/v9LuBJe4JHmB4GcDc7hehr0BqguAdX/zCrfDhR0V66TmZlmFm2dPoRlRKzh2QuvPTbbZuJ2dRbc+Au45bB6fZLhCVoopnHQX6AAKpplf6aUrz9KhwbZxJY4ZgXoAD43FtLJ0CaGHk2/D0/jDiIerfwBX4mwvubZeWXoFOp8pdpamiidAD/4DxeWGucKFmsOKcEM9FwtR8Jy26/LThGvR2ep0JIK1fxqRy8MSyV4XdS1EsN43uwBudDVy+qCvv/tl7DMMZTQy3p04RmKc4JU4Rbczi1guGOAP6xV6VKoMfKK+hHFgj+jE9eOn4yDsZvVbpQ7CqRwd5TnSpcTr4THP0dSbBjo1M3bNkKO1AGmpRGsQwuhzQljykKzGJ+BClCKc/KJpHuz/TXi35dncqRVXF1DkFbqclXd+8mgx0hJ6Y2bEA+ZE/QVrK+E9mLxkKWzs9ubfZtwjC4Dn1CGjU9WyonVI7wsECo5PhGA06ZXNDgvQecm3HDdnPIocor7cnWEU+6bhtVVL4KyCYPNHZdtzOzNSc2jRlk15RDchxNgXK+oLlRZO4iI4qENXnNcTrhXVn0QFQdmoXMhxVr55u8X9HCVdg9WWAIliTgwnV1c60UWUJWs06g0Bja9adw==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(10067099003)(261009223027099003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	U2sPcQEOTBJZgMYkjKDXi/LmGVqxYfLY+HLJC1mAfLthaLJgo/Duoy86apBX7BM1jvZk3uaO1zfUVAUgwBr452fIwO0PmTga+dathCLAEzYJmeY1D8Si8zUvpqiet2YthcVrF9a9UvHPF+4y/GLgEvfenm4ooy2xJTZk+ZmdwWsBNZDFgzy7KOYu85Asc8jeTsKVR0/lgAHUx2RA+z7cWUcqjkCPg7QlGbv/6qxl0Cf4zQBhfGqhr5stJjmGXDrXjrVdfdgeQtLxc5aLLqMIBKjFrLSSlCHI1+K1Tc2X+THWXoz6ZLuj0UetAcC+n4d4/5ca6IU8Nh1kwliCTV0yNIT0yqbgXmgHZlIh0rM36RT2zPRT382hgLyg0r7kNHM/j9PKnVip+HKINjBCJ1Sf67MnVCk71xMkB/8WV0mlN5aRq07tNopUAeV00WVKpmiL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 10:20:20.8735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ac3061e7-a130-461d-4dd6-08df29dcc081
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913
Message-ID-Hash: NEG36ROCW2MQ6WTIVT4YP2AHKZH3RY5P
X-Message-ID-Hash: NEG36ROCW2MQ6WTIVT4YP2AHKZH3RY5P
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NEG36ROCW2MQ6WTIVT4YP2AHKZH3RY5P/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Register snd_soc_acpi_amd_acp7b_sof_sdw_machines as alt_machines in
the ACP7.B SOF device descriptor so that the SOF core selects the
SoundWire machine driver when ADR devices are detected on ACP7.B
platforms.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/pci-acp7x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/amd/pci-acp7x.c b/sound/soc/sof/amd/pci-acp7x.c
index 2999dc6d72a63..6aa16d1a12b95 100644
--- a/sound/soc/sof/amd/pci-acp7x.c
+++ b/sound/soc/sof/amd/pci-acp7x.c
@@ -47,6 +47,7 @@ static const struct sof_amd_acp_desc acp7b_chip_info = {
 
 static const struct sof_dev_desc acp7b_desc = {
 	.machines		= snd_soc_acpi_amd_acp7b_sof_machines,
+	.alt_machines		= snd_soc_acpi_amd_acp7b_sof_sdw_machines,
 	.resindex_lpe_base	= 0,
 	.resindex_pcicfg_base	= -1,
 	.resindex_imr_base	= -1,
-- 
2.48.1

