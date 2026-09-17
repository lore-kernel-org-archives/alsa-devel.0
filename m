Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613B4C982D0
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:41:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2596F60218;
	Thu, 17 Sep 2026 10:41:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2596F60218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789634489;
	bh=NWmfg8PkXWApSrD/HNGOAmbgIvhW5yLjpA1/mMVGrMs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=dCncU37v7owxQ4gTqcfS9VmhdJtLUKI4rI0EsKf5D44qQb0lxtLEeu7F5Tvtb8sej
	 Nsa8HkTsQBAeGYqA16sgLwvzq2DHVYezd6hTeeirADbHlyxGrnArmgbCYo3Bryu75q
	 St8guLm7oXAXXuKZtXgg8RyKVrMysoFzGGaKV0y8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 56375F806DC; Thu, 17 Sep 2026 10:39:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BB079F806E3;
	Thu, 17 Sep 2026 10:39:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F0B60F8068E; Thu, 17 Sep 2026 10:39:24 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.60
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789634360;
	b=IB1QcXlky+Jw5dPunQ9hvsuaexZoQ6MMNIHHh6Mml/Nyek90DanQtj/5DbPwnuH49Z9L
	 rT/s5cxK18mT1ZK+16Mk1qdSM4DMaI+q9EycT3XhXsu5/gJj/giaIOvwHAOdzE7QqvEOw
	 W/nOYBQXrxBDhSWndnbbamjJVlHIIv0bsZB1LVYiKEnXxWTGEMIZnPzppDrJsmO51ngUd
	 8/o5q+41ONzWazoLrNjFhRQbGu3CkzMms6WWFMruOSiWy8/kLEtB02mfvgVqIrx5o4zRi
	 1fR1ymazYfNQehrx1pWgnpktJc8NeEQsGU58D8nc0NzMJJ4yFBCaQaBSchJRwGD7C/g==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789634360;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=NWmfg8PkXWApSrD/HNGOAmbgIvhW5yLjpA1/mMVGrMs=;
	b=nZ3kymSfS9GuJh81NOZWgM5pVP4oUImcFMO1+lImI6HXuTTp+p0ts2GtHmDyj7kIw6g0
	 V0BkALzjPI73szHrzbJ3u6L3q3Vz0KHIgtEscnfvMiDhev6dzL4szPG1jfM6AJr+9X9g2
	 oQXTk9wBQ/ngpvvFo43i8UrhzyKl5Wttfo/JAP9lEtIvpgUr/B/fu/721XwVjaOqzIGtP
	 nasivfW4JVfHbRptHCdDCrx1TZZfd8Q0vZV73KhP06tYTLQvHTJc+lCldrlyB/MvQTPzu
	 zFSv5EGseHFgTMwD6xoWxQLzXE+61evohFlK+7ssAZuOyfrBFQ9icYy7ujG3dwE56jw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=4WFMzmtY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.60
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011060.outbound.protection.outlook.com [52.101.52.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A425EF80652
	for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2026 10:39:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A425EF80652
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=4WFMzmtY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGoMRRah/U6O/uVOWggRNiQ/K4sLyg1IC25dJqnKHkHr42CAN5f5/ig6szwDPt/nazdlQTtVz7tW54FkNK2F9N3LNi/oYr9vVCQ8CMOQZse0LRloQL7VJ0qq7pfhVTXhTVgXyekInjgojFK9737J8xrUxIdL96IVbUl+MnNH1ci9d12442h/+GMXmawCEwquf3kzkLN1VQBF4SxPMPplRt4wAGaEqG/cJmH8UAwXrptJFliZ6EKtSoxpBtl4KtgjKCip6rDzoNKgC8EepojlFaEYhQToJOYB9MRIIatufPpVXZ6vzzRVX+IcHnqkEq649JTfW72NdqLbEo3aqORXFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/BB4mj2h1naswNQfVcvWfadcd+r4Z63Ld2vw1mUC84=;
 b=f5qSeRJhdy9GIWOVmDzp6VIjabuklP2+VOE1V75yEXSOQUzth1WxFlhkCiLcXBX7LTJa7Yc6dNVv6BMb2aKE0Hb0XpmObBEXz2MMQyGhc+hUexjWHfo7Po/BlRV6gGNFg0QyVIPSnr/Bo4XjGaz5MG7YUP+FSq0bxP7z8FajN8B3TPBx10FBWDPTSr4G0jiMPFUlRhEPT4yKOqmiRcIKvUbAqbEB+vBwdebI6ORU/3S4FzdcbIhhRoGsWcZLQ52mz7SLMKpxQNL3VHRLxkjckm0hBNlx4i3a/Ofx/BChOqrMxyqiyTX2EQEoa34A0hSAR95yghYVU7aYQtN9fQxdJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/BB4mj2h1naswNQfVcvWfadcd+r4Z63Ld2vw1mUC84=;
 b=4WFMzmtY3KxB74DPv8jP3rPYqptPQnZHZQVu1OuLbTLL3Vby5k9PXvM1eg2cWGxZabZ0O8GBhYr65GLH9JpqRpzdnCrvHbAoiDfbIfOw9xg6dWBPhH/a0oqhJAgMJkNS3SSILW70aHIK3tZkVS2unfGzGCUKkcm/8+hhLSLqneI=
Received: from BY3PR04CA0014.namprd04.prod.outlook.com (2603:10b6:a03:217::19)
 by IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 08:39:14 +0000
Received: from MWH0EPF000C6194.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::1c) by BY3PR04CA0014.outlook.office365.com
 (2603:10b6:a03:217::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Thu, 17
 Sep 2026 08:39:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6194.mail.protection.outlook.com (10.167.249.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Thu, 17 Sep 2026 08:39:13 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 03:39:12 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Thu, 17 Sep 2026 03:39:08 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH V2 7/9] soundwire: amd: drop amd_deinit_sdw_manager() in
 POWER_OFF suspend
Date: Thu, 17 Sep 2026 14:04:18 +0530
Message-ID: <20260917083732.3803526-8-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260917083732.3803526-1-Vijendar.Mukunda@amd.com>
References: <20260917083732.3803526-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6194:EE_|IA1PR12MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 48a0b74c-85fd-4bb4-981f-08df149726f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|10067099003|56012099006|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	hpsoaNvDCMpTWYUyehwlciukYTczbWkEBMMaPSO+CdOcsp/eDNhhTssBzftroBxON9IlGmn9dOFStXJuhkVZ8PyXfAV720cYMDa64PSmjQe6kLtmsUSQHMEOOK9EXJUNMETrrZLhJ7uB2rr4+6Gf9rz+LZDzbqfAZKy+k0ak+pnOMImyfgtmzDrXEUaWj3jkNaLgKcMHTZ4Xj65+3T//4Z2nCzw+pOSn7Q3NN2vhHMWiz3hJWxTVIVOZEvwwtY9G1A2+wRs8Q8+ltDJmtja2XALnW6GEJiZaUDm8V4Mwh8tlH6n6hgT2asmVfw4SiiREE2EP7cFQoZTZfY3xHLYXOnuD5jvriV4m0froL96HchaRq6m0SZWdnZWdyJgLMKMHgkQZ3242JKZr+BeKCnJ4MPorQ7hwkygxHeext0DNSYmTzdttG+x9scSTwHCfpmBOnE1ypmHD+ohCqT7gnDpaHG1089J+H3aBJKvGrgQvpwWoDjTQj6wQ2bHP/7Ub9ILOHGctPzOJvZ7g3xs6cST2A0bl66k9DXt1zXOsMDV4Tt/KRU5vHbGY0UZFEN87TGnUxxwx5r5Pa30aQV9FdBUrEq+LicCtAz6TNP76Jd8Mz4a486AZh98Xfy6yVHP+BA+qfzjaEocaGSFYRdk6WaoMIPrkeB8XVSGSmKJybuSsonK+3fs1vKiuuCVApJ4ElO7OXegoDWgUhDxPXDbjUlLJGw==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(10067099003)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	GoI3056FFFxYXQW2qo6ob56Uswx+KPJWSd5c85u2bLwoxm7NJQVweuU8sXIj9NGiNgCxUf7X/zrBPP3s2l19jfW+7gEp1Maw/CdUpNKKvNimZejkGwRt4/UaJ1mTBwv186y638yORONFGQTKuaYN0FvHO3MHD7oCpeWwzc++btreXvhCbDiNhYSGCN+ggUetkR113zxVZ9Wn6bbhJkEU9SIVBm6sw1xQ+MmXUMK/s1MTvzVJWuZrXEHi8Jktw0q9RqyEoPLT6hu+O1iZ1OkVSKXHMMRyRw4YzKkP1VM6SF5WB0CW4DbwgZK0RUbGZTsKLOuFn8zLamOtsWEuYJyHZu+AKr4356wFYrhmF3CQ7h7jLfLpWbEVq76NPD+3cRwG0UpyMcRmnY2r4+3auCsbKqVAWsTmMqCnjQgbhZej8PxxOM9ushFsGVTtADrm17HM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 08:39:13.5192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 48a0b74c-85fd-4bb4-981f-08df149726f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MWH0EPF000C6194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7495
Message-ID-Hash: DKS5BF32JD57S74I4ETDQHOYXBIY2Z7L
X-Message-ID-Hash: DKS5BF32JD57S74I4ETDQHOYXBIY2Z7L
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DKS5BF32JD57S74I4ETDQHOYXBIY2Z7L/>
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

