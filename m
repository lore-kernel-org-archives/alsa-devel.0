Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFC7C43458
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:00:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 30CC66025B;
	Wed,  1 Jul 2026 12:00:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 30CC66025B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782900037;
	bh=M8Slm2Bx3gpbzqUOTP5FXMJlWD1KtXBRU0s11q8YqyI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=FEn+WQRXOPDNF4tdq73DQ8cfd6U56Sw6B1JnJWCO9k4pLSAcv+XW9Ksk1Y/lrX3up
	 VgqFtHUQNgsDPx7EgDCnsIj+jxNwTbPK361gEGPHn1dGWK0s29BlRrXNC7Ak2vCK3m
	 CAsgNX9QPtXcpsTrQg6jPnzzP8fHbVAFl62ZOxkE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 832DAF806AD; Wed,  1 Jul 2026 11:59:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 48D26F806A2;
	Wed,  1 Jul 2026 11:59:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1507FF8064C; Wed,  1 Jul 2026 11:58:54 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.65
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1782899928;
	b=J4sGZZP/edTsZtveMyPyBZ40fyyqVewhMgsre5bjZD31C3y4cmIJKiTA6LnGnyv5+Num
	 NBbWdvI0o+fAigJVsYeL3AKX44ETbsHAUjRoUNoeXPXngyduvJ3JpPRidSjOwYP4kRVUs
	 d8z86RAG8M3l/SjA+X4/thMab0s8rmCgD8OCiQfEIaVMK4xXjMIul9ZVoi5l2xe6dEChS
	 +79uf4VUD/EVUj8RF8oMP81z8hRXC9U50Xk3rajPOIk8kwMZlmA7mRDqOT1h/SyDxdyJm
	 GYq3MLeO4n+6Hfd7afQloyaymoFiKXjUPd0WGoAAcHcRqQhgb9AzSnHs1yAd2jASwAA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782899928;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=M8Slm2Bx3gpbzqUOTP5FXMJlWD1KtXBRU0s11q8YqyI=;
	b=RDKi5/cJNFLWrIrbHbKS5E6TXS+UqF+rry1gD+ne+735z4pS4t5OVpEUf7dwMpZzwRW3
	 TtQREAM7Er6j8uiUjq2Osu5pgdmUkmDsGcOA4uftRoCKVZjL0FIFe4UvAYbS6ReqMacdv
	 lDACm4vqxymtfXGQdrMS2y3QYzcSrMwmkwxMU/W1Zj6dAGcWnstCxh/j3iTry3iE75bST
	 xIrPJi+D8vNN0dzCBLfDJPyFnfHUzj4BoaO+miFlcgQ/P9+gzsCnCk5SBtOBfXRDiqWEO
	 lT7auuwKUL8Z/AKzu1M2CQzlpw0mHH7KLLpI84T84PkCb/kpZFQOz9bja7qfbsN0PRw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=JaQBHfuK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.65
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2F718F805FD;
	Wed,  1 Jul 2026 11:58:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F718F805FD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=JaQBHfuK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whRDFmUcGcGnjspzqklB+BdL3PHoWUFMLUPRtfRb4lbDtFb6tWgt7k3pUh6tR6/EpCA9rXhCKCxXhU6bb3wRv/62RjPRHg43w/q/6LWRIM6fS6QCOz5xdbshbJKSE7mORmhOjVQMiT50XZA6bpO1VFk/mh+g+QCLIaZgCmbSJvWIgwQwNlq39iDqyOXlJ4Vp6LP1d9o0bP6r1HVy3K0NxeJbyhBgeYqcQshmDMe3EfO6kZswaMLgh5KO7iqIWcHVL5Dnw5ctVBQOXvIKWuYiDWcy/pP43bZH5bV07m3AR6PcEdMDuwgonmA277S2hiqB/42pptbLFSixolbE/rGOgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMyVCoZF2MI5YlpZXazpL9EYZQ430erIx6DVcndn2tQ=;
 b=SQzHgH4XfSkojvwyqmCpGaTQAWcTQ1t5dVdmIfm1zKVnAjXNrvCIXbHR6snixl54MOj4t2KyOTTXmjQ9zkDxH3oMFknLepNcTO57+iPBCUtopk/B9N/jTZlG5U9X+cW2w3W3O3EZ/Ftf753ZD1kC6shTDhF2OiIeRPTsxghzNqHoj8qFz5qVFLu/9TqVV0s4LBudD6LzB3uSy8gOweSFh4+4DLl0mue0YSTd9c3cGNlLtzAb3SZQNgxwdXSFaAb5WFvp0+ipwI/83szFqp1LSNvhp1gXTGrzFe1NEPfxaA5tj/Y2FOo7lb8k+ZuwOUCHjHhPMxkAexbQN7wwhzmuAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMyVCoZF2MI5YlpZXazpL9EYZQ430erIx6DVcndn2tQ=;
 b=JaQBHfuKW18h9vF7KjWo8v9MqmL7uiAFuIRbOHCpXzjWTOZPMZxusTYjAHw+P51Lb2carcnTAm0cG83E2ASHFc03ZNMqh6GRQ08iFaGMC4ZSagzC/eWwwfZmyEY7s0W9dpuGUGCGJNr3FKQmc0HfzSrrjK4qYoR97PYOhNwByxA=
