Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6536C43458
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2026 09:59:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9749660243;
	Wed,  1 Jul 2026 11:59:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9749660243
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782899993;
	bh=G4Ca02eqZqTAFolBGkYMOEul6NQ+AdKxr5wfldtC0G4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=G3YEQrt7/hM+m2PwgK/7iRGc3++BI1LthKpSECXZnujzSP1cFVNKL/cW+g4YN3gah
	 EvKXO3dBoOPWS/xCzS42MVgGweHwv5egTdM4L81xFJU5pGRkMWPRSbBEl04HGivraf
	 5GuYjOAPz0zfApmOm4wTdgm20H8xht6Xhuykjxfk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B9662F8061F; Wed,  1 Jul 2026 11:58:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BC465F8061B;
	Wed,  1 Jul 2026 11:58:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C4E28F8051F; Wed,  1 Jul 2026 11:58:42 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.67
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1782899922;
	b=QUSzuUF/j8V+4GwtrPGVamBNtf7ScNaSFTmOQFbhlz1UZmfoZsNDuaFRCzXzk3tDRUVa
	 8Fs01uxlFLpYFxrpG6lFKzN+vPD5PCnea1m845veA7znIvK+Uh6YS9KH6OnRAcEcwUly+
	 qH9pb7mBJJ3huaVzcSfyfWhbXYgEkzzYHPX1mL8Qg4VDjlFPqnnek7191L6qoFpg2BRu3
	 MkZI42r82NvfyUY+hrk1F4s7cSkrwi4lGnLGHHfdVQuigeGk8ajWZJ+AKCfoy+wezA/MM
	 SYWb7793EhdGlme71M7dcGATNQdRn4DNdhRJLvi5aR5FEXdiOCjmWeMmyYJfju452Cg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782899922;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=G4Ca02eqZqTAFolBGkYMOEul6NQ+AdKxr5wfldtC0G4=;
	b=Dh0KhrssNfSu89jRfwKeo5j9FL8RtVsgTfwaYRzuPLUtNlON5XM5LturptnPnkPwVZoH
	 CwVchzonJX5j0ETEdC0H3m3+UUKQ9xzindzXPlvqd39W/XA2yQVGJlgezJFTNTZtV6OZA
	 ewB2dRzWgagugNVUZt4HD/uA14Fp7sk6HYaELwGAx0ccUC5qySZfPGo6i/+DentVAOUQH
	 OT7GP+k/Q5BfYy61ULLaaHtNHcjCcJxqwFqYeGiDHGjxW4vt7yd0Ob1SxamYq1xsqG3YP
	 hqv52uInUa/QoZxCGICbZEd0zMLNAyrue6qf611962j7+aX13u5ZwyB44ejPCT4klfw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=RqZl4IVe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.67
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010067.outbound.protection.outlook.com [52.101.46.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A973AF8016D;
	Wed,  1 Jul 2026 11:58:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A973AF8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=RqZl4IVe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4NLO99FwYyQ6MueSWCN4O1vfXdyfj3QyPnPK5dZwcsKh3BmDci5m0O/kB755E1PApnoe+tDkC71RbUgUTRwy6MtcehxjW8Hcgfd1WH54NxudeaXNNrFYkvXTKa/vonBlIYXizKcx/0MUz4rbGgi45fd9ZS8mX0QXGyUlD63oLbWOcxF9OFBRz0zH8Vs6DoLcuVmwePjsz2w6kmn2K1GxxNQZuFbCqdKlGdyh+9DzzCSe0A/Pcq2Wxk46imSlNv//m3I6CWnsWsuBuQodcA5Ji0aTywrzU1mhab4zE+nVK4xeoKJvj87LxZHatfv0VaQl7XEMA3nMnv9GoeoVHswqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51hJSSJjKhjeBpgf3ZcoCnv4B5c4YZ9GT+YjfvNtOX4=;
 b=fmMUDpyjHceaiqSJHd/R/4aJWlcwVq86EIWD+tKSep/CZs0uh5iTIJ5BiF6APSDzDVBX9opNe3phq4tuW0USegCmWzO4jyqPZlQ2GMntquK4rl+bpMnfajFkdtDW1TR0Ax9YSliH/PEkp+IfTPdh1jpGTyiDHdnaKlDK3Y/zqi7vjQWK7GstT66N7O6+EeY8fxDcdrU+GDsCmcnHXQy8hRVrtd+/2RiYEFbM1V64oDGvGwNmIstKdyGr9nuOW7HSXi78i4wO1Y+LqsIuy1gcxcOQUF9YXxyD2CmwS03mezFV4fYRRabh2xWH41rVty0y/e9xVGyWS+EVk+pAJ4MjYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51hJSSJjKhjeBpgf3ZcoCnv4B5c4YZ9GT+YjfvNtOX4=;
 b=RqZl4IVenO0t0jdZpZMewMMVJLUn6COffcP6rzQkbZiSOaSXp2kG8JWzLYCsO7fUsIZxfJzIL5+YUT/uc+AX7EGGIo7kTdo+cWg1zvRH7NJzD0nQQx2+bw0R1UwXQpEOb5w26JsDCSNmOd4Cn0BK2Ge54vxTd65rsxvKc0lWyWM=
Received: from PH8PR15CA0013.namprd15.prod.outlook.com (2603:10b6:510:2d2::16)
 by DM3PR12MB9350.namprd12.prod.outlook.com (2603:10b6:8:1ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 09:58:32 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:510:2d2:cafe::af) by PH8PR15CA0013.outlook.office365.com
 (2603:10b6:510:2d2::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 09:58:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 09:58:31 +0000
Received: from vijendar-linux.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 04:58:27 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<perex@perex.cz>, <tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<mario.limonciello@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 01/16] ASoC: amd: acp: add ACPI machine table for ACP7.B/7.F
 SOF driver
Date: Wed, 1 Jul 2026 15:25:02 +0530
Message-ID: <20260701095759.1012929-2-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|DM3PR12MB9350:EE_
X-MS-Office365-Filtering-Correlation-Id: 913ed04d-368d-42a7-922b-08ded7574eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|7416014|376014|1800799024|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	JPiMsVj/yQp/3jN7eu6WbKq9ev4PA1S54oxTkxVTV8TPkQiSTz+UQi+apiiTB3bzKyvNInjA7YouKLbqhmCKqcSl2XyOoKb7h7v7svtr0hI2lAlxcly4x5oipK5pU1BWQze269xk/5/Cnj4lk3E5Nzv/+L68umZNQdAU6mJqNv1tO+GWNwIHK2CJ7mt4F6jY8GspUMMW4qUnt6rzTcsJKG+isGzJokOoVsx7xWtwvfPo9NSJM2B8+jcrp4rsLO/9Yn8CKvmHwIl/PGcCy5eWw1sjULJ6aqcVrXVZ14EK/zXDkU0X5eimS4kXDXfe/5x2YJrLDqLThG5ZcMrgs/ET959cUPOLQaVPvFFZS+h8pxalJXQUO+taTgtOdk8Ie6yzsxM4utRg146J3z2lPt0dOkd0emBbM4+BztkGNvV6iecyOs0x5aCeSx1+PojNTvp1oikABsRDqNXwC6OOv0HbO3zYRw20KFIXDp/uC1yd4wTZb41sWSkBPFKPa1qngSXTL17j+6/TzzD9ux32DMszT0RdCRLKwy1a7yBvtvCx3oWBs+jGV0XI9S+GLtXkLNorRKJwPu2+B6fO/DZQak+c7tg6YsIi3h7XGVn4EfgPjbBHe7+oVrGaLZuPC8n9KG3kTbetBYFkz3rLNMPVJ/aDXs27/eCeoSlSGOR8/i53jHr0AV2oewWQ391On6uG81LuBP22CnXFTFE6u1w+Fi171A==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(7416014)(376014)(1800799024)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	CCXmF8Znm2kKyU0evF+qFD6l+9jgD5osBBQgM81skObKodYZQ61Z3zTi6Bl0yoAP0l5rxKkfhflTExlMLX+rVT86XDEkY7qAMZzS8CXPf+FkbwIUu+dkt1yMDQrPGpDIpCLfUbSoLdMAxtyR3zLDJGJI7JZzWWoph4As+duHwT3ePNXksFasNNAOvv6APSnZSor2PS2NnP7/LaMYxYxRvOkjbRxJl1xNwEJMAd0kyOl58wzfhUmtuEY8nakeUdeP8FjidwAKxbyelZP2taiaL3cfMDTVHxE8pRBXHG1KPc1TWjSStxE4Pv0k67nwCvPOds7501griMwgU0kDCFp4WT7A0tieHo0T4ireoPsX8oiZqH2VW6gAv4EKtxTXt8PouL1CZSHbL0oRwZMEyHy/gjiUIbQGnxBMptz2q756MErL7tTA6i+ho1k7osHmBi00
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 09:58:31.8782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 913ed04d-368d-42a7-922b-08ded7574eec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9350
Message-ID-Hash: BKHEE2MZHEXIGSQGVQEXKLTOQJQKICQ5
X-Message-ID-Hash: BKHEE2MZHEXIGSQGVQEXKLTOQJQKICQ5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BKHEE2MZHEXIGSQGVQEXKLTOQJQKICQ5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add snd_soc_acpi_amd_acp7x_sof_machines[] ACPI machine table for ACP7.B
and ACP7.F PCI revision based platforms. Add the extern declaration to
mach-config.h so that it can be referenced from the SOF PCI driver.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/amd/acp-config.c  | 12 ++++++++++++
 sound/soc/amd/mach-config.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/sound/soc/amd/acp-config.c b/sound/soc/amd/acp-config.c
index 0d977f4f758d..93a2182d4e86 100644
--- a/sound/soc/amd/acp-config.c
+++ b/sound/soc/amd/acp-config.c
@@ -360,5 +360,17 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_acp70_sof_machines[] = {
 };
 EXPORT_SYMBOL(snd_soc_acpi_amd_acp70_sof_machines);
 
+struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7x_sof_machines[] = {
+	{
+		.id = "AMDI1010",
+		.drv_name = "acp7x-dsp",
+		.pdata = &acp_quirk_data,
+		.fw_filename = "sof-acp7x.ri",
+		.sof_tplg_filename = "sof-acp7x.tplg",
+	},
+	{},
+};
+EXPORT_SYMBOL(snd_soc_acpi_amd_acp7x_sof_machines);
+
 MODULE_DESCRIPTION("AMD ACP Machine Configuration Module");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/sound/soc/amd/mach-config.h b/sound/soc/amd/mach-config.h
index 5b6362103ca0..b602a983feb7 100644
--- a/sound/soc/amd/mach-config.h
+++ b/sound/soc/amd/mach-config.h
@@ -28,6 +28,7 @@ extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp63_sof_sdw_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp70_sof_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp70_sdw_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp70_sof_sdw_machines[];
+extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7x_sof_machines[];
 
 struct config_entry {
 	u32 flags;
-- 
2.45.2

