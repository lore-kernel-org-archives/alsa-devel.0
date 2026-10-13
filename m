Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07B4CC6B0F
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:06:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0E5B060210;
	Tue, 13 Oct 2026 12:06:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0E5B060210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791886004;
	bh=D8BcQYk9l65kUSwgRYfeRjBS3/eqkyICB9P8juNhQ+I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=XT62CTmhr+claK0IK8/tpZQljHWdezrsm/ODOUpxSE0T9csmULXid5Y3BIU6CTUu2
	 CIiTOWmfz7AweUpmSCOg02nuWwXev/HUl3qEmxPI+eLSoBpAhHbdFqQ5XZZ4LvVLJi
	 q0cr48ht4sQQ/j2j6Xv9YAMPcs4tG+hpJjiEZNSo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 11ACCF806DA; Tue, 13 Oct 2026 12:05:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CA5E7F806E0;
	Tue, 13 Oct 2026 12:05:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 59880F8063D; Tue, 13 Oct 2026 12:04:48 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.9
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791885883;
	b=Qv8J3zApwtC3y15Geed6Hl3LshrZ43RvhYO5n5SkM0Q5RBtKmVFSCAKFPDaPxjyVQvr2
	 Jou7q7p9i5edSxE+bYItzi/RDOHsXgaEVRo3GtXtjBhYUC52sfcDk08eW9OnqWhODkQ8D
	 FccyBCzU2nY5wslhI6US2eYymXfWWT8N9syDB0wo1dHM/7ZPkKcufNuI7lIcNZY6NgTFZ
	 Asa8kXYtEsCJdQi+lULSAXdC+BBWdgyXyka/5KTmYHUfT53ePlNfc7ZphyX4cU8AUPjdb
	 K05a3TFI3+LRH+ofASQja+1rGBBlCCgDTB/2j3QDPamocCFABVhnXAo3OB3rto1+GYA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791885883;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=D8BcQYk9l65kUSwgRYfeRjBS3/eqkyICB9P8juNhQ+I=;
	b=F9+hORDV5FTg6m+24eRduB06eBQccgTqVCHhLhUj+uyolQTe8RwUxpfjOZytFdaHK4EL
	 3P4TNw07wP1DjCRHYStgoWDlZ22fRgX1uUFQf00Jnk5+k5pMtagmLIdQ6t4TfXe3GwdRZ
	 aj9veYv+pEdZdz7mTIrhgSBT1HTzvilZAWNENr6K0TZG1DP7DKRdIPQLtEbdpiI2K2BSy
	 t4aQxIriUUJimFZ3zgCC0KWZKtJ+IsJf/Pm2mrooQBxwQgB04MK+Lx/yPka2qenr7rKwF
	 3mXZS22xQ30w8PUTgzPtHIadmA8siE725BAZxSsEsiY9OqqdojyNQKe75wTWvDcxGZw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=YHWgfY1b;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.9
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013009.outbound.protection.outlook.com
 [40.93.201.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4218AF805D3
	for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2026 12:04:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4218AF805D3
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=YHWgfY1b
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9KM9UJEFEH3iq69DYLkwzwmJv4gKOtXe3FK7yqAxLuDFDXrmQJo0E4sccjQ8d4YmJS0IZaCDMG+tJGM06+heEPHUkDEnxUS39AA3swom3nPCc93YLuLKKkek3umNOh/tH/yFBCQgmmM9cp5E7VAR8j1ep7PJ2ch1HXWBdHnv+BnffL8XNTYViTY2e/SEqtvjRcgGcNhkLJU7Fl/KLXLBsZFFsHXEHK5eTtQrZlrx//eVv6M5aXZNWLd+39oJGJugL1K6qdWtZpQd9x2BWAYkrw8jP8KNE80wKuzKgzwT6l0ZeMpMFYcY4V0ioG+A0RwkJE7eUGUoNJnwSSJSwe0PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUt0fTzW5FOwJ9QcoEYgam8KZv0ZDAHlQ30ENqhT+qg=;
 b=TrXmiGQ5Puqv9eqteZ02kfECXBHx4D4PbJtjJrbeDK4XKoNaIJL4ZgKs4AJ673Lr9BLoMUELsjneZ4OE5XLIK5Z+cVPNIwj6RBO+KNkG7LDU7Q7Ka0zVqkPxxzP9G8Db4b04r3in1s7qxbRB+2rtvV8LxVl0wndZVJ7MEjnVBGHZx6B3dkcHBRVsggf5+7ZBDkQjuU8WZQjXqB+yb4F9rr7/qebCjqy1i5oibV+jZS6ZphdvvsP6g6jVLiwfUK37AjrmsUzbuNV522yabuIJbmY2Io5849JD5B26b1EjphxBsNMhHPYp7sbB7LauVLQSDwrozuKViX5HToXIJN/ASg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUt0fTzW5FOwJ9QcoEYgam8KZv0ZDAHlQ30ENqhT+qg=;
 b=YHWgfY1bJfYeMVVETCnSjNCYRhLr40TYgRFOtNp6B4RDnSnF8UaWh3bn/euMCGoZS8pCQAT0cymzPbLWQaLOnPuPXmntt7OoyOyxxGBHxQT06dCL/zkYFZl1G9jf7iuy/PReMND5ajiHB4ryyhN7emDMYZ4/foQMu/gMb0V2Wmw=
Received: from PH8PR07CA0020.namprd07.prod.outlook.com (2603:10b6:510:2cd::12)
 by SA1PR12MB6918.namprd12.prod.outlook.com (2603:10b6:806:24d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 10:04:33 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:510:2cd:cafe::16) by PH8PR07CA0020.outlook.office365.com
 (2603:10b6:510:2cd::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.21 via Frontend Transport; Tue,
 13 Oct 2026 10:04:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 10:04:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 05:04:26 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 05:04:26 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Tue, 13 Oct 2026 05:04:22 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<Vijendar.Mukunda@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2 7/9] soundwire: amd: dispatch irq/work handlers to
 per-revision functions
Date: Tue, 13 Oct 2026 15:28:53 +0530
Message-ID: <20261013100306.2921771-8-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261013100306.2921771-1-Vijendar.Mukunda@amd.com>
References: <20261013100306.2921771-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|SA1PR12MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e0d3c30-0aff-4bfd-9ae0-08df29116163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 
	n7gz5KyHXjYR18/qVzriAkrwiamIYDCZ9iWjOnD6WUda/kXWy3cwRah1H3dS9Jl6UbMsybjSJE6Irr660pVz+IEmycm+Fy8ewPRZnXg7hFonaVdIM1gHjQmfcO6lIhWvVqML4u73BO+srH0ofW0I7+zB+/BcBZhPYOolcw8aZ99TNmXZelEk9XZzOODFgAjP8zSSZImNTKrBP+z8bNo65CbKLSeqOQ14PFyNVu2k2GIQ1VI85X5Q9ATof+Yu1QsDXAYe1Yjelww3AVq/UwUNfaG+2rUUew/09jA3lA03c1B3GiyrhFHeHeY13TUKtug7loYMAzHPYnyP2+rTKQ5vjhnaLzCCQO2ErvaQIRHwduoQfhzIeXP54JF2s9ESoav1nD3U9MBOAG5tarshvjyKaYJ+gvCOWhpygAmHliXowDIdgQfPhbFR6nEP9JIeoUndt2j/oxzufJidgf1+bLIWhXOh7MhM6Is7oLbyOS1SPkh+dSjLXChFToPzFh42ih7z9dgo/xnUb9O1XVKA0av3rajXtJgw5Qtf3BkRRiZqcGa4xal7lsEdsI+8221sC690gvJYC0kUCESRPZAVPN2jaJQ6tTgQMwRwbf79ChethyQIuPvk8demepq3AwK9jgSK+ifJI7jn6is6NnYY0WOCLM+leZuznYOBqxg3QuMRSgsUNYNmF/OvY6hRAODezikj9KyqIVFc7Req8Si81jFOyA==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	PyOGMaZNFOjoyKdBfIxc2W/PhqzLSJoT60im3vjm6cT44FdY4JLZAfA/jYYOTSWBpAXksuAsukw9/HqCjOnEzujTmcmV/JvNV1v1N/XHhwWngB4RkTQTrYa++4vIzgaVzwTB/D8/4aVvlkaV7xcunlUeHLKnF/kDO9HPvanFv4gw8ctgah495d/e22UAsl63cYAAZ7iAM7ggmj7qTe3aCQ5onlRvoGyLs/ovqlYfjdw7c8/dJbu3LXo7EZ1M5M0WZFic6cToxhjpAKBFWSyONcAlf3JaSjz6as2iy1ueQ41Op2ZTB3Y9PTM2JXA7KaNGDBJKCVcEyVlcEoR7jYudgenWRk49wjOGnm3Da7aan3o1rJkSm35G2Wzzvjo53K6J0ygOVi9jLLUfrd6pUNBRiwqI5ioJYOlYd+T6MD8we7NF4wijDwNzV59aFAs6B6x6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 10:04:33.4622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2e0d3c30-0aff-4bfd-9ae0-08df29116163
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6918
Message-ID-Hash: EIZIQDQTR4RAPX3QQYGEQWKBZONOJZ67
X-Message-ID-Hash: EIZIQDQTR4RAPX3QQYGEQWKBZONOJZ67
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EIZIQDQTR4RAPX3QQYGEQWKBZONOJZ67/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Split the top-level interrupt and status-update work handlers into a
revision-specific implementation and a generic work_struct entry point.

amd_acp63_sdw_irq_thread() and amd_acp63_sdw_update_slave_status_work()
now hold the ACP6.3-family handler logic and take struct amd_sdw_manager *.

amd_sdw_irq_thread() and amd_sdw_update_slave_status_work() remain the
work_struct handlers registered with INIT_WORK(); each recovers the
manager via container_of() and switches on acp_rev, invoking the
corresponding amd_acp63_*() implementation for ACP6.3, ACP7.0, ACP7.1
and ACP7.2 and emitting dev_err() + return on an unexpected revision.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_manager.c | 44 ++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index c585f7d529c0..90bf5d4e5ba2 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -949,10 +949,8 @@ static int amd_sdw_register_dais(struct amd_sdw_manager *amd_manager)
 					       dais, num_dais);
 }
 
