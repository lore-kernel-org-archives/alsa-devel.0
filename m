Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79670C88E72
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:09:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A82960236;
	Thu, 17 Sep 2026 11:08:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A82960236
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789636142;
	bh=inmCZD/bAPxwY79dm0Na1075YpZjKLjr0vwhZ0emzxQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hScAlMuEbAPIwLlrgfVah7/cuNC9XnYuOcHeppYrIgr53alMWWzOMr96DBcYI61jh
	 iiSO69giuYl7zFVwNZ8+yDYeM4f+cBzT5AmcPm2sNUp0GxFIlwpGAu172tcyEzjHAR
	 Z4aSir1jokeDaX+Z0+xPfh1sI4CW/pkS4FOAe5/0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 58DCCF80791; Thu, 17 Sep 2026 11:06:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EDBBDF8076B;
	Thu, 17 Sep 2026 11:06:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3E461F80605; Thu, 17 Sep 2026 11:06:16 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.57
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789635971;
	b=IBTO7exBpKO/T6Gbib0rHvoil0z5h/yyx4skJo3k/dfVx9ZUTtN/eGdlboeePTKXNrXU
	 xPDXVE6vP72eQPXxDYE9n7Sy+CNhw2qS8qkBgZoBr5s6Hix0CNbE1ze16SXKvF/2glIma
	 lh9Z6XxxlIyHfXNccGVLLnFj9g+UDBbjmNSYfnLSvbfgcNNNZM8ziVFIp+4u5YSs/4Dqi
	 QwY5A4zlO5FGKxlnEw3zj6l+sMbAQ1ds8UTUphH0GjzmwhcKI0QW8DDmN4ENMl4zcdiA2
	 Jj/Sl0qKcTmHW99Ffd1MlyjrHMi7ExSbZ0AXVQlVItiIlyQWSm6tRSAUanUJFm/FQ8Q==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789635971;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=inmCZD/bAPxwY79dm0Na1075YpZjKLjr0vwhZ0emzxQ=;
	b=A/+Rq1qBFPisXsOric2rTN7S0ctsha6W7rWEmlgi2PZUelZ6/uGrDQDxC2vFytdks/my
	 IGjBapVXrYvha72RsQhBB+poGG5sZC1S4TXt+KMc99Hd5uj+1ljf4dq7roHtipyMrRyIB
	 XibtAUNG2m/JN4go4RK1HSVuvm5+aY97LGq7a8EEv1XwC38EMCblsDMBvQyf3JUZvwtKO
	 lWWHFo+7E8izxdarWpS6sKAV2j7TBzId6wM8k33LaZsJn0KQV3WmGO1of6GUrm7TdUROc
	 R4T7Pr7F4DpRNd/WjbSvFQDBqdd9IO+bEFrVfw/YVGtD7lqo4JrjUqIPVMwH7yFRVPQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ftnlHa3d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.57
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8883EF806AD
	for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2026 11:06:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8883EF806AD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ftnlHa3d
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7bMSyh28TwIllD44mPNAFrsqeTCo3gi2arMZd2BPCzWvK4Kp2q84GOU1LWzNTSAv65WUUpKldw68yzcGpD3TWgNL/yHa1A8J73n8IgiB2D2KsPYHhimnaWjDlQoaI8zJkh7JRXOYtAN51uwzkYP+kPjQS1C98NRNiRX8YWQ1wTeiCC/yDOy0OJUUeGYNbE+vLDXCu+XGEqHjk9pgT5UzwAI8wUWeGcXqDUaDbj3xO2jiSJ7VOxK0wJSK41zrB+1vH1iOuhGnRBH2WHYEBnxLHEtjD4L16Yx3nULS7O3Y/OdBkEH2ANleU81wuNwnIFBZr1bKZmjwkhqfrc+yTwtSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ythecsojjHVRfZtH8zEVJ9w+aIjT8oQkUtP4G2ZGwrc=;
 b=Od8YgRLf0CGfoATqXX2YMEANhSTyQqq75oVZ3z82UEVF5FbCoYsMiCWb9iyS/G9Jq+kdsVE8q71h0ORap3/zfO2234U2/Aevu3+9bef0RUJ/eKELdXXjnF2IB7nwjuQ4WvZzU5WXfRlV4cuqqqWzRG6QWQOQwFOkzKL88JRb16W6s5SV/W41t4mXv3/x21JzuPlKlIkpp3JmHns7/HCXsJiBTH7d/vcZyqLOE32+cm2DbXMNPUPKTq5Fa0LxFz5xu0x9e9kmsbRO0s1I+xdPeNy/fJhipMBxXT5eqR47Q67uSOpJ1nGiCZEac8j4rZ7858VdJVyee0o5pvPPOkg5uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ythecsojjHVRfZtH8zEVJ9w+aIjT8oQkUtP4G2ZGwrc=;
 b=ftnlHa3dbG2JxsgUOxKBAyEKJ5RLFaAuFYChaLJAcPBtUVl73i9EPdqxwE9wrGTEjBLFmKxXYcMOUxZJhVNAeW5ZLMfWtd8MHaYYoWTB1WAe6CNMedPQe28dY6W3vob5uulh+3moGLDwgNVgJQHyDy+PptcUNHHoepp+P5way4I=