Received: from PH7P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::7)
 by IA0PPF7646FEBB5.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 09:58:37 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:510:33a:cafe::45) by PH7P222CA0016.outlook.office365.com
 (2603:10b6:510:33a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 09:58:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 09:58:36 +0000
Received: from vijendar-linux.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 04:58:31 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<perex@perex.cz>, <tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<mario.limonciello@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 02/16] ASoC: SOF: amd: add base platform support for
 ACP7.B/7.F
Date: Wed, 1 Jul 2026 15:25:03 +0530
Message-ID: <20260701095759.1012929-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260701095759.1012929-1-Vijendar.Mukunda@amd.com>
References: <20260701095759.1012929-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|IA0PPF7646FEBB5:EE_
X-MS-Office365-Filtering-Correlation-Id: b057c35a-5873-4708-ed94-08ded757516c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|82310400026|7416014|376014|1800799024|36860700016|18002099003|22082099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	mj48/JKEUMOxqOu5VuBbme5JLDwwzoYQF/6hSnO9l6mGvcvEBToldTvtSwa0ZSXY7y5jL5wWEuCeBbipM02sUiHYgXBYeeZxl7eGvdWPsQvXln72X6cxh7kTYsCcpIc1LP22mstC/EUnoVXCqS8CpZUu6uKhFASsGVyBxxOlcSg1XmcUenjDbwL9SF89LVfO7IaFGgW/5Htmq+iRlI+1yRiRv6J6xZVkEWOydX7dADwos8KCatnyfSL5mOIaB3Rcz5KswhHzqR3Jfcbot3KCujs8NHngBqluWhMoYHfSCe+I2E+K1+HQHRu7782UjvfVpGhSvKDrXxsJVIUvn2v5ho42GJIIhW04UCnPJlHITQ5wKQ1X5fzOC6VBf7IlhOsait4fuMvfwD11/Q3onfHuCPpuKj0zgdmhD69x/aXWKvBWCSeqzAn7/snrpTakhIe7NatHu7hwhrcI+yBbvKOYoeveBzzTKrM/lI+5RUCEm9/0D1HCG/qFJEE87twLZH5XBVCqN3dABmUM6wr3voJ958hk2hp6cEZKcqhZZGYJFQW4Y3UaQ7CBLcKDJZu5WFMBNv9D9KblyGjswkpQ5Pzl/gMpCQoNkzRvRPR6+oC/CQQuRkcuQq0Gprp3hcxqZTioXR3SoVWmG00wFM2yvQfhzyQnxnmLzqTPhDiq5krNrHg5vcDAjl+lqd/Mit1futAkZxxnmCWqtufi+eAp0dE/pw==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(7416014)(376014)(1800799024)(36860700016)(18002099003)(22082099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Fd5+fUxGwiGvGeQoVPIr0hZt5uOEMja6W3s6ZjK4jpqMQGzw8zZyT68oLOlQiBLuSOktcMcsv9bCWq/Pwwih7QorTE2f9nmur4pv+iK8uWjxUHP0izeY6qhTW/7Eyw9sN9wsInbkT1h+YF+Hs1N3R+XzwoOk1qtKvDe8drESpO7O2wip62TKsLm+AfpTbfmKPD4YTM7gzB6qG5896uzhsVqIYAXZCr7k7oMyhPoaq+uzJwocD879ZEbxFlG394vKZhoFu/iuiiRVj5VpXj+3dFDsIt9KUpaHSkCwLpKJ3jO+Xl288FxFPl9CjTrVRGHyxIKU7V3TywVh2knE8t9OTrGUFmZQcvhLstfnGb6z9/oRiySNcmvDcVGJ5qmUVNMDBxSMcpaOzk4f54dZ4feZ1qQtPpfOmkjzil7ZPWCYERAXXsfulQN9imS6u3dKMMyV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 09:58:36.0777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b057c35a-5873-4708-ed94-08ded757516c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF7646FEBB5
Message-ID-Hash: NY2RDO62WJFJDNIE2KTA3UQ4YW6V7XZ2
X-Message-ID-Hash: NY2RDO62WJFJDNIE2KTA3UQ4YW6V7XZ2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NY2RDO62WJFJDNIE2KTA3UQ4YW6V7XZ2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add SOF support for ACP7.B and ACP7.F PCI revision based platforms.
This covers Kconfig/Makefile entries, register offset definitions,
DMA descriptor/channel/status paths, PGFSM power-on handling,
PCI device driver, I2S/DMIC DAI definitions, and IPC SW interrupt
trigger offset selection for ACP7.B/7.F.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/amd/Kconfig          |  10 ++
 sound/soc/sof/amd/Makefile         |   2 +
 sound/soc/sof/amd/acp-dsp-offset.h |  17 ++++
 sound/soc/sof/amd/acp-ipc.c        |  15 ++-
 sound/soc/sof/amd/acp.c            |  23 ++++-
 sound/soc/sof/amd/acp.h            |   9 ++
 sound/soc/sof/amd/acp7x.c          | 142 +++++++++++++++++++++++++++++
 sound/soc/sof/amd/pci-acp7x.c      | 116 +++++++++++++++++++++++
 8 files changed, 330 insertions(+), 4 deletions(-)
 create mode 100644 sound/soc/sof/amd/acp7x.c
 create mode 100644 sound/soc/sof/amd/pci-acp7x.c

diff --git a/sound/soc/sof/amd/Kconfig b/sound/soc/sof/amd/Kconfig
index 05faf1c6d6fc..7413bfdb0943 100644
--- a/sound/soc/sof/amd/Kconfig
+++ b/sound/soc/sof/amd/Kconfig
@@ -103,5 +103,15 @@ config SND_SOC_SOF_AMD_ACP70
 	  Select this option for SOF support on
 	  AMD ACP7.0/ACP7.1 version based platforms.
 	  Say Y if you want to enable SOF on ACP7.0/ACP7.1 based platforms.
+config SND_SOC_SOF_AMD_ACP7X
+	tristate "SOF support for ACP7.B/7.F platforms"
+	depends on SND_SOC_SOF_PCI
+	depends on AMD_NODE
+	select SND_SOC_SOF_AMD_COMMON
+	help
+	  Select this option for SOF support on AMD ACP7.B and ACP7.F PCI
+	  revision based platforms.
+	  Say Y if you want to enable SOF on ACP7.B/7.F based platforms.
+	  If unsure select "N".
 
 endif
diff --git a/sound/soc/sof/amd/Makefile b/sound/soc/sof/amd/Makefile
index 6ae39fd5a836..bb1c0ddef69d 100644
--- a/sound/soc/sof/amd/Makefile
+++ b/sound/soc/sof/amd/Makefile
@@ -11,6 +11,7 @@ snd-sof-amd-rembrandt-y := pci-rmb.o rembrandt.o
 snd-sof-amd-vangogh-y := pci-vangogh.o vangogh.o
 snd-sof-amd-acp63-y := pci-acp63.o acp63.o
 snd-sof-amd-acp70-y := pci-acp70.o acp70.o
+snd-sof-amd-acp7x-y := pci-acp7x.o acp7x.o
 
 obj-$(CONFIG_SND_SOC_SOF_AMD_COMMON) += snd-sof-amd-acp.o
 obj-$(CONFIG_SND_SOC_SOF_AMD_RENOIR) += snd-sof-amd-renoir.o
@@ -18,3 +19,4 @@ obj-$(CONFIG_SND_SOC_SOF_AMD_REMBRANDT) += snd-sof-amd-rembrandt.o
 obj-$(CONFIG_SND_SOC_SOF_AMD_VANGOGH) += snd-sof-amd-vangogh.o
 obj-$(CONFIG_SND_SOC_SOF_AMD_ACP63) += snd-sof-amd-acp63.o
 obj-$(CONFIG_SND_SOC_SOF_AMD_ACP70) += snd-sof-amd-acp70.o
+obj-$(CONFIG_SND_SOC_SOF_AMD_ACP7X) += snd-sof-amd-acp7x.o
diff --git a/sound/soc/sof/amd/acp-dsp-offset.h b/sound/soc/sof/amd/acp-dsp-offset.h
index 08583a91afbc..bea1bd3afa70 100644
--- a/sound/soc/sof/amd/acp-dsp-offset.h
+++ b/sound/soc/sof/amd/acp-dsp-offset.h
@@ -68,12 +68,14 @@
 #define ACP5X_PGFSM_BASE			0x1424
 #define ACP6X_PGFSM_BASE                        0x1024
 #define ACP70_PGFSM_BASE                        ACP6X_PGFSM_BASE
+#define ACP7X_PGFSM_BASE                        ACP6X_PGFSM_BASE
 #define PGFSM_CONTROL_OFFSET			0x0
 #define PGFSM_STATUS_OFFSET			0x4
 #define ACP3X_CLKMUX_SEL			0x1424
 #define ACP5X_CLKMUX_SEL			0x142C
 #define ACP6X_CLKMUX_SEL			0x102C
 #define ACP70_CLKMUX_SEL			ACP6X_CLKMUX_SEL
+#define ACP7X_CLKMUX_SEL			ACP6X_CLKMUX_SEL
 
 /* Registers from ACP_INTR block */
 #define ACP3X_EXT_INTR_STAT			0x1808
@@ -86,21 +88,31 @@
 #define ACP70_EXTERNAL_INTR_CNTL		ACP6X_EXTERNAL_INTR_CNTL
 #define ACP70_EXT_INTR_STAT			ACP6X_EXT_INTR_STAT
 #define ACP70_EXT_INTR_STAT1			ACP6X_EXT_INTR_STAT1
+#define ACP7X_EXTERNAL_INTR_ENB			ACP6X_EXTERNAL_INTR_ENB
+#define ACP7X_EXTERNAL_INTR_CNTL		0x1A04
+#define ACP7X_EXT_INTR_STAT			0x1A1C
+#define ACP7X_EXTERNAL_INTR_CNTL1		0x1A08
+#define ACP7X_EXT_INTR_STAT1			0x1A20
 
 #define ACP3X_DSP_SW_INTR_BASE			0x1814
 #define ACP5X_DSP_SW_INTR_BASE			0x1814
 #define ACP6X_DSP_SW_INTR_BASE                  0x1808
 #define ACP70_DSP_SW_INTR_BASE			ACP6X_DSP_SW_INTR_BASE
+#define ACP7X_DSP_SW_INTR_BASE			0x1860
 #define DSP_SW_INTR_CNTL_OFFSET			0x0
 #define DSP_SW_INTR_STAT_OFFSET			0x4
+#define ACP7X_DSP_SW_INTR_STAT			(ACP7X_DSP_SW_INTR_BASE + DSP_SW_INTR_STAT_OFFSET)
 #define DSP_SW_INTR_TRIG_OFFSET			0x8
+#define ACP7X_DSP_SW_INTR_TRIG_OFFSET		0x30
 #define ACP3X_ERROR_STATUS			0x18C4
 #define ACP6X_ERROR_STATUS			0x1A4C
 #define ACP70_ERROR_STATUS			ACP6X_ERROR_STATUS
+#define ACP7X_ERROR_STATUS			0x1A88
 #define ACP3X_AXI2DAGB_SEM_0			0x1880
 #define ACP5X_AXI2DAGB_SEM_0			0x1884
 #define ACP6X_AXI2DAGB_SEM_0			0x1874
 #define ACP70_AXI2DAGB_SEM_0			ACP6X_AXI2DAGB_SEM_0
+#define ACP7X_AXI2DAGB_SEM_0			0x18F4
 
 /* ACP common registers to report errors related to I2S & SoundWire interfaces */
 #define ACP3X_SW_I2S_ERROR_REASON		0x18C8
@@ -123,6 +135,7 @@
 #define ACP_SCRATCH_REG_0			0x10000
 #define ACP6X_DSP_FUSION_RUNSTALL		0x0644
 #define ACP70_DSP_FUSION_RUNSTALL		ACP6X_DSP_FUSION_RUNSTALL
+#define ACP7X_DSP_FUSION_RUNSTALL		ACP6X_DSP_FUSION_RUNSTALL
 
 /* Cache window registers */
 #define ACP_DSP0_CACHE_OFFSET0			0x0420
@@ -139,5 +152,9 @@
 #define ACP70_SDW1_HOST_WAKE_STAT		BIT(25)
 #define ACP70_SDW0_PME_STAT			BIT(26)
 #define ACP70_SDW1_PME_STAT			BIT(27)
+#define ACP7X_DSP0_IDMA_ERROR_MASK		0x4B0
+#define ACP7X_IDMA_ERROR_MASK			0x1FF9FF
+#define ACP7X_ZSC_DSP_CTRL			0x001014
+#define ACP7X_PME_EN				ACP70_PME_EN
 
 #endif
diff --git a/sound/soc/sof/amd/acp-ipc.c b/sound/soc/sof/amd/acp-ipc.c
index 94025bc799ea..494f9cb0c06f 100644
--- a/sound/soc/sof/amd/acp-ipc.c
+++ b/sound/soc/sof/amd/acp-ipc.c
@@ -32,11 +32,20 @@ static void acpbus_trigger_host_to_dsp_swintr(struct acp_dev_data *adata)
 	struct snd_sof_dev *sdev = adata->dev;
 	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
 	u32 swintr_trigger;
-
+	unsigned int swintr_trigger_reg_offset;
+
+	switch (adata->pci_rev) {
+	case ACP7B_PCI_ID:
+	case ACP7F_PCI_ID:
+		swintr_trigger_reg_offset = ACP7X_DSP_SW_INTR_TRIG_OFFSET;
+		break;
+	default:
+		swintr_trigger_reg_offset = DSP_SW_INTR_TRIG_OFFSET;
+	}
 	swintr_trigger = snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->dsp_intr_base +
-						DSP_SW_INTR_TRIG_OFFSET);
+						swintr_trigger_reg_offset);
 	swintr_trigger |= 0x01;
