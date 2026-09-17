Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94C6C88E72
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:41:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 52E1960222;
	Thu, 17 Sep 2026 10:41:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 52E1960222
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789634472;
	bh=j6ZWkAhaWpl5Wvfvw5PdFy42tR2wYIrAkGaqLbpAZlg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jU5w5J62C+mwwsw9osbfoz96v/WMFATDxmPx5gNeNBtZYtGSlMJaKRA8jogaKmJxR
	 qfkchWKMBwt0hcPJYjD+OGiYbf3C2UPGXYFiOeFAFx1nls07QPMN61Bf9tVZMMZwoW
	 4sBFkKqWBfOESmpk2JTZvdV+nngO7K525RspuRIY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 28446F806C6; Thu, 17 Sep 2026 10:39:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EE172F806C4;
	Thu, 17 Sep 2026 10:39:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E8614F80631; Thu, 17 Sep 2026 10:39:18 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.8
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789634357;
	b=N5MZ1ZaPX3Ys8UQvN69bwYfxKboE+HIjHix9k5GorpelRzLO/PbFTW3l1uAnRLDTkk/A
	 Zt29O4y0tHwynZ1a0GekQcc8AAmqwoV546cVKk3ghQnD9mmA1D1N5mIFJmuDQc7hjMxJv
	 b3eljFOeBq28ANzeVFcLu/gkRnoR/NfXy53yMirFYmIUl449ceZuKFTIJGCJC+lFLAftR
	 EtmUpwHbYwKW7JK4VOAnX/69H3z8k7x1hH3/uQy6du1fDtbPHLEGJA2UfsmW/OwK1tMCc
	 O2F4oa2+SkUjZ2IL6ffTwTBIUAdJRk/H3Ohl9d04kBEiFppB+GREScteF05n8EMcaYg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789634357;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=j6ZWkAhaWpl5Wvfvw5PdFy42tR2wYIrAkGaqLbpAZlg=;
	b=VMnULVRHEMDm2se0PKY6NeJZxM/c+OvcEPreQ24GNoAhYHoKffjqTQkWoIQz7StiyVp5
	 /rIOTqmyos95pZA/tqPepBamFYaYgQ/0YUIwLZevINAsclb5pRE+B62PDc2fR2/oMhqFz
	 IU01cH22nFNN5YsMfuP2/kvCjvsGFsdZ0a6EvXz4K5dkmPw7hT+Jq/59xzNlQPTYfpN0c
	 cUMkIYfuTFnSLI/aIGBhnaoGq4tMkjCdaRmj9CWk/vlgx+a79HBC886mhDg2onFPBWyGu
	 aFYy1g5DBe4OaAyCaqnZquObOuwiVogXkA5C67f73k+ZXLFyCpndtrZrcnL28nOB42Q==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=fHZq2qw+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.8
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 68164F8062D
	for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2026 10:39:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68164F8062D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=fHZq2qw+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUendDKDsFy/2ACw62eSdlubWm5fpATr2+FyZz3TwoiWa46Mjn0uLxxuhdj77+S8X2AKHurAKPeWyui8duWLWN2/fu/DUKDq0AyXPHG38adxL4TIaethbrbC9aKWTrfZty/DXUt416889c9SKv7/oOEJX9jx/RIiDr/Mit/GarvuFBySzy3Y4RoCluR9zXB3GQCkrJPO4+dpbsIAW5jHfb67cE1Xv0SpZ4cQxWO6VzqcmdzuRO6704YiEEtPXNSQ2cWPwyFTwvx4Laa2WvhiD/bbKiW5OKYbzp4JCyPy/6uWA/1ZJSj+wZ/b9Gfn1qiQzkg529qYxSnvOXKT80pKCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXcEEB/rWlVlM/YCXOy7QLZ2sjE2sbD1MRfMg9Ll+uk=;
 b=yhQSY/LbLEJIFiXzndj5QFgf5ankHhtR3DcYWgh3lpTKhir5jxSHBIx9iBr9Pp+ykJ6aLdKweFfEQTTO1NjzPtdM0fnGl+QsmeURCTsfgNdCD3bbGtQRULWvClFG0tS1suHlSOzOa5hi8lcVFtsrunoSKOpnRmVCH6yrwQUQZMTkbXADX4bCtPjO6OiC2C0IXKzjTRE9jrHgHywSBa2MKYRJNAxE/J/6wVe3/r6Epx2TqQ7sATWypC6EHL0ziLrOq/OIq2ZgtdbodV+NBqkrFvCEjPhhfi+rjoSQ1J4nxifsvRVm6I1r+23kfhD2zSH5hRQANFH22WJKsNcbJIs/7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXcEEB/rWlVlM/YCXOy7QLZ2sjE2sbD1MRfMg9Ll+uk=;
 b=fHZq2qw+DUnl++z7kDWBRywNm4fImex3akzZZqv6eo3B73UOH3+PQP4XvuNibZvWsrKdGZpSjHZy3nfYdDT3De1udj5Z3J1YrUeDtvlNjKgea9FlcU4ScrLFCpK/GWYEPqbEfux0swQbuC52wLNmU4R9OqkBzNu8bdmiUgYQkOs=