-static void amd_sdw_update_slave_status_work(struct work_struct *work)
+static void amd_acp63_sdw_update_slave_status_work(struct amd_sdw_manager *amd_manager)
 {
-	struct amd_sdw_manager *amd_manager =
-		container_of(work, struct amd_sdw_manager, amd_sdw_work);
 	int retry_count = 0;
 
 	if (amd_manager->status[0] == SDW_SLAVE_ATTACHED) {
@@ -985,6 +983,24 @@ static void amd_sdw_update_slave_status_work(struct work_struct *work)
 	}
 }
 
+static void amd_sdw_update_slave_status_work(struct work_struct *work)
+{
+	struct amd_sdw_manager *amd_manager =
+		container_of(work, struct amd_sdw_manager, amd_sdw_work);
+
+	switch (amd_manager->acp_rev) {
+	case ACP63_PCI_REV_ID:
+	case ACP70_PCI_REV_ID:
+	case ACP71_PCI_REV_ID:
+	case ACP72_PCI_REV_ID:
+		amd_acp63_sdw_update_slave_status_work(amd_manager);
+		break;
+	default:
+		dev_err(amd_manager->dev, "unexpected acp_rev 0x%x\n", amd_manager->acp_rev);
+		return;
+	}
+}
+
 static void amd_sdw_update_slave_status(u32 status_change_0to7, u32 status_change_8to11,
 					struct amd_sdw_manager *amd_manager)
 {
@@ -1016,10 +1032,8 @@ static void amd_acp63_sdw_process_wake_event(struct amd_sdw_manager *amd_manager
 	writel(0x00, amd_manager->acp_mmio + ACP_SW_WAKE_EN(amd_manager->instance));
 }
 
-static void amd_sdw_irq_thread(struct work_struct *work)
+static void amd_acp63_sdw_irq_thread(struct amd_sdw_manager *amd_manager)
 {
-	struct amd_sdw_manager *amd_manager =
-			container_of(work, struct amd_sdw_manager, amd_sdw_irq_thread);
 	u32 status_change_8to11;
 	u32 status_change_0to7;
 
@@ -1048,6 +1062,24 @@ static void amd_sdw_irq_thread(struct work_struct *work)
 	writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_0TO7);
 }
 
+static void amd_sdw_irq_thread(struct work_struct *work)
+{
+	struct amd_sdw_manager *amd_manager =
+			container_of(work, struct amd_sdw_manager, amd_sdw_irq_thread);
+
+	switch (amd_manager->acp_rev) {
+	case ACP63_PCI_REV_ID:
+	case ACP70_PCI_REV_ID:
+	case ACP71_PCI_REV_ID:
+	case ACP72_PCI_REV_ID:
+		amd_acp63_sdw_irq_thread(amd_manager);
+		break;
+	default:
+		dev_err(amd_manager->dev, "unexpected acp_rev 0x%x\n", amd_manager->acp_rev);
+		return;
+	}
+}
+
 int amd_sdw_manager_start(struct amd_sdw_manager *amd_manager)
 {
 	struct sdw_master_prop *prop;
-- 
2.48.1