-	snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->dsp_intr_base + DSP_SW_INTR_TRIG_OFFSET,
+	snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->dsp_intr_base + swintr_trigger_reg_offset,
 			  swintr_trigger);
 }
 
diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index e6af8927baa0..bb3766aacf0e 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -60,6 +60,8 @@ static void init_dma_descriptor(struct acp_dev_data *adata)
 	case ACP70_PCI_ID:
 	case ACP71_PCI_ID:
 	case ACP72_PCI_ID:
+	case ACP7B_PCI_ID:
+	case ACP7F_PCI_ID:
 		acp_dma_desc_base_addr = ACP70_DMA_DESC_BASE_ADDR;
 		acp_dma_desc_max_num_dscr = ACP70_DMA_DESC_MAX_NUM_DSCR;
 		break;
@@ -101,6 +103,8 @@ static int config_dma_channel(struct acp_dev_data *adata, unsigned int ch,
 	case ACP70_PCI_ID:
 	case ACP71_PCI_ID:
 	case ACP72_PCI_ID:
+	case ACP7B_PCI_ID:
+	case ACP7F_PCI_ID:
 		acp_dma_cntl_0 = ACP70_DMA_CNTL_0;
 		acp_dma_ch_rst_sts = ACP70_DMA_CH_RST_STS;
 		acp_dma_dscr_err_sts_0 = ACP70_DMA_ERR_STS_0;
@@ -342,6 +346,8 @@ int acp_dma_status(struct acp_dev_data *adata, unsigned char ch)
 	case ACP70_PCI_ID:
 	case ACP71_PCI_ID:
 	case ACP72_PCI_ID:
+	case ACP7B_PCI_ID:
+	case ACP7F_PCI_ID:
 		acp_dma_ch_sts = ACP70_DMA_CH_STS;
 		break;
 	default:
@@ -595,6 +601,11 @@ static int acp_power_on(struct snd_sof_dev *sdev)
 		acp_pgfsm_status_mask = ACP70_PGFSM_STATUS_MASK;
 		acp_pgfsm_cntl_mask = ACP70_PGFSM_CNTL_POWER_ON_MASK;
 		break;
+	case ACP7B_PCI_ID:
+	case ACP7F_PCI_ID:
+		acp_pgfsm_status_mask = ACP7X_PGFSM_STATUS_MASK;
+		acp_pgfsm_cntl_mask = ACP7X_PGFSM_CNTL_POWER_ON_MASK;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -604,7 +615,8 @@ static int acp_power_on(struct snd_sof_dev *sdev)
 				  acp_pgfsm_cntl_mask);
 
 	ret = snd_sof_dsp_read_poll_timeout(sdev, ACP_DSP_BAR, base + PGFSM_STATUS_OFFSET, val,
-					    !val, ACP_REG_POLL_INTERVAL, ACP_REG_POLL_TIMEOUT_US);
+					    !val, ACP_REG_POLL_INTERVAL,
+					    ACP_REG_POLL_TIMEOUT_US);
 	if (ret < 0)
 		dev_err(sdev->dev, "timeout in ACP_PGFSM_STATUS read\n");
 
