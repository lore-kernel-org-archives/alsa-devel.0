Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3B8C43458
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:01:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A99960220;
	Wed,  1 Jul 2026 12:01:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A99960220
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782900086;
	bh=c9TA/P0L4ccO7GGiZ/7IlZEwdxFLXNJhK2nGA0W9oPU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Ggclksz66dqfI3JKSqSGgky+qP0hiIVPJTdpW3OTxk8gtG01q0odjARGTRtC2ImSF
	 BXkZJrBrQGiUvHziFZCbfXEGgtXOZ1cG/39VfSvSMD7p95XYqwL0TC/W8ujcmicXpq
	 V/Jk3eS4+eOfGj2XB7sngBxLZ5Mxtavp01+iaIF4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 17002F80717; Wed,  1 Jul 2026 11:59:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F25EAF806FA;
	Wed,  1 Jul 2026 11:59:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F0708F8068D; Wed,  1 Jul 2026 11:59:01 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.25
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1782899937;
	b=Z/knTIoBWZfdifVfSxkeBvwUIPIzvah5xgXd1gCKgjAmMpzPJLZE461UFDvMjg1g0Cxl
	 9RLA7pUIyZBx5U9MiuWonv6TDCOEoH3Lrwb4U6L3fkJu91EvnIAUjhoT4QOSh5ibw9xNX
	 ZIiccAZQRW6CXM8iqvj/RQfjXQFMyF/Mb7IpcRH01VsduZIOK0O/RC/Gvq0ceX5rr62RX
	 pvVRSOEzd057fQYFppiBmZJYPxifKHKj3p6/PLJssa011CXqheK/rOqfhtIYuGS+7zz3A
	 sjYTqdHAgPcxLCE0bs90G0T+WRhw5ZhO7Z5g09Bfcl1YHPeTlMdkoQU2N87prqcJFAA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782899937;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=c9TA/P0L4ccO7GGiZ/7IlZEwdxFLXNJhK2nGA0W9oPU=;
	b=GSRgMqGzieEtF/tCvWqj8lq6vMgwB10Y43JJ2WLxWfLmIjSHIXhOjwG7QmZEF7O0aG54
	 cCof4XOAPsqUjcmhiMCF7vECQx+oiy9P9tDRzGZOP3QnXtad6rgSlO7ER5v2eOQTowXKg
	 O8l5bxOVGY75mD/I1rlUoqK9InWr7UKb2/7V06z6jaq/JGQsd6hTgmYJ5Eq1XDq7AgnIk
	 lj8LsbISVlPuT2BZ2cyMxcxWcL4na7UcW/8keywzpJDYZaVgHlgN+hN0Go6x4VFpuyb2I
	 b8HMqNgSZGuDGpt2Wt3rL4C3oAh1wAg7f8KL3QajpqeuYxz1XusRrLggrBmKD3LtSeQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=fpUelaKQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.25
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D5607F80641;
	Wed,  1 Jul 2026 11:58:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D5607F80641
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=fpUelaKQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHMGMJOQ+SZUCERKtT5KpnPNhHZpgyePRRmmJhLgm/WMm46Dgg3jV7eUDmthnZJGklBvcwb3nrfdcFd6EiwsxpuQUbjX453YIb+0DOWSucAudp4urubd94tWD1P4eU/R6TDHZYAkQW5Roe5ljdY9UctodleeXsfQs6GQjq41hbxzWWXfGw5siSgO2Qvrt9gutDbqx/T3LPWY3WuPWBzhDbB1AYa6TE4oCCgZvaHgUWh0X7v2nlK6ZLc26Ha4AiPDPgcES0YQgkJsICqgfdC7nGCgkEc90ejIMJelEPo98EMZvtQTKgefRkyZHB16TWhvf6sQrdUZup2PWfejYa/dFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYawF+KLhTgIKp5SAIaTcX8eKABj91JD10vv7+b4t+E=;
 b=FhsQLsW2wDodbe3rryqCW9WMY7UgDKLoozZqfvJzCcWhESmszNlZS3oZAPgpKTOTt9sCPfD5fsF/0xA1rZ7sC3sURJQk/uk4MwAFvXspbxHcl/XGN9kbr1zyeQrxQEOr/LbiXVd/Pul/W8H7bUJJHJFmhGoAkEUoV/0yX3THCPglOFf1BaIu6T454jfkawSSGl16fU+LduA+L8fcH+VhHUt+OfKWmw3l3pb0A+FXcGpWDm7AthNpShlNY+m1pWVjXFYfivNrm05vzD0IgeaPyqKfHZGo4mEmzv4uMTBMVC5GX0UjyUJ+C452UGBLYt4+YlvXbrTYnKb97rk0EVFe2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYawF+KLhTgIKp5SAIaTcX8eKABj91JD10vv7+b4t+E=;
 b=fpUelaKQtNnCDN+v4T8TT5y8kIS4iAJSu4uZUC1bXdhT7R1VwA3cT+UXE5j+BN3RqN+9yI0xsKfHNr5tT2fOzqKNan209NUBx/OABq9VSfkhutaYpQ+Dte0ygzTqu5tj3Ehd17D51WkW1X8uhGqzXNSV9nOK2uf2XybGbyiZbBk=
