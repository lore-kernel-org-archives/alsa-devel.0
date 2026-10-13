Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C43FCC6B10
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:53:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 497DB6020A;
	Tue, 13 Oct 2026 10:53:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 497DB6020A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791881634;
	bh=QbeBVgrWaqvBBmDDztDGnqGdas1WWcpHvTmCiMUdw4U=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=d/p/QuKFeQkK4PeEbCC1Ra4jF5OByU6aQNG9lo63P4ayj729scNY/0SEx2XP/K5sk
	 0nY2Eoj/R20xuop9UnFLS6q0yiCLL84y5Mrk73SnVNtPKJodQmTPZkQk1kDEK8q0fA
	 OdxuQmK3Uwm2SbeH3U3nIyXpYx+U3Aqa1z70OQ6o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 06FB7F8067D; Tue, 13 Oct 2026 10:52:48 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 871C8F80680;
	Tue, 13 Oct 2026 10:52:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 210DDF80608; Tue, 13 Oct 2026 10:52:37 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.9
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791881555;
	b=UEV2RF+l2z4ahgzQJljsrdzZwpq5n6Z+xwdJv6PRwrbhUVOfrhgPR8uHPqPltD079LGY
	 vd+QLHLneGXHgiqU6dXOz7EtQCc76PZoamWLUcOH7/hjJdb1KsNPehXO7ultWQFbBUMYs
	 gytHhWnKPr2V4ncvOkzIqf6m5rBNUJm2MyHzFPgr6SWGSHALxvqY8UoHgrsl/RkC1rr9/
	 4tjxgCroTumOZA3C7WriD+aiEhRs+9qQbqCPIUEgoWOutEBcZjHpMuVdTjjoGgT96CYk3
	 AsQKbfWeJRj/lE98fbqNeFwfmPnhhx9E1gLm4WvXXpdw/zKKbWxY0/MSpxkYZLIei0g==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791881555;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=QbeBVgrWaqvBBmDDztDGnqGdas1WWcpHvTmCiMUdw4U=;
	b=ZMzqYRWAnOa1CKJ7QHbUt8kA2k/XRoCoL/8oLko/nze09d3Ilam6G4xu+kpN52YEbe+N
	 y2Ojm4f4ZGCM3LkrEoTU6V/jHRgQ2HTB8OOUGzkms6d1F+Dn5VSCWCgqWkEtCmiympA7a
	 qr4RuOyyqt2VrhKuIdIyE5FVz5GyaBkhV8fWhwFCmr6Vtm1tnFfAhXKxpFPgJDmCNn/Jd
	 pkHWFaFTgo1YrNpRpd8id6lpnP3o8hKLAaPfRCmjdaxU6CENtbOL4xHk4ZkWwBQ9wjtWc
	 oAI+/uFejIHaeTKAjGX6RrkzTKKaMBT6+JQUy+vxb86gAtw75fYYxA/Sbrh3+w8kgWw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=qRu4l7H+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.9
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010009.outbound.protection.outlook.com [52.101.85.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 80B20F805F8
	for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2026 10:52:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 80B20F805F8
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=qRu4l7H+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1qQUD46oFgvsnOyhbK3RVrtAYc93CgHU1ahE2Ex+i1a2ABOCTimiFbVYiYwD/Sklx0eAuEsDSmOKfYUS9Tq8zl11odXPH7pQYsfJvUzWQ+Jz2X2SZuzBJv78vy8eXSmFSHYxg0zw9q5LQJBRA7PaGPtN0J9Uqh8A1EeKGuFpDQMrn7DFppoGd4T/bXLRndLQxQ4P1pVU9gtqp/h/Jqt3jE9eZmYqS/R4ZOmbvjrHXL9x7+HrWEtjr2xVzKaC1BGcvIjEsifwvQQVhaU1cJ6jAlO8Ye25BEBSmEQxQsb2kZh+D2n0MVlp92V6cDqq/hZjJZb71oaR1Td3my+1D+7Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SokXp4As+pEwZQZSxe6/tvtqBxAhLJ1E+tsat3U6m1E=;
 b=RSPKi2j6uGrBnUQ08+76f3aX/u5B3f5v8Fcwe59aNimA2nAx7eCiT1lYR4Qs4r6O7njxps2yULZFvn0a1gPmpEs/9txd7pUnplQZ+muI7r1nu0UaPnKjHmx2JAW/PIxfEnacCIoKBecCPVGCYM03UOxD2y9lJ7ZgGYifYTSnzFThNRLxYv+BDHYn/VwUTl9nR7/8CwkwSagmztwJ8ifXdUDegCpyAo+k4OMz8iXJvZsrusmKIPEYZoU/Px4+Qvs3eeg5DuT3Jns9iZAng2flaipaoCEwi3q1OEmYPj0BOSVnkfs6AHh2//608JSo0pyeWcR2HLgRmVIcfoI02L2ozA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SokXp4As+pEwZQZSxe6/tvtqBxAhLJ1E+tsat3U6m1E=;
 b=qRu4l7H+ga9E1HtibcMPjgm4m8xnZ8q64iwMw5SwmkrDxyhiicXzbZeXSVM96qm+g4AEBGgiVDQfbzw/b+Rh+F6+T4vEnJz2o1M6FcALY0tdjTukDC5cpOqdVu+imrMPxhFDX0OC2rQB93haPZZCVmPcEFd5cULwE692nIMsreE=
Received: from PH5P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::16)
 by CH3PR12MB9396.namprd12.prod.outlook.com (2603:10b6:610:1d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 08:52:26 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:510:34a:cafe::98) by PH5P220CA0004.outlook.office365.com
 (2603:10b6:510:34a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 08:52:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 08:52:26 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 03:52:19 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Tue, 13 Oct 2026 03:52:16 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH V3 04/10] soundwire: amd: pm_runtime guard in remove path
