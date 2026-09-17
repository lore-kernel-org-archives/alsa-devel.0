Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9861C88E72
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:06:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 584E1601FF;
	Thu, 17 Sep 2026 11:06:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 584E1601FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789635978;
	bh=yO6y328vNISbtDzDtnHJj32oXmV1a/DRh1d44nc7UlI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=unro12x0vN2DRjJPIEor/4a4GZCFy176sK+/YbtoPDhHwbQdd8OS3ZguwIOdDJITd
	 kgH1pNXTmT+JMj3Lrdqj4KiG5GoUZmBqfwfuPo6xmlTf02iiCdp7sG+1NC6VZgSlwK
	 8Xu5ruknrmzu5tNuxqCyCZEd4bvz3XIlTRzdvjTs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 68892F805FA; Thu, 17 Sep 2026 11:05:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8EFB9F805FD;
	Thu, 17 Sep 2026 11:05:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0EB97F80537; Thu, 17 Sep 2026 11:05:33 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.2
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789635931;
	b=poJAqustPe2rqIB6hvviTAlmuinl2VYwkogT1MNlY31wdDcg2o3oYud7fJRHv+ZQ/3d3
	 ZplXwYQ017xmztvm47gJ3ERdVR5l1cWtWH5U/UqyQoczd8KfSEXpQvj7U/CFAFCg+ZUPy
	 CTCDwG1CmhOURMrfqw373PSvVjBQSZdgXqioueZIcjbhdIvqzBxsS89xo1FMTl5bwa6qH
	 pP12anaAAcA+pdkvzc5lv9Q9QdA07nmjkHdk2NW0yRU1Zi301syWnRCMdkxyKT0cDtF/z
	 JKRLHkvHq7wf5UKQKnaQoNnyix09Hshz8cjkSP5V4kOWv3UiL1Je7mj3UqO6zJIUD1Q==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789635931;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=yO6y328vNISbtDzDtnHJj32oXmV1a/DRh1d44nc7UlI=;
	b=RJLf2cTVPhPCTNbFtjUvuQlU0dYfFD34M5v8IPzAszFK+TT3/exokNmeicUEQIzrLNE8
	 BYVxQdu3nlBkUEy1GOkELICRslBE6E4zOoPo1j/5GDoSv474yAPYmB8qmxDnjW+4AfR5/
	 MhFA8UuN2D1HJ/RggH1RitrDGK4hXx/gMomTLD19Mgd7lVCXFtG/EHyQUvR9vPS4kcmpo
	 pCkSttA6roxUcvJ8+W3P1yQH/jwHi2AbIm8qDRsi3UBAmqYeTZhQ2vEx8J2TL6WklhtJF
	 tB/lfM62ZOy2As2CQd8glWALh4Nmj7a+h9QDAJQwN8k9UReSCFUNM4dunprVFvFoSVQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Uvhq3kIf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.2
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010002.outbound.protection.outlook.com
 [40.93.198.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 89F43F8007E
	for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2026 11:05:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89F43F8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Uvhq3kIf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfGe63WTQBb8y9tDmcbyp5ZEJbuiW+/fkCOmfc5vvbGGyTEelnnbcZaexUUixLdbvkPQIyKhNFd4iaMXy5znUtm6IZnN92SSb9Tu5hWYFT5NIU1HKgOH/DBLCHyDi3sSc1voNPvhmpfdMe/c8S4DMhDvAghsnFEFutVy87AbJXfkWpJiP1JPDC8FShcV6Qw8ixZfdaA8QNNUMGokMTKEaNikI1gYZI76E20pZMlUCNl348UElZzp9uEJiyLEHPy5QWsTAbCAFbMP19W8dSAg9BwwYNSXtL6qOrOfzTsW2e7S8Ljc0CdcyfBoyTIerPFEvD1OK0JJXtyI1XPJuUA9tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4KVcA+y82Qchbu12Uwtd3EUK1/q3BrOCPRpv+APbwE=;
 b=nQZskMxLtzqnNTfhaHatR2sfjZVxm+QrwmP2shY9jaKbZjUYGpgbP1F33tQXAZC1F0qZjDCdOolAGHz9v7EpPutzidlWdD71AllvFHTWJGXwDaSIbgYiknFDXrJ18+KPjGbaPTI80hVd20ntL9BgNfQJbJmfEytnYdmtjdrso7bQNH5zO9ipbnlIXj0FUR+odpYRze1M2OzrOcMHahT6FRy+AdRjSEXnGRJqY6Wq0qDgEXu3BNbstqvetU/vLBWke5FLvRj9fSE/gn5knl1iXevYAeTjTCoK+xnuvXptZuxmxtq+Ey95T2fFVr4puWkuyX0Ho6qPu/f8hc8S6qWGKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4KVcA+y82Qchbu12Uwtd3EUK1/q3BrOCPRpv+APbwE=;
 b=Uvhq3kIfCNd9Ye8afbmbGTPYf2E/DqdJz4Qx+6C8kX5BIO/f/d4LI/9JyxmDccPl7KrYOs/FIKwlnjUsgWvtyWcFJ/sXWiKx2O2q/zQYfKHJkLcI5FxMe5CFtJHeGxi3LbFHAB2dpLILwgWs+30WHEKA9JlFemvmdNb4LNGhuEw=
Received: from PH8PR21CA0013.namprd21.prod.outlook.com (2603:10b6:510:2ce::22)
 by DM3PR12MB9328.namprd12.prod.outlook.com (2603:10b6:0:44::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 09:05:24 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::16) by PH8PR21CA0013.outlook.office365.com
 (2603:10b6:510:2ce::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.7 via Frontend Transport; Thu, 17
 Sep 2026 09:05:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 09:05:23 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 04:05:22 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Thu, 17 Sep 2026 04:05:19 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH 1/9] soundwire: amd: rename AMD_SDW_MAX_MANAGER_COUNT macro
Date: Thu, 17 Sep 2026 14:32:49 +0530
Message-ID: <20260917090407.3828816-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260917090407.3828816-1-Vijendar.Mukunda@amd.com>
References: <20260917090407.3828816-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|DM3PR12MB9328:EE_
X-MS-Office365-Filtering-Correlation-Id: cfec3cae-d36e-43a3-9e90-08df149aceab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|56012099006|11063799006|10067099003|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	Ks5/+e4FlMtV3KTW3CSQANxW6nanp2sE/oF/O2lz3QIxanW60pbhBhk+zjPtbj3brmVZ/1AaV++7bMJW8sqHl9rwIoHQsgPDDoSvn3wO0m75LA4tCBxuiwQn4YwRR1aXhxAV7gg1eB+V5Ez8siFpfGolmP+6j5yEtUDwT/xrWmakc8GdYYui/lqkP8oeVYddxVk3nf6/J3KHfkNaazc/8gi24QhHuzJ57qjUu2Yy3/o+j6GqwT2QK8XHV6wU/L4gkY5gme32QekIBWjfALmSycEjJ54uQwMYP1DxbQIqNOpq+8pvPEik582wK30UmCG+evkTl6Dg0xIUV7uY/+lzDMmt/EK4D2v66RnrxcIoa/R7nLAHluzPIuEopPR+gp7a0El0lgpSR8hJfdZT7OhGIvNjcNnYqkyctFGjEgNHhmdJJQFBhI/YZxT7N6oWdxgK2tHXmr3G22cEuPNWUk1WBrIPJt79PHDW0W+5pNcUBQUW0w167epxYfWb+/YBfgdi3+kuNco/4fSF9HZXKiUtyAbAtViCwqqnJ9fUDHiQ4NhtHMbiD+CaGb3qyQTwAJ1LRWtbzScgl6wJ4xnBDCxssase+SYasGSK1n5CNpARDwTUq8EWn+tlRx0c3W7Z8cWry/9b8V71/VeDKhY5c1cc7zgnOcKaqbtLWVB3MPzThCER6e8ugsdrUUGAz/8CHAGOy4mARUVm8xNbBVx+g5Jmzw==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	h43MCfJhykG2NVV1bdn6f6YMDe45EdUhTlWZpimnvh9w6VfrneadQwBImUet+/OAPLDvQoS9NucjJK7L4MJ/qxSoDW/yk0wrk0QF7xyLw73vew4ohSEJ6RuOLz+LhJCMu7lDN3MzoES17+8eaFFZDJ5aCmCwdr0yQk/I5lwOLzus85lbdvCJOlJzyFn+rSEf0MB+IaDU03O4d9pjUJXfSGVADkQmecjd6wPrWuU4WpgBjr1l7PfvdBDghx9DIgxduhQn6LOXLTUAynoJN7Dud6D+MmcbZEAIUJsMcsVeu6mwmCy9tl9heZ/M6f2ed/lV6OWRZpOA/Tk0V0VRiCgCu6mFmx3bNQLMlzdH9ymaATE0fc66QFxK6TR6QTLBVsbD+Jse6JwxLy67R1MBc0GcY+oudB3AIfvevj3R2vWuNMbIM1Ulgg3LmQjDXOIhsFRA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:05:23.4009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 cfec3cae-d36e-43a3-9e90-08df149aceab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9328
Message-ID-Hash: KXKHLM4RSZM2P3SUIGKVWIZMDXWWPBX2
X-Message-ID-Hash: KXKHLM4RSZM2P3SUIGKVWIZMDXWWPBX2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KXKHLM4RSZM2P3SUIGKVWIZMDXWWPBX2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Rename AMD_SDW_MAX_MANAGER_COUNT to AMD_ACP63_SDW_MAX_MANAGER_COUNT and
add a comment clarifying that ACP6.3/7.0/7.1/7.2 all expose two
SoundWire manager instances. The rename makes the platform scope
explicit and matches the acp63 prefix convention used for the shared
ACP6.3-base hardware throughout the driver.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_manager.c   | 2 +-
 drivers/soundwire/amd_manager.h   | 2 +-
 include/linux/soundwire/sdw_amd.h | 5 +++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 1a252a81269a..400fa05456a1 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -486,7 +486,7 @@ static int amd_sdw_compute_params(struct sdw_bus *bus, struct sdw_stream_runtime
 	int port_bo, hstart, hstop, sample_int;
 	unsigned int rate, bps, channels;
 	unsigned int stream_slot_size, max_slots;
-	static unsigned int next_offset[AMD_SDW_MAX_MANAGER_COUNT] = {1};
+	static unsigned int next_offset[AMD_ACP63_SDW_MAX_MANAGER_COUNT] = {1};
 	unsigned int inst_id = amd_manager->instance;
 
 	port_bo = 0;
diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
index 88cf8a426a0c..76ecaceb3ee5 100644
--- a/drivers/soundwire/amd_manager.h
+++ b/drivers/soundwire/amd_manager.h
@@ -266,7 +266,7 @@ static struct sdw_manager_dp_reg acp70_sdw_dp_reg[AMD_ACP70_SDW_MAX_DAI] =  {
 	 ACP_SW_AUDIO2_RX_OFFSET, ACP_SW_AUDIO2_RX_CHANNEL_ENABLE_DP0},
 };
 
-static u32 sdw_manager_reg_mask_array[AMD_SDW_MAX_MANAGER_COUNT] =  {
+static u32 sdw_manager_reg_mask_array[AMD_ACP63_SDW_MAX_MANAGER_COUNT] =  {
 		AMD_SDW0_EXT_INTR_MASK,
 		AMD_SDW1_EXT_INTR_MASK
 };
diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
index d0e97007e3ff..40ba84c3b2cc 100644
--- a/include/linux/soundwire/sdw_amd.h
+++ b/include/linux/soundwire/sdw_amd.h
@@ -26,7 +26,8 @@
 #define AMD_SDW_POWER_OFF_MODE		2
 #define ACP_SDW0	0
 #define ACP_SDW1	1
-#define AMD_SDW_MAX_MANAGER_COUNT	2
+/* ACP6.3/7.0/7.1/7.2 all expose two SoundWire manager instances */
+#define AMD_ACP63_SDW_MAX_MANAGER_COUNT	2
 #define ACP63_PCI_REV_ID		0x63
 #define ACP70_PCI_REV_ID		0x70
 #define ACP71_PCI_REV_ID		0x71
@@ -138,7 +139,7 @@ struct sdw_amd_acpi_info {
 struct sdw_amd_ctx {
 	int count;
 	u32 link_mask;
-	struct platform_device *pdev[AMD_SDW_MAX_MANAGER_COUNT];
+	struct platform_device *pdev[AMD_ACP63_SDW_MAX_MANAGER_COUNT];
 	struct sdw_peripherals *peripherals;
 };
 
-- 
2.48.1

