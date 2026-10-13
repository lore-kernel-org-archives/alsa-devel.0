Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D03CC6B12
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:48:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 93E43601F2;
	Tue, 13 Oct 2026 17:48:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 93E43601F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791906519;
	bh=jWvvmMYMRXHpEAlMKD6TTSrSgvKWy5PurfZW8LK+QLI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rP16ohrCxYez6BuBzLasF5CBF2ToEyFzjrVjmxsBn8nOiwSg97qWZjlv04zL6V/ee
	 a5+XNwYYgGJFwwvgZoK5YFVMsxHH8Z8FPDRhVYMy/aWYGbOy3EMjvC7OXwNVE5mzVM
	 nlOwOKnHrUr4bOO2sxka1po/gB/o6W59fKG1TI1g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 69903F80604; Tue, 13 Oct 2026 17:48:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 86EBFF805F7;
	Tue, 13 Oct 2026 17:48:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2C080F805A0; Tue, 13 Oct 2026 17:47:59 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.62
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791906477;
	b=aAlk3FpAmRQ7y2vB8Xmxpd4zIuwxoH4IYzRR5JMwAsLfKUytp3YfrJJ45xTL7mndLwFH
	 D5EcsfNLJoLNIuXUxyb82OB+nHUuby5hi4y7ZaRe9LwVfRbcBEfUoeBslcvnzIPi87I7e
	 jF8lb0TZSrG2jCp+6FuEK+ZVMxqkpwtuwHObKuee5wC1RmVpBiDaFA+RlFk0z6SildPKY
	 3iGvpczduqnBm9FxqVNOLa5gU8+nomT8THbQqE1P8+GoOjPtuMmrn5o3N+hmUfea/CjeJ
	 MAx1jV1gEOpwx0m2ry/EHo7MLo4Ou9xLnXdeyQ+hPI/P3pT5XOeT77cRG3SLPkmaToQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791906477;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jWvvmMYMRXHpEAlMKD6TTSrSgvKWy5PurfZW8LK+QLI=;
	b=hHhTIiIjlnqqWXDBcvv57whin6W3VHfBMtkOhd6tRz26C/hgVLcfbNm61Q9EnujrBRok
	 movD4u/abXukfe6ONDIpD0e96Y2HGDmjRattZ3qi32iZKc4Ss+RHPmiv7wcfz8YE6o8/Z
	 fWk6OtG8N3lg2M8VY/g0DW+DKKOxrBElb8xObLihj93GoZHpMnG54NZoDwC7NQ7GszXjF
	 uO5MUjN+oNzMmy57Zb0mHvulFp/2txbmyBUj0YC1PPeFz1tGiJR0P8grOaPnTWmY/DRAI
	 svYW3ifrmY9Q4i1+SDGVZDgM5CUfdvemqDxy7hPpdZ42p7pcPQlUbW/PR+wygeSqjjw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=w5o2e3gl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.62
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011062.outbound.protection.outlook.com [52.101.57.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8A84CF80448;
	Tue, 13 Oct 2026 17:47:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8A84CF80448
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=w5o2e3gl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vAA/m/j8ZLAO2J793fE2R6ircAo1nH3r/9CbUOZlIdgfEmm0RDRrhwKR7I8O+rnM8zrOdeTNG4l8Zs3+AMEubryRlEjIL0r2UgTNqUvopS3G6+8ZCFTJsRHAUxkJ6HBqkMAlSYXJNeDSkmoeljo6kvLphwkOqdxbonpq4XIkMS06YGLbrVV495xOw9vyiwrrHU2s/iWYTudFco4GHuCEIiHAmnwU0KWfmnNwXC4rQLZEmd9GL+/HEX4FN1JcSkT6vS0M6wuTTa60ZU0vKqJp28qRe2GkrzMsltvX3i5pDiZAWWYxr2MIkLYm9D3r4hQqj59MiTSLqQ6DhhcKYc6CjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8w50jiJdV9jvJwvRxJMO4GNxf8MdWXUmTipDcS4/sh4=;
 b=LFqLlOcfF1Tua15NNEUCcWb8CF3yUPmlSfH3kN0bDe8WL6KfohTsMPxziOIDJUULT932p7QUKgLYWUYF8rR894B26zGoA3YCBdOoqG3W7JFCTpNuNG0uBbV7qcZ3ohLIbugiIxW13bOpRoUdMkWMOTwLMbilYIKM4D7zlEwyLnyUmN54ljsb2/KB35awcrkt0Lg3juqzv2+Xs7qcGKB9u8qV8ZAvlSnno6BhTlRCqmylzPqVfuKF/C/A9v7cOtBfNl+aSGgzhwLNfRQZeE6eR4HEBcnUUbpTT8Vd55+jxu9OrX3Ha/Z0u54vJ5FTvKrKsfW7o/wjT5pTp7z0VlPQqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8w50jiJdV9jvJwvRxJMO4GNxf8MdWXUmTipDcS4/sh4=;
 b=w5o2e3glaaFiHglZxihgRlrllYK0dEee+9cQLt2/ZQELdu/ZzgwXqf9TNMu945IxBPvzqSdiMS/tE8bjMdqam3BBoUAagLe68p7rAzdHfPuBOjYwNIh88zVzI3NhD90sBsjRuYkuyZ8fZVM4KcOAIxOY+ie9wg6sqDLwCMhecOo=
Received: from CH0PR08CA0023.namprd08.prod.outlook.com (2603:10b6:610:33::28)
 by SA3PR12MB7808.namprd12.prod.outlook.com (2603:10b6:806:31b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 15:47:48 +0000
Received: from BN2PEPF0000A801.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::46) by CH0PR08CA0023.outlook.office365.com
 (2603:10b6:610:33::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 15:47:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A801.mail.protection.outlook.com (10.167.245.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 15:47:47 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 10:47:41 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Tue, 13 Oct 2026 10:47:37 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <yung-chuan.liao@linux.intel.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<Vijendar.Mukunda@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>
Subject: [PATCH 1/9] ASoC: SOF: amd: rename acp7x machine table and descriptor
 to acp7f
Date: Tue, 13 Oct 2026 21:11:33 +0530
Message-ID: <20261013154644.3788064-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261013154644.3788064-1-Vijendar.Mukunda@amd.com>
References: <20261013154644.3788064-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A801:EE_|SA3PR12MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f5e4e6-eea5-4629-61bf-08df294154ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|11063799006|261009223027099003|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 
	Y0AKPEaCYVibCCbq+4f1EOv6JZvlfuIV7/9jxvyJXAzNIIdaoPCC4L+Iq3jiS6FtWxpf8vZ3yMaskFM3YO4Wub8+Z40+kgBKVsQn5qmazhHwZDLI8pAsCVjJHUA1Mtpe+EOlIJvm4bV/yOr+YHZWu2+63o0jMuRdKg34H40o8ju33/6khsB0MZkZt04tAWu5CA2KlaVBciHhU8QbRdfa7tFBCe2t07zAcFb3yAT0lVUYCNFMYNdkdpDCZmFCA5PHxBIrdsEocSDt1nAJ5xyN5eXS0lmW0d2CPha/MgK4CIuWUv/963z+SXM5Tf5aYl6j14tKrFwSsxZADXq2L0a0k7L+kpsgXeBByAgUf/N46fczw+estHy6mcDD8mStsLyv14QOmdRpo2zex2JONBvvB7WazmlkiFxVQ6VlDrMUGQzmWOYeKypSiYOjTh7ixtI19GZVHaER7NdL+TZyUCbHbitQgLklvS1IyvOJ3X9RipwIuLoHLf3DZZRGoJMHGutXBjaoyH5d4qafB4AKFihWBquDeC9E7n8cXy3QlTLFP6Qj7uoM9/Sy/2kUNIXYdWGRHub04hnghvG94y0V6jPJTFzuew8UgIY1jD533/dJpAcbp30EkMzvxjQ/eRN1JE51ZsHg/kkB+IeBDcXLnktg0O1rMbsH2J1mRVUSQKhqfh3bCbNTmZuunkbFXXMkTucmR4NAh9mmKPwJ9smJrLhheQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(11063799006)(261009223027099003)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	pggqDf7/xMNMj6FvAUubAjrzu0o7+/gLHtr3D9kk3FNSk6g2TislDIQYRTVHFEEZgYf3UfX3DRm1i4jbCdrBppFgGy+z4Rr8Gi9lCz1THpDFdRq+VLba8jn98GATzCUWqaclnrOTn/ViKz4PTY9URPHyGOsVA9oIUiqO2VxmKS14XeTYFt1xRBugrBcnkUw+WkUqix9FjcxSdCytftqi5wbQRlSkObuuwUCsmNzxIhmEgWCPvFY5hI0uoKGOm7xEl9gslVZ4/NULGetAaZr5JmmCEH+lFzskCJYVHCv88UEWL0y/kMpcyTpLscUG+f0m4V2wSYGsJzzCvrIpiaoDEi06s96wlAe61e3gIab7Zr7KexkFlIGcamURTFfOuqtJomr8d7j1GcCnoY3wZ/FhRHiyGLEjxKeBJ7+x6hv8f3AcLA1thv7OEqniuImCF7db
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 15:47:47.9592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e4f5e4e6-eea5-4629-61bf-08df294154ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN2PEPF0000A801.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7808
Message-ID-Hash: 4AEHSAAW2HH3ARU2D3ICGLIG4JCKKVKS
X-Message-ID-Hash: 4AEHSAAW2HH3ARU2D3ICGLIG4JCKKVKS
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4AEHSAAW2HH3ARU2D3ICGLIG4JCKKVKS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The existing acp7x machine table, chip descriptor, firmware, and
topology files all target ACP7.F hardware. Rename them to acp7f
to reflect the actual hardware variant.

No functional change.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp-config.c    | 10 +++++-----
 sound/soc/amd/mach-config.h   |  2 +-
 sound/soc/sof/amd/pci-acp7x.c | 14 +++++++-------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/soc/amd/acp-config.c b/sound/soc/amd/acp-config.c
index 3d48bb0f100f2..d40600e12d4f0 100644
--- a/sound/soc/amd/acp-config.c
+++ b/sound/soc/amd/acp-config.c
@@ -428,17 +428,17 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_acp70_sof_machines[] = {
 };
 EXPORT_SYMBOL(snd_soc_acpi_amd_acp70_sof_machines);
 
-struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7x_sof_machines[] = {
+struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7f_sof_machines[] = {
 	{
 		.id = "AMDI1010",
-		.drv_name = "acp7x-dsp",
+		.drv_name = "acp7f-dsp",
 		.pdata = &acp_quirk_data,
-		.fw_filename = "sof-acp7x.ri",
-		.sof_tplg_filename = "sof-acp7x.tplg",
+		.fw_filename = "sof-acp7f.ri",
+		.sof_tplg_filename = "sof-acp7f.tplg",
 	},
 	{},
 };
-EXPORT_SYMBOL(snd_soc_acpi_amd_acp7x_sof_machines);
+EXPORT_SYMBOL(snd_soc_acpi_amd_acp7f_sof_machines);
 
 MODULE_DESCRIPTION("AMD ACP Machine Configuration Module");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/sound/soc/amd/mach-config.h b/sound/soc/amd/mach-config.h
index b602a983feb7f..2dafd742dc01c 100644
--- a/sound/soc/amd/mach-config.h
+++ b/sound/soc/amd/mach-config.h
@@ -28,7 +28,7 @@ extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp63_sof_sdw_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp70_sof_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp70_sdw_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp70_sof_sdw_machines[];
-extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7x_sof_machines[];
+extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7f_sof_machines[];
 
 struct config_entry {
 	u32 flags;
diff --git a/sound/soc/sof/amd/pci-acp7x.c b/sound/soc/sof/amd/pci-acp7x.c
index 0594c1f3deb6b..5949aefe26bc3 100644
--- a/sound/soc/sof/amd/pci-acp7x.c
+++ b/sound/soc/sof/amd/pci-acp7x.c
@@ -26,8 +26,8 @@
 #define ACP7X_REG_START			0x1240000
 #define ACP7X_REG_END			0x125C000
 
-static const struct sof_amd_acp_desc acp7x_chip_info = {
-	.name		= "acp7x",
+static const struct sof_amd_acp_desc acp7f_chip_info = {
+	.name		= "acp7f",
 	.pgfsm_base	= ACP7X_PGFSM_BASE,
 	.ext_intr_enb	= ACP6X_EXTERNAL_INTR_ENB,
 	.ext_intr_cntl	= ACP7X_EXTERNAL_INTR_CNTL,
@@ -45,13 +45,13 @@ static const struct sof_amd_acp_desc acp7x_chip_info = {
 	.reg_end_addr	= ACP7X_REG_END,
 };
 
-static const struct sof_dev_desc acp7x_desc = {
-	.machines		= snd_soc_acpi_amd_acp7x_sof_machines,
+static const struct sof_dev_desc acp7f_desc = {
+	.machines		= snd_soc_acpi_amd_acp7f_sof_machines,
 	.resindex_lpe_base	= 0,
 	.resindex_pcicfg_base	= -1,
 	.resindex_imr_base	= -1,
 	.irqindex_host_ipc	= -1,
-	.chip_info		= &acp7x_chip_info,
+	.chip_info		= &acp7f_chip_info,
 	.ipc_supported_mask	= BIT(SOF_IPC_TYPE_3),
 	.ipc_default		= SOF_IPC_TYPE_3,
 	.default_fw_path	= {
@@ -61,7 +61,7 @@ static const struct sof_dev_desc acp7x_desc = {
 		[SOF_IPC_TYPE_3] = "amd/sof-tplg",
 	},
 	.default_fw_filename	= {
-		[SOF_IPC_TYPE_3] = "sof-acp7x.ri",
+		[SOF_IPC_TYPE_3] = "sof-acp7f.ri",
 	},
 	.nocodec_tplg_filename	= "sof-acp.tplg",
 	.ops			= &sof_acp7x_ops,
@@ -95,7 +95,7 @@ static void acp7x_pci_remove(struct pci_dev *pci)
 /* PCI IDs */
 static const struct pci_device_id acp7x_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, ACP_PCI_DEV_ID),
-	.driver_data = (unsigned long)&acp7x_desc},
+	.driver_data = (unsigned long)&acp7f_desc},
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, acp7x_pci_ids);
-- 
2.48.1