@@ -703,6 +715,13 @@ static int acp_init(struct snd_sof_dev *sdev)
 
 		snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP70_PME_EN, 1);
 		break;
+	case ACP7B_PCI_ID:
+	case ACP7F_PCI_ID:
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP7X_ZSC_DSP_CTRL, 0);
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP7X_PME_EN, 1);
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP7X_DSP0_IDMA_ERROR_MASK,
+				  ACP7X_IDMA_ERROR_MASK);
+		break;
 	}
 	return 0;
 }
@@ -749,6 +768,8 @@ int amd_sof_acp_suspend(struct snd_sof_dev *sdev, u32 target_state)
 	case ACP72_PCI_ID:
 		enable = true;
 		break;
+	default:
+		break;
 	}
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_CONTROL, enable);
 
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 7bcb76676a98..063aa41dd237 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -76,6 +76,12 @@
 #define ACP70_PCI_ID				0x70
 #define ACP71_PCI_ID				0x71
 #define ACP72_PCI_ID				0x72
+#define ACP7B_PCI_ID				0x7B
+#define ACP7F_PCI_ID				0x7F
+
+#define ACP7X_PGFSM_CNTL_POWER_ON_MASK		0x7F
+#define ACP7X_PGFSM_STATUS_MASK			0xFFF
+#define ACP7X_SRAM_PTE_OFFSET			ACP6X_SRAM_PTE_OFFSET
 
 #define HOST_BRIDGE_CZN				0x1630
 #define HOST_BRIDGE_VGH				0x1645
