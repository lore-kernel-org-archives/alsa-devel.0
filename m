Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1318DC43458
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jul 2026 10:30:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C0DD2601ED;
	Fri, 10 Jul 2026 12:30:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C0DD2601ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783679456;
	bh=iAhf50fQQCKgM/5js1zWE6521TBRbW1sa4W7yk2Xxs8=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=heyx5c8sctCuP6yXBfbShwxaXtpiHDK94hrv9axlN9/rMGy4V6v2ErVBwKboGqSYT
	 LCheF8c+9VeNFn+owWXogF6NARfG44bCX2kv+zFlJsAxaenz/F/2JrEMZ8lmDmBYzP
	 HMRnqW16WmXlmkcBe1x+4UJYuLiDdNJLutnrYBt0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CB6A1F805FE; Fri, 10 Jul 2026 12:30:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C8ABF8057E;
	Fri, 10 Jul 2026 12:30:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7EF70F8057E; Fri, 10 Jul 2026 12:30:16 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.17
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1783679412;
	b=YigpZmKPT+NXZ8nGS5dKL5ql8nVmru2Dhs9wZlUckMCs27Wl4Ra0IpIfqlpUmrXoXDQr
	 tv2iM7bBzwIKNDBAsDGtbpe1KAG1Mgjm/iIxCV1IZQjDp/cKP/BQczgD08fPA8jCp9GWf
	 BmCvhYQoAAoojyIh8nowsNHDiANAO40K1Nw4/SilcYAOzbiTNvkgfLW0dg8g5jZfKFokI
	 s/SH5Xidj3rZuBjmJ8oa/DC5pSB72B76x2VJq7Xu9yOX3tuDkxzXd476GCc3cR28c6CxD
	 QDMSkHI1LOyUSAimGoMenYvRtndy5XXJKwAewzMuygSnmZHp3CDkYFFyp56cnwpU8yw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783679412;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=iAhf50fQQCKgM/5js1zWE6521TBRbW1sa4W7yk2Xxs8=;
	b=AKVkDy+e+iaPWSsCbe/uGJl+csxe9fJFib/VOYWVIahEs2eOM3O4EEWFRm1fp+CGHr2L
	 UUdY4XW/soMzVBwaRH+9UcFbCdEMjv/FHpueFNFcoGuRBze5amUtS61+xNpYGHL16Zm5u
	 ON07P7qL+sQ3QMGaXz0rnsNym+vU/qY7TVSl+Bm7CvZQZBxbT0LtwVAQ348kihgIY8pkO
	 aoWGX3hJMw3gd55ZbBDPl6760ei/REZ/zP+LgMRGlZDmnRw+XV1MbidTU1sMcaan112ku
	 FHgdSbCFQhKNFdvbitL7dVZXxkmmf5rn0d96fP6n65MhjY59v89oqJd/YOVx6bju96g==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=2r+rUY9s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.17
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012017.outbound.protection.outlook.com [52.101.43.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2918BF80423
	for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2026 12:30:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2918BF80423
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=2r+rUY9s
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhdmC9608V6WYApTDrEx5AtCXOH+qlDWK1Ue8usaazM7kpx/OSlXQYmhZYT+o4LlYJjgS6hdi7berF5TQI6kzAk5OsTQpkBkgK+m8G05FmtNmw5E85g7jYLKlKwA//Ork6nHdYcm35Rx39rbKOoVeUFp4n207J3NMKLim77XKfSiJ4Xk6/XYam6F7Oj4lSFgZfCmKw0zz21cRbVzhkd9Sfluoa7t00Ww8HV5+81I+jgC4FsTz8mf4oxrPe3E4PNvY/zweeEnRvuZBNv3eX9HVxjsjELwAgDWUDdHMYpQg7hZNmmP9SDAkdcd6yjv3VnzNiVTmOTXcHXM+lutWUlTIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQrBue9TXY2L7Ym33UjjeSc0b/6V9HZFDcyVSm4P1FY=;
 b=y55vQBDV/w1QMzj6aQLMFtKEbRHv78WPaBe3XRLhVs7+Hq0sdJ4i7ErsI/8jw+p9nDwxPqvYj35rdBjqhyB5NkRR6Ktt/DzidUOsgu/ZTqgHjQFtLrppjgGwmxTv+Ah9nXxDgHEgkB2z7Fo2IC9t6D194ofRVXIVyDU7NM+tf3WoWZWAeKAlrM2/TA4ISPrKLkWItUgqYddaKLJcQwv6yj5XjqoUzaxGqCxIPmjwYJQnJd+Ugeydp1LqSBdJXoXbdWt4/+E3kQ23uxaRyasYLg/mfYp3nM1R5LbliD8LOfYfMjf29vRWFe+a2lYjzwH6meDPFKglsfGZjf6wRajwyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQrBue9TXY2L7Ym33UjjeSc0b/6V9HZFDcyVSm4P1FY=;
 b=2r+rUY9sUgSgbMjroq8KAXTKRKd/FhXjJTrpj0eI4XCYVFQhk/X7bDsG9FvO+GtZVgdLX5KCX287/f1aXoJijf0sGFfbyXWqmfK6Lj6X+NuEz5/eUCyo3xnqnjDcX1J0wX7JqFcBXEGqoWcHtu62FLYExBl4i6VInx9eClY43EA=
Received: from MN0PR05CA0007.namprd05.prod.outlook.com (2603:10b6:208:52c::9)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 10:30:04 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:52c:cafe::7) by MN0PR05CA0007.outlook.office365.com
 (2603:10b6:208:52c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.6 via Frontend Transport; Fri, 10
 Jul 2026 10:30:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 10:30:04 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 10 Jul
 2026 05:30:04 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 10 Jul
 2026 05:29:40 -0500
Received: from amd-B550M-DS3H.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 10 Jul 2026 05:29:32 -0500
From: Syed Saba Kareem <syed.sabakareem@amd.com>
To: Mark Brown <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Sunil-kumar Dommati
	<Sunil-kumar.Dommati@amd.com>, Syed Saba Kareem <syed.sabakareem@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>, Syed Saba Kareem
	<Syed.SabaKareem@amd.com>, Venkata Prasad Potturu
	<venkataprasad.potturu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "open
 list:AMD ASoC DRIVERS" <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: acp: add ACP70 DMI override for new ASUS TUF
 platforms
Date: Fri, 10 Jul 2026 15:59:19 +0530
Message-ID: <20260710102926.1633385-1-syed.sabakareem@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: e5227be7-469f-43a8-aaf9-08dede6e3483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|18002099003|11063799006|3023799007|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	NpgJBZfHkVY7T+4N0pPmuWJcsrIE9DwZkhypQqyTZakFFbRt4z5mcdte92sysc+wwOt28axLGobcy73LcAsr3BsD6GOw2ms7ksgWRk+t6uoO4OdIJKq+huXJWGYewZ53zviXj14pYyDGzCdSoNktLBHYc85bsosl1R0cXkWseT9ug3Y8R1ltwh2Zj5uZOs6ZOPFFzw8JHMG/sFSXjJ1Lxn6i18kZO2pNJVMEGRc75znngTDTdhJ+eEKBqujY2OsEO1xpOdNB2mIwWtUMHt2v4CB6sMYDdikbTMjK9bBMsOyD3odGTI9F0YWy3vGw4RJreXdevCkOaVTKz4pov9rr3RkeIRIkxdbxICsljgIegQNVwB99UEnCf2fqDqoOFZGB6s1O2qedmQUYr/KNbQ994mHBvEcd8OFytvLYvLvG9FRiMRj7wlS+KNvfECy/yqiTlu8YHZR2rQqHQ6t0KGu0TNMlGB630pJLzHek0RGevYB3bxEqli33wsoJfkTnbZ6ZR+k2ItZJUTn6KhtEkE/E0NXC1frHSthaLSmIpbffL/Tv4iGb0MuAOaBA5n4pSU/f/vCczBDjjqil0XLYf6xMuibkDfiN/syAbjY6N1qMvN35iMe1lJ1njgXSzKjVK1KTq3Hze1EBIYbr/Vpm2M5YbX42E8hs4Bxv8F8ipqvDjbxJpiV8kr8LGmrZhsv1JTl4cN7pEGQu1WpefWlQ+tAFMQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(18002099003)(11063799006)(3023799007)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Uc7fQAqZLuOBbttbe5SU5kpQYQ1EuOaX5LnMg/X+dTki9meXif/ugeMYFyX/+LLzxJctZV9tyy3JMPmBfnqgBt063M2CSfyi/BmSQ8079ckffz+Qrawbc3x+eWJUQdAVGpIZuF8e5gMDbTLKCkI1CM+8DlL3jAqRTgv2UojuPMpvH/uRH2BF5F3dTeAIQ8Ntyd0qs9QHjRVtL1XoPUbT3z6T7hr7gChE2jGELuF77MLIRCe5/ELj4ZRjqJ+FEADri/NkMKu/XI8Gq7QaeSA/WakCl5Wy4qwxz1y4h+l/+e6EcxnsOSnFXCqzvZzg7B9AAqUzQ/R9R3WW96bIJrsepQEdBSvjotHa4K5+2RqLPRyI/ZzVj552xvJ3wHf4F/5ISc4yUbLhauZ3LzUx+kRbb7uavcjYYv3tUmUI6LUV+uq/ScI8KC1PF0WYTqJVF6er
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 10:30:04.1652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e5227be7-469f-43a8-aaf9-08dede6e3483
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519
Message-ID-Hash: KN5I23J7S7OKPKBVLKT2NQB3NYBSGOIN
X-Message-ID-Hash: KN5I23J7S7OKPKBVLKT2NQB3NYBSGOIN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KN5I23J7S7OKPKBVLKT2NQB3NYBSGOIN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Syed Saba Kareem <Syed.SabaKareem@amd.com>

Some ASUS TUF ACP70-based systems expose ACP ACPI configuration flags
that select a non-working fallback audio path, similar to previously
affected ASUS platforms.

Add DMI-based overrides in snd_amd_acp_find_config() for the following
systems to skip ACP ACPI flag-based selection:

  - ASUS TUF Gaming Vivobook 18
  - ASUS TUF Gaming A14 FA401EA

This ensures the intended SoundWire-based machine driver is selected on
these platforms.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp-config.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/amd/acp-config.c b/sound/soc/amd/acp-config.c
index 93a2182d4e86..f4c1bae878c1 100644
--- a/sound/soc/amd/acp-config.c
+++ b/sound/soc/amd/acp-config.c
@@ -44,6 +44,18 @@ static const struct dmi_system_id acp70_acpi_flag_override_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "83W5"),
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TUF Gaming A14 FA401EA"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Vivobook 18 M1807GA"),
+		},
+	},
 	{}
 };
 
-- 
2.43.0

