Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EC6CC6B03
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:07:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 53E2360255;
	Tue, 13 Oct 2026 12:07:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 53E2360255
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791886041;
	bh=+Drp3wLreGAjMlNKcZzp7rjnb4xVDdA1enVC3IjDY0Y=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=c9j1otUrUZplK84p1kWBg0ImSVaH25CnhJVQC0OHRQ4ObRSp8b6hYDV40VlEeW2A7
	 Ctn1Y9RlNmoID0RktjkoduYVBcEU6A4QLF6ClUUhWyPcuMhuFE1T48jWO1ujAv9RZA
	 5ObiuNXeRmZibKT7Q1JfntQ7dUekkzp/vR29SV9g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A72FBF80718; Tue, 13 Oct 2026 12:05:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9BFF5F80710;
	Tue, 13 Oct 2026 12:05:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 540F6F80611; Tue, 13 Oct 2026 12:05:16 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.61
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791885896;
	b=ac9iOWJB8tiUaRdN7Hd23piPd3FCeYzRl9zTea6S20s2vPOz9AMoz34Urd4A2UzC+YpC
	 JHKWsFjmzziR3vkWnc80rIgpayiJJYIrEImKj4bdyJTernCAxUl1sLgwDoj8AfQTjJhLA
	 CWMm0CLpHnJ5DPQTHmNHGSeEBT2r90jIyRirJ/bM8P4IlemrxNdSYAxQg2wMHDdq7w8WG
	 QkG4uBc1uGax7hj/oYg756irFf4fh/pcshJ7Hr0Zho0I9iUTedTWKiooF7hETTkTJMIzv
	 /5JZ4V0wanxC+a6o8CzsYjsLKn3gdBKPBmnhHI5jlU5D+ZT9wH6i9ljWNDxrgiF+7sg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791885896;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+Drp3wLreGAjMlNKcZzp7rjnb4xVDdA1enVC3IjDY0Y=;
	b=lFtsG6cz477uFy5XPF/396RkUsAbMh3Ypm1Bl8aYfkzXVyZhg8GrWdYGwydLa6GUw/jm
	 PdmvJHQbbZhRHdms4tmS+lD7VBifMkSsEWrmB3gbT/HVw+CW+NV0ZpGGzG5fsSVmvITLc
	 OhrKXHFOL37NFGNeOBhQqxFL+IiYau3wonH5MXbLYZYC/1tZXnUDQgrpEEPeWAaCP7K5D
	 AOfymr5ves/Wh4QRPng1t/+gG6hYwmeidspEfzEx7MtK4hHa1Dp/V4qhELBV84Tpg43tF
	 Ip9XPHpFJ3Uy7FqZgTAKescMhP5QMPnJf8eC3tdQ+Xor3uBGxJMUlFeNB+z/2uKMg/w==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=f2NnDax2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.61
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010061.outbound.protection.outlook.com
 [52.101.193.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 44433F8060A
	for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2026 12:04:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44433F8060A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=f2NnDax2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcqZ+HZ1xyXfwwqLShkJx8RBxNAVz9t4rmZkdbEFSuoaPI9He3K7GaKfejxgyr5Nl6Bmw8yfoWcov8F0J0XkksLIbsXAYLeqoUlxHkrjl6ZN0J6LB0iDv/1EcbUvxJGixxyb60HDGqwETxeMlD23Zm4e2g0xWBsRiRtMGnk06FemFbD1YiX27kylJuXX9Rcv5FB8ykrpz/RvKJaxHSQVkd74rr3Wsne5HxFdTntfH6vmVa91dsILBFnQolPExedKWaABdNl5gQJizUBXSOFrXHcRC+4NQXvIiw31qEqMO9Fuj3a+z4sWT6fnpIyOIWzV+OfTQlS37UkeydkOyOifOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gusLrHr4G99vPsd6MdJDeZ4JYPmtvV+/ud8+aXTWcVY=;
 b=lPBjl+3Qf9hCvxMmL4Opopd+Lmf1fP5A4VpG6YNUXVqcCpyywVeuX3R+FZeHkQcpxEC/ValVlFQ+Hp4rkNZ9dcjrhRs2d8K9UinQCQvwzxaHW+kfGwRR6w/5DuPBrvuDNQtfQbumrYg7kbj/QbYERtGerbmKsBYlRxF65RuluAg1Ip2i2s0CsfyAh+mwxfhvGlw1W+WCVQNdF2e1iDWZ6UgE0ZLQvSqogW4kGg5b4CidIk9kOu8DK7K8yJAglPSZgtqIoAAT2Gn9QR6tM7Hpe+CRqHpEH2RLhUpoXhBwDxa0Dmv0vPQ2t9nKUKo/2DjK6LptIyAlO0U3YNVujLGWJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gusLrHr4G99vPsd6MdJDeZ4JYPmtvV+/ud8+aXTWcVY=;
 b=f2NnDax2WG4eR6ZbJQ+LMWfVcYvsJgJQSzgjhm8uqgHPwdQzqO9u+8ZjUqo8o14yg6bR4+kgu87GWesbKczhwBDLLuubwaC1NHLai8OTttYSGSjXxGPdPrdeCYJp9KMHsG5d5bVO+a2DqTuH3271cSxhgYvuEuC8oEWiD+/yhao=
Received: from CYXP220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:ee::13)
 by SA5PPFCB4F033D6.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 10:04:41 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:930:ee:cafe::7e) by CYXP220CA0010.outlook.office365.com
 (2603:10b6:930:ee::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 10:04:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 10:04:40 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 05:04:34 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Tue, 13 Oct 2026 05:04:31 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<Vijendar.Mukunda@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2 9/9] soundwire: amd: extract shared functions into
 amd_manager_common.c
