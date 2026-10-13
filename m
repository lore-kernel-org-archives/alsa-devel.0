Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4FACC6B03
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:05:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1840360232;
	Tue, 13 Oct 2026 12:05:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1840360232
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791885919;
	bh=jVGEJq3DlDXb89LcuCRpcVk7H7IdPFZkUOMjumnx5ug=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gps8qRJfkrQDCIBHTsyVadT/P9je7HpEyHw8qzhCFGlFSOPdhgh5cDEP8h9e1/07b
	 avKRNFztxLYp1XMct1IPZiA2aw83XtWtNFbKxJpY0aNIeIZuTwnXz2kFLdOWpsDWTy
	 MJvemKrT78lCXzg4/YGoHeRs1uRKzBzXakD55wNs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ED76FF805F2; Tue, 13 Oct 2026 12:04:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 45816F80620;
	Tue, 13 Oct 2026 12:04:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 57905F805B3; Tue, 13 Oct 2026 12:04:34 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.53
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791885870;
	b=GKS9DJouAI/hIZWU1tmAKrLKXOGVVbMOgFyLH4zrixFjyQIFdfizjz0hUCc1NhM6nz7L
	 I8VWNn8CkPh/6gFfE0/1M/Ui4CYZDymwofc4gndDZlG+Buci2e2dLT2dzz5dB3alBCSth
	 AAppQQDh1H3b8j6zNDAHMlysawMmZ0ZI0yYflwqyMPt4ZFUQURzxpTL6LIEJnOZgr6LUi
	 RLF4t/TANPxzxm1yJM4Msz3X54m07CJ3HJkj+JXq8QSmYlBeVNntkCbdepVnS9VJJTHi2
	 D/iLmwyDiRwqDhJZ8SH2eyXFDFA0kx0qB7T1YbYvvcK/fQ/RcM9Yrsfjr3PnFo6+3AA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791885870;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jVGEJq3DlDXb89LcuCRpcVk7H7IdPFZkUOMjumnx5ug=;
	b=rPkoOyXHDzHdvu0PZ2WDle4lZNBJbdn7NoV9kPx/wuqJF8lJ9DYzgPdwTn8+RXExy3KK
	 QefZyiVXjxnzrn4f4eLsyKuK9LvmyE+DxWcF5pP3/sybjboURLSWvgiR+2nKRfpminGH2
	 F3Zp0Rh0iWF7kTjRmGELty4JOlBD6pJeQqT5/8cl4Jr6quCJKsEF1qTo0vhePmTjt7zT8
	 p6gmmjCGYiCbDUXmwu/YSegCONOPp+ltVsUS0C6scITEtpR7wzQWLSyW2P6zzd06BgYDq
	 ExkmTvL6kpbOaNXH6xni+Ei+C4EOPYVlZYK/Y7z+Uep+zSpdveuVwYHlrfNAGYTvRAQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=N3AeK5Kv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.53
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010053.outbound.protection.outlook.com [52.101.201.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0CC54F8060C
	for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2026 12:04:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0CC54F8060C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=N3AeK5Kv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgY4W1lzoBh456BR0m4UnotKxBVDP/2wO4XfvIFTrUAvI8kZCqLoLjXWFRPYIAyFbFY8F4CM4FWOx9p3FZ4/zYWlgAs4u6rXE+7rvd3QVRm7qokw7LWOSoJ1SB2EiIAyN0CqQqje/qDddnmpyi/F3Qc5z0INV67SSzQDZSwzBj/PbhbAxTYJxqSjlXk39R6fzoVFuF9IFO4/mjY10fku/FLfNGrbFudjT7hYtuAjMddU/TlJgTtcmC0KO6nO3IOUOfu6rkLi/Oo3LstdzaRrI5kPCcvHzH8ylr7+0lolMfmzKRgFPrKvNHm5/8Duy3d4kruBaeoo7z6/Mziz3TidHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwCXNYXZEY2qKnkrMO+fVMTp1IyCtYaTLliuV5Ft//c=;
 b=D1Er9DjHbylU9UjS/3W93kCLoZhvno+Bs7x5ppdj1+5Tt5gPqnfSFNNn67iqeE0tV/Hrg7GZTFluZSBTHa3K1Ss1ZBOQqyjdNCZrKd743WRKWLXKbbjdAMEoZPTLE9vDPdHso9OZ6xLbFfqmHdxHdhYqkywm6YZWCIC6pjsj/V3noAfXKcEA2cPnuPVAliGdjRwpAtsRhBipY2XkW1ZAMIWIg7RpWE8kNH/Igz166eNJuAeUOVb8++gevVaC6vhaOt3xCK4kNPtEZvWFH4b83M3tSpQcTVksmb8BU9FuHweNmldjHLkZQuCZSDGREWEPW/IGRuRLQKt4UtxooMkm7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwCXNYXZEY2qKnkrMO+fVMTp1IyCtYaTLliuV5Ft//c=;
 b=N3AeK5Kv7ChOpY6+9XnhsW3lzreSVGLm3xVuKKyLXnioKAh5e+BySzZVJSS+4UXOs1OGx7Pe5D7PDAH219wZU/p5jKyjL4/kI8fkfXnFzsXlwsFddQY7oYCyBVswa/8XxNJhvbEwLq43Mb0w6bGzaDR2HVoW9MpO+4Qu/KNQJCE=
Received: from SJ0PR13CA0059.namprd13.prod.outlook.com (2603:10b6:a03:2c2::34)
 by BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 10:04:19 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::7e) by SJ0PR13CA0059.outlook.office365.com
 (2603:10b6:a03:2c2::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 10:04:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 10:04:19 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 05:04:06 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 05:04:06 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Tue, 13 Oct 2026 05:04:02 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<Vijendar.Mukunda@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2 2/9] soundwire: amd: allocate pdevinfo and sdw_pdata by ACP
 revision in probe