Received: from PH5P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::11)
 by PH0PR12MB7885.namprd12.prod.outlook.com (2603:10b6:510:28f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 09:58:48 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:510:34b:cafe::73) by PH5P222CA0010.outlook.office365.com
 (2603:10b6:510:34b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 09:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 09:58:47 +0000
Received: from vijendar-linux.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 04:58:43 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<perex@perex.cz>, <tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<mario.limonciello@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 05/16] ASoC: SOF: amd: add ACP7x probe and remove
Date: Wed, 1 Jul 2026 15:25:06 +0530
Message-ID: <20260701095759.1012929-6-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|PH0PR12MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: ec39c1dd-a367-4494-fe59-08ded7575878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|7416014|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	xl4qh8HC6HYqz7XpFTEZ6UG8wIifVcpa9ZBrOK2aYb0nIaJmAUXdVT9kXijace0HkXC3B7rEUKfpoh00frZpVVLn480mWcAmzWaia/sVMVMWWF8zYYefhYR5jmlg/5ppzQAy+UICfO11nBIngNDo88swzuZeWODfthg//Eyi4H0RjdtWoYK01LLLJYkjzjlY8lvbz1pPv5j4yHAtN0EpORUkF0ghGUnzYT0ojt4SLaPRiZTqON7pKnOlmzLJZrfT1KHWci7/+4Kr0TpOt1qygJuGxm3Ny/v4oaQmf+KlDs5WH/Rmp4COiMUSGH/J7hA7QJpcn5er8OEtgxp6FEivguLX5k7H/+CTSMIJCduPQBfeF9jP8TGfEadU1lPvHEsslCb0Mx3K5C3WE49s0VR0WIvmzg5YqDnu7vvFfSHylQ2GJzS/PWYOgKf6lJb6KJcaJZuJUxUXxgbV6Sc9dkuRPthg/hy8WlbZMCjUcgJWzLDR1j1moUsD/AOsTYmlBkC6rdE0AAY5iZMnof1Rym9RGalCMJbl/juwJs7agyWmspEnlfU4G1NRIzbixn+CuQeTS87zsDQxGLE5dXa9jWEGX+m4Wjx54NZ+KroGVXoLS7mXhdhQusBK+lgHosxdth2+dO2WAlyb3E4XcuyuALk1agpa9RGKZpLKZlShsvJMtoWOH1epOvl3W1SQSbjJZIe9JJUWM0Im54X8CANIt+BGaQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(7416014)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Zf99Fv+UQHGhMtWlmpg+K/gKo9ScnyXyKAJYRRgVYVBaH+/KcQP57NFYulo+c8XDifXXr7GZxvFxpaPMN7mee3+UwrSRyJ+bJDvqaLAE/TqEQ/UHedgfxypfTTXiCYPLWaPKnmVZuE1TY5XMJfXeQurgr2RxAtn74bzrDeMWMXdEa39kTqiyvDJuiYQpSJPzZ5fTlR87UeCLiB4HNz9OP+Ok66XB4pjgOJjwvaq0CO5UWS0jE6qKEokR7ke03eTKDP5Sqx9SzQvEPQI0Qt4N1QkehxEd+GSZRswd9j2vG/pNjXxtFknLmUWgMLm7qnrZTdlSMzwysyGNFaB5sY0oPx/VDmVOZcA0sPMTdmvsljv7qUDbE7UGWw6ANUjnmvE0PgmkTcejQrNwE+wNecwKF6gM5fTsQk7Qhr56vgjwnkbFwfAOSlr65jY0kVuzNkGE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 09:58:47.8984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ec39c1dd-a367-4494-fe59-08ded7575878
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7885
Message-ID-Hash: RFKCWSLLB7KA535L7XA7LBMYSAP6BWNZ
X-Message-ID-Hash: RFKCWSLLB7KA535L7XA7LBMYSAP6BWNZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RFKCWSLLB7KA535L7XA7LBMYSAP6BWNZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add amd_sof_acp7x_probe() and amd_sof_acp7x_remove() for ACP7.B/7.F.
Wire probe and remove into sof_acp7x_ops_init().

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/amd/acp.c   | 102 ++++++++++++++++++++++++++++++++++++++
 sound/soc/sof/amd/acp.h   |   4 ++
 sound/soc/sof/amd/acp7x.c |   2 +
 3 files changed, 108 insertions(+)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 1f0fc052ea1a..b2c319857ad8 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -12,6 +12,7 @@
  * Hardware interface for generic AMD ACP processor
  */
 
