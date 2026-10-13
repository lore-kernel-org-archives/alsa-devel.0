Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D87ECC6B03
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:54:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C43A60203;
	Tue, 13 Oct 2026 10:54:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C43A60203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791881685;
	bh=NWmfg8PkXWApSrD/HNGOAmbgIvhW5yLjpA1/mMVGrMs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=W0/BRYtObZ89Vntk4gwJK4PNk1NBdzrsHyIKBXJt/nOLLSKwPi4mY020OYG4dMP/i
	 zuHVe812zSX87rdJcOD2i1HU9+4ByBQb25crdZN7wRPZIgJoz5vPFo7U14HnpA4wkY
	 8uNk9p5SJnRjUDeHNjanOuvi/EBc+Yanic966RFk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 09225F806E0; Tue, 13 Oct 2026 10:53:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 69FB7F806F2;
	Tue, 13 Oct 2026 10:53:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B9AA9F80689; Tue, 13 Oct 2026 10:52:56 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.40
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791881573;
	b=T4puPhCxPAlXBqR4/g+0eztGpGMQ9T1lC/diSac+Y9Dc5Pjl8ZAqIx4V9BYp/c2VaE+f
	 tXA66nyhnPdHgEeevB0oDROnmgsiVmMcq1n7bou7pDqzyHrxEYKHa44vlAMBy3/6vCv/X
	 6cllnpxYj5XGT/KWtZpUrqHLvoeFM2P1F8MxoqEH4QYAw0L6k+Z3hdqAoA05SNJWG/1Lt
	 cRwipWJiUvNLT5uxcuSIKIsFJkjpm/gPlA/T924K/MXKgfuTuYdBQEana2J7A+0dWal3i
	 dXRzZLTXvs3+Z6y7zd6eB9MZwMQ2BbNWrzBynmraz46nDSX851c14p4PZs30xnSYfPQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791881573;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=NWmfg8PkXWApSrD/HNGOAmbgIvhW5yLjpA1/mMVGrMs=;
	b=j3C9oiiF7nq/jJ9flcezac4VVQrET2C8D3diq8kQs1cAnfIqHxCNGFqhwsB8PcUt7JQq
	 sMwuLgPpw6L2TpK8FlnscesnDHduAy+WO8VK10xsZU03leN4yCRZY+x5+13JCb3HBgH4T
	 swmD6m7SgbUYuqnWLKZOHcluAfU58etMiR0glSbvyKkels2wpGm+yLNh43zRWOgg1w2M1
	 ds1mpZRzkItqJOGmNHMqC/OxlIEsOgbyIgDJkJpUi6owJ88/2JGQ5M9HdQD70w2jGGr2g
	 +yyoQltcYGeyQi7y2+d1YXZJAbKGtJqNYc1HiEewRxF4qo61UlM84KpXHUD1+9fCcsA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=izPNmSbq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.40
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011040.outbound.protection.outlook.com [52.101.52.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B3207F80689
	for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2026 10:52:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B3207F80689
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=izPNmSbq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Te/WmBgCgui+Htf2lvqZ23ONBDT6L69gRkXbU3uU17mKtOLuc/zDePBZSCkDl2W+FE7pTF1PuXVOoJfJn56+SXyP+pOQofahWxqxxqyWOe0oNxPCt7qlPHBRkjykqBjL7DfVMwvdR+aFMqDB9e9pc/6zXd8rdQaLfDQjzVuAeO713giS58r6jMJE1U0W5I95eI9EERbBGdts9GzrDJnP+/QFgFNfc1qfWLkIfRpjEvo0fTM6cps9k7I6dOiXKiOzNz1KvnMT5UefmeVt2YV7I8/v/u7/QxzAkISYYYfRHsMA7AfwkXDEvZoy3/Yvm/wKRiKbPed2R5TY3+JFU/BDCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/BB4mj2h1naswNQfVcvWfadcd+r4Z63Ld2vw1mUC84=;
 b=koTBs4/12NvUmQQAY2Qo2MsoSmFBZDsxgdOmDKttKJpd0adJo9ad+ubjzKTspRt/K6Qsp2hdwgJpfdi5ZPQhU40r9IsIWxZznT6h/oGb26yC5ko7wiTO+mopGsIjthenQTSu9NASMqKOJMsaWKgyUme9n4GUlBnxllibLFYLXxK+Lw8KXWSC/Yw0nawuHhE9qtMrUeOB9O1iFGaQpC0i+/QSpXMaoGis50r03DASZjSqntOsYvSvkHbTUFJVt/WDg0PjjeAijXM5hTrYeCruQPdlgJVEmgCj8S8//GtUuWEnc3vkxS9PL/PWr6aBpMoetMeuaR9Lm9zgQjIv/oXVRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/BB4mj2h1naswNQfVcvWfadcd+r4Z63Ld2vw1mUC84=;
 b=izPNmSbqQ0fP2Fi9kCAAWf/dNkgab26hrYztzeqZ+PuLumN0UIdsg+RzzKuBPvkWFGzXr3CH0EaDYABXXOo0lhEh0HMPNRtJsLjeYyL3LrVjjyTrsuf4ku7qPUorXtsYHsAifqhog+WDk+r0d/EczcWKbuCUHI5JId4McXeHAok=
Received: from PH5P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::17)
 by IA0PR12MB7752.namprd12.prod.outlook.com (2603:10b6:208:442::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 08:52:46 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:510:34a:cafe::6d) by PH5P220CA0002.outlook.office365.com
 (2603:10b6:510:34a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 08:52:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 08:52:45 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 03:52:31 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Tue, 13 Oct 2026 03:52:28 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH V3 07/10] soundwire: amd: drop amd_deinit_sdw_manager() in
 POWER_OFF suspend