Date: Tue, 13 Oct 2026 15:28:55 +0530
Message-ID: <20261013100306.2921771-10-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261013100306.2921771-1-Vijendar.Mukunda@amd.com>
References: <20261013100306.2921771-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|SA5PPFCB4F033D6:EE_
X-MS-Office365-Filtering-Correlation-Id: 51359764-8b7f-486e-1deb-08df291165d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|6133799003|18002099003|22082099003|10067099003|11063799006|261009223027099003|261009223327099003|261009221727099003|261009221227099003|261009220027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	3WoALtJBHB8qMCDAeWeUAHNY2I4a2uut7BzVNR2JvWup2EcVi2Rm45VFO6dKPXSh3hTOXS4cUqRTt2zieXGQG+TOGoXZ2n3AvJswWTcVQZyZhk3vhwQRSDumIUzFhDD/e7dlX3Ni5O8loSlqyyNPzAuP2qpm3kdpc8ssTELNBL9pVdzzBdXMlYQBapoGau9CED1qnW5lRv5JNB/uM3cuobseMBjzmHj208rHLByF2laAZ2s9kNV1PVcRmOkOeouCJ6C0vvJva7MkvoRAR757fkSKnKBOdB2l3exQwnaNMJdPc8l6rb1adjQwjGnEv6aDztImlh9hkQu1xR0P4Enay3tZvuu5f00E/4pOEKGRoBFUk4gtbw5x4aF2/MdbHTVzTRSZRxRDbVPb853ggDhnFt0w6rsESn5ArMjMlUbUPyfkz8t5UgnTx/4SG4yYLMUTWdWj+NIsLEXYTrgySwZRCDMx+3kvY26oBtNgEll041vAnCAXTWYVy+rVShgmg0qBRsFhhqecEWW6XJ2nQo4JWwOR7TpUTNfj62QCRa5m2LBA00WI39I5eswYXN/k/vlRuOvMYyMtw7ksTEyEe8gdtCj0Fs7s4MohsQkPJ5SfOm9eIgJqZ9i3GNmb7rXvonXy+fNxFG1dS95J5o0JTEzUW/42+tm1ltkxagBG8YforJeEVi0qViSe23/8L1jXaquVEq+TEa8An7FAsViZOj37+g==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(261009223027099003)(261009223327099003)(261009221727099003)(261009221227099003)(261009220027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	D+taaLvrJpMoCcLthfSbw8u4Y/i21fQl5hRp5ZOZvtOmFIiIsSbM5Szpy1MyDNJWA0qxrac2CJb/x6A6k1N81XsOEyfeYzKmX3lcwyCqniZow0AVezC0rurFjsen01hsGkZijwpDkrtzs6rLp1YGh2StExK7USvxjKxVGDZDNH8MIP1E8BAshX1zUmyoIZBmX62UJX56JcsfsPK6gB19ilT+BLeD9fLqffaNVnyPwZHaqv+Sk51GDgbdeZTJpdMW6os/gAAwrL/UReM6V35ofzga81U1I4KtmoE2aNWz77CgeX2YheIgt1gmuKlgMpSNG4YdaR+UWCAc1FHV1Vb8T3i80D4sgZpm9yoiHnjbaVc2PB1uWQHhuUMbCgbk5f5X01HrMF1by+C5QX9LHErm1viycjAIkDG/6dBEWY3bamY0FMigbknO2Wvu6txtHPpX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 10:04:40.8532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 51359764-8b7f-486e-1deb-08df291165d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCB4F033D6
Message-ID-Hash: 66FMQSLLYH2AFGW42DOZ2FDXBWLXNV6B
X-Message-ID-Hash: 66FMQSLLYH2AFGW42DOZ2FDXBWLXNV6B
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/66FMQSLLYH2AFGW42DOZ2FDXBWLXNV6B/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Move the revision-independent amd_sdw_*() functions out of
amd_manager.c into a new amd_manager_common.c. This covers message
transfer helpers, ping and slave-status processing, DAI ops and
registration, the clock-stop sequence, PM prepare and
suspend/resume thin wrappers, and the platform_driver infrastructure.

Rename amd_manager.c to amd_acp63_manager.c now that it contains
only the amd_acp63_*() register-level functions, the amd_acp63_hw_ops
table and amd_sdw_hw_init_ops(). Update the Makefile to build
amd_manager_common.o and amd_acp63_manager.o.

Add cross-file prototypes to amd_manager.h for symbols each file
references in the other. Drop static from amd_acp63_sdw_ops,
amd_acp63_sdw_port_ops, amd_acp63_sdw_compute_params,
amd_acp63_sdw_irq_thread, amd_acp63_sdw_update_slave_status_work
and amd_sdw_hw_init_ops, which amd_manager_common.c now calls.

Move the revision-specific register-map tables (struct sdw_manager_dp_reg,
the acp63/acp70 dp_reg arrays and sdw_manager_reg_mask_array) from
amd_manager.h into amd_acp63_manager.c to avoid -Wunused-variable when
amd_manager_common.c includes the shared header.

No functional change.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/Makefile                    |   2 +-
 .../{amd_manager.c => amd_acp63_manager.c}    | 824 ++----------------
 drivers/soundwire/amd_manager.h               |  84 +-
 drivers/soundwire/amd_manager_common.c        | 773 ++++++++++++++++
 4 files changed, 867 insertions(+), 816 deletions(-)
 rename drivers/soundwire/{amd_manager.c => amd_acp63_manager.c} (56%)
 create mode 100644 drivers/soundwire/amd_manager_common.c

diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index e80a2c2cf3e7..1011599c20e7 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -20,7 +20,7 @@ soundwire-bus-y += irq.o
 endif
 
 #AMD driver
-soundwire-amd-y := amd_init.o amd_manager.o
+soundwire-amd-y := amd_init.o amd_manager_common.o amd_acp63_manager.o
 obj-$(CONFIG_SOUNDWIRE_AMD) += soundwire-amd.o
 
 #Cadence Objs
diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_acp63_manager.c
similarity index 56%
rename from drivers/soundwire/amd_manager.c
rename to drivers/soundwire/amd_acp63_manager.c
index 2e78d68cb37a..af59fb453df2 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_acp63_manager.c
@@ -1,12 +1,11 @@
 // SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 /*
- * SoundWire AMD Manager driver
+ * SoundWire AMD ACP6.3 (and compatible) Manager hardware ops
  *
- * Copyright 2023-24 Advanced Micro Devices, Inc.
+ * Copyright 2023-24, 2026 Advanced Micro Devices, Inc.
  */
 
 #include <linux/completion.h>
-#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/jiffies.h>
@@ -23,10 +22,76 @@
 #include "amd_init.h"
 #include "amd_manager.h"
 
-#define DRV_NAME "amd_sdw_manager"
-
 #define to_amd_sdw(b)	container_of(b, struct amd_sdw_manager, bus)
 
+struct sdw_manager_dp_reg {
+	u32 frame_fmt_reg;
+	u32 sample_int_reg;
+	u32 hctrl_dp0_reg;
+	u32 offset_reg;
+	u32 lane_ctrl_ch_en_reg;
+};
+
+/*
+ * SDW0 Manager instance registers  6 CPU DAI (3 TX & 3 RX Ports)
+ * whereas SDW1  Manager Instance registers 2 CPU DAI (one TX & one RX port)
+ * Below is the CPU DAI <->Manager port number mapping
+ * i.e SDW0 Pin0 -> port number 0 -> AUDIO0 TX
+ *     SDW0 Pin1 -> Port number 1 -> AUDIO1 TX
+ *     SDW0 Pin2 -> Port number 2 -> AUDIO2 TX
+ *     SDW0 Pin3 -> port number 3 -> AUDIO0 RX
+ *     SDW0 Pin4 -> Port number 4 -> AUDIO1 RX
+ *     SDW0 Pin5 -> Port number 5 -> AUDIO2 RX
+ *  Whereas for SDW1 instance
+ *  SDW1 Pin0 -> port number 0 -> AUDIO1 TX
+ *  SDW1 Pin1 -> Port number 1 -> AUDIO1 RX
+ *  Same mapping should be used for programming DMA controller registers in SoundWire DMA driver.
+ * i.e if AUDIO0 TX channel is selected then we need to use AUDIO0 TX registers for DMA programming
+ * in SoundWire DMA driver.
+ */
+
+static struct sdw_manager_dp_reg acp63_sdw0_dp_reg[AMD_ACP63_SDW0_MAX_DAI] =  {
+	{ACP_SW_AUDIO0_TX_FRAME_FORMAT, ACP_SW_AUDIO0_TX_SAMPLEINTERVAL, ACP_SW_AUDIO0_TX_HCTRL_DP0,
+	 ACP_SW_AUDIO0_TX_OFFSET_DP0, ACP_SW_AUDIO0_TX_CHANNEL_ENABLE_DP0},
+	{ACP_SW_AUDIO1_TX_FRAME_FORMAT, ACP_SW_AUDIO1_TX_SAMPLEINTERVAL, ACP_SW_AUDIO1_TX_HCTRL,
+	 ACP_SW_AUDIO1_TX_OFFSET, ACP_SW_AUDIO1_TX_CHANNEL_ENABLE_DP0},
+	{ACP_SW_AUDIO2_TX_FRAME_FORMAT, ACP_SW_AUDIO2_TX_SAMPLEINTERVAL, ACP_SW_AUDIO2_TX_HCTRL,
+	 ACP_SW_AUDIO2_TX_OFFSET, ACP_SW_AUDIO2_TX_CHANNEL_ENABLE_DP0},
+	{ACP_SW_AUDIO0_RX_FRAME_FORMAT, ACP_SW_AUDIO0_RX_SAMPLEINTERVAL, ACP_SW_AUDIO0_RX_HCTRL_DP0,
+	 ACP_SW_AUDIO0_RX_OFFSET_DP0, ACP_SW_AUDIO0_RX_CHANNEL_ENABLE_DP0},
+	{ACP_SW_AUDIO1_RX_FRAME_FORMAT, ACP_SW_AUDIO1_RX_SAMPLEINTERVAL, ACP_SW_AUDIO1_RX_HCTRL,
+	 ACP_SW_AUDIO1_RX_OFFSET, ACP_SW_AUDIO1_RX_CHANNEL_ENABLE_DP0},
+	{ACP_SW_AUDIO2_RX_FRAME_FORMAT, ACP_SW_AUDIO2_RX_SAMPLEINTERVAL, ACP_SW_AUDIO2_RX_HCTRL,
+	 ACP_SW_AUDIO2_RX_OFFSET, ACP_SW_AUDIO2_RX_CHANNEL_ENABLE_DP0},
+};
+
+static struct sdw_manager_dp_reg acp63_sdw1_dp_reg[AMD_ACP63_SDW1_MAX_DAI] =  {
+	{ACP_SW_AUDIO1_TX_FRAME_FORMAT, ACP_SW_AUDIO1_TX_SAMPLEINTERVAL, ACP_SW_AUDIO1_TX_HCTRL,
+	 ACP_SW_AUDIO1_TX_OFFSET, ACP_SW_AUDIO1_TX_CHANNEL_ENABLE_DP0},
+	{ACP_SW_AUDIO1_RX_FRAME_FORMAT, ACP_SW_AUDIO1_RX_SAMPLEINTERVAL, ACP_SW_AUDIO1_RX_HCTRL,
+	 ACP_SW_AUDIO1_RX_OFFSET, ACP_SW_AUDIO1_RX_CHANNEL_ENABLE_DP0}
+};
+
+static struct sdw_manager_dp_reg acp70_sdw_dp_reg[AMD_ACP70_SDW_MAX_DAI] =  {
+	{ACP_SW_AUDIO0_TX_FRAME_FORMAT, ACP_SW_AUDIO0_TX_SAMPLEINTERVAL, ACP_SW_AUDIO0_TX_HCTRL_DP0,
+	 ACP_SW_AUDIO0_TX_OFFSET_DP0, ACP_SW_AUDIO0_TX_CHANNEL_ENABLE_DP0},
+	{ACP_SW_AUDIO1_TX_FRAME_FORMAT, ACP_SW_AUDIO1_TX_SAMPLEINTERVAL, ACP_SW_AUDIO1_TX_HCTRL,
+	 ACP_SW_AUDIO1_TX_OFFSET, ACP_SW_AUDIO1_TX_CHANNEL_ENABLE_DP0},
+	{ACP_SW_AUDIO2_TX_FRAME_FORMAT, ACP_SW_AUDIO2_TX_SAMPLEINTERVAL, ACP_SW_AUDIO2_TX_HCTRL,
+	 ACP_SW_AUDIO2_TX_OFFSET, ACP_SW_AUDIO2_TX_CHANNEL_ENABLE_DP0},
+	{ACP_SW_AUDIO0_RX_FRAME_FORMAT, ACP_SW_AUDIO0_RX_SAMPLEINTERVAL, ACP_SW_AUDIO0_RX_HCTRL_DP0,
+	 ACP_SW_AUDIO0_RX_OFFSET_DP0, ACP_SW_AUDIO0_RX_CHANNEL_ENABLE_DP0},
+	{ACP_SW_AUDIO1_RX_FRAME_FORMAT, ACP_SW_AUDIO1_RX_SAMPLEINTERVAL, ACP_SW_AUDIO1_RX_HCTRL,
+	 ACP_SW_AUDIO1_RX_OFFSET, ACP_SW_AUDIO1_RX_CHANNEL_ENABLE_DP0},
+	{ACP_SW_AUDIO2_RX_FRAME_FORMAT, ACP_SW_AUDIO2_RX_SAMPLEINTERVAL, ACP_SW_AUDIO2_RX_HCTRL,
+	 ACP_SW_AUDIO2_RX_OFFSET, ACP_SW_AUDIO2_RX_CHANNEL_ENABLE_DP0},
+};
+
+static u32 sdw_manager_reg_mask_array[AMD_ACP63_SDW_MAX_MANAGER_COUNT] =  {
+		AMD_SDW0_EXT_INTR_MASK,
+		AMD_SDW1_EXT_INTR_MASK
+};
+
 static int amd_acp63_sdw_clk_init_ctrl(struct amd_sdw_manager *amd_manager)
 {
 	struct sdw_bus *bus = &amd_manager->bus;
@@ -219,32 +284,6 @@ static int amd_acp63_sdw_host_wake_enable(struct amd_sdw_manager *amd_manager, b
 	return 0;
 }
 
-static void amd_sdw_ctl_word_prep(u32 *lower_word, u32 *upper_word, struct sdw_msg *msg,
-				  int cmd_offset)
-{
-	u32 upper_data;
-	u32 lower_data = 0;
-	u16 addr;
-	u8 upper_addr, lower_addr;
-	u8 data = 0;
-
-	addr = msg->addr + cmd_offset;
-	upper_addr = (addr & 0xFF00) >> 8;
-	lower_addr = addr & 0xFF;
-
-	if (msg->flags == SDW_MSG_FLAG_WRITE)
-		data = msg->buf[cmd_offset];
-
-	upper_data = FIELD_PREP(AMD_SDW_MCP_CMD_DEV_ADDR, msg->dev_num);
-	upper_data |= FIELD_PREP(AMD_SDW_MCP_CMD_COMMAND, msg->flags + 2);
-	upper_data |= FIELD_PREP(AMD_SDW_MCP_CMD_REG_ADDR_HIGH, upper_addr);
-	lower_data |= FIELD_PREP(AMD_SDW_MCP_CMD_REG_ADDR_LOW, lower_addr);
-	lower_data |= FIELD_PREP(AMD_SDW_MCP_CMD_REG_DATA, data);
-
-	*upper_word = upper_data;
-	*lower_word = lower_data;
-}
-
 static int amd_acp63_sdw_send_cmd_get_resp(struct amd_sdw_manager *amd_manager, u32 lower_data,
 					   u32 upper_data, u64 *response)
 {
@@ -289,158 +328,6 @@ static int amd_acp63_sdw_send_cmd_get_resp(struct amd_sdw_manager *amd_manager,
 	return 0;
 }
 
-static enum sdw_command_response
-amd_program_scp_addr(struct amd_sdw_manager *amd_manager, struct sdw_msg *msg)
-{
-	struct sdw_msg scp_msg = {0};
-	u64 response_buf[2] = {0};
-	u32 upper_data = 0, lower_data = 0;
-	int index;
-
-	scp_msg.dev_num = msg->dev_num;
-	scp_msg.addr = SDW_SCP_ADDRPAGE1;
-	scp_msg.buf = &msg->addr_page1;
-	scp_msg.flags = SDW_MSG_FLAG_WRITE;
-	amd_sdw_ctl_word_prep(&lower_data, &upper_data, &scp_msg, 0);
-	if (acp_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data, &response_buf[0])) {
-		dev_err_ratelimited(amd_manager->dev,
-				    "SCP_addrpage command timeout for Slave %d\n", msg->dev_num);
-		return SDW_CMD_TIMEOUT;
-	}
-	scp_msg.addr = SDW_SCP_ADDRPAGE2;
-	scp_msg.buf = &msg->addr_page2;
-	amd_sdw_ctl_word_prep(&lower_data, &upper_data, &scp_msg, 0);
-	if (acp_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data, &response_buf[1])) {
-		dev_err_ratelimited(amd_manager->dev,
-				    "SCP_addrpage command timeout for Slave %d\n", msg->dev_num);
-		return SDW_CMD_TIMEOUT;
-	}
-
-	for (index = 0; index < 2; index++) {
-		if (!(response_buf[index] & AMD_SDW_MCP_RESP_ACK)) {
-			if (response_buf[index] & AMD_SDW_MCP_RESP_NACK) {
-				dev_err_ratelimited(amd_manager->dev,
-						    "SCP_addrpage NACKed for Slave %d\n",
-						    msg->dev_num);
-				return SDW_CMD_FAIL;
-			}
-			dev_dbg_ratelimited(amd_manager->dev, "SCP_addrpage ignored for Slave %d\n",
-					    msg->dev_num);
-			return SDW_CMD_IGNORED;
-		}
-	}
-	return SDW_CMD_OK;
-}
-
-static int amd_prep_msg(struct amd_sdw_manager *amd_manager, struct sdw_msg *msg)
-{
-	int ret;
-
-	if (msg->page) {
-		ret = amd_program_scp_addr(amd_manager, msg);
-		if (ret) {
-			msg->len = 0;
-			return ret;
-		}
-	}
-	switch (msg->flags) {
-	case SDW_MSG_FLAG_READ:
-	case SDW_MSG_FLAG_WRITE:
-		break;
-	default:
-		dev_err(amd_manager->dev, "Invalid msg cmd: %d\n", msg->flags);
-		return -EINVAL;
-	}
-	return 0;
-}
-
-static enum sdw_command_response amd_sdw_fill_msg_resp(struct amd_sdw_manager *amd_manager,
-						       struct sdw_msg *msg, u64 response,
-						       int offset)
-{
-	if (response & AMD_SDW_MCP_RESP_ACK) {
-		if (msg->flags == SDW_MSG_FLAG_READ)
-			msg->buf[offset] = FIELD_GET(AMD_SDW_MCP_RESP_RDATA, response);
-	} else {
-		if (response & AMD_SDW_MCP_RESP_NACK) {
-			dev_err_ratelimited(amd_manager->dev,
-					    "command response NACK received for Slave %d\n",
-					    msg->dev_num);
-			return SDW_CMD_FAIL;
-		}
-		dev_dbg_ratelimited(amd_manager->dev, "command is ignored for Slave %d\n",
-				    msg->dev_num);
-		return SDW_CMD_IGNORED;
-	}
-	return SDW_CMD_OK;
-}
-
-/* AMD SoundWire bus helper shared across all ACP revisions. */
-static unsigned int _amd_sdw_xfer_msg(struct amd_sdw_manager *amd_manager, struct sdw_msg *msg,
-				      int cmd_offset)
-{
-	u64 response;
-	u32 upper_data = 0, lower_data = 0;
-
-	amd_sdw_ctl_word_prep(&lower_data, &upper_data, msg, cmd_offset);
-	if (acp_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data, &response)) {
-		dev_err_ratelimited(amd_manager->dev, "command timeout for Slave %d\n",
-				    msg->dev_num);
-		return SDW_CMD_TIMEOUT;
-	}
-	return amd_sdw_fill_msg_resp(amd_manager, msg, response, cmd_offset);
-}
-
-/* AMD SoundWire bus helper shared across all ACP revisions. */
-static enum sdw_command_response amd_sdw_xfer_msg(struct sdw_bus *bus, struct sdw_msg *msg)
-{
-	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
-	int ret, i;
-
-	ret = amd_prep_msg(amd_manager, msg);
-	if (ret)
-		return SDW_CMD_FAIL_OTHER;
-	for (i = 0; i < msg->len; i++) {
-		ret = _amd_sdw_xfer_msg(amd_manager, msg, i);
-		if (ret)
-			return ret;
-	}
-	return SDW_CMD_OK;
-}
-
-/* AMD SoundWire bus helper shared across all ACP revisions. */
-static void amd_sdw_fill_slave_status(struct amd_sdw_manager *amd_manager, u16 index, u32 status)
-{
-	switch (status) {
-	case SDW_SLAVE_ATTACHED:
-	case SDW_SLAVE_UNATTACHED:
-	case SDW_SLAVE_ALERT:
-		amd_manager->status[index] = status;
-		break;
-	default:
-		amd_manager->status[index] = SDW_SLAVE_RESERVED;
-		break;
-	}
-}
-
-/* AMD SoundWire bus helper shared across all ACP revisions. */
-static void amd_sdw_process_ping_status(u64 response, struct amd_sdw_manager *amd_manager)
-{
-	u64 slave_stat;
-	u32 val;
-	u16 dev_index;
-
-	/* slave status response */
-	slave_stat = FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_0_3, response);
-	slave_stat |= FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_4_11, response) << 8;
-	dev_dbg(amd_manager->dev, "slave_stat:0x%llx\n", slave_stat);
-	for (dev_index = 0; dev_index <= SDW_MAX_DEVICES; ++dev_index) {
-		val = (slave_stat >> (dev_index * 2)) & AMD_SDW_MCP_SLAVE_STATUS_MASK;
-		dev_dbg(amd_manager->dev, "val:0x%x\n", val);
-		amd_sdw_fill_slave_status(amd_manager, dev_index, val);
-	}
-}
-
 static void amd_acp63_sdw_read_and_process_ping_status(struct amd_sdw_manager *amd_manager)
 {
 	u64 response;
@@ -481,7 +368,7 @@ static u32 amd_acp63_sdw_read_ping_status(struct sdw_bus *bus)
 	return slave_stat;
 }
 