Received: from BY5PR03CA0011.namprd03.prod.outlook.com (2603:10b6:a03:1e0::21)
 by PH8PR12MB6796.namprd12.prod.outlook.com (2603:10b6:510:1c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Thu, 17 Sep
 2026 09:06:00 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::9a) by BY5PR03CA0011.outlook.office365.com
 (2603:10b6:a03:1e0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Thu,
 17 Sep 2026 09:06:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 09:06:00 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 04:05:56 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 04:05:55 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Thu, 17 Sep 2026 04:05:52 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH 9/9] soundwire: amd: consolidate revision-specific probe setup
Date: Thu, 17 Sep 2026 14:32:57 +0530
Message-ID: <20260917090407.3828816-10-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260917090407.3828816-1-Vijendar.Mukunda@amd.com>
References: <20260917090407.3828816-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|PH8PR12MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f18229-3814-4ee6-fde6-08df149ae49a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	AqxVN8oW7dYkGdB8Qv9zzpKblo17UKqZjE2wWulkVTsZ0kFbDKS1V+fB2vbgiNOyiY88O9i+Kf1NIz8DMhYyJvkqeC7XIKiIN+0+toLzM5j2iEdniRl7PuGN8dd8uK69iQV+FmmyJW9z1bt6reiaZ/6OIx7nD9/THpISXISncp4rpIE9a8p9s1e6Md5P2GZ9oSxaggZnZmVo75uYtPorVlsBnBSq2BmTsIaHbjWVHpkkY8LBkTs2HakcseeYIoL4GHcNrPkZMWbWLeJbAUPomFBBJwFFVjivfEKMSDRno/l37kh7ACxxf5l4ddgjhGLDXgmr6s8XyNY3NxvmbI4EjCyWi+IZ57uBSWyh/DbrvKDMvW4XTKGuYtXARvTZV6uhTGuNFeQFAhWmPOPoZQdHAaeMMwW3Ab43GjdvALxElyY7V9wcK/iOfs2lVfcCSI1K/nNsOT35w2M8d+esrK6uwURLKSbUeOmJDJ358e+jrxrgCVUfF8ozBwuHppwL/UYcqGJPspJdXaZk5+Cb5zLB+6UTyFge/EgmcSuM4l9gCElgdF+nBtJV8/NrsRzkkmd5a4jfLHXznWhTWUtG/r8s2kQK+3Ad+dpp44fmJ2fjhFpVV0E0QidkYwhzW0EYlW2NBhn0lpcnKFUfv4ao3K3Z/M8DdW4UYOQzFlhsx0MpVaeh2t7CaRKPc/DTJvpqHs4Rns6hQo84kVCodcSoI3wiJw==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	XhPbbjCeq2LQWZIXAhItxi8w1Mt6EecBYAH0KyK/u5BVQ73WLlOZS7bD0vfHnkW7gWgP2Znub4CbrYIoWqlhGSUUfSwBszsp4esNjTpiPoYT6FsAzQ0xohngSrdkwJzcLSjOZPpmcuZ7difhTkx5b0Z+hJltC+RYi+OMo1ICAZiEH3gVPgLcpt4kDwbRFiHnAnAZfn6xBf+0uygGWS8j9ZoyIfJ7M6rZqSte7+09bDUcXnmq6hd5KSYGxXDa1LYIgbRW4BZLlFxi2dkYQXhQV3tC7ag7966u+VpZP/4QZVUUinSRKR8dLpWPUD0m9TaYHDRaDXKUqEldYRNT+BQBke2GeFF/d+hGCPjD6cqdqwxjUTob9wS4MWnBVTveCA82PAZQPggSJVNahcda4V2KOYYYnHyuuPaztMQy+LVL+3O2a/XB3T3KedE4UKH8uegx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:06:00.1817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 55f18229-3814-4ee6-fde6-08df149ae49a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6796
Message-ID-Hash: LVGDFGLFNLCRKNBPOQC4TZX4L44ULPYR
X-Message-ID-Hash: LVGDFGLFNLCRKNBPOQC4TZX4L44ULPYR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LVGDFGLFNLCRKNBPOQC4TZX4L44ULPYR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Determine port counts first via a switch on acp_rev, compute max_ports,
then consolidate all remaining revision-specific assignments
(mmio offset, bus ops, port ops, compute_params, and port_offset_map
allocation) into a single second switch. Both switches reject unknown
revisions with dev_err() and -EINVAL, keeping each switch
self-contained so an incomplete addition of a new revision is caught
at whichever switch it is missing from.

