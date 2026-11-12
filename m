Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EAC606A31C
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=DxJ94J5G;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=R76bWQkP
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8384460228;
	Thu, 12 Nov 2026 13:41:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8384460228
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794487294;
	bh=BAncrBsdNlNWzNdvwfDhlrjYFQfLOXCf3/Al1uQpYM4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=DxJ94J5GyJtDJ8oLXaW9we1YNnQNRdODsaLyYhlP2QHEJTECf/dP7ss/zSy9zPCx8
	 FyS+B6LVAMHc3VtfACPvnIX1shug5sPIahKhFfMPbVVdjYKkK9l6zjqa0kEoTJWip9
	 B4Z7y4lNC8tHtLAAe1a+PRonFahxaiVjYnU1OrYI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4CDC8F80604; Thu, 12 Nov 2026 13:40:59 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A9035F80600;
	Thu, 12 Nov 2026 13:40:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 12015F8016E; Thu, 12 Nov 2026 13:40:52 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.37
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1794487250;
	b=cLkXs1/2oufZhwjhzxXQP9oUEctiLAZduNZl+sMmg63mSyUR4bCUkQBas+YqoExQO1sQ
	 i7byoI+oEvWaa5fj3MvKzQIrjyet/8aUzyvPOBhP6iC6lw+XGtaNWwFxvaTe/kcX8lDUN
	 UVb/HbWs0Gtvitko0PfW0tKpKNJ8W8Y6eC68QeTJuNRsbrQrik7H5eL0esefoEGQq2/7o
	 E+kbrAfGvGHofWYuHYHziMBJ83HoFId5NaOAckoxroISQ31Fn3bZInIaEqhhjGc089Zli
	 /kfGorNlq5O4IQwoZuYtwTfNJ2eITVW2bfeD4/68mB0WLpw0gJ5zURaFkUIjfovA56w==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794487250;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=BAncrBsdNlNWzNdvwfDhlrjYFQfLOXCf3/Al1uQpYM4=;
	b=bSzqzFg5H7Snjepwyv1G/0uPa+XiH9xhjaG9UJRIprGWmdM2eFUrzQa/GQgVUnQR/Vhv
	 GQNghp4VbX3ZJklygnWXzeF1i7NDKDyvvp7IxhM6zqMjPvuiKOO5oetG8yhYckIFlxTJ3
	 PJ69B6CTetAOmqOsR3WK51FOiEUgQ7MWLiJpHlTuHZcDLyZ3AiLlG15HABOWiG5Tp+vJW
	 JQV+2axasSw6nb256IofylVRaCAurLXSmVZ7dGd2MWLLWSXxSldCy/rU6i3xnnNXO7R+o
	 jKEBA8SWQaeB94io9CQOfsKvlvod2jC8ytzu+pnP1aJ/nXPzsLWtAFh/Hh60RMv48dA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=R76bWQkP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.37
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013037.outbound.protection.outlook.com
 [40.107.201.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 16997F800DF
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2026 13:40:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 16997F800DF
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=R76bWQkP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lm7v6qZ3vRRvQbkYDFrOtqS7/LRnGlw0oooA6ZwGGu39qbUJRq8fDPgwGnRGYV7G2zUo4Q8p/FhQ8c/HgalOPbUAy4NUdoOO2CIhi5QLkli1GRyBzHFAZNbFOFP8SUlRYDAF3u+NTC3Nd+ZDzN9zY2r4rXVzo+G82ZMdBvt0ZNknvKWzjk4Q5dzp2OPif6ob5WdX53Dhtq4ZPts+EkUYkN9zHJqmC7ey/xyS27fq7paYqgO21QbNgSbvLH6o0ui0pNABMqzSQqJPRoBoYa+9Fmykc+abcPdeHBRR5T9x+IwSgvatcwSeTsFTpTHAPVGZt1KJgb/Qjj41F4YyyADaFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRkwHrPVos3vfZloaWmmzHjkqim7GMHw2Ljabh2N/78=;
 b=v41Id+eJadBDo7MoOIRJEAtF0vcKGtvlf+oHc0NRMW9q7mVcsATEp9IvpJ5phmfAGC9pkV4QQQ5tklH9WSXKslP/yYmClfskxxcVVHxb9pKGEkGXqEwgADmmu0KcaoJ1S3xySBa2bgCja9srMDGBtg9wkJv+boD/TNt6PyEXjhNoLygrAgwGPKk/3Y9RTTWUUi53RA6GXoJj6j3h/IUng7rFbBJZAQjLdEMrO/p/lE5hNuQmZ2mU978FLgxQrRjcdJ6R/napx9neL3me0+oEVAF23PocXItezsgxUBUkcqBIEve1NBXoQwYbpYfiHHbGewN+AwRbKWPS91jlmCB+DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRkwHrPVos3vfZloaWmmzHjkqim7GMHw2Ljabh2N/78=;
 b=R76bWQkPARIEMXC1b8ldQy38fRCb8EOBjCAqFxKtdcnvusRypSqNZ3+8ZCSIjw/TW6C/Cw/zGOmYg06AIqOkcXSxCSeoWogzN383i1kzx7F36D6pVl/iGgYl4jJvxigbf4JY0xdWkRXcvo4AL96cGKmD5cf5KeZ/iVx3hgXAgxQ=
Received: from CYZPR12CA0008.namprd12.prod.outlook.com (2603:10b6:930:8b::9)
 by DS0PR12MB7873.namprd12.prod.outlook.com (2603:10b6:8:142::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 12:36:47 +0000
Received: from PH3PEPF00059618.namprd05.prod.outlook.com
 (2603:10b6:930:8b:cafe::8b) by CYZPR12CA0008.outlook.office365.com
 (2603:10b6:930:8b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 12:36:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH3PEPF00059618.mail.protection.outlook.com (10.167.243.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 12:36:47 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 06:36:46 -0600
Received: from amd-B550M-DS3H.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 06:36:41 -0600
From: Syed Saba Kareem <syed.sabakareem@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <anson.tsao@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>, "Siva Subramanian
 Ravi Saravanan" <sravisar@amd.com>, Syed Saba Kareem
	<Syed.SabaKareem@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, "Jaroslav
 Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Venkata Prasad
 Potturu" <venkataprasad.potturu@amd.com>, Arnd Bergmann <arnd@arndb.de>,
	"Randy Dunlap" <rdunlap@infradead.org>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, open list <linux-kernel@vger.kernel.org>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
	<linux-sound@vger.kernel.org>
Subject: [PATCH v4 4/6] ASoC: amd: acp: add SOF function topology support
Date: Thu, 12 Nov 2026 18:05:39 +0530
Message-ID: <20261112123603.2891858-5-syed.sabakareem@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112123603.2891858-1-syed.sabakareem@amd.com>
References: <20261112123603.2891858-1-syed.sabakareem@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059618:EE_|DS0PR12MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d826f6d-1d1b-475e-4237-08df40b99df7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|7416014|23010399003|376014|22082099003|18002099003|6133799003|261009223027099003|10067099003|11063799006|261021123027099003|56012099006|261102123227099003|261028144727099003|261026121527099003|261022105027099003|261026140227099003|261022075727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: 
	VwocheUUtE7mlKK+sO27e1mFNc+I8mCGe7lb3mTdzPDcJDs6rjwMkRho7zSZfy/gbxFDodvmKRb9um7IEwYTtu8P6qWM6yTTwrCsCfI+oGBLJ7L+b1YJUT1IQxxNe+eeZ3jpmUxo/JQiVn1Ju2tiJRrV2MWDVpR7xw+nJGUelmkaWBLkQxL6qEnm2SCXn014XmmccFrrX6jl1pDZHag6AzCjPAbIOOJKUQugWPz/4Ujl3x7xljjHlX9OGVZItCa/KuxKJl0osyoWGXTIDJmI2k0bMIvPM94A0HFMxBAOAoDvUPHjYhoulWJ2Iy8slbprp8oUMl6a0r2tt0PLeZpwUROcq+2CdIzVVhfAsSNcH2t6bmxTJ/4Y9rs+xQoageuWi5othQ6Ueg+E6b+tcfhilbCRQvnDoaT7A/jyvxtDhEwL1Rh0YmPZuDBeXEKkeuuP7TRxtHBsuHmDdRc5+c6112kb3i182DaboDIu473KCotdYAGf/zVhTAPLkpZXVCDtLwbRQ00hSrPlOUPS42IF7pF1zesRgs/Lz7ZSkG797OXIbKn/3ZQWheuqqYvual3LOdCGQHkADQ77XNV+w5560pV7u5gtKovoj414Q4JCEH8LJI7UV1P2QsWn7rLY7Bjzv3hcqWqhp/ndd44os56B8i4C10GGYG7Ad81blvVmDXyNXxfSCm9Bu8YwUni5aXDuSmuON3zTOV5SYEQrnSWL0Q==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(261009223027099003)(10067099003)(11063799006)(261021123027099003)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261022105027099003)(261026140227099003)(261022075727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	C6xuU+wm1RjC0K8hnlMlmbImCB/mjXIPgXFYQtCVUwXNMaZVR2yaYzl7fralpz54XwIDHKAuEui26C0nV6qAHXM0IRF03rywwBM54FrZoLzWnRWtqyEi7AeWqAiFmG1bskbFKU3uxEU6ZRc8ouueLghKKKfAhq/Ug+cBRc2SEoWuJwcQcaNahhptQIez5tkvmLM6ycdRk/nG4Wx6gLUABjAB+7udjljK4VVofAzghyujKikfrLDArDyS9mnSsLzAQMm92L44bsOOn0EXwgJHr3RI3WmgYce8o/mxQXtO3hZ8xyg9I6oGrB1Oe6WlKIgQsIyF21a1KVN2hdjmkhhWZBy8Ri90LMNQiIovhisvFG/xIEw93Zzda+/z0HKMy/jADXy5Ozf6/e/VLqs7ErnnAQh4EhUB07rkjska+LNJzwj7fNbeIRoOhYrnjCq8FBt9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 12:36:47.2414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 5d826f6d-1d1b-475e-4237-08df40b99df7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	PH3PEPF00059618.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7873
Message-ID-Hash: TSMROI5GOYMHESTEF2SMJE3GG6K3MG5J
X-Message-ID-Hash: TSMROI5GOYMHESTEF2SMJE3GG6K3MG5J
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TSMROI5GOYMHESTEF2SMJE3GG6K3MG5J/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

From: Siva Subramanian Ravi Saravanan <sravisar@amd.com>

Add amd_sof_sdw_get_tplg_files() to build the list of SOF function
topologies from the card DAI links, so that a card can be formed from
per-function topologies instead of one monolithic topology per codec
configuration.

Add the ACP topology device IDs (SND_SOC_ACPI_TPLG_DEVICE_ACP_SDW_JACK,
SND_SOC_ACPI_TPLG_DEVICE_ACP_SDW_AMP, SND_SOC_ACPI_TPLG_DEVICE_ACP_SDW_MIC
and SND_SOC_ACPI_TPLG_DEVICE_ACP_DMIC) to enum snd_soc_acpi_tplg_device_id
and the corresponding cases to snd_soc_acpi_sof_get_tplg_filename(), as
these are used to construct the ACP SoundWire and PDM topology file names.

Size the platform-name buffer with the shared
SND_SOC_ACPI_SOF_PLATFORM_NAME_MAX constant from soc-acpi.h so that it
matches the buffer size required by snd_soc_acpi_sof_get_platform_name().

amd_sof_sdw_get_tplg_files() calls snd_soc_acpi_sof_get_platform_name()
and snd_soc_acpi_sof_get_tplg_filename() unconditionally, and these live
in soc-acpi.c which is built with SND_SOC_ACPI. Select SND_SOC_ACPI
unconditionally from SND_SOC_ACPI_AMD_MATCH, as is already done for the
Intel match, so the helpers are always compiled and there are no
undefined references if the match code is ever built on a non-ACPI
configuration.

Signed-off-by: Siva Subramanian Ravi Saravanan <sravisar@amd.com>
Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 include/sound/soc-acpi.h                      |   4 +
 sound/soc/amd/acp/Kconfig                     |   2 +-
 sound/soc/amd/acp/Makefile                    |   3 +-
 .../amd/acp/amd-sof-function-topology-lib.c   | 140 ++++++++++++++++++
 .../amd/acp/amd-sof-function-topology-lib.h   |  19 +++
 sound/soc/soc-acpi.c                          |   4 +
 6 files changed, 170 insertions(+), 2 deletions(-)
 create mode 100644 sound/soc/amd/acp/amd-sof-function-topology-lib.c
 create mode 100644 sound/soc/amd/acp/amd-sof-function-topology-lib.h

diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index b850295e9584..81b27778e27a 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -268,6 +268,10 @@ enum snd_soc_acpi_tplg_device_id {
 	SND_SOC_ACPI_TPLG_DEVICE_SSP_BT,
 	SND_SOC_ACPI_TPLG_DEVICE_SSP_HDMI_IN,
 	SND_SOC_ACPI_TPLG_DEVICE_LOOPBACK_VIRTUAL,
+	SND_SOC_ACPI_TPLG_DEVICE_ACP_SDW_JACK,
+	SND_SOC_ACPI_TPLG_DEVICE_ACP_SDW_AMP,
+	SND_SOC_ACPI_TPLG_DEVICE_ACP_SDW_MIC,
+	SND_SOC_ACPI_TPLG_DEVICE_ACP_DMIC,
 	SND_SOC_ACPI_TPLG_DEVICE_MAX
 };
 
diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index a62bf0fb1efc..1b492a9ab582 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -15,7 +15,7 @@ config SND_SOC_AMD_ACP_COMMON
 
 config SND_SOC_ACPI_AMD_MATCH
 	tristate
-        select SND_SOC_ACPI if ACPI
+        select SND_SOC_ACPI
 
 config SND_SOC_ACPI_AMD_SDCA_QUIRKS
 	bool "AMD ACPI SDCA quirks"
diff --git a/sound/soc/amd/acp/Makefile b/sound/soc/amd/acp/Makefile
index 42e2bd34da06..91bbbeef5b8a 100644
--- a/sound/soc/amd/acp/Makefile
+++ b/sound/soc/amd/acp/Makefile
@@ -23,7 +23,8 @@ snd-acp70-y := acp70.o
 snd-acp-mach-y     := acp-mach-common.o
 snd-acp-legacy-mach-y     := acp-legacy-mach.o acp3x-es83xx/acp3x-es83xx.o
 snd-acp-sof-mach-y     := acp-sof-mach.o
-snd-soc-acpi-amd-match-y := amd-acp63-acpi-match.o amd-acp70-acpi-match.o amd-acp7x-acpi-match.o
+snd-soc-acpi-amd-match-y := amd-acp63-acpi-match.o amd-acp70-acpi-match.o amd-acp7x-acpi-match.o \
+	amd-sof-function-topology-lib.o
 snd-soc-acpi-amd-match-$(CONFIG_SND_SOC_ACPI_AMD_SDCA_QUIRKS) += soc-acpi-amd-sdca-quirks.o
 snd-acp-sdw-mach-y     := acp-sdw-mach-common.o
 snd-acp-sdw-sof-mach-y += acp-sdw-sof-mach.o
diff --git a/sound/soc/amd/acp/amd-sof-function-topology-lib.c b/sound/soc/amd/acp/amd-sof-function-topology-lib.c
new file mode 100644
index 000000000000..477ecdf76996
--- /dev/null
+++ b/sound/soc/amd/acp/amd-sof-function-topology-lib.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright(c) 2026 Advanced Micro Devices, Inc.
+//
+
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <sound/soc.h>
+#include <sound/soc-acpi.h>
+#include <sound/soc-topology.h>
+#include "amd-sof-function-topology-lib.h"
+
+#define SOF_AMD_SDW_MAX_LINKS 4
+
+static int get_sdw_link_num(struct device *dev, struct snd_soc_dai_link *dai_link,
+			    unsigned int *link_num)
+{
+	if (sscanf(dai_link->name, "SDW%u", link_num) != 1 ||
+	    *link_num >= SOF_AMD_SDW_MAX_LINKS) {
+		dev_err(dev, "Can't get SDW link from dai_link->name %s\n", dai_link->name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int amd_sof_sdw_get_tplg_files(struct snd_soc_card *card, const struct snd_soc_acpi_mach *mach,
+			       const char *prefix, const char ***tplg_files, bool best_effort)
+{
+	struct snd_soc_dai_link *dai_link;
+	char platform[SND_SOC_ACPI_SOF_PLATFORM_NAME_MAX];
+	unsigned long tplg_mask = 0;
+	int tplg_num = 0;
+	char *tplg_file;
+	int tplg_bit;
+	int tplg_dev;
+	int ret;
+	int i;
+
+	/* ACP SoundWire and PDM DAI configuration is platform dependent */
+	ret = snd_soc_acpi_sof_get_platform_name(card->dev, mach, platform);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * ACP SoundWire DAI index and stream names in the topologies are
+	 * specific to the SoundWire link, so the link number is part of the
+	 * SoundWire function names.
+	 */
+	for_each_card_prelinks(card, i, dai_link) {
+		unsigned int link_num = 0;
+		const char *tplg_dev_name;
+
+		dev_dbg(card->dev, "dai_link %s id %d\n", dai_link->name, dai_link->id);
+		if (strstr(dai_link->name, "SimpleJack")) {
+			ret = get_sdw_link_num(card->dev, dai_link, &link_num);
+			if (ret) {
+				if (best_effort)
+					continue;
+				return ret;
+			}
+
+			tplg_dev = SND_SOC_ACPI_TPLG_DEVICE_ACP_SDW_JACK;
+			tplg_dev_name = devm_kasprintf(card->dev, GFP_KERNEL, "jack-l%u", link_num);
+			if (!tplg_dev_name)
+				return -ENOMEM;
+		} else if (strstr(dai_link->name, "SmartAmp")) {
+			ret = get_sdw_link_num(card->dev, dai_link, &link_num);
+			if (ret) {
+				if (best_effort)
+					continue;
+				return ret;
+			}
+
+			tplg_dev = SND_SOC_ACPI_TPLG_DEVICE_ACP_SDW_AMP;
+			tplg_dev_name = devm_kasprintf(card->dev, GFP_KERNEL, "%damp-l%u",
+						       dai_link->num_cpus, link_num);
+			if (!tplg_dev_name)
+				return -ENOMEM;
+		} else if (strstr(dai_link->name, "SmartMic")) {
+			ret = get_sdw_link_num(card->dev, dai_link, &link_num);
+			if (ret) {
+				if (best_effort)
+					continue;
+				return ret;
+			}
+
+			tplg_dev = SND_SOC_ACPI_TPLG_DEVICE_ACP_SDW_MIC;
+			tplg_dev_name = devm_kasprintf(card->dev, GFP_KERNEL, "mic-l%u", link_num);
+			if (!tplg_dev_name)
+				return -ENOMEM;
+		} else if (strstr(dai_link->name, "dmic")) {
+			/* ACP PDM DMIC is always stereo */
+			tplg_dev = SND_SOC_ACPI_TPLG_DEVICE_ACP_DMIC;
+			tplg_dev_name = "dmic-2ch";
+		} else {
+			/* The dai link is not supported by separated tplg yet */
+			dev_dbg(card->dev,
+				"dai_link %s is not supported by separated tplg yet\n",
+				dai_link->name);
+			if (best_effort)
+				continue;
+
+			return 0;
+		}
+
+		/* the same function on different links needs its own topology */
+		tplg_bit = (tplg_dev - SND_SOC_ACPI_TPLG_DEVICE_ACP_SDW_JACK) *
+			SOF_AMD_SDW_MAX_LINKS + link_num;
+		if (tplg_mask & BIT(tplg_bit))
+			continue;
+
+		tplg_file = snd_soc_acpi_sof_get_tplg_filename(card->dev, prefix,
+							       platform, tplg_dev_name,
+							       dai_link->id, tplg_dev);
+		if (!tplg_file)
+			return -ENOMEM;
+
+		/* Check presence of sub-topologies */
+		if (!snd_soc_tplg_files_exist(card->dev, tplg_file)) {
+			devm_kfree(card->dev, tplg_file);
+			if (best_effort)
+				continue;
+
+			return 0;
+		}
+
+		tplg_mask |= BIT(tplg_bit);
+
+		(*tplg_files)[tplg_num] = tplg_file;
+		tplg_num++;
+	}
+
+	dev_dbg(card->dev, "tplg_mask %#lx tplg_num %d\n", tplg_mask, tplg_num);
+
+	return tplg_num;
+}
diff --git a/sound/soc/amd/acp/amd-sof-function-topology-lib.h b/sound/soc/amd/acp/amd-sof-function-topology-lib.h
new file mode 100644
index 000000000000..cea49aa9c200
--- /dev/null
+++ b/sound/soc/amd/acp/amd-sof-function-topology-lib.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * amd-sof-function-topology-lib.h - get-tplg-files ops
+ *
+ * Copyright(c) 2026 Advanced Micro Devices, Inc.
+ */
+
+#ifndef __AMD_SOF_FUNCTION_TOPOLOGY_LIB_H
+#define __AMD_SOF_FUNCTION_TOPOLOGY_LIB_H
+
+#include <linux/types.h>
+
+struct snd_soc_acpi_mach;
+struct snd_soc_card;
+
+int amd_sof_sdw_get_tplg_files(struct snd_soc_card *card, const struct snd_soc_acpi_mach *mach,
+			       const char *prefix, const char ***tplg_files, bool best_effort);
+
+#endif
diff --git a/sound/soc/soc-acpi.c b/sound/soc/soc-acpi.c
index 1c6e20e00dca..a344d497aa87 100644
--- a/sound/soc/soc-acpi.c
+++ b/sound/soc/soc-acpi.c
@@ -238,6 +238,10 @@ char *snd_soc_acpi_sof_get_tplg_filename(struct device *dev, const char *prefix,
 	case SND_SOC_ACPI_TPLG_DEVICE_SSP_AMP:
 	case SND_SOC_ACPI_TPLG_DEVICE_SSP_BT:
 	case SND_SOC_ACPI_TPLG_DEVICE_SSP_HDMI_IN:
+	case SND_SOC_ACPI_TPLG_DEVICE_ACP_SDW_JACK:
+	case SND_SOC_ACPI_TPLG_DEVICE_ACP_SDW_AMP:
+	case SND_SOC_ACPI_TPLG_DEVICE_ACP_SDW_MIC:
+	case SND_SOC_ACPI_TPLG_DEVICE_ACP_DMIC:
 		filename = devm_kasprintf(dev, GFP_KERNEL, "%s/sof-%s-%s-id%d.tplg",
 					  prefix, platform, tplg_dev_name, dai_link_id);
 		break;
-- 
2.43.0

