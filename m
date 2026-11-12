Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA077606A323
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=aXDSOobH;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rauRzTEb
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB7CE60207;
	Thu, 12 Nov 2026 13:36:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB7CE60207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794487028;
	bh=hvgPr6aBqwkfmjfbRZNXfS1IwdBm/hRYiLv3z7LfIwA=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=aXDSOobHJyXOWrus3tdv3gtic5loKYWQV6x+NwPIy9IuhRT7+ZpAL+8lQDr6QwaFh
	 RHlBoN5wgy1Hz2qBkiSf1aqiZYq1j16vUCLafXRbc1J5+mrB71cBhDTSfnkcLOMMls
	 4KKT+L4LWlFmC71wy9DiixLCO2TzwqzOJgecndno=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2B130F805F5; Thu, 12 Nov 2026 13:36:35 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8B6C8F805F7;
	Thu, 12 Nov 2026 13:36:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D5AD6F8016E; Thu, 12 Nov 2026 13:36:26 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.21
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1794486982;
	b=e/A0ARXQyVrcyMzRkYDpVFJpAV0YQtrD4bfOLqDrnNXNwUfjciDJfVU5L6nMiq7Fv9Hv
	 f5+IlsUtLSjOFSWRzqNGWm2dd6lfrcyLbjcll0SnUC9rn40adjkrtk/6CI8HH5+r0FAbe
	 HaI/DTQtHacc235VKxKC2Uugh311JSneNmnPR0qS7Md1LZE4rzu54P8j5PytXCPftDKtD
	 uNBpgk/G8wcXNY/fTH6FhVFqfo2Lob3vdgJLJwFi8XAm37O3lZqvJaLx0ZiVajPum+K4R
	 WN33RO1PdqRqcUwaXCxQlwnveZxlt1dDM/ph0Sz78e+/JhOwa7GLNh9sAlBOdXLJdXg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794486982;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hvgPr6aBqwkfmjfbRZNXfS1IwdBm/hRYiLv3z7LfIwA=;
	b=UyYacigBP9P1/lPo5dJiUiYTooGXEdqHrNWauIu7BJRnnpg0+A40Y2jFoV2v5L7+E/Ie
	 yYEfO3ZJ8qsnUWVJiHqLInCiamXLo994+D5Bw3E/9M/0zRcB7S9YYwjZm/MDFu71aakdA
	 sFgOGl7UH/ReCJ+1QwUNfWPZR9vQSEUeKxe+1USj5RNN5tGihhvfQknTRNHT+gwzFwXMg
	 rnVWe8Ho26vRFPwP37fUd5ZcFAQdwa8ACGTrpRuaWxIYOQRTP8cSyhaLs40uC9MG0NIRj
	 iLIVkGbTYjGlrkzpod0cxxxwwa14cW9tUUTCUMhHEJQODiZ7WzbhOT2MpZ54cBJuUKQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=rauRzTEb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.21
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013021.outbound.protection.outlook.com
 [40.107.201.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 79C4CF800DF
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2026 13:36:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79C4CF800DF
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=rauRzTEb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLON6wXONL5rMUtmbMsMoDTLLd3+NqJQpmGbm9pEiUKpjBwhuPayR9evpen25W4TnALLv8nzIlk4rYqmQH0mYqudmah9yD9ZpBaQnUTkZKA3qri3EwazYQ1DF8BAhAUKI4A/7tWgYahQqEv29kkfw0kTizfj5CQ22nTeBzNXywADgLpZ6kQByGs7HMV14XOvtMFUmnEvxQNktiGdlykdnQUh7fP00hmgqpQ7ZTly+R5VgklIcW/vHOwKmFdufNmLw44IwEiGwQAC1qMK4fZAim+tna9st2TnDBWsThpw57rOXKGKOCtNKVKbLAECcT9RjM+aPJchyQDyIIXLQlkSeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abwTEDO/j8WW6DWAk8A89voBr+H7EQ60jzRlPkMPKgI=;
 b=kzALukR8wBCmphjIYlZEzdNo+PWjilavj/bIvZFWUgkuVNL6F1XSNRUqfQeLobRDLoSRFXJ+l/p3uctAXUprgsgSu5u7uLLkOhT4SPy4ICfeR435ILlh1fqN+Qrf86GhxmAH3BcHJDcRVWTb06md/ncWAUgmKGUQovs8o4qyH3XBeqUK/vOpnVj2zXH/eAAQ8Zfobaq/tyYxRq+bw38pMpCJnF8mLLuM+GhcwVP+3xyEOJ3Jo74jFzKi3Q7Z1EqJG4fi5eOd9iJ0e3C6EDDjicFi+5Vkum6c3dcL7exR0mIE0Sb4tCKMWS0pLRv6NnmZKFUxVRSvd5tBOL0ku16ouA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abwTEDO/j8WW6DWAk8A89voBr+H7EQ60jzRlPkMPKgI=;
 b=rauRzTEb1pgeglMCWj1ba0aboviMh9g8cSmcxr08U3/lLQSWzTyBf9vAShxRtpfDMjAna1CytGXqI/oJH2X0GONAfJanjLtVJ7r5hRggwPm+NIM8f/jqSvZBqGa59ncY+AzVhVLHd8271ANCqtjyDaZzvMTywqcmZ/lWMXzCTos=
Received: from PH7PR03CA0017.namprd03.prod.outlook.com (2603:10b6:510:339::32)
 by SA3PR12MB8022.namprd12.prod.outlook.com (2603:10b6:806:307::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 12:36:13 +0000
Received: from PH3PEPF00059619.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::79) by PH7PR03CA0017.outlook.office365.com
 (2603:10b6:510:339::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 12:36:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH3PEPF00059619.mail.protection.outlook.com (10.167.243.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 12:36:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 06:36:12 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 06:36:11 -0600
Received: from amd-B550M-DS3H.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 06:36:09 -0600
From: Syed Saba Kareem <syed.sabakareem@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <anson.tsao@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>, Syed Saba Kareem
	<Syed.SabaKareem@amd.com>, Guo Ren <guoren@kernel.org>, "open list:C-SKY
 ARCHITECTURE:Keyword:csky" <linux-csky@vger.kernel.org>
Subject: [PATCH v4 0/6] ASoC: amd: acp: ACP7.F SoundWire configs and SOF
 function topology support
Date: Thu, 12 Nov 2026 18:05:35 +0530
Message-ID: <20261112123603.2891858-1-syed.sabakareem@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059619:EE_|SA3PR12MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: c2caf170-5818-48c1-e1f1-08df40b9894c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|18002099003|6133799003|261009223027099003|10067099003|11063799006|56012099006|261028144727099003|261026140227099003|261102123227099003|261022075727099003|261026121527099003|261021121427099003|261022105027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: 
	ZWQEAYA4knB2OGLDqshQI7hwY/ZiV7rfupptOu3HQkpytGiVB0Z5Qr2OcVpxhdXad0rUr1wiDAS8THbl3g7BBSqXakAc0jCJFkQ4P53YWeEk+lJ3Y3c8wY08LLTtfqvk3CuQCc3YUjGhwzKcVKDYesWOksnNycm3ubb2oBqJRT9gFvl+2hwrioaqaFLnk7IafmcaE48YiG4NzAkPV2gJBJ8EA/rvxWF/bszAVch55fD9xs4KgNxSkWmVo4eew0fh8vm0IVZhg7ovlwd30ITpaXAKcesQcfytR+3AiCGRIhPHv1V6Dc4f4b6HFajsxSDagBcmgkKGA+jo0gjvfQfqYNQJUVb7GR8635KpGhavPxW9RcU/b4Lgy5nFcpk+ZzLmmultpyIqb+fK8Z+KgzuevNsQGcJOY1lE6S3NHN3rD6xIWTmhe5fmZDBz+qPie+imvBPix0FnGclNtMTbxOfE5MhTgMKYQUsIsu0+Zx1eGZQuMqm2oD9q8eWL7y6qugUWRAz4djUC0p6hXobRSQZkfT6NTjx+FOVvRRssgGYE0Y+K6nAUnKXxKvVJeZ/f2sanHbHMqVKRQtZVxhMA+u/BMoSyU/5cOdPE906xo173bPYpGtPH7kCkwMUjpz1Lf0KOuc2lp2GsAzRkXvvBpijpfCqSoV29lJBOxA1IUCYhE9DsblCkfd6LlpxfjDvwFtQzjVX+UDHaSFHg2xFDYCJwZg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(18002099003)(6133799003)(261009223027099003)(10067099003)(11063799006)(56012099006)(261028144727099003)(261026140227099003)(261102123227099003)(261022075727099003)(261026121527099003)(261021121427099003)(261022105027099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	8MBsOwzkIFgk3r+v/O4YnLBZ2lGShza5BkIHKucIkItM0eytdbDzOl1wRhUzC8SVXaNJsuiPDXkKWRivlGq/C3UsDSxk8PiENr5jNYzOCTZGe9YyPSecXsAFcQ6VO09PfA7gMlFGlkjYvgTE1z0+b9dylbgFDNQ+clnqwRRnYbLKvaQu4h0ozitVR8dtY91QxCfIvlh8PEiMkzkqrNfF0BUhOsTeYino5bc3p9XyDxJ7eLVVHnDkT8FlvLXIsl6a/1Y9+qXKEFurMucBYhDPQugdj6/VLxK8aJwDCySVwdUMt9Ka+5OprSLV7as5KjJ8A4doaRJUbkZ0asvIj5f4Mef/yPFSiveYpWB4SjbOkssRTxJKk61VgCH6BNRVuWHfbWIv3moCRcggRLXJKP89R3qL4QpTY6V9gJ/ucO83s2QFRFWoeA5cl/4CkvNc7xjV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 12:36:12.5895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c2caf170-5818-48c1-e1f1-08df40b9894c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	PH3PEPF00059619.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8022
Message-ID-Hash: BY3RJQVWVJY4GM4MSNINYCYGMFHGB5FY
X-Message-ID-Hash: BY3RJQVWVJY4GM4MSNINYCYGMFHGB5FY
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BY3RJQVWVJY4GM4MSNINYCYGMFHGB5FY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

From: Syed Saba Kareem <Syed.SabaKareem@amd.com>

This series adds the Cirrus SoundWire machine configurations for ACP7.F
and reworks the SOF function-topology handling so it can be shared
between the Intel and AMD ACP drivers.

Patches 1-2 add the ACP7.F Cirrus SoundWire machine descriptors
(endpoint, adr_device and link_adr tables and the machine entries) and
the Dell speaker-amp DMI quirks.

Patches 3-6 move the common SOF function-topology helpers out of the
Intel code into soc-acpi, add AMD ACP support for them, always append
the DAI type to the SoundWire DAI link names, and finally enable
function topologies for the ACP7.B and ACP7.F SoundWire machines.

Changes in v4:
 - Add a public SND_SOC_ACPI_SOF_PLATFORM_NAME_MAX constant in
   soc-acpi.h as the single authoritative platform-name buffer size and
   use it for the Intel and AMD callers, replacing the per-driver
   SOF_INTEL_PLATFORM_NAME_MAX / SOF_AMD_PLATFORM_NAME_MAX defines.
 - Make snd_soc_acpi_sof_get_platform_name() take a struct device
   pointer instead of a struct snd_soc_card pointer, consistent with its
   companion snd_soc_acpi_sof_get_tplg_filename().
 - Type the tplg_dev parameter of snd_soc_acpi_sof_get_tplg_filename()
   as enum snd_soc_acpi_tplg_device_id instead of a plain int, now that
   it is a public API.
 - Select SND_SOC_ACPI unconditionally in the AMD match Kconfig as well
   (matching the Intel match) so the shared SOF helpers are always
   built and there are no undefined references on non-ACPI configs.
 - Drop the now-unused linux/firmware.h include from the Intel
   sof-function-topology-lib.c.
 - In amd_sof_sdw_get_tplg_files(), honour best_effort when
   get_sdw_link_num() fails on a recognised SoundWire link: skip the
   link instead of aborting the whole probe, consistent with the
   handling of unrecognised links.
 - Expand the patch 3, 4 and 5 commit messages to document the sscanf
   field widening (the old "sof-%3s" field silently truncated longer
   platform names), the platform-name buffer sizing, the CONFIG_ACPI
   guarding of the ACPI-only matching helpers, and why appending the
   DAI type does not regress the monolithic-topology platforms
   (ACP6.3/ACP7.0) given the partial topology/DAI-link name matching.

Changes in v3:
 - Select SND_SOC_ACPI unconditionally in the Intel match Kconfig so the
   topology helpers moved into soc-acpi link on non-ACPI builds (fixes a
   kernel test robot modpost error on csky).

Changes in v2:
 - Drop the unused acp7x_cs35l63x4_l0u0246 link_adr array in patch 1
   (reported by the kernel test robot).
 - Add "ASoC: amd: acp: always append the DAI type to SoundWire DAI
   link names" (patch 5).
 - Move the AMD function-topology helpers into their own
   amd-sof-function-topology-lib.{c,h} instead of reusing the Intel
   file name.

Siva Subramanian Ravi Saravanan (4):
  ASoC: soc-acpi: move common SOF topology helpers
  ASoC: amd: acp: add SOF function topology support
  ASoC: amd: acp: always append the DAI type to SoundWire DAI link names
  ASoC: amd: acp: enable function topologies for ACP7.B and ACP7.F
    SoundWire

Syed Saba Kareem (2):
  ASoC: amd: acp: add Cirrus SoundWire configs for ACP7.F
  ASoC: amd: acp: add SoundWire speaker quirks for Dell platforms

 include/sound/soc-acpi.h                      |  34 ++
 include/sound/soc-topology.h                  |  10 +
 sound/soc/amd/acp/Kconfig                     |   2 +-
 sound/soc/amd/acp/Makefile                    |   3 +-
 sound/soc/amd/acp/acp-sdw-sof-mach.c          |  51 ++
 sound/soc/amd/acp/amd-acp7x-acpi-match.c      | 452 ++++++++++++++++++
 .../amd/acp/amd-sof-function-topology-lib.c   | 140 ++++++
 .../amd/acp/amd-sof-function-topology-lib.h   |  19 +
 sound/soc/intel/Kconfig                       |   2 +-
 .../intel/common/sof-function-topology-lib.c  | 129 ++---
 sound/soc/soc-acpi.c                          |  55 +++
 sound/soc/soc-topology.c                      |  16 +
 12 files changed, 808 insertions(+), 105 deletions(-)
 create mode 100644 sound/soc/amd/acp/amd-sof-function-topology-lib.c
 create mode 100644 sound/soc/amd/acp/amd-sof-function-topology-lib.h


base-commit: 87eda92d89790d56ddce1af560815a04d70e3a43
-- 
2.43.0