Date: Tue, 13 Oct 2026 14:19:25 +0530
Message-ID: <20261013085111.2009061-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261013085111.2009061-1-Vijendar.Mukunda@amd.com>
References: <20261013085111.2009061-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|CH3PR12MB9396:EE_
X-MS-Office365-Filtering-Correlation-Id: bf919766-6be2-45af-69bd-08df29074e3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 
	w9g5cT7aLqzBkBxvhZ46abY/Hpu4zt8bQIUbfwWlK7Eqc8Q3O1DEfIQN8h/UXILZd5PPH8D90AqYgi+oaC8TcYqpcVmp+que6TycQrihSAS2weYT7qJ665c6hoQkPq5pLOGlgSr6Etk31R0riyMZJs2sH4guoETDjjv1f9RPsXXxRFQ6VlaNm6gAh70sjFIWNIiN2aJoAzk533Ifhsw2xP2yvDDKVKFj91zD4mEai4xBJlyNBjOnX+Aiy3KP5KvbKV9x3NMrQMQdSH05SfakZ7fDdGxWjlxZG/fF8K2KJOt1dxjEUxzigvzm0He6zl7ElvUUZ2n0k+JV/WpnC2eAkvUkcN3VyfyVKAE/AxKFbKdoHpy5+sXZ07O1rt+qujUdL/HibZznq2y1XnrTx9fQuAN4NkrPyRnAbQEYFFcaXLvz67CC/R6s4Hm2HnQWl7p9Zz5qiUrFaxYKRENLVw3+35tRyZMfthzLJ/T3++lOqvGsroGCQFLask6i9sBCsKO8+NWTVBcn6pHYXIGqnPX99is7Vhr/f5TRxOE783xgjAwq1bw+QCweCYXJ8pFHF9RyZc2ZK0m0gAJ0FAQuwiBUfVJVhGCuEpUEj108zIxK0KfS3IOzGpLyghpPEW+eU0RMusIic5bORUh2Dd/bxeRF94MbEnRxGrbAekksvdkvsVeKVWBT/C6lNvV1XeErigozv+I1t5FnWKtHV0JawxunxA==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	moaQ+aSP1QLY35dHSr2z2SWzhVdt5sdidZHhAjkCYTrcW9S9lzuvztyi1dsKZrxuZGUsEII8uTdo1AaBYJtwj+75vqq8CKLhdbYvoCwfQf2rylrE2DiEWXjn4hIobcaPpk7JHUZDWofadbKzlFoyWfyq6yXp3riENEiDrmZRwDurCG2nZW3ufeVy2Kf4PrQ4lTPHz+w/cswHNV0nYb34Cw6eaBGgUBxVx9yS1UkgMyuu1mwCKn5TiyV0DElfpMR1sFpfyMxd5wd5lBAbqtQ3AZCX++xzIlFTMQvb++mly7ChriBArvm8HgdUx7/QUkiKgcC0zBHlhyR+0DTKjnrydky9RHKz1TwS+Jy9zeI3jzR/VPHOMYrZ8RZycjz51Lk3AFUaMY0zQosMMA317KfxxbFnmKundJ+mcaX3y/GmeKCg9t5YV6wqMkh+iA1pgMGK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 08:52:26.2674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 bf919766-6be2-45af-69bd-08df29074e3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9396
Message-ID-Hash: PQEUVCEMEWPTMFMBEGEZ3V5V42KXJV7K
X-Message-ID-Hash: PQEUVCEMEWPTMFMBEGEZ3V5V42KXJV7K
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PQEUVCEMEWPTMFMBEGEZ3V5V42KXJV7K/>
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