@@ -344,6 +350,9 @@ int sof_acp63_ops_init(struct snd_sof_dev *sdev);
 extern struct snd_sof_dsp_ops sof_acp70_ops;
 int sof_acp70_ops_init(struct snd_sof_dev *sdev);
 
+extern struct snd_sof_dsp_ops sof_acp7x_ops;
+int sof_acp7x_ops_init(struct snd_sof_dev *sdev);
+
 struct snd_soc_acpi_mach *amd_sof_machine_select(struct snd_sof_dev *sdev);
 /* Machine configuration */
 int snd_amd_acp_find_config(struct pci_dev *pci);
diff --git a/sound/soc/sof/amd/acp7x.c b/sound/soc/sof/amd/acp7x.c
new file mode 100644
index 000000000000..87c70014d777
--- /dev/null
+++ b/sound/soc/sof/amd/acp7x.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license. When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2025 Advanced Micro Devices, Inc.
+//
+// Authors: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
+
+/*
+ * Hardware interface for Audio DSP on ACP7.B/7.F platforms
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pci.h>
+#include <sound/soc-acpi.h>
+
+#include "../ops.h"
+#include "../sof-audio.h"
+#include "acp.h"
+#include "acp-dsp-offset.h"
+
+#define I2S_TDM0_INSTANCE	0
+#define I2S_TDM1_INSTANCE	1
+#define I2S_TDM2_INSTANCE	2
+#define PDM0_DMIC_INSTANCE	3
+#define PDM1_DMIC_INSTANCE	4
+
+static struct snd_soc_dai_driver acp7x_sof_dai[] = {
+	[I2S_TDM0_INSTANCE] = {
+		.id = I2S_TDM0_INSTANCE,
+		.name = "acp-sof-i2s0",
+		.playback = {
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			.channels_min = 2,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 96000,
+		},
+		.capture = {
+			.rates = SNDRV_PCM_RATE_8000_48000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			/* Supporting only stereo for I2S HS controller capture */
+			.channels_min = 2,
+			.channels_max = 2,
+			.rate_min = 8000,
+			.rate_max = 48000,
+		},
+	},
+
+	[I2S_TDM1_INSTANCE] = {
+		.id = I2S_TDM1_INSTANCE,
+		.name = "acp-sof-i2s1",
+		.playback = {
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			.channels_min = 2,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 96000,
+		},
+		.capture = {
+			.rates = SNDRV_PCM_RATE_8000_48000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			/* Supporting only stereo for I2S BT controller capture */
+			.channels_min = 2,
+			.channels_max = 2,
+			.rate_min = 8000,
+			.rate_max = 48000,
+		},
+	},
+
+	[I2S_TDM2_INSTANCE] = {
+		.id = I2S_TDM2_INSTANCE,
+		.name = "acp-sof-i2s2",
+		.playback = {
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			.channels_min = 2,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 96000,
+		},
+		.capture = {
+			.rates = SNDRV_PCM_RATE_8000_48000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+				   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+			/* Supporting only stereo for I2S SP controller capture */
+			.channels_min = 2,
+			.channels_max = 2,
+			.rate_min = 8000,
+			.rate_max = 48000,
+		},
+	},
+
+	[PDM0_DMIC_INSTANCE] = {
+		.id = PDM0_DMIC_INSTANCE,
+		.name = "acp-sof-dmic0",
+		.capture = {
+			.rates = SNDRV_PCM_RATE_8000_48000,
+			.formats = SNDRV_PCM_FMTBIT_S32_LE,
+			.channels_min = 2,
+			.channels_max = 4,
+			.rate_min = 8000,
+			.rate_max = 48000,
+		},
+	},
+
+	[PDM1_DMIC_INSTANCE] = {
+		.id = PDM1_DMIC_INSTANCE,
+		.name = "acp-sof-dmic1",
+		.capture = {
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = SNDRV_PCM_FMTBIT_S32_LE,
+			.channels_min = 2,
+			.channels_max = 4,
+			.rate_min = 8000,
+			.rate_max = 96000,
+		},
+	},
+};
+
+struct snd_sof_dsp_ops sof_acp7x_ops;
+EXPORT_SYMBOL_NS(sof_acp7x_ops, "SND_SOC_SOF_AMD_COMMON");
+
+int sof_acp7x_ops_init(struct snd_sof_dev *sdev)
+{
+	/* common defaults */
+	memcpy(&sof_acp7x_ops, &sof_acp_common_ops, sizeof(struct snd_sof_dsp_ops));
+
+	sof_acp7x_ops.drv = acp7x_sof_dai;
+	sof_acp7x_ops.num_drv = ARRAY_SIZE(acp7x_sof_dai);
+
+	return 0;
+}
diff --git a/sound/soc/sof/amd/pci-acp7x.c b/sound/soc/sof/amd/pci-acp7x.c
new file mode 100644
index 000000000000..532e15313795
--- /dev/null
+++ b/sound/soc/sof/amd/pci-acp7x.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license. When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2025 Advanced Micro Devices, Inc. All rights reserved.
+//
+// Authors: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
+
+/*
+ * PCI interface for ACP7.B/7.F devices
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <sound/sof.h>
+#include <sound/soc-acpi.h>
+
+#include "../ops.h"
+#include "../sof-pci-dev.h"
+#include "../../amd/mach-config.h"
+#include "acp.h"
+#include "acp-dsp-offset.h"
+
+#define ACP7X_FUTURE_REG_ACLK_0		0x18e0
+#define ACP7X_REG_START			0x1240000
+#define ACP7X_REG_END			0x125C000
+
+static const struct sof_amd_acp_desc acp7x_chip_info = {
+	.name		= "acp7x",
+	.pgfsm_base	= ACP7X_PGFSM_BASE,
+	.ext_intr_enb	= ACP6X_EXTERNAL_INTR_ENB,
+	.ext_intr_cntl	= ACP7X_EXTERNAL_INTR_CNTL,
+	.ext_intr_stat	= ACP7X_EXT_INTR_STAT,
+	.ext_intr_stat1	= ACP7X_EXT_INTR_STAT1,
+	.dsp_intr_base	= ACP7X_DSP_SW_INTR_BASE,
+	.acp_error_stat	= ACP7X_ERROR_STATUS,
+	.sram_pte_offset = ACP7X_SRAM_PTE_OFFSET,
+	.hw_semaphore_offset = ACP7X_AXI2DAGB_SEM_0,
+	.fusion_dsp_offset = ACP7X_DSP_FUSION_RUNSTALL,
+	.probe_reg_offset = ACP7X_FUTURE_REG_ACLK_0,
+	.reg_start_addr	= ACP7X_REG_START,
+	.reg_end_addr	= ACP7X_REG_END,
+};
+
+static const struct sof_dev_desc acp7x_desc = {
+	.machines		= snd_soc_acpi_amd_acp7x_sof_machines,
+	.resindex_lpe_base	= 0,
+	.resindex_pcicfg_base	= -1,
+	.resindex_imr_base	= -1,
+	.irqindex_host_ipc	= -1,
+	.chip_info		= &acp7x_chip_info,
+	.ipc_supported_mask	= BIT(SOF_IPC_TYPE_3),
+	.ipc_default		= SOF_IPC_TYPE_3,
+	.default_fw_path	= {
+		[SOF_IPC_TYPE_3] = "amd/sof",
+	},
+	.default_tplg_path	= {
+		[SOF_IPC_TYPE_3] = "amd/sof-tplg",
+	},
+	.default_fw_filename	= {
+		[SOF_IPC_TYPE_3] = "sof-acp7x.ri",
+	},
+	.nocodec_tplg_filename	= "sof-acp.tplg",
+	.ops			= &sof_acp7x_ops,
+	.ops_init		= sof_acp7x_ops_init,
+};
+
+static int acp7x_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
+{
+	unsigned int flag;
+
+	switch (pci->revision) {
+	case ACP7B_PCI_ID:
+	case ACP7F_PCI_ID:
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	flag = snd_amd_acp_find_config(pci);
+	if (flag != FLAG_AMD_SOF && flag != FLAG_AMD_SOF_ONLY_DMIC)
+		return -ENODEV;
+
+	return sof_pci_probe(pci, pci_id);
+}
+
+static void acp7x_pci_remove(struct pci_dev *pci)
+{
+	sof_pci_remove(pci);
+}
+
+/* PCI IDs */
+static const struct pci_device_id acp7x_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, ACP_PCI_DEV_ID),
+	.driver_data = (unsigned long)&acp7x_desc},
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, acp7x_pci_ids);
+
+/* pci_driver definition */
+static struct pci_driver snd_sof_pci_amd_acp7x_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = acp7x_pci_ids,
+	.probe = acp7x_pci_probe,
+	.remove = acp7x_pci_remove,
+	.driver = {
+		.pm = pm_ptr(&sof_pci_pm),
+	},
+};
+module_pci_driver(snd_sof_pci_amd_acp7x_driver);
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("ACP7X SOF Driver");
+MODULE_IMPORT_NS("SND_SOC_SOF_AMD_COMMON");
+MODULE_IMPORT_NS("SND_SOC_SOF_PCI_DEV");
-- 
2.45.2

