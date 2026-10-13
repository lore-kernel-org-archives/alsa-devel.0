Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258EDCC6B08
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:54:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2B19060215;
	Tue, 13 Oct 2026 10:54:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2B19060215
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791881658;
	bh=ZtbntJycbmSbN6o0sZVzksLKG5qXW2LBBgQv3q0WiPQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gFk+WOiLC3/96/YbFMeL0g8/9rATNcOTYRvKccCxv7nLEKJ4RzWXVizjkMZP5pc9l
	 fuYlqxw2J9iApO37fO1BeyliGCNFD/sica4NY9f4sQqVpQqzNC+QsNM9CeV3Ta3Qp0
	 ZbQM9ovp3ng6QC8R0lgaj8Cz4sv0Zo6mHO/Dx4Yk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8D6C0F806A8; Tue, 13 Oct 2026 10:52:56 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D670EF8069F;
	Tue, 13 Oct 2026 10:52:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 43586F80624; Tue, 13 Oct 2026 10:52:47 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.39
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791881563;
	b=hoUrobU2n3iHSnDWVgnQ82dt/3VrHkraVmGwUkyAveb3RzasMTXgFYiwYQQKND3qMBda
	 kcwE90enqIiVGsQh1sEBvDh2m+WKY2ioYR2rBL0cdIZ6YrS/LeWMalNrez+ZTeG7UjS3D
	 1mCnCrr39+pmWufUqRQzHYEL3aNcK6HNW8E4bsMdHbxw1x8gEEKosBm4WHd4XyJMUplPw
	 um4E9UwafsMOulVTJFn+yQ9fq8kFy+RFqQ3JMn2V+eHyCLAd6rLsvRZAZTkUE6q1jiUST
	 UyTEvwmJzwYWtZVkBBg1Ljo0q3ftr/gBRReCAX3Qk7phc3oR9yWewB7nCzcI99Cb9vg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791881563;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZtbntJycbmSbN6o0sZVzksLKG5qXW2LBBgQv3q0WiPQ=;
	b=ZQYQfxqas41gKyKJNFSIRX8qANJkvQrErFCHFonjO+5BgZX1LXBem7vMcsmm3r5apWhe
	 wde480zlMvkVnqN/JFoqTV1FYACv8fXNKux4Efevy3Hxbr/wed5frFxanZy6M3QOk7pMK
	 kwAF+EclOm10zouYHcujRHgS0mmqUV8h6yriq0lULQDGCu+eXWFdvDcoL+u5RdM1yix3h
	 nixwUk8PARfHxoFfAXCWNdedA7ohNbyZJ2BLOdzsUFq6qigxpH9rrIFh/5ZTLDEsbKsqZ
	 SbjKApUxXUEAUsaNF0rbN2Ol6CdDB28nLoIvEC2ggrucCbXQUGVncNOkanL954LhFew==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=1WQJaeVx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.39
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011039.outbound.protection.outlook.com [52.101.57.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BF146F80624
	for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2026 10:52:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BF146F80624
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=1WQJaeVx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKFvOgm+GtfUhos3RxH7YA6Wg29WOVsJqS45JyThCk0qUwqFTEa/tM5VMd+WyMNwKcf9cd9WvGzOvQecHk5wkp1lJ6JzFlyb/zkDRFEH6j5Im6hGBwNKLdtlmi/AkeunN+lA+ktmO1cGkwZHtiFJMqvTLdITWYWu9aurHIvY6Psy8lp2BPzmQCBALI9jcI7C8c/DM7eDr/oBNTfBQEGAq/beon0FFlmsVqyttFNonRg/WKtp08KKscrYcreRPp/3UfBHVNXKCWQsAHJbsCva4mlmv+euQeCordISUN9irE8rc0y3XVjtMk6G4U+jv4QDWNP/tNAmgA62LwWVebX0iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fS3oxGWZfkHEQHkHrwT/tlXhEfWx6AObVf3HmcYXOhs=;
 b=P1ssoSFA3yity1Z0WPj8dFIRuJxxiUaC5n1oz9SR4+AaWWG75bHY4QkWD/RR/qiRQ2YFzQCeySCocsqJjKKT5Gs7+9UUsup07smFF/AK3ihcV3ntQIIQodDuV+988+8NpMOnIJv1fU7F61qfJFEy128ykLy4FT1qKBkjc5sp7jzx9Q5rOftMuiSSgcb4qZD4w0t0HT65/LUzBG+ErlZlJXqlAtHTTsrZ8PqCQWudGR5dZYx4dOqKLyadabfYzhGQfuDg+BEBFssxXlweM9G1+jrHdKzSIIclBEfwbUqil0gbVORp/SUM9AYVGYM9QmRuOjI6Xf9SrS8XYSzExCFt4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fS3oxGWZfkHEQHkHrwT/tlXhEfWx6AObVf3HmcYXOhs=;
 b=1WQJaeVxiUvnUzAgfKkIHo48ataOsGlvUDiPB0ahwV2gn0WUU5KeRQBT6i+fJbxWaBYcZA78H57jijgWmFuPrQgMP/fQPuVbIPjV3WPSAXfFXc7ZxspsgweJnQBdQxppp+egRH8GdX1aL8zDbHgml5z/ePSnDEV4tvRGGXhG3vk=
Received: from BN0PR03CA0005.namprd03.prod.outlook.com (2603:10b6:408:e6::10)
 by SJ5PPFCD5E2E1DE.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 08:52:34 +0000
Received: from BN6PEPF00000076.namprd03.prod.outlook.com
 (2603:10b6:408:e6:cafe::64) by BN0PR03CA0005.outlook.office365.com
 (2603:10b6:408:e6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 08:52:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN6PEPF00000076.mail.protection.outlook.com (10.167.248.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 08:52:33 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 03:52:27 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Tue, 13 Oct 2026 03:52:24 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH V3 06/10] soundwire: amd: propagate amd_init_sdw_manager()
 error on resume
Date: Tue, 13 Oct 2026 14:19:27 +0530
Message-ID: <20261013085111.2009061-7-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261013085111.2009061-1-Vijendar.Mukunda@amd.com>
References: <20261013085111.2009061-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000076:EE_|SJ5PPFCD5E2E1DE:EE_
X-MS-Office365-Filtering-Correlation-Id: beb5d02a-327c-4250-773b-08df290752bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|10067099003|22082099003|18002099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	yt8A5chhB+KLVNjovBOOlxrmzXlbisRhTftVbBVDv8tiHwPlqrxDfSG1737846RACbMlzV+XYUqhl+bxHBaPar6+TUCARarQz+UEV9i1E+Ccdd9OCg9lXAb02/0eEO26YfGlm70n7vXWzJdGhOoesTvh93AnrnD0wQuOZ8WxkJZyTjAkkETFSWCP2rSzOfvCDOnfLfTX5X1VW3Tw3au4tfWE6yGDDputZ9I6XXuRJip5kniaYbWomnfFOiUID//niDeHpiN+Trft4ahMBJ1TotfR0QXo2q7X1ShhyRA59aEQNQBlzetQBV10k9oKzL5nYP+TYnjQbs2IpRuUPcdQ4WkTP0wE3PBqymyvRK/OLyx/WflO83bW/RM2SzmxGQyE1zE54GIXnjZreZRDGbGdrQxQwc3qVNGR3u0jawP2J27/LHRpsBkYWoNoM0IDyRpMTg3PHMNCdgUY/HFkXPXwTVvXmlVP0RbfZmQKgN57cdk5bb6weHdI64ql7M8HFxiKGkOo233DKbOYJJ7gp31GR8JneyQv7v/lOfuTeWeHlYOB1Hc3EzCwwNux6pgDMZ4rDI7KSK6gZdRbogyfj0qAB9Ml9q3m+1krRmLHQ2vDEwCGpCxklMIxQrsPVLZKIa8buwpPdTE3bOzyE1pWw/v9dpFHb4rXyJ1B5TGIBLwPpK8G+kzk1KJq8TfiMUFqi6qEzmR2+u7ayWPuxUrDUOricg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(10067099003)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	D0/iL5MhKkaFJ0z1HY8xj2UfChYq9aOLax4kbziZqTyAIGt9wVoYRUcEzkQkemk56hNhaafyTDA5Swoc4owtSr+lf5Nixsi1PJw87Qj/RrgXptbUtgjBVFyMg4im813kaJ/s9YxY/N61C3HmdgLJT72n/gxhpS0/T1wzz/oqpHFb6gB/Xz1MyujqrXYWgNXK8zwibhUj4WJ0VGkXHfkmVJLNjNb53B6IzshKN0t2hX9J2/EdH/GhHA1lIOP9RhBHkORthR05dw1KCygRVzk+C2gVNl3TiUL8xlLVYPW6PhWiQQUnG+WC3gw2HeCvcM59WSgcBmPfa8veg3T0U71E0up/gOJhfIH526r0+Vdo/IdMjGBTqDzhaygzOT9MybdDLYfZerX4hwJWY1KAFbHf0rmcQCpoNKzTo/IM3JRIax37hxju4aaaCfGgeqKwXX9R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 08:52:33.9067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 beb5d02a-327c-4250-773b-08df290752bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN6PEPF00000076.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCD5E2E1DE
Message-ID-Hash: PRJM2OGG7LKXFZW4S2UFOL7TWVCIEOII
X-Message-ID-Hash: PRJM2OGG7LKXFZW4S2UFOL7TWVCIEOII
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PRJM2OGG7LKXFZW4S2UFOL7TWVCIEOII/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

In amd_resume_runtime() POWER_OFF_MODE, amd_init_sdw_manager() was
called without capturing its return value. The function performs
hardware bus resets using readl_poll_timeout() and can return
-ETIMEDOUT if the hardware does not respond. When that happens,
execution fell through to amd_enable_sdw_interrupts() and
amd_enable_sdw_manager() on hardware that may still be in a broken
reset state.

Fix by capturing the return value and returning early on failure.

Fixes: 81ff58ff71ad ("soundwire: amd: add runtime pm ops for AMD SoundWire manager driver")
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_manager.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index bbe1e73ed255..2d2f628230ee 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -1456,7 +1456,9 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
 		ret = amd_sdw_clk_init_ctrl(amd_manager);
 		if (ret)
 			return ret;
-		amd_init_sdw_manager(amd_manager);
+		ret = amd_init_sdw_manager(amd_manager);
+		if (ret)
+			return ret;
 		amd_enable_sdw_interrupts(amd_manager);
 		ret = amd_enable_sdw_manager(amd_manager);
 		if (ret)
-- 
2.48.1

