Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6326CCC6B1A
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2026 10:24:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7A483602EA;
	Wed, 14 Oct 2026 12:23:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7A483602EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791973438;
	bh=MYydjdi5Yjb2K4L/QZGw8URq67NrrlD0cGChI7zBIIk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qHfO6hqd+d+dHcKHR7SP+NAqFqiIzxnAbQZnY4xjIs47kJyye7cBiBJjAyolYl4lL
	 bl4LYVkyBPX990xKMCxM2HryS3YM5baH7C3as9lEgl8Vxdgi1H4tEFNxzxEjAaqZiC
	 mW6H2wXdTPogAyWhSprnSK/HlRTLiOcErl/c5cm4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5D979F80C18; Wed, 14 Oct 2026 12:20:49 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CEB4EF808F5;
	Wed, 14 Oct 2026 12:20:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9D82EF80847; Wed, 14 Oct 2026 12:20:36 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.13
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791973226;
	b=dvOuVq124bx+jK0XrSsySBZ7k+wsQzY59Dt6uhV7bfIoUPLgBjZN5vmFL+CG6K8JuyNt
	 AXQgQyt4KdnnPyDgHT6mSdr3NY0+kbeT9+xE+AWT/Tad24lscgqlDj7wlSoaUTqa+U91k
	 7XO/RnhshAht8yN7Cbf3r+jOa8qz6kpH6o7xFIkU00H9ZvMTzejuCcY288wYZmVNWi8T6
	 6dL2t/Vxb628CXn0kxEDMhFovFY79GCRPMkwWTvSTfvbSBfhBtmG7Imw+lz9XEEGUk73j
	 OXyo76HXfObeB/cC8y8W7vwmx+P2x9LjkRb/nPFr6qu7b9jvGg9m0D9XxQtQqrenPbQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791973226;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=MYydjdi5Yjb2K4L/QZGw8URq67NrrlD0cGChI7zBIIk=;
	b=fSNcKqV+4PdKC0gOn9sq3ert0kKaAzRG3RWIOo7vOT/K5ZFmHBOSLMZtJxDl22g0XH/G
	 oKChIlPmtw/9bssJWeHjnCuVV29l+sXf4Lv6WIp0cIqK7RnFIaXzhKfJHvHC0S/uElhae
	 4/AdsbXkea5zUwr0mE5qkSbTq/16g2SxEEI4awMeqeBkSJZ2+ho9SdOcmNy0mHExJAuyG
	 d+rf6eGBOKkokhdsNPgGQ9gdVmI3osrdv/zKUSet2RQIYUtOADFXYvJjA9gH9F2iqfPqk
	 XpJ7iwO/n0i2wEEULD8Il1S8Ghu+OnWaXllRiax417Vv4D9bCHiwwUkeQ9ZC8Kn3GGQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=cc7OSkeN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.13
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010013.outbound.protection.outlook.com
 [40.93.198.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B2218F80764;
	Wed, 14 Oct 2026 12:20:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2218F80764
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=cc7OSkeN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmjC1BQRuryRBwyRVIjGlC0sKMVtR1PT2kjT6lJ0pgkgFX2k+lCxEgFPXkk2xGs/SPfNfEZG2x8OnLkkH5c7/T1I74aPfnXUOCPKudeb3lZ1o4iU0HZu2dymcN7gKn/IeHMWGVsVe/036O1CHlTqow4VzgX89oE8kHlJ7sQtdU36j8K3pVRMdAnxxhZLuqlBwOUHZVzmvN5dhW40mEcr5R5vGEb8RYt91ORxCV+4iVogjJS5LA46uPY+KtNg7bfWaXqZcrTmdyVcavJNQ9bZTbb4uh3MArMOizshBVx0R1gXngfaXo1iPj6x0JkS12iDh9YQmP6LDX9z6973G0Dl9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KfTk3Uuu5/r1ixTcmSrg/SsIAsGezUGfeW3iomcpRk=;
 b=rTW5nuE/2Vi6/+C9vS2buDNr01dpRotpkBRf8jPdtmiy6rrvKgcjcS4MSOuq211R+1ocBwZ41n0+O2J1OFQE67G4Mi2kI8IsDujbawD1W8+eIe8Q3Jp28Eb4nGtf5E8O7qG8EEPuBRNkO8UvC0L38d5Mp+2+LMHmSUwfoRoUz5GPtacpTSLUx/P7/4M4EPY5n/b6V3IXDFSBUQbJZ0n93D+z2TsVqoyOtiqV+MyZosYLkPFEa4bxyt0J06uhTMuWpv/EPEHav6uDA77UXz30OQay9uWe0E1wpOU9DjaMdKk69M06C17z1bvwVrtDWaQFGl+0IBI+EJFg3PU59mx/XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KfTk3Uuu5/r1ixTcmSrg/SsIAsGezUGfeW3iomcpRk=;
 b=cc7OSkeNR7paa/rVtJgHhgGE9bhnlPQIl2UU8d7q1/8TrN6VBIliuIInDovwBqCym8l/4DRKzsP2ze/mDsrmKC//ly7IjBq3kef+sEG0zZ3bQ9Vhr+BCdDEoKQ0LU8js7XvjHCKVnESTZjq/yhln1r+0KiWSvc7eEO/jzrNG9YM=
Received: from PH7P220CA0060.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::29)
 by SN7PR12MB7324.namprd12.prod.outlook.com (2603:10b6:806:29b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 10:20:15 +0000
Received: from CY4PEPF000392DA.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::73) by PH7P220CA0060.outlook.office365.com
 (2603:10b6:510:32b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 14
 Oct 2026 10:20:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF000392DA.mail.protection.outlook.com (10.167.247.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 10:20:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 05:19:59 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Wed, 14 Oct 2026 05:19:54 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <yung-chuan.liao@linux.intel.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<Vijendar.Mukunda@amd.com>, <Poojitha.N@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sound-open-firmware@alsa-project.org>
Subject: [PATCH 10/13] ASoC: amd: acp: add ACPI machine tables for ACP7.F
 SoundWire
Date: Wed, 14 Oct 2026 15:46:29 +0530
Message-ID: <20261014101817.1240200-11-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261014101817.1240200-1-Vijendar.Mukunda@amd.com>
References: <20261014101817.1240200-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DA:EE_|SN7PR12MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a777ac1-7163-4349-e2a3-08df29dcbd2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|6133799003|18002099003|10067099003|22082099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	1PxqisNNrnG7bI1/MGWrADq464kOjUtCoC8hruxkUdq6YdqS2ZDQkP8EKc17yIhai3psCsh0wPeOzD2xGDK9FQgWRaCyrnUMB9fIAPWQ/3aNzMm1UlXB80jYoxUp3M1cI5SyVdFLKztjx83LzehR4jDxkwFByg1K3iSq1XRWDpRr1rtG8bOcDsvafeuA9YupQ/uqjMzMaUGCFMAlqIwVRVzJY0fbtHT1AtarVnxuFqVNM5PSNAyywfC9ugYd1T6xZLdEcDOvYq5BU9QIw2Etbe/PBU+WLaEZ0nHUzhN1tyoKNr3frO0p3smWXhrHUtZ0QqUkWg7/ccQVZLkx/uF3j2n9Ok8qk8Mgh8R+R5jN4uEgYczrLVEGhDsGMj2e2G9xsEkWE9mDu8bl+XAhmlUC9RpsnvoNbdpJsTopWq1V5jT7yNXb5CmBb47MrfGokJbodrMhUPGtpeis7y7wArMq/IGHWr/hqq2IY0TBLwzgxl32JucAoQ6m/rWq79vb5O2Ve3s3PZ0XW2jIXc0fKDfZGul2a0MIBSibL0xqApI1reqvvTMoRNo3XyH9q3sOJi0CBjv/7DYRVDF49fHwy+wRtxXrAl2MKDH9QW7YCihPzoIiqBJCMo64QMMSmp6rSsZmYZ8+2yNO2lfBF4ET8hxfgCNrtmAPgefNh8x2VpDtFl9kbyFVkcE4yYSUqgscDGz7
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(6133799003)(18002099003)(10067099003)(22082099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	8owqJaDcxPjjyu2byCMIpQ8ouOqU8lj0znYtqg6GJFTcnf93xhrbrfqW+Ps6Q1LK+Jn5ylK1dxzzb5T28LsVGlmQoJLyyNS53xcMsXOMUB4vsQ1riuGmc16YFivlooljqH/e4cZmQomXQMQ+ZUluvWMIJU0ffM7yLN6N+aR9b2/iJChrB0cUSDF3flAfzgw7eTaQDGuSPS3blfFP/hgN1Y/FzuyQjzHN2p9brkoOB6Hdz30OPfTD+lFAfc4AqbZl4FDPT70fhkCLQQT4iX0ysDAenNk1E/6Xc1em26LVhHt+7pwIyEFW78XxxzuVRNdjwRUuSge1NHTMWLCupg4aUQP2UJKD6bq0pSi91TMHvBz9OaAztgfZOGpb9NNfVN5w2nzvEBgyZCkjzN+J2+wMRu0/ImpyYNY5SExnPdEDvgOAm1VFURiYOfZXDuoJWeYh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 10:20:15.2589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 5a777ac1-7163-4349-e2a3-08df29dcbd2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CY4PEPF000392DA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7324
Message-ID-Hash: ROFZK3VM3GIBFM7A6WIYOQUNNNF7Q3QG
X-Message-ID-Hash: ROFZK3VM3GIBFM7A6WIYOQUNNNF7Q3QG
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ROFZK3VM3GIBFM7A6WIYOQUNNNF7Q3QG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add amd-acp7x-acpi-match.c with four snd_soc_acpi_mach entries for
ACP7.F SoundWire configurations:
- RT721 + RT1320 on SoundWire links L0+L3
  (jack+dmic on RT721, spk on RT1320)
- RT721 + RT1320 on SoundWire links L0+L1
  (jack+dmic on RT721, spk on RT1320)
- Standalone RT721 on L0 (jack, amp and dmic endpoints)
- Standalone RT722 on L0 (jack, amp and dmic endpoints)

RT721+RT1320 combo configurations use jack_dmic_endpoints for RT721,
skipping the internal amp since RT1320 provides amplification on a
dedicated SoundWire link.

ACP7.B machine table will be added in a follow-up patch.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/Makefile               |   2 +-
 sound/soc/amd/acp/amd-acp7x-acpi-match.c | 186 +++++++++++++++++++++++
 sound/soc/amd/mach-config.h              |   1 +
 3 files changed, 188 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/amd/acp/amd-acp7x-acpi-match.c

diff --git a/sound/soc/amd/acp/Makefile b/sound/soc/amd/acp/Makefile
index ab5f9dc871a67..42e2bd34da060 100644
--- a/sound/soc/amd/acp/Makefile
+++ b/sound/soc/amd/acp/Makefile
@@ -23,7 +23,7 @@ snd-acp70-y := acp70.o
 snd-acp-mach-y     := acp-mach-common.o
 snd-acp-legacy-mach-y     := acp-legacy-mach.o acp3x-es83xx/acp3x-es83xx.o
 snd-acp-sof-mach-y     := acp-sof-mach.o
-snd-soc-acpi-amd-match-y := amd-acp63-acpi-match.o amd-acp70-acpi-match.o
+snd-soc-acpi-amd-match-y := amd-acp63-acpi-match.o amd-acp70-acpi-match.o amd-acp7x-acpi-match.o
 snd-soc-acpi-amd-match-$(CONFIG_SND_SOC_ACPI_AMD_SDCA_QUIRKS) += soc-acpi-amd-sdca-quirks.o
 snd-acp-sdw-mach-y     := acp-sdw-mach-common.o
 snd-acp-sdw-sof-mach-y += acp-sdw-sof-mach.o
diff --git a/sound/soc/amd/acp/amd-acp7x-acpi-match.c b/sound/soc/amd/acp/amd-acp7x-acpi-match.c
new file mode 100644
index 0000000000000..2f5e060ec79b4
--- /dev/null
+++ b/sound/soc/amd/acp/amd-acp7x-acpi-match.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * amd-acp7x-acpi-match.c - tables and support for ACP7.x(7.B/7.F) platforms
+ * ACPI enumeration.
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <sound/soc-acpi.h>
+#include "../mach-config.h"
+
+static const struct snd_soc_acpi_endpoint single_endpoint = {
+	.num = 0,
+	.aggregated = 0,
+	.group_position = 0,
+	.group_id = 0
+};
+
+static const struct snd_soc_acpi_endpoint jack_dmic_endpoints[] = {
+	/* Jack Endpoint */
+	{
+		.num = 0,
+		.aggregated = 0,
+		.group_position = 0,
+		.group_id = 0,
+	},
+	/* DMIC Endpoint */
+	{
+		.num = 2,
+		.aggregated = 0,
+		.group_position = 0,
+		.group_id = 0,
+	},
+};
+
+static const struct snd_soc_acpi_endpoint jack_amp_dmic_endpoints[] = {
+	/* Jack Endpoint */
+	{
+		.num = 0,
+		.aggregated = 0,
+		.group_position = 0,
+		.group_id = 0,
+	},
+	/* Amp Endpoint */
+	{
+		.num = 1,
+		.aggregated = 0,
+		.group_position = 0,
+		.group_id = 0,
+	},
+	/* DMIC Endpoint */
+	{
+		.num = 2,
+		.aggregated = 0,
+		.group_position = 0,
+		.group_id = 0,
+	},
+};
+
+static const struct snd_soc_acpi_adr_device rt721_l0_single_adr[] = {
+	{
+		.adr = 0x000030025d072101ull,
+		.num_endpoints = ARRAY_SIZE(jack_dmic_endpoints),
+		.endpoints = jack_dmic_endpoints,
+		.name_prefix = "rt721"
+	}
+};
+
+static const struct snd_soc_acpi_adr_device rt721_l0_only[] = {
+	{
+		.adr = 0x000030025d072101ull,
+		.num_endpoints = ARRAY_SIZE(jack_amp_dmic_endpoints),
+		.endpoints = jack_amp_dmic_endpoints,
+		.name_prefix = "rt721"
+	}
+};
+
+static const struct snd_soc_acpi_link_adr acp7x_rt721_only[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(rt721_l0_only),
+		.adr_d = rt721_l0_only,
+	},
+	{}
+};
+
+static const struct snd_soc_acpi_adr_device rt722_l0_single_adr[] = {
+	{
+		.adr = 0x000030025d072201ull,
+		.num_endpoints = ARRAY_SIZE(jack_amp_dmic_endpoints),
+		.endpoints = jack_amp_dmic_endpoints,
+		.name_prefix = "rt722"
+	}
+};
+
+static const struct snd_soc_acpi_link_adr acp7x_rt722_only[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(rt722_l0_single_adr),
+		.adr_d = rt722_l0_single_adr,
+	},
+	{}
+};
+
+static const struct snd_soc_acpi_adr_device rt1320_l1_single_adr[] = {
+	{
+		.adr = 0x000130025d132001ull,
+		.num_endpoints = 1,
+		.endpoints = &single_endpoint,
+		.name_prefix = "rt1320-1"
+	},
+};
+
+static const struct snd_soc_acpi_adr_device rt1320_l3_single_adr[] = {
+	{
+		.adr = 0x000330025d132001ull,
+		.num_endpoints = 1,
+		.endpoints = &single_endpoint,
+		.name_prefix = "rt1320-1"
+	},
+};
+
+static const struct snd_soc_acpi_link_adr acp7x_rt721_l0_rt1320_l1[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(rt721_l0_single_adr),
+		.adr_d = rt721_l0_single_adr,
+	},
+	{
+		.mask = BIT(1),
+		.num_adr = ARRAY_SIZE(rt1320_l1_single_adr),
+		.adr_d = rt1320_l1_single_adr,
+	},
+	{}
+};
+
+static const struct snd_soc_acpi_link_adr acp7x_rt721_l0_rt1320_l3[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(rt721_l0_single_adr),
+		.adr_d = rt721_l0_single_adr,
+	},
+	{
+		.mask = BIT(3),
+		.num_adr = ARRAY_SIZE(rt1320_l3_single_adr),
+		.adr_d = rt1320_l3_single_adr,
+	},
+	{}
+};
+
+struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7f_sof_sdw_machines[] = {
+	{
+		.link_mask = BIT(0) | BIT(3),
+		.links = acp7x_rt721_l0_rt1320_l3,
+		.drv_name = "amd_sof_sdw",
+		.sof_tplg_filename = "sof-acp7f-rt721-l0-rt1320-l3.tplg",
+		.fw_filename = "sof-acp7f.ri",
+	},
+	{
+		.link_mask = BIT(0) | BIT(1),
+		.links = acp7x_rt721_l0_rt1320_l1,
+		.drv_name = "amd_sof_sdw",
+		.sof_tplg_filename = "sof-acp7f-rt721-l0-rt1320-l1.tplg",
+		.fw_filename = "sof-acp7f.ri",
+	},
+	{
+		.link_mask = BIT(0),
+		.links = acp7x_rt721_only,
+		.drv_name = "amd_sof_sdw",
+		.sof_tplg_filename = "sof-acp7f-rt721-l0.tplg",
+		.fw_filename = "sof-acp7f.ri",
+	},
+	{
+		.link_mask = BIT(0),
+		.links = acp7x_rt722_only,
+		.drv_name = "amd_sof_sdw",
+		.sof_tplg_filename = "sof-acp7f-rt722-l0.tplg",
+		.fw_filename = "sof-acp7f.ri",
+	},
+	{},
+};
+EXPORT_SYMBOL(snd_soc_acpi_amd_acp7f_sof_sdw_machines);
+
+MODULE_DESCRIPTION("AMD ACP7.x SoundWire machine tables for ACPI enumeration");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Vijendar Mukunda <Vijendar.Mukunda@amd.com>");
diff --git a/sound/soc/amd/mach-config.h b/sound/soc/amd/mach-config.h
index 02ce044bcbf72..321af4682fd30 100644
--- a/sound/soc/amd/mach-config.h
+++ b/sound/soc/amd/mach-config.h
@@ -30,6 +30,7 @@ extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp70_sdw_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp70_sof_sdw_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7b_sof_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7f_sof_machines[];
+extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7f_sof_sdw_machines[];
 
 struct config_entry {
 	u32 flags;
-- 
2.48.1

