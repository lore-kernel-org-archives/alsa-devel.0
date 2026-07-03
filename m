Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFD6C43602
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jul 2026 12:34:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5D100601F6;
	Fri,  3 Jul 2026 14:34:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5D100601F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783082058;
	bh=S2Kpl9s3mFKp3lVIHtMDBPmg8t8k29mE3/mlGDx2qyw=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=dcPGZYhRZVFd0j9ShVk5gTOtMIGcyAl0RJNpCA+miZUFJ0bEuTlDD0BIS351x+NJH
	 YuJiJGVxXqozEC2HaA40RDUGKQBEiDzH56xxE3v9fJkmodCWys8zz/j0Gq+ISPk2b1
	 zIfYMofyRj49cL/vhW+CyJfGtu/KULlfYwfVdWWk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 24C2FF80600; Fri,  3 Jul 2026 14:33:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B82B1F805BA;
	Fri,  3 Jul 2026 14:33:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7052DF80579; Fri,  3 Jul 2026 14:33:36 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.27
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1783082012;
	b=bh26Lt7kXYErLYxJkQSDYOQeTnaxy6rOnGM9LTCMcgs8jkFm5qKbhW3twXrzsrt/EHbN
	 aoWVAjgtfbI+ENFj5jp0CHfg/Pj70uWH/ojN7ky1skqEhPZlEtTHJTvgKWVh6rwtn8zzu
	 cscsMxPjGbszTvROFvF63Gymb/+cG5yP9KXeuQxIfngzdaYmgzc4d/PoTXSDlKJT/CrNY
	 4ogbbS8o/O5QOjEwwbc+6tc465dUlBwzu7wKFYrSoRQgr14pDYzQCQDBvc9UClBXY5Ss6
	 tS9xi6vrbS8VCPO73P3OOdWuSfrT+41KGkFl9O+C4KzMzLHFETvTn+vEX/RwYQ/I9SQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783082012;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=S2Kpl9s3mFKp3lVIHtMDBPmg8t8k29mE3/mlGDx2qyw=;
	b=mXaZ5EGY+B2lPCzfut6EzRiTx0F822Pnuu670NbV89NQ6titH36T0ND5zfyrXpZfIAKw
	 60G1jnov7dfn+5qYupRcqKXeGhwuIVhvuCVmaQv03MSNY3eL52YmT6l3MIw8zXy50YOMi
	 jfK6qRk7be8gS3UvH00wS/JXxt/MOa1X0L0NyxPg8md94/48IiHZp/5hq2LSvs2GULMrZ
	 o2LDCPSKGCFwvGSDi7QD+qNdYLtuolkOt6sx2NytFZhA1ToYfG4Dsd2eVtT20Bi9fHkWC
	 SmJCQOxl56DfQlqfaIY3lv0AGXuMAnydM5KQ/Vn8P/ROHlKeILkGlVbHbUUQp1mgstQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=22LGmLjh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.27
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010027.outbound.protection.outlook.com
 [52.101.193.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E2857F8045D
	for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2026 14:33:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2857F8045D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=22LGmLjh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmCldXxMzbVBzlrXULhqdnK2+LCUGYDcGI14gjYYxZdkYaccN6fESOyz3dB055elwTEtbJoLYuu6Ib/G+znHKpmNS895D8o1XHPwnp0GiOHYDVn2Om2BK6fPoGv4Sec2xIj48W8fcs101OI7fZPg+1X+I/aENh4IBo8BCYGRa3rTal51W6bojKhnZFcWr60IgGcVZF5pEn4XVPR0H8zMr7IaKmwJbWYKSfwzZ1h/15NT6HkdXKpar4OYrOPkb8HgFVjeofcRmAj0DIBMxZV6grn6VNgt4zP4m8P+WYTJGwky8Pxd7nhYzEgoGnbreuX09Bw8NakCVvsad5lxT/gbtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAoxoj0ySMLbg/oR3nzaWb1393JCd8aGIMrhyBHf4L4=;
 b=bmiOqnR8pNpAfIZzylJ7bQNJLMFE6kLh1iNJM6Em8EYZw+1uU480Lp7wUvsDuEOLfGu8BvsgYSuEp5+OBwSuzcv6tKISZ31Q7qT9Y9rJ3+/P0rPX5NcawskcXYvATQ6LZ/Q4O09IcfrBqT1R/fn/cJ4sDWgJOxyAt2FN435w1bGGguk3g6tsm2Eu5QacVpI2zZZW4+6GeSGLGIMWm7ciWjcX9QXpMC26b0Z7esvRM8iPpmFpRR2YNERMwGtF2QPCxKlrPhjYhMIDwleFl5hEVWDhvWbd2FkcLdIHqwCuVkYdsgXeehgrL6a3LtgM0cGLzUdVefJPIXP/o9oJJIP7ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAoxoj0ySMLbg/oR3nzaWb1393JCd8aGIMrhyBHf4L4=;
 b=22LGmLjhginzwi0BIeOHm1rjCjHK+gItxVUlvcJU2GnZNiPoV8NscsszvmIVaYi6wH2EG+IjXzZWh2iL2jnTRZUqkJ1QjhzhyOgtn+crWcDmo32ijImnBFn56piKewlCwugo2EukNPCqMGyMG1pR1/P5o66UfckP+62CUnLxmIc=
Received: from SJ0PR03CA0197.namprd03.prod.outlook.com (2603:10b6:a03:2ef::22)
 by PH7PR12MB6609.namprd12.prod.outlook.com (2603:10b6:510:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 12:33:20 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::8d) by SJ0PR03CA0197.outlook.office365.com
 (2603:10b6:a03:2ef::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Fri, 3
 Jul 2026 12:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 12:33:20 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 3 Jul
 2026 07:33:19 -0500
Received: from amd-B550M-DS3H.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 3 Jul 2026 07:33:15 -0500
From: Syed Saba Kareem <syed.sabakareem@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <Sunil-kumar.Dommati@amd.com>, "Syed Saba
 Kareem" <Syed.SabaKareem@amd.com>, Arnd Bergmann <arnd@arndb.de>, "Venkata
 Prasad Potturu" <venkataprasad.potturu@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Simon Trimmer
	<simont@opensource.cirrus.com>, "Mario Limonciello (AMD)"
	<superm1@kernel.org>, Aleksander Pshenitsyn <brains.fatman@gmail.com>, "Hasun
 Park" <hasunpark@gmail.com>, "open list:AMD ASoC DRIVERS"
	<linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] ASoC: amd: acp: Fix linker error with SDCA quirks
Date: Fri, 3 Jul 2026 18:02:47 +0530
Message-ID: <20260703123314.147977-1-syed.sabakareem@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|PH7PR12MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 901e0424-1505-40e1-409b-08ded8ff440d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|36860700016|82310400026|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	VsYtdPyyM43DtlyEkAMq30qif8qnHmeUjpDGCH3Em1m7Tt58MVPETuMoiR3N+esb+7T6L0JGcHZoNmwD7A+yHl5D2cpVzD1IS1p1BAMMSuQI6k366JhZgadtCHzsROPrJfavY7Ml89xOdTmlomUOAXShY1bPVXpOBvD/CjvR++AtDa3ZGT9lgFFxQDRcSYzFygRX0NvSY6dsCewDaOjzTs58el0yg1NVfq4hcZFbs8NZV8UfOW7MIyy1j4PLQxP7cI+R70nCQXAc9fbINpWOwMJhFNw/uPR3vKvhcrKMmnIVspLZ6bV0Co5bR5f3EkusdzY2DOgVVjztfmly+vge1ewv+yRpvz3rN4fxJeYqPKS51+8T+vsrM7J7rmqbqtLE0Xfg9SDTUQx94zcoLykhtFhVTMG8XZcv4nh6hrfeZptHHuX5hnfvr8+xv2BLqADxtlTBCwLhTCpz5Y8B6bgBNlwiXtx9aHwxN0lj07t5pgFDGyLR2TxniI/c4UUA02jT4MSnf2PIFcWTPXjpT+jv4Lzs2BWcZsdjRH89ajQVVNBd6LmfHDpFIQJnzh9v0kbrIcGeIPYFUvw/16SDRPAb5xQT4VvEGgE/qCcmp1HbesQua/JLmKE+3QvdcdtahFrkJ537Fg5HJxOUDaC2azK5tBHuBtAlxFqGrUZ0K/AE6/agvCy7oXh6Ve9yj8pxRKvEjMGEFLNVdhgWw7+XYLZ9uA==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(36860700016)(82310400026)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	SNSyeUx1upb3fRBAqFXgun1/NVlStWIzY9Kd9J4Wq9dC2E3S6LXWDfzvppg8Z1xG7rVLvihWEHE7dmFU237O/9dHwwE0ZD84SVgCo5svngbvOd+yf3v8DBCxCqYgEPEfnWml6NmaCrwFBv+AfbIp4iZXVBJZIOLrTpHdk1XMoCoKThe8oaB+7GTIKjH7/r7FdhCRbMbSOcVTB2ykaertuNQEIFNmiNo5xr3Vnoq07Er8WgKAO30Rwk5zRO3ydidgfFVUVlG4ysfgZugyn16TKvbgmhMiXsEiUTTg+3LybZQLHlZVVj/mztBM19aemK91NWaVZf27TJ9s1UqFSTN2p7odQMzFcJgHg9zPdoW0SBConzPUZt7O1pjW16t8Y9Gtdtprc1RGJjXTs1gQaGC5h8hONco2cr5ER+gy7VYnwBaqa0JzNczaIQRzVTnDa/0m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 12:33:20.2160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 901e0424-1505-40e1-409b-08ded8ff440d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6609
Message-ID-Hash: WUMX7A3HI7UKCG4POIRJBFFK2KB3HOGX
X-Message-ID-Hash: WUMX7A3HI7UKCG4POIRJBFFK2KB3HOGX
X-MailFrom: Syed.SabaKareem@amd.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WUMX7A3HI7UKCG4POIRJBFFK2KB3HOGX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Syed Saba Kareem <Syed.SabaKareem@amd.com>

Fix undefined reference to `snd_soc_acpi_amd_sdca_is_device_rt712_vb`
linker error when CONFIG_SND_SOC_ACPI_AMD_MATCH=y and
CONFIG_SND_SOC_ACPI_AMD_SDCA_QUIRKS=m, which causes built-in code to
reference a symbol only available in a module.

Fix this by changing SND_SOC_ACPI_AMD_SDCA_QUIRKS from tristate to bool
and compiling the quirks code directly into snd-soc-acpi-amd-match
rather than as a separate module. This ensures the quirks symbols are
always available at link time when the match tables reference them.

Fixes: 10d366a846be ("ASoC: amd: acp: Fix Kconfig dependencies for SND_SOC_ACPI_AMD_SDCA_QUIRKS")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/Kconfig                    | 10 +++++++---
 sound/soc/amd/acp/Makefile                   |  3 +--
 sound/soc/amd/acp/amd-acp70-acpi-match.c     |  2 +-
 sound/soc/amd/acp/soc-acpi-amd-sdca-quirks.c |  4 ----
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index 977e4f2a7a70..a04c301df4d6 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -15,13 +15,17 @@ config SND_SOC_AMD_ACP_COMMON
 
 config SND_SOC_ACPI_AMD_MATCH
 	tristate
-        select SND_SOC_ACPI_AMD_SDCA_QUIRKS if SND_SOC_SDCA
         select SND_SOC_ACPI if ACPI
 
 config SND_SOC_ACPI_AMD_SDCA_QUIRKS
-	tristate
-	depends on ACPI
+	bool "AMD ACPI SDCA quirks"
+	depends on SND_SOC_ACPI_AMD_MATCH
 	depends on SND_SOC_SDCA
+	depends on SND_SOC_ACPI_AMD_MATCH = m || SND_SOC_SDCA = y
+	default y
+	help
+	  Enable SDCA quirk support for AMD ACPI match tables.
+	  This is compiled into the snd-soc-acpi-amd-match module.
 
 if SND_SOC_AMD_ACP_COMMON
 
diff --git a/sound/soc/amd/acp/Makefile b/sound/soc/amd/acp/Makefile
index 81d23aded348..ab5f9dc871a6 100644
--- a/sound/soc/amd/acp/Makefile
+++ b/sound/soc/amd/acp/Makefile
@@ -24,10 +24,10 @@ snd-acp-mach-y     := acp-mach-common.o
 snd-acp-legacy-mach-y     := acp-legacy-mach.o acp3x-es83xx/acp3x-es83xx.o
 snd-acp-sof-mach-y     := acp-sof-mach.o
 snd-soc-acpi-amd-match-y := amd-acp63-acpi-match.o amd-acp70-acpi-match.o
+snd-soc-acpi-amd-match-$(CONFIG_SND_SOC_ACPI_AMD_SDCA_QUIRKS) += soc-acpi-amd-sdca-quirks.o
 snd-acp-sdw-mach-y     := acp-sdw-mach-common.o
 snd-acp-sdw-sof-mach-y += acp-sdw-sof-mach.o
 snd-acp-sdw-legacy-mach-y += acp-sdw-legacy-mach.o
-snd-soc-acpi-amd-sdca-quirks-y += soc-acpi-amd-sdca-quirks.o
 
 obj-$(CONFIG_SND_SOC_AMD_ACP_PCM) += snd-acp-pcm.o
 obj-$(CONFIG_SND_SOC_AMD_ACP_I2S) += snd-acp-i2s.o
@@ -41,7 +41,6 @@ obj-$(CONFIG_SND_AMD_ASOC_REMBRANDT) += snd-acp-rembrandt.o
 obj-$(CONFIG_SND_AMD_ASOC_ACP63) += snd-acp63.o
 obj-$(CONFIG_SND_AMD_ASOC_ACP70) += snd-acp70.o
 
-obj-$(CONFIG_SND_SOC_ACPI_AMD_SDCA_QUIRKS) += snd-soc-acpi-amd-sdca-quirks.o
 obj-$(CONFIG_SND_AMD_SOUNDWIRE_ACPI) += snd-amd-sdw-acpi.o
 obj-$(CONFIG_SND_SOC_AMD_MACH_COMMON) += snd-acp-mach.o
 obj-$(CONFIG_SND_SOC_AMD_LEGACY_MACH) += snd-acp-legacy-mach.o
diff --git a/sound/soc/amd/acp/amd-acp70-acpi-match.c b/sound/soc/amd/acp/amd-acp70-acpi-match.c
index 18f2918d4ada..9e97a805d0df 100644
--- a/sound/soc/amd/acp/amd-acp70-acpi-match.c
+++ b/sound/soc/amd/acp/amd-acp70-acpi-match.c
@@ -775,5 +775,5 @@ MODULE_DESCRIPTION("AMD ACP7.0 & ACP7.1 tables and support for ACPI enumeration"
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
 #if IS_ENABLED(CONFIG_SND_SOC_ACPI_AMD_SDCA_QUIRKS)
-MODULE_IMPORT_NS("SND_SOC_ACPI_AMD_SDCA_QUIRKS");
+MODULE_IMPORT_NS("SND_SOC_SDCA");
 #endif
diff --git a/sound/soc/amd/acp/soc-acpi-amd-sdca-quirks.c b/sound/soc/amd/acp/soc-acpi-amd-sdca-quirks.c
index 63bf9e3c0ae1..9248b6d09e76 100644
--- a/sound/soc/amd/acp/soc-acpi-amd-sdca-quirks.c
+++ b/sound/soc/amd/acp/soc-acpi-amd-sdca-quirks.c
@@ -35,8 +35,4 @@ bool snd_soc_acpi_amd_sdca_is_device_rt712_vb(void *arg)
 
 	return false;
 }
-EXPORT_SYMBOL_NS(snd_soc_acpi_amd_sdca_is_device_rt712_vb, "SND_SOC_ACPI_AMD_SDCA_QUIRKS");
 
-MODULE_DESCRIPTION("ASoC ACPI AMD SDCA quirks");
-MODULE_LICENSE("GPL");
-MODULE_IMPORT_NS("SND_SOC_SDCA");
-- 
2.43.0

