Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BDAC43458
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:05:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9176960296;
	Wed,  1 Jul 2026 12:05:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9176960296
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782900320;
	bh=kyWbQFThqFCfNt1k6sJVcDAGUoUj8GlQ59jpaXz1tXU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=n+CLs5Sp7ljHSrR3XUqUH8B/6cZf/B4pS4KXaJ16KHVtO+2aULU9rJyPva8DrcbBs
	 18Tg4uYOGEUr4WlRbFKSgINYkEZ8W/fdzTqYETCOuZPaoaIcVb6IEBkqWaZp8zlMnf
	 IftspcsouYfTPnEoY1nCMDfNLKrqHBcSkLmqVnvg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0ED15F89701; Wed,  1 Jul 2026 12:00:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1DABFF89728;
	Wed,  1 Jul 2026 12:00:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4DA04F80C8C; Wed,  1 Jul 2026 11:59:47 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.43
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1782899980;
	b=IKhfX7upqwfALhLFnyG4/ezkju7SlCd85dy/RoHyNOr+DlhZwEbDy9pBLFHS8kCrolVA
	 +MPlT/WtCoBZlZg7fLTgihyAp3BBRNMvRmXYZjtLtvii8rjmQ6AGWDxcHGWsVRn7XsKrX
	 9hcI4um+kNn4ykfqgQbwiSYkaRUCh3oM1OF113rUUQ3jsh1XpwD0eygQaX9HZIsdkZizB
	 nX4KSaP37DlGutLHwfy4E5SJ/tg9QmLSCjgZWfHu1JLD9EBM9oJGpul13UJvhyanxFVB4
	 bMQEP5FdoS2q3tSbLZIcwi3W+VsyMnWL1n7/HcWQqe1Qd8W/20o2xznEsSTrt6PTs3Q==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782899980;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=kyWbQFThqFCfNt1k6sJVcDAGUoUj8GlQ59jpaXz1tXU=;
	b=hZgv/t7/MysSqlyCR8VyGF1KxsjBAWy8fwaFAbkQ5jnSArJ8b0iVeNrR9WsZwUTTe1H0
	 17ZY0ZFxsq6++n8Z6biRJHmt8A4Zj2lkhF0ApYMpajL5XOaMdq8BtQYhMjfySj0fNth2L
	 Udj+JaSMhQwaioEIftbnCkmFzP4FD+2rrNPXvuyO0B8eUyhsIYKDSKlCgDxnQO7QSk9vx
	 bkjbYlZPieM8WfsMkcaaBXkNiVqEbxeHIQSerRyICuAH46lPYitljzrrhfy0Ntvb/AhYw
	 JME3qWAt5WdVqUOS7PR+UiIO8EsrsiKY6uJv0NXQuTUOuifKlZ2Byvc8guvlhu8wUtw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=SLIKRet3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.43
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013043.outbound.protection.outlook.com
 [40.107.201.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4E4B4F808C2;
	Wed,  1 Jul 2026 11:59:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4E4B4F808C2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=SLIKRet3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlReb45FGfP3k4mUtFZHYC+QAxjTWiYAJTPyR1YQE1Hg8y0nvub3xEpmC9QkCLx0QaLnxH4gNQFpciuUT7VH3LNoV0W58otDFbPBlWUQge5fHRSBVqRJrJHwy1xzIFw1bxQtu6XgAn1oqm7AzJubOg0ZESCwAAmv4JaB+xQ4Zx0D4eRfluj1sSRUlemuY+wDuD7Log1IoAonBxy+iCMExfB94JwB0QvC9pYvXzRS7KKD3kQCLplg/5JhnQJKEAtR+I+HKUtIrTwZcTtdrOS3yXey2/kpSIdluiDxGuynyJjxpk3Fp3ow+HvDh1O8RPggOtDGHOZzPrSce3zaQlQp5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJgyHQAj2gOiPrwAqeabOjmKQnfCjhOShIkB+eZxTdc=;
 b=PuOTXFjN96w2yWA3y/h0RAaFuo3UiSxT3bWiCJF85Lmf/3fm1elcWuroMwzn4BySjMgU3L8Y7Fn7wCQ5+EFXBJNtMYSUec4svJGi9ip8VHr90luv4Oep8OIuC8D8abbGvftgZYqldw5fw4MRjHxY3scSBFT/hnGBABH7dPAdWWTzFdFGkxtESrlnJ5BHRC251HzYOVGmR++kfnGeHEREVWGVkpOZpWhuJxNX3bCrWJ6RPNRPm4Fy6PVjV9cuGAKu/lQl4Vi7dVuk+G/mkcJ7F0tWX5k7WPotV23W+XeGtzugGvOA77Oq9f87uwHOyVZHrY44hfKpuwwEuHfEQuQksg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJgyHQAj2gOiPrwAqeabOjmKQnfCjhOShIkB+eZxTdc=;
 b=SLIKRet3pfOmUsD2YusIXMUFwu6MlNvn9WNcI2EVksJlyoc+Oypr4lZJj7OzmYe9o6jh3rhrgFTDNbbLlQgDpQiSQ+E8tsvLxMveMah1pPgvqCnchfXJH+pcrathwtYo+zGEymnMUTseG7cZNcLBPZaZsNuhJ97RrPgqSpNU9Ak=
Received: from PH7P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::17)
 by DS0PR12MB8069.namprd12.prod.outlook.com (2603:10b6:8:f0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Wed, 1 Jul 2026 09:59:32 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:510:33a:cafe::56) by PH7P222CA0012.outlook.office365.com
 (2603:10b6:510:33a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 09:59:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 09:59:31 +0000
Received: from vijendar-linux.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 04:59:27 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<perex@perex.cz>, <tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<mario.limonciello@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 16/16] ASoC: SOF: amd: add system and runtime PM ops for ACP7x
Date: Wed, 1 Jul 2026 15:25:17 +0530
Message-ID: <20260701095759.1012929-17-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|DS0PR12MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: 122523ad-c48d-4b46-2832-08ded7577277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|23010399003|7416014|376014|36860700016|1800799024|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 
	HmuumdnMvRAvrKUA+rxxAItEC2V0pMew06u2UgMiy3zqVwk5VhEbjIayt1zUHnkZn72Xwj0omnVJHU33avOVoTUEVYSVQ5UxrgO9c9HzYpFf5y/ZS53xKgotxSfad9ihe5nSWFN15SO38bJPJc1FRaCFyQ8fMsoeEHYxssou8bBubBBgJCZuA4mCrsAzy6eN0laGGA8UezcSa6KCSDHj1i6HOxG/L762nnQjXmYEpPzW2rGu86K3vm4w2WY86BDOSS504GgrUcE/dv7U3CmKVkRqldWHThzT+kQyjFDTJmL9lg/fScYnP7O0z/wAMwBEOneo/JzJyawESoP7+c30rzFpdP6a8kvzd3EaMTz3rTB/MoojdT7vn7BhhK1iy2xCzWhJInpjiOwokqvFdoRADjU4K/9vJGaQ7bwucybluMOBaS6OaPse2WzMfLRaszhUkYKrMMiv+Byy3K2PXgf1nzpWdFWN9URCWMFZvhymoCNHn1NK9RQbd14BPIA/qwFHEcCjxFGrGWKV0sPIE58QTpCj6bv0ACbXLeSFU13u6cCoCIcQ/DBvi38gtHdy9M88dVOYB0rtewmJtzB5pLtSvxHL5Wc0o3FrETGPeMJR5MVVEFAzCyYDnbi8E4wi0JwCWTsSQzFQZpUhpbg8mzqf0Ukpi+TOv/aK13083R4wHut56TSqhd4TJTwqHIPAr9FQ8kQIMQsIafKcWmnn8eK1LA==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(7416014)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	TH+QpMdFUOjbnI+LJExIQOkm5Xr0n1V4Rvt6h/SvwBWERa4a6CkTRicRSjCCDrIPvcPTqC28/blIny+yLjE6LidHlGrKc3nJxxJBVSMCuCJD21rzIzLRjnK2iYz6C+ztYEPl9/CG2UDrszZAHlePDd8R9CDjRdAkGsBjIfT88DF7K/Jcd/J8MRBAbLLNTNd5ZkTRn84yzFyS/xmzFZz2sEFxliWgR9yo8v5YdQQNvjb9KPBCoKG0TgatXXntcOPpatFFEavLijpfkzVE6bYSUwwE223DX/aQWNqnCd+FM6X2yAuVBwrBd75E/dXJhbNENRpbpnpcyDMUz6TG9mcvugfwcLJSV0ZqDBcONQd8lQ8BE7czgItBEzc6SxXrlvfozPkQNKm3B9vAWhjq8l/3R/KO+MUguholoASA6yBqkmUB8H5em5LsY3iU/zk/azEX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 09:59:31.5114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 122523ad-c48d-4b46-2832-08ded7577277
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8069
Message-ID-Hash: WBM7HLXC53RI3BGAKHCR6D6LR6GWVQ7Q
X-Message-ID-Hash: WBM7HLXC53RI3BGAKHCR6D6LR6GWVQ7Q
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WBM7HLXC53RI3BGAKHCR6D6LR6GWVQ7Q/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add amd_sof_acp7x_suspend() and amd_sof_acp7x_resume() for ACP7.B/7.F
platforms power management.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/amd/acp.c   | 71 +++++++++++++++++++++++++++++++++++++++
 sound/soc/sof/amd/acp.h   |  4 +++
 sound/soc/sof/amd/acp7x.c |  5 +++
 3 files changed, 80 insertions(+)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index c2143821fb83..f89ad86260b4 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -1178,6 +1178,77 @@ void amd_sof_acp7x_remove(struct snd_sof_dev *sdev)
 }
 EXPORT_SYMBOL_NS(amd_sof_acp7x_remove, "SND_SOC_SOF_AMD_COMMON");
 