+#include <linux/acpi.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -1030,6 +1031,107 @@ void amd_sof_acp_remove(struct snd_sof_dev *sdev)
 }
 EXPORT_SYMBOL_NS(amd_sof_acp_remove, "SND_SOC_SOF_AMD_COMMON");
 
+int amd_sof_acp7x_probe(struct snd_sof_dev *sdev)
+{
+	struct pci_dev *pci = to_pci_dev(sdev->dev);
+	struct acp_dev_data *adata;
+	const struct sof_amd_acp_desc *chip;
+	const union acpi_object *obj;
+	struct acpi_device *adev;
+	unsigned int addr;
+	int ret;
+
+	chip = get_chip_info(sdev->pdata);
+	if (!chip) {
+		dev_err(sdev->dev, "no such device supported, chip id:%x\n", pci->device);
+		return -EIO;
+	}
+	adata = devm_kzalloc(sdev->dev, sizeof(struct acp_dev_data), GFP_KERNEL);
+	if (!adata)
+		return -ENOMEM;
+
+	adata->dev = sdev;
+	adata->dmic_dev = platform_device_register_data(sdev->dev, "dmic-codec",
+							PLATFORM_DEVID_NONE, NULL, 0);
+	if (IS_ERR(adata->dmic_dev)) {
+		dev_err(sdev->dev, "failed to register platform for dmic codec\n");
+		return PTR_ERR(adata->dmic_dev);
+	}
+
+	addr = pci_resource_start(pci, ACP_DSP_BAR);
+	sdev->bar[ACP_DSP_BAR] = devm_ioremap(sdev->dev, addr, pci_resource_len(pci, ACP_DSP_BAR));
+	if (!sdev->bar[ACP_DSP_BAR]) {
+		dev_err(sdev->dev, "ioremap error\n");
+		ret = -ENXIO;
+		goto unregister_dev;
+	}
+
+	pci_set_master(pci);
+	adata->addr = addr;
+	adata->reg_range = chip->reg_end_addr - chip->reg_start_addr;
+	adata->pci_rev = pci->revision;
+	mutex_init(&adata->acp_lock);
+	sdev->pdata->hw_pdata = adata;
+
+	ret = acp_init(sdev);
+	if (ret < 0)
+		goto unregister_dev;
+
+	adev = ACPI_COMPANION(&pci->dev);
+
+	if (adev) {
+		if (!acpi_dev_get_property(adev, "acp-sof-signed-firmware-image",
+					   ACPI_TYPE_INTEGER, &obj))
+			adata->acp_sof_signed_firmware_image = obj->integer.value;
+	}
+
+	sdev->dsp_box.offset = 0;
+	sdev->dsp_box.size = BOX_SIZE_512;
+
+	sdev->host_box.offset = sdev->dsp_box.offset + sdev->dsp_box.size;
+	sdev->host_box.size = BOX_SIZE_512;
+
+	sdev->debug_box.offset = sdev->host_box.offset + sdev->host_box.size;
+	sdev->debug_box.size = BOX_SIZE_1024;
+
+	if (adata->acp_sof_signed_firmware_image) {
+		adata->fw_code_bin = devm_kasprintf(sdev->dev, GFP_KERNEL,
+						    "sof-%s-code.bin", chip->name);
+		if (!adata->fw_code_bin) {
+			ret = -ENOMEM;
+			goto unregister_dev;
+		}
+		adata->fw_data_bin = devm_kasprintf(sdev->dev, GFP_KERNEL,
+						    "sof-%s-data.bin", chip->name);
+		if (!adata->fw_data_bin) {
+			ret = -ENOMEM;
+			goto unregister_dev;
+		}
+	}
+
+	adata->enable_fw_debug = enable_fw_debug;
+	acp_memory_init(sdev);
+	acp_dsp_stream_init(sdev);
+
+	return 0;
+
+unregister_dev:
+	platform_device_unregister(adata->dmic_dev);
+	return ret;
+}
+EXPORT_SYMBOL_NS(amd_sof_acp7x_probe, "SND_SOC_SOF_AMD_COMMON");
+
+void amd_sof_acp7x_remove(struct snd_sof_dev *sdev)
+{
+	struct acp_dev_data *adata = sdev->pdata->hw_pdata;
+
+	if (adata->dmic_dev)
+		platform_device_unregister(adata->dmic_dev);
+
+	acp_reset(sdev);
+}
+EXPORT_SYMBOL_NS(amd_sof_acp7x_remove, "SND_SOC_SOF_AMD_COMMON");
+
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION("AMD ACP sof driver");
 MODULE_IMPORT_NS("SOUNDWIRE_AMD_INIT");
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 063aa41dd237..46b946132de8 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -277,6 +277,7 @@ struct acp_dev_data {
 	/* acp70_sdw1_wake_event flag set to true when wake irq asserted for SW1 instance */
 	bool acp70_sdw1_wake_event;
 	unsigned int pci_rev;
+	int acp_sof_signed_firmware_image;
 };
 
 void memcpy_to_scratch(struct snd_sof_dev *sdev, u32 offset, unsigned int *src, size_t bytes);