Date: Tue, 13 Oct 2026 14:19:28 +0530
Message-ID: <20261013085111.2009061-8-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261013085111.2009061-1-Vijendar.Mukunda@amd.com>
References: <20261013085111.2009061-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|IA0PR12MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: d05e11e9-d2ef-4568-b982-08df290759f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 
	sm25K84CboZlggyyHrfFvyNvP9wW81m3gKoHLXQLFFoRV/tzxlD2ap4wpsOxpzWuz2X7JS969uuK3wWe3w9nUPmQUYxZXxMuMQSkcMJBt/uSBNim9g48Nc2CuRZwp/s14H0nXBvk6PIJOBnz2/4R1xZP4z6tQ0GvwRgbdI/wLVY67OR6UDqoucEulDoV+4cY44f+2k3ZgUiXJaJRKqGBjF7Kt7p+pzGbdaFRAz/VB4jYizHPRzBol2UOpf2xOQnRBAKi92DFJKsivg620GSDwiV5AvaPtXYtR+vfoPu5nqdstPr6t4Mo1Q8ip3MwgUFEiYBVeUnWSXOsSWqhvhIGhgKxmdFjpd2HJU3LkprPwIdzYyFnVdHwzWtltYKR/Ozl5E8/TbM7GIk1zP9iZMQ+09o9CWwa5Htq+BFvveGh/21oCTepVofURYEW0aIfveNFZpY2Snv5YmLB4xR31mMaOmpNO2+mJ0os8AOU7YBxF2qy3Om95P2LrqQXwQGkSKFdmi4ln+JRtqqTWBTATPZT2VPjDasFQ4f/IAmd2REPBsnVFY6YlX5+OYM+XZNKnYiHzZ0YNZ7PGE5U7tYL9A0XhVYlKulWiI8Y7tw16NLwxT0bZGKWC8U+AbQcQ/pmc18L7zkTgN8gykMLl5Kgs0QSFWA7rBKVtZKHyJAKxKuA2AooVucrWWh3wiMxG+SrnEgCG+QdSaRlZx1rBQbGSQLOKw==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	ojesKvRirMsN3221xNdG879+fpPtvJPQxEaTHFmxYRQYzj0laWhPcQ+F3SMYFpflxwMH8yzLY3KUSK/iU0ewR/5MmojpltZVU3NAo8c7k4hUX+ylbPenTum87RNL8SQYFCAdLa5g6VFMdRJ32nhde3yXTTSyv1G5qYYV42FRg9F6G0qhRpyLRHbTK3iM9X96jsA1jTNlwonNsfLDyYt8wiy54GaEHwfFLERI9STMMyPqm9J7FpLb/n5WWadJqURTsqjglObzAhuiQvNG75/57U4NFBPueNnKKeqzsST5egMEOUxw7Nz7CJvqfvfibmghaSNSXAEfmL6k5Lr++NHYiDJaTKDC9pmXOksuwZs4JavaLbBxenJV6rTpJfiZs7fUifwfS7309+sobqOfn3xmVeZRtatoiTgnQrWG7NdgKxulNCgbKlnX2XIfvPAOYZ+3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 08:52:45.9287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d05e11e9-d2ef-4568-b982-08df290759f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7752
Message-ID-Hash: TTVRO3JVGXJEYPSPZARTCXFG2XPKXR6N
X-Message-ID-Hash: TTVRO3JVGXJEYPSPZARTCXFG2XPKXR6N
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TTVRO3JVGXJEYPSPZARTCXFG2XPKXR6N/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

amd_deinit_sdw_manager() was a small helper that bundled
amd_disable_sdw_interrupts() and amd_disable_sdw_manager() together.
Expand the two POWER_OFF_MODE call sites in amd_suspend() and
amd_suspend_runtime() to call those two functions directly, then remove
the helper. No functional change.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_manager.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 2d2f628230ee..6af224ca54a3 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -146,12 +146,6 @@ static void amd_disable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
 	writel(0x00, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
 }
 
-static int amd_deinit_sdw_manager(struct amd_sdw_manager *amd_manager)
-{
-	amd_disable_sdw_interrupts(amd_manager);
-	return amd_disable_sdw_manager(amd_manager);
-}
-
 static void amd_sdw_set_frameshape(struct amd_sdw_manager *amd_manager)
 {
 	u32 frame_size;
@@ -1336,7 +1330,8 @@ static int __maybe_unused amd_suspend(struct device *dev)
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
-		ret = amd_deinit_sdw_manager(amd_manager);
+		amd_disable_sdw_interrupts(amd_manager);
+		ret = amd_disable_sdw_manager(amd_manager);
 		if (ret)
 			return ret;
 	}
@@ -1380,7 +1375,8 @@ static int __maybe_unused amd_suspend_runtime(struct device *dev)
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
-		ret = amd_deinit_sdw_manager(amd_manager);
+		amd_disable_sdw_interrupts(amd_manager);
+		ret = amd_disable_sdw_manager(amd_manager);
 		if (ret)
 			return ret;
 	}
-- 
2.48.1