Date: Tue, 13 Oct 2026 15:28:48 +0530
Message-ID: <20261013100306.2921771-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261013100306.2921771-1-Vijendar.Mukunda@amd.com>
References: <20261013100306.2921771-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|BL1PR12MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 024e615d-7b4a-41a9-6cfd-08df29115900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|22082099003|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	WWTMI78a/ECuQ/9iw/jQptosdDebBFEsr1o2eUakgJc1YC9XUXw4Qn/FHTt1JuGbHEqL4hFYZr43r2TdymUCpOR6WK93h22+eEXPEY1dWu27DMmKSMfWwVvvVuGLXW05jm50zyoKh0K+HGofSDDOPVGKSTxNTZXXXnYBekeqfSC5hNYGxXThgnKg0VRpXMPxDQEG0FGpXeVcws/2PEWExjAEo2MvptLpOtf0OIHeGYr2aoXYdqLMN7WyPQvfDkt7rmiXs9yUEPSr1hHJrA1BL5yQ9D0pOsgCFUFc8F9SG2ZWzQHuVKHRXzxBKB49lTJr6GNp92/i1XZUsCyUqaBp14FXy7V0ttTMPRthKA4Q4rP61W6eCKaUlL8Y3A+hj6wrjo5eiN394Wd+DWTCflWR1jy8vVvjEbbzECyo+KvIaDOdGZwYGRyNHXrcw1AIvRsp8oz8PPWk06TAXE8BInpo1Gl0rC5e8rWI5WzYsj7WxWi8U4gfUDqYEOoWWxwB8AJ7o9dwdBaxsm4ZhCLz4ilRQ1PJzAt5lUlhYVOJeE61Iy0R6qjlEpJIY02ASA/waUrf8ZZBs5L/bLq5ulnI3G+5W72vljR6gB/mJZrgFH9uirn/oXU8FOSa6D9GSANtSu9t6p38sjFQHxFFGEutZe4xkwpIpnt8QtDBTL/YnuVbMyIzEIvF942mXhiQhPEiWtTV+5fyjXu8ZPWvORwe024mew==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	AOZDhE1z62eXqOamws3LjI+gjZ4ajycjuQio+dfLKwaaZ03LifUx2NHnenD3F0NHC5AT3fpjngbaLxekXGUfmu4zuQp8Odu2RmC8YWaqmUBP9tWQcZk3IzGka+z61i4TVpzr5wr/i9+2V6rhIU49gVH7aFydPlBg3Hdi9w/gJT/LddpiLvBM4QezKOsxgaDDFiKxGP2IVCRncd1oTUtpTGXSLwBms/7c38KzSKicVYduHALEOQVkpXaytKeGwfwWsrQMl42GUF8PcExPDVQwYyyyuKE66w2XMuBr/+NbO8A1F6NDQKyDjq2ADWHeO4TBd/QzmhV4FzL6xMbQAmkl8kgKL5Jzlzww2LYBS+mfMkYfJOLoc+33dJdxR1V0rNiwKgTfzqNXjfYbpOE/TGbRcFZKZ2HUcw2v34PHpC+wVq+pyp6rVO26uFoS68vwvQaw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 10:04:19.3232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 024e615d-7b4a-41a9-6cfd-08df29115900
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756
Message-ID-Hash: 3DNU3TXF7Q6KPRD5M2IYJGHQ5WVOGVNQ
X-Message-ID-Hash: 3DNU3TXF7Q6KPRD5M2IYJGHQ5WVOGVNQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3DNU3TXF7Q6KPRD5M2IYJGHQ5WVOGVNQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Determine the SoundWire manager count from the ACP revision and allocate
the pdevinfo and sdw_pdata arrays dynamically instead of using fixed-size
stack arrays.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_init.c | 37 ++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/amd_init.c b/drivers/soundwire/amd_init.c
index 88004d59322e..15d117172bdb 100644
--- a/drivers/soundwire/amd_init.c
+++ b/drivers/soundwire/amd_init.c
@@ -68,12 +68,12 @@ static int sdw_amd_cleanup(struct sdw_amd_ctx *ctx)
 
 static struct sdw_amd_ctx *sdw_amd_probe_controller(struct sdw_amd_res *res)
 {
+	struct platform_device_info *pdevinfo;
+	struct acp_sdw_pdata *sdw_pdata;
 	struct sdw_amd_ctx *ctx;
 	struct acpi_device *adev;
-	struct acp_sdw_pdata sdw_pdata[2];
-	struct platform_device_info pdevinfo[2];
 	u32 link_mask;
-	int count, index;
+	int count, index, max_manager_count;
 	int ret;
 
 	if (!res)
@@ -88,6 +88,18 @@ static struct sdw_amd_ctx *sdw_amd_probe_controller(struct sdw_amd_res *res)
 
 	count = res->count;
 	dev_dbg(&adev->dev, "Creating %d SDW Link devices\n", count);
+	switch (res->acp_rev) {
+	case ACP63_PCI_REV_ID:
+	case ACP70_PCI_REV_ID:
+	case ACP71_PCI_REV_ID:
+	case ACP72_PCI_REV_ID:
+		max_manager_count = AMD_ACP63_SDW_MAX_MANAGER_COUNT;
+		break;
+	default:
+		dev_err(&adev->dev, "unsupported ACP revision: 0x%x\n", res->acp_rev);
+		return NULL;
+	}
+
 	ret = amd_enable_sdw_pads(res->mmio_base, res->link_mask, res->parent);
 	if (ret)
 		return NULL;
@@ -112,7 +124,20 @@ static struct sdw_amd_ctx *sdw_amd_probe_controller(struct sdw_amd_res *res)
 	sdw_res->flags = IORESOURCE_MEM;
 	sdw_res->start = res->addr;
 	sdw_res->end = res->addr + res->reg_range;
-	memset(&pdevinfo, 0, sizeof(pdevinfo));
+
+	sdw_pdata = kcalloc(max_manager_count, sizeof(*sdw_pdata), GFP_KERNEL);
+	if (!sdw_pdata) {
+		kfree(ctx);
+		return NULL;
+	}
+
+	pdevinfo = kcalloc(max_manager_count, sizeof(*pdevinfo), GFP_KERNEL);
+	if (!pdevinfo) {
+		kfree(sdw_pdata);
+		kfree(ctx);
+		return NULL;
+	}
+
 	link_mask = ctx->link_mask;
 	for (index = 0; index < count; index++) {
 		if (!(link_mask & BIT(index)))
@@ -133,6 +158,8 @@ static struct sdw_amd_ctx *sdw_amd_probe_controller(struct sdw_amd_res *res)
 		if (IS_ERR(ctx->pdev[index]))
 			goto err;
 	}
+	kfree(pdevinfo);
+	kfree(sdw_pdata);
 	return ctx;
 err:
 	while (index--) {
@@ -142,6 +169,8 @@ static struct sdw_amd_ctx *sdw_amd_probe_controller(struct sdw_amd_res *res)
 		platform_device_unregister(ctx->pdev[index]);
 	}
 
+	kfree(pdevinfo);
+	kfree(sdw_pdata);
 	kfree(ctx);
 	return NULL;
 }
-- 
2.48.1