Received: from BN1PR13CA0005.namprd13.prod.outlook.com (2603:10b6:408:e2::10)
 by BY5PR12MB4308.namprd12.prod.outlook.com (2603:10b6:a03:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 08:39:09 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:e2:cafe::82) by BN1PR13CA0005.outlook.office365.com
 (2603:10b6:408:e2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.7 via Frontend Transport; Thu, 17
 Sep 2026 08:39:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Thu, 17 Sep 2026 08:39:08 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 03:39:04 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Thu, 17 Sep 2026 03:39:00 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH V2 5/9] soundwire: amd: fix ctx leak when sdw_amd_startup()
 fails
Date: Thu, 17 Sep 2026 14:04:16 +0530
Message-ID: <20260917083732.3803526-6-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260917083732.3803526-1-Vijendar.Mukunda@amd.com>
References: <20260917083732.3803526-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|BY5PR12MB4308:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e890b5-28d2-4953-efe8-08df14972416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	mmHajSfs+DS2ukWd0x2aeZWA9bg0CNLPT2O0dAXhmkOPw5s9jV0O1itbH/8ye/acQyZDrmBJ0AROF09ZXvjqD1IzbgvJIaAfsDQFD/AW86cM0AoJG+xV0WRLQ+kQGPAnEC5o0mNRmu9/nNFL3WXSgWU1HqcdzGE3960Sizqs/p9oRwG2Xcehq5x7lyDmRLSr8PD4wI49NK62jBGoWhH6JqnjzFeWuJIVoisHh9oeyKNZRgVk/s1z2BrYUwX8bfhTAEgZv06zr5moV9qShnAdxnUgiy6oul/JgMJUYkWjbO4R6jrGX1cleJjCmpXfWtyxN71OhpZCh3JhxMrD0WThKIVyGxEmNGN0PiNs+BYYUtF4mzKSNk5YJidsWi8NiASyyfL5y44/Dw0ICtHyRXrqdvF5Mi7bDz551vcBz4NSivmqKPKsb4po8xaSnlDjQHYdz7xucu/X3G4icwg/IdVb+c16vq8xVihQjKB8K83oTnEXYBdKR3f0Iesh+rZE0MPN6ThuH/P6P0gnd7BbcvnYnI+MJQ23cvZXlrfdU0OTRy8oWsFXJPSteA9iBVwSSxvfD+BA8o0mSrUcEHcEgtkEI02A5wQkv9RfnpH8+OcAhTq9bsxaDAIcxPdy+69zxoEXFy7dvIHl+uv0bJpS74eNvy6bvUfzInkaS8oAX3i+cMTBR5CeSl01hL4ohX9EnaJLEwB1OBv4t31dX4bOiP346A==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	WplYtl47ht7gJfJ5hRzU1slG68i67GxE7cf68RtnOVABpKRhqdrEgJu1vGer75ZibpmPxolgJyrtIuDl+CCLSzBY/3BOCDzJSMKpJfn1vq70M7xTkveP3VppuTFiehNQOhhUINdxdsX6UEpNOnPpIfrIWPsy/WaKFPTTw7PFKwzX/pQIYGfV/gmkQU7yXjj7UcYA2KcCt1ysqyslZqQRNdhRfySISvi7Rs5xoVTKfdrxoDwRsJKjrAR5shaZ7D4eevGU7ddQBp+mOhZud0s4DRSaNXkzTueB+o7KPsZHlevouW4QCoxxQ1DCYBMP1AjlHyhUR83puZ/4lV95M6WfK3DjeJJVbNQhvtZN9fbf2QmhGsZSNHyyn/PlVtyFDM0y/BxAXXosMjwQmpLoBR4u+uTBgSCMgXXeLf+83NnyHONgxpFIfkJf407JiODPqEJ2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 08:39:08.7570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c9e890b5-28d2-4953-efe8-08df14972416
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4308
Message-ID-Hash: WXUFOTLSBW4CXFIHDRNIJ3Q43C2S2VWT
X-Message-ID-Hash: WXUFOTLSBW4CXFIHDRNIJ3Q43C2S2VWT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WXUFOTLSBW4CXFIHDRNIJ3Q43C2S2VWT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

sdw_amd_probe() allocates a context and registers platform devices via
sdw_amd_probe_controller(), then calls sdw_amd_startup() to start each
manager. If sdw_amd_startup() fails, the error was returned directly,
leaving *sdw_ctx non-NULL with the allocated context and its registered
platform devices leaked.

Call sdw_amd_exit() on the failure path to unregister the platform
devices and free ctx, then clear *sdw_ctx so callers observe a
consistent NULL on error.

Fixes: ed5e8741b8db ("soundwire: amd: refactor amd soundwire manager device node creation")
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_init.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/amd_init.c b/drivers/soundwire/amd_init.c
index 8e419ddfa516..88004d59322e 100644
--- a/drivers/soundwire/amd_init.c
+++ b/drivers/soundwire/amd_init.c
@@ -166,11 +166,18 @@ static int sdw_amd_startup(struct sdw_amd_ctx *ctx)
 
 int sdw_amd_probe(struct sdw_amd_res *res, struct sdw_amd_ctx **sdw_ctx)
 {
+	int ret;
+
 	*sdw_ctx = sdw_amd_probe_controller(res);
 	if (!*sdw_ctx)
 		return -ENODEV;
 
-	return sdw_amd_startup(*sdw_ctx);
+	ret = sdw_amd_startup(*sdw_ctx);
+	if (ret) {
+		sdw_amd_exit(*sdw_ctx);
+		*sdw_ctx = NULL;
+	}
+	return ret;
 }
 EXPORT_SYMBOL_NS(sdw_amd_probe, "SOUNDWIRE_AMD_INIT");
 
-- 
2.48.1

