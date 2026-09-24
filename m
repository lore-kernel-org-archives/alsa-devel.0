Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE954C98317
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Sep 2026 12:43:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 836A9601E0;
	Thu, 24 Sep 2026 14:42:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 836A9601E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790253781;
	bh=+xCrtj66QO9rWsMqb1rbHm7jKGK/4s3TdlGuqDRcMK0=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=j9TAuXKKLnKUqcu905aCUKp/U3toy0vthYWE6WHL6R1lFwfZgd8jCpyPSjFUapr8/
	 kxlsHcwK98BkgiZCsigklYyV1I6GfWLP4i5U+pWJyf2oBooZj+34Kz/ZU80w6FpLm1
	 Muphpnux9vlzsQNwtzbDaI43uQc8ggr7GcS+PMlE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ED4E3F80600; Thu, 24 Sep 2026 14:42:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 75F0AF80600;
	Thu, 24 Sep 2026 14:42:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3FBDEF8049C; Thu, 24 Sep 2026 14:42:19 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.69
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1790253737;
	b=NR9ss/mEDvi5C4fW2Pd3GpoFGbo5hJb6EQiiFbZgWdge6feBL9q6GLVwvt/9jHP95v8B
	 I4nkc/09LBS1e1CsQj/2A1z4eT+aAXGJ8FeOAIwWZRyZKvCbdd8v+NdR28Pwu+e/Ja+Si
	 uwb81rZIyKDtn0rd5wetksxxjmmSmNSzUJUX5IhunOKD3ciCFFmZC5t7dC99J/5nQhV4b
	 3ALjkUtsvwMNhHhz+mRbxhnZ5S2gK6MeMeeLqJmrTJxIF7NWqoTS/UBJUdETZKTof4KWg
	 J2bsTj5OnkPS8yeMN3OB+G1vyUjKDsCnni6VMH/VgajFq932eLAqDKIAIaJcCeAQ8kA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790253737;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+xCrtj66QO9rWsMqb1rbHm7jKGK/4s3TdlGuqDRcMK0=;
	b=EYS9LiffPGFOTLDipHoxAfRVVQY5VRkkDLCiy0eSLdNsPM/3fjp/KcgGOaWrv9fHnvim
	 UHV57Er1d5irD/rv9zRNghE8zD8fH1UKEYJBM5EuUIGF8YwFvHtXy5e+aEpY9u1R/XauI
	 WAbUshPId1ivQqIFFLCLPwDRrgqxUlSULUUbHN8jz/l7tgUgi1V3vohzoJKe8QkY0xTrN
	 tVKpECifprCtPmRo9WYEHBnLrKGGXofg7jdBSS6LmNYLYgh1i+AEJTt0AjaRBgVIBStlz
	 zP6dlD71ajWzI8owWAyzQUbe0hUzoac5kOJlX4ruU9grlJRngqd8ME43OYrif2iheTQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=jJjCF22u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.69
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010069.outbound.protection.outlook.com [52.101.56.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B0733F801F5
	for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2026 14:42:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0733F801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=jJjCF22u
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8YWbDgVPGJ6e7joaPE/GLktX6PghmUBtAqny3HSbko4y/Gi29GcD2mco9ujfxaSH0UNhWFchw/xocCFihoyiDBTLuzGqyWTy9Rw3QkRg2hE6k36YcNkEGgzerNjI1ecwLKlHHTEszWKJxXJ7L2u0i78b4WKWlQTNJXMmTiPTTpvQv5UdxLNhrr85niD7UvuXMjybOtmoPPek6x4o9bTOzKxteWuN88lL3lEwTsP9yw38GRdjBgrFT5YPV3fcJTYaiPv5gMBDzAMWbTUvm6Idz2AFJd1HiVWcQEj1dfpaGw6FaFneNsKDsqG4TLhocH7lxcS0xpnaCeJNNsZqNyDnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJuuMkonr8yu5W1VSdv3ft+cbnWiMd+NeijaBiM0Hfk=;
 b=QyxqKoTDo6VbegS9Sd/ZnD+Axzwe5QO+NuffJUv4CUToIOCbpab4KObnMW1oKV7rn/pOEQX9l/KtliwAGD0m4r23NlLzmhBJBaIUeW4bgZ6zc0JbPjOsju3cgp0K95FQj3UpDIwt9VsOp05gawGLXaRSlecMh2h1AeIba5El1vGAHu1m8fLhgVed7c1uh51N/o0K72Lhoieh8yDNot8gMj2ljZK9k0X5zZ3kN63yKJTsoXoHBq3kI+gw1P0v/8MhCKTsQRA786hpys06izEaDjHeFyIJNZdyXLahOjKmtOI+fuQlpscoxid9NLobkEEAKruQ1zmDYtJJn3Gvd+hL+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJuuMkonr8yu5W1VSdv3ft+cbnWiMd+NeijaBiM0Hfk=;
 b=jJjCF22uq2SOb46Rk/I7+Km5neTCwQ2HYvikVOWlg2tZQRqw2VzYj85F4axwxCZfA1KkYonSuRM9TtR0XExGk5zIvma/YZx2KA87nLgm8gaIu8sxgqvVannvEnv3hTlluWxeCgz6yqt5jQIIqVB3WlsRbhHtx0nICuK8EpZe2VI=
Received: from SJ0PR03CA0162.namprd03.prod.outlook.com (2603:10b6:a03:338::17)
 by DM4PR12MB7527.namprd12.prod.outlook.com (2603:10b6:8:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 12:42:11 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::85) by SJ0PR03CA0162.outlook.office365.com
 (2603:10b6:a03:338::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.11 via Frontend Transport; Thu,
 24 Sep 2026 12:42:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 12:42:10 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 07:42:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 07:42:09 -0500
Received: from amd-B550M-DS3H.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 24 Sep 2026 07:42:05 -0500
From: Syed Saba Kareem <syed.sabakareem@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <anson.tsao@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>, Syed Saba Kareem
	<Syed.SabaKareem@amd.com>, kernel test robot <lkp@intel.com>, "Venkata Prasad
 Potturu" <venkataprasad.potturu@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Randy Dunlap <rdunlap@infradead.org>, "open list:AMD ASoC
 DRIVERS" <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: acp: fix TAS2783 SoundWire codec unmet
 dependencies
Date: Thu, 24 Sep 2026 18:11:52 +0530
Message-ID: <20260924124205.3376083-1-syed.sabakareem@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|DM4PR12MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: 27abe038-f04b-49ea-1c69-08df1a394077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|13003099007|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	Gg3XyppgMfxM8+N31DQEIOPMNgazQ54m9M5zSfODSt9VGstiLzeoP0NFsb8F81IIqSKrLXVW0UMAlo7eFdORIdER1CWX5g4/KVFIW6w1kDZQHupREF4HReHpT8G8HXXVxam2Q3S/Azi79wpYTudaiXR4fTGuakJxUvBcx8r5GsDg0e4bMmOOgf40Hc8kwT4CX+Objm7LvTsHcY9qNQ8F1sJ1S2F4HyoVU9lJTvX5kpoqjkf+GZwZuCZz8WZG2AqxkKS/2e+q1XC3iO/IrBdyWhZqinJNnPjLV1TqZaJFu2h2LyJHv0ySIhu4O3v75Q+h+vgR2qii0HawkFdxu9NDFVxIzbzJNDPaCJdL/tpNeKkkHog1MBnhAfx6fjErxGbJpAuWPBFo5DHBMPpPhSiK3ppisZiZnkaUGzDBkcRjQUz4BaHPpcHMLku85Vl//o6OXZBDVXXgyutsG89KYqVS+yNnoOiUcJJvYvmIGviZEfx7Z7bjy9V326FecZ/qonFzbrSU5krtglnI438XmbtJ7yYxtEJYxymW4Ozm6RGZB/FFGsll+Os9vGeznVSYHSwW3IDCrCeKH0AK787W8Q1MrwNBxGjNns+XZYV14gqxwIGRqjcOb1HW5HKfeCgEArDltcYNuOUOfhZw5r6x2bi5wg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(13003099007)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	AjG5hZ1XyXwoLT34BmBY8G/cIAYd9e7CsXZZHQA9R26A/pymzxgW1iCwm0Mfl7Rkf20+3rD8rwR1P1SPEW2HIEo4yMkkXSQvkf/tCneoTQazBmMcU1WGTNjzR1sbzcS4ScH+G+/Xut51xbE9VVBg7DsON6luV5Q/oiZXa8+w2E5Ua97suCfhOd5KN00SPefbj/cHtiro8/gDftym78VeTNUeCmkchLrmk6u6Lfb706k/hFqvM9bUEdTYZzIotFQal+uCmr3tjSfcZN49A06vna1F5uSElKanu5J7Rdot04DncznljMA0vkctlQLdnvFtjXjpH9ek/P5xr/+fj5qo3XlkT2dBfA+pAss1Sd9TV875QCJ3v2UUfeeJwkNThvpfkUOKf6tO7I5TBwTNHQQqgOlyWw9Muky3uOnuq0YRKuNorBFZ4syRwCpvz9s4I5XO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 12:42:10.6231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 27abe038-f04b-49ea-1c69-08df1a394077
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7527
Message-ID-Hash: MRMHVNU2PMIUVXHDA35QNNKRGDZIMXOH
X-Message-ID-Hash: MRMHVNU2PMIUVXHDA35QNNKRGDZIMXOH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MRMHVNU2PMIUVXHDA35QNNKRGDZIMXOH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Syed Saba Kareem <Syed.SabaKareem@amd.com>

SND_SOC_AMD_LEGACY_SDW_MACH unconditionally selects SND_SOC_TAS2783_SDW,
but that codec depends on SND_SOC_SDCA and EFI in addition to SOUNDWIRE.
An unconditional select force-enables the codec even when those
dependencies are not met, which the kernel test robot reported as unmet
direct dependencies when EFI=n:

  WARNING: unmet direct dependencies detected for SND_SOC_TAS2783_SDW
    Depends on [n]: SOUND [=y] && SND [=y] && SND_SOC [=y] &&
      SOUNDWIRE [=y] && SND_SOC_SDCA [=y] && EFI [=n]
    Selected by [y]:
    - SND_SOC_AMD_LEGACY_SDW_MACH [=y] && ...

The other SoundWire codecs selected by this machine driver only depend
on SOUNDWIRE, which the driver already depends on, so they select
cleanly.  SND_SOC_TAS2783_SDW is the only one that additionally needs
the SDCA core and EFI (it reads speaker calibration data from EFI
variables).

SND_SOC_SDCA cannot simply be selected here, as that introduces a
recursive Kconfig dependency (SOUNDWIRE depends on SND_SOC_SDCA_OPTIONAL,
whose default pulls in SND_SOC_SDCA), and EFI is a platform feature that
must not be selected by a driver.  Instead, guard the select with the
missing dependencies so the codec is only (and always) built when they
are satisfied:

  select SND_SOC_TAS2783_SDW if SND_SOC_SDCA && EFI

This keeps the TAS2783 SoundWire codec built together with the machine
driver on platforms that can use it, while avoiding the unmet dependency
when SND_SOC_SDCA or EFI is disabled.

Fixes: 28114992dd2f ("ASoC: amd: acp: enable TAS2783 and add RT712-VB SoundWire machine")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202609182147.gfofWIXW-lkp@intel.com/
Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index e880e44b9763..6433876430f0 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -181,7 +181,7 @@ config SND_SOC_AMD_LEGACY_SDW_MACH
 	select SND_SOC_RT715_SDW
 	select SND_SOC_RT715_SDCA_SDW
 	select SND_SOC_RT722_SDCA_SDW
-	select SND_SOC_TAS2783_SDW
+	select SND_SOC_TAS2783_SDW if SND_SOC_SDCA && EFI
 	help
 	  This option enables Legacy(No DSP) sound card support for SoundWire
 	  enabled AMD platforms along with ACP PDM controller.
-- 
2.43.0

