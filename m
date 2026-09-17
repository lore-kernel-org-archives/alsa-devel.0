Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AB4C982D0
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:40:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9FB00601DB;
	Thu, 17 Sep 2026 10:40:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9FB00601DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789634450;
	bh=QbeBVgrWaqvBBmDDztDGnqGdas1WWcpHvTmCiMUdw4U=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=cJ+4Wuh+YDjibzaXod8JJU1kmR3KUJUbUhnBkBqGYkfWvVaaY9xHTfk4ANQ9e3OPs
	 clxs8leeHtBFnZf5OwVthWwSRf9XGO2ZXffTKLVn5zgNgcbNMuRafmO6PHtM4qgU64
	 +U08DXdV/X3+gcMMikHR78HtiYhRVyoOCtWNZcTQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C0500F806AA; Thu, 17 Sep 2026 10:39:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0849AF806A5;
	Thu, 17 Sep 2026 10:39:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9AAB3F80606; Thu, 17 Sep 2026 10:39:13 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.49
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789634349;
	b=efr32olrO32XajPHVw+AyWYjJjdUcUuZNq7hiV3mw9lLbdXLWwm5cK4p1N+9feeLvUMt
	 RGkBZPTo0pW0sLlY2c2MKFtwvzkMYdWgrml/pMc6j8Jp5RuIP86nPVc/86E1gK8iLoY67
	 xBvWKVhUfTMbEUkQlAZmSV2/QEWUPkyL8sVMc/zS851J0FJfmWD2iUVUQC4OidTjNw2eN
	 DezSQ8OoVmB4JtP6xEQP3KocQpBjHM/DqOa4VRyvXCfbtl5IG3MyPrtGk7sgoOhAzQDyu
	 Df2uXAS2vIGPf26ViWFRYiO4txoeyLqbM3lN9FWXRSszw7Odbr+Tfn2TdcO4mulgyMA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789634349;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=QbeBVgrWaqvBBmDDztDGnqGdas1WWcpHvTmCiMUdw4U=;
	b=pRQ+B85a8qj1hRRaGA/PPj5MLht4pV8189NSmulhsPIaJGe1MTHmy9TMEElgTSVBjtwQ
	 Pr37l4C76p7bkQ6HniBQxnesTkgNg63g6mwJoBFljJQ++GehvynUwKWkZ4Xm7s53e+zfV
	 Ue4WR1cm13VD3iZF8G/KU/Fe95v8UmV0j/BdLM4NrAJzhh/yespcjy0JW5M5/g/bvbEfv
	 j6z3P6Xj7r0CFRnRz6+r79SUSw8aBVNn+wpy3KgscwQqiqA56f/WozD+bB1z69VA5Fne0
	 p78ltxuU2Aeyt5I80KJxVFh37nndnGKKQWUXAlvpgyacvfAPOTWOlCoRcITFanEB+OQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=fzk84Byh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.49
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011049.outbound.protection.outlook.com [52.101.57.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 07979F805F5
	for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2026 10:39:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07979F805F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=fzk84Byh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWhQwVJbj1ilXBged2q36AlJbq/e3E7uQ99uMo5YWpCJcxNCNhf/4axaxMghUph9eL0u/G+npbI5rogEeAbb+QfEAhfBGd2QrpVV+B7lIObHIxpDCb0hOJiUFvpIG7RdyE3Yv5yjjQe6FWBsVQ33AphJKQO2UiRUj+OXqlZM3dmYkadpv+0wZHdJN57iAWzgYyvrq7VLUp+W1Vco4Cu58DbAnoFrI9bC6l7x3tLTM8dwtNmmTIPIuleT7IaMmuv8mCdzCSKFzBBsrjKtXu7HXLRygo7tqRO13R4EdgConIRJw5nPdYUA6zn9B1J96FPbSujs5Dbub8KpMU3gCC2qTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SokXp4As+pEwZQZSxe6/tvtqBxAhLJ1E+tsat3U6m1E=;
 b=k/cJylxIGxdnkg5QRX7vr+kKB+2i8OLmQj80GdDMNX4ZnHyfGpg6QoHSgV7JO0zKDzT8UjaNuXOdMLkkpMghEVbMilwPLKfBaWtVbnmslf/KoTQoNpJbIzfat18N3qWNE+aWGkzFJ5gg7aMFeD37uhOSwKaSn7VZncIx8EVyEDAfqPDhnE/Cl8sIVl2syZ4rDQGfrXGV1YpZZVyVSY7RPwUt7DPY8lqBkJo0XsK1CC+K1J9oZ6pK/WRy1BGGZ5TdFS8JDRxLeLidNB9xCPi6uxFNu/8U7YMdIY779v6MMSSeQZzlyAwbsxb/q8eSMk9l8wbto1cB3uWT4HMRWav1pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SokXp4As+pEwZQZSxe6/tvtqBxAhLJ1E+tsat3U6m1E=;
 b=fzk84Byh0LSRvyPQXOz11AeFTAfJiMQUMgGMXTYZHfz+9kq9Wmwhi7tPBZCfOcOe/YWQ37wtwH2g/uFqaAbLuTmwZpk46ons3T+2rxVntfftqyb4x01wZpkb2CVgY44CMRrLkC/2YTu7pQfZHzp08ur9IStWfvqb1qbwe5sbTIo=
Received: from SJ2P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:a03:5db::15)
 by PH8PR12MB7253.namprd12.prod.outlook.com (2603:10b6:510:226::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 17 Sep
 2026 08:39:01 +0000
Received: from MWH0EPF000C618E.namprd02.prod.outlook.com
 (2603:10b6:a03:5db:cafe::85) by SJ2P221CA0001.outlook.office365.com
 (2603:10b6:a03:5db::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 08:39:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C618E.mail.protection.outlook.com (10.167.249.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 08:39:01 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 03:39:00 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 03:39:00 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Thu, 17 Sep 2026 03:38:56 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH V2 4/9] soundwire: amd: pm_runtime guard in remove path
Date: Thu, 17 Sep 2026 14:04:15 +0530
Message-ID: <20260917083732.3803526-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260917083732.3803526-1-Vijendar.Mukunda@amd.com>
References: <20260917083732.3803526-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618E:EE_|PH8PR12MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd7f2f7-a322-4bdb-4783-08df14971fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|6133799003|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	PGLZ2xFP9OXpyP7pL0EpPN+hlVpDsuUUoBJCN0otUeptzefCBhU29dtXfT4nZcQsYV+q+BAfpo9kdkSM6K+BfuPTzfw/h701dNsl5lXQHtFOfGwLiiujZU3ZhmB9otEC5I24IR7FGPhkSGZcK+RuNZVLWN3OwipSkr7rwf+N5OjwFF/2v44OWTzEZso6GwWxZm+rXVzNO8L37RoPZ0ZKSYiKIkvcz+dpie3tO07rp8BBpONKHK48uKIHsEIVwoAXHI3X2aBXM+FqGZLqLbMCrP+sDe97NYpH3Qe/Emfh2O9/FzFFcPApWmz839PT3VC2wKLbp0bN8CORHIXNib/TTbG5Ga+GGyPXBkI0wb3ANCZgOnHeHdGkWz43ISryIS9Qj1YI4kKvRF0wdeDsjDx6HCInInntK1lCUv8eARvQbFymlQWbHJfJjD2b8deUMkHicqA+pzXI+ecP0Wo1HFo1rYt8/CeVO7QLBd6cdGvIbSd6rolaLw8jXLZgIRplVez8yz+SLCzoJyCdBwDq5ozvEUn6XyzIjZms16M5nsYocPfg05lX6w+sOLIKPKi9ae/iKZo7XA35uqjK8vcqV+78VUEFSQxQJBIaeowU5faEx43QF0ysJ/EHkkb2mKfbUtnkgg0xnMNbrQZ5fECfMMOlsZifduliA1oBhl6OqSPjYM0Q22xVwrXmfek/7LL5JCMt3WOO6qrnE3XTz512haPucA==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(6133799003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	89OgLbz3e0N3BvF3UhJHjsSqKqwdqPAFdgqUsDxe1RWrF7vT0CfWHfnkRibiifWAb14UJ8ePiqeLjCYLKQb4Q7Id2v8P+4AEpEhXrakMeMfxLiGW6hy8qayLm0+rmdfsYxvyDfwIT3fV8yEFSPJRxIxJ4tQbVjQzNKZd6BMXH+GT/8ArM7hJUjAzBzcjzufg0Nxqd6uR3Fzihy1F8xkSAwPZJ1yW3rxg2MEn9zYnP/+2XT3OTobMocoyox1O7F9lqAV/lElVWkboQ+X2cB9x+6Ory9xF+Rl7ZErsMnml6JTfRY8dvVldeGkw/GK6jo2Wk5t9mdP0D+q60TWPXmWA6H02VKqsZ+BQwdExLqoplQeh/LR/xBPQoU0q+VpcmMUBSe5sg+Cwb9i30IaVUUtgFKvnt0sW/DkdKwss920JB3CbIBH+mQBGzjtMGSM+p/LD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 08:39:01.4285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6dd7f2f7-a322-4bdb-4783-08df14971fbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MWH0EPF000C618E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7253
Message-ID-Hash: OS5ENZXKGZX7JBLS5KY7HJV3DDVKO2YR
X-Message-ID-Hash: OS5ENZXKGZX7JBLS5KY7HJV3DDVKO2YR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OS5ENZXKGZX7JBLS5KY7HJV3DDVKO2YR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Guard pm_runtime_disable() so it is only called when runtime PM
was actually enabled. amd_sdw_manager_start() calls pm_runtime_enable()
only at the very end, after several fallible hardware init steps. If
sdw_amd_startup() fails mid-loop (one manager started, the next fails
before pm_runtime_enable()), sdw_amd_exit() triggers
platform_device_unregister() for all managers. Calling
pm_runtime_disable() on the partially-started manager finds
disable_depth already at its initial value of 1, silently increments it
to 2 and returns without a warning, so a later pm_runtime_enable() would
only bring it back to 1 and leave runtime PM disabled. Use
pm_runtime_enabled() to skip the call when it was never paired with an
enable.

Fixes: f93b697ed98e ("soundwire: amd: cancel pending slave status handling workqueue during remove sequence")
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_manager.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index dfbe9a181983..bbe1e73ed255 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -1172,7 +1172,8 @@ static void amd_sdw_manager_remove(struct platform_device *pdev)
 	struct amd_sdw_manager *amd_manager = dev_get_drvdata(&pdev->dev);
 	int ret;
 
-	pm_runtime_disable(&pdev->dev);
+	if (pm_runtime_enabled(&pdev->dev))
+		pm_runtime_disable(&pdev->dev);
 	amd_disable_sdw_interrupts(amd_manager);
 	cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
 	cancel_work_sync(&amd_manager->amd_sdw_work);
-- 
2.48.1

