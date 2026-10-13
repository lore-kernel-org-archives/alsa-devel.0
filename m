Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D67CC6B12
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:51:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F4211601FD;
	Tue, 13 Oct 2026 17:51:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F4211601FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791906701;
	bh=DC6kP+RHKYVexG3fLNcU8ST5fmLGbQbaemeul8omra8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=kGpWyiFtZMMjUC42Nbte3+6PHoC00eHXsA+u/OSpk/CWzIJOf5wKaGz6pcQ1UrARP
	 YU0W8BA0RAMICr20Btz+hszdfPef5sVohOHUSTxF2oKQnugImsQe4XZtryYkgcXtHo
	 OG27BDc7SMUSgxIqbjEtjugzvVTpqGra8OC1OIF8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F080AF80815; Tue, 13 Oct 2026 17:48:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 10070F8085E;
	Tue, 13 Oct 2026 17:48:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B28A6F80764; Tue, 13 Oct 2026 17:48:43 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.31
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791906521;
	b=Pm1eIzOXJMtO8NY4zzyysmW2YBoFRh6tO9FToR1H9iRMibVp7DKgFLwfM8wUWYJr0+MA
	 J6SE23sGjIHIukoL4jlRN03XcCfG3v/wmcG+DRHtbCKTmjwbBp5FgK5U/USBsbc485qJ+
	 zRZOxjRgO6pYh5qEx0pP8Dr2ZPaGEE2POmCduF0fqvtvee3WB+1E0M67j++rCaM0FTeKa
	 G09sLUHyTvl9ZjnG2CkFGUoaXCPnZG/efnjK2myaFOc3Bp/oeuINHBMIKzDyNPM035ByO
	 0juNsPkVVbDQhYUSC3VsHu1QWD0b6hmkoY0+TZiOuu8ZFM75/XJIPmjFdM6kr4Ea1Kg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791906521;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=DC6kP+RHKYVexG3fLNcU8ST5fmLGbQbaemeul8omra8=;
	b=erbiWblufJXf7+muwNzg5QzBW6V07dewzXI9Td5TRLThtTBe7uxo5CtCoO1oHDAffdks
	 ClunvGqAHRNWs74z2zxgrRJfAZ+B/9LIpNmOigfZ2TF+qe+i45LMUaVDA62fwDowtIHcE
	 U5N+5uzlUatUSMJK3pfYPQyVbqFUws30CwWIG4LVK7Hnk4TawR5VzghzH7/rYz5DkaTww
	 c5McuXd2h5kwr8RbIZWu2dZAQWSf6NXcF/728xyEqq5++UtpjkZ2Q6CRrMY41prWiVG3y
	 UM2q53kMP7drGz3k0TMohZayFVMdLKdNl7bBoNeHAhNpTfWBy9XmucrsXFNAkUZOQeg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=juINahJD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.31
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010031.outbound.protection.outlook.com [52.101.46.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EC3AFF805FC;
	Tue, 13 Oct 2026 17:48:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC3AFF805FC
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=juINahJD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9/e2bawC7xCqCxJ1w077Zmmq02Gs+EX+9W0A9jLwfguOW+axbA6htvb/6wa46XRwtr21GHiQ2dDZwZ4rJi2HRmdeLJo/aIdw6auux5ZBZcj41vrtmjuNajnD28rSCuKRg0jh3b3ap/f8c9qoePEYReWJp3fNfubDAkC2W+2Ycxc/bosZYSe33qoqor1cNAGsk7eMlGJ06p/Rxdoe6FCwzwZOrMnZGjPdROq9uyfJ6Qe7zdnSzr30lc2/JK9Bo1WlAxt9NDDKFWTedS6bWRYS2yYPdB5ulzHdPq3hNlu0pKDumSiU4oeMhOpmveGSE/Gl5ys4TrvslYfZcs76gEQuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxDBVLY7cNB42NcVSbhgSajcqqWPAp0q3/tygryuFvY=;
 b=ZFVQecW4dwCYbJjgwp4AZKC69vNcFjxJA+4Aky7zAimY+7IEo2Z1CCwRL4tgSa4/1/epXHVaKb+Gp4rdGX5OsjuP6fm0YBqynX8ZqCNM2ymSVh9FDFh+HGN/uw7VGf1mau6MQ2afLnuQnaysTXf9lXP5JSVbMpjQK0CAgDaLyPu3iLHtH49wzEQrHauDh8ugzKlDKsOYBY7ZV47b3y2a86nk1NEb2/MyeBiVQW/epd899NIWO8XH/3ZpK2kMpeGBihLTz+xcKKrrq5sDA8IGyBYsAQqQHF+Wu/OGZlHygV/3rncZlO5zBIERNNgVQGBpuywzoQuhqcbYwtS9mcc8bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxDBVLY7cNB42NcVSbhgSajcqqWPAp0q3/tygryuFvY=;
 b=juINahJDSnPRtyhsE81ktmVQ1nrvO7xqwQ3FhiOkUQ6HoU5vQtYe55Zu3XTmVrLSOBYB6S3OJ33vVn+n47ZtoSkqPYm42GgPdCSdCH9O4+B1BlsaXNAIGUp9CaAwwaqVA2RV2aIHCLoh73/f+0cmxer1d/cNllPVQ0URsrB/KOs=
Received: from BLAPR05CA0009.namprd05.prod.outlook.com (2603:10b6:208:36e::16)
 by MN6PR12MB8544.namprd12.prod.outlook.com (2603:10b6:208:47f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 15:48:18 +0000
Received: from BN2PEPF0000A804.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::16) by BLAPR05CA0009.outlook.office365.com
 (2603:10b6:208:36e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 15:48:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A804.mail.protection.outlook.com (10.167.245.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 15:48:17 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 10:48:09 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Tue, 13 Oct 2026 10:48:05 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <yung-chuan.liao@linux.intel.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<Vijendar.Mukunda@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>
Subject: [PATCH 7/9] ASoC: amd: acp: add acp-mach-common.h for shared machine
 driver types
Date: Tue, 13 Oct 2026 21:11:39 +0530
Message-ID: <20261013154644.3788064-8-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261013154644.3788064-1-Vijendar.Mukunda@amd.com>
References: <20261013154644.3788064-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A804:EE_|MN6PR12MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f04c99-3699-4b33-efe1-08df29416660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|11063799006|56012099006|22082099003|18002099003|6133799003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	fGfjD++fYgmcRabvKpH50lUC+/Vno97VNJevzKwqJUttl2WoVuHFlOj+WYc6BVj8S0SNmmdOqgf3fYts3kHvepZQq5OLwFKlN2VlyilPtISGFE0tB1BkvXNeTvAysAt3BZssY8Qw6Ax6/7rEkGb1NcCyUFlRvPOO8nKJAR8FYS/eFdNHIcbUFJwM6DmtLUuJIdYbymPo7UAgXab8nxvCynvymnUYdV/ODt/yk5IplDaKHm4uyguoFy2h+uOnqufozkCgs3an+dNhwlNkz2RcYdqTlNtA/TC4UEHqdrNjuaSujZ9f4KDLKfmbugTX3JVtRc8jbOtuIPHZwBaXahMqKIdbOBfgTGzn16ViR1FfhNviKxJDVQoaPCEkb9rU7YlvRkB7vmGTO5bL4aAXDzzBn2b0cAf1d5UOUHTqWXz53ZxPAkhNYIg+4AD3GGbCTDp90O33ZePoLCDluaF3eiK5bhmzLJG22oLoBZKjubq7ruE2MNcjLJLAEYRP0A35bdWRNqDA1QaZR0yeUDvj4KRCYLPW/jOBdDNzhQV5PLk/QVMYxFZFLRB0nH0FLlrh+KdiZQ5HY3bZ1VGugV84aY4wLrRGG3WFcl2XwdK+2SBQWX0jSTLysSs5KvQX2JALUy0od2wvcRNqjRlY8c/lWAClvyRCSS1MmLo5ANwGan9pkI56aE+4zPlippoWFoz16BvCOChUORsGZvNEQEn4RxtZgA==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	sIWUmu8vjLgYotc+SjTyEZp7QLMk951y4pO0wIP2zAjw/PkxLVjz/9CRCZxjf++FdTN/37uK7h0e2c4J6ZOJ3qGhe6Pc6DuRiA5HgIL5zkJt2S+nFBClqe3biMs+PZ4uEsRaaEmiGzY3UPF+ZjsfY/bB+9Pyj4AvGvJJpfjHWy0LmRTVFkREIrBld09mwP6xS48OcIhVKIXICmP0uUu6GV7lrLHNZJY9KGcj7DPOa8EFmpQD57xRaoJr6DeSADtB3lg6UTkTFf+NOvEbMCEsKaCFiT9ymSojSx/AeNLNxV3V0ChtPt6YN3ZPvfa7TtjAx7iVnZFuN4SONOQ8lXaBqlY/IntfWdzGTnCqSj9C8R5EjIucP4wbvz1Zd8tWBuqsBBLLY10TgmW29PG3iVfGke8YIoep4dsDD1KlgcysCdOi7nXZixKEpm53FMMtpXsh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 15:48:17.6004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 56f04c99-3699-4b33-efe1-08df29416660
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN2PEPF0000A804.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8544
Message-ID-Hash: F6R3E7YOOO5EGIJFETJVKZQCJG7LDNJL
X-Message-ID-Hash: F6R3E7YOOO5EGIJFETJVKZQCJG7LDNJL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/F6R3E7YOOO5EGIJFETJVKZQCJG7LDNJL/>
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

