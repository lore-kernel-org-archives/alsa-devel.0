Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD76CC6B1A
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2026 10:13:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6EBDC602C2;
	Wed, 14 Oct 2026 12:13:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6EBDC602C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791972817;
	bh=DC6kP+RHKYVexG3fLNcU8ST5fmLGbQbaemeul8omra8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hPsHE4/Ny86h6wy3kKzGINDq1H6/kpCjAmLQOLvT0cg6z69o7NoekD50PQ/xbjr5j
	 tA0daAtTRMEGrEbVsHoK3Y7obpS/OyvEgZsw2U6nF+uZIX475ZCbY8Evq/8jw4SY5D
	 cvqUiOCt7sQLqrX2BWi8M2YhnWVxXFD4L7ynukEQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9C7DCF80769; Wed, 14 Oct 2026 12:11:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 53AF8F8078F;
	Wed, 14 Oct 2026 12:11:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B69E8F806B2; Wed, 14 Oct 2026 12:10:52 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.3
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791972648;
	b=mLjTvxmZj1wB1OHeuGnJUOIaYEdNG1TdqV0EjgTc5kppuFHSVun1RDZkFfemRLciHgaE
	 4uR76Ic5AGStFTz4zAueDZ4+6/tL16/XUMAxPPEfTpco4GvJPqCXDVtwhFE29CKSIjThd
	 GvegOT1f0XTDSEdWk8UHqb6H4oC3JVkPPyCgkcZ6jUHd6EqyuT/tvU9vgpEBEFrM08GjK
	 URPX28X/2gTsTGYTkRCxZvy0ry9+j8QFcLmBS91TvH/+gGHbf2mCernVuPuZdIvJbG3A1
	 v9HRu6huVRDWeXxJuiykZ/5ub8Z5cX7Q6vk9Z9zHAWxijhCJbo36GSoMITv/HjADiLA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791972648;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=DC6kP+RHKYVexG3fLNcU8ST5fmLGbQbaemeul8omra8=;
	b=okQRF+pFq45hIXwmcmPTRJVgm/qk+3LLO30p4PED5zTczf0Ayy/PjTPrh5rkNp8TUNp+
	 iJqvA0RKTq8pR4NDhBqXjeLwCxOOCnxwLcUCH9vXJx/Z91heS0YgaNLWRnrgJl6RovsbS
	 XeIRB4U+7axqlLklNgPMxPr7rzN35IPqSXTYEfSKalaZa6CQlwm0SLfZScGyRNcAHL961
	 DmD2HIYVD3TWr33JIFk2EV/donQZeeZN1fTwWPQ6NiESqapr9bWdZHcLcE/6vQbUIE5/5
	 fgwcKnssA6ISBEiBTuxHTcJJPnOH5VdIteWIKHP1DxtRUp8zKWTTqmhI+U3wv8H5IWg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=nlywy81e;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.3
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010003.outbound.protection.outlook.com [52.101.46.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 40A20F806A0;
	Wed, 14 Oct 2026 12:10:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 40A20F806A0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=nlywy81e
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2TIWN60js1BxLOIFQ2ZjjiHdoW0zqx4QIlAkXRtR7c2iZWM26x/b0gG08aHbjb8J8gzww0oUvoiSSZtugVnjg2jYYA/f+HyzBHeHoKqMUhn88fdeGCP4ug+yiDeEjwgDxL5avH/d5jIxbGpxT5BC4VMM6HmywoItTBL3JmJ4j/2KcU+ufg/PQ4H4IDxuBC3Q0qqa4wfKMWLw6kWa4BnDQWwQCZUsLiWTPHvxBueK2IuRTcG36C4iPb08w60/oAZlExYIYWGe+slnFSY93WHZlZNOOOfAXOUOqiTeByTCqpQvv6Hf1Zwuhmnmmp6GN3A/I9LoLa4N3dy9rnaCVgdeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxDBVLY7cNB42NcVSbhgSajcqqWPAp0q3/tygryuFvY=;
 b=dFGeyQKKKuv9IIaZ6L3wnarx/AURz648tfUoxqAyyo1v0U0gYScw2m25uG6oEhXUoJeQaym4//Pu96y0QVR4DV+rDIpIeqgLe5v/GoeWyZ8G7zToAQ+x6uO55jG0ll8WrpO9XfuWDW6p6isnYCwuz2EWsfuAOfWNzRaepLIxvwe45iWijhnCxz69iJ0AhXl4Cx/pW0agXOTXT2hUExSjijQ+EfILTmFQi36CrKjj0JdTKEWVVfd7/BmE8oGhfTaoPtif/AD5cfuN5RmTXryat0nwFbhTa5UxoTl+/bqX058gNFuVEZS5Px3GoobS1J4p0vqmYn0+wvjvovtLHBgNLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxDBVLY7cNB42NcVSbhgSajcqqWPAp0q3/tygryuFvY=;
 b=nlywy81ecOD5ts+TOCwM/3DIjbJMKTKoP9eF7qiXmRR8PxJlJcr1FHfsphIH+Lwnbg8UUACqT5UohssM7Q98nv/l0U9g49hmefssDggmXpWTu+VDji7Kd9TaSEvL4sVsR8czKA7/BywMzgH7+xtJHPYwyOSR7/i7V6ELywhTPx8=
Received: from BN9P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::11)
 by SA3PR12MB9107.namprd12.prod.outlook.com (2603:10b6:806:381::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 10:10:39 +0000
Received: from BN3PEPF00022BBD.namprd04.prod.outlook.com
 (2603:10b6:408:10c:cafe::16) by BN9P222CA0006.outlook.office365.com
 (2603:10b6:408:10c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 10:10:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BBD.mail.protection.outlook.com (10.167.248.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 10:10:38 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 05:10:27 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Wed, 14 Oct 2026 05:10:23 -0500
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
Subject: [PATCH v2 07/10] ASoC: amd: acp: add acp-mach-common.h for shared
 machine driver types
Date: Wed, 14 Oct 2026 15:29:15 +0530
Message-ID: <20261014100902.1215212-8-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261014100902.1215212-1-Vijendar.Mukunda@amd.com>
References: <20261014100902.1215212-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBD:EE_|SA3PR12MB9107:EE_
X-MS-Office365-Filtering-Correlation-Id: f7fc234e-193b-4fd7-234e-08df29db657e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 
	0HBy3rPeSBQPJIVakeNWf5pFEdqcxEp9FNdIrQTWZDfzj/juAGtFUUBTpEHCuyMeYLhnoEuB3ltdKdvUvU7N3cUQQc1ZkhmQ4nA9UOlnPs229xvdOHrNNWABs87gdMf9Cjj5tX1DfytCACeySwoBeFs5EJ1vDQYolLcUfoBs10z9Vj9ZpIw+AV1MHhEXeOgRojAoqZYhQ8d914+AbKYiVgcx987+wbEjiiUnWxzW8gCLD/kDAFaDlR7wvxcCtCDv5LfqQfzDymm9t727pQPZz0wd+YIw6jJCvgmvlrBgdfnzzuNa08Br41DzhOpKEAB93oZdmKLvL4RJQIb/hvSD5P23GjoupKpr02MIBa7C4KoISnoykOe/8W8TIhvUP69f8QwPI7TksdUoV0UwBdZi6SDGnqjA5eLRAptqKpNzG7lH6N6F/1JRQQu4XAol/7MReR0ZEO3uy3RM2IMPF7Y46qUZxbjR1TdrXTmWVC7rTtD+RoHNUg25qSMxuW5nSkHElewoapNePDMUxZOO7nUIHJM495Ig+sZX3tRzAKhgVvBsh7mb9G0hZCiqL+6SSXyGO/bBpmkm8yS6lbqD/6yEbewtSWvwmVLdlVPvMyXA8YHNkW2Qb4REW22L/Al+ha1bb3Bdf13Rg8P4mYmGc1gvnqb4SS7xASSYPZkvkeHbIrdQm3XSKkfdFRgIclcW+nUdpxlO84v6jgJ5vkbGs0hpbA==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	vFEGteFQqmpOqjnqRyXJN4GMiyf4Z5xSpLcdrh3JsjV+h20SU7KsW8AIzLP0TLaqKNheqfxoAKh0reCwfUrJ7ijfjteAXyA1pJ+UUZDGrQU8/XogPPv6UG03E+zCegUjabQZVGogQ6qR8f/+235FiAsq62gH1m+kGZpiPrIq9PV1Th9t3NAd0hmG2k7lKzCd8gDH1SFJvXYoAyrqXaU6ustq1CLh9UlG66jWinFFjTfGWnj4JQsNmAUZRY7rtapmZNVHrwY3vAqB9OEZD6gFf1czTijYnbssWEBFUrofnMW28+mdMgkVE4hL3iDz7Lhs7vvieYBoxM36KwI3zUejygtk/pGNlGzWM3PHg6PXCWReMFYBXbYLPvZ+A7CnT87lg3gAWtE0fkrZIDvK6avF5y82Gjt/GDevIV+cApzAZYOXJZliUZt1kIqmbBiFAtZc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 10:10:38.6850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 f7fc234e-193b-4fd7-234e-08df29db657e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN3PEPF00022BBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9107
Message-ID-Hash: UDWZEJRILXKZTEKS74SLNEIQU4XUGPU6
X-Message-ID-Hash: UDWZEJRILXKZTEKS74SLNEIQU4XUGPU6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UDWZEJRILXKZTEKS74SLNEIQU4XUGPU6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

ACP7.B/7.F platforms expose a PDM controller selection via the
acp-audio-ep-port ACPI _DSD property. struct amd_pdm_pdata carries
this selection and is required by multiple machine driver variants -
the legacy (non-DSP) and SOF stacks - for both I2S and SoundWire
paths.

Currently the struct lives in soc_amd_sdw_common.h, which is
SoundWire-specific, making it unavailable to I2S machine drivers
without an inappropriate header dependency.

Add acp-mach-common.h as a minimal header for types shared across all
AMD ACP machine drivers. Move struct amd_pdm_pdata there and retain
an #include of it in soc_amd_sdw_common.h so that no call sites
require modification.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-mach-common.h    | 25 +++++++++++++++++++++++++
 sound/soc/amd/acp/soc_amd_sdw_common.h | 14 +-------------
 2 files changed, 26 insertions(+), 13 deletions(-)
 create mode 100644 sound/soc/amd/acp/acp-mach-common.h

diff --git a/sound/soc/amd/acp/acp-mach-common.h b/sound/soc/amd/acp/acp-mach-common.h
new file mode 100644
index 0000000000000..a2cb25be6bf8f
--- /dev/null
+++ b/sound/soc/amd/acp/acp-mach-common.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *  Copyright (c) 2026 Advanced Micro Devices, Inc. All rights reserved
+ */
+/*
+ * acp-mach-common.h - Structures shared across all AMD ACP machine drivers
+ *                     (I2S, SoundWire, and SOF paths).
+ */
+
+#ifndef __ACP_MACH_COMMON_H
+#define __ACP_MACH_COMMON_H
+
+/**
+ * struct amd_pdm_pdata - PDM controller platform data passed via mach->pdata
+ * @pdm_sel: active PDM controller (ACP7X_PDM_DMIC0 or ACP7X_PDM_DMIC1),
+ *           non-zero when a PDM controller was identified via ACPI _DSD for
+ *           ACP7.B/7.F platforms.
+ *
+ * Passed via mach->pdata by machine select logic to both I2S and SoundWire
+ * machine drivers so each can configure the correct DMIC DAI link.
+ */
+struct amd_pdm_pdata {
+	unsigned int pdm_sel;
+};
+
+#endif /* __ACP_MACH_COMMON_H */
diff --git a/sound/soc/amd/acp/soc_amd_sdw_common.h b/sound/soc/amd/acp/soc_amd_sdw_common.h
index 17e4e97fb3d1d..034c9ab6e4ea6 100644
--- a/sound/soc/amd/acp/soc_amd_sdw_common.h
+++ b/sound/soc/amd/acp/soc_amd_sdw_common.h
@@ -13,6 +13,7 @@
 #include <linux/types.h>
 #include <sound/soc.h>
 #include <sound/soc_sdw_utils.h>
+#include "acp-mach-common.h"
 
 #define ACP63_SDW_MAX_CPU_DAIS		8
 #define ACP63_SDW_MAX_LINKS		2
@@ -23,19 +24,6 @@
 #define ACP71_PCI_REV			0x71
 #define ACP72_PCI_REV			0x72
 
-/**
- * struct amd_pdm_pdata - platform data passed via mach->pdata to machine driver
- * @pdm_sel: active PDM controller (ACP7X_PDM_DMIC0 or ACP7X_PDM_DMIC1),
- *           non-zero when a PDM controller was identified via ACPI _DSD
- *
- * Carries the PDM controller selection for ACP7.B/7.F platforms, derived
- * from the acp-audio-ep-port ACPI _DSD property and passed via mach->pdata
- * to the machine driver.
- */
-struct amd_pdm_pdata {
-	unsigned int pdm_sel;
-};
-
 #define SOC_JACK_JDSRC(quirk)		((quirk) & GENMASK(3, 0))
 #define ASOC_SDW_FOUR_SPK		BIT(4)
 #define ASOC_SDW_ACP_DMIC		BIT(5)
-- 
2.48.1

