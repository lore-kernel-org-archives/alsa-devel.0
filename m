Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10432C79FB9
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:27:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 26A83602C4;
	Thu, 10 Sep 2026 15:27:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 26A83602C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789046853;
	bh=t9nxrc8CXPp/87L/6SXnEbchmJI4NMEf3lr6/aXfebA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BAAvxNEsWvDYY5uhkTrws+2T6KqWezqHfrC+q4LjevZBeE9/x3xglm/dac977j4SU
	 Q3Ix7u/9E0ZiKH6fM2YqyLknxACfWoW7AS2p3koml0/v/G27zlR/EjECJwQap/yv3i
	 uQOPuXnYG9+bZ9hU3C8xVdV0/Zk9E2L5RV2BnsZA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 53528F8075A; Thu, 10 Sep 2026 15:24:49 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A3831F80768;
	Thu, 10 Sep 2026 15:24:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B22CBF806E0; Thu, 10 Sep 2026 15:24:41 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.37
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789046680;
	b=o94EO1R5foc++U3SHKgTtCunwt745aqUE+BiYZMyXkB4Cau8fRkLpR0iDbwcByV9ma4z
	 pi7r8ZSmzROiDu0G7LFBu9MPHZt+xXuuzkto8tDHt7WABGT+JPLJ4aRV7hRuQXPgFaY10
	 eeDK1q/AgEDfzprVBkl9xgqIRDAsedLCLrhWBCs/0dG5MXrPhClTcFW61PlYtnOt3CVYq
	 kK1yBobvFJortRXd/3rAg9o/7zKtQFbJbH9eSk5usTR5vfx8NXsoVImH5VJOwfsnr6MUd
	 utKaWsPf9h4alaWRTCxz4toKzokZJk3O+DfrOQ5B1C3wMVibmW72yC4l1O54K6OkJIQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789046680;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=t9nxrc8CXPp/87L/6SXnEbchmJI4NMEf3lr6/aXfebA=;
	b=rDcDkYRqHefkKHZfYb9A+QbOzw3cuWd+PskpQfsVdAGv+DsagY8vVkRn84qu6WxemWCE
	 CMirx7SEbWMlmZvl+v0QzL3BTXzQGDcth+tIpK17ZKi2fQOwgQlAGF7BDaa9vRifuqx1i
	 6JHGod94tQAb7u5tOlXTX4fizpwFEmRWDbxBejkt0kSUzM9gWpzKd7Q1A1pz3u9D+7Bzs
	 MWsQLpRGT8ByBRzmk580bfxTfO0WYwsfbb3YoUfz1VX0A9gm6iPNWvhT18YI08pO8Pg2X
	 2zw5is9b2SVdXJFnxkR7FptBMdZyRXSwKBLg49GDa9v/32KsdjQAkaiSVlCpd5m+81A==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=SwdQhLt0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.37
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010037.outbound.protection.outlook.com
 [40.93.198.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B0D52F806B6;
	Thu, 10 Sep 2026 15:24:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0D52F806B6
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=SwdQhLt0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rlegryd2waCKC95hkIfpyv5KtGJm7BRJBAqWVQfX6e1gwdnXCSWX/W6MblYofEAjyIYQR5TgXu7UEq5ZJh53jYHIfIe6T3VwSKO3BJva/e+0nbMe+zBbAJeQ/IJW6kkt3Ao34WlJr9XwC3IuyH9I/yACJwepqVVCm9x27rIMQI63zVG1DjwKDL2DoI/9SYfkfXQB2Bw4F69goJFtEU+17zhllvMS0tdBdFTXAYQow/mIQ0kzeDPa0VG5GBo6jwtAaZcMHchrH3xCfjPWC7jr4u6sdrGiOXbVFU8DmwuH7t2LCilxMktL8yqh9IpijhLROVR/bTiORuf+NwJvFsDh2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CfYy4C8dP/mBg7vzEoE/Y742fPvu54oWx8zNceHPpU=;
 b=XYu5CrPJTP6sxZJft6+CY43Znw47vYxUVz30dJGiPhRN/V2uTO+BjTDizoQdn9sWNR8K1wyX7h5mP7uKUGaXFOdi9dgyF9s4ZK8gGxmJqqINImmM2LfR7vL9jBo39IEGFlEv1W55yuXt8JZHfvcEdQkj6/qGIhGg2ck15+EbeNmfBttKnE8vzf3s3T1D3jrjkj0v6iJaoeYvusBhuZfRawZ0P+063y8rQceFyULBqZJFQhETJL3JpJkE4Uym7Uz1c3AhRtSrNkMkS2wzei3kHxduW+j+04A1ea/KHPwrH64EgEBOq1CwfPAR+gu8hJwlpMspPtDtmzN+XB4HaW7QOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CfYy4C8dP/mBg7vzEoE/Y742fPvu54oWx8zNceHPpU=;
 b=SwdQhLt0AmO0E9wNyF7k//NoqC57Yc6sdV6LSKVjsq+HymbnmH/VQ9j7O7bbXgbWvPHMcLNmBsUOy8f3gCcU198ge7lczt/yuhS3q8pKW7mcQan6kBhwV+gUjZBVhSmOULoTiPqzjJl9kzYAqUk9LZQSy2YcVjBp6QPmUCZL8oo=
Received: from PH8P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::12)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 13:24:31 +0000
Received: from BY1PEPF000264B2.namprd02.prod.outlook.com
 (2603:10b6:510:345:cafe::73) by PH8P220CA0020.outlook.office365.com
 (2603:10b6:510:345::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Thu, 10
 Sep 2026 13:24:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF000264B2.mail.protection.outlook.com (10.167.242.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 13:24:30 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 08:24:27 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Thu, 10 Sep 2026 08:24:23 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<perex@perex.cz>, <tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<Syed.SabaKareem@amd.com>, <Mario.Limonciello@amd.com>,
	<Richard.Gong@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 06/11] ASoC: SOF: amd: enable SoundWire build for ACP7.B/7.F
Date: Thu, 10 Sep 2026 18:50:06 +0530
Message-ID: <20260910132251.1171943-7-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260910132251.1171943-1-Vijendar.Mukunda@amd.com>
References: <20260910132251.1171943-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B2:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cbe9571-e8ca-480d-e966-08df0f3ed8cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|7416014|82310400026|23010399003|1800799024|36860700016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	Mh7SLZwo7b1rzk7rsxOLSxwBHyheAKWZOg3p8dFGlp704wmoPSbgYklJc2Z7K1o/qYMKe8Ps1U2JRNcmbL/x1debN9SJYj6Uz1rGu7YQGXV3v7vD6cRHPrWMszjnBQEFDsJUGNikfJYblI7I2tkCOUBqZj3/nux+OToIWCGw2e9c+Xq7Fft8XcTcXnikq3waCLww7JKyVT5tJ5sy+wTpHAAG9i94V7xVHxq7jKwuRaThRL/eMr1mA+viReAA0437Xaa2yRiwngxIfRGH6yWjAQDc1XxBy39X3Xp8gHWztr56Ls/uW3Lwb4DKIe7rvQql5Y2ms8SDCjeT3GmqJVoOQwpzjEROgg0gNJ3C72C7dLmZo8aVJI/UlvhctVj4qfDQnwquhMBZ7KisK/QcrbXoX372sSnD1hJGkdmY5bEwzlAMq0x+tmm+xv0v0Vu2VKUNDaHECzE9W4rIhsiWqoHRaz/puN7EKEBlSXTiHcMiKzUcDStfBYFrQfvmB9y05F/FuOvMrdbRpknfstXkNBP8nQHEAbMvEG9oS4FDG4WLzmFVA01onO4UQTej65uTQbXLLZM8maqVc/ZtuPY/Y6EQOU4ykK2/x0ujDUq0tVqSd8EaDvI4/tyozG4AssmPT2+MCVj6bQYcS6uJog/Mb2GL7xBYLgXBiFleA9eSIo5OnfgSBMcAgJC6D0ttF5DCnpRt/bFrRKKwsXzz0ZR475TeVA==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(23010399003)(1800799024)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	9fWCnvGvqlRYU2SNV9gVF+UImnHspTiYAB+n6F9fnWUp/er84nNv+FVLhE7XPkTrjrn2WK5C7vqiMEys491Kj+oLucY5dnYPXcWi8RPDQmHJ7JEZxxHf0o/+MTp6CtpG974a8fYKpr2e6uUheRRlRk+mlI1UCoqZk7f7looJU6mbdOuB9sr0H8wsZ7ZJOK0wBqEvwJBTgAWkYrhXquWjs+D8ENii/maUWK9IdsWkT/WrZNQL9/ujR5t7OYdHXVtwLbuZZgx50K/MaNexKPYewOrtDs4jdt9tP+kTR4fvA5/4F+wIz/Ji2IZWN9M4Ve50lmq+1vbVwdSI8fYAO6p7EcuYHVd3gS5yloBW+nWDr6azg0BL23LWASGlWaGGkZuPjqgWTxi9uqw0Ibni1IIUFWKHwXR9h1IaurFH9sAD6+mapX0pbwg6Ia5hGbDP6GGM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 13:24:30.8269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6cbe9571-e8ca-480d-e966-08df0f3ed8cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BY1PEPF000264B2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326
Message-ID-Hash: 7OZCEWBSVGMKKWKZWYFKTNQSNG7EXKIE
X-Message-ID-Hash: 7OZCEWBSVGMKKWKZWYFKTNQSNG7EXKIE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7OZCEWBSVGMKKWKZWYFKTNQSNG7EXKIE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Select SND_SOC_SOF_AMD_SOUNDWIRE_LINK_BASELINE in Kconfig for
SND_SOC_SOF_AMD_ACP7X so that the SoundWire stack is built
when ACP7.B/7.F SOF support is enabled.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/amd/Kconfig b/sound/soc/sof/amd/Kconfig
index 903e7ec3b3ba..d64f682cfbea 100644
--- a/sound/soc/sof/amd/Kconfig
+++ b/sound/soc/sof/amd/Kconfig
@@ -109,6 +109,7 @@ config SND_SOC_SOF_AMD_ACP7X
 	depends on SND_SOC_SOF_PCI
 	depends on AMD_NODE
 	select SND_SOC_SOF_AMD_COMMON
+	select SND_SOC_SOF_AMD_SOUNDWIRE_LINK_BASELINE
 	help
 	  Select this option for SOF support on AMD ACP7.B and ACP7.F PCI
 	  revision based platforms.
-- 
2.48.1