@@ -353,6 +354,9 @@ int sof_acp70_ops_init(struct snd_sof_dev *sdev);
 extern struct snd_sof_dsp_ops sof_acp7x_ops;
 int sof_acp7x_ops_init(struct snd_sof_dev *sdev);
 
+int amd_sof_acp7x_probe(struct snd_sof_dev *sdev);
+void amd_sof_acp7x_remove(struct snd_sof_dev *sdev);
+
 struct snd_soc_acpi_mach *amd_sof_machine_select(struct snd_sof_dev *sdev);
 /* Machine configuration */
 int snd_amd_acp_find_config(struct pci_dev *pci);
diff --git a/sound/soc/sof/amd/acp7x.c b/sound/soc/sof/amd/acp7x.c
index 87c70014d777..3366e1b638af 100644
--- a/sound/soc/sof/amd/acp7x.c
+++ b/sound/soc/sof/amd/acp7x.c
@@ -137,6 +137,8 @@ int sof_acp7x_ops_init(struct snd_sof_dev *sdev)
 
 	sof_acp7x_ops.drv = acp7x_sof_dai;
 	sof_acp7x_ops.num_drv = ARRAY_SIZE(acp7x_sof_dai);
+	sof_acp7x_ops.probe = amd_sof_acp7x_probe;
+	sof_acp7x_ops.remove = amd_sof_acp7x_remove;
 
 	return 0;
 }
-- 
2.45.2