+int amd_sof_acp7x_suspend(struct snd_sof_dev *sdev, u32 target_state)
+{
+	struct acp_dev_data *acp_data;
+	int ret;
+	bool enable = false;
+
+	acp_data = sdev->pdata->hw_pdata;
+
+	ret = acp_reset(sdev);
+	if (ret) {
+		dev_err(sdev->dev, "ACP Reset failed\n");
+		return ret;
+	}
+	switch (acp_data->pci_rev) {
+	case ACP7B_PCI_ID:
+	case ACP7F_PCI_ID:
+		enable = true;
+		break;
+	default:
+		break;
+	}
+	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_CONTROL, enable);
+	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP7X_ZSC_DSP_CTRL, 1);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS(amd_sof_acp7x_suspend, "SND_SOC_SOF_AMD_COMMON");
+
+int amd_sof_acp7x_resume(struct snd_sof_dev *sdev)
+{
+	struct acp_dev_data *acp_data;
+	int ret;
+
+	acp_data = sdev->pdata->hw_pdata;
+
+	ret = acp_init(sdev);
+	if (ret) {
+		dev_err(sdev->dev, "ACP Init failed\n");
+		return ret;
+	}
+	ret = acp_memory_init(sdev);
+	if (ret) {
+		dev_err(sdev->dev, "ACP Memory init failed\n");
+		return ret;
+	}
+
+	switch (acp_data->pci_rev) {
+	case ACP7B_PCI_ID:
+	case ACP7F_PCI_ID:
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP7X_PME_EN, 1);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS(amd_sof_acp7x_resume, "SND_SOC_SOF_AMD_COMMON");
+
+int amd_sof_acp7x_suspend_runtime(struct snd_sof_dev *sdev)
+{
+	return amd_sof_acp7x_suspend(sdev, 0);
+}
+EXPORT_SYMBOL_NS(amd_sof_acp7x_suspend_runtime, "SND_SOC_SOF_AMD_COMMON");
+
+int amd_sof_acp7x_resume_runtime(struct snd_sof_dev *sdev)
+{
+	return amd_sof_acp7x_resume(sdev);
+}
+EXPORT_SYMBOL_NS(amd_sof_acp7x_resume_runtime, "SND_SOC_SOF_AMD_COMMON");
+
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION("AMD ACP sof driver");
 MODULE_IMPORT_NS("SOUNDWIRE_AMD_INIT");
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index c2f3add05d0c..16d66b2eaa70 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -359,6 +359,10 @@ int sof_acp7x_ops_init(struct snd_sof_dev *sdev);
 
 int amd_sof_acp7x_probe(struct snd_sof_dev *sdev);
 void amd_sof_acp7x_remove(struct snd_sof_dev *sdev);
+int amd_sof_acp7x_suspend(struct snd_sof_dev *sdev, u32 target_state);
+int amd_sof_acp7x_resume(struct snd_sof_dev *sdev);
+int amd_sof_acp7x_suspend_runtime(struct snd_sof_dev *sdev);
+int amd_sof_acp7x_resume_runtime(struct snd_sof_dev *sdev);
 
 struct snd_soc_acpi_mach *amd_sof_machine_select(struct snd_sof_dev *sdev);
 /* Machine configuration */
diff --git a/sound/soc/sof/amd/acp7x.c b/sound/soc/sof/amd/acp7x.c
index 94b7ea08b309..b6722d11168c 100644
--- a/sound/soc/sof/amd/acp7x.c
+++ b/sound/soc/sof/amd/acp7x.c
@@ -176,5 +176,10 @@ int sof_acp7x_ops_init(struct snd_sof_dev *sdev)
 	if (acp_sof_post_fw_run_delay)
 		sof_acp7x_ops.post_fw_run = sof_acp7x_post_fw_run_delay;
 
+	sof_acp7x_ops.suspend = amd_sof_acp7x_suspend;
+	sof_acp7x_ops.resume = amd_sof_acp7x_resume;
+	sof_acp7x_ops.runtime_suspend = amd_sof_acp7x_suspend_runtime;
+	sof_acp7x_ops.runtime_resume = amd_sof_acp7x_resume_runtime;
+
 	return 0;
 }
-- 
2.45.2