-static int amd_acp63_sdw_compute_params(struct sdw_bus *bus, struct sdw_stream_runtime *stream)
+int amd_acp63_sdw_compute_params(struct sdw_bus *bus, struct sdw_stream_runtime *stream)
 {
 	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
 	struct sdw_transport_data t_data = {0};
@@ -726,228 +613,19 @@ static int amd_acp63_sdw_port_enable(struct sdw_bus *bus,
 	return 0;
 }
 
-static int sdw_master_read_amd_prop(struct sdw_bus *bus)
-{
-	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
-	struct fwnode_handle *link;
-	struct sdw_master_prop *prop;
-	u32 quirk_mask = 0;
-	u32 wake_en_mask = 0;
-	u32 power_mode_mask = 0;
-	char name[32];
-
-	prop = &bus->prop;
-	/* Find manager handle */
-	snprintf(name, sizeof(name), "mipi-sdw-link-%d-subproperties", bus->link_id);
-	link = device_get_named_child_node(bus->dev, name);
-	if (!link) {
-		dev_err(bus->dev, "Manager node %s not found\n", name);
-		return -EIO;
-	}
-	fwnode_property_read_u32(link, "amd-sdw-enable", &quirk_mask);
-	if (!(quirk_mask & AMD_SDW_QUIRK_MASK_BUS_ENABLE))
-		prop->hw_disabled = true;
-	prop->quirks = SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH |
-		       SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY;
-
-	fwnode_property_read_u32(link, "amd-sdw-wakeup-enable", &wake_en_mask);
-	amd_manager->wake_en_mask = wake_en_mask;
-	fwnode_property_read_u32(link, "amd-sdw-power-mode", &power_mode_mask);
-	amd_manager->power_mode_mask = power_mode_mask;
-
-	fwnode_handle_put(link);
-
-	return 0;
-}
-
-/* AMD SoundWire bus helper shared across all ACP revisions. */
-static int amd_prop_read(struct sdw_bus *bus)
-{
-	sdw_master_read_prop(bus);
-	sdw_master_read_amd_prop(bus);
-	return 0;
-}
-
-static const struct sdw_master_port_ops amd_acp63_sdw_port_ops = {
+const struct sdw_master_port_ops amd_acp63_sdw_port_ops = {
 	.dpn_set_port_params = amd_acp63_sdw_port_params,
 	.dpn_set_port_transport_params = amd_acp63_sdw_transport_params,
 	.dpn_port_enable_ch = amd_acp63_sdw_port_enable,
 };
 
-static const struct sdw_master_ops amd_acp63_sdw_ops = {
+const struct sdw_master_ops amd_acp63_sdw_ops = {
 	.read_prop = amd_prop_read,
 	.xfer_msg = amd_sdw_xfer_msg,
 	.read_ping_status = amd_acp63_sdw_read_ping_status,
 };
 
-static int amd_sdw_hw_params(struct snd_pcm_substream *substream,
-			     struct snd_pcm_hw_params *params,
-			     struct snd_soc_dai *dai)
-{
-	struct amd_sdw_manager *amd_manager = snd_soc_dai_get_drvdata(dai);
-	struct sdw_amd_dai_runtime *dai_runtime;
-	struct sdw_stream_config sconfig;
-	int ch, dir;
-	int ret;
-
-	dai_runtime = amd_manager->dai_runtime_array[dai->id];
-	if (!dai_runtime)
-		return -EIO;
-
-	ch = params_channels(params);
-	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-		dir = SDW_DATA_DIR_RX;
-	else
-		dir = SDW_DATA_DIR_TX;
-	dev_dbg(amd_manager->dev, "dir:%d dai->id:0x%x\n", dir, dai->id);
-
-	sconfig.direction = dir;
-	sconfig.ch_count = ch;
-	sconfig.frame_rate = params_rate(params);
-	sconfig.type = dai_runtime->stream_type;
-
-	sconfig.bps = snd_pcm_format_width(params_format(params));
-
-	/* Port configuration */
-	struct sdw_port_config *pconfig __free(kfree) = kzalloc_obj(*pconfig);
-	if (!pconfig)
-		return -ENOMEM;
-
-	pconfig->num = dai->id;
-	pconfig->ch_mask = (1 << ch) - 1;
-	ret = sdw_stream_add_master(&amd_manager->bus, &sconfig,
-				    pconfig, 1, dai_runtime->stream);
-	if (ret)
-		dev_err(amd_manager->dev, "add manager to stream failed:%d\n", ret);
-
-	return ret;
-}
-
-static int amd_sdw_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
-{
-	struct amd_sdw_manager *amd_manager = snd_soc_dai_get_drvdata(dai);
-	struct sdw_amd_dai_runtime *dai_runtime;
-	int ret;
-
-	dai_runtime = amd_manager->dai_runtime_array[dai->id];
-	if (!dai_runtime)
-		return -EIO;
-
-	ret = sdw_stream_remove_master(&amd_manager->bus, dai_runtime->stream);
-	if (ret < 0)
-		dev_err(dai->dev, "remove manager from stream %s failed: %d\n",
-			dai_runtime->stream->name, ret);
-	return ret;
-}
-
-static int amd_set_sdw_stream(struct snd_soc_dai *dai, void *stream, int direction)
-{
-	struct amd_sdw_manager *amd_manager = snd_soc_dai_get_drvdata(dai);
-	struct sdw_amd_dai_runtime *dai_runtime;
-
-	dai_runtime = amd_manager->dai_runtime_array[dai->id];
-	if (stream) {
-		/* first paranoia check */
-		if (dai_runtime) {
-			dev_err(dai->dev, "dai_runtime already allocated for dai %s\n",	dai->name);
-			return -EINVAL;
-		}
-
-		/* allocate and set dai_runtime info */
-		dai_runtime = kzalloc_obj(*dai_runtime);
-		if (!dai_runtime)
-			return -ENOMEM;
-
-		dai_runtime->stream_type = SDW_STREAM_PCM;
-		dai_runtime->bus = &amd_manager->bus;
-		dai_runtime->stream = stream;
-		amd_manager->dai_runtime_array[dai->id] = dai_runtime;
-	} else {
-		/* second paranoia check */
-		if (!dai_runtime) {
-			dev_err(dai->dev, "dai_runtime not allocated for dai %s\n", dai->name);
-			return -EINVAL;
-		}
-
-		/* for NULL stream we release allocated dai_runtime */
-		kfree(dai_runtime);
-		amd_manager->dai_runtime_array[dai->id] = NULL;
-	}
-	return 0;
-}
-
-static int amd_pcm_set_sdw_stream(struct snd_soc_dai *dai, void *stream, int direction)
-{
-	return amd_set_sdw_stream(dai, stream, direction);
-}
-
-static void *amd_get_sdw_stream(struct snd_soc_dai *dai, int direction)
-{
-	struct amd_sdw_manager *amd_manager = snd_soc_dai_get_drvdata(dai);
-	struct sdw_amd_dai_runtime *dai_runtime;
-
-	dai_runtime = amd_manager->dai_runtime_array[dai->id];
-	if (!dai_runtime)
-		return ERR_PTR(-EINVAL);
-
-	return dai_runtime->stream;
-}
-
-static const struct snd_soc_dai_ops amd_sdw_dai_ops = {
-	.hw_params = amd_sdw_hw_params,
-	.hw_free = amd_sdw_hw_free,
-	.set_stream = amd_pcm_set_sdw_stream,
-	.get_stream = amd_get_sdw_stream,
-};
-
-static const struct snd_soc_component_driver amd_sdw_dai_component = {
-	.name = "soundwire",
-};
-
-static int amd_sdw_register_dais(struct amd_sdw_manager *amd_manager)
-{
-	struct sdw_amd_dai_runtime **dai_runtime_array;
-	struct snd_soc_dai_driver *dais;
-	struct snd_soc_pcm_stream *stream;
-	struct device *dev;
-	int i, num_dais;
-
-	dev = amd_manager->dev;
-	num_dais = amd_manager->num_dout_ports + amd_manager->num_din_ports;
-	dais = devm_kcalloc(dev, num_dais, sizeof(*dais), GFP_KERNEL);
-	if (!dais)
-		return -ENOMEM;
-
-	dai_runtime_array = devm_kcalloc(dev, num_dais,
-					 sizeof(struct sdw_amd_dai_runtime *),
-					 GFP_KERNEL);
-	if (!dai_runtime_array)
-		return -ENOMEM;
-	amd_manager->dai_runtime_array = dai_runtime_array;
-	for (i = 0; i < num_dais; i++) {
-		dais[i].name = devm_kasprintf(dev, GFP_KERNEL, "SDW%d Pin%d", amd_manager->instance,
-					      i);
-		if (!dais[i].name)
-			return -ENOMEM;
-		if (i < amd_manager->num_dout_ports)
-			stream = &dais[i].playback;
-		else
-			stream = &dais[i].capture;
-
-		stream->channels_min = 2;
-		stream->channels_max = 2;
-		stream->rates = SNDRV_PCM_RATE_48000;
-		stream->formats = SNDRV_PCM_FMTBIT_S16_LE;
-
-		dais[i].ops = &amd_sdw_dai_ops;
-		dais[i].id = i;
-	}
-
-	return devm_snd_soc_register_component(dev, &amd_sdw_dai_component,
-					       dais, num_dais);
-}
-
-static void amd_acp63_sdw_update_slave_status_work(struct amd_sdw_manager *amd_manager)
+void amd_acp63_sdw_update_slave_status_work(struct amd_sdw_manager *amd_manager)
 {
 	int retry_count = 0;
 
@@ -981,48 +659,6 @@ static void amd_acp63_sdw_update_slave_status_work(struct amd_sdw_manager *amd_m
 	}
 }
 
-static void amd_sdw_update_slave_status_work(struct work_struct *work)
-{
-	struct amd_sdw_manager *amd_manager =
-		container_of(work, struct amd_sdw_manager, amd_sdw_work);
-
-	switch (amd_manager->acp_rev) {
-	case ACP63_PCI_REV_ID:
-	case ACP70_PCI_REV_ID:
-	case ACP71_PCI_REV_ID:
-	case ACP72_PCI_REV_ID:
-		amd_acp63_sdw_update_slave_status_work(amd_manager);
-		break;
-	default:
-		dev_err(amd_manager->dev, "unexpected acp_rev 0x%x\n", amd_manager->acp_rev);
-		return;
-	}
-}
-
-static void amd_sdw_update_slave_status(u32 status_change_0to7, u32 status_change_8to11,
-					struct amd_sdw_manager *amd_manager)
-{
-	u64 slave_stat;
-	u32 val;
-	int dev_index;
-
-	if (status_change_0to7 == AMD_SDW_SLAVE_0_ATTACHED)
-		memset(amd_manager->status, 0, sizeof(amd_manager->status));
-	slave_stat = status_change_0to7;
-	slave_stat |= FIELD_GET(AMD_SDW_MCP_SLAVE_STATUS_8TO_11, status_change_8to11) << 32;
-	dev_dbg(amd_manager->dev, "status_change_0to7:0x%x status_change_8to11:0x%x\n",
-		status_change_0to7, status_change_8to11);
-	if (slave_stat) {
-		for (dev_index = 0; dev_index <= SDW_MAX_DEVICES; ++dev_index) {
-			if (slave_stat & AMD_SDW_MCP_SLAVE_STATUS_VALID_MASK(dev_index)) {
-				val = (slave_stat >> AMD_SDW_MCP_SLAVE_STAT_SHIFT_MASK(dev_index)) &
-				      AMD_SDW_MCP_SLAVE_STATUS_MASK;
-				amd_sdw_fill_slave_status(amd_manager, dev_index, val);
-			}
-		}
-	}
-}
-
 static void amd_acp63_sdw_process_wake_event(struct amd_sdw_manager *amd_manager)
 {
 	dev_dbg(amd_manager->dev, "SoundWire Wake event reported\n");
@@ -1030,7 +666,7 @@ static void amd_acp63_sdw_process_wake_event(struct amd_sdw_manager *amd_manager
 	writel(0x00, amd_manager->acp_mmio + ACP_SW_WAKE_EN(amd_manager->instance));
 }
 
-static void amd_acp63_sdw_irq_thread(struct amd_sdw_manager *amd_manager)
+void amd_acp63_sdw_irq_thread(struct amd_sdw_manager *amd_manager)
 {
 	u32 status_change_8to11;
 	u32 status_change_0to7;
@@ -1060,89 +696,6 @@ static void amd_acp63_sdw_irq_thread(struct amd_sdw_manager *amd_manager)
 	writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_0TO7);
 }
 
-static void amd_sdw_irq_thread(struct work_struct *work)
-{
-	struct amd_sdw_manager *amd_manager =
-			container_of(work, struct amd_sdw_manager, amd_sdw_irq_thread);
-
-	switch (amd_manager->acp_rev) {
-	case ACP63_PCI_REV_ID:
-	case ACP70_PCI_REV_ID:
-	case ACP71_PCI_REV_ID:
-	case ACP72_PCI_REV_ID:
-		amd_acp63_sdw_irq_thread(amd_manager);
-		break;
-	default:
-		dev_err(amd_manager->dev, "unexpected acp_rev 0x%x\n", amd_manager->acp_rev);
-		return;
-	}
-}
-
-int amd_sdw_manager_start(struct amd_sdw_manager *amd_manager)
-{
-	struct sdw_master_prop *prop;
-	int ret;
-
-	prop = &amd_manager->bus.prop;
-	if (!prop->hw_disabled) {
-		ret = acp_sdw_clk_init_ctrl(amd_manager);
-		if (ret)
-			return ret;
-		ret = acp_init_sdw_manager(amd_manager);
-		if (ret)
-			return ret;
-		acp_enable_sdw_interrupts(amd_manager);
-		ret = acp_enable_sdw_manager(amd_manager);
-		if (ret)
-			return ret;
-		acp_sdw_set_frameshape(amd_manager);
-	}
-	/* Enable runtime PM */
-	pm_runtime_set_autosuspend_delay(amd_manager->dev, AMD_SDW_MASTER_SUSPEND_DELAY_MS);
-	pm_runtime_use_autosuspend(amd_manager->dev);
-	pm_runtime_mark_last_busy(amd_manager->dev);
-	pm_runtime_set_active(amd_manager->dev);
-	pm_runtime_enable(amd_manager->dev);
-	return 0;
-}
-
-/*
- * AMD SoundWire clock-stop sequence shared across all ACP revisions.
- * Differences between revisions in this path are minimal; a switch/case
- * on acp_rev is sufficient to accommodate any variant-specific additions
- * needed for future platforms.
- */
-static int amd_sdw_clock_stop(struct amd_sdw_manager *amd_manager)
-{
-	u32 val;
-	int ret;
-
-	ret = sdw_bus_prep_clk_stop(&amd_manager->bus);
-	if (ret < 0 && ret != -ENODATA) {
-		dev_err(amd_manager->dev, "prepare clock stop failed %d", ret);
-		return 0;
-	}
-	ret = sdw_bus_clk_stop(&amd_manager->bus);
-	if (ret < 0 && ret != -ENODATA) {
-		dev_err(amd_manager->dev, "bus clock stop failed %d", ret);
-		return 0;
-	}
-
-	ret = readl_poll_timeout(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL, val,
-				 (val & AMD_SDW_CLK_STOP_DONE), ACP_DELAY_US, AMD_SDW_TIMEOUT);
-	if (ret) {
-		dev_err(amd_manager->dev, "SDW%x clock stop failed\n", amd_manager->instance);
-		return 0;
-	}
-
-	amd_manager->clk_stopped = true;
-	if (amd_manager->wake_en_mask)
-		writel(0x01, amd_manager->acp_mmio + ACP_SW_WAKE_EN(amd_manager->instance));
-
-	dev_dbg(amd_manager->dev, "SDW%x clock stop successful\n", amd_manager->instance);
-	return 0;
-}
-
 static int amd_acp63_sdw_clock_stop_exit(struct amd_sdw_manager *amd_manager)
 {
 	int ret;
@@ -1172,77 +725,6 @@ static int amd_acp63_sdw_clock_stop_exit(struct amd_sdw_manager *amd_manager)
 	return 0;
 }
 
-static int amd_resume_child_device(struct device *dev, void *data)
-{
-	struct sdw_slave *slave = dev_to_sdw_dev(dev);
-	int ret;
-
-	if (!slave->probed) {
-		dev_dbg(dev, "skipping device, no probed driver\n");
-		return 0;
-	}
-	if (!slave->dev_num_sticky) {
-		dev_dbg(dev, "skipping device, never detected on bus\n");
-		return 0;
-	}
-	ret = pm_request_resume(dev);
-	if (ret < 0) {
-		dev_err(dev, "pm_request_resume failed: %d\n", ret);
-		return ret;
-	}
-	return 0;
-}
-
-static int __maybe_unused amd_pm_prepare(struct device *dev)
-{
-	struct amd_sdw_manager *amd_manager = dev_get_drvdata(dev);
-	struct sdw_bus *bus = &amd_manager->bus;
-	int ret;
-
-	if (bus->prop.hw_disabled) {
-		dev_dbg(bus->dev, "SoundWire manager %d is disabled, ignoring\n",
-			bus->link_id);
-		return 0;
-	}
-	/*
-	 * When multiple peripheral devices connected over the same link, if SoundWire manager
-	 * device is not in runtime suspend state, observed that device alerts are missing
-	 * without pm_prepare on AMD platforms in clockstop mode0.
-	 */
-	if (amd_manager->power_mode_mask) {
-		ret = pm_runtime_resume(dev);
-		if (ret < 0) {
-			dev_err(bus->dev, "pm_runtime_resume failed: %d\n", ret);
-			return 0;
-		}
-	}
-	/* To force peripheral devices to system level suspend state, resume the devices
-	 * from runtime suspend state first. Without that unable to dispatch the alert
-	 * status to peripheral driver during system level resume as they are in runtime
-	 * suspend state.
-	 */
-	ret = device_for_each_child(bus->dev, NULL, amd_resume_child_device);
-	if (ret < 0)
-		dev_err(dev, "amd_resume_child_device failed: %d\n", ret);
-	return 0;
-}
-
-static int amd_sdw_host_wake_enable_by_rev(struct amd_sdw_manager *amd_manager, bool enable)
-{
-	switch (amd_manager->acp_rev) {
-	case ACP63_PCI_REV_ID:
-		break;
-	case ACP70_PCI_REV_ID:
-	case ACP71_PCI_REV_ID:
-	case ACP72_PCI_REV_ID:
-		return acp_sdw_host_wake_enable(amd_manager, enable);
-	default:
-		dev_err(amd_manager->dev, "unexpected acp_rev 0x%x\n", amd_manager->acp_rev);
-		return -EINVAL;
-	}
-	return 0;
-}
-
 static int amd_acp63_sdw_suspend(struct amd_sdw_manager *amd_manager)
 {
 	struct sdw_bus *bus = &amd_manager->bus;
@@ -1442,139 +924,6 @@ static int amd_acp63_sdw_resume_runtime(struct amd_sdw_manager *amd_manager)
 	return 0;
 }
 
-static int __maybe_unused amd_suspend(struct device *dev)
-{
-	return acp_sdw_suspend(dev);
-}
-
-static int __maybe_unused amd_suspend_runtime(struct device *dev)
-{
-	return acp_sdw_suspend_runtime(dev);
-}
-
-static int __maybe_unused amd_resume_runtime(struct device *dev)
-{
-	return acp_sdw_resume_runtime(dev);
-}
-
-static int amd_sdw_hw_init_ops(struct amd_sdw_manager *amd_manager);
-
-static int amd_sdw_manager_probe(struct platform_device *pdev)
-{
-	const struct acp_sdw_pdata *pdata = pdev->dev.platform_data;
-	struct resource *res;
-	struct device *dev = &pdev->dev;
-	struct sdw_master_prop *prop;
-	struct amd_sdw_manager *amd_manager;
-	int ret;
-
-	amd_manager = devm_kzalloc(dev, sizeof(struct amd_sdw_manager), GFP_KERNEL);
-	if (!amd_manager)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENOMEM;
-
-	amd_manager->acp_mmio = devm_ioremap(dev, res->start, resource_size(res));
-	if (!amd_manager->acp_mmio) {
-		dev_err(dev, "mmio not found\n");
-		return -ENOMEM;
-	}
-	amd_manager->ping_slave_stat = U32_MAX;
-	amd_manager->instance = pdata->instance;
-	amd_manager->mmio = amd_manager->acp_mmio +
-			    (amd_manager->instance * ACP63_SDW_MANAGER_REG_OFFSET);
-	amd_manager->acp_sdw_lock = pdata->acp_sdw_lock;
-	amd_manager->acp_rev = pdata->acp_rev;
-	amd_manager->cols_index = sdw_find_col_index(AMD_SDW_DEFAULT_COLUMNS);
-	amd_manager->rows_index = sdw_find_row_index(AMD_SDW_DEFAULT_ROWS);
-	amd_manager->dev = dev;
-	amd_manager->bus.ops = &amd_acp63_sdw_ops;
-	amd_manager->bus.port_ops = &amd_acp63_sdw_port_ops;
-	amd_manager->bus.compute_params = &amd_acp63_sdw_compute_params;
-	amd_manager->bus.clk_stop_timeout = 200;
-	amd_manager->bus.link_id = amd_manager->instance;
-	ret = amd_sdw_hw_init_ops(amd_manager);
-	if (ret) {
-		dev_err(dev, "Failed to initialize hw ops (%d)\n", ret);
-		return ret;
-	}
-
-	/*
-	 * Due to BIOS compatibility, the two links are exposed within
-	 * the scope of a single controller. If this changes, the
-	 * controller_id will have to be updated with drv_data
-	 * information.
-	 */
-	amd_manager->bus.controller_id = 0;
-	dev_dbg(dev, "acp_rev:0x%x\n", amd_manager->acp_rev);
-	switch (amd_manager->acp_rev) {
-	case ACP63_PCI_REV_ID:
-		switch (amd_manager->instance) {
-		case ACP_SDW0:
-			amd_manager->num_dout_ports = AMD_ACP63_SDW0_MAX_TX_PORTS;
-			amd_manager->num_din_ports = AMD_ACP63_SDW0_MAX_RX_PORTS;
-			break;
-		case ACP_SDW1:
-			amd_manager->num_dout_ports = AMD_ACP63_SDW1_MAX_TX_PORTS;
-			amd_manager->num_din_ports = AMD_ACP63_SDW1_MAX_RX_PORTS;
-			break;
-		default:
-			return -EINVAL;
-		}
-		break;
-	case ACP70_PCI_REV_ID:
-	case ACP71_PCI_REV_ID:
-	case ACP72_PCI_REV_ID:
-		amd_manager->num_dout_ports = AMD_ACP70_SDW_MAX_TX_PORTS;
-		amd_manager->num_din_ports = AMD_ACP70_SDW_MAX_RX_PORTS;
-		break;
-	default:
-		return -EINVAL;
-	}
-	amd_manager->max_ports = amd_manager->num_dout_ports + amd_manager->num_din_ports;
-	amd_manager->port_offset_map = devm_kcalloc(dev, amd_manager->max_ports,
-						    sizeof(int), GFP_KERNEL);
-	if (!amd_manager->port_offset_map)
-		return -ENOMEM;
-
-	prop = &amd_manager->bus.prop;
-	prop->mclk_freq = AMD_SDW_BUS_BASE_FREQ;
-
-	ret = sdw_bus_master_add(&amd_manager->bus, dev, dev->fwnode);
-	if (ret) {
-		dev_err(dev, "Failed to register SoundWire manager(%d)\n", ret);
-		return ret;
-	}
-	ret = amd_sdw_register_dais(amd_manager);
-	if (ret) {
-		dev_err(dev, "CPU DAI registration failed\n");
-		sdw_bus_master_delete(&amd_manager->bus);
-		return ret;
-	}
-	dev_set_drvdata(dev, amd_manager);
-	INIT_WORK(&amd_manager->amd_sdw_irq_thread, amd_sdw_irq_thread);
-	INIT_WORK(&amd_manager->amd_sdw_work, amd_sdw_update_slave_status_work);
-	return 0;
-}
-
-static void amd_sdw_manager_remove(struct platform_device *pdev)
-{
-	struct amd_sdw_manager *amd_manager = dev_get_drvdata(&pdev->dev);
-	int ret;
-
-	if (pm_runtime_enabled(&pdev->dev))
-		pm_runtime_disable(&pdev->dev);
-	acp_disable_sdw_interrupts(amd_manager);
-	cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
-	cancel_work_sync(&amd_manager->amd_sdw_work);
-	sdw_bus_master_delete(&amd_manager->bus);
-	ret = acp_disable_sdw_manager(amd_manager);
-	if (ret)
-		dev_err(&pdev->dev, "Failed to disable device (%pe)\n", ERR_PTR(ret));
-}
-
 static const struct amd_sdw_hw_ops amd_acp63_hw_ops = {
 	.init_sdw_manager		= amd_acp63_init_sdw_manager,
 	.enable_sdw_manager		= amd_acp63_enable_sdw_manager,
@@ -1595,7 +944,7 @@ static const struct amd_sdw_hw_ops amd_acp63_hw_ops = {
 	.resume_runtime			= amd_acp63_sdw_resume_runtime,
 };
 
-static int amd_sdw_hw_init_ops(struct amd_sdw_manager *amd_manager)
+int amd_sdw_hw_init_ops(struct amd_sdw_manager *amd_manager)
 {
 	switch (amd_manager->acp_rev) {
 	case ACP63_PCI_REV_ID:
@@ -1609,24 +958,3 @@ static int amd_sdw_hw_init_ops(struct amd_sdw_manager *amd_manager)
 	}
 	return 0;
 }
-
-static const struct dev_pm_ops amd_pm = {
-	.prepare = amd_pm_prepare,
-	SET_SYSTEM_SLEEP_PM_OPS(amd_suspend, amd_resume_runtime)
-	SET_RUNTIME_PM_OPS(amd_suspend_runtime, amd_resume_runtime, NULL)
-};
-
-static struct platform_driver amd_sdw_driver = {
-	.probe	= &amd_sdw_manager_probe,
-	.remove = &amd_sdw_manager_remove,
-	.driver = {
-		.name	= "amd_sdw_manager",
-		.pm = &amd_pm,
-	}
-};
-module_platform_driver(amd_sdw_driver);
-
-MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
-MODULE_DESCRIPTION("AMD SoundWire driver");
-MODULE_LICENSE("Dual BSD/GPL");
-MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
index d66b8d6f41c1..cbd91eb2411f 100644
--- a/drivers/soundwire/amd_manager.h
+++ b/drivers/soundwire/amd_manager.h
@@ -207,73 +207,23 @@
 #define AMD_SDW_DEVICE_STATE_D3				3
 #define ACP_PME_EN					0x0001400
 
-struct sdw_manager_dp_reg {
-	u32 frame_fmt_reg;
-	u32 sample_int_reg;
-	u32 hctrl_dp0_reg;
-	u32 offset_reg;
-	u32 lane_ctrl_ch_en_reg;
-};
-
-/*
- * SDW0 Manager instance registers  6 CPU DAI (3 TX & 3 RX Ports)
- * whereas SDW1  Manager Instance registers 2 CPU DAI (one TX & one RX port)
- * Below is the CPU DAI <->Manager port number mapping
- * i.e SDW0 Pin0 -> port number 0 -> AUDIO0 TX
- *     SDW0 Pin1 -> Port number 1 -> AUDIO1 TX
- *     SDW0 Pin2 -> Port number 2 -> AUDIO2 TX
- *     SDW0 Pin3 -> port number 3 -> AUDIO0 RX
- *     SDW0 Pin4 -> Port number 4 -> AUDIO1 RX
- *     SDW0 Pin5 -> Port number 5 -> AUDIO2 RX
- *  Whereas for SDW1 instance
- *  SDW1 Pin0 -> port number 0 -> AUDIO1 TX
- *  SDW1 Pin1 -> Port number 1 -> AUDIO1 RX
- *  Same mapping should be used for programming DMA controller registers in SoundWire DMA driver.
- * i.e if AUDIO0 TX channel is selected then we need to use AUDIO0 TX registers for DMA programming
- * in SoundWire DMA driver.
- */
-
-static struct sdw_manager_dp_reg acp63_sdw0_dp_reg[AMD_ACP63_SDW0_MAX_DAI] =  {
-	{ACP_SW_AUDIO0_TX_FRAME_FORMAT, ACP_SW_AUDIO0_TX_SAMPLEINTERVAL, ACP_SW_AUDIO0_TX_HCTRL_DP0,
-	 ACP_SW_AUDIO0_TX_OFFSET_DP0, ACP_SW_AUDIO0_TX_CHANNEL_ENABLE_DP0},
-	{ACP_SW_AUDIO1_TX_FRAME_FORMAT, ACP_SW_AUDIO1_TX_SAMPLEINTERVAL, ACP_SW_AUDIO1_TX_HCTRL,
-	 ACP_SW_AUDIO1_TX_OFFSET, ACP_SW_AUDIO1_TX_CHANNEL_ENABLE_DP0},
-	{ACP_SW_AUDIO2_TX_FRAME_FORMAT, ACP_SW_AUDIO2_TX_SAMPLEINTERVAL, ACP_SW_AUDIO2_TX_HCTRL,
-	 ACP_SW_AUDIO2_TX_OFFSET, ACP_SW_AUDIO2_TX_CHANNEL_ENABLE_DP0},
-	{ACP_SW_AUDIO0_RX_FRAME_FORMAT, ACP_SW_AUDIO0_RX_SAMPLEINTERVAL, ACP_SW_AUDIO0_RX_HCTRL_DP0,
-	 ACP_SW_AUDIO0_RX_OFFSET_DP0, ACP_SW_AUDIO0_RX_CHANNEL_ENABLE_DP0},
-	{ACP_SW_AUDIO1_RX_FRAME_FORMAT, ACP_SW_AUDIO1_RX_SAMPLEINTERVAL, ACP_SW_AUDIO1_RX_HCTRL,
-	 ACP_SW_AUDIO1_RX_OFFSET, ACP_SW_AUDIO1_RX_CHANNEL_ENABLE_DP0},
-	{ACP_SW_AUDIO2_RX_FRAME_FORMAT, ACP_SW_AUDIO2_RX_SAMPLEINTERVAL, ACP_SW_AUDIO2_RX_HCTRL,
-	 ACP_SW_AUDIO2_RX_OFFSET, ACP_SW_AUDIO2_RX_CHANNEL_ENABLE_DP0},
-};
-
-static struct sdw_manager_dp_reg acp63_sdw1_dp_reg[AMD_ACP63_SDW1_MAX_DAI] =  {
-	{ACP_SW_AUDIO1_TX_FRAME_FORMAT, ACP_SW_AUDIO1_TX_SAMPLEINTERVAL, ACP_SW_AUDIO1_TX_HCTRL,
-	 ACP_SW_AUDIO1_TX_OFFSET, ACP_SW_AUDIO1_TX_CHANNEL_ENABLE_DP0},
-	{ACP_SW_AUDIO1_RX_FRAME_FORMAT, ACP_SW_AUDIO1_RX_SAMPLEINTERVAL, ACP_SW_AUDIO1_RX_HCTRL,
-	 ACP_SW_AUDIO1_RX_OFFSET, ACP_SW_AUDIO1_RX_CHANNEL_ENABLE_DP0}
-};
-
-static struct sdw_manager_dp_reg acp70_sdw_dp_reg[AMD_ACP70_SDW_MAX_DAI] =  {
-	{ACP_SW_AUDIO0_TX_FRAME_FORMAT, ACP_SW_AUDIO0_TX_SAMPLEINTERVAL, ACP_SW_AUDIO0_TX_HCTRL_DP0,
-	 ACP_SW_AUDIO0_TX_OFFSET_DP0, ACP_SW_AUDIO0_TX_CHANNEL_ENABLE_DP0},
-	{ACP_SW_AUDIO1_TX_FRAME_FORMAT, ACP_SW_AUDIO1_TX_SAMPLEINTERVAL, ACP_SW_AUDIO1_TX_HCTRL,
-	 ACP_SW_AUDIO1_TX_OFFSET, ACP_SW_AUDIO1_TX_CHANNEL_ENABLE_DP0},
-	{ACP_SW_AUDIO2_TX_FRAME_FORMAT, ACP_SW_AUDIO2_TX_SAMPLEINTERVAL, ACP_SW_AUDIO2_TX_HCTRL,
-	 ACP_SW_AUDIO2_TX_OFFSET, ACP_SW_AUDIO2_TX_CHANNEL_ENABLE_DP0},
-	{ACP_SW_AUDIO0_RX_FRAME_FORMAT, ACP_SW_AUDIO0_RX_SAMPLEINTERVAL, ACP_SW_AUDIO0_RX_HCTRL_DP0,
-	 ACP_SW_AUDIO0_RX_OFFSET_DP0, ACP_SW_AUDIO0_RX_CHANNEL_ENABLE_DP0},
-	{ACP_SW_AUDIO1_RX_FRAME_FORMAT, ACP_SW_AUDIO1_RX_SAMPLEINTERVAL, ACP_SW_AUDIO1_RX_HCTRL,
-	 ACP_SW_AUDIO1_RX_OFFSET, ACP_SW_AUDIO1_RX_CHANNEL_ENABLE_DP0},
-	{ACP_SW_AUDIO2_RX_FRAME_FORMAT, ACP_SW_AUDIO2_RX_SAMPLEINTERVAL, ACP_SW_AUDIO2_RX_HCTRL,
-	 ACP_SW_AUDIO2_RX_OFFSET, ACP_SW_AUDIO2_RX_CHANNEL_ENABLE_DP0},
-};
-
-static u32 sdw_manager_reg_mask_array[AMD_ACP63_SDW_MAX_MANAGER_COUNT] =  {
-		AMD_SDW0_EXT_INTR_MASK,
-		AMD_SDW1_EXT_INTR_MASK
-};
+/* Cross-file prototypes: amd_manager_common.c functions used by amd_acp63_manager.c */
+enum sdw_command_response amd_sdw_xfer_msg(struct sdw_bus *bus, struct sdw_msg *msg);
+void amd_sdw_fill_slave_status(struct amd_sdw_manager *amd_manager, u16 index, u32 status);
+void amd_sdw_process_ping_status(u64 response, struct amd_sdw_manager *amd_manager);
+void amd_sdw_update_slave_status(u32 status_change_0to7, u32 status_change_8to11,
+				 struct amd_sdw_manager *amd_manager);
+int amd_sdw_clock_stop(struct amd_sdw_manager *amd_manager);
+int amd_sdw_host_wake_enable_by_rev(struct amd_sdw_manager *amd_manager, bool enable);
+int amd_prop_read(struct sdw_bus *bus);
+
+/* Cross-file prototypes: amd_acp63_manager.c symbols used by amd_manager_common.c */
+int amd_sdw_hw_init_ops(struct amd_sdw_manager *amd_manager);
+int amd_acp63_sdw_compute_params(struct sdw_bus *bus, struct sdw_stream_runtime *stream);
+extern const struct sdw_master_port_ops amd_acp63_sdw_port_ops;
+extern const struct sdw_master_ops amd_acp63_sdw_ops;
+void amd_acp63_sdw_irq_thread(struct amd_sdw_manager *amd_manager);
+void amd_acp63_sdw_update_slave_status_work(struct amd_sdw_manager *amd_manager);
 
 #define AMD_SDW_HW_OPS(amd_manager, cb)	((amd_manager)->hw_ops->cb)
 
diff --git a/drivers/soundwire/amd_manager_common.c b/drivers/soundwire/amd_manager_common.c
new file mode 100644
index 000000000000..94b4b611a2ea
--- /dev/null
+++ b/drivers/soundwire/amd_manager_common.c
@@ -0,0 +1,773 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * SoundWire AMD Manager driver
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/completion.h>
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_registers.h>
+#include <linux/pm_runtime.h>
+#include <linux/wait.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include "bus.h"
+#include "amd_init.h"
+#include "amd_manager.h"
+
+#define DRV_NAME "amd_sdw_manager"
+
+#define to_amd_sdw(b)	container_of(b, struct amd_sdw_manager, bus)
+
+static void amd_sdw_ctl_word_prep(u32 *lower_word, u32 *upper_word, struct sdw_msg *msg,
+				  int cmd_offset)
+{
+	u32 upper_data;
+	u32 lower_data = 0;
+	u16 addr;
+	u8 upper_addr, lower_addr;
+	u8 data = 0;
+
+	addr = msg->addr + cmd_offset;
+	upper_addr = (addr & 0xFF00) >> 8;
+	lower_addr = addr & 0xFF;
+
+	if (msg->flags == SDW_MSG_FLAG_WRITE)
+		data = msg->buf[cmd_offset];
+
+	upper_data = FIELD_PREP(AMD_SDW_MCP_CMD_DEV_ADDR, msg->dev_num);
+	upper_data |= FIELD_PREP(AMD_SDW_MCP_CMD_COMMAND, msg->flags + 2);
+	upper_data |= FIELD_PREP(AMD_SDW_MCP_CMD_REG_ADDR_HIGH, upper_addr);
+	lower_data |= FIELD_PREP(AMD_SDW_MCP_CMD_REG_ADDR_LOW, lower_addr);
+	lower_data |= FIELD_PREP(AMD_SDW_MCP_CMD_REG_DATA, data);
+
+	*upper_word = upper_data;
+	*lower_word = lower_data;
+}
+
+static enum sdw_command_response
+amd_program_scp_addr(struct amd_sdw_manager *amd_manager, struct sdw_msg *msg)
+{
+	struct sdw_msg scp_msg = {0};
+	u64 response_buf[2] = {0};
+	u32 upper_data = 0, lower_data = 0;
+	int index;
+
+	scp_msg.dev_num = msg->dev_num;
+	scp_msg.addr = SDW_SCP_ADDRPAGE1;
+	scp_msg.buf = &msg->addr_page1;
+	scp_msg.flags = SDW_MSG_FLAG_WRITE;
+	amd_sdw_ctl_word_prep(&lower_data, &upper_data, &scp_msg, 0);
+	if (acp_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data, &response_buf[0])) {
+		dev_err_ratelimited(amd_manager->dev,
+				    "SCP_addrpage command timeout for Slave %d\n", msg->dev_num);
+		return SDW_CMD_TIMEOUT;
+	}
+	scp_msg.addr = SDW_SCP_ADDRPAGE2;
+	scp_msg.buf = &msg->addr_page2;
+	amd_sdw_ctl_word_prep(&lower_data, &upper_data, &scp_msg, 0);
+	if (acp_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data, &response_buf[1])) {
+		dev_err_ratelimited(amd_manager->dev,
+				    "SCP_addrpage command timeout for Slave %d\n", msg->dev_num);
+		return SDW_CMD_TIMEOUT;
+	}
+
+	for (index = 0; index < 2; index++) {
+		if (!(response_buf[index] & AMD_SDW_MCP_RESP_ACK)) {
+			if (response_buf[index] & AMD_SDW_MCP_RESP_NACK) {
+				dev_err_ratelimited(amd_manager->dev,
+						    "SCP_addrpage NACKed for Slave %d\n",
+						    msg->dev_num);
+				return SDW_CMD_FAIL;
+			}
+			dev_dbg_ratelimited(amd_manager->dev, "SCP_addrpage ignored for Slave %d\n",
+					    msg->dev_num);
+			return SDW_CMD_IGNORED;
+		}
+	}
+	return SDW_CMD_OK;
+}
+
+static int amd_prep_msg(struct amd_sdw_manager *amd_manager, struct sdw_msg *msg)
+{
+	int ret;
+
+	if (msg->page) {
+		ret = amd_program_scp_addr(amd_manager, msg);
+		if (ret) {
+			msg->len = 0;
+			return ret;
+		}
+	}
+	switch (msg->flags) {
+	case SDW_MSG_FLAG_READ:
+	case SDW_MSG_FLAG_WRITE:
+		break;
+	default:
+		dev_err(amd_manager->dev, "Invalid msg cmd: %d\n", msg->flags);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static enum sdw_command_response amd_sdw_fill_msg_resp(struct amd_sdw_manager *amd_manager,
+						       struct sdw_msg *msg, u64 response,
+						       int offset)
+{
+	if (response & AMD_SDW_MCP_RESP_ACK) {
+		if (msg->flags == SDW_MSG_FLAG_READ)
+			msg->buf[offset] = FIELD_GET(AMD_SDW_MCP_RESP_RDATA, response);
+	} else {
+		if (response & AMD_SDW_MCP_RESP_NACK) {
+			dev_err_ratelimited(amd_manager->dev,
+					    "command response NACK received for Slave %d\n",
+					    msg->dev_num);
+			return SDW_CMD_FAIL;
+		}
+		dev_dbg_ratelimited(amd_manager->dev, "command is ignored for Slave %d\n",
+				    msg->dev_num);
+		return SDW_CMD_IGNORED;
+	}
+	return SDW_CMD_OK;
+}
+
+/* AMD SoundWire bus helper shared across all ACP revisions. */
+static unsigned int _amd_sdw_xfer_msg(struct amd_sdw_manager *amd_manager, struct sdw_msg *msg,
+				      int cmd_offset)
+{
+	u64 response;
+	u32 upper_data = 0, lower_data = 0;
+
+	amd_sdw_ctl_word_prep(&lower_data, &upper_data, msg, cmd_offset);
+	if (acp_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data, &response)) {
+		dev_err_ratelimited(amd_manager->dev, "command timeout for Slave %d\n",
+				    msg->dev_num);
+		return SDW_CMD_TIMEOUT;
+	}
+	return amd_sdw_fill_msg_resp(amd_manager, msg, response, cmd_offset);
+}
+
+/* AMD SoundWire bus helper shared across all ACP revisions. */
+enum sdw_command_response amd_sdw_xfer_msg(struct sdw_bus *bus, struct sdw_msg *msg)
+{
+	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
+	int ret, i;
+
+	ret = amd_prep_msg(amd_manager, msg);
+	if (ret)
+		return SDW_CMD_FAIL_OTHER;
+	for (i = 0; i < msg->len; i++) {
+		ret = _amd_sdw_xfer_msg(amd_manager, msg, i);
+		if (ret)
+			return ret;
+	}
+	return SDW_CMD_OK;
+}
+
+/* AMD SoundWire bus helper shared across all ACP revisions. */
+void amd_sdw_fill_slave_status(struct amd_sdw_manager *amd_manager, u16 index, u32 status)
+{
+	switch (status) {
+	case SDW_SLAVE_ATTACHED:
+	case SDW_SLAVE_UNATTACHED:
+	case SDW_SLAVE_ALERT:
+		amd_manager->status[index] = status;
+		break;
+	default:
+		amd_manager->status[index] = SDW_SLAVE_RESERVED;
+		break;
+	}
+}
+
+/* AMD SoundWire bus helper shared across all ACP revisions. */
+void amd_sdw_process_ping_status(u64 response, struct amd_sdw_manager *amd_manager)
+{
+	u64 slave_stat;
+	u32 val;
+	u16 dev_index;
+
+	/* slave status response */
+	slave_stat = FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_0_3, response);
+	slave_stat |= FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_4_11, response) << 8;
+	dev_dbg(amd_manager->dev, "slave_stat:0x%llx\n", slave_stat);
+	for (dev_index = 0; dev_index <= SDW_MAX_DEVICES; ++dev_index) {
+		val = (slave_stat >> (dev_index * 2)) & AMD_SDW_MCP_SLAVE_STATUS_MASK;
+		dev_dbg(amd_manager->dev, "val:0x%x\n", val);
+		amd_sdw_fill_slave_status(amd_manager, dev_index, val);
+	}
+}
+
+static int sdw_master_read_amd_prop(struct sdw_bus *bus)
+{
+	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
+	struct fwnode_handle *link;
+	struct sdw_master_prop *prop;
+	u32 quirk_mask = 0;
+	u32 wake_en_mask = 0;
+	u32 power_mode_mask = 0;
+	char name[32];
+
+	prop = &bus->prop;
+	/* Find manager handle */
+	snprintf(name, sizeof(name), "mipi-sdw-link-%d-subproperties", bus->link_id);
+	link = device_get_named_child_node(bus->dev, name);
+	if (!link) {
+		dev_err(bus->dev, "Manager node %s not found\n", name);
+		return -EIO;
+	}
+	fwnode_property_read_u32(link, "amd-sdw-enable", &quirk_mask);
+	if (!(quirk_mask & AMD_SDW_QUIRK_MASK_BUS_ENABLE))
+		prop->hw_disabled = true;
+	prop->quirks = SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH |
+		       SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY;
+
+	fwnode_property_read_u32(link, "amd-sdw-wakeup-enable", &wake_en_mask);
+	amd_manager->wake_en_mask = wake_en_mask;
+	fwnode_property_read_u32(link, "amd-sdw-power-mode", &power_mode_mask);
+	amd_manager->power_mode_mask = power_mode_mask;
+
+	fwnode_handle_put(link);
+
+	return 0;
+}
+
+/* AMD SoundWire bus helper shared across all ACP revisions. */
+int amd_prop_read(struct sdw_bus *bus)
+{
+	sdw_master_read_prop(bus);
+	sdw_master_read_amd_prop(bus);
+	return 0;
+}
+
+static int amd_sdw_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *dai)
+{
+	struct amd_sdw_manager *amd_manager = snd_soc_dai_get_drvdata(dai);
+	struct sdw_amd_dai_runtime *dai_runtime;
+	struct sdw_stream_config sconfig;
+	int ch, dir;
+	int ret;
+
+	dai_runtime = amd_manager->dai_runtime_array[dai->id];
+	if (!dai_runtime)
+		return -EIO;
+
+	ch = params_channels(params);
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		dir = SDW_DATA_DIR_RX;
+	else
+		dir = SDW_DATA_DIR_TX;
+	dev_dbg(amd_manager->dev, "dir:%d dai->id:0x%x\n", dir, dai->id);
+
+	sconfig.direction = dir;
+	sconfig.ch_count = ch;
+	sconfig.frame_rate = params_rate(params);
+	sconfig.type = dai_runtime->stream_type;
+
+	sconfig.bps = snd_pcm_format_width(params_format(params));
+
+	/* Port configuration */
+	struct sdw_port_config *pconfig __free(kfree) = kzalloc_obj(*pconfig);
+	if (!pconfig)
+		return -ENOMEM;
+
+	pconfig->num = dai->id;
+	pconfig->ch_mask = (1 << ch) - 1;
+	ret = sdw_stream_add_master(&amd_manager->bus, &sconfig,
+				    pconfig, 1, dai_runtime->stream);
+	if (ret)
+		dev_err(amd_manager->dev, "add manager to stream failed:%d\n", ret);
+
+	return ret;
+}
+
+static int amd_sdw_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
+{
+	struct amd_sdw_manager *amd_manager = snd_soc_dai_get_drvdata(dai);
+	struct sdw_amd_dai_runtime *dai_runtime;
+	int ret;
+
+	dai_runtime = amd_manager->dai_runtime_array[dai->id];
+	if (!dai_runtime)
+		return -EIO;
+
+	ret = sdw_stream_remove_master(&amd_manager->bus, dai_runtime->stream);
+	if (ret < 0)
+		dev_err(dai->dev, "remove manager from stream %s failed: %d\n",
+			dai_runtime->stream->name, ret);
+	return ret;
+}
+
+static int amd_set_sdw_stream(struct snd_soc_dai *dai, void *stream, int direction)
+{
+	struct amd_sdw_manager *amd_manager = snd_soc_dai_get_drvdata(dai);
+	struct sdw_amd_dai_runtime *dai_runtime;
+
+	dai_runtime = amd_manager->dai_runtime_array[dai->id];
+	if (stream) {
+		/* first paranoia check */
+		if (dai_runtime) {
+			dev_err(dai->dev, "dai_runtime already allocated for dai %s\n",	dai->name);
+			return -EINVAL;
+		}
+
+		/* allocate and set dai_runtime info */
+		dai_runtime = kzalloc_obj(*dai_runtime);
+		if (!dai_runtime)
+			return -ENOMEM;
+
+		dai_runtime->stream_type = SDW_STREAM_PCM;
+		dai_runtime->bus = &amd_manager->bus;
+		dai_runtime->stream = stream;
+		amd_manager->dai_runtime_array[dai->id] = dai_runtime;
+	} else {
+		/* second paranoia check */
+		if (!dai_runtime) {
+			dev_err(dai->dev, "dai_runtime not allocated for dai %s\n", dai->name);
+			return -EINVAL;
+		}
+
+		/* for NULL stream we release allocated dai_runtime */
+		kfree(dai_runtime);
+		amd_manager->dai_runtime_array[dai->id] = NULL;
+	}
+	return 0;
+}
+
+static int amd_pcm_set_sdw_stream(struct snd_soc_dai *dai, void *stream, int direction)
+{
+	return amd_set_sdw_stream(dai, stream, direction);
+}
+
+static void *amd_get_sdw_stream(struct snd_soc_dai *dai, int direction)
+{
+	struct amd_sdw_manager *amd_manager = snd_soc_dai_get_drvdata(dai);
+	struct sdw_amd_dai_runtime *dai_runtime;
+
+	dai_runtime = amd_manager->dai_runtime_array[dai->id];
+	if (!dai_runtime)
+		return ERR_PTR(-EINVAL);
+
+	return dai_runtime->stream;
+}
+
+static const struct snd_soc_dai_ops amd_sdw_dai_ops = {
+	.hw_params = amd_sdw_hw_params,
+	.hw_free = amd_sdw_hw_free,
+	.set_stream = amd_pcm_set_sdw_stream,
+	.get_stream = amd_get_sdw_stream,
+};
+
+static const struct snd_soc_component_driver amd_sdw_dai_component = {
+	.name = "soundwire",
+};
+
+static int amd_sdw_register_dais(struct amd_sdw_manager *amd_manager)
+{
+	struct sdw_amd_dai_runtime **dai_runtime_array;
+	struct snd_soc_dai_driver *dais;
+	struct snd_soc_pcm_stream *stream;
+	struct device *dev;
+	int i, num_dais;
+
+	dev = amd_manager->dev;
+	num_dais = amd_manager->num_dout_ports + amd_manager->num_din_ports;
+	dais = devm_kcalloc(dev, num_dais, sizeof(*dais), GFP_KERNEL);
+	if (!dais)
+		return -ENOMEM;
+
+	dai_runtime_array = devm_kcalloc(dev, num_dais,
+					 sizeof(struct sdw_amd_dai_runtime *),
+					 GFP_KERNEL);
+	if (!dai_runtime_array)
+		return -ENOMEM;
+	amd_manager->dai_runtime_array = dai_runtime_array;
+	for (i = 0; i < num_dais; i++) {
+		dais[i].name = devm_kasprintf(dev, GFP_KERNEL, "SDW%d Pin%d", amd_manager->instance,
+					      i);
+		if (!dais[i].name)
+			return -ENOMEM;
+		if (i < amd_manager->num_dout_ports)
+			stream = &dais[i].playback;
+		else
+			stream = &dais[i].capture;
+
+		stream->channels_min = 2;
+		stream->channels_max = 2;
+		stream->rates = SNDRV_PCM_RATE_48000;
+		stream->formats = SNDRV_PCM_FMTBIT_S16_LE;
+
+		dais[i].ops = &amd_sdw_dai_ops;
+		dais[i].id = i;
+	}
+
+	return devm_snd_soc_register_component(dev, &amd_sdw_dai_component,
+					       dais, num_dais);
+}
+
+static void amd_sdw_update_slave_status_work(struct work_struct *work)
+{
+	struct amd_sdw_manager *amd_manager =
+		container_of(work, struct amd_sdw_manager, amd_sdw_work);
+
+	switch (amd_manager->acp_rev) {
+	case ACP63_PCI_REV_ID:
+	case ACP70_PCI_REV_ID:
+	case ACP71_PCI_REV_ID:
+	case ACP72_PCI_REV_ID:
+		amd_acp63_sdw_update_slave_status_work(amd_manager);
+		break;
+	default:
+		dev_err(amd_manager->dev, "unexpected acp_rev 0x%x\n", amd_manager->acp_rev);
+		return;
+	}
+}
+
+void amd_sdw_update_slave_status(u32 status_change_0to7, u32 status_change_8to11,
+				 struct amd_sdw_manager *amd_manager)
+{
+	u64 slave_stat;
+	u32 val;
+	int dev_index;
+
+	if (status_change_0to7 == AMD_SDW_SLAVE_0_ATTACHED)
+		memset(amd_manager->status, 0, sizeof(amd_manager->status));
+	slave_stat = status_change_0to7;
+	slave_stat |= FIELD_GET(AMD_SDW_MCP_SLAVE_STATUS_8TO_11, status_change_8to11) << 32;
+	dev_dbg(amd_manager->dev, "status_change_0to7:0x%x status_change_8to11:0x%x\n",
+		status_change_0to7, status_change_8to11);
+	if (slave_stat) {
+		for (dev_index = 0; dev_index <= SDW_MAX_DEVICES; ++dev_index) {
+			if (slave_stat & AMD_SDW_MCP_SLAVE_STATUS_VALID_MASK(dev_index)) {
+				val = (slave_stat >> AMD_SDW_MCP_SLAVE_STAT_SHIFT_MASK(dev_index)) &
+				      AMD_SDW_MCP_SLAVE_STATUS_MASK;
+				amd_sdw_fill_slave_status(amd_manager, dev_index, val);
+			}
+		}
+	}
+}
+
+static void amd_sdw_irq_thread(struct work_struct *work)
+{
+	struct amd_sdw_manager *amd_manager =
+			container_of(work, struct amd_sdw_manager, amd_sdw_irq_thread);
+
+	switch (amd_manager->acp_rev) {
+	case ACP63_PCI_REV_ID:
+	case ACP70_PCI_REV_ID:
+	case ACP71_PCI_REV_ID:
+	case ACP72_PCI_REV_ID:
+		amd_acp63_sdw_irq_thread(amd_manager);
+		break;
+	default:
+		dev_err(amd_manager->dev, "unexpected acp_rev 0x%x\n", amd_manager->acp_rev);
+		return;
+	}
+}
+
+int amd_sdw_manager_start(struct amd_sdw_manager *amd_manager)
+{
+	struct sdw_master_prop *prop;
+	int ret;
+
+	prop = &amd_manager->bus.prop;
+	if (!prop->hw_disabled) {
+		ret = acp_sdw_clk_init_ctrl(amd_manager);
+		if (ret)
+			return ret;
+		ret = acp_init_sdw_manager(amd_manager);
+		if (ret)
+			return ret;
+		acp_enable_sdw_interrupts(amd_manager);
+		ret = acp_enable_sdw_manager(amd_manager);
+		if (ret)
+			return ret;
+		acp_sdw_set_frameshape(amd_manager);
+	}
+	/* Enable runtime PM */
+	pm_runtime_set_autosuspend_delay(amd_manager->dev, AMD_SDW_MASTER_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(amd_manager->dev);
+	pm_runtime_mark_last_busy(amd_manager->dev);
+	pm_runtime_set_active(amd_manager->dev);
+	pm_runtime_enable(amd_manager->dev);
+	return 0;
+}
+
+/*
+ * AMD SoundWire clock-stop sequence shared across all ACP revisions.
+ * Differences between revisions in this path are minimal; a switch/case
+ * on acp_rev is sufficient to accommodate any variant-specific additions
+ * needed for future platforms.
+ */
+int amd_sdw_clock_stop(struct amd_sdw_manager *amd_manager)
+{
+	u32 val;
+	int ret;
+
+	ret = sdw_bus_prep_clk_stop(&amd_manager->bus);
+	if (ret < 0 && ret != -ENODATA) {
+		dev_err(amd_manager->dev, "prepare clock stop failed %d", ret);
+		return 0;
+	}
+	ret = sdw_bus_clk_stop(&amd_manager->bus);
+	if (ret < 0 && ret != -ENODATA) {
+		dev_err(amd_manager->dev, "bus clock stop failed %d", ret);
+		return 0;
+	}
+
+	ret = readl_poll_timeout(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL, val,
+				 (val & AMD_SDW_CLK_STOP_DONE), ACP_DELAY_US, AMD_SDW_TIMEOUT);
+	if (ret) {
+		dev_err(amd_manager->dev, "SDW%x clock stop failed\n", amd_manager->instance);
+		return 0;
+	}
+
+	amd_manager->clk_stopped = true;
+	if (amd_manager->wake_en_mask)
+		writel(0x01, amd_manager->acp_mmio + ACP_SW_WAKE_EN(amd_manager->instance));
+
+	dev_dbg(amd_manager->dev, "SDW%x clock stop successful\n", amd_manager->instance);
+	return 0;
+}
+
+static int amd_resume_child_device(struct device *dev, void *data)
+{
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	int ret;
+
+	if (!slave->probed) {
+		dev_dbg(dev, "skipping device, no probed driver\n");
+		return 0;
+	}
+	if (!slave->dev_num_sticky) {
+		dev_dbg(dev, "skipping device, never detected on bus\n");
+		return 0;
+	}
+	ret = pm_request_resume(dev);
+	if (ret < 0) {
+		dev_err(dev, "pm_request_resume failed: %d\n", ret);
+		return ret;
+	}
+	return 0;
+}
+
+static int __maybe_unused amd_pm_prepare(struct device *dev)
+{
+	struct amd_sdw_manager *amd_manager = dev_get_drvdata(dev);
+	struct sdw_bus *bus = &amd_manager->bus;
+	int ret;
+
+	if (bus->prop.hw_disabled) {
+		dev_dbg(bus->dev, "SoundWire manager %d is disabled, ignoring\n",
+			bus->link_id);
+		return 0;
+	}
+	/*
+	 * When multiple peripheral devices connected over the same link, if SoundWire manager
+	 * device is not in runtime suspend state, observed that device alerts are missing
+	 * without pm_prepare on AMD platforms in clockstop mode0.
+	 */
+	if (amd_manager->power_mode_mask) {
+		ret = pm_runtime_resume(dev);
+		if (ret < 0) {
+			dev_err(bus->dev, "pm_runtime_resume failed: %d\n", ret);
+			return 0;
+		}
+	}
+	/* To force peripheral devices to system level suspend state, resume the devices
+	 * from runtime suspend state first. Without that unable to dispatch the alert
+	 * status to peripheral driver during system level resume as they are in runtime
+	 * suspend state.
+	 */
+	ret = device_for_each_child(bus->dev, NULL, amd_resume_child_device);
+	if (ret < 0)
+		dev_err(dev, "amd_resume_child_device failed: %d\n", ret);
+	return 0;
+}
+
+int amd_sdw_host_wake_enable_by_rev(struct amd_sdw_manager *amd_manager, bool enable)
+{
+	switch (amd_manager->acp_rev) {
+	case ACP63_PCI_REV_ID:
+		break;
+	case ACP70_PCI_REV_ID:
+	case ACP71_PCI_REV_ID:
+	case ACP72_PCI_REV_ID:
+		return acp_sdw_host_wake_enable(amd_manager, enable);
+	default:
+		dev_err(amd_manager->dev, "unexpected acp_rev 0x%x\n", amd_manager->acp_rev);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int __maybe_unused amd_suspend(struct device *dev)
+{
+	return acp_sdw_suspend(dev);
+}
+
+static int __maybe_unused amd_suspend_runtime(struct device *dev)
+{
+	return acp_sdw_suspend_runtime(dev);
+}
+
+static int __maybe_unused amd_resume_runtime(struct device *dev)
+{
+	return acp_sdw_resume_runtime(dev);
+}
+
+static int amd_sdw_manager_probe(struct platform_device *pdev)
+{
+	const struct acp_sdw_pdata *pdata = pdev->dev.platform_data;
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	struct sdw_master_prop *prop;
+	struct amd_sdw_manager *amd_manager;
+	int ret;
+
+	amd_manager = devm_kzalloc(dev, sizeof(struct amd_sdw_manager), GFP_KERNEL);
+	if (!amd_manager)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENOMEM;
+
+	amd_manager->acp_mmio = devm_ioremap(dev, res->start, resource_size(res));
+	if (!amd_manager->acp_mmio) {
+		dev_err(dev, "mmio not found\n");
+		return -ENOMEM;
+	}
+	amd_manager->ping_slave_stat = U32_MAX;
+	amd_manager->instance = pdata->instance;
+	amd_manager->acp_sdw_lock = pdata->acp_sdw_lock;
+	amd_manager->acp_rev = pdata->acp_rev;
+	amd_manager->dev = dev;
+	amd_manager->bus.clk_stop_timeout = 200;
+	amd_manager->bus.link_id = amd_manager->instance;
+	ret = amd_sdw_hw_init_ops(amd_manager);
+	if (ret) {
+		dev_err(dev, "Failed to initialize hw ops (%d)\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Due to BIOS compatibility, the two links are exposed within
+	 * the scope of a single controller. If this changes, the
+	 * controller_id will have to be updated with drv_data
+	 * information.
+	 */
+	amd_manager->bus.controller_id = 0;
+	dev_dbg(dev, "acp_rev:0x%x\n", amd_manager->acp_rev);
+	switch (amd_manager->acp_rev) {
+	case ACP63_PCI_REV_ID:
+		switch (amd_manager->instance) {
+		case ACP_SDW0:
+			amd_manager->num_dout_ports = AMD_ACP63_SDW0_MAX_TX_PORTS;
+			amd_manager->num_din_ports = AMD_ACP63_SDW0_MAX_RX_PORTS;
+			break;
+		case ACP_SDW1:
+			amd_manager->num_dout_ports = AMD_ACP63_SDW1_MAX_TX_PORTS;
+			amd_manager->num_din_ports = AMD_ACP63_SDW1_MAX_RX_PORTS;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case ACP70_PCI_REV_ID:
+	case ACP71_PCI_REV_ID:
+	case ACP72_PCI_REV_ID:
+		amd_manager->num_dout_ports = AMD_ACP70_SDW_MAX_TX_PORTS;
+		amd_manager->num_din_ports = AMD_ACP70_SDW_MAX_RX_PORTS;
+		break;
+	default:
+		dev_err(dev, "unsupported ACP revision: 0x%x\n", amd_manager->acp_rev);
+		return -EINVAL;
+	}
+	amd_manager->max_ports = amd_manager->num_dout_ports + amd_manager->num_din_ports;
+
+	switch (amd_manager->acp_rev) {
+	case ACP63_PCI_REV_ID:
+	case ACP70_PCI_REV_ID:
+	case ACP71_PCI_REV_ID:
+	case ACP72_PCI_REV_ID:
+		amd_manager->mmio = amd_manager->acp_mmio +
+				    (amd_manager->instance * ACP63_SDW_MANAGER_REG_OFFSET);
+		amd_manager->bus.ops = &amd_acp63_sdw_ops;
+		amd_manager->bus.port_ops = &amd_acp63_sdw_port_ops;
+		amd_manager->bus.compute_params = &amd_acp63_sdw_compute_params;
+		amd_manager->port_offset_map = devm_kcalloc(dev, amd_manager->max_ports,
+							    sizeof(int), GFP_KERNEL);
+		if (!amd_manager->port_offset_map)
+			return -ENOMEM;
+		break;
+	default:
+		dev_err(dev, "unsupported ACP revision: 0x%x\n", amd_manager->acp_rev);
+		return -EINVAL;
+	}
+
+	prop = &amd_manager->bus.prop;
+	prop->mclk_freq = AMD_SDW_BUS_BASE_FREQ;
+
+	ret = sdw_bus_master_add(&amd_manager->bus, dev, dev->fwnode);
+	if (ret) {
+		dev_err(dev, "Failed to register SoundWire manager(%d)\n", ret);
+		return ret;
+	}
+	ret = amd_sdw_register_dais(amd_manager);
+	if (ret) {
+		dev_err(dev, "CPU DAI registration failed\n");
+		sdw_bus_master_delete(&amd_manager->bus);
+		return ret;
+	}
+	dev_set_drvdata(dev, amd_manager);
+	INIT_WORK(&amd_manager->amd_sdw_irq_thread, amd_sdw_irq_thread);
+	INIT_WORK(&amd_manager->amd_sdw_work, amd_sdw_update_slave_status_work);
+	return 0;
+}
+
+static void amd_sdw_manager_remove(struct platform_device *pdev)
+{
+	struct amd_sdw_manager *amd_manager = dev_get_drvdata(&pdev->dev);
+	int ret;
+
+	if (pm_runtime_enabled(&pdev->dev))
+		pm_runtime_disable(&pdev->dev);
+	acp_disable_sdw_interrupts(amd_manager);
+	cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
+	cancel_work_sync(&amd_manager->amd_sdw_work);
+	sdw_bus_master_delete(&amd_manager->bus);
+	ret = acp_disable_sdw_manager(amd_manager);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to disable device (%pe)\n", ERR_PTR(ret));
+}
+
+static const struct dev_pm_ops amd_pm = {
+	.prepare = amd_pm_prepare,
+	SET_SYSTEM_SLEEP_PM_OPS(amd_suspend, amd_resume_runtime)
+	SET_RUNTIME_PM_OPS(amd_suspend_runtime, amd_resume_runtime, NULL)
+};
+
+static struct platform_driver amd_sdw_driver = {
+	.probe	= &amd_sdw_manager_probe,
+	.remove = &amd_sdw_manager_remove,
+	.driver = {
+		.name	= "amd_sdw_manager",
+		.pm = &amd_pm,
+	}
+};
+module_platform_driver(amd_sdw_driver);
+
+MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
+MODULE_DESCRIPTION("AMD SoundWire driver");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.48.1

