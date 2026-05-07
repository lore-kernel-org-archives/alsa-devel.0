Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420EDCD343F
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2026 18:15:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6B45B601C6;
	Thu,  7 May 2026 20:15:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6B45B601C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778177727;
	bh=GtFC48xK4z/EYkdZrNhVwawSR6MV4VgMVNQreduUafA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=avOXweXPu+7pA6u6B2tLhdy6CiClLklqhNQocTDI7TYzv7H/bZJnSmGZb89uvZ55X
	 jWmmZ7SMPWgE/EKZijmc1CGQj43MQYsNduTBlFfsfVLvB2hTw30WW3RAi+MtoM2dkz
	 Jx+OWhTtuYA+IBVe5beQP3ghgZgEwmJ4PlTd7AQ0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C2E84F8069A; Thu,  7 May 2026 20:13:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5B2BCF8068A;
	Thu,  7 May 2026 20:13:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CBEA5F80654; Thu,  7 May 2026 20:13:40 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013019.outbound.protection.outlook.com
 [40.93.201.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 514FFF805FB
	for <alsa-devel@alsa-project.org>; Thu,  7 May 2026 20:13:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 514FFF805FB
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=1gDufLZg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PnHaeoIB5csHtBbC2dwfnRlYO8BRwtXnlUYfUXlV9XILM0PkQWOoyNXJh4M2GU0JNHM+/Hbxk0L7b/wYXcttMjyueA2ZvBAy9TP5F6R+LDDrajnGlZ7XilIfIE3p+gBfEr81eMQVjQhYdbQ5H00CrQzWAbKc85irwrU9vnMNkb8j2tn4HudfktyUIBUC/FNQaXcW8DE2d7GuWFUiMqqkPvtyeTK8HYwlEaU4QBQHi6/hCqAionE+wOHBjysYLp61/n17G1lqgtwLKwbwyf4UwraGdQS4IIlS9uN0E0XuX4kxdetn9B62u8Ihfsjg9r3FK3dD8jXu+sXgknxVCe1qzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJAydrVUKXgt6AqeHnKIWzgxJP88cjkvuFKSIriyRj0=;
 b=IQloOz10l6sKcKLo/lvKAIpOY0QjJFN8eD3aze/oirV2SIRo8AhMQLwdAwl+d3tZgen7OX92Cnr6u6J/urpk5ltOzuu1/Z9/wUSu7lkftJe8lnIE9z4mTanIXciCEafh2yNMhITD/CS9fAeGYs7m3ZxWPRmcvfR31FpvD0B9znAMsWnQGI2I80ufG/QIYN6p8VEo9CBjDHVV/DYZQR55vhbGv0TaD94KqwOCRdgCFgkisSz0d0L4YEHcyNfnJxnk2ehCk7D5VEVVYtilzp6qnEcgnTQ0j5Z7QMlS+L6zPHAsOjz5XK3sjYtuyRzhh9mqiA/duWK4CAij99Zu4XbjoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJAydrVUKXgt6AqeHnKIWzgxJP88cjkvuFKSIriyRj0=;
 b=1gDufLZgJIAYB68SHdbjK+8x1PVwJyn4O6pElU5NCQLe68mfGb1hje+jyAEDysfpT4JSGzlaHhaPFjCKoyOjS2Lg/CWth2jyUOPGh48g5MH7cnNpZfTQrRLx6OlhsScxaKdUC8b0ZNIdTIB9NAB+BMYySsz7zKxQmWQQ8D+9lRM=
Received: from BLAPR05CA0026.namprd05.prod.outlook.com (2603:10b6:208:335::8)
 by IA1PR12MB6601.namprd12.prod.outlook.com (2603:10b6:208:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Thu, 7 May
 2026 18:13:27 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:335:cafe::f) by BLAPR05CA0026.outlook.office365.com
 (2603:10b6:208:335::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.7 via Frontend Transport; Thu, 7
 May 2026 18:13:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 18:13:25 +0000
Received: from vijendar-linux.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 13:13:20 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <mario.limonciello@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH 4/5] ASoC: amd: enable acp7.x drivers build
Date: Thu, 7 May 2026 23:41:32 +0530
Message-ID: <20260507181251.20594-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260507181251.20594-1-Vijendar.Mukunda@amd.com>
References: <20260507181251.20594-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|IA1PR12MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: f2ac89aa-a642-41ba-5b2b-08deac6454e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	9OoAU4ayuCGABJGW6Wgm3pUwZeZVfwXV7APQXvUL3jUXEcv/c04wRj2vhj206QHy32gpJ02xghep2UXrDdM3qGOT5d93B9LmSrGaifuJ4CuxoT7UUZlAYzEvz3hQAfgQBmbi2FVLE6Kc6iBgnVAK4JJPxHKDDk/aRKwBCsevXHTBLPSH7+BFU75/ztmOhmbWdqxp95+wcUPwREgKq3ne8Cy+qt6VV+SaYZ51KAkMC1IP0YtmgPCNAqVTORnKJIGg3tqdE0Xm62mQ2jO9dhmDHuBtmXTinTVmUSFmvgsuOMg1rn/L4Ozl2QMyilCV+xiN3z3BvP/Ci2Pq69faVgkRhJiyqSjn1uwqRfury6+RWf0Ivt0CyMCyYFpOLUQ9nr8Lz06E1DVQ8q+JA33ShqfJiVNLzWszeD97/4AsPigajfjKG/+oPVvd6YFbigTbwOEdVMkG2vPhZG6ZNmtJOXC/p+jn9bhviE4G4Nm2nKw1t6fb6inSuQ48fvwaZLp/4eMVze2LM3AMeK+kSwucq42aCeV345593Mj7csijr28rhU9sH+mjeU2510lj59jGxJUeQwJVEAJDKMtCi5/ijFULdqF871QcVh3WyATJp8qWJxNa1BFcFfGyOEBJdxF9GnMC1SsRShHDOt6MHxQjVgP5Hj+QsEndCatWNfPcniMxFSgrIi5weTdIV8PZYEQIQSDNCyvEj/BQ727LTHAu/1HjsAZ2x//1QyO8N1KjSO4BDvA=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	aG0HBhXQascgLJPrD4ZGE8T2TcQgxbjgq6kiI5slVYGWR+JbhrOULWx1C8bjXAXjAisFvgT1t2jXpiUNPSjDL7TRXnpXC79Tn/o+or//jOkTdLm8VTIzLedLaNd3GpUyWtbHrMEJ13g11OpfKOimD17oyuCEk6ITySrxikr9FMsnA6iTWg6H4vAEF+F/1MAmK26/zupgcc7mHH6X3tWOeQHYu385VHScH/l11Z3dSNbdZdHyKa9dkbN6RK523V/4rSwTuYgi1hCIxTE1Jvy1YeMVPwC0ZbflU8SHjOfKZ9nNg4xQt3sGNBVpSnla3wO0mvWJ0Yw4UCC5yAHcYE7SDIZvIoqwcetaFdSmQOrYhSJg0dcqLzFKoHlogU6QVbqs9cYLSAERuhWQdR6ZaSV0zPuH3zaBJVQ3WyBpKPlYKCrh1PdOz83xVEkMh5oksrDf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 18:13:25.3509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 f2ac89aa-a642-41ba-5b2b-08deac6454e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6601
Message-ID-Hash: 55NVAO4HW4ZQ76Z5C4RH7N5K6CRKHVBH
X-Message-ID-Hash: 55NVAO4HW4ZQ76Z5C4RH7N5K6CRKHVBH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/55NVAO4HW4ZQ76Z5C4RH7N5K6CRKHVBH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

ACP7.x drivers can be built by selecting necessary
kernel config option.
The patch enables build support of the same.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/Kconfig        | 10 ++++++++++
 sound/soc/amd/Makefile       |  1 +
 sound/soc/amd/acp7x/Makefile |  5 +++++
 3 files changed, 16 insertions(+)
 create mode 100644 sound/soc/amd/acp7x/Makefile

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 53139766fafb..9f4f1f4ac3f8 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -174,5 +174,15 @@ config SND_SOC_AMD_PS_MACH
           Say m if you have such a device.
           If unsure select "N".
 
+config SND_SOC_AMD_ACP7X
+        tristate "AMD Audio Coprocessor-v7.x support"
+        depends on X86 && PCI && ACPI
+        help
+	  This option enables Audio Coprocessor i.e ACP7.x
+	  variants support(ACP7.D/7.E/7.F). By enabling this flag build
+	  will be triggered for ACP PCI driver.
+	  Say m if you have such a device.
+	  If unsure select "N".
+
 endif
 endmenu
diff --git a/sound/soc/amd/Makefile b/sound/soc/amd/Makefile
index 23b25ff0d800..ef2b36d47705 100644
--- a/sound/soc/amd/Makefile
+++ b/sound/soc/amd/Makefile
@@ -18,3 +18,4 @@ obj-$(CONFIG_SND_SOC_AMD_ACP6x) += yc/
 obj-$(CONFIG_SND_AMD_ACP_CONFIG) += acp/
 obj-$(CONFIG_SND_AMD_ACP_CONFIG) += snd-acp-config.o
 obj-$(CONFIG_SND_SOC_AMD_PS) += ps/
+obj-$(CONFIG_SND_SOC_AMD_ACP7X) += acp7x/
diff --git a/sound/soc/amd/acp7x/Makefile b/sound/soc/amd/acp7x/Makefile
new file mode 100644
index 000000000000..9426e3b47c08
--- /dev/null
+++ b/sound/soc/amd/acp7x/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# ACP7.x variants platform Support
+snd-pci-acp7x-y := pci-acp7x.o acp7x-common.o
+
+obj-$(CONFIG_SND_SOC_AMD_ACP7X) += snd-pci-acp7x.o
-- 
2.45.2

