Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF42CD4F26
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:44:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 25CD2601F6;
	Fri, 19 Jun 2026 14:44:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 25CD2601F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781873089;
	bh=K/mY1/3hx+4duxKs+PdrufkGRXY9heoUdPAtiJyitxE=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=oJhbbAzReQylqfuvQJQlt9+pX6VMCsATqvsAzJrluU3vI4lTTebrhaks2WS3wOPpA
	 ++MguMYD2fhoRTnR4TP8TRNorG3AQzyJoZGSdPGKqxsek7FAwDjJ5BrZZnGkV0S4iU
	 uQfs7noi1zZGUtUND0uvw4a/cuH7dS8wmYr4pTfU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A44CFF805F1; Fri, 19 Jun 2026 14:44:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B8B9F805EE;
	Fri, 19 Jun 2026 14:44:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E131EF80448; Fri, 19 Jun 2026 14:44:07 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.9
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1781873046;
	b=qbtEa8N9RgiA+bEkif9WceE29hUrLxQS9oz317AvHUnKlw1hsaUcAr9pJN464TiJKlCL
	 u40vfnhqMBE4IOP+ZO057G+V+4E1gdGOl9uzMwM9KaEWmomCIBh5R/7g59AhLRQO/kXf9
	 +slRfmwEtNOMVCuCssx7o6PpX6HBn9tq2rylEeIzNdkyWA4UP4JshGqoP9lFCA0v2G9v6
	 r9gb27UmeXB2YM4M/Wvp8fi4gJmRQMkz3vwozs0N96Wz/ovxWskSE+KmvG6nQ4jmaNnJ2
	 oqj57qhlCBupY7Y1E250PMEnMh0tbbOsOJDLULrsC3xUQDXLQvuxivJzBV1TgHZA3gw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781873046;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=K/mY1/3hx+4duxKs+PdrufkGRXY9heoUdPAtiJyitxE=;
	b=VIEjVBx9aNBHizkPyYlTGPRYD2MaN2Eyp0xQ6dquWLWY90bbNiubZzYQTOcwoKc65hUE
	 3M0lZ3KPpOoVweMGHc0zC7NXnf14KyfLsW+FmN+5WuRdB0RnmmUeXM6a7Vl+95xUyAs6u
	 +lXlW19UXN6iaNosPbBAD60AtYX2CFkWDNX75x24opkKgqKBWJbSZEwEuggqt88hLl+9A
	 eouI1U8Vb490eOUnng6p3cy9UUjWGPbT0jgwL5Ai/RBMyOZCllE4hTLBQjFUoFCZHjB/w
	 /CmR/VBHXy3Vg03p+cWNMJ9FH+KsTdlby3EtWFe3UMOl5jZrLzE42JpSHuqPr3nJUAA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=KrNsDgBm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.9
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010009.outbound.protection.outlook.com
 [40.93.198.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4DD99F80124
	for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2026 14:44:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4DD99F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=KrNsDgBm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s15qW7RpK2FJlSTxxeA1PZlXtD7jRBH8Ndx1Ob4GN04yzpxR9ZJXYFxZ9jkj317XLS5UckHTqMLjVCxXSKzlFaFI5bgnxmK5zrobWXh0/+Dovw7f6tF4tJXZ2e5m6MUEgFEDu3oqxFKISxD49mfRPlWzap3WhnqtOWqtcqMkDlXzA7XUPtREjkKaLH38bCZ2iNeYJgvfZbbAAaPLMFNFk633RPZQCx/tJ0laFgAabPT0VOQ5eWPCDclOkL6KLKiU0iamSfFYBS+x31Lp4mcRaGwf5wVCFbPkFauaRHhXEif6eusZHoim7cBo6Gvofzb7cXylqwzQl0Yk8j5pA/O6TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eigS1vO28hKHtUq/5DncjXy6Wviu1p2RH9A9PILUW7M=;
 b=zFVA9qONeIZIj2cJhMkkmelkiYKOX9ZU6zNOtP36hdKoYK6vcG0/2VSBiWuf//tOP0HXckQjdgzLe+NTFgpSklc4yJkcibpOxh3FpSIsXZeUzXVv0tOdesVPZN6/RhHCrhjVVxFP1+Oft51WH23ZFshIhEtJocTGJ7FWWik7+U52iCK8gYTca69Gj7cXh4ZaUgXRL1Ofag1vriYDgxkhp4Zk8RYYtmWX1bOmAb5G1LFaGOuq2ojk9VBFgsN7wacGyVZRFOcmtA/B1ye9ScA+pJsE+yRT2NXYR24GEiyBYAls0apXAFqpfEbshU59i8tG3z7Md699f/cFl4sWjEbn8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eigS1vO28hKHtUq/5DncjXy6Wviu1p2RH9A9PILUW7M=;
 b=KrNsDgBmtz+yIgILt2TZtG/3upR0B3j2SLqUAHiqw/6mk63IOvWEhTtSrTstgKR4Cqk3Dj1oZNKOxN9zjzyuBBmhEqYrESLAbOy8RPECDTb8ik7KkVvRUEOrqY7lA6yETscRjUOHciL38nyBlOJkB2bMH45JZ1Y+dj4TWDvi/OI=
Received: from SJ0PR03CA0088.namprd03.prod.outlook.com (2603:10b6:a03:331::33)
 by PH8PR12MB6817.namprd12.prod.outlook.com (2603:10b6:510:1c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 12:43:56 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::4) by SJ0PR03CA0088.outlook.office365.com
 (2603:10b6:a03:331::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Fri,
 19 Jun 2026 12:43:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 12:43:56 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 07:43:53 -0500
Received: from amd-B550M-DS3H.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 19 Jun 2026 07:43:44 -0500
From: Syed Saba Kareem <syed.sabakareem@amd.com>
To: Mark Brown <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Sunil-kumar Dommati
	<Sunil-kumar.Dommati@amd.com>, Arnd Bergmann <arnd@arndb.de>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Syed Saba Kareem
	<Syed.SabaKareem@amd.com>, Venkata Prasad Potturu
	<venkataprasad.potturu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Randy Dunlap
	<rdunlap@infradead.org>, Syed Saba Kareem <syed.sabakareem@amd.com>, "Simon
 Trimmer" <simont@opensource.cirrus.com>, "Mario Limonciello (AMD)"
	<superm1@kernel.org>, Hasun Park <hasunpark@gmail.com>, "open list:AMD ASoC
 DRIVERS" <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: acp: Fix linker error with SDCA quirks
Date: Fri, 19 Jun 2026 18:13:23 +0530
Message-ID: <20260619124343.1683484-1-syed.sabakareem@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|PH8PR12MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: ea14fa3d-f184-4d75-7238-08dece006d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|7416014|376014|82310400026|36860700016|1800799024|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	8HTn+CVEkeAvrEd0MhivmSeEl08+41cC2zLOwOPGK5aVRwGvm1zHKF/L/UTqPGlqYQX9MQJHo2U0/Y4gKqawW/IIb1XEfizqG3DK0Lqq6qU6gW4QCrC9l7YWyNtjIE7+4wOjT+k6kAC/3xv9Slq5MkuFKhM0Avx1XZO7xo8i6W4V60eUnE4pxRUnVgEVBmYxQ0Lko1MLzGhZsrUzIMZMKK+8hwdq7Azm1+vXqBcqyFAHf5FRM1lNjE9FNIYdoWXLAQ4Eg/hAlLachaHNjWli15o3bCa6W+UQr4yl1mDwmzYAh1c2jfjZdLq3foxF2L0JI3Sw81QjcbeCclmSUUMa+f8aMQ76EOds8c5jZFO/jpIFojX4zOcTeIVDsnUkW04LzcIsynTg7A4WhZcLWs8UUve0HyqEcT7ORlD20yfNf0A0m/QQBTXGwtreXOP8/17jzpVZpOVc9AKgPuu7V9hYh606zZ42xp3B0DTUKWKOQmpSKKsSsr4cpPvnd4fhUaESasws/cRW8UkTqsgi/Zk7yxaZ0Q+l+A5HhoiTQPa2F4BlACPEEdgHBBATSrCikEwIpQ6QJBlvaT3ylbEGuvjJY3yMtszzAQ1SJ52dm6gqJkyntIVgB1fPT91TPNx1yWpx0BQKd/MH38pmMu4wFKZCbNr0ib/CbA+EXBePhj7L3l97P6VlGnePMQlnMpgsK/ow9VGKaIKjgA4YIFqtX4HrfA==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(82310400026)(36860700016)(1800799024)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	6hsZoC0xKOIQXUF7HlMQnrN8IHGqOpjKOCG2mTSlfWae3yGG0MT27PbYfCTUsqB0lll5vqR38mAxDxqpW2IUV4zBtowhOdsfkRmQrujiP6Ltt+pgS6sRc3rx8L65H36Y4MdWSz2OkTSqHDzfxkxzhrRYWODdaIWNN6MV1h5Ltuisc6CNrbtItgD4mq6XlEfVLb6pAxavf1GU4GVLFGHpqwfb8mT5H1vATFg6UyxL9N84G91hRSttg1evqlTIHi6s8E7g7x8N0kkFKPVYQiGGXthgAF/y4JIfL9NZrMkRirYIXFYTosta1kOEGIk4GHi8mi3sYA+oTtT1SLBEflRTO9v1CywxTLDpGAhNtzur0t6ilPxOExMci+TFdBegAwHNPqJ0gXshoXgLUP9aplmNtbp+gjHMt3KrR/nJDnm7gpeQCgVKu3cBmGHviOHFBQQF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 12:43:56.1864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ea14fa3d-f184-4d75-7238-08dece006d51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6817
Message-ID-Hash: O43UPE35O5VUMSWYBB7EOF5BCEPOUJME
X-Message-ID-Hash: O43UPE35O5VUMSWYBB7EOF5BCEPOUJME
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/O43UPE35O5VUMSWYBB7EOF5BCEPOUJME/>
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
index 977e4f2a7a70..d3c860303a7d 100644
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
+        depends on SND_SOC_ACPI_AMD_MATCH = m || SND_SOC_SDCA = y
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
index 1ae43df5da6c..3782c7014655 100644
--- a/sound/soc/amd/acp/amd-acp70-acpi-match.c
+++ b/sound/soc/amd/acp/amd-acp70-acpi-match.c
@@ -731,5 +731,5 @@ MODULE_DESCRIPTION("AMD ACP7.0 & ACP7.1 tables and support for ACPI enumeration"
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