cols_index and rows_index are no longer initialised at probe time;
acp_sdw_clk_init_ctrl() sets them from the actual bus clock and frame
shape before amd_acp63_sdw_set_frameshape() is ever called, so no
early initialisation is needed.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_manager.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 834e943b040b..c660f4c8d0e6 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -1462,16 +1462,9 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
 	}
 	amd_manager->ping_slave_stat = U32_MAX;
 	amd_manager->instance = pdata->instance;
-	amd_manager->mmio = amd_manager->acp_mmio +
-			    (amd_manager->instance * ACP63_SDW_MANAGER_REG_OFFSET);
 	amd_manager->acp_sdw_lock = pdata->acp_sdw_lock;
 	amd_manager->acp_rev = pdata->acp_rev;
-	amd_manager->cols_index = sdw_find_col_index(AMD_SDW_DEFAULT_COLUMNS);
-	amd_manager->rows_index = sdw_find_row_index(AMD_SDW_DEFAULT_ROWS);
 	amd_manager->dev = dev;
-	amd_manager->bus.ops = &amd_acp63_sdw_ops;
-	amd_manager->bus.port_ops = &amd_acp63_sdw_port_ops;
-	amd_manager->bus.compute_params = &amd_acp63_sdw_compute_params;
 	amd_manager->bus.clk_stop_timeout = 200;
 	amd_manager->bus.link_id = amd_manager->instance;
 	ret = amd_sdw_hw_init_ops(amd_manager);
@@ -1510,13 +1503,30 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
 		amd_manager->num_din_ports = AMD_ACP70_SDW_MAX_RX_PORTS;
 		break;
 	default:
+		dev_err(dev, "unsupported ACP revision: 0x%x\n", amd_manager->acp_rev);
 		return -EINVAL;
 	}
 	amd_manager->max_ports = amd_manager->num_dout_ports + amd_manager->num_din_ports;
-	amd_manager->port_offset_map = devm_kcalloc(dev, amd_manager->max_ports,
-						    sizeof(int), GFP_KERNEL);
-	if (!amd_manager->port_offset_map)
-		return -ENOMEM;
+
+	switch (amd_manager->acp_rev) {
+	case ACP63_PCI_REV_ID:
+	case ACP70_PCI_REV_ID:
+	case ACP71_PCI_REV_ID:
+	case ACP72_PCI_REV_ID:
+		amd_manager->mmio = amd_manager->acp_mmio +
+				    (amd_manager->instance * ACP63_SDW_MANAGER_REG_OFFSET);
+		amd_manager->bus.ops = &amd_acp63_sdw_ops;
+		amd_manager->bus.port_ops = &amd_acp63_sdw_port_ops;
+		amd_manager->bus.compute_params = &amd_acp63_sdw_compute_params;
+		amd_manager->port_offset_map = devm_kcalloc(dev, amd_manager->max_ports,
+							    sizeof(int), GFP_KERNEL);
+		if (!amd_manager->port_offset_map)
+			return -ENOMEM;
+		break;
+	default:
+		dev_err(dev, "unsupported ACP revision: 0x%x\n", amd_manager->acp_rev);
+		return -EINVAL;
+	}
 
 	prop = &amd_manager->bus.prop;
 	prop->mclk_freq = AMD_SDW_BUS_BASE_FREQ;
-- 
2.48.1

